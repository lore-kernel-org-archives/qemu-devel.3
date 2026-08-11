Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E9FC5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnar-00012h-2Q; Tue, 11 Aug 2026 10:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnaW-0000LO-8E
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:36:21 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnaU-0001wD-PD
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:36:19 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-8efb708b1a0so18945316d6.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458978; x=1787063778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D3MDMyFwx9BA61yhNaWY6HqytTiFGsQ7fXIYaLXoOcs=;
 b=cjTn/Em1k7SdRoDArbLvPuqb2U9CoXqHnhORz5GKHCXo4NcQ5bILwAbrLKY7gIVdh2
 tI11ps0AxESGm/1YlFra5Xn4GFAShSHwr71f0TGtIxw8sC3LIZO4RhN7954PNrlhsbF9
 /j+5pAfoIP22Pi42wYTMDGI4yQ0kNBBkzCy/KZCmzmyVDOmjhcQhf/GZP1i/+h2uUIe7
 avnMsLKiuy57Nm2aURRqz8fP8Jl5zyw8Y6ij1NipKTePIekcwlrTJYWD/9O3eBmkw7Fv
 Lf9l6mZO/L0bnlsiV21pg5bgNhV5kzs09CLP6F5xoat0FnF57BFhbFmTVtwuGHs2DwYe
 jVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458978; x=1787063778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D3MDMyFwx9BA61yhNaWY6HqytTiFGsQ7fXIYaLXoOcs=;
 b=W2F45Fa6DhdeYTXGm4iMgzXlv+vgMSHO5BodkR5MRXYT5OBkqBTk3d5CoW95AEVJaq
 NANJ3s7CusJsPNWdDqhs9LauRMo6OxrK2TynUCOs/TLB0z2UumE+zaG10hWhRGJYE/4B
 3MCmSn7ebD85VKzZMUH02jvSHTXUUQFKZ4RKpbkH+EkXITZTaJJbZh9fAYcwSpXrqxyp
 SxRGPt+hdcJrSIJY2hKFSmVatWFzLvrJvZkFNIrwKZBRzfUjjStsgfeOf+S7gPdYlVhp
 8C44U1PZ7GHbnR2dW2BJQEQtTC0Gjr+fhH6D7ThdkcoBkrSeQmRe59zAUmVoPdN6HNym
 hMBg==
X-Gm-Message-State: AOJu0YyS5pCwo7SVDMWIlr+1CC9+SStVf8W6l3U5oclpjy7OmRTztrTF
 yn5UeI/HKFIT2rsXnpl4LGXYcJM3skDKVsTgWv4lqJqhY5OvMyDiUNglmq0DXA==
X-Gm-Gg: AR+sD10pGze43GQRzRALH/bIqMTLnq0AvyiHAWaasKZHl0JXdgfXOSFwvxeqIeUY4r0
 TURHTYft4viXDLSgeBr9dIJxrIlky59mkxRiDD7PQYuvomITAKeTC3XUgQ2HtGgn71xtF+Eaq7p
 Gl8282YBjqPZTPxSMkhE1LcavU41Wlvpuqd1vWKLpgYNRe9dwfyeBx6QsjmNZliKDhPovIgN99C
 JHrZphGOq3XGltoSQX8U00VfaxMr9yd/L7KJFHy2imXJKLOz5D5EYUJNWKzH6Bmc9e5KdWpo+T7
 Wqjv27l3mPrLUNf0xnaSYAPmvtlVfmggeH5AlB+pgvVeLCx8DyHERdcuidKFcAsqboOmyrhINog
 vfvrv2PU+BXddracn1T1QoHAWAJYumAKdTBuNsyiwJ5ki7B6wyZtRXN5onfDVfzLb2DlZmg8nlm
 cOZLjHBWJzK4bosB2tfaQxUsTwTkKTDak9nM7xYC4wM3RjS++47Wry3+Jr0VYpZyDvbuYhQkfrH
 /vUi/MUvg1hU4hZryU=
X-Received: by 2002:a05:6214:3204:b0:8dc:ad48:70a7 with SMTP id
 6a1803df08f44-90a6c27faa6mr3659446d6.26.1786458977557; 
 Tue, 11 Aug 2026 07:36:17 -0700 (PDT)
Received: from localhost.localdomain ([198.16.145.87])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c26e074sm681286d6.2.2026.08.11.07.36.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 07:36:17 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v2 17/19] hw/net/bcm2838_genet: fix TX ring activation check
Date: Tue, 11 Aug 2026 10:35:54 -0400
Message-ID: <20260811143557.7862-18-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260811143557.7862-1-marcelomanzo@gmail.com>
References: <20260811143557.7862-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qv1-xf31.google.com
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

bcm2838_genet_tdma_ring_active() extracted the per-ring enable bit
from ring_cfg_reg using the GENET_DMA_CTRL register's EN field
definition (1 bit wide, at bit 0) instead of GENET_DMA_RING_CFG's
own EN field (17 bits wide, one bit per ring). Since a 1-bit
extraction at bit 0 only ever reflects ring 0's enable bit, every
other ring (1-15, and the default ring 16) was silently treated as
inactive regardless of whether the driver had actually enabled it.
TX traffic hashed onto those queues was dropped with no error,
eventually tripping the guest's qdisc watchdog ("NETDEV WATCHDOG:
transmit queue N timed out") and causing intermittent DHCP failure /
link-local address fallback.

bcm2838_genet_rdma_ring_active(), the RX equivalent, already used
the correct field, confirming this was a copy-paste error isolated
to the TX path.

Confirmed fixed across repeated boots: real DHCP lease every time,
0% ping loss, no more checksum or watchdog messages in dmesg.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index ccf3c2fef0..bb967ad845 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -517,7 +517,7 @@ static bool bcm2838_genet_tdma_ring_active(BCM2838GenetState *s,
     uint32_t ring_mask = 1 << ring_index;
     bool dma_en = FIELD_EX32(ctrl_reg, GENET_DMA_CTRL, EN) != 0;
     bool ring_en =
-        (FIELD_EX32(ring_cfg_reg, GENET_DMA_CTRL, EN) & ring_mask) != 0;
+        (FIELD_EX32(ring_cfg_reg, GENET_DMA_RING_CFG, EN) & ring_mask) != 0;
     bool ring_buf_en =
         (FIELD_EX32(ctrl_reg, GENET_DMA_CTRL, RING_BUF_EN) & ring_mask) != 0;
     bool active = dma_en && ring_en && ring_buf_en;
-- 
2.47.1


