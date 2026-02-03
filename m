Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E79E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 14:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHfi-0008DI-Pw; Tue, 03 Feb 2026 09:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnHff-0008Cy-TS
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:46:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnHfW-0005wI-7u
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770129976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hmTCcF+HKBES3K6OXlSA4Cu5w5QfqqgL1UCfnHVpWDM=;
 b=Tb+XMbKlziMP/RFV8PsNfqxrx8ewKUCk5xZRPJdD+qLnMTkQECgABBU0oGcXDcM8c4Je81
 fRmy2pTUuQ2O8m0NR7tvkxl+RgSJ/goB2q4ZWHPDemedJr6ivsrOgX4mhwWAOReztValEa
 SWgyVSGLooEkKko0MF3E1fPGWioKu+E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-xsv8EFfWPzCKebzcdQlE2Q-1; Tue, 03 Feb 2026 09:46:14 -0500
X-MC-Unique: xsv8EFfWPzCKebzcdQlE2Q-1
X-Mimecast-MFC-AGG-ID: xsv8EFfWPzCKebzcdQlE2Q_1770129972
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4801bceb317so52881995e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 06:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770129972; x=1770734772; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hmTCcF+HKBES3K6OXlSA4Cu5w5QfqqgL1UCfnHVpWDM=;
 b=jOuqMnvnY8oT/8QI3hvktmLAke+pWQMtEXQMTtXR7VsamieXC0f7z7pp2/OxQFobLT
 wkP3g5mDpisaIndslWLGilCzo9hw6Lv3+4I0gUxVtxQo2DsfRTDXOlQEknspNTmZybjz
 wJ3Cc77lWPYJ9yksh4Jx+pKJwwc1lKHFkQ3TOA/NiN65lHspMAq8G8aHL2vai4FkLB4+
 CBTSyugaLC9pGU2BcbZaxaKkF1mWzioKdl2hjyFnitZG/MZowPzWZz1IKcHMfUjbau04
 J3WRzOz+HO4OC83T85bzju3rrIrqpVWkPRdd7bjyJ/4auuWZgTnMp2gPgj4uzE7UhoYT
 QV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770129972; x=1770734772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmTCcF+HKBES3K6OXlSA4Cu5w5QfqqgL1UCfnHVpWDM=;
 b=dIFmyP5keaD7x2k8Vathf37xUrDtSql/3fDpTUCzx4zqZ8UiIRHeerOLuYc7/1PYvV
 x48nqKX+O6Sre1WWXg4J04njJ68+oTS69ub585wQKdDRV/kicdKhPVWGozIKO++cc9q7
 8Dhl+XSFoexVQNHDXCkc11M+r1srVirHaX2P87O3XVad+FKRJruvJgaIfFlvTNprmrF/
 tv21puRhc7ypUVmn2T1ORgCC1D917FiMrZb6AGKzI0cByvECF71cHOWvwipQLkYG2GLl
 4hYO3uGEQlRLtsgKJ1CR2coh4618g0JdjaXuft22t4spqIWbKTLz6ivp2F2BYP411iWB
 1FqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlL3I958Avk0bLqZJmu1QlHl7pM+6Jh9SOZAE4/1+bKtC42uHwQ3MApxRRXxKwFq2ra28CwCdINW32@nongnu.org
X-Gm-Message-State: AOJu0YxfCJl6iCFSZs76mLIqpWZLlC5HB5qcpOWgCpxijM9uSUTbQ8IM
 1YlmRoDTvAXwyvFV7OO1dmX/QRdicJbHkFfmh8Avnj9onD1aQfyUaGlORzfeMH8q7n1B+qlmZHw
 8qJrQ5Gu/vfiSeqqFHTQth6j9KfZa/+ygOuLXNZZ4Qeh0MBgGmFBKXW02
X-Gm-Gg: AZuq6aLNTz8MGpk0p1c+3/+DXCdlTuirz9R9PxmCHDe68wk/d7h7CDbdDCqe207VnWc
 eE6WQPr1/xODYyfd0++HV06HIU/YueSD+O5P0JTwR1/OuM4eZhypm00COE9617uBJe7jJJHraAz
 f68rFIhiaZhJxpo3oUtCNeeIy43St57wLKfq53Ogsr6BKFiY7RSM2ACfAPwNwIbnpoXnm6DYWA+
 bRhGSGfNhpNb4keSnrASWg8BOeei6hPfLlco1hbwA8Ddx0BMvuw/Cq8WrQ7WmbomtkIqUtFhClG
 N3DNJB6hzQM+hHhDERoHUbnN9l5BPF0+qJGngcemXqIl9/x+8qBIya+c3dsXfn1p/92JOjZbzhM
 eklEcktBjjQ8PCv8+5yo5UwGsvoPdrVFUyA==
X-Received: by 2002:a05:600c:4f8a:b0:477:76c2:49c9 with SMTP id
 5b1f17b1804b1-482db4568dbmr216139365e9.2.1770129971948; 
 Tue, 03 Feb 2026 06:46:11 -0800 (PST)
X-Received: by 2002:a05:600c:4f8a:b0:477:76c2:49c9 with SMTP id
 5b1f17b1804b1-482db4568dbmr216138985e9.2.1770129971409; 
 Tue, 03 Feb 2026 06:46:11 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830511bfc6sm122054025e9.2.2026.02.03.06.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 06:46:10 -0800 (PST)
Date: Tue, 3 Feb 2026 09:46:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: liu.xuemei1@zte.com.cn
Cc: imammedo@redhat.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, sunilvl@ventanamicro.com,
 anisinha@redhat.com, pbonzini@redhat.com, palmer@dabbelt.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v4 RESEND 0/2] hw/riscv/virt: Add acpi ged and powerdown
 support
Message-ID: <20260203094546-mutt-send-email-mst@kernel.org>
References: <2025111309270952219AjKpVEnbJXB7fcGTE4g@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025111309270952219AjKpVEnbJXB7fcGTE4g@zte.com.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Nov 13, 2025 at 09:27:09AM +0800, liu.xuemei1@zte.com.cn wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> Add riscv acpi powerdown support


did you abandon this or do you plan to address Igor's comments?

> Changes in v4:
> - Added modifies of DSDT blob in another patch
> - Link to v3: https://lore.kernel.org/qemu-riscv/20250723113739751COZ5PkRzx6aXEuKzsHhm_@zte.com.cn/
> 
> Changes in v3:
> - Added missing param to virt_is_acpi_enabled
> - Fixed failure of bios-tables-test
> - Link to v2: https://lore.kernel.org/qemu-riscv/202506201130099861lTkD839Hh6oko8Jo2W2H@zte.com.cn/
> 
> Changes in v2:
> - Unwrappered acpi_dsdt_add_ged function
> - Modified base address of VIRT_ACPI_GED
> - Added conditions for function calls
> - Adjusted code formatting
> - Link to v1: https://lore.kernel.org/qemu-riscv/202506191556260735QxWC8sxRwFURYEvlD24y@zte.com.cn/
> 
> Xuemei Liu (2):
>   hw/riscv/virt: Add acpi ged and powerdown support
>   tests/acpi: Add acpi ged and power button in DSDT for RISC-V
> 
>  hw/riscv/Kconfig                  |   1 +
>  hw/riscv/virt-acpi-build.c        |  10 +++++++++
>  hw/riscv/virt.c                   |  35 ++++++++++++++++++++++++++++++
>  include/hw/riscv/virt.h           |   4 ++++
>  tests/data/acpi/riscv64/virt/DSDT | Bin 3538 -> 3681 bytes
>  5 files changed, 50 insertions(+)
> 
> -- 
> 2.27.0


