Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72332C52D6F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 04:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shipf-0006Hz-Sq; Sat, 24 Aug 2024 00:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shipe-0006BY-9h
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:56:58 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shipc-0002Er-Re
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:56:58 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5d5bb03fe42so1901848eaf.3
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 21:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724475415; x=1725080215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHt6pbRW07xJLDMoO5UcezJiyi3YHPjGjTmMqWnnjc8=;
 b=TYKjv787HMBohoFXQIvSH3e7vWsSYiZb39lfob0KDWvAecIWXKCRl4sjFzXpJAfGuf
 Bep55a3yWnZumxKmZ4THhVydxHCi9jf0cQlAQBYDKuHcD6GB7tp1+7YJf747+cpdu6Fl
 f6ewSxUvzvdTEJZowAq+wxZsCK266qePeIlfAcXhS47nCEKi3NILBYLL5rMmGgaD3/8/
 GBqX3vVdnz8RySLokLDyKIzZBYvnZ7lh2z7IhGvq2LS9jucind9Bxt7AX8+NvN+XV0X5
 KrCXMaKh+iCa2L4mOy4wK1ToGsSCN+hU9pIcTOHumWQsV4Ew5CChLAM6fj1xGmIdeIYf
 lrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724475415; x=1725080215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHt6pbRW07xJLDMoO5UcezJiyi3YHPjGjTmMqWnnjc8=;
 b=qTmtggyrT7cjlCQ5RyM9bQXZgsTb+b7k/eoT0HKMbfcL6Ei9eUFhTwdPBU98bVPAT8
 In+FrowO7WKO5kvlhhN6ISl4feMsBJTqWpXlPa6Vm7wUxWydkDCZoyJ22lUyi4UWfFNA
 8Ql1Is6tsVXN4LbriHL0DrIT8XfQHhpnnu70dNmo/Jjb5CGel/+rvoTKSS6iYEnl98Hy
 G7jALSPo5o+SPQh6WQjRQco9RYcmFG7qdLe3GB3V4g5ZZUWmVCPrMlqwLvDQxkwRDny5
 V64PVmobjYH+asa/RVakimebmyoJnb+QwiRlHZPkzIOE3t2RtipiuQmtL16bdD2Stn0Z
 B7vA==
X-Gm-Message-State: AOJu0YzsrZa1pJEKRF7F7+ngFUSZZgHlCHljuTg47/nvN9ZpvBrnJtMG
 Il+nii9aILru3DFC66l3W1VY22d5jmgYh6Weji/2vuRRjWG2DaYdb0b3bd1eRvQ=
X-Google-Smtp-Source: AGHT+IEMPz2UEANsPdLwkbUgr0pLrGSu8dDju7pQJF68wDnwnXAjK6WmM7RnfvAa7/QiT/PXZv+hhQ==
X-Received: by 2002:a05:6870:ac11:b0:270:68e:34c with SMTP id
 586e51a60fabf-273e6552b54mr4849141fac.26.1724475415458; 
 Fri, 23 Aug 2024 21:56:55 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422ecedsm3805934b3a.25.2024.08.23.21.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 21:56:54 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 03/17] bsd-user: Implement RISC-V CPU register cloning and
 reset functions
Date: Sat, 24 Aug 2024 14:56:21 +1000
Message-Id: <20240824045635.8978-4-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824045635.8978-1-itachis@FreeBSD.org>
References: <20240824045635.8978-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=itachis6234@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index eb37b062a3..522cfc099b 100644
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
+    env->gpr[xA0] = 0; /* a0 */
+    env->gpr[xT0] = 0; /* t0 */
+}
+
+static inline void target_cpu_reset(CPUArchState *env)
+{
+}
+
 #endif /* TARGET_ARCH_CPU_H */
-- 
2.34.1


