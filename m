Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDA9606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oaVffktg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsEM-00060t-Ux; Mon, 02 Nov 2026 08:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCv-0003Bb-J8
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:18 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCu-0002HN-4n
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:17 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso1637411f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626574; x=1794231374; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5fwV1ISCnFnohdXPev+qEL1UKsDmjksz8K5cS5yRSlI=;
 b=oaVffktgN2FaluEVWYEa0i/d1KEX3M/AOXlCDlaKYBkma6zP2c5MkuLO0LALXosccD
 COjVvGZRdpyWZXKebXQwxDWxrjZo1IXJWICh8JVc3PM+lqqilHh97NiYFaqfzeeqr1VR
 gyTQKFE/EeYzC3DUuDV2Pg8d9pnG9IG/XuBU3GCzwzjIwPE6iwru5bAY23jz757VypDl
 52FQvvMtG7QkS3/obJv96w4DH5a1mFDqjZs8f9nAMkENUWWRB0rWPefUieoYcfqstEjM
 qzOkIvUW45eyJCM95bcGswUfuKaRE4JK/ZC7A5TNX1CQS2cURTeZq+r2cioBHyxcEOCl
 e02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626574; x=1794231374;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5fwV1ISCnFnohdXPev+qEL1UKsDmjksz8K5cS5yRSlI=;
 b=j9ZqcppcMFW5BgLhPuTkE4cQAPI9O8B0OX7d7CD3bNN2Pet1x0C2Kegd/K2W/oq4D/
 fCrTlWVumX8IbQTwBNwYH0wxIqscYbZgvcthSswlaZSl0S5NnULL72gpP/bwPFeDQkg4
 B+yrIGwY4kHonjtkNnS436ag/953xd4Q9WfzgdJdZqiyU1eNGumaXAVr1V1N1cXMSXKZ
 hPm5o3cb8LEWrKuAqLSRv632rddbiUalaO2r5VIivkAgncYJeIRbNnVeLYM1lGEirmx/
 Jpz4OHWZoNzsAFoB9Jh/tsDg3u7GRsBkAfvb8tpHr5/1TGt/wneABSqL9bCm/I92KPMB
 pGBQ==
X-Gm-Message-State: APuU4Z8SRG4LMPyQ/GZuNg9VHSv9xIDUcYU6huWNSZNrZDDy35KLrR7Z
 lEPnFm/re3gxww8SNDvuMP665mPcaIkOqqKo6NHH8eBibTjkjS0hrQPDhttmXESbNLG6E0udboG
 bEyX7Css=
X-Gm-Gg: AYBFou1BFZ7NFGorfYFTDj+mA4Ao042KFtxmCR1aht49QnJ1NLke6PTNIuijc9eFtcR
 XC74u4vHLyIMaVJDEWMl4TkLd0Lk4UO1CnuMkxwrYEfKyTYvRTBiM/AKcT/KbeRWN2jsKaxBhWl
 p5yuMhZ1t2CAiw/nh+8ugg+8MkEi8PR7jUKb/cDuXy0ODuRDPN+/yPLt+wOn19HqcY/0bGL502d
 reRfTZoYrVyya5AUZvv0IiZAVpDpm1y6Yoz4RsFOtkP6do8mdOMG0wdKfjnlAKDuLh3mKMirRpa
 1/H+TGZTzcukHafbRtO5CqrxEQ8msN7d7bQSDqOVQFtFmxGzmfHrevQ7JN9cb5GtSjTighYwPfE
 s/IcqHwLLvlH0Wlxf/01DjlDZOXb1AXR1GIUM6sYuMEg00Zo8sj6klggqMnOJ4jAMWYnl6W+kiR
 isou1IjxIcdGVIBIApDd1bDSsch7V4As8Cj968IQevra3UIqz1juonsBDJdg6hi8mDpU+e9OwXG
 5fINbcytTmp6G5LU8/+GS+17tVgFnmcTUW17lOwsvM1PH16sRQHk8fht8eIPXBIO8pBeM7gGdKI
 K28WOJl++WE4jEzhRWaL7+EPwfdGtFH3Rs5cuh9sBJOTcBhnztg7U5P+nG7GMgHP5nePr1huyWn
 oMA50hXJX68b/kaq65RHXWDfIJiJVkjKvQA==
X-Received: by 2002:a05:6000:4287:b0:488:7df9:3898 with SMTP id
 ffacd0b85a97d-48e6e30ba37mr23069459f8f.56.1793626574045; 
 Mon, 02 Nov 2026 05:36:14 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/47] net/tap: Avoid "close(-1)" in net_init_tap() error path
Date: Mon,  2 Nov 2026 13:35:21 +0000
Message-ID: <20261102133547.1375701-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Coverity point out (CID 1660042, 1660052) that some error-exit paths
in net_init_tap() reach the "close(fd)" at the 'fail' label when 'fd'
still has its initial value of -1.  This isn't a valid fd, so while
close(-1) will fail and we are ignoring its return value anyway, we
should avoid it.  (Compare net_free_fds() which has "don't close -1"
logic in it.)

Resolves: Coverity CID 1660042, 1660052
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20261022160426.451919-1-peter.maydell@linaro.org
---
 net/tap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index 665dee800d0..9bce0d088f9 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -1252,7 +1252,9 @@ int net_init_tap(const Netdev *netdev, const char *name,
     return 0;
 
 fail:
-    close(fd);
+    if (fd != -1) {
+        close(fd);
+    }
     net_free_fds(fds, queues);
     net_free_fds(vhost_fds, queues);
     return -1;
-- 
2.43.0


