Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CCCECD999
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5V5-0006WG-EC; Thu, 05 Feb 2026 14:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5V4-0006Vf-Is
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:58:50 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5V2-00031l-QT
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:58:50 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4806f80cac9so9429565e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321527; x=1770926327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6J2P5pQ/XJxmCYaQi8+PyRlPmOCkYxMPN6R3b9FjYyo=;
 b=mDBEBia/Jg1YQumSESUFcPlQ/CiP+Se3Finj+1IGD2iMXqkmcQIqJg2kGtB/j8VIy7
 NIHYGB0gJ4RqroX6jFVBczGD/3263AL1LWjnPEXZ01UNvlwOQ0bJI9jwUMoiiWSojL+x
 46NEDAR9/CYTo4kcoXCHePiHVXmCjlHbCFsJrYa2B4R+vU1N+ewqjspDYzV7+Ky0EDQg
 seEzpXvaQtxW9X6FomhAa5NX/BUGUIPPFgRiewcM4UeXG+PnJGKsrWXB90dCbCXDIy+I
 M2YCplIgeb+Eq19KjdJGymlC6yEHb6guEr+DVwfG9OchL+LVZbOrHxXL5IF2XwkWVxHn
 zulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321527; x=1770926327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6J2P5pQ/XJxmCYaQi8+PyRlPmOCkYxMPN6R3b9FjYyo=;
 b=kJb9zSyG/cm7xarqaeBUeP2+uuH7ds7yK89LWG4wGR+oZ6LrJyKxl62E1Ua2QKwIII
 VvCfLk/vIfnPOgDRx2lGzpHyoD3sUWSO7I7Z6vTleTrYOMNRH5pAj1DutLkBSA4Y11PJ
 2T+MaOtgreG0S/GAmPz+egp4tSigMG5IVMFnEU2ZG00OIRlY7IvzAXOKKtr3+o094zdH
 C8UTKKHPFD0+FJdchErxO6ueP2TneqqTOTNnP6P90aMa4i9clAZt7rFf6LJe3pJj8VRA
 KQ37/r5zsR5pSz6nXKetodbAf34LArS1xQiFjxFj9FNp4/JWIzJLtZIhr7DXiCEtayKG
 a+ng==
X-Gm-Message-State: AOJu0Yx61OsjFefY0OmSxUV/kwSIWIvZIVm1nYs1XPAVJnNBtBSVxaRm
 4nfgj8TOZbuPsINWGT3NaVyM6URPctXgqsfgBSAVnshAQtADZcvAcU66akDszcuJZM8=
X-Gm-Gg: AZuq6aLsSh1fod02HIZYjrDsqf0wEfhPTZaObZv8kaUF9mYdjAI62rk5k7HlCSXUbPK
 8SOFB1Ic9Y4j3zXqGc3utxFs5K9vAOgNK2Ruc5dUi0EPhwWT/5cJJOZiGqc4oMkQl+QAV/Ys5xI
 5Dg4Yoxs8/vZglrdDoxKf+K+zQtspHvyus2/R+OrflBdPHzxcANLgv2WEZb4yz1cKPxz7XN93TE
 woSPPvsupFqShPmbU5JDvL/vguH4au1ij62NHlW0g5J1bGDjXrQje/ghWC4pCHsYM90n69efPGo
 aGR3Wr8soNkZ9pd2GWqEG+esv10LozfI2xEvLw7ph0RrTqRuZ9BSX7fyTgdAm2P3MQyehp78GwF
 fCS0ZVQmfj0XqhqdUp82K5kNRMnCRL9Hl+xWGEscpBpYa/PUPl4a7SYHTvUFpUYXZQ08HbrE0AG
 X4Y0U9eo3A1uIAap5WMTM=
X-Received: by 2002:a5d:5f50:0:b0:431:b6e:8be3 with SMTP id
 ffacd0b85a97d-43629380ed0mr692048f8f.38.1770321526648; 
 Thu, 05 Feb 2026 11:58:46 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:58:45 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 03/29] hw/core: Add Remote Port session state and hello
 protocol
Date: Thu,  5 Feb 2026 20:57:58 +0100
Message-ID: <20260205195824.2610192-4-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Implement the session management for Remote Port protocol.
Key features implemented are following:

- Hello packet handling and capabilities negotiation
- Dynamic packet management routines
- rp_peer_state struct definition to hold negotiated
capabilities.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-proto.c         | 134 +++++++++++++++++++++++++++-
 include/hw/core/remote-port-proto.h |  72 +++++++++++++++
 2 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/hw/core/remote-port-proto.c b/hw/core/remote-port-proto.c
