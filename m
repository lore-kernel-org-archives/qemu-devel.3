Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14B1606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LoKfOwdI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNyUs-00076a-81; Mon, 02 Nov 2026 15:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUO-0006zq-Ap
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:51 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUL-0006jN-Sw
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:43 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so2013827f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 12:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793650720; x=1794255520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JQxHT8XwDw2zxgMzF7vQ8+X3vrqCs1RSuRYRRucS740=;
 b=LoKfOwdImgK0/R95Hn2UXA+aVPuYdDJgJKv03C+yNz1ObzXdma+zGVws9eRNxeiFU3
 sCViWcGSJ6A+ee0KK3oHZ76KTGTYt81hOohP3D6deh5T54vDBMlXHNNzaWQo9OalaEk3
 FbhSJlBS8/ZYZzB/gIzijKV3G646INN1kkU+HeikcMLhEMqbElZKLgCN+AA92J8jRSo8
 77SrEfuJiCd3gfQpXTWLTmPmRLop/B1Nv7e5IiqLqVDu1MEHHN5+K/3r58FB+RHQ3gg2
 k6lfNFpYSDHX3SACyzZzQsgC4p9yhEeD5irWzf+H+G6HauKYwiWvCdPd08VwDBD8Iooz
 JVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793650720; x=1794255520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JQxHT8XwDw2zxgMzF7vQ8+X3vrqCs1RSuRYRRucS740=;
 b=ID85xg1QaRBz/tiq/b9ULhhIJMImS+hbCUaQhAJtFfKod/x4ymRMf43T4S2DYsTzDT
 npTIIuJ0XGCQBNWF/xlWm6Z3p8MJkjRGuxTn7JNlj7H/Zsok1LuG3eXzt86q7K4KTmU/
 Ufyg/o6fFA9S0f6WzTI4Okjb2tZV0MWG5anDoSwhkANQb17qTz1buNewWo0kL3+xF5r/
 +1msU94t/t6fEGlpxiQBGtC559v1vbp4rz5M3KDkVVPB70efTffARcr/cZZoIhY4Uw4j
 tYtL3gz52cEOgDblsz6joR+uArQqRmH36fIwv95qtOv7T36F+Aa31b1zWT5mxeYUVuQ8
 nd8w==
X-Gm-Message-State: APuU4Z8fV0mtqJdxhrjgfbCI25p3vBnRQfk5KZ3Lyi+1spvAS3J/Ckjr
 ulEYWYDC7pDmWUtxssXoxbt+Trzz6hrWMAOO79EdCwa3IRfgdN1VGKyWha5jt/oEO1VFLbWrK3B
 wXaSYhyw=
X-Gm-Gg: AYBFou0fnuM+8581fr9B36Taq0yWl04x2gORIX2mbBroUc0Q5og/l2rcgiWB1dT4966
 TblFsAolIja8oac42V9BjIZnBqiVMaaUszS2FStB8s/rGUuftjxfit+OyE61u+U1wge/0raNwLw
 jteE0Y0r5j7GqpfN/Co5Ag8ZEco/NMP16KS52UPmFh7G/BsQG3PPDA1pNXrE23/+wPxUmqEqtd+
 TTylHGFwq6CThvW2e6PaKPF+ciun+KIHq/4fPImeO/gWBdbcRGPBKA2UO3gMyGiCHTFtm+j9bV9
 Z9JA3VVeyOcTihAqEEzDG/VLD5CP1AHqg2F9gABULgTJnPuDWtSrsSweUGONhZUURHtOorUqS4V
 QRVkI+6Wq5GYhYNztHULWlWL5/omCIfsQclXkohWrHmHU8Z702AoEjxnLG0WT8ITmi72ECwtOB/
 ndScOn9PERpvgbQEdov+BABxRyKqWNKMnT73QeZRo4XxoYrGQoXBP/TN5QIXWURYX2WNw0vPq16
 0ma05dAgkod8de1LIScPA3sZaxXj60DYiH03Md4TmZdak4rMz8Ac7Dguuy8xCcrRjujc0C9pgOe
 4RpoKeLio3ojaALzOG5ar40Wsylxad7w+FyhW3xX0b7LbLqg0flGdSxPLUI/oMOKgkpq6DCTnSB
 5PiqUquz3frj4PzZwIL+mRFByiWUFOr2j82kg2IEK6vrYL6jRJFdjJLg=
X-Received: by 2002:a05:6000:1aca:b0:48c:7037:aee9 with SMTP id
 ffacd0b85a97d-48e6e4fcfacmr24701591f8f.50.1793650720456; 
 Mon, 02 Nov 2026 12:18:40 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm22152836f8f.30.2026.11.02.12.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 12:18:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH 08/11] hw/net/net_tx_pkt: Sanity check GSO headers in
 net_tx_pkt_build_vheader()
Date: Mon,  2 Nov 2026 20:18:25 +0000
Message-ID: <20261102201828.1879576-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102201828.1879576-1-peter.maydell@linaro.org>
References: <20261102201828.1879576-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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


