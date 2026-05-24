Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A06CD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 07:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR33b-0005nP-30; Sun, 24 May 2026 03:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wR33T-0005mU-8s
 for qemu-devel@nongnu.org; Sun, 24 May 2026 03:15:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wR33Q-0005Jw-Jf
 for qemu-devel@nongnu.org; Sun, 24 May 2026 03:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779606918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MeMcg9poW2sZLHBkaJ9tRSZykW1udUhXLX9HUewfT1M=;
 b=S7ZLoNb6A4ECa6WqqZcyNdcnDnW7Zu4nw9NrCEbAl4XVRFCbO+YQfdsQv5AvPdoSOfr2MY
 ucAGtWjGtErcvo3RkH4p7vNHDZ6mZeFoWTXbYfqEN2Era2hI85sDlyzJ98mZbeaUvYQsqP
 7Bq9rxvzZIypUTvEFUTE9VcYyhqSBCw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-SIjkAeQOORmdnSIll5Jq2w-1; Sun, 24 May 2026 03:15:17 -0400
X-MC-Unique: SIjkAeQOORmdnSIll5Jq2w-1
X-Mimecast-MFC-AGG-ID: SIjkAeQOORmdnSIll5Jq2w_1779606916
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48ff0eb77b5so2419195e9.0
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 00:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779606916; x=1780211716; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MeMcg9poW2sZLHBkaJ9tRSZykW1udUhXLX9HUewfT1M=;
 b=NMX53+Fy95WQ5QSpmUhPxIThRlGyfjdBlsODjNookJmGRjFF+Yxtb7YCaXnmuCM2Ps
 4ybR93t4EsEmN/546T3hl34Mn/UR5nYk5bPDf9J1H420D3vX1qgqO+UNLwgWcU8mJpi5
 n3HYgp/FOkSjsRKjZdqQeytJ9nuZ9BeifDa0av4ECXuPH0GSxdmsZ8SplS5TiRr496NK
 FS2CCeLuRdQYIkFgCWLg0HPlF7Q1B84WnGhC6bboH0AdHqQkYI8ZVa8/qFtOOa10M0oF
 6TUse7D0Q7ygK+mHBYUrSZjU083NKlYqH3UZJYTCvNUl4qhnNZqoH+po9GL6rquqEUxR
 MhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779606916; x=1780211716;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MeMcg9poW2sZLHBkaJ9tRSZykW1udUhXLX9HUewfT1M=;
 b=VXzPvt61kdLnfe+gwSa/YLhZlU+0WDb9jgTRVL5isceC8mHClSs16MOM+uxYgxcPeS
 Tg321/v8o4vdHdKlg6Z5dEQVv6B2JgqHd+fXBzn1umNqyxv5bm0xcES8MILUp/Kh9a3u
 2cd25Lm1yFyftXK62e2LJ7LFqMQv7fvzZBIwxOQmKbWijGJGuVxqnWddwcOVAYKB/dMo
 5dBHM/Qfi9Hu2NxsicPkV6NJKXFtjGtn7WpYsD2GC3Ei+oyorLKmjUMg/r5TBucnauK3
 /E3nPGFCvDY1ZLkUCjffbXxUafoxxLlL+LRIaoqs2ooMEVllePYWUQu9t1a/hQmJ5X5n
 sISg==
X-Gm-Message-State: AOJu0YySP9uqIUbYf0VkHwF4q1JthqXAtaO7+4Q9QlHWZYWZyzlNWIo8
 an0WkthPeFyVT0l+s1bNofYR4aYenfMIQGtwaW36kaS5aa+2KtaulicRYczNewNekNLm0mUYLmd
 Eg7E0Bs7+1Dehm1/AwCo2VOCkclcpB1se1XkjuS54LwIzTc9R3GAKUPrM
