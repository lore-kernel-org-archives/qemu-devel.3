Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C15CDE00B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcv8q-0005p5-Fe; Thu, 25 Jun 2026 21:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <y.sanjeevreddy@gmail.com>)
 id 1wcv8o-0005oh-H1
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:13:58 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <y.sanjeevreddy@gmail.com>)
 id 1wcv8m-0004La-5V
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:13:58 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-137335bc3caso945335c88.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 18:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782436434; x=1783041234; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6avgqf4MNaaOD+Ab5nRNkYkhl5HvSm8YMl2yYqO9HZ8=;
 b=JC3i3kLmcPJi/Qg9GfVbqL0vGVJH+ByO+aW7hEN50wjbNNmR3xPAB3elRf4jmIixw3
 ISBKWnKPPNC5MNyh3fOR546c2xf9sfgcCwA+SgY54AIsNCIxp55ZQc5g7bht9iLksmaq
 rm8ZA7KMmZzPuD6TPR1MI4wFyJUCJcHj9STo6fltaRUk6EmEoy1GHqAVo0M400x5JglL
 Fvyealn3DgBlZO7hTzgIK/jRKVxjGsA3pbkGvZL1sJ3vP4KsoTxb7GDFcLPjBvXrsWBL
 fKRPG184CoSQ6Y9apoA+bBr3gvKJNR6QQKj5ShqFt/V+F3+seZ12p7KdttyKO+2hVwH5
 S7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782436434; x=1783041234;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6avgqf4MNaaOD+Ab5nRNkYkhl5HvSm8YMl2yYqO9HZ8=;
 b=HC89Lasd46BbChMx6G34fFTVZI4JaZb32D7kIHuk/cIwcVtl70dsLnPvDixYa7+iKf
 qzUEMXOgUDXkLOcoAr76fgcNoom7fMsJd4KFZu8A+IpbU1/Du6iKFf+OJwdgrNBOsa+Z
 odc2eJRPzDoCtBtepdDv78sLZUhbta1oulgIDKKXFIHxsqOVK00ja1pz9vq/45jV0VVA
 KIpMdbA7agMsJ+ce+4KAZ7S1L8wmy88Iftz0zVjQRZXzvzQPEIqt73L2VEdRdOGFof4J
 l7BMK6WolTodWghWzTVTvoGe6vecC7M67YIrOhLgGYjJJGMMN4cdcDmZ0JfkmtVzI1xr
 Sz9A==
X-Gm-Message-State: AOJu0Yz0oRvm42jl58Ro0QAT/GhSnZof75FOpG6M12yXloelcBa+Ao6z
 ClYAyELx1PHx6T96xgo4En+rueHPbfvtvPcNewYSFwemfrxrp0qec1V7
X-Gm-Gg: AfdE7ckO48vhfHf5C6medrLRAwT88FixGEnkhSlb7nrRRYmRPhMWYX7c4oFYghQRdkv
 a6G6gR8gFLXJG9+DuY1m/MiCJ50u75IFgaLlia1QsnrJKrZBNujz6su/sEtOJZGZHTpPdwCFTip
 xZ5Yfqe4HnTLgAg0s8E3Hmb8Aet0RwwXlrUhpD9ZR3b9ZEnZ3c2oTmc0ML1Jwj3KYiejIjtQsYo
 RPQ92svfpdbtd3FOqvlM3f1Cl0CcoWH6KXQ6xz34XRqiV0Nv74TfHsnJgGJm4iUxa9M3dlTV9YU
 ROsMhNzFpMcNcrkQotE3ocQh9phTqiPEpbI+l9fdfc5ZUlLqvgt3dszMG0/ozH+1N94h55Cj1/O
 ZHQeLipN0vROqzdQVU4JhKEsaiKQ/Q4XD21KGHL7qxNgEezGifSimmgZlLn9sKyYaT+FEVrLc4z
 HS/EDCutYSCIVMa3bT7h1f8GsgWO+Q73idwTOJcinN6tGG5hJzA0Tu0eG8
