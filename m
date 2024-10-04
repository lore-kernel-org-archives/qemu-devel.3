Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FD6CF885B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 20:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swosm-0007gi-63; Fri, 04 Oct 2024 16:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swosk-0007gA-Oo
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 16:26:34 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swosj-0007qc-9W
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 16:26:34 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5399041167cso4399242e87.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 13:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728073591; x=1728678391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LLQgRzH03j4KDZZg/DuGoGCaTZmvUbN0udQPjdBZrNA=;
 b=OkBBF5dqBOjZ8uht/zkwq8fawPe2l1UAdLKdknEQGcKCVWxz6tL1nIIuUFyDGXtMST
 OJ3Gpw9QRdxbeMvGC3gEsDr7a2/OSDpfUqDz1quWJF18jCCLthqouuPg3RqDecfDpkjp
 t9mjsdm6+QsCHzcxo4yLO8eMt7l234hGNFGN87vqw3uXIJg8kiP9yFdHpkyQFucWOsMY
 WMdpmjr8GBxsWTYMk7Q/SEAlyZ4ZeRTkyE7zhcn0gl201uBnGOK7LwkotTZfynjbWSkp
 Fp1TtdLYe/hf+Q1ls3+vKkZ68Rj1nz/2OFCpRhdbCXxt+C+ctqkCnZFuARn0SbRSKqOe
 BnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728073591; x=1728678391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LLQgRzH03j4KDZZg/DuGoGCaTZmvUbN0udQPjdBZrNA=;
 b=mziVxNVaoyxw+Rnt+Nf4Jf7bKgnVKstL+gc4UqPwAimdJvyTB51wIn3H7uFDgcDg1M
 SFTOGjY4MV4hkLlhemo3jKbGzvXqgH46/XASeXTgxmvSShUYuTlSwXsxS4DrtCtBjGzJ
 9c9c/Kltpyk9HIJxa2cp497jvG6LCMeu3zfaNKbmID2ao/e9tdS6FLUwFiGCBwUU2d6G
 p4vnF66vz7EAMC0KxPXFI7s9Ca4zTuXIC9paP1Zi349cAX4wHdLp4d6U9jscFlhHR+SQ
 Sz1SHdVOLUsed0J2nrlaq00Z70m/nYa5kFdwSFVxZxeO41JCwhzCOoWNyPyuYT0lg30s
 PLzg==
X-Gm-Message-State: AOJu0Yxq6jqrIzzpq89c2OcQGiqLGbNZ7dDTMnZWiGVr5WL+pQMEQYgn
 RmMlDSoL/bQ6p1hru6IzLh8/Y0BEX8Ptccwqa9wEK/ms+i8u+joBGEePwFTEzvqk/3WPFlElTsJ
 rE+R9Mg==
X-Google-Smtp-Source: AGHT+IHDsnkDts1wWzwVjQiDsU3zq4XnGVAZPJsOS3+i/bIc62RNRA8j0dM8Z62kQntXjJmwTabKyA==
X-Received: by 2002:a05:6512:234e:b0:536:542e:ce1f with SMTP id
 2adb3069b0e04-539ab866575mr4141994e87.18.1728073590761; 
 Fri, 04 Oct 2024 13:26:30 -0700 (PDT)
Received: from localhost.localdomain ([91.209.212.135])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539aff232c5sm50239e87.185.2024.10.04.13.26.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 13:26:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] target: Use tcg_constant_tl() instead of tcg_gen_movi_tl()
Date: Fri,  4 Oct 2024 17:26:18 -0300
Message-ID: <20241004202621.4321-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

Directly use tcg_constant_tl() for constant integer, this
save a call to tcg_gen_movi_tl(), often saving a temp register.

(Only build-tested)

Philippe Mathieu-Daudé (3):
  target/mips: Use tcg_constant_tl() instead of tcg_gen_movi_tl()
  target/tricore: Use tcg_constant_tl() instead of tcg_gen_movi_tl()
  target/ppc: Use tcg_constant_tl() instead of tcg_gen_movi_tl()

 target/mips/tcg/translate.c               |  56 ++++-------
 target/ppc/translate.c                    |  13 +--
 target/tricore/translate.c                |   3 +-
 target/mips/tcg/micromips_translate.c.inc |  12 +--
 target/mips/tcg/mips16e_translate.c.inc   |  15 +--
 target/mips/tcg/nanomips_translate.c.inc  | 114 ++++++++--------------
 6 files changed, 74 insertions(+), 139 deletions(-)

-- 
2.45.2


