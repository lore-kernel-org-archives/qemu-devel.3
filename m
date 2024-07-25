Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955A3C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8LC-0002tM-Dj; Thu, 25 Jul 2024 19:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8L9-0002ep-R2; Thu, 25 Jul 2024 19:57:43 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8L7-0001QN-Sc; Thu, 25 Jul 2024 19:57:43 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-76cb5b6b3e4so292695a12.1; 
 Thu, 25 Jul 2024 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951860; x=1722556660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IZNXvpP0wcpjvJx+nPXwZmvG3WU6OhipKjq6IwzM/Q=;
 b=clf0e/++8KBwekHpQTiJXRMrdeoseBB0MCxHBG+1zrx+5Rv/GzKKntZkq/oafCeAi2
 gcjOdoyxNyPtK1bazDPRF5YtW9xhb+K4kiSW1Ph927gXVMNtglSu1KqsjpFoY3eXfCkc
 JIQ5PdolXpGuxjhi0KhOaaAl64VW502oXqNd6y4z7sm18sS1vqyZrOFpArQOykoqPiAj
 XFgve5M1RoIF3PETLkS40MHss8Inni/cyBI8HImmSY1wGbD8Jy7aJvKnAcDVqPY9AHTW
 5q001tBFFsNID3dYSFmx1o+6Rw88wHV2fZ1sxQxSZE2vWRCFDG1EFLRtv0HFTkZ4yWU2
 nhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951860; x=1722556660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7IZNXvpP0wcpjvJx+nPXwZmvG3WU6OhipKjq6IwzM/Q=;
 b=wGXBG3QC8r0Bg4sIDQXoBSNsVoPhRpoJuXbTvEfhYpmUJPFe6e9SgeeSj0mQt25bPG
 rVSQyBHCwv0RSdP96Wt2q1ZJpxNQH7bodx2PAVmxhTPbAwFqedKGwja8Fb4h0Zfwfa2m
 6HAW2SziLk93tHNZMsuhRewIhUr/eReOkOHXrZurM14asqN2hM2NhnNHzpGe+/SokEly
 WX4Yh8c0TKBzc6bhWBf6AzP723Jmz4iO//5PBAUxpD+AU+o36mlV4orCMLxC7JwOkyvU
 rCMwynKS4qzU50kEazxyQjEJYztnB7BW1nu6k/qznzCTVUU2TQ0W+cZZAuuGevKAXTRR
 C9TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5CG7UyA0Rfos5eHeJ5BE6WNI/tTha+sBwgyBwrpBVX0e7J4cAPmBSBpZdo5pW/4AOV6eRnE8BhNkM9a9tDolWqJyS
X-Gm-Message-State: AOJu0YwhTMBKQFOz+QJZNJut0QGlyECbFc+Qa3HhH3JW/yldYDVLIlHA
 dheJ1boZJp6jkmwea4JRzRiY8C9bxdRT2YJA8LpFrJCEK2AWDbgfv6fBSA==
X-Google-Smtp-Source: AGHT+IGOFMZURx0sNLz9XewB+cSrH2OYXBommPcWfMH4VoE7cPNQ2OuahA+QZwivxCdIG7SMnt13cg==
X-Received: by 2002:a17:90b:4b4a:b0:2c9:81d3:65d5 with SMTP id
 98e67ed59e1d1-2cf2ea12db0mr4201086a91.24.1721951859952; 
 Thu, 25 Jul 2024 16:57:39 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:57:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rath.chinmay@linux.ibm.com>
Subject: [PULL 54/96] target/ppc: Improve VMX integer add/sub saturate
 instructions.
Date: Fri, 26 Jul 2024 09:53:27 +1000
Message-ID: <20240725235410.451624-55-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
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

From: Chinmay Rath <rathc@linux.ibm.com>

No need for a full comparison; xor produces non-zero bits for QC just fine.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rath.chinmay@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate/vmx-impl.c.inc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index fdb283c1d4..152bcde0e3 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -2876,15 +2876,15 @@ TRANS(VADDCUW, do_vx_vaddsubcuw, 1)
 /* Integer Add/Sub Saturate Instructions */
 static inline void do_vadd_vsub_sat
 (
-    unsigned vece, TCGv_vec t, TCGv_vec sat, TCGv_vec a, TCGv_vec b,
+    unsigned vece, TCGv_vec t, TCGv_vec qc, TCGv_vec a, TCGv_vec b,
     void (*norm_op)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec),
     void (*sat_op)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
 {
     TCGv_vec x = tcg_temp_new_vec_matching(t);
     norm_op(vece, x, a, b);
     sat_op(vece, t, a, b);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
-    tcg_gen_or_vec(vece, sat, sat, x);
+    tcg_gen_xor_vec(vece, x, x, t);
+    tcg_gen_or_vec(vece, qc, qc, x);
 }
 
 static void gen_vadd_sat_u(unsigned vece, TCGv_vec t, TCGv_vec sat,
@@ -2916,16 +2916,16 @@ static void gen_vsub_sat_s(unsigned vece, TCGv_vec t, TCGv_vec sat,
  * GVecGen4 struct variants.
  */
 static const TCGOpcode vecop_list_sub_u[] = {
-    INDEX_op_sub_vec, INDEX_op_ussub_vec, INDEX_op_cmp_vec, 0
+    INDEX_op_sub_vec, INDEX_op_ussub_vec, 0
 };
 static const TCGOpcode vecop_list_sub_s[] = {
-    INDEX_op_sub_vec, INDEX_op_sssub_vec, INDEX_op_cmp_vec, 0
+    INDEX_op_sub_vec, INDEX_op_sssub_vec, 0
 };
 static const TCGOpcode vecop_list_add_u[] = {
-    INDEX_op_add_vec, INDEX_op_usadd_vec, INDEX_op_cmp_vec, 0
+    INDEX_op_add_vec, INDEX_op_usadd_vec, 0
 };
 static const TCGOpcode vecop_list_add_s[] = {
-    INDEX_op_add_vec, INDEX_op_ssadd_vec, INDEX_op_cmp_vec, 0
+    INDEX_op_add_vec, INDEX_op_ssadd_vec, 0
 };
 
 static const GVecGen4 op_vsububs = {
-- 
2.45.2


