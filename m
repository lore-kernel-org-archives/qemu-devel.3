Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BAAC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYAG-0007QX-Kp; Fri, 08 Mar 2024 06:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAF-0007He-9g
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:23 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAD-0001hW-3L
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:23 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dca3951ad9so15462645ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896399; x=1710501199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGp8FCP6DqYm5MF5sGHTK5WHnrx+YfxNOewSUCkHhK0=;
 b=RlcjzcDty6+ppUPS86AhXmwpj3zkMypUn22BKjHaXqf/c6oO+NGiuMiGP4Da8QB3TM
 r/eF5hjixanHe+cqy/WcW0HJe9WViZ/sNEefq619c5PJoLQAfBKKyjQt3vqcrzKLP164
 472bBIX1KEweRZDhrUvBhkajN3hQzZ+tLsyl1UyN0QlE3uBvlYspWlu8ckY1nIWCwXRJ
 n4vddVs1qgXZqEtOrTXaMUreLASCItBJPLvNfcfIrytWKOfv27K15f/FPaEuxIsi53+l
 Hn4RX/QOGfBqDACSllyl/chD1fg28GsJEdycJdVfg99cgiaufuVNpmtguRFou7gYTXZC
 Zs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896399; x=1710501199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGp8FCP6DqYm5MF5sGHTK5WHnrx+YfxNOewSUCkHhK0=;
 b=Y8Jf43+DM2y+UdIvOIrXtCk8JUHAZOY4uEgc8obNpg8B2+N76q72Y79upBTjDSh25p
 lIOQvwjEJpN9/vUNOwMle1FcIFAJnX5lHoiFCVOxxyokUZhOPzMNeMjBZall6lXTfVjq
 tXAKmyz5c340DkZ2uMHMHn8dMvEJM5Ip+LcR6wzmM3/BDPGchmjknbED92+5bvWp0xZr
 3RtOfelwsD9cpv6fNIC8LCEt2/x7Nhu+EMFe78ElTVY2RpjmkntwYDbDRuTiK2joo6fs
 BuUkt1GhnqeOKvWRnqKZANJf9OrldbnxKuN4Ewf6RKwz7Audmqbf/nG1vloWTLm1/htq
 N6KA==
X-Gm-Message-State: AOJu0YxPXVxBvnR2uaVl40vpRHT6GRoJuOkSkD0Z89wLRZOuW3xD5rcE
 5LPBRwWSt2sURj/q2rCnKZ3P3aKPAgJnrOzj4neqbeEQmRIUcdOmCNxZlrjIKJ9wHg==
X-Google-Smtp-Source: AGHT+IHo9jgBxCFDDCs0dBzfVK/0maigiFfl10hB3UrJ6B+SuZBBXT7GAkw59sjOQB8jJR9dbK/oEQ==
X-Received: by 2002:a17:902:d315:b0:1dd:6a2d:e5c8 with SMTP id
 b21-20020a170902d31500b001dd6a2de5c8mr1036911plc.55.1709896398954; 
 Fri, 08 Mar 2024 03:13:18 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:13:18 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/34] tests: riscv64: Use 'zfa' instead of 'Zfa'
Date: Fri,  8 Mar 2024 21:11:41 +1000
Message-ID: <20240308111152.2856137-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

Running test-fcvtmod triggers the following deprecation warning:
  warning: CPU property 'Zfa' is deprecated. Please use 'zfa' instead
Let's fix that.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240229180656.1208881-1-christoph.muellner@vrull.eu>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/tcg/riscv64/Makefile.target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index a7e390c384..4da5b9a3b3 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -17,4 +17,4 @@ run-test-aes: QEMU_OPTS += -cpu rv64,zk=on
 TESTS += test-fcvtmod
 test-fcvtmod: CFLAGS += -march=rv64imafdc
 test-fcvtmod: LDFLAGS += -static
-run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,Zfa=true
+run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true
-- 
2.44.0


