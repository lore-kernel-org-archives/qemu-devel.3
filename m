Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C690ECD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScFz-0005Qw-HW; Thu, 28 May 2026 11:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wSbyG-00018b-NT
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:44:28 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wSbyE-0007NC-9O
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:44:28 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8379e010b01so5571450b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779979465; x=1780584265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s3OGZYfXnteRuvNA+6MIt19Oh5drbLD/0Yb8FeJHQwI=;
 b=OMTstlbQAa+Gv20CjWbNP6nryJ9cIU+6VAhXBt68AwPQ50hrFPe9xueC44USSIw3+/
 pwEMGqKfDtqdEyjH/XWkP3WHoNnMCeWNuAqQmMz1/O+riCHVZH3v2d7YiKkgbppUR03d
 kl5Z4U6gPwP8EBfJrdAMIpQvmXE0VAa6Slf0+sKStXV+Up0R6d0x/VhqNu4YcLWLWjCs
 STfXqq86PgzSaUM0hc8HC55idGdgMXMlLSyMCa7TQtTxteA3nV+5M4yuEG2XVq2chucy
 LJ42jAvnJpbTUCPujUii3O77Kv7IHWh+a9brkfWrZZ9AXkK4A6kCBJvfBczq0okDz8q8
 eSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779979465; x=1780584265;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3OGZYfXnteRuvNA+6MIt19Oh5drbLD/0Yb8FeJHQwI=;
 b=sCaVoUybJFgPsfIc9p0cOHFj/ciNtxYQy48hBIDJ0CVqQT/AoRABkP1JC9HLS3bg7S
 +G3OS5tN81vqI4ynzx0y8Mu+k8QCStfRr1yfJ4N/Zf9FU42o7fETYiYfcYCerInbcroA
 xXJQLQMmfK8AkbTbNSwi9bVY+ZjgASaXed8MSurM5pgDvbrOOj5LXNUZwBzxefumPmWL
 jEjDbImwDLyzBFI9SCtdC1gxZMxexPAqRBgYnSzPhSlSNAKe0U2Gj2NcUt3FJrBZUEhp
 sIyj6jrRHZ2j1HE65ptVZ/B1GGbi+XILjruD4gLKSZu7KT498aGLDdHoVepOygJXZaey
 UArw==
X-Gm-Message-State: AOJu0Yz/P47ue6ptorwWl1b3XbvckzBjFwFJMuPJKPEwjhpqhW7hGsRy
 HNaoJp2ZZ3tqaNm5EUq4HW2EjVL4pLGhn+d8vRzFy46LjP9gJ2yGeX/5XopqmA==
X-Gm-Gg: Acq92OHqwYOwxspj7qSfTaLn1fW8odQ+lqCEp5lazgcOYRrHxKtGTFppPful1DuayBj
 OBeGfnSWW+zvVAJnHOyYTh36FiTQ5l5n54IcRbnduCytzYaQUOgrGU2Lr0FDLd5wK0VEgByitBZ
 euyOty2aKRebDizgvPI5jourp58vjUm43Kee59yuQY9snxjWSDmXo/HokObF5pU9M1wjXqIs2zD
 7BtlFhT4gpGNCfs3e5jzKBlOR+Cs/Cmiy3Urp6g7dy1zS7F3yI/aDdnP4kRE5au5XPyRUoFnHB0
 1FpxK2paFkvin6WxiXzjfGMbR+xO3m6UDQ4d+6ZCkik7XQfHc6Ec8dlOuAkVSbgoQu806JE4C3f
 UmJwYe3SVn9/kGbMJiKTwRlS/5OibgCxgxWCb87BQofeAge4Kd+lbWh4lsfA1LDye+UJirbaskG
 dcMu7wPiouiRVVVNxt1egBQWgn5jiumOs=
X-Received: by 2002:a05:6a00:6f61:b0:841:dc7e:5891 with SMTP id
 d2e1a72fcca58-841dc7e5b91mr6104211b3a.0.1779979464660; 
 Thu, 28 May 2026 07:44:24 -0700 (PDT)
Received: from arch ([112.133.246.11]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841d6e80c2asm6080524b3a.6.2026.05.28.07.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 07:44:24 -0700 (PDT)
From: Abhigyan Kumar <314abh@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Abhigyan Kumar <314abh@gmail.com>
Subject: [PATCH] target/i386: Fix incorrect tcg generation for RCR & RCL
 instructions
Date: Thu, 28 May 2026 20:14:14 +0530
Message-ID: <20260528144414.681987-1-314abh@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=314abh@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 28 May 2026 11:02:45 -0400
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

RCR and RCL instructions of a count of 9 is meaningless for 8-bit
operands. In gen_RCR and gen_RCL functions, gen_rotc_mod converts a
rotation of 9 to 0. But, the can_be_zero flag wasn't updated and hence
we skip the immediate if branch. This causes 0 to underflow into -1 at
tcg_gen_subi_tl(count, count, 1);

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3452
---
 target/i386/tcg/emit.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ce636b6c5..a71af846d 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3452,6 +3452,7 @@ static void gen_RCL(DisasContext *s, X86DecodedInsn *decode)
     low_count = tcg_temp_new();
 
     gen_rotc_mod(ot, count);
+    can_be_zero = (ot == MO_8 || ot == MO_16);
     have_1bit_cin = gen_eflags_adcox(s, decode, true, can_be_zero);
     if (can_be_zero) {
         zero_label = gen_new_label();
@@ -3504,6 +3505,7 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     high_count = tcg_temp_new();
 
     gen_rotc_mod(ot, count);
+    can_be_zero = (ot == MO_8 || ot == MO_16);
     have_1bit_cin = gen_eflags_adcox(s, decode, true, can_be_zero);
     if (can_be_zero) {
         zero_label = gen_new_label();
-- 
2.54.0


