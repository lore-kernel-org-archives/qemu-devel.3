Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D169606D7BF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XSbQ1c3N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSueg-0003wG-0H; Mon, 16 Nov 2026 06:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueU-0003s7-OZ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:36 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueS-0002CH-Ek
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:34 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so3508419f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827610; x=1795432410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mcnGsYx296n1KwArJiNQTyaA32M8m7TVAvnpqGuU26Q=;
 b=XSbQ1c3NYpvyu6yLfNLos72MfYcVeQlNT71pUzI2HJfSkcLbdmB3rZPSPfT4kod71s
 kPBg9xrAjVpZ98ka09b3Ztr7XRr/mXdSBZRyV9MMedOTIRO8N/vv5/1DHZGklmZfFnvI
 Nf+wz7z6sDTrlIgmH7GJqui2k/JDDgLZFypQfXPGyyFFxdcov4ceQxIpS8QNzaQgrpbH
 3kTz9LuWxcy64uBud2annOA1PFctjv2Wslt7eDOrf5zDiNk9WGrd7SI9aU3SI1iSNpvA
 9olBkjfdtfyqUi6SBHxBTq0ez4Ff/6stPESY4ZW2wdGb5vYB1Wjywv07hG80ChqJn1YQ
 RC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827610; x=1795432410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mcnGsYx296n1KwArJiNQTyaA32M8m7TVAvnpqGuU26Q=;
 b=i38WUHJMud2dkqSWgE6ZuVsav0QPO+aTAt40Tx9rrZIbrKQXdp+sA+hldP7nUscN45
 eSANTRHbRtFkxuqv9oWzZDo7QGccivsMA1Qxulb204EskMknKSvkyD+uLuYxbPim8xJT
 oWMnFaoNirJjZSuXxrGIVB3Ui9gPzeqQLsvVQKclHcj2Xk8s5y4TQ+kCowL1QBBILK9c
 pYvGZ5d6JIvBV0P3hIpHWaHmEigYrExBLLckhb6uCXdz/Gc/mpT8eqkd1NnvjeqKl73T
 CyBN1l525ezcufxZr9VqpqqZ2O0MTeeoUZzw8dAt4HBFnP2Mnb+MWJl6JrgwjVLgDB1X
 z69A==
X-Gm-Message-State: APuU4Z9eQmkVuWmkc7lXm+tS8n3VJh6AGYnrWN7SQcfWr72dw+7zfhOA
 VNmaykWl2bkaw593PBTOzTH/b2t3/bMHfJuGCaliwu1sERumOCbyLRoHBqL/D+4AW32o6V2aiiT
 O+tOJfDo=
X-Gm-Gg: AZFdTZeW19IjKnqg8MHmmtL1QxqjpQYJXxIqawYdZtDYKqFo4IJPRhyfoBo9nmMJn8A
 qnQww7QJGc6roktfi2k5GxfgwQgmhSBQ60PNqQqV8H0xPzBrJHonoi00tdLGw/RnUs2OVICI+4m
 s2RdUXOpEM+rhaX5Ym9rzga5RJQGbvllQuEbcWUbBlGKD9hpcbyMM1CJR4TySvoQRxW7Ox4jdEZ
 l/JsolnLsdFjinRAo7rBafXjMOm6030FjEfS3somDQNdOaUWu1WqqsqtX+cezLGnho4lvhIA66m
 Ii4qvhIfCVY2BgstHceaNtPa0CjscNANKh5SHD0kuGPOXrRE2r9VS88iEJyAUrYPqIXscFnLKs3
 XEpy8b7sRrQpUgBf2URuVtUMbkRt+sUr6OqNNLifPKxqbhhzBi24Otzx6Rc1mPoMI7FWe9JUyb5
 iRC74xu+9kcngnXMOWiVkrbKo0wdFm8dhwdkc4aYKGSPM22W0f5OqmgAufOHW8ccar37SaW/+91
 5b0ZNZ9Vx7JDeupIQFOEitUtjY1EyYTxNj9F3MpTK43H/1wOI7fzvcpSjFtg+M7TsErk5uPF5Nm
 73OdXMUh+puvOY9i+OZyDLpNiRgLYeLhi3DllOtDbJIVmOWHvFSalmRKVFWzi++ik2P5DLjsd+p
 iH61mhUCtr3jdfkmtR503UVbK/XeD7RQt7g==
X-Received: by 2002:adf:e00e:0:20b0:490:1881:80ec with SMTP id
 ffacd0b85a97d-49c710c24f8mr15815630f8f.36.1794827610272; 
 Mon, 16 Nov 2026 03:13:30 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/33] hw/net/net_rx_pkt: Check for overflow in
 _net_rx_pkt_calc_l4_csum()
Date: Mon, 16 Nov 2026 11:12:53 +0000
Message-ID: <20261116111303.1692832-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-14-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
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


