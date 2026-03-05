Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7B3F30946
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 11:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6j1-0007zP-Mv; Thu, 05 Mar 2026 06:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy6j0-0007z6-7A
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 06:18:38 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy6iy-0000R8-Bs
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 06:18:37 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439c9eb5d36so1566244f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 03:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772709514; x=1773314314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kBw5xZpZ5HLo1LF7ZTMTO+WtNbjWd3O9pSahygjjBYA=;
 b=BZsq7sHr7zWYDZavmH9jPZxkPR9hX3QgFjICW2LTaKLAI3UIwljEL/TdpspuX8HbTD
 Tv8Tho34p9wW9geY3qvG3sV1QtVPSJjXnvK+jSpNkKgRfv/loFbk6D5iPF5BnHXGbmqC
 CtlWyn/eUmXJEgoEwa2H9aahtPP/j8ijA5qLx5QpD34mWXmrbbo+Komt5TIUSiDt2wWV
 8gvvNwsi2ADnWqIPNQi7SBdr0hJF6afry3/ckrD4YEnPahaGXigJB+TqCkc5nWlYs/5G
 LRGJ+OAF5VZbtB/39sPmNoqLxi1fCrrUJxXwBJD3mNOzfjlLN8ucOBEbB6JseoDS7rQ9
 alLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772709514; x=1773314314;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBw5xZpZ5HLo1LF7ZTMTO+WtNbjWd3O9pSahygjjBYA=;
 b=Afh0jnCB56n9HYjvq8oHxjcO8+L9FlYNUY8sMJmfihFuK9bks6WZskIOwsfzEcMq/P
 65H4NcI0jSiOuw+MjXUG1Sh6JiTBs6qGd70Hd28ZjaYxFxyz1McHtnjJ5UX+ZirTEjJ6
 Km3gkrqPAd/YA0t4NpV6eBV5J66msoA0ObVMJGz6l3etBCD1mugG55pE8Nc02/bBs5YM
 Z+TPmAFutkJ57rFjT77Ydj7M17sgVXtCneO/+XDGfg/eCbsRz/UZGdYIsweHNUe9MsMm
 v2OYEwAB4HTPsAADU2ocua6P8KC9ZYiMKsq4P24GkWnTha2jWmohk+xCuiaX+xq10gDb
 +vXw==
X-Gm-Message-State: AOJu0YxJ6aD5MEXpqjfALEg/h47dT5d4HbmVCzPzQhFx+2ZziIosAhNe
 rYoC5xmT4HxRTHvnAGxW0aqnzQIcMZfxz/eMmvHXHZbgjpSZvYA/A+oT3BjWhAS8POB9H2Dse++
 PABqz
X-Gm-Gg: ATEYQzyyhO2kpBn3hkFkiI/QwTZoHhPY8KduJazCHa7I6dTAQ6tiPJN0gLWLCMIRFq/
 Vc22nr0QPSExyMzMhNFr4n/Wbj1khH/WAqDP9oYUGe1JYStcYU91oTROj6TvVgqwoYJp3P/4yRH
 JU1FyftcEmChp/vRxOUp2pvmqH21A0BXpW26NGD59RZnWqnguV7gLU6UduDbL1v36U2XajhV9Oy
 fIss1YXJPaW2P43KwI+q+Y3YwGCFCNGDo2qtw+IuKgqUTpUEnnnRA01T2K/shzlHm58ZGsmFL/I
 24GMXzCl1BBhigee89MW3thgs5vCQxHyB6h4Oa1trRa9WHDCT7w14GoIawvIVf9DnxWi3OKZXsb
 Qt5qmmox+jVSbMUgJfD69Ol5dqZyq/8o2GcHACFqZGVJYfvLA+wJNRUfmhs4jiq0g+LuyLVJgQW
 e5Dxw8h6TsPMp1TFfohWmKCTfsqYtBX53ujhoXMmzYJGLntkHU6W45QB4+Y0SqHJiOojYcbJn9k
 JFgnd43VW38IZrzR9re2GmzRBDrsNQ=
X-Received: by 2002:a5d:5d82:0:b0:439:c5c5:4146 with SMTP id
 ffacd0b85a97d-439c7f64bdcmr10642548f8f.11.1772709514291; 
 Thu, 05 Mar 2026 03:18:34 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b1b97927sm35837007f8f.28.2026.03.05.03.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 03:18:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH] hw/net/rtl8319: Work around GCC sanitizer /
 -Wstringop-overflow bug
