Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10F8C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes3N-0005Un-Li; Wed, 01 Jul 2026 06:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes3F-0005Ah-LV
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:20:19 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes3E-0005HI-5J
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:20:17 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-139f3eaaa49so489476c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901215; x=1783506015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLUhJfzbCYk9A3+G7+as9F7PDtMpfTdzJ2wND1eSiFM=;
 b=EseTazMxD8/wNg0WgnC09W/bkSbvAEB/Ky9bJel94w/UkqDp51oXv2PqhDlkHjcWNR
 mdllnQ/pcObR44z3/rE2oy170HzpD0+myIAB/HPDgycmW1fj0mNTWDxHEjhs6nlbRzPy
 V0f5m6e49hh0ppl831wlzt3uDBuokFYpdw3tTY/O2K77lIlqQQ56b09s3/XPpToqB4op
 xjX0cb9eCmoUTFrpQ0XWd1EYFqOaUuCvsJWzo5eIERZqavxEI8S+OFKNq81mJOXXDggJ
 D0bphWNDSzWRQE/XANXb9ASgBGa8kVf4bO5qnH2DxNr7YavHoBObcR/VLvpaLf6TjoNd
 5Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901215; x=1783506015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TLUhJfzbCYk9A3+G7+as9F7PDtMpfTdzJ2wND1eSiFM=;
 b=lBGnPqUbcsO0HlFC63vZpzyq/b07iE0YtFxs5TOo8vaWBetSL/yceuF4H3aMkk39dZ
 tFdnyYel3AJhcaoOTuNBI2xoVu9afdABVzIDrDsupZK9pPRsvQm27QwEWivcAfkIdoRR
 lqNOrQXZo3HRocShhwpOLrIUY7v8yeHREgkolfSq/fnIyIwBk/fNNJt/7IN/T7aApzE3
 iDXvazKlIlhyNidJajdL9DNxJaLkwz3MWSKBYY5YIi7q2VkJnWmShJ2AlY/GGZeNfaFz
 UdBsg2TgFicagVFl8ek7w8iwSHkx06xnWvwD7ec1CSth+BM5RcU0u97o+1542CAzt04n
 nF3w==
X-Gm-Message-State: AOJu0YyVxPGJ9Ogt40lwzGkddEvd8/1XKVfmEaB5PlTdZCWrnahVR46m
 rgRzcMvaMene03q7RjM5SDGzZ7OSSGbA1m/QmE9AS/XtDzK1O1s0x6CvquH5nQ==
X-Gm-Gg: AfdE7cm74dnSZsQNIkMGIAQ9xlXW8NmfmKG+7+i/kbaxGv+NswThL2Zzs9TN5PovQm1
 2KLkD/Vr3MMc28Bpjur/Mcr/iDdgv62itHH5s3SvjPF725fm+iePmcKeNNDQJpGiGFZzzeRbWtY
 loC8Xy/mH/6h3c5wE4o4CZj7ULmqtHtxk9JuL9mVZ4k2LbRNotkNn9V1HzQJHElOTVz2br6u9O1
 SnWeNCe8f+wHas3WtNfMQX7wNjVsT1MzjDsHhGsgdpy6Glc4ONHBNKyOfRHhk1Ii4njZlxFmngi
 WK3AVock7Aw7mzwMNsRNiySSG+ypJtjXfwVyaUkZamTDM0VDSj2rCrtQY3sb/mVKplWFti12+Hm
 hkqgAi8jsToBQOwilwdCrxevapC2XA360WEabGDxqCLdjASRNYb5WOLdNVvoMOVwNTtk3EeIL/r
 7fR8Cavo4ZpDiS7nwAqujE4md0wJKLn2c=
X-Received: by 2002:a05:7022:48:b0:138:3613:db8 with SMTP id
 a92af1059eb24-13b36d6f2e7mr1012770c88.3.1782901214561; 
 Wed, 01 Jul 2026 03:20:14 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:20:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PULL 39/39] hw/riscv/riscv-iommu.c: always fault with SADE=0 and A=0
Date: Wed,  1 Jul 2026 20:17:52 +1000
Message-ID: <20260701101752.2522962-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1234.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

riscv-iommu spec: "If SADE is 1, the IOMMU updates A and D bits in
first-stage PTEs atomically. If SADE is 0, the IOMMU causes a
page-fault corresponding to the original access type if the
A bit is 0 or if the memory access is a store and the D bit is 0.".

Note that SADE=0 and A=0 will always cause a fault regardless of the
original access type.  Right now we're faulting in this case just for
reads.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3551
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260630211044.82894-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 01f5634f04..974042d017 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -480,7 +480,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             break;                /* Read access check failed */
         } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
             break;                /* Write access check failed */
-        } else if ((iotlb->perm & IOMMU_RO) && !ade && !(pte & PTE_A)) {
+        } else if (!ade && !(pte & PTE_A)) {
             break;                /* Access bit not set */
         } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
             break;                /* Dirty bit not set */
-- 
2.54.0


