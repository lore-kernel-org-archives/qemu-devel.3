Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EE5C5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQKO-0001gW-Gj; Tue, 18 Aug 2026 16:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwQKM-0001g6-HG
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwQKK-0001Zg-Ab
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787084547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g2eywgoqKIQsjaTetCZcwjW3/NAJMVp978iHd1m2B6w=;
 b=ZEbz99UB4lgvb2TegGBrqgFWpSfUjaVaGYRFiJQSZ9OxQLWkdahKH2eN0OOGWs8MCA+M4c
 y/72dQhPRTKxp6CjfNiigT8wGU4EamYEr9EVeT2Za3Gi0Maxrfcqfzb0+DSwe5KXZ/fkfw
 Zkp5HCEx9hfBhjLXqNFlCEMkKKhugps=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-3Z74MnjNMA2QLh3sfBW8OQ-1; Tue,
 18 Aug 2026 16:22:15 -0400
X-MC-Unique: 3Z74MnjNMA2QLh3sfBW8OQ-1
X-Mimecast-MFC-AGG-ID: 3Z74MnjNMA2QLh3sfBW8OQ_1787084534
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44CA218004A9; Tue, 18 Aug 2026 20:22:14 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0189E3000239; Tue, 18 Aug 2026 20:22:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 32/32] hw/display: mark most display adapters as
 insecure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20250926140144.1998694-33-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-33-berrange@redhat.com>
Date: Wed, 19 Aug 2026 00:21:49 +0400
Message-Id: <178708450916.1320462.1427984683087351414.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9454;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fRu1Z+gGHz4+SkkKISkorbNQS7HqJHRSJLluR/9pkb8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhL7g37+oMOL4rWd+7ncXKpU+Cb7TOqMmRYOYL
 bKYYK8uZmSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoS+4AAKCRDa6OEJdZac
 5XKtD/wNslaBt2VGBz/WWM3DuHRvCAdmSAJKVtgrypERQ5I9RLokMVT73PdYMVFuXO8I2A1bBhm
 7qaz4/fpc4Vyl0LIgTkVD1lq48U6bppPRThLqkukjXlraGHDyJ9eWGnpcYXfCsPIpPXNc062yxh
 FZdDNlQe9YhVVy0Gc+Ti/kWXJAjMXV8TbXrWCW99G0tvz94g8wC4ROnjS9t2DzUZTF8qCYF/gxk
 eSbvOX82rHuCcwPrbAiu/jy6rH6koYnweiy51avBVAqGNPPW12lp1JtSEjbei01nbOYfi8mdneZ
 ItVnwXOTu7wd7kdCkOB16iX3V70XKRDJQImOLUQtSpCJuWst2Ns++Hc1Tn9+vgaxTQnVx3ilJr3
 CX3O4pjzTDxl+nhdCd0y63H1SGevkm5bCx2JgiIiqLMknEJul/FyCOasQqyerEw29+CmGA2YZaT
 9QrIEOoQYb2OrLbyjQxgp+wns9TL/jolSpdwsepFQcBl+uCW+FVQnBWiJaOfQCkch9Ut6fZ4++G
 PGAZL/RPStiCxnPq/TqRszlyVDZ5FLx+V7r/UoIif2eKhuwfXR9Od24DhNc94PrTey61sojDmMM
 3HiYrZS2TLEuSw2yJm8PSNafZ8PgSavWx7fvpXrZrxN2zFYiReuBT3w0EiFeg/8qFg/NWVW5arm
 MzzPSFA3NnaeP6Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Most of thte display adapters are emulating old hardware which is not
