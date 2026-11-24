Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5FF606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=R0c+XFdG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqa9-00056J-Mq; Tue, 24 Nov 2026 08:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqa7-00054a-DX
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:11 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqa5-0007NW-JI
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:11 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so57477895e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 05:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795526948; x=1796131748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MX3EvT9gWZIQrSqtLnfI9TAsoPsBd5+upIdgO+sQCF4=;
 b=R0c+XFdGhWr2kqsxhJcbbDGQc1W708AZs22EVjH+Kufiu5uKZAsaXPEhEXtvfFjlzD
 3l8ICIZEJzvuUmSwGDG67KmAbyGm8ENeE5MzVJ8wlzbSdMfMl3qGwEQi2VgWpZtutUW1
 bkOrG738jVXP9zEBecmqk1/2zQNaReEZhBPW8spXJPyBq9RvDSa8zK1s5+96CV/Jv84X
 DNbFToIW9UEMm44BQioRHhONOKz8L62t5k1EEEaav632ocN7f/jrui+VOOGOlGKItl10
 AQ7551vL7sXOu2JcL76E4rXHMXAtpNSsAfEfGaNTkBquxKf9VF/Bz8L/kJtaFoLH0gE8
 26Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795526948; x=1796131748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MX3EvT9gWZIQrSqtLnfI9TAsoPsBd5+upIdgO+sQCF4=;
 b=EX9p9AgF9MR2/QyNEpmDXci7I5FdsOYdJ8qLPUssJkz/BFB9WBFSeE7ctbPSLVDAdM
 5X2ItuqR220h0h027iI9wCvxTIQBwTW+OWqTpjKwLoz3pa+ZxcTYUkQU77gjU6PN9EU6
 dKOlZB9ovIxU8NvfCzgw97QinNvoBRFpXM1jnF+CG3cPUFx1Tcvp4E7OPpQWtlFqudly
 oDQ19gC6Gf6xmpFQmXgB//tGI/zK6ZXHXoPR31+b1DiwCyN2YxGyS3SNDVTZ0l6Qw6ie
 K11KpgFKTGj831zIUMLPezX+vXV0bXCDxFxg/vA1f3WIvFRg8lPjtG5ndVKh9RAaa79E
 35mQ==
X-Gm-Message-State: APuU4Z8H+rFNrReKcQ5SkikZBbNszNLK0LalB+VIp/AFR3uBQLmYWliu
 d8lqxFTau85h2HeX74t+orIWMpLGLXaX2YGyEYiMjgeZAiGLr4VL0VSekzY4Hg+M81dx0hIPDOn
 erDke
X-Gm-Gg: AZFdTZfTdfDLUc6a67XrRauJX/CvbhIOeNxhFrAD/Ttr03WsTNqeNxGG/Ok0R6VuCt6
 EszrRDqXo8UDled61h6flomVc9W1jLCJiU8cfIvWb4Ir6RSNjjA/zm5QMugb3jltPnzbTp8VrC1
 2qD3AobiEWF9AtSvNDwrFhUqLYO47yvL4HOTXzQfymTTIrPtfjG2thwn4w6WYM9pgiqcFXM+5sy
 cWxxSLx9ViPLpVUXf8vDIwuDXduqZdEzB+nrL6s8fepzf04lDDKURmUu8xIbdKAyOilervpx/3J
 pqBko6BIVurLg3TfDY3WJzjLZ3+0r2WXrebrgK0UNMbybqLdhELOr6ECBwpb8iOvNgigtTb4Q3g
 e0d7i7b7Eow3iNDUOgp/AEeBQbUt6hqn/aDl1qk+LSD/T34ZzijNhKV/uUAccvQMGYX2i2R5agU
 4S4tjjM1bYsYZWVa1yScnVbM0KjN+6EG35UFUpO/i7Dw1VX3XDIssvmU272qfBsTUO8824r9EV3
 HweTcI/Q+xL5c3FLmAGqx7B4Edr4zN0+bxQMN3X04B33JupOCDsV26TZkkPbiuR9ysyms/kkOz1
 cmOiR4QO4sz4o5WFVtSPS7sKNqnXNlQ+EtBekT9vfNALHgCM1i5lyYUYbUy8/JNf25kg7VL77fb
 LGggv5yoFECtErjwn2AwRH26/X5s9OY/jUA==
