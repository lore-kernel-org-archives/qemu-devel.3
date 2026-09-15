Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65096C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6VbS-00086D-AI; Tue, 15 Sep 2026 12:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbP-0007rT-4r
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:47 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbK-0003RI-Bv
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:46 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f9f7dbfso77504066b.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488091; x=1790092891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zwMKlS2VrjCsV9DFKblvAqWVEdyn/Vlz9Y/BIWWjlFo=;
 b=LxlOX+FeALXWiGyEzwUywkNC5uUcrrXicasTNZHzxpUa0g+oGgid+fMortj2Fq80Wv
 yuHl3sWY89az2ncj9YLEWlxVL7TIuUa4ZSAEqgRyuWYz6zTwlh1XwND4p9vY83YPMnh7
 Qr/N1yOVP1OK9Pez6L0xqk6t70IQ+pFn2SADZmbWZXyGfaG333zp+UrVwSWiIlHFAsk5
 Svzs9iEbDhks5kxJT0xAkjxX7ifME9rZpup5NQhDzLBVF169qrvbT50Xt88KRDvrEJeE
 4VXlr+lAGTP0wS35gzBwNkjoJ24pZgsacecTOf9eyWqrRkUBIBcLeTO7B+sjI3NfYhKg
 0Jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488091; x=1790092891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zwMKlS2VrjCsV9DFKblvAqWVEdyn/Vlz9Y/BIWWjlFo=;
 b=C3gurkskdspZc4nT7uSdUOvTvIoquGia4hL0/l1jb6lKhHJ9e6YnM3PyF9fm0P0D1O
 Rrf+J8PAj0Wg5SpE4mgpWrKalsvxhbx8SwMkCE0w5yHVjHOoqzaWDH1UfqTrG3HbGZ+d
 634Sxs0D9E/0Jm4N2kaZoHF2UEtSeolRpHafYaRSkVnDoJdr/mbrmNxAe/Uo1AS2d8nx
 xaZaH9F+k0c3cEFBFHOFgYuP9s5/Fr0MjpzpQ64PqPAbiD2J2+RHrYZG0louaaeasz3Q
 SYnmfUjFBix/otlkgqJPooCzDaKBiIxzsouz8xn7f3HX81MSrVVKo8X4eSKhWZCC74+R
 DW7A==
X-Gm-Message-State: AFuF++kcx/biSrakgNnbiNDQPW/C18fTnohd+F18aYpfxOTCdqI4J1eY
 7yGCeAxlO/wv7sc0wsJmiPbalFitmDiNUOIeaaYQ5Odo8lKt5/0TGoi3JflFBQ==
X-Gm-Gg: AYBFou0zAlZ/MtCgqiscDp9eQ6CLUAV3Jex0xzrxPHR7zATLDXlOTU8sfELZwfRELXp
 Iz4f+rC6H6sXYH9+NwBCFRZ1I23VzvBCL1HhJlY7usJhFoc+5WqvqiXJCJ3WTcckIILk5Vn5wCg
 X0Nh6bbUPzO5cufdVS0TF3wkmVUAZHnjxe9fgB3wCS0Kfe1WaDJKrR/JdJ5oiRYp4uut6xTzFhR
 td96d/7xphybkjBc0bakYQKhZm0UrO2E9cpTk6+4Ueh/UX2BGqjYeLjKUNfAdkx4e4GoIbJVsmm
 UYocxkZfwJeItdBWHLbArnfvs4lLLDpur9H2B2ZfIjsq7D2qBVNTJSdPTB9eygvkewIwVqgueLI
 /C3XxW17YvtWofOVjh2PoPJbRwtdmIcEj4dgrBCso6HaWa12yjwA8uzOhjBE61Oe/28JjlU3ved
 29+QcLkMSPHt+MbQpCREL5n9vFCSKc5PPCKmJHg+AXBld5HwRR7z2EKSF0Z16N2A0MVxIavw5h+
 cjJ7H+qggANa89THUCXraadWxhZZ0Aurw+55T4E/LsHgjk=
