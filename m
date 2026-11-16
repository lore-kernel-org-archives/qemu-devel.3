Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4D606BD35
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gwN75Gwc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSufF-00046Q-NF; Mon, 16 Nov 2026 06:14:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueS-0003rs-Mz
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:34 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueO-0002Ba-HZ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:31 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1791204f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827606; x=1795432406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HEFF52zQcGWzOKUVmjH4myjX8doFqqSzEqp+wmFiVeE=;
 b=gwN75Gwc/mWbnqwDoTitrUYVswGDdiEC06cYQA7ronwDdPe+UfwjqmloOJqEvozKJ/
 NaGsu3OAjtf50fWhce4PM8iH21r1X2OwC5Px5SXftSQlhAaLjdB78VL79Ce+qWByDM0t
 iiN8DG6E5sB2wYbBdlBCWZm3WEjQUvMIVgt9YhDML0K6so4gTgq/9SxjjI6S1mzPjTja
 JGfcWg8b20BD85CEpSldvojgV6K4IysVwU8ht+JtVAoX/jG1iC+NQNXpMEzGaXfqlHUN
 nQIXviFaoi6ag3Id9w/XgDhaJa9vM7eMipmzR4w1A8WwejBuEo0Q1oKHY68pydpQKXRO
 kneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827606; x=1795432406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HEFF52zQcGWzOKUVmjH4myjX8doFqqSzEqp+wmFiVeE=;
 b=qhZvaIv9rPVqpVd6MdOkHVizfELxdMN4ANn4b6y4C5NHqVaEkEcVQHfq/xiYdRjZ+3
 peb9+X+DH+7nz4htYwH2IiUXMV5V3/ZFYgIlra4m5A2NP1JiZaNQDV0irIKvFkTFxko2
 oRwY85KvwUN8vOP7aYF2uA5n6Jx1P/l3iarsrUCzAl2hl/uGedXv0y98FMzfldmYJu2d
 556Z+7b0np68HsYZHUbXl52uMliFlAVYvvYGfTb0mxwArK+72uEHMesMsZjAhbDetJB8
 Ohd2CRmMfRV/vh/fO+Rgk5fVkykqI8OFShyE6POalBYAEwJAy6rR6BEQnAM7vnoS8X6T
 j+lQ==
X-Gm-Message-State: APuU4Z80pNd+9YgRiHS6Fnks7niz45OhXFFkZsDIDFNBUoLKVxOFEj1N
 9OFd6qRJD4f4w62D8IdcIRwUmolfZC7Qea1+B0DAb5aq+woym1WpzyyvRd5oy17RndiEtv8MCqc
 9CVkAklE=
X-Gm-Gg: AZFdTZciFHxQ06wfqmzpYkPeSdCgyuBlZDgZJMIipVuO3rsv66lJaNo54+abgo9Bkg8
 kwxPMqF2yflVDYYGPXvJBomSsw9VL+gF4k6pvbtN2qS8Zfxa6Fxr+MD4kWpEx5HyZ4S7sj14v3C
 AQBDkMMi1R6OxA5mG1YVey6uup5+SXze8BQfd8OvyonxB0vN7acUNk/WGXI3F+LZ4UeGzVIwf5F
 D/tcQ7EAT9RmRzJbRDO76WUl6o0yAz8J25RjtmHpbPJd3Jsy3nSeFcOA5AkUyHiX3Hg1cXTufbm
 HSFfJdwDfcXvXTPskrxgAfHM8yKBSvRnP5A9BWYWdZxktTYlD5vwogEhaC09ODmAk37PX4lrMtJ
 cH91HsEzMC0fhUxqhT7kiUqhsR77hEc9fVlYMmA38hspQ+CO6Nr8gtN9+xB2tUcVZaE3PJgetLH
 6W5UBNWLrxwM6faLLumadCugciwOVhXgVCWE+fWpdR9KdTc6su+CE9gg8fUesWbbwj5GEtnWpNZ
 uYLohTa1EVYYNo6caOMiMxT87pS2OZ8+wocVe7Dt5MpZSSGDG+isRgj6dKoXtDV7A55gzj6v27p
 5ycnsc52546FBH5Cs5YW/m74oG+rg6CAU3hYVXm0h3jGNUKTwQoMq71pDjJvdGZXjmY1QM3QuZQ
 PmSWRSUQ/AUa9hTlSGQEUmiDpLvKlGAfJnw==
X-Received: by 2002:a5d:5e85:0:b0:48d:f391:5c45 with SMTP id
 ffacd0b85a97d-49c740bcf7amr19942300f8f.42.1794827606194; 
 Mon, 16 Nov 2026 03:13:26 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/33] include/net/eth.h: Make eth_get_l2_hdr_length_iov()
 check protocol
Date: Mon, 16 Nov 2026 11:12:49 +0000
Message-ID: <20261116111303.1692832-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

In eth_get_l2_hdr_length() we return sizeof(eth_header) for
any protocol other than VLAN or DVLAN. However, in the iov
version of this function, if the packet is larger than
the ethernet header but not large enough for both the eth_header
and the vlan_header we'll end up returning the actual packet
size rather than the eth_header size. Fix the "not enough
data" return case.

This will only cause issues if the caller isn't already checking
offsets and sizes, so this is defence-in-depth.  It also in theory
corrects the result for the hypothetical case of an ethernet-level
protocol that allows a payload of less than 4 bytes.

Cc: qemu-stable@nongnu.org
Fixes: eb700029c783 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-10-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/net/eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index e10684ed923..3e83f5d68c0 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -321,7 +321,7 @@ eth_get_l2_hdr_length_iov(const struct iovec *iov, size_t iovcnt, size_t iovoff)
     size_t copied = iov_to_buf(iov, iovcnt, iovoff, p, ARRAY_SIZE(p));
 
     if (copied < ARRAY_SIZE(p)) {
-        return copied;
+        return MIN(copied, sizeof(struct eth_header));
     }
 
     return eth_get_l2_hdr_length(p);
-- 
2.43.0


