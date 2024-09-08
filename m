Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4884CECE579
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 02:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn7dU-0003Gg-UI; Sat, 07 Sep 2024 22:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dQ-0002uU-De
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:40 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dN-0004yq-Ol
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:40 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2d87a0bfaa7so2344094a91.2
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 19:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725762396; x=1726367196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scmIlN57Rm25WLgsDvFofZSXreJWo4oYdwMtH2Klqjo=;
 b=YNCLN8+x5H+WX05kGDckfJgwfD7Z6YLino/SQXbKLW4UO/oU7H0mWIw2pNl4ZUmSoA
 4+C+fCHAskgjcJUVWs7GcNsw7coyyymAPISc0OvTtBoirTsFetQ1lD3R9MZjaExAmL3G
 c3sdxdWg+vV9nXWOQt1IJSQQ7UMReKdldCrMYyIhQis1jhDWt1SlvEr8rQ3O8GnppG9X
 gGORDdJAAYF4TrC42a4sPsctMQCg0ubimnlnw4ZjdN61YA8NN8V9/67pmN9qnzaJhA5f
 d7X8v8MDHnOI49YtMJ+NfqbxBjLdkDhgyqU801SQCuxr0IEtlReiUoFXfPtL4zooSgU6
 OACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725762396; x=1726367196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scmIlN57Rm25WLgsDvFofZSXreJWo4oYdwMtH2Klqjo=;
 b=Ck8el1Aeai0eRR72cTdHRPJyDekmNg/18jY/EVxGLHaQF1CRhf4aVOO98Iz2CQfsfB
 Bi+LVxs0NTH0MAaRz6lay55ELVei9QSHarONxYXluHsOcfjyvcUjGfDc14Lyq1v9F/hq
 1WzzJfO178axs0PBsl7s08CdjmYIed9yY+gA15KHYDy/m2Vky6Z9tR8X6Fsn+NGMPbBr
 zRYguas8ITxiLqiOEvJpz98AHz5wSDC9p4LVTwDLrpUPnJgj4bSQz7WULqBiLnpDlW3j
 Ht+6lNxqLGKrCdOSNDh9xD87rQXr60PH/yndlqBJLjZx6u0JmME22LtKG1qAxRIOZdqI
 QKwQ==
X-Gm-Message-State: AOJu0YzzqdoYuq6GN1gElM9/RuJDUePLgvvGKo+e4qagQPwe1MJ6ZAgU
 b5VGq9P6c6j7r0rFO3wqjyAtIhyJ5hWJssmR8kzVlIxrZR8UyXdFfDC/BktSby2x2jEvSrX4gVf
 X
X-Google-Smtp-Source: AGHT+IFlJz+jw6RLMW3QTAwGnzyaCBP6Fhg6lSUze3oCRuvP57meC70MIx1Lv7vATdHYJCY8t224Zg==
X-Received: by 2002:a17:90b:3c83:b0:2c9:6a2d:b116 with SMTP id
 98e67ed59e1d1-2dad4dde0bemr7833299a91.7.1725762395626; 
 Sat, 07 Sep 2024 19:26:35 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadbfe46d4sm4084019a91.1.2024.09.07.19.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2024 19:26:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com, qemu-stable@nongnu.org
Subject: [PATCH 01/12] tcg: Fix iteration step in 32-bit gvec operation
Date: Sat,  7 Sep 2024 19:26:21 -0700
Message-ID: <20240908022632.459477-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908022632.459477-1-richard.henderson@linaro.org>
References: <20240908022632.459477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

The loop in the 32-bit case of the vector compare operation
was incorrectly incrementing by 8 bytes per iteration instead
of 4 bytes. This caused the function to process only half of
the intended elements.

Cc: qemu-stable@nongnu.org
Fixes: 9622c697d1 (tcg: Add gvec compare with immediate and scalar operand)
Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240904142739.854-2-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 0308732d9b..78ee1ced80 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -3939,7 +3939,7 @@ void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
         uint32_t i;
 
         tcg_gen_extrl_i64_i32(t1, c);
-        for (i = 0; i < oprsz; i += 8) {
+        for (i = 0; i < oprsz; i += 4) {
             tcg_gen_ld_i32(t0, tcg_env, aofs + i);
             tcg_gen_negsetcond_i32(cond, t0, t0, t1);
             tcg_gen_st_i32(t0, tcg_env, dofs + i);
-- 
2.43.0


