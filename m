Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B13B606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZrEH2hXP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOzAb-0001Bs-Lh; Thu, 05 Nov 2026 10:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itai.handler@gmail.com>)
 id 1xOzAY-0001BY-6t
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 10:14:26 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itai.handler@gmail.com>)
 id 1xOzAV-0007kT-QC
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 10:14:25 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-490b7266f7bso72362f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 07:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793891662; x=1794496462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YED3UkXnGkeRIQg9+GqoACwf2Z55OMF8QOscjGBLPko=;
 b=ZrEH2hXPv+lIxtbpdpYDNWwlho9xseLWRFJ4FRULQm8u3vGM1468kvLVStkKg0Pb3f
 lJ+YotQIxyQQSpoiq6dnUi+pfwiUdQd7bCMQ4HKny1Fs+zP0jGIGXMlfQyfJoKDQkHYu
 SFldLoehnqaPjlIk27AvbYs7tQWqcqUC4cuvxLgPwhLpOjTS2FEpJU+YRadzjR+mKiqC
 bXgdw+oYjTaKp7z3IqULgQ8SItKf4/KTNeRdMwJkRp+7okb9tx3zRVqBIvQOgC6T+8D7
 +Zh1WzIYAsGjlpE+B3SQuXeJRnejGSrndzwxIx5okJturr5JNU+UQEcKuTuPgnuoFtyZ
 4w8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793891662; x=1794496462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YED3UkXnGkeRIQg9+GqoACwf2Z55OMF8QOscjGBLPko=;
 b=EgAsrH2saFkJlrsBQbpEiArTTzvU5ZpuVomxAcK1jI2tBXlMGoArjbpV3xLGyQzE5i
 9bLaKN3xEF2PowrdiDVBZa+rPDJATJ/v/L2mXhtfkj9dcTVhacloXTrC7mTq2WjB3G3W
 MHe6H0igkYecLbuf3iqYVK9e0Uq0qMRw0K+cnzzUbT6JhXIrqKYCegTqJkS0TvLq1m6K
 h3T6ObX8o8yNae+DHzQp9iyxsCAPeUQAPpCa4oTqtwyB+uymTOpEvyljiawFCB929uQ4
 OGzxMKvxU4mWkDW4YXcyvIk3Bl8ui+CxMfvzEjRc1V81JKETaU82oqpBFUzHYDJZhHTV
 1Zpg==
X-Gm-Message-State: APuU4Z/LtDi9kCaPrWT8UQB6a4wdN+DEIX5zOHALYkQ2y4034ZXOtiNU
 D6q8DnAYplk1svchi+34yVpUb2/YHXFlifD9tzHMkpOXvpVlpysWvPwX
X-Gm-Gg: AYBFou0gdoXZIfBNdaX5nPMChE62H9xvrD1UK8zgl3Q9/d5c+FjrdwJDbwQq8/RcWyA
 NwYmH3Wt4SP1KzYgF162oLA7LNANrIO/oaU6IL4Pesk6uvToeRenyZMjoHnawmnemlj5s9vqeQD
 y0gv2O6W9cT1BXXKyHT2i71p1PmxQJPlBw5PhyfV85txsgKjW8Ma7dc39jWLrBHsn4ancBw58OI
 D5jx5GT9GKOmOhH34Mg3Y0LAVlDSoVtbiD8M35GBf+AUJp5RilXsFyHsA0I5Mh13+EdeaYjHuEY
 yV4g/h+K1B+q8k1d6a/4HPTsVtdE8hEQXrHKI2kXqUzKdsDgp0hwAcBmnVhPok9htrGufdk5Ycu
 RL5A1l/ECCWC6fRRRVZ97qXqF4X4iJwRdKM+/H7Wtz41y8hAM0mnPV3o+S/L+2Tup4piSQDF3d7
 q0INQz1BEwYrL1l5i69EeDNen9nhH3kVx4qKdYp7UtgjifE7Y8pUPm9st+3I+MJFpn82gUtLTYy
 ILAdeYH+uHJA+Q9q3vBt6R+F5pb8eq6XM1StkLX4nUthDGmEpCPpide/0V9sA7HgdyIvQphSb+1
 hPZfbJIUolewGOS0YYYxN59E4/YQo2Ko0HMMk9pu/GO8mg==
