Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA48CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ8Kz-0007L2-Ni; Thu, 21 May 2026 14:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wQ8Kp-0007J1-0k
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:41:31 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wQ8Kn-0006tQ-Lw
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:41:30 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-651bf695701so6330837d50.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779388889; x=1779993689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oORnzJD4oolaPBbAjh79M9DWve3dRnVwNg1j1EfVTdA=;
 b=kpOT7OkZ8Y55CrrfwIDradLnucav5DUoc5cnFo8UMOafEWlXg62zYkia789QGoMob1
 wL6SniKH/E7wBGmgXFuG84WQvuRybLTWQtewF4jTuTe1oZSyUisIAUbw+fCqpEkS32lQ
 BgvNZkyUT7J9r67nO/hCCMklVJwzfzRwjkQtTPXiHbIUdb5xVVVGywDrdxPN0wRyu3CE
 304YFfnK2RAJDfd8ViAe4GOvIShxWfvwaY/VQcqutwE0fS6ZVZ+/iZig+0ZVZkYVHOGh
 lLg3hsAOO6JWUV1rYeiHScscXORXh7tiFJWBJtLRwIK96644jESdoLWy/6yCSei5lheN
 rnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779388889; x=1779993689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oORnzJD4oolaPBbAjh79M9DWve3dRnVwNg1j1EfVTdA=;
 b=WuJ7XW3GDQ53wc33wjKzklYdUzXY9zm1wN5jmUyKkzV0EUNnowcT5foDGMvMCVR7vK
 YhKQGyWjwdhJfLHxUGuEDTb4bGzc+xEvQM6qBXK5NqWksQ/EECROaSO2yYJ0tsEjM9TA
 wXG0p6IZ8f9YY3S/axKhplvId+73ToWT0HrbwDfTFbd6zllOUKJ0+rMOuoIa5qZDS1jp
 rzEGXwFQOmmRkxa0Nr7vIjeTqIhrI+mmqJJrc7aslt0zM/XKlyTBNT/4Yr137CIqMSMB
 XChmbvEGqaC4T3shIhf22b7sQm2ta4uTgyhHqWsZcfOxeDuSQmnSgVyTClcuCLCkNojm
 knQw==
X-Gm-Message-State: AOJu0Yzs18FTdNsXbKJ3GAlAmJclmjlLprb9lIK6Dx6C8EclRCqxuFMB
 3ISFc/VxgNE8fztQLSbyRK/gY5bLj9DlxJOtH/hK6UvIQG781BDjihzPsArPy/jQ
X-Gm-Gg: Acq92OFJf+t8otielzgi2Otg5pKz9HaP0LxfgE2pF5GdJ7grxX1b1t9iHCVpO0h4GdK
 1jVTopzAFzZYi6ogu+Jb4SwCTXqocWOkdduHQQwds+J0nqibPkpQ4IEYx1WDNpOfG5PxVRji16+
 ctJdL+FYojxLxK1Pk4jR/eTRpC0AjCrZzf3sKQ+S5vLZ4o+BbE8gc9fpK4AnNq/6pG/sn42r2J0
 0QIyiKDhuui6csYXumnzTRe5h18ixZsMtTfYxqHK5J3glmQzSMjmXD2xpw6DnqjJkl6PlePolzE
 JKxWCY8Qfd0KjvF5QfAS6pS0I2Bpft0H4AmHpxnuFwqaaoVrLollspCN6ecsfSZhcG/v7stF6Hd
 DhKVqToFRoQWP+Nj5+GvASteJwJq8c9WsNNGHO5UEpeccrBqEtTLGlzM+B+m6UWrGt37rNVtUcx
 OzrojNM7yPo1bTeL0yvBg315qHQ0aP08C7HruAOFXFfVPAddj3Am6UdP19D58Lpp8S1/oCRxauX
 3l63MeXcXnGWgN4JvaNLjHl
X-Received: by 2002:a05:690e:5d1:b0:651:9544:fe1b with SMTP id
 956f58d0204a3-65ec98dbbafmr292599d50.35.1779388888648; 
 Thu, 21 May 2026 11:41:28 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-65ec200fc87sm529131d50.16.2026.05.21.11.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:41:26 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 3/3] linux-user/mips: use tswap32 in elf_core_copy_regs
Date: Thu, 21 May 2026 14:41:03 -0400
Message-ID: <20260521184119.1631958-3-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521184119.1631958-1-mattst88@gmail.com>
References: <20260521184119.1631958-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb12f.google.com
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

---
 linux-user/mips/elfload.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git ./linux-user/mips/elfload.c ./linux-user/mips/elfload.c
index 1a46e180cf..ce2c4514f3 100644
--- ./linux-user/mips/elfload.c
+++ ./linux-user/mips/elfload.c
@@ -135,16 +135,16 @@ const char *get_elf_base_platform(CPUState *cs)
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
 {
     for (int i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
-        r->pt.regs[i] = tswapl(env->active_tc.gpr[i]);
+        r->pt.regs[i] = tswap32(env->active_tc.gpr[i]);
     }
 
     r->pt.regs[26] = 0;
     r->pt.regs[27] = 0;
-    r->pt.lo = tswapl(env->active_tc.LO[0]);
-    r->pt.hi = tswapl(env->active_tc.HI[0]);
-    r->pt.cp0_epc = tswapl(env->active_tc.PC);
-    r->pt.cp0_badvaddr = tswapl(env->CP0_BadVAddr);
-    r->pt.cp0_status = tswapl(env->CP0_Status);
-    r->pt.cp0_cause = tswapl(env->CP0_Cause);
+    r->pt.lo = tswap32(env->active_tc.LO[0]);
+    r->pt.hi = tswap32(env->active_tc.HI[0]);
+    r->pt.cp0_epc = tswap32(env->active_tc.PC);
+    r->pt.cp0_badvaddr = tswap32(env->CP0_BadVAddr);
+    r->pt.cp0_status = tswap32(env->CP0_Status);
+    r->pt.cp0_cause = tswap32(env->CP0_Cause);
 }
 #endif
-- 
2.53.0