X-Received: by 2002:a17:907:3e29:b0:c26:19de:9ae1 with SMTP id
 a640c23a62f3a-c29d78ed54dmr127476566b.32.1789488090831; 
 Tue, 15 Sep 2026 09:01:30 -0700 (PDT)
Received: from thinkpad-t470s.. (83-131-196-251.adsl.net.t-com.hr.
 [83.131.196.251]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c29ddd86344sm3235866b.0.2026.09.15.09.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:01:30 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 11/20] hw/core: Implement Remote Port Memory Master bus
 transactions
Date: Tue, 15 Sep 2026 18:00:35 +0200
Message-ID: <20260915160044.345788-12-ruslichenko.r@gmail.com>
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

Implement the core access handlers for the Remote Port Memory
Master device, which enables QEMU to initiate memory-mapped
transaction to remote peers.

The patch adds support for:
- Translation of QEMU memory region read/write into Remote Port
read/write packets
- Support for propagating of transaction attributes
(Secure, MasterID)
- Synchronous response waiting with optional timeout (timeout
  configuration to be added within later patches)
- Add trace events for monitoring TX/RX bus transactions

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-memory-master.c | 191 +++++++++++++++++++++++++++-
 hw/core/remote-port.c               |   5 +
 hw/core/trace-events                |   4 +
 include/hw/core/remote-port.h       |  11 ++
 4 files changed, 207 insertions(+), 4 deletions(-)

diff --git a/hw/core/remote-port-memory-master.c b/hw/core/remote-port-memory-master.c
index 4b0283f9fe..41ef1df518 100644
--- a/hw/core/remote-port-memory-master.c
+++ b/hw/core/remote-port-memory-master.c
@@ -29,18 +29,201 @@
 
 #define RP_MAX_ACCESS_SIZE 4096
 
