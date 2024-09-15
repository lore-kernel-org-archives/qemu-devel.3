Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F60AC35FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spdjK-0001go-On; Sat, 14 Sep 2024 21:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdjF-0001ca-J2
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:07:06 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdjD-0004At-LF
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:07:04 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71788bfe60eso2463149b3a.1
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726362422; x=1726967222;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zri61GtPq3fqTMAS9EVk13RVqopymUiIUwzvDEJGhnU=;
 b=uEBB/O9jw9QeBEDxiURi1/LocWXrjdbgDsJPaeR+xbvjGjpl+g33kuMOWMZfC8xlC0
 dMrxgW9IXZOZU2zy3wZ+3Rk56A9zGGj3463NGjDhhjDS00jTHNztjWF8gEzJZLVXHEGY
 KvsE8En46OiEwfloStPM36387zFBQ22d/tvGfGw9wkp5le0vH1vTWUeluA6OZWs4wGpE
 j4IQlXLtBZKJWJCoNsSYWRjRyNhppoQC/aUUJbVQd2jxPh/p1iAlnezL8etodSuCPmNH
 V9X5ahT+YsbcRAIyDc7vwkNHtpbRjUbra3tyye9FCjeKasRBIyq4StQ5q4icdlbjkX/L
 9N5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726362422; x=1726967222;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zri61GtPq3fqTMAS9EVk13RVqopymUiIUwzvDEJGhnU=;
 b=FI9/mgzgJFRCFrrV28xfzq9A/wAtRzEJBsfaS5p8s5cor1gMZtt4N7Qi492DvA15FY
 0qnvV21YNo0ggxd6Ylh15ki4FWQs8XC79iZYV03sTwQv4NUsn1zCrqUX0uKg0HTxoeOV
 ZZwzt4kvPTDd0AYK5E3MnSQdlMPKN95AyLJiDk6RdfJ73u94wQhkwcPU2w2BPKp4nwfN
 UGvUH6z66QKRNfH+As1JoOHbsXDp6q3719FL6WYTxV74TzoWT6j/F6ibN9WiyWdew8Qh
 3Os0MJwN4AROj1Txf676KlYGjPSEIdG6rXUQFEEEHn81mgF+hrpHAfr9+rrI33htU2jr
 qePw==
X-Gm-Message-State: AOJu0Yz1KkTnmDifB4XUTUtDWTrqovG5l1d7UrYCFttuvA9v96Wo97mA
 tmrwI0qvydB+xN6eBdRDEnHR4JIUWmsc7h5/qHMbwJdYwgr4PcYSJjvJT2E79txKJbxoUX+VLEa
 kjRA=
X-Google-Smtp-Source: AGHT+IGK0kXQZeV5O6VAg1ns3LSG6MSEt6PMelo2BTdBVAM0YCUB0E+XNX2m/JGaLjbBBJjnGIVPaQ==
X-Received: by 2002:a05:6a00:14c8:b0:714:3de8:a616 with SMTP id
 d2e1a72fcca58-719261e1393mr16890502b3a.19.1726362422156; 
 Sat, 14 Sep 2024 18:07:02 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71944a98092sm1510518b3a.41.2024.09.14.18.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:07:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:06:43 +0900
Subject: [PATCH 5/7] virtio-net: Initialize hash reporting values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-queue-v1-5-b49bd49b926d@daynix.com>
References: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
In-Reply-To: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
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

The specification says hash_report should be set to
VIRTIO_NET_HASH_REPORT_NONE if VIRTIO_NET_F_HASH_REPORT is negotiated
but not configured with VIRTIO_NET_CTRL_MQ_RSS_CONFIG. However,
virtio_net_receive_rcu() instead wrote out the content of the extra_hdr
variable, which is not uninitialized in such a case.

Fix this by zeroing the extra_hdr.

Fixes: e22f0603fb2f ("virtio-net: reference implementation of hash report")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3753c6aaca83..3fc1d10cb9e0 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1901,6 +1901,8 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     size_t offset, i, guest_offset, j;
     ssize_t err;
 
+    memset(&extra_hdr, 0, sizeof(extra_hdr));
+
     if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
         int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {

-- 
2.46.0


