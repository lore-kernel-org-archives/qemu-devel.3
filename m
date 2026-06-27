Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1A1C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 13:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdSw3-0007ii-IZ; Sat, 27 Jun 2026 09:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <y.sanjeevreddy@gmail.com>)
 id 1wdSw1-0007iQ-P6
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 09:19:01 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <y.sanjeevreddy@gmail.com>)
 id 1wdSvz-0006F5-98
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 09:19:01 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-30ca1b4b278so2544267eec.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2026 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782566337; x=1783171137; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HkpMs9T/VvB+0ijSS/+4onYhLeyWwz3Px13au0QxjLU=;
 b=EAHEO+jnwq0pxna45fm97wnhLn1yig/c2qsFjPD2JM9jlDkih+t5p++xX9zPcYGlBZ
 5x9k1Zvwm1Z5dErXEJbr2/cxeqeNoEBpbadWIk9y36F9oqgHV+n4Ltez91S/TSm0/xfS
 h8zOdjpkCcfsZ9mM9Q2dw+0r4kegN74AfNU+7m/8VU3PgBN9He/HrO3ZAXjpoc+Kb1N6
 9peERHYXpUXUJGFMX5BtuN7lP2YRY5ENIE1YhH9GJ2C0WHyy9mGkEDf5zsTtPpYysXAm
 7/AGZ3N2E7jTseuMcpJN0siz+HZRUuh7VvTPapes7HrybEJAsIf0qkkKcaQnDwb2ZTIo
 HAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782566337; x=1783171137;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkpMs9T/VvB+0ijSS/+4onYhLeyWwz3Px13au0QxjLU=;
 b=XNqgh31PnMC6BTy1zFfLYXKBl6Li7z+vh6Ro0mbZfbmAcwGsogoc6VGUCawj94qQ4A
 ooyF6TJFJR24a9Eq7BCclGY/VtytOzazAteavB02TKmGxM05sntBKmumIkapxm/oGp9T
 ub/3KduPzrrINYLnG1JDDtAHDdO3pPXqgYH8zHVKYgZ14thG5kt2FHSxjur9OxijWyZK
 WbdnbJNBUJLtXNTHkA/uHx1ZoHF0zPJyjBA4nbPvCGtahInq9OIzTJP+QjrwGgTAnOE3
 YRn0cxD52ggCejiohWEv2NjidYdnjcpUMm/4WRFJVNXO7kNQvLt6keIi6MmWlQ7gIWoi
 Gy1w==
X-Gm-Message-State: AOJu0YwvjtwRXWbLcOdKoqpENIF55xsxKUHYj9sn6uAvNPYAeH6ffdma
 Vi1s0dDJ/o3zzM8FKJxGB21CcaOhMhKwhhlqcuwq+TZA9juSrNg3uSDU
X-Gm-Gg: AfdE7clBIgktIzae7n3US0aRY7aAj+vaEHglCRLFWD3c6PHijkmSeE7y/c/4wnhh6aI
 6WDbtwfz70hLBmaET2vjTOsYEA5Jhw9tcu6qsAK43fo9jmWOCqCwFixZu5rIpJ4W3a5nLxj++az
 u082sOEUso0XLo65Xbyw+ogFWdTSajFg7LtaLzKye2r0jXbQkoXXCfF0jDz/GVGQ8PUm1XzaSji
 IxcmR4/IFe4zM6/4nY6rs8fFq61pjy/P9aQ+dDUL2vyLcWVDDZMK7rrh/qzQbyYwzCgmnv2TQbN
 5Fv5Z7pf4zWO+uGUUjCJMzKnsxxk1TbhM9Z5Jmb72QuPp9S2ORusOt/RiEv4Sb8xfZUagjpHQri
 Ufivg/FxC51y5IqKVlTqxogWv+EOwoWveRBlaMD+33nUo3VJfE/MJAEjYcOK4RCTwntL8KAhGye
 jsC550jdIvrypH9n7P1BxQIb0V8cX7hD5GOpBbnt+XqILZBcft8epLfHBe
X-Received: by 2002:a05:7300:1824:b0:2ea:5057:a304 with SMTP id
 5a478bee46e88-30c84d9e27emr10232295eec.2.1782566337043; 
 Sat, 27 Jun 2026 06:18:57 -0700 (PDT)
Received: from [127.0.0.1] (67-2-23-151.slkc.qwest.net. [67.2.23.151])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a75sm27682492eec.19.2026.06.27.06.18.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 27 Jun 2026 06:18:56 -0700 (PDT)
From: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
Date: Sat, 27 Jun 2026 07:18:05 -0600
Subject: [PATCH v3] hw/net/net_tx_pkt: fix payload_len for Ethernet-padded
 short frames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260627-net-tx-pkt-ip-length-padding-v3-1-ff6357d0bd6f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAI3NP2oC/43NSw6CMBSF4a2Qjr0GytuR+zAOSnsLV6E0tBIMY
 e8CTpjp8E9OvjMzhwOhY5dgZgOO5Kg3a8SngMlGmBqB1NqMhzwLM56AQQ9+Avv0QBZaNLVvwAq
 lyNSQikLHaVHGsZZsJeyAmqadv92/7V7VA6XfzG3RkPP98N7/x2jb/Xk1RhBBLjjXWFYJJuG17
 gS1Z9l3bLsa+RFLf2B8xVSa6TyJKqmkOmLLsnwA2L8wEScBAAA=
