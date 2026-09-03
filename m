Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4E5C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 04:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1zLa-0002p4-93; Thu, 03 Sep 2026 00:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1x1zLY-0002ov-JU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:46:44 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1x1zLX-0006TX-5f
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:46:44 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3964dfb5a69so2643833a91.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 21:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788410802; x=1789015602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i3g73XDbayun2RDRE4Z2oQdeeiZiLVapMTAbvYIdgx8=;
 b=LEVUtaQEYDnPZ5c42D6KESlsYpeQoJlI8L39wvyJyu4Qo123IaHm9RHzbyvHFKvfRo
 LFouz//7FwOgYhMjB7NkoYgdpKZ8yzNCaDheZCB57qz+97ugqaa55jc3UtjreSUrOKej
 C5JsX6pAURpVTYKIXVjT3Cv4O1Dh7PnoWvLFOFgeX8PbCLMW80lYgb9/F0g5taKrSFME
 8aqLt976I2Z5WdHI9caOhLF2qR3zbmP1LA7YV2qDlB3qodJGuTTW14cdKA3GsF6zhDaV
 nFTOTaN+CJcxNz0mMqA1r2tb54+mEi8Wgd/QyPMmYqbFiUV7NQ0ntl5/zVVEyF+zDGpa
 H6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788410802; x=1789015602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i3g73XDbayun2RDRE4Z2oQdeeiZiLVapMTAbvYIdgx8=;
 b=QE3CLgN8lSdet5pxVS5TnhwWeDti63bSNKTBvoIBHgSQE+1rr+17NgEoJQYegb8RQK
 u3jK1tjIIj9pOKvWgFMWdLZsBdigVNFJ/uQmgQzmOpaoGzADPwEHClt6k7YSbDtQkJXz
 WNvKGxaQuD+SZvQkUNocGzaEsaRUVuA40DuxOIDYUPrTZEC/Q4mFtULzE3Tl9z+3rg28
 C6YNc6Ncxo25aCOXOqMnqosJ2dqERHQaIuyB+mIB/Bgys1MmIHu/9haddGz0NySdWwGA
 pkkcG5LkaGIbd/fhD9VutzIXRU5wcyyL/1KO+gj8WGMRhOVfgEeDatGR5xuYYu7ijjzJ
 I+qA==
X-Gm-Message-State: AFuF++lNqVCETWfOKjD9I8St88kzTXyS9Ibsp+va9fJVeyqvleKJnl9e
 AVRrm1MxuBxNMbyT+bPhl2UeWoqOblnlX4VV5gfCGwmeltrvjxxprhTEVMCNPMgG
X-Gm-Gg: AYBFou2cGf9Ssyn4hOuSdyk7JqrUIuAoWv5RFTIHe1z3WfPhVrKIhTxb9KdIu/GSC9b
 qkMlJ5iBqhlpSvjvkN5jRAo+LxhLMJC4esqC5bU7FL0YTBORe9zfc8sRqH9f17b3A8qWFJhzF0A
 SIZ0ng5OzXGLx9gLVOou7Gt8b9hO4hX86svxsPcpjLN/m/Qc+AjZuZq8zpgiE4zz+GS+Ls3zbNY
 Y8MkWkjRpjQlUG9I1YfnAC1nGQ60FLTkOn8mKnyO8UdH9MaRHY+RSgv2IwUbsC2oQRcfxitaRPT
 ZxgSE0gendM+nlDk4yedqFs09TqhBnnKPdFf3PY7C8fauUeH8UvI77d9SH468JFJaN4A7XIUq48
 e6cNG6ywdQ3tTqHN0jxxksOkC6bxVa8Rbz7NC8hJ6Zd2Ee2W3GC7J6R2EDAgbHTqDvhE1iB3K7d
 CtUYhhjFZ78MrzS96mXQnzydJxRUcXXcVmLSRDbmRjzdwYSXi6e+igtIsWhisJrjSNE7MSMDq64
 mH+c0CVVJ6Vk1YZ3A==
X-Received: by 2002:a17:90b:2752:b0:38e:4cb:51f with SMTP id
 98e67ed59e1d1-39aee00bddcmr15550653a91.11.1788410801776; 
 Wed, 02 Sep 2026 21:46:41 -0700 (PDT)
Received: from localhost.localdomain ([76.133.142.170])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431994db8csm2337726c88.9.2026.09.02.21.46.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Sep 2026 21:46:41 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	balaton@eik.bme.hu,
	54weasels <54weasels@gmail.com>
Subject: [PATCH v5 1/6] target/m68k: Add dummy CAAR register
Date: Wed,  2 Sep 2026 21:45:14 -0700
Message-ID: <20260903044626.24453-2-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260903044626.24453-1-54weasels@gmail.com>
References: <20260903044626.24453-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=54weasels@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Why this change is made & How it will be used:
The Sun-3 ROM expects the Cache Control Register (CAAR) to exist on the 68020. Reading/writing this register currently aborts QEMU. This patch provides a dummy implementation that simply ignores writes and returns 0 on reads, allowing the ROM to continue booting.

Impact on existing functionality:
No impact on existing targets. ColdFire and Mac targets do not access CAAR in a way that currently aborts, and providing a safe dummy implementation ensures robustness across M68k boards.

Signed-off-by: 54weasels <54weasels@gmail.com>
---
 target/m68k/helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 5f91d206f5..68f523ea84 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -281,8 +281,10 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
             return;
         }
         break;
-    /* Unimplemented Registers */
+    /* Dummy implementation for CAAR */
     case M68K_CR_CAAR:
+        return;
+    /* Unimplemented Registers */
     case M68K_CR_PCR:
     case M68K_CR_BUSCR:
         cpu_abort(env_cpu(env),
@@ -385,8 +387,10 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
             return env->mmu.ttr[M68K_DTTR1];
         }
         break;
-    /* Unimplemented Registers */
+    /* Dummy implementation for CAAR */
     case M68K_CR_CAAR:
+        return 0;
+    /* Unimplemented Registers */
     case M68K_CR_PCR:
     case M68K_CR_BUSCR:
         cpu_abort(env_cpu(env), "Unimplemented control register read 0x%x\n",
-- 
2.50.1 (Apple Git-155)


