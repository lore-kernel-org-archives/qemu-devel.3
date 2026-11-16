Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18774606C119
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GNZwUL0h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSueg-0003wa-Nf; Mon, 16 Nov 2026 06:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueS-0003rr-MJ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:34 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueO-0002BN-HB
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:31 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4910b863b84so2390366f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827605; x=1795432405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7SS6FJJkWZhO26FG6U9/l0Wg9zApFtclZ49Uvh8f1NA=;
 b=GNZwUL0hG9qTCcNfjXo7NkZ73gVLUKO7/+UyBAwm1kZgqEHAF7xesubqIBeGfycU1i
 9FWUEUCFX3VND+FulPTkzdFbK1MSKOniOat9lPVobkjgQoMTcpa2Oa1l63ecahOBaT2m
 k3Df8UQW6MNeb6ypA/DbsCEWySr+VOCTyTmoODOwwD0DmcHIBQE7Yoy97RPt7J2zOf+6
 KT9Zkv0SlSkQJkYUopFMXd5bOBR/VaGciGju/v4Cv5jIJXJfbUissFqW8Q6/YF01RvIp
 t5Nz4d0VU7ouOR+z+AJ/ha8E30aMxklfm63QSEe64ib5uckn3UGrrh4BfXev4xRqEtnm
 JLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827605; x=1795432405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7SS6FJJkWZhO26FG6U9/l0Wg9zApFtclZ49Uvh8f1NA=;
 b=FqytCEIOxMc92vYLjEBrNx0nVLryvNJwVHEiNM4nC+QmgT2OM6PFDwNJMKeP9u7nRX
 ++uSOuV1P4g0jDXyzSMPZUUx7G4+TnA3MTgqjn8HPoWTjE0R5bS6gzWfMMpgyNvIFD5v
 zgFUtZHhtcjqpYKkYgHyRU0hSMGjUZQWm7s33G0fQ93h1EmHzhHH1784Vfd2+5gMmsYK
 xAaVn494iMHSJVrEWP8RDaYOpD6UqseTrNa6RFpKoqX/JqrJjrZfvugQpPbTUR0KZMbB
 YsS9Slj4xEY1em1QWSy9H1nFGMC/KQUlff4mbGBNdxrC09Tzz2gxo8bZRgH8WjwD1Rjt
 +4SQ==
X-Gm-Message-State: APuU4Z/s0XRjT235RCo0q7yMCYAz5CeepguaIpyb66ei2oFHgBRJb66+
 /Iw8NTXMJIq/MpQnX/OcY+rAqDTG3oe7OyRkQ5x1qYQjaF5+/vq4nYeyKXwh9OmxD9s/QsRwYIb
 Pnhg9qE0=
X-Gm-Gg: AYBFou220phzi2R5ZK2zf2m7U6WweaqAqr1BXGS4f+sTZLdw+JgGiJObrd6QzN+f9Mc
 sdVv6CfnUBy+9WUXNYev3qHncqq4iqW+vkNRKRf2uZopOn9cv01RX7ktaaJq3KqBqzfuYnRHOBd
 KhcwIx8YKRuaFpm8V+HF3fDdRJSTtGoOtlAg16p+f/fLmY0Zox80Kyt45pl4L8yX40WpKgn03qh
 awOklgp2ZUbaryhWN+YfE3NLB3RiBvvmEtLf3U7cnqCA71oN09r0v/2Kex0Zktz7sUHH7ZMipdF
 yBaSYO02vVSKCejeB1PW6RZtsTX+cArI47Uw2zYpsoDIRWfJjSzY+JeKFulOHia3TXCrn7QPB2N
 DuWD8BeNuQOjvd3X+o14mTTMocUXhzOmgEXJrFpsgUxv6rt6Rq1t2DktP/fMdn2e3jdlD0Rg6no
 fwSfREpJP9rncQMM1x//d9rMEFcl1q2wbGNf5L4KwXItq57xO678+zqR1itSNGlDy8gi6vnNhMy
 EUSDJJen1EW0t7UF2iis0W3pPRV3uH/kNbr9tQaUvzIGVrtZVonFVGUeaS7VxXu+bsASnyBGvLN
 1tuRZD5OW9t83GdRZ+Hq+x+jzQqdVsMILozJLFfSHfiQ595a+WbT1ztDasOUqTRMm22Qkxy2wgg
 Nblb9eplB1xFyl0ptU770lRnoVPHROe0dDg==
X-Received: by 2002:a05:600c:4703:b0:4ba:4928:8aec with SMTP id
 5b1f17b1804b1-4bb55a755b2mr221758535e9.9.1794827605254; 
 Mon, 16 Nov 2026 03:13:25 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/33] net/eth.c: Tighten size checks in eth_get_l3_proto()
Date: Mon, 16 Nov 2026 11:12:48 +0000
Message-ID: <20261116111303.1692832-19-peter.maydell@linaro.org>
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
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-9-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/eth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 74a705a2679..33b61cac414 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -75,11 +75,13 @@ eth_get_l3_proto(const struct iovec *l2hdr_iov, int iovcnt, size_t l2hdr_len)
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


