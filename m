Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F19C47DB3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 00:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUc7s-0007lO-BB; Mon, 29 Jan 2024 19:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rUc7a-0007hS-Uy
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 19:37:09 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rUc7Y-0001Jr-AL
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 19:37:02 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55c33773c0aso3375968a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 16:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706575018; x=1707179818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=1uiKDdqWco/b2Xfnp3UEOuEPYTtfPdX0+YSRA5Q8bUg=;
 b=UPaewLV7UCk09BuSRrpHDhFg3QWsAqC6QL7/nURcvMWhr2WLalkmkidM7c/etXG8db
 OIAvMBOFHr2asq3vumuXGUeabLrVWMJTL9s1DLROCoJ3UAhW+n0lLKweNIb0DQJzSnyO
 eIfNcl+aRgls6NUKHNslV3IDnFxSCa455jm57O02Ctm1ZQFLOkiOIEI95Kc56xywgWX9
 36gvh4Y6vpIpFfGocsptQEO/3DJ9D99CGLrC6PYVkWHVDRVXYbgk4w1msSwtZsNMLO9v
 twY23EM+L+maCnhRvNZbDxmlZ5l2ylraKVjrtTMRayaJwqdyQXE9Cdvm5niBjLBeilAN
 jGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706575018; x=1707179818;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1uiKDdqWco/b2Xfnp3UEOuEPYTtfPdX0+YSRA5Q8bUg=;
 b=eK7hzyI9aSz08vpi5lQjiYxhsn4coK2QQw9QpeacRQ5hZPxq64Y6/LippcOBN2qNog
 BFEhOya6rnSE5w9yHXv8y2RZWQLv9hkTb7RLv2Dr2OT/QyQ/i6NXTl+Kbya9bzRSVd/K
 UTGmgqyAxX5dssFI6Nvkqub62HLCLNUbbgFn9UzohJTXt21MU+SLj2JDW/NnOUYhMi+h
 t6/uaWLNspe6bJbzuHAXsVzF4QU9Rnr/svk+rzjRIEowisdiMGRImaE4xQj1D/r+UU6t
 nOKwZVnb4LCR1kHbgiJzHiimbrLzS1+FiQeHFxQM0pO5v2yz84X7Sgq4RlW5zl9ZgvZ8
 JAoA==
X-Gm-Message-State: AOJu0Yx6Drflv9wN6BPWWWKEQ1LFsAUqqOUvlIAV7PddNyMuFGQHr91b
 ojsGkpBggJyReVKPrWGWfKcF10S+uxy83HDf3+tbiNSyGFCOMhb/vQ+X4qUj
X-Google-Smtp-Source: AGHT+IFodGByfeABetCIgxC/hxMRv8WT09ED0dnUzgexm7VKe/ez9gfvGjoTKitJMnKmlC0I8LjOyA==
X-Received: by 2002:a05:6402:51cb:b0:55f:891:d8e3 with SMTP id
 r11-20020a05640251cb00b0055f0891d8e3mr2282610edd.21.1706575017617; 
 Mon, 29 Jan 2024 16:36:57 -0800 (PST)
Received: from ?IPv6:::1?
 (p200300faaf172400ed0c0d8c68bcda58.dip0.t-ipconnect.de.
 [2003:fa:af17:2400:ed0c:d8c:68bc:da58])
 by smtp.gmail.com with ESMTPSA id
 b4-20020a056402138400b0055f2e703b52sm499928edv.33.2024.01.29.16.36.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 16:36:57 -0800 (PST)
Date: Tue, 30 Jan 2024 00:36:56 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] smc37c669: remove useless is_enabled functions
In-Reply-To: <20240129133420.1105877-1-pbonzini@redhat.com>
References: <20240129133420.1105877-1-pbonzini@redhat.com>
Message-ID: <E3DFA608-FA6C-4793-AE6E-FF0CD2CA2240@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 29=2E Januar 2024 13:34:20 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>Calls to is_enabled are bounded to indices that actually exist in
>the SuperIO device=2E  Therefore, the is_enabled functions in
>smc37c669 are not doing anything and they can be removed=2E

Indeed isa_superio_realize() only considers =2Ecount instances respectivel=
y and `qemu-system-alpha -M clipper` prints something on the screen=2E So:

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat=2Ecom>
>---
> hw/isa/smc37c669-superio=2Ec | 18 ------------------
> 1 file changed, 18 deletions(-)
>
>diff --git a/hw/isa/smc37c669-superio=2Ec b/hw/isa/smc37c669-superio=2Ec
>index 18287741cb4=2E=2E388e2ed9371 100644
>--- a/hw/isa/smc37c669-superio=2Ec
>+++ b/hw/isa/smc37c669-superio=2Ec
>@@ -14,11 +14,6 @@
>=20
> /* UARTs (compatible with NS16450 or PC16550) */
>=20
>-static bool is_serial_enabled(ISASuperIODevice *sio, uint8_t index)
>-{
>-    return index < 2;
>-}
>-
> static uint16_t get_serial_iobase(ISASuperIODevice *sio, uint8_t index)
> {
>     return index ? 0x2f8 : 0x3f8;
>@@ -31,11 +26,6 @@ static unsigned int get_serial_irq(ISASuperIODevice *s=
io, uint8_t index)
>=20
> /* Parallel port */
>=20
>-static bool is_parallel_enabled(ISASuperIODevice *sio, uint8_t index)
>-{
>-    return index < 1;
>-}
>-
> static uint16_t get_parallel_iobase(ISASuperIODevice *sio, uint8_t index=
)
> {
>     return 0x378;
>@@ -53,11 +43,6 @@ static unsigned int get_parallel_dma(ISASuperIODevice =
*sio, uint8_t index)
>=20
> /* Diskette controller (Software compatible with the Intel PC8477) */
>=20
>-static bool is_fdc_enabled(ISASuperIODevice *sio, uint8_t index)
>-{
>-    return index < 1;
>-}
>-
> static uint16_t get_fdc_iobase(ISASuperIODevice *sio, uint8_t index)
> {
>     return 0x3f0;
>@@ -79,20 +64,17 @@ static void smc37c669_class_init(ObjectClass *klass, =
void *data)
>=20
>     sc->parallel =3D (ISASuperIOFuncs){
>         =2Ecount =3D 1,
>-        =2Eis_enabled =3D is_parallel_enabled,
>         =2Eget_iobase =3D get_parallel_iobase,
>         =2Eget_irq    =3D get_parallel_irq,
>         =2Eget_dma    =3D get_parallel_dma,
>     };
>     sc->serial =3D (ISASuperIOFuncs){
>         =2Ecount =3D 2,
>-        =2Eis_enabled =3D is_serial_enabled,
>         =2Eget_iobase =3D get_serial_iobase,
>         =2Eget_irq    =3D get_serial_irq,
>     };
>     sc->floppy =3D (ISASuperIOFuncs){
>         =2Ecount =3D 1,
>-        =2Eis_enabled =3D is_fdc_enabled,
>         =2Eget_iobase =3D get_fdc_iobase,
>         =2Eget_irq    =3D get_fdc_irq,
>         =2Eget_dma    =3D get_fdc_dma,

