Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08386606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h28Lgiao
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTT-0003mM-Ad; Fri, 30 Oct 2026 09:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSu-0002ls-On
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:20 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSr-0005WJ-EC
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:15 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4af173320f9so558329b6e.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366167; x=1793970967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sHlhV1ZqXIbzro91dvfRRIbXHqg/uhhPXyMLjbkNVnQ=;
 b=h28LgiaoarJ+lkZLQQGz8FtqdiuB+JXymfYB5x4xHzS2YbvQ3vzoTEl4k1h7QRMRbF
 0FTOzUMfErZviQ40vtZuMiHQGyt9amitn0o5m6xmMYPCNgMJh2LZH9lCIqOeP86DRa9X
 qpHdMwTFnAc8Rwxd60egWyUYifyPfjfZD5poDIj5ni/3474ou0djFxIZJlB/NV219qD/
 pvuXZM2Cnq6ZrZgu6G3Q/MjL9A0JjOh1iGYORJVoCu2z0d9T0XBz4DN0flc0GrPgJ7XF
 g5yWeOwr/AEQpTywSW5QRQOAuHaJ+kz9FhzP5s4Ac8syBXL0PUul1nvru29hP5W89D8T
 3IFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366167; x=1793970967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sHlhV1ZqXIbzro91dvfRRIbXHqg/uhhPXyMLjbkNVnQ=;
 b=Pe+C4XTgRqKa/+UgADEv58K2xeJUyxekhkSbBjgpRXNg2XRqvKO+K2Tk7QYko70Fpw
 2GxoylzI1nLWkMd7nK0udxqja7hOFBAMVWuaU5w+pw7X1gXBldG2Ez8uO6gflAahdvXx
 hvuZs8w9PnSINWP0KdZW8tmvb2wWEyNdn9ZBW2pWeiaP9Sl6Lvu4ssCn8HRY4LhZ+FCW
 ZtM6+nPP/nHGHETosSCqb7fYpnzXeJXtwNxX4MxhTf9W5mKz3JxtbYNpRfg0nxvN7uKV
 xtj5Nt8sN5Z3nexwvT6ZwexEzjJ5trb0tgEawICIxPOUWOWOe9ZSi126OI5j6vt0evKM
 HiBg==
X-Gm-Message-State: AFq9FYJJFc7LI3hRiX6mXy747QVeUrJbWou/OnprjEaVICUEurp46x3y
 4WhMz3/g+hKSzvqE4FDylukm/mUcJdLfH6x+4kgLL0bYtGMaPQuPw6kIEVGVFxuTGG+mmZbuiAU
 QBvTI
X-Gm-Gg: AYBFou1nP6zdxn3XKE0vJwZIFb4bh8j9xNqA0ZZX+GGcyrZB7/Yf6lzWpU3ib4iZbYg
 3hrilLhlehKf/TmtKgN3jvGq9Mh0J5++OduR2rwXtq/mnqHtiUWSfTds7nKOFs8fBaMxIaQpPSr
 /s2Nran+jpBgwl9W6XqeXBKYpqV6ogZYmm4w37Jzhv5lj0xZDZdNr+SlgcEds2HgD7InxiwzJVr
 nGfqtkokhFzuq+0+WekqL+QMWJDOzhqBya0FrOI1uwbdvxADQ6L5/1NtLWpZ9c02bRGE4nZ6BRi
 4r/mcL3U2pjr73mdE4wQp+6SfktzuMN4eqzB0hMeQxD9jarcyRG8EmYDn04aYgaBJid7v2BOT9T
 wUwU4G/wZ3C6NGJxHB8UYogQrYiWmNuQ3mzXhK4hQMp55UssJ1Z1Dy4yH22sxAGmkWjApwRNSxk
 SQr6NYGWwgc6mWy/RrRTHDU/ThhUKZShwcrqPG6AZnK5LClZ6H+uuowc0TJjuLvfeOVF3nsa8cj
 q+4YamZmj16xliu31aMqwZvC7YnrrfDLOlLpUWhLbRAW7un5SpAgkjK9/LGNYnHLCbQIVgXeBDc
 CsaPZG9yAG0wHL377OgM+2zLV6fXEA==
X-Received: by 2002:a05:6808:1585:b0:4d6:2545:b12a with SMTP id
 5614622812f47-5640de05bc0mr1559805b6e.26.1793366167228; 
 Fri, 30 Oct 2026 06:16:07 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:16:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 12/19] target/i386: Use tcg_gen_lea_tl in gen_lea_modrm_1
Date: Fri, 30 Oct 2026 08:15:47 -0500
Message-ID: <20261030131554.41208-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index dd417cb534..5199c330ac 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1698,31 +1698,32 @@ static TCGv gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
 /* Compute the address, with a minimum number of TCG ops.  */
 static TCGv gen_lea_modrm_1(DisasContext *s, AddressParts a, bool is_vsib)
 {
-    TCGv ea = NULL;
+    TCGv ea = (a.base >= 0 ? cpu_regs[a.base] : NULL);
 
     if (a.index >= 0 && !is_vsib) {
+        TCGv index = cpu_regs[a.index];
+
+        if (ea) {
+            tcg_gen_lea_tl(s->A0, ea, index, a.scale, a.disp);
+            return s->A0;
+        }
         if (a.scale == 0) {
-            ea = cpu_regs[a.index];
+            ea = index;
         } else {
-            tcg_gen_shli_tl(s->A0, cpu_regs[a.index], a.scale);
+            tcg_gen_shli_tl(s->A0, index, a.scale);
             ea = s->A0;
         }
-        if (a.base >= 0) {
-            tcg_gen_add_tl(s->A0, ea, cpu_regs[a.base]);
-            ea = s->A0;
-        }
-    } else if (a.base >= 0) {
-        ea = cpu_regs[a.base];
-    }
-    if (!ea) {
+    } else if (!ea) {
         if (tb_cflags(s->base.tb) & CF_PCREL && a.base == -2) {
             /* With cpu_eip ~= pc_save, the expression is pc-relative. */
             tcg_gen_addi_tl(s->A0, cpu_eip, a.disp - s->pc_save);
         } else {
             tcg_gen_movi_tl(s->A0, a.disp);
         }
-        ea = s->A0;
-    } else if (a.disp != 0) {
+        return s->A0;
+    }
+
+    if (a.disp != 0) {
         tcg_gen_addi_tl(s->A0, ea, a.disp);
         ea = s->A0;
     }
-- 
2.53.0


