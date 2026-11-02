Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC69606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RGtYLXNJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNyWe-00007j-84; Mon, 02 Nov 2026 15:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUK-0006zD-LD
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:42 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUI-0006il-Dv
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:40 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so27851795e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 12:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793650717; x=1794255517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MSHn6yE/T+6ZdS+CvwhmLlPfnMRXY7q3UBT+geptnSA=;
 b=RGtYLXNJxIP25idUOW4AOZ9sp6ixFpSHO9/y7956TtuTsgYAYsYWSfxf4J9ZiZ5mB1
 NfIXPT3jYwAX+woKmfaH8HiqBCSRf+qHqYJGX2xO2X2567/Rso9UgYbp1Wx3ZUmjtJ0f
 Zj/I0xG5SDnFqylFZga+C561PxUiLbU+UZGr9KPfOJB257spw5JBAK/DVsiDNbgi0ll3
 DECzraC8KDtQwiZ8ljh4TMRHnXTPjOHDtWQsMdla6fwYvgRxsvV9dCPKvdYi5jYAxMzZ
 G3yuzq+tHF8wZUS2O7l4yJvdYG43ZTLq9MxA6V4hnT4KdZO4NRfROD/rMkufUIk6i1h2
 mj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793650717; x=1794255517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MSHn6yE/T+6ZdS+CvwhmLlPfnMRXY7q3UBT+geptnSA=;
 b=XcXlIHHhoOFt+UEp8MNYKancCUiwjcDD5vk6pytonVtxhFCAQqtxtSW7MrVwwAp5KD
 WywrzOq3xmJU2+5MoJbdkktzZLAWTxoB0H36axVIdiBgtQ0DB8YOx8OLL3mdvBtZrjqg
 +YIq6BAuHkJzC2f4EzswdrmQSgd2n/oEE2zUeby2H/uvly1fA8ClkcQPo0qZFfhVG0T/
 IypGcqHFyZQgmzHnO+c/rYpUrA/EF9u96KUYX36vtA7tZU7LjMtOdwrql5pp74BRn5uM
 Uzmg6iT44e0FV0jvh4lWVq6r1aYcqk4c2ncMJKN/IPHdmXHpzUxN7R0G3jI99VeN6kJW
 7YvA==
X-Gm-Message-State: APuU4Z8wW+a29n6RvNMDyprMZkIRJ+5vUtfEiztw4ZlMOrq8g+2b3FOT
 x33Hjux15h3MQZ9kNWTPE40A8JAU0RlcIK1rLdZ9wWEWHg7Cz5N9QeFltftM7Q8A/bERhMXmnMR
 /TIFULy0=
X-Gm-Gg: AYBFou1evveCD5sscCmc1/9F3IFBaNype+iw9bAy58YzkgdFCumi1dZ8057m1aPymoq
 H2xYMr8HZrBhII5BgZ13oCYwtT4Pj5Fu0ft6FHhKw+xlTI0nJpDErUtOBjA1Vc6QW8EFcxQSwEd
 j+dbwhAETaVg/BriHBdargtfGMi30aQ7KThOs1caqqKMUEE1izA4EIlyzgUDbIQGLJzmWaGvKY+
 NFxaneyhSycablYlh+INuox5+nDuTX3IMTbV2dh0c0YaQ5sKMyGbMlFAfogmkFQSVT0hbSZjmSb
 kOlrDD3DKIeae9Be2p9M5FGG0/Yb5UK4LmWJq3Latj94c80kezHUOVzwkG+ceCZ3AvRNfEOw8lv
 8OMbRkp9ePiGNBxX1OfnHavyxO7jUnZlGWwEsp849LlaKBJOCnVQCH7ny1fa7jP2kJnI3S3Ycwn
 8i8cvsJUnDGVoeOBO/CI4g4sJKKHfd81iTNmcTfdw4ZvI/VOjiz7bcmqtNegwjfUh5lhcr5eRF+
 TDUnxLKCBbWpQbsIBRcORG1nyWYye+gSRLQoxfu7LroSMVvFeZowMd2SLbwUHZr3E/K9+gSPEB0
 YcVwhBNZDUkluHjAPB5bjFqdLJpgS2xkXM2QC0wZ8y4UzsnG85/JMoONw6ejQ1ZBPQDUmUCJAQr
 AIQYgYwC641g8HLETReNvhX+qsLjdIKNqFQ==
X-Received: by 2002:a5d:5f07:0:b0:48c:7caa:12cd with SMTP id
 ffacd0b85a97d-48e6e4faddbmr25942077f8f.22.1793650716689; 
 Mon, 02 Nov 2026 12:18:36 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm22152836f8f.30.2026.11.02.12.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 12:18:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH 05/11] net/eth.c: Harden _eth_tcp_has_data() against short
 lengths
Date: Mon,  2 Nov 2026 20:18:22 +0000
Message-ID: <20261102201828.1879576-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102201828.1879576-1-peter.maydell@linaro.org>
References: <20261102201828.1879576-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

In _eth_tcp_has_data() we calculate the length of the rest of the
packet after the ipv4 header by subtracting the header offset from
the packet length.  If this subtraction underflows we'll return the
wrong answer. This shouldn't cause any problems if other layers of
the code are checking lengths and offsets, but defence-in-depth
suggests doing a checked-subtraction and returning "has no data"
if the subtraction underflows.

Cc: qemu-stable@nongnu.org
Fixes: eb700029c783 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/eth.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index e2c1e08ed28..955f2bff5e6 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -117,10 +117,20 @@ _eth_tcp_has_data(bool is_ip4,
     uint32_t l4len;
 
     if (is_ip4) {
-        l4len = be16_to_cpu(ip4_hdr->ip_len) - IP_HDR_GET_LEN(ip4_hdr);
+        if (usub32_overflow(be16_to_cpu(ip4_hdr->ip_len),
+                            IP_HDR_GET_LEN(ip4_hdr), &l4len)) {
+            /* packet too short for claimed IP header: no data */
+            return false;
+        }
     } else {
         size_t opts_len = full_ip6hdr_len - sizeof(struct ip6_header);
-        l4len = be16_to_cpu(ip6_hdr->ip6_ctlun.ip6_un1.ip6_un1_plen) - opts_len;
+        uint64_t l4len_64;
+        if (usub64_overflow(be16_to_cpu(ip6_hdr->ip6_ctlun.ip6_un1.ip6_un1_plen),
+                            opts_len, &l4len_64)) {
+            /* packet too short for claimed IP header: no data */
+            return false;
+        }
+        l4len = l4len_64;
     }
 
     return l4len > TCP_HEADER_DATA_OFFSET(tcp);
-- 
2.43.0


