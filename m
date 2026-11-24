Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0916606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fB+0k1ra
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqaB-00056a-IO; Tue, 24 Nov 2026 08:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqa6-00054Z-NF
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:11 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqa4-0007NP-Ms
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:10 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so3102503f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 05:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795526947; x=1796131747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t7bkANgdfQ8UjA/UG6YRPx6FbK1b8K4BZ/p2pO5Cs4E=;
 b=fB+0k1raH5oAE5HqBZnzjqqu2k4TGN8gOkHwLEyo8GwH4tPmHV4X9y1+WMdtohZL1j
 KLeuQ7WUZ2Y3FNDIBSMZl0jCJTLioMZwa9fQRPcjiVsekkkIEa4eOxplV25veVkbxcTL
 W7X5/ptkYxwv6hujrjFbhteEwMiauSxXtIVi97PAjL0Yzqq+yDWMGH4RpRgyKNwZQplM
 hwDiTvtf4TjXB3jyF+do33IJnX/qYRPUgltTZPMKJ/a0quRHgbHeY3bhbCRYgnvRgp0O
 pxQrgVbuUiF0sWvlmdb0BLvB3uLfB3Tvm1rpHgN14nK2Lw8gY6cNtbifPdyE0HKtS6Zh
 yhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795526947; x=1796131747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=t7bkANgdfQ8UjA/UG6YRPx6FbK1b8K4BZ/p2pO5Cs4E=;
 b=Ps5ByoCLoble8gXBv0OUUr1xzu4rWWWnVQSh/khUj+jnKYSB1SuC+BWF1EuC6nwFU3
 r+C56iGrqImfF5CDGVRnvzKNfs+Hl/8egzKTuX6RZHPN9S9+QGQhCjGW+HQGpR8t4M4i
 oOSBacO1XBwu9A84ZIJwvOXdXk8E0r38ZL7dFkU7ZuB1p+KsWZ5VdexldZjI8DeRCmw3
 LjMeHbX+AjTHRvOUIZOwDIP6Bgl1QbpqSGk7jx555PvVCRqsJkJ+TSwBsko0HKoOruhn
 72AwKGeC1+Dx7ZWURpcam2985rJ2oaPetMBvPKEBhC5u+bMCEP0Dqh5P/gFw9pD22Rvj
 oeZQ==
X-Gm-Message-State: APuU4Z9SA1liAggUsMtRQ+xbekaCUZgzecvbXAgsV/m+rww5qJgku31D
 zJypTgokrDgiu5/24a0pXusSkkT1CLscNIlh5QCw4NuNeOkhtCZlEB0vte6PRXxXH70A5PWdvo7
 h6PkY
X-Gm-Gg: AZFdTZfbVTmQAljXr+BJvJg5NMVHQEl7hx8jBDnNMY4/lwR3T2mfavJJkO4pZeIi3co
 Bj1tYLUwPP2mTlQ4gvGTb/gyKrzFCjZNxfLSGHETTmrKCU2BP2mePPxIwN9Qi3O75399eElI63O
 rfrzewSQRMnCDdmWzVXV3gd2WYyS3UL8DKQoH3JvIzbYSdJgM9aPIzuIGMwtZ6IGPLl5gu8eQSj
 joap0N6JbhZKDz+4bMvsDCdILOs4dWQMr81FPGs5P2SXxFKPBMmw2ytw1N5RMNmNRGp92B53MM1
 WmmOGMx8NtcseclK8zZohgfxlPXv1mss7NlLmHR0cpptb3trbLNJC3E1mMkoooN6z40dPIcVJ9r
 QUTQ8w+LybCULNQ0jYeyjrzYB69RfI6JnSRti3Lu1u/aJJtAuo5MfZe3oCbwRN+7kJdJ67E9Ffi
 3OAA1GwXAlQIbwHHP/CmXaW8tSMlOLH2uGZ4ktntom+d9KALaL+7S/5T1nItWDsu4iZ5pukw3n5
 dEucY1JSfTHHtC4ScHQXO3Q/jjsSlhGx3tomc2cecDw6Szaq/FIgteVb0951WM0s6AFw1bFLq3W
 G9m8ZQboUxg/ny3xkPF8zhKGxoc3DBziBeQ+bejaCN4JkrFseo+R8V41+i6mTScE6cvSv6cadyT
 x2OWZLdpWo7hTZ6T5+O4qm6lol4CT0v0fvFx79z1GrxxYuh1oMaU3nlw=
X-Received: by 2002:a5d:63c5:0:b0:48b:4a2:8175 with SMTP id
 ffacd0b85a97d-4abb4e64383mr20923920f8f.43.1795526946883; 
 Tue, 24 Nov 2026 05:29:06 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b2c9sm29098031f8f.31.2026.11.24.05.29.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:29:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] net/checksum.c: Correct handling of IP header length
Date: Tue, 24 Nov 2026 13:28:56 +0000
Message-ID: <20261124132904.138731-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124132904.138731-1-peter.maydell@linaro.org>
References: <20261124132904.138731-1-peter.maydell@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261114132350.1456994-2-peter.maydell@linaro.org
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


