Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B24606FE99
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DLaLrIom
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSufv-00054V-0g; Mon, 16 Nov 2026 06:15:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueO-0003r1-Pk
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:30 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueJ-0002Af-25
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:26 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so33920465e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827601; x=1795432401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kL4SgvltG+W6ILZgCdTxarRkRdAKAfKGrZ36FtoArh4=;
 b=DLaLrIomN4ZAmrSJmDA+sQiJzHnFannjHwcxlA2w8587Uk3vBtpXGnB593AEYet5Cx
 ztV0sEmW0r8U2v6C/gYL8vM4X3ASMIttA4tVqAJiAZOe71SISCuYlx2kJV+Wvo/Q99u4
 BgULn5dRlmUJ/mK0pIADsjs06tq90bQCzFedcZ5DxydnXVS3g9D38cGwUVBJZNpAzYOx
 cXDNiVSpDM14FlNt0vwhPuHAlLMvw2X54P3w5X3YXMAkY+7+GrjlpNLgxI+pRQwDZSZA
 ep+uX/U2koPx9a3qrtpzt8t+zJFcFOJC7AwMXg3JY+1uDHJ4ZectGTX3xXJiOAtOgETT
 Zbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827601; x=1795432401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kL4SgvltG+W6ILZgCdTxarRkRdAKAfKGrZ36FtoArh4=;
 b=LsapmWOGG7v0SH78q6tdEhB23H1TTIathwazdywohjq+tI9x5JqtVn5w3+Thc9E5ig
 C9duxdlub8FFb8HKkI8VoUt7yHPzrz3pfi3+0J6o97k36rz8mR8zsYgHqiYL50tt2qUM
 g7DYq7TRV+/bsquspFi9x/zgLXRFWBtc+McY82WpdHyHmSIcgPhpM6IndhOirCpHn39L
 V1yrsWfATZ64hgKXVhX7z1uTL6LpU6qDzav8Tc6zAfdxvvSTfC+/5mKTJRJgLFXdRV6X
 Es/48z6PRCZjD3T8fjE2xP9FNXWg1o+/xegqMfzgyWELkuBIUwuOF8s30k4fxdMx055U
 zFJw==
X-Gm-Message-State: APuU4Z/xBCjIbqe09qosZyrPYsvTQAubWiNDa+QNJn7JuU/Bjv3sZmTO
 tcPUq2eInX3cVJjB94r+zjra5t5SSMK4yudXRPfX2ZYfyfagl6pA8Tf/vkwK6rH2FS+j3wECOm3
 yJeQbTOI=
X-Gm-Gg: AYBFou3x+ZCY9EUQwcGrY4IytTb/T2k3Is/TXExTzjRzDephR0+oKPHuzzAwe4+0GxX
 Dd+R6DV+yRB+KWoS9GRTUA0nmeHuAWucDjs8k0ZeovM75rEFJ6gxyBH2HRNHDxIcIYmSzbw2QVj
 QmLzhqqkEDyWCGeKLQ28wIQWZOAYFF8GZHpSG4nUTJyGAcxdYTRi8AFcoEKNDfJu8izJdGYSP8P
 Q0WKBVJOxDW2kKHs4yCdP5ajntgGKpPpwg7d0DH/WVhV0M9yLZExr435CLQB5TubltQvnnWf9J9
 MPUrv+PhVzA53yX5Fqzvv4JsMyPNwxmVigHyZ+8YFs3J/VI6vzkejaBejViInbKW4wKFOlOzcgm
 ldlws/rUMrc4VOkE51DS85VEa5ve5L6eNBQy+ZaEKJHERlWqEeyPrcHgPdqxyUOxDV3oWhvSF27
 FjRGk8iKJWfmzvbXPkCPIwSM7TR51UwEEuJMpEMVyDOwYC/1C+72MwSooSAowS72SCCOjqjsX8T
 kNtsWRqdmK0CRIq/7i1Sk7I5/poI8TjrwFzGtNXtLX43Td9tUay2cF0Gsy9phl5Q/C4Ea3IrO08
 VEAEuMgcBE+e9leBRFBudqktxqJdb9cUC6vFusA4w1Z/n7/Lcj1CgPfRj6T3T25idgbMC4Qv/nk
 fEci+hHOV+Alri1S9evyvpKDvABsmbtv/lA==
X-Received: by 2002:a05:600c:3b16:b0:4a2:1960:6fa with SMTP id
 5b1f17b1804b1-4bb55a6116bmr221997925e9.4.1794827601376; 
 Mon, 16 Nov 2026 03:13:21 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/33] net/eth.c: In eth_parse_ipv6_hdr(),
 fix check of input size
Date: Mon, 16 Nov 2026 11:12:45 +0000
Message-ID: <20261116111303.1692832-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

We already have some L4/L5 header bound checks. Add the missing
coverage for IPv6.

