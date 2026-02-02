Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C362CE7FDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 23:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn3cX-0005aq-EZ; Mon, 02 Feb 2026 18:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3cW-0005aP-1U
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:46:16 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3cU-0004uS-Gm
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:46:15 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so4106622f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 15:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770075973; x=1770680773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xBbXyS5fYaMQMQgGnrQEP9mxFnEIUHqcktwDF9spmuU=;
 b=PilkQ25e3faKcSNkIhE3nLcAGZjmIJKiFau618MFAKak8DDQMazCMH48ZtNzEC4E6i
 VwTo+UxQX77rs/Iy/kAPMXBgLIqYGIGSjgDriDcl1jELkGbHHnDEZcaRzoKcMcIdFBwd
 qulvxwxW2gOQacgnehNKBu5t1ZnnWvBkr2tBjbFcUlR6MFuCcALlrABAA7cB8ax6Ol3l
 tpv7D3tCC7mImLPA4ULiMUPuGZc7L83W5huAIHVPpZSrLxqDI7ZOw6EbzBU8X6ogY0Sd
 JpvsPqM77gLoZjmjshB4hXZOdNsktfqox0s9ituXNCNaQlyNTA+Xb68QyEFH5mYhfKjH
 SJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770075973; x=1770680773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xBbXyS5fYaMQMQgGnrQEP9mxFnEIUHqcktwDF9spmuU=;
 b=NRdBRKx6fJJiv2FPG3Bj8OyhUbZw0nfo3BiIcfzuDDYO3633ymtqwxZGmdCfeMVY7k
 QJLnJhpxZqQSJP6zy7NUL3q7e8a5fyVyULH0KxCSzEMWW9gbXM6gmdGW3Ay3CATjLRnY
 vdt4mlA1wQ03xDZOW1lkzU/3+//oh642HjwnE5/CGCCeDPNrHO3wSmujEyY0AJNzB7Dv
 7X+xwSmGhleJvW8Gsj0NZ3SHll7zY+3JwDtXFYxKhjn9vEt93p6fJ02T0wjK3UfXzIJz
 pjztZPssknFoYyPinR5hcUg0cz/dk0hGxKEx9f7ZsirrphLQPJ+OfYIE7ltYJ+/njZWr
 1Pnw==
X-Gm-Message-State: AOJu0YxXKqYvf/sfj0EZSNLoh98KiyoGdyyI1GSQDsjuo4RNBUOb70rz
 HCINakMVdBzf2xArMm9H90dbRgxvlfBwzWc/Wz/nuUyjUn91kIyasZURbJS2veB1JQ1EQOfNJ5H
 dJKlDo+0=
X-Gm-Gg: AZuq6aLvhUOc+a3urV3hpufHGws0JbVnL0/cxgXCgmOSficp+438jDW9vEoqbxLvteK
 mXwQN4FuNd8B9FuzFVtkFcVmDPXZOiORNhzwALUh6eTwgnuGSFq3aJLbVqJdZS2KvnGfaASF0ym
 hvPRWY8q/MnzGaPU79m9UllJKDbQ5/CJeJnPpcz/omE56jY7B2hnHFLNCVzZjLp0eDtMiSonrKy
 FfxyGdT8zWB6DHOnY1R+LMPv6HjY910gAncq9D2yvxUqJwTMC/H25OsVDWtgtLt6fDJdAGxcJLb
 6jxI/dsZX3bx1wY7muhBIIJhMMp6tdfFGdMJnA667bRmE+imKJOQaXmFOD0Bl9XgE/vhaoLNJ4o
 JaMb5Z1ye3xPYsn1eEwAXuk7yO2kGVqypOEsEppfBAqvtpLBE0psEKCtkdH72YkV6v1x2opGuIo
 st6tCpAY1j5yRf9eR1c7kCranEUYv3dInTypUhdXF55vttHrqMeof7FG2ZP9hn
X-Received: by 2002:a05:6000:2305:b0:432:da3b:5949 with SMTP id
 ffacd0b85a97d-435f3a72ae9mr19088811f8f.21.1770075972815; 
 Mon, 02 Feb 2026 15:46:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e132303fsm47827739f8f.36.2026.02.02.15.46.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 15:46:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/7] target/alpha: Replace target_ulong -> uint64_t in
 gdb_write_register()
Date: Tue,  3 Feb 2026 00:45:45 +0100
Message-ID: <20260202234550.34156-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202234550.34156-1-philmd@linaro.org>
References: <20260202234550.34156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On Alpha, the target_ulong type expands to uint64_t.
Besides, ldq_be_p() returns a uint64_t type, and all
field / values accessed are uint64_t, see target/alpha/cpu.h:

  200 typedef struct CPUArchState {
  201     uint64_t ir[31];
  202     float64 fir[31];
  203     uint64_t pc;
  204     uint64_t unique;
  ...
  443 void cpu_alpha_store_fpcr (CPUAlphaState *env, uint64_t val);
  445 void cpu_alpha_store_gr(CPUAlphaState *env, unsigned reg, uint64_t val);

Use uint64_t instead of target_ulong.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index 1a7e2dd9202..a7110e8d1eb 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -59,7 +59,7 @@ int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 int alpha_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUAlphaState *env = cpu_env(cs);
-    target_ulong tmp = ldq_le_p(mem_buf);
+    uint64_t tmp = ldq_le_p(mem_buf);
     CPU_DoubleU d;
 
     switch (n) {
-- 
2.52.0


