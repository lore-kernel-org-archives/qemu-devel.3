Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF15C3ABA1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 15:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spr8o-0005q4-2g; Sun, 15 Sep 2024 11:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr8l-0005ir-QO
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:20 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr8k-0008Ag-Ac
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:19 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-206bd1c6ccdso21719305ad.3
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726413976; x=1727018776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eb2IXxxnHK/KXo5R/L/8Ek9ID/ZcfvZRBf6/jcc1+Bk=;
 b=hIBDRPPnbzNdCb8G6jxAHPEfs2tLKr2om5BrF5en2+Q+n+hekSfRfUTDuTfRAEnxAX
 2Q4RmeCZICJ99OK/zGKEVoQnGJOylDX3ulYl4YwfX/wliE9S8672RYrZDnbMYIWlFXyH
 WnAq55o6ek3H63vjBSBxQ0cPa75KQeyv+VMADalofqBPCVBnREK/+XC30nvwXxtH+fqv
 MddiUu3T/6//VizHojRDlrkIA886jQkYxmto2SrAqDeqqkWBjBZMl2GrDUl1uWDyaO+t
 8gyTHq3IjwyR+IAxErejdsC8sXA7ChWyGGFoH1UdLmRvIfL770crsHHtllBeLFmiHpvo
 xjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726413976; x=1727018776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eb2IXxxnHK/KXo5R/L/8Ek9ID/ZcfvZRBf6/jcc1+Bk=;
 b=AWrC9HieyDWcQvsbZJSfGeQR5t/9Wg3QLMc2Kv1JFtG3tsx+DVv5OvO+VYQwVoSOcP
 M0spfg19G0iU2GgLPAF5fr900v+cMDuW2Yq9nZr4rTZ+rV6NIgeJ4dPTs9uau9bs+agv
 pbgPRvRx+gsSeON4rt9KC0TvByWcD0ApbQc3nMqGvfHSmzF8vafgGFm8fCJE8n9JQ1vp
 8U2et280AP/7VGu8UMu8/tq/kf7a+CG1H7sUISKeddGDsvl6uuEfKXKvVLn1+bB4ROOd
 guSWydBDqoxAX8ephrKreeptfPfzWNNBQ2CD+AjQsgVUPvTtU2V0N4yxwMXT7bsM/vGz
 L11Q==
X-Gm-Message-State: AOJu0YxwngERuUwIslAO/eLf0RHABP9aUFoh76MseWm118G51XAXL4C+
 aIBoTSEVB1/iB3CiJ3vPJe53ao6tOR2dmDMXh4E0ZTZiROj2N6IAK1op3Q==
X-Google-Smtp-Source: AGHT+IG/48QqgRMsYFaXeTTCbS2v8BzJyBdHbUbjsek2zFWROOTnlx/wkIvZ+t9QvkS9ZtL9MwFTZA==
X-Received: by 2002:a17:902:ebcd:b0:206:93e7:5845 with SMTP id
 d9443c01a7336-20782b85109mr111520465ad.59.1726413976239; 
 Sun, 15 Sep 2024 08:26:16 -0700 (PDT)
Received: from localhost.localdomain (14-200-149-22.tpgi.com.au.
 [14.200.149.22]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946f34c1sm22554335ad.184.2024.09.15.08.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 08:26:15 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 03/17] bsd-user: Implement RISC-V CPU register cloning and
 reset functions
Date: Mon, 16 Sep 2024 01:25:40 +1000
Message-Id: <20240915152554.8394-4-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915152554.8394-1-itachis@FreeBSD.org>
References: <20240915152554.8394-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x633.google.com
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

From: Mark Corbin <mark@dibsco.co.uk>

Added functions for cloning CPU registers and resetting the CPU state
for RISC-V architecture.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_cpu.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
index ea2a8d1ace..57abfbd556 100644
--- a/bsd-user/riscv/target_arch_cpu.h
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -130,4 +130,18 @@ static inline void target_cpu_loop(CPURISCVState *env)
     }
 }
 
+static inline void target_cpu_clone_regs(CPURISCVState *env, target_ulong newsp)
+{
+    if (newsp) {
+        env->gpr[xSP] = newsp;
+    }
+
+    env->gpr[xA0] = 0;
+    env->gpr[xT0] = 0;
+}
+
+static inline void target_cpu_reset(CPUArchState *env)
+{
+}
+
 #endif /* TARGET_ARCH_CPU_H */
-- 
2.34.1


