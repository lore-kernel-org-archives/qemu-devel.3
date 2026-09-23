Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F82C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 01:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Bv7-00034C-Gb; Tue, 22 Sep 2026 21:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x9Bv5-00033J-CC
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 21:37:11 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x9Bv3-0003CE-Qg
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 21:37:11 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-671563fb8beso388831d50.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 18:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790127429; x=1790732229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rHFFQLI2eSLiztok5hXJbXBwrgkdpzMl1QDGLvY5sUA=;
 b=G8qyrpVWuSwf6dloqeGMGO5q6dxyZDmJpSjL7pxNNkIYzC5pavST3X+B1GebBwGdLD
 +qzElNYRMV2B2TZCHes3i/PPBd4RNrqHLEuQ8ytvhJAQrX3LUOPuFkgAFm/WFqu5AzPa
 ckWa572iGB4IM8XG8SJtbU9EzVn0m1XCI+9Yw+RQSNQloPFqp+sU3+Au+bPEENQ72klc
 mGlWbJ6tHipP1aL7vRfnKRRZO9d7epJiYiVlgG84UyJarQMMGqhpBZAtq4ubZBGNnRBN
 2sGnKbXHiA3lsxiZzFq9hTtiNQeFppjIuxezYN0aHaWJUbBkS5nWBoibPbSZ+Qp8gJh4
 sXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790127429; x=1790732229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rHFFQLI2eSLiztok5hXJbXBwrgkdpzMl1QDGLvY5sUA=;
 b=2RG/dmyplxyFk6/Qoc8ApMql3jO5t9z/T4aCD9CiVs3JVDR314kO05YdKIBB5HnUZ3
 FSnabOPzayXmFpkeSoh3QHTyaKJGw8PmBmij9pUG98UD05NMjkkDVrjidxfbnjLhYTfz
 W/7/Re1bg++8GmveamMk/RIQpixsRu2PyQHLWzj1V6a7HsTFKSJ8S7BmrhRttA1TXk9b
 VwNJAr/LcE7FG+Do1iSWSGwy2YWaYMgVbVaBV3byiHOqXZ6Cguh9/8J9k9iHEuAiQD9H
 I6xTaJ2syb+LPDb5RLiGWOr3pw2U36DkNwqND/iYu7bI7S1C1567i7ZVpYbQJ3RyM4sS
 HoIA==
X-Gm-Message-State: AFuF++mx6meFTpH7eOL7Ah5DJb6olAiQlM+BlU0JFj209bNFFlo+uCtO
 djZCBJhE3WBmxOZonmQmkPwMrzFT5SwQ2B1pbiO5spkK0Id/YzHZ4OIu5+1z1cJ6
X-Gm-Gg: AYBFou3pMsgfjshxIdyyi12OdgiJN1Z94iaethofeUJmG6/muelMHDk+xT/cBEwNCAr
 V4vuClavPrgvI+Px4l39Q7/5c5cjFx0ctKBt7t0jR9MWvMK47iZ81BZPfXmg9ppu/sxXyQApw5D
 ul8GVOdf8PaE+vVa+7R/cgeHn7u1awC64jD9SBqCNpwHuQW4WdcnQJUBlJoFUws3J3WHKmQx76P
 lOdGtuLQvTtFg91tqNjk2LECG30okOQxAcS8fR6EDLYZIfA5lTOTFLMWqAO7et4ifWc/8Z01jbz
 RapAb8RlSQemqVYybVo1yHs9T6F3SBJTap1mc+MtyAZH1XqlDatv4yox5hkzcjh8QmhsQ32UwwD
 JVahMkWFUNc92Emmjj3r0Ur5bwHXRin+F5ZA67CTtch7Rsyl41txLqb3MG4DdfCKqzTWykPDTgJ
 eDuadrnJ5o88NKqPxjOn7JqXAgVSG6gz+1ZMLTc0pIrhzXZRwuxSUiwUsIoSmBjPRtgk/z9k5vC
 BACz0COFg==
