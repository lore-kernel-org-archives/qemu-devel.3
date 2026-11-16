Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7F2606A8A3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LqbEwCae
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSued-0003vX-Rz; Mon, 16 Nov 2026 06:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueQ-0003rW-MA
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:32 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueM-0002BB-Mx
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:29 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso3178054f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827604; x=1795432404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5Y4/vqJflN7tAP8idq7EOJGSBtQ7FAx/pao0uWnr4hg=;
 b=LqbEwCaeHzGxl4aszRUeqrS/Eu8exsgnZuF5JV5g8ZSMqQn6GKhZHuTSJC7KEeTNvz
 lbiFaMpWQSHwDqNYxBKozqABBItfAUgW0ERIG6IuMADuVnv1xq01MGmfMUzjQsv9Us9d
 O8ewYglpTn4+v2lL+cJ/PJkX0EgBMTKWX7khXRZsJj3KafZ7/+IsuyEarkW1y+ngPyHf
 ewH9hKL/0BiytyFtBSoGCv1upknFdwD9B9FFV0SnWrFVwkVLzORTRAsBBoOI1+h+LhbB
 K3qADMBChDI1W76dKRxDMSV7HH115CQbKVRI5XnD357rfCygb/scpbjn9JCKcCWje12h
 4b0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827604; x=1795432404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5Y4/vqJflN7tAP8idq7EOJGSBtQ7FAx/pao0uWnr4hg=;
 b=gbvejbBZUx+9DrIUuU42MJR2AUOevs01xA3fq4ixZIl7cxln6upK0WRlMyLPlvdFLy
 PNX1Woqa0b5LIEKD4985gFLTUarIakk1KXVNJ9ZnqSpmd7ko5CNwGOfvUgDCl1i+XZnO
 t+XtVAdHf5iglaJUCE0GHnO1tYZKqhfwjA13rpXx/33UZj/EUmf5cdVW6TbRAC4Jv6Xf
 RqNeju+b1xrMsEVhzzYEBZUQ4Y/tQTrzlETKJ7rtoMGbzOffdnGqo5Fs3hTLf47jbWPx
 iWrhCTVBDXhl9JverpqvXtGvHO9b9yAP2l3O9tXbdIwfy3054FzHzG/34qxM6CSgyRpC
 H6Tg==
X-Gm-Message-State: APuU4Z/izyswPxkwNNqhfM7H/etlmhORcQvTRz2RpFz7302HL8lI6ghG
 AtloLRoZK15DPCsNYWYp1UYdQW7q4DJiQksnqoj6mrt1QMmpIPR9J3Q6nF0gwvd2NDcfn3Gb4zW
 Hd6y5AwM=
X-Gm-Gg: AZFdTZd8Y9Mtj+I1CcPszFwneDrqmag27cgv+hxlT+DrgwUTalzcKNt35Sx+NwQxqUe
 xzacFYdOwDgSCCqwTtJpag2ZT5YvKM0+3oZBKvnsKHhsZq0ds9CKOWWimVavhRUgZsx5uZ9l2n+
 ArWCnbQTZgoMErJYYzqSXbJXBFgTjOuU7knS4kCjIu/sa4gGvYQiEOqNDeTj6hwEJ6sDkeH/Qt9
 mFnKYnVZdVGuBIcLyabF8o09iRaAPEfN3/LgJgE2nIJLStGitaVX0DPBHOnqW9jbPk9WFLVUBKG
 a8dFUoTswKKU9969IyjGQk3lVY5RwA7K23d7yS4PqDIZ0doS7JklA3i1nZ+w6/KjvnM72HWpjBt
 aYDEr4ORZ0PXawk0fYJB4sc+41Ih8il0zY9gt/RI93b9KzhKzx5cDv/6bYYMVmRX2LvRB+bXXDE
 ZX4V/2Hg6klSH5nDJb8tuGz+5OpL4pttSyKYnetA4mwqZM1friuRCbiH/1uOiSQhoXdg00SJ83S
 Quz9y6suMkt0hzjTu9Pp7h/K1ebNPovCF47oY3H4c+rJmKoIaEfCX822qP9k6EgkoKAI3SmCXIO
 /kvNsIlWP33wl2VrJFWYhSuijm1DThB3tn5WVyckYeaOMb5NYsSV3bf2IdC8aCb/VYNzFdtOK1G
 9KzB7aib/qt5fT8ke7QuUQ0cgA07jq0nkew==
X-Received: by 2002:a05:6000:4022:b0:49e:1601:2fb1 with SMTP id
 ffacd0b85a97d-49e1601310bmr14177618f8f.24.1794827604059; 
 Mon, 16 Nov 2026 03:13:24 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/33] net/eth.c: Harden _eth_tcp_has_data() against short
 lengths
Date: Mon, 16 Nov 2026 11:12:47 +0000
Message-ID: <20261116111303.1692832-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-8-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/eth.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 54b0a77fa0a..74a705a2679 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -118,10 +118,20 @@ _eth_tcp_has_data(bool is_ip4,
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