index 1653fe7b78..969dfc3cb2 100644
--- a/hw/core/remote-port-proto.c
+++ b/hw/core/remote-port-proto.c
@@ -64,7 +64,43 @@ int rp_decode_payload(struct rp_pkt *pkt)
     int used = 0;
 
     switch (pkt->hdr.cmd) {
-    /* TBD */
+    case RP_CMD_hello:
+        assert(pkt->hdr.len >= sizeof pkt->hello.version);
+        pkt->hello.version.major = be16_to_cpu(pkt->hello.version.major);
+        pkt->hello.version.minor = be16_to_cpu(pkt->hello.version.minor);
+        used += sizeof pkt->hello.version;
+
+        if ((pkt->hdr.len - used) >= sizeof pkt->hello.caps) {
+            void *offset;
+            int i;
+
+            pkt->hello.caps.offset = be32_to_cpu(pkt->hello.caps.offset);
+            pkt->hello.caps.len = be16_to_cpu(pkt->hello.caps.len);
+
+            offset = (char *)pkt + pkt->hello.caps.offset;
+            for (i = 0; i < pkt->hello.caps.len; i++) {
+                uint32_t cap;
+
+                /*
+                 * We don't know if offset is 32bit aligned so use
+                 * memcpy to do the endian conversion.
+                 */
+                memcpy(&cap, offset + i * sizeof cap, sizeof cap);
+                cap = be32_to_cpu(cap);
+                memcpy(offset + i * sizeof cap, &cap, sizeof cap);
+            }
+            used += sizeof pkt->hello.caps;
+        } else {
+            pkt->hello.caps.offset = 0;
+            pkt->hello.caps.len = 0;
+        }
+
+        /*
+         * Consume everything ignoring additional headers we do not yet
+         * know about.
+         */
+        used = pkt->hdr.len;
+        break;
     default:
         break;
     }
@@ -80,3 +116,99 @@ void rp_encode_hdr(struct rp_pkt_hdr *hdr, uint32_t cmd, uint32_t id,
     hdr->dev = cpu_to_be32(dev);
     hdr->flags = cpu_to_be32(flags);
 }
+
+size_t rp_encode_hello_caps(uint32_t id, uint32_t dev, struct rp_pkt_hello *pkt,
+                            uint16_t version_major, uint16_t version_minor,
+                            uint32_t *caps, uint32_t *caps_out,
+                            uint32_t caps_len)
+{
+    size_t psize = sizeof *pkt + sizeof caps[0] * caps_len;
+    unsigned int i;
+
+    rp_encode_hdr(&pkt->hdr, RP_CMD_hello, id, dev,
+                  psize - sizeof pkt->hdr, 0);
+    pkt->version.major = cpu_to_be16(version_major);
+    pkt->version.minor = cpu_to_be16(version_minor);
+
+    /* Feature list is appeneded right after the hello packet.  */
+    pkt->caps.offset = cpu_to_be32(sizeof *pkt);
+    pkt->caps.len = cpu_to_be16(caps_len);
+
+    for (i = 0; i < caps_len; i++) {
+        uint32_t cap;
+
+        cap = caps[i];
+        caps_out[i] = cpu_to_be32(cap);
+    }
+    return sizeof *pkt;
+}
+
+void rp_process_caps(struct rp_peer_state *peer,
+                     void *caps, size_t caps_len)
+{
+    int i;
+
+    assert(peer->caps.busaccess_ext_base == false);
+
+    for (i = 0; i < caps_len; i++) {
+        uint32_t cap;
+
+        memcpy(&cap, caps + i * sizeof cap, sizeof cap);
+
+        switch (cap) {
+        case CAP_BUSACCESS_EXT_BASE:
+            peer->caps.busaccess_ext_base = true;
+            break;
+        case CAP_BUSACCESS_EXT_BYTE_EN:
+            peer->caps.busaccess_ext_byte_en = true;
+            break;
+        case CAP_WIRE_POSTED_UPDATES:
+            peer->caps.wire_posted_updates = true;
+            break;
+        case CAP_ATS:
+            peer->caps.ats = true;
+            break;
+        }
+    }
+}
+
+void rp_dpkt_alloc(RemotePortDynPkt *dpkt, size_t size)
+{
+    if (dpkt->size < size) {
+        char *u8;
+        dpkt->pkt = realloc(dpkt->pkt, size);
+        u8 = (void *) dpkt->pkt;
+        memset(u8 + dpkt->size, 0, size - dpkt->size);
+        dpkt->size = size;
+    }
+}
+
+void rp_dpkt_swap(RemotePortDynPkt *a, RemotePortDynPkt *b)
+{
+    struct rp_pkt *tmp_pkt;
+    size_t tmp_size;
+
+    tmp_pkt = a->pkt;
+    tmp_size = a->size;
+    a->pkt = b->pkt;
+    a->size = b->size;
+    b->pkt = tmp_pkt;
+    b->size = tmp_size;
+}
+
+bool rp_dpkt_is_valid(RemotePortDynPkt *dpkt)
+{
+    return dpkt->size > 0 && dpkt->pkt->hdr.len;
+}
+
+void rp_dpkt_invalidate(RemotePortDynPkt *dpkt)
+{
+    assert(rp_dpkt_is_valid(dpkt));
+    dpkt->pkt->hdr.len = 0;
+}
+
+inline void rp_dpkt_free(RemotePortDynPkt *dpkt)
+{
+    dpkt->size = 0;
+    free(dpkt->pkt);
+}
diff --git a/include/hw/core/remote-port-proto.h b/include/hw/core/remote-port-proto.h
index 1d8e1b25da..ca1ab2f1d3 100644
--- a/include/hw/core/remote-port-proto.h
+++ b/include/hw/core/remote-port-proto.h
@@ -302,6 +302,28 @@ struct rp_pkt {
     };
 };
 
