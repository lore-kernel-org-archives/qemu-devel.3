Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FE9C98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 04:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAJiG-0007Cm-5d; Sat, 26 Sep 2026 00:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xAJi7-0007CU-O4
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 00:08:28 -0400
Received: from mail-yx2-x0c.google.com ([2607:f8b0:4864:41::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xAJi5-0003kM-1s
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 00:08:26 -0400
Received: by mail-yx2-x0c.google.com with SMTP id
 956f58d0204a3-67413c9dcf1so1157560d50.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 21:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790395703; x=1791000503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xu8QQeYsLU2+I6ykCLnxSq0STJmvG0R5jf7q2bk+YRw=;
 b=ss6lCB9uzCSR7quMlkCi5S59oRd+8AZ3jGurGhJZQocpfgyQ80y32IfgYl4GYLFvVr
 bUJpMeoLt75rxariJqzz9qCkL+BsjZKCNa+SKaGarEJpS6YNT8+re7du4UMyVUThk7xp
 76uvDV43Z9bYuuxd1r7vvjFSJNVJPpBwftp3peHM2gxE5vAnJEfG9EG87uFrAHUNQiqo
 +kPgE3UCHfjgvk/gvAG+BDQJYHvWzzHeh+g/x5CsWrogBdOZEe++vlmOqFe5sXmPx16Z
 NSFNLF5VCdGaLHLEQVKQ52i/awdCSVRKaYthOYdpbvmtDCWhjhjntASeGu9zDCfbLNdp
 7S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790395703; x=1791000503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xu8QQeYsLU2+I6ykCLnxSq0STJmvG0R5jf7q2bk+YRw=;
 b=mMdr2dGOUT+U70snaSTqZfqqfFJFpwVUkArMYLXphUY8p8ieP3V2Imi8ytWN3bR+GP
 bWgy2+7hsoViL+dCn273OH/8nEAE7ga9XJyEWDIRK7YgP6Jm4dzlb95t7rd2gDgP1c7b
 lTHzJCcIr8HTKEm5onnPXKSgqDkzDzxYPPwLWjI1ggz9RaTxdzsS3lD8Zav8cLULdOvT
 KyIeJm4nhw5JzSW/nzFv2m8MpnlpmFG29a0gt6PMrBMTge9I8ynw6siRYMddqVQft29c
 zxHLRx4XYCqOO+LKJN7X5ijNbSNE1HHNcfRI66NjSPsyeexf/hqrRiR32Zb0sDw5AaJA
 zfkg==
X-Gm-Message-State: AFq9FYKiY/EpMTFoTT4s2A0DazYUTMBRUXK3DoG7QHJc/8A3uTuQQGZJ
 AKrTaZwEzYHTXUMtt3wFOTu+sg4OVYlacuecnFBMCxnWFUcppcIYocY8yI8SAA==
X-Gm-Gg: AYBFou2BYJIEisLheN7dNlNE2225zebkRIxqgnXrkgiYnHn1jLUOd4ks9yd+J2b88mb
 F8VHMZhSt1sYXpYSyBHJFT7kuf9P3P0nJ5MpZblo5dQa3OqwoUI880h04JtYyLBmFrM0ukXmiPB
 afXAMY5SBBVKkq9E2Lsm6furwx8HNtOS2ZfPabuRo243hiIxOOZVRHkF2UQ5BaP2YKgHNMG8b3T
 hKL5yYil/+h9oRh00XOfW0BJgeNQd3krv/S0Fir3sF+gbAJila4LIoamtnRFMu0CsEcxHXsjgG6
 GgmtyoM1IyEXp+HYGv4zC4NME8VhYrRTC4i7fHLGidzC43b6Sap4N5xjoCKWeOd1UXYsD98/YIC
 QG4RUYzTgZ1h0Foz8gyk6iZGtiB8Xmp86oyH1dViEupN0YhJJdtZcigrKgA2QSBiQK4kz5KWPCW
 bzxp1Ma3NUxrMZCw1qG2P0xlcGjX6RJAOTCTqHwcOOOFnhTlUo5GdpKhbNXFcBso0tpH3voqo=
X-Received: by 2002:a05:690e:14c7:b0:672:f620:3563 with SMTP id
 956f58d0204a3-672f6204d21mr3475410d50.97.1790395703484; 
 Fri, 25 Sep 2026 21:08:23 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6740efb13fasm1914769d50.18.2026.09.25.21.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 21:08:21 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 2/3] linux-user/mips64: set EF_MIPS_ABI2 in mipsn32 core dumps
Date: Sat, 26 Sep 2026 00:08:11 -0400
Message-ID: <20260926040812.725493-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260926040812.725493-1-mattst88@gmail.com>
References: <20260926040812.725493-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::c;
 envelope-from=mattst88@gmail.com; helo=mail-yx2-x0c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

mipsn32 core files had e_flags 0, so gdb took them for o32, found no
general-purpose registers and failed with an internal error in
frame_unwind_find_by_frame.

Linux sets e_flags to EF_MIPS_ABI2 for n32 cores (user_mipsn32_view in
arch/mips/kernel/ptrace.c).
---
 linux-user/mips64/target_elf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git ./linux-user/mips64/target_elf.h ./linux-user/mips64/target_elf.h
index efb5d97563..fd9fb89269 100644
--- ./linux-user/mips64/target_elf.h
+++ ./linux-user/mips64/target_elf.h
@@ -16,6 +16,8 @@
 
 #ifdef TARGET_ABI_MIPSN32
 #define elf_check_abi(x)        ((x) & EF_MIPS_ABI2)
+/* See linux kernel: arch/mips/kernel/ptrace.c, user_mipsn32_view.  */
+#define elf_core_eflags(info)   EF_MIPS_ABI2
 #else
 #define elf_check_abi(x)        (!((x) & EF_MIPS_ABI2))
 #endif
-- 
2.54.0


