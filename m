Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DD6EB1076
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzPk-0003CL-0u; Tue, 10 Mar 2026 11:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzP5-0002pr-Um
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:53:52 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzP1-00069T-OD
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:53:49 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439a89b6fd0so9618871f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773158025; x=1773762825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6mhKW9cyui3RXBaMvsXOeklQUvgkDOQLWXx/oKD7aQ=;
 b=eJKM552mdVFaAY32QiV2Yoqx9LgagrDhXFP6xcqN/eFe54daAyxscIW2hO4iHpOH8j
 CxTP/XOOS+XBm209undrtlMcJtw8qNAiHJAN4jVxYc/ksBte+NeSy6tnbzRj0hbQlcG+
 rGXUG5xLhKT8ck0f2XPkDJztgNYrJz5tr3nbfk1tpBgYfjRvEQapGD7bsK6jov+9ErlL
 ncQ5kc98PkrLOyEYj10Qr/DAgGm3ED3m1LlnuIsD9UWL7DQDueqCmI4mgD+C3ix1MD6W
 9rsBUNhMoxgc6WGD9RjVfuYClQJZ31ZinQ0YPr42SVJtbAYb5IivIsmeR04sbLjedbjp
 1GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158025; x=1773762825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C6mhKW9cyui3RXBaMvsXOeklQUvgkDOQLWXx/oKD7aQ=;
 b=ZmJ7e7X8zLGYaLIUVvdtpX3tbHfGi63zeZgyNT3ENAi1nQ2wOWeTH8RH4o6K2El3Iv
 ZT85DT3QMpKibBqnVoplurzWsvNEHMkbcQzI9uZIDpdF9OpmIv3kl6nSAXL23ZS/IBkf
 /5hWsO7ahZxQVzPIePkAH2HrRsXz/77xtvsAaqTDvERSX7bvEQCT7tHZ2z+0cMvJAPUy
 mMHOqN/5OagQ9nLjXPi40eldQaZfifkETqecARavz85h6zg/fpYOuarDvhiGSOW8tQ1v
 VHlhq9w5DlUE4AmYeqb1R3vOmr6kRip2WqjpF1uKTMXM18ZVIalXVw6ntNpKCwhQj9g1
 t9ew==
X-Gm-Message-State: AOJu0YypYngIF0mdV8hyJfOQlKvc2GqMKPiffKYP6j97z8CIO99DoDng
 YOeToaodKq4VEk4uo/PxhdKfbLGt1wMIWxon2HSx6Dt2ioNRBbtxm0UHcQrLS4SvEaVy679hdeY
 yH+l6etw=
X-Gm-Gg: ATEYQzyxxH5H7TnU1Hwy8sxRVVe0vRQoTN6r5YchA2ywi7iwqdt/kl80OeFySZR5K1j
 bhErk4OzUgxiBhVbEA67jo9fEFiBNfxSB89dCJzOOG0LdMN/nBatC+UXV0B6COql5UVTp/wHfqb
 gI8f21iiboY/9QhwbLwyNbMqOJlXwDqMSf4JuQ3+nnr9Zsakpi1uLr0PcRb86c0/C4sZY1gzh/0
 8Ps8K0A7QMRJgah7MuecadbzcGMBtwK653ydV7WFgS97DCr6ZRNhS71eUesYc+8v+HucL06BbYd
 d1PwXpL7KgJxXGGAoFT4D+KeM/zr7/i68eGyKT0xocNzSdyXPKjCYFpEGkXD7r+mpjCSYA6GrqF
 osjklnqOLNDAW82aDQsCltfjVDCgygtIRHfzLzbxct2SMSfheRQ5Q7OLTMKbn+CXEdoigyhmQ/Z
 GA3eCHz8YWfBaaCemof1pFwU+ovm4bzziesT++C8xb9NeUaDxaFGny9GY4pBG21xr8mcwAxW2H
X-Received: by 2002:a05:6000:2902:b0:439:d8e2:9a3f with SMTP id
 ffacd0b85a97d-439da89fe7amr28417989f8f.56.1773158025399; 
 Tue, 10 Mar 2026 08:53:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadb29fdsm37044857f8f.16.2026.03.10.08.53.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 08:53:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
Subject: [PATCH v2 02/13] target/i386/gdbstub: Remove stale comment
Date: Tue, 10 Mar 2026 16:53:18 +0100
Message-ID: <20260310155329.48772-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310155329.48772-1-philmd@linaro.org>
References: <20260310155329.48772-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Since commit ecd6f6a8820 ("gdbstub: Infer number of core
registers from XML") gdb_num_core_regs is inferred for
the x86 targets. Remove a stale comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/gdbstub.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index f1ce90a046e..b86520f8f9c 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -39,9 +39,7 @@ static const int gpr_map[CPU_NB_EREGS] = {
 static const int gpr_map32[8] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 
 /*
- * Keep these in sync with assignment to
- * gdb_num_core_regs in target/i386/cpu.c
- * and with the machine description
+ * Keep these in sync with the machine description
  */
 
 /*
-- 
2.53.0


