Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE382D148A0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdibt-0005Vv-LM; Thu, 08 Jan 2026 00:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibl-0005GB-HQ
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:53 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibj-0005MM-Lh
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:53 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7f0db5700b2so1621007b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850249; x=1768455049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oq6C1ngTyRjWGR4ozu5wSZGz3mAgcjt24Mtp3jaLWhw=;
 b=z7Q1vjpVVHMCzkqbraPiYkxNeNiC4SQkAlNkDM0C98QUhKgmmCjTNQ/UlwAuRNh32v
 cyVIvT01NepBlS2zR5ZgV82zZZvCYdFCYykeWz4bkCemHbUNwUgQq4RhPQZ6P+UHFG/S
 cMBk7/DqLqPorjRZrDw/60c89w4vMylDJySstbNVPKIKJ1Wp1nmmRPwMVGKJ3bKfzJl3
 RgfOke4z+dO9ra02lFBzppG71zWBZdTx2c1rtX2ZrhGBb+UJuMnpuAa7cZAWWlDBGYNC
 GwP296bK0NWj+mAUfaBxJIGZev+W2YIw2Z4hJ+ik0lOfnQ9lYNXOPyU+AAHQ1b+I9jzm
 OWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850249; x=1768455049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oq6C1ngTyRjWGR4ozu5wSZGz3mAgcjt24Mtp3jaLWhw=;
 b=Gyk4SvhmdZSNdCfirX5DnIoNQOicdKTBfQVjIb2S4lJVAAZDhttGEQUTTpItGrRAAD
 F3/ALPj2TG+J3J9jBO5urVxOzWrIwNtzXaJlQZNEfdkDSuLtUqKBgJx2DuU2fIQmtC4s
 3uAPe/823WNBeXI0KIWbBhizEV/4xqfsQAx25kZ9sUr+JPuZ19e/pZ19QPHarbS+GvCO
 OvjKhGUlVoDEsTyUTsH/nT5IX20x7GJoCCXrWZYuvQWjPMLjLJK+YDsh/bH7bcIkhl9i
 reNpzbFh2NeGEgCwBpydEqx3rjr7sColMjwjo3OvfofoRSrdGdUfPzQRdonYNftXM8uc
 dLOg==
X-Gm-Message-State: AOJu0Yw0KM1LAGqLq2mN8QBWPmNx1R0iP0Y6qq+rRFJtV6OsMGJcxCCu
 ZLz87FgG6qSIAk8DshGtCEx5y+vyjxhHk9SK19I9CawTLi2avIRiFJ8L7j1d6o78HcojWlntUC6
 g0jak6BU=
X-Gm-Gg: AY/fxX4dVzFPmG+rT2wX2g4OWNf6xr0SyhEkWsjM3Lj1mg2Kj96mLCJQf3967uRb1oY
 kI9951VVT1UAuqCHZ86ikiGq2vJ/XDfyH8pFiJmRFQgYjIqJ2k1639iF1yS0pVMJD8w35eLwEhl
 lA80VcZZc/9k81aHF98WWGdXpwwPSFMlEpr2JZJidOPODpXLi+b//0nsV00eU76iml85USoPd+M
 TVzgXPGQ+l++wgNBZP6DJOl66YhFvC0+2GkquKCGaoK1KgwWKZXe0b3e+vie3Itw3hNcnbsvS1P
 DqEvaakWSvc4u6uwuuQ7YX4EoCzcvRavtQXUwYYYxnb4GLpb6pUVGhGbixNz2nU3vs4rGyhDgK5
 UotVLAL6FijgooKoip6NrVZ8qEW4WlPupAhJtCapPBqTKsJyzd/sdfUwuW7hGHSvUFhhGGf/kHB
 E1SqEv+DkkGvcQ2+WWxQ==
X-Google-Smtp-Source: AGHT+IH09+2oc9jWUIYiucmJGoKDsUkI0TjD0+TRqJE0uiiDslrJbdn/6GSYVMuJD687V+4AqJklDQ==
X-Received: by 2002:a05:6a21:32a2:b0:366:14af:9bb7 with SMTP id
 adf61e73a8af0-3898fa087b6mr4469929637.65.1767850249226; 
 Wed, 07 Jan 2026 21:30:49 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/50] meson: Drop host_arch rename for mips64
Date: Thu,  8 Jan 2026 16:29:41 +1100
Message-ID: <20260108053018.626690-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