X-Received: by 2002:a05:6000:2201:b0:48f:bb47:3d68 with SMTP id
 ffacd0b85a97d-48fbb473ee0mr16648646f8f.1.1793891661592; 
 Thu, 05 Nov 2026 07:14:21 -0800 (PST)
Received: from localhost.localdomain ([193.169.70.108])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed45d71dsm10452802f8f.36.2026.11.05.07.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 07:14:21 -0800 (PST)
From: Itai Handler <itai.handler@gmail.com>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, peter.maydell@linaro.org,
 francisco.iglesias@amd.com, edgar.iglesias@gmail.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, berrange@redhat.com,
 eugene@nuvacore.ai, Ruslan_Ruslichenko@epam.com,
 takahiro.nakata.wr@renesas.com, philmd@oss.qualcomm.com
Subject: [RFC PATCH] hw/core: Add a read FIFO to the Remote Port memory master
Date: Thu,  5 Nov 2026 17:13:53 +0200
Message-Id: <20261105151351.2644438-1-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0b67848f-d69d-4402-b378-4012bcface17@gmail.com>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
 <20260915160044.345788-12-ruslichenko.r@gmail.com>
 <20261103135503.71748-1-itai.handler@gmail.com>
 <0b67848f-d69d-4402-b378-4012bcface17@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=itai.handler@gmail.com; helo=mail-wr1-x430.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A guest that drains a device's data FIFO, a QSPI controller's for
example, reads it one word per access, and each access to a Remote
Port memory master is a round trip to the peer, about 17 us on a fast
host: such a guest reads a flash at about 230 kB/s.

Let the peer hand the master what the guest is about to read.  When
QEMU's hello announces CAP_READ_FIFO, the peer may send writes on the
master's channel: their data, up to RP_READ_FIFO_SIZE (4 KiB) bytes,
replace what the master's read FIFO holds, and the next reads whose
start address is in [addr, addr + stream_width) are answered from it
in order, without a round trip.  A read the FIFO covers only in part
reads the rest from the peer.  A write of no data, or a reset, empties
the FIFO.

The peer posts the fill before its response to the access that told
it what comes next, and rp_process() runs after each response, so the
fill is in place before that access completes.  The peer decides what
the guest will read; the master only replays bytes in order and knows
nothing of the device.

The size is a protocol constant rather than a property, so that the
two ends cannot disagree: the peer never sees the error response to a
posted fill.  The buffer is allocated at the first fill.

Measured with a model of a QSPI controller, the flash behind it a
model of its own over a link of its own: the controller's first read
of a batch hands QEMU the bytes that the guest's last read of the
fill level promised, so a batch of 256 bytes costs two round trips
instead of 65.  A guest booting from that flash through U-Boot, means
of three interleaved runs, two for the kernel FIT:

                                            before    after
  U-Boot sf read, 1 MiB                     4.59 s    0.35 s
  U-Boot sf read, the 15.9 MB kernel FIT    68.0 s    4.9 s
  Linux dd from a flash partition, 256 KiB  1.21 s    0.16 s
  QEMU's start to a Linux shell             90.1 s    24.9 s

The capability's number needs agreeing with the other Remote Port
implementations.

Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
Ruslan, thank you for the quick answer - here is the patch as an RFC,
as you suggested.

It applies on top of "hw/core: Introduce Remote Port Co-simulation
Protocol" v2 on its own (the 20 patches, on QEMU 11.1.2): none of the
FDT machine series is needed for it, and checkpatch is clean.

