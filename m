Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBA4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsir-0001PA-8B; Mon, 03 Nov 2025 06:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vFsio-0001Oh-RI
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 06:27:39 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vFsim-0001Xy-Id
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 06:27:38 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-294fc62d7f4so38356585ad.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 03:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762169249; x=1762774049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IH5y8cSTsLuu+kxabeu9Y8wnfm8qwsnFMoMTkwLb6zE=;
 b=ktC6h9rnLn5hy9SwPwm9cOiDjbnKgv4bQP21cGKgTEHQ/FCVeqZ2F32Sl8rLRZL2Tm
 XDwT0YESrcmiQ9TjPxb99BAtapAe19y7tVVZH7aRAmEEsSPfnS4Oob4zs++TIq/xqG2R
 RMYRjgg+rjWW7ndC5ZzV4IhAdry4oKvsm87mTunN/y7Bcp7bixn6fU8Wm5brfkgHV3mZ
 hH9K4Xz/ZvZOE7yPBlwSw0LcFKCXbSeC/eAXGWSpZ93dsJ+2JJSQt68NjVcHLeSFb1PO
 n/IEENwschwLOpXcBkoPJcCZ8aglz5hnT+GTQUFuO672yAUjuInYCBzg/qvyyzF/Jsm9
 DyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762169249; x=1762774049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IH5y8cSTsLuu+kxabeu9Y8wnfm8qwsnFMoMTkwLb6zE=;
 b=ctgfYhYUOBzgk48eV4l79BO9EWoncYVl282ITMpXtMv54dnj0GjQEm0m9HObu2LBzK
 paWVPSIwXUltPDmOiX5fvEf0LH637z7t3mo2tsJ8O5KfKTLFj2KUj5SncYenOIYJJzig
 VZUToLQvBZSuBOOQJaBMZug9D4jRO3mMa3+dyeLwW006Jl/i2Mu0PxnjvhiKnZFYsG3h
 HLtd/l3i7t4dd+fKT/NeiNiJJ2v3dcJg5sOrWJuHlhKVIVkAJ5MzyosKgWp3G3ilUD5F
 xhmnTNc0J6rNP229vyAE+QJw2iILbUyVWKS8MQm6fTzzQBpOS+GC4TzGRNjN36SkgtiB
 jM+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjnu97KXwdnaGLkbXWSsLnSdJXOz0kZpnkn1ILX+dwW1wcbxbwommlCTvih1hhsMAGFW9qPFj3/ZUw@nongnu.org
X-Gm-Message-State: AOJu0Yz6kGb9wUw0lpdWHJq4QT1W6sx/YAQ2KlICclPzaDo2a50yzDvf
 AXXiaA1xPBnnaZrw/zWHOj+IAkO9axn6J8aPprvDwI6W6abNCp56yyeB
X-Gm-Gg: ASbGncvU7raE9xGMImabyS57V8c9Hq7/HkQDmSoOR4lsTimB4BoJ2W8BljNsVFr8c0L
 eCIjqq4TqpOe7VjBYCSHcdmvgkujfWxWggsU+BlaAETmZ/xIh+HIrUw2lh6RVGgrJiTqyJF4Qg5
 0qR8juMnzE5Vd0NRX4bVQjJnQm7RacjrkWQk5orgk+I9+3bawUZATmtPjUPrzm1ovtWbryFPF+z
 Av1XGgUJ8OnRAoDmOex+6FpvMA1kpM1QcWFtGeoTiV2zpIsjJ3s1ztJaz8KK8wWbp4Oe4jj5xHD
 DUSrtgRR3K1ilmAHB/i198otZoa9QXROla9yFzSuiqBP71gU9kYUtvCDNWZvfskz2f4dJTf+H+P
 eOIpOJ3POYrZtwT6bEEYCR6ReXib2COtTWrI2gLB3epV8Mg3b9i+jhkf4rSEgSJVQ7TKeBTvgY7
 l9pFcGqapLhw5fZVgXPZuecrDvMcSJiKamNsRwshMXFtW12PyeDQ==
X-Google-Smtp-Source: AGHT+IH9BXQZAP/GoIyrBaPEcQFy9m9NUOWd+VUNWPUR6cqxxTVwWT8pkSWvg1z/tAmiUpay2G6QKA==
X-Received: by 2002:a17:902:ecd2:b0:295:2cb6:f494 with SMTP id
 d9443c01a7336-2952cb6f57amr137058555ad.6.1762169248896; 
 Mon, 03 Nov 2025 03:27:28 -0800 (PST)
Received: from fedora.. ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341599f14bbsm741661a91.13.2025.11.03.03.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 03:27:28 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: mark.cave-ayland@ilande.co.uk, sarkarsoumyajyoti23@gmail.com,
 linux@roeck-us.net, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 deller@gmx.de
Cc: Jason Wang <jasowang@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v3 0/3] HP-PARISC 82596 Network Interface Card
Date: Mon,  3 Nov 2025 16:57:20 +0530
Message-ID: <20251103112723.12256-1-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pl1-x642.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Second round for review:
As suggested by Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
- Removed inline from the i82596_translate_address() function
- Added trace-events for 82596 rather than using the ENABLE_DEBUG flag
- Added TYPE_LASI_82596.
- Removed and rewrote the functionality of lasi_82596_init().

As suggested by Guenter Roeck <linux@roeck-us.net>
- Removed duplicate define in hppa_hardware.h
-----------------

As part of the Google Summer of Code 2025 program "Implementing LASI
Network Card and NCR 710 SCSI Controller Device Models" I fixed various
bugs and enhanced the existing Qemu i82596 network card implementation.

Specifically I added the following functionality:
- Monitor Mode
- Promiscuous Mode
- Support for linear mode, segmented mode, and flexible memory models
- RX Timer
- Bus Throttle Timers
- Support for Little Endian mode
- Accurate CU and RU transition State
- HP-UX Specific Behavior Support
    - Support for Loopback mode
    - Self test
- Statistical counters
- VMstate descriptors
- Polling mechanism
- Transmit and Receive functions

Please review this series, as I'd prefer to get them included
for QEMU v10.2

Thank you,
Soumyajyotii & Helge

Helge Deller (1):
  hw/hppa: Enable LASI i82596 network on 715 machine

Soumyajyotii Ssarkar (2):
  i82596: Added core infrastructure and helper functions
  i82596: Implement enhanced TX/RX with packet queuing and filtering

 hw/hppa/hppa_hardware.h     |   10 +-
 hw/hppa/machine.c           |   31 +-
 hw/net/i82596.c             | 2405 ++++++++++++++++++++++++++++-------
 hw/net/i82596.h             |   74 +-
 hw/net/lasi_i82596.c        |   36 +-
 hw/net/trace-events         |   21 +-
 include/hw/net/lasi_82596.h |    3 -
 7 files changed, 2032 insertions(+), 548 deletions(-)

-- 
2.49.0


