Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12329606E4B2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=De2bGksd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSuex-0003z3-4e; Mon, 16 Nov 2026 06:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueI-0003q9-E5
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:22 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueD-00028V-1y
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:21 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so1385063f8f.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827596; x=1795432396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=du6iacM3+OChFwCRCiaLKdvRu0Ssw2623VpPE1+iVeo=;
 b=De2bGksdxQdnEm85qpWN89yX1BqIyfR1GHIE8RAZtnKYwNRbXf9whqGohw3IOo8hYF
 clPE3MvjtwNHZQ7SvOdtPcf0310wS5R/T0q4caSHnyo/4kyS1tIhZBRxgHex7cEKwq0S
 Gu2FwQ149zPxlvt6TByhfphROVhPPX1bIyzbh7NuwBzy1IEKwCEXuOR2F3qR85lIv7LB
 cI+hpNNfOiviIf8NKYveE9pRrgVdmG2PcMB0pUqeAormzz0UiX5MUcYnXZ+VFkPfbHaW
 juUK2gBl9PNi83OjGFjFVAHY3lKK4eMf0jJTFtOelgAX/m018kR/RUUAlE/o/gJubPgN
 aLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827596; x=1795432396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=du6iacM3+OChFwCRCiaLKdvRu0Ssw2623VpPE1+iVeo=;
 b=MVEW8AL1FPfn/PBsNLtX8hxvSY9Ggmhr33yPQ/8dD6Iwla3js3OmwtEhz6UMkAqZPL
 2NJboxmM4qwLn6wrzBZCmMDGLsdsYRdFkrD2j3TDns5Pd9p0bVE0kiw0Wt0NqiOdRF3/
 m/UggFMnCATSGXo+Vw2VIgrALq+OgE4cnQzJZC60NP+W8eiqLN0BikV93d8WizhYgWaX
 hAjgY0vI6uSORqzFo6QRIoPwYquvph3WRROzQQAIeQtsQhqwiOkYVX8e/PlgkvdSRw7W
 xyPmtJIwXteQgnCcTf8fa9bWoRERDpcXmDTazSlZbYIWJlt6ofZ36hFrScnSi9IW58t5
 Ra5A==
X-Gm-Message-State: APuU4Z+NI6hQO1X68adkMa955Qo0b42kug10VlERr9IB0G8vJvsDSOVr
 oRDjGexwLXrPNLLdsvTsXXDfO/0GVPeEFn729P4K2Pw+EQ5IvE6FVnYN50Zmy85nm3qlYQIN0DQ
 NFmEYTIY=
X-Gm-Gg: AZFdTZdxGxKXi/8e7gmqtmSNEvMXYvIBUtWqrvy651OwIUDDEghBcflqr5DactBh2BA
 pk2jBnCQLccHv/wPhFNF6p9n/ZBpGU/LhvjApVrqD0wqRTCoxj821F7lkpqSVsk1WF6jlT/a3eO
 VCWFtRCMZEQD7LPYHmnOhOb/pkyiqjs5nDTALnJcKncBNyVYh9xgbJoSCcNPYsI1dC4LIYPynh6
 XnsC6BBoHS0D4dED6JgiKI2YK/JcgLqR9oqLbHWABjGj0JbyTqHHy4SCi+ZXNPE23WCHfeqKopw
 3PTYoWHlEsGjzAxWOi8hcp8VAv3tMHHqRHLICzNR63MMBrA2dMss2h7n+FL5U72s3ucf1DQWQvh
 3LBmye7PlsL07pv2klyna0LYdPqYmfUIIqo4WB1LuASYNyEcQIwAqxvHdsrmg1k/W/khJm34+QS
 Rg//FRD27AT/19ZoMQ7nlxIcrQANkvu8hgSb7U71HcgvkMRD1SsJvXFYpItkz/eSJFNkVgWvRaO
 r2GERRq0/dwId+9Hv3a8RTN1SYeCZgfXe6V7xqU2/wpKhQ7fdYcF7S03EfnwsKJBjPEVsombQAu
 HN66vCrJhotlVjIYfaXrO48lwIy/ygtnRtsGAnhibZPZuloPV32LqIOC8PIqFG7/4WW9SubtVl6
 U5JK22gzBXfYBm1JRlHkrqfQ8NR3nxJHxxg==
X-Received: by 2002:adf:e19b:0:b0:498:b92a:2f7 with SMTP id
 ffacd0b85a97d-49c71d49040mr20864152f8f.30.1794827595594; 
 Mon, 16 Nov 2026 03:13:15 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/33] hw/net/net_rx_pkt: Handle bogus l4hdr_off when
 validating SCTP checksum
Date: Mon, 16 Nov 2026 11:12:40 +0000
Message-ID: <20261116111303.1692832-11-peter.maydell@linaro.org>
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

In _net_rx_pkt_validate_sctp_sum() we calculate a checksum that
starts at the NetRxPkt::l4hdr_off offset.  If this offset (which
might be guest controlled) is larger than the size of the packet, the
loop that walks through the iovec can walk off the end of it.  The
resulting out-of-bounds read in attempting to convert the iov to a
buffer might cause a segfault.

We also weren't correctly checking the return values of iov_to_buf()
and iov_from_buf() when reading and writing the checksum word: if the
l4hdr_off claims the checksum word is half off the end of the packet
these functions will return the count of how much data they were able
to access, and we should fail if they don't write the entire 4 byte
word.

Return "checksum not valid" if the l4hdr_off is too large or the iov
accesses don't do the full read/write.

Note that this affects only the igb network device; the other user of
this function (e1000e) does its own check on the l4 header and won't
calculate a checksum if it's out of range.

Cc: qemu-stable@nongnu.org
Fixes: 907209e3111dd62 ("igb: Implement Rx SCTP CSO")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4138
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-1-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/net_rx_pkt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index f87b6f046cc..03a35f03154 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -549,19 +549,23 @@ _net_rx_pkt_validate_sctp_sum(struct NetRxPkt *pkt)
     uint32_t original;
     bool valid;
 
-    for (vec = pkt->vec; vec->iov_len < off; vec++) {
+    for (vec = pkt->vec; vec_len > 0 && vec->iov_len < off; vec++) {
         off -= vec->iov_len;
         vec_len--;
     }
+    if (vec_len == 0) {
+        return false;
+    }
 
     csum_off = off + 8;
 
-    if (!iov_to_buf(vec, vec_len, csum_off, &original, sizeof(original))) {
+    if (iov_to_buf(vec, vec_len, csum_off,
+                   &original, sizeof(original)) != sizeof(original)) {
         return false;
     }
 
-    if (!iov_from_buf(vec, vec_len, csum_off,
-                      &calculated, sizeof(calculated))) {
+    if (iov_from_buf(vec, vec_len, csum_off,
+                     &calculated, sizeof(calculated)) != sizeof(calculated)) {
         return false;
     }
 
-- 
2.43.0