> relevant to virtualization use cases.
> 
> The exceptions that should be considered secure are Cirrus (PCI, not
> ISA), Bochs, QXL, RAMFB, VGA (PCI, MMIO, not ISA) and VMWare VGA.
> 
> The Cirrus PCI decision is borderline. It has been heavily used with
> virtualization in the past, but these days VGA / RAMFB are strongly
> recommended instead. Due to its historical usage though, we can
> consider the code fairly mature, even if no longer hugely relevant
> to virtualization use cases.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20250926140144.1998694-33-berrange@redhat.com>
>
> diff --git a/hw/display/artist.c b/hw/display/artist.c
> index 3c884c92437c..caab4d1d4c52 100644
> --- a/hw/display/artist.c
> +++ b/hw/display/artist.c
> @@ -1504,6 +1504,7 @@ static const TypeInfo artist_info = {
>      .instance_size = sizeof(ARTISTState),
>      .instance_init = artist_initfn,
>      .class_init    = artist_class_init,
> +    .secure        = false,
>  };
>  
>  static void artist_register_types(void)
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index f7c0006a879d..6e332e02d2fb 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -1080,6 +1080,7 @@ static const TypeInfo ati_vga_info = {
>      .instance_size = sizeof(ATIVGAState),
>      .class_init = ati_vga_class_init,
>      .instance_init = ati_vga_init,
> +    .secure = false,
>      .interfaces = (const InterfaceInfo[]) {
>            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>            { },
> diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
> index 1bb2ee45a015..bb6c986fb86f 100644
> --- a/hw/display/bcm2835_fb.c
> +++ b/hw/display/bcm2835_fb.c
> @@ -459,6 +459,7 @@ static const TypeInfo bcm2835_fb_info = {
>      .instance_size = sizeof(BCM2835FBState),
>      .class_init    = bcm2835_fb_class_init,
>      .instance_init = bcm2835_fb_init,
> +    .secure        = false,
>  };
>  
>  static void bcm2835_fb_register_types(void)
> diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
> index ad2821c97458..0495d900f6d2 100644
> --- a/hw/display/bochs-display.c
> +++ b/hw/display/bochs-display.c
> @@ -374,6 +374,7 @@ static const TypeInfo bochs_display_type_info = {
>      .instance_size  = sizeof(BochsDisplayState),
>      .instance_init  = bochs_display_init,
>      .class_init     = bochs_display_class_init,
> +    .secure         = true,
>      .interfaces     = (const InterfaceInfo[]) {
>          { INTERFACE_PCIE_DEVICE },
>          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> diff --git a/hw/display/cg3.c b/hw/display/cg3.c
> index daeef1521745..f437921a7e70 100644
> --- a/hw/display/cg3.c
> +++ b/hw/display/cg3.c
> @@ -384,6 +384,7 @@ static const TypeInfo cg3_info = {
>      .instance_size = sizeof(CG3State),
>      .instance_init = cg3_initfn,
>      .class_init    = cg3_class_init,
> +    .secure        = false,
>  };
>  
>  static void cg3_register_types(void)
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index ef08694626d6..d9403ccb57e7 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -3013,6 +3013,7 @@ static const TypeInfo cirrus_vga_info = {
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCICirrusVGAState),
>      .class_init    = cirrus_vga_class_init,
> +    .secure        = true,
>      .interfaces = (const InterfaceInfo[]) {
>          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>          { },
> diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
> index 4b55c48eff85..7b38e6c33a3c 100644
> --- a/hw/display/cirrus_vga_isa.c
> +++ b/hw/display/cirrus_vga_isa.c
> @@ -91,6 +91,7 @@ static const TypeInfo isa_cirrus_vga_info = {
>      .parent        = TYPE_ISA_DEVICE,
>      .instance_size = sizeof(ISACirrusVGAState),
>      .class_init = isa_cirrus_vga_class_init,
> +    .secure        = false,
>  };
>  
>  static void cirrus_vga_isa_register_types(void)
> diff --git a/hw/display/dm163.c b/hw/display/dm163.c
> index f8340d8275e9..f0437867753e 100644
> --- a/hw/display/dm163.c
> +++ b/hw/display/dm163.c
> @@ -343,6 +343,7 @@ static const TypeInfo dm163_types[] = {
>          .parent = TYPE_DEVICE,
>          .instance_size = sizeof(DM163State),
>          .class_init = dm163_class_init

missing trailing coma

> +        .secure = false,
>      }
>  };
>  
> diff --git a/hw/display/dpcd.c b/hw/display/dpcd.c
> index a157dc64e761..733f6433759b 100644
> --- a/hw/display/dpcd.c
> +++ b/hw/display/dpcd.c
> @@ -155,6 +155,7 @@ static const TypeInfo dpcd_info = {
>      .instance_size = sizeof(DPCDState),
>      .class_init    = dpcd_class_init,
>      .instance_init = dpcd_init,
> +    .secure        = false,
>  };
>  
>  static void dpcd_register_types(void)
> diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
> index c61e0280a7cd..85e32e8700d0 100644
> --- a/hw/display/exynos4210_fimd.c
> +++ b/hw/display/exynos4210_fimd.c
> @@ -1974,6 +1974,7 @@ static const TypeInfo exynos4210_fimd_info = {
>      .instance_size = sizeof(Exynos4210fimdState),
>      .instance_init = exynos4210_fimd_init,
>      .class_init = exynos4210_fimd_class_init,
> +    .secure = false,
>  };
>  
>  static void exynos4210_fimd_register_types(void)
> diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
> index a6ddc21d3e4a..c23d5846843e 100644
> --- a/hw/display/g364fb.c
> +++ b/hw/display/g364fb.c
> @@ -543,6 +543,7 @@ static const TypeInfo g364fb_sysbus_info = {
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(G364SysBusState),
>      .class_init    = g364fb_sysbus_class_init,
> +    .secure        = false,
>  };
>  
>  static void g364fb_register_types(void)
> diff --git a/hw/display/i2c-ddc.c b/hw/display/i2c-ddc.c
> index 2adfc1a1472f..525479aa49a2 100644
> --- a/hw/display/i2c-ddc.c
> +++ b/hw/display/i2c-ddc.c
> @@ -117,7 +117,8 @@ static const TypeInfo i2c_ddc_info = {
>      .parent = TYPE_I2C_SLAVE,
>      .instance_size = sizeof(I2CDDCState),
>      .instance_init = i2c_ddc_init,
> -    .class_init = i2c_ddc_class_init
> +    .class_init = i2c_ddc_class_init,
> +    .secure = false,
>  };
>  
>  static void ddc_register_devices(void)
> diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
> index 90e82b58be29..946f78306e2f 100644
> --- a/hw/display/jazz_led.c
> +++ b/hw/display/jazz_led.c
> @@ -310,6 +310,7 @@ static const TypeInfo jazz_led_info = {
>      .instance_size = sizeof(LedState),
>      .instance_init = jazz_led_init,
>      .class_init    = jazz_led_class_init,
> +    .secure        = false,
>  };
>  
>  static void jazz_led_register(void)
> diff --git a/hw/display/macfb.c b/hw/display/macfb.c
> index 574d667173ca..b80ce26d9b90 100644
> --- a/hw/display/macfb.c
> +++ b/hw/display/macfb.c
> @@ -825,6 +825,7 @@ static const TypeInfo macfb_sysbus_info = {
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(MacfbSysBusState),
>      .class_init    = macfb_sysbus_class_init,
> +    .secure        = false,
>  };
>  
>  static const TypeInfo macfb_nubus_info = {
> @@ -833,6 +834,7 @@ static const TypeInfo macfb_nubus_info = {
>      .instance_size = sizeof(MacfbNubusState),
>      .class_init    = macfb_nubus_class_init,
>      .class_size    = sizeof(MacfbNubusDeviceClass),
> +    .secure        = false,
>  };
>  
>  static void macfb_register_types(void)
> diff --git a/hw/display/next-fb.c b/hw/display/next-fb.c
> index ec81b766a7e4..9ddbd13ba325 100644
> --- a/hw/display/next-fb.c
> +++ b/hw/display/next-fb.c
> @@ -134,6 +134,7 @@ static const TypeInfo nextfb_info = {
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(NeXTFbState),
>      .class_init    = nextfb_class_init,
> +    .secure        = false,
>  };
>  
>  static void nextfb_register_types(void)
> diff --git a/hw/display/pl110.c b/hw/display/pl110.c
> index 09c3c59e0ed6..ce33d4c68cca 100644
> --- a/hw/display/pl110.c
> +++ b/hw/display/pl110.c
> @@ -596,18 +596,21 @@ static const TypeInfo pl110_info = {
>      .instance_size = sizeof(PL110State),
>      .instance_init = pl110_init,
>      .class_init    = pl110_class_init,
> +    .secure        = false,
>  };
>  
>  static const TypeInfo pl110_versatile_info = {
>      .name          = "pl110_versatile",
>      .parent        = TYPE_PL110,
>      .instance_init = pl110_versatile_init,
> +    .secure        = false,
>  };
>  
>  static const TypeInfo pl111_info = {
>      .name          = "pl111",
>      .parent        = TYPE_PL110,
>      .instance_init = pl111_init,
> +    .secure        = false,
>  };
>  
>  static void pl110_register_types(void)
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 18f482ca7f7b..8f876c872ad8 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -2516,7 +2516,9 @@ static const TypeInfo qxl_pci_type_info = {
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCIQXLDevice),
>      .abstract = true,
> +    .secure = true,
>      .class_init = qxl_pci_class_init,
> +    .secure        = true,


.secure is set twice here

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


