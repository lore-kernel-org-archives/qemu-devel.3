Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EBA606A8A7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fmOpOhgH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSueZ-0003sO-7M; Mon, 16 Nov 2026 06:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueL-0003qk-87
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:28 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueG-00029s-Fl
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:23 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so2354291f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827599; x=1795432399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CnMUk4PqwLKmABb5XS8dEwBI81Oyl0v4bv0Q38Wo4ZM=;
 b=fmOpOhgHFfxL1XKQVXOME1NV3ZqIEZuOE37dn6jIsObvPLmaTT48dy/YnGqROq8Yz4
 SeFOGPqXRSFZ3iqJmelGgtE185DV9BedUa1MalZT7M9R7HYltHaTI/7vbvIqIxZ5ls+U
 2/VYYpClQQUJwVI1pMJdZ3EoMCIHdI7twOaT8uT22OuYJzkM63hfcTAzRxQiOHCZFxAq
 c4dC8T+ad05Ll9G1m7puq3uLJJZPV7GPfej7/dcg0egByFXQro+p//7H/YEZ+jgwVsww
 ZrTQGFgtQ6VGRs47LZFF/M/m858bwEM8lAUorw5d1vE2r48DPJ/W/TMIbHkpinDCs+SV
 2xJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827599; x=1795432399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CnMUk4PqwLKmABb5XS8dEwBI81Oyl0v4bv0Q38Wo4ZM=;
 b=i8I7VV8Ep3b+bmrH8L5ad6+155NwdnZqCQ9tsfQY0gazJIMyln5iCekMCfbiGFW+w2
 7/sCRnqw9ySeqtIG/dDPGON57bsEB4AWZEcb/DahAQTXw97KCcgB7osGA2/uMD12D5dO
 rEThtDdRkdSf903ORH6y9YdzFH7KSsk0t5rarMk4UoJVx0/DOirWosFouSdfDO4Cb8qZ
 rQwqv6+Sk9tUAebBvd5ko2B9nc6InR1YrpK+VgjZ3G5U14o3tHjqKNoZcy2I2vaFPXq+
 7uo/kLk+qRoHnbGP/8l6rDoXv9UMDTa05614RCV6/YlmOavdHIk+CA8di1NbZAif5zo2
 Ewng==
X-Gm-Message-State: APuU4Z+3KmwQ2GUeZsurDVM5NmgwGzx1G8iZWVk/GLEmVaGOMj3PbYSI
 89uKKsWNq4MftEpqKOYrk+dX8SRGyysfzAjdi5bVq9PzU8/uDfLu3z41X9eeK7hohWEnqbic3Nu
 nKI9NZhY=
X-Gm-Gg: AZFdTZdFvDFFS0Ipd0xYx3vfUdEsAtCoy6Kw4GbvrexXeNT/InWxtuVCC0WJxzJgEo6
 NoScSZuSS1P0u+vWpTqy7nAWxChevI8QY5QJVrvHcJPJWcClWL8hznV6fhIUC6OuDMjAoqnNHLL
 cxxWOAifykT3piASKFeVJhtshTp86uPjRd6cCWQGrfII4ST2o8rEeVHA4sTfo9m8pnsr8mxqMgy
 TqC+JIr5pURR8EbZz353IS+D6LHp7p46c4XI7g6EBh7DiqAJw8kETIvgvff1gRJTnspTHRh9Z5e
 9PLjBXIjPt6eygx0Anr7FsCHaYYjkwXnTaaS/ZyoMDHed7OJuHguarELOFx5sfJ3x/TG8ivTYXU
 8ilPM1fMeNsW+fRndDhtB7pGQ63mpyxpUboP7urWtEbXib4a4XooPsnV2dcoQq1OiRCeZHU2oA4
 exORqje3KwpYvOwm9P0NMeAzxDqYOT6ChL24Yf2+PbNbUEmBLU+N1SJqTs2GKXUmsboGDLcfFop
 378ksUczdk2LzBTNjwi1+mz25DAryWnrg0WVBqDddj1MO1zQEcO8av6Bo7IZcNDzMrCHb+TWCsm
 JTnVvUR++R6LFIgGIWTEDnR1JZXVkttg3vzix6r4UncdWeX2sn1mXVgT2yd0BSCvuDP63pIp2Op
 NaGWhzu4/QLeUa7bDdfwYpE42Hlwm6tUXCbG9AxwCXnRidlmmxBtKnIU=
X-Received: by 2002:a5d:64cf:0:b0:48d:f3ee:7cc with SMTP id
 ffacd0b85a97d-49c71a66085mr19840265f8f.30.1794827598759; 
 Mon, 16 Nov 2026 03:13:18 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/33] net/eth.c: In eth_get_protocols(),
 don't report TCP data offset off end of packet
Date: Mon, 16 Nov 2026 11:12:43 +0000
Message-ID: <20261116111303.1692832-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

eth_get_protocols() already rejects some out-of-bounds offsets found in
packets. Add a missing check for TCP data offset.

Fixes: eb700029c783 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4155
Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261109-eth-v2-4-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/eth.c b/net/eth.c
index 038f7d889c3..a444377fd0a 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -197,7 +197,8 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
         if (_eth_copy_chunk(input_size,
                             iov, iovcnt,
                             *l4hdr_off, sizeof(l4hdr_info->hdr.tcp),
-                            &l4hdr_info->hdr.tcp)) {
+                            &l4hdr_info->hdr.tcp) &&
+            input_size - *l4hdr_off >= TCP_HEADER_DATA_OFFSET(&l4hdr_info->hdr.tcp)) {
             l4hdr_info->proto = ETH_L4_HDR_PROTO_TCP;
             *l5hdr_off = *l4hdr_off +
                 TCP_HEADER_DATA_OFFSET(&l4hdr_info->hdr.tcp);
-- 
2.43.0


