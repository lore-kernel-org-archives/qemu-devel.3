Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BCCC55AB9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 13:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtQc2-0005tN-M0; Fri, 20 Feb 2026 08:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtQbw-0005s6-29
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 08:32:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtQbu-0000MB-0I
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 08:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771594316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EuqsRuBFLY9yOpMu+UA+hXNkj1oESpQZXgyeOHQGK6w=;
 b=HmsBpegw0/gAjw0JHOrnH2nucTUZXXul0wpfyEwnWL09y/RUlLTE3CNPrOYu4FwbzWoC79
 3V6kH3TdMj4zfgnWU8gypAAsZbLF0mjM8xd6T+kv8O/rd8+mGtEhLIE0rLrtBM+lKOXrQ/
 K0mKDjIDWJmOD90sEh33cp7aK85DqOg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-MfYpm1NoP4K_TkUMuRo3Uw-1; Fri, 20 Feb 2026 08:31:54 -0500
X-MC-Unique: MfYpm1NoP4K_TkUMuRo3Uw-1
X-Mimecast-MFC-AGG-ID: MfYpm1NoP4K_TkUMuRo3Uw_1771594313
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483a2db68caso13638535e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 05:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771594313; x=1772199113; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EuqsRuBFLY9yOpMu+UA+hXNkj1oESpQZXgyeOHQGK6w=;
 b=qCQWZBqnOFw4it2MjBJPMD7Tq4oFBTtpX6Z4ZT2uO8+B35zwLWvRlmE2F47/4pUKpn
 2+4j0R3kpz8wfaDOdNaOYgNgBpM9abIRZufww11oT96j/v5AVqhH5ZKWb9pVbQQeEeJQ
 9uAz+nZKnezQmeq3n4zkJRUcSnamPxRLRNWgxh4xnMD9zNzPqRgLf3FMC//UoUvCPZbz
 NRqULxkxdkOODdQTw1bNV3xLVo2WPaFAMSWS2xUUKP13exD2MU6em1Vno0FguSx4HNNZ
 yMoB6Yoae5bxQpxer358WDEfhcweAOtjwTBfiaGAYk5g4JgiUqhHuQ+w8+i1BY5j2tdF
 En0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771594313; x=1772199113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EuqsRuBFLY9yOpMu+UA+hXNkj1oESpQZXgyeOHQGK6w=;
 b=lEBVvKPUqX3eDghD2V1YUNO280Jvy0Xqpxfv4wlrjdxffrb0VIpmxK6z3o3ZnleJ6A
 EhPCluS+F/CDKAWbptAiX4nJvxg0TPEiha0E3o8zvEeeZNS07/fdT2pwIB8VayJT7we6
 NlUO6Nn/6+nG4DPJpUZzZP17IZsWFBhOcxmktQLfbdh5Yfcry4yWrAYZuWS0Lh9I5WkD
 1HEtPFfyAkfH/ZqDu/7VUKjJ9IgSw/OCHF/pDwlBAjdiAjU4YC9PCcWfKbUSsDuUk/hP
 /jf70RDlJJ0FxDa9A/s6tcX+9twngCKSs5PJF20GKSsPlKuqcymws6IyImmuVs6O8jkB
 OpSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5FmNhezGvEZf0QwhxC4/WCkU6PoNTttS4yg0VXnL4nxjOhMslVIod64f+a3oXhBa8JVSiJ2Jk5A4F@nongnu.org
X-Gm-Message-State: AOJu0YyS6pfAQ/bIAehxb8n8W1PeWHP9bN/Al+M/OnbEkpCuOnhPQ7Ng
 Eb0xRomUuIlhyS0yH3qt+LAP9JRXuVrNkJ8qyYCpiPBXNcIYHLOHVNqgtPM1bexAPegUZPERe5a
 oTtOHgpOFeMC/vas0ORHOKbnV9/XDzYHiD6QIRvSoq67gb5k2B39itKoH
X-Gm-Gg: AZuq6aLKLXlrXoMduKGu5kJALbaiJXAtKKUG7JXPClt1v8J6NmZ23ApkSZ77POwrxCb
 yjBTI7NiAaYYGEFI+xBNRRESwzZRKPEGn/ku1UyazWrqrpwpzmPdN3cpfDvRs2Kh5t5PEVQj6Rd
 R7iu/cEUNpFV7y7gBsSd27zwYxqBAQD/eqNr7gXe/4mQqF51hV3UIx7ndM1ZwQCvMVbRefN5hFi
 wGtGERETJOOVjCU1UFFz7ClewN6jaVCnqOuY2JDNdfdXIlMDJt1yhsrCeOVimp99FOFM+lb5eV5
 dAzkxHNNfm3INylOcIUQ22/xnvRGBASFDbfID3D5aE3H9EESTCHPyT2qShR+u3JFTCDzGW5JRtF
 5QFsOb+ICi1X0vVrsi0OGBN73bjieGxB3EPt/TK3+JSNSCA==
X-Received: by 2002:a05:600c:871b:b0:483:8e43:6def with SMTP id
 5b1f17b1804b1-48398ae5461mr125128315e9.28.1771594313142; 
 Fri, 20 Feb 2026 05:31:53 -0800 (PST)
X-Received: by 2002:a05:600c:871b:b0:483:8e43:6def with SMTP id
 5b1f17b1804b1-48398ae5461mr125127735e9.28.1771594312692; 
 Fri, 20 Feb 2026 05:31:52 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31f9475sm62803155e9.14.2026.02.20.05.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 05:31:52 -0800 (PST)
Date: Fri, 20 Feb 2026 08:31:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: liu.xuemei1@zte.com.cn
Cc: imammedo@redhat.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, sunilvl@ventanamicro.com,
 anisinha@redhat.com, pbonzini@redhat.com, palmer@dabbelt.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v6 0/4] hw/riscv/virt: Add acpi ged and powerdown support
Message-ID: <20260220083119-mutt-send-email-mst@kernel.org>
References: <20260209102128930gN_7xu7bNIZcEawnIz3c7@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209102128930gN_7xu7bNIZcEawnIz3c7@zte.com.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Feb 09, 2026 at 10:21:28AM +0800, liu.xuemei1@zte.com.cn wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> Add acpi ged and powerdown support for riscv


acpi bits:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I assume this will be merged by riscv maintainers?

> Changes in v6:
> - Removed unnecessary condition when build ged aml
> - Link to v5: https://lore.kernel.org/qemu-devel/20260204182041057hohVHgmaAJborE1DrghXH@zte.com.cn/
> 
> Changes in v5:
> - Added a new patch to allow DSDT acpi table changes
> - Split a new patch to support ACPI GED
> - Introduced a condition for calling acpi_send_event
> - Link to v4: https://lore.kernel.org/qemu-devel/2025111309270952219AjKpVEnbJXB7fcGTE4g@zte.com.cn/
> 
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
> Xuemei Liu (4):
>   tests/acpi: virt: allow DSDT acpi table changes
>   hw/riscv/virt: Add acpi ged support
>   hw/riscv/virt: add system_powerdown hmp command support
>   tests/acpi: Add acpi ged and power button in DSDT for RISC-V
> 
>  hw/riscv/Kconfig                  |   1 +
>  hw/riscv/virt-acpi-build.c        |   8 +++++++
>  hw/riscv/virt.c                   |  37 ++++++++++++++++++++++++++++++
>  include/hw/riscv/virt.h           |   4 ++++
>  tests/data/acpi/riscv64/virt/DSDT | Bin 3538 -> 3681 bytes
>  5 files changed, 50 insertions(+)
> 
> -- 
> 2.27.0


