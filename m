Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D87EEB56B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sofVy-000417-Nw; Thu, 12 Sep 2024 04:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sofVV-0001rL-QK
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:48:54 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sofVR-0000L0-EE
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:48:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cb5b3c57eso6191635e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 01:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726130927; x=1726735727;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DbIiKpe94DikCsQx7ZUJ7hfk6G1VSudpYPlKpBAptb0=;
 b=QGw2KQ1WbuSxjw10jP+Egip5u7PbHQFlvafpc1qv5jarnRNHdoStUS9+o57Sw33fb/
 +pwUR13TMEYLBqa0yPYgKoMu+J5A4LoN5ca29kiyEpcghzW2dNRjXKLxm/8/u7Ejbqdy
 ynvTHxHu5BQnOjUOqCIpiO3okYZklket/9L1nY/QSQUovencnlv5+o2n0sjhEwZzgpDZ
 ilSopZE2ARRLjeJgCICaATWHYgiuRnA8UIzVUBbkG/UAeKfC80nqT1mW8wJ+pd30vrHu
 v/yJwwR206Aw5D3ePz9lNG0mWneDFUgmK8ghB+e2UXB/TrSg8lURIw2WKTRJPN9Ihipe
 ugUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726130927; x=1726735727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DbIiKpe94DikCsQx7ZUJ7hfk6G1VSudpYPlKpBAptb0=;
 b=kHM0V4I0thqKGd622I6LlBp+nYM3nWnXj46z1pgnwOsqw45IKAdpmzJHiXzHfTF2lA
 6vTRADojAmYYNmX7PuYqCxe6dl555RsiIprbQUj/vc0edVnIbrE/937O7Boei6I+ppHG
 HY5HToZbrIgsbfLV0gMv2/Aae3Iw0qCSZyDq3SmGdGNQSWtGgnkyNeu+1HBI4izk98JR
 wtV6DoePUCvJ/TEexPCBhe5dPIL24dzN4uUT32mCyZmee94AzToemQJFj3D80LEBFGr+
 fQVTSr7e2K97XM/Uh3brSdhCSb5MbpxqBjwzxs8OfFkOKk9EwZNgPD1+OkY5R7riIf5N
 Q8Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJiPWBzz9pjf0685e1uMKFdHffRSbD89pzLIsAFSLd4Me2+itTv9bTlX3cEgDIWEx23NGbzO73tPg0@nongnu.org
X-Gm-Message-State: AOJu0YwFSK7hKIP8WHl1V0AlHmMhjgACnVDatsuIrePiXjPCIMOi5xdc
 VnPuunwXDD+/EmWVBIQWR0qR3v7jdCTi9DeE+N22GIv0IUqFcWbx3o0xZJpDSJ0=
X-Google-Smtp-Source: AGHT+IFWUjZI26GbDL//PYrrQU7Cb3DYVR0quXUykaBWdI9CJCnnvLaBJ+YPjR1xSFa28kyUaTNk0g==
X-Received: by 2002:a05:600c:3b17:b0:42c:ba83:3f0e with SMTP id
 5b1f17b1804b1-42cdb538c44mr16565485e9.7.1726130926723; 
 Thu, 12 Sep 2024 01:48:46 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb33a92sm165637475e9.20.2024.09.12.01.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 01:48:46 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 07/10] target/riscv: Add Smdbltrp CSRs handling
Date: Thu, 12 Sep 2024 10:48:26 +0200
Message-ID: <20240912084832.2906991-8-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912084832.2906991-1-cleger@rivosinc.com>
References: <20240912084832.2906991-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Implement MSTATUS.MDT behavior.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/cpu_bits.h |  1 +
 target/riscv/csr.c      | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 5557a86348..62bab1bf55 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -561,6 +561,7 @@
 #define MSTATUS_SDT         0x01000000
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
+#define MSTATUS_MDT         0x40000000000ULL /* Smdbltrp extension */
 
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d8280ec956..cc1940447a 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1617,6 +1617,14 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         }
     }
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mask |= MSTATUS_MDT;
+        if ((val & MSTATUS_MDT) != 0) {
+            mstatus &= ~MSTATUS_MIE;
+            val &= ~MSTATUS_MIE;
+        }
+    }
+
     if (xl != MXL_RV32 || env->debugger) {
         if (riscv_has_ext(env, RVH)) {
             mask |= MSTATUS_MPV | MSTATUS_GVA;
@@ -1655,6 +1663,13 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
     uint64_t valh = (uint64_t)val << 32;
     uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mask |= MSTATUS_MDT;
+        if ((val & MSTATUS_MDT) != 0) {
+            env->mstatus &= ~MSTATUS_MIE;
+            val &= ~MSTATUS_MIE;
+        }
+    }
     env->mstatus = (env->mstatus & ~mask) | (valh & mask);
 
     return RISCV_EXCP_NONE;
-- 
2.45.2


