Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF60CDB475
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbZuR-0004M3-0P; Mon, 22 Jun 2026 04:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1wbZuK-0004Lj-F8
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:21:29 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1wbZuI-00022D-LH
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:21:28 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5ad5a2138b4so2792564e87.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 01:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782116484; x=1782721284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JRneSGpadxsEjMKre1BP1NkYZpJSiPSjblQpGRTMIQc=;
 b=qv90WDygcqBVyGvrd+yUPEUkj2n/eSonNthsn0zX5e0OiCH6Do6/mlxGfPj2FalVmo
 PPVqDgvxmEKzxQqRqr6z7hiY+ImJ1Rhm1qLTfQ5UlXEjMpLda3GTBmbq39J8FzDkWgTw
 bA1rSDPzXgPAk4IaBIl65z39EaIkuBeKOiRTUg8yUSDbXJtP1eyJ55+rVb/P64aZWt0h
 +3oAQoC4vaWdBddke4KbEAhDUg1ciaqSk4UVJ++wtrIQaxpF8Jtty8KhkISniQiTZJqC
 ivRUpXO4+2dGpzIvUFSjX1TOYxXOb1Q4mPIKYyxXIL89JqQRu9fJdPjOGtTJmVzivp8X
 cKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782116484; x=1782721284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRneSGpadxsEjMKre1BP1NkYZpJSiPSjblQpGRTMIQc=;
 b=UKfjAcpU2UlJMRZ/OihRRRhtNMVbHftLDMZi9PRFpvfhMpeLdLCybJXAclsiCS9nJC
 U1dMGZM8M586bWhyyeBefFh29+VlX1pjSm8x9JArAqHhhDzwxX8iDRdakVZ/yICCy326
 2NSQ36KZNYiceEm89FPXJ1Azo6myvdlD/VsIZAAHLYxBYLT8LQGM9BmH+s+ikoXPDMdQ
 BaelgJntQg4L9x/WmrjKMqttMfDHwgh9wo5vFNUv3tSShp4ArdzJB5BYGTXCLHG1rM/B
 vwz369csQzcrglWwpQmMufuZV6SEDK7Sguw6Gl+GSVu7xM3HaQ5CCt42b4FkJnneSJXd
 DQ6g==
X-Gm-Message-State: AOJu0YwUGnKgkuyPTjGpokpm1NQn0y6zKZWwfsLY6ZzkT/j7YNJYagdU
 GyuoHDZIh+EFZn7oiU2ybatp9q8SSjQ7/Tx67FBbL84kkS9e0RwXmbdyhGuyV3prOYc=
X-Gm-Gg: AfdE7ck/Q9z6+RnUe445hUt4+IKC/13hBbHlQ4D6N2ziIZ6JtmaWhM0iR7hC1eXtKWY
 72we3yImukKmOBOKUAP0rUbP7JzRIKdO4xntzLjxG+I6lp4qFOej0ryCvX6LoGXcFGFeBhLOtj/
 TnAeervtr59X+/RtOL/m4G6iFEw0Ze5xgNUg6Aoh2NOf/+H3O9tvL2MTo9whcuovobHysWUPcMi
 XyYKI0jN05M8Nbf8CGkoKehNElkrypRnFkNNVYuU6a+vEtydBMoQA/VDWuJluSvUMTliiyOZNH3
 8Gq1ddwFRKj0rDGrQy8B0B/SAJqg8yKKBI/unDEsqwCZbxJ6feJXf49O2BcqjgnemLeLg+58cvM
 BQ3fF/tAXGGnM9pmWDfnYt25AKgb1zsUYA65NOjX4oEiMrrtIPRUyIbIOA/heqW8zdEQ7CiNX+g
 iigKCd4w==
X-Received: by 2002:a05:6512:1108:b0:5aa:6a18:2b84 with SMTP id
 2adb3069b0e04-5ad56289469mr3572379e87.7.1782116483459; 
 Mon, 22 Jun 2026 01:21:23 -0700 (PDT)
Received: from kali ([82.162.57.219]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999b17f8b8sm16455441fa.28.2026.06.22.01.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 01:21:23 -0700 (PDT)
From: Andrey Polivoda <apolivodaa433@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/i386: allow transition to virtual-8086 mode only if
 CPL == 0 and CPU is not in long mode
Date: Mon, 22 Jun 2026 18:21:19 +1000
Message-ID: <20260622082119.11903-1-apolivodaa433@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=apolivodaa433@gmail.com; helo=mail-lf1-x133.google.com
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

According to the pseudocode for the IRET instruction in both the Intel 64 
and IA-32 Architectures Software Developer's Manual and the AMD64 Architecture 
Programmer's Manual, a transition to virtual-8086 mode is allowed only if all 
of the following conditions are met:

1. The new EFLAGS.VM bit is set to 1.
2. The Current Privilege Level (CPL) is 0.
3. The CPU is in protected mode (and not in long mode).

Currently, QEMU performs only the first check. This omission allows a 
transition to virtual-8086 mode from long mode, and also enables the guest's 
userspace to trigger this switch.

During a legitimate transition, the EFLAGS register is updated in a way that 
allows modification of sensitive fields, such as IOPL and IF (which is expected, 
as only privileged code should be able to initiate this transition). 

However, due to the lack of appropriate checks, an unprivileged guest userspace 
process can now force this transition and freely modify these fields.
This allows the userspace to:

1. Disable interrupts, preventing other processes from running on the CPU.
2. Gain direct hardware I/O access by elevating EFLAGS.IOPL to 3.
3. Crash the guest kernel by setting CS and SS to resemble segments with RPL = 0 
   and triggering an exception. Since the kernel is unaware that the process 
   entered virtual-8086 mode, it will misinterpret the exception as originating 
   from kernel space.

This patch fixes this bug by adding the missing CPL and long mode checks before
jumping to the `return_to_vm86` label.

Fixes: 90a9fdae1f1a ("more ring 0 operations")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3583
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
Cc: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/seg_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 58aac72011..8bab2db00a 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -2068,7 +2068,8 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
             new_cs = popl(&sa) & 0xffff;
             if (is_iret) {
                 new_eflags = popl(&sa);
-                if (new_eflags & VM_MASK) {
+                bool allow_vm86 = (cpl == 0) && !(env->hflags & HF_LMA_MASK);
+                if ((new_eflags & VM_MASK) && allow_vm86) {
                     goto return_to_vm86;
                 }
             }
-- 
2.53.0


