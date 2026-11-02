Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260BA606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XmObYXjI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNyVe-0007Wz-Li; Mon, 02 Nov 2026 15:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUP-0006zs-L7
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:51 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUN-0006jW-VZ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:45 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso2106365f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 12:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793650721; x=1794255521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+TA3F9sqKJS4JB0mwiT1BxsREsozO0IhCycBI0psi5I=;
 b=XmObYXjIKHpsTGe4r/rIRHdB9RiKm+RmCaNGxNDwT77o1+HP3nlEF1/8bkVu28yrqV
 KDYzNYaV7OZ3TakMWSGRHqvqslCLWXGEB1HfjkH8x8n7mRNIG0MWqSM5RmCCpK191ab6
 ylxDhapAzPsehKi1WgBKdTNMSMKHppDG9tEoQJvZQgxyt4QhvQfgBFRXJuI0g6DhhFC8
 6gnjT6+sBfyHGVwJOQjIKnBrtC4nZXYrVzgOQdj8otyhzjiwrUD4Cb81OJorbVrtcx6M
 MQsUb/rEzRXyaV3VmRtLc6gIbFSW6iDndfb2iXVIxdXcfqZnkATAyX/KejNa8iQQ89eL
 ixUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793650721; x=1794255521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+TA3F9sqKJS4JB0mwiT1BxsREsozO0IhCycBI0psi5I=;
 b=naMWWH7q4Knnxq8gBn4e3tRN32ZIjE/5o5jpnIltdzFJDzKujoGq3KFllpFTFfXAMu
 3YqRk683319YjLAjt6xDI+7mFXLZkrAMxBNyvukYHzHE6mMZ2rc9leDBL2Ylh/e56VP1
 nQOLSLYRGDPJ7sTQVL+wToGi9U9hTsGrVgbb6nNVLlotk882dxiZf/MZX/P2EAK4hFL+
 qgGfgtl7HcC4Z2lltiiQVjacZNfFEUxG0f8zYvEqMiq9vX/pualZXMjGyFLXkBY0WfWd
 9A+nGwPwsklwcCzdPQEyvPhfjxSsdC3aWcs5s41bgyeuTpjEbvhe5es/CJr9tMX1I9bu
 Befg==
X-Gm-Message-State: APuU4Z8Ol8fmbVHHvuG55o2nux6upHrPgJBB376L+IA+TD84Pd4740eA
 obt5/wTTR/G6vJ2J74oW2A2PgJH+oz915bjRT8/O1w6HiDQUyAIaoi/icQt1PjsXAe9L1fZlafu
 f6HJ1iE4=
X-Gm-Gg: AYBFou2euYfhdjurxbE6aiUZaMR/S69e+JZqfhnO9DnIcIAW/ox+84Rm9XsfaWGCSO2
 eyeYfetslQ4o4MrE/z3gH1YGdO+GriENnAubY/1A2NUWHk25g1XpgW/wMEN7rtWVw9cqOR8L2hE
 Qx2wMqRU1bUbnUbKld0oqGWsy9XQnUuDjAXEPvbeQ8kJsrb9MTjOlMXXBmfkrwFSNiZooESx797
 sFPqvOOy1CbmDwJwGf8Yi7Ay4R/0vlbN1yR9u2/eDNtkBh8W1lk3LdMN1XpSYaPlxV6dEL/Jfhg
 GcVsvounhCMB8+/CcOL8Kw+ilgKcD6jJHMOq63tUX0CCSzET+MtSauvHhBMjMVymLPQYC5dOFg4
 4oS7BSKFiDkad+m0MsTmvP7PT31v1jcD9wTFIXO51aYaA81B/NDBfLTCaRUcBOgqtP3iWDsWsV2
 CGjKlswQk/JdMgYEzK0Fy4VWy0150ZBRf//pgB983RzC47kaxYfG47tkR5/b9dyVrtQX1aIUPvq
 yxkpBfGh5f1beJ96i5wzCmd00sdxa2kkDYs5c0OzdAS7KuMFkfvm1auPwn7mVHgLt6XS07EcHDB
 8jmTsHoL3Mnh5Dm2Y7b9eOg2RzPBfDhbT66kigNM9n5gR4Ty8tN626RNqE/Gw0dp3/aO/2l4M6U
 pA1w3/lCYbiLkRH7lU5YILMlrXqGidnVQBw==
X-Received: by 2002:a05:6000:71b:b0:48e:68d5:81b1 with SMTP id
 ffacd0b85a97d-48e6e4fcfbbmr23956890f8f.48.1793650721629; 
 Mon, 02 Nov 2026 12:18:41 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm22152836f8f.30.2026.11.02.12.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 12:18:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH 09/11] hw/net/net_tx_pkt: Sanity check virt hdr len in
 net_tx_tcp_fragment_init
Date: Mon,  2 Nov 2026 20:18:26 +0000
Message-ID: <20261102201828.1879576-10-peter.maydell@linaro.org>
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In net_tx_pkt_tcp_fragment_init() we calculate the l4 header size by
subtracting the packet's virt_hdr.hdr_len from its overall length,
and then we g_malloc() that many bytes.  This shouldn't underflow if
the caller has been sanity checking sizes and offsets, but as
defence-in-depth, check again here before relying on it for the
malloc size.

This change would suffice to avoid the guest self-denial-of-service
via overflowing the virt_hdr.hdr_len calculation in
net_tx_pkt_tcp_fragment_init() which we fixed in the preceding
commit.

Cc: qemu-stable@nongnu.org
Fixes: 02ef5fdc092bd4 ("hw/net/net_tx_pkt: Implement TCP segmentation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3648
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/net_tx_pkt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index b2935900fe7..dc2563721e8 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -604,7 +604,7 @@ static bool net_tx_pkt_tcp_fragment_init(struct NetTxPkt *pkt,
     size_t bytes_read = 0;
     struct tcp_hdr *th;
 
-    if (!pkt->payload_frags) {
+    if (!pkt->payload_frags || pkt->virt_hdr.hdr_len <= pkt->hdr_len) {
         return false;
     }
 
-- 
2.43.0


