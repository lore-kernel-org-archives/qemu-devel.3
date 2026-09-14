Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B824EC88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6EZd-0003tT-Ph; Mon, 14 Sep 2026 17:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZc-0003st-Bb
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:48 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZa-00019k-O1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:48 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c13f35cc24so310110b6e.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789422645; x=1790027445; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DyBx0xIjCmYzU71v3yB77Rqtpf2N+P8SW+R5eIAH76s=;
 b=jf83yIpAUoOxOzgUf263hYSiXB1Bh/geRpAbmNp9GPXu2lUHxigvtoDPZV6j7iumtO
 b3wH548wNwlGNSEh5glzH2UzZ7MkhtOQRw721bYJ4XvHC9/wSsI0JOrXzY0crTzl7Msd
 PphSALtHW/PqBHIlMO6ucgGaUXmbbHxZKFtN8ii1VkBp6bwlcFgqJibFTVxQRtwhpqi3
 EhKt2DQNJa9LYeX4o4EdYU11ebJ7p5mKILDIr35mM4rGrJ4no0JMqvHT3kg+ryXZTUid
 sw8HnxttCJ+S4pBA7Lr54fysDD2cGJsFJKJmfYdyMc/Oyv/Yf/MrxT42IdWnwGP5jMl2
 qdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789422645; x=1790027445;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DyBx0xIjCmYzU71v3yB77Rqtpf2N+P8SW+R5eIAH76s=;
 b=u5ZLCINs+A2Jt2R70U0ZfwUZey1OCjMizsnBXcC/KCUebCRmm6Xeq8yEJbtMJdcdx2
 87gOYU7ttz2ZENUKubF0tfNtxK9fLkLMRDpbykZnxkZO1FrdpnVsHG/GqEk6HiqLvt9H
 QPZY0vZqpl7h2YHM7fTT3jrrMyl/niqQtdeY77k0N9da8W6AS2O1+fvx42hX4mrXcAX4
 CLvEInN5JJ8xGwPfoiaN9zS5jpeXoGKpFnr4wHPBaQaSNR+Gaotycv0g360SjFODXvjN
 8uXch3Zez0xyZPQNmNRr7Gi/8/rE1dh/kxvYc146MhJrLQnxkMQ5tZVzKX8hbWyYTret
 mPIA==
X-Gm-Message-State: AFuF++llXWjczb7TWFamqichYy97lNlFMx6FZbUFBYSHHFmuSAHCyg2z
 13F/qGtMFxxqMlOKHquCe9jwsWrDXRsOCdESj8/siR0BMVfl9rftQetIIAurnbrn
X-Gm-Gg: AYBFou0q7euDGszE75GhbKFVCLfjd3xkbDgoMgEPBB3FKe2Vubv74/9P1bmXg1QlOQq
 ugNmYlzUTUNaiwrWaO4Eknik6KncrmSvmV+JUwN2KYDPhBFEqFE0hRx/qpLOX1hX7PKzpRf55hQ
 qIbfZ4GMWYVKtoJ+xivVWDLeQkOK2IJxewD8Ix4zFZiwMTvNGU8ehNtXjlKrpdEPnXM1jhYJp5J
 aH9SHEQtQfnbWm0fa/IPDrG11fRdV1UTeE7jFHZjv7BTmV4lOm2vuT+SaltAA6Wz5TPSjHndwXc
 K9mdZ7MlhYtqbabDMc2ePAixyUCVytNTD7TKFV1BJqr0aXKSzt8YlVsHVBYSv5z2Arv2nMPYXQg
 oTcDFoOzXQ+jLe++KX8zLEncRTHlAEtf2jDs4lwq6Ag6A/CU8KBfqr5umXFYdxN46Ztg6WAqylZ
 IzqYBnVA92n0wo3BlmJQxBZlzDSxEKveoLncLPng7mEdvzvBdl+AeGbUniv9blVSzPAXVA8wysU
 m/nkSiZ71gQZoVXXE5xGGp11mOYOU463hz/DUm1mR21SYWpg2IHs5KDnmt20k4i
X-Received: by 2002:a05:6808:1642:b0:4c5:6a01:210a with SMTP id
 5614622812f47-4c8a13fac32mr608042b6e.17.1789422645588; 
 Mon, 14 Sep 2026 14:50:45 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c4a2504bc4sm8937163b6e.17.2026.09.14.14.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:50:45 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v3 03/10] Hexagon (tests/tcg/hexagon) Add tests for
 multi-destination instructions
Date: Mon, 14 Sep 2026 15:50:29 -0600
Message-ID: <20260914215037.157879-4-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::11;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Instructions such as post-increment loads define multiple destinations
These make it harder to detect multi-write conflicts

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 tests/tcg/hexagon/multiple-writes.c | 60 +++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tests/tcg/hexagon/multiple-writes.c b/tests/tcg/hexagon/multiple-writes.c
index 8686317fdc..4305903547 100644
--- a/tests/tcg/hexagon/multiple-writes.c
+++ b/tests/tcg/hexagon/multiple-writes.c
@@ -143,6 +143,62 @@ static int test_zero(void)
     return sig;
 }
 
+/* Test multiple post-increment writes to the same GPR */
+static int test_post_increment1(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0x9b004021    /* {    r1 = memb(r0++#1)      */\n"
+        ".word 0x9b00c022    /*      r2 = memb(r0++#1) }    */\n"
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "memory");
+
+    return sig;
+}
+
+static int test_post_increment2(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0x9b00c020    /* r0 = memb(r0++#1) */\n"
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "memory");
+
+    return sig;
+}
+
+static int test_post_increment3(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0x9bc1c020    /* r1:0 = memd(r1++#8) */\n"
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "memory");
+
+    return sig;
+}
+
 int main()
 {
     struct sigaction act;
@@ -164,6 +220,10 @@ int main()
     /* Illegal: zero encoding = duplex with duplicate dest R0 */
     assert(test_zero() == SIGILL);
 
+    assert(test_post_increment1() == SIGILL);
+    assert(test_post_increment2() == SIGILL);
+    assert(test_post_increment3() == SIGILL);
+
     puts("PASS");
     return EXIT_SUCCESS;
 }
-- 
2.43.0


