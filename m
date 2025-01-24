Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2127CC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 05:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbBzO-0003K2-Gi; Fri, 24 Jan 2025 00:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBzM-0003JR-4K
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 00:12:16 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBzJ-0000FT-VK
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 00:12:15 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2f43da61ba9so2468824a91.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 21:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737695532; x=1738300332;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vKKjjIIugBtCNk8yP306BjA6akW2VMionZJS3JpFXkk=;
 b=gJCCgOBi9ys0oXzbGMLPxzJIEmULOVVx37wGdjOUwqaplGwlRoXXfAoECeMXUanEKJ
 fe+kHfCGCIGGtxtp6QVMPvg8UaczO3CIQMp3gMp2bYEq57xL8PT/bqG8aUoabROWNieL
 SfQwJy5iyTVq3QGxgyn2NkEP73uUhWMVXg7OEad91bkqR1526I3bJNvY/MCvydGYtMBe
 fAv6v6UlJBd/VR81iHagfu4KPsg400KmrWVb5KBkMb7awTP0w+RzGCqe6e6ddaL2taIq
 lzkuUL8EFnJKAWBEXN9z9nXK46ttUBEcvOHmjPkZAUmqaKCwJ4BQbMW/YQHCMASPatSL
 HpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737695532; x=1738300332;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vKKjjIIugBtCNk8yP306BjA6akW2VMionZJS3JpFXkk=;
 b=goJl43G1pl86Kabt6oS9XEVwHhw04UhNhbL5jcGIn4qX74aymYcJUMxDw1W5DlCJ7B
 +D7mxpuHD8kho8Ada16TyixsjG3PDCINRp+BgplJIF03GD/ro+vYSigu8Vpe1PFh7ETM
 gJ8El38Omon0QR9kgwu9qxd9LL5CQpksEdmNHyGR+QCN8JG08BHOY8eY5uGUPdAvy+1i
 btXYYK+wZIGVzOk2OHhicR10RXtQeXmNo3u6xy689MYP5FpnltwBnOi/CL4lhWIwHOLC
 HPbWMR1/nkzOHU+GIbqH8YymY3k5w/K2eRVCp3vCJb4agRGOGdevZUhy0hQZYDTKXnRM
 u7Pg==
X-Gm-Message-State: AOJu0YyTgR9rsJaH8c6hnC/M6Nx+R7DsNkmzNzKTXG6boXpIa9A2EB0g
 eyunSmOdIXkrYvWqV4sSQMJhmE9zZMEaGdxoYOgXNPG8KBkiEb3oC+CBCCb6i5nntIPjzqsxyvU
 qYUA=
X-Gm-Gg: ASbGnctqvs40iT/+h3E5R0pel+WUmA6RNuQ9DpYtdrNgJGnB5jvv5s3To8XnT/Ka8TH
 5ElsVT9VBlWmAkJOShAasMAiCheAPSNT+YKKUlmAh7m2FSbwKAVA8Erdp56bJL/+7kzNYJCmCaL
 JmyGake55tewt+5s3nluXI8fegQUFV0kWOglQV+sfTlXkYA7Hmvu3D9tFHzthbwZkxp+9SULclr
 oPjSXY9Ndxu2Nz1F2XtBaiCKqFc6jiuNQ3CoUB/KrrOK/uzRhGlUR6QTbJ/ECD250EsgEWiOZ7d
 +TuJqfex
X-Google-Smtp-Source: AGHT+IGU5WZoGGKRvD+Z8u1faxjxbEQsgLZg1HqX1Eu7JFScIMAROXJWZLm85C+mCl1D3l+t0SgoEQ==
X-Received: by 2002:a17:90a:be08:b0:2ee:d7d3:3008 with SMTP id
 98e67ed59e1d1-2f782c93dbemr47642159a91.12.1737695532104; 
 Thu, 23 Jan 2025 21:12:12 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f7ffa83b24sm758331a91.46.2025.01.23.21.12.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 21:12:11 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v7 0/6] coreaudio fixes
Date: Fri, 24 Jan 2025 14:12:03 +0900
Message-Id: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACMhk2cC/2XOTQ7CIBCG4asY1mKgHaB15T2MC36VhcWANm2a3
 t2pcYFx+RGeN7OQ4nP0hRx3C8l+jCWmAYfa74i96eHqaXS4ScMawTjrqU3Z65eLidq+A8mU566
 zBP8/sg9x+rTOF9y3WJ4pz5/02G6v3woXVWVsKaPGGWmsESb04eT0PMTpYNOdbJkRaqpqCkhD5
 yBoQBzgj4qKNm1NBVLZqdYFaLjQ7I/KmkJNJVLOA94rLSj7e/C6rm8d1DLAVAEAAA==
X-Change-ID: 20250109-coreaudio-c984607e1d8c
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This series contains two fixes for coreaudio. See each one for details.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v7:
- Added patch "coreaudio: Remove extra whitespaces".
- Link to v6: https://lore.kernel.org/qemu-devel/20250124-coreaudio-v6-0-11fbcb6c47cf@daynix.com

Changes in v6:
- Added patch "coreaudio: Remove unnecessary explicit casts".
- Link to v5: https://lore.kernel.org/qemu-devel/20250123-coreaudio-v5-0-6873df4215a0@daynix.com

Changes in v5:
- Added patch "coreaudio: Improve naming", removing verbose names like
  outputDeviceID and audioDevicePropertyBufferFrameSize altogether.
- Link to v4: https://lore.kernel.org/r/20250117-coreaudio-v4-0-f8d4fa4cb5f4@daynix.com

Changes in v4:
- Splitted patch "audio: Add functions to initialize buffers" from
  patch "coreaudio: Initialize the buffer for device change".
- Changed the message of patch "coreaudio: Commit the result of init in
  the end" to tell that early returns happen when there is a fatal error
  or the device gets unplugged.
- Link to v3: https://lore.kernel.org/r/20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com

---
Akihiko Odaki (6):
      coreaudio: Remove unnecessary explicit casts
      coreaudio: Remove extra whitespaces
      coreaudio: Improve naming
      coreaudio: Commit the result of init in the end
      audio: Add functions to initialize buffers
      coreaudio: Initialize the buffer for device change

 audio/audio_int.h |   2 +
 audio/audio.c     |  24 +++--
 audio/coreaudio.m | 284 ++++++++++++++++++++++++++++--------------------------
 3 files changed, 166 insertions(+), 144 deletions(-)
---
base-commit: 7433709a147706ad7d1956b15669279933d0f82b
change-id: 20250109-coreaudio-c984607e1d8c

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