X-Received: by 2002:a05:7022:ff45:b0:139:85c2:d7b7 with SMTP id
 a92af1059eb24-139dbb1200dmr4036229c88.32.1782436433874; 
 Thu, 25 Jun 2026 18:13:53 -0700 (PDT)
Received: from [127.0.0.1] (67-2-23-151.slkc.qwest.net. [67.2.23.151])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f55b04sm12556851c88.4.2026.06.25.18.13.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 25 Jun 2026 18:13:53 -0700 (PDT)
From: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
Date: Thu, 25 Jun 2026 19:10:40 -0600
Subject: [PATCH v2] hw/net/net_tx_pkt: clamp payload_len to IP header
 length for padded frames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260625-net-tx-pkt-ip-length-padding-v2-1-d56f741bcdcd@gmail.com>
X-B4-Tracking: v=1; b=H4sIAI/RPWoC/42NSw6CMBQAr0K69hkoH4GV9zAsSnktT6E0bSUYw
 t0FvIDLSSYzK/PoCD2ro5U5nMnTZHbgl4jJXhiNQN3OjMe8iAuegcEAYQH7CkAWBjQ69GBF15H
 RkItSpXlZpamSbE9Yh4qWM/9ofuzf7RNlOJqH0ZMPk/uc/zk5vD9XcwIJ3ATnCqs2wyy+61HQc
 JXTyJpt276zmtcX2gAAAA==
X-Change-ID: 20260624-net-tx-pkt-ip-length-padding-5a8f358933fc
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>, 
 Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782436432; l=10586;
 i=y.sanjeevreddy@gmail.com; s=20260624-gmail; h=from:subject:message-id;
 bh=GpqpTAYUk1X8bKnLf67XM/I5X3buufXCbmBBZGfH1VY=;
 b=GMKqHr+TSeHRBcX1nUDGSYBXMDnntFWwDxAEpOS4nIDiMiczPwoMZ1JIRjvd5CjoB71oOA/C/
 uOeQFLysSHnBtszAAgPHRe0ceS5EgC5XO3JqfGcN3CylVfqy1/e1l/3
X-Developer-Key: i=y.sanjeevreddy@gmail.com; a=ed25519;
 pk=3ELbcw0bH36IEv3JvxqzTAgl5rrkOyv/tQHQzhpObAU=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=y.sanjeevreddy@gmail.com; helo=mail-dl1-x1234.google.com
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

When a guest transmits a short Ethernet frame, iov_size() returns the
wire length including any Ethernet padding bytes added to reach the
minimum 60-byte frame size.  net_tx_pkt_rebuild_payload() used that
inflated size directly as payload_len.  net_tx_pkt_update_ip_hdr_
checksum() then rewrites the IP Total Length (IPv4) or Payload Length
(IPv6) field using this value, producing a malformed packet on the
wire: the receiver interprets Ethernet padding bytes as IP payload.

In practice this breaks protocol stacks that validate IP lengths
strictly.  A nested ESXi host running on OpenStack using the e1000e
emulation sends short TCP ACK packets in response to a Windows guest's
virtio TLS client hello, which get padded to 60 bytes; the inflated IP
Total Length corrupts the IP header seen by Windows, causing TLS
handshakes and TCP connections to fail.

Fix net_tx_pkt_rebuild_payload() to read the IP header's declared
length and clamp payload_len accordingly:

  IPv4: ip_total_len - l3_hdr_len
  IPv6: ip6_plen adjusted for parsed extension headers

Guard both paths against malformed guest packets where the header-
declared length is shorter than the IP header itself; without the
guard the unsigned subtraction would underflow, producing a huge
payload_len.  Fall back to the raw iov_size() value in that case.

