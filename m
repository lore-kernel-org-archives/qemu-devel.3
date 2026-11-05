Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87309606A335
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtlX-0006d6-9t; Thu, 05 Nov 2026 04:28:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtlF-0006bU-Cp
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:27:58 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtlB-0006tu-50
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:27:56 -0500
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8a058f74a54so698507b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870869; x=1794475669;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0UOK4RfGRXkyPumPucgP3sRwcECSt4JXJcHkIBrJ0EM=;
 b=Pjt9WsZAKnirfyqo+qIUp4SC2fXeu8a4G0j+uogJVe0Zte5lfLkagtWrsktQSewqxC
 jmpFJgheDDKqGbolRoG4XYGuAnBRiKJEGU1QXAW4CL+oF14GvnuvrE/4XKMo8+RfQDqe
 4CNaoNjAg3DH4wIHniAKRfC78y7Eqe0y3qzIruzHrvf2QL4C+to+3H+wzo4M1wwLsCtf
 ErN8T098BV5Pqoadwz1hoQeXjodk6TTu/qe9WQP2jGKBNX6V5afSL6cCPr0rOOpK0tcb
 hBMudfaB55A2O5+8ue/2jrVi18OoOWZGYKpfF7ylsw/2i78BvNl/I/rXuk4vjRGGvv6T
 jLmw==
X-Gm-Message-State: APuU4Z/fY5sBC6hV0CB95XDcsEx6SaGhgqx5bOvNAiJNifIim/t2RQp9
 MWFt3Y8xp4ga5FF+lS+2vxSYgMTVo0cV1ZpGZFvspkJ8ldFGXgI8qYjD2w0TV+7ehok=
X-Gm-Gg: AYBFou26Uxy+hHPQZE3Dx2OTaPIoynD+Yq0l/ObTFj8XzQOVN3rwp6D5lkxmqxnFBa7
 cDeQ+KCXW7lObkSfECbT64Y0geoxFhEc1/cWkqKq8dSNZ72ahS4HOLeDsKZ2ggug1zdTRB7XNF5
 xWxwjKF4c6qKEaOWtfj7nF2hZdgmyWglqbe2o6q7+F81N4/TXQQxE0FUThAa2wbCr6C6uu9mKSm
 2ERy8uqd5rJg+zJWcqBz4h+XvhbJocofl/0Q7x+RGi66XlK1oa0eCqgNo2wLB45Xj2f5Yeenn9S
 Ece4Opp6ZfrPKsadnPQcJvTxk4jlL/Micq7FLjo2fw8Ck5v31x0wQC2GwdRUmIpm6M4UcYO/z3p
 Uvcb2NA44ONAuyXkZ6eikNmD+IKbA1V8XvBX3igp06uaKahU2Nh2W0MsPZZT3sT/5b3hAUk2sOR
 KDmpmBhXPTORIHdd+AUgX4r3SLgSQMbEB1CU8YwtQt59dq6e6RBO5gr+LZ5Te+9vSgREzSkXryz
 9e/rABp9ckU9d1ppCR/Sh/qi27wIFDJVBY+4cQSuqApQkvul3qNn0WdrGWsZx3BIVec+t3hgK2H
 iqQRrHA2nlvkGzmt5cG5Nf0tqRJ15Fn0aiyEUad2GbAdqRdV3vrBN+Mp/ogblpBUBW0TQ8p3CZE
 H
X-Received: by 2002:a05:6a00:9a5:b0:899:55e9:880b with SMTP id
 d2e1a72fcca58-8a9be48bcd8mr17044659b3a.14.1793870869044; 
 Thu, 05 Nov 2026 01:27:49 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09ae9d26csm1835802b3a.27.2026.11.05.01.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:27:48 -0800 (PST)
Subject: [PATCH 00/16] hw/sensor: TMP421 improvements
Date: Thu, 05 Nov 2026 17:25:39 +0800
Message-Id: <20261105-sensor-tmp421-v1-0-c46853f5e1f0@free.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDVpG21SVxELajASJR1EIu6uW
 L7F/xcwRkKGMrsg4kFMS0hQeQZ+bMKAgrpk0FJbpaQRjIGXKLZ5LbQSrrPOoymMtxZSs0bs6fx
 +Vf2b93ZCv70TuO8HPraJfXEAAAA=
X-Change-ID: 20261105-sensor-tmp421-9d69ce545c66
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, eblot@meta.com, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>, Jamin Lin <jaminlin1207@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870742; l=2706;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=jd0vR9vEGWTA2UvjlfzO6sac3fr1/sWC4XS8Ho9tt2Q=;
 b=wEOiRx8QR2fmhBnuCvbg5ZrsM6FoVdFn5neviJadSHugeefMYFfvZ1YyiGJgU+/YW9vLaxGdp
 mqF8xa29Qy0D5eduIQ6BdzIbn+R0b+QIwc6s4qY3Z1nUqEEiGIHy4D8
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.210.179; envelope-from=eblot.ml@gmail.com;
 helo=mail-pf1-f179.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Based on master, at:
  f29ccc287a

The TMP421 variants are now described by a class descriptor instead
of a lookup table. Channel enablement, register write masks, the
one-shot trigger and the per-channel N-factor registers are modelled,
reset follows Resettable API, and the variant type names move to a
header so boards stop open-coding the strings.

The new TMP421 state is stored in optional subsections.

New qtest for the TMP421 family, checking a migration round trip.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
Emmanuel Blot (16):
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

 hw/arm/aspeed_ast2400_palmetto.c          |   3 +-
 hw/arm/aspeed_ast2400_supermicrox11.c     |   3 +-
 hw/arm/aspeed_ast2500_supermicro-x11spi.c |   3 +-
 hw/arm/aspeed_ast2500_tiogapass.c         |  10 +-
 hw/arm/aspeed_ast2500_witherspoon.c       |   7 +-
 hw/arm/aspeed_ast2500_yosemitev2.c        |  10 +-
 hw/arm/aspeed_ast2600_bletchley.c         |   3 +-
 hw/arm/aspeed_ast2600_catalina.c          |   3 +-
 hw/arm/aspeed_ast2600_fby35.c             |   2 +-
 hw/arm/aspeed_ast2600_fuji.c              |   3 +-
 hw/arm/aspeed_ast2600_rainier.c           |  13 +-
 hw/sensor/tmp421.c                        | 429 +++++++++++++++++++++---------
 include/hw/sensor/tmp421.h                |  19 ++
 tests/qtest/meson.build                   |   1 +
 tests/qtest/tmp421-test.c                 | 326 +++++++++++++++++++++++
 15 files changed, 692 insertions(+), 143 deletions(-)
---
base-commit: f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5
change-id: 20261105-sensor-tmp421-9d69ce545c66

Best regards,
--  
Emmanuel Blot <emmanuel.blot@free.fr>


