Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E82C49EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Ii-00051M-FF; Thu, 25 Jul 2024 19:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ig-0004tE-Cc; Thu, 25 Jul 2024 19:55:10 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ie-0000nB-Rp; Thu, 25 Jul 2024 19:55:10 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-79b530ba612so304194a12.2; 
 Thu, 25 Jul 2024 16:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951706; x=1722556506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tzSJO/z7j+GgnjnioIlTWgJR2vtdMWm0HI0he1OMD1c=;
 b=F3Hs56tVspgrfAEMe0T4Ms8cT8jcso62EHMAN622sAniYwpvBK1DnVRCY1/HpVSoTJ
 4TSh4A7IORvLACNbgX/ETzxz+EfuU9VFkfmIDy/0GLBrwE3chU2GapIBLkIDUChexAcC
 kuGI9L4Pj/AYRR861d0riqh3f1yvSo7y9Yc9IJ36bHgQgKqHiPzmCNJSFAcbstyT2ZVq
 tKQY5tvZYgGfS5ugcxKWbGahGeuvgA1Vo3fJvJvbZn9vJxkUphxs9pT6WI+e4fi26+cR
 xnmNIitTTy5rVwJ5AF70ALAetyCuPKfKIfmnrKzlV0u5RzTOWR6YFonX2Gqhpf394hAp
 X1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951706; x=1722556506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tzSJO/z7j+GgnjnioIlTWgJR2vtdMWm0HI0he1OMD1c=;
 b=OwL9neRWDicacen0fm00zhW/oxGSQ9Ow57rt67RAO6h7nPanRw18yRtT8DWrCXRV3S
 UAOFY2vTZ+oTGJCtAO6MaKVDq/vnUng65lES7xcs6FoJMAuc3+4CUqiECLI/LY4reXSn
 E1W7Ead8C7AURBSSYwTn1RfxVEZfismKA5iF7PsYpMfR2ySGXBSekkXBv+sGw5i3F9V5
 GdSQMBHP4Vn8U9FAjcELO7wULMoJbO0SSq7nRVieq6yJIepxzz2MCjfE/gG/HQVpY4Ye
 NYX8vFYwo29/HZID0x9gwfJz79C6Vph1VAoiEeoitz9JeIFDaoSL+zDdVJEAxp1TBXOn
 NSNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2LmrGda6L6q8DEuCTRRM81XpwVz0JBtya0jk3WsCZauPYEbez8rJd8se+VQDrFb+zYFnI3Fls2yvggrPOhn/kColZ
X-Gm-Message-State: AOJu0YzOnOAuF8bURKpQ/TzHmCawRfFmuYK6Kt51ZxFFxyVpOPBiZpQa
 xNNopEdLrEi2EnrTGYVy60mu7k0DT/e3xZVOVQtqShM6SoDKzNBCWJIpJg==
X-Google-Smtp-Source: AGHT+IFdJmb22TFtMVqzNbS5R6/EkUjlL/d0UxzAuLWGicBTELvVU9Vqy1uFxlHKWdITBJ+xziaA3Q==
X-Received: by 2002:a17:90a:474a:b0:2c9:3370:56e3 with SMTP id
 98e67ed59e1d1-2cf2eb20f74mr3969651a91.34.1721951706249; 
 Thu, 25 Jul 2024 16:55:06 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: [PULL 10/96] target/ppc/cpu_init: Synchronize DEXCR with KVM for
 migration
Date: Fri, 26 Jul 2024 09:52:43 +1000
Message-ID: <20240725235410.451624-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x533.google.com
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

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

The patch enables DEXCR migration by hooking with the
"KVM one reg" ID KVM_REG_PPC_DEXCR.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index cdada7987d..7c3ee80661 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5886,9 +5886,9 @@ static void register_power10_hash_sprs(CPUPPCState *env)
 
 static void register_power10_dexcr_sprs(CPUPPCState *env)
 {
-    spr_register(env, SPR_DEXCR, "DEXCR",
+    spr_register_kvm(env, SPR_DEXCR, "DEXCR",
             SPR_NOACCESS, SPR_NOACCESS,
-            &spr_read_generic, &spr_write_generic,
+            &spr_read_generic, &spr_write_generic, KVM_REG_PPC_DEXCR,
             0);
 
     spr_register(env, SPR_UDEXCR, "UDEXCR",
-- 
2.45.2


