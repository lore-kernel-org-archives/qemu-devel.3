Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3E3E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 23:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTqvx-0007jL-7n; Fri, 03 Jan 2025 18:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTqvv-0007iz-EK
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:18:23 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTqvs-0004Kl-Sk
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:18:22 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385df53e559so9964141f8f.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 15:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735946299; x=1736551099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFgkKamr5QeIwstbRr7Q/p762wUgXwLu6RDwYB0Omtc=;
 b=wXmEtYwpUMEXiLKSfOddrl9CtuYv1JGRQNJdlMuIaFnn3t/dbsd/YMXZka0bixAGxX
 YJg29PVXP+n8S5JWwHUx6SLYXeUTTFxZdKt0FtFCIlvKly4Ui9X+FqzvoZSp1zn8KrZ2
 9H5v0lFMSSgBWmTbOSGpnAaWIAAUTOaHKlGsKzk0qlcAGZdl+Zd9wQIAxrz6Z/c+dQ2h
 jJz/+69kznjx8tJpvl3eT27EKvX9QMazZmVL8fSs2LOlEETus/JLSM0UwLZo0XqjDaUb
 O5vUphD24q6ZQmGzfRYqGRWx763EtXIezJY+VN/dWCaQbWZEzIf8dcFJgEOFncS3uVvw
 /0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735946299; x=1736551099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NFgkKamr5QeIwstbRr7Q/p762wUgXwLu6RDwYB0Omtc=;
 b=t2n7aLFY7iv2W2hBWq5Jzc2+sKJJ+sQfq5RObdTP1yyZVaxqeYq/ZJJ+mo8FhhLhSg
 k7B1/coBx3VhrRHG3nM31nsNr3PM+epUM+sjuCXuPhfOSKYLNYDiH8uCqjseKoZrD8k6
 cqx2vzELo6ya1GgdAGFbFgq+dBxaZQzv96yHjLkkD1BLBTm6jXuac0cqf1Z4Hx8QGzVZ
 lQjn5gakdzre2nUvOCh008Kss72YApoJBhaGHGPPnn7fBFwu4C2AC4iugP0Qy0ZrzljY
 QUlmLDF9B1tJddjfQcrSDzDJUArob020F+hUktiWDQ3SSekoWogFUnwACBkok7L9fP//
 wmiQ==
X-Gm-Message-State: AOJu0Yy/Ldu1LG6jQjoIpLuwXi9VF8IcSxtkkWYGmv1Zk2a1QdF8WV1L
 l/j1lPd6FsyA5rdUfsdMrUkflTLi8ni0KCu2ud5IhQh94ojJqtn3IZepk8Y7oDZOaVniMG0XpnD
 QDfU=
X-Gm-Gg: ASbGncshij/ql4RqlGGUw+F598Sps47yfbsAcr+YIOI1qACNqlfIf/lGe3Na+QgI6HM
 fYvZUViokp9bdWJSjq5BPJI7qjatGcEcUt65nJiUQpdnmXiesFRRdRIFqVdEN8yG3TstFwn64N3
 YplAs8I+mWw62OZ1fmE7NMxd8szAFW383/v5bdg3W+XslNH2WKWYSowvxv1GZij7vGHUOIcw0px
 I/EcBNe2TpgpFrsqkkeRwIeZrJ8nuMO4LioZxWOp8hGE+GCln83BsYPqCJObs31nKpbitLxPH7T
 q5NSIVrtRbwI/QvWA3gC1C1G547+zMQ=
X-Google-Smtp-Source: AGHT+IEELyeRPCxWvjPw55To1sVaG4rmYhgqPjLZbhNjea9LVY8pUjkiArH7cSW7A3cNDMnoXhekuw==
X-Received: by 2002:a5d:64a3:0:b0:385:f527:be6d with SMTP id
 ffacd0b85a97d-38a2240074fmr41498707f8f.36.1735946298953; 
 Fri, 03 Jan 2025 15:18:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a2e25edbbsm34109746f8f.110.2025.01.03.15.18.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 15:18:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 6/6] disas: Select capstone targets by default
Date: Sat,  4 Jan 2025 00:17:38 +0100
Message-ID: <20250103231738.65413-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103231738.65413-1-philmd@linaro.org>
References: <20250103231738.65413-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

When capstone is available, we get ARM/X86/PPC/S390X
disassemblers in common_ss[] for free.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 disas/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/disas/Kconfig b/disas/Kconfig
index 1d2c397c953..8af8ecd5c81 100644
--- a/disas/Kconfig
+++ b/disas/Kconfig
@@ -3,6 +3,7 @@ config ALPHA_DIS
 
 config ARM_DIS
     bool
+    default y if CAPSTONE
 
 config AVR_DIS
     bool
@@ -15,6 +16,7 @@ config HPPA_DIS
 
 config I386_DIS
     bool
+    default y if CAPSTONE
 
 config LOONGARCH_DIS
     bool
@@ -33,6 +35,7 @@ config OPENRISC_DIS
 
 config PPC_DIS
     bool
+    default y if CAPSTONE
 
 config RISCV_DIS
     bool
@@ -42,6 +45,7 @@ config RX_DIS
 
 config S390_DIS
     bool
+    default y if CAPSTONE
 
 config SH4_DIS
     bool
-- 
2.47.1


