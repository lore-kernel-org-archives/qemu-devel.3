Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1767CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKco7-0005HH-6G; Wed, 06 May 2026 10:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcnn-0004yK-Dh
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:00:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcnj-0000Z1-04
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:00:38 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so25238275e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076032; x=1778680832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aiS5VPVZwmKd8FQ7cW6jsheyhp9wBNYj5aSAD9f/3t0=;
 b=dgSO+aILkm66TZ/yfE6hSfuFYRi2W8sdccza8fAguBB2/+bRc1C2QEMMaRSm4mxjZx
 QWe9Zg6gNibo5AnbXAnYR1qU5p4raSaJ7pu6GT5lp2cbT5JFzcOk82opvI1/7O9nxMxE
 jmBVyjklhPUCNPKjSXMG1DA2mnH3ekNZ29BhxbQt842kAi65aqw/G/45xbn/FZFZ1P9y
 u3fBLbR1NMC6B/7HPk6u4NsOM8epQFR2MQLDknvss42kJanGgTKyTComgjunBrgtEWCh
 GXQp8s77sp4KdKbJHy4EFc4gbX8/GQVBTf4tyt6dAfrUHQiofqLyTMyU148/WD3v8Z/R
 cV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076032; x=1778680832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aiS5VPVZwmKd8FQ7cW6jsheyhp9wBNYj5aSAD9f/3t0=;
 b=eH+wSmzEn+x0OmzBzEMDgdZq5Szdsfrb8TY5Tn89wFLS7+rXEqkiZUn5a5laGa767B
 i9HAJ1+LuCbBVE9ZT6vAEMb7XIXyfq8Th+k5ozPqQEZm7q5YZwiT3Li5rLn/8xDgX/pm
 u1dqZ1BdjFLHLkHlsDWO93TuwE2Sfk4noYduDxREgVPRuEwW0WiLWPTurPAfnF9os41U
 OCYKYaBQ8oOQ4K8zEdHt1epPk5dcUqYQLKa03I76AFSVg8nimyWRTzdwrbWqwO1apFB9
 2B1k/oz5qJXuyAaIBgNscC+A9IFkqx4ekw29EYbA5K5nDRUKLYwX4e6imFWT5YBBErPs
 H6ng==
X-Gm-Message-State: AOJu0YzeS7jHx9SZHDsyeNvrAKYWdDWVBl9hmx9gHZx05xwxL9Q9T3Ri
 XaTJydrQbKb6dH18/csSZj/zhGTmP2HwHNcn0/u2HYssuvEolyy+FwLGY0RyLlLGTiSslfYfO4E
 u+KWW/UY=
X-Gm-Gg: AeBDiesrQh58PCZof/9v+8WCCUz/SLG9WMVEUeLnhLjT/Q5ycFuBf5eakD8RjXg/p2l
 uP043aUKTHtxiWJ7rlyIVHusBosmieVDq+YnttPiSEbei16m2Kjj/Hwpl9utaNopcWnh8bqeL7W
 4lL1PypDdZUQXX7hglm9XowOTBYWJQlJDuuShpaDZxIzJJdTz0vVdtCFlAD7hDFgvVoJgeGq6I2
 PlLphIx2HQmmH6EIaETIT3CXGvqQ/VgihRMgrIX/OFy0GebDSAhh8ynsvfP6UxtSH+INtxKroAe
 H9jLkXF7ZKRDRlS3xoyn6l1QNLjuPddy8i2rSGidTB59prS+cykKFBuhvKuXECa/lxyNtLnmNWU
 BKA7pr6xUWUyouSXzQZqif65E5GNRjbNzdZBloW/sW5WVjF/cocTidNoTO4HhKqRz8gM0yl3jk3
 DLt2qNQd6VvhceNRfy4lhB0Xqa46uYNxMnQQM0AZblWTFyS5qKS9WJc3NqA3BMVcIXUrcTsxfUx
 51RdYCeUE4=
X-Received: by 2002:a05:600c:47d6:b0:489:1cda:bbb7 with SMTP id
 5b1f17b1804b1-48e521d750fmr38309865e9.25.1778076031425; 
 Wed, 06 May 2026 07:00:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312de76sm17276255e9.21.2026.05.06.07.00.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:00:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 040/110] target/mips: Check alignment for microMIPS pre-R6
 LD/ST multiple
Date: Wed,  6 May 2026 15:54:12 +0200
Message-ID: <20260506135524.20617-41-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Pre-REL6 microMIPS requires alignment while REL6 microMIPS does not.
Use @default_tcg_memop_mask in gen_ldst_multiple(), it is set to
MO_UNALN for REL6 but MO_ALIGN for pre-REL6.

Fixes: 3c824109da0 ("target-mips: microMIPS ASE support")
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260417035734.32334-5-philmd@linaro.org>
---
 target/mips/tcg/micromips_translate.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index fb107eb91fe..da2419792eb 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -693,7 +693,7 @@ static void gen_ldst_multiple(DisasContext *ctx, uint32_t opc, int reglist,
                               int base, int16_t offset)
 {
     TCGv t0, t1;
-    MemOp mop = MO_UNALN;
+    MemOp mop = ctx->default_tcg_memop_mask;
     MemOpIdx oi;
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
-- 
2.53.0


