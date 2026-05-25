Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0704ACD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRX9E-00037A-L6; Mon, 25 May 2026 11:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRX9C-00036L-7Y
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:23:18 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRX9A-0004ds-LA
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:23:17 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-65dd9b25829so7546404d50.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779722595; x=1780327395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BUqcEl28Au1cZ78/w2W4Hh3qAO1KF5koxsiMBDgS/O8=;
 b=Ld9srr2MWq80dlTTAy13MUSjahRmeemOcc7K5ZZm6ZKgbSO+LXBvNVJM/a+pZe5cZ9
 ibD6+/YNj+tfv4+mE0ON4CTMjuhG9CQCbqzpZN/CNDZOTwL6aqQDI9OdJmqsqJAg7lZ4
 X/Gdph01n7yItnTQOGcvcCeKttCn8zpA7T25I8wd4Drsj5TDLzibYSDJs8eq9lQJWixI
 UEzUX3a0K/Vh308/RUfjp6qu2pb8Vk+bO1LdRUCgW9qRmZqf3MbiLAN3CUoybotfb+RH
 2LhaUwkRXh7tQPuWmez+EBCXBtXo+U2Aj5txDoUZt+/5e/rwpJK1Fj94sP3HV6Q9u05+
 gaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722595; x=1780327395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUqcEl28Au1cZ78/w2W4Hh3qAO1KF5koxsiMBDgS/O8=;
 b=qy1TAt6PVSYMAErg0EK+JSa9wwUIpbzYNiZzfqhlO8KguX3Ed1vm7WKvyr0QXCRJf0
 2s+9qWlF1KolLcoyVVZXld/DQw7bz5N9KTegiRb4CubKMcJFN7WvFxNiJSyE31k6qwRt
 RaLaVbmoUpfck55ypC2PD9sLFL61s0YQfbGy046QlQ0YleP9yX8o7moQa+uZQnqph08a
 h9w3QQXtKnPWalv9J76NVCqbCz1cPCkzwmtBhPfa5a9OoFB1RDpzH5F2SYhJrll0BsnH
 2kC7lO4F/epo229hm1QkpPMtbLXlgT3P7ZpMuT4EGYdkQloZFyDCs1YmD97+cp0jh2bL
 Rwrg==
X-Gm-Message-State: AOJu0Yx6pH29U5PvAmcONbxxbGXRbNy6YWy2l9q7Mjy6UbitQwqlG/Rp
 BsepOjXmYod5L8kVoCntRVslO2b0HO8kIE2kd5JTdOXEd45kjvXaaiggVNT0xBEj
X-Gm-Gg: Acq92OGMXTGIQ3V/mIfHzE5GGS3NM73iALpEHH2elQVTyCqX6q3Xgc+KoiJQljQd7sc
 fpOu28ZGsqpwOQN0AHm6jmDadN+Lu25ZPGUcIBbWkcInVpdlpN4Tz2Hfix1bOv+tl1gKdJP5fkV
 B7YdrcEg3QMOwvP70VXA7wLRl4/N6Bf3/iMNtkzH/X04nyH/wvoXyMk4cDFRlY1/s9Dy0hp29qv
 V6/Rmcy1c1WgnqQz/u1WyhqxNzUVTkLPm18VE4PQPoXLsRYAkAplP+MwV7DMaiXz3utrxVHmTGC
 uaCQvvEIyaiODlWFyczrQqiDnicskPfaHE58Ju8wL2qa6pSuzT3qxgxaKQqMbEUHe6KgGyqhTmb
 DtDiVs0CaiWUm7CtLlTDVkspA1BkTQQdU3XvGLu3vhJshb5+v1iGq70mT63eKh5qXgAjp2NZ4cJ
 Lhci3WfGyiLOlv27emS24+0Jc9dCOl5vZMBuNHAdikXb0tvWBZXgaS0f3HXUFLQEIKvV7ac7NQ+
 dklNm1ybBqDog==
X-Received: by 2002:a05:690e:d4d:b0:64a:e222:d3fa with SMTP id
 956f58d0204a3-65ec999ebf0mr13626095d50.58.1779722595507; 
 Mon, 25 May 2026 08:23:15 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-65ecfda36b2sm4662523d50.17.2026.05.25.08.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:23:14 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Turner <mattst88@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH] linux-user/ppc: restore fp_status from FPSCR on sigreturn
Date: Mon, 25 May 2026 11:23:12 -0400
Message-ID: <20260525152312.4120017-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb12d.google.com
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

restore_user_regs() restores the PPC FPSCR with a direct assignment:

    env->fpscr = (uint32_t) fpscr;

ppc_store_fpscr() exists precisely to write FPSCR and keep the derived
env->fp_status in sync: it calls fpscr_set_rounding_mode() to update
the softfloat rounding mode, and set_float_rebias_overflow/underflow()
to reflect the FP_OE/FP_UE enable bits.  The direct assignment bypasses
all of this.

On sigreturn, interrupted code resumes with whatever rounding mode and
overflow/underflow-rebias state the signal handler last installed in
fp_status, rather than the state that was saved at signal delivery.

Replace the direct assign with ppc_store_fpscr().  The FPSCR_MTFS_MASK
applied inside ppc_store_fpscr() only excludes the computed FP_FEX and
FP_VX bits, which it re-derives correctly from the exception and enable
bits in the restored value.

Fixes: bcd4933a23 ("linux-user: ppc signal handling")
Cc: qemu-stable@nongnu.org
---
 linux-user/ppc/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git ./linux-user/ppc/signal.c ./linux-user/ppc/signal.c
index a9c10e0987..ab1afea30a 100644
--- ./linux-user/ppc/signal.c
+++ ./linux-user/ppc/signal.c
@@ -420,7 +420,7 @@ static void restore_user_regs(CPUPPCState *env,
             __get_user(*fpr, &frame->mc_fregs[i]);
         }
         __get_user(fpscr, &frame->mc_fregs[32]);
-        env->fpscr = (uint32_t) fpscr;
+        ppc_store_fpscr(env, (uint32_t) fpscr);
     }
 
 #if !defined(TARGET_PPC64)
-- 
2.53.0


