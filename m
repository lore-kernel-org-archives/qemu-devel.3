Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE94CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHN5t-0005Zm-2P; Thu, 15 Oct 2026 11:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN5e-0005Ty-7N
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:09:56 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN5a-0001OO-OG
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:09:53 -0400
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso3467400f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 08:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792076989; x=1792681789;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hZuyob+ovQFH/gM76ih2SzJ8peHZvlXMktkW8YUoZ8E=;
 b=NxC9Pfu8oCXqXeekE2xJ6JIYKbp7Q8ImmS8KZUmuv4Fupf0iRkoDXje4eVV5+gQIjt
 cTqoGAOM+22dwIHgkfLvAYgJTVsToPVseN+h90neiVUG3YKNKRomXzfR9hnLz3T63aKe
 IVZwUC/cPc8Xesa2E4E79gZxg1qpNWYCKBzq151gO9PVGzDiGyUPElT7ZwkRGHm9BOQw
 7u1n4sMZHcSRgG+WzvUi6Sa8nWtfc0UlJ4/lO6QkTT3Ke+FnkvNrM/88kg6lQS9z5+0i
 Y03SWgGfNUWx6czl8nM07r5W6mwhz9/5p9zyEChKUUQQ46CrCx2lGe37rTYaPXGCqFVH
 TOJA==
X-Gm-Message-State: AFq9FYIN6Jy/lXnPFN9AVefYHsNEZn8qjGgP7TQ9+FWfCP/2CToayxkb
 +4mgjArQzCQQuCIFr3rBaOfdTjIBpRWuBVL+0dy0xnivq/ZTGIIN/+x04kVwbw==
X-Gm-Gg: AYBFou3+7pv7KiqshEZIJrLUIlEWlll69giHEp90HfIfS6CFowoIMb5yQLkueqcwQEb
 2k8GizKC3M/p2CWRsTIyyj/4Qh/U9cngQwqnC8w6a6S+Ed6cBAyVY8n50rNyfh2JsAC57jCZsru
 hiW/a9rb0qd3e6auD55TfAuE1swJWs2mTaikiKDr5Mxubg4Xmbq/n+GFK5CubQDZvE3V4SJLgSS
 CzkOs9f+5Zrj22JviresDiSLh8du6+1ARfJi9Fz3nF5iaimwkOHr1r3QgI9daq0LR1vA7Fcfpq3
 msLjFVLmdxoMwbvxu+uRmEHB1eztudIDyAFkmY5d4mxwPxCb5BKpbauMmZlInKjkK+qjrN7r19y
 wNjDuLJyUl6Eie6IwjjGeMHPZuPqGXQKZ+lNM10Tx752Bfqp4ZuFAPpBJINNoE0GPemoNN/G9e3
 h0Gonvmk6p302nvRt9RnX5T4qGGaqYabF03XmblIzcLZwA+Q+ZDrVBJfKq9XlQByxJmQ0sj4pQk
 MlmKA7QQzEobJ82CVuC/thYPiCZU5hrf4GKt4xMc+J4iw==
X-Received: by 2002:a5d:5885:0:b0:48d:f7f0:327d with SMTP id
 ffacd0b85a97d-48df7f03308mr3494199f8f.29.1792076988777; 
 Thu, 15 Oct 2026 08:09:48 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df8f9ee47sm2435883f8f.45.2026.10.15.08.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:09:48 -0700 (PDT)
Subject: [PATCH 00/22] Aspeed: TMP421 and TMP1075 sensors, and the Clemente
 BMC machine
Date: Thu, 15 Oct 2026 13:57:38 +0200
Message-Id: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQW7DIBQFr2KxLtWHhI+xoqr3qLLA8JxQBScFx
 6oU5e61nS5Hem/mISpKQhVd8xAFc6rpOi6g3hoRzn48Qaa4sNCkmRxZ2ecgwwUZ4wRJZDgyW7b
 KiuVyKxjS76b7Or643vtvhGl1/C8Kfu5LZ3rNREatfut0zWHNKFJmy+Q0osxezjtJ0kZDofWKW
 pjPoQDvQ/lYjb2vkOGac5q6hpVBwC7siXvN2jmGYTdoB89ApNiqsI9tFMfn8w9FmWIX/AAAAA=
 =
