Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46688CD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKam-00058o-J8; Fri, 29 Mar 2024 18:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKai-00057f-Kt
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:20:53 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKah-0001q2-5R
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:20:52 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e740fff1d8so2012850b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711750849; x=1712355649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1pFViSSelBLDC7jQWPNWKQ58HUVyc3Kf8+NgXdrfBUc=;
 b=Tva+OfnKh9KR7OktjPfOxSJAsP6pAvXCA2q9RtdmrT2s+KqhHQkmxCcLMLAI9hcM8k
 mZxmy02efutIBEecJ6Cr1EEmsLd1Ul6jdRZnfDrF0O8Dw+1Obuy173nGJMoNIPTugwxj
 uA3b3uxmpivHUSy1q8NsiM3UJBYRIUkNLsA/RxmyciOn3zU//qZWun0ABEDQdTkv9g3z
 Axx7fkJbEsmeG1ARCjsfihBjPdnFM0FvNPkq4ERP3xygoMLqaMx5jT0TL6P44y14tdQb
 d/OBoENRTIGytuyhfeExy8WdGkzwZZAWdh21ju5GT5Jk9US4SiRPYL8w2Yr/d8QI+LKm
 DKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711750849; x=1712355649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1pFViSSelBLDC7jQWPNWKQ58HUVyc3Kf8+NgXdrfBUc=;
 b=XVJzL2Th15il8bP5W8J32SoUpN51LaTB73r/t+vdr5PKekn9eUEjKAp3ADhnuoqVNE
 8h2tX5GcZBoKG3bmAzBu99HxnGMpYfQZt+URWE+usPADggD7CEBvmRtCRUkrK0/RxtCw
 dRGfLAVwHRIaw6FyJ9o5aPsr2CgJiPZ5bD0YZFJqPnWrRNAWT2p5+e8HhUuxzr3lWvpk
 Y6njmOyyzt7D30ZnzHj87sazD3h6PSoXCv8LO99dng2c9lSlvJ73z/Le2siULzlKLicr
 9mG88hphtLlp2br5f7KuRXXRH5ZVGO0+1G2RGlDUoB0cw7uupnR3q4Ff9Nx19Y2fQ9pI
 FGug==
X-Gm-Message-State: AOJu0YwhZtcslby7Lb5Oc13Y96IUTahY0obaiYz6oijScYXBEl1I3hox
 809ZVByMNttu1vxdbJv+SOxuSdMPTArm+x3lEKfeUS0wWfd0fhvnC1pj35HJjcPNI6us/GChVqL
 S
X-Google-Smtp-Source: AGHT+IGIIGOGD3pPzUhhIIkKoxv0HYorUl//Y/yg7POhEYJ2TNpwl+bNLGaX81FxBFQiZPQ1BZEz9g==
X-Received: by 2002:a05:6a00:4b50:b0:6e7:6a7d:5a58 with SMTP id
 kr16-20020a056a004b5000b006e76a7d5a58mr3560406pfb.25.1711750849554; 
 Fri, 29 Mar 2024 15:20:49 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 lc24-20020a056a004f5800b006eaacc63435sm3579811pfb.173.2024.03.29.15.20.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:20:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/7] disas: Show opcodes for target_disas and monitor_disas
Date: Fri, 29 Mar 2024 12:20:36 -1000
Message-Id: <20240329222037.1735350-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329222037.1735350-1-richard.henderson@linaro.org>
References: <20240329222037.1735350-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Fixes: 83b4613ba83 ("disas: introduce show_opcodes")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/disas-mon.c | 1 +
 disas/disas.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/disas/disas-mon.c b/disas/disas-mon.c
index 48ac492c6c..5d6d9aa02d 100644
--- a/disas/disas-mon.c
+++ b/disas/disas-mon.c
@@ -34,6 +34,7 @@ void monitor_disas(Monitor *mon, CPUState *cpu, uint64_t pc,
     disas_initialize_debug_target(&s, cpu);
     s.info.fprintf_func = disas_gstring_printf;
     s.info.stream = (FILE *)ds;  /* abuse this slot */
+    s.info.show_opcodes = true;
 
     if (is_physical) {
         s.info.read_memory_func = physical_read_memory;
diff --git a/disas/disas.c b/disas/disas.c
index 17170d291e..7e3b0bb46c 100644
--- a/disas/disas.c
+++ b/disas/disas.c
@@ -211,6 +211,7 @@ void target_disas(FILE *out, CPUState *cpu, uint64_t code, size_t size)
     s.info.stream = out;
     s.info.buffer_vma = code;
     s.info.buffer_length = size;
+    s.info.show_opcodes = true;
 
     if (s.info.cap_arch >= 0 && cap_disas_target(&s.info, code, size)) {
         return;
-- 
2.34.1


