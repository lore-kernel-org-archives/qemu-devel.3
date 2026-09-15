Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB17C88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Vb4-0007YJ-IQ; Tue, 15 Sep 2026 12:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6Vb2-0007XL-T2
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:24 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6Vay-0003O2-R0
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:24 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f6c7a58so412152566b.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488079; x=1790092879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=94yLgCZJnXztgL+1gk8uCJyDC6aCfGWvrBiAVC0Bd04=;
 b=nkT4hykCQAg/7iWpvknzKwynrh4GwqTGkWtfMG8qy5jUfDUcRMgT7C6SUB+jwobg8n
 EfyGlbUJeWz8K5pEXTLOIGtukLBvf3ly0Vo6d4TwsI0CzB1Wd0v7cxQUbx4uEmPv5MPH
 ek1QuMYr60H9zY2RyjoT+ak7gamB3p5TNz1nE9yenrtKG/Z9TqVk89rZh3rKt3hbQD0L
 o2HIcpeLKyBZWY4Xn7dTAKmpCXVGBpxzTYJP2VzYXbawozPNTrE2GZJ0fTVY817oMfsE
 9PO9h0cujf548LWROTdqL8TiZCsNj8Y04VKGEDc+pBD/6e6qwqepZSX9tI+qkZN6BnrZ
 EMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488079; x=1790092879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=94yLgCZJnXztgL+1gk8uCJyDC6aCfGWvrBiAVC0Bd04=;
 b=HF5tNzx/a+t6c7GOMq1EMRHTATFo8lr1wMXmdOuk7XecmND5FFOvXLUCSia6nc3q6r
 xOtwOk/zyfHAHBBxhY6sRka+pN50oBCIzmBhSLVhQHeH0s9uylc1U5eGvFCibFJ4Scmk
 g8yD9wYNWDlUZLsMyD74b8/8LwMdsAUFPMjA5DC12SCRk0fS6kTkBqAdK+qPBK2cf+oJ
 u9xHvCFH7zTcgooVZoDBkyTjHfkkghaO5gWqmH2EQT4DUGExVJldrY8zwV0WJ49tfZ+e
 0avSkeKW+BsaEgVtmP82Psl/K/w7edPF0jK4mE5ZCmmrsKELGpCOqfYlp5xnBNbFq8ht
 YMAw==
X-Gm-Message-State: AFuF++k3dZ3XBuHnDMNxWR5cmaU5CUTPwyzjJ5nJ1jqziwd79/YLFYNr
 J1j/2STc+lj4sG4aHE6oM539KHDPCMpVHBJsMUD83A9lLRlmjWcYUD4qpaVrbw==
X-Gm-Gg: AYBFou0IjoqtlXw06A+91oOml4Bh7oYv3HuYahjQzgSnhqsv51oKbflc1U/ipkN++3a
 iwAy5+3v8nQL187aKtgn7hM4L+1onq/ZU2zdfYtBG4/EElwf3CLhwL+n25HSR0t45j4XqsmajLj
 4vKnKmF4s6sFPw2zDIbfoOq0TqiFLlbxBMswoWvsyA0oGnnH2aHnF/kV7BDdnJTFX1cdlqEnBfG
 HNV6swvj5DuRY+lvhE6YcUtdKJ1agwtu4AYiYWkdJoHLs+eB0D5lYX2he//EkY1nKFSArKcx1IL
 fKrELlqNmaAeJ+PnZE13JMEmQmnmwIF5r8ch1BNATdRg0JliIHoraoxEC1wGF/yAoziTTamarDd
 gVY1tVydjCHvFGMDhQiKEx350yl6blAFsi6AobKpGr/Bw2peK53eSZVxerxxcQjG0sP2mTmpE/3
 NaOcPkVxjdhJrNZPZD+5ZcP2tMD6eHtdck6/5nM3iukKkt7hLmaMC2dl6QqwgC4ulSPFUEY+DlK
 EVIPWNoLQI9b3q6OXhMW2eAK0KN+2yUkoy8uJ9Q5Z0lfG55qtGGxyWG
