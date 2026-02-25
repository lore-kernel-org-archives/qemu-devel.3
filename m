Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52983FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO9j-0006iB-TH; Wed, 25 Feb 2026 18:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO9g-0006bv-T3
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:58 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO9e-0003MQ-Ng
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:56 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43991cc3155so210318f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061533; x=1772666333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9QVxu1A064iUxwpVmsQIbDTx89e1GwGXO7Kjzj1g25o=;
 b=C6NyH98PLTRHJDEMiEgZVfeABhtKvC/xlANjA9KuTMM+Sp7mdKX8bNXdUszfsj9YEd
 YWUlajw4TrGu9zQ2r41TYoTp3isVc1C+rQ5Oqr/0sprcypHgNYfTTywcYnY5RwrbTFZ8
 phE74e7GyPVUjdvNjanxQNsg7DBpHREmAfzf/zvmMg8I7kcr//SSgLMd3ojBtV8NNwPM
 Gc2iAYs5yhJ8BDcCVo+f7uPmDpQzWU4sDt889RZjhcQm3jeWidSWjhfPof8MHb78XEGI
 JdUOsfKwM8idOzfab7NdEpB7A2ldMKOv4YjM+63q3pYhaVoViDCU0KPuekIT0qBAFQ+E
 tstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061533; x=1772666333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9QVxu1A064iUxwpVmsQIbDTx89e1GwGXO7Kjzj1g25o=;
 b=fCmQOM3eFFzsGPhjhcsDfZkuxMKKKHSn+BPBERiJns7BA1tFQoX5IFMMTxSB2ehMDr
 258H3PX9v1Gt1GcphO8p2Q42lPEl7IcAu1F1pZr0eb46JBw6JFCgtOOpaPj+l5QgBHz2
 LVKFl7z8KyMJBJ6ytHWbcNrJ8c9O/uWqnckQSUY+vvFhf/I+e2pLQJH9qjqu25ZeAkbl
 W3R6F+s9cNS5wOgfLk0wihQ40CRvXo6qiFXM1Oqa6tTPpjZRuX5QyYN8LezZTC6Ju0xC
 +lhlWN9+jcIrLPbkdPe3Rd4MSMMvDrNStj+A4Sw8Wnt/KNnCfm3D3N6IZF8KfIecUFh1
 YbpA==
X-Gm-Message-State: AOJu0YxCXg3d66PxCOdyJnO4KNM4RRIIdfQSCUIZQTUVhSmfMvdbIt+m
 OGfyCHlttfJxqZnrkkd4WAQUu3e6w/lVlBXAvfErCBrOZL7LEWDnvpUayw/uKnjH5w8S7EjvnGP
 sIYKjOD4=
X-Gm-Gg: ATEYQzxFSTXS1+39QBRAl2BwGf7uhVOl3r5qw4QXIxkqdzAGH6FFloUpNTT1DMtq2XJ
 YxK8cTpelRThYy2OIX/LQKaQaJPrW4wHqNKJNg0rlbR9xUMRhcpgsk6PptYUMneVUvhC/up+dkI
 h39WJivrz/rMJUnGKGkSlLj/jrT6BrkUKK803S1ezhJhM3qyvgCJ78fUpXalAKBuXuKFc84PskX
 20ztIc2hahxm7b89C2qGMD6ZbKKtNRfDgQyAwQTt3lafXwt+c/G0Z56mlQg83DWUKen8udcDNc4
 oJPlu2qq4IpvYdMb4mB8nyeIXqXaONGSGqGa4J3LnRa532WPccoD6hAjPfGUtim3MMeLlgtx3ir
 nyuFC++OJ5/w4tprr4myjEMwTC4RSv9JnAv6qFxN8sl77jlTdxxVtcogVO1YhEGks3p1RqctUyZ
 /3MAUxTs1iMNgqGSPd6u/Fn56/PNxT7sQgnQ6Kv8OPioowX5/78YdsMrZvsW8uzbLz27pvFYiJ
X-Received: by 2002:a05:6000:144d:b0:439:9799:dd4a with SMTP id
 ffacd0b85a97d-43997f316b8mr523341f8f.27.1772061532695; 
 Wed, 25 Feb 2026 15:18:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d3fc12sm35205327f8f.24.2026.02.25.15.18.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:18:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/70] target/hexagon: Expand gdb_get_regl() -> gdb_get_reg32()
Date: Thu, 26 Feb 2026 00:13:41 +0100
Message-ID: <20260225231411.96482-42-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The Hexagon target is only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/hexagon*
  configs/targets/hexagon-linux-user.mak:5:TARGET_LONG_BITS=32

Mechanically replace:

  gdb_get_regl() -> gdb_get_reg32()

Reviewed-by: Brian Cain <Brian.Cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-34-philmd@linaro.org>
---
 target/hexagon/gdbstub.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
index 12d6b3bbcbb..b9856cfc978 100644
--- a/target/hexagon/gdbstub.c
+++ b/target/hexagon/gdbstub.c
@@ -29,11 +29,11 @@ int hexagon_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         for (int i = 0; i < NUM_PREGS; i++) {
             p3_0 = deposit32(p3_0, i * 8, 8, env->pred[i]);
         }
-        return gdb_get_regl(mem_buf, p3_0);
+        return gdb_get_reg32(mem_buf, p3_0);
     }
 
     if (n < TOTAL_PER_THREAD_REGS) {
-        return gdb_get_regl(mem_buf, env->gpr[n]);
+        return gdb_get_reg32(mem_buf, env->gpr[n]);
     }
 
     n -= TOTAL_PER_THREAD_REGS;
@@ -56,12 +56,12 @@ int hexagon_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         for (int i = 0; i < NUM_PREGS; i++) {
             env->pred[i] = extract32(p3_0, i * 8, 8);
         }
-        return sizeof(target_ulong);
+        return 4;
     }
 
     if (n < TOTAL_PER_THREAD_REGS) {
         env->gpr[n] = ldl_le_p(mem_buf);
-        return sizeof(target_ulong);
+        return 4;
     }
 
     n -= TOTAL_PER_THREAD_REGS;
@@ -81,7 +81,7 @@ static int gdb_get_vreg(CPUHexagonState *env, GByteArray *mem_buf, int n)
     int total = 0;
     int i;
     for (i = 0; i < ARRAY_SIZE(env->VRegs[n].uw); i++) {
-        total += gdb_get_regl(mem_buf, env->VRegs[n].uw[i]);
+        total += gdb_get_reg32(mem_buf, env->VRegs[n].uw[i]);
     }
     return total;
 }
@@ -91,7 +91,7 @@ static int gdb_get_qreg(CPUHexagonState *env, GByteArray *mem_buf, int n)
     int total = 0;
     int i;
     for (i = 0; i < ARRAY_SIZE(env->QRegs[n].uw); i++) {
-        total += gdb_get_regl(mem_buf, env->QRegs[n].uw[i]);
+        total += gdb_get_reg32(mem_buf, env->QRegs[n].uw[i]);
     }
     return total;
 }
-- 
2.52.0


