Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E655E606BE2D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CouZtney
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSuec-0003uu-T3; Mon, 16 Nov 2026 06:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueI-0003qB-Fe
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:24 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueE-00028p-B2
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:21 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-49134c8509fso3274508f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827596; x=1795432396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gNUPkpbDXQCDBt3QEsN8Lb8ogQufVlkJZMGSxDNGCaw=;
 b=CouZtneyNMtccaoXudVmuJc8T9N5RdpsQMjHeAzTQWO0wkVKw5vMtIMPp4y6FWKhEc
 ZRBHtNaUoSK6vXYsbirSJsShbaUIyYM2sRUpqCd8jhI0pnnXMJg2A+EOrwtwS1gAD6J6
 maLR2Ohzg6ouhCGMkcKOqYp86Kuicf54TQw4cwVLxaft6JE7sStxEHcM8rz3upgtZKX1
 WKNumYRe4w50jgbCVLvPrIR2GbxfB4Vs23yrDq5tZt2c6MNxJ/BGywn9Cw+r5hFR3BpU
 45r1fnF3L+p0iX7cjpQ3VBzaepkgWIEVL4hRA/GX9PmZMIOCGgWhU4e1qMzIyYxKQ1yL
 dSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827596; x=1795432396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gNUPkpbDXQCDBt3QEsN8Lb8ogQufVlkJZMGSxDNGCaw=;
 b=fAWdE3v8oI50QjxGd4pyNYcJYM+6Ixk42Bz/J3ojhwSaCtO4cJtAK21HYK//je8qP7
 NX87TtrPQK0ZqBKU3IzaNxXr6XHHsjPidPWQNDTP5HYpk+5j37rWuhlKnhCCsk1DT4xn
 vWVRdSLpyFeSQK3Cn0JRs3mOs9GhoofWOaa1RwamWgq4E/kXP0RpkmuXuIJ0+k1MRqBB
 S6UvFuem38g/x3Hw/pcA9o4jSMECuI+eJiXCT+TTVUOiYWX/t3WOQra2zvk1MzQHZMxe
 fHxiZjrKxFHKHCpr/kEYe7tqBB+jR32gDumyFw343S7jZPzZK8+8IjZLLd6GiYlTpQzn
 XXvw==
X-Gm-Message-State: APuU4Z9REQuvg2LUaAQazPMwBbfPdzDMLYcxKdNQmgNvTcEr3dZGHfjN
 l9n/H7wu1CP74xKuBEnFsVY6xQMlXpIyCkpzbcBIrodQAzzK+dm4kyXCJgSESbhUfsBIyzdfKun
 biyRE6kc=
X-Gm-Gg: AZFdTZcx4HNLinHpqbkZyWk+qvAz+e0Lw51XMX6jXtyo7fxrS4QBWeHan0cTQ4jrRuJ
 5vDRU/Tr9hHYcGtn4120EF7Np8gCEOxKGJPVq3zL676e/45IxFVBGjvUPIDX9CEUnAT5Onkg+Fb
 iQAPB0qUXNnFoTF1Y2OgztFNi6drPp9Rw1t7KUN2IbXSBGTufgLdO/+HyTSCWkEwnxE4hJoHSV3
 DU+XM4yDfFEXFSTI54144+o66Z4C/LPG+pO1faOMnx3VmgDB5QVqGsimx2hi9v8Mf+sV3zmGaxA
 crrL4Fr6S0tTm1IdA/veSmQg30B+bmJvE4rlBK8qlASGsMWnpBsE2yT/SfaFwsQY1W/qV3Xxanv
 d+0AOyOnFkmwT93siWmC1f6QPCp+ZBgAKF6jrdPX/dIoA1fGpd4xSSY7LTTZoMJVpUyZRYhgCvo
 4G+uswfy/OnOe/jmjfq9UWcFjjh9Wd0zosE6TnQqt678GSrjAUBKacUhdM9fnG3la78TBf2yrrC
 vPpLreXHHnvq5eeIYE0iJS77geK7V9e0GPkYu5+uqGQPEBtSY7JYNsR+TIks8/Q1BCdqzBcoIhq
 RI5xuEgKuTwKM/XNlj9rpYPEHTDkInCCJgwQTgBI5Xxl+cCu0LsYnT9dOZSfBWBsmyWN/2sr8wv
 RazyDAw+jQWBCdySQg8Q1JODRmfQ23dTc9g==
X-Received: by 2002:a05:6000:29d9:b0:498:b92a:30b with SMTP id
 ffacd0b85a97d-49c70ed7d88mr14144803f8f.15.1794827596569; 
 Mon, 16 Nov 2026 03:13:16 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/33] net/eth.c: Check for undersized L2 headers in
 eth_get_protocols()
Date: Mon, 16 Nov 2026 11:12:41 +0000
Message-ID: <20261116111303.1692832-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

We already have some header bounds checks. Add a missing check for
L2 headers.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261109-eth-v2-2-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/eth.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 12ec316e240..59b278b887c 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -139,21 +139,28 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
     bool fragment = false;
     size_t input_size = iov_size(iov, iovcnt);
     size_t copied;
+    uint32_t hdr_size;
     uint8_t ip_p;
 
     *hasip4 = *hasip6 = false;
-    *l3hdr_off = iovoff + eth_get_l2_hdr_length_iov(iov, iovcnt, iovoff);
     l4hdr_info->proto = ETH_L4_HDR_PROTO_INVALID;
 
+    if (input_size < iovoff) {
+        return;
+    }
+
+    hdr_size = eth_get_l2_hdr_length_iov(iov, iovcnt, iovoff);
+    if (input_size - iovoff < hdr_size) {
+        return;
+    }
+
+    *l3hdr_off = iovoff + hdr_size;
+
     proto = eth_get_l3_proto(iov, iovcnt, *l3hdr_off);
 
     if (proto == ETH_P_IP) {
         struct ip_header *iphdr = &ip4hdr_info->ip4_hdr;
 
-        if (input_size < *l3hdr_off) {
-            return;
-        }
-
         copied = iov_to_buf(iov, iovcnt, *l3hdr_off, iphdr, sizeof(*iphdr));
         if (copied < sizeof(*iphdr) ||
             IP_HEADER_VERSION(iphdr) != IP_HEADER_VERSION_4) {
-- 
2.43.0


