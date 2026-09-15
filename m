Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C7AC982C7
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Vat-0007NO-7C; Tue, 15 Sep 2026 12:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6Var-0007N2-Vu
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:14 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6Vap-0003Mh-Qb
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:13 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f5603a0so77994466b.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488070; x=1790092870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9T9DqjVoclJjAXs7joIA6JzcMftC3mdXuayXnuMYjRs=;
 b=ZUxVs717xB6JkBlDA85+0nMpnUqdX6OmifuCmB+/xOB9qg3VD8pW9LdXO3webFaJtX
 N7IUAXN5qGKVA5uTiciwj4B/PP2EbKi2ArjK9I1OE/p3BP/BJusE9ONBhu3Z5xkl6nSh
 ExKLmrH6pENcsvQhyxoBXVbAEvvq7ytTX6uLADdEB+iAkuyB9+sfzzBK5bYrq9+NIOEs
 7kFqN3GPbEQa7RWZnQsfLx2aClry6pwCHvj1umbFCZukl0o7YbDMFk2jghWvuvkA0eIP
 xU4CsXMz1sVCpJE0QnyKOT2IKk/PP8BZeoOfArML0Wr7MSGagq9D6XOlHwdbGMhqFOgI
 iLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488070; x=1790092870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9T9DqjVoclJjAXs7joIA6JzcMftC3mdXuayXnuMYjRs=;
 b=YxyIrhwJ11vJ/KWOzz/YyUXOdogTE/wDuYfoj2q7P6kRiSFEThZGnmelhWMCP/l7s8
 38pZeWd40/Gvjdt0J7pPVoUD1gKN1NAUMNa4uGjV7ZHhqsmPIKvEpMI0MyqPHqEv1DrG
 qw0S8jsFIIL1nl82zkWEXt20NZqYhPrh5tGf7WxQ+8scPvRZwVy5PGnQ0rgPvip0AEPb
 /jKVIRjttwaEGh17aqlMFqdNxBKNdGxoxt0VEe55IWpuQ0MnTXWoK4r7163bRrF5sVkG
 wZJf5tjNciz+x/3XT2+QL3ALD0LEbpss3P7EFDojbGelM4+BeI0m8nyeTUmfclR+tHQQ
 99Iw==
X-Gm-Message-State: AFuF++kwfaYoV1cSytl2d7gZ/XTOMVgRwgMg9sUmx9aQi/lc4WLOxfkX
 pH/DmT504W+g9KMkkB6KPovv5GUTk/W1NRAn2SmVR4TYsbY2T2JzuPjaRwMrxQ==
X-Gm-Gg: AYBFou02nCci1mu2gNZHCMuSgnDXANB7ADcEIOs3ssRZm6PBCrzLDGQERQJCGUDXgBn
 6B6s0N/2eRPBk3QegDjSWGOnnQvjQCjKr7EFGCKY/PtNd0YEVEV7GtwiI3+xhlldrhzYPDIz3Yf
 vVOL+jnBQKB0+NNA7GdcQkgfu5hZSi2YEXyiRYq8l1Uhm5tE5ntyCFqrXGW5omccK/DMLwCihuB
 cu3mPNKUD2aWMboUzhnxyAbpIy4APRWoPbm/0oRDxSozTReh8m5CcbL7DQMKxhpbI14NYTb0BXO
 Iz1uooaG3kn3RuZz1M5WN/qKkrTz6vIG4mikcyju9gvrvCFydCMZqAGLmvE65ptU46aKC5fzrZn
 ObmAJP/CDy7dPvqHhsSc/AlN6R/aiMZwfZ0k5AW4quQxaqHqJVVUN9Y3u7S6omFMhMKOO/3uLcg
 ejt5TdIOPE32PW4Zt7ACqB2iv/FzrARCvdptdeMhKsq5P4ZVXrfQwvcTxafO1Zzxe5Eg2GSHK8m
 h+zXsbQ3SxAbg1I+rbRqTmwcBANJTmQYBsSbPTBqMIxUg==
X-Received: by 2002:a17:907:9610:b0:c26:2da7:347f with SMTP id
 a640c23a62f3a-c29d734648dmr143017166b.0.1789488069835; 
 Tue, 15 Sep 2026 09:01:09 -0700 (PDT)
Received: from thinkpad-t470s.. (83-131-196-251.adsl.net.t-com.hr.
 [83.131.196.251]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c29ddd86344sm3235866b.0.2026.09.15.09.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:01:09 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 01/20] hw/core: Add Remote Port protocol packet definition
Date: Tue, 15 Sep 2026 18:00:25 +0200
Message-ID: <20260915160044.345788-2-ruslichenko.r@gmail.com>
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

Introduce packet definition for Remote Port protocol.

Remote Port is a socket based inter-simulation protocol
designed to connect QEMU to external simulator (such as
SystemC models, RTL simulators, etc) for hardware co-
simulation.