+static int rp_mm_get_timeout(RPMemoryTransaction *tr)
+{
+    RemotePortMap *map = tr->opaque;
+    RemotePortMemoryMaster *s;
+
+    if (!map || !map->parent ||
+        !object_dynamic_cast(OBJECT(map->parent),
+                             TYPE_REMOTE_PORT_MEMORY_MASTER)) {
+        return 0;
+    }
+    s = REMOTE_PORT_MEMORY_MASTER(map->parent);
+    return s->rp_timeout;
+}
+
+MemTxResult rp_mm_access_with_def_attr(RemotePort *rp, uint32_t rp_dev,
+                                       struct rp_peer_state *peer,
+                                       RPMemoryTransaction *tr,
+                                       bool relative, uint64_t offset,
+                                       uint32_t def_attr)
+{
+    uint64_t addr = tr->addr;
+    RemotePortRespSlot *rsp_slot;
+    RemotePortDynPkt *rsp;
+    struct  {
+        struct rp_pkt_busaccess_ext_base pkt;
+        uint8_t reserved[RP_MAX_ACCESS_SIZE];
+    } pay;
+    uint8_t *data = rp_busaccess_tx_dataptr(peer, &pay.pkt);
+    struct rp_encode_busaccess_in in = {0};
+    int i;
+    int len;
+    int rp_timeout = rp_mm_get_timeout(tr);
+    MemTxResult ret;
+
+    if (tr->rw) {
+        /* Data up to 8 bytes is passed as values.  */
+        if (tr->size <= 8) {
+            for (i = 0; i < tr->size; i++) {
+                data[i] = tr->data.u64 >> (i * 8);
+            }
+        } else {
+            memcpy(data, tr->data.p8, tr->size);
+        }
+    }
+
+    addr += relative ? 0 : offset;
+
+    in.cmd = tr->rw ? RP_CMD_write : RP_CMD_read;
+    in.id = rp_new_id(rp);
+    in.dev = rp_dev;
+    in.clk = rp_normalized_vmclk(rp);
+    in.master_id = tr->attr.requester_id;
+    in.addr = addr;
+    in.attr = def_attr;
+    in.attr |= tr->attr.secure ? RP_BUS_ATTR_SECURE : 0;
+    in.size = tr->size;
+    in.stream_width = tr->size;
+    len = rp_encode_busaccess(peer, &pay.pkt, &in);
+    len += tr->rw ? tr->size : 0;
+
+    trace_remote_port_memory_master_tx_busaccess(rp_cmd_to_string(in.cmd),
+        in.id, in.flags, in.dev, in.addr, in.size, in.attr);
+
+    rp_rsp_mutex_lock(rp);
+    rp_write(rp, (void *) &pay, len);
+
+    if (!rp_timeout) {
+        rsp_slot = rp_dev_wait_resp(rp, in.dev, in.id);
+    } else {
+        rsp_slot = rp_dev_timed_wait_resp(rp, in.dev, in.id, rp_timeout);
+        if (rsp_slot->valid == false) {
+            /*
+             * Timeout error
+             */
+            rp_rsp_mutex_unlock(rp);
+            return MEMTX_ERROR;
+        }
+    }
+    rsp = &rsp_slot->rsp;
+
+    /* We dont support out of order answers yet.  */
+    assert(rsp->pkt->hdr.id == in.id);
+
+    switch (rp_get_busaccess_response(rsp->pkt)) {
+    case RP_RESP_OK:
+        ret = MEMTX_OK;
+        break;
+    case RP_RESP_ADDR_ERROR:
+        ret = MEMTX_DECODE_ERROR;
+        break;
+    default:
+        ret = MEMTX_ERROR;
+        break;
+    }
+
+    if (ret == MEMTX_OK && !tr->rw) {
+        data = rp_busaccess_rx_dataptr(peer, &rsp->pkt->busaccess_ext_base);
+        /* Data up to 8 bytes is return as values.  */
+        if (tr->size <= 8) {
+            for (i = 0; i < tr->size; i++) {
+                tr->data.u64 |= ((uint64_t) data[i]) << (i * 8);
+            }
+        } else {
+            memcpy(tr->data.p8, data, tr->size);
+        }
+    }
+
+    trace_remote_port_memory_master_rx_busaccess(
+        rp_cmd_to_string(rsp->pkt->hdr.cmd), rsp->pkt->hdr.id,
+        rsp->pkt->hdr.flags, rsp->pkt->hdr.dev, rsp->pkt->busaccess.addr,
+        rsp->pkt->busaccess.len, rsp->pkt->busaccess.attributes);
+
+    if (rp_timeout) {
+        for (i = 0; i < ARRAY_SIZE(rp->dev_state[rp_dev].rsp_queue); i++) {
+            if (rp->dev_state[rp_dev].rsp_queue[i].used &&
+                rp->dev_state[rp_dev].rsp_queue[i].valid) {
+                rp_resp_slot_done(rp, &rp->dev_state[rp_dev].rsp_queue[i]);
+            }
+        }
+    } else {
+        rp_resp_slot_done(rp, rsp_slot);
+    }
+    rp_rsp_mutex_unlock(rp);
+
+    /*
+     * For strongly ordered or transactions that don't allow Early Acking,
+     * we need to drain the pending RP processing queue here. This is
+     * because RP handles responses in parallel with normal requests so
+     * they may get reordered. This becomes visible for example with reads
+     * to read-to-clear registers that clear interrupts. Even though the
+     * lowering of the interrupt-wires arrives to us before the read-resp,
+     * we may handle the response before the wire update, resulting in
+     * spurious interrupts.
+     *
+     * This has some room for optimization but for now we use the big hammer
+     * and drain the entire qeueue.
+     */
+    rp_process(rp);
+
+    /* Reads are sync-points, roll the sync timer.  */
+    rp_restart_sync_timer(rp);
+    return ret;
+}
+
+MemTxResult rp_mm_access(RemotePort *rp, uint32_t rp_dev,
+                         struct rp_peer_state *peer,
+                         RPMemoryTransaction *tr,
+                         bool relative, uint64_t offset)
+{
+    return rp_mm_access_with_def_attr(rp, rp_dev, peer, tr, relative, offset,
+                                      0);
+}
+
 static MemTxResult rp_mm_read(void *opaque, hwaddr addr, uint64_t *data,
                                  unsigned size, MemTxAttrs attrs)
 {
-    /* TBD */
-    return MEMTX_OK;
+    MemTxResult ret;
+    RemotePortMap *map = opaque;
+    RemotePortMemoryMaster *s = map->parent;
+
+    RPMemoryTransaction tr = {};
+
+    tr.opaque = map;
+    tr.rw = false;
+    tr.addr = addr;
+    tr.size = size;
+    tr.attr = attrs;
+
+    ret = rp_mm_access(s->rp, s->rp_dev, s->peer, &tr, s->relative,
+                map->offset);
+
+    if (ret == MEMTX_OK) {
+        *data = tr.data.u64;
+    }
+
+    return ret;
 }
 
 static MemTxResult rp_mm_write(void *opaque, hwaddr addr, uint64_t data,
                                   unsigned size, MemTxAttrs attrs)
 {
-    /* TBD */
-    return MEMTX_OK;
+    RemotePortMap *map = opaque;
+    RemotePortMemoryMaster *s = map->parent;
+
+    RPMemoryTransaction tr = {};
+
+    tr.opaque = map;
+    tr.rw = true;
+    tr.addr = addr;
+    tr.size = size;
+    tr.attr = attrs;
+    tr.data.u64 = data;
+
+    return rp_mm_access(s->rp, s->rp_dev, s->peer, &tr, s->relative,
+                    map->offset);
 }
 
 static const MemoryRegionOps rp_ops_template = {
diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
index b4c9fa1528..6a6effdd19 100644
--- a/hw/core/remote-port.c
+++ b/hw/core/remote-port.c
@@ -39,6 +39,11 @@ static void rp_event_read_and_process(RemotePort *s);
 static void sync_timer_hit(void *opaque);
 static void syncresp_timer_hit(void *opaque);
 
+uint32_t rp_new_id(RemotePort *s)
+{
+    return qatomic_fetch_inc(&s->current_id);
+}
+
 void rp_rsp_mutex_lock(RemotePort *s)
 {
     qemu_mutex_lock(&s->rsp_mutex);
diff --git a/hw/core/trace-events b/hw/core/trace-events
index 631cbb9c37..dc98745178 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -38,3 +38,7 @@ rp_pt_process_pkt(const char *rp, uint32_t cmd, uint32_t id, uint32_t dev, bool
 rp_process(const char *rp, unsigned int rpos, unsigned int wpos, uint32_t cmd, uint32_t dev) "%s: io-thread rpos=%u wpos=%u cmd=0x%"PRIx32" dev=0x%"PRIx32
 rp_pt_rx_queue_full(const char *rp, unsigned int rpos, unsigned int wpos) "%s: rpos=%u wpos=%u"
 rp_wait_resp(const char *rp) "'%s'"
+
+# remote-port-memory-master.c
+remote_port_memory_master_tx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len, uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
+remote_port_memory_master_rx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len, uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
diff --git a/include/hw/core/remote-port.h b/include/hw/core/remote-port.h
index cef7471a73..7e3e022a20 100644
--- a/include/hw/core/remote-port.h
+++ b/include/hw/core/remote-port.h
@@ -150,4 +150,15 @@ ssize_t rp_write(RemotePort *s, const void *buf, size_t count);
 
 struct rp_peer_state *rp_get_peer(RemotePort *s);
 
+uint32_t rp_new_id(RemotePort *s);
+
+static inline void rp_resp_slot_done(RemotePort *s,
+                                     RemotePortRespSlot *rsp_slot)
+{
+    rp_dpkt_invalidate(&rsp_slot->rsp);
+    rsp_slot->id = ~0;
+    rsp_slot->used = false;
+    rsp_slot->valid = false;
+}
+
 #endif
-- 
2.43.0


