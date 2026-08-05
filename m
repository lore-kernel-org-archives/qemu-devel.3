Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A0BC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrdZf-0005qc-CN; Wed, 05 Aug 2026 11:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrdZV-0005o0-Sv
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:30:21 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrdZR-0007dN-OZ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:30:20 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4af81963f35so459654b6e.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 08:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785943815; x=1786548615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ceor1s7HR8GNDcyh7kwDT8r2E1Lvax6O+6vcMQOKk04=;
 b=nwLBbdx5CGluiUXjftLIP5KvyqUktfo/PubRKNtK4uudVLLLplNVDhM9kdl54o232P
 oRqtOvwo2CO5uBFw37ydz4KrrV+gQDpt94tbK45l4kCF3mGICWOkJwaEmHzqYJCvhm6m
 g/npMNJFNzDqaOPgExLSny9URyo2MQh4Lja71etawYDyY9JcgK7pahr6VP3eDVB/wYtD
 /avBwhEUqXho3V6RuFLIBkifc8BoH1UMCkrfonWZRAA0vVELwSumWbMBtrQtxKDqo/Xc
 7M7bBzPq4hsAkx/dFRthZXIaJGtUVJBuG5rPZf2cAb+ccRjHu45vjo3b3xPeik0q+ZZy
 c7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785943815; x=1786548615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ceor1s7HR8GNDcyh7kwDT8r2E1Lvax6O+6vcMQOKk04=;
 b=qe7ofbjr/PXvttvqPuf8B2O+PKmYtmh0Q4Jr3sf1LxoWZQ8SKd9COYVAi2SigU2GUy
 BJDvVpJMxe1wLCrI3PlFn+hPKr5vNk3S9iUBaKiim2osMG3gnQXXuL6nUne1xhc2Alnh
 tZP2xemMcMaQ7seVaCTLcxHNDBm798p+sJbsC02+cwsriAbBa22qcX4A/kZ21lfsbUm8
 ZN3OAaQk1ouCo7JYmRROf4zLrYS1l1p8jm5tmpsUbGn+9rmfDMxJdV0KTpeEoS02GoPf
 0DvQVBAsoY+BXw++gUgvkugGnQ1SHGokWS17ZM6U5IYBwTzc8WY5zO65Trrxb03KP+oq
 K9Nw==
X-Gm-Message-State: AOJu0Yztm36diy2k4+E1kuu6J0PiGfpn3hXAfNnTdlB8NTGku8Zbs/Iz
 yQ9DJPm0S8gSesXQTpG6MPg1EGYgh3XhbPkp7+uzp2br3F45/I+VctulQSh/TAzZ
X-Gm-Gg: AR+sD10mcwzOswi+4dmye+VXPmaFIupYON8+vlOVL+DsfIUDyC3igT/JYMFCpwFDQGH
 17xm9CPaXBdCwr2niNS/p7u9QcID3eOwmpNJuRzFHJIeG65OZ7UAqDX+kBAErrVAs3gi0CKzGaT
 Q5ZVQAYBoYrge51oUihxjtMM5QG8m0RZXJWksg5z1RxN3JzSIFlpntaGDZvqNvvHzzIVHRNLpdo
 1skcTW9Zo7UEVjqwZbvACpbbxFRaBUi58VYg4SW1jt3mstgptcRDsIr/6SnJA3h9CnhCrOo5VF2
 3PHpZZFVe4oTazjm85a8JTcGFJeiKBqUDn/OY/nvyi2QD3hiajCp/Xwpj0a5yU+z14D81GjeMoa
 H9G1OyOARoCYeEoj3p1mdeSFrzqIp7qbZOnNWaJ4tMHUJNm8EgB8bMnUTt3ER2A8HBJdzNhnx5j
 EMic7ToXPTclTKBJjnPOdDFAp/SP3a+3ZRNEbW8I57fRvE5I57nOKoGiYXHzxQuXjT+/JVOZtC6
 1+QgLmKx7pw
X-Received: by 2002:a05:6808:1986:b0:4a3:fb6c:9adf with SMTP id
 5614622812f47-4afae067fe6mr4614720b6e.12.1785943814706; 
 Wed, 05 Aug 2026 08:30:14 -0700 (PDT)
Received: from HPE-2MQ6131DV6.ams.hpecorp.net ([170.85.99.9])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4afae75ce1bsm2185614b6e.15.2026.08.05.08.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:30:14 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Owen Giles <owen.giles@hpe.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Robert Elliott <elliott@hpe.com>, Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH v2 5/9] hw/misc/iotkit-secctl.c: add SSE-310 support
Date: Wed,  5 Aug 2026 10:30:01 -0500
Message-ID: <20260805153005.9989-6-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805153005.9989-1-simonxhy0404@gmail.com>
References: <20260805153005.9989-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add SSE-310 secure and non-secure ID registers.

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
---
v1 -> v2
	With the bug fix from the previous patch	
---
 hw/misc/iotkit-secctl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 93753c2ced..9f6fb81088 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -109,6 +109,18 @@ static const uint8_t iotkit_secctl_ns_sse300_idregs[] = {
     0x0d, 0xf0, 0x05, 0xb1,
 };
 
+static const uint8_t iotkit_secctl_s_sse310_idregs[] = {
+    0x04, 0x00, 0x00, 0x00,
+    0x52, 0xb8, 0x3b, 0x00,
+    0x0d, 0xf0, 0x05, 0xb1,
+};
+
+static const uint8_t iotkit_secctl_ns_sse310_idregs[] = {
+    0x04, 0x00, 0x00, 0x00,
+    0x53, 0xb8, 0x3b, 0x00,
+    0x0d, 0xf0, 0x05, 0xb1,
+};
+
 
 /* The register sets for the various PPCs (AHB internal, APB internal,
  * AHB expansion, APB expansion) are all set up so that they are
@@ -232,6 +244,9 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
         case ARMSSE_SSE300:
             r = iotkit_secctl_s_sse300_idregs[(offset - A_PID4) / 4];
             break;
+        case ARMSSE_SSE310:
+            r = iotkit_secctl_s_sse310_idregs[(offset - A_PID4) / 4];
+            break;
         default:
             r = iotkit_secctl_s_idregs[(offset - A_PID4) / 4];
             break;
@@ -499,6 +514,9 @@ static MemTxResult iotkit_secctl_ns_read(void *opaque, hwaddr addr,
         case ARMSSE_SSE300:
             r = iotkit_secctl_ns_sse300_idregs[(offset - A_PID4) / 4];
             break;
+        case ARMSSE_SSE310:
+            r = iotkit_secctl_ns_sse310_idregs[(offset - A_PID4) / 4];
+            break;
         default:
             r = iotkit_secctl_ns_idregs[(offset - A_PID4) / 4];
             break;
-- 
2.53.0


