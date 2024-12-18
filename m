Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080C7E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2Yp-00031H-0C; Wed, 18 Dec 2024 17:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Yk-00030d-Oz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:26 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Yi-0002Dh-Ow
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:26 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2156e078563so1505025ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561023; x=1735165823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZX0TgFMJ8uN9pbvITB6VLJTDE458zw/ldNK20g8Glo=;
 b=RTMSdsGNhOf2l7NajdcWj+9fNzCJlr9rioX7D6NI3sj+fzVevV+e3NA3cQ/f5YFfWb
 inUEZ8JpAuEuGgzh52K25be7E8LcYuEg3SRIEWcGumySi42zcT+Z2ZLq4rdKgdodwb8D
 6FxL9qoJ4VyyYhXpCyHVHIvQgPZA2Lo2vuNWC1j5KJNDppn8QFodOIQDKhcw63DBK2pf
 tgZPQdSsibCKA3pYVVk43IKAzeYq2UfgSrxNx79IqcQx7Fu0xZQSEmmAoKktDZh+K4Su
 PkspxHRbEaupm4CDKrDHJpjsbSq4ULdZ8sdX3kJ3/f/eZgWnzyRTR1k2rbU0q9q38nAs
 S3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561023; x=1735165823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZX0TgFMJ8uN9pbvITB6VLJTDE458zw/ldNK20g8Glo=;
 b=k7WlPqS3ruJhahF1wnjGPrlw2CuZzoOaQXGEeuERDl718j+fWRorqcjmExAvCwhZNc
 Ha2pnJM/IBoEi1rN3maqo6oxxv6ZcecUC0uwhR0zRr0D92Si+o4cFyEeyju+xp9/8fGv
 QA6Yep8CuyL9mcNjcSKEfDWEOJQBT1TToOlgVv+HShFPfVFqrHg3notqVPjb8rXkuANJ
 U/j/Bz9N9KRpl0uSVezw0UcBd3Il86csZGH7QN0w9O8RIxrnyS2/i0arDWI4obZHZOBN
 B+6Ir+JeEBqvRlogeXjX/MxvXqwEP2nqKzxlNkoHH+yYyJ4P1Asm+jeQX7ekICI9UAd0
 PcTQ==
X-Gm-Message-State: AOJu0YyVdvE04Jqs/NxKSJKr/lIooAMZf/DAQg4DepTui9vH37jRn5vu
 39fWlJHyuAmBQEh4X5UJafUltAqs8FAKblR3wcomiQsw4eInnSRYy3pwhGRe
X-Gm-Gg: ASbGnctt7G3wmRMZmupxK+fE0oVmt8crIhE2DvBhLRXT13VS4sR1UIZOnOSkaWERfIE
 FzgPQ9ddXeUqyzUZPIfMAcUSv/GlhGlbrV1bYSwl2S1E9X6JWkJKpmNd1HtTVBNuqIKb8/+CaVR
 qzN/+2HsH82T/w+Uwu4EaW0624zErGqdqPbuSwH97HRLMMALZrGvRlWjG5DuhG4AJV3aIeWxciP
 nM+i1ankNxQi36I98rX4KuLonBECUpvkGG1/hvlwcPtxvINmMiLyc+AVtcu5aoVCsjkeqCMD5xe
 /88p8RS3pAoMFICsTX97ZkX1YlozaNtey5oL7UqZMsfPqWiYaOSrAU7gejXpLaU=
X-Google-Smtp-Source: AGHT+IHguVXEyGSuWB4Q51iAQ+wvlAlcSF6iEU7BK74W+Ig9W6bBS/QZbYzqxB50saaw92crBTug/g==
X-Received: by 2002:a17:903:22c8:b0:215:9379:4650 with SMTP id
 d9443c01a7336-218d7269c85mr61004635ad.42.1734561022938; 
 Wed, 18 Dec 2024 14:30:22 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:30:22 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/39] hw/intc/riscv_aplic: Fix APLIC in_clrip and clripnum
 write emulation
Date: Thu, 19 Dec 2024 08:29:32 +1000
Message-ID: <20241218223010.1931245-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

In the section "4.7 Precise effects on interrupt-pending bits"
of the RISC-V AIA specification defines that:

"If the source mode is Level1 or Level0 and the interrupt domain
is configured in MSI delivery mode (domaincfg.DM = 1):
The pending bit is cleared whenever the rectified input value is
low, when the interrupt is forwarded by MSI, or by a relevant
write to an in_clrip register or to clripnum."

Update the riscv_aplic_set_pending() to match the spec.

Fixes: bf31cf06eb ("hw/intc/riscv_aplic: Fix setipnum_le write emulation for APLIC MSI-mode")
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241029085349.30412-1-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 353eec8136..3edab64b97 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -248,9 +248,12 @@ static void riscv_aplic_set_pending(RISCVAPLICState *aplic,
 
     if ((sm == APLIC_SOURCECFG_SM_LEVEL_HIGH) ||
         (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)) {
-        if (!aplic->msimode || (aplic->msimode && !pending)) {
+        if (!aplic->msimode) {
             return;
         }
+        if (aplic->msimode && !pending) {
+            goto noskip_write_pending;
+        }
         if ((aplic->state[irq] & APLIC_ISTATE_INPUT) &&
             (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)) {
             return;
@@ -261,6 +264,7 @@ static void riscv_aplic_set_pending(RISCVAPLICState *aplic,
         }
     }
 
+noskip_write_pending:
     riscv_aplic_set_pending_raw(aplic, irq, pending);
 }
 
-- 
2.47.1


