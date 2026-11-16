Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6C960703C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zKamMwgn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSufY-0004Op-Ih; Mon, 16 Nov 2026 06:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSued-0003vA-5f
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:43 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueU-0002Cx-SB
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:37 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4918c2d727fso1808075f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827613; x=1795432413; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zIEgskHLHp1xxZ0CrCgRpaQC5xY5tGTsVVzDXmvtLvA=;
 b=zKamMwgnzuNDh1T+A4XThJlKhhV8Ze9TXcHjaYmzGbQnGR3N7Ha6rDw522MVgVE36T
 srviPDQnEiHvBGJVXDogmxEO0Py7ShovXxqhVIu0ebjF9dgjhn714PnUJAYE1Etz/zD5
 jydXI7TJSldgIluuz7rvKl2ZNHgVG8+XvLBE3349+I5R7xpA/ykohSxhTgbpCTzWW9ZF
 P403eUubGpbTBNQpWVVG6wzZCk0JJWfgqDfxUUBFgrAVRZemmeEtrlRvPFA1OHb7Hyeu
 wU8GSwhYvSBFgPDXfLVAPHh5zg0XmkCFmu43aRqULAN6gdW88tx2PimxPyp3qwMtqhoh
 1ObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827613; x=1795432413;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zIEgskHLHp1xxZ0CrCgRpaQC5xY5tGTsVVzDXmvtLvA=;
 b=Qba247UKWH4ePc+xxRvF6NDPlDcCvnxmks2n+t7PDpQUMZ9zblUbGXMOUPb+sSd131
 mKwRhqV6p0Fp0EoCACwWaHUn0zDl1qlVvkGbtqPrpL289ovi5p0E/7rmlUHiOLjsrjE0
 y6Nbvtds2wgSPKtr58RyY0yRD48Ndw10TaI4x6z9Qbfks0MUMFucyDvzXVoa9ObY/oq9
 1holseqM95ulWroLO0kQcD394o4opJHvxl1BFS1vZKszgkQ79JZX6zIdrPZY5NfGDmnz
 jdqAi/JhTdDzorzaVjgq2NOWuM3Q6PGY1lRN3XBV5Qi+bMQPsZlgvsodmrf4InM3YKHx
 EB8A==
X-Gm-Message-State: APuU4Z+kgGzJ8mtUe31TdKJ+269Mya7PP2QwqkLTUlxi17CXCDtQObR4
 FXrbjAWA7ylbC8MTqRPkUf+7uin8fJX30TE1t82g4q+vMdXmMwhnqeBXpmrvQ3BiG0DOa79X6RG
 lJasCkYE=
X-Gm-Gg: AZFdTZfKC//xfZhPy6ZrcrVG25XR5ZDoxFgUYC6TaWRlLPMqmGP3o2tViZm6B5InkO8
 MdFZ5H4azCYIkDxob04lIZJ1lVJy6MV1tKROWfAosHSqadKC9tvvvKCflfo9FBbMzPGQq8j79Ek
 54aMei2fxLTHVFwIzF/7N36FovjdE5ynVtfrhgYgfbdik50SrKsLK6yaunm4Fxj8Iu9TatOTYET
 5claXEfMIhhWTcWvjGZhjaJF6gpqq/wA1XcTbnrFkYzfC81A8JBen5Yzgh3A2rHP4SqBKd81i1w
 r/0e1YorifiDWxBBAcOTt455V+UUqt9Ae5oxumqRNQUr+IA56Z7EXlEnFKauZtaBu9JkBIBDxx0
 /noNM3w/3byF7jsPO5djcjgECsIr2GZ72KiIoai5nbxkSD5c1R0mW3ehVi4sA6K44JTgjaXc2q3
 3/UpUiM3Z23JI++YxqPfiyancdLaDv371luTAErkgfpDAt40w0wIXone/ujZ9yKXsdg5SB0qksz
 UoOdlg/5mVTXWNT3KcIHB+Huyk4j2Vwbs9K56md/cgyuwUkgA9CesVsYKxTz38rv6GFM3/H3zWt
 9RWzy93dqog+1pFDvN9DaCcfFgZS9aUvBVXPpJr93IzwwQLj1uNDIUwf+M43Mboj4D7T5L9yM32
 ol0S0NSQpFTOGgb3pq2Hf60GeRo8D/SrHFA==
X-Received: by 2002:a05:6000:25ee:b0:48d:ee0d:8b3d with SMTP id
 ffacd0b85a97d-49c71a66cffmr19293116f8f.28.1794827613321; 
 Mon, 16 Nov 2026 03:13:33 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/33] net: Remove padding code from net backends
Date: Mon, 16 Nov 2026 11:12:56 +0000
Message-ID: <20261116111303.1692832-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20261110180655.2072265-4-peter.maydell@linaro.org
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


