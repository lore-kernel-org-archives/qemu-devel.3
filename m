Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A29D606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=d38SU7N1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZ8T-0004gZ-Fs; Thu, 12 Nov 2026 13:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRZ8P-0004fJ-BN
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:02:53 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRZ8H-0004zO-Qx
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:02:50 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so751895e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794506564; x=1795111364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=89EXNihCvSXSzLQmqgDR8KvMO33G2KOTB+GxhtZ52NQ=;
 b=d38SU7N1rMzUNoydfBJ0bmP/mUsuj2NsVMdgLQ1EtmqAHhY+vANSMu3PgBLeTwJswn
 BTXUI7PDSitQYJMddJJIEScFcJbuHo0VIw1ulSyTG6/dW9peAhESvNSiRaZid9S2OmAA
 OpUO0bVf2jF8eBnHv3TU4pIbo8pTxY9b3ovqyH6fwWb4HIpOPi3iNR/bzma4dMfU512t
 icHAFv2qpE7ghOgft2xCrvZ4NiXtbx+c9d30pUSwKcpMaYv4DsWUh2Z4U9kHeG9XnZih
 vqydWd2X1tmOonswA4L8K73hLxDH6vNV0YIyVTUkpgV/dLp1/4kxtj2lQCjNaSf3rHiv
 hJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506564; x=1795111364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=89EXNihCvSXSzLQmqgDR8KvMO33G2KOTB+GxhtZ52NQ=;
 b=P8iZfMxqGbrUy47rSpEOHQPv4CWtBvvoReN5r/FVzBCL8eFHWxloPchyPFlVTr9lZS
 fDE34I6eaA7mqINLN0FJtR7G7OveOJK9rQ5fjd6GTV+WFMOhjCQug4db8HwQ6LQmVl2s
 C7h8ekK/ZRJXvYzs/FzgqbajT080fiPZvaHpnFNvW8CY9CRV46Y3/Th8K/ksyFdwPvD9
 vY7eTAZNQTV6YKC85yomD9o6P9ZpavGziGt+/8mL9HrysZc/rg1uv8QwbpsoUZJJVTwM
 s7uhLqk0VSUEYwllPz4fgEPftSeAyQ4FuYeuH2aYXB1E64G1lFGxcA9VBjdLEY/54rRJ
 IeRg==
X-Gm-Message-State: APuU4Z912qvjln3v2Pv5S9u7qu9fkOj8fJfGoqsW1v7DyVjBFdC4H9GK
 6+mbLdzamu0PLHrjGwXlI15DIj+caYvYZJ7Vu2+Xnv6bnhPZ5ckq9gHKKWvLbj04+LJ7FIfxSL2
 NIMnhrfw=
X-Gm-Gg: AYBFou3Vas3QCGUkSAkQP5kx51kJ5J4WHufpKfx+aemVA2YtzMehO0oDdM8oVLP2SFD
 SBClsa7NAOYevjLAr34AZCGsMpu2lIz8iiRA32vU/0hpnFwTlbdcdLMODKG001bLTbmxua5Ia86
 dbKdamcJf+Cv6C1Nh0mNnY0EuPpm06KtiPpzBa5JNbAbPca+xAqkaUCsybjLJQOx/Tzobr5ZH+k
 GFEC2hWQ9/QMvLFjhW7WHFnqkXec+KMNKqjWpZaJp0ZkWyy/euDc+6kf5Xfgm33VV+TS1BVBGNg
 gQVf3FRm4TJDxbCnebxV+QqtrvYek6rBLBmUPWmQ+f7HBf1IUTKeesZP2uq4cS5ySneWVDl7AuR
 SF7xBDGgzZ5l3B/MDOhZzZUeycrH/hTuZyhXaPXWVI1o5j4frZEgbzRxbmxcBny2px/kT8djfVR
 xzEnRuKNhZ62N4lnLFL4YxKP5WeCffAlsiXQndPH7pfeh1hBCNCfXMiYHs3Qq3SO4Q7Lhcc7NGB
 19kaABU08UN7ximmQCBZDRsQVnj7Yf2bnlE8v9vcH0kL03g67PrjskQqGvxANd3k7JoI9lXKBst
 qNQRQlNcGfrSTjGTD8r5vbPMvsJFZo1Ld8J0g7dKXc0KuJo58h4WqrlWotHYbGXjoB900Kqn2w4
 fNfr2jHiN8zrrk7LYNXZ1W3H06SnBD/dIyyGN8l3JV08rvT6XTfYBWz8=
X-Received: by 2002:a05:600c:4f84:b0:4a1:fc98:1cb1 with SMTP id
 5b1f17b1804b1-4bb559f5f44mr579075e9.2.1794506563996; 
 Thu, 12 Nov 2026 10:02:43 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60d9fff8sm521325f8f.52.2026.11.12.10.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:02:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 2/2] net/checksum: Correct handling of checksums when IP
 options present
Date: Thu, 12 Nov 2026 18:02:39 +0000
Message-ID: <20261112180239.489819-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112180239.489819-1-peter.maydell@linaro.org>
References: <20261112180239.489819-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
---
 net/checksum.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/checksum.c b/net/checksum.c
index 997a0dd2350..277b2e652d9 100644
--- a/net/checksum.c
+++ b/net/checksum.c
@@ -62,6 +62,7 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
     int mac_hdr_len, ip_len, ip_hdr_len;
     struct ip_header *ip;
     uint16_t csum;
+    uint8_t *ip_payload;
 
     /*
      * Note: We cannot assume "data" is aligned, so the all code uses
@@ -142,20 +143,23 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
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
 
+        tcp = (tcp_header *)ip_payload;
+
         /* Set csum to 0 */
         stw_he_p(&tcp->th_sum, 0);
 
@@ -170,16 +174,18 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
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
 
+        udp = (udp_header *)ip_payload;
+
         /* Set csum to 0 */
         stw_he_p(&udp->uh_sum, 0);
 
-- 
2.43.0


