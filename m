Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE7FC55175
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 09:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtN0T-0007iJ-0H; Fri, 20 Feb 2026 04:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vtN0P-0007gn-HC
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:41:01 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vtN0N-0006LD-9s
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:41:00 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48372efa020so14696775e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 01:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771580457; x=1772185257; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OwjDbbDSYRRg9TB+ewjiT268sdOfgsMULYw8nePMOys=;
 b=rPhsgUVsYLLMBt3PMSe5sc0ue3KIW13MDAKfbZQBQIMQrxqRkW4y3x/lZYBa408+wg
 o8gOzRr0XVZcI469ViOrdiORNu0MtP+e2QlASPDlm3klwQg7CJlKovnw+hnSyW/I6nzx
 K9/KonkRXJ89I6hJs6zd41GTyl3YTdulgTgutA/vGH0QdsIBcSWxtTcvC5Oai9GJ0J4H
 l/DeSbRmsdyJ/MRPVOJTryoblY9oMcG3/PW+FyhTDR5ChfzyIV8IkuAGh6jiowVqGTL3
 C5VRrp07gz8VDTg5ETOuCXHidlBkItpMBMVPmPGlvWRGVULGbXx1UMf+fcxqyCzHkI6m
 IwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771580457; x=1772185257;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwjDbbDSYRRg9TB+ewjiT268sdOfgsMULYw8nePMOys=;
 b=g0HpkAD6ryrGeQRb+BoLXZAKNnM0MifwL1E4Wvh9fRvV1K+ZGU6zB4K7qF69mkrV4Z
 ddRJEUlGqibJILpdYto40Iu9FBd09eWfn39SS36VJHk/vxhyFGUPcbjf45y7RgkEnSeL
 B4fV6bEv8QfHgPWtJ7qhYkXpddiTzSjigc8k3eCTvFJmwUTQuVON6CZmVSxegX8pNLry
 VOcFGAjw5SMsLtIu/+W9AixDDWNdIL7QXVqNSQeG5FJlizbRwlD6o/kQ8Aoh+dnGSTvC
 vLkv6jgI0OnQ78J+RMotuxxOqym2MERg6AU3XnD9m/FMEig7X+Rr4Hq2nibjArn7/FmP
 yasQ==
X-Gm-Message-State: AOJu0YzDBjHfwIMWLMf7mhoFAIfAjmItr1S8Uaa6wd5yUe9aj+qhA9CN
 z8Jz25QHIlL3mxMsaquFhEdvaBkxxrE1AsmP6AwETcjt0vIwey21/p93YLKlPWRFQ/M=
X-Gm-Gg: AZuq6aLuHRf1lNTG4GTGdKhdnD602fGtQecR2DpqzYM+z5QkHM3TGOC19pesl8s31vI
 OqPVvldBjb5OAhQB6uMGJr0wCc8VnZVduj1r0ePAa6UX3251k8G7NWsmVZuCO3qqLgxLjCWoF87
 WGt8EcJlKqNHEwWxA2D3hhCDZjTNrSLyY7g0Exq/SSa8MlbEhv8kHRHFE8K+w3k8zpzJ2D7Qsdb
 V/VrDeOwbXftf2HTkqO/1VJ+SKxwWIudyxWBWWjBD5yXkWUG1y19bme9y5/DMu2uC0gO8GmmBq2
 g5EW8NbGDpyjQRj9jJbtSApiClKX0XKtLtBPiLwf2cSwXtoDsXWFx0WDJ/IgQfwG5PEgiV8RkvM
 xreWGChm2qJUlTBMpcQJK46qtwlgQu6icdui5AsccaJOkLC/VL1+jvKGXLBcYGhcxxVSdYpEPhq
 yQq7+Cbw2ZV8Fo9pxErT+DxVR5b8+te7G9c8SVlEMsXs/kDqGeyMZGYKLabecOm9cKOD0SIa5UE
 8fsX65sh/fAcme3Ih+ZcILbI8lUu/A3EKw7fgk=
X-Received: by 2002:a05:600c:3488:b0:459:db7b:988e with SMTP id
 5b1f17b1804b1-48379bbcb51mr337597875e9.13.1771580457136; 
 Fri, 20 Feb 2026 01:40:57 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-215-248.home.otenet.gr. [2.86.215.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac87sm58432818f8f.3.2026.02.20.01.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 01:40:56 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 0/5] virtio-snd OOB fixes