X-Received: by 2002:a05:690e:1550:10b0:671:2bb8:ceb0 with SMTP id
 956f58d0204a3-672d58ae57fmr604696d50.65.1790127428635; 
 Tue, 22 Sep 2026 18:37:08 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a466bc81a6sm4407187b3.46.2026.09.22.18.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 18:37:06 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Turner <mattst88@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH 2/3] linux-user/sh4: fix vdso CFA for rt_sigreturn frames
Date: Tue, 22 Sep 2026 21:36:59 -0400
Message-ID: <20260923013700.1505113-3-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923013700.1505113-1-mattst88@gmail.com>
References: <20260923013700.1505113-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=mattst88@gmail.com; helo=mail-yx2-x11.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

The unwinder looks up a return address as IP - 1 (hence the nop before
sigreturn_region_start). For a frame returning to __kernel_rt_sigreturn
that is the last byte of __kernel_sigreturn, which still has the
sigreturn CFA, so the rt_sigreturn frame is unwound with the wrong
sigcontext offset. _Unwind_Backtrace() from an SA_SIGINFO handler stops
after three frames.

Add a nop after .cfi_def_cfa_offset, as linux-user/i386/vdso.S does.

Fixes: 975bd51a88 ("linux-user/sh4: add VDSO support for sh4 and sh4eb")
Cc: qemu-stable@nongnu.org
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/sh4/vdso-be.so | Bin 2720 -> 2720 bytes
 linux-user/sh4/vdso-le.so | Bin 2720 -> 2720 bytes
 linux-user/sh4/vdso.S     |   3 ++-
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/sh4/vdso-be.so b/linux-user/sh4/vdso-be.so
index bc1fb37e1089b7aa5612da0039e24193b156b3d8..df9fa22efab46bffbb9957af078199639998ea43 100755
GIT binary patch
delta 94
zcmZ1=x<GWo6OqVuQt#KSJ9B!^(@jmb3bB#wuObyE{&>##V)FyW-As%sljpE_2{CX^
vW<4yRzzu^8YbPf%icjWeeZcr*@(0#@#ut+l*u2^Nd@N1<oHuV|d(R92IA0@3

delta 94
zcmZ1=x<GWo6Op!OLQF3#0+d8#l(nNCM8CN5&G7ofAI}+|ZGOPGn~70r@*EZ~p~<X=
u1r)epkYOzY=j232@yYzG4;a5q{=k~g_-t|ln>SlhXr*UW(&mk9@0kI)8X|`P

diff --git a/linux-user/sh4/vdso-le.so b/linux-user/sh4/vdso-le.so
index c1ff560cc165413d7b07aa873225bd92afb8569e..decd674202260f045b646b318ebb0b6daf416651 100755
GIT binary patch
delta 93
zcmZ1=x<GWo6Olh5saKn)T)*7)W8rK!`{(^j`F=Z0{PBeG#pb(=yO|hOCeLK?735@K
uoh)#eTLA{wPEKSLoy^1ffbqxVx2*Y$FDA#b`LUHn_<IEVZ{EoEo*4j_?<GY5

delta 93
zcmZ1=x<GWo6Op|ikGEYj60C8&_)xA>#wX*~i%pXz{&>RpZ1Y{l-As&1lV`H{3bIZX
uILxg8gKHT$CnqwBPUc~K!1!(QTh@HWXOm;u{Md{<Esc#+H*aKn&kO)kh$G_w

diff --git a/linux-user/sh4/vdso.S b/linux-user/sh4/vdso.S
index 1faa665774..290eb498ae 100644
--- a/linux-user/sh4/vdso.S
+++ b/linux-user/sh4/vdso.S
@@ -141,8 +141,9 @@ __kernel_sigreturn:
 	sigreturn_tramp __NR_sigreturn
 endf __kernel_sigreturn
 
-	/* Update CFA base for the rt_sigreturn frame layout. */
+	/* rt_sigreturn frame layout; nop for the same reason as above. */
 	.cfi_def_cfa_offset	RT_SIGFRAME_SC_OFFSET
+	nop
 
 __kernel_rt_sigreturn:
 	sigreturn_tramp __NR_rt_sigreturn
-- 
2.54.0


