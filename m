Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C47DD7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfCM-0006xr-SR; Fri, 19 Dec 2025 13:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfCG-0006wb-JE
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:27:26 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfCF-0005Y6-7C
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:27:24 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so1620722f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 10:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766168840; x=1766773640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=80eIc4DjrOU7auVm5Rkv4MvDkt9/G8asUqt6MOnMzSQ=;
 b=mvrsahYNZQnyfbYQCngoMFx4UDW8ZOkqk0sMpd3Owg/BWPszQkI7QMgDc73NdPt790
 EoFKA7x7TSUu+aXumIRjG8jwSVDzdox5+Tk/P2JjX0YvtWOiimgB7+m9z0SsC4mjX91j
 kgjvNs1KsiJLkhU7TlhoHjcd7DCJ/MAl+p4U2cBDH/kaI6uUKEo9KUq9xvzASxsLOYKY
 YjAp2njyN23xZ6lW/Q3ZBe4R1OMmUZq0E2I3DoiWDMa6nI1VeqgOhrtRmei+uV81zLxw
 CAa5BTBzaKMBJQzKAO1mPZsEvfJTHwdnhQjERJCYYf482Vt4ZtRqYYphZXMAUaSq3ptq
 l69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766168840; x=1766773640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=80eIc4DjrOU7auVm5Rkv4MvDkt9/G8asUqt6MOnMzSQ=;
 b=bAGHkHeNda5gknFUdJ3Zxx5eJneNmE6SBi9NKUtZ9WOWk9SWq3FYDw8hLm/yZIh8bx
 VsRDuS5UfDlzW8HWt+iobUxd+OW4bzfJrxYJ4q0qiUd2XAm9fHn0BPVhbuCZikAprVe0
 Plxd0rDHLdZ2GEa/0aN1GNlGVuJOoECjy4gAI7spmwfNTvELxSfuwNiduJeVh8TqpeI3
 tqhJ91nfB2MPeSGsN2j/1C7hjjI/44SqsSkuNfYjzL7eRiLgoN+eERcVsnPOx3XOQYHc
 maousqrqZ5+/1X/nWmTgCZU8QGfL7jOvt668d4ZZLOtC2w78ZOPvTOYmaHk9VG4UBQZi
 uqvg==
X-Gm-Message-State: AOJu0YxH6zKcadsbzcainhESl/1JxKj2EP3WGgDhnfra8BKBl0HKqLTp
 f29OB+bNGB0brVADApmisPS123zWT+Q6rbWZJhdrjB7KdNLHezw2gfpoqrSmOhCQPYzeeiriMij
 9NVcEn5A=
X-Gm-Gg: AY/fxX7OZvI5kFoicZquwNkBKw1gMl4At7gpmgHEnacOu8cs2OmCJShqJ2JJo7ORVhP
 zzUNFxc76UJs9gUqyR4orP8daMiDPoFyftxQYITXwxetNE/AcJ7FTsjbS3kT+E6Y7h9Ej74B3z/
 5bZETvkZChnaeCRLFExSpgU8l+a4m0WqRNte67k4VyxQpIDm9RQysL+NRUBDFVT7aO1MhMt/sCh
 N8unsS/G20Nq+CSiJLPToAZ/1msIBpNJJSB8le3kuTIh7hFGO2HoYC1rx8r0HrsHMJgfszyzkGQ
 0t4POs07i4pOc216a24Ys54POVXZU6Xfn91wql/z2QCw0dGuXCijAOVFbdpDi37P/dzS2g13Uig
 6XPEYX0bQ9vAakJIpRIF4kp9LznEteHBomdm3j5BlmQQP1n8cZqPVO2ZMqeDcpLJrH1P6FBfMaf
 rPRLQAxgjhWlen/LQ7BSoWNJN4rAAW3zGPv+UdcJEJVIFSvs2chrz18XYBMPJw
X-Google-Smtp-Source: AGHT+IHnfD9pXy9t9B+OkXNqJkar+XYRRRDthXe4pad4h0Nr1f9/yPwtG5wUHWNHixUrqr2a4pYjdg==
X-Received: by 2002:a05:6000:400b:b0:430:f68f:ee97 with SMTP id
 ffacd0b85a97d-4324e4fd8fdmr4100405f8f.40.1766168840120; 
 Fri, 19 Dec 2025 10:27:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea8311fsm6235455f8f.28.2025.12.19.10.27.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 10:27:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] target/openrisc: Inline translator_ldl()
Date: Fri, 19 Dec 2025 19:27:03 +0100
Message-ID: <20251219182704.95564-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219182704.95564-1-philmd@linaro.org>
References: <20251219182704.95564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

translator_ldl() is defined in "exec/translator.h" as:

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> MO_BE
since we only build the OpenRISC targets as big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 6fa4d6cfa70..a6d550bbc2e 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1558,7 +1558,8 @@ static void openrisc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    uint32_t insn = translator_ldl(cpu_env(cs), &dc->base, dc->base.pc_next);
+    uint32_t insn = translator_ldl_end(cpu_env(cs), &dc->base,
+                                       dc->base.pc_next, MO_BE);
 
     if (!decode(dc, insn)) {
         gen_illegal_exception(dc);
-- 
2.52.0


