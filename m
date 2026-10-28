Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B369606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GuPLAqmj;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fx3GL2gw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM3zt-0002ST-Of; Wed, 28 Oct 2026 09:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM3zm-0002RX-DJ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM3zk-0000FT-J7
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793195230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oKwPo2y1+9LCt0tDpALKvVNZXvNd47CM65evbfSeNys=;
 b=GuPLAqmjcDYImQglTZXjRkAzeEi5i6ilus5/taMDwVqjJno2myu2m9u+ye5TinGIqAUZT2
 RCy80/0IScTd4zwyoXffHnF5dtlJpHnwwudIIZZgFepIUWfEhLR4bZnsVuIvRtzQoBzSBF
 /CqQ7LCYoo6Ea90Dpgx5BtZ4k9VR8jQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-n5qsPLzMNFC5qP--BOM0yQ-1; Wed, 28 Oct 2026 09:47:09 -0400
X-MC-Unique: n5qsPLzMNFC5qP--BOM0yQ-1
X-Mimecast-MFC-AGG-ID: n5qsPLzMNFC5qP--BOM0yQ_1793195228
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48b00febba3so633419f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793195228; x=1793800028; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oKwPo2y1+9LCt0tDpALKvVNZXvNd47CM65evbfSeNys=;
 b=fx3GL2gwEqFDt1CQRACZEGasioo/pItNv1Y2xIAPPCA1xR1+O2SMpPb1OxrpO2OUcq
 Mb1E78SXUoC1K5SbtIRxYVs0AIbV9jA8tF/9wOcRK46hZMOAGKJbyv3ZplmdgYXU8rcm
 O/HH7+ERSdjZ6pyNLpQuISDLrR+aCQ2CybG4gjdt90L0pYkP7LoWMVQthKXkmhmrKD6D
 QTGc0Tl0g39jXx5kyCTtzg4qn62q/Ts9bJbyCQOnR3M+V8tT1S9bpRM8hF9lxYMH0NfK
 G/EoPhqvUztpilc1qkE8q7De2Fzs/gPI/b0xNzYFbFHHoUTTT5sPWXQgTeQ8tR+kq9oz
 LdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793195228; x=1793800028;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oKwPo2y1+9LCt0tDpALKvVNZXvNd47CM65evbfSeNys=;
 b=1SZfYWu+PtOH6qt9odBzr8HDene8/eSiIXqxOL/q+HsU6P8KuFs5bbEWTCzRfSA6pM
 psFwxscaBlBnKz4yFK0hlls+PPnTm7CvAHR5BlA25VXZ3a4e6WMjzDztvw2jPOIzXpBh
 NkDrYYYJC0gSVPrkEO7UtpZfZJCZkLvyG5dpX7zsb2d8Y1dxtB6QFwAhObLsr1SE5pDu
 hBZzfjtfIBdVH0CEEtGtpEm0+Mul6oKJ6G9D4eOSJAh3tf5iZyVBqDSlC226CvQIPwS4
 L7iAxA61cz2fE8/vJho0TOuNVFx7JbOdSk8YYXsH4Bmoc4bY1VYddac4Lzac5S8p5UG9
 RhzQ==
X-Gm-Message-State: AFq9FYIoNyZNRPqaI/64poxRCVVm7ytRnZblqYGQD78f91BKSmbFdqCi
 8oRqTEzPfg/4RspABf2hycInDgQvQzqcf0EF/mfdkus75T4wgGaHy927+i/zXwV5P1PUrWcItIU
 c6Bzy8Gd+i4/NCujDtYCVSOXdOzmjsjgh36StVPdFptKUegJDQwVDFLih
