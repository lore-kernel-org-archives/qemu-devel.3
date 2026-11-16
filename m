Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBAF606A332
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=f1+YE6kP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSufB-000404-Os; Mon, 16 Nov 2026 06:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueO-0003r0-PD
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:30 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueK-0002B6-Ge
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:26 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-491d1f66968so536460f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827603; x=1795432403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cFs0jMd9FQ081ajvl89T/IIEC/4yeBrwaqCaW0cbeP8=;
 b=f1+YE6kPutS4QTw/LlrZ+78HlkrxIxxLuct0qScw6J+BnzjfII3lmFw+IDTs+jN77H
 oLn1qfzGWvLZ3BP9yaeRzYsjzBdQ1w/7Bj/yJGJ169mLdOgWw7zSyT1opXUIYrm0I3+O
 OhXMUdQTaIh615lPxsUaFzlXaN2+oisd9VKmBLgy9PMHs8qJ81yZKW/HnTYRA4rjLChL
 7cfuuzPpo7rvfZNb/Rx0E9i0Xmm6A9LJRQuCqkhCK3hTqkupjGinQfAXAb1QEQlgMYQ9
 lCsnFfO31QY8twPEBv8uDMaFFLJ32FYJ4qs6vZ/XhQV3feXucLzSC/bA56sT+Npah+ri
 /gIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827603; x=1795432403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cFs0jMd9FQ081ajvl89T/IIEC/4yeBrwaqCaW0cbeP8=;
 b=NX0EIBfrfyKriPhTFoe6vhaGWUAP5QJBWNy3Shb9pZtNGxwoZer8kiHY1jdEiFPwqv
 hfYoaItma5NtzCSSzPzJtYE7ENcqyxWWXg1v0ON2J6NsTAFPsY0kOYdUJbcZKaN5qH+F
 8+kroP2vMqhUmIcN4kVV2f5/Zkrqw2Y0Aqzj8nITRE5NCo90aPR4MAJ9FU5Qzjp5i1VS
 FRQjIskbFJzi7fCySY9dqk6yo8yrM9dg7QcaaZ1JUl+J++pliMlzHaCee0wWgIwk9wN2
 zcsa9AMxg4F9vFFUzSDBXwmvKCGyv3c6W9GqSI2pAzBAGhxjvs1PPWUaHpoW2mjIWZU/
 YQIg==
X-Gm-Message-State: APuU4Z9bvmnWGxCxtibXi2twb/yML9Hl+d9M2tRGMb5udUWwnR86l0zG
 F80WKygwPQETDk6dEoyjIXi3188ZUhnqY1b4MAh9HDxzxFs6360zLTzwX51I1I1fezjEgUn9xK6
 UY0brPcY=
X-Gm-Gg: AZFdTZcXFblsLQbn9o9py+glznUUwqG2bfQVca3DI07n8m7u2uaU6aO2ZR2R9tPescy
 IdBtavYTFUUQQTeyzTugkpq4sUM6bAQXlxC4CD9ksONU5ZrpzucsbNLk8zHY2C6fVY3kQ7yhAVV
 DgFIfyTViFXOR3881CQHztgyolJHPLeVf5O88yzz4MvVqbh4Ssxc+KcKwZQRp/yyWbZUN9QDkdj
 YlsRO2QevCQFK/DAHNFo04d3Sv9N1pfzDjuHMO4RmjUoCNRusyhMUfkDC8velsZQD4tN2nrhzWU
 L6lZiwMpU4DjMXj6io/ehbgmM5IIIoQtDEt9WyhiH516AbY+bMwX1y/vVRxuXtRzkdQxXkDKSjB
 fc9+9x1naa7FMYVKJEtvwUaEUKk87usrcmEn92mMgazUhFh8uSzgLHPUNrH8UO25n2g72UylZ21
 BiG++LtM2XjaYRppSHH+aYuGy6OabbCEpV/WF6pt3rB8Ib5n6CvhfpVUhiz7gikqnW8IT2tUvkJ
 GlbksA/k+Bv6RWVGscB2rB4k8gQES6p1Xyl2krQ/vyvsYI7c6XA/GMw8P+EYq1CuK+OipjbIlTp
 tmLvKZQGd5QbsPfJ2bMMuBvuyB8QRQmr6tIc6xMmOXeh0IZWwTN2uDrH/mN5LubKiEW4GiOZ5FK
 JXehQbtY8MMekihDXB1bxrPpvixHU0r0QXw==
X-Received: by 2002:a5d:5887:0:b0:48d:fd4d:7fbf with SMTP id
 ffacd0b85a97d-49c6d4539d5mr24594811f8f.4.1794827602915; 
 Mon, 16 Nov 2026 03:13:22 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/33] net/eth.c: Move the Routing Header Hdr Ext Len check
Date: Mon, 16 Nov 2026 11:12:46 +0000
Message-ID: <20261116111303.1692832-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

RFC 8200 - Internet Protocol, Version 6 (IPv6) Specification section
4.4 [1] says the Routing Header length depends on the Routing Type, so
place the checks of the Hdr Ext Len and the Routing Type together.

[1] https://datatracker.ietf.org/doc/html/rfc8200#section-4.4

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261109-eth-v2-7-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/eth.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 484f61ef31d..54b0a77fa0a 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -407,7 +407,8 @@ _eth_get_rss_ex_dst_addr(const struct iovec *pkt, int pkt_frags,
     bytes_read = iov_to_buf(pkt, pkt_frags, ext_hdr_offset,
                             &rt_hdr, sizeof(rt_hdr));
     assert(bytes_read == sizeof(rt_hdr));
-    if ((rt_hdr.rtype != 2) || (rt_hdr.segleft != 1)) {
+    if (rt_hdr.len != sizeof(struct in6_address) / 8 ||
+        rt_hdr.rtype != 2 || rt_hdr.segleft != 1) {
         return false;
     }
     bytes_read = iov_to_buf(pkt, pkt_frags, ext_hdr_offset + sizeof(rt_hdr),
@@ -518,12 +519,10 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
 
         switch (curr_ext_hdr_type) {
         case IP6_ROUTING:
-            if (ext_hdr.ip6r_len == sizeof(struct in6_address) / 8) {
-                info->rss_ex_dst_valid =
-                    _eth_get_rss_ex_dst_addr(pkt, pkt_frags,
-                                             ip6hdr_off + info->full_hdr_len,
-                                             &ext_hdr, &info->rss_ex_dst);
-            }
+            info->rss_ex_dst_valid =
+                _eth_get_rss_ex_dst_addr(pkt, pkt_frags,
+                                         ip6hdr_off + info->full_hdr_len,
+                                         &ext_hdr, &info->rss_ex_dst);
             info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
             break;
 
-- 
2.43.0


