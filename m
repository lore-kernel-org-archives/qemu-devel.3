Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60D2606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RNphCN/D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNyVG-0007K2-R2; Mon, 02 Nov 2026 15:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUP-0006zu-V6
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:51 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUO-0006jc-BE
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:45 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so2013845f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 12:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793650723; x=1794255523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SC1qHyVrmkpxv/nh5NA1V78Ni3DKw4xU1LOHUvCRN5E=;
 b=RNphCN/DAOA5Bw2asc1hS1bNVkoJOgMr394NuBzBsYT3hFOUVPAXd5c4p6opAu/Ced
 rFoKrHlBmZyDOleLxctfvs9m1JNmcYMCF/Ba3wbeYiZek6zhhApw8WJy3L1wBgS8v1rF
 mezfSux/4myAvSVnZBSrBqf9kE9WQo+FoVbzbRlSDZd1fTZtnrq+LEzpKEA9njFhpGc0
 IUqxiHEn0YCjF4OTeB6cvhF3tbBUhG//UtlnWXc35jh4Zf9WTgHFo0pBWgwCx/QLd0e0
 clmzUc2zjzSxDHc1ER8Ki/fpDbX+yg4AH6YOp/rMccTv2G7k95KnwftUl27tKl0kyrUc
 w22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793650723; x=1794255523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SC1qHyVrmkpxv/nh5NA1V78Ni3DKw4xU1LOHUvCRN5E=;
 b=WT25LsLs/HgXx8KiPWKTvh4KQQN2lcI3kFN6+0WJ9nNE5ZpFIVLLZvmIGa03344Byr
 aIGnhIIi5MXuBWodzTsEiM8K4l2A4XTr0UnM4HiY8JxjfVUBFdqEh80WrvhBj5q3Awgh
 DQI8xqzSSR9az3VLgn9kNBqp5kznWCzG6X2ZjI9i6qXAbxaJGAEPuHfnYoxMCYuG3be5
 OeqcGX58T5HIf+YE/33x02iEtWH6+htMavPBgnyBCz6jXJmHSrTdfxZPOJ30r6IUM6wD
 JY4NQDii9CFjMiTWOt7C1SlSLuPQD+WWZO8JE1m1+8tJoJfcGoe/eXA2mcXYNHb77gRP
 Yp3w==
X-Gm-Message-State: APuU4Z8kXdstcFtGWc+vQ8DYmymCJ+SqiceBLRT5ObMn7WhFHv86x++Z
 pF/MI5NeslIrauN/FIcKAip/IFkSw4hH945XTsIiFjkQCuTWuXPTDUclgH0SmlvcYI3x2vrVXLy
 hkZeDx94=
X-Gm-Gg: AYBFou0w15GCH0ufBP/xCd4WslfzLHgZJ3FcUVHWg69aoWO5OJXkYPEam9BCE2/ioXK
 7rnUiOP0h7zmyXPUncTUfLBsdVq+0WOtuBivvbrUGgUykZDk015bixzs12Tg9W/Ji4arq6pIlPy
 tLZTAddamjbAzbh6YJPFwmJQW9TGXd181g/rOkiXP7uvqZI+oSwc0xSO/gRXsVpY1ulxAg+c9Ai
 cvUtgy/xBCu6vH9sM9dCic2zr/MsMuZ6+WOrHkPRvWzYCgY8VwOL6b+GujTmCue2/CsYKI0/tHE
 pN21Yk9hoQxUJK2f4rvykS2kI2x/3noYKd1KrLK3FYWDU9r9HcDiPIGtuaKVMpG458KTYY/FVq8
 yH7vdNdl8xVD7SY+vCqGrH2x552ZCkkm0cscp6diteeJbN8/7tKfIgYzZ+WRFaaeWfBek17OLFs
 VfT9HPbFMz52n9A/r8ZAOdTzlAu+5CLA/YjgBRhaVvUgtqzJ9ozAN9VhXYQEbM1zhtJGRdE93aM
 HMHwT5FTdx7JrnMEy5EtwlFCId44718o57Bq2f6P8DVIWE/6Nu6k5Rhmr56Cx310SmJTaaTo1Vt
 u8AE7eo28IW0FtqS+ZLabKNBb7dLz/9WYgEFaeu5SaVs73UW7UKJsn+BoGEVz9QU1VpNAEi/Piy
 5WgANujmYlDLUA7p0FAQWJv1CGu7LmwLZsTjoJ6mMT/cORyeEJNPaTEM=
X-Received: by 2002:a05:6000:2407:b0:48c:54c0:4cf3 with SMTP id
 ffacd0b85a97d-48e6e2ffc51mr26185603f8f.28.1793650722868; 
 Mon, 02 Nov 2026 12:18:42 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm22152836f8f.30.2026.11.02.12.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 12:18:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH 10/11] hw/net/net_tx_pkt: Sanity check L2+L3 header len in
 net_tx_pkt_parse_headers()
Date: Mon,  2 Nov 2026 20:18:27 +0000
Message-ID: <20261102201828.1879576-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102201828.1879576-1-peter.maydell@linaro.org>
References: <20261102201828.1879576-1-peter.maydell@linaro.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In net_tx_pkt_parse_headers() we examine the L2 and L3 headers one
after the other.  Add a sanity check that the two together don't
exceed the packet length or the maximum IP packet size.  This
shouldn't happen if the L3 parsing was done right, but is worth doing
for defence-in-depth.

Cc: qemu-stable@nongnu.org
Fixes: e263cd49c73c595 ("Packet abstraction for VMWARE network devices")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/net_tx_pkt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index dc2563721e8..c331628134e 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -267,6 +267,14 @@ static bool net_tx_pkt_parse_headers(struct NetTxPkt *pkt)
         break;
     }
 
+    if (l2_hdr->iov_len + l3_hdr->iov_len > ETH_MAX_IP_DGRAM_LEN ||
+        l2_hdr->iov_len + l3_hdr->iov_len >
+        iov_size(pkt->raw, pkt->raw_frags)) {
+        l2_hdr->iov_len = 0;
+        l3_hdr->iov_len = 0;
+        return false;
+    }
+
     net_tx_pkt_calculate_hdr_len(pkt);
     return true;
 }
-- 
2.43.0


