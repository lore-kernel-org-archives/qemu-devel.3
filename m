Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24035606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=H5CNRolB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMsWH-0006Q0-Lj; Fri, 30 Oct 2026 15:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVj-00063v-6U
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:35 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVh-0000Ag-PW
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:34 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-844a8bf7e25so827417a34.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793389412; x=1793994212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oyaQfeYT5wXmSWJB7DEMxmJHMERAlVWYZeH8XtA2gq0=;
 b=H5CNRolBz4jwg1teTrOm2VJOJ0AXhFF9gFmmEUkZ4rwLVGUJvXX/l5J6WER4qMOmG6
 ut57ChJpBvetJD3xSo/1WOujdMNHLUIc+0n+aLdZhG6D0Lj8AQj/h6vofaYUvrcJZcEp
 06dtb+j6gc3sktFjI5Ax2wNMt6pkq0t7WxuzAmPrvq9H6ge+JIL8zdKi1lLTHQxplRye
 9E1bA2Ba003p9qfYYNMPCTP20tP7kKBvnAsyzKRzVOCeOdRwh0qmTp3kQ66SFZYWgO3N
 o1plJEBAWbcj7d/B7qpG+ZX7dJ9YULxvU/MJQnNID3/E44wFqvs2FMDtuZjpqlq0hNVR
 5Rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793389412; x=1793994212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oyaQfeYT5wXmSWJB7DEMxmJHMERAlVWYZeH8XtA2gq0=;
 b=bueCBNn/+ZF88vp3SSa1gobUUIaSRGSJXWqNYWTBpDQd/z/4wrXNEw9x7Rcqx0+kwI
 Y3RTaxIAEj/CQZJXj8Idp97z9EhwvOCOVXT4JGEGCQwOX8t20E5O2QOAaxKywLfaVkAu
 ifft4KOCBMopcZrm/sEhq5CvWIRDOs/6+okJYHeEQGPxZccsuHd8B8PHoe5/jWXYIedV
 2M17j8mrV2DDKMKCMBch4mDOARapQHm06nVaNjdve7zj98VxzFO6Uwd7c9z5pFjzkVmJ
 ajsNqP2zDXva3zJmyrABu69u7pJE0i0NlAfTcpYkVP3yYkDnJzVdb8J+NU/DZsnTMVS/
 DO2A==
X-Gm-Message-State: AFq9FYL98BQ+3PfJW7iZBLYM+CC1F/lBkDza0nNZYYdk6fRf+UtrNmSB
 Spmn+7/EGQYvWx7uq0hmhLTFsCGOa7/cwbtVnf0c8YlrI1b87agU5KOQDwX/wAhX//gYi1m6JFb
 Ng+d3
X-Gm-Gg: AYBFou05pOjhxcCcIjK7UgNaQCAfGGaksnAf0UyUi7vOHnrdaFDtBLMOuZUkcx1sWVn
 +Jrxp+v4bLVSUe7aj4R5JsdqlDOkTEUoyvW3BL5VOZOOaxusNTJC0ii3b8x992cPF4rxnYEMJ6W
 S5FaEPlaDZtkBGQbcZ8CuQ+2XoPN3XCIQNhzZDdK2rTN7qjlxjrj/NglB/SFbCGxDZLSi5zTQUH
 HfR5G/SUNgG84dMkXawl+FcZdpa5BLVF7Rr99e0g6sAWblTGovwcVRtf2in8Zk3T/mQjbu6qYCo
 0p66ng+NHDfaM4OUYveXU6eSwJAIyzYfzeYm22qZY1uB0btaslyDhdGjkcZSZnjUOaE6yGATN3Q
 6F+XLcX2REA70cmvzc9PdvKyPLcsTD3X+irljKvNEz2sj2FOkCK2pj8+ANTmS/FlnwOPlZCD/qm
 cI4rqJqRybNEdO1VuzpErX7WMzB34y0aJLBTYEj3KKWbSBs8xlK9c8qaPUOrNtwwckd/791tDjK
 DMyk+/TuUo8Aw9vUebWLODwDcvt71TB3VELUVHEl/d3pftM6cUkeFtTYf9BkupjrQtEW+5HuAVS
 KG0oxmogHJ1AtGS+j/kkfIRU2mNi8WXL0Xk=
X-Received: by 2002:a05:6830:2317:b0:81c:a8c5:633e with SMTP id
 46e09a7af769-85d363b8959mr2446586a34.11.1793389412514; 
 Fri, 30 Oct 2026 12:43:32 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d351e77c8sm2654768a34.2.2026.10.30.12.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:43:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 9/9] target/arm: Use tcg_gen_goto_jc3_i64 for aa64 branches
Date: Fri, 30 Oct 2026 14:43:18 -0500
Message-ID: <20261030194318.319310-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030194318.319310-1-richard.henderson@linaro.org>
References: <20261030194318.319310-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Assuming FEAT_BTI hasn't needed a page-table lookup to
determine the BTYPE for the destination, we can compute
the tbflags for the target.  Pass all that to goto_jc3.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index edbf67b03c..4a56fa70b7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -566,8 +566,11 @@ static bool gen_indirect_branch(DisasContext *s)
 {
     if (s->ss_active) {
         gen_step_complete_exception(s);
-    } else {
+    } else if (s->tbflags_invalid) {
         tcg_gen_lookup_and_goto_ptr();
+    } else {
+        tcg_gen_goto_jc3_i64(cpu_pc, tcg_constant_i64(s->tbflags.flags2),
+                             s->tbflags.flags);
     }
     s->base.is_jmp = DISAS_NORETURN;
     return true;
-- 
2.53.0


