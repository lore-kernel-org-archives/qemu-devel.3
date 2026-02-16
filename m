Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088A3E8383F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 22:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs7Tc-0004LU-3L; Mon, 16 Feb 2026 17:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7TX-00049e-Vn
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:53:56 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7TW-0006se-GP
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:53:55 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4362d4050c1so4189351f8f.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 14:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771282433; x=1771887233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFudOc/oMxtQlpMgDNqOz0GyKx9jheZ4E4APiNB+NOY=;
 b=qL9mvDB71syBAnzcgzHtG+4rO+KE+zKmj+nX59yN3z0UQCOT/w1dkVblCHQD2K4LJe
 dFwbmtTks3Q6/CfsZWft5XbRC4IHdglm8XYpJNlmVRGZ0jBl2pc79BSPra3NRTFRvy76
 JiBm3I0gMz2KjBkEkgnureG1Qq09WktB+nlnuDGvhBaksnhFrKxDdKaVYoSTaDZui2dT
 aCgx8S2w7qLjUdRg1WD9gqjKfheRa4TF5Kqn9Hi1/3+3BkBr66c3p+yr0D5c+0p/iT4l
 pNqK7hp8188CiuhnhrXGVEaY3/ifL7+SYVGNVLQ0Cn7DHoM5pGMRoRJkJHVnkZj3uKE7
 k40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771282433; x=1771887233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uFudOc/oMxtQlpMgDNqOz0GyKx9jheZ4E4APiNB+NOY=;
 b=jFjS9sOGSIGQUfrPrCBgbrUiXW5CPP3HWDXgOMFJFMMoXGc07KwSQ4Rl09UuLw6nsT
 I+gOVFjBO/BKYxWmTaZodxsfjz8gmwAQO4Izg9fym9y3B0cNyk/xhMch7Tb+3VaRAGsI
 RQ3iJGW3BLGuc6sgarYMEHQK2tOfYp8F8Fhkz40IKQhAUfBc0vY+A2PgOcpS3hl1vbWr
 37JSVSihB/Qt3oC1qm+QTof2McRd3pSFpLbiE7kSE0FWYDyzekJOeGD8CCzSGvTaq5da
 vPHA4/hlm4vLxTunzQ2zPu0aF8kgPRKPLAsSeIswt+K8eZ893UM+3PYvSfKYL8GTmJei
 xVtw==
X-Gm-Message-State: AOJu0Yyie5mOyYdhMLbUh+r6iOtjYhV8iW9vCW5fNB9NTDFP87W8dl6r
 zETt/pH1bRVmbdjZKEagdBzzFitytLiEKFl1k/roENKlxiG0YPRkwkpwlfd56VLNi7NYoGS4Z2r
 0Tn291n0=
X-Gm-Gg: AZuq6aIcBoAgPB2BYIPGkOD9Yv4Ypj1RZXn8ZMXMHUjvCUjYmuxIKAIcl6ONmsapF95
 mbZHeklz9/+Xz9QM7wL2kdsnvcTp67cvZoxnmnXDd6sIzDnqCGHjj+IXDZ5RzDql7e698iuddqB
 epOFTXz/qbf0EcE8Q/RHXGFp5x081eDhn8rY/UeMZQOiZMzlpggouX1+XeyJQZG5iXzcShIdArI
 Lnhu1Y4tBsTdK7gu/9gUWQmxnze8aMnOlzDLn9SpLHcxJJnfbv0JI8bWF/e6FvRyFqlIzRE2XSy
 kzksuHUiOLrZcOOw5+2fqK5ZeWiN1OeUuXSG1Y7fkMeFwbBNsb81BW+n9+q5zYKmTW9/NLsl7Cb
 uz9SUXu/y6Eh0cT+j/dcZBEKQpEHw2hYnFyrZtdFCvwtgFYxj0mv0niSqps6CLq+WSjpMWtUjMa
 bGR1DLA9phMfweEHZleKVyQJAzN4jXePKBGsC7gI3jmojmr4RFypTT3DJ6JG/I69kdv5logqJ8
X-Received: by 2002:a5d:5f54:0:b0:432:a9db:f9a2 with SMTP id
 ffacd0b85a97d-43797913b92mr20541061f8f.41.1771282432575; 
 Mon, 16 Feb 2026 14:53:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5d156sm33100660f8f.5.2026.02.16.14.53.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 14:53:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, unisono@quyllur.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org
Subject: [PATCH 11/11] target/ppc: Remove MonitorDef register entries
 available via gdbstub
Date: Mon, 16 Feb 2026 23:52:27 +0100
Message-ID: <20260216225228.53959-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216225228.53959-1-philmd@linaro.org>
References: <20260216225228.53959-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All these registers are already provided by via gdbstub parsed XML
and handler by the gdb_get_register() helper in the monitor/hmp.c
file. Remove as now unreachable code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/ppc-qmp-cmds.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index 7022564604f..7dfa78c2e0d 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -93,16 +93,11 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 }
 
 const MonitorDef monitor_defs[] = {
-    { "fpscr", offsetof(CPUPPCState, fpscr) },
     /* Next instruction pointer */
-    { "nip|pc", offsetof(CPUPPCState, nip) },
-    { "lr", offsetof(CPUPPCState, lr) },
-    { "ctr", offsetof(CPUPPCState, ctr) },
     { "decr", 0, &monitor_get_decr, },
     { "ccr|cr", 0, &monitor_get_ccr, },
     /* Machine state register */
     { "xer", 0, &monitor_get_xer },
-    { "msr", offsetof(CPUPPCState, msr) },
     { "tbu", 0, &monitor_get_tbu, },
 #if defined(TARGET_PPC64)
     { "tb", 0, &monitor_get_tbl, },
-- 
2.52.0


