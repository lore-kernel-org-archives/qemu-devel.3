Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7467C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 15:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tng2R-0006ej-2z; Thu, 27 Feb 2025 10:43:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_4fAZwcKClYJ2BHIF24CC492.0CAE2AI-12J29BCB4BI.CF4@flex--venture.bounces.google.com>)
 id 1tng2P-0006eB-OU
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 10:43:01 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_4fAZwcKClYJ2BHIF24CC492.0CAE2AI-12J29BCB4BI.CF4@flex--venture.bounces.google.com>)
 id 1tng2N-0003oA-St
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 10:43:01 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2feb5cd04a0so504699a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 07:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740670976; x=1741275776; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CBpQXoGnkk/N4rkAFSURDip0LkKazKlgtMnD0NIaRRM=;
 b=anVV6k0dVL96Whn+5C9CPUe7SWDA/7nR03cVCTqRGzI4u+am9VMrAgDDCKt/L9ryV3
 vqmpj5V9LmuDizTuWXyjo6ts31ARTS6PWMOIEf5XHT7X1/R5LX05G/PM4fmiakTSOQe8
 l8PqOM5sKV62cZJ3BE0adgEuTNCL1P1VkD5qe9/8lm16UPcstQN0GCRs2AQzWb4kMBNa
 ZClPzR04XYAFso7bkrj0AViSQkNOQ/5BBOo/uCD6AG/LlCBF8WJzWzvDj4IdUGwLlVdM
 I/z1txF+r722T7kBlgFe1XUnWKyn1JUfRLxGGh447ikSfPJfYBGOozN0llLxi0+dWMcY
 zs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740670976; x=1741275776;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CBpQXoGnkk/N4rkAFSURDip0LkKazKlgtMnD0NIaRRM=;
 b=xQCkXUJrUj2L7vhI2qDdqtNpLxuc+mlMHdaeVlm2Y0s1UIykBbDb+84cyD2SKTNA/p
 veN+JW+4nqBDHDUQEznud0B2AqtA1C8XF+NWgpZfKMohdVG9IaHPmHSwWtILCdyk//yw
 FJFgiPJo8MhYTG2dPSXKI/UoOlW1IyhtGDBEICA47E8YglzhMyGcUJpoD2GVNOZC+vtl
 GzXvWkJfh+uqdDsy0FhWfkYOhkuh7HoKDoYFSocQBRaw5cDwGcQ/ZhnGrtg4R7FZ395b
 1zG5QrzeSywrXA6gbt4T9AbEZbrB11dGBtiJGfzY6gSNrk5QA+5tEzdr/uW7lllqT6NE
 r7ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGGxz8nCBSxdp2w3l64hqbKBvLVaFpjfkflWmLY8lh7/D58NDfh5x97wWs67puKDGJxztgKVwFE7jM@nongnu.org
X-Gm-Message-State: AOJu0YzTcRT8R+oNd9ERBw/vDa5S6T1xRVu5y1/N99K92atCIR9ghb5a
 lWVLO31aUMIaNHNobrDJ26qJGD9GQx/JLr+9Im73ONU+VqEme6+nkYUK8buTQ15OFThJ7MUveLj
 lZtfscA==
X-Google-Smtp-Source: AGHT+IE6+PbxgUrn3e3KqpZZXzOvuVQMkSnpYL1WGjV9sc+35MLfl1IQhKgojt1I6p2NZRYFF96aVCBFmZXq
X-Received: from pjh15.prod.google.com ([2002:a17:90b:3f8f:b0:2fa:e9b:33b7])
 (user=venture job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:254e:b0:2f9:c144:9d13
 with SMTP id 98e67ed59e1d1-2fe7e36c6d7mr12739472a91.24.1740670975832; Thu, 27
 Feb 2025 07:42:55 -0800 (PST)
Date: Thu, 27 Feb 2025 15:42:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227154253.1653236-1-venture@google.com>
Subject: [PATCH] hw/net: ftgmac100: copy eth_hdr for alignment
From: Patrick Venture <venture@google.com>
To: peter.maydell@linaro.org, clg@kaod.org, steven_lee@aspeedtech.com, 
 leetroy@gmail.com, jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, 
 joel@jms.id.au
Cc: jasowang@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3_4fAZwcKClYJ2BHIF24CC492.0CAE2AI-12J29BCB4BI.CF4@flex--venture.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

eth_hdr requires 2 byte alignment

Signed-off-by: Patrick Venture <venture@google.com>
---
 hw/net/ftgmac100.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 1f524d7a01..a33aaa01ee 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -989,12 +989,16 @@ static void ftgmac100_high_write(void *opaque, hwaddr addr,
 static int ftgmac100_filter(FTGMAC100State *s, const uint8_t *buf, size_t len)
 {
     unsigned mcast_idx;
+    struct eth_header eth_hdr = {};
 
     if (s->maccr & FTGMAC100_MACCR_RX_ALL) {
         return 1;
     }
 
-    switch (get_eth_packet_type(PKT_GET_ETH_HDR(buf))) {
+    memcpy(&eth_hdr, PKT_GET_ETH_HDR(buf),
+           (sizeof(eth_hdr) > len) ? len : sizeof(eth_hdr));
+
+    switch (get_eth_packet_type(&eth_hdr)) {
     case ETH_PKT_BCAST:
         if (!(s->maccr & FTGMAC100_MACCR_RX_BROADPKT)) {
             return 0;
@@ -1028,6 +1032,7 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
 {
     FTGMAC100State *s = FTGMAC100(qemu_get_nic_opaque(nc));
     FTGMAC100Desc bd;
+    struct eth_header eth_hdr = {};
     uint32_t flags = 0;
     uint64_t addr;
     uint32_t crc;
@@ -1036,7 +1041,11 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
     uint32_t buf_len;
     size_t size = len;
     uint32_t first = FTGMAC100_RXDES0_FRS;
-    uint16_t proto = be16_to_cpu(PKT_GET_ETH_HDR(buf)->h_proto);
+    uint16_t proto;
+
+    memcpy(&eth_hdr, PKT_GET_ETH_HDR(buf),
+           (sizeof(eth_hdr) > len) ? len : sizeof(eth_hdr));
+    proto = be16_to_cpu(eth_hdr.h_proto);
     int max_frame_size = ftgmac100_max_frame_size(s, proto);
 
     if ((s->maccr & (FTGMAC100_MACCR_RXDMA_EN | FTGMAC100_MACCR_RXMAC_EN))
@@ -1061,7 +1070,7 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
         flags |= FTGMAC100_RXDES0_FTL;
     }
 
-    switch (get_eth_packet_type(PKT_GET_ETH_HDR(buf))) {
+    switch (get_eth_packet_type(&eth_hdr)) {
     case ETH_PKT_BCAST:
         flags |= FTGMAC100_RXDES0_BROADCAST;
         break;
-- 
2.48.1.658.g4767266eb4-goog


