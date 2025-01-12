Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0BCE7719C
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 13:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWxlt-0005Di-HK; Sun, 12 Jan 2025 08:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWxli-00056C-Q6; Sun, 12 Jan 2025 08:12:44 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWxlf-00016I-4s; Sun, 12 Jan 2025 08:12:40 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3cf094768so6102549a12.0; 
 Sun, 12 Jan 2025 05:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736687553; x=1737292353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H8c/UCICLRBXHpkJfG5pRUpK2IfBWdGLk+BZkMzxMUw=;
 b=faY+S6oNfu29c62eqd1dS5sKi1BWwLqAvmoaULrmjR+RjF3Q4L3u3MI9dXPs0JhTy8
 JaMYh/zdlodLlGe3A5fppE/n+p1lNgkQRqxL5fEFEdBvdtlmLAwfBPGkwJbGsrVWK6lB
 Uwn+UaEYWXkxyk/OgG3uqvb7HAbXNXHbFxxjvzF/TADTxR+T4uQEkHo0kTGMzDuJ1uyB
 MngEsHqqpokvm1NADDdL4Ox0wVXnqtNFFYi4Wsqr5Kpp4rKFspZV4ADrb5tYPtawoBwF
 RdkrLxyENYC3hvDehwrYehNLWqwBsVUFKHF2igM0V1Egi2eGFlfH7iDjK/AUSFVAxvR+
 9L+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736687553; x=1737292353;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H8c/UCICLRBXHpkJfG5pRUpK2IfBWdGLk+BZkMzxMUw=;
 b=kWKZqYaRNVt4WlVTA2fTH8hBKvwYU3hjeJPR6DNNXD06XNZfUF8+b68/+ZcRgziqCL
 UIdX4ALsPr895pWNHmnKTTGRaWQ8XWkXqezPQSUg+T68JpuWf02yvluaDar7iMZdiOOx
 p/VSGCDAukkMu9vqHa/NHPGGtdvXHIDgjK85TO4lV75hx+JIqgIKLGw9ruEuJqF3W/sb
 2B0dLnk63DCRwhnL+u2ETYwbc+ZGut/BYSc831FN7vZqX1CPxX9/LttKfjq8D7N6AkhQ
 gwus1t/W6qli4Od8hLDpO6nU5on4Bdk1MYEoGIzVPTLFh906yL1U2ByVeyQ+qLSJkljs
 UCaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRcQLnb10r6rIGBGdHBGrtgxMD8+RgpfoqOCRA/TS5//p737TgfgSsWmyORLFESJyDOuWyG33R30/C@nongnu.org
X-Gm-Message-State: AOJu0YzvBgIc9oTcp0eOjkxehOmhTdtFvmyc02vI4NB4xlDvMB3iHeso
 v+qNOBJ9RrttTLVnFHakyAuxrgzl6aBOSsToeFJv3sxMCYZjGTnh
X-Gm-Gg: ASbGncvtzHryiuFc58uQLNFPi3da/g9IUw4RKnYv3kyGMLfcByk5o59EZUDbVEWjkBv
 A9XY6z8esoxaUNmYot64rPhB3QB+5nnEgLZfz+JVVDYe2+RFKaiyXNi//3bvtOVofK7cIOxKoTH
 1EMvXbKzOxsnUzRSnDxRDb+TxHY8QwxhFspRqio19gqbxkJzJQVd+ygQ0OYr2O3yPEqZnoMsIIn
 2ZHnc/16sH8LZGerV73bCOEuTBHfTk6E+opRD0d4h+qVxztTOWeC8Hu7dOVxJorFDPyeqcmrv4k
 zcGZXxWFwMLvBcAohSezFNtUzGH2C4g=
X-Google-Smtp-Source: AGHT+IEJilvs6VBJZGyAgvAC/udeESjbHZi+keHunnRaROEes/Jxl6Djs6InJyvf5EA5pyp95BIPQQ==
X-Received: by 2002:a17:907:3e9b:b0:aae:d199:6eae with SMTP id
 a640c23a62f3a-ab2ab6a38bbmr1431328766b.14.1736687552305; 
 Sun, 12 Jan 2025 05:12:32 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-013-193-192.77.13.pool.telefonica.de.
 [77.13.193.192]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905e1fesm373785666b.2.2025.01.12.05.12.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 05:12:31 -0800 (PST)
Date: Sun, 12 Jan 2025 13:12:31 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH] hw/sd/sdhci: Factor sdhci_sdma_transfer() out
In-Reply-To: <20250109122029.22780-1-philmd@linaro.org>
References: <20250109122029.22780-1-philmd@linaro.org>
Message-ID: <AA6E1DC2-B956-480C-AA5A-3ABB90526E43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
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



Am 9=2E Januar 2025 12:20:29 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <ph=
ilmd@linaro=2Eorg>:
>Factor sdhci_sdma_transfer() out of sdhci_data_transfer()=2E
>Re-use it in sdhci_write(), so we don't try to run multi
>block transfer for a single block=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>---
> hw/sd/sdhci=2Ec | 22 +++++++++++-----------
> 1 file changed, 11 insertions(+), 11 deletions(-)
>
>diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>index 299cd4bc1b6=2E=2E332ea13fe55 100644
>--- a/hw/sd/sdhci=2Ec
>+++ b/hw/sd/sdhci=2Ec
>@@ -694,6 +694,15 @@ static void sdhci_sdma_transfer_single_block(SDHCISt=
ate *s)
>     sdhci_end_transfer(s);
> }
>=20
>+static void sdhci_sdma_transfer(SDHCIState *s)
>+{
>+    if ((s->blkcnt =3D=3D 1) || !(s->trnmod & SDHC_TRNS_MULTI)) {
>+        sdhci_sdma_transfer_single_block(s);
>+    } else {
>+        sdhci_sdma_transfer_multi_blocks(s);
>+    }
>+}
>+
> typedef struct ADMADescr {
>     hwaddr addr;
>     uint16_t length;
>@@ -925,12 +934,7 @@ static void sdhci_data_transfer(void *opaque)
>     if (s->trnmod & SDHC_TRNS_DMA) {
>         switch (SDHC_DMA_TYPE(s->hostctl1)) {
>         case SDHC_CTRL_SDMA:
>-            if ((s->blkcnt =3D=3D 1) || !(s->trnmod & SDHC_TRNS_MULTI)) =
{
>-                sdhci_sdma_transfer_single_block(s);
>-            } else {
>-                sdhci_sdma_transfer_multi_blocks(s);
>-            }
>-
>+            sdhci_sdma_transfer(s);
>             break;
>         case SDHC_CTRL_ADMA1_32:
>             if (!(s->capareg & R_SDHC_CAPAB_ADMA1_MASK)) {
>@@ -1174,11 +1178,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t =
val, unsigned size)
>             if (!(mask & 0xFF000000) && s->blkcnt &&
>                 (s->blksize & BLOCK_SIZE_MASK) &&
>                 SDHC_DMA_TYPE(s->hostctl1) =3D=3D SDHC_CTRL_SDMA) {
>-                if (s->trnmod & SDHC_TRNS_MULTI) {
>-                    sdhci_sdma_transfer_multi_blocks(s);
>-                } else {
>-                    sdhci_sdma_transfer_single_block(s);
>-                }
>+                sdhci_sdma_transfer(s);
>             }
>         }
>         break;