The one thing I cannot settle on my own is the capability number:
CAP_READ_FIFO takes 5, the next free one in v2, but the other Remote
Port implementations would have to agree on it.

Happy to rework or drop any of this, and to test v3.

 hw/core/remote-port-memory-master.c         | 111 +++++++++++++++++++-
 hw/core/remote-port-proto.c                 |   3 +
 hw/core/remote-port.c                       |   1 +
 hw/core/trace-events                        |   2 +
 include/hw/core/remote-port-memory-master.h |  13 +++
 include/hw/core/remote-port-proto.h         |  12 +++
 6 files changed, 139 insertions(+), 3 deletions(-)

diff --git a/hw/core/remote-port-memory-master.c b/hw/core/remote-port-memory-master.c
index 4ef03c959..3a519f562 100644
--- a/hw/core/remote-port-memory-master.c
+++ b/hw/core/remote-port-memory-master.c
@@ -17,6 +17,7 @@
 #include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
+#include "qemu/error-report.h"
 #include "trace.h"
 
 #include "hw/core/remote-port-proto.h"
@@ -184,31 +185,115 @@ MemTxResult rp_mm_access(RemotePort *rp, uint32_t rp_dev,
                                       0);
 }
 
+/*
+ * Pop up to @size bytes of the read FIFO into @data for a read at @addr,
+ * the address the peer sees, if it holds data for that address.
+ */
+static unsigned rp_mm_fifo_pop(RemotePortMemoryMaster *s, uint64_t addr,
+                               unsigned size, uint64_t *data)
+{
+    unsigned n, i;
+
+    if (!s->fifo.len || addr < s->fifo.addr ||
+        addr - s->fifo.addr >= s->fifo.range) {
+        return 0;
+    }
+    n = MIN(size, s->fifo.len);
+    for (i = 0; i < n; i++) {
+        *data |= (uint64_t)s->fifo.buf[s->fifo.head++] << (i * 8);
+    }
+    s->fifo.len -= n;
+    trace_remote_port_memory_master_fifo_pop(s->rp_dev, addr, n, s->fifo.len);
+    return n;
+}
+
 static MemTxResult rp_mm_read(void *opaque, hwaddr addr, uint64_t *data,
                                  unsigned size, MemTxAttrs attrs)
 {
     MemTxResult ret;
     RemotePortMap *map = opaque;
     RemotePortMemoryMaster *s = map->parent;
+    uint64_t fifo_data = 0;
+    unsigned n;
 
     RPMemoryTransaction tr = {};
 
+    n = rp_mm_fifo_pop(s, addr + (s->relative ? 0 : map->offset), size,
+                       &fifo_data);
+    if (n == size) {
+        *data = fifo_data;
+        return MEMTX_OK;
+    }
+
+    /* What the FIFO did not hold is read from the peer.  */
     tr.opaque = map;
     tr.rw = false;
-    tr.addr = addr;
-    tr.size = size;
+    tr.addr = addr + n;
+    tr.size = size - n;
     tr.attr = attrs;
 
     ret = rp_mm_access(s->rp, s->rp_dev, s->peer, &tr, s->relative,
                 map->offset);
 
     if (ret == MEMTX_OK) {
-        *data = tr.data.u64;
+        *data = fifo_data | tr.data.u64 << (n * 8);
     }
 
     return ret;
 }
 
