Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037FF606A33D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wMULg9u5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSDjn-0007lP-0y; Sat, 14 Nov 2026 08:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSDja-0007hq-BX
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 08:23:59 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSDjY-00081H-5F
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 08:23:58 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso10400175e9.1
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 05:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794662634; x=1795267434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AYigO0Jz9iiefYHwMEhCa+1yikT++DWVv7odFVY6EkM=;
 b=wMULg9u5RgHJORL2hjCPq7NiFRt5r1ngoQHG6dPz7xkkjJTqaqrm7NVMjretN3aGte
 YPWbUnfGt4YLwYJn4zjUntLYxaVLl52Jx2CDYHZmUqBoYDl2FwkOW44QzEwxXQeqf5zn
 DzacNLTM1DK4U9bgtJK9yzL/TcuCukFOkd51J0pkzuSUqCc8wjeVrMWyMQDBdJk1ODtc
 azP/TjfbM36spUSWBXyeLhZYqO/6NXCB4ArpiE51NSxL9n2lVB9cxX8h8m4aNM+y/2a8
 vmu7+JMEwo1kkF2lIIVQp+Bt91vAxkznF9NI2ZLSFTjvoRXSTVUkQFXaFVUjs2aCoFFh
 mBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794662634; x=1795267434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AYigO0Jz9iiefYHwMEhCa+1yikT++DWVv7odFVY6EkM=;
 b=g+0Ko25xbF4Q2i1mBmbaHz78rqEJTHNRgKvVxcFJQ/hKngbfrzFrmNc6gMBtfjA9KH
 YNFtOcQqZHqiaoLJugOOk26wEMplDi5+0AVlVQAC3WhNQI/sOlAWOrgkBB32LJWuU0ZZ
 O8l3bnhU7cc0vmqXtbbt/1TYqo9HPdR5lPNXwVWGx2BXeBfweG4QsgjPG9Ko+h0ObW/B
 rZaGZwc5sm4VXHuMlXGV/0vtJZJ5nZjvRn0o7ZJStTxOEtncg5/NycevizI0gZwLk2Ut
 BpcRRl7zDzVP4QuPLeypJACHjYJwC2IAWbWQcg4fA72G3VdNzdJj7/WVhi93xhVgMNy3
 ZLyA==
X-Gm-Message-State: APuU4Z+nYsEDhVyKNd4dcSRDN3ZZWRHpM3Ns9D3ByjSzj7tJCsdF84m6
 XSmiiZmfQgTHn/j4gG65O5S/M18Lovdw+q+Hxpco3KBCUpTgo/+ZLQAAsJ+C22eGUm4Ps0w+z2/
 qSX9gWow=
X-Gm-Gg: AYBFou3fj6kb+AbXnc2nIDRJ8dVHX0u41aEYbWQwDDtX2PeuWjSA3wqjdzXxcfkXMCO
 j0un3E064maM/pwCw6vn+GEHjamhSUabiTDPuJnwYKOcfRJ49xofYtNPW3+xusLSILgAM4xEZ7b
 iuHsdiQQIpJlzC5qSd3i11FEYKSp60iMzEpJxdTiKFgGBBwYj8GtzFVedsO0Dru0bcKwApyIJuy
 DRtWbr2VelgSNqrwZg49eQswFlYPEe7On8pXC3gZczMEQ2vNyAeujvbrGrxSkpzI0sGxZ/wRi3k
 bEh//E1pQiMhghgmRA2KvbaDG+Q9hvcckwWGmBk9P26D1Cc3epStr73jsmpDX1io6Yd7nXBAL+K
 xjlBZ+xXe/lSaY0VM1lG7exiosgpltqFRp2VGfAnsYnMdFYNj6ncNvM3cvDJ7cXBbEeqxvkuzaw
 ufJ18EEHzpV53EQwMBYt7o/Zo7UzpqPLqxcJrPky0n7hHd2kGrCEqZFmuwqXkrxpKPBZ8ruzcIo
 F7DViyyCqQqZRJjam6N+8ixqsbDbP9fjViCk3J8DyrMJzjzrn6x5Z991nv0G3ZzRGqMd6dL+wcV
 3PYFR4BkAA/nLm0238oj7Djite82i4T56yyMh+7i1POLYXLNCX7ld40/ogUW18l/ewQnTdM9CBN
 JiJ2dV8bjqEC/w6Ykyrb49yOwvKBEBsceGA==
X-Received: by 2002:a05:600c:4585:b0:4a1:cf60:dcc3 with SMTP id
 5b1f17b1804b1-4bb55a8ccaemr116807415e9.29.1794662634197; 
 Sat, 14 Nov 2026 05:23:54 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55a0ffcdsm130357045e9.0.2026.11.14.05.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 05:23:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 for-11.2 1/2] net/checksum.c: Correct handling of IP header
 length
Date: Sat, 14 Nov 2026 13:23:49 +0000
Message-ID: <20261114132350.1456994-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114132350.1456994-1-peter.maydell@linaro.org>
References: <20261114132350.1456994-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

In net_checksum_calculate() we are careless about handling of the IP
header length, in a way which can allow it to become negative for a
suitably crafted packet.  This bypasses the attempt to check that
it's big enough, because in comparisons like
  if (ip_len < sizeof(tcp_header))
