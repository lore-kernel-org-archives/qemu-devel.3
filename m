Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7374CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 22:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcVuX-0003tC-9V; Wed, 24 Jun 2026 18:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <y.sanjeevreddy@gmail.com>)
 id 1wcVPk-0006VO-GN
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 17:45:44 -0400
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <y.sanjeevreddy@gmail.com>)
 id 1wcVPi-0003dY-6i
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 17:45:43 -0400
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-30c713f37c2so283545eec.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 14:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782337540; x=1782942340; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/vghZDYVubbr7+CnA9I+jTZNdgR/7bQvlz7v7ZesAyM=;
 b=Ic/AkdGhnx8vGrzjFmwwnwbkHrIi2Nv/jo+DAKYD6c3R48RdAYFwDIuoyeZdd6mZJc
 GqRVdNEg34AMtYZiOhgKjW6hcud1E3/i5fWQDnJcIWPm2aRN0Gn7vWFFh1j5BEikw3Hm
 L3jPWzmhwJH2xzuDkIzSFeE2Ty3KYCRK9Bla5Y4z6cte5xQiUzGK1g5JKiEDQM76LpYe
 j8n3ZAGyMPJgilspeSGcqX0g+ViGvpSwysJL6/gkU33eQx+3eXC8Oaj0D3/VARtiyx0T
 w79E3Q7vD+ZcxmSN1MBEYbRelaQdCj6qGS1VnxGnjhKja+GsoykzRJBRGADFI7Wakyn/
 OuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782337540; x=1782942340;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/vghZDYVubbr7+CnA9I+jTZNdgR/7bQvlz7v7ZesAyM=;
 b=I0XeS+HBJrbtULtvBEwMkQfIjC1EvkwuKd6guzV8YDcJuvW0KkTN3Mnkds9WE2wUdV
 a/hx1y5xOZJ4WROGzK9OCjzYT5JiUWFnjZrVJjNOGoq+RSejd1UnzTgsYqJMOhw2mKEc
 XldTthzXIu16j/r3dw5LrH+CCxedY1gU16nB8NOR8XGLZa4bXK9PpgB/wE8tB8IHAJcH
 tk2TWKs/BlqmdEbrgtzQLBCYkFQf61jRJkfLsVWLxCXJfwwmwdkmfm4qiX9GjsCMUhqU
 9MCSIKWuSTuox+5BiO+gIbIXLT4zUYcoojQvyA3DZ96Lyk6CAsrQAEcjDLxhjUz+cbrx
 3Yng==
X-Gm-Message-State: AOJu0YxNEd4pHqYV/dIPenbVVKIa2nMU5YuMxRLxZttfFnaGy4O1j7+C
 7V95mcnc5lhQ3TjGOPoeC8bMTFBkcAP5tD4/nnDgL8V/zFcpYPJjr2Fr
X-Gm-Gg: AfdE7cnTWltScb8kXWRFAPxIgTG6na0HUbHuKHW3iV5J/RpVYqK4zSLQ+OlItmX1B0G
 wEqSkABFe5xJ2RKacz6bbJH6riYtU0NVk5wzjn9N5ioQJZCFFYE6gbQbOBxuOWnyP+7Ywt72Pns
 dSzvxJgwH7q9d1DVZ2kkXt7qsL/fFxVUJGIsin6luVEX1Nxf5gd9i+OvmtH0mHrPIa919G6OqPm
 MVe+0vTQ+Gm1YkBGlWcwtl2o9efkLWwgCDhN5uKSXNTVsbGJz6xtJS34PurEFbx0D2lEIFtIDpj
 wIt8KDC+0KASVetNgdcScHWaQaLoXCq2HuGSuY5i93qF+ZfXOSueNcZC1bJpxyjwtEFukfBmxQ/
 ZcQ7GdfFFUxYJou2mjEYJnXseC/Wz29Zo/gTQTJZBk2l7fF2bz8Q4YwbPou5Cuq+T8K0/eC7jKg
 FNFNT1MKSMszx2WxvTAxTOHYRm++A17eupFRPhuqKPM5PqVnXL5bhsqkXx