Signed-off-by: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
---
Changes in v2:
- Fix iov_copy() to use raw_payload_len (full wire size including Ethernet
  padding) instead of the IP-clamped payload_len; v1 silently dropped
  padding bytes from the TAP frame, causing short frames to be transmitted
  with incorrect wire size (addresses part 1 of Akihiko Odaki's review).
- Fix net_tx_pkt_get_total_len() to return iov_size(pkt->raw, pkt->raw_frags)
  instead of hdr_len + payload_len, which under-counted for short padded
  frames (addresses part 1 of Akihiko Odaki's review).
- Expand comments to make the two sizes explicit: payload_len is the
  IP-declared payload length used only for header/checksum operations;
  raw_payload_len is the full wire size used for iov_copy and total_len.
- Document the LSO/TSO super-packet (ip_len=0) and IPv6 jumbogram cases
  as known real-world triggers for the fallback path.
- Link to v1: https://lore.kernel.org/qemu-devel/20260624-net-tx-pkt-ip-length-padding-v1-1-7a22fe9b4e40@gmail.com

On the fallback to raw_payload_len when ip_len is too small (Akihiko Odaki):

The fallback is necessary for LSO/TSO super-packets where the ESXi e1000e
driver sets ip_len=0 as a placeholder in the unfragmented super-packet
header before the NIC performs segmentation.  The following log traces
(captured with a temporary debug printk and then removed) confirm this
path is triggered in practice:

  IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len=14793), using raw size
  IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len=16445), using raw size
  IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len= 5864), using raw size
  IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len= 1528), using raw size
  IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len= 3870), using raw size
  IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len= 2621), using raw size
  IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len= 1659), using raw size
  IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len= 1528), using raw size
  IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len= 4610), using raw size
  IPv4 ip_len=0 <= IP hdr len 20 (raw_payload_len= 1830), using raw size

For these packets the TCP segmentation engine drives the loop and does
not rely on payload_len to determine the payload extent, so using
raw_payload_len is correct and safe.

On the relationship to the short-packet receive-path discussion (Peter Maydell):
https://lore.kernel.org/qemu-devel/CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com/

The linked thread concerns the receive path — whether tap_send is the
right place to pad short incoming frames for guest NIC models.  This
patch addresses the transmit path: the guest NIC adds Ethernet padding
correctly, but net_tx_pkt_rebuild_payload was then using the padded
wire size to compute payload_len, causing net_tx_pkt_update_ip_hdr_
checksum to rewrite ip_len to include the padding bytes.