X-Gm-Gg: Acq92OF4DR2fr5XSmzaTxEBJKPRnGTfCw10Duc8OAKmXxFRRKVtcjVweCDRuYhnMhD2
 GiBtfGkOkB9+ApxeoDD6qn+MH4mcQmKYUZJ06ZxTef3sS5s5Sf86LEPjvdYclWgsyaXeTUqEhr8
 E9RSGmavEPSgBMZObCFSRIP4oxyQw3PWkCl0IjQEyYgckpTr/kCsksNjUhVwdB4/uDARBcUFnht
 OWxBXpEIdTgjaAsw5guho+xWp74O6OQ0E8WLuHsDahY0RJl2zBFAUQa8pHv07dd5+WG0KY6wUlh
 OBrgd3oxaARxES/LXoi5Hq+YaUm+PjE5Z7YzSSj7JiJ8OYqaAQB2uiNsYq1UH2smyVEFcY6rbXn
 N+9E7GWU5rpjJlYnVmgzi+McqkgO3tEm/SpsOqCXXTd0=
X-Received: by 2002:a05:600c:4f0b:b0:48a:7676:30bc with SMTP id
 5b1f17b1804b1-490426a4753mr152248325e9.14.1779606915884; 
 Sun, 24 May 2026 00:15:15 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0b:b0:48a:7676:30bc with SMTP id
 5b1f17b1804b1-490426a4753mr152247945e9.14.1779606915505; 
 Sun, 24 May 2026 00:15:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490456274ebsm153744685e9.15.2026.05.24.00.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 00:15:14 -0700 (PDT)
Date: Sun, 24 May 2026 03:15:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thierry Escande <thierry.escande@vates.tech>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 0/4] Xen: Add Q35 initial support for HVM guests
Message-ID: <20260524031423-mutt-send-email-mst@kernel.org>
References: <20260313164649.794591-1-thierry.escande@vates.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313164649.794591-1-thierry.escande@vates.tech>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 13, 2026 at 04:46:56PM +0000, Thierry Escande wrote:
> This patch series introduces Q35 chipset support for Xen HVM guests. This is
> based on the work from Alexey Gerasimenko (See patchset [1] for reference).
> 
> This series does not implement device passthrough as this will need more work
> on the Xen side to support multiple PCI buses. Since Q35 chipset does not
> support device hotplugging and with current Xen mechanism for device
> passthrough, they have to be plugged to a new PCIe root port, i.e. not the PCI
> bus 0.
> 
> As a first step for Q35 guests support, this series implements:
> - Legacy interrupt routing for the ICH9 LPC bridge (i.e. not IOAPIC)
> - Xen HVM machine initialization in pc_q35_init()
> - Access to PCIe Extended Config Space
> - Fix for incorrect values and usage for PCIEXBAR masks

Xen maintainers, who's merging this?

> The corresponding patchset for the Xen Project has been posted at [2].
> 
> [1] https://lore.kernel.org/xen-devel/cover.1520867740.git.x1917x@gmail.com/
> [2] https://lore.kernel.org/xen-devel/20260313163455.790692-1-thierry.escande@vates.tech/
> 
> Alexey Gerasimenko (2):
>   pc/xen: Xen Q35 support: provide IRQ handling for PCI devices
>   q35: Fix incorrect values for PCIEXBAR masks
> 
> Thierry Escande (2):
>   q35/xen: Add Xen support for Q35
>   xen: Handle PCIe config space size in cpu_ioreq_config()
> 
>  hw/i386/pc_piix.c         |  2 --
>  hw/i386/pc_q35.c          | 12 +++++++++++-
>  hw/i386/xen/xen-hvm.c     | 38 ++++++++++++++++++++++++++++++++++++++
>  hw/isa/lpc_ich9.c         | 16 +++++++++++++---
>  hw/pci-host/q35.c         |  6 +++---
>  hw/xen/xen-hvm-common.c   | 11 +++++++----
>  include/hw/pci-host/q35.h |  4 ++--
>  include/hw/xen/xen.h      |  5 +++++
>  stubs/xen-hw-stub.c       |  4 ++++
>  9 files changed, 83 insertions(+), 15 deletions(-)
> 
> -- 
> 2.51.0
> 
> 
> 
> --
> Thierry Escande | Vates XCP-ng Developer
> 
> XCP-ng & Xen Orchestra - Vates solutions
> 
> web: https://vates.tech


