Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367E4CD1297
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryWX-0007R1-Fb; Wed, 03 Apr 2024 07:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWV-0007PD-0E
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:19 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWS-0007Fy-C4
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:17 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e73e8bdea2so5649346b3a.0
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712142675; x=1712747475;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HEZpES9h8MU394FyVCCY/HdTFC7gaKBiXgMhqvKOBUw=;
 b=uf0T9FyCK7rOcz1BjB08mTwlearsAb/9UMnyhg5jNczzifPuS0+AphuzbseIuFy1Wg
 4YR+vyhDiejTTO2AxRIaN/PzvrpVtV9qLfN38bvo6qgjC3CVveqgndAyDyI59sgk9boe
 JIsWpFv40AK4L3AabwlEaJi8Z2Hq1ynZlTKnLWCx7X9W+fG7gVzFYJ5z3M63x9oEFW0h
 OLvvLVsgLlpykyitgDDWfqP0v2Q/8QaLaAy9RYpIJB+EGrv7A+Kvmv31kQGaRT3k6FK/
 UR2k4JRGLBx2rRPt5oehjnZZ8Q4n7XcpqYu22awOr12lD9gIe0NOOf3cGwQvpYiFhGk1
 hUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712142675; x=1712747475;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HEZpES9h8MU394FyVCCY/HdTFC7gaKBiXgMhqvKOBUw=;
 b=Xwur+MpLrez6F5n0fVxiK5dLOMv9ScE3RD7Id+7kJk3IDLR34kGjc7cINRA+xbl6gD
 jPJwcWzq0Uw62FgGlJJLm5WVE5VLtkXtquthist/3L3AYJWSerDSeXHlUKHZFt23PuL9
 Wrqys5Hk2fp/QpRMBxUK6ndGgnDy2urBBs68R+f1t7bnt8Xa5RJQZcdE9nn8qgcEgst0
 Fg9rHrLz1Djci6Wko7vFbPc+YtvRad/4IXseiROvM1VoC7vz87LVIKgWOOC9Ug5hMf0F
 Z9eeY1Caz2TArAZ84z0th7nI9n09jg7Gq7A0+xoJ5cWq/FZwC5hKY8wjlGuh93jzITGx
 4ZZw==
X-Gm-Message-State: AOJu0Yw9rjlcfxyBj+QkqPSSmXh/9wjWpEFUeh6YdNfIBiqlL4cRxk5C
 ehuZuSd7myjp4aU1x615AkDD5IELseWqoeWvvKUba+GaYKCEcFxZi8nN85KoqSqNz7zXEIMax+I
 oxss=
X-Google-Smtp-Source: AGHT+IHHLzce/mOUCLXoZmapKlUvzJLRFWtyEkmYopAUigLNbVQMXp9IG3IZyhLKEtnwcs8yo4hh2w==
X-Received: by 2002:a05:6a20:6a08:b0:1a5:6bfd:6bdd with SMTP id
 p8-20020a056a206a0800b001a56bfd6bddmr18740951pzk.50.1712142675127; 
 Wed, 03 Apr 2024 04:11:15 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 y8-20020a17090322c800b001ddd6ba8113sm12943175plg.207.2024.04.03.04.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 04:11:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 03 Apr 2024 20:10:53 +0900
Subject: [PATCH v9 05/20] tap: Call tap_receive_iov() from tap_receive()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rss-v9-5-c6d87e69d38b@daynix.com>
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
In-Reply-To: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 "Zhang, Chen" <chen.zhang@intel.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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


