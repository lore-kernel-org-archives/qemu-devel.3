Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F4606A330
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VRFPpCOq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSuef-0003wD-Nb; Mon, 16 Nov 2026 06:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueU-0003sA-Pj
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:36 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueQ-0002Bg-31
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:32 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso34867535e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827607; x=1795432407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MMRHoVzzc0EDS3fwZLo7PKSoGIS2Ack5SdX/7J5QnFw=;
 b=VRFPpCOqaD5DaJ7PMV4tEzc882kDp8jPwhZsHEI3cMZamAbaDy8ILueRRqZgSROei2
 RWAydRjxfLspQHqaagGN0MkZvs6A/nA0xu9z3yhg2FPHBUgKOe/9ew1P7+2AFAG7CDmJ
 IQ4VHRveVkeubxBBS9i5wQDO4B/6gQdeTd8k2TweVWQpDRj6ATnJi0UAyYiCfYAh2Xci
 RnXImj2OG4qjYa8bUCKcRbJSvqsVqhYwiG5RE6xqeHIh2frV08lQ9GCQEaMxU3UFsPGb
 fTm4nu5xPx75LLuoeSkmf96zZGBu3hBKH/y4vtGSHZyyHYRUEV+xoNIz0TbY4KfdlyIO
 ikvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827607; x=1795432407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MMRHoVzzc0EDS3fwZLo7PKSoGIS2Ack5SdX/7J5QnFw=;
 b=kwpoOb3RTnIevUcujSjbzOxNmrUJx6kJguBVW2xBpJtcDvIMyiq24x5wJhFozr2UfQ
 F+3souEW9fuYjuCyS1CX/5PCsNWdMz4mlIGPoqU0kjymJ+JKG6I+CM6DkMGY9RiECFZ4
 nxfmhcKqSYphujdcaPijjaKE/Exkfps4xzSEvmXeCXhH2Ih5QEZgNf4aY3zCn1ImvqJc
 uAZQjg2dUeAd9B7/Fpwo2IE15CZI2FcWw8qVNv5XzV4y4A93J09zYk17OVTFv4Zrn9Tx
 dCf6RTSO1xLbGk/sD9HjUclRG0JuFcw8N682i/sbUpfwuklLeBpS/GTHACMyhg+yG8cW
 19ZA==
X-Gm-Message-State: APuU4Z8bcaHN5k/23X6afv1PH6/2Jc9PV32dl//RvNOQJZKIo3Tg97HE
 Rz0QUsVWEHur0IwwaxnhUlupof3JhLc58BLiCehH9ysOFjst2njWmVnzLGmAc51HwO/w4hbB2so
 tNcFWZCc=
X-Gm-Gg: AYBFou0SptXzXTNZcljnsyRgdW1NnO8yCI7WJzIVBhoDWPHSZrkDDDun1vLH6xLq3BF
 JuVEnEr/VDqolEVjXDPn/iH2Mz1XWM8oGb1VNX8L7R1tTQN+M8CstVg5r9eWI/vx6faayx/dQS9
 0LzSDkLANV7nnysm6Eh3bWM3qVo6elxB3QjVu8lz4p1cVAF82bBcT73droNofF13dei0UCLPC/0
 VJ4X65jeLhGVqai4+BQ+ptbsymlAsH2EqMV1h5JAj3QsQw9teHI7d37PNtqbC2P0XOG6Ev+tSdA
 RNrAasXpid2oEW8A/ZDVBMkg9pFtdWdFeyavEpLrzNzH+XOjmUju4HYSg45D9V7sib4EdeIJFlN
 rb7+quKA8QE4iT6mVfJTm7uOeLSVd83I6wdVSwFZDBUI6repNW8aUWoH/9nSP5+tXVVFipmK/Df
 yatuyOL3Dok5ldpaWTiq89HPF0MgniKSHW6DYAM+JYkG2LRvU3iGL2C44bHUuTQZjrbNHhO0Cb9
 iPk3HHYSMsq73pFkYA9DhWoc/hHr9pl+rxlixK0aFltQ2lJ9ASvShrMEk/XyeSKKtKXjcu79EW7
 sYSrU/Ikc6FHo4xVWDJTCtnDAq3S5cfsdDFtafUz0Qmf2h5dqp/5BmY550KlRIPPAebgFOKwL85
 NXaU+dicOWiG39/m5NOqUpcUgZAS7UfHZWg==
X-Received: by 2002:a05:600c:37cf:b0:4b2:2ec5:8a2b with SMTP id
 5b1f17b1804b1-4bb55a4301emr218097165e9.10.1794827607242; 
 Mon, 16 Nov 2026 03:13:27 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/33] hw/net/net_tx_pkt: Sanity check GSO headers in
 net_tx_pkt_build_vheader()
Date: Mon, 16 Nov 2026 11:12:50 +0000
Message-ID: <20261116111303.1692832-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In net_tx_pkt_build_vheader(), we are insufficiently cautious
about headers from the packet from the guest. Add more checking:
 * that the segment offload payload gso_size isn't 0
 * that the packet is not too small
 * that the TCP th_off is inside the payload
 * that we aren't going to overflow in our header length calculation

Of these, the most significant extra check is in calculation of the
virt_hdr length.  We calculate this with
 pkt->virt_hdr.hdr_len = pkt->hdr_len + l4hdr.th_off * sizeof(uint32_t);

The struct field is 16 bits, and so this can overflow if the guest
hands us a packet of close to 64K in size and an appropriate
l4hdr.th_off. The effect is that we record a bogus virt_hdr.hdr_len,
and later on in net_tx_pkt_tcp_fragment_init() this will cause us
to make a very large allocation that causes g_malloc() to abort.

This is a hardening issue rather than a security issue, because the
amount of guest control over the allocation size is such that it can
only generate allocations very close to SIZE_MAX which always make
g_malloc() abort, and so it's a guest self-denial-of-service only.

Cc: qemu-stable@nongnu.org
Fixes: e263cd49c73c595 ("Packet abstraction for VMWARE network devices")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3648
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-11-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/net_tx_pkt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index b134348fe80..b2935900fe7 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -335,6 +335,11 @@ bool net_tx_pkt_build_vheader(struct NetTxPkt *pkt, bool tso_enable,
         break;
 
     case VIRTIO_NET_HDR_GSO_UDP:
+        if (IP_FRAG_ALIGN_SIZE(gso_size) == 0 ||
+            pkt->payload_len < sizeof(struct udp_header) ||
+            pkt->hdr_len + sizeof(struct udp_header) > UINT16_MAX) {
+            return false;
+        }
         pkt->virt_hdr.gso_size = gso_size;
         pkt->virt_hdr.hdr_len = pkt->hdr_len + sizeof(struct udp_header);
         break;
@@ -344,7 +349,10 @@ bool net_tx_pkt_build_vheader(struct NetTxPkt *pkt, bool tso_enable,
         bytes_read = iov_to_buf(&pkt->vec[NET_TX_PKT_PL_START_FRAG],
                                 pkt->payload_frags, 0, &l4hdr, sizeof(l4hdr));
         if (bytes_read < sizeof(l4hdr) ||
-            l4hdr.th_off * sizeof(uint32_t) < sizeof(l4hdr)) {
+            gso_size == 0 ||
+            l4hdr.th_off * sizeof(uint32_t) < sizeof(l4hdr) ||
+            l4hdr.th_off * sizeof(uint32_t) > pkt->payload_len ||
+            pkt->hdr_len + l4hdr.th_off * sizeof(uint32_t) > UINT16_MAX) {
             return false;
         }
 
-- 
2.43.0


