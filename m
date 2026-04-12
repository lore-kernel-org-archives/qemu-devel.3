Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EAEE937E4
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 14:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBveW-0005Bm-Ll; Sun, 12 Apr 2026 10:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivien.leger@gmail.com>)
 id 1wBv34-0007b6-Bf
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 09:40:26 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vivien.leger@gmail.com>)
 id 1wBv31-00051W-Qt
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 09:40:26 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cfd1f9fd1so2260551f8f.3
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 06:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776001222; x=1776606022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ArzLsLDSjc83muoLDyS1M+CRJjI1FneSSOb42Mz0oPY=;
 b=N3jWnB5ux8pKIB21C7VnD/zN5WtnGisG2xBPXHgX0/ShW15fArJBlzoko+wwASQLQe
 +Zox5tpmJzsfLaNIg7yZOgmOgSbqdWkf6y5VWf/I5RY4f3oIWsRhS+FOt3YNIdxLHm0H
 mzGaRcwbCiZVSf95tdMGjzVgL24sWcxRRoeUYR0/1JyBZGgOd/4rcxNAowyPeFxUZ3HH
 VqYQxV3bFDE7MIAmNDJinhhe9qx5Q37jB8lLy/j7l7AztCFASCXESImK6B2+tc9dCTOP
 mwe6aJptGYqmL25KAAB05LPOq1PWbYszbTGjt+hsSChOrdnTu+208+pms5LZoCvi+7RQ
 Wejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776001222; x=1776606022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ArzLsLDSjc83muoLDyS1M+CRJjI1FneSSOb42Mz0oPY=;
 b=FnwdGQkDEXuMZcQeQ/4+X0yG4UUgJGq1OEkcasUCRXuAL5zrqzWmK7KJS2JQHH98bK
 KPlcss635pD3sLHTWAdhdpyTR048524ch3x7sNPpjQAF+QkrBvjWDIcaR3DBEnXEqD2X
 5zGvep0DWo24WlUheOgOOfCxe9XJT6qjvsXQ64arzKUamKKYEhI2OIA+wl13Iq2qLxbL
 8etWEJ7+F2zZ0O6fBpmLs+Ro5ron3bw160qmZMi67yC1bU5+BCQj9RmOwugtqczoFZ0s
 w5Vof8wCkj/QU4/JeG4cxXEffdMW08Y5QqsFwSQGGt4ZIGEKX37H3+zU+ttQ4WETCptI
 xrkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IvTCOfB3QVODlYTSMiEAIxOHGqu+v+p/ZVV70eGvR3T0N0xGshZ/L9CfiDPQgIeJJI598jiVgxU89@nongnu.org
X-Gm-Message-State: AOJu0YxDfYg5ky/RI8bERRbQy5c95qgzINIrhN41Wjn4i635XGGn7u7f
 I6C+YxkBPJncaRpKe3RUWS57bvSBCfEt2T++lqBqTx+QNQE7Ffy0ms6j
X-Gm-Gg: AeBDievbfikGItyqUX/K98LFxVCZRjLRQMGUAJDDthgtB2UpusL4pOxb2c43pCleS5M
 GhQqo5aqfVNyktbCe/v/OqZ2jww7HrdP6HoSKtcdqDf5GM53KAxl8AHUjenW/7eKGQIxZi1/Um4
 7W0dO2/VhD062sXFrNGnZgDKdpQd36e8YM1asMAHrsSWw1v0HJ/FMTciipHaaGAOiMoFy3ZGJ3u
 RQvU/9yTHflTsQOcygMscEyxSwnb2qknLPXuX5NiqXjShF2g012nfjuO6xfFeuGs2C9Mu1KHs1u
 zRvFOROGvT5EXehl5A+CCnJ/BzuJQUfSfXywWAeHXykk+X5G3iJ4XYRn3IEuNb1LPlmTjxXwcTT
 cPADhvUd7AjsaiEfurkWzpg1ForK0Te2UWluPcR6cbLeqTIWIorLRg2hut4v4nyqkzjH8/orL06
 sRAIk4YRVHlbbNsil22mmFb0dtCHVcnpeHHJskYhSnw3Cdg3bOyOpTvE2k/8Jhi6IGwMUnihatv
 KMYrrVr21PLjVpAze6n0bOmVn1H+daBGxQLOAs=
X-Received: by 2002:a05:6000:2403:b0:43d:4b00:9ee7 with SMTP id
 ffacd0b85a97d-43d642d1b1cmr14406156f8f.33.1776001221475; 
 Sun, 12 Apr 2026 06:40:21 -0700 (PDT)
Received: from vle-arch (88-184-113-142.subs.proxad.net. [88.184.113.142])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d6ffd3880sm8713324f8f.7.2026.04.12.06.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 06:40:21 -0700 (PDT)
From: Vivien LEGER <vivien.leger@gmail.com>
To: qemu-ppc@nongnu.org
Cc: shentey@gmail.com, qemu-devel@nongnu.org,
 Vivien LEGER <vivien.leger@gmail.com>
Subject: [PATCH] hw/net/fsl_etsec: implement RCTRL[CFA] FCS stripping on
 receive
Date: Sun, 12 Apr 2026 15:40:16 +0200
Message-ID: <20260412134016.1640882-1-vivien.leger@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=vivien.leger@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 12 Apr 2026 10:19:06 -0400
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

The eTSEC hardware strips the 4-byte FCS from received frames by
default (RCTRL[CFA]=0). When CFA=1, FCS is copied to the application
buffer and bd->length includes it.

Previously QEMU always included FCS in bd->length regardless of CFA,
causing guests using the default RCTRL to receive 4 extra bytes per
frame, breaking protocols that validate frame length (e.g. ARP).

Fix by subtracting 4 from bd->length when RCTRL[CFA]=0 (default).

Signed-off-by: Vivien LEGER <vivien.leger@gmail.com>
---
 hw/net/fsl_etsec/registers.h |  1 +
 hw/net/fsl_etsec/rings.c     | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/hw/net/fsl_etsec/registers.h b/hw/net/fsl_etsec/registers.h
index f085537ecd..1766e39a1a 100644
--- a/hw/net/fsl_etsec/registers.h
+++ b/hw/net/fsl_etsec/registers.h
@@ -103,6 +103,7 @@ extern const eTSEC_Register_Definition eTSEC_registers_def[];
 #define RCTRL_PRSDEP_MASK   (0x3)
 #define RCTRL_PRSDEP_OFFSET (6)
 #define RCTRL_RSF           (1 << 2)
+#define RCTRL_CFA           (1 << 11)  /* Copy FCS to application */
 
 /* Index of each register */
 
diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
index 22660c32b8..38e27ad6d8 100644
--- a/hw/net/fsl_etsec/rings.c
+++ b/hw/net/fsl_etsec/rings.c
@@ -442,6 +442,16 @@ static void fill_rx_bd(eTSEC          *etsec,
             cpu_physical_memory_write(bufptr, padd, rem);
         }
     }
+
+    /* Strip FCS unless RCTRL[CFA] requests copy to application.
+     * Per FSL eTSEC architecture (RCTRL field descriptions):
+     * CFA=0 (reset default): FCS is checked and discarded by hardware,
+     *   bd->length should not include the 4-byte FCS.
+     * CFA=1: FCS is copied to the application buffer, bd->length includes FCS.
+     */
+    if (!(etsec->regs[RCTRL].value & RCTRL_CFA) && bd->length >= 4) {
+        bd->length -= 4;
+    }
 }
 
 static void rx_init_frame(eTSEC *etsec, const uint8_t *buf, size_t size)
-- 
2.53.0


