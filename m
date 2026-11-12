Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3797A606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ftKeUHNn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZ8R-0004fp-Gi; Thu, 12 Nov 2026 13:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRZ8O-0004fA-AV
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:02:52 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRZ8H-0004zH-H4
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:02:47 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso827095e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794506563; x=1795111363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z+e5oGU4r5lTIB9R0WOGTLO18IlLvspFB/OoKB4LXQg=;
 b=ftKeUHNny14cA1rkGFkRpWv5oye3W3JpyYJYHmuo67nNW2YV5y/wwTsZR1rXdQomRs
 74en47UQ7swdyA3VvzRQxy9hZxuCz08mjN3SCF/xXUalRyxEMvr9Xr19BZN9whmQLQYA
 Uliqkm08NfDGUKuBJMbmsRfV1+3bYj8cfinIGm4BbsTAtNBjo4vLrr2ctJ46i9B0TNbI
 LG/gklwdChIFV4VhYO3LOYmxIjTTZSx8qW5APJTDiH1lxXdOtFJdGR99cx/8Z/eHPrFk
 M3x5l5M6HTgdp9+BdUBFDLtsNROOdi4Y6f3YloTdHEzxbbC9vYu8YUWIRPK2wQVI+W66
 EZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506563; x=1795111363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z+e5oGU4r5lTIB9R0WOGTLO18IlLvspFB/OoKB4LXQg=;
 b=fAdmgr+aM7iDT+SNBrtBV8DuenI5Rl5PWf6Nt0GcCLQSgE28i89iyh3Ho7f4vi4Fng
 O4ZDWelV/D79a8P8lw3DxHh8TmtGMtER4dtaBBaofpfyVkcSk1UMTxvXpv57iM4Wh03R
 LNJG2TNYxd73bxB4zec37Fsyv+c08uD8VSRaWlW93ER6lv+sCrWUk6+wHFXvUe0Kbisl
 9tgwUEpjYC7nraKbnFztmOAKdRd2hhcZU03xPBi7+VTVY1wxoa1cXxcUD7h7JCk6w+Xo
 fUgv3/DO54M0RUZoOH8WrdgsZQKREIJh6C5enozxVQZEspUGAxkWo6Kh5zs+pK3w4JQ8
 QgRw==
X-Gm-Message-State: APuU4Z9TNmwAWpbm+TJxjuab3cmSFbsB8v6ENFwOdzUbwy+TuXMwaZ0I
 iuHE5sQkaHeSBVUVtbE3bDTSzQApVay9Qdz19/kRr+R1Exq9cXrRAYuVNXrXACZVkAgBI4NQTp/
 FaUaj2Nw=
X-Gm-Gg: AYBFou1xcpED8kR6Fm8XPHAjyUamBxMgs6LATsi0jEVVlRU61po1c77heHCcduG2ups
 YEY0yUFjkU2h3yEGwmr2iw0jv8HUnJXAAUEUIApV9QmelE8O6eGtEAU+ciPj4EhCzL9QBr0dxUD
 vtlhqbuRvKVgkofJnl9dw8dSTibMaZWqIrbOIDDIJKhMJlcVEE6ON7000baGcyMwp+iKmoF5TEV
 KydgRo4uKfSBy+Gd2i8cv/1UN9vpc0lpVvyp4uO5uUg/NnBurL9oqRPQ26nF5ibLy+HTHTDT4rI
 hPpRoE42CGDzze16Ur7/UgSGgRCS70+A1NbYqVBTz2OWbOIgrEaG3yeSRcjZs8TrKwRlVJO2+Nc
 0O4DAe20VAshknkEE2hDllL8/6kwElYjyana7vnqnsK8iQgAzrCMBARUS/ApTzW4RcBB+8C0AbX
 ulPXZvID7Pq0KjSHI1cdwNXJL0wIZ5pPGXOayLO/2FsFB0Eg9DAQcx+61y66LHN/YlpdCkxE+Ea
 0hhOTkLzD1dLx2igiOyGJOLQImt8lGLTeIsH3nrvAvKCR4Gxyf8VS9PNSHLyQB7cSPvk97sNC/h
 1xMjQ/5yOEs/pNOsDvEfKkFHBbSWS0Jvu+K5zQTvECRU/WT8m9L1l7VQT7x6a1Fw70jpJTC7UzV
 sUU2eLI3n3SYcYGf265Q767uSJf7eiBlWLCHAj5iXi7ALKzn8jXV6EUM=
X-Received: by 2002:a05:600c:3d92:b0:4ba:e7:ef3d with SMTP id
 5b1f17b1804b1-4bb559f7044mr479475e9.1.1794506562686; 
 Thu, 12 Nov 2026 10:02:42 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60d9fff8sm521325f8f.52.2026.11.12.10.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:02:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 1/2] net/checksum.c: Correct handling of IP header length
Date: Thu, 12 Nov 2026 18:02:38 +0000
Message-ID: <20261112180239.489819-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112180239.489819-1-peter.maydell@linaro.org>
References: <20261112180239.489819-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
 * assert that the caller provided us a positive buffer length
 * check length before subtracting various header sizes,
   rather than afterwards
 * check that the packet's IHL field reports a valid header
   length that's not larger than the packet itself
 * check that the packet's total length field doesn't claim
   to be smaller than the header

Cc: qemu-stable@nongnu.org
Fixes: 50dbce6538d1 ("net: improve UDP/TCP checksum computation.")
Fixes: CVE-2026-127233
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4720
Reported-by: Xiang Chen <https://gitlab.com/x14ngch3n>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/checksum.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/net/checksum.c b/net/checksum.c
index 537457d89d0..997a0dd2350 100644
--- a/net/checksum.c
+++ b/net/checksum.c
@@ -59,7 +59,7 @@ uint16_t net_checksum_tcpudp(uint16_t length, uint16_t proto,
 
 void net_checksum_calculate(void *data, int length, int csum_flag)
 {
-    int mac_hdr_len, ip_len;
+    int mac_hdr_len, ip_len, ip_hdr_len;
     struct ip_header *ip;
     uint16_t csum;
 
@@ -69,6 +69,8 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
      * struct members (just in case).
      */
 
+    assert(length >= 0);
+
     /* Ensure we have at least an Eth header */
     if (length < sizeof(struct eth_header)) {
         return;
@@ -94,23 +96,33 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
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
 
@@ -120,12 +132,16 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
 
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


