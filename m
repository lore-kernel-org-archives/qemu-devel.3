Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E6BCAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6u0-0000f7-8K; Mon, 15 Sep 2025 06:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uy6tx-0000eV-8d
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:57:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uy6tl-0003Z9-8c
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:57:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45f29dd8490so13268395e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 03:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757933845; x=1758538645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vMBHMTY0ddgI8i7LR4d1rIcwAZNy8ZNwdVi3IKnSwjE=;
 b=hBaScRAtIL2c7R7wpKmEQqHuVg93x8ufYgXEh7TqybDIyzm2sTaRcnFuanTzO2OUN5
 2zbCLd9/gfmjsWyfLIbZINUnFvDxEHG9dz6g9LvGYlIiL8kvBaChroGQI6qDi3QrKAe0
 XQkzXQI708x7QMTY/ZOCkZ4bBc67ha3USPGRju+vBhwBGr0DDd23Iuo686X2hLSev1pp
 1FHRpGoCSIkN7ZiQ3xl6d3PWltKexVF9/sQvfaFb25UNMHx9vVp7xT5WGXXO9Cmaxx3Y
 rbm/6kBVRwBZeWZ0asfsVFMkGJmuGEDs6/p+tKXcThVgGOMxytJfEqZWicAcUedSThab
 Rc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757933845; x=1758538645;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vMBHMTY0ddgI8i7LR4d1rIcwAZNy8ZNwdVi3IKnSwjE=;
 b=LulrdJSwUIrOBb0gy+rVFg1l1+zZh83GwrvFxxJyLFTaNFrMQfRXAwBdYxtMAdjei7
 hA6+zNMIoRLHe/dBpxRYwBLnrq01va5wgVje7Q1F6/r/HcEoeuohtlporQwqvLUuHY6y
 JIo9kmmsOAWUbCnU0JuMg+jk6jGxUIt0uVnl4x8ce1rZXxYGQPMYYX6mGFrqAcgmF+XV
 CftDtUhTYX47DqJzKWpoltiFIML+UHvdbIPfSL1D7swLXD+a7DxUOV4WSv0dw5BKqLmt
 ibyc6mdSvzlBj73LYYlsClXOOR1N5ewi3Xr+yVQJaYE9t2jID6nrYmG8Z5OsvsjVXNMG
 ZESA==
X-Gm-Message-State: AOJu0YzY2IDLQ6Je0A+uL7JWThp26c5wCQ8F0W6LFgc8C6uhwgIi65gL
 5SwWBw/bEP4EehOpjHinCsZ2uwUx3rWbiDjz+xjqMaRe9i5kkGotGqWOFeenIQ==
X-Gm-Gg: ASbGncuB+oAQUGXmzqhIr78k9sdIBEk2jGD778QNIimo/dbuLtQk6X+Y+c5Q7duIIhu
 +StNg9W5hmeRp7q7pfmNikrN5v5LPupEbM8voeiGHnT+UPFHW5EJH1oYVFXzr0Va+WYdyVplqGn
 HpskJRuFXJSU5rhyPUYxD49QWb+8DIr6BT6Dcg2uqRSpFVlVpMOErxlqLuSN4itn7b5myFur1ga
 21lMTao/C0kKUYWXqN6wqU38W46+F+c89W2MWAbu67XduuyYmGcyGtfWlie7rHbaXwsdQZFM+lj
 JsRwvrZS8ftKLuNzQdDufEPMej6Kstut9NIcvDTaf6cdt0kOMvdqRIVPN+pjQ9X5M+fQ7aSVGRm
 D8xRZXUVPj0suolTr2UXX7cfKQ615tNExe7/3tVi8
