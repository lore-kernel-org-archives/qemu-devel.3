Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6B9FED2F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 08:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0bn6-0001r7-Rn; Thu, 12 Mar 2026 04:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0bmt-0001g0-W0
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 04:53:00 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0bms-0004Xw-FP
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 04:52:59 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-829759ca646so447040b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 01:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773305577; x=1773910377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m6ZZoAiPWb5a1hdPgHJXKg2H3qKBxJDoJj3D7ny13Ao=;
 b=ckq/pWRPtJ1I85VF4WRmsbi0tNLqBJyyYmR1ohLYMKkfm17v18zfzeZFaEDDum8isv
 XRrdukXQcFcV5r4XUTzS/9U35IUF+MstF0IEYleUVD1B9z/ku5+Dj5tJGdv0cGANMG0l
 fqd3HUPHZTAgDzBwYuCFl1Uh5/nmr5JxTqrnue08BmuDe8eLpjYMbrA2kDWBAE0cIs34
 f6E96J7GEfhdi11ZCt5jFu/IgdsiSnSAhKjSSipnf3pJ1PRXZxYIwpA5Lvkn0CbpqQwq
 fDlqbKVxrqEEOSaZDTw19Ox3ExMft+NP9U6QRxhUS+sbHHm/+8h93bnhN04As8F08+QN
 JBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773305577; x=1773910377;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6ZZoAiPWb5a1hdPgHJXKg2H3qKBxJDoJj3D7ny13Ao=;
 b=gCdN7gQTzIZOxWG3LkhPHkN+VieqZZRfJh63lTVrtPnl7FTKAFQ2gSwEUs3oX7jdXJ
 +r1077xzdeDF6uOjJdhJqtIEsjhMJCqIfJeqav+nl3PeA6wuTLCbL64ZriP+uVvMsBK4
 GIUR6VN1yl1OMwW9rxau2o4Ap/xdzjFRiHhvL3Y/XlNkdTjp2oCrfKL99BVWYLFIRlmz
 E8EDyDDctiChw9EHPIEsJJwBhEJa1Pac9ml6j6DnS84SF2Gv8QjZYKDO3eHU432aZ8Sa
 BKQWcH3nK4pdBnH0KLuOPBDerG7yGt5c8JsjfJO3gll9gGgMQU813T8lhPa3LZMCo0HB
 2CAg==
X-Gm-Message-State: AOJu0YzJpP048wQhRNYrBupG1uWdeGzjc5olIasmnFgtZK2OGaUgAnxF
 U+1xM8C1/ItZ/ouDpciw6yiLlciIwnLmzHB5mGrJpXdMxrocnIkTIQe0W+Aj7ukJAs8PVg==
X-Gm-Gg: ATEYQzx8gjNAJwA+SB/EgdssVokA3jVVN1R5BbEeiPDEDr/vJ/YVHUQy+PZSBxpaX+f
 Fh0m4fxAeYTOwQr6z8zs0QuX5+NwDsdfVxl02ktk5Kx1gevWF+fuGxNE+OwC8+TXIk/xzHwEIzx
 tbkqGB+qO1bQfDkEsJYUl0S1TAS+miUqSHK5Iv/5fav031iEgS6lkytmp6sYtBoGrcM2K+iga4B
 HmDdWaKEHAyw5g+TFutKtKUFu4bNOX3f1wF2PfML6IiD2lyfrow4nBjsp9Il2kXeIGB7wi7qFcV
 Yz2W+U3KCcAPZBDzA+ZRDY1phWxcreas9hFw6SmXqz6SYawaWp13xouj0VX9xO9G8mkKgvZXJ6C
 pi1mh9P5ZhcP/6fcZdudIR4MaFKt7cxv/mwWBSiAy8UipHXv6MgHExRROV045cG/HHOVOEb9BEW
 OxAMxx0cQgbczZ/Jg9xXXSTuUOzF9IRYOoqYJ6MxCAqq0yQexaMIyEpO8sqCE9RGKR3Bu+sxGi6
 cDTiaPmqg==
X-Received: by 2002:a05:6a00:6d55:10b0:827:26e7:5c34 with SMTP id
 d2e1a72fcca58-829f729c2a2mr3835475b3a.61.1773305576858; 
 Thu, 12 Mar 2026 01:52:56 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0734039asm2649625b3a.41.2026.03.12.01.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 01:52:56 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 "trieu2.huynh" <trieu2.huynh@lge.com>, Trieu Huynh <vikingtc4@gmail.com>
Subject: [PATCH] block/curl: Fix Resource Leak in curl_header_cb
Date: Thu, 12 Mar 2026 17:52:20 +0900
Message-ID: <20260312085220.194207-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=vikingtc4@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "trieu2.huynh" <trieu2.huynh@lge.com>

The function curl_header_cb uses g_autofree with g_strstrip(g_strndup(...)).
However, g_strstrip may return a pointer that is an offset from the
original allocated memory, causing g_autofree to attempt to free
an invalid pointer or leak the original.

Separate the allocation and the stripping to ensure the original
pointer is correctly tracked and freed.

Resolves: CID 1645633

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 block/curl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/curl.c b/block/curl.c
index 66aecfb20e..5b66c80704 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -208,7 +208,8 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
 {
     BDRVCURLState *s = opaque;
     size_t realsize = size * nmemb;
-    g_autofree char *header = g_strstrip(g_strndup(ptr, realsize));
+    g_autofree char *header = g_strndup(ptr, realsize);
+    g_strstrip(header);
     char *val = strchr(header, ':');
 
     if (!val) {
-- 
2.43.0


