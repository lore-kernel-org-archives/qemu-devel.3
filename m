Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1CC606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=su0gW1q/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNyUk-00070p-Qn; Mon, 02 Nov 2026 15:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUG-0006ye-Nm
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUE-0006iF-Vw
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:36 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so36624085e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 12:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793650713; x=1794255513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Atfu0g8wY0eKizwD/l8cX4C3K+pWhHyMdzqeBKdenA=;
 b=su0gW1q/dyKL5l6YZ+mmmEBdmoITt29CBxuuXOqgxJJuQlYgaEDWX5Vol5qhaq6m14
 /9wmshni9+4PYbaMLW0CI0TeNSX71N1tzc7Ws+dqsqT658zcbPJIXSF2jR1q5t93Ckse
 x7i4ilDAhmECk3hl/hRZnBd7aGuwOH702kJREiFU4C+pdxkq01ex861FkcMWSfj2OgaU
 5yjWcJqv+bKqTtrxtiV/glbRmJab+V2yZkeQsg7ZmFySkIs1YCocBgmpFvMuRa7xfqd9
 0u/Le5500GD1H2gNel5Hwn00v91L0VknLfVVAIKiNPyz3rm9TNt8czrWjJ1enoCbC+YV
 wXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793650713; x=1794255513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Atfu0g8wY0eKizwD/l8cX4C3K+pWhHyMdzqeBKdenA=;
 b=2p0S0NmjOK5FjIEOSlfKItp3+ZjM6SbrQKpulBd/F5zQ2LGi3/NxVWyYBURuQvNV53
 i9KiToP0ubwcIgpbeOGl/6EsreafGCzSXdLUpXHt8mxtJbSWXrG3mvn5VldE6UZ7lkBt
 pmMOXb+JA7DwYI2wk7Gwh6cJXFty7MYQcBHsPfJJ57bKebHPdKHQZ5/i/UXrwt3XBKKg
 9JS+6UR2Z9FAQfmKuE4BVd5DOePv6NaDlDTXzqtRw3Ac+Dd6MwGzOtmQ/nheqFiyxB4t
 Ec+UMODPuZeRJ4dsyFD7z1ObX04WFVPMbDAaI7u5ld2Ytq1YKG20CCLNo+gEEKq0JseV
 SkNw==
X-Gm-Message-State: AFq9FYJg7ZmnC6WL7p5rwBjaeYh4LWnHJRHGziuLkGsUFzWtt9foinG3
 rO6jojtS11L6gqCKit3AfijA9xsJjyfeVyx0pIMbAAeTvlfSqWhYMQ2KW4Ti1xWnDv66a5Fllxe
 cHAGQ0sE=
X-Gm-Gg: AYBFou0R93e+Gj4skVNJuapgjgkCan91b1rme7t9f7uq3Z3zioVouoM4QbfC5u+Fj0y
 DfM6cqxrjIkxZVj7XdAwlLryhkYH91YL02US7M8ukXQHy8+pQwCYjI2qFsoYZAZb8qZYzcWECkl
 WEux/ta3PCOyAX3Jnwqef1NRnMa5dJqhEFidfHCQRSOC267ZkUgJDgRxXrrPsNe8T9CIIP9Pzv1
 02jbqF1IZYI1lyIBPCtt5pv/3mniBAK3D9yQFuIIEondIfx15U6lYnYETSDvzopk7NJTrodcX8k
 NRljyrFIxUFI82kg2UKuoHGnHaM5fQqWntX8oTVWZ6rg7yJCgfb5pnp0Ej0ajM1xS93a9xnCOwR
 YyAmE95TJIGLH6Pw5A2s77rb2gra0GyAnFRdhmXmLCncO12fbzuKhptE0V5OO0IhQdSxESN2Aph
 K6vBHUfEmB3HMaEsVVQwvL/jiEB+cbfjNArkTFzc+fJLxKXyiB1PxMde+7KaAomqHHw/pLa1HYQ
 E/6r1Q6oOv8Bz+OgP9ZuX/91F3TUJXWai4PpnjNoxRD5XpraPqBLR/d6SAzAr6z/XClVUOFFmKJ
 Eu5PiR4RMnKmbG5+GKpFnlJ1eh5ROlq2C+VouUJFAIq3K6lXUuAgymFcOfs0Dn4487r46x6Xe0S
 2319MO4M+tlyQShw6VuA5Nw3RRr8r8M8uvw==
X-Received: by 2002:a05:600c:4f86:b0:4a7:669c:c988 with SMTP id
 5b1f17b1804b1-4ac18b7df2cmr261711115e9.23.1793650713546; 
 Mon, 02 Nov 2026 12:18:33 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm22152836f8f.30.2026.11.02.12.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 12:18:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH 02/11] net/eth.c: In eth_parse_ipv6_hdr(),
 fix check of input size
Date: Mon,  2 Nov 2026 20:18:19 +0000
Message-ID: <20261102201828.1879576-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102201828.1879576-1-peter.maydell@linaro.org>
References: <20261102201828.1879576-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

In the eth_parse_ipv6_hdr() function, when parsing the
extension headers we check
        if (input_size < ip6hdr_off + info->full_hdr_len) {
            return false;
        }
This is checking that an extension header did not specify an
extension header length that claims to extend off the end of the
actual packet. However, we do it at the wrong end of the loop:

 * In the first iteration, full_hdr_len is sizeof(struct ipv6_header)
   (i.e. just the initial fixed IPv6 header); but this check is
   redundant because the initial part of the function did an
   iov_to_buf() of sizeof(ip6_hdr) bytes from offset ip6hdr_off,
   and checked that it read that many bytes. If input_size was
   small enough to fail the check here then the iov_to_buf()
   would have reported a short read
 * In the last iteration, we update full_hdr_len at the end of
   the loop, and then exit the loop without checking that that
   final extension header had a valid length

Moving the length check to the end of the loop fixes this.

This bug has no visible effects provided that all the callers
validate accessses into the packet before doing them, but spotting
the invalid headers at this level provides a defence in depth against
bugs elsewhere; so it's cc'd to stable on that basis.

Bugs #4138 and #4516 both note this mistake (in amongst a pile of
other things).

Cc: qemu-stable@nongnu.org
Fixes: eb700029c78367 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/eth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 12ec316e240..bc26d38dc21 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -485,10 +485,6 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
     info->has_ext_hdrs = true;
 
     do {
-        if (input_size < ip6hdr_off + info->full_hdr_len) {
-            return false;
-        }
-
         bytes_read = iov_to_buf(pkt, pkt_frags, ip6hdr_off + info->full_hdr_len,
                                 &ext_hdr, sizeof(ext_hdr));
 
@@ -514,6 +510,10 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
 
         info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
         curr_ext_hdr_type = ext_hdr.ip6r_nxt;
+        if (input_size < ip6hdr_off + info->full_hdr_len) {
+            /* This extension header's length field was bogus */
+            return false;
+        }
     } while (eth_is_ip6_extension_header_type(curr_ext_hdr_type));
 
     info->l4proto = ext_hdr.ip6r_nxt;
-- 
2.43.0