X-Received: by 2002:a05:7300:72c4:b0:30c:a0f:3bd0 with SMTP id
 5a478bee46e88-30c78e617fbmr1714620eec.13.1782337539809; 
 Wed, 24 Jun 2026 14:45:39 -0700 (PDT)
Received: from [127.0.0.1] (67-2-23-151.slkc.qwest.net. [67.2.23.151])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4ca240sm1690287eec.4.2026.06.24.14.45.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Jun 2026 14:45:39 -0700 (PDT)
From: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
Date: Wed, 24 Jun 2026 15:45:32 -0600
Subject: [PATCH] hw/net/net_tx_pkt: clamp payload_len to IP header length
 for padded frames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-net-tx-pkt-ip-length-padding-v1-1-7a22fe9b4e40@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPxPPGoC/yXMwQrCMAwA0F8ZORuYrRvTXxEPtU27qMTSRhmM/
 btVj+/yVqhUmCqcuhUKvbnyUxr2uw787CQRcmgG05uxH80BhRR1wXxX5IwPkqQzZhcCS8LBTdE
 O09Ha6KEVuVDk5defL3/X1/VGXr8nbNsH+ARDS4AAAAA=
X-Change-ID: 20260624-net-tx-pkt-ip-length-padding-5a8f358933fc
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>, 
 Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782337538; l=5110;
 i=y.sanjeevreddy@gmail.com; s=20260624-gmail; h=from:subject:message-id;
 bh=daH8nWF3nNK7cB/peJAGgwGdhRfDkIQUCopx72tC86o=;
 b=nMfcNu49UQlWF9P9vxYABogjSQ7UexEXSIff/g4SmC5TQEHg/5J1SMySFGUJRdYTQNI/Zn81v
 yeTJl+BXFLRBOHzUKlFcQxP1jmoI3p+TKae2uugmoso4iVKCOBCApAE
X-Developer-Key: i=y.sanjeevreddy@gmail.com; a=ed25519;
 pk=3ELbcw0bH36IEv3JvxqzTAgl5rrkOyv/tQHQzhpObAU=
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=y.sanjeevreddy@gmail.com; helo=mail-dy1-x132e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 24 Jun 2026 18:17:32 -0400
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
 hw/net/net_tx_pkt.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 903238dca2..d3549a4378 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -274,7 +274,60 @@ static bool net_tx_pkt_parse_headers(struct NetTxPkt *pkt)
 
 static void net_tx_pkt_rebuild_payload(struct NetTxPkt *pkt)
 {
-    pkt->payload_len = iov_size(pkt->raw, pkt->raw_frags) - pkt->hdr_len;
+    size_t raw_payload_len = iov_size(pkt->raw, pkt->raw_frags) - pkt->hdr_len;
+    struct iovec *l2hdr = &pkt->vec[NET_TX_PKT_L2HDR_FRAG];
+    uint16_t l3_proto = eth_get_l3_proto(l2hdr, 1, l2hdr->iov_len);
+
+    /*
+     * Clamp payload_len to what the IP header says, not what iov_size()
+     * returns. When a short frame is padded to the Ethernet minimum of 60
+     * bytes, iov_size() includes the padding. Using that inflated size as
+     * payload_len causes net_tx_pkt_update_ip_hdr_checksum() to rewrite the
+     * IP total/payload length to include Ethernet padding, making the packet
+     * malformed (receiver may treat padding as payload or miscalculate
+     * checksums). Clamp to the guest-provided IP length instead.
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
+         * Guard against malformed packets where ip_total_len is zero or
+         * smaller than the IP header itself. Without this check, the
+         * subtraction (ip_total_len - l3_hdr_len) would underflow (both
+         * types are unsigned), producing a huge payload_len and corrupting
+         * the packet. Fall back to the raw iov_size value in that case.
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
+            pkt->payload_len = raw_payload_len;
+        }
+    } else {
+        pkt->payload_len = raw_payload_len;
+    }
+
     pkt->payload_frags = iov_copy(&pkt->vec[NET_TX_PKT_PL_START_FRAG],
                                 pkt->max_payload_frags,
                                 pkt->raw, pkt->raw_frags,

---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20260624-net-tx-pkt-ip-length-padding-5a8f358933fc

Best regards,
--  
Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>


