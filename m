Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBE2C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yXF-0002OB-5U; Sun, 28 Apr 2024 03:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXD-0002O1-Pj
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:16 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXB-0005PW-FX
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:15 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ece8991654so3329217b3a.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714287672; x=1714892472;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HEZpES9h8MU394FyVCCY/HdTFC7gaKBiXgMhqvKOBUw=;
 b=2Ydu1tOoIvjNQ1nS9AkzFZz9cDmPi6aXJBE42LYj6z1MJlTIei8Y1ntJcDuSfIcEYY
 /Se2dWRdgEF+akaTG8kunhngCpWRmG06svNCLJFbPq15LfnsjB4xiTIWUJc0drz5zhKz
 jB6g3DmnbSkLMx6tlEzwiiVMOpRnQbSkBhbRUlhZYhViwUBJclLAxucmbcM8wJpGYFQh
 cjvzmpmW8oxY+Kz/6Eab1/xE5jACRSi+JhEiWXXQkZmeU4cIgd9JLXCR0Guxe96AdgZe
 caxWZlGY7qGPL7W4vNfRSQevTwHKHkAQ4ExkDQqHUFAnwhPQLXXA40RL1dmKzhakqn7H
 Je4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714287672; x=1714892472;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HEZpES9h8MU394FyVCCY/HdTFC7gaKBiXgMhqvKOBUw=;
 b=QFET/Fvw03Cg0m0bD7c7XJx6MrakkAabxwdxf/rpD3hV/OP65a3J1mD5YFbB3Hg2ky
 dmnlaxUs2CdpMql+6hpsFcaHtr0a9MCrOu2RSGw++ier29Rmy/UhcyZwrbtWuej4HuJM
 V1W9mS7C6pS9x3r7W+shLHKQI+yQFDtpFiB0DfIjK5QKPbQb5ZDDuHxasbvgZntaO7JO
 n2rPxud6Ak1IfBhtpTm59ULjDaRJ0lX57562xsE1ZoICKLFGX0D6BzDtaE3tfR0XxRjT
 1Re8IMBcS41GTTQ7JkB+XOtwUrViK0KLmKcafjdpy2VHtavMh/NoQVGSMuzwPuQJvdlz
 pWIw==
X-Gm-Message-State: AOJu0Yzy4ljyMCmxmZoqgAHts0Bf9xDKktcs3iz+35NM+K9lt9b6b/S9
 Ox7m5gl1ibWy03/qwJNqd416nELi5c/I9iB94ZI6JHXI1FQ3YyNlZOb6T7brdlQ=
X-Google-Smtp-Source: AGHT+IFSMn0mwu2UDRViFu5NeB+Wvf+3IILwU7k4b2UQjppokeaQKWDne3siuAW3ugrLVI+5ZIpnzA==
X-Received: by 2002:a05:6a21:789b:b0:1a9:b4ed:a with SMTP id
 bf27-20020a056a21789b00b001a9b4ed000amr10387930pzc.20.1714287672325; 
 Sun, 28 Apr 2024 00:01:12 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 ld2-20020a056a004f8200b006eaf43bbcb5sm17253365pfb.114.2024.04.28.00.01.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:01:12 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 16:00:48 +0900
Subject: [PATCH v10 05/18] tap: Call tap_receive_iov() from tap_receive()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-rss-v10-5-73cbaa91aeb6@daynix.com>
References: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
In-Reply-To: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 "Zhang, Chen" <chen.zhang@intel.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This will save duplicate logic found in both of tap_receive_iov() and
tap_receive().

Suggested-by: "Zhang, Chen" <chen.zhang@intel.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 99c59ee46881..9825518ff1f3 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -133,39 +133,14 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
     return tap_write_packet(s, iovp, iovcnt);
 }
 
-static ssize_t tap_receive_raw(NetClientState *nc, const uint8_t *buf, size_t size)
-{
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-    struct iovec iov[2];
-    int iovcnt = 0;
-    struct virtio_net_hdr_mrg_rxbuf hdr = { };
-
-    if (s->host_vnet_hdr_len) {
-        iov[iovcnt].iov_base = &hdr;
-        iov[iovcnt].iov_len  = s->host_vnet_hdr_len;
-        iovcnt++;
-    }
-
-    iov[iovcnt].iov_base = (char *)buf;
-    iov[iovcnt].iov_len  = size;
-    iovcnt++;
-
-    return tap_write_packet(s, iov, iovcnt);
-}
-
 static ssize_t tap_receive(NetClientState *nc, const uint8_t *buf, size_t size)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-    struct iovec iov[1];
-
-    if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
-        return tap_receive_raw(nc, buf, size);
-    }
-
-    iov[0].iov_base = (char *)buf;
-    iov[0].iov_len  = size;
+    struct iovec iov = {
+        .iov_base = (void *)buf,
+        .iov_len = size
+    };
 
-    return tap_write_packet(s, iov, 1);
+    return tap_receive_iov(nc, &iov, 1);
 }
 
 #ifndef __sun__

-- 
2.44.0


