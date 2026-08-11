Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89095C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnar-00012c-2A; Tue, 11 Aug 2026 10:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnaV-0000K0-VR
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:36:21 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnaT-0001vs-Mv
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:36:19 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-8f032b47e3cso22080666d6.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458977; x=1787063777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0jXwXMcIM9domi9Vq64aJDlJVcT9DGz1pqG5naol8gc=;
 b=RjoN6LqXA7Y0ZrXVmLrygATIQFWcCaY/KLJtyZyZID1Lw1+jxKPs58BBZdtOIBXiFR
 X2EL4AJ9OS/ZdRxg8f+sh88wsEsk+dQ0fqh6cneMxSGTf6EAYILox6dDV5wUJoWl8X86
 /Bx3Ugp9WbWDGOmeQOg93o7RtcfnfeJAZfBtntztEaHNdWwGrnB7RZiEMCNCQ+ehEBQy
 MLF3mBYxKJZ4O7D/0fIB0gkQCdrzADTQz8i4zTFxq/btfxOtFMNFLTp5pFtI4Z3GZ08R
 K5DfPKDYqK9rmrDjM/5dc+L1AOE8wrSCcJTlaERD/Yer8scSp5moD4nSqEe1NiBU59W/
 0CWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458977; x=1787063777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0jXwXMcIM9domi9Vq64aJDlJVcT9DGz1pqG5naol8gc=;
 b=WZQx4y8dPq+gwDvKQ8SYqxgVXm4tQZM9D0WzNJcMxyZO9AYnJvD7/eSTrcc8DqFRh1
 V1n43jMAd3qZ2qVdmIwjSwnpE1zb6FZ6EdOoZUHPOtfpsYGi6dJwMoO9eCKmiRclhr/M
 y3WevEOcfqOohuEdapYDQUHz0k0bK8AjldGVK1T16Rpss5gY3zaPe58Bb/QRn48IVvIL
 b+JdectXiT/GpZ9ccSMp6L/4DVkGU1nDjqJDXo1dqDZknecq5A6xjwCV86OYrtcEkC5n
 s0pX3tmXsn0JMigybMalZcsH1CSwIWbD2+/PboLT/LleKcHWUoBO6y4wdCbgwXBVp6yc
 KOEQ==
X-Gm-Message-State: AOJu0YzDtAd1FeAr4ANYyh0q9ZhP9aXr4zbE2RzfVubk8fGG0t8iZbUe
 zaRF3suq9efOpKZAcJTvnihsm5CYpv9RvQWba6lsMYpynvK7L3T5IJbwGF4IXw==
X-Gm-Gg: AR+sD10TYmlwwcL9/nefKueIPbPXN+QSOPqhX+SSWpWsvEiy/zUjBG7jp3D1DBg+KR5
 VZG7krtMNoOdCh2NznTYlxm6AioVQo0U6pbPEuQFpqmGqA+144mhcQvflVVaPtPzSkm8aVBgzFV
 7dZBLhIAe3zeaOc7u8NZ2TOZCjeEdJreGaz/L4MHxTcrdO5IWPTeSfdk8C74yIVZ/n6k6ur/DrW
 Jo0KrRKcp78p+6Z5PfYrrko3qh2U13KaeI3h0mp13TEt4Ge1xgXLOcZEBsbn1JkyzYewJ0YxJBg
 L7WhVgg/rdma5J9a2gZSN6hwnGTWJBFIUla5jLdd++MMpD+PsgxM+OEnDAddgfkExX1ivB09kP/
 GzM4adlahFfvOBgWFJPBmLqlIsyDANEb5Hk38refoA4N1dLWcEGjRZZ2cVrxpk4b9xuNUJD+R96
 OTVV27omxzhReqQTY5MX56oli+WWQHVRq32hfX76V3hbk/shzAiMr6NYuFr7zEH2YVdJ1xTIJaM
 hOwMirGBC1UuzCT8SM=
