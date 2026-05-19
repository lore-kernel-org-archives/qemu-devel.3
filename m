Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9998ACD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPOYv-0004hw-B0; Tue, 19 May 2026 13:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <williamdapinho@gmail.com>)
 id 1wPOYk-0004fg-Jw
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:48:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <williamdapinho@gmail.com>)
 id 1wPOYi-0008Mz-Oo
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:48:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso32879445e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779212927; x=1779817727; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/SBLz/jBkK5JwJeAidAiyw3zmoon26oOp3vH5EZYXkU=;
 b=RP9BlRBqBsZvNSFFh3oOyT5oHk7F7lI8oraIKZ7tZ6k/bFLMEwpr3xoHpo2lHbQVIK
 i5uYVNtbkOAd4IceklrNs+26Bxk+yIVDGcTms8vc11JfLtKWdM1rZ0K/rk1hqTb60ofh
 r3Yfx26q5+p7o0sIPkTl7bcVMIFv2zvecpVggDjy1MkwoWQyNdz4N8GbJERAGJ2a64Qy
 caIvCCwZkynttngqP3sYgIi+px8H56DI48atii9SGBtiOya2wwVAjKoBn0J1+LU7r9dq
 fa7VvEg2DpFk5QST4lZSxAT9IVNnEf81yjJOfH1+qdtoFmJAw4nkxMAfGv/V0nVxa3zt
 ljbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779212927; x=1779817727;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SBLz/jBkK5JwJeAidAiyw3zmoon26oOp3vH5EZYXkU=;
 b=HvHR5zZ8eLOGwxwqsVaOnXZ3e/SlzFVXvNx6RrOY8fuNRr6kis9MQ89SCfd/T4o2nz
 ESm0nAKGasTPgl5bZK0LWRRGyqeaBBXUNZVKVe1g9jEVes7Z6n/7iROnrfmtNcaffU3m
 NR+zJjSjBFhF4PgNLJ1HD2Ejmgud7ejJWuDU1IqpP7zGduOYgGJcvb/jt8yIBi1GbdOL
 tdcOZDep6bhysiZsQiTxlefTiLVhYXl0J1L7FayMl3JcT6RUEvoROx4EPEm/BEFjcOPy
 pe4vH7+zue8JmewBCsvIBI0mRmbza9LlcaQDppMPwMgdyxnXAlAW/Aug6L5YDoEZZPid
 LA5Q==
X-Gm-Message-State: AOJu0YyuBLGpeVjeQryDFTIj4wUsvUOO3ef5tsF6SPRQMeO9V/+56Wpu
 X0kF0TlYs36j2QMfCcS5QT1lTP1gGtxQChfVTCzDfiyOpbK9h3/9oKTW
X-Gm-Gg: Acq92OF/iYYajkL+WDieoJe57HhaMv0BLd0L+JtBTjNGqUqPJBS89pFoSHFGXmHJieE
 iP9YvMtwFtsiK/JEuVj1Lxf7+18TUZwPKPTMFcUaemtPYa8k/Wpl8FPipUKdcyyXbEf7SJGPGBn
 1nbmiGnQAkyPx1ZGIa9lqI45g9Q+B3ps2GAT/XwVV7na7Ga1LKr9eIZUOtP58lohWVZrk/sMH3T
 vHsn5+JPFc1CuoDwUn1cfFstbvdLVKkKxT/4OV4gdeIRjZw6EdU3Dfu0yyNM8LvnAFZW+wS7eXY
 ru04+lGLQoT+8fCAWCtPz2EUlGjW3bfupCmgBFGeYLgQgolnOl/8G0KSTUS/QPJ1E/iwrVEEWbO
 mrAP/IG4a/KQGasp9K4UJfmLc2NVRb4gebd26mOa6JHP9VsfomK7j6qWkzxxpEkbEDCZj685wtm
 NzJ+pc0JeRlwaMoO3m7bm5UMsrI1Sv05mf
X-Received: by 2002:a05:600c:a30a:b0:48a:568f:ae8a with SMTP id
 5b1f17b1804b1-48fe5fda35fmr246912045e9.8.1779212926714; 
 Tue, 19 May 2026 10:48:46 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fea52a0bfsm174471855e9.0.2026.05.19.10.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 10:48:46 -0700 (PDT)
From: William de Abreu Pinho <williamdapinho@gmail.com>
Subject: [PATCH v3 0/3] hw/arm/aspeed: add anacapa-bmc machine
Date: Tue, 19 May 2026 10:48:37 -0700
Message-Id: <20260519-add-anacapa-machine-v3-0-56c23993a20a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHWiDGoC/23OwQqDMAyA4VeRnpfRdtrOnfYeY4fYVg3MKu0oG
 +K7rwoDDx7/QL5kZtEFcpHdipkFlyjS6HNcTgUzPfrOAdncTHKpeCUEoLWAHg1OCAOanrwD02q
 uFTYcW2R5cwqupc+mPp65e4rvMXy3I0ms079XHXpJAIdaq8o43tSlVPduQHqdzTiw1Utyb9THh
 sxGqbnUV6Vt/m5vLMvyA+/pFR36AAAA
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 William de Abreu Pinho <williamdapinho@gmail.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=williamdapinho@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series adds support for the Anacapa machine type.  The first patch
introduces FacebookAspeedTest and updates the existing Facebook machine
tests.  The second patch adds the machine model and functional tests.
The third patch adds the FRU EEPROM contents.

To: qemu-devel@nongnu.org
Cc: Cédric Le Goater <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Steven Lee <steven_lee@aspeedtech.com>
Cc: Troy Lee <leetroy@gmail.com>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: Kane Chen <kane_chen@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Changes in v3:
- Update docs/system/arm/aspeed.rst to add anacapa-bmc (suggested by
  Cédric Le Goater)
- Link to v2: https://lore.kernel.org/qemu-devel/20260519-add-anacapa-machine-v2-0-47027867d76a@gmail.com

Changes in v2:
- Split the functional test (FacebookAspeedTest) into a separate patch,
  also updating bletchley-bmc and catalina-bmc to use it.
- Link to v1: https://lore.kernel.org/qemu-devel/20260515-add-anacapa-machine-v1-0-9765ce0b9426@gmail.com

---
William de Abreu Pinho (3):
      tests/functional/aspeed: introduce FacebookAspeedTest
      hw/arm/aspeed: add anacapa-bmc machine
      hw/arm/aspeed: anacapa: add FRU EEPROM data

 docs/system/arm/aspeed.rst                    |   3 +-
 hw/arm/aspeed_ast2600_anacapa.c               | 362 ++++++++++++++++++++++++++
 hw/arm/meson.build                            |   1 +
 tests/functional/arm/meson.build              |   2 +
 tests/functional/arm/test_aspeed_anacapa.py   |  25 ++
 tests/functional/arm/test_aspeed_bletchley.py |   6 +-
 tests/functional/arm/test_aspeed_catalina.py  |   6 +-
 tests/functional/aspeed.py                    |   8 +
 8 files changed, 406 insertions(+), 7 deletions(-)
---
base-commit: ee7eb612be8f8886d48c1d0c1f1c65e495138f83
change-id: 20260511-add-anacapa-machine-cf7076ab0afa

Best regards,
-- 
William de Abreu Pinho <williamdapinho@gmail.com>


