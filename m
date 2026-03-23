Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6F9EC01C9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cvl-0001uX-BS; Mon, 23 Mar 2026 06:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvj-0001tq-Fj
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:43 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvh-00066N-VB
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:43 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-486ff201041so21133305e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 03:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774263280; x=1774868080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d1Bl0lKWC4KpVkS31ZxF1KFY77v74e5vNIPVSZv7eHs=;
 b=NqD8YELkGbUPG3Kx6+18Mw4s75G9iyNVUTI/JBN+p9DKdAZbI7nHGPCxBurIOJTXs6
 18MS2Dq93v5BkkCXJJ22SUp5bnsoHQCrQEreCdJCa4kQ5PJuKufqB+6OLIbYZPQexkPZ
 TY3B5ZbGmwueFq5X78BhXdsWhJfp9mq8uk3lLuMVoWoxSkhNoxWvTm6V/2xtjFEvgBHD
 BKAAHIAozj54KiiKkWhBayUdcfx+ZwlYEigM5WlDTWckMKO1/+bx6fOVyLD5/jmUwpOs
 n6KttFxq9Jzd3AXIowZbqNr3Fl56an8EkPyyedfsTDDpPi0/Q4b0gJvJ3uDvZUtgqd6e
 aG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774263280; x=1774868080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d1Bl0lKWC4KpVkS31ZxF1KFY77v74e5vNIPVSZv7eHs=;
 b=RHwfX7KYEnR4alMLbDrIFWvc0xoe2ugA1Ys6LIK64azXyxknwSicL9cqNBlaC241WZ
 6THEfYYhCEJz+nm2y7x7HWCNTE7wB1DNYqxlJX+g/gTIb9Hv3gqzjYyC9/HVBYSF25LY
 IFvxNffLCGMv7ahpwu1OHdaRzqRsbsxOm3g2lHmAHApn27RmBLwaqwBmItrNzB7CU+HK
 OnKZZimVP80oLAEBjhtW8TClUTsWCVljyIfXYIbG9gv57bTcoa/YbYkp3KMIursYLT8j
 6L1S8impkzk+Qw2Xaf0Dqi6AAFHVpRdzgG3XPRCSCKzU17FzKwOAl3PVgXdVjYkzLT+v
 RkaQ==
X-Gm-Message-State: AOJu0Yxqd8Y5YB/MyInmkukoMhZivxSYWsVZ4p3WLxO1g9DIZhatL77o
 gGMQL5bORN9rD5wlEDgzi8O9Aa8awzpw7yZyNuMtKaDBykuftaj//bLjNe7IT6jbB5s9a6vu24V
 3voO06p4=
X-Gm-Gg: ATEYQzw15XMMGR83I0tLw7OUkOAWeh/og8G7OxHceEf96YsTHiHovxjc6/ict/wd19y
 kg09D5h/NSqUSFlVhI+FLW+fg+IEN0vbrAWGRDtQCa1RNgTNYPDpBj4TzZ+mZ7XLFQQ3uVaFeFu
 Dk2jKBzAGRhLVN/Ithx/A4MhAaIVOIuzViBiCPlpAt4iEgKlyjHTB/1cMO1xYRyyvIJDbRc7Htg
 Y1HoZuVVlA674ZBMpsZxooMxf9XdkLAdGKRcMQFjG7vbvuDUqrcHjKFqUDDq/MzXZ6Ngxfbf1TR
 aHi2Avz406lorYCLskbRye4aGxhvrA3CALAKykNe9uO+2SiTjs32V9/JhOWlu8bqMekzey0yj8p
 B2yCyq/OWTaAe3fGdno6wfBxQPoN7r7AUbgTgUbeK2lS0dwtN4FJvS07qau6H5VxKrYg8ErBKe4
 OrTuUAuLzLDLPykhl+vm0UTXg/4ELNRhPaKp1bjSn0/dBiWFid2NT5DgLFrrKelilmfDGKwkss7
 BAbzh2wuyEv3Rgs08y/Q9WczivNIQE=
X-Received: by 2002:a05:600c:c083:b0:485:2fc5:3a5 with SMTP id
 5b1f17b1804b1-486fee19f85mr121739325e9.26.1774263280403; 
 Mon, 23 Mar 2026 03:54:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1dd9f1sm115483185e9.8.2026.03.23.03.54.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 03:54:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/10] configs/targets: Restrict the legacy ldst_phys() API on
 ARM / Aarch64
Date: Mon, 23 Mar 2026 10:54:28 +0000
Message-ID: <20260323105429.4059580-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323105429.4059580-1-peter.maydell@linaro.org>
References: <20260323105429.4059580-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit d751921cffd ("hw/arm/omap1: Remove omap_badwidth_*
implementations") removed the last use of the legacy ldst_phys()
API. Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to
hide the legacy API to the ARM / Aarch64 binaries, avoiding further
API uses to creep in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260319104414.66367-1-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configs/targets/aarch64-softmmu.mak | 1 +
 configs/targets/arm-softmmu.mak     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index 9a20187e2c..d34aead41c 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES= aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/arm-softmmu.mak b/configs/targets/arm-softmmu.mak
index 35af7da79f..b235e34a38 100644
--- a/configs/targets/arm-softmmu.mak
+++ b/configs/targets/arm-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_XML_FILES= arm-core.xml arm-vfp.xml arm-vfp3.xml arm-vfp-sysregs.xml arm-
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
-- 
2.43.0


