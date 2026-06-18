Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C88ECD98F8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCsg-0005zH-8S; Thu, 18 Jun 2026 09:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1waCse-0005z4-S8
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:34:04 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1waCsd-0000UF-F3
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:34:04 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-7ff3362e35dso5487897b3.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781789642; x=1782394442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/tbhj2Rk9RZg81NIh8OKcFKs2E2wE7askwGHFpKXwuE=;
 b=akCo+aMEoONr/FeBApSJcYQzvD6SS++9tVmugUtz8i0C5FnXKd12IaiXs1LazF4pNJ
 d3YQ0KZYrUhbJQYVaivIVJNOU9eydn4+ZkOLrtlqZmHIUqL229l0PwfoB0FlsrsILbRj
 MBzmvRWYhQC7b4ki3as3fjgX7skLXY1oYtqEyPrkbT8LZ5R0l2lrAltFBUN5/n3ZCRn7
 hoaRL4UtRKxDxFeiVjyq/d36JSLRdHem07uMOMy/U/trZ80Z71YUaxLEX433ZNusclb0
 rN1cNzRtCkL3S/nz7Adnr4fLOP4n+378up6NcqkOvQGLKbiF8xbeUL+cbSftRlRoIZ+D
 At9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781789642; x=1782394442;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/tbhj2Rk9RZg81NIh8OKcFKs2E2wE7askwGHFpKXwuE=;
 b=rn/eA5Lhf3PFm1yipbnY+xsQcI4ogldZOVYw88QraDW+3eRhs+jR1gy7LWBqhs/vR8
 pX+JXFbT2PEeFP1sPlmX9n9Sl5CtB3oYCr/ECCnba1ouXUAPZmbL47LYIc81rAgEPMTq
 KAsH5Ou51lDB83YDR1/8OnRSBL14lskfTggdbzMcXa1VdSA0aNil+vjcktsA19mYVjcO
 zb7cMyIzalLO7LL9LBF+3CpWu2du5Lh2W3T7Df1hoSSApH1TBAi0XmKeBFsM00mFwDI/
 RhwTsUAOgO8VDZL7oCgjp/4RrRLqm7aUrK+BgEpqbw+kLMDKWfxj+W26ayVrsnZYvJ+P
 62fA==
X-Gm-Message-State: AOJu0Yz8CxzFD/vWR11K9ggrza1rEYfixFagAGRfcn+fWWkJSh7XaF5E
 2hlwgbt8j6/nWB/kyrgWRbb6HHHxs9RCW35LuWjDgE0aOrVNzOmCnFwvOqHy6A==
X-Gm-Gg: AfdE7cmCjKN13HKvgLuB2BVlsqczZNGVPqnhQ0cM0de2IWe30xX8wyznw0mGANkZtGA
 lsVI8+0jR+ZUs++bwXYW2aq/RNnB0Fv4wkaWqXjSrC5xF5PXszJjY5wedm0FA5ArE4p5Ani6sXb
 1qy+66VBvHTMXO4p+Oj3xKRaCI5m1JRxHneioepNzTgwr1suf++UsBTllEyfX73SyoFGzWCuHpn
 u4khJHlmntp0R1GkaMfc0bzwTda4Y6dNQQxOzqj99X3sbZqXpcTK+8Ns+nMa4KdG3FEm+Mrkss7
 o2wJDt5VlO+me04yUS4SVcke6BJVk95bs81Q1tMiid9WBOPVNfnBjQPA3R/fjt1AC3g70Yk89a/
 WauH3iZVFXN/INSNUoZz3LpYkjg7kOg7BaD5QhWbOXM/kpTibFL1qbBxoxUcDXRYyOMxHvr5Krx
 flB21WIAHbf9DA
X-Received: by 2002:a05:690c:47c4:b0:7ff:1399:7e6a with SMTP id
 00721157ae682-7ff13997fc8mr56377877b3.9.1781789641725; 
 Thu, 18 Jun 2026 06:34:01 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7fcd00dbc0bsm68338817b3.8.2026.06.18.06.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 06:34:00 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Matt Turner <mattst88@gmail.com>
Subject: [PATCH] linux-user/xtensa: fix unlock of uninitialized frame pointer
 on sigreturn
Date: Thu, 18 Jun 2026 09:33:53 -0400
Message-ID: <20260618133354.3369437-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1136.google.com
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

If lock_user_struct fails, frame is uninitialized but the badframe
label unconditionally calls unlock_user_struct on it. Handle the
lock failure inline so badframe is only reached with a valid lock.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/xtensa/signal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git ./linux-user/xtensa/signal.c ./linux-user/xtensa/signal.c
index e3f9da322b..4990c50045 100644
--- ./linux-user/xtensa/signal.c
+++ ./linux-user/xtensa/signal.c
@@ -355,7 +355,8 @@ long do_rt_sigreturn(CPUXtensaState *env)
 
     trace_user_do_rt_sigreturn(env, frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
-        goto badframe;
+        force_sig(TARGET_SIGSEGV);
+        return -QEMU_ESIGRETURN;
     }
     target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
     set_sigmask(&set);
-- 
2.53.0


