Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F88606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mtOJ4dnk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNyUm-00072a-U1; Mon, 02 Nov 2026 15:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUF-0006yH-GJ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:35 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNyUD-0006i8-LX
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:18:35 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so2948349f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 12:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793650711; x=1794255511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t24QZAPTVs1RY8XVA5r9uFyJSsdgfHnAH1qIEZM4lLI=;
 b=mtOJ4dnkDK9thEK5HMex7lAX3ILiUXB79dywiW/nKXJ3Kx/ulvJDqBsgJhtYQ1UgKu
 M1B0YGF7x4S5PLZgFqVQYPgRf/TfBIQYtnGJGbnCxCAH37UCJwDUCiqrBcwwwuhKN7+R
 qaL9RtN9TCVqLoKgQhEcOjO6k0Ump6Gkjp2czTW6zHwR/4SBq7aglEoumrIDXJDXe2Vy
 prIE9rzx7gHFWcp7pF8Q/45H0wGb1+sTqiCR643XXf17BcWeJLqp1089UFkL92h4KbG8
 OFmjecfQ9mNeSB9eB6Gj5lTd2+6o78FgdUD4+ZCQpnrYUlWb4n5tDQEBU9qZvsGQsImo
 VRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793650711; x=1794255511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t24QZAPTVs1RY8XVA5r9uFyJSsdgfHnAH1qIEZM4lLI=;
 b=paeEPPmXDMEuMWdVaBJqXFvzlrfx2zY1pyuaFejbwwKu+lp9kyrp3UnmToWEdGZsP/
 3sQiuQ2Dcuu9hAuXLt/cMuOu7nmm9MxceuFvGdkE2mnwP+M8Ro4eBZR/hNd/8b/caZdV
 BmxP9HC3xU2+zAGeTmXXC47f1wqoGgP1Vq0l+0PVieI6z7w5evVurM8w8clK9smxIpDH
 8kKYUQPKWYYGcI8MmaxjZwIKc6GohPZMFGNYRUryQdoOPNXNSwPX6X1M78Q9hDi0Fchf
 ipnbHluvmOdoNxyU1Y3oYT7NpsTE8SzWCrlg4P14fjDXofyz4U442on95FD+2G3swPCk
 I4qw==
X-Gm-Message-State: APuU4Z8Aaa6xFj1IJTaK6V6FZCwUg4gVuFX4j3Z3sT3makwopjLRL3zr
 xaIL6v5cKP+s8Uo51RV1x595z8ukjinzHhERORVgNpAeOTSGDNW3tCSOD57nncmJ2MFqV7piuUA
 klRXK260=
X-Gm-Gg: AYBFou2+k42oH+kH13lmsV9BtYJwxZmjojfweO20Er/gd/AzjvPtn3mXTx/yFkwEjbU
 AvLbE4dwC7G4qUwSLH83EoZI+10xoTAabXVxeA6tcgzlQ4okIcG0ACI5zw8gZUDIP3SlH0vv91P
 J/k3KnvN1gBg8RCXlCeMtYdhlfXD4yiAFyBvwHOndTpOP8+jpHwz0j9FA2hN+fL6pdt9/HWom/8
 iHgwQ62+1v8CVUJ2rE7pqnaPh4chrvVNrnI8mGuRo9iDJkT6M5icNIgKNsCQBrESPZWoI20kYXk
 WlCCLfEFJWKpX34cnb09hRDy+eNPkaE0k/X8+8mz1HFNqhq47jVJ5ij/Bvlqn7qsKnpbNoeKLU1
 sLYV21z4/gpIi9vto2GaaBg+w+2k0hBWS5cUYxiOCli/zRTuJC/shIrCl2GCrRxVw8s4c4sECy/
 WlQEFBT7h1ZeQ/Xvf+w+imspkWZ7AY2yEssYjPPtUPC0xm7AUeZDM1Yzw4yLqlHBfUpivPBrc7h
 oLidzJkIJl+h3YDHi5wZ3cBXce2wxghWIUyLTT8+AFSlwi/DKlKG2kWqisneRL+fonAk7ZVjYhk
 4s6YR38MBedwKLXOKLp1FV3ftBewEXhKSnPQQ5OCLPNsUKGERx6erDAqtAUpornOKWgsgbFtcxf
 Z9sqBqurnn7nRodfxHe4/WnRW4q67mKPR+3k=
X-Received: by 2002:a05:6000:2207:b0:48e:e98:8b6a with SMTP id
 ffacd0b85a97d-48e6e2db50fmr22513811f8f.4.1793650711593; 
 Mon, 02 Nov 2026 12:18:31 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm22152836f8f.30.2026.11.02.12.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 12:18:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH 01/11] hw/net/net_rx_pkt: Handle bogus l4hdr_off when
 validating SCTP checksum
Date: Mon,  2 Nov 2026 20:18:18 +0000
Message-ID: <20261102201828.1879576-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102201828.1879576-1-peter.maydell@linaro.org>
References: <20261102201828.1879576-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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


