Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66CEC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 15:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnfzh-0004Om-1S; Thu, 27 Feb 2025 10:40:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3VofAZwcKCqsgPYefcPRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--venture.bounces.google.com>)
 id 1tnfzf-0004Ny-JZ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 10:40:11 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3VofAZwcKCqsgPYefcPRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--venture.bounces.google.com>)
 id 1tnfzd-0003MT-V5
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 10:40:11 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2fc0bc05c00so3526940a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 07:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740670806; x=1741275606; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vATRtvB1MuGKCPpZKPTC8CQ1uuM3KZNlItHcM8oSpj4=;
 b=ZtM92sZBrUlJNH/YSlkSjUaGpV898nYLNL4jz/UEjY8qfuPmw4VTcSl8sH/qpLzp3h
 vvsC8l4hNOhd28ky8+SgvAILgRG2OFvHl/uaMNiq8w56CgJRx9l2iF6BLu5xNbFHBNJ0
 +c+HHK55+3lPuqlBJGYMHQlKsvyzDXbDC+R7/83aU70yOl1QYAj90qcTDkgdJ/JKrudv
 LuVFEvQJc2cWDa+c3JgCdAZ7s+dtS2yQkc9YivOFHTkTPlC8HPUoTukFnsNoJ8UdsuZk
 oKNfFf6fuDBnSwhzdj+IckdtVWZSg8qeLpRGYJoKnsi4YCSkCB1g+m9iiZQevqWKSfN7
 SJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740670806; x=1741275606;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vATRtvB1MuGKCPpZKPTC8CQ1uuM3KZNlItHcM8oSpj4=;
 b=WzC6baKw0ZQ1w3Rf577/W5nmCGzPbUKlD1M2z+FgeLiFDTfD4Jlsyhm4u5WSUYLFa0
 G+SJPQI37a7Nkj5wwvmTtKmTGgExS3RsP3PXJbECPnQ1Xqku1CWan7IL6s36xW3VAoqd
 qeCIXfdOfDkfus0oPTE1u4C6PHFhemvKMopoGWX4t27jsDCSXBqDSQe2LXGHvJxVxGe6
 DvlV0Q5kYBPgTwkizsygfMDRtnsdddLVUkrV8AN/xUl3jc0sZrwyKm/RE0274QxjAZnL
 O+f5pwpO3fFvRC93zCvkRg5mvExIw+7nuwwdbhwQnECHhxVG7o+yNxsVkOzxrpLuszaK
 Oj8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX84LjQU1mSm3u0re/fx+FEsHYfxVg0pLHPL5+tz+BxXCPiONbenVc7g7NAPwUT7tS4CntcZQ2FxyAS@nongnu.org
X-Gm-Message-State: AOJu0YymckaOWeBYx8lN0/l2OSb9adDqgNh14zhOfbeg6tdettO7OJKw
 4mB44/noP0ClUbRGkRtgoN8k3Yo3ZpjEtH6AC8N4SxebDYSzRzFaqOI/TBIAcBrmIo5vusXxUSP
 oQJ6zLQ==
X-Google-Smtp-Source: AGHT+IExloInBjyWlt+YnsDPEsJApbIigwfhxyGgKHwydzExTfNKp/lnvH1HSGLwWn0GyfOelxB7kjBFZrD4
X-Received: from pgby4.prod.google.com ([2002:a63:6404:0:b0:ad5:1ae7:2563])
 (user=venture job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3a93:b0:1ee:e0c0:85a8
 with SMTP id adf61e73a8af0-1f0fc139c4fmr20808069637.15.1740670806091; Thu, 27
 Feb 2025 07:40:06 -0800 (PST)
Date: Thu, 27 Feb 2025 15:40:03 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227154003.1646017-1-venture@google.com>
Subject: [PATCH] hw/net: npcm7xx_emc: fix alignment to eth_hdr
From: Patrick Venture <venture@google.com>
To: peter.maydell@linaro.org
Cc: kfting@nuvoton.com, wuhaotsh@google.com, jasowang@redhat.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3VofAZwcKCqsgPYefcPRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--venture.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

'const struct eth_header', which requires 2 byte alignment

Signed-off-by: Patrick Venture <venture@google.com>
---
 hw/net/npcm7xx_emc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
index e06f652629..11ed4a9e6a 100644
--- a/hw/net/npcm7xx_emc.c
+++ b/hw/net/npcm7xx_emc.c
@@ -424,7 +424,12 @@ static bool emc_can_receive(NetClientState *nc)
 static bool emc_receive_filter1(NPCM7xxEMCState *emc, const uint8_t *buf,
                                 size_t len, const char **fail_reason)
 {
-    eth_pkt_types_e pkt_type = get_eth_packet_type(PKT_GET_ETH_HDR(buf));
+    struct eth_header eth_hdr = {};
+    eth_pkt_types_e pkt_type;
+
+    memcpy(&eth_hdr, PKT_GET_ETH_HDR(buf),
+           (sizeof(eth_hdr) > len) ? len : sizeof(eth_hdr));
+    pkt_type = get_eth_packet_type(&eth_hdr);
 
     switch (pkt_type) {
     case ETH_PKT_BCAST:
-- 
2.48.1.658.g4767266eb4-goog


