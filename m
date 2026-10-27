Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694D606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Nbo8x3xv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlFx-0006oU-QU; Tue, 27 Oct 2026 13:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLlFr-0006n5-5I
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:46:35 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLlFp-0000j2-Cv
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:46:34 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a218c463d1so978715e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 10:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793123192; x=1793727992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m5klfN9HYpmqR5jE7JRUeg/q9a5L8gTTTh4pweWQuow=;
 b=Nbo8x3xvlpLf9aQLRhpw8U/VBKsxeieZ/QXWHHJOGv04YTeJICvp/ZL72Nn+WQ2vN8
 lY69Mn2/MFW4wtjjP+artol6OZcC2UFtJyE5D71UZdEhnO1FOI40M3tIaKlu3QQAtMhZ
 Po2CeWJMDGlGFXPo3KbB6s3SNo0aUsdnYlsJCoilE71+byV6H/vmsofosnvDFY++q1UL
 xbkUZXOBbHXJ4GoOO+wZb2md50WUg61EGr8Do9to9oYBcat/cTnR9jmXvNfRrQM36ToR
 URc1ix+8oHk6VMW+nUgSbfSwXnJT3W3mTpTHyM/DXkZugJT/Nwp8UYlsrzqvPZtiNhva
 YtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793123192; x=1793727992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m5klfN9HYpmqR5jE7JRUeg/q9a5L8gTTTh4pweWQuow=;
 b=GXuTUJ6nEoEaVZ9Gy17/Vh1yBR4p94HTWdNjjw3rRKw2lo2JocH75qdlWb6rBpOi6r
 YEiGLemUIiNILbxHwyhjtZ/2hn40PmA8g91uYLhK1zNTQ0pwB+xfVimHRnVu6mfMrGw7
 2jAYiuCVg+5H1aShFBtvgS0Ni+L3tdRYm8ugmQrxmqXDT87bmeN78K5jv0yLyle27jUm
 G6qIv7LgDyufpbF7lQryqEoFItMfkd4RD8c2W/PLvtNZcwTBtAGcQUor9eSZSs8LhVF5
 XGS/UI8tEUi4UPHUGbw8o3RbSGG0TM+RPt6/Z9+BiwUthmUWeA1dW0TFOk7Q4DJ97MTT
 EImA==
X-Gm-Message-State: AFq9FYKeyf1FGuGzwujbePNChH2zm7s7LeLu+JYbG9Wx2OFU/5hlBkm0
 pgaHsQAKAOanlHSqf0s9vPpOE8wsjgol3xs2Rfhswux8kZPNTNhVpKh61XVNIMDoY2tFxbD7nyL
 IhEjIf2Q=
X-Gm-Gg: AYBFou3hg6q3KNiJSsO0+34XgH4osICDOGWdCGpT6/cSlIXKzs66nnYcL+OQLAV0YJL
 Egx8ll1XKt8TvYQkMMBVNJPLXJszxynnxCuM8Khz5ziRKHgIaFMQ/lf1ARttNvgettA/FdMg1Lv
 geMiPgY5A37V6ryZA7oUSM8xMnW6KKljZNRxR/MiEyuQ/zHLGU9qf3iYhzJEHX4SE8YRpz/Mrc9
 EZmkYBAD4rTjw8aCa7QGPCMth2DeYA/mcOoMNkvRNEos8cL+6krl3eVPHuEpQl72y1lahVMmRrU
 e5/7mEYdMo3WFKH0LcT1il5df+xDgrisRprWfQ0I2QAjp1j0Y9N/9uKjyQxiwRFSoXKcRxL1ToF
 /8P7jz3LTIbYTyHa0vi7YPA6CxCD7EkRPOjzsJ9VR0K1WeR0N6KPG7JxjaNk4fp3o0IupdOQFU/
 JeRoHl9Ktc143TTm2DDy45mzoJhuXRgcqnqQgujxfTLlOR44igI/YXBnQxL6kvb87pCbzULI6X7
 frbcP5Q+9pJtWTzDKCETBS6nelUl03jcZUPu8sZJsXWCVEi00VnQRaq4L4UN74H9j/4aezkw9NW
 DKQSL57BWJ3QZ0/C+j8+uzm9d2pG7mR03QxCgYyy6EQmSjFcALKTB4nZuxzkTKNr0dytNecWNTg
 Sbxo5Hw==
X-Received: by 2002:a05:600c:3541:b0:4a1:fbf8:55c9 with SMTP id
 5b1f17b1804b1-4a35acc6a2emr211595835e9.33.1793123191974; 
 Tue, 27 Oct 2026 10:46:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92b8812c5sm5518875e9.10.2026.10.27.10.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 10:46:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowangio@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 4/4] net: Remove padding code from net backends
