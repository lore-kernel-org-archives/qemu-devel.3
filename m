Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C00C67861
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 10:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rt3Ou-0003D3-J0; Sat, 06 Apr 2024 06:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rt3Os-0003Ck-6k
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 06:35:54 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rt3Oq-0004uk-KD
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 06:35:53 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a46a7208eedso422706766b.0
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 03:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712399751; x=1713004551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UTzEXs39efSP0D1vIf8LgwE3n50e92VC9ryCdX6S+WA=;
 b=VZHFpj5M+2hg+xuOiJvu0WKInLWxmaHuRRFSCkaXh696LbXyu2bt4E3u0cGIjUn2X5
 vJrr8t4QNf/tL9Qy2TnbnZeyLy0IRMwjuVlUJCj2N6QFzQ6jjJw7QnJt/2rteKfMalvM
 zpNcHaaiRVSEXFSHSL4W/W967HT7Asro9emo7CG9pcwo36/LUQnUNjvw8hn5KqKzDy9D
 74gOWEE73zaErX5gZbFTkaKyoo2KtA9gWb30Gkvc6pxhG35W2yIIniN4gtIiapW0s6qm
 M3XRXtO+vHY1F9qZNqHbA9JL/hToHZbh5usQ1BJZ69HL8zzOM2qMDNa270zcTehKakjs
 B7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712399751; x=1713004551;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UTzEXs39efSP0D1vIf8LgwE3n50e92VC9ryCdX6S+WA=;
 b=Oy/qJdXiZ+ixPAbG71YdbUgWwLNCIPVhF1uV1cX82yCcEL0M5XPbsu+RrCatNxs0bC
 LOsiBce+LwaCUC2k5tbZa4UHHX5DknBuO0HhFT+1opC4gT1ECFVT3tAP+fXDF6QLyici
 XnYnSjFL+F3TZ85nkxcdvbUDy5NHJokEE2+vjGWioDIWOqoTQpk3tXth5CXKilP3Ha9L
 3Ie+w6erDZbBrrUxILG3IPuIfAz9tIAl/fR3P8g34FvYvHDkyOsgyJzgqJyA9fD49zfL
 Gpkesxw/+moXP2v42xv3nLrP8wl45Rw4EhVBe7ZmT0cW0ixLHsxtOx3t7Iv5sxoRJ4PA
 jl9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkoZmEIQzRhptgLRX3QBaAkMvOqUS73Mpkjo3gN1wnZYBJdzmp6NhURp8t7P/eK1GGr59gVvQ+42iHkjbs/733uzIfVZo=
X-Gm-Message-State: AOJu0Yy+KhuPgTDXN/ecd2BZ7XfA5HDmBk7qGelg4rVkKHgFPz1XVS5i
 fSwR8oxPr5wh9JEug4f1Z5bNOx3KMC3vY+ikqU4EbdbIWrBUHMsK
X-Google-Smtp-Source: AGHT+IGbcRVdg5kMQaFwVbyuLd1okzwpm7IOgExQ3yqwmajrZzwx+/t0cPkPqlZ5tPPZxtOgSNqS/A==
X-Received: by 2002:a17:906:2488:b0:a46:8daa:436f with SMTP id
 e8-20020a170906248800b00a468daa436fmr2432052ejb.69.1712399750635; 
 Sat, 06 Apr 2024 03:35:50 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-220-023.77.13.pool.telefonica.de.
 [77.13.220.23]) by smtp.gmail.com with ESMTPSA id
 og42-20020a1709071dea00b00a4e657a5f1asm1860284ejc.112.2024.04.06.03.35.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Apr 2024 03:35:50 -0700 (PDT)
Date: Sat, 06 Apr 2024 10:35:45 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, Ani Sinha <anisinha@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH-for-9=2E1_13/29=5D_hw/i386/pc=3A_Remo?=
 =?US-ASCII?Q?ve_non-PCI_code_from_pc=5Fsystem=5Ffirmware=5Finit=28=29?=
In-Reply-To: <20240328155439.58719-14-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
 <20240328155439.58719-14-philmd@linaro.org>
Message-ID: <857F87E8-3876-4083-A1D0-F867649582A9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 28=2E M=C3=A4rz 2024 15:54:21 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=
 <philmd@linaro=2Eorg>:
>x86_bios_rom_init() is the single non-PCI-machine call
>from pc_system_firmware_init()=2E Extract it to the caller=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> hw/i386/pc=2Ec       | 6 +++++-
> hw/i386/pc_sysfw=2Ec | 5 +----
> 2 files changed, 6 insertions(+), 5 deletions(-)
>
>diff --git a/hw/i386/pc=2Ec b/hw/i386/pc=2Ec
>index f184808e3e=2E=2E5b96daa414 100644
>--- a/hw/i386/pc=2Ec
>+++ b/hw/i386/pc=2Ec
>@@ -956,7 +956,11 @@ void pc_memory_init(PCMachineState *pcms,
>     }
>=20
>     /* Initialize PC system firmware */
>-    pc_system_firmware_init(pcms, rom_memory);
>+    if (pci_enabled) {
>+        pc_system_firmware_init(pcms, rom_memory);
>+    } else {
>+        x86_bios_rom_init(machine, "bios=2Ebin", rom_memory, true);
>+    }
>=20
>     option_rom_mr =3D g_malloc(sizeof(*option_rom_mr));
>     memory_region_init_ram(option_rom_mr, NULL, "pc=2Erom", PC_ROM_SIZE,
>diff --git a/hw/i386/pc_sysfw=2Ec b/hw/i386/pc_sysfw=2Ec
>index 862a082b0a=2E=2E541dcaef71 100644
>--- a/hw/i386/pc_sysfw=2Ec
>+++ b/hw/i386/pc_sysfw=2Ec
>@@ -202,10 +202,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
>     int i;
>     BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
>=20
>-    if (!pc_machine_is_pci_enabled(pcms)) {
>-        x86_bios_rom_init(MACHINE(pcms), "bios=2Ebin", rom_memory, true)=
;
>-        return;
>-    }
>+    assert(pc_machine_is_pci_enabled(pcms));

AFAICS nothing refers to pci in the whole file any longer=2E The only reas=
on for checking pci_enabled before seems for filtering out the x86_bios_rom=
_init() case=2E This has been moved to the caller=2E Can we thus drop the a=
ssert? This allows for further removal of code in this patch and avoids sup=
erficial barriers for reusing this code=2E Or do I miss something?

Anyway, this patch looks like good material on its own and could be tagged=
 independently=2E

With dropping the assert considered:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>=20
>     /* Map legacy -drive if=3Dpflash to machine properties */
>     for (i =3D 0; i < ARRAY_SIZE(pcms->flash); i++) {

