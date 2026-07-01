Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4978C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welGD-00067w-EY; Tue, 30 Jun 2026 23:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welG1-0005km-T1
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:05:02 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFw-0002sG-Vp
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:05:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ca06ad2d11so1499225ad.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782875096; x=1783479896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bn7nR5aCNzjwIjjAfoSQIcT16OvTScPNGETb7yLySDw=;
 b=cLX6OQSJrcyDlg/eHUOcX3E0MfG2lE6rW+7AFwPGXS3LUNfhGXvhKYe2KNluj58/KQ
 4+E4VdeR8J5RAsCNtoYs37apCuHSrdGO/Sg2FJVETa+0d39hzAClo1nXuW1RJyCtcSXA
 t6NCG/ZK5T1hilDYnrn7TADn+fJsexNJx5GCtIuGKqJz3ZQqfAXDDejeLaNXIvjDXDBo
 /mbtz7OB95dJ5tc/ApBoyrkLKHQA8QS6Zt4n1lWpV5EyuB/vCW7Tys/Ibrrj2vrZqeqs
 OcYlX3UiQUCYFDayYqzN+zkdHnRHFhGJLbBEEAq50y041OQCNCSj70JmU06NlpBK2e1I
 VoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782875096; x=1783479896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bn7nR5aCNzjwIjjAfoSQIcT16OvTScPNGETb7yLySDw=;
 b=iL0YWAHNWhZ/O2/xCGdzUykpdVYaW58lrgavfig93dSyTn7ssspKQhBhVrYZW2VI33
 pSBi9iSisBMspQKVWBOlhSpwEUE+u1+7MfbEIR9d/3Osgi6B8d3WpTgkaYheNpF8ESlk
 Uk6ELFwzAzP+FSyoqsVVmLxFkHfFD7DxH+uR70Zfkg/aSczRwDvxAooyIuQ9A3zvSN7w
 ynZoo9sSsYgOfUUN/hpVcpMwbj6voEry8sF2Df670cln6DrVkA1r6NmqsUkPH0w//+bq
 /1FgVOU3sS/r1hk/n3ZNBTSO0m5LgKY+XBA8AzqwlPVFxq4O4f/sfTFYGiDIR7z4Bz7u
 pg0Q==
X-Gm-Message-State: AOJu0YwvvzdV8SQVPQN4Xh6ESinKaYReb+cG8LxwkLgueVlwgA6zmY52
 aWqUlLM0PznqMgIx1MBSRFbrJmxB3HdyyOA/+w+MvBHymA0QXYU0FwJ07y9VQ0SGTES2rOBkwAT
 n1A32
X-Gm-Gg: AfdE7cmq9PUJoh222puUXJj1rxs8QCJTTsppjGNMFWAR1Q5ILHG9YHhvU6komcg1vlu
 8n1URb9/avbuVxa+siJD5lipLhjyWjwU9kyq99I8+Plr7fxwQcdFBEZu/V7Jtp+ejJ+icA9I2UF
 Ia4b6kcfUrJecL2/cOIExOpa5iT/OWKUFAQCUezExZbDx11b/L9/0wnGPitIl7gRxqstrZm1jQv
 hfOS9r0jJ2SPS4xA0JOCqiVDpWBduO6Om5dXiokN99xKJSKz94+kz4G12IBt7F8c13TV1+0X1Ur
 wWzC8LnVfSEQUhTZryR6Hg9P7fRaInN9y+VOXTfVxs7FeUE1lIg7YpHzZXmPQ1U37UHZJ8dO06x
 BhbrtmOHRDE36RkVRU4cVaySD4P+yOo3Uxgqgh6ZFAqo0ISAoLH3v1io/jqaS0eCs/XHTWH6dnJ
 +C5ZF9xz8+Wl+AHpo7y+PgNbjLA2+CN5hx/Jp+PaQGJFNkf99J/Q==
X-Received: by 2002:a17:903:f8d:b0:2ca:75af:1a92 with SMTP id
 d9443c01a7336-2ca75af1c05mr6048165ad.33.1782875095494; 
 Tue, 30 Jun 2026 20:04:55 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37c74261sm23758085ad.22.2026.06.30.20.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 20:04:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 13/17] target/riscv: Set ID for watchpoints and breakpoints
Date: Tue, 30 Jun 2026 20:04:39 -0700
Message-ID: <20260701030443.1382447-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701030443.1382447-1-richard.henderson@linaro.org>
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index ad9df09cf7..5f76dd4b7a 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -479,7 +479,7 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
     target_ulong addr = env->tdata2[index];
     bool enabled = type2_breakpoint_enabled(ctrl);
     CPUState *cs = env_cpu(env);
-    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
+    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS | (index << BP_CPU_ID_SHIFT);
     uint32_t size, def_size;
 
     if (!enabled) {
@@ -604,7 +604,7 @@ static void type6_breakpoint_insert(CPURISCVState *env, target_ulong index)
     target_ulong addr = env->tdata2[index];
     bool enabled = type6_breakpoint_enabled(ctrl);
     CPUState *cs = env_cpu(env);
-    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
+    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS | (index << BP_CPU_ID_SHIFT);
     uint32_t size;
 
     if (!enabled) {
-- 
2.43.0


