Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B265FCD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt8M-000279-Ce; Mon, 08 Apr 2024 13:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8K-00026q-Oo
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:16 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8G-0003jY-PH
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:16 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-29e0229d6b5so3889745a91.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598610; x=1713203410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLzmDWgl8qUDWCq3D57/PwLyiFcPLxohH0NJBMBSEDg=;
 b=c9OolPn3B22rSeVbPk820E26xTJsb99TplPvozZx8Ca4oohmhh6dBr1HxfdEh99dv5
 5zdBSYjKHPjy6HyHq5xAmNqJ3fcnW0iRt3XsiVpDVaz4+hDlFhU/i77t/l0STesBOoaK
 gyS+AV+bfcBXjz/jYQofTdDFZjt60/Cvzf2dD8kdlS7fabU6Spnc5QeONliSKsxlFtB/
 xXx80PJ0slpAPV+MHJ1AYqeuR/RptMV0hVfcFsqie6MeYJfdnGjJ0lDEJvfQUlFDAwBX
 N6fCnqk5Yfgs9V2q3UeIquSI6b7Wegy60FCHNd8Qno2jYD4EjuWqI/sR2gkjhnAcN3oV
 sF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598610; x=1713203410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLzmDWgl8qUDWCq3D57/PwLyiFcPLxohH0NJBMBSEDg=;
 b=wg2pq+z2SuNskt35fegnSxQi6FifyAcjTm/8Vi6yupvu/OmfMQU3dpSn/XJUXIJlB9
 u/TLC8HokAxOP38wfBfaRSw2eLI1apOomgsFS5WJXItSSO+wGc1YzwKWIWbkLtCVoZ8T
 OqgXt3f9PSAza0/ep19i9fbu3fgnURC/9lAPTyvXkuNfYE0Y5KBd2a6CUMrzI8jpMrE8
 Jkq32lpEdN1qIBUDny+x20l5xf0po5dcQo9SeNSbdwlPfc2PjgsmHhxAcUEXBc63zxKz
 Xe8F+LdPRbsaC2Q8oZZ5CXhosX5MdXGaSmgLwvOWTRMP9+kC8SUML6smPx08mP8Etr4O
 se4w==
X-Gm-Message-State: AOJu0YyKyugeJHGzuSwtRV8ky9/0JQ7UvwvUh+i9B5DzVfZCt1d/enS5
 gOLTKXetPFFbnZmJjVlN0pXC2AcvgZuXKGe/pBZKs29iieG55g+kZXMlKDqe8iQp8tUQhDpqY47
 B
X-Google-Smtp-Source: AGHT+IElBetL066uhjs8ZPDx/ZpOcjL8/KI/mqZiWa6PQ8roRc/dU3J8AiP7xiUx6Yjukj/vyUL9GQ==
X-Received: by 2002:a17:90b:3ecb:b0:29f:7672:7fee with SMTP id
 rm11-20020a17090b3ecb00b0029f76727feemr8845985pjb.31.1712598610243; 
 Mon, 08 Apr 2024 10:50:10 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:50:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/35] target/s390x: Use insn_start from DisasContextBase
Date: Mon,  8 Apr 2024 07:49:20 -1000
Message-Id: <20240408174929.862917-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 57b7db1ee9..90a74ee795 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -141,7 +141,6 @@ struct DisasFields {
 struct DisasContext {
     DisasContextBase base;
     const DisasInsn *insn;
-    TCGOp *insn_start;
     DisasFields fields;
     uint64_t ex_value;
     /*
@@ -6314,7 +6313,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     insn = extract_insn(env, s);
 
     /* Update insn_start now that we know the ILEN.  */
-    tcg_set_insn_start_param(s->insn_start, 2, s->ilen);
+    tcg_set_insn_start_param(s->base.insn_start, 2, s->ilen);
 
     /* Not found means unimplemented/illegal opcode.  */
     if (insn == NULL) {
@@ -6468,7 +6467,6 @@ static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 
     /* Delay the set of ilen until we've read the insn. */
     tcg_gen_insn_start(dc->base.pc_next, dc->cc_op, 0);
-    dc->insn_start = tcg_last_op();
 }
 
 static target_ulong get_next_pc(CPUS390XState *env, DisasContext *s,
-- 
2.34.1