Date: Tue, 27 Oct 2026 17:46:25 +0000
Message-ID: <20261027174625.4025878-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027174625.4025878-1-peter.maydell@linaro.org>
References: <20261027174625.4025878-1-peter.maydell@linaro.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We can remove the short-frame padding code from the net backends that
were previously doing it, because the qemu_send_packet and
qemu_sendv_packet calls they use now do the padding for them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/slirp.c        |  9 ---------
 net/tap-win32.c    | 15 ++-------------
 net/tap.c          |  9 ---------
 net/vmnet-common.m | 11 -----------
 4 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 451c0fd1ba4..eea12e79816 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -120,15 +120,6 @@ static ssize_t net_slirp_send_packet(const void *pkt, size_t pkt_len,
                                      void *opaque)
 {
     SlirpState *s = opaque;
-    uint8_t min_pkt[ETH_ZLEN];
-    size_t min_pktsz = sizeof(min_pkt);
-
-    if (net_peer_needs_padding(&s->nc)) {
-        if (eth_pad_short_frame(min_pkt, &min_pktsz, pkt, pkt_len)) {
-            pkt = min_pkt;
-            pkt_len = min_pktsz;
-        }
-    }
 
     return qemu_send_packet(&s->nc, pkt, pkt_len);
 }
diff --git a/net/tap-win32.c b/net/tap-win32.c
index 38baf90e0b3..2fccfdbaacf 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -682,25 +682,14 @@ static ssize_t tap_receive(NetClientState *nc, const uint8_t *buf, size_t size)
 static void tap_win32_send(void *opaque)
 {
     TAPState *s = opaque;
-    uint8_t *buf, *orig_buf;
+    uint8_t *buf;
     int max_size = 4096;
     int size;
-    uint8_t min_pkt[ETH_ZLEN];
-    size_t min_pktsz = sizeof(min_pkt);
 
     size = tap_win32_read(s->handle, &buf, max_size);
     if (size > 0) {
-        orig_buf = buf;
-
-        if (net_peer_needs_padding(&s->nc)) {
-            if (eth_pad_short_frame(min_pkt, &min_pktsz, buf, size)) {
-                buf = min_pkt;
-                size = min_pktsz;
-            }
-        }
-
         qemu_send_packet(&s->nc, buf, size);
-        tap_win32_free_buffer(s->handle, orig_buf);
+        tap_win32_free_buffer(s->handle, buf);
     }
 }
 
diff --git a/net/tap.c b/net/tap.c
index ada69a21021..786c31f5adf 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -261,8 +261,6 @@ static void tap_send(void *opaque)
 
     while (true) {
         uint8_t *buf = s->buf;
-        uint8_t min_pkt[ETH_ZLEN];
-        size_t min_pktsz = sizeof(min_pkt);
 
         size = tap_read_packet(s->fd, s->buf, sizeof(s->buf));
         if (size <= 0) {
@@ -279,13 +277,6 @@ static void tap_send(void *opaque)
             size -= s->host_vnet_hdr_len;
         }
 
-        if (net_peer_needs_padding(&s->nc)) {
-            if (eth_pad_short_frame(min_pkt, &min_pktsz, buf, size)) {
-                buf = min_pkt;
-                size = min_pktsz;
-            }
-        }
-
         size = qemu_send_packet_async(&s->nc, buf, size, tap_send_completed);
         if (size == 0) {
             tap_read_poll(s, false);
diff --git a/net/vmnet-common.m b/net/vmnet-common.m
index ab33ce2b0c2..4dfc8abbc15 100644
--- a/net/vmnet-common.m
+++ b/net/vmnet-common.m
@@ -150,23 +150,12 @@ static void vmnet_write_packets_to_qemu(VmnetState *s)
 {
     uint8_t *pkt;
     size_t pktsz;
-    uint8_t min_pkt[ETH_ZLEN];
-    size_t min_pktsz;
     ssize_t size;
 
     while (s->packets_send_current_pos < s->packets_send_end_pos) {
         pkt = s->iov_buf[s->packets_send_current_pos].iov_base;
         pktsz = s->packets_buf[s->packets_send_current_pos].vm_pkt_size;
 
-        if (net_peer_needs_padding(&s->nc)) {
-            min_pktsz = sizeof(min_pkt);
-
-            if (eth_pad_short_frame(min_pkt, &min_pktsz, pkt, pktsz)) {
-                pkt = min_pkt;
-                pktsz = min_pktsz;
-            }
-        }
-
         size = qemu_send_packet_async(&s->nc, pkt, pktsz,
                                       vmnet_send_completed);
 
-- 
2.43.0