X-Change-ID: 20260624-net-tx-pkt-ip-length-padding-5a8f358933fc
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>, 
 Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782566335; l=12505;
 i=y.sanjeevreddy@gmail.com; s=20260624-gmail; h=from:subject:message-id;
 bh=uRFTA1vpNokYUauRfVJgTsr1K2cnj8rX9yAtZUU7+/o=;
 b=pgePDWLtnLnvZ4JItxQeJ3YH1Q6v7w6tc8C+OZqYX8t6VwsOBErFWIT8zWrumn0YQ6l/XhL1j
 Wzlt3GvvbVVBtyXqrzgzAd1ysGTFn/79VCJ60RTYpOi8hQYRW3gq171
X-Developer-Key: i=y.sanjeevreddy@gmail.com; a=ed25519;
 pk=3ELbcw0bH36IEv3JvxqzTAgl5rrkOyv/tQHQzhpObAU=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=y.sanjeevreddy@gmail.com; helo=mail-dy1-x1329.google.com
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

net_tx_pkt_rebuild_payload() now handles three cases:

1. ip_len is valid (ip_total_len > l3_hdr_len): clamp payload_len to
   the IP-declared payload length, stripping Ethernet padding.

2. ip_len is invalid and pkt->payload_len == 0: no authoritative source
   is available; fall back to raw_payload_len as a safe default.

3. ip_len is invalid and pkt->payload_len != 0: a device pre-set an
   authoritative value via net_tx_pkt_set_payload_len() before calling
   net_tx_pkt_parse(); leave it unchanged.

Add net_tx_pkt_set_payload_len() to the public API so devices that
carry the payload length in a hardware context descriptor can provide
it before net_tx_pkt_parse() is called (case 3 above).

For e1000e, TSO super-packets have ip_len=0 as a placeholder per the
82574 datasheet §7.3.4.  Use the descriptor fields to compute the
correct IP payload length before net_tx_pkt_parse():

  payload_len = paylen + (hdr_len - tucss)
              = L4 data + L4 header length

net_tx_pkt_rebuild_payload() then sees a non-zero payload_len and
preserves it, never reaching the raw_payload_len fallback.

Signed-off-by: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
---
Thank you Akihiko for your review and for providing detailed guidance on
calculating the payload length for e1000e and the relevant sections in
the Intel datasheet.

Changes in v3:
- Architectural redesign per Akihiko Odaki's review: remove the
  device-specific ESXi/TSO heuristic from the common
  net_tx_pkt_rebuild_payload() code.
- net_tx_pkt_rebuild_payload() now has three explicit cases: (1) valid
  ip_len — clamp to it; (2) invalid ip_len and no pre-set value — fall
  back to raw_payload_len; (3) invalid ip_len but device pre-set an
  authoritative payload_len before parse — preserve it.
- Add net_tx_pkt_set_payload_len() to the public API for devices to
  supply a context-derived payload length before net_tx_pkt_parse().
- Move e1000e TSO logic into e1000e_core.c: per 82574 §7.3.4, compute
  payload_len = paylen + (hdr_len - tucss) and pre-set it before parse
  so the common fallback is never reached for TSO super-packets.
- Link to v2: https://lore.kernel.org/qemu-devel/20260625-net-tx-pkt-ip-length-padding-v2-1-287d0ba59ec1@gmail.com

Changes in v2:
- Fix iov_copy() to use raw_payload_len instead of payload_len so
  Ethernet padding is preserved in the TAP wire frame.
- Fix net_tx_pkt_get_total_len() to return iov_size() instead of
  hdr_len + payload_len to avoid under-counting short frames.
- Link to v1: https://lore.kernel.org/qemu-devel/20260624-net-tx-pkt-ip-length-padding-v1-1-7a22fe9b4e40@gmail.com

On the relationship to the short-packet receive-path discussion
(Peter Maydell):
https://lore.kernel.org/qemu-devel/CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com/

The linked thread concerns the receive path — whether tap_send is the
right place to pad short incoming frames for guest NIC models.  This
patch addresses the transmit path: the guest NIC adds Ethernet padding
correctly, but net_tx_pkt_rebuild_payload() was using the padded wire
size to compute payload_len, causing net_tx_pkt_update_ip_hdr_checksum
to rewrite ip_len to include the padding bytes.

