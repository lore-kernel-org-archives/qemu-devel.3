Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7532606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NU86YyTz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMSkw-0005j8-Ph; Thu, 29 Oct 2026 12:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMSkq-0005fa-1H
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:13:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMSkk-0000Wr-3Q
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:13:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so22376515e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 09:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793290393; x=1793895193; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s4l0KimBrWHvvMusyKOm2DKSCNNxRX8/fD5OazWpjLY=;
 b=NU86YyTzxF8E12Co4Fuw0+cWfhQRJFwe/uHYGr/tDDyzUb9a+cQefuWIqqcJD45fAR
 iI9C3Z8uSoL9VS4zxg0aYD+5MALvbNqsY3Kggrzh1q1uLhraDNCNZv6j7pImZN1vzxml
 bgs6XKeMK6szhDpmrgqRshdqU9OHKkaMxr8Yxo6UGDol3OXmD/4W0IB8z1pymtASPTNP
 TuJmhqrihYb1XxdH94pP+CbQvY0tT0HojVWVYDhkpU3XRfPAFqNKFnBA+yAqqvCQYkjZ
 eqPBwIs8ka0Z6sCTO1voiIJbhJHmSjfJ4fVpVlAAUr2B8CCvz+bhqUjfeu55CT2aQ+pf
 DjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793290393; x=1793895193;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s4l0KimBrWHvvMusyKOm2DKSCNNxRX8/fD5OazWpjLY=;
 b=riulopCne6Z0sfZ1NGlA3LVtlRPaDDg3syqttEPuK+O2hir0zwmbCo+lFjvZ15emWQ
 3QiDZTHiqzBt4palR3zSF1nn/GeOwdtfgMIE06Kv3LlP7Mfa99EvEt7JtQZ6LTgkt+oj
 2DXj2Jb0Ichs7kzcURLlFO382EwW8Q8lzNatRxYOMj/v7VIQ/fQYvZHjI3k+Ul3O4ysb
 X/WetGeI30MwW2vMbo/+dXzYEnzimjRPdu3NYNfaQhS8bdD7IXsnqpJXJ3+UAm0Y8Rxb
 cVlIhN4vf05Ym4mHObr58jyVOW3lvk7Wg4ZuImS2D7sbQFCqpOpNbBPC0F1/BfkdUq46
 cOkw==
X-Gm-Message-State: AFq9FYIqqkcg6lb8WcLBAr72VS8vGsy0qJCXx/3TmlwpfoXJgM+J6huq
 sDz7CvF0IHLYVn/zFjSktWz6l9HcoWXbryfzf7wt9qjYkCiX9uC2zifGgBfxaNQgodk=
X-Gm-Gg: AYBFou1yEwc3wR4xfasBy3/2QRgy9lQlYub5efPb10HFV0viWiD6YjaO3tgUXgU8iLf
 Y98zTHcv5iRrHvbxPleCpIcurR3lAf5EaP14f5P2JpYRw1RbLkLYAndvkkPzOw9qG9+SrGpp/Zk
 L/bObsPxZeK6u8SJQu98O/QQ7ZFTZhErbWOuKtmvo465z5Sg142AMVKqI0ivjVmT9l3TW+fsjt3
 PFe6jNTw3vHAB3AitlkKaHPQTtAnajz/fMjs5vXr8FA9XcakVBaBBdQ3IzUpfhsoOY17ZIgGtaN
 JiHR1w9GIXv3am6dOPEc6aMRiIgnIck7/aGz/smuqUh3gvDAjjJqUT7UFJ3gVbvToXSKsd+hufs
 JeG0mNmkkFHFoJIaI26whUYf6anauk20n3g0Thozh3mMk5G70o5vG3rTlupFtquee2bETMeaTRS
 X4OYduhnyQOS0+T4Iu9XShdUx9BHYt91mo2PbkCw0F1JFMX0r10/tVMZg+C1EDVIcxooYTi2h/X
 ViMisBhC0PInDzfsqSAg3vQuB0FH44gKOIcUJxQGo5Q8UA200NiAiOU68VOEtpBuXGz5/v5dDKg
 ju6P8UhXEUIuG9JqmLx1pHy+kGqz
X-Received: by 2002:a05:600c:3e86:b0:4a1:83f0:7c91 with SMTP id
 5b1f17b1804b1-4a96b0ab6b7mr133595925e9.18.1793290392920; 
 Thu, 29 Oct 2026 09:13:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f7f4cdbsm83293675e9.7.2026.10.29.09.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:13:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 122BD5F898;
 Thu, 29 Oct 2026 16:13:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/8] fixes for 11.2 softfreeze (checkpatch, gdbstub, wfxt,
 bcm fb)
Date: Thu, 29 Oct 2026 16:13:02 +0000
Message-ID: <20261029161310.2065290-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A small selection of fixes as we approach softfreeze.

The core changes are tweaks to the WxFT emulation which fixes a
deadlock when the vCPU goes to sleep. There are some tidy ups in the
following patches including an import of the test case from one of the
bugs reported.

The is a quick fix for a gdbstub test regression I inadvertently added
in my last PR.

While checking the series I also ran into an issue with checkpatch
which I have a proposed fix for.

Finally there is a random bug fix for the bcm2835 frame buffer.

Alex.

Alex Bennée (8):
  scripts/checkpatch: validate fixes against origin/master
  tests/functional: fix call to common_tuxrun_gdb
  target/arm: hold bql when SEV sets the event_register
  target/arm: don't pass env to the sev helper
  target/arm: simplify wfxt_timer_cb to only trigger cpu_interrupt
  tests/tcg: import arm wfe test cases for #4670
  tests/functional: remove @skipSlowTest from quanta_gsj test
  target/arm: fix bcm2835 migration issue

 target/arm/tcg/helper-defs.h                  |   2 +-
 hw/display/bcm2835_fb.c                       |  11 +
 system/cpus.c                                 |   2 +-
 target/arm/cpu.c                              |  20 +-
 target/arm/tcg/op_helper.c                    |   7 +-
 target/arm/tcg/translate-a64.c                |   2 +-
 target/arm/tcg/translate.c                    |   2 +-
 .../tcg/aarch64/system/wfe-sev-lock-aarch64.c | 259 ++++++++++++++++++
 tests/tcg/arm/system/wfe-sev-lock-arm.c       | 240 ++++++++++++++++
 scripts/checkpatch.pl                         |   4 +-
 tests/functional/arm/test_quanta_gsj.py       |   1 -
 tests/functional/s390x/test_tuxrun.py         |   1 -
 tests/tcg/aarch64/system/meson.build          |   7 +
 tests/tcg/arm/system/meson.build              |   7 +
 14 files changed, 538 insertions(+), 27 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/wfe-sev-lock-aarch64.c
 create mode 100644 tests/tcg/arm/system/wfe-sev-lock-arm.c

-- 
2.47.3


