Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A8606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=waD2LJEB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNyWR-0008D2-Mz; Mon, 02 Nov 2026 15:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUL-0006zL-Q7
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:42 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUK-0006j3-8R
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:41 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so3662285f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 12:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793650719; x=1794255519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XJkZEXMXimgf/73tqNpqC4zidCU8t1qFKIc2RadN57c=;
 b=waD2LJEBVc3RZAeu1NJRF3+YfQZnRTbyuD5gBR548utg9rqNIRCEQsEJtkllfkIEDa
 1EG2WUmUffWJ9HLfAkBb2jw6wjlaJRf6AOKkhsoRZAQA+GDhxpFsng00CQsglsPFJ18A
 UJbVjhQ6uuWNwogSKDKF8UpE903ZIGoFqrtLTe6s9Lv3pb7D06wmSUdBVhSLj28xiuOQ
 M2zzw+KPyNM75nP0Ny65yw3j6HAHDWx37z5qocLDK+BnfSYzVXskBgK+xT4laVNYp/FY
 mQhHliHUHdxg+lLSinkP11oOJpNdHxBvyLhqlWvZT4iQ9jyn2aZ8A1CO18P0yw/0z/qn
 xqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793650719; x=1794255519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XJkZEXMXimgf/73tqNpqC4zidCU8t1qFKIc2RadN57c=;
 b=E8LyLqFcD8BHpuiND+Un9ATFYoldLNBnOP8uD10usW6w/AgOgr0ST3Jc8WOlVr9ZvC
 w1zFQ3yNAM83AJJLRdckYqdlgGeYrCtCUxy1GD/qzpnNEeiblXhZBCAMEmcEMRB2iMhr
 p7tzLP8dQftM8Ce7NqyVx2t6TDQpXZiI5M/xu+Nn9cznwcEuppWPCatfcjA1zAo/Xun+
 59AdK5txdBMTr+mZYXM5XRSYKyN698TrOvLmXcKCfr7D5s1qoJe0z+mR4n4kO7W6CgD2
 +TGvSVhithPHEa20xQ2DtP7/mkT+4RpgN66gDFBr/a/jRkQ6X4zKDmu8LzBmu1rGXQlk
 mQbw==
X-Gm-Message-State: APuU4Z/I0Tqi61IL9TaLfVOpPpOFE2EZ69AI/1/yei2GRHjsCHz5ZEff
 bSK3mVY9RC+QeI7CNaQv7Nln5ziyWXzyujCvIwxOYuXxdXCSKNKtVXLvyLQlH++WomOGyQvcXID
 JKqwSuDE=
X-Gm-Gg: AYBFou2ImIr44CxMpWDkXmZ1WDjwIwcbUC+9l1wtkVM3B+0iVwpfxGTUpxOBQePAcy8
 fCgPIa15YV5HcFALDYN3NOyEhsqe3vyG8zTwY4fK45R8ITw1OROfTWgHHfSHvckwc5qJrbjkpjW
 vuDIqG24HoGe2CU3MwkiDkoO+SVJzwr6fEjvjUwPRRkH+XWwhq/SpTcbj728r0l9Tbr0Z8PIbCz
 EEDzeQu2Rd+dw/hIlisPqIqOIF9b1lDcdle8mQ3QbYapCZDj8RLJbCqWxzIy2SXvR/cNgCC9qPb
 khCVLEgDRTnTP8B+xi1LSEMfL74hb1Qfnjv5rZWqRTwbmNiitCIP30dWpMU80RBdSutBMqfvuGO
 1GJzCLhGwioKzDyMIaQd6+bkxkmQhd4BhiSWcEGWdSPA3iWgF0U+hP+lqlrpAtHBvdMQ5XJ0HKB
 W1KFfkTNw+f5SUU4A++SObAdrSI5AvZrMIi4snSxrsB/Qtj1oKl2z9uw5TvpcZ2UGA32b0ZoYGk
 pBLXFHycMs1o7Xt4EDaoX8wxDvUJhKWYzbkM/yBULOvygEV74EwkUSJAWHvEiyRcFEYiyZYsJn3
 teNfQQf4B8QzMB5EChsxqHV5l9byMFWU6fBNzRlJq7bvDKE22WhcbIjHQgCooZtp9fWcQhWDY4E
 PZX3uPxLZFb8Xc/RP0VEQwI/ZXGnH77YIAg==
X-Received: by 2002:a05:6000:40cf:b0:48d:c29e:40c3 with SMTP id
 ffacd0b85a97d-48e6e5008f5mr26250387f8f.33.1793650718717; 
 Mon, 02 Nov 2026 12:18:38 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm22152836f8f.30.2026.11.02.12.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 12:18:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH 07/11] include/net/eth.h: Make eth_get_l2_hdr_length_iov()
 check protocol
Date: Mon,  2 Nov 2026 20:18:24 +0000
Message-ID: <20261102201828.1879576-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102201828.1879576-1-peter.maydell@linaro.org>
References: <20261102201828.1879576-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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


