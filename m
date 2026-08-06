Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5301BC56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 16:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws18E-0006kU-Rt; Thu, 06 Aug 2026 12:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws18D-0006jm-Eo
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:39:45 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws18A-0000HM-UI
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:39:45 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2cc891373e0so30242965ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786034381; x=1786639181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JQVXlhf8twHyD4IKFKJt8HG/wz/ubfI6lRd4dbnWJZY=;
 b=aT4xbk8ellZmCHbPnsb7esxbNihke+wo/weCirO84tcEwp7xK0qV7KFj4nl7ds4oA3
 QX3MQwTR5jayKh7AKHtQZ8e8hPDXVmS7HiOxo4JEOY+xe2cJuRIB4DLOs+4dgmXtFTX2
 zfxedPzxtEfJFxfY1rlGOFXskTl2LeXS8govIllDC4U961RldoeAgCRLuJs8bgSCbyCL
 IUX/zZivpR+VrK5O1bZTlXm8n+hqVNWA/uHcR/AAEpxuVMsSHIZfE3FE4emTGTHaOfxd
 5vLi4U51RdTb4X2xtJBqIFs+e1sh8nA5sVv0DARKt8zFElrtBsP4CJoLVGuJLFd067wh
 +cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786034381; x=1786639181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JQVXlhf8twHyD4IKFKJt8HG/wz/ubfI6lRd4dbnWJZY=;
 b=KIMMEqgwfPdhvU0lmgTD+oYSBOfm0zoOyRpRKyQ0RrwHP8JmtpbVCBP6VAQy351isa
 upT38D754fahck/tiz+IYCnCfuPaIlbb2K78101mIdqOS2xiul9nDDjg8Y4jArdw70ta
 HA9x9A4Ek2FvbtYBLxAjnAUZuvFZ8iGxAy3YmT6nSErfiXaA4SPe3VJTVIaLwnI/UtTo
 zskGgwg9+nRyzloxVLZXFtRJyWHydH9bKc6vIghBT2nH9MhqrUqKnrEEMxKzbLz1F1/S
 OE9zfO0hvvId3Dq6Rpc/P5hhRARVzhydziaAeNmiFxpCJqDTylqQfEoPG6Umf+pUCI0y
 tYuw==
X-Gm-Message-State: AOJu0YxPtn4TZbrZ+fpfgV70HBPB/0RC9rhpqMVs+rgyI/mYZRUKGWve
 tpmj7wwM3NwT1ozkwabMUKhn7IVZQkH6pVSLtUxetomsUNl4VsLeo0MiCVKZJMJusV10nvN+An/
 yXZRZ
X-Gm-Gg: AR+sD10AxDZoIDG+a5j7lLH2Zco/ipwqpg9NBbNnIjbv95ZsZAoEtqdR9aoka1+UOUy
 WNKgpLgRUtQNLkUtUyoxRGoWIxXVlgv3VCzbC8zMKjCdMO7/ime3ojhgZQT2sQa//UBwFa54677
 PhjyG9sZ8mNAE+GQUN+2hse+pQQuFC8s2zOfdHSw3+k+xgk84Sea9RsH0WVLc0E3nwvJplYKA1K
 /HaHO3zjjmAgTSMyasKIa+sNgPO/5Rxrqq3wkCtglF1BDorZ/HAqImrVB7220mnBQXyy95Z0o/D
 8NdINFa4D9XqrxSvVNU24oy0v0+b1y+E9SEZPcPqyiwamHAiN1qdBZJE7Ll4qFIZcMYCQtVCgZ6
 Mriums4unNlQ3qGx3SK3DkUqFyCT82uA1FQIuSqX0BdfeiLzBcEJdAyEVeQTxfH8XTh9uIcz7Ja
 aMoc8pvqrVU37qtVnNLVqQJyd8Tr99LMUCMRnOIKKA9mjgocxJ96YQK8X/vnb3VM/N89lJOSaAQ
 9+jV98gusuZ9Xa+0js54YG+3yOdhiLK
X-Received: by 2002:a17:902:f54d:b0:2ca:ecf6:9104 with SMTP id
 d9443c01a7336-2d0ca711c8emr175409245ad.4.1786034381514; 
 Thu, 06 Aug 2026 09:39:41 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0aa4ec8c7sm34280735ad.80.2026.08.06.09.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:39:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 1/7] target/arm: Tidy cpu_max_initfn
Date: Thu,  6 Aug 2026 09:39:33 -0700
Message-ID: <20260806163939.328201-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806163939.328201-1-richard.henderson@linaro.org>
References: <20260806163939.328201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Once we have eliminated hwaccel_enabled, only tcg and qtest remain.
We don't really need to test for it anymore, but convert the if to
and assert.

Remove an assert on aarch64_enabled that is directly protected by
a preceding if.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-max.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 88b7c04633..089f514bd8 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -203,9 +203,9 @@ static void cpu_max_initfn(Object *obj)
         return;
     }
 
-    if (tcg_enabled() || qtest_enabled()) {
-        aarch64_aa32_a57_init(obj, !aarch64_enabled);
-    }
+    assert(tcg_enabled() || qtest_enabled());
+
+    aarch64_aa32_a57_init(obj, !aarch64_enabled);
 
     if (!aarch64_enabled) {
         aa32_max_features(cpu);
@@ -218,8 +218,7 @@ static void cpu_max_initfn(Object *obj)
          */
         cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
 #endif
-    } else if (tcg_enabled()) {
-        assert(aarch64_enabled);
+    } else {
         /*
          * '-cpu max' for TCG: we currently do this as
          * "A57 with extra things"
-- 
2.43.0


