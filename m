Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4197ECFD626
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTHB-0000bk-MN; Wed, 07 Jan 2026 08:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTH8-0000ae-BY
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:08:34 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTH6-0008O6-KF
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:08:34 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42fb03c3cf2so1116059f8f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791311; x=1768396111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxF+PzZ1QlzvGpjebmovb1a8ovPqD1CmKjnHZwd0lKI=;
 b=QuzC6gLUcup6xLFLTGyd4sDM4vh5xFzokzy6TsPXwm6fHHeshisoiBar93XoiShdlY
 cpS2I0kLdcHHPZCU4wu71G7HUxeDUbL69CQySSqWCRjgCiORKD5hx6+crhtaTW0ym+rS
 4DHBnC4a7ClmkVX4yCeIKrd9FR4AG+9jCv7iAW1OTHI7a5Ytdx1+csTLMy0514DHL5Zj
 FVTSU0J6i4BdsSjvs0tXq/cBrq7lKr648lkDMx/TaMb1bLvmhA+gM+SeaLSjrC2McQJI
 T+k7dX1Nutz8OxbvKZJogsmzI+RpG7pF6rnJjHZngwkttSPKLAUn6BnX9MoVHqF7zFpe
 JlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791311; x=1768396111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZxF+PzZ1QlzvGpjebmovb1a8ovPqD1CmKjnHZwd0lKI=;
 b=n4qMHbtkg58JUZWV3F7Dl8kT+K85Z9CMLMPoJhoP5zkP/GSgTeGk7IOJT1tmTBAkxc
 W/1O5SKpzhUYxT0FngTAiwsM3i25pr0CRn4888miHJT8URm+LyYMRolZy+XxT3Fu3xCr
 YH5hRvMOKqjp6gsMym2JSk+DMDI04UxolDfgzDN+A2wgpg5XQItEUgxWkoGHB6ghKNN2
 XDYpjyoqwhSJQ3bId3hO6DTZHZBi26Ym+zoEgOFG0scbwvcDeQg+mOjJ4YzgeNKZtiwz
 2FRGJ/wIzf85j9hNio51uwuj1VlYDHDdkWeZZ8YXyCKci/eh/g1wOAcUgW0Wqyg6tLRE
 HRJg==
X-Gm-Message-State: AOJu0YzCtH/FTlSwwoCaPryU4iPN7RlznRtEeVCvHqOw9pzYhOYHqyua
 QimkH9VlH3IMfOUtllCpj8rWullm0XalV+QbNXqaIM3Zqd93tT8ofukp1Lm75/TG09TZyN1HbkM
 Pi83KSDY=
X-Gm-Gg: AY/fxX5hQwm+Nr0fNMaCJUb7+sGaLydDrQiQvv9T2qCXSgVXu4maBUZpMx6tjYb7JoD
 cmK+wyx32a6m2KP9JQVNJX0thHmLgCH7QObYeiS2SHeA7FvFaZNhV8SQp8xeFSXSX4ZBOnVaUBc
 qqvnz3BaWQG/tWQlP0/sYdS9e9Ehj52ADeO0SWRXQHmrjtMjsAX3MazACjZm/SY012So30dliXI
 nbcPmtMbxtnIslHCqopkkhKqY1RqMwtS3lq+wNyKnJPP+gh1Mpx/pqOxCWTlzAOowmxJ+ZZ0jC5
 +Z1Gg8nTSs7S+v6ylRht7ev9W7ZwciiBcfa33oRY1iv7o1TjP3bFUrChLtYTUESMItosrIzP/cF
 cdD4diE0C8It85omVX5gzX18R8p/i6tTsDwk6qSKd/Qn1odZNOz88FpHM3FL7TLYMLGUr8InCP+
 P+pt0jswXhT6U14U70MPg8i3l5pnOQJZ8iQfKg1GOad7IaMMwuFdiG/V8jhiI3
X-Google-Smtp-Source: AGHT+IF10Z+LS6NjB/XcznWOvxPeoNqQGuw7Xz7MA9StnCBML/X/tVBTA9TnB0YxQXOJ16buk07PoQ==
X-Received: by 2002:a05:6000:2909:b0:431:a50:6ead with SMTP id
 ffacd0b85a97d-432c36340eemr3649045f8f.20.1767791310619; 
 Wed, 07 Jan 2026 05:08:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e180csm10094151f8f.10.2026.01.07.05.08.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:08:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 03/18] target/s390x: Use vaddr for $pc in get_next_pc()
Date: Wed,  7 Jan 2026 14:07:51 +0100
Message-ID: <20260107130807.69870-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

DisasContextBase::pc_next is of vaddr type.
Since translator_lduw_end() returns a uint16_t,
also use that type for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index e38607ee18c..540c5a569c0 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6405,10 +6405,9 @@ static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
     tcg_gen_insn_start(dc->base.pc_next, dc->cc_op, 0);
 }
 
-static target_ulong get_next_pc(CPUS390XState *env, DisasContext *s,
-                                uint64_t pc)
+static vaddr get_next_pc(CPUS390XState *env, DisasContext *s, vaddr pc)
 {
-    uint64_t insn = translator_lduw_end(env, &s->base, pc, MO_BE);
+    uint16_t insn = translator_lduw_end(env, &s->base, pc, MO_BE);
 
     return pc + get_ilen((insn >> 8) & 0xff);
 }
-- 
2.52.0