X-Change-ID: 20260907-bmc-clemente-0056d6676717
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792065464; l=7193;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=iydWwc1WObcU7xqqvK5Efg+4Nf+SqeMppXxCXaC0b3M=;
 b=YryBHCazq2cFEHUQL7BiOfXsB7VaAsKF3A8rUUJUCQA0ZitgziWOw6BwZUEuxD9O+BXfSykU2
 po0M/wM1cHSCMdVB8/QehX3gARdckUiWosUDW0Axboga8OHGrWknOri
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.54; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f54.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the clemente-bmc machine and the temperature sensors it needs.

The TMP421 variants are now described by a class descriptor instead
of a lookup table. Channel enablement, register write masks, the
one-shot trigger and the per-channel N-factor registers are modelled,
reset follows Resettable API, and the variant type names move to a
header so boards stop open-coding the strings.

The TMP1075 is a TMP105 with a 16-bit Config register and a read-only
device ID.

The new TMP421 state is stored in optional subsections.

The clemente-bmc machine is derived from the platform device tree and
instantiates every device that is supported in QEMU. FRU EEPROMs are
sanitised images taken from real hardware.

New qtest for the TMP421 family, plus TMP105 cases for the TMP1075.
Both check a migration round trip.

Based-on: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
Emmanuel Blot (22):
      hw/sensor: tmp421: do not report a stale errno on a parse failure
      hw/sensor: tmp421: name the parent object field parent_obj
      hw/sensor: tmp421: implement Resettable reset
      hw/sensor: tmp421: model device variants with a class descriptor
      hw/sensor: tmp421: honor per-variant channels and channel enablement
      hw/sensor: tmp421: implement register write masks, one-shot and N-factor
      hw/sensor: tmp421: describe the temperature properties
      hw/sensor: tmp421: keep the measurement across a range change
      hw/sensor: tmp421: migrate the exact measurement
      hw/sensor: tmp421: publish the variant type names
      hw/arm/aspeed: use the TMP421 type-name macros
      tests/qtest: tmp421: cover device IDs and reset defaults
      tests/qtest: tmp421: cover temperature encoding and range
      tests/qtest: tmp421: cover per-variant channels and enablement
      tests/qtest: tmp421: cover software reset and N-factor registers
      tests/qtest: tmp421: cover the register form of the migration stream
      hw/sensor: tmp105: add the TMP1075 variant
      tests/qtest: tmp105: cover the TMP1075 device ID and reset defaults
      tests/qtest: tmp105: cover the TMP1075 config register width
      tests/qtest: tmp105: cover the Config low byte across a migration
      hw/arm: clemente: add Facebook Clemente BMC machine
      hw/arm: clemente: populate the FRU EEPROMs

 docs/system/arm/aspeed.rst                |    1 +
 hw/arm/aspeed_ast2400_palmetto.c          |    3 +-
 hw/arm/aspeed_ast2400_supermicrox11.c     |    3 +-
 hw/arm/aspeed_ast2500_supermicro-x11spi.c |    3 +-
 hw/arm/aspeed_ast2500_tiogapass.c         |   10 +-
 hw/arm/aspeed_ast2500_witherspoon.c       |    7 +-
 hw/arm/aspeed_ast2500_yosemitev2.c        |   10 +-
 hw/arm/aspeed_ast2600_bletchley.c         |    3 +-
 hw/arm/aspeed_ast2600_catalina.c          |    3 +-
 hw/arm/aspeed_ast2600_clemente.c          | 1154 +++++++++++++++++++++++++++++
 hw/arm/aspeed_ast2600_fby35.c             |    2 +-
 hw/arm/aspeed_ast2600_fuji.c              |    3 +-
 hw/arm/aspeed_ast2600_rainier.c           |   13 +-
 hw/arm/meson.build                        |    1 +
 hw/sensor/tmp105.c                        |   85 ++-
 hw/sensor/tmp421.c                        |  429 ++++++++---
 include/hw/sensor/tmp105.h                |    2 +
 include/hw/sensor/tmp105_regs.h           |    5 +
 include/hw/sensor/tmp421.h                |   19 +
 tests/qtest/meson.build                   |    1 +
 tests/qtest/tmp105-test.c                 |  111 +++
 tests/qtest/tmp421-test.c                 |  326 ++++++++
 22 files changed, 2050 insertions(+), 144 deletions(-)
