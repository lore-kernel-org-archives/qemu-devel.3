Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2EDC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafex-0000eH-NQ; Thu, 15 Feb 2024 12:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeL-0007z9-UF
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:54 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeG-0003xN-Lk
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:53 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d0cdbd67f0so15801341fa.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018546; x=1708623346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t74q4lHJfmRE6xLpC3azh8koFmuAF2w+Csg2/m3aH1I=;
 b=yyUzQUMdy9t8P7Go1WZnnq1xpJsG78l+1A+zRn/vpsuTvbfOYNSLqT60EMJ9wlNhbI
 GuSE0CC78xckj4xY7ZeSob1QnVLbXRbAGuoTD0uTT2KjBPETfLDfAjT20nldWHWxz3w7
 TLUmHMKCPk4KB4XQx1foUp88gaEHnYwCkiO6QvPvWCtZHqXEVyohDzCErFgwsrIJtHN6
 2fWcrkVyoGklPi3Sc4QC4ovlZV5NNxuec5hxVz2QrnhX754tsazkBbt5l7iy9W1Sr+tC
 baTwBg/f4YaPvyGrlhwGqB/65YcM/ND6AdMVK1yvRoUjxHCnqr7YRIRFlUy/ZjxegHsN
 5zEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018546; x=1708623346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t74q4lHJfmRE6xLpC3azh8koFmuAF2w+Csg2/m3aH1I=;
 b=SoHSXZssf9uxNHL5DJooWLd4zjoa3zAiaKGGs5kx86ovNDRGvIVXA/H+SvSg3aujVI
 GjIvyywlxdTxZiBMLgnwy3KJZvdbhd36acI0Irp1ytnA2jI1FuD9sZ0fNEKwe8vSZCVB
 WLrIW4L6cwP/yTFrFlfqdTpAg/wAr/FOsTInTf5MtfFQgfRyc/3JvmWLWEcS1XV8JNLI
 YU4r5TgGhARXEBtzR2keWiuUQQPWK+6M2YeQaVrx1cSK8oQvChibFF+UQNB6nVxAUCdM
 mwlNwKCyYNVoYhIxRSvhwIZUHX61HoU+MDKxPl8zMQfCy5bS7CkmNap7I+0XiwPasHE7
 MaKA==
X-Gm-Message-State: AOJu0YyWZY2c/XwATRJRYQ0et1iot3LsrbXXuZf9RlO2XjzZfwOJVfGb
 RT3vkY9pP+cAWlcGPpWKAgK1DYRIejuu+wRThY7qBNMeyXA/mAph6eO3Ukwpl+vws/BfYZFNWTT
 9
X-Google-Smtp-Source: AGHT+IETiigBd7kSnUWzNet5IAI2ZE5oDfzOIv1Vl0JLgqQifCrW5vpaq8NElj19/fphbm96yaUCyw==
X-Received: by 2002:a2e:80da:0:b0:2d0:9fb2:2c79 with SMTP id
 r26-20020a2e80da000000b002d09fb22c79mr2135678ljg.3.1708018546072; 
 Thu, 15 Feb 2024 09:35:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/35] tests/qtest/npcm7xx_emc-test: Connect all NICs to a
 backend
Date: Thu, 15 Feb 2024 17:35:18 +0000
Message-Id: <20240215173538.2430599-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Currently QEMU will warn if there is a NIC on the board that
is not connected to a backend. By default the '-nic user' will
get used for all NICs, but if you manually connect a specific
NIC to a specific backend, then the other NICs on the board
have no backend and will be warned about:

qemu-system-arm: warning: nic npcm7xx-emc.1 has no peer
qemu-system-arm: warning: nic npcm-gmac.0 has no peer
qemu-system-arm: warning: nic npcm-gmac.1 has no peer

So suppress those warnings by manually connecting every NIC
on the board to some backend.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20240206171231.396392-3-peter.maydell@linaro.org
---
 tests/qtest/npcm7xx_emc-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/npcm7xx_emc-test.c b/tests/qtest/npcm7xx_emc-test.c
index f7646fae2c9..63f6cadb5cc 100644
--- a/tests/qtest/npcm7xx_emc-test.c
+++ b/tests/qtest/npcm7xx_emc-test.c
@@ -228,7 +228,10 @@ static int *packet_test_init(int module_num, GString *cmd_line)
      * KISS and use -nic. The driver accepts 'emc0' and 'emc1' as aliases
      * in the 'model' field to specify the device to match.
      */
-    g_string_append_printf(cmd_line, " -nic socket,fd=%d,model=emc%d ",
+    g_string_append_printf(cmd_line, " -nic socket,fd=%d,model=emc%d "
+                           "-nic user,model=npcm7xx-emc "
+                           "-nic user,model=npcm-gmac "
+                           "-nic user,model=npcm-gmac",
                            test_sockets[1], module_num);
 
     g_test_queue_destroy(packet_test_clear, test_sockets);
-- 
2.34.1


