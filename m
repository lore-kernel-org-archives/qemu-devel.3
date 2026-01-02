Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886E2FA3729
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 15:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbgox-0001pR-T6; Fri, 02 Jan 2026 10:12:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vbgos-0001oq-OO
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 10:12:02 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vbgop-00036Z-1H
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 10:12:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47d493a9b96so25972645e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 07:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767366716; x=1767971516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aK2olkTpRWCFEb6DHOzo3M+Yo+gZujeyKPO/GMd0xGc=;
 b=SVwdyoPnwmtdG7u2p8recuyNRwEKpNEVxaAP9a+6i7DtAEdFUSmrfvYldA/KFB2Td7
 Zo4HAgtO0E3xYWFWk3FeTjvrheGSSfhT5tliNGOp9bOQ+pFai6bTyy3a/Ar5K8QlsoOB
 kyUnlO/+GjEQ+q6dKlmA7r7SPIvY7ZnQMNqXoKvd2YaXPsrQkK/VXH2MELvio0bTH46B
 m6HeOTCm1fBv3ySxKlLORqb7tSa+hkjGbJiH+DrBROGm1zLgQcsy0KwlvoIGh5Pnp3ak
 Wy+uCOCqndS93SNaXkJVg9x91oBqY0Yc09y1WUG3XPXfXERS17YLug8sJnth58M8vH+H
 xnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767366716; x=1767971516;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aK2olkTpRWCFEb6DHOzo3M+Yo+gZujeyKPO/GMd0xGc=;
 b=Dgh+XKNz2rdpQZqDaW4Gu6JGQUq3IVVzUaXTaVhQNOOFTZB7Gu5pVtxpng3Bg7JI5i
 HTv/b2ts4DONxAtUIQrYY7TZmzFpYy/aRg3WTPFAzbfT3fvvrOjcc3DJ2b+24VLvY2+H
 UCVA8eRP25WVAODei0pEbldxoutO50H9JHuU9LvVFwg7dIlUA2iHTp18zHoe66NVyULv
 qrtmtyx1JACCThnWwdHInenBFbypc8jv7hndaMWWKb5fkVcNWdqLrADh83Ho3fvvpf1f
 Lxw3/aOHXFipvucp1exaLDmALWGK+goVfQzmv/kcE00glLoID2QAUxo0TGDJddDnlfZO
 ag5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNVS1z0PpwqO7Z7r6ZqC4GiN5DJxQir5SVKkpf/VktaM4mWsQxZ2oURZlXXNuFkBhSLo3xj4cG+rpQ@nongnu.org
X-Gm-Message-State: AOJu0Yw3dSe5rF/USGv3FXmBOegE8561btagd9aSN2JM/CJvLSG80G4V
 ks6aeGW4Gu8bqWfIiN1wmRUrYdsz8R8qbkwl4o98JhfbXCHb2QGfN2zI
X-Gm-Gg: AY/fxX7YK1ckAR4A4D6xZ2WDrnctJHF9HAd0rVymj2oJmSn0/eHU/Y6FGUNGMQwZikK
 +9l23RS6tCuerNq021MaAurpTwURzn3mQpdcstgQUoCa0vBJ8t8kLiaThw3tmd9tnbrL3g8yYll
 FmMMztLbRzrXr3YpTetcfLw76oHTjV0uY44iLDrn+DusiAZGfKcdEm5q9zJkiu06MZFMZ5uXwJb
 1FIEmotvvIeu/+/3UVN8JPQwTCN0bcpuVJpmUSUg0cunWuHwjjkFxsHJNXDq/XijWVfBSs32dXe
 W/A+tVushxO8GB8HGdKELjML4uGTVUzWt2v2/BoZmRMeqFaJuXkcFCPUtB3mQjW+N1kTB7u1kbw
 xA7sNv77eBx5xK8XvnMYRCYW1ppSexQwvturWrQT3pUGS7W4bDiraPLNLthtteZZPr3pVVpWETX
 wyC73fbEgwAZW4rrwMDdp2HLPeZnnVxOtjbgxSMZEDWCJ//pzUx+90xHMBvcLfreo53GDGYwZMH
 mcVmi+Fk9B9YIFXmgOWUIslB7m+Um2s69w=
