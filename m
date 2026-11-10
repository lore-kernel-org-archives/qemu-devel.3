Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B3606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bENmdAsq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQqFO-0007EV-3q; Tue, 10 Nov 2026 13:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQqFM-0007Dd-JW
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:07:04 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQqFK-0000JS-0x
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:07:03 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4918c2d727fso1283789f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794334020; x=1794938820; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vWUKlujesHAaIn6IDqfcnh3YdDOi8lwA7YWzYsX797w=;
 b=bENmdAsqc3cHiH4KLEWeprjceaolDm/bnHlWH2qja3ZKnJkzFABAKSiMJKr3hChruJ
 aSqx+4m+t+AdXMIU1X/Ytte4qEK15bfbt/bKtw+Ph0ICObrCiS7bcwZbKRgtl+pEKStI
 kTHT+AhHbRMQgjoEw+NMQa5NBwfhYT8ODK7mIz3GocQS1/Yb8k2/+Y44dgE1NLTiQkm+
 YEBcE/DSRNfcycIxnoZP/qg2a584bIOOIE0XqzgxhU5bh8DhSi63a7W1NsjMyv37DVfz
 VI3IknlP0gcQ3am13PrIumqbiQNNNWGWKwUXivaHkCGBSsTR9Xt3F7S6DQwz32XrAXDW
 VXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794334020; x=1794938820;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vWUKlujesHAaIn6IDqfcnh3YdDOi8lwA7YWzYsX797w=;
 b=Ky7URSmxsYk3m7+Z3jl7925n+GbrzHithr1hZiYk21/X4/8fdgcPiqF0Htt6+WRhic
 MW/NmP/iFPnqC6wXK3Ul5Rq52/zG8yLPy0P779DTuiC03jrI9pUVkAs61/iuP/x5dY+T
 I4pJtvIqoWCMvNXV9lCX3+CISOlmWr2iuRrjUWIFe0k8Qpj0L9BhYwVNh/oH7mHgVHpL
 5KjUKnnuPErrP9UseHASPIavEVPHUMR2UC+YXzubQ4pB4Njt313rSDoI5ANku4tleURv
 dgro90WygdHR74op1gQw4T3vJCPBwsQ7gv1/ZGCrIr1ZQYXC2KkKgSrUoTkKuR/x327l
 lG+A==
X-Gm-Message-State: APuU4Z+WgmPk7zo2UYcAvA6LLFggIc0h22htnNclD/lrlh33qSxHOk+T
 il2jtQLBgsjX3qZ+w7louJYiFyDck6CBmCBFAcU6d3rGkyY3MVf8YHNeAA75ZPClQ6MHxG0AaCe
 ZGjQh69g=
X-Gm-Gg: AYBFou0zqR1ChG4CMK6P8vmF6RvgMa7t/IZOU8a2kJ4P0O+WiHRTlFMmlax0ogq0s4j
 VttPJ1a3TVUd+Q8uu02uVFWpr7OO+0HywPOLssCv2EKjjivIpolo63B+kWHN9MXMQ7zPcgCQB/Z
 vLpfYvPHFLei0Ou4CQ+ie0qJjgZuYkgXh2Ir5xgrmFTTgQc7w9OBjwKToIVQM+yxFMcljpJvFwB
 0DNuXR0CNkp+X2fca63AHObo4ySHfuiaXekA1LB6+2lU+jqt/TomsYemNv/PfI9L28miZ8FhaJj
 mKzvOtqmoFYxcaJm5ttmRCKrVcQfPXVwpxl86gObOrnGcvQ+IauNoFGktv+0FZsMBe/Exq9sRb7
 q60RsrJGB6u/W6vpu1hgU2TPigRaWmVpQnRNDAbSd4cK5yoK6nDvVahC4mIvPrj8ZeX2ke9hop/
 47Gg8/zH1WHLCcWFdy8H+Lw9PeKTKHAlHa1E0niAytz1JfOBJuTom5YkieW0rpdtZruI2wM3bdg
 jEqEZCRubjGGtOo7zhDj4a//iDl92m1PDtWpKm/EIiLXUYPRWCbpis1cUU72D8eyrRd1q4vN7Ru
 HMtrYcgWonolIbvh0C2XtAzaqYhmR8MAukfkugGfNauWHcxwdl78pwGgGrCXiVK/lwj9kVS8k6m
 AItGlw32xBEXBKkwDcI6Wr5lWPCgK1cbyBWTk5s6ciuGEdYbYcmZ9osE=
X-Received: by 2002:a05:6000:26c6:b0:48e:6f84:2e8e with SMTP id
 ffacd0b85a97d-498307c5073mr6574740f8f.39.1794334020292; 
 Tue, 10 Nov 2026 10:07:00 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a3f4esm6825701f8f.53.2026.11.10.10.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:06:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-stable@nongnu.org,
 "Dmitry Fleytman" <dmitry.fleytman@gmail.com>,
 "Jason Wang" <jasowangio@gmail.com>,
 "Samuel Thibault" <samuel.thibault@ens-lyon.org>,
 "Laurent Vivier" <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Zhang Chen" <zhangckid@gmail.com>, "Li Zhijian" <lizhijian@fujitsu.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 for-11.2 3/3] net: Remove padding code from net backends
Date: Tue, 10 Nov 2026 18:06:55 +0000
Message-ID: <20261110180655.2072265-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110180655.2072265-1-peter.maydell@linaro.org>
References: <20261110180655.2072265-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
index ee6430d34a5..9f3d0b08ab7 100644
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