---
base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
change-id: 20260907-bmc-clemente-0056d6676717
prerequisite-message-id: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
prerequisite-patch-id: 5aae2c14351eb51fea0cb307bedf21021730debd
prerequisite-patch-id: 4d9a408b21353dda070052227302e799e4c01726
prerequisite-patch-id: 01470b3e3d522778ea23f39f03a3b82a2a0f2d3e
prerequisite-patch-id: 11d0a41b1b3009d95ddf51d9bde960658c924ac1
prerequisite-patch-id: f1072c7d99e462e1c85ecace78eef33bc6e8778a
prerequisite-patch-id: 8897466a7505261a1060243ca01572c3a8874068
prerequisite-patch-id: f35c864317c68dd2b9ca969bec243fafd80497e6
prerequisite-patch-id: 8b05ecb9c1191509e7e4cc76944c88f4f7891ca2
prerequisite-patch-id: 78155b4352683ffc03826038c3d8160b788c29ff
prerequisite-patch-id: e0af745b421c39fd47311ca21576c510bc961526
prerequisite-patch-id: c14af0a372dcb314ef92a04a47e5bedc846281c8
prerequisite-patch-id: 684f5ec9f4ac0640438d1eead20832c529d67508
prerequisite-patch-id: e09c684b2002e30ae14a11bfe409869478d104bd
prerequisite-patch-id: 09afec3682584cbda09b00c0ac87dc60835454d7
prerequisite-patch-id: a89dfec61a795b84c3cf02927fd7c40bc6f694ae
prerequisite-patch-id: 6a23cb3b1362aaf70fe73f554d9d5fcf2e72c3ec
prerequisite-patch-id: 7c11c16803a5b96be5653a05acf8b46a3020e8d9
prerequisite-patch-id: b9251deb99859cc30a9c67b5dba3066124f32033
prerequisite-patch-id: 87291d7798b6bddde6242c651f0e03deb96ab559
prerequisite-patch-id: caac35561ca8b2bdd86101f943e93aa7bcd3a90c
prerequisite-patch-id: 27b0b37242fba900f982f9bcaca36f48c6a115bb
prerequisite-patch-id: 1259c5fbfeb5d2bf1760e7b12df59f182528cee6
prerequisite-patch-id: 2654532e955554fbae6ffcdf6ff3b38bb03fbbd5
prerequisite-patch-id: ff0505a46b3604ba502834d3f5bf17ab85b3c5fa
prerequisite-patch-id: 250958c152f11026aa98d334892132f9ab7467db
prerequisite-patch-id: f3d938264fb2f0c2c292dbb4fb218e5b8d22c3d9
prerequisite-patch-id: 06602fc849e499131998af486ae455497a4245c1
prerequisite-patch-id: d857ee22db2d62a98f4f2054d1966cce7ed39452
prerequisite-patch-id: 7909e49ac93573ebd56424a556d4e4872e9778eb
prerequisite-patch-id: 53cd0411fed556e85f6557cab6fc32056c24bddc
prerequisite-patch-id: 71752a32c10eacd296f62bcc94c09db5d54007c3
prerequisite-patch-id: 7a21b5fabeddff9c08d6b532b2a398737f375a06
prerequisite-patch-id: c6154dd1e7a48decd770f062fb57f32cfb2e1826
prerequisite-patch-id: b94e4e3d83aa013ffd05267e20d48d6813ca2d7c
prerequisite-patch-id: 23716ee3fbb2395d0fc33922433fb6d708081fae
prerequisite-patch-id: 2e57dc2effacfdfb8adb93f5e33bfefdb7c28dc0
prerequisite-patch-id: 2400063e36ca403574b812436fef8c38608e6005
prerequisite-patch-id: 557a2e98bce9c59d1d4513207e021e217d9dcc59
prerequisite-patch-id: db5ca53f9dccded71da127446b4870678640c86f
prerequisite-patch-id: ddf5d85c6eb13a9121342263b6f0ee9902b40d06
prerequisite-patch-id: d9e3e31b88133c8d2ffac7c931d9ab153cf20af7
prerequisite-patch-id: 7ed25d5dc6b899645ef98cdb591344042b77c41f
prerequisite-patch-id: 6c70cb570c5c6bfe0d61cb4c5260e6d8f195f383
prerequisite-patch-id: 3caea8b32b51fa447ee21565594b6465d2e51670
prerequisite-patch-id: 758236b35dcee46e176a7167e703048e11f6e634
prerequisite-patch-id: 0521a46d473cad9f3924b4e0f86473fe237c1982
prerequisite-patch-id: 819077eedcc252ade342c8288af2d57e0c8ece6f
prerequisite-patch-id: 913f8260d8274a1c1706d09915cf75c0dd11061c
prerequisite-patch-id: b0913e3e23d3bd41ffb248a3afecdbfe93b4915d
prerequisite-patch-id: ef2e1478aad5f5722a2d021b424803d7cb2cdc4c

Best regards,
--  
Emmanuel Blot <emmanuel.blot@free.fr>


