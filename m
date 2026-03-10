Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5709EB1070
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzz5h-0002qz-RR; Tue, 10 Mar 2026 11:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzz5c-0002qO-EA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:33:44 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzz5W-0007rD-Ow
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:33:41 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439bcec8613so7106279f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773156816; x=1773761616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2uiTfksFHNHzJzvkw5nta263FHLPMUM8xCQCgBMubD4=;
 b=RSbk627qTBhsfek32LmVK5+KkLOaSbIU3SE3iDTrE0DSb41wtK7o2x+HwiHtsRJ1y1
 KMYgAleRxa6K4TukG7/18IrhD1k5qaZ0MdP2FfokXPfWiBX++NDht8Zay5oFtIgYNtar
 15yftFmUMUZAhOGB5Ka0xi0I5/cXbsBLa6b65XPaJ/pB36sllpqCpuvdTiHXRsa4Q7/w
 U4Kl2G3X2QTfzK7ZmmLM49+5J/hsF/0AJFqVopjPPmnzUocRkdpzoB/sDW9h+jINU9sl
 JBQ8r7xOsaxFmSug/ZWkEZkB1f+qQfDCSBBZM5TjZb0ApcR62vZqp3Vx7jiFMSG1TvVB
 oepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156816; x=1773761616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2uiTfksFHNHzJzvkw5nta263FHLPMUM8xCQCgBMubD4=;
 b=mosrwjzpooJRSUeZxoEIRk5xAfCYZKbKRWDpMxM2dXnLqrF2+KOpUnXGzLeiwCPtZE
 REqhmq5GRtsHX+1rjPOEIPUWKho51wLgyOa7ID1faxWdInqK1K8DdK0377On4zNyr/HM
 +cBoahKQddXuIKIeQpSRR37eomHFoQff7PENAlm128srwJjYjkPxm7Sp78SNGdlDCEVF
 9nP103Oq4PFO6VqbkMQfYEWDvTHzbxzXsiZZu4R1zvZ65q7zMLnKOuovjnvPdf9SMniE
 KPhNQTNsyQf5wdPakwk34Bv5zQ3NZQzXFoNG5uFDIvomrKbr06fu/rA7mYJp4rCob9QW
 l3LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv5WtXEnu6B+3onMa8Lpc8TVZhL/RENSEf9ei5iX3gwYMaDP0ezNyqwjTUMkoJjm5KHlxYYPHx8m7Z@nongnu.org
X-Gm-Message-State: AOJu0YwtioffZxNGGvw2zzsrLgzberHCQZ+EFlGMWpDu7hWAzEekeg66
 SEu4DnnYGYljPXybH6DNsUtoTdoiCCaWkcmBmcMht7o8bNHFJm/ypnxK6YW+dm36L2Q=
X-Gm-Gg: ATEYQzwTT0LTLMJTy1KXL84WpB8JtbXjMWcMo/8SlubwLvXixZsNrdmTmD02BZwuz9p
 ixDeJsrPf7U2PzP5nCXH5ebZg3Ff7+w91iji3E7fUIGTPvQFv/HRy0Ya6k0Ia6GTM+vFpmnE+PE
 pjSzBeQRx5zBx/mUlPKLCGMCrHs7tpGzDzvpxVgpluYCGmVqeV/IDXYN+dzhfFU4zslpsNSBufp
 XhYJ/5NZaC+eG/69yzpjCgVjAAjRXMbxqHhxHKlxByvE74dQBDeZLAqDmFgAzb+Wqr1i7P+CVGw
 TiqYyczVfAcXUmxzJEuRJw1kvtxNnzae3qXVKdc0knNpMqVkjqbEBpzc5gAf+mT6tkuTOV8nqbc
 mKOW59LPGohT/tKjmWxE8zPfqs/KA4xj9Cwa31wF/mpChpl6pAu6HMa+TxHafVoVdN8VkNyU60E
 hu4NaKxOt0Bq0HI3fxBJ8qzWGo4uMbbIHmzB9z3KZTmKkLp4XGosL66Rk34pVFGRce6an4faaWQ
 dov3tVy7DogQrcNNUM1rJNNmsV30YY=
X-Received: by 2002:a5d:658b:0:b0:439:f55c:b556 with SMTP id
 ffacd0b85a97d-439f55cb7d6mr2407252f8f.8.1773156816418; 
 Tue, 10 Mar 2026 08:33:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae45786sm41709388f8f.32.2026.03.10.08.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:33:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 0/2] tests/qtest: Avoid char arrays in more Arm tests
Date: Tue, 10 Mar 2026 15:33:32 +0000
Message-ID: <20260310153334.3063224-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

This patchset fixes a couple more -Wformat-overflow=2 warnings with
gcc 7.5.0. Same issue as this other series I just posted, but two
different files:

https://lore.kernel.org/qemu-devel/20260310151507.2973843-1-peter.maydell@linaro.org/

Since there's no dependency between the two sets of patches I sent
this out as a separate series rather than a v2 with those others
folded in.

thanks
-- PMM

Peter Maydell (2):
  tests/qtest/ast2700-gpio-test: Use g_strdup_printf() instead of char
    arrays
  tests/qtest/aspeed_gpio-test: Use g_strdup_printf() instead of char
    arrays

 tests/qtest/aspeed_gpio-test.c  | 4 ++--
 tests/qtest/ast2700-gpio-test.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.43.0


