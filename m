Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F284DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sesBC-0007YX-Vq; Fri, 16 Aug 2024 04:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sesBB-0007Rz-9Q
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sesB9-0003bs-MS
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723796363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjGlFvMeZNehK1w5wtaKUP74GiBi92a6em/Iv+rrTAo=;
 b=ambEKBrodhL2Lghw2u3J80uFCQfag5yPFIKpquoFdgfkSw90Ay8tFk71TZ2uuUzg9tf0Jy
 ZF0rE59fB5hFc0SdO6veDh3CgadIUCOzx/rv8PDH6zUQeoZqGN1zKDQrIkhhuKgrem9fgK
 t8cFrOTVXS5KdxuVE1DASie+CtNElMQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-74PMUcoeMm2sms9D4Ad6WA-1; Fri, 16 Aug 2024 04:19:17 -0400
X-MC-Unique: 74PMUcoeMm2sms9D4Ad6WA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ef23b417bcso13663901fa.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 01:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723796356; x=1724401156;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MjGlFvMeZNehK1w5wtaKUP74GiBi92a6em/Iv+rrTAo=;
 b=fr9JN1k5PVebIl7+ZWtJNVJaP+bloAudpEktweZ5bc2fAONKCFTjh5g1fsteT48Lsr
 cr6yotObXDFf8zTmfkbg22TXeqF8nNgsU+tmBlBu0LlXznNOTX12CRpNlY019illqkqN
 zdeAaJko/HBQOFUzlyD3miqnaNOBol4sl3MLkI3UG1nVdNAiejzp7UFigp3ns55XFHnN
 iudT6VJmzvHWCTORvyvqLdey8YhOyjDnY4impQU8RoanOM2qXp5cjowGvrpff+nLe1hx
 G03K5fK1hbaDmDcR0tW6YHRSPF4ndi0294dKn9lqJHztLR5eD6EFFuRifLqEBkiucMH2
 YTQw==
X-Gm-Message-State: AOJu0YzY4jKCQRzYFYoeOgKmnk3DJgdK8/RbjghJbhItiYzpYBtXRFbr
 c7sbL9EXcBnO7IVseVLY7zwBzDE79nPxuBiDcV04BUu7gwv7lD6nXq3cIuVo+N7G+QEldGI561s
 ATXLUijVNVOlfoAVCwkdIGHM6ISTMet4ZglhntFRyl77VtnPZHfO9
X-Received: by 2002:a05:6512:1085:b0:52c:a016:5405 with SMTP id
 2adb3069b0e04-5331c6914a6mr1571274e87.8.1723796355768; 
 Fri, 16 Aug 2024 01:19:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETUpoGQAUzUH4RwR7T53nNjTGrischl3/TwsHI0X5+ohyTf+2GXpQiTYjm3/yLiMF/VyElPg==
X-Received: by 2002:a05:6512:1085:b0:52c:a016:5405 with SMTP id
 2adb3069b0e04-5331c6914a6mr1571230e87.8.1723796354919; 
 Fri, 16 Aug 2024 01:19:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:3378:6322:e9ee:713:b9ed])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cfaffsm218902366b.76.2024.08.16.01.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 01:19:14 -0700 (PDT)
Date: Fri, 16 Aug 2024 04:19:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kamil =?utf-8?Q?Szcz=C4=99k?= <kamil@szczek.dev>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Joelle van Dyne <j@getutm.app>, Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-9.1 v2] hw/i386/pc: Ensure vmport prerequisites are
 fulfilled
Message-ID: <20240816041900-mutt-send-email-mst@kernel.org>
References: <CJaQOvoJMl8P04F7-0Pk23paXt29GnSt2ICM-xlruQ9rGsMHocU_xH3RRaRRJEQpqUxGo63sATZb5St7968jHLV0r7NORODN3zHgi_qxpPE=@szczek.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CJaQOvoJMl8P04F7-0Pk23paXt29GnSt2ICM-xlruQ9rGsMHocU_xH3RRaRRJEQpqUxGo63sATZb5St7968jHLV0r7NORODN3zHgi_qxpPE=@szczek.dev>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 16, 2024 at 08:01:26AM +0000, Kamil Szczęk wrote:
> Since commit 4ccd5fe22feb95137d325f422016a6473541fe9f ('pc: add option
> to disable PS/2 mouse/keyboard'), the vmport will not be created unless
> the i8042 PS/2 controller is enabled. To avoid confusion, let's fail if
> vmport was explicitly requested, but the i8042 controller is disabled.
> This also changes the behavior of vmport=auto to take i8042 controller
> availability into account.
> 
> Signed-off-by: Kamil Szczęk <kamil@szczek.dev>


tagged, thanks!

> ---
>  hw/i386/pc.c      | 8 ++++++--
>  hw/i386/pc_piix.c | 3 ++-
>  hw/i386/pc_q35.c  | 2 +-
>  qemu-options.hx   | 4 ++--
>  4 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c74931d577..c99f2ce540 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1075,7 +1075,7 @@ static const MemoryRegionOps ioportF0_io_ops = {
>  };
>  
>  static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
> -                            bool create_i8042, bool no_vmport)
> +                            bool create_i8042, bool no_vmport, Error **errp)
>  {
>      int i;
>      DriveInfo *fd[MAX_FD];
> @@ -1100,6 +1100,10 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
>      }
>  
>      if (!create_i8042) {
> +        if (!no_vmport) {
> +            error_setg(errp,
> +                       "vmport requires the i8042 controller to be enabled");
> +        }
>          return;
>      }
>  
> @@ -1219,7 +1223,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>  
>      /* Super I/O */
>      pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
> -                    pcms->vmport != ON_OFF_AUTO_ON);
> +                    pcms->vmport != ON_OFF_AUTO_ON, &error_fatal);
>  }
>  
>  void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index d9e69243b4..cf2e2e3e30 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -312,7 +312,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>  
>      assert(pcms->vmport != ON_OFF_AUTO__MAX);
>      if (pcms->vmport == ON_OFF_AUTO_AUTO) {
> -        pcms->vmport = xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
> +        pcms->vmport = (xen_enabled() || !pcms->i8042_enabled)
> +            ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
>      }
>  
>      /* init basic PC hardware */
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 9d108b194e..6c112d804d 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -278,7 +278,7 @@ static void pc_q35_init(MachineState *machine)
>  
>      assert(pcms->vmport != ON_OFF_AUTO__MAX);
>      if (pcms->vmport == ON_OFF_AUTO_AUTO) {
> -        pcms->vmport = ON_OFF_AUTO_ON;
> +        pcms->vmport = pcms->i8042_enabled ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>      }
>  
>      /* init basic PC hardware */
> diff --git a/qemu-options.hx b/qemu-options.hx
> index cee0da2014..0bc780a669 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -68,8 +68,8 @@ SRST
>  
>      ``vmport=on|off|auto``
>          Enables emulation of VMWare IO port, for vmmouse etc. auto says
> -        to select the value based on accel. For accel=xen the default is
> -        off otherwise the default is on.
> +        to select the value based on accel and i8042. For accel=xen
> +        and/or i8042=off the default is off otherwise the default is on.
>  
>      ``dump-guest-core=on|off``
>          Include guest memory in a core dump. The default is on.
> -- 
> 2.45.0
> 


