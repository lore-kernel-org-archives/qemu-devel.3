Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83479606A891
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LKehK5DM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSDjk-0007kH-6l; Sat, 14 Nov 2026 08:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSDjb-0007ht-F9
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 08:23:59 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSDjZ-000848-8G
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 08:23:59 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4b7252a32c8so26048035e9.0
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 05:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794662636; x=1795267436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+0maCb+diTV7wSImSXlX11VAHe0aCu50WZLJ8OVLd7w=;
 b=LKehK5DMeZMJchiEDzwNFGsTzJQloIbmXEQ5KuIKX1vMQRE2fsGm2RkAwZINe/fchQ
 bSR2OdfBhZY1Mp3KNuhzHg2R6petXXru3JLVqKtYEUEVbhRHbP7gsAt5andAYC4xOR/S
 8VYp+vS/aCb6Xi2oq/tJ9GeEJh46ekiK87fcR5sIk8szprrfC+r096Kzju71cb1wbnog
 sT+IhLV79tSpfUuuBIaYbTA7STTS4LG/vxAR0S7IG5F0OMAOE9+oDK/tgv7n/9xtUXT/
 u4D3fDich1xRfjqKWaeK+LXxFWwKgiI4joKjTWz7i1a1v4v27jTX6TOcKLYyB66HIqcz
 ir5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794662636; x=1795267436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+0maCb+diTV7wSImSXlX11VAHe0aCu50WZLJ8OVLd7w=;
 b=gAMCnrXpElueqo/4JO/JiijACGj05tRnkPZr+3Fy3gm83RyLV240FWCkz0U87eyMQg
 vFwoRCZFeUluvKLfQsUVv9Bfc+6ESp5Us+Phzk9RiPukCTtL9XHAYO6Kdi+YXaPNIrBZ
 NLwoO5eBcs+3OF6U3q3WKhgbmnn/9sYPRUWrgm+xfih9yGiEm10cBvMzAqcseDWxWl1u
 GiyHHkvaVnFxpBjRVZZKRAJqCSjLY2RGSYhAwsaAhdGjACkEuZhoohoTyPfrOtyVQlJC
 UNwJDz8tHyoIMcwyRyN+xHEqTLauTATWlRYNtJndeZSuvG26GqqFeFVH+Tm9SvDsYp/P
 Yt+Q==
X-Gm-Message-State: APuU4Z9lKOAM81MtkJMB8fCe0/rWYbXcBBhEmdhguJhkb2gtuiUbAbv/
 qI4F4CWdsU0payOAaBR0hc6ybqMSzokXtO+RdqGfS2kdgGqMdiHLOQG0W9ClyWLoIp4qjEaX+Dv
 TQntxtsI=
X-Gm-Gg: AYBFou3h5a4+60I5MPds7WZ438yZy6ZmVJWSOaK9rJcg8YWC20phqEv5smYi1Q7GCqt
 l/K+zAoO2wnx1jqhyYU99MFGmHqB16HJtnATW3HZv5zHOXw13sWGQBo0hDAhysgKs4kTsrCz/+j
 CtqDha4C13rDvMqNcYmdbZh8nVXiV4dzmyKmYzDVr0kBDcEZTBsoNIBSY2DT8/EsGkCRJC1WRJ8
 B34xedXQNokhbcTaU0W9aKP033nvGvQzAFTiu5jsLgPmyxBOqB3q73RiObbRtGznJ1Y15tDMM+z
 dIuuS7DL63FQsjxJvu03rLo4hHGkFtgslgKiNbsVv9EZ3/DnZ+tKrbw+6sAOWINZCL/W+4GArri
 ujWYUN6uoAXasXc8Rgw4YjPhhwTms81QVxTtjmWpFm9IvACJWcBTDEJgjWRqh95azkujWJCMlsz
 NKYdI3U+U9NESF2OKpJOSxnyUVylCVCdRfNAvhFENY/1YMAXjRp69/1AVN9PAXnHjJlm76bvBm1
 pWRppxCk4x4nry7Vr7obwYk/ORdsTouhOCJGwUzSa+7V66l9ZGOrLhnh6OOJfpcbPmXMdO/Bd9l
 l1D5J7JIdhOjqg0wMaXNHIkJfAHGmnRhuCKZ3M9dAqPinNtO59buaUTTMS3mnuvFcq/fLBeJsdX
 VjLyBdFYntPGlbL7+gmJ6l3emjyd69nnbNQ==
X-Received: by 2002:a05:600c:3551:b0:4bb:534b:ada4 with SMTP id
 5b1f17b1804b1-4bb55abdc18mr119972705e9.33.1794662635622; 
 Sat, 14 Nov 2026 05:23:55 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55a0ffcdsm130357045e9.0.2026.11.14.05.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 05:23:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 for-11.2 2/2] net/checksum: Correct handling of checksums
 when IP options present
Date: Sat, 14 Nov 2026 13:23:50 +0000
Message-ID: <20261114132350.1456994-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114132350.1456994-1-peter.maydell@linaro.org>
References: <20261114132350.1456994-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
v1->v2: use 'void *' for ip_payload, and drop casts
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


