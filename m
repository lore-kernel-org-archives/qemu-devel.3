Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCF0D2B950
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8LzR-0006kL-Sj; Tue, 05 Nov 2024 11:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8LzN-0006jO-MA
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:01:05 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8LzK-0007PD-Fy
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:01:04 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c9850ae22eso7060995a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 08:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730822460; x=1731427260;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQ/wvxuTvQaiavS01m+IKLgZecmKu0OzwEWLUO9nnOE=;
 b=Vqo0vDH9t/KURVAkXBf8BLXu5Lz5li8CDz83hjyZFlfWdWdym+GLQpcjEfiPiNCbrB
 2XnbguiKdJIGP/j5TiiD/OYOdVhWmyYmMFYhYkX1k+MG8L6Zs8vMkd4zSeBTP14OxHYx
 UXDkTgUOytNp+b0vd+L3fx+v2uqspyvTQZKCZsCBgsBCM5YbtjkYta1ngbvtwMARFIJH
 E1cjtfYqEeIxmUmzxKheV+VQSzqW1jw+/KyB0JhLrc51p/z5ORgTL+AHou47n0t9cS+v
 aFzviT/RDahsAeVvJCVNLImfkaFCoB5KAkzfIXutaTPtaLKFXUqIalXi6HkNUEFp9c9G
 KXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822460; x=1731427260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQ/wvxuTvQaiavS01m+IKLgZecmKu0OzwEWLUO9nnOE=;
 b=cYLxygq4qlldDn1JxHUAyFy4TmBgXfoHcUkaBoLv29ICo8RG1Z0PfTblXNvh0T92Du
 x77KiVNJoOixG/H8Dxne5ge55ffuqNOnfM0Nm6Ll5CMrc0eZViswSlO91zFzOhY3iVJb
 3E9u9Zv1qvFUBMNaerj4zgyWFPvfHtSsCMgdqqpFcwkoJGPpwM6tJz1Gg7hi3kKd5MM0
 axej4Cz8CQAQPFtP8/vD4SlxUIkxeS5T8zY1jeHLgA9B1RX/JfkHQFlyIXy91g0hajd4
 jJIi9jDnCc0pxj9TYRqBjCso5Zx7samkdr3btVs1HAMTlQZ6aGHQuDM3mX+bLHs9t24E
 iKPw==
X-Gm-Message-State: AOJu0Yw64iikJBhnJdQnzkkQGiT99Yaq6eDqijuJFlwBvFKL2cnhy2XY
 yh3/8Tt9w5D4Kib+sKaBmgQjK/Jwaezkf10vHQuX93P1FgaZwnj71a2rlk8fTspVFopKam2yiGC
 cgA==
X-Google-Smtp-Source: AGHT+IFsoc5ezJdzFbA8gnVMPniGejHymxh15nQc4VaY5FOXNpE7dnw+gMN0f03Ms4QRpg5zJy7LSg==
X-Received: by 2002:a05:6402:4405:b0:5ce:df98:a609 with SMTP id
 4fb4d7f45d1cf-5cedf98a716mr4504664a12.27.1730822458271; 
 Tue, 05 Nov 2024 08:00:58 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6a9a41bsm1467773a12.14.2024.11.05.08.00.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 08:00:57 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, pbonzini@redhat.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 5/5] i386/hvf: Removes duplicate/shadowed variables in
 hvf_vcpu_exec
Date: Tue,  5 Nov 2024 16:58:00 +0100
Message-Id: <20241105155800.5461-6-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241105155800.5461-1-phil@philjordan.eu>
References: <20241105155800.5461-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52b;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

Pointers to the x86 CPU state already exist at the function scope,
no need to re-obtain them in individual exit reason cases.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/hvf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 8527bce6eef..c5d025d5576 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -586,8 +586,6 @@ int hvf_vcpu_exec(CPUState *cpu)
             break;
         }
         case EXIT_REASON_XSETBV: {
-            X86CPU *x86_cpu = X86_CPU(cpu);
-            CPUX86State *env = &x86_cpu->env;
             uint32_t eax = (uint32_t)rreg(cpu->accel->fd, HV_X86_RAX);
             uint32_t ecx = (uint32_t)rreg(cpu->accel->fd, HV_X86_RCX);
             uint32_t edx = (uint32_t)rreg(cpu->accel->fd, HV_X86_RDX);
@@ -644,7 +642,6 @@ int hvf_vcpu_exec(CPUState *cpu)
                 break;
             }
             case 8: {
-                X86CPU *x86_cpu = X86_CPU(cpu);
                 if (exit_qual & 0x10) {
                     RRX(env, reg) = cpu_get_apic_tpr(x86_cpu->apic_state);
                 } else {
-- 
2.39.3 (Apple Git-145)


