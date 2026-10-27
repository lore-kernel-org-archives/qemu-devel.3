Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3AB606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nsXtt10U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLagk-0002nR-Kl; Tue, 27 Oct 2026 02:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagY-0002MW-QJ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:29 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagW-0008Cy-Qt
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:26 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ace9e6e1a5so375298a91.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082563; x=1793687363; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IZihB7hgp8DFN+EGoFV6SItgOtKWC0iVgI7691uXaCc=;
 b=nsXtt10U7r0WQ5qnhqLL1XFesCTQhnBAA5BNnqdYmbHiH2VXHgTPbKSGcIkAOb5A3N
 gdHBNXfJ07h4m7r9IoQ5SulZCdNJ7lSpHTnKx7x0mjhWDy1Tu64iLKJGh8jWzB3ffS2J
 /XDqpGgsnjOCsMM2QQN3ZQ+B25o4QbomkDdw+dMGUdaVLc30XOlmSjxsVP2sZY0gDB1V
 0SPTvMhpq3ZXjf0xHeCeU1AKulacbxh1D0eKqwEO9/4gXXFb67j8CjEaMqf9sIAG8h5o
 0jnfsvQ6r3UOdgmF9awhOe+6ojNcACVjPxGFh5JlMLfKGgmg+nFT86vl56DPJtK3IkiX
 qjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082563; x=1793687363;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IZihB7hgp8DFN+EGoFV6SItgOtKWC0iVgI7691uXaCc=;
 b=MrklhR1+mNUQcZNf+SMhdre1t3n4hdsUpNDvT0mZS0zAO961UKWqfv+6JiKdhefX7A
 6Yw/W8J0e4xHs3iRHNLEGmne+nwszYj7kfJKjvGFrp4K51fcjW2c80ebJ/GNWV44dSjt
 ewpIOnqF1kS0w+hpSu48mAojfQeazaHDKlUpKh8RCxl64iq4lrXX92c5oXNGbu1MtEpn
 HyuH6Yfq73KQbOPWk0CAFGggZCk73t4kynSx4aULhjRBRy1CpybgrCRfmCzTWgEonUkf
 uc1Wz7eSo56o3B28etuTL9aqhgh4ZemTPNb0ZnVmrSxQdABtjiPr5xz5zOkATzr88lNg
 jbfw==
X-Gm-Message-State: AFq9FYKMjATJvdCcfI0oHVaqQZ8M6z1di5VQiqBsGPU8Rp4WtTAyi2BL
 Lx/WakJMk9xuDwdZQSMlmaMlYhx/3Rfpur76ya6POdkgysVYg81dOcZ3JmuKrg==
X-Gm-Gg: AYBFou0jIMlbXWeosYpITg+bwLRv3w3H+DwPmZWy4lpLFRHIHv1DSxNkQ/jHRk+6Udx
 WZdwPLrPSOPoith2IpyushHm017MBBdqWSBM98iVbdNufiwvtXfJY6SUMIkJlA/FOLKPeWW2pGf
 23b47Ipwgq8Oeu8rtREwiZzE/nIUnySPkdE6LG6XIK0S03Nfp/8cdCPjm6WY7ItFAs/af5uy63W
 MDugunlYtbgj++tw92pFVJIYf3hU1rc5pIrV4pmh3bMx17dJ8Kme90PJ0vN6HDaduR9WzQ37OVf
 9U9y7PuSP6ZgxME8ytQUdjLZrX/rjEGiZoNV5wxy/+OanBbd+/vAbgMYZ5iSpN8JcosD+2bwMmP
 3PRMmaz3bCGXxjSWKMzBizHm9Z+TN1Gx+LhKg0e+/otdBw+qdjUi9KWivKP6UVuglJlEhyWo2D2
 XVckjp0gBATWQt70s108h4GLL1u/XKv5j/u81Y/umPT4eiOorgkzRbgz/K8qaViK1MeqShdwLVG
 UNc6ix4XErqJC9Bx2NJoRqNGK0zXWQsCxGo5lg2aXYMkO6yWHl8oRIOgaE0mRkmxJTb18rtsA==
X-Received: by 2002:a17:90b:4f84:b0:3a7:a3c8:8f4a with SMTP id
 98e67ed59e1d1-3ae402841b1mr976930a91.18.1793082563297; 
 Mon, 26 Oct 2026 23:29:23 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:22 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 18/29] docs: Move RISC-V 'Z' CPU properties section to removed
 features
Date: Tue, 27 Oct 2026 16:27:57 +1000
Message-ID: <20261027062808.1995205-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

RISC-V 'Z' CPU properties were removed in commit 455c0fa9eef,
for the release v10.1.0. Move the corresponding section from
deprecated.rst to removed-features.rst, adjusting the wording
accordingly.

Fixes: 455c0fa9eef ("target/riscv: remove capital 'Z' CPU properties")
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261020075927.56983-1-philmd@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/about/deprecated.rst       | 24 ------------------------
 docs/about/removed-features.rst |  7 +++++++
 2 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 153fe118151c..dab47b6ca38b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -362,30 +362,6 @@ the addition of volatile memory support, it is now necessary to distinguish
 between persistent and volatile memory backends.  As such, memdev is deprecated
 in favor of persistent-memdev.
 
-
-RISC-V CPU properties which start with capital 'Z' (since 8.2)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-All RISC-V CPU properties which start with capital 'Z' are being deprecated
-starting in 8.2. The reason is that they were wrongly added with capital 'Z'
-in the past. CPU properties were later added with lower-case names, which
-is the format we want to use from now on.
-
-Users which try to use these deprecated properties will receive a warning
-recommending to switch to their stable counterparts:
-
-- "Zifencei" should be replaced with "zifencei"
-- "Zicsr" should be replaced with "zicsr"
-- "Zihintntl" should be replaced with "zihintntl"
-- "Zihintpause" should be replaced with "zihintpause"
-- "Zawrs" should be replaced with "zawrs"
-- "Zfa" should be replaced with "zfa"
-- "Zfh" should be replaced with "zfh"
-- "Zfhmin" should be replaced with "zfhmin"
-- "Zve32f" should be replaced with "zve32f"
-- "Zve64f" should be replaced with "zve64f"
-- "Zve64d" should be replaced with "zve64d"
-
 Block device options
 ''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 6a9944a0c794..225841bd9bb9 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1038,6 +1038,13 @@ initial RISC-V QEMU port. Its usage was always been unclear: users don't know
 what to expect from a CPU called 'any', and in fact the CPU does not do anything
 special that isn't already done by the default CPUs rv32/rv64.
 
+RISC-V CPU properties which start with capital 'Z' (removed in 10.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+All RISC-V CPU properties which start with capital 'Z' have been removed.
+They were wrongly added with capital 'Z' in the past. CPU properties
+with lower-case names are used instead.
+
 Power8E and Power8NVL CPUs (removed in 11.1)
 ''''''''''''''''''''''''''''''''''''''''''''
 
-- 
2.55.0


