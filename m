Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FD5C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 20:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tue0V-0007Ks-9A; Tue, 18 Mar 2025 16:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tue02-0007Hv-9P; Tue, 18 Mar 2025 16:57:23 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tudzz-0005lH-SQ; Tue, 18 Mar 2025 16:57:21 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e5e63162a0so9057461a12.3; 
 Tue, 18 Mar 2025 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742331436; x=1742936236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W+m/MM6yhH7CW9/u/Bw86g2b2P0pk0zVcocYDACn2/8=;
 b=jDvGjTy3yO01g4DZ/o3p9fgK2/a4P43TPiDMN+G6s2mS9oMu5T7iWr9J+mPEL0jwEM
 stSeQCpdO8Ca1WZ6yzmBpfv5HJ90T8RPkTQPj567tDcpE7/rHwAy/1wIViUc7PeRvvvK
 V9Tlx4XZ0/rOPRBCeYGjd0FE5LHx3KRK0gFNl1uY0OnL7y21EJymzkDdcI5kX8WhVUqf
 PitTx/kV/Fe7/+7dUSs+Knzu5sY9ixhloo6LOpY7ACcyUW+2ZRKCjNRgtVpzrCa5OO5m
 Aqq4L21DoI5EbyQuXLJ1rGn8Dku/4yrLf2Z1/89xHXUz6jmUUAtseA3NBy0gKwdZaihA
 11Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742331436; x=1742936236;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W+m/MM6yhH7CW9/u/Bw86g2b2P0pk0zVcocYDACn2/8=;
 b=kFLmIAb2yisCGr/MiTN+GBI/pJxAlO7npivf8AJ9O8hgV8tNdbqdlhdM6ahC8wMK1f
 qwLEb1UVPcAZvqlgblYOpbTQs/aeSqrjhuHdkzAHpAzkHy5r/cpO2hAUx3jM/f63LvO3
 DDX4kddxreER2BFydWPny789GHUXWN1LjMxdOPONCUpICe+s6QbYDx8dC9NWUUvzphFE
 rFgMW3ETmflDW+H2xTIHt4Wg5zcJcW0dL8SGZEiiG4bJ0qyB2gfoHRrECG5/qFqiSvV7
 /HiR6qPQSIpD0He27ihhmkDQWhz0RgPUQpmh4XEwjPKK2fR/zykDZJks4EWFNxBNDJ4m
 3zGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6m7KcLKzIKXJ9wsGt9VWTYpxiRiXwcYrDzuzGpgJ/+ev4EGRZ7RRhp7F22y4hMJdGcurYAqWmBw==@nongnu.org
X-Gm-Message-State: AOJu0YwgopnCM5V+2K+9TSz9BYG2n+zz/lfDUAUHs4ymmKmS3msPiH5I
 uR65K1icuN9Hw9q4Ef3c75n3HFqOYa2SHCu8ohWRRk/x+fvvzVRnAMRdqw==
X-Gm-Gg: ASbGncuFfPenodequIfbnf2X+7edGtn3EX+uEcSUCAno3OpENsWiHOo+UgZv3oFNEO+
 CKKJsCSL0TaqLLgngqzfM52w6+8NEAbXfOvDER1xNjGHLmXgZL0xoje4Ynju4hwBxeihUizNzAC
 6OibouarjsuaFbPEHU4tb6RbFn0OUcNfJLn2UNY6NOeqJZDzaQQINRhbC73qH8V01ajUclm1C0S
 v8jD9cV6kqi5Ek7tnZu4qKztKkAYLOk0a4ZnQGYGQmIGHcHkfoOgqUHv9qbMY8Qj4zSslps4dA2
 cEJwtxlqnI+cB0fEExLsqNC9iXU1BU3Ky/qbuU1dk5mRNNbO2cc75LC/+XfkNsaK1rGsgJy4cVl
 yyMPkpozld57nTdWnX1h4+PfWXS1L3eLxyPHe0+14Mv90TTCH3FnhFzemEABLKgc=
X-Google-Smtp-Source: AGHT+IE1+ec8gZyduLXL8F4mfccqpzpb02+czuBqT5kJK6XTyivjv2aARRfbspBY+qp9MP6CqLGxCg==
X-Received: by 2002:a17:907:2d0e:b0:ac3:3e43:3b2b with SMTP id
 a640c23a62f3a-ac3b7d9469bmr8124866b.18.1742331436377; 
 Tue, 18 Mar 2025 13:57:16 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-19c6-0d00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:19c6:d00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3146aed4fsm895944266b.26.2025.03.18.13.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 13:57:15 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/3] i.MX 8M Plus EVK Fixes
Date: Tue, 18 Mar 2025 21:57:06 +0100
Message-ID: <20250318205709.28862-1-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
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

As discussed in [1], this series modifies the SoC class be derived from=0D
TYPE_SYS_BUS_DEVICE to fix the reset mechanism and to prevent it from being=
=0D
user-creatable. It also removes an unused define.=0D
=0D
v3:=0D
* Fix reference counting in separate commit (Peter)=0D
=0D
v2:=0D
* Do not set user_creatable =3D false; (Zoltan, Peter)=0D
=0D
[1] https://lore.kernel.org/qemu-devel/1cdb6643-8fcc-4bd8-93fc-fcc93589c9a3=
@redhat.com/=0D
=0D
Bernhard Beschow (3):=0D
  hw/arm/imx8mp-evk: Fix reference count of SoC object=0D
  hw/arm/fsl-imx8mp: Derive struct FslImx8mpState from=0D
    TYPE_SYS_BUS_DEVICE=0D
  hw/arm/fsl-imx8mp: Remove unused define=0D
=0D
 include/hw/arm/fsl-imx8mp.h | 4 ++--=0D
 hw/arm/fsl-imx8mp.c         | 2 +-=0D
 hw/arm/imx8mp-evk.c         | 2 +-=0D
 3 files changed, 4 insertions(+), 4 deletions(-)=0D
=0D
-- =0D
2.49.0=0D
=0D

