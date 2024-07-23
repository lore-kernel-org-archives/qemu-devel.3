Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C498C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJxR-0002Pf-Bj; Tue, 23 Jul 2024 14:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwv-0001Hk-EA
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:25 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwo-0001Do-Me
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:19 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-376069031c7so21280905ab.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721758150; x=1722362950;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKGM9WxUN43+saolT8pUI05xHvMsh3XU6bG+jc3msxQ=;
 b=hlLf+C4beHtkT9fCT/JoDVVeCW8mgKuuj03OrHB3LNun0s09Jlnvh7hdelQ5hvEDZ0
 69lkEMn44A73xklZN8TrUwKk0AIJ6Zn2nmVvLiPPEzUpG4UCgdRMtFV25OZiSC+85eZm
 6NFlc1e7wh3teXm5ncW8RJRXOE3Y9gASfgnaDuyrEgobz8t8ragvhAODasLwtV+GKyob
 bMl/P5JYH0oSHZYykUC7yg6f9fADHyukSJ7LTGFzBK8uCSJI2XbsJc26LBYUqDOElJVx
 ptfDC7QS3OWZjfgWispLKKkev3nlO2t1JRF8zMujNsR6gfUuZ+yLckL80R4ra6DodJ2o
 2E2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758150; x=1722362950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKGM9WxUN43+saolT8pUI05xHvMsh3XU6bG+jc3msxQ=;
 b=WFuzz1DQtQK2icS4g6VlGfSZkmBUixWMYjuRx+PIppTu4LREr+iuRTQnZyHPjwSVPO
 eDunnd+81vWw9RlAbdK5sU9dJdHmTj/53t/p/9ODzwjRyZzpZERWeYgQRSFUIVSJr+lq
 8tntup/FZG7L63aQ7DhDaoQpQM+j92YnWYFqgjZtNKnjr4lqvnV/blPBuaEW7rW7oJ62
 qX56xRWjB/NezVWHziq8IZgK1GK269WZCAqp1T6kYW+4HPNd9O+uFXOf92um9r6YiF2Z
 bosENTzDO0CfHbouCTeVfgiC9PPDSTSJeOJPR8K/eB9sUktSrENyPGk+erp9VV9MuvoI
 c2QQ==
X-Gm-Message-State: AOJu0Yy/gFYFU2Ke05YPJer+C5qOYzx27jxok5bkTChCK5LFvL33bTeH
 3g8tG/9o2desCl2WfzE+G1n0NGqU/ntsAVkU21HC9xD77DFmG7koqBF44E0Lir6H2wPJrOilRDy
 NO3c=
X-Google-Smtp-Source: AGHT+IGbsUUhEiJEC1G3Fl1Gg/nabeaaMDK7/JM9PitUoHMoK17o5Fdym5Fu58UFP845dXpZSHqvZg==
X-Received: by 2002:a05:6e02:13a6:b0:398:54dc:1408 with SMTP id
 e9e14a558f8ab-39a0c93d842mr44229435ab.23.1721758150198; 
 Tue, 23 Jul 2024 11:09:10 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-397f7a2827csm33361775ab.53.2024.07.23.11.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:09:09 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/14] bsd-user: Make compile for non-linux user-mode stuff
Date: Tue, 23 Jul 2024 12:07:24 -0600
Message-ID: <20240723180725.99114-14-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240723180725.99114-1-imp@bsdimp.com>
References: <20240723180725.99114-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::130;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

We include the files that define PR_MTE_TCF_SHIFT only on Linux, but use
them unconditionally. Restrict its use to Linux-only.

"It's ugly, but it's not actually wrong."

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/gdbstub64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index c8cef8cbc0e..5221381cc85 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -404,6 +404,7 @@ int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg)
 
 int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
 {
+#if defined(CONFIG_LINUX)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
@@ -425,6 +426,9 @@ int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
     arm_set_mte_tcf0(env, tcf);
 
     return 1;
+#else
+    return 0;
+#endif
 }
 
 static void handle_q_memtag(GArray *params, void *user_ctx)
-- 
2.45.1