The protocol supports bidirectional communication for:
- Connection setup, version negotiation (Hello/Cfg packets)
- Memory and MMIO transactions (Read/Write packets)
- Interrupts and GPIO signaling (Interrupt packets)
- Time synchronization (Sync packets)

The patch introduces header file with packet definition
used by protocol.

Preserved existing MIT license for include/hw/core/remote-port-proto.h.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 include/hw/core/remote-port-proto.h | 299 ++++++++++++++++++++++++++++
 1 file changed, 299 insertions(+)
 create mode 100644 include/hw/core/remote-port-proto.h

diff --git a/include/hw/core/remote-port-proto.h b/include/hw/core/remote-port-proto.h
new file mode 100644
index 0000000000..16f3752877
--- /dev/null
+++ b/include/hw/core/remote-port-proto.h
@@ -0,0 +1,299 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * QEMU remote port protocol parts.
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#ifndef REMOTE_PORT_PROTO_H__
+#define REMOTE_PORT_PROTO_H__
+
+/*
+ * Remote-Port (RP) is an inter-simulator protocol. It assumes a reliable
+ * point to point communcation with the remote simulation environment.
+ *
+ * Setup
+ * In the SETUP phase a mandatory HELLO packet is exchanged with optional
+ * CFG packets following. HELLO packets are useful to ensure that both
+ * sides are speaking the same protocol and using compatible versions.
+ *
+ * CFG packets are used to negotiate configuration options. At the moment
+ * these remain unimplemented.
+ *
+ * Once the session is up, communication can start through various other
+ * commands. The list can be found further down this document.
+ * Commands are carried over RP packets. Every RP packet contains a header
+ * with length, flags and an ID to track potential responses.
+ * The header is followed by a packet specific payload. You'll find the
+ * details of the various commands packet layouts here. Some commands can
+ * carry data/blobs in their payload.
+ */
+
+
+#define RP_VERSION_MAJOR 4
+#define RP_VERSION_MINOR 3
+
+/* Could be auto generated.  */
+enum rp_cmd {
+    RP_CMD_nop         = 0,
+    RP_CMD_hello       = 1,
+    RP_CMD_cfg         = 2,
+    RP_CMD_read        = 3,
+    RP_CMD_write       = 4,
+    RP_CMD_interrupt   = 5,
+    RP_CMD_sync        = 6,
+    RP_CMD_ats_req     = 7,
+    RP_CMD_ats_inv     = 8,
+    RP_CMD_max         = 8
+};
+
+enum {
+    RP_OPT_quantum = 0,
+};
+
+struct rp_cfg_state {
+    uint64_t quantum;
+};
+
+enum {
+    RP_PKT_FLAGS_optional      = 1 << 0,
+    RP_PKT_FLAGS_response      = 1 << 1,
+
+    /*
+     * Posted hint.
+     * When set this means that the receiver is not required to respond to
+     * the message. Since it's just a hint, the sender must be prepared to
+     * drop responses. Note that since flags are echoed back in responses
+     * a response to a posted packet will be easy to identify early in the
+     * protocol stack.
+     */
+    RP_PKT_FLAGS_posted        = 1 << 2,
+};
+
+struct rp_pkt_hdr {
+    uint32_t cmd;
+    uint32_t len;
+    uint32_t id;
+    uint32_t flags;
+    uint32_t dev;
+} QEMU_PACKED;
+
+struct rp_pkt_cfg {
+    struct rp_pkt_hdr hdr;
+    uint32_t opt;
+    uint8_t set;
+} QEMU_PACKED;
+
+struct rp_version {
+    uint16_t major;
+    uint16_t minor;
+} QEMU_PACKED;
+
+struct rp_capabilities {
+    /* Offset from start of packet.  */
+    uint32_t offset;
+    uint16_t len;
+    uint16_t reserved0;
+} QEMU_PACKED;
+
+enum {
+    CAP_BUSACCESS_EXT_BASE = 1,    /* New header layout. */
+    CAP_BUSACCESS_EXT_BYTE_EN = 2, /* Support for Byte Enables.  */
+
+    /*
+     * Originally, all interrupt/wire updates over remote-port were posted.
+     * This turned out to be a bad idea. To fix it without breaking backwards
+     * compatibility, we add the WIRE Posted updates capability.
+     *
+     * If the peer supportes this, it will respect the RP_PKT_FLAGS_posted
+     * flag. If the peer doesn't support this capability, senders need to
+     * be aware that the peer will not respond to wire updates regardless
+     * of the posted header-flag.
+     */
+    CAP_WIRE_POSTED_UPDATES = 3,
+
+    CAP_ATS = 4, /* Address translation services */
+};
+
+struct rp_pkt_hello {
+    struct rp_pkt_hdr hdr;
+    struct rp_version version;
+    struct rp_capabilities caps;
+} QEMU_PACKED;
+
+enum {
+    /* Remote port responses. */
+    RP_RESP_OK                  =  0x0,
+    RP_RESP_BUS_GENERIC_ERROR   =  0x1,
+    RP_RESP_ADDR_ERROR          =  0x2,
+    RP_RESP_MAX                 =  0xF,
+};
+
+enum {
+    RP_BUS_ATTR_EOP        =  (1 << 0),
+    RP_BUS_ATTR_SECURE     =  (1 << 1),
+    RP_BUS_ATTR_EXT_BASE   =  (1 << 2),
+    RP_BUS_ATTR_PHYS_ADDR  =  (1 << 3),
+
+    /*
+     * The access targets the I/O address space.
+     */
+    RP_BUS_ATTR_IO_ACCESS  =  (1 << 4),
+
+    /*
+     * Bits [11:8] are allocated for storing transaction response codes.
+     * These new response codes are backward compatible as existing
+     * implementations will not set/read these bits.
+     * For existing implementations, these bits will be zero which is RESP_OKAY.
+     */
+    RP_BUS_RESP_SHIFT      =  8,
+    RP_BUS_RESP_MASK       =  (RP_RESP_MAX << RP_BUS_RESP_SHIFT),
+};
+
+struct rp_pkt_busaccess {
+    struct rp_pkt_hdr hdr;
+    uint64_t timestamp;
+    uint64_t attributes;
+    uint64_t addr;
+
+    /* Length in bytes.  */
+    uint32_t len;
+
+    /*
+     * Width of each beat in bytes. Set to zero for unknown (let the remote
+     * side choose).
+     */
+    uint32_t width;
+
+    /*
+     * Width of streaming, must be a multiple of width.
+     * addr should repeat itself around this width. Set to same as len
+     * for incremental (normal) accesses.  In bytes.
+     */
+    uint32_t stream_width;
+
+    /* Implementation specific source or master-id.  */
+    uint16_t master_id;
+} QEMU_PACKED;
+
+
+/* This is the new extended busaccess packet layout.  */
+struct rp_pkt_busaccess_ext_base {
+    struct rp_pkt_hdr hdr;
+    uint64_t timestamp;
+    uint64_t attributes;
+    uint64_t addr;
+
+    /* Length in bytes.  */
+    uint32_t len;
+
+    /*
+     * Width of each beat in bytes. Set to zero for unknown (let the remote
+     * side choose).
+     */
+    uint32_t width;
+
+    /*
+     * Width of streaming, must be a multiple of width.
+     * addr should repeat itself around this width. Set to same as len
+     * for incremental (normal) accesses.  In bytes.
+     */
+    uint32_t stream_width;
+
+    /* Implementation specific source or master-id.  */
+    uint16_t master_id;
+    /* ---- End of 4.0 base busaccess. ---- */
+
+    uint16_t master_id_31_16;   /* MasterID bits [31:16].  */
+    uint32_t master_id_63_32;   /* MasterID bits [63:32].  */
+    /*
+     * ---------------------------------------------------
+     * Since hdr is 5 x 32bit, we are now 64bit aligned.
+     */
+
+    uint32_t data_offset;       /* Offset to data from start of pkt.  */
+    uint32_t next_offset;       /* Offset to next extension. 0 if none.  */
+
+    uint32_t byte_enable_offset;
+    uint32_t byte_enable_len;
+
+    /* ---- End of CAP_BUSACCESS_EXT_BASE. ---- */
+
+    /*
+     * If new features are needed that may always occupy space
+     * in the header, then add a new capability and extend the
+     * this area with new fields.
+     * Will help receivers find data_offset and next offset,
+     * even those that don't know about extended fields.
+     */
+} QEMU_PACKED;
+
+struct rp_pkt_interrupt {
+    struct rp_pkt_hdr hdr;
+    uint64_t timestamp;
+    uint64_t vector;
+    uint32_t line;
+    uint8_t val;
+} QEMU_PACKED;
+
+struct rp_pkt_sync {
+    struct rp_pkt_hdr hdr;
+    uint64_t timestamp;
+} QEMU_PACKED;
+
+enum {
+    RP_ATS_ATTR_exec     = 1 << 0,
+    RP_ATS_ATTR_read     = 1 << 1,
+    RP_ATS_ATTR_write    = 1 << 2,
+};
+
+enum {
+    RP_ATS_RESULT_ok = 0,
+    RP_ATS_RESULT_error = 1,
+};
+
+struct rp_pkt_ats {
+    struct rp_pkt_hdr hdr;
+    uint64_t timestamp;
+    uint64_t attributes;
+    uint64_t addr;
+    uint64_t len;
+    uint32_t result;
+    uint64_t reserved0;
+    uint64_t reserved1;
+    uint64_t reserved2;
+    uint64_t reserved3;
+} QEMU_PACKED;
+
+struct rp_pkt {
+    union {
+        struct rp_pkt_hdr hdr;
+        struct rp_pkt_hello hello;
+        struct rp_pkt_busaccess busaccess;
+        struct rp_pkt_busaccess_ext_base busaccess_ext_base;
+        struct rp_pkt_interrupt interrupt;
+        struct rp_pkt_sync sync;
+        struct rp_pkt_ats ats;
+    };
+};
+
+#endif
-- 
2.43.0


