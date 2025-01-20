Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39ABDC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXA-0003rn-5v; Mon, 20 Jan 2025 15:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyX6-0003pv-Ab; Mon, 20 Jan 2025 15:38:04 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyX4-0002UE-T0; Mon, 20 Jan 2025 15:38:04 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso903768766b.0; 
 Mon, 20 Jan 2025 12:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405480; x=1738010280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0nIpK+vgsWpATL4czO/j2RJH+dpZL7DdfQsmB3VvxNg=;
 b=UgiTeYZyHQtpWCSHqTUAMiP8HewK8DSx0TNR2oa8zIbKnYXb9eJu/qcSHjbO2X9N7E
 GGnfZuIDgx5IVlC8YXAJzCLZi/gsIV7FvvNvddDXeWP9Bb77f2826zCyuECXhvGSXOWE
 74mdX0ce1lUt7dbI7RaiJ+kHgLuqxxE8T2+yKfSJEqTLKabsDtGC1HrPpr6DV7ambIN5
 rNawHhCgXkOqZKnhFTiFp5e71nXhVa3teNpDCgbgH8431BJjAKrj+WXIpdYPv3ApTZcg
 RbdclaOR/jNAdC1Xsr4xRTi0QFRxnOTcUE6ihM8OjwZ5FphRFsmefjD+lhYwhmGVT53K
 uh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405480; x=1738010280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0nIpK+vgsWpATL4czO/j2RJH+dpZL7DdfQsmB3VvxNg=;
 b=cs/WG2qPM+8mhv00oT0C+m3O/HLMDpG34/fgQ6yWa2dduvZevRRjw1MF/oMdIi6aSq
 SgzkzhxOGGuBLAog9X66uQWPLGZamTi9mQYs/I4iEk22XWAOOwQ26rHefP7vzOs/rxAa
 eH6TextuILqfNFVTuz/FHpP6tq2VKunHg77JXT1zwwdHzp76+HyNE8OGX6jf0/QdD895
 eEUG6BYmNzRNiWhiclwRoQo+tLkJCDdFvJgTGUtuhKAgHnPZIBl4rb+lsMYVq86h/t+e
 5a8TTsH43uuUnl3nT2nM1uTdhgimbz+4R9sbFc44T7LQJe75k6b9MbNseFmu1f/GxabD
 vaLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUXIKa+L9IclcUE3IFduJXvb0Rr+bnRFBG9nUi7c8ZJL7K1M/bISEqmtVG5nK2llt85u0WUT2e/g==@nongnu.org
X-Gm-Message-State: AOJu0YyJF2ls9s6zynqiYanRE6S4S4v2DzoDceSecU7nU8Op1QuJaHG7
 r+Y0NNL5NrXrol7GOz7/qjafO46uP7plU320CXwXrdrBDXZpjY1veiX+4Rqy
X-Gm-Gg: ASbGnctkwWkKJgMkHgMboYHFTFEiV3jwgv/gnhpjZ+sFOBMXOaNU1wLgCNz/Ijp1hqg
 gNiaBUgMMiWWpOa8RekRkezlODaUujoFZtff1PGhwub7vS/DK4pSPVVHEuffq7xroYcA41ZKN/e
 guEUTCioTlqPz5RySzae5+LSILMCVvKHZRULlSa01PE91JS7tyaMhbJ2U5tK/N2niD+rcu4kLiQ
 HJAmujjfvALTzZDSL6iW9zJrCMoakBLC5qL44iGLy/lQuwZnlRLGFPzeK0mptLQLzF325kLw+Yz
 lwS3mZhVOpDXKdVqFI+/laZMBOYtxUu68ZWIEWUBEwqRRhzvIg9yEyxTR8je
X-Google-Smtp-Source: AGHT+IEHaXhmZ4+5LIK9AWK4er7YHc3bWSFgN9N0g3qr2Am2GD0mNA30ShkB7er+ISsA0V8mCLoK2w==
X-Received: by 2002:a17:907:3f99:b0:ab2:d8e7:682c with SMTP id
 a640c23a62f3a-ab38b372461mr1399891266b.38.1737405480254; 
 Mon, 20 Jan 2025 12:38:00 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:37:59 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 02/21] hw/char/imx_serial: Update all state before restarting
 ageing timer
Date: Mon, 20 Jan 2025 21:37:29 +0100
Message-ID: <20250120203748.4687-3-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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

Fixes characters to be "echoed" after each keystroke rather than after every
other since imx_serial_rx_fifo_ageing_timer_restart() would see ~UTS1_RXEMPTY
only after every other keystroke.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/char/imx_serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index cb6761d40e..38b4865157 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -401,14 +401,14 @@ static void imx_put_data(void *opaque, uint32_t value)
     if (fifo32_num_used(&s->rx_fifo) >= rxtl) {
         s->usr1 |= USR1_RRDY;
     }
-
-    imx_serial_rx_fifo_ageing_timer_restart(s);
-
     s->usr2 |= USR2_RDR;
     s->uts1 &= ~UTS1_RXEMPTY;
     if (value & URXD_BRK) {
         s->usr2 |= USR2_BRCD;
     }
+
+    imx_serial_rx_fifo_ageing_timer_restart(s);
+
     imx_update(s);
 }
 
-- 
2.48.1


