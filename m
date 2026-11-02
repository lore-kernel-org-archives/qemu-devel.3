Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C1606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sbLsISTk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNyWr-0000cW-Se; Mon, 02 Nov 2026 15:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUR-000703-AZ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:51 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUP-0006kG-GZ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:46 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so2032287f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 12:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793650724; x=1794255524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ESBM2k8065RGhx8nl7Bk7sbL5CPU/3J5jANQgKuufpU=;
 b=sbLsISTk41dDfpFkdFVTEpKtCseu59smAi80L1HpVef2XfHBaqtkot7bqOzqLWGd1A
 9i5C2TW08wL9jatHLSl35Rs45ClsZoxVnBOHLyQBTRqckOa/NqNgyW05cVUUYzlhAO/n
 Lq9RyjHs8q16EbycfiQfbaJJ5Csju5IzV/2dLbX3DQCiO3hZnnaSV2XN/o2IUy7SiIHX
 3JLA3RuMdqWKwmUF7I+lcAXYlRfdK+G/ZQ6ls6FRkPK6ga5kTA3sSTJ517/+E5oNATRV
 KCWgHAeHN5Tg+ZmILKJ11kzHJr8/9AUULm9iPetL5D+Ym8LKHCF6c7Sj9kd0yFNCR/Bf
 X27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793650724; x=1794255524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ESBM2k8065RGhx8nl7Bk7sbL5CPU/3J5jANQgKuufpU=;
 b=nmIQpFatz7wL1m4quvPHV2FJ6EFVbZrdK6HCaFeF0/70VCJH5diTyDYZ752cyPghRx
 O1sNKJtUGMpEg+/+410YKpyBP/MRUVGuKH6ljNGezeM+2TBw6y899RFI7YYrbiLk7a2v
 MKAW6D7fUViM5KgjjIH7KbD7/C/LI2Vv0aF7r4skO9QiVp1G+hDBTIaZTZWeK1mz4wgl
 GX5sF5NzWmxcQkvGx3EZ3VJ+jySdpYgks2cV5BjoU3xNC9piF0LJfiwEOjvoxzIinSDJ
 +hOyfMX84Id9af2NpXPuP5YrAvtYbUcC9s8VkkmK11VxOX7gGrmdV96NhHox84pK6Euv
 ZB5g==
X-Gm-Message-State: APuU4Z/gsN/OL/OV3LTB7S4EuIlbnkqgSZUQNIeXl7eu5x9/1uDcPlSF
 z9zphvpcivyQsMA3AzrqQVSLR6GQ+CMT28zvKcbU4GxTIsKjfeeJFgz0V01ZZDvDm/UirlNb4YK
 aME4eNP4=
X-Gm-Gg: AYBFou0Ev9XOyJIg3iX2ZMgd41L5HbYM4Az6xenHmEGr/19OrF3Ln7oDrl39pRmC3c6
 G26ZJpjVqBFpfxRIP4Ycwrc3QtYdrQuhzLBWZ97w7YwHHTKyKuFF4ROIYaVbEILh9ZjIy64qslE
 h2kpMydP8kpEk0xDXtQBWj+Bd++7dD9vzKsvXnnyGotPDZUOuR9JtWbHv5NH49HlunvOBIgfnMl
 3ZtW95kCGS1XGh8k2lamp2ozpo+P0tYm48oZC7JXc9kNMPNL+mDB5qiU2Sbhycrg5kVHLRRXyKZ
 g0VRLsygk8bkEeqBd4lHo1BS1raM4c9yQZoBjpjY+6tSoRXuLeNoWn4zCtZveqS/KK/biLMwrdh
 wsAwqZ12gLkh4SSX+R9Y3FpNQS3JxYszEaZP/SeQX9QwK9r6UuPpzXzTCAqHZESUJSxrG/2C4R4
 0LCX3cwNlSIAXaoezVhFYiFZfywVKRKLWCYv8Os2f4edcIE7J1oU6HiYgXaCkdHoAmxBhz6jBwA
 D1oLMWPkzS2agMbXgnSecqmaNIiJ7HQBeeSvyGb10wZIWR8kVZhA6S+1COMBBL8MHRKaWjxyQDE
 IvrBOhoHTqWcu3k4+FDtNXIEh0AYMViHFH7sVyOAAXFscqGXpFxHgDO4NoZioQKN0Z0WMuZFNbB
 PLB6269n9ZFawXrUvve9qtIW8RY7Ie5Mk7w==
X-Received: by 2002:a05:6000:250a:b0:48d:b650:69aa with SMTP id
 ffacd0b85a97d-48e6e309fb9mr24441735f8f.50.1793650724181; 
 Mon, 02 Nov 2026 12:18:44 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm22152836f8f.30.2026.11.02.12.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 12:18:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH 11/11] hw/net/net_rx_pkt: Check for overflow in
 _net_rx_pkt_calc_l4_csum()
Date: Mon,  2 Nov 2026 20:18:28 +0000
Message-ID: <20261102201828.1879576-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102201828.1879576-1-peter.maydell@linaro.org>
References: <20261102201828.1879576-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

In _net_rx_pkt_calc_l4_csum() we calculate the number of bytes to run
the checksum over by subtracting the IP header length from the total
IP packet size.  This shouldn't underflow if other parts of the code
have been correctly checking and calculating sizes and offsets, but
for defence in depth check here, and don't checksum any bytes if we
would otherwise underflow.

Cc: qemu-stable@nongnu.org
Fixes: eb700029c783 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/net_rx_pkt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 03a35f03154..110496e9c81 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -501,8 +501,10 @@ _net_rx_pkt_calc_l4_csum(struct NetRxPkt *pkt)
             csl = be16_to_cpu(pkt->l4hdr_info.hdr.udp.uh_ulen);
             trace_net_rx_pkt_l4_csum_calc_ip4_udp();
         } else {
-            csl = be16_to_cpu(pkt->ip4hdr_info.ip4_hdr.ip_len) -
-                  IP_HDR_GET_LEN(&pkt->ip4hdr_info.ip4_hdr);
+            uint16_t iplen = be16_to_cpu(pkt->ip4hdr_info.ip4_hdr.ip_len);
+            uint16_t iphdr_len = IP_HDR_GET_LEN(&pkt->ip4hdr_info.ip4_hdr);
+
+            csl = (iplen >= iphdr_len) ? (iplen - iphdr_len) : 0;
             trace_net_rx_pkt_l4_csum_calc_ip4_tcp();
         }
 
@@ -517,9 +519,9 @@ _net_rx_pkt_calc_l4_csum(struct NetRxPkt *pkt)
             struct ip6_header *ip6hdr = &pkt->ip6hdr_info.ip6_hdr;
             size_t full_ip6hdr_len = pkt->l4hdr_off - pkt->l3hdr_off;
             size_t ip6opts_len = full_ip6hdr_len - sizeof(struct ip6_header);
+            uint16_t plen = be16_to_cpu(ip6hdr->ip6_ctlun.ip6_un1.ip6_un1_plen);
 
-            csl = be16_to_cpu(ip6hdr->ip6_ctlun.ip6_un1.ip6_un1_plen) -
-                  ip6opts_len;
+            csl = (plen >= ip6opts_len) ? (plen - ip6opts_len) : 0;
             trace_net_rx_pkt_l4_csum_calc_ip6_tcp();
         }
 
-- 
2.43.0


