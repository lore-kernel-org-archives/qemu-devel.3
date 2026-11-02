Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10673606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HKzfpi1Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNyUp-00075i-6B; Mon, 02 Nov 2026 15:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUK-0006zE-Vx
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:42 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUJ-0006ix-9H
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:40 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so27851895e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 12:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793650717; x=1794255517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zYP3UuQpxXa0Gmc41CzZ5nRNzgygyc8mQxZJvr2++LM=;
 b=HKzfpi1QCXq4smK2Jmd3knbZVKXTpfJuYhqkuMuTJ6DHoT6yMA89ThmScRgbKJo/7m
 o+Z3vIJMtUA/wety8f9FZUefXfZAKZhteZZ2Zj/zRmHwXL6ySCO+/na7c7cDNCSmPSz7
 O8inIPmGyJQbr4+Bm9Xr0nRvygoH50bskmoAUDCU4U90z3HEr3Hjobn7JT509v1xFuOO
 NnNb/g7JtRF2JSd1ghTVSq9tfVeSvl3pgs4o2YHHEAj9IUNk5JKmd5PKNh/CK3a5IcnE
 OJvgLl5IT+StiL3qHPd7x+cuT5OwmbYmUwpbuqpg+MSBWDPeFe1VwWagAFCFoS/3o3w3
 6Hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793650717; x=1794255517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zYP3UuQpxXa0Gmc41CzZ5nRNzgygyc8mQxZJvr2++LM=;
 b=AfMA9tBtPi0QXkKuWbQC6snZgFGP6Bh1TWdiDyQ9IX6gb7l5Kf5U13nSVvR6DoTIoc
 Aw70BW98mviUDq8SEQ7Ly/JcSmL+B4CLSNO4T5x71AMsiwZN47mSEUhNV+oZiQ0L+1PR
 Q/7iZmFGbQg6v2BRMJ/fzKFhc1zEIvyGhuliuyzXrTWaXeT+5Ok8WkXuaVx3R4D/LXz2
 Ip7kllwqoWML29wQs97qC2leTZ9vFzd0f7FuwX7hr2K0L6CXsE6MhprWb6UX2J+zfS0U
 UboM6bP6sf0zkAwiOFQvJwc1uDM3ZlnHzt/0D4UJ9DtxcIS+KOaCKDQfIWHnyfZK9Iit
 3JIw==
X-Gm-Message-State: AFq9FYIXajRSYHW5+G4ZyQflrQe8zECn1ruCLQ+cA3hW3oQSL/OzIJuI
 fFxsr9yXsRLVVH/bzggqM0PorznAmUJZrOJPq3/TdtEb0kVSwuPGW6ZpWC3/CJpY3kudqM3Xhcd
 5FHNJgs8=
X-Gm-Gg: AYBFou3at4kjDV9FaBqhu3K50l5uDEElP4wZwvjvxE8ArOGbFLn91/QkILZoe2Uj3hp
 vrImudB39DX3s1gkGnZBw9SCFz41lJtDBaNL4nlxxqiHIefnAwUHwTpPU2G4OT3IwnmInvixCIm
 dC5vnbXDwNHJMOw7Az5pDBo3o/m2gOnpvq4JIJ5V5fblxAwDUw1RbJLjSP9NqSgNlRzb4Fr4Sle
 pko1H7oNQxyJj7WAI+6dz4y9DPLCbqpCtKHkJGZkytjTxfdt6+xoEAu5YsIWM1S4D12Z6DRcvfq
 wOLObaIXt94H9Dnk4Hl9pnmPvfsNSWtEkquf5QENqk3SwgXBYxKVvXiGPDykiZ0WNLYCQSTLzhr
 pLhrTB5rZd8WTHtF3xhVLL1NK0Xfxdj8HKCl2WChxx0uWTRqYvFcQM5TaYPmIc9mqG2r8mw5g1U
 EXGVGt/zAcL8mYoWyAOYOmG1hQcbLuvg93G+c0vMSncSMODmlLijHDc+wzeD0+ukwhi8qf5ZR5e
 p1np01KQsvOI+yBf3rRXL2Z8QYK4gbKw1MS1KzF7J1Cttk1vFymQsOGtQDyewqG26mXtlLIlljt
 LXUCoUAlWqg0iCypohjrDt7m9Vx5WJWQdpzmbXRV+eagHTFqS1krSQuvP4vJAa/79ylIJZ6+qfG
 V/1gwjUqmtEL8bpAwQf4dSwRbOKJGvMaoYmcmjZZW8Q15yDI26T3UqKNr
X-Received: by 2002:a05:600c:34cf:b0:4a1:dbdf:17a8 with SMTP id
 5b1f17b1804b1-4ac150b3d01mr267974405e9.2.1793650717665; 
 Mon, 02 Nov 2026 12:18:37 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm22152836f8f.30.2026.11.02.12.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 12:18:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH 06/11] net/eth.c: Tighten size checks in eth_get_l3_proto()
Date: Mon,  2 Nov 2026 20:18:23 +0000
Message-ID: <20261102201828.1879576-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102201828.1879576-1-peter.maydell@linaro.org>
References: <20261102201828.1879576-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Currently eth_get_l3_proto() has a check that the offset of the
protocol field is not off the end of the iovec; this is actually
unnecessary because iov_to_buf() guarantees to return 0 for offsets
off the end of the iovec.  On the other hand, it assumes that the
l2hdr_len it is passed is not so small that the protocol offset
calculation underflows and it doesn't check that the packet is
actually big enough for the l2hdr_len. This shouldn't matter
if other parts of the code are checking, but for defence in
depth we tighten this check.

Cc: qemu-stable@nongnu.org
Fixes: eb700029c783 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/eth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 955f2bff5e6..d9113da58eb 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -74,11 +74,13 @@ eth_get_l3_proto(const struct iovec *l2hdr_iov, int iovcnt, size_t l2hdr_len)
     uint16_t proto;
     size_t copied;
     size_t size = iov_size(l2hdr_iov, iovcnt);
-    size_t proto_offset = l2hdr_len - sizeof(proto);
+    size_t proto_offset;
 
-    if (size < proto_offset) {
+    if (l2hdr_len < sizeof(struct eth_header) || size < l2hdr_len) {
+        /* We don't have a complete ethernet header */
         return ETH_P_UNKNOWN;
     }
+    proto_offset = l2hdr_len - sizeof(proto);
 
     copied = iov_to_buf(l2hdr_iov, iovcnt, proto_offset,
                         &proto, sizeof(proto));
-- 
2.43.0