X-Received: by 2002:a17:906:6a04:b0:c26:1649:47ab with SMTP id
 a640c23a62f3a-c29b87180afmr450840166b.33.1789488079117; 
 Tue, 15 Sep 2026 09:01:19 -0700 (PDT)
Received: from thinkpad-t470s.. (83-131-196-251.adsl.net.t-com.hr.
 [83.131.196.251]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c29ddd86344sm3235866b.0.2026.09.15.09.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:01:18 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 04/20] hw/core: Implement Remote Port bus access helpers
Date: Tue, 15 Sep 2026 18:00:28 +0200
Message-ID: <20260915160044.345788-5-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160044.345788-1-ruslichenko.r@gmail.com>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej2-x10.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Add bus access logic for Remote Port memory transactions.
The patch add support for read and write commands, which
enables data communication via the protocol.

This includes support for both legacy and extended packet
formats (such as 64-bit Master IDs) based on peer's
capabilities.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-proto.c         | 152 ++++++++++++++++++++++++++++
 include/hw/core/remote-port-proto.h | 133 ++++++++++++++++++++++++
 2 files changed, 285 insertions(+)

diff --git a/hw/core/remote-port-proto.c b/hw/core/remote-port-proto.c
index 9439f4b119..ddaefa7e36 100644
--- a/hw/core/remote-port-proto.c
+++ b/hw/core/remote-port-proto.c
@@ -63,6 +63,8 @@ int rp_decode_hdr(struct rp_pkt *pkt)
 int rp_decode_payload(struct rp_pkt *pkt)
 {
     int used = 0;
+    /* Master_id has an odd decoding due to historical reasons.  */
+    uint64_t master_id;
 
     switch (pkt->hdr.cmd) {
     case RP_CMD_hello:
@@ -102,6 +104,34 @@ int rp_decode_payload(struct rp_pkt *pkt)
          */
         used = pkt->hdr.len;
         break;
+    case RP_CMD_write:
+    case RP_CMD_read:
+        assert(pkt->hdr.len >= sizeof pkt->busaccess - sizeof pkt->hdr);
+        pkt->busaccess.timestamp = be64_to_cpu(pkt->busaccess.timestamp);
+        pkt->busaccess.addr = be64_to_cpu(pkt->busaccess.addr);
+        pkt->busaccess.attributes = be64_to_cpu(pkt->busaccess.attributes);
+        pkt->busaccess.len = be32_to_cpu(pkt->busaccess.len);
+        pkt->busaccess.width = be32_to_cpu(pkt->busaccess.width);
+        pkt->busaccess.stream_width = be32_to_cpu(pkt->busaccess.stream_width);
+        master_id = be16_to_cpu(pkt->busaccess.master_id);
+
+        used += sizeof pkt->busaccess - sizeof pkt->hdr;
+
+        if (pkt->busaccess.attributes & RP_BUS_ATTR_EXT_BASE) {
+            struct rp_pkt_busaccess_ext_base *pext = &pkt->busaccess_ext_base;
+
+            assert(pkt->hdr.len >= sizeof *pext - sizeof pkt->hdr);
+            master_id |= (uint64_t)be16_to_cpu(pext->master_id_31_16) << 16;
+            master_id |= (uint64_t)be32_to_cpu(pext->master_id_63_32) << 32;
+            pext->data_offset = be32_to_cpu(pext->data_offset);
+            pext->next_offset = be32_to_cpu(pext->next_offset);
+            pext->byte_enable_offset = be32_to_cpu(pext->byte_enable_offset);
+            pext->byte_enable_len = be32_to_cpu(pext->byte_enable_len);
+
+            used += sizeof *pext - sizeof pkt->busaccess;
+        }
+        pkt->busaccess.master_id = master_id;
+        break;
     default:
         break;
     }
@@ -144,6 +174,127 @@ size_t rp_encode_hello_caps(uint32_t id, uint32_t dev, struct rp_pkt_hello *pkt,
     return sizeof *pkt;
 }
 
+static void rp_encode_busaccess_common(struct rp_pkt_busaccess *pkt,
+                                  int64_t clk, uint16_t master_id,
+                                  uint64_t addr, uint64_t attr, uint32_t size,
+                                  uint32_t width, uint32_t stream_width)
+{
+    pkt->timestamp = cpu_to_be64(clk);
+    pkt->master_id = cpu_to_be16(master_id);
+    pkt->addr = cpu_to_be64(addr);
+    pkt->attributes = cpu_to_be64(attr);
+    pkt->len = cpu_to_be32(size);
+    pkt->width = cpu_to_be32(width);
+    pkt->stream_width = cpu_to_be32(stream_width);
+}
+
+size_t rp_encode_read(uint32_t id, uint32_t dev,
+                      struct rp_pkt_busaccess *pkt,
+                      int64_t clk, uint16_t master_id,
+                      uint64_t addr, uint64_t attr, uint32_t size,
+                      uint32_t width, uint32_t stream_width)
+{
+    rp_encode_hdr(&pkt->hdr, RP_CMD_read, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr, 0);
+    rp_encode_busaccess_common(pkt, clk, master_id, addr, attr,
+                               size, width, stream_width);
+    return sizeof *pkt;
+}
+
+size_t rp_encode_read_resp(uint32_t id, uint32_t dev,
+                           struct rp_pkt_busaccess *pkt,
+                           int64_t clk, uint16_t master_id,
+                           uint64_t addr, uint64_t attr, uint32_t size,
+                           uint32_t width, uint32_t stream_width)
+{
+    rp_encode_hdr(&pkt->hdr, RP_CMD_read, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr + size, RP_PKT_FLAGS_response);
+    rp_encode_busaccess_common(pkt, clk, master_id, addr, attr,
+                               size, width, stream_width);
+    return sizeof *pkt + size;
+}
+
+size_t rp_encode_write(uint32_t id, uint32_t dev,
+                       struct rp_pkt_busaccess *pkt,
+                       int64_t clk, uint16_t master_id,
+                       uint64_t addr, uint64_t attr, uint32_t size,
+                       uint32_t width, uint32_t stream_width)
+{
+    rp_encode_hdr(&pkt->hdr, RP_CMD_write, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr + size, 0);
+    rp_encode_busaccess_common(pkt, clk, master_id, addr, attr,
+                               size, width, stream_width);
+    return sizeof *pkt;
+}
+
+size_t rp_encode_write_resp(uint32_t id, uint32_t dev,
+                       struct rp_pkt_busaccess *pkt,
+                       int64_t clk, uint16_t master_id,
+                       uint64_t addr, uint64_t attr, uint32_t size,
+                       uint32_t width, uint32_t stream_width)
+{
+    rp_encode_hdr(&pkt->hdr, RP_CMD_write, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr, RP_PKT_FLAGS_response);
+    rp_encode_busaccess_common(pkt, clk, master_id, addr, attr,
+                               size, width, stream_width);
+    return sizeof *pkt;
+}
+
+/* New API for extended header.  */
+size_t rp_encode_busaccess(struct rp_peer_state *peer,
+                           struct rp_pkt_busaccess_ext_base *pkt,
+                           struct rp_encode_busaccess_in *in) {
+    struct rp_pkt_busaccess *pkt_v4_0 = (void *) pkt;
+    uint32_t hsize = 0;
+    uint32_t ret_size = 0;
+
+    /* Allocate packet space.  */
+    if (in->cmd == RP_CMD_write && !(in->flags & RP_PKT_FLAGS_response)) {
+        hsize = in->size;
+    }
+    if (in->cmd == RP_CMD_read && (in->flags & RP_PKT_FLAGS_response)) {
+        hsize = in->size;
+        ret_size = in->size;
+    }
+
+    /*
+     * If peer does not support the busaccess base extensions, use the
+     * old layout. For responses, what matters is if we're responding
+     * to a packet with the extensions.
+     */
+    if (!peer->caps.busaccess_ext_base && !(in->attr & RP_BUS_ATTR_EXT_BASE)) {
+        /* Old layout.  */
+        assert(in->master_id < UINT16_MAX);
+
+        rp_encode_hdr(&pkt->hdr, in->cmd, in->id, in->dev,
+                  sizeof *pkt_v4_0 - sizeof pkt->hdr + hsize, in->flags);
+        rp_encode_busaccess_common(pkt_v4_0, in->clk, in->master_id,
+                                   in->addr, in->attr,
+                                   in->size, in->width, in->stream_width);
+        return sizeof *pkt_v4_0 + ret_size;
+    }
+
+    /* Encode the extended fields.  */
+    pkt->master_id_31_16 = cpu_to_be16(in->master_id >> 16);
+    pkt->master_id_63_32 = cpu_to_be32(in->master_id >> 32);
+
+    /* We always put data right after the header.  */
+    pkt->data_offset = cpu_to_be32(sizeof *pkt);
+    pkt->next_offset = 0;
+
+    pkt->byte_enable_offset = cpu_to_be32(sizeof *pkt + hsize);
+    pkt->byte_enable_len = cpu_to_be32(in->byte_enable_len);
+    hsize += in->byte_enable_len;
+
+    rp_encode_hdr(&pkt->hdr, in->cmd, in->id, in->dev,
+                  sizeof *pkt - sizeof pkt->hdr + hsize, in->flags);
+    rp_encode_busaccess_common(pkt_v4_0, in->clk, in->master_id, in->addr,
+                               in->attr | RP_BUS_ATTR_EXT_BASE,
+                               in->size, in->width, in->stream_width);
+
+    return sizeof *pkt + ret_size;
+}
+
 void rp_process_caps(struct rp_peer_state *peer,
                      void *caps, size_t caps_len)
 {
@@ -173,6 +324,7 @@ void rp_process_caps(struct rp_peer_state *peer,
     }
 }
 
+
 void rp_dpkt_alloc(RemotePortDynPkt *dpkt, size_t size)
 {
     if (dpkt->size < size) {
diff --git a/include/hw/core/remote-port-proto.h b/include/hw/core/remote-port-proto.h
index ac7b7a9b96..de67cd6501 100644
--- a/include/hw/core/remote-port-proto.h
+++ b/include/hw/core/remote-port-proto.h
@@ -344,6 +344,134 @@ rp_encode_hello(uint32_t id, uint32_t dev, struct rp_pkt_hello *pkt,
                                 NULL, NULL, 0);
 }
 
+static inline void *__attribute__ ((deprecated))
+rp_busaccess_dataptr(struct rp_pkt_busaccess *pkt)
+{
+    /* Right after the packet.  */
+    return pkt + 1;
+}
+
+/*
+ * rp_busaccess_rx_dataptr
+ *
+ * Predicts the dataptr for a packet to be transmitted.
+ * This should only be used if you are trying to keep
+ * the entire packet in a linear buffer.
+ */
+static inline unsigned char *
+rp_busaccess_tx_dataptr(struct rp_peer_state *peer,
+                        struct rp_pkt_busaccess_ext_base *pkt)
+{
+    unsigned char *p = (unsigned char *) pkt;
+
+    if (peer->caps.busaccess_ext_base) {
+        /* We always put our data right after the header.  */
+        return p + sizeof *pkt;
+    } else {
+        /* Right after the old packet layout.  */
+        return p + sizeof(struct rp_pkt_busaccess);
+    }
+}
+
+/*
+ * rp_busaccess_rx_dataptr
+ *
+ * Extracts the dataptr from a received packet.
+ */
+static inline unsigned char *
+rp_busaccess_rx_dataptr(struct rp_peer_state *peer,
+                        struct rp_pkt_busaccess_ext_base *pkt)
+{
+    unsigned char *p = (unsigned char *) pkt;
+
+    if (pkt->attributes & RP_BUS_ATTR_EXT_BASE) {
+        return p + pkt->data_offset;
+    } else {
+        /* Right after the old packet layout.  */
+        return p + sizeof(struct rp_pkt_busaccess);
+    }
+}
+
+static inline unsigned char *
+rp_busaccess_byte_en_ptr(struct rp_peer_state *peer,
+                         struct rp_pkt_busaccess_ext_base *pkt)
+{
+    unsigned char *p = (unsigned char *) pkt;
+
+    if ((pkt->attributes & RP_BUS_ATTR_EXT_BASE)
+        && pkt->byte_enable_len) {
+        assert(pkt->byte_enable_offset >= sizeof *pkt);
+        assert(pkt->byte_enable_offset + pkt->byte_enable_len
+               <= pkt->hdr.len + sizeof pkt->hdr);
+        return p + pkt->byte_enable_offset;
+    }
+    return NULL;
+}
+
+size_t __attribute__ ((deprecated))
+rp_encode_read(uint32_t id, uint32_t dev,
+               struct rp_pkt_busaccess *pkt,
+               int64_t clk, uint16_t master_id,
+               uint64_t addr, uint64_t attr, uint32_t size,
+               uint32_t width, uint32_t stream_width);
+
+size_t __attribute__ ((deprecated))
+rp_encode_read_resp(uint32_t id, uint32_t dev,
+                    struct rp_pkt_busaccess *pkt,
+                    int64_t clk, uint16_t master_id,
+                    uint64_t addr, uint64_t attr, uint32_t size,
+                    uint32_t width, uint32_t stream_width);
+
+size_t __attribute__ ((deprecated))
+rp_encode_write(uint32_t id, uint32_t dev,
+                struct rp_pkt_busaccess *pkt,
+                int64_t clk, uint16_t master_id,
+                uint64_t addr, uint64_t attr, uint32_t size,
+                uint32_t width, uint32_t stream_width);
+
+size_t __attribute__ ((deprecated))
+rp_encode_write_resp(uint32_t id, uint32_t dev,
+                     struct rp_pkt_busaccess *pkt,
+                     int64_t clk, uint16_t master_id,
+                     uint64_t addr, uint64_t attr, uint32_t size,
+                     uint32_t width, uint32_t stream_width);
+
+struct rp_encode_busaccess_in {
+    uint32_t cmd;
+    uint32_t id;
+    uint32_t flags;
+    uint32_t dev;
+    int64_t clk;
+    uint64_t master_id;
+    uint64_t addr;
+    uint64_t attr;
+    uint32_t size;
+    uint32_t width;
+    uint32_t stream_width;
+    uint32_t byte_enable_len;
+};
+
+/* Prepare encode_busaccess input parameters for a packet response.  */
+static inline void
+rp_encode_busaccess_in_rsp_init(struct rp_encode_busaccess_in *in,
+                                struct rp_pkt *pkt) {
+    memset(in, 0, sizeof *in);
+    in->cmd = pkt->hdr.cmd;
+    in->id = pkt->hdr.id;
+    in->flags = pkt->hdr.flags | RP_PKT_FLAGS_response;
+    in->dev = pkt->hdr.dev;
+    /* FIXME: Propagate all master_id fields?  */
+    in->master_id = pkt->busaccess.master_id;
+    in->addr = pkt->busaccess.addr;
+    in->size = pkt->busaccess.len;
+    in->width = pkt->busaccess.width;
+    in->stream_width = pkt->busaccess.stream_width;
+    in->byte_enable_len = 0;
+}
+size_t rp_encode_busaccess(struct rp_peer_state *peer,
+                           struct rp_pkt_busaccess_ext_base *pkt,
+                           struct rp_encode_busaccess_in *in);
+
 void rp_process_caps(struct rp_peer_state *peer,
                      void *caps, size_t caps_len);
 
@@ -376,4 +504,9 @@ void rp_dpkt_invalidate(RemotePortDynPkt *dpkt);
 
 void rp_dpkt_free(RemotePortDynPkt *dpkt);
 
+static inline int rp_get_busaccess_response(struct rp_pkt *pkt)
+{
+    return (pkt->busaccess_ext_base.attributes & RP_BUS_RESP_MASK) >>
+                                                            RP_BUS_RESP_SHIFT;
+}
 #endif
-- 
2.43.0


