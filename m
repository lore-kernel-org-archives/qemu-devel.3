Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A92C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yXJ-0002Oo-LU; Sun, 28 Apr 2024 03:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXI-0002Od-9r
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:20 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXF-0005Ph-JM
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:19 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2a484f772e2so2332930a91.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714287676; x=1714892476;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lzZZwAvDlZW0POG/57kWL/3/6EoUmB+Yu+cgaQmA+uE=;
 b=Gtm7qzXOVi61quGBOoApDrrsu1g13GlmhNE0Dxg9opJ1Ff3EIbKsqOPwtshcFgRDEw
 jzFOZ9GpvXql/nBEkj0p84mULNCjHuvkMmEvUbErppZn2RlzuR03Q1C5i86ziiiEz6FC
 umM2gkFWmCNpaEOlqUYlyPvzspD98TT9pKJO/uUNl3uDZ9YagKtIOYxD4cs7bTwa/EX/
 pEUepp7oNCqBqVzLpMi2E+01DdwpLYoNEnS/RdRly+xr5c7J/fHXMP8BhoKj0bjHghcs
 sCFz+FSFrH9REwqk4j7JZhI0TkJ6hY3PKT4M65eaFlkWCDyZUz3OKM1idmd2GEZq7HAR
 yBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714287676; x=1714892476;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzZZwAvDlZW0POG/57kWL/3/6EoUmB+Yu+cgaQmA+uE=;
 b=fwDlox5TAqdifvnVDyw9aVUjP6w0KsDoaaiRm6LJSxqhSIwpo6MyjTSGasP/V/Pug8
 DpiAWUR58yGvDWCRRw6qDyHHhNobaMz6DtDFV5bhbD6dr/iwIELc4iNt55oo6rcMgeuN
 US0/KNgt7eIlLTzE9P2Veg5T9Dty/FNYiMua2Zd7rSl2r92itk60tkT6M5aqhbVqXZIO
 HHHUHDIwbLoZODkF3THQZEzSrOX4EM3gNVvnHFzZrnEZh/+tDpq/q38ka3EuVjKrs/m1
 Mt15K9HBynUKcUyySZJgMq3QEEWdxSpdjLblx8f21KCKmicitk0aplupr4qw/YxZx5he
 zfUg==
X-Gm-Message-State: AOJu0YwcCj/R0S5+0Yl9H/CrydcsuwQ30O8ev8yHyVur4xOXmhPHrEYf
 Y06t7XPpuxWeVPwK48wrjateDLd5O2IFpr+llkp2fD1DQaAlSEJ9xwZ9hM6LWLU=
X-Google-Smtp-Source: AGHT+IF8ogqlpOchkq5m6xnyxpXLDoaLe0ys4U29po1ZYBqTxhvJNQEcI/qt0o64i1BTxJpXbnv52A==
X-Received: by 2002:a17:90a:fd85:b0:2a7:cd5:faa6 with SMTP id
 cx5-20020a17090afd8500b002a70cd5faa6mr6800447pjb.44.1714287676146; 
 Sun, 28 Apr 2024 00:01:16 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 gt5-20020a17090af2c500b002b16f39c917sm449957pjb.50.2024.04.28.00.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:01:15 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 16:00:49 +0900
Subject: [PATCH v10 06/18] tap: Shrink zeroed virtio-net header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-rss-v10-6-73cbaa91aeb6@daynix.com>
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
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1033.google.com
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

tap prepends a zeroed virtio-net header when writing a packet to a
tap with virtio-net header enabled but not in use. This only happens
when s->host_vnet_hdr_len == sizeof(struct virtio_net_hdr).

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index 9825518ff1f3..51f7aec39d9e 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -119,7 +119,7 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     const struct iovec *iovp = iov;
     g_autofree struct iovec *iov_copy = NULL;
-    struct virtio_net_hdr_mrg_rxbuf hdr = { };
+    struct virtio_net_hdr hdr = { };
 
     if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
         iov_copy = g_new(struct iovec, iovcnt + 1);

-- 
2.44.0


