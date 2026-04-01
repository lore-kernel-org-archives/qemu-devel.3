Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AD210FCAC9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8186-0006gh-No; Wed, 01 Apr 2026 15:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w8184-0006cb-0r
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:28 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w8181-00032f-55
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:27 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35da1af3e10so47706a91.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775071281; x=1775676081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqnRyG6zdU1ZH/l3FmD/wb66PtVxMf73YZ7rro8DuT0=;
 b=tEXDcgxuStCKb6kC+fHGwSVcEni8lTq8pjezx52iX7o6JhcVnv+lzeHzUZT876HOVc
 2eaz0cNBEUlib2fSqGotkFM2fqt9rxq27Di9IA63aN027dUZEJFHWcSPowVopJlBeKbV
 PeK9Dw6PpytlUmzxO6bbaDIf2gcE5HfuLrIpt1HjmNxXJHtOj4k2szXILG2fWKUrbD58
 djjEgGrKuNtrlgwZBKrosiBhnWoDurtgboZGoq6XreCpUZLNo4opnO24LjEF+KxwSKbW
 e7qSdOtiq4fHOjz4Q1qsmmq1ObRmHxeMt4Pm2UX1nt7T4SFJNbTZQjGoXSrpAa4uzQYW
 drsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775071281; x=1775676081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XqnRyG6zdU1ZH/l3FmD/wb66PtVxMf73YZ7rro8DuT0=;
 b=baiqyKPnivBvpMt1/y1XlZNFTv9/ky/x10ajbP26nQvxzbvOnG9mXURFKP0RNYeju9
 Dr3kQPLh8ypgbu3sCe9el9sMoE+oJ7A2q0GHukmblf78el1k7sKa1P+hG8SqFFhL9to8
 miGQhUvpHlaSzszI+sAtAQ/3w6U3tMOd1lbdqBwMvobLXbeiQomgMH0Ptf9N91oiAL68
 KxclvKUYn6PLS78Isja4dl71c2KaVnGrHctVRNP4nTIQmc0wmhmXCDIGl1XJhAw1utDn
 BJxi+whgsX1FAKIQjHgmO0mKroUUK1+6Wc+irxGA24MsdoxQeT2U+PKCX88I7eglLOFP
 VJNQ==
X-Gm-Message-State: AOJu0YyMUCVS5+s1p9sTobDEj1zifo7HftYt1aBbdJMIByu5CfGM/eP+
 1LqCLWfm5dHrmsCXQSGawOI0rMSEr3/lmDLYmQXLAgW9UkF0V5/buCx4IJLJMkOwPF/OI2Fqezg
 NeoyU+v32Dw==
X-Gm-Gg: ATEYQzwhO/w9bzUFjoGzhfP3Qzh5ueJvs1UhCTJof+HuwLqDjEvSICKo17hfwk07vqv
 U8TFtv7QNAcV3JxoVAT+b8l3F2CObBbFxGbxbnjAeO7YvrCjBmMexD8pEFHyMM/aRuE7IcHkfgr
 +AXDCbWDrGW0UZT+LBOPoRdakSkphc2mQ6jFo0l4StK3aKxEMDzInQjKPuTDyIz0+tlywRjwAa2
 h+6Wu5Xdya0rfnfJpIQ0an9vjmtX4xQ9imVi5KnT8wQKJ/TK9hDYGgQXrurUHLeE4wJygjJgf3+
 Qo5i1QADO9WsPHb9vEtXfEEDKAemi0lVVFiuVy7yA/joFLM7f8KIsWkNUB5+1g7u/nQlxei2xoQ
 dlKqVoPntWO6zVm1t1bdwZaf2qu4kklimgiWrVW7uLsoIF7jcsLa4ufDedaZM7TRGQ33KL9AUFd
 2BHoxJ+Ghfnb+6WgbE70ZsIua8CEXYOs7Zr1vDlIbagWsk8REyJZ0wM6kroT/0u1WP4FoovNm0A
 1Ep
X-Received: by 2002:a17:90b:2ec4:b0:34c:904a:d92 with SMTP id
 98e67ed59e1d1-35dc6fdd803mr4462580a91.26.1775071281103; 
 Wed, 01 Apr 2026 12:21:21 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe41b11fsm5633113a91.0.2026.04.01.12.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 12:21:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 10/12] target/arm/tcg/gengvec.c: make compilation unit
 common
Date: Wed,  1 Apr 2026 12:20:55 -0700
Message-ID: <20260401192057.1182724-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
References: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 1fa26670587..0740de92c1a 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -33,7 +33,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-  'gengvec.c',
   'translate.c',
   'm_helper.c',
   'mve_helper.c',
@@ -72,6 +71,7 @@ arm_common_system_ss.add(
   'cpregs-at.c',
   'debug.c',
   'hflags.c',
+  'gengvec.c',
   'neon_helper.c',
   'op_helper.c',
   'psci.c',
@@ -91,6 +91,7 @@ arm_user_ss.add(
   vfp_d,
   files(
   'debug.c',
+  'gengvec.c',
   'hflags.c',
   'neon_helper.c',
   'op_helper.c',
-- 
2.47.3


