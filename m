Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260E9606C11B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Mn807bSd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSueb-0003uG-Pu; Mon, 16 Nov 2026 06:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueI-0003qA-F9
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:24 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueF-00029J-Ar
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:21 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so3570123f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827598; x=1795432398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TkQoPkRLNFdXq+ep1WWHdvaKfBTMnRBtHIYGuPuCr+U=;
 b=Mn807bSd2cbbhvPpTnCc6WkwfT/C6gWvcz1Xnnp6BZBYwZaX8XJchk3FzrxFmBjTnv
 WlJXhI7aLxb9SUh9mgl6/ptmxPrdb9fTaUaVNKhSxnkKsNiyppz8/F3zLIZIJ0yTZjFl
 4kBFEYapcXCumwR/C7LD/LJdFF2o/xLDNcJZul86YsBAQCaUS5pUp7aCu+LYj7Wu2s36
 xggYqNsFV/cbnILnEY9gfWPKU9h+BJT4a6fQv5btaZ2aCwgxgl7p2cIwz+yP1YMytpQl
 TzPp5wSMyR88QTVLerznimCruBPcaJB6kQl/qt41y811E5e50VnSaXzxFsZrGhcTUo6Y
 efVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827598; x=1795432398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TkQoPkRLNFdXq+ep1WWHdvaKfBTMnRBtHIYGuPuCr+U=;
 b=0a4AcUQNu45KdoxjAN4JtwpLervTy29UYnSRFpMMlNBIBM1gLsM8q/Lzkw7CwSf2As
 3KuYhfdlL25xOh6n6KxpOOrekJlX3Q+VT4lZb+JT2GOwbEgJRI0BosAzeh662J5wYsbd
 s8HXY2g4saaTnVXO1OqLlaFS/69Fu/SuoJlL0mzX5D7CutewSze/ZjZ1UOmAZEnahTon
 uIm/dkwYYN34B1g157hiM2SZtIlxbtQsSqRKUai7fawF1tIr8AFamUkY8gixdY09cw6S
 5d0+ZclQ9nRsH2CT4/hUVFJt4Wd0RXWBzuWdpyWJwt9Z6778eFT7yklSv8y4DJ40vNqJ
 NFyw==
X-Gm-Message-State: APuU4Z/9X9Y6g/hR9PEjqLOU5w4lKkjnvDVbqUI5Pp02Lfo+54/ys/AV
 oPJLUZkFsdFymtWHx62tPbsLiqLQp1MOXAO013057O9N4Gm3G4wMvbaMviL7836T1zhtbJxvUG9
 Yy/7fYRo=
X-Gm-Gg: AYBFou3aM/aXjEf/HDuFHPtXuTVwSBlT3hEVJBWDtZVhyaQY7rr8GwLPY6ID+d5tQET
 BNlLFN3fkh9aUDUBIKoGdAJqBz3FUhKPUbU/WJxHYc8mrZYRNkJTd7/4Y86CuOD0x6pNNLXM2VC
 e9SeQFlysCER9JFi06aDQ15lGxUBGJ+s6nfH5h5fQJzRnTCdMKiXxLlkAYxfJAhUg3LvfxCKPj+
 t352/PpH8Fv2ei2QyhyWiyMZ9QCu9RRjvEtwM1bDJ5pvzm5cWsf9Fm+3P2ztplLasNwW0Gb5uP7
 2yjKYqSimXeFMjWzFGz+sBEoXJ9YXt0p3OX8ObshNfuLalE/xurYl71X4NNZDIy5B6+QbONBvZ5
 DFOHhO/XIyupJL1jF7SI6+ZCONcRAaElE4Y5e646biD1eShQ/iy6xVSlfXziPjeB+uLtm4pZ/bb
 s0z8GDwhDkxz8gymGD11VFU0CGydSr0Sj9f/7XrXFwmCg2F9CT4rrmaSZrDabB79WdUm6RH0XU2
 sA9KM1Lblyz/nC7b59DLEA6ukrKL/Sj5FZXM8J7xPmFzadlcrQQxfO0EKzztWEDRKR2eFX55Ihy
 ENgqiWrRlYymK6zJ1XIJqRy/PP0ZhnxtLjDgVWPfwv2HfzZ5vDG+9lreXKsXGxm9Z2TYXp8Dq+i
 DeT7VovwkkGJ7V9gzFFPVYjzNHvzeeTqbBA==
X-Received: by 2002:a05:600c:83ca:b0:4aa:2339:a375 with SMTP id
 5b1f17b1804b1-4bb55a4d9b3mr218691645e9.13.1794827597816; 
 Mon, 16 Nov 2026 03:13:17 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/33] net/eth.c: Check for undersized IPv4 headers in
 eth_get_protocols()
Date: Mon, 16 Nov 2026 11:12:42 +0000
Message-ID: <20261116111303.1692832-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

In the IPv6 path of eth_get_protocols(), eth_parse_ipv6_hdr() does
various sanity checks on the packet's IPv6 header, so we won't tell
the caller we have an IPv6 header when we have a malformed one.
However for IPv4 we only check the version and that we have at least
the minimum header size.

Harden this codepath by checking also that the header size declared
in the packet's own headers is neither smaller than the minimum nor
larger than the actual packet size.

Missing these checks shouldn't cause problems if the caller is
validating all offsets and lengths before use, but checking here
too is defence-in-depth, hence the cc to stable.

Cc: qemu-stable@nongnu.org
Fixes: 69ff5ef847457555 ("net/eth: Report if headers are actually present")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-3-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/eth.c b/net/eth.c
index 59b278b887c..038f7d889c3 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -163,6 +163,8 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
 
         copied = iov_to_buf(iov, iovcnt, *l3hdr_off, iphdr, sizeof(*iphdr));
         if (copied < sizeof(*iphdr) ||
+            IP_HDR_GET_LEN(iphdr) < sizeof(*iphdr) ||
+            input_size - *l3hdr_off < IP_HDR_GET_LEN(iphdr) ||
             IP_HEADER_VERSION(iphdr) != IP_HEADER_VERSION_4) {
             return;
         }
-- 
2.43.0