The IPv6 header parser incorrectly derives L4 offsets greater than
actual values. Adding a bound check without fixing it would reject
valid packets while fixing it without adding a bound check can result
in an out-of-bounds access, so fix it along with the bound check
addition.

One fixed problem of the parser is that extension header size is not
properly computed for the Fragment Header and the IP Authentication
Header.

RFC 8200 "Internet Protocol, Version 6 (IPv6) Specification" section
4.5. "Fragment Header" says the Fragment Header has a fixed size.
The byte represented by ext_hdr.ip6r_len is reserved and "ignored on
reception".

RFC 4302 "IP Authentication Header" section 2.2. "Payload Length" says
it specifies the length of AH in 32-bit words (4-byte units), minus "2".

Another fixed problem is that the parser continues parsing extensions in
noninitial fragments.

RFC 8200 "Internet Protocol, Version 6 (IPv6) Specification" section
4.5 "Fragment Header" says the noninitial fragment packets have the
Fragment Header containing "the Next Header value that identifies the
first header after the Per-Fragment headers of the original packet"
followed by "the fragment itself."

Therefore, the data following the Fragment Header in the noninitial
fragment packet must be treated as a fragment instead of another
extension header, regardless of the Next Header value the Fragment
Header contains.

Fixes: eb700029c783 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
Fixes: 75020a702151 ("Common definitions for VMWARE devices")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4155
Cc: qemu-stable@nongnu.org
Reported-by: Lazymio <mio@lazym.io>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261109-eth-v2-6-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
[PMM: fixed typo in comment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/eth.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 55d85cecd1d..484f61ef31d 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "net/eth.h"
 #include "net/checksum.h"
@@ -473,7 +474,9 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
     struct ip6_ext_hdr ext_hdr;
     size_t bytes_read;
     uint8_t curr_ext_hdr_type;
+    uint16_t buf;
     size_t input_size = iov_size(pkt, pkt_frags);
+    bool subsequent = false;
 
     info->rss_ex_dst_valid = false;
     info->rss_ex_src_valid = false;
@@ -513,25 +516,73 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
             return false;
         }
 
-        if (curr_ext_hdr_type == IP6_ROUTING) {
+        switch (curr_ext_hdr_type) {
+        case IP6_ROUTING:
             if (ext_hdr.ip6r_len == sizeof(struct in6_address) / 8) {
                 info->rss_ex_dst_valid =
                     _eth_get_rss_ex_dst_addr(pkt, pkt_frags,
                                              ip6hdr_off + info->full_hdr_len,
                                              &ext_hdr, &info->rss_ex_dst);
             }
-        } else if (curr_ext_hdr_type == IP6_DESTINATON) {
+            info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
+            break;
+
+        case IP6_DESTINATON:
             info->rss_ex_src_valid =
                 _eth_get_rss_ex_src_addr(pkt, pkt_frags,
                                          ip6hdr_off + info->full_hdr_len,
                                          &ext_hdr, &info->rss_ex_src);
-        } else if (curr_ext_hdr_type == IP6_FRAGMENT) {
+            info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
+            break;
+
+        case IP6_FRAGMENT:
+            bytes_read = iov_to_buf(pkt, pkt_frags,
+                                    ip6hdr_off + info->full_hdr_len + 2,
+                                    &buf, sizeof(buf));
+            if (bytes_read < sizeof(buf)) {
+                return false;
+            }
+
+            /*
+             * Per RFC 8200, the Fragment header does not have the Hdr Ext Len.
+             */
+            info->full_hdr_len += 8;
+
             info->fragment = true;
+
+            /*
+             * Detect a subsequent fragment per RFC 8200.
+             *
+             * A subsequent fragment contains no extension headers while the
+             * Next Header value identifies the first header after the
+             * Per-Fragment headers of the original packet.
+             *
+             * The subsequent fragment is detected by checking if the Fragment
+             * Offset is nonzero.
+             */
+            subsequent = extract16(be16_to_cpu(buf), 3, 13);
+            break;
+
+        case IP6_AUTHENTICATION:
+            /*
+             * Per RFC 4302, the Authentication Header has the Payload Len
+             * instead of the Hdr Ext Len. The Payload Len specifies the length
+             * of AH in 4-byte units.
+             */
+            info->full_hdr_len += (ext_hdr.ip6r_len + 2) * 4;
+            break;
+
+        default:
+            info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
         }
 
-        info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
         curr_ext_hdr_type = ext_hdr.ip6r_nxt;
-    } while (eth_is_ip6_extension_header_type(curr_ext_hdr_type));
+    } while (!subsequent &&
+             eth_is_ip6_extension_header_type(curr_ext_hdr_type));
+
+    if (input_size < ip6hdr_off + info->full_hdr_len) {
+        return false;
+    }
 
     info->l4proto = ext_hdr.ip6r_nxt;
     return true;
-- 
2.43.0


