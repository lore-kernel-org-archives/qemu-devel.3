Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E89CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPOGw-0007vP-S5; Tue, 19 May 2026 13:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPOGr-0007uS-KN
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:30:22 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPOGp-0003co-7j
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:30:21 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so1158541f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779211816; x=1779816616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xGnS8RysZeo7INKX/jimJFmp0STmOzcX51/ApGEfyxU=;
 b=t4yqh/252U8qwjxpfHPPlGZIaPy78O1Vw+ZKfO5rnbwgU52bJVNWMXSBP60iXCrk1q
 hBgheAwdzx4LwurPJfRBv1asTebNmw+la0zI50BLVp5davwQIha10u8AaHDrfBor0Csq
 FpvKB5SZWO7RcFBwakyEzA78m/vf4uBKM6VQez4HoAd5vbLAxm+8eSD0qaWWjK/ySObT
 GYmHyp4P9ZBfz46NTbHHP/b8rcOpZMYVKZ27F3XgR64yCW42vI3oIpsq4WzBuRDiGAcr
 RADYrlJNNfK1cIMvphF+/0MFKXDUbH3Uz31cfGSRcAI4IFLln0/vr5Dj0/GEmz1DrSWn
 Wehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779211816; x=1779816616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGnS8RysZeo7INKX/jimJFmp0STmOzcX51/ApGEfyxU=;
 b=rlMWOehr3UAIBN7pPSrfIFdWQ1wzOwPpVE5R/j7Qk4E01cVLJBGT3uVKXthANm1rL0
 QZaSj9bh5Mph02D8K35Zdf3i1HBh5549SPZrhHn9aT+ZbPeHq8lkEJhYZLUV1RJYf60w
 dsIVhqpgwyMaVKrb1PevmaSK1n/ZVvhQcLZuQWLBGBoh1qA4KrwQnracz9RFCxcvM8mA
 bkkwbEauo9yXQeu5dahrCGCG19SL9Z8G4jJbHMO2+vY8KfcqKqZKzBKxMgEfiw42TvO/
 5cnewNoUONL39kHQTHpKc/E6jznscZil6oW6Ru2uoOBqp8g2Tenhlt4MCIbjzFJU5mEr
 DrhQ==
X-Gm-Message-State: AOJu0YzYGJk2XxgP8Leo8+ojKALTeHJAd9ZCz9y5sDkAb7RWXetXe3zv
 TIbcKohfhkO5Pr85iUi5BmtpoJ3zfh0d59FW0YAPVNWhLLAz/JoUNQZMuzigE7Y3nyOjdVng6la
 7n5Fyd5c=
X-Gm-Gg: Acq92OGzYlQwAD+FcP0uL1lO9C0TDklU9IzoDqXiDcAsDN1nAfb5S7f0PwWOIBZO/R/
 RpAElcX6OxyDlwBdfjErDmfPbk4DMJcN9/EXywD8gtNgAR9ixDl+19rvIbXKawF/yKhpIgIhLwp
 rXd3ulCYaXkgszAJuVXr7oPjm7g0UAOar4+HtIMJQsbsEQiq66RI3D0qAqI74GFu9zGeRlUztqc
 MSzWK7LZDjx9DCi24dmShSEnHuQTgoEa7dA6DlwnigvSZoC36p3LTr2esTdGNR+QQbROBTzPoay
 J/zW5QYM1nV1SfSzEFT3Wi3798lU7anIJfYD6GIRpDrIUVSTh/M0YX2WTQ5qs1b9D61QjkvLqmB
 l12FWQ0QmSFBcuARvv0nztQIxEtmqHKC2SW29c3HKpMiaKL2fpud+/uYW+ss9xbYezxjX12gGZj
 vbP4JJuZrpWjg78UZijP5EKnxUUqDbd9uzkLSgogW4+JpwAkOAiLrByU1sJkFBmCQoB+KgIUtNC
 2LNDSMet9c=
X-Received: by 2002:a05:6000:186c:b0:44a:247e:67b1 with SMTP id
 ffacd0b85a97d-45e5c35e40amr33283709f8f.5.1779211816527; 
 Tue, 19 May 2026 10:30:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768072sm46461819f8f.5.2026.05.19.10.30.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 10:30:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/2] MAINTAINERS: Update PhilMD entries
Date: Tue, 19 May 2026 19:30:12 +0200
Message-ID: <20260519173014.98967-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

v3:
- Rebased, removing merged patches

v2:
- Addressed Markus & Daniel comments w.r.t. FW sections
- Drop T: tags
- Remove dead emails

Based-on: <20260416091654.316158-1-peter.maydell@linaro.org>

Philippe Mathieu-Daudé (2):
  MAINTAINERS: Transfer FW schema specs section to Daniel
  MAINTAINERS: Remove PhilMD from firmware sections

 MAINTAINERS | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
2.53.0