ip_len is converted to size_t and we do this as an unsigned
comparison, so negative values of ip_len pass the check.

This results in net_checksum_tcpudp() attempting to checksum nearly
64K of memory (because it takes the length as a uint16_t), which will
typically be a read off the end of a buffer resulting in a segfault.
If the attacker is able to set up a situation where the read doesn't
fault, it's possible for some callers that the 2-byte store of the
updated checksum is an out-of-bounds write.

This code is used by at least xen-nic, virtio-net, and the COLOj
filter-rewriter, all of which are in QEMU's security "virtualization
use case", though the write is probably only exploitable for the
filter-rewriter; otherwise it's just a theoretical "information leak
to guest" of a 2-byte checksum of 64K of host RAM.

Improve the checking of lengths in this function:
 * make the input length size_t as it is a buffer length
 * use unsigned int for internal always-positive lengths, so
   comparisons are always unsigned-vs-unsigned
 * check length before subtracting various header sizes,
   rather than afterwards
 * check that the packet's IHL field reports a valid header
   length that's not larger than the packet itself
 * check that the packet's total length field doesn't claim
   to be smaller than the header

All the callsites are already passing an unsigned value to this
function, with the exception of those in ftgmac100.c and imx_fec.c.
Those two pass an "int" value which can't ever be negative.

Cc: qemu-stable@nongnu.org
Fixes: 50dbce6538d1 ("net: improve UDP/TCP checksum computation.")
Fixes: CVE-2026-127233
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4720
Reported-by: Xiang Chen <https://gitlab.com/x14ngch3n>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v1->v2:
 * use 'size_t' for length argument, and drop assert(length >= 0)
 * use 'unsigned int' for mac_hdr_len, ip_len, ip_hdr_len
---
 include/net/checksum.h |  2 +-
 net/checksum.c         | 32 +++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/net/checksum.h b/include/net/checksum.h
index 188e4cca0b7..6c565f2e0ab 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -30,7 +30,7 @@ uint32_t net_checksum_add_cont(int len, uint8_t *buf, int seq);
 uint16_t net_checksum_finish(uint32_t sum);
 uint16_t net_checksum_tcpudp(uint16_t length, uint16_t proto,
                              uint8_t *addrs, uint8_t *buf);
-void net_checksum_calculate(void *data, int length, int csum_flag);
+void net_checksum_calculate(void *data, size_t length, int csum_flag);
 
 static inline uint32_t
 net_checksum_add(int len, uint8_t *buf)
diff --git a/net/checksum.c b/net/checksum.c
index 537457d89d0..9e4ba1bc910 100644
--- a/net/checksum.c
+++ b/net/checksum.c
@@ -57,9 +57,9 @@ uint16_t net_checksum_tcpudp(uint16_t length, uint16_t proto,
     return net_checksum_finish(sum);
 }
 
-void net_checksum_calculate(void *data, int length, int csum_flag)
+void net_checksum_calculate(void *data, size_t length, int csum_flag)
 {
-    int mac_hdr_len, ip_len;
+    unsigned int mac_hdr_len, ip_len, ip_hdr_len;
     struct ip_header *ip;
     uint16_t csum;
 
@@ -94,23 +94,33 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
         break;
     }
 
-    length -= mac_hdr_len;
-
     /* Now check we have an IP header (with an optional VLAN header) */
-    if (length < sizeof(struct ip_header)) {
+    if (length < mac_hdr_len + sizeof(struct ip_header)) {
         return;
     }
 
+    length -= mac_hdr_len;
+
     ip = (struct ip_header *)((uint8_t *)data + mac_hdr_len);
 
     if (IP_HEADER_VERSION(ip) != IP_HEADER_VERSION_4) {
         return; /* not IPv4 */
     }
 
+    ip_hdr_len = IP_HDR_GET_LEN(ip);
+
+    if (ip_hdr_len < sizeof(struct ip_header) || ip_hdr_len > length) {
+        /*
+         * Ignore packet with an invalidly short IHL, or which claims the
+         * IP header is larger than the buffer
+         */
+        return;
+    }
+
     /* Calculate IP checksum */
     if (csum_flag & CSUM_IP) {
         stw_he_p(&ip->ip_sum, 0);
-        csum = net_raw_checksum((uint8_t *)ip, IP_HDR_GET_LEN(ip));
+        csum = net_raw_checksum((uint8_t *)ip, ip_hdr_len);
         stw_be_p(&ip->ip_sum, csum);
     }
 
@@ -120,12 +130,16 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
 
     ip_len = lduw_be_p(&ip->ip_len);
 
-    /* Last, check that we have enough data for the all IP frame */
-    if (length < ip_len) {
+    /*
+     * Last, check that the packet's total length field doesn't
+     * imply a negative amount of data given the header length,
+     * and that it's not larger than the data buffer we have.
+     */
+    if (ip_len < ip_hdr_len || length < ip_len) {
         return;
     }
 
-    ip_len -= IP_HDR_GET_LEN(ip);
+    ip_len -= ip_hdr_len;
 
     switch (ip->ip_p) {
     case IP_PROTO_TCP:
-- 
2.43.0


