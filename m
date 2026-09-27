Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DAFC98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksI-0006yH-CJ; Sun, 27 Sep 2026 05:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrU-0002HD-EK
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:58 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrS-0008H8-JI
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:56 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 41be03b00d2f7-cc78d45f78fso1200690a12.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500071; x=1791104871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zMD7ymTOYJDBoYV7LsUQ9zk1ZoLly78yNzWsLIls5+M=;
 b=ZwXCwRwz4qyjQsBG40QdelLDPUh0aTZVz3k3TwkGpObd7hQ2IZhT4mJLmtzrBE9CRU
 Mlk4gJezOiIZM0PyFt3gPsKcRFwh8TauyJg7lqdEZf5UuDwXqbsXQJ9MaZecew7GcqJ8
 N6BbUD0eps+6aFzU234+rlrcQNg5tYDs0R2GBu3FDTWsJe7c5w5DumWVDe4J2akc2KOr
 yesusFLs+qA5bBIykMovIEs+SfZonxBs8yQk6Nggftm+OaLgKKLPFJoBvbTF+UTA855n
 uR/s5JOhGXzshgiB/szm+1hmZbq+GabEBViPbJdZKnPlU7BYRVWNo5b7ltoWovb3qC8y
 wIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500071; x=1791104871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zMD7ymTOYJDBoYV7LsUQ9zk1ZoLly78yNzWsLIls5+M=;
 b=NIfykMW4H2bCIxgl8/3LebQ5XlZmBFcfqeWpF5lmyjfbvwT1mJB4iaYRQOcqh8EH74
 ydIWB/IInOsefPeRVSLo5GRkKtAuRmVLeBPBWugwkooiHad9a091HeD+h77+BXtAefar
 1GyTgaAnkOqiQKrHYf0GdMyBPBqKNlMX5MCRYUKvEQjKZg5imWVXEvQ+0e+8lHynHW8U
 JXpW3LiMWOtLYRj0z5keuOWQ7bR/KgFcRrb+Qu8+TyXjpy/LwwzfsdOtRkN0GQDSOhh0
 +gN6OZVOXWmMTucM/udNd16zVE7eoSJs9B3VbA/eefml/WrtClkVMV63omlShCOyfdC3
 nqpw==
X-Gm-Message-State: AFq9FYLlXrCaic+UZmapZaKFyUy9w2YlKRoQO5npbSWRvX5yk7csq69n
 J15sdemyQy2lUwjH05VqdmkxjiqHI8ZeV1YObEKkqW7RfT6GS4UO4UuPikhlkjXjlK/SfXCDOyf
 sl3a8
X-Gm-Gg: AYBFou2JjfzsNc+sGrtcdYQeMIubB/KzMDPS0EhsQodRyL0JltzMPkjtYdEqLot6KQV
 4ESP8uB/+CkVRvX+A6u6PqsD1X6T1C+YnFqOcnYW6Ny5gwiyZPfje1QCqxHldBjm/1f3bkan5cu
 PgJ0TuE6MfO9EPrLbIkpv0piSxA54ympf1iPQM+MfUAM2YYhI9Ex056Uo0qUvF5KFqZc60+vLG/
 q+mDFhAL+NYKndEid2JUfunHizngjZ8tyM57jgHAWi9oJssmSN1PEcpWcXbRrvE20noWCrMVOtx
 GpM54f6VoepjFgGBjrKX6S2jQRQIzvn0X9DX9+X6CNP02gpINA5xcWILOFEBadVogS89eQUjoTd
 lbdDrNUuwW5gFPycWqe8VDYa0gkFE7giTPrveiq70vb51xlOxaKOi8VQtwoisHV6L/JzLsoiV/C
 T5USPbnbNoYVqOGQZBNmjob3mFsopwSBojxTcFeDubjs7tV1wnQ/46G60CTLKb1lBGAbAnDUeCO
 qOX5UZdE7fff6kYlXSbLgS+J+jMxw==
X-Received: by 2002:a17:90a:d2cb:b0:3a0:dfb6:aed1 with SMTP id
 98e67ed59e1d1-3a0dfb6d480mr3339159a91.18.1790500071171; 
 Sun, 27 Sep 2026 02:07:51 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 089/101] tcg: Generic expansion of tcg_gen_ld8s_*
Date: Sun, 27 Sep 2026 01:59:59 -0700
Message-ID: <20260927090011.10724-90-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 16 ++++++----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b7c31ad6c8c..981dfb73019 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -141,7 +141,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
@@ -170,7 +169,6 @@ void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 6284358a132..a110e645104 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -32,6 +32,7 @@ DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4d6838e8dc3..cbed2ce790f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -776,6 +776,12 @@ void tcg_gen_ld(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_long ofs)
     tcg_gen_op_tti(INDEX_op_ld, type, dst, base, ofs);
 }
 
+void tcg_gen_ld8s(TCGType type, TCGTemp *dst,
+                  TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_ld8s, type, dst, base, ofs);
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1386,11 +1392,6 @@ void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
 }
 
-void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld8s, ret, arg2, offset);
-}
-
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld16u, ret, arg2, offset);
@@ -1424,11 +1425,6 @@ void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
 }
 
-void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld8s, ret, arg2, offset);
-}
-
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
-- 
2.53.0


