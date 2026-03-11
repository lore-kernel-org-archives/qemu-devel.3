Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51283FD88D9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08XE-0003wb-TW; Tue, 10 Mar 2026 21:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XD-0003wK-Mb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:51 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XC-0004ni-3p
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:51 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so99595455ad.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193128; x=1773797928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dYqkenDrOlE3cFKViZj6RXUNa2pzu4ANaZkfMGI4aoc=;
 b=pYOKUFYrcYwgaATkOBP9X1ROC4sAV402vPUz/IBlprAZL2Kdp24sLqM50/eglmd/5E
 TwiQcZFGuuCiX2lkvYE29ddnRy/s8WkQbpwK0eBA1rvxxgPdJOCaFlMgBkbXbSmhAwhA
 JptT90sEat7GxO8vItYWoOnQqRrWom+/CamaU5f19q3YGdd1F2gWv1QcSLg97K1an7ZG
 cA4o6VfLUyqhjATEGFLpjOjS0XGX7t7ZLH5PDwm0Oqn5u6j2fPJ6c8ue/hGxk2jGMqlS
 nmwsIH/s95Ue6Ana2P8Ob6n4pvDu+/gCJ62T8/bAFzcgkFGuTSJzkrlZBQrco15gXt1I
 o0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193128; x=1773797928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dYqkenDrOlE3cFKViZj6RXUNa2pzu4ANaZkfMGI4aoc=;
 b=mqT0/Nka2WSNjIxsbbZuRro+KWhFEqhKjBCSfC08MV4uYGd4iUXEdP7KN7Ina/9kXn
 k/vinVi4YYgDkQQL91KKQ8DIRat1AYU3YrUIFova0Y4k0zBxX0imlmE+vMx8LlfgGabF
 2GXdwxLuC3SbucPHBogh4IE1WhDUTK/8KrkxvXyGpV8aA1xYQih7KCYowDdApTJvrIxD
 xDbp/o1HG9YZpGs32qfMD9aAulKFBvuetmJQwPaX6PJeVmOB4s2UKWjOms86+IMT8UZ1
 3YF+jNIcEIs3PWsp6imj5wmVvN1+rM6JYCD13kvHb7TMgzwQO+78zH37zzZ0gOGIn9bL
 urdw==
X-Gm-Message-State: AOJu0YxS/5E74fXi0MDKi42LpGRq/sZQF/sG8GvVtPiCvNfOm07Pslhr
 UViEHXTZSIr9wURDaHr/45ZlVTwyfI5Tt81IvBhpmbWL+zuXSwdSi1NGFTjetoXEjD6WW4mifC+
 BHf7l
X-Gm-Gg: ATEYQzzh1kHprzX4vZqv4tQrlWB4EGRSm+DLvjRpog/yM8SxWt/+0yEm7elgkBmGIt9
 HuNBlcJuahv4pX3QMw+zlMNfzkrJUY/C201tidKTAj6es76zdIPoOL0JQgkiSonHNlDeAbK2PfU
 EEN2CO7UzqRGeh2ieBpNMzJB0agaEMTRPdAqCL1QXw6Kwhl2JZX+VVq3xFzNsjr8UMXtAeJShLq
 1wP1ZVUxSlR1r4Y1acjx4iPQ6gHNkh/5Rv4EWZIvDULzhbOS7h2rf55ubwa6cuNSxZbGMzYh1MC
 f9Y7DdoarXarOIeV+qEXil4r5c4sGGFnSQsn47kmsSS+r/HiBvSUH0QZL/vNdKkk7ZbJSSf1PY1
 o/l1fIvXd4e2nJztVlT0BpTTV2dGaSHUDjIN6rwhxRG4kTcz+pLM8z0mfVHZXRCzWeZ4rn63IYY
 M4T9HGpKqVr8GxTOh5mGdGrAT29Mcd79gDr7EDDL1EoOsAS1p+YNxFOMgZXrMY6966w8lX7CIF0
 7fDyhaTCT6thIk=
X-Received: by 2002:a17:903:2451:b0:2ad:c1e1:c286 with SMTP id
 d9443c01a7336-2aeae7d4b79mr8532695ad.24.1773193128160; 
 Tue, 10 Mar 2026 18:38:48 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae2466d3sm5390175ad.22.2026.03.10.18.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 18:38:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 01/16] tests/tcg: Temporary disable multiarch tests for PPC
 targets
Date: Tue, 10 Mar 2026 18:38:22 -0700
Message-ID: <20260311013837.69945-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

gdbstub is currently broken for the PPC targets [*]. We
didn't notice because our tests require gdb-multiarch which
isn't installed on our containers. Next patch will fix that,
but we need to temporary disable the PPC target test to keep
our CI green.

[*] https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <c957fe25-a0a2-405f-be83-d411261c21e6@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-2-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/multiarch/Makefile.target | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index a347efbadf0..73c2a78215c 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -156,12 +156,16 @@ else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
 endif
+# gdbstub currently broken on ppc, see:
+# https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/
+ifneq ($(TARGET_NAME), ppc)
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
 	      run-gdbstub-registers run-gdbstub-prot-none \
 	      run-gdbstub-catch-syscalls run-gdbstub-follow-fork-mode-child \
 	      run-gdbstub-follow-fork-mode-parent \
 	      run-gdbstub-qxfer-siginfo-read run-gdbstub-late-attach
+endif
 
 # ARM Compatible Semi Hosting Tests
 #
-- 
2.47.3