Date: Fri, 20 Feb 2026 11:40:11 +0200
Message-Id: <20260220-virtio-snd-series-v1-0-207c4f7200a2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPwrmGkC/yXMQQqAIBBA0avIrBswKcGuEi2GnGo2GhoShHdPa
 vkX7z+QOQlnmNQDiYtkiaFF3ylYDwo7o/jWYLSx2hiNRdIlEXPw+FP0ji2RGwdrCZo7E29yf89
 5qfUFCdSLOGMAAAA=
X-Change-ID: 20260220-virtio-snd-series-d9e6aa95466a
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 qemu-stable@nongnu.org, 
 =?utf-8?q?=E7=BD=97=E9=93=AD=E6=BA=90?= <myluo24@m.fudan.edu.cn>, 
 DARKNAVY <vr@darknavy.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=901;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=l7+zLrulbrmTxVwCpnwKrkPpynl3KxjGdeD0do4WKNY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBtQ3duRGQvd2E0N3Z1ODFTeGw5dzQ3bHgxRkVDCnYzQ2U4cE9Ba0xMY25YZjda
 TWFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYVpnc0p3QUt
 DUkIzS2Nkd2YzNEowTHllRC80bzZrUVNPUXdSdmRUM2dSSTFvVm9lVVBTTGE0RTUrOWxLdWVaMQ
 p0ZzJtbzVSTTJyMFgvWDdVMkU5Tlk1TDBHY2ZSbVd2WEdldlRrU3pNU3hEaitNdnpvM1ltdVlMT
 0xVNE02V0x5CjJuYTl4MDJLejFNVWlQYTFUUXNVblJ0UzZxcVFoMGVaUlBFUVA4cnozQUVYZUIx
 OG01OGVWeWZkNGRHWHhsQk8KYzY5NG5lSVRjUGhnZTZzVy8xMEpvOGM1dVNFanNGcEFhdGJ3cEF
 IL0g4Z1ZEV0J2T01lVVJ6UUhHT0xGTXZHNgpLd3RkVFg0NkhiYW5iT1J4UVVGYUJBeFYrTE5TV2
 VhazQ2VlFPenZZOXk2N29kREN1SUdkTGo2clVVVmgzblF6CnFJZXliR0pITEZJbnk5R01OMTFrT
 jNINGUzaHdSczcxdFR4Z2tHQ2xIa1o1OFN1bzNkVFFlb0xobW1pNU5pRnIKSHZkU2tSWHVLZ1d1
 RlEyeWtrdVBqTTlBUFY4R0ZZSXcvT3hjcnk0YzBSZzlmSEkyU1F4Z2lJR0hDQVZJV2dOTgpveEY
 3dkxheXgvL1NjWEtlVm5SUCtyb3I4cXdtSEFJcnFJZnpFU0d5YWlSTjhMQkdYWWU5aG8yeml3Lz
 lWU1RtCkp2Y2ZicEg2QzlJdEtRZWg3ZytnSGtsZXk1ZlJxME9GK1c0N0tEYmQ5RlpPK2xzRXdpT
 S9QeFhSQSt3WnljMEwKWk1jWXYwNEpkYWNudXFOcWJGTE9CYlpqVk5vK3g2bEptdS9nQVhuWGxv
 Yk5SbWpBa1pQR2h3bVVKYXR0THpvRQpZWUdKWTVjYm1UVEZHTjdReDRvQThrbEhhaldNd08wNXR
 pVGdKZzlmVFdVWkg1N3RWMG5MQ2tVODF4c2hHS3FiCmcxdW93UT09Cj03SUZuCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series adds guards against two potential OOB memory accesses by
checking for integer overflow, and by checking for the correct size of
input buffers.

Also, at the request of mst I added myself as a maintainer.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Manos Pitsidianakis (5):
      MAINTAINERS: add me as maintainer to virtio-snd
      virtio-snd: remove TODO comments
      virtio-snd: handle 5.14.6.2 for PCM_INFO properly
      virtio-snd: fix max_size bounds check in input cb
      virtio-snd: tighten read amount in in_cb

 MAINTAINERS           |  2 +-
 hw/audio/virtio-snd.c | 68 +++++++++++++++++++++++++++++----------------------
 2 files changed, 40 insertions(+), 30 deletions(-)
---
base-commit: 07f97d5da04a9f97e273de85c76f5017d8135a6e
change-id: 20260220-virtio-snd-series-d9e6aa95466a

--
γαῖα πυρί μιχθήτω


