Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BA060A382F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qZdM8G2Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUM6v-0004FQ-Fa; Fri, 20 Nov 2026 05:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xUM6n-0004Eh-Mu
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:44:45 -0500
Received: from mail-pj2-x04.google.com ([2607:f8b0:4864:39::4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xUM6m-0007jd-7S
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:44:45 -0500
Received: by mail-pj2-x04.google.com with SMTP id
 98e67ed59e1d1-3b10718b387so408138a91.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 02:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795171483; x=1795776283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dd3Qh+cLFVuVabZEy0pFyjUo50S9bkDox3kUAgImQ64=;
 b=qZdM8G2Q+la215IbZOq3MymyEIS3HyRc2in9+TOuKI0iVY5EZwZVwJWmUBsWYRu2ZI
 6bZGHT9AGK/Mat2QrULoKF/t7bSZnkLumIg7+jf1Rc6b2RJWePpQX/QYUX4X3VDVZFth
 dHkNuJAgbFOZmhc2Oz4E5Jd4oYSZexCAoNSFUrMLd5WtA76RkHE+r8wWA0VBOE4kVx9w
 M97qoxoFhRTgalsK5O3YVyzW3BHbSjFf+/GFoyizUvse78SHj0nm+xE6DYcSM2Xawzje
 qCrZfBVdZqHMQBH/ybYLBmNlXl3KSKmCYH1peSKLR/TBOaR7A/RS/vsxxTwR4PrvTGV1
 9+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171483; x=1795776283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dd3Qh+cLFVuVabZEy0pFyjUo50S9bkDox3kUAgImQ64=;
 b=LuYGrIw0rlb9qz24ljgPulEmLYVzkBvmmdZGc8nH5e/aUwyZF3hhH7HyTAKaqs0pGH
 yqENDz/dThXCjpXEXyiZBjvgLEV9QWXSGNyvVFpht0JyX+2s6iVBdPiap4aFR4gcQQ53
 lBhyMl7g4U9Snt4dRPBz4UXbunQnSQ+EqNez9gTGPPybqurs10ydJcYx4erW04NHkjtK
 0NAyFxxSmlbgnfGF6uBRpROZSlgrRMq9y/rFOr4wy+B9GBDQAD7syCNi/ee/JVzJWMrF
 huAqCWUR7s6LFKFMwC5pAIFt+K9iltlTMJGvq0nMc5C2qP0Xe+OUSSBnkOaX/K8Iq4QA
 tOcg==
X-Gm-Message-State: APuU4Z/YfKQAOOFBTBQcINjIyuVYp+FWEp146nXYc/RPr8kVr7+KCs9u
 wkZxO7E+PTq+cpTizNt9L5ZKwow0z3eWQ3S6eLe6Fh+CO9Hhu2RZUTyczEyB9jXk
X-Gm-Gg: AZFdTZcaUMddB66A+OrMYmQdgw0z/XFZ10G5rSWDRQy8YAzObIJfWkOl5qHLOJqyeLn
 TyzK2w6I+FokUtaC9f5Su/5JRP5i7yPB/6vcOaaendfUNcJ8yqsUTP1Yfgnmhqjle+MikFA2nrj
 +efXzpHjoX3ZGhP7d4qndJRezNtqvYGVqSk63qbt35zaCk4PJD3/DsqVq8uGIob0I9eacv33pFL
 n2XO8umZmDHtRyBGaWmmxWYZnYToebTFACCeGy8wH2dvHfF1CoCcGiVswBqvX6J2siU1v0zVtiv
 wflfdUHYr5a1l6eg5ZWd5zonzisD4S0dJPq5IdIcNMWrPweTJoriFQU07Oaw63thwb4wcwr4oo7
 ksmZ+MItma23+OQ4JLuEQYPx1V9Z9bmSfnM99OvZnxBUEZbRI4XS//S3dIjLcXhgUs4Re4En/C9
 xayPX+HKNDdBYONfkfU+ytvzx3+fcPhELaqAJji/zfNp67a3eh6Nb1ZEZF7ubv7VkDL6zVxlKye
 gNR+f8VfIKmSJYaVxZ8rOOt+53XeFM9jn+9X7/B51KUHa0jb4b/HeCFdEDwX19Ob5sbj9BFDiMZ
 yzMLmRih40K+f6hIyXXJ2oqp3SxWDRc=
X-Received: by 2002:a17:90b:4b85:b0:3ab:c80:9370 with SMTP id
 98e67ed59e1d1-3b41c9b2c94mr2253958a91.20.1795171482757; 
 Fri, 20 Nov 2026 02:44:42 -0800 (PST)
Received: from computer ([2604:3d09:98d:800:cd94:7b9e:bb89:3491])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6cfc80d4sm1151506a12.6.2026.11.20.02.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:44:42 -0800 (PST)
From: Tim <mdspan.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, zhao1.liu@intel.com,
 Tim <mdspan.github@gmail.com>
Subject: [PATCH v2 1/5] target/i386: mask the PML5 table address taken from CR3
Date: Fri, 20 Nov 2026 10:44:27 +0000
Message-ID: <20261120104431.733136-2-mdspan.github@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120104431.733136-1-mdspan.github@gmail.com>
References: <20261120104431.733136-1-mdspan.github@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::4;
 envelope-from=mdspan.github@gmail.com; helo=mail-pj2-x04.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 5-level page walks in mmu_translate() and
x86_cpu_translate_for_debug() take the PML5 table address from CR3
with ~0xfff, which keeps CR3 bits 63:52.  The 4-level walks already
use PG_ADDRESS_MASK.  Use PG_ADDRESS_MASK for the 5-level walks as
well, so that CR3 control bits above the physical address width, such
as the LAM bits 61 and 62, do not become part of the table address.

Signed-off-by: Tim <mdspan.github@gmail.com>
---
 target/i386/helper.c                 | 2 +-
 target/i386/tcg/system/excp_helper.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index cb25018e..723e87fe 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -297,7 +297,7 @@ bool x86_cpu_translate_for_debug(CPUState *cs, vaddr addr,
             }
 
             if (la57) {
-                pml5e_addr = ((env->cr[3] & ~0xfff) +
+                pml5e_addr = ((env->cr[3] & PG_ADDRESS_MASK) +
                         (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
                 pml5e = x86_ldq_phys(cs, pml5e_addr);
                 if (!(pml5e & PG_PRESENT_MASK)) {
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index 44be98a3..6c48ccbd 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -173,7 +173,8 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
                 /*
                  * Page table level 5
                  */
-                pte_addr = (in->cr3 & ~0xfff) + (((addr >> 48) & 0x1ff) << 3);
+                pte_addr = (in->cr3 & PG_ADDRESS_MASK) +
+                           (((addr >> 48) & 0x1ff) << 3);
                 if (!ptw_translate(&pte_trans, pte_addr)) {
                     return false;
                 }
-- 
2.47.3