X-Google-Smtp-Source: AGHT+IGFvxxAG6tZ6HEvgND2vujLrvYNyv0WE8bnidZ5AVSdZVeuVDtyQpdxPK1OrQdZh2NiRZbyrw==
X-Received: by 2002:a05:600c:4686:b0:471:9da:5232 with SMTP id
 5b1f17b1804b1-47d1954ea05mr595555345e9.15.1767366716001; 
 Fri, 02 Jan 2026 07:11:56 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-237d-1400-f91d-651c-a220-693b.310.pool.telefonica.de.
 [2a02:3100:237d:1400:f91d:651c:a220:693b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2724fe8sm946375695e9.1.2026.01.02.07.11.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 07:11:55 -0800 (PST)
Date: Fri, 02 Jan 2026 15:11:55 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?UTF-8?Q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>
CC: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 6/6] docs/arm/sabrelite: Mention FlexCAN support
In-Reply-To: <b13be1ee5d264b051eacf260ea767f6b6424e55b.1765826753.git.matyas.bobek@gmail.com>
References: <cover.1765826753.git.matyas.bobek@gmail.com>
 <b13be1ee5d264b051eacf260ea767f6b6424e55b.1765826753.git.matyas.bobek@gmail.com>
Message-ID: <547A6765-6BAE-459C-A41C-E3667AA1486F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
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



Am 15=2E Dezember 2025 20:03:15 UTC schrieb "Maty=C3=A1=C5=A1 Bobek" <maty=
as=2Ebobek@gmail=2Ecom>:
>Also added example command line usage of the Sabrelite board
>with FlexCAN controllers=2E
>
>Signed-off-by: Maty=C3=A1=C5=A1 Bobek <matyas=2Ebobek@gmail=2Ecom>
>---
> docs/system/arm/sabrelite=2Erst |  1 +
> docs/system/devices/can=2Erst   | 20 ++++++++++++++++++++
> 2 files changed, 21 insertions(+)
>
>diff --git a/docs/system/arm/sabrelite=2Erst b/docs/system/arm/sabrelite=
=2Erst
>index 4ccb0560af=2E=2Ed3a3c01dd6 100644
>--- a/docs/system/arm/sabrelite=2Erst
>+++ b/docs/system/arm/sabrelite=2Erst
>@@ -24,6 +24,7 @@ The SABRE Lite machine supports the following devices:
>  * 4 SDHC storage controllers
>  * 4 USB 2=2E0 host controllers
>  * 5 ECSPI controllers
>+ * 2 FlexCAN CAN controllers
>  * 1 SST 25VF016B flash
>=20
> Please note above list is a complete superset the QEMU SABRE Lite machin=
e can
>diff --git a/docs/system/devices/can=2Erst b/docs/system/devices/can=2Ers=
t
>index 09121836fd=2E=2E5f21c01550 100644
>--- a/docs/system/devices/can=2Erst
>+++ b/docs/system/devices/can=2Erst
>@@ -173,6 +173,26 @@ The test can also be run the other way around, gener=
ating messages in the
> guest system and capturing them in the host system=2E Other combinations=
 are
> also possible=2E
>=20
>+Examples on how to use CAN emulation for FlexCAN on SabreLite board
>+-------------------------------------------------------------------
>+FlexCANs are connected to QEMU CAN buses by passing the bus IDs as machi=
ne properties:

Blank line needed here=2E=2E=2E

>+* property ``canbus0`` for connecting ``flexcan1``
>+* property ``canbus1`` for connecting ``flexcan2``

=2E=2E=2E and here to turn this into a list of bullet points=2E

I'd merge this patch into "[PATCH v1 4/6] hw/arm: Plug FlexCAN into FSL_IM=
X6 and Sabrelite" but this is totally up to you=2E

With the bullet points fixed:

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>+Note that upstream Linux SabreLite DTs have only a single FlexCAN (``fle=
xcan1``) enabled=2E
>+
>+An example command to run QEMU emulating a Sabrelite development board
>+with both FlexCANs connected to a single QEMU CAN bus (called ``qcan0``)=
,
>+bridged to host system ``can0`` interface::
>+
>+  qemu-system-arm -M sabrelite -smp 4 -m 1G \
>+    -object can-bus,id=3Dqcan0 \
>+    -machine canbus0=3Dqcan0 -machine canbus1=3Dqcan0 \
>+    -object can-host-socketcan,if=3Dcan0,canbus=3Dqcan0,id=3Dqcan0-socke=
tcan \
>+    -kernel =2E=2E=2E -dtb =2E=2E=2E -initrd =2E=2E=2E
>+
>+Note that in the Linux guest, bitrate for the FlexCAN device is ignored,
>+but needs to be set via the ``ip`` command=2E
>+
> Links to other resources
> ------------------------
>=20

