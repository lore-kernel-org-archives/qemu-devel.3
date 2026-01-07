Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAF6CFD629
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTHs-0001WO-2v; Wed, 07 Jan 2026 08:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTHU-0000rY-M0
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:08:58 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTHS-0008QL-0M
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:08:56 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so21697335e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791331; x=1768396131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuQHI+q1gbkBJnpX6BDTg6s0HDV4CInGXFHR6psqb1Q=;
 b=Qf37ONiPM3jDGYICrVHK8ApQu7dZTw7C48Hc3e4wiex2cOajD10E1fK2PMOzLC+lKF
 Ke/1lkh6NIpRnaEkHPZmLWEa82kC1ydpGOxdEOkrOqR+1I/A+rVzSuaun1dslF6E4pym
 hGtDxMbz6JFKmsriDAJ0l7Qof7yVWgRGL14ISEYRFdI3IT/za7hQhFyHAxFkAovzQD/D
 FhmlMx4oI/dMAXU8thzL/e3f2I9U3x2PVF5vPKiD4HThat8jRpsxOzKKICh/mQ0cr2tK
 uyDQT1avgz1/hwL6+ThMcWBp9kUmK6bpIsRKnOzI6q2YWr4uET92JLcwMowaqdTGCI1N
 /7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791331; x=1768396131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kuQHI+q1gbkBJnpX6BDTg6s0HDV4CInGXFHR6psqb1Q=;
 b=GWLe9dXIWP/TRDvAaiJgFpHZlvPzkY1HDHxYJlA2QYWWg/fObzyr+rYPtKJs7ZK7Oq
 nEmRd6DyIWd2ZFQeereGkjy5fQi5SQly9zrLqTPhLLkrvpcljoF9ecAmPjMX33Uba5dC
 EZ6I5MGPVl/RqctXEbXTKa0awhSI+7b+zOYKB549ktAYxm76vrOcrrfDRYbKwiD4CIre
 YR22bnArJGLY+oraXzA4mouW353PjyJt5BI4qt4E9H9jywPoB9nHobl/kQZGMiiPPGt6
 sujpclOhSeKTO2nAPVblSWsmxSIKjIKwWueOFcd0HYZvCsl7a5ueribHHrq7IwnHqMMl
 WDPw==
X-Gm-Message-State: AOJu0YyaLteeQJsC1e+RzOaC3ihpWxSko8q8DJMZxxKwc0Z8/7mEiyZV
 vQyiAG9oYAgQrfkzJ6HfPXm9catJ8WOMXaFH02kw0Fh0AiI0RB+E3pbgVWdHkSSrzIAmBPq0/gS
 ztr5NhSI=
X-Gm-Gg: AY/fxX7Rr+zz9oCsLsrFiFtvZcdI8PsS9p5A1ZDvupeyiiVXLNeqSU0aoU+lf+8dc2S
 YJnZRI2Z3TOhQe8EltXPRlWvas9oD7P7Ou1OhH6N2V3lVtOb+d9nFIcMkHI8JHHhbMcJPcQ2YcS
 qDyRseq4644fDhLutGQCQ2nlrIbx/yAuIcULIXIobAx2Dqx0XpYSq8dpScAZtgvFm0A/SvQWx8o
 u8P55RiGAgNYHmxn/xSroQTVX9HzJgSBPXeI3Ni8ZNDfQeBjWrqUiuX0ZhcaRUYydcyVburI3yT
 NJLhvRoHe4FO5otZLAUyaIo9bqsPr/LxvnG0YOQRh35HOQCsQRoXNCcILMGjaaWTLtfakgYLFq+
 ZIK9JLFS9aWUnQk2Pgn0LfYuxt4YW2LhON4x9lZq2eotjL9Cf3G/36D6wAVNCrWAGQjeTqkNP1O
 x1SXvdg5jx9puE3PEvAuzysDMQFKD+ez/ED8L/6/3+qRKiDGkvTQHWdp3V4vXk
X-Google-Smtp-Source: AGHT+IHSptVLu7l8uBZB+TJMhzP3+3+lzGXD0gW0SaDYo5AJyAg81fDNffclOvt093Z+icB0Co1AwQ==
X-Received: by 2002:a05:600c:4e86:b0:477:9574:d641 with SMTP id
 5b1f17b1804b1-47d84b3281fmr27619445e9.22.1767791331436; 
 Wed, 07 Jan 2026 05:08:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d86637b90sm14109815e9.2.2026.01.07.05.08.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:08:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH 06/18] target/s390x: Replace target_ulong -> hwaddr in
 get_phys_page_debug()
Date: Wed,  7 Jan 2026 14:07:54 +0100
Message-ID: <20260107130807.69870-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

mmu_translate() fills a hwaddr type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index a6c89ed0af3..59e1fd0c4fe 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -43,7 +43,7 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
 {
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
-    target_ulong raddr;
+    hwaddr raddr;
     int prot;
     uint64_t asc = env->psw.mask & PSW_MASK_ASC;
     uint64_t tec;
-- 
2.52.0


