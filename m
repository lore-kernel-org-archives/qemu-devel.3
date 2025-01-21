Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EB0C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taJJP-0005Zb-5l; Tue, 21 Jan 2025 13:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taJJH-0004nm-CZ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:49:12 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taJJF-0005NC-1E
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:49:10 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-216426b0865so103696615ad.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737485345; x=1738090145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFnox9paCwopK+iw70x8l4RBRO8z4SdTp83xgjmiXGE=;
 b=P39n/vObDA5bl+HO+C8vdgx5MYNbfVNJNrVOeaYzR2F9DjlP+4XqrvIhHYKxDu/OtA
 nYLJ/wpIHmk+QgBbZ35hn4C75XrkDM8q6zAQDPMFeWpywodEr1Zf4HGBKcBq4dsfTfSZ
 lrJqh2k/UTnHgOv+0Wb55kfQoqAe/iSg+pS07+kMv3AIx/6wsE8OlLEjDCyXb6/kM36p
 IvKa/ATZkkhkiuGq5yLtLJIuuxnR5egYLApSOjczP9gLcDL3RUvsqHXVQ2g1tAkw380G
 gCWzQCOc1hEJ3aj79a35z4L4fO2oxf0cebXYacAI+sNUNbbXxfKDHvSQmyAZ4ombmjJf
 vWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737485345; x=1738090145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aFnox9paCwopK+iw70x8l4RBRO8z4SdTp83xgjmiXGE=;
 b=RUlpZYGQ/hzw3eqEPswo4WE3IquNCWbh0PFWwyqwGZdMc/HA+v2XBVkP21+trEC2jE
 7dCEfP/c7NX5wUITT58k2gGXyR90nOmiM13RIDm6jiHDxhaJs2M6UT6IA3JshFFXVvfL
 a2DqK4wEBaiDCKtsL8mNrQBO4vcZzZwPzqOjWIFwkeyu/jKf6MTJ1Jil0nfIZ+Q59t2D
 Ucoz4W63jPdw4n2UQDgppvBJL4q2JKlxY9LtsxrhcQ+hVRTsVreWkI1n3ixA12GppDc9
 TJZkWC/zOXHHDkkQobTbeQBeMrXmqQ6f61hH5/nmJSgksvV1jRicDoOobKOMGJ3NuFK0
 qxdA==
X-Gm-Message-State: AOJu0YwLQ3yzLmmoo9OmQ0BgrqbNR1eHL2ldUAJOVjPfh/IhLUXXrKro
 q7Gy7ROWPfbtnFsv/n+Mk5ZlleefbQBlm4TsPjFmihPH34ZZH5D1oOF+9+DzaZPjPVyNKeaTNcv
 d
X-Gm-Gg: ASbGncs7r2CgLH4Ld7ZJvqz1td0c2S1HcX3Me5s7NL12qZtW9lgjA+lPzYlTiAuvHpP
 5ndbK6L3T51ZfjrKgzT07azUUfxMxAR8zcmQP590oyvJyqCdmwPFSs8C/onx6y6reBEK+vNdmLq
 wB9YkboB3J6mJN/X5D9VCR7A5uDQNY9qHy6rGXAyeSncgYeiAIhd751C67ON7g9ZLSCfBv30qrv
 ebcS305ND5LInpUuEQ8lqBlkmPiXE2NZwuGKcrwKvF23CiCoQxUZEm26UuW9zPlpTkTjbsQ
X-Google-Smtp-Source: AGHT+IHbpsnBVrUf1PnyjrEd5diSaZNG27segl+kTh6f+rQJ0fRpX3TLg88OcpnqyW8y0MJkhlRmRQ==
X-Received: by 2002:a17:902:ea10:b0:21a:8716:faab with SMTP id
 d9443c01a7336-21c352ec1f0mr259659385ad.16.1737485345158; 
 Tue, 21 Jan 2025 10:49:05 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2ceba56asm81121865ad.98.2025.01.21.10.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 10:49:04 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 peter.maydell@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 4/5] target/riscv/csr.c: fix deadcode in aia_smode32()
Date: Tue, 21 Jan 2025 15:48:46 -0300
Message-ID: <20250121184847.2109128-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
References: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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

Coverity reported a DEADCODE ticket in this function, as follows:

 >>>>      CID 1590358:  Control flow issues  (DEADCODE)
 >>>>      Execution cannot reach this statement: "return ret;".
 > 380             return ret;
 > 381         }

The cause is that the 'if (ret != RISCV_EXCP_NONE)' conditional is
duplicated:

    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_AIA);
    if (ret != RISCV_EXCP_NONE) {
        return ret;
    }

    if (ret != RISCV_EXCP_NONE) {
        return ret;
    }

Remove the duplication to fix the deadcode.

Resolves: Coverity CID 1590358
Fixes: dbcb6e1ccf ("target/riscv: Enable S*stateen bits for AIA")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/csr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 75f21ccabb..dc0a88a0f0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -376,10 +376,6 @@ static RISCVException aia_smode32(CPURISCVState *env, int csrno)
         return ret;
     }
 
-    if (ret != RISCV_EXCP_NONE) {
-        return ret;
-    }
-
     return smode32(env, csrno);
 }
 
-- 
2.47.1