+/*
+ * A write from the peer on our channel fills the read FIFO
+ * (CAP_READ_FIFO): its data replace what the FIFO holds, for the reads
+ * of [addr, addr + stream_width).  A write of no data empties it.  The
+ * peer sends it before its response to an access, so that the response
+ * drains it (rp_mm_access_with_def_attr()) before the access completes.
+ */
+static void rp_mm_fifo_fill(RemotePortDevice *rpd, struct rp_pkt *pkt)
+{
+    RemotePortMemoryMaster *s = REMOTE_PORT_MEMORY_MASTER(rpd);
+    uint8_t *data = rp_busaccess_rx_dataptr(s->peer,
+                                            &pkt->busaccess_ext_base);
+    uint32_t len = pkt->busaccess.len;
+    uint32_t range = pkt->busaccess.stream_width;
+    uint32_t resp = RP_RESP_OK;
+
+    trace_remote_port_memory_master_fifo_fill(pkt->hdr.dev,
+                                              pkt->busaccess.addr, range, len);
+    if (len > RP_READ_FIFO_SIZE || (len && !range)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+
+        warn_report_once("%s: a read FIFO fill of %" PRIu32 " bytes for 0x%"
+                         PRIx32 " bytes at 0x%" PRIx64 " was rejected "
+                         "(at most %d bytes, for a range)",
+                         path, len, range, pkt->busaccess.addr,
+                         RP_READ_FIFO_SIZE);
+        resp = RP_RESP_ADDR_ERROR;
+        len = 0;
+    }
+    if (len) {
+        if (!s->fifo.buf) {
+            s->fifo.buf = g_malloc(RP_READ_FIFO_SIZE);
+        }
+        memcpy(s->fifo.buf, data, len);
+    }
+    s->fifo.head = 0;
+    s->fifo.len = len;
+    s->fifo.addr = pkt->busaccess.addr;
+    s->fifo.range = range;
+
+    if (!(pkt->hdr.flags & RP_PKT_FLAGS_posted)) {
+        struct rp_pkt_busaccess_ext_base rsp;
+        struct rp_encode_busaccess_in in;
+        size_t enclen;
+
+        rp_encode_busaccess_in_rsp_init(&in, pkt);
+        in.attr |= resp << RP_BUS_RESP_SHIFT;
+        enclen = rp_encode_busaccess(s->peer, &rsp, &in);
+        rp_write(s->rp, (void *) &rsp, enclen);
+    }
+}
+
 static MemTxResult rp_mm_write(void *opaque, hwaddr addr, uint64_t data,
                                   unsigned size, MemTxAttrs attrs)
 {
@@ -286,6 +371,13 @@ static void rp_memory_master_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void rp_memory_master_reset_hold(Object *obj, ResetType type)
+{
+    RemotePortMemoryMaster *s = REMOTE_PORT_MEMORY_MASTER(obj);
+
+    s->fifo.len = 0;
+}
+
 static void rp_prop_allow_set_link(const Object *obj, const char *name,
                                    Object *val, Error **errp)
 {
@@ -339,13 +431,25 @@ static Property rp_properties[] = {
                        max_access_size, RP_MAX_ACCESS_SIZE),
 };
 
+static void rp_memory_master_finalize(Object *obj)
+{
+    RemotePortMemoryMaster *s = REMOTE_PORT_MEMORY_MASTER(obj);
+
+    g_free(s->fifo.buf);
+}
+
 static void rp_memory_master_class_init(ObjectClass *oc, const void *data)
 {
     FDTGenericMMapClass *fmc = FDT_GENERIC_MMAP_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
+    RemotePortDeviceClass *rpdc = REMOTE_PORT_DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
     device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
     dc->realize = rp_memory_master_realize;
     fmc->parse_reg = rp_parse_reg;
+    rpdc->ops[RP_CMD_write] = rp_mm_fifo_fill;
+    rc->phases.hold = rp_memory_master_reset_hold;
 }
 
 static const TypeInfo rp_info = {
@@ -353,6 +457,7 @@ static const TypeInfo rp_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(RemotePortMemoryMaster),
     .instance_init = rp_memory_master_init,
+    .instance_finalize = rp_memory_master_finalize,
     .class_init    = rp_memory_master_class_init,
     .interfaces    = (InterfaceInfo[]) {
         { TYPE_FDT_GENERIC_MMAP },
diff --git a/hw/core/remote-port-proto.c b/hw/core/remote-port-proto.c
index 0c90ba897..df4157de6 100644
--- a/hw/core/remote-port-proto.c
+++ b/hw/core/remote-port-proto.c
@@ -420,6 +420,9 @@ void rp_process_caps(struct rp_peer_state *peer,
         case CAP_ATS:
             peer->caps.ats = true;
             break;
+        case CAP_READ_FIFO:
+            peer->caps.read_fifo = true;
+            break;
         }
     }
 }
diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
index 6a6effdd1..a8718161a 100644
--- a/hw/core/remote-port.c
+++ b/hw/core/remote-port.c
@@ -274,6 +274,7 @@ static void rp_say_hello(RemotePort *s)
         CAP_BUSACCESS_EXT_BYTE_EN,
         CAP_WIRE_POSTED_UPDATES,
         CAP_ATS,
+        CAP_READ_FIFO,
     };
     size_t len;
 
