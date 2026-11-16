Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98F1606AB74
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=x+Gpba3E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSuf4-0003zt-Td; Mon, 16 Nov 2026 06:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueU-0003s9-PB
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:36 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueQ-0002Bv-DK
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:33 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-491846221ffso2996475f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827608; x=1795432408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cwdI2ks2UX6ufxBpWH5uqNqrepl84PaA06uzdEISrr4=;
 b=x+Gpba3EcWbUtBnulFNEi2bb8fHdiPxXfp55iE3ngp5MHkrzuX/GTQRRL1xOOas/c8
 t5OP63dxrqM6ecFc1EyCOANctUFB1jhhWZZNNG3TJR7O8BW/7WPTcoVKTfnnQsHqsnJE
 30fJmekJ1pAgLM2D/vE0rapgy2NqT2k1JkzUjknDEPfzZsuFzubOTdBPuzRlrpZt1THb
 AivheXDOGtqEsSI9bkDv56dP4l8PTmvvCArfU8MOWx0U1JpY4eqlBLd251k0fAyd1QvE
 QZ6DGbHHAz3HLdMQMk25l5cJ7WlgpiaVkEENQhZwAvlMIPG4i4gfXjqM+b+/gAWHPaAy
 1soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827608; x=1795432408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cwdI2ks2UX6ufxBpWH5uqNqrepl84PaA06uzdEISrr4=;
 b=NZyD5JM94w6hFtiSy1AkJoFhZ36A7cuh9MFJtGb9ktxTg4BNZH6IpwBdp/N3T17dOw
 EriVrsWy+20gAQsgZZBFIgMnaJpCzNtc27tKYedzgsdW3uBxU495FTRl2D2v4+tVcsdC
 fIvhpqVQtkxcPIgCI/cIXiNquN772/rxPn/y36goFJdXYb4Xwjs/3lPd8GCA5fE5FpFr
 E4RJHir9mFWknrLZ9LwsqwBHS2iXSlcM7ByuJebIAYotazA7LdACG8acfYPqQl13pwml
 LgwPsbYzCbv53q5sQ6BoAAgGsCntKuNIVZWKLJYpa88/iTUkYkzkgvJOyffG4WmanlTW
 qzug==
X-Gm-Message-State: APuU4Z8GwMt4QgEiT0wfJ60fwA/vTdwTFwVQcP1Qt3QrlrBmh1SOXTAl
 5pKoH8o/Tmo/O5/o8R7JVsRow1M0p4jg7bfT4s6hSLjyqlCIxxigttxCy9vfRJmcJzo3tzkYjni
 r9QxNgH0=
X-Gm-Gg: AZFdTZfPyg0c1usf7mJC+zTaEbw2KQ+fymOQVdxa/d87ztGLc2XnMTOwUw1Ld8tw5cm
 8z77ADdIzIj1pmV7yWSDq7uARGOH+72D8p4Zx7voz7li53nqXnyAE7axFymo0Y2HxxIGWMnDBbM
 DobnN8wQA1LehnsxeBIKHhgGy0NHLxHAjXPUf7goVFL5Gj9+h9pTwUUqGtDIM68idIOo3DgWE45
 GwQPvhtNTj91LN34vcBbYXs1ykenGyCAQ9i+bSDC8Ytc7y1NYLhhB/kUkXcaSHvJao21yUu1SP2
 ++L4GTZYDeyHzRiEFvHjNvS3xruWsRf6UkflDwWCqeqom583BJqDvuaKrxpOHTsDoyLLv/VPQIJ
 q7z6zOLTr7SsYLwNbZHLgwJfqhn5XVNr8XQZV+BZqmBJa772Ov++ecteUv2hqykiFfqII6Tgq96
 HWp3zQ2g5LMlFG0BnDLICYV6k1xjGXPSKV+ft2pzrR3nyniWnee+/zrJRJo2E9QNgOZR4jwHzga
 +qN5ahXSWJnWAov/LCUy3UeTW74eTCSuWpjiwsu8Vjrho0DgCDlqBUzWtSwbg+HYTbJP0UJWBqn
 maphGeEE1iUT5pUFrBfDUDnHCfMsn0T8+AJ+KU/9W6/a99o7+Fc1ymc57lPh38xhHKhVIYn6bqa
 XMx2QTS/3zXq5u2UMEs/8mBrJnLudC7/nFA==
X-Received: by 2002:a5d:5f51:0:b0:48e:d88:55f4 with SMTP id
 ffacd0b85a97d-49c6d63fad2mr23388887f8f.2.1794827608197; 
 Mon, 16 Nov 2026 03:13:28 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/33] hw/net/net_tx_pkt: Sanity check virt hdr len in
 net_tx_tcp_fragment_init
Date: Mon, 16 Nov 2026 11:12:51 +0000
Message-ID: <20261116111303.1692832-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-12-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
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


