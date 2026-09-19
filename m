Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C899C982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 14:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7wAF-0003se-V5; Sat, 19 Sep 2026 10:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x7wAE-0003sH-UY
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 10:35:38 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x7wAC-00023g-F5
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 10:35:38 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49cc9f581c4so6388885e9.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789828535; x=1790433335; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZndMV5axR+hjxphvmqfflbldXZhnpjy8+95sFYxa8Sw=;
 b=MCPSH95zBzNC5Jutbocvk2/Cto2YVYfv3NLpeA6i+bb+4lsPkQ9ky4dOLRQPWnf7vR
 PiwaJG5oRvUix4qplMYmg2g0ycBgZWksSNtOrdsRiVJnhFo4mgW0cB0kzLgkbvrTJ0jy
 UXSmsAjU4EDokZzdJpYtcYOC4Dh+gNj8PwdFRorud54yFx4GEywvCVqIpSOYKJUbcU9A
 7r6P6V9p/G9hLt0fWPS8Pwb3o+eOtenU1EMvzFN+wfS97Y58dPAzRX0GV5YPTCrglUEx
 qcfFkhNbpS3iDBb7tLdR+rWIfNasAjPIQsnFuJuK04KELvlOnL7yt2Hr8bGeKJSlHYdM
 j3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789828535; x=1790433335;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZndMV5axR+hjxphvmqfflbldXZhnpjy8+95sFYxa8Sw=;
 b=R5s1ZSvubrjieH05hyq9J3K1cBUUK8sPeo8NlzQj2I91XmJVqtfDgAF/nOrFwOBOAn
 gBiG4ggxNRdiy929dSR1wFQH3cjqQ+mnrEnFRyhtrIfLp8QAo6Et9Xh6LhXo0ti9Zl1O
 jo4rmkESj+GDV+uYkum42b7Uu5SPDI2RE2ComVDH9nY1wBdWRIKz1osFZmUzi6Wvoq5U
 2p0SNAxCELwuX+Flpc0BYDfdvZtdUHB3trPtYr7HF9F5I4Jv4hYw5hSBxgQDvIEORmSV
 /GrgP5wdcSR6q7+A7J5dS/CLOTO58ATInUzpI/HbdQzJMyL1Ql1J1c83Q+fosX0XvKa7
 r/9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzi7FRol6ABY+Cq0CZq34Aqyj6lwCbsMEvvMCdW4Vih8RjHlw7M1RformAg4YZCu0fpqA1R6xoewlS/@nongnu.org
X-Gm-Message-State: AFuF++l1j0jcuaVqnoxGaEcJsVqkbxiQJCP/gN4RcZOXioLVLatm0/RI
 3P0IhzMG9W7jymxPXL+jSQUzCv9uNwqlK/r7hsEaJT4f9gFkVigDGSUkY29SjA==
X-Gm-Gg: AYBFou0jECE3FqfXysjXAIA6rtKPY1/Li2tLw5pw3NVdvH25pdHpZuCAA3tUrHkzVKT
 u6Ux1YmiuLgitk2Kgw4iBjjhi3ldpmrzkU+uP+A2noGiWSAyKCw8iQIEECEaN3F0pLDc0JAOvBG
 91KMHcYeI04ivozxUqYAVqhpEEowYOd8yvxXcq+DxXGnFRWIPv1h3hgx2jfWYqLHw8eGunwr4Gk
 5cRFW6B30hbXsJ7olxJCoFyyywjvt02prbf+rMXdYvMDzM8SUJtQ5OSaO4mAyVMp2e60tPm7V6F
 9Kdjl8wJ0JTKRK0BBLLfGNDb/EcdLkAEcD7M1FltT5JcT5hVijhM1pFJmWa0UHgWcddXNOqK2qK
 03AhVxr1Y/5sN5IPeBNzlvnMXcxRijAAJshJTOpf8E2JmIMhmaMt0XW4Y0UqYi0ZBoqf8W8Yt44
 FBJRkvb2Z9nYBojE+au4JincU7Lsok7MYfLT6CeNNqSO1j7z8dBrwVh57RkQMBehqvqQe5D1L99
 4npUrili2N/2/Drv7VSccww2TukbY9f9RTlmT+KI7XzV7x9xIJ9CMHnfg==
X-Received: by 2002:a05:600c:4e42:b0:49e:63cc:6324 with SMTP id
 5b1f17b1804b1-49fc4f85e54mr86252205e9.6.1789828534519; 
 Sat, 19 Sep 2026 07:35:34 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-077-011-070-039.77.11.pool.telefonica.de. [77.11.70.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd0eabfcsm81075725e9.3.2026.09.19.07.35.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2026 07:35:33 -0700 (PDT)
Date: Sat, 19 Sep 2026 14:35:32 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 QEMU <qemu-devel@nongnu.org>
CC: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_05/10=5D_hw/sd=3A_sdhci=3A_U?=
 =?US-ASCII?Q?se_a_QEMU-local_no-busy_IRQ_quirk_bit?=
In-Reply-To: <20260904161438.3838261-6-bin.meng@processmission.com>
References: <20260904161438.3838261-1-bin.meng@processmission.com>
 <20260904161438.3838261-6-bin.meng@processmission.com>
Message-ID: <C36E0D73-249F-4BC2-ABA0-52DE3134998C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 4=2E September 2026 16:14:28 UTC schrieb Bin Meng <bin=2Emeng@processmi=
ssion=2Ecom>:
>SDHCI_QUIRK_NO_BUSY_IRQ was copied from Linux with its bit number
>unchanged=2E The quirk mask is internal to QEMU: it is neither visible
>to guests nor part of migration state=2E Mirroring Linux therefore
>provides no compatibility benefit and constrains local allocations=2E
>
>Move it to bit zero so QEMU can allocate SDHCI quirks sequentially in
>its own namespace=2E
>
>Signed-off-by: Bin Meng <bin=2Emeng@processmission=2Ecom>
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss=2Equalcomm=2Ecom>
>---
>
>(no changes since v1)
>
> include/hw/sd/sdhci=2Eh | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
>diff --git a/include/hw/sd/sdhci=2Eh b/include/hw/sd/sdhci=2Eh
>index c485277744=2E=2E2d03e37653 100644
>--- a/include/hw/sd/sdhci=2Eh
>+++ b/include/hw/sd/sdhci=2Eh
>@@ -111,11 +111,8 @@ typedef struct SDHCIState SDHCIState;
> /*
>  * Controller does not provide transfer-complete interrupt when not
>  * busy=2E
>- *
>- * NOTE: This definition is taken out of Linux kernel and so the
>- * original bit number is preserved
>  */
>-#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(14)
>+#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(0)

In anticipation of the upcoming commits you could align the bit such that =
this line doesn't change again=2E

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>=20
> #define TYPE_PCI_SDHCI "sdhci-pci"
> DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,