X-Received: by 2002:a05:6214:404:b0:8ef:cfa:2a36 with SMTP id
 6a1803df08f44-90a6681f28amr34221656d6.9.1786458976516; 
 Tue, 11 Aug 2026 07:36:16 -0700 (PDT)
Received: from localhost.localdomain ([198.16.145.87])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c26e074sm681286d6.2.2026.08.11.07.36.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 07:36:15 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v2 16/19] hw/net/bcm2838_genet: fix bogus RX checksum reporting
Date: Tue, 11 Aug 2026 10:35:53 -0400
Message-ID: <20260811143557.7862-17-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260811143557.7862-1-marcelomanzo@gmail.com>
References: <20260811143557.7862-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qv1-xf2e.google.com
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

bcm2838_genet_rdma() reported the received frame's IPv4 header
checksum (in host byte order) as the descriptor's rx_csum value.
The guest driver's CHECKSUM_COMPLETE path expects a running checksum
over the L4 payload there, not the L3 header checksum, so the
mismatch made the guest reject otherwise-valid inbound packets
("hw csum failure" in dmesg, from bcmgenet_rx_poll()), breaking
DHCP and general connectivity intermittently.

Report no hardware-computed checksum instead (rx_csum = 0), which
makes the guest fall back to verifying checksums in software; this
succeeds since the packet data itself was never corrupted. Drop the
eth_get_protocols() call and its output variables along with it,
since isip4/ip4hdr_info were only ever used to compute the checksum
value being removed here.

Confirmed with the guest booted repeatedly: "hw csum failure" no
longer appears in dmesg, and ping to the gateway succeeds with 0%
loss.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index dfdc5ac728..ccf3c2fef0 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -828,12 +828,6 @@ static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
         MemTxResult mem_tx_result = MEMTX_OK;
         uint8_t *frame_buf = dma_buf + sizeof(BCM2838GenetXmitStatus) + 2;
         BCM2838GenetXmitStatus *xmit_status = (BCM2838GenetXmitStatus *)dma_buf;
-        struct iovec iov;
-        bool isip4, isip6;
-        size_t l3hdr_off, l4hdr_off, l5hdr_off;
-        eth_ip6_hdr_info ip6hdr_info;
-        eth_ip4_hdr_info ip4hdr_info;
-        eth_l4_hdr_info  l4hdr_info;
 
         bool crc_fwd = FIELD_EX32(s->regs.umac.cmd, GENET_UMAC_CMD, CRC_FWD);
         size_t buflength;
@@ -844,12 +838,6 @@ static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
         }
 
         memcpy(frame_buf, buf + len, l);
-        iov.iov_base = frame_buf;
-        iov.iov_len = l;
-        eth_get_protocols(&iov, 1, 0,
-                          &isip4, &isip6,
-                          &l3hdr_off, &l4hdr_off, &l5hdr_off,
-                          &ip6hdr_info, &ip4hdr_info, &l4hdr_info);
 
         len += l;
 
@@ -875,10 +863,19 @@ static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
                                          MULTICAST,
                                          !!is_packet_multicast(frame_buf, l));
 
+        /*
+         * Report no hardware-computed checksum. The IP header's own
+         * checksum was previously (incorrectly) stored here, but the
+         * guest's CHECKSUM_COMPLETE path expects a running checksum over
+         * the L4 payload, not the L3 header checksum -- and it was stored
+         * in host byte order besides. That mismatch was causing the guest
+         * to reject otherwise-valid inbound packets ("hw csum failure" in
+         * dmesg, tied to bcmgenet_rx_poll), breaking DHCP/connectivity
+         * intermittently. Leaving this at 0 makes the guest fall back to
+         * verifying checksums itself in software, which succeeds since the
+         * packet data itself is intact.
+         */
         xmit_status->rx_csum = 0;
-        if (isip4) {
-            xmit_status->rx_csum = ip4hdr_info.ip4_hdr.ip_sum;
-        }
         xmit_status->length_status = desc->length_status;
 
         mem_tx_result = address_space_write(&s->dma_as, dma_buf_addr,
-- 
2.47.1


