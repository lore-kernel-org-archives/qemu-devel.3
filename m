Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DD4C3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAcI-0004w7-5k; Wed, 30 Apr 2025 12:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcG-0004sk-JM
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:00 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcE-0001tQ-Cy
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:00 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so1239492b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746031737; x=1746636537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8QQZQVqZoC308ckvLV+kB4d6m4SiPb0nD+im6xT08U=;
 b=L5u/+81YhJyXNbFsj+0l/R+iIMl/pQ2cMEcChT3uNym59EIhSQ2x1pKwablYeYJyi/
 ZZpOhKpjo5kE/AVwFgznUPOmETkeWKklUMUnwwt7L/sfmNO9YbSHpAXHVc1ZqXnXB3pw
 95875TiICjMp0QgXR09r4dpd7yT65PBX3LhtWOIACyEjNHtRhMXYRKYuW8Kmc9BARFgx
 Wo+4K+wLFgQK+AjFpf1Ig8EPvn70aM46FPH/BT6uiRvGmGhFSf4ftGeCahHY8D/UaH22
 Z4KdKQTg9CHMmhmo7CbHFO812MAfYKxsCBvEThCGnZO8aMmi+fOCIpOBBvdLuwLgLDIv
 vYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031737; x=1746636537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m8QQZQVqZoC308ckvLV+kB4d6m4SiPb0nD+im6xT08U=;
 b=nmZWrzUGW5sqJXwIeEYhdRleWu160hd5RTRyLicMwM8z53gghKzSFWKtxv2Ksv+Vqw
 R0zzS/r6T/XJj4RMQ965Aipvdyi2wrptGWG/QNLRu/xkmpxns4y/XZIW10uSoQDXrUoS
 yLEUDNRhBHRlS7T8f7P5e3SbZ7wnhNWDQIVHuxEpiGIDE+CETXwOA+3EOKrQNJhG4UAf
 X+f9ESBZm0ODsZ5VNRiJChwUJPOn9O2H7+bFGid/LuTsw5zQUPbyrF17Rz4Vo8pk1OCY
 XTmuXLBtQyBEUmADFnVc7LNpYZuJE/46k9xHqyPfHm5K8C6j75zgNXCeHmiPNtp8WrXX
 KE7A==
X-Gm-Message-State: AOJu0Yx1CehaklE8sMnGjUFupXyddM7aZ22CUlZ7927E0B1utGCxNTHr
 bPHzO10WH0S5p/7n40R4osru5BDxEe7RlyHv3M6EjVKg5zZxOE6Q9IwHVz/whnYJYCdtzjqeOuA
 h
X-Gm-Gg: ASbGncuW6LUTfc0zHCQapGERM2ikUqWr1stkWzA/4atT8XZtK/G3EYEDqH/fUBYoJmI
 7OyJHCxa51V76ZKUPQOSWr/xhrxhS04pnYnpGOmwq9Bn5ZLA5THzKZbilfB5cKA4XxFCLQcs4Nf
 fm1KJDEmb+6P0Gf3YxDV77XJPcYYRyKoUZGykwMQ0R6p4bK7C4jpNw15gKchJnF3P659/wTVyJ4
 +NQoxIEqvDfmTtFiSHvuM3PnNwZFsEuAIpZ3AYldhpq/u6ZK2jTQZGw9QP0MBQfQE+MbL9+raPx
 T/wxw6MdIWdvtFJXHzP++aQ+oZk0tRNCzBjBL8k37nEA8D1YyIjUwgy4eJVIt3aruSwTDDKy0C4
 =
X-Google-Smtp-Source: AGHT+IEjiXGq65W3AQN3yQZif1AObQuuPkPWlyk066RbUvm4BqWosniNjxe71pT3TZkFsUui7vqjmg==
X-Received: by 2002:a05:6a21:1796:b0:1f0:e6db:b382 with SMTP id
 adf61e73a8af0-20b96d5f470mr247574637.8.1746031737052; 
 Wed, 30 Apr 2025 09:48:57 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f580asm9129704a12.2.2025.04.30.09.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:48:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 02/16] accel/tcg: Unconditionally use CPU_DUMP_CCOP in
 log_cpu_exec
Date: Wed, 30 Apr 2025 09:48:40 -0700
Message-ID: <20250430164854.2233995-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430164854.2233995-1-richard.henderson@linaro.org>
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

This flag is only tested by target/i386, so including this
makes no functional change.  This is similar to other places
like cpu-target.c which use CPU_DUMP_CCOP unconditionally.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8ff4a34509..ff979a2c57 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -285,14 +285,11 @@ static void log_cpu_exec(vaddr pc, CPUState *cpu,
         if (qemu_loglevel_mask(CPU_LOG_TB_CPU)) {
             FILE *logfile = qemu_log_trylock();
             if (logfile) {
-                int flags = 0;
+                int flags = CPU_DUMP_CCOP;
 
                 if (qemu_loglevel_mask(CPU_LOG_TB_FPU)) {
                     flags |= CPU_DUMP_FPU;
                 }
-#if defined(TARGET_I386)
-                flags |= CPU_DUMP_CCOP;
-#endif
                 if (qemu_loglevel_mask(CPU_LOG_TB_VPU)) {
                     flags |= CPU_DUMP_VPU;
                 }
-- 
2.43.0