This fix does not change when or where padding is applied.  It only
ensures that payload_len reflects the IP-declared payload length, while
the full padded frame continues to be forwarded to the TAP via
iov_copy using raw_payload_len.
---
 hw/net/net_tx_pkt.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 3 deletions(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 903238dca2..2dcbf23354 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -274,11 +274,89 @@ static bool net_tx_pkt_parse_headers(struct NetTxPkt *pkt)
 
 static void net_tx_pkt_rebuild_payload(struct NetTxPkt *pkt)
 {
-    pkt->payload_len = iov_size(pkt->raw, pkt->raw_frags) - pkt->hdr_len;
+    size_t raw_payload_len = iov_size(pkt->raw, pkt->raw_frags) - pkt->hdr_len;
+    struct iovec *l2hdr = &pkt->vec[NET_TX_PKT_L2HDR_FRAG];
+    uint16_t l3_proto = eth_get_l3_proto(l2hdr, 1, l2hdr->iov_len);
+
+    /*
+     * payload_len tracks the IP-declared payload size. It is used by
+     * net_tx_pkt_update_ip_hdr_checksum() to rewrite ip_len and by the L4
+     * pseudo-header checksum helpers. It must NOT include Ethernet
+     * minimum-frame padding: if the guest sends a short frame (e.g. a pure
+     * TCP ACK of 54 bytes) padded to 60 bytes, iov_size() returns 60 but the
+     * IP header still reports the payload as 20 bytes. Using the inflated size
+     * would cause ip_len to be rewritten to include the padding, making the
+     * packet malformed on the receiver.
+     *
+     * Note: the actual iov_copy below still copies raw_payload_len bytes
+     * (the full wire payload including padding) into the payload fragments so
+     * the TAP receives a correctly-sized Ethernet frame. The receiver's IP
+     * stack uses ip_len to find the real payload boundary and ignores the
+     * trailing padding bytes, which is exactly how a real NIC behaves.
+     *
+     * IPv4: ip_len is the total length including the IP header.
+     * IPv6: ip6_plen is the payload length after the base 40-byte header
+     *       (extension headers are included in ip6_plen but also in
+     *       l3_hdr_len, so subtract them out).
+     */
+    if (l3_proto == ETH_P_IP) {
+        uint16_t ip_total_len = be16_to_cpu(pkt->l3_hdr.ip.ip_len);
+        size_t l3_hdr_len = pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len;
+        /*
+         * Guard against ip_total_len that does not cover the IP header.
+         * Subtracting would underflow (both types unsigned), producing a
+         * huge payload_len.  Fall back to raw_payload_len in that case.
+         *
+         * Known trigger: some LSO/TSO implementations (e.g. ESXi e1000e
+         * driver) set ip_len=0 in the super-packet header as a placeholder
+         * when offloading segmentation to the NIC.  In that case
+         * raw_payload_len correctly reflects the full super-packet payload
+         * from the TX descriptors, and the TCP segmentation path does not
+         * rely on payload_len to drive the loop, so this is safe.
+         */
+        if (ip_total_len > l3_hdr_len) {
+            pkt->payload_len = MIN(raw_payload_len, ip_total_len - l3_hdr_len);
+        } else {
+            pkt->payload_len = raw_payload_len;
+        }
+    } else if (l3_proto == ETH_P_IPV6) {
+        uint16_t ip6_payload_len = be16_to_cpu(pkt->l3_hdr.ip6.ip6_plen);
+        size_t l3_hdr_len = pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len;
+        size_t ext_hdr_len = l3_hdr_len - sizeof(struct ip6_header);
+        /*
+         * Guard against malformed packets where ip6_plen is zero or does
+         * not cover the extension headers that were already parsed. Without
+         * this check, the subtraction (ip6_payload_len - ext_hdr_len) would
+         * underflow (unsigned), producing a huge payload_len. Fall back to
+         * the raw iov_size value in that case.
+         */
+        if (ip6_payload_len > ext_hdr_len) {
+            pkt->payload_len = MIN(raw_payload_len,
+                                   ip6_payload_len - ext_hdr_len);
+        } else {
+            /*
+             * ip6_plen=0 is valid for IPv6 jumbograms (payload length
+             * carried in a Hop-by-Hop option), but QEMU does not support
+             * jumbograms so raw_payload_len is the best we can do.
+             * Also guards against malformed packets where ip6_plen is
+             * smaller than the extension headers already parsed.
+             */
+            pkt->payload_len = raw_payload_len;
+        }
+    } else {
+        pkt->payload_len = raw_payload_len;
+    }
+
+    /*
+     * Copy the full raw_payload_len bytes (including any Ethernet padding)
+     * so the wire frame sent to the TAP has the correct size.  payload_len
+     * (the IP-declared value set above) is used only for header/checksum
+     * operations; raw_payload_len preserves the original frame size.
+     */
     pkt->payload_frags = iov_copy(&pkt->vec[NET_TX_PKT_PL_START_FRAG],
                                 pkt->max_payload_frags,
                                 pkt->raw, pkt->raw_frags,
-                                pkt->hdr_len, pkt->payload_len);
+                                pkt->hdr_len, raw_payload_len);
 }
 
 bool net_tx_pkt_parse(struct NetTxPkt *pkt)
@@ -428,7 +506,14 @@ size_t net_tx_pkt_get_total_len(struct NetTxPkt *pkt)
 {
     assert(pkt);
 
-    return pkt->hdr_len + pkt->payload_len;
+    /*
+     * Use the raw iov size rather than hdr_len + payload_len.  payload_len
+     * reflects the IP-declared payload length (excluding any Ethernet minimum-
+     * frame padding), so hdr_len + payload_len would under-count for short
+     * frames.  pkt->raw always holds the exact bytes that arrived from the
+     * guest TX descriptors, padding included, giving the true wire size.
+     */
+    return iov_size(pkt->raw, pkt->raw_frags);
 }
 
 void net_tx_pkt_dump(struct NetTxPkt *pkt)

---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20260624-net-tx-pkt-ip-length-padding-5a8f358933fc

Best regards,
--  
Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>