X-Gm-Gg: AYBFou0BlT7dGqtX9H0/Xu/QtFen5Y+bZYdwaWMQ++0rk+tNHqT+p9PHz2/JpBusQL8
 I7cm9uoP5d/CgxPKD3bPuBNmfDqZquXCzGKRAVcjOx8AyoFOYLm6W+BytlolZ7Dz+ovo1GpPANr
 M3Tcg1mWd65HGj/72VqOOSsbMAduYic+2EktbB0fvWVW+FAInWMANYpiFw0kHUXdSqx3mMEXOpW
 W3CEEMFjYosReZeo17UVllCg20qp4V40FsQ4ZF1X6oa4cJ1kmTmz9TK3IWklqJZv5mTUOtCktXK
 teU1W5BgMWIsCGT1zyunCiWJdjLghsjhNuXlPGJfwp+cUQnZUE6qMAWPKnzWCMexDsFr6SsW8Qc
 TLDflhKpyjVHbNaogs0Fci105BvTk71a2Slql1sVj
X-Received: by 2002:a05:6000:2508:b0:48e:5ea1:260a with SMTP id
 ffacd0b85a97d-48e5ea18152mr4937597f8f.3.1793195227771; 
 Wed, 28 Oct 2026 06:47:07 -0700 (PDT)
X-Received: by 2002:a05:6000:2508:b0:48e:5ea1:260a with SMTP id
 ffacd0b85a97d-48e5ea18152mr4937525f8f.3.1793195227116; 
 Wed, 28 Oct 2026 06:47:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc39b3sm29535147f8f.10.2026.10.28.06.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:47:06 -0700 (PDT)
Date: Wed, 28 Oct 2026 09:47:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sunil V L <sunilvl@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>, Drew Fustini <fustini@kernel.org>
Subject: Re: [PATCH 0/4] RISC-V: ACPI: Add PPTT support
Message-ID: <20261028094619-mutt-send-email-mst@kernel.org>
References: <20261011182552.1071742-1-sunilvl@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011182552.1071742-1-sunilvl@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 11, 2026 at 11:55:48PM +0530, Sunil V L wrote:
> From: Sunil V L <sunilvl@oss.qualcomm.com>
> 
> Hi all,
> 
> This series adds ACPI Processor Properties Topology Table (PPTT) support to
> the RISC-V virt machine. PPTT allows the guest to discover the processor and
> cache topology exposed by the machine, which is useful for making better
> scheduling and cache-management decisions.
> 
> The implementation describes the RISC-V virt cache hierarchy with separate
> L1 instruction and data caches, followed by unified L2 and L3 caches. It also
> enables the corresponding cache and cluster properties in the machine SMP
> description and wires the generated PPTT into the existing ACPI table
> build.
> 
> Unlike ARM, RISC-V doesn't have a way to discover the Cache
> topology from registers. Hence, I am hardcoding default values for the
> cache topology structures. These cache topology structures are added in
> virt.c itself so that a future series can add support for DT as well.
> 
> The series also updates the bios-tables-test data and removes the temporary
> PPTT entry from the allowed-diff list. The generated table is 96 bytes and
> describes the package, cluster, and processor hierarchy for the virt machine.
> 
> This work follows the discussion and earlier work shared here:
> https://lists.gnu.org/archive/html/qemu-riscv/2024-01/msg00928.html
> 
> I have retained the contribution from Sia Jee Heng and added his
> Signed-off-by tag to the relevant patch.
> 
> To enable cache structures in the PPTT, one should use similar to below
> command line option.


acpi side's tiny here. that

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> -M virt,smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=cluster,smp-cache.3.cache=l3,smp-cache.3.topology=socket
> 
> lscpu -C in linux can be used to display these cache structures.
> 
> Sunil V L (4):
>   tests/qtest/bios-tables-test: Allow PPTT for RISC-V
>   hw/riscv/virt: Add ACPI PPTT table
>   tests/qtest/bios-tables-test: Update riscv64 virt PPTT golden
>     reference
>   MAINTAINERS: Update Sunil's email id
> 
>  MAINTAINERS                       |   2 +-
>  hw/riscv/virt-acpi-build.c        |   7 ++++
>  hw/riscv/virt.c                   |  54 ++++++++++++++++++++++++++++++
>  include/hw/riscv/virt.h           |   4 +++
>  tests/data/acpi/riscv64/virt/PPTT | Bin 0 -> 96 bytes
>  5 files changed, 66 insertions(+), 1 deletion(-)
>  create mode 100644 tests/data/acpi/riscv64/virt/PPTT
> 
> -- 
> 2.43.0


