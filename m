Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7436DE68950
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MFj-0007EQ-4V; Wed, 30 Oct 2024 23:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFh-0007EI-UO
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:41 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFg-0003tB-Fr
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:41 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20b5affde14so4363985ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346819; x=1730951619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+FRnF6zFYJlNe+SSGtltkqyDEcqAOn0tvz5ttl1V1M=;
 b=Bt2UMcxkHSfK83rBOlLxI539egDK5gzJjVp/yLr1C4E35ZO8Z6YKqE0rF+OrGchd/P
 eLky0OJz3Oeut7VblXKrMDALe7OQub0MCnAY9+SLM+QoEix8U2aqvoP5hEsnUqYvcn0V
 NFYqW7L85wq9IvPyYfMQLRuK6Nq7Z+so/uI2uuKx+yW5lkv9HhGyGCdXssxfFR6VBUHj
 kEjTzo0XIz1OqqQimabyh7W3Clr/e9o1RkEF5BG9AUyWnqMUV2BhYP9SsNE2mV64ibOl
 97z6F0HNSBROMEm67QSsstXnrGGhIuSjXmvwj9wUuQdPNpTNcUP6hHtj0Z9iIdLK5D4K
 k95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346819; x=1730951619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+FRnF6zFYJlNe+SSGtltkqyDEcqAOn0tvz5ttl1V1M=;
 b=YvyhRzUYxgQW8eazuWDI++R8P12cZo0VohCR8IjCmIssVl/od06FKcTBSkxuUi1Y6e
 NF9k2pFYJOXtqy5AwFQK5xjHe8MpZNFbT0SP3HxRZcx2PoLdvy8LCj+UXMJWoXT1K+XP
 t8yED+TsVRNwpCJNjkU19mVz77b5FAmD1A3Kzi53K0bNof3wqZEtB3HKcHARviS4CNBR
 st9XA6+HiS6Pbf3zQIoDnVCAJmfZIYtH1iOuWRgGj40iouorKJuzjJR9Vf5U6rZ5w2Z8
 FbXiQYGv8Le8x5dyFzYevS9oVOIypak8ZbF7rj7kZwKsQMMD9eLFBPZKvo7kT9cYAMa8
 +2JQ==
X-Gm-Message-State: AOJu0YzNTdfK2d+pGYkZFSYDNDT41BPwel8XGvzxNqFelxlcmuln9shr
 pF5Tr4qG7PA7eNJJxxXOdfILTJd++OTXm704601IO8Q6TAZrQfKWOVoQBv6n
X-Google-Smtp-Source: AGHT+IEyUcuP6H0zOoMNChh5E4iyEfEHAvXgSBQFNVv4crIX84Pp4LHCFHEfjwdS9a2XceKr3B4rWA==
X-Received: by 2002:a17:902:cec3:b0:20e:57c8:6ab3 with SMTP id
 d9443c01a7336-210c68739b0mr272226115ad.4.1730346818760; 
 Wed, 30 Oct 2024 20:53:38 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:53:38 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/50] target/riscv: Correct SXL return value for RV32 in RV64
 QEMU
Date: Thu, 31 Oct 2024 13:52:32 +1000
Message-ID: <20241031035319.731906-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Ensure that riscv_cpu_sxl returns MXL_RV32 when runningRV32 in an
RV64 QEMU.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Fixes: 05e6ca5e156 ("target/riscv: Ignore reserved bits in PTE for RV64")
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240919055048.562-4-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1619c3acb6..a63a29744c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -709,8 +709,11 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
 #ifdef CONFIG_USER_ONLY
     return env->misa_mxl;
 #else
-    return get_field(env->mstatus, MSTATUS64_SXL);
+    if (env->misa_mxl != MXL_RV32) {
+        return get_field(env->mstatus, MSTATUS64_SXL);
+    }
 #endif
+    return MXL_RV32;
 }
 #endif
 
-- 
2.47.0


