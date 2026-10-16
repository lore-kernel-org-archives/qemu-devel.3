Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67E6CCA463
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWOZ-0003VT-Hv; Thu, 15 Oct 2026 21:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNA-0001UZ-Bq
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:41 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWN6-0004Na-1G
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:36 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2e95b3b52f2so7883095ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112667; x=1792717467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s0/6a5SJjLsVo8JScVF6g8q+2Tkpu4lCuyAYzlRXHvA=;
 b=LR6oSUY5ZGJRwxhnps3GD8a6YYUdjMZgK5NGahANLpgCXo6vRICwkvyTxT+fLEr4cb
 Q2HM8c5siHWjFwKDEsh3a/5omjCVSXOBLlYTWkHjpUNTcfwL5urQf+WeBikxTHeIED25
 Th35VvedLLI0pQKR191Uy6WosD8LP1itXvJmGNuAxwVvr3QEPi9WSJF2M9ysdfXyu9aY
 l2q6cmOH965OFacBY3LpsxxbX8aR3D1+qV0rHRML3eeaFTzzytiJHsqDHJPLmfSNLuaH
 3AG5n6nkdJsRUtMtBNft7OHtDT6AcEZwrmzA2lD+4dmVoyQZycI5yYSmZa+gR41TX0QY
 ArCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112667; x=1792717467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s0/6a5SJjLsVo8JScVF6g8q+2Tkpu4lCuyAYzlRXHvA=;
 b=1ieeT5f3sxIc5nDd3bxio9VeZeUn8eQ+p4IBUVcZvbmOYj3jcPtjXqRmaUfcpEW/ZB
 WavGAjvTzu76SL6D39M45rOfBGDkEillhIRVV1XT7AWDKYBtL/MTqEo14zRBC7d8X/ZX
 ukgZ7Rb7/VCwGarkqFp8GMGz0OQLx9mDCprdszYEtKB6lAG2TRB5Q5Bvrrexu/h8grNi
 /zswG2x7KqdXv3WP3flNtQBXcXHQU8DrEbtGp6f2J5wCHr7pqS7QzOOs5i73dXLRKN7Y
 0dOBzuvPEeGaRBfLMoBYAkoazx2Wm573uDlohWjOD+hWSbGfpDHHa7y5MBOCQTSf/33U
 SVHg==
X-Gm-Message-State: AFq9FYK41H7Cp/xrwlH9qhRyupdHD1DZuN7THIZEusAHjJsWecdVrfKA
 u57MUw0fDB4u9FoHZBGAx+GCoAeZ7l5qHXtOUcnFRYlP5BTjZSzT9SIGz048dg==
X-Gm-Gg: AYBFou3XJDUEBjgrK+oTGFWNl3uAOoTY7RRLdjfKykfzCODSr2ScEtiO0RwM1awyszu
 yeJvVqlOOXZmRfT2taMS5pc2fs5Ix1rvu7zHuN2W2xV06KjEuoqIQWZeUEMmvwCpDd+ghaeRYQ9
 D0M9Ose5aB9ytUmzxq044WjIlbrXWnJkU9prt2KftLp+xmXhbhdi4Frp+mZJSJdZGtIyMs2XBUp
 Gqt6iEI7K7GoMjSZCiTYOoYFzHRJfApraktnpbPvuUtJqPAgFuxCYMF4SEGLcJjvwu5Pz7czYvQ
 cT2h3S2xmwFf12Ex/MtMgT6bmMyGYd8yMq+Q5kuNTSIfyF0qaM4s1nyTsW60qSWapKEW98mI+pC
 WC0C834Jj3BGJsnVVSVzULiunyLXK/WPHVMLMPFfaYkXLPnKCSvNYv/V2kW/B9If7yhf0yBQEMY
 Y9Cd+d5CISF7iMW+qbMgmhGszmaCvtlevFU4rxIbinuMUgWye68B5DCQAi87sx+QsHuLn85jD8g
 cYu7P4LRJPOm3yQ
X-Received: by 2002:a17:902:db12:b0:2e9:8b24:8dca with SMTP id
 d9443c01a7336-2e98b24c797mr2738065ad.54.1792112667074; 
 Thu, 15 Oct 2026 18:04:27 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:04:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [PULL v2 35/50] target/riscv/cpu.c: remove 'bare' condition for
 .profile
Date: Fri, 16 Oct 2026 11:02:22 +1000
Message-ID: <20261016010237.1102834-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We want to configure other CPU types to use profiles as an alternative
to adding every profile extension explicitly, i.e. a profile is nothing
more than an extension bundle.

This means that a vendor CPU can set .profile=rva23s64 while having the
same handling as any other vendor CPU. Same thing with all other CPU
types.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Message-ID: <20260928201107.2049458-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9e3d096802..658a8162dd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3166,7 +3166,6 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         mcc->def->bare |= def->bare;
         if (def->profile) {
             assert(profile_extends(def->profile, mcc->def->profile));
-            assert(mcc->def->bare);
             mcc->def->profile = def->profile;
         }
         if (def->misa_mxl_max) {
-- 
2.55.0