X-Received: by 2002:a05:600c:3491:b0:4a2:c2b:a91b with SMTP id
 5b1f17b1804b1-4bb8880014dmr309445135e9.10.1795526947965; 
 Tue, 24 Nov 2026 05:29:07 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b2c9sm29098031f8f.31.2026.11.24.05.29.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:29:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] net/checksum: Correct handling of checksums when IP
 options present
Date: Tue, 24 Nov 2026 13:28:57 +0000
Message-ID: <20261124132904.138731-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124132904.138731-1-peter.maydell@linaro.org>
References: <20261124132904.138731-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

In net_checksum_calculate() we calculate the position of the TCP or
UDP header in the buffer with:
  tcp_header *tcp = (tcp_header *)(ip + 1);
where ip is a 'struct ip_header' (and similarly for udp).

This only gives the correct location if the IP packet has no options
and its header is the minimum length.  Otherwise we will corrupt some
part of the packet in writing the checksum word.

Fortunately packets with IP options are rare (and often get blocked
by routers or firewalls), so this probably didn't often cause
problems, and the incorrect offset we write to is always inside the
packet, not out-of-bounds.

Use the IP header length value from the packet to locate the TCP or
UDP header, instead of the fixed minimum size.  While we're adjusting
this code, make sure that we don't assign to the tcp_header or
udp_header pointer until after we've made the length check that the
buffer is big enough (the previous ordering of operations was
harmless as we never used the resulting pointer, but not ideal).

This was mentioned in passing in issue #4791 (which is otherwise
a duplicate of #4720).

Cc: qemu-stable@nongnu.org
Fixes: 50dbce6538d1 ("net: improve UDP/TCP checksum computation.")
Reported-by: Alex Meiburg <https://gitlab.com/timeroot.alex>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261114132350.1456994-3-peter.maydell@linaro.org
---
 net/checksum.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/checksum.c b/net/checksum.c
index 9e4ba1bc910..d6925e9a496 100644
--- a/net/checksum.c
+++ b/net/checksum.c
@@ -62,6 +62,7 @@ void net_checksum_calculate(void *data, size_t length, int csum_flag)
     unsigned int mac_hdr_len, ip_len, ip_hdr_len;
     struct ip_header *ip;
     uint16_t csum;
+    void *ip_payload;
 
     /*
      * Note: We cannot assume "data" is aligned, so the all code uses
@@ -140,20 +141,23 @@ void net_checksum_calculate(void *data, size_t length, int csum_flag)
     }
 
     ip_len -= ip_hdr_len;
+    ip_payload = (uint8_t *)ip + ip_hdr_len;
 
     switch (ip->ip_p) {
     case IP_PROTO_TCP:
     {
+        tcp_header *tcp;
+
         if (!(csum_flag & CSUM_TCP)) {
             return;
         }
 
-        tcp_header *tcp = (tcp_header *)(ip + 1);
-
         if (ip_len < sizeof(tcp_header)) {
             return;
         }
 
+        tcp = ip_payload;
+
         /* Set csum to 0 */
         stw_he_p(&tcp->th_sum, 0);
 
@@ -168,16 +172,18 @@ void net_checksum_calculate(void *data, size_t length, int csum_flag)
     }
     case IP_PROTO_UDP:
     {
+        udp_header *udp;
+
         if (!(csum_flag & CSUM_UDP)) {
             return;
         }
 
-        udp_header *udp = (udp_header *)(ip + 1);
-
         if (ip_len < sizeof(udp_header)) {
             return;
         }
 
+        udp = ip_payload;
+
         /* Set csum to 0 */
         stw_he_p(&udp->uh_sum, 0);
 
-- 
2.43.0