This requires renaming several directories:
tcg/mips, linux-user/include/host/mips, and
common-user/host/mips.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/include/host/{mips => mips64}/host-signal.h | 0
 tcg/{mips => mips64}/tcg-target-con-set.h              | 0
 tcg/{mips => mips64}/tcg-target-con-str.h              | 0
 tcg/{mips => mips64}/tcg-target-has.h                  | 0
 tcg/{mips => mips64}/tcg-target-mo.h                   | 0
 tcg/{mips => mips64}/tcg-target-reg-bits.h             | 0
 tcg/{mips => mips64}/tcg-target.h                      | 0
 MAINTAINERS                                            | 2 +-
 common-user/host/{mips => mips64}/safe-syscall.inc.S   | 0
 configure                                              | 8 +++-----
 meson.build                                            | 2 --
 tcg/{mips => mips64}/tcg-target-opc.h.inc              | 0
 tcg/{mips => mips64}/tcg-target.c.inc                  | 0
 13 files changed, 4 insertions(+), 8 deletions(-)
 rename linux-user/include/host/{mips => mips64}/host-signal.h (100%)
 rename tcg/{mips => mips64}/tcg-target-con-set.h (100%)
 rename tcg/{mips => mips64}/tcg-target-con-str.h (100%)
 rename tcg/{mips => mips64}/tcg-target-has.h (100%)
 rename tcg/{mips => mips64}/tcg-target-mo.h (100%)
 rename tcg/{mips => mips64}/tcg-target-reg-bits.h (100%)
 rename tcg/{mips => mips64}/tcg-target.h (100%)
 rename common-user/host/{mips => mips64}/safe-syscall.inc.S (100%)
 rename tcg/{mips => mips64}/tcg-target-opc.h.inc (100%)
 rename tcg/{mips => mips64}/tcg-target.c.inc (100%)

diff --git a/linux-user/include/host/mips/host-signal.h b/linux-user/include/host/mips64/host-signal.h
similarity index 100%
rename from linux-user/include/host/mips/host-signal.h
rename to linux-user/include/host/mips64/host-signal.h
diff --git a/tcg/mips/tcg-target-con-set.h b/tcg/mips64/tcg-target-con-set.h
similarity index 100%
rename from tcg/mips/tcg-target-con-set.h
rename to tcg/mips64/tcg-target-con-set.h
diff --git a/tcg/mips/tcg-target-con-str.h b/tcg/mips64/tcg-target-con-str.h
similarity index 100%
rename from tcg/mips/tcg-target-con-str.h
rename to tcg/mips64/tcg-target-con-str.h
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips64/tcg-target-has.h
similarity index 100%
rename from tcg/mips/tcg-target-has.h
rename to tcg/mips64/tcg-target-has.h
diff --git a/tcg/mips/tcg-target-mo.h b/tcg/mips64/tcg-target-mo.h
similarity index 100%
rename from tcg/mips/tcg-target-mo.h
rename to tcg/mips64/tcg-target-mo.h
diff --git a/tcg/mips/tcg-target-reg-bits.h b/tcg/mips64/tcg-target-reg-bits.h
similarity index 100%
rename from tcg/mips/tcg-target-reg-bits.h
rename to tcg/mips64/tcg-target-reg-bits.h
diff --git a/tcg/mips/tcg-target.h b/tcg/mips64/tcg-target.h
similarity index 100%
rename from tcg/mips/tcg-target.h
rename to tcg/mips64/tcg-target.h
diff --git a/MAINTAINERS b/MAINTAINERS
index cf7d2fba2f..4a79947ba3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4042,7 +4042,7 @@ R: Huacai Chen <chenhuacai@kernel.org>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Odd Fixes
-F: tcg/mips/
+F: tcg/mips64/
 
 PPC TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
diff --git a/common-user/host/mips/safe-syscall.inc.S b/common-user/host/mips64/safe-syscall.inc.S
similarity index 100%
rename from common-user/host/mips/safe-syscall.inc.S
rename to common-user/host/mips64/safe-syscall.inc.S
diff --git a/configure b/configure
index 846fab904e..fab9a45531 100755
--- a/configure
+++ b/configure
@@ -395,10 +395,8 @@ elif check_define _ARCH_PPC64 ; then
   else
     cpu="ppc64"
   fi
-elif check_define __mips__ ; then
-  if check_define __mips64 ; then
-    cpu="mips64"
-  fi
+elif check_define __mips64 ; then
+  cpu="mips64"
 elif check_define __s390__ ; then
   if check_define __s390x__ ; then
     cpu="s390x"
@@ -448,7 +446,7 @@ case "$cpu" in
 
   mips64*|mipsisa64*)
     cpu=mips64
-    host_arch=mips
+    host_arch=mips64
     linux_arch=mips
     ;;
 
diff --git a/meson.build b/meson.build
index f9fb76ece3..6896c7a64f 100644
--- a/meson.build
+++ b/meson.build
@@ -265,8 +265,6 @@ enable_modules = get_option('modules') \
 
 if cpu not in supported_cpus
   host_arch = 'unknown'
-elif cpu == 'mips64'
-  host_arch = 'mips'
 elif cpu in ['riscv32', 'riscv64']
   host_arch = 'riscv'
 else
diff --git a/tcg/mips/tcg-target-opc.h.inc b/tcg/mips64/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/mips/tcg-target-opc.h.inc
rename to tcg/mips64/tcg-target-opc.h.inc
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips64/tcg-target.c.inc
similarity index 100%
rename from tcg/mips/tcg-target.c.inc
rename to tcg/mips64/tcg-target.c.inc
-- 
2.43.0