This fix does not change when or where padding is applied.  It only
ensures payload_len reflects the IP-declared length, while the full
padded frame continues to be forwarded to TAP via raw_payload_len.
---
 hw/net/e1000e_core.c | 27 ++++++++++++-----
 hw/net/net_tx_pkt.c  | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/net/net_tx_pkt.h  | 14 +++++++++
 3 files changed, 116 insertions(+), 10 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 46e156a5dd..0f0f18c675 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -717,14 +717,27 @@ e1000e_process_tx_desc(E1000ECore *core,
     }
 
     if (eop) {
-        if (!tx->skip_cp && net_tx_pkt_parse(tx->tx_pkt)) {
-            if (e1000x_vlan_enabled(core->mac) &&
-                e1000x_is_vlan_txd(txd_lower)) {
-                net_tx_pkt_setup_vlan_header_ex(tx->tx_pkt,
-                    le16_to_cpu(dp->upper.fields.special), core->mac[VET]);
+        if (!tx->skip_cp) {
+            if (tx->props.tse && tx->cptse) {
+                /*
+                 * Per 82574 §7.3.4, ip_len is zero in TSO super-packets.
+                 * Pre-set payload_len before parse so
+                 * net_tx_pkt_rebuild_payload() preserves it (case 3).
+                 *   L4 header length = hdr_len − tucss
+                 *   L4 data          = paylen
+                 */
+                net_tx_pkt_set_payload_len(tx->tx_pkt,
+                    tx->props.paylen + tx->props.hdr_len - tx->props.tucss);
             }
-            if (e1000e_tx_pkt_send(core, tx, queue_index)) {
-                e1000e_on_tx_done_update_stats(core, tx->tx_pkt);
+            if (net_tx_pkt_parse(tx->tx_pkt)) {
+                if (e1000x_vlan_enabled(core->mac) &&
+                    e1000x_is_vlan_txd(txd_lower)) {
+                    net_tx_pkt_setup_vlan_header_ex(tx->tx_pkt,
+                        le16_to_cpu(dp->upper.fields.special), core->mac[VET]);
+                }
+                if (e1000e_tx_pkt_send(core, tx, queue_index)) {
+                    e1000e_on_tx_done_update_stats(core, tx->tx_pkt);
+                }
             }
         }
 
diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 903238dca2..be09727ad6 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -274,11 +274,77 @@ static bool net_tx_pkt_parse_headers(struct NetTxPkt *pkt)
 
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
+        if (ip_total_len > l3_hdr_len) {
+            /*
+             * ip_len is valid — clamp to the IP-declared payload length to
+             * strip any Ethernet minimum-frame padding appended by the NIC.
+             */
+            pkt->payload_len = MIN(raw_payload_len, ip_total_len - l3_hdr_len);
+        } else if (!pkt->payload_len) {
+            /* No valid ip_len and no device-specific value was pre-set. */
+            pkt->payload_len = raw_payload_len;
+        }
+        /* else: device pre-set payload_len before parse; keep it. */
+    } else if (l3_proto == ETH_P_IPV6) {
+        uint16_t ip6_payload_len = be16_to_cpu(pkt->l3_hdr.ip6.ip6_plen);
+        size_t l3_hdr_len = pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len;
+        size_t ext_hdr_len = l3_hdr_len - sizeof(struct ip6_header);
+        if (ip6_payload_len > ext_hdr_len) {
+            /*
+             * Clamp to the IPv6-declared payload length minus any extension
+             * headers already parsed into l3_hdr_len.
+             */
+            pkt->payload_len = MIN(raw_payload_len,
+                                   ip6_payload_len - ext_hdr_len);
+        } else if (!pkt->payload_len) {
+            /* ip6_plen is zero (jumbogram) and no pre-set value. */
+            pkt->payload_len = raw_payload_len;
+        }
+        /* else: device pre-set payload_len before parse — keep it. */
+    } else {
+        if (!pkt->payload_len) {
+            pkt->payload_len = raw_payload_len;
+        }
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
@@ -428,7 +494,20 @@ size_t net_tx_pkt_get_total_len(struct NetTxPkt *pkt)
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
+}
+
+void net_tx_pkt_set_payload_len(struct NetTxPkt *pkt, uint32_t payload_len)
+{
+    assert(pkt);
+    pkt->payload_len = payload_len;
 }
 
 void net_tx_pkt_dump(struct NetTxPkt *pkt)
diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
index 0a716e74a5..1a1c5edc2d 100644
--- a/hw/net/net_tx_pkt.h
+++ b/hw/net/net_tx_pkt.h
@@ -133,6 +133,20 @@ bool net_tx_pkt_update_sctp_checksum(struct NetTxPkt *pkt);
  */
 size_t net_tx_pkt_get_total_len(struct NetTxPkt *pkt);
 
+/**
+ * pre-set the payload length before net_tx_pkt_parse()
+ *
+ * Devices that carry an authoritative payload length in a hardware context
+ * descriptor (e.g. e1000e PAYLEN for TSO) should call this before
+ * net_tx_pkt_parse().  net_tx_pkt_rebuild_payload() will then skip its
+ * ip_len=0 fallback and preserve this value.
+ *
+ * @pkt:            packet
+ * @payload_len:    IP payload length (L4 header + L4 data)
+ *
+ */
+void net_tx_pkt_set_payload_len(struct NetTxPkt *pkt, uint32_t payload_len);
+
 /**
  * get packet type
  *

---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20260624-net-tx-pkt-ip-length-padding-5a8f358933fc

Best regards,
--  
Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>