Date: Thu,  5 Mar 2026 11:18:32 +0000
Message-ID: <20260305111832.1068093-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If you compile QEMU with GCC with -fsanitize=address and
-Wstringop-overflow, this causes GCC to produce a false-positive
warning which it does not produce when the sanitizer is not enabled
(and which makes compilation fail if you're using -Werror, as we do
by default for builds from git):

../../hw/net/rtl8139.c: In function ‘rtl8139_io_writeb’:
../../hw/net/rtl8139.c:2264:17: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
 2264 |                 memcpy(data_to_checksum, saved_ip_header + 12, 8);
      |                 ^
In file included from ../../hw/net/rtl8139.c:62:
/home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
   50 |     uint8_t  ip_ver_len;     /* version and header length */
      |              ^~~~~~~~~~
../../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
 2192 |                     memcpy(data_to_checksum, saved_ip_header + 12, 8);
      |                     ^
/home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
   50 |     uint8_t  ip_ver_len;     /* version and header length */
      |              ^~~~~~~~~~
../../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
 2192 |                     memcpy(data_to_checksum, saved_ip_header + 12, 8);
      |                     ^
/home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
   50 |     uint8_t  ip_ver_len;     /* version and header length */
      |              ^~~~~~~~~~
In file included from /home/pm215/qemu/include/system/memory.h:21,
                 from /home/pm215/qemu/include/hw/pci/pci.h:4,
                 from /home/pm215/qemu/include/hw/pci/pci_device.h:4,
                 from ../../hw/net/rtl8139.c:54:
In function ‘stl_he_p’,
    inlined from ‘stl_be_p’ at /home/pm215/qemu/include/qemu/bswap.h:371:5,
    inlined from ‘rtl8139_cplus_transmit_one’ at ../../hw/net/rtl8139.c:2244:21,
    inlined from ‘rtl8139_cplus_transmit’ at ../../hw/net/rtl8139.c:2345:28,
    inlined from ‘rtl8139_io_writeb’ at ../../hw/net/rtl8139.c:2728:17:
/home/pm215/qemu/include/qemu/bswap.h:284:5: error: writing 4 bytes into a region of size 0 [-Werror=stringop-overflow=]
  284 |     __builtin_memcpy(ptr, &v, sizeof(v));
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/pm215/qemu/include/net/eth.h: In function ‘rtl8139_io_writeb’:
/home/pm215/qemu/include/net/eth.h:50:14: note: at offset [24, 64] into destination object ‘ip_ver_len’ of size 1
   50 |     uint8_t  ip_ver_len;     /* version and header length */
      |              ^~~~~~~~~~

This has been triaged as a bug in GCC:
 https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114494
 https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673
(the sanitizer pass rewrites the IR in a way that conflicts with its
use by the warning pass that runs afterwards).

Since this is the only place in our code where we hit this, work
around it by rewriting the relevant bit of code, and noting in a
comment why we do so.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3006
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Here's a patch that takes the "just work around this one problem"
approach to the gcc sanitizer compile failure.

On the fence about whether this is worth backporting to stable.
---
 hw/net/rtl8139.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 2ad6338ebe..eb4dfcfbe0 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -2092,7 +2092,20 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
             eth_payload_data = saved_buffer + ETH_HLEN;
             eth_payload_len  = saved_size   - ETH_HLEN;
 
-            ip = (struct ip_header*)eth_payload_data;
+            /*
+             * It would be more natural to write this as
+             *   ip = (struct ip_header *)eth_payload_data;
+             * (the IP header is at the start of the ethernet payload).
+             * However, writing it that way triggers a GCC bug where an
+             * interaction between -fsanitize=address and -Wstringop-overflow
+             * results in a false-positive stringop-overflow warning that is
+             * only emitted when the address sanitizer is enabled:
+             *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114494
+             *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673
+             * So we work around this by writing the expression in an equivalent
+             * way that doesn't run into this bug.
+             */
+            ip = (struct ip_header *)saved_buffer + ETH_HLEN;
 
             if (IP_HEADER_VERSION(ip) != IP_HEADER_VERSION_4) {
                 DPRINTF("+++ C+ mode packet has bad IP version %d "
-- 
2.43.0


