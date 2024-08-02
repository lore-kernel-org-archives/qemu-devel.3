Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE836C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 21:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZzs3-0005L3-7c; Fri, 02 Aug 2024 17:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZzs1-0005KS-QE
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 17:31:29 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZzs0-0003IX-4c
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 17:31:29 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5afa207b8bfso9159769a12.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 14:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722634285; x=1723239085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SsIJvXECX3ZUrG58uSJMHDT5xr/6hYjddrPUH/LP6yY=;
 b=WQPgDAYI8gwmZdR6Zs9h7D+6g3jpCLOvzZTBuFKqiPOcid7eF1nr+6idrO2Nsjs0J8
 iJ8Z218HYDNQIwHKv+lUISicx3pQBGG0uSiBEUz0IbsqJ5b90vIO51I+PJmu0oYcBiZg
 dCDEibYpDNDgbpGlFcdAtj0Aa/GroVJaprRWUOkFALqE/MeLlMKsszdrEoshYJgY5bzf
 xmvcTQYCToaTImTkepM6A5vuarrPDW+muW3qRlEDNzTCT7U7MYBTD2QUOaavcS+sZPnB
 /IiKk2sO4+cmOFoZZyLmfw3FZ9W35vj5a2bbemwXL+6jitnQbYTP7Zg4nLyD3HVbqB1B
 12ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722634285; x=1723239085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SsIJvXECX3ZUrG58uSJMHDT5xr/6hYjddrPUH/LP6yY=;
 b=GNt10dFQK++TFDLjCRQv5NvK7+S92rkITjpBJph9te1JkjgopMBEeEMYkEnmWFuKYy
 ZvitqUw0CrsLYgSoDcK924wW046Q5aiGFty51Ld8g1h+Rt5SfI6r9f+2MMMMlb7TeQZ4
 uYq1sp9v/BzVa0tP/m6Ln4+oafcyirJfrrQn9OG2snuHbjtRE6qJKlBwsBJvr+11za8D
 yA/JPOED+5jgcjCLPgU4VwHKKVRnE9ayGaOfkl4e4WTFDyZ2rN8hqXv4NNDiJtcTdqQZ
 WE6OcA6mkV6INhva7y76QJnLqQ2Om+LVGNmRp1KLnNbEF9QOGFAtbmQ9Y1MjaUB61KX0
 0vvg==
X-Gm-Message-State: AOJu0Yz6BMVHeH04TdLuUZcQYCEek47703wkUFUO4rsmTZDhume1u9m5
 46bOuva+LegmfbjUzhfCH0O5w6DtKmwKmPiWc4O/aYFXh15G1CTbnnKPejMwa+3I7HiGMDkeG5j
 o
X-Google-Smtp-Source: AGHT+IF5QNcS6x1+LlrxAxH1Z72XR1Sw7qN3z1CwlNKwxrKlEruuRjt/nFOqEbZrnJXGcu1wdY5wlQ==
X-Received: by 2002:a17:907:2d27:b0:a7d:3de1:4ab2 with SMTP id
 a640c23a62f3a-a7dc4fa885fmr275820366b.27.1722634285289; 
 Fri, 02 Aug 2024 14:31:25 -0700 (PDT)
Received: from m1x-phil.lan (cvl92-h01-176-184-49-210.dsl.sta.abo.bbox.fr.
 [176.184.49.210]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d88650sm137862566b.152.2024.08.02.14.31.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Aug 2024 14:31:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH-for-9.1 v5 0/2] hw/pci-host/gt64120: Set PCI base address
 register write mask
Date: Fri,  2 Aug 2024 23:31:20 +0200
Message-ID: <20240802213122.86852-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

v5:
- correct wmask (Zoltan)

v4:
- invert patches order
- set wmask in DeviceRealize
- update patch descriptions (migration, Resettable API)

Philippe Mathieu-Daudé (2):
  hw/pci-host/gt64120: Set PCI base address register write mask
  hw/pci-host/gt64120: Reset config registers during RESET phase

 hw/pci-host/gt64120.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

-- 
2.45.2