diff --git a/hw/core/trace-events b/hw/core/trace-events
index b5f8fafc6..2722e4306 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -41,6 +41,8 @@ rp_wait_resp(const char *rp) "'%s'"
 
 # remote-port-memory-master.c
 remote_port_memory_master_tx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len, uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
+remote_port_memory_master_fifo_fill(uint32_t dev, uint64_t addr, uint32_t range, uint32_t len) "dev=0x%"PRIx32", addr=0x%"PRIx64", range=0x%"PRIx32", len=0x%"PRIx32
+remote_port_memory_master_fifo_pop(uint32_t dev, uint64_t addr, uint32_t len, uint32_t left) "dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", left=0x%"PRIx32
 remote_port_memory_master_rx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len, uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
 
 # remote-port-memory-slave.c
diff --git a/include/hw/core/remote-port-memory-master.h b/include/hw/core/remote-port-memory-master.h
index 011867f36..a7bcdb703 100644
--- a/include/hw/core/remote-port-memory-master.h
+++ b/include/hw/core/remote-port-memory-master.h
@@ -35,6 +35,19 @@ struct RemotePortMemoryMaster {
     MemoryRegionOps *rp_ops;
     RemotePortMap *mmaps;
 
+    /*
+     * The read FIFO the peer fills (CAP_READ_FIFO): the reads at
+     * addresses in [addr, addr + range) return its len bytes from head,
+     * in order.  buf, RP_READ_FIFO_SIZE bytes, comes with the first fill.
+     */
+    struct {
+        uint8_t *buf;
+        uint32_t head;
+        uint32_t len;
+        uint64_t addr;
+        uint64_t range;
+    } fifo;
+
     /* public */
     uint32_t map_num;
     uint64_t map_offset;
diff --git a/include/hw/core/remote-port-proto.h b/include/hw/core/remote-port-proto.h
index c86f0657d..7d1016757 100644
--- a/include/hw/core/remote-port-proto.h
+++ b/include/hw/core/remote-port-proto.h
@@ -132,8 +132,19 @@ enum {
     CAP_WIRE_POSTED_UPDATES = 3,
 
     CAP_ATS = 4, /* Address translation services */
+
+    /*
+     * A memory master takes the writes its peer sends on its channel as
+     * fills of its read FIFO: the data, up to RP_READ_FIFO_SIZE bytes,
+     * replace what the FIFO holds, and the next reads at addresses in
+     * [addr, addr + stream_width) return them in order without a round
+     * trip.  A write of no data empties the FIFO.
+     */
+    CAP_READ_FIFO = 5,
 };
 
+#define RP_READ_FIFO_SIZE 4096
+
 struct rp_pkt_hello {
     struct rp_pkt_hdr hdr;
     struct rp_version version;
@@ -309,6 +320,7 @@ struct rp_peer_state {
         bool busaccess_ext_byte_en;
         bool wire_posted_updates;
         bool ats;
+        bool read_fifo;
     } caps;
 
     /* Used to normalize our clk.  */
-- 
2.34.1


