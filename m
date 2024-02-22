Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A8EC54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 15:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdAwk-0002eY-PW; Thu, 22 Feb 2024 10:25:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rdAwh-0002eC-3H
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:25:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rdAwf-0007xc-7I
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708615507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nvLcEKFoeqR+bYgHg9r5skCMskVASqgKSTlChKlJ+2Y=;
 b=hQNnF05kmaW3ocuqGW6moOKNrJ2BL/eE502dBwCaDwjmXMKAy9rDIsoAA/5ZNjjQQ9ZGSb
 sJohWiC2YATRqq7Su8H8vUewr6otCLtIQ/L3dLkjW0VqbnH+CSHeI1Fdx9RRIp42XGWI3z
 P/OKxGbPdCD2EgUv6DM05uwvfHTn0uw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-dEu3VZ2iPV-PWU6sVFEONA-1; Thu, 22 Feb 2024 10:25:06 -0500
X-MC-Unique: dEu3VZ2iPV-PWU6sVFEONA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-412829eab17so4253505e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 07:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708615505; x=1709220305;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvLcEKFoeqR+bYgHg9r5skCMskVASqgKSTlChKlJ+2Y=;
 b=Qf2jsh7p9DLljXj/Zs4kFullQK8U4IxHLWOS/KUFAdOus+sb7Stapx0Y8MGGuE/YU6
 PcMF5p6jN43aTnZIlh4V4aose2CKLCy/Mj/c2YDGzfDHmRSv7zRv5b+VGhK/9RMejYWX
 cYwZ3lSdiMS/Ha4STVLoWWVGn9487FuDMdShsqm3Dq5k0vD5ljPd7XkXLQpBnTKUb7Zi
 wqbrZ4Y7i0HJSVv+wOPJpOvnjnIPB46m5uK4tTZbUTSQbOAS2hIL3Pbv9Uxxu5hIjgnw
 voHCD10PVRbqeGCe97a/oB/mjqHYj2jeBRKrn6p8DfFc7Vw7pjigRWHIuO37T7dCkrXV
 RoKA==
X-Gm-Message-State: AOJu0YyxtyH5c4z3N5v4vJyMbNP13jJXFfReglByiGutwqLULmvVNOsU
 vcrWcKHhKxMkaM8LcxpJ2LjtxWzk7sOiSAIfFrlNBENHt4aRDemhUu3hpD6JAtqOMgjrspsgLjO
 teu4YDeMKdCAqGYeYsTHDzIchg5uaxn//I6fPChsTVjnLM3j9unym
X-Received: by 2002:a05:600c:3106:b0:412:7b4d:4518 with SMTP id
 g6-20020a05600c310600b004127b4d4518mr1879433wmo.23.1708615504914; 
 Thu, 22 Feb 2024 07:25:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgZLhpn/L0v+gaHoAu5heI2TyMH/25AXnvkzSUB2qX2a4/29+nWmLAwElCO/UqF2K5hLGUgA==
X-Received: by 2002:a05:600c:3106:b0:412:7b4d:4518 with SMTP id
 g6-20020a05600c310600b004127b4d4518mr1879415wmo.23.1708615504605; 
 Thu, 22 Feb 2024 07:25:04 -0800 (PST)
Received: from redhat.com ([2a06:c701:73fa:1600:1669:f0ad:816d:4f7])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a7bcc89000000b00412393ddac2sm6355972wma.6.2024.02.22.07.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 07:25:04 -0800 (PST)
Date: Thu, 22 Feb 2024 10:25:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 0/9] Simplify initialization of PC machines
Message-ID: <20240222102414-mutt-send-email-mst@kernel.org>
References: <20240208220349.4948-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208220349.4948-1-shentey@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 08, 2024 at 11:03:40PM +0100, Bernhard Beschow wrote:
> The series aims to simplify the initialization process of all PC-based machines.
> 
> It consists of streamlining redundant code, as well as consolidating the setup
> of system flash and generation of smbios data which are currently fairly
> distributed.
> 
> These changes are expected to make the code easier to understand and maintain.
> 
> Best regards,
> Bernhard


This looks good to me overall.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

I see Philippe started queueing these, fine by me.

> Bernhard Beschow (9):
>   hw/i386/x86: Let ioapic_init_gsi() take parent as pointer
>   hw/i386/pc_piix: Share pc_cmos_init() invocation between pc and isapc
>     machines
>   hw/i386/x86: Turn apic_xrupt_override into class attribute
>   hw/i386/pc: Merge pc_guest_info_init() into pc_machine_initfn()
>   hw/i386/pc: Defer smbios_set_defaults() to machine_done
>   hw/i386/pc: Confine system flash handling to pc_sysfw
>   hw/i386/pc_sysfw: Inline pc_system_flash_create() and remove it
>   hw/i386/pc: Populate RTC attribute directly
>   hw/i386/pc_{piix,q35}: Eliminate local pci_bus/pci_host variables
> 
>  hw/i386/fw_cfg.h      |  3 ++-
>  include/hw/i386/pc.h  |  5 ----
>  include/hw/i386/x86.h |  5 ++--
>  hw/i386/acpi-common.c |  3 ++-
>  hw/i386/fw_cfg.c      | 12 +++++++++-
>  hw/i386/microvm.c     |  2 +-
>  hw/i386/pc.c          | 25 +++++---------------
>  hw/i386/pc_piix.c     | 55 ++++++++++++++-----------------------------
>  hw/i386/pc_q35.c      | 38 ++++++++++--------------------
>  hw/i386/pc_sysfw.c    | 17 ++++---------
>  hw/i386/x86.c         |  7 +++---
>  11 files changed, 62 insertions(+), 110 deletions(-)
> 
> -- 
> 2.43.0
> 


