Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0499ACD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHo9-0005BX-O1; Tue, 19 May 2026 06:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <williamdapinho@gmail.com>)
 id 1wPHo8-0005An-Iv
 for qemu-devel@nongnu.org; Tue, 19 May 2026 06:36:16 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <williamdapinho@gmail.com>)
 id 1wPHo5-0005sV-F4
 for qemu-devel@nongnu.org; Tue, 19 May 2026 06:36:16 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso34852545e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 03:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779186971; x=1779791771; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7y9tRwO+0lSOO4TaJoPdAdG3p2FWJzmWaZsdLD7jsEU=;
 b=CvZCd3Ryk3xzDrxzYb10CpYoh5FW06Evxwi+/R58iSWB+Lq2/4GQChYHndal4uFuDF
 1VjhTVkP79Kjjc+s2fQszR3cNk7K/hYru9/ezYfju394Xgt3UTQLr8BQahcb5tGIk0IZ
 +cW8HZjw8BzBppLP1hhN+YbPYT7ezHX+EeVhxAqw28RZPIoqrOzmz88hqDUtUtGU28r4
 ODWmCQrJ027ioc/EgDYfHzrYgwFW38h1xVD6aQXGEQzEE8/vIkUAkUJ+S3eJRelMcem7
 U4ehjwtad+MEawtXotzgeTrP0Wh8xP6vtSEPXZj0MAkTi/hTy416Y0wNvuIent4zWDIP
 srBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186971; x=1779791771;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7y9tRwO+0lSOO4TaJoPdAdG3p2FWJzmWaZsdLD7jsEU=;
 b=hMB40MCBH26bvcALL1Yv70FCxqh45k/Nx6L0o4SQVwBzrTStgWjAtUbhhwRfC5dIyW
 7aOd7UUEV/OZ0ZwWlP1cloqeEiWjyrrDSl8CL5ojzE0A6kU31QCZLFcS5lEeemjHeETO
 /n3gEEg4sDGTQ+cy7LdwBmcxTDKeozTwWPuogpdL8xa5xBelCKHa8eG7JUlKQ6FJ4m9o
 d0tvCoWAwmzpQSzDq/7C0joI3vWcqjxoCjokjO/v/S5bViH5dG5/bm+x4MzgvidfEQwL
 SzJNgyVMlYdeYgftB796dEgmtRitiICUV8pG+yNOkchXdSaJQ8xLRBFhz7vXfVehPbv5
 55NQ==
X-Gm-Message-State: AOJu0Yx0IFq6YVDT04sEuFsUq9uT5cOcUxSReGTXwHaoPjygORGzlP29
 V8NHOVSrT8S0pKrkb0rlQkM4XeRvHd3eXmfakdzOyQtIv7e3OU8DuXRP
X-Gm-Gg: Acq92OGW3FKTBRhDDXAvZf6wwEKlk24QJsULht9CpnwXwHJbdmUsq3JJAZSL+yNG4dW
 EEDFC0oOyQH0WlSO8linUVd79XXaEyduaX1eoVkRxuTNsn4CQRyOoSQgv0HREeM0JU8IL/ZAwM5
 YuEzunfIn2RwPqLVmPtSCzk7zm3zdBYu/44tPTQW/ugqNgPJC5ytg8adJbxAkxGUHc98LCFTQ4/
 9A1ifq2masaWqIVLOScwCW20JcqN1KUVeU4eCpZK8r+MLO/7uopP8i4m0yxZb6qvpWcQPmlyKn0
 z5uqDQRFWlE5BhmL6pojafvlvWNH3sSx/+wx6CBn1NWdfWx0dp7dIUoHkMJH3t/f8dcUxRJ/Hn9
 Oz+NgNFPr0IkMOSXfd6Ga28DjC8XSZUz0yrJnMtydP38ukGs+KaLEttJ7bG6yavVhyjiKXBhNck
 nmfZ8VujOuxgxgWz/F8Xf2hw==
X-Received: by 2002:a05:600c:a406:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-48fe4fa1902mr228931695e9.6.1779186970772; 
 Tue, 19 May 2026 03:36:10 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab52a6sm315450985e9.10.2026.05.19.03.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:36:09 -0700 (PDT)
From: William de Abreu Pinho <williamdapinho@gmail.com>
Subject: [PATCH v2 0/3] hw/arm/aspeed: add anacapa-bmc machine
Date: Tue, 19 May 2026 03:36:02 -0700
Message-Id: <20260519-add-anacapa-machine-v2-0-47027867d76a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABM9DGoC/22NQQqDMBBFryKz7pQk1Ihd9R7FxZhMdKBGSYq0i
 HdvKnTX5Xvw398gcxLOcK02SLxKljkWMKcK3EhxYBRfGIwyVtVaI3mPFMnRQjiRGyUyutCoxlK
 vKBCU5ZI4yOuo3rvCo+TnnN7Hyaq/9ter//ZWjQrbxtaOVd9ejL0NE8nj7OYJun3fP91ilq+2A
 AAA
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, William de Abreu Pinho <williamdapinho@gmail.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=williamdapinho@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series adds support for the Anacapa machine type.  The first patch
introduces FacebookAspeedTest and updates the existing Facebook machine
tests.  The second patch adds the machine model and functional tests.
The third patch adds the FRU EEPROM contents.

Signed-off-by: William de Abreu Pinho <williamdapinho@gmail.com>
---
Changes in v2:
- Split the functional test (FacebookAspeedTest) into a separate patch,
  also updating bletchley-bmc and catalina-bmc to use it.
- Link to v1: https://lore.kernel.org/qemu-devel/20260515-add-anacapa-machine-v1-0-9765ce0b9426@gmail.com

---
William de Abreu Pinho (3):
      tests/functional/aspeed: introduce FacebookAspeedTest
      hw/arm/aspeed: add anacapa-bmc machine
      hw/arm/aspeed: anacapa: add FRU EEPROM data

 hw/arm/aspeed_ast2600_anacapa.c               | 362 ++++++++++++++++++++++++++
 hw/arm/meson.build                            |   1 +
 tests/functional/arm/meson.build              |   2 +
 tests/functional/arm/test_aspeed_anacapa.py   |  25 ++
 tests/functional/arm/test_aspeed_bletchley.py |   6 +-
 tests/functional/arm/test_aspeed_catalina.py  |   6 +-
 tests/functional/aspeed.py                    |   8 +
 7 files changed, 404 insertions(+), 6 deletions(-)
---
base-commit: ee7eb612be8f8886d48c1d0c1f1c65e495138f83
change-id: 20260511-add-anacapa-machine-cf7076ab0afa

Best regards,
-- 
William de Abreu Pinho <williamdapinho@gmail.com>