X-Google-Smtp-Source: AGHT+IET9xvosbOa+6N8vO7cRRtioaIHRPAMKttffeUNuK5YNHdqqr+oFrm8Zk7PneiwEnBMu7x48w==
X-Received: by 2002:a05:600c:1387:b0:45c:17a:4c98 with SMTP id
 5b1f17b1804b1-45f211f8ed1mr96839575e9.19.1757933845372; 
 Mon, 15 Sep 2025 03:57:25 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.238.219.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0156b0a8sm176070315e9.3.2025.09.15.03.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 03:57:24 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:50:21 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
CC: Huacai Chen <chenhuacai@kernel.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 5/5] hw/pci-host/bonito: Add comments about documentation
In-Reply-To: <AB55B48E-F903-4524-9D6E-058238D33EC2@gmail.com>
References: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
 <20250508-bonito-v1-5-4f9f27733028@flygoat.com>
 <AB55B48E-F903-4524-9D6E-058238D33EC2@gmail.com>
Message-ID: <A88DC801-EC13-4984-84A4-1573CBB0A8A4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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



Am 9=2E September 2025 07:14:00 UTC schrieb Bernhard Beschow <shentey@gmai=
l=2Ecom>:
>
>
>Am 8=2E Mai 2025 14:46:10 UTC schrieb Jiaxun Yang <jiaxun=2Eyang@flygoat=
=2Ecom>:
>>Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>>---
>> hw/pci-host/bonito=2Ec | 21 ++++++++++++++++-----
>> 1 file changed, 16 insertions(+), 5 deletions(-)
>>
>>diff --git a/hw/pci-host/bonito=2Ec b/hw/pci-host/bonito=2Ec
>>index 49b4be26393a08eda4f99c8e2ef8a0c455c57bc0=2E=2E918ee39661004d902d2d=
eb25dd5e782855a11854 100644
>>--- a/hw/pci-host/bonito=2Ec
>>+++ b/hw/pci-host/bonito=2Ec
>>@@ -1,5 +1,5 @@
>> /*
>>- * bonito north bridge support
>>+ * Algorithmics Ltd BONITO north bridge emulation
>>  *
>>  * Copyright (c) 2008 yajin (yajin@vm-kernel=2Eorg)
>>  * Copyright (c) 2010 Huacai Chen (zltjiangshi@gmail=2Ecom)
>>@@ -8,10 +8,21 @@
>>  *
>>  * Contributions after 2012-01-13 are licensed under the terms of the
>>  * GNU GPL, version 2 or (at your option) any later version=2E
>>- */
>>-
>>-/*
>>- * fuloong 2e mini pc has a bonito north bridge=2E
>>+ *
>>+ * For 32-bit variant:
>>+ * "BONITO - PCI/SDRAM System Controller for Vr43xx"
>>+ * https://wiki=2Eqemu=2Eorg/File:Bonito-spec=2Epdf
>>+ *
>>+ * "BONITO - Companion Chip for Vr43xx and Vr5xxx" (uPD65949S1-P00-F6)
>>+ * https://repo=2Eoss=2Ecipunited=2Ecom/archives/docs/NEC/U15789EE1V0DS=
00=2Epdf
>
>This one gives me a 404=2E This link works for me: https://www=2Erenesas=
=2Ecom/ja/document/dst/upd65949s1-p00-f6-bonito-companion-chip-vr43xx-and-v=
r5xxx
>
>>+ *
>>+ * For 64-bit variant:
>>+ * "BONITO64 - "north bridge" controller for 64-bit MIPS CPUs"
>>+ * https://wiki=2Eqemu=2Eorg/File:Bonito-spec=2Epdf
>
>This is the link to the 32-bit variant=2E Correct link: https://wiki=2Eqe=
mu=2Eorg/File:Bonito64-spec=2Epdf

With the two links fixed:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>
>>+ *
>>+ * For Godson (Loongson) 2E variant:
>>+ * "Godson 2E North Bridge User Manual" (in Chinese)
>>+ * https://github=2Ecom/loongson-community/docs/blob/master/2E/Godson_2=
E_NB_UM=2Epdf
>>  */
>>=20
>> #include "qemu/osdep=2Eh"
>>