+struct rp_peer_state {
+    void *opaque;
+
+    struct rp_pkt pkt;
+    bool hdr_used;
+
+    struct rp_version version;
+
+    struct {
+        bool busaccess_ext_base;
+        bool busaccess_ext_byte_en;
+        bool wire_posted_updates;
+        bool ats;
+    } caps;
+
+    /* Used to normalize our clk.  */
+    int64_t clk_base;
+
+    struct rp_cfg_state local_cfg;
+    struct rp_cfg_state peer_cfg;
+};
+
 const char *rp_cmd_to_string(enum rp_cmd cmd);
 int rp_decode_hdr(struct rp_pkt *pkt);
 int rp_decode_payload(struct rp_pkt *pkt);
@@ -310,4 +332,54 @@ void rp_encode_hdr(struct rp_pkt_hdr *hdr,
                    uint32_t cmd, uint32_t id, uint32_t dev, uint32_t len,
                    uint32_t flags);
 
+/*
+ * caps is a an array of supported capabilities by the implementor.
+ * caps_out is the encoded (network byte order) version of the
+ * same array. It should be sent to the peer after the hello packet.
+ */
+size_t rp_encode_hello_caps(uint32_t id, uint32_t dev, struct rp_pkt_hello *pkt,
+                            uint16_t version_major, uint16_t version_minor,
+                            uint32_t *caps, uint32_t *features_out,
+                            uint32_t features_len);
+
+/* rp_encode_hello is deprecated in favor of hello_caps.  */
+static inline size_t __attribute__ ((deprecated))
+rp_encode_hello(uint32_t id, uint32_t dev, struct rp_pkt_hello *pkt,
+                uint16_t version_major, uint16_t version_minor) {
+    return rp_encode_hello_caps(id, dev, pkt, version_major, version_minor,
+                                NULL, NULL, 0);
+}
+
+void rp_process_caps(struct rp_peer_state *peer,
+                     void *caps, size_t caps_len);
+
+/* Dynamically resizable remote port pkt.  */
+
+typedef struct RemotePortDynPkt {
+    struct rp_pkt *pkt;
+    size_t size;
+} RemotePortDynPkt;
+
+/*
+ * Make sure dpkt is allocated and has enough room.
+ */
+
+void rp_dpkt_alloc(RemotePortDynPkt *dpkt, size_t size);
+
+void rp_dpkt_swap(RemotePortDynPkt *a, RemotePortDynPkt *b);
+
+/*
+ * Check if the dpkt is valid. Used for debugging purposes.
+ */
+
+bool rp_dpkt_is_valid(RemotePortDynPkt *dpkt);
+
+/*
+ * Invalidate the dpkt. Used for debugging purposes.
+ */
+
+void rp_dpkt_invalidate(RemotePortDynPkt *dpkt);
+
+void rp_dpkt_free(RemotePortDynPkt *dpkt);
+
 #endif
-- 
2.43.0


