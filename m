Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E81CE9D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9Rn-0003Ia-Lf; Tue, 06 Jan 2026 10:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9Rm-0003IS-He
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:14 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9Rk-0006Tb-Vj
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:14 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4327555464cso641737f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 07:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767715091; x=1768319891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O3ZOyyrZ+O3zgjlLHnoxYf+lt/LGps43wfGqI92W+nU=;
 b=zqZlQuR2M6DPRpw+NNJB65gyZ5+j6Iqj8UznTXqGIiPiSF7UMJg9GRG1usAs81hd08
 Ctj0Dq1tMENoS9OuCRuYHgM+KKQmkb0KxZdQXh+iYKfme6Eiv3jLMqUybFiTeul8F22O
 k8hWF6YIed254x6MPgouuGdp2kPmJ4IjhOBqGvuC0Acaj4hhE6iqXN7m+HLetPhEj64F
 07kelXx3/7ZENWvm49IO/N84u7550yq5xAjTqqOFWOsETJfWaGFkesBTMh/G/PjMzREp
 B1Vf6r2ELd+0GoFGQ0gBLAIVG0O0GFPRHepjGvAy/klelnshRzNZjWrzzQwLsB89hkCP
 4Udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767715091; x=1768319891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O3ZOyyrZ+O3zgjlLHnoxYf+lt/LGps43wfGqI92W+nU=;
 b=uhCVw3/ZhY+8oXFuQPcSrqJbHAKoy1AZBVI7KPkVVeb5PJfvb9P3+lNGTTGZHqAXuG
 h1R/+U4ztzoZWkXqHyZH/Y9bV5n9Oiw3X1jTfFSZYNvelhXbdqjZRcWqavivykBCByTy
 /mNVuX2sH50XB49/Fe6pKMGVZC2G/8lfX9Nv7+FjJm2fiUabgkasJ+51cTnduPJdNvMH
 7RZpkawWtEGvSdFrKfkTV/0FKfG2tCIfjHA5JjtU7ydYtq7RoXB/euAVbdxXfFdzUP8T
 c5+gEn4scwhbtPAsw8ZCiqEES60gv6MEMwkaw51PpjiLw1a8GAMSVRplHsIw2jIXS9dW
 Bv+Q==
X-Gm-Message-State: AOJu0Ywq9GaPisEpQBBsUFx2kRNPMEW1waK+RAGtVz2064lloN1Qecob
 4hsjbbib745NuKAhP8a+hfZ7vE34ts5Fm7qm3sh5XDbekYRbhfGKfdbmZH7fm9SYjjoocnGLOIU
 hO/4Zddg=
X-Gm-Gg: AY/fxX48nCk62jNWl9JiCCvGEU0cGOWagwL7zsScN2CTvJ4C+RW1YZ8RaNzrW+WYWjt
 EaGbe7/D6IVPuyMMcPOBBiu2MJPOJ033K+vCoAVsNeIRDkpdYHn4KbdAcrZgXm2kCtRGCu2E9D7
 REqJwh/zgUHR23WJ1R4dQf3uvc5OFqEXK+0dJmyoH1fwX9sIJFgXVvzaPnjuUX0fJ/9rk1lc0R0
 Ef0lsYATGF/DiDJKXwLapGscyKcZarZWFQ55LDH4lYrQVil6Eh6oRVolYvIaJ9kD1CBnS6H2xlR
 LIzfY1xT0OAOVtclrG5Ms16I/xpIVFTCLhA592Ljm8YNqF1F9G+BmNo/HdfOB5c6yOyKkNUUQLl
 SFEe8DtP6XQWJhfDXCzHivjfxbIv6gjR+lsym0kgYKqMdsX1twUyf0o7oHCkLMUXJKv3KhUdeIL
 +GXxpFh+oAsjN+9Ujn7FEZpB0VYB9WPBC3bk3Z7tMsaygIfKEuN1+8MAdafFtS
X-Google-Smtp-Source: AGHT+IEZ86I3WcEW/eKZMbQiX9Fc+OHHuEzEwEvc5KzfTW8G9rLRJ+YDP9TFcDEeEapQkZPdunuQ6w==
X-Received: by 2002:a05:6000:26cd:b0:430:feb3:f5bb with SMTP id
 ffacd0b85a97d-432bca5227fmr4838632f8f.60.1767715090978; 
 Tue, 06 Jan 2026 07:58:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e175csm5161993f8f.14.2026.01.06.07.58.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 07:58:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/8] target/alpha: Use explicit little-endian LD/ST API
Date: Tue,  6 Jan 2026 16:57:48 +0100
Message-ID: <20260106155755.53646-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106155755.53646-1-philmd@linaro.org>
References: <20260106155755.53646-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

The Alpha architecture uses little endianness. Directly
use the little-endian LD/ST API.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_le_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' target/alpha/);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index a9af52a928f..80542cb0665 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -214,17 +214,18 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
 
     pt = env->ptbr;
 
-    /* TODO: rather than using ldq_phys() to read the page table we should
+    /*
+     * TODO: rather than using ldq_phys_le() to read the page table we should
      * use address_space_ldq() so that we can handle the case when
      * the page table read gives a bus fault, rather than ignoring it.
-     * For the existing code the zero data that ldq_phys will return for
+     * For the existing code the zero data that ldq_phys_le will return for
      * an access to invalid memory will result in our treating the page
      * table as invalid, which may even be the right behaviour.
      */
 
     /* L1 page table read.  */
     index = (addr >> (TARGET_PAGE_BITS + 20)) & 0x3ff;
-    L1pte = ldq_phys(cs->as, pt + index*8);
+    L1pte = ldq_phys_le(cs->as, pt + index * 8);
 
     if (unlikely((L1pte & PTE_VALID) == 0)) {
         ret = MM_K_TNV;
@@ -237,7 +238,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
 
     /* L2 page table read.  */
     index = (addr >> (TARGET_PAGE_BITS + 10)) & 0x3ff;
-    L2pte = ldq_phys(cs->as, pt + index*8);
+    L2pte = ldq_phys_le(cs->as, pt + index * 8);
 
     if (unlikely((L2pte & PTE_VALID) == 0)) {
         ret = MM_K_TNV;
@@ -250,7 +251,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
 
     /* L3 page table read.  */
     index = (addr >> TARGET_PAGE_BITS) & 0x3ff;
-    L3pte = ldq_phys(cs->as, pt + index*8);
+    L3pte = ldq_phys_le(cs->as, pt + index * 8);
 
     phys = L3pte >> 32 << TARGET_PAGE_BITS;
     if (unlikely((L3pte & PTE_VALID) == 0)) {
-- 
2.52.0


