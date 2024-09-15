Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3C5C35FE2
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spdj7-0001Hg-2n; Sat, 14 Sep 2024 21:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdj5-0001CG-Ay
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:06:55 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdj3-0004AD-QM
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:06:55 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2da4ea59658so1870841a91.0
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726362412; x=1726967212;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZUcT+2gn0meAFPXtJKPK+LJvYH+cHREDYZFhX2vH00E=;
 b=hazzoG+DmJqPJF31gHwtCrE7RD1z9pCPbYQbqp8BTCK5OoAvVt2SKKz/pPoqqvAe/t
 MPvvImrZSIsdKKB/YHV7dL1Cd2f/oBZfmCDZwZBholHQ5jV+pnevFKeHuvg5T+KCVo/Z
 eaATtsZ0yOfXR4BZKeMXJebYiCx5IFHj3YoXcwiXXbMHe/DA92iIIz5EmJmZuV5eQOhk
 +Vry25TwSady2qDhbcHpu71dE/i/JkKsb0IYd2iE63WXZX2OYu3gGGh609uMtCOzuWNm
 8p29GcrdWHuczROD1PLNsKN+ZnW3TVZDBv5Y+4X75LWGvXcdBmTdSZxWra5NyxafYbl/
 J92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726362412; x=1726967212;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZUcT+2gn0meAFPXtJKPK+LJvYH+cHREDYZFhX2vH00E=;
 b=mruP3wE0Ng/IK8lF7DD0ckzqVnomn597Zb3v70hpK4T9LlBC7KphzGDhmhs5PzdSoa
 SqlKXr5qeIdBcstg+kCTKmPJhyfCbfSsIfVG80DhwM5VcKfqI0t+yFh6D/Ok/pJsqNJ3
 wcVmGsc4XHGoNEzS752qmvxD/mtQ4rk5dE1M81CdS1L4LjtYBItYL8UU6e9/zTYlzcXI
 dctaep06OeL0kDgX69jiZgt5NLFxDiBcrXo37igd5RIUZxScGmkTp6e0HrlBwuOdLKlE
 gNyU2hjN1NGlwvzlTEyfr5zTsFTUeums9plWX/eU/qDue5KUL7eDQoqlxvIgBGJBI+M2
 PH2Q==
X-Gm-Message-State: AOJu0Yw+ucKuJwZJ/snUpZyXWO6oAQza1x4q2Dte9MY1DqX5sxSygYLN
 OuevkBuWpvI+4ZSugeh81V9WrU33Rqjm7lTKSlV3Gv/Kx5/PApKNCZI53/5nLI4=
X-Google-Smtp-Source: AGHT+IHtSwK0WBC3+G8cJ73ei9TYeDv3GAf+7aPlliHpntNmlfZMyfjdFrKVVOCP7elqmYzyoitxtg==
X-Received: by 2002:a17:90b:254b:b0:2d8:27c1:1d4a with SMTP id
 98e67ed59e1d1-2dbb9e47368mr9939934a91.24.1726362412321; 
 Sat, 14 Sep 2024 18:06:52 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2dbb9d98963sm4332039a91.53.2024.09.14.18.06.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:06:52 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:06:40 +0900
Subject: [PATCH 2/7] virtio-net: Fix size check in dhclient workaround
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-queue-v1-2-b49bd49b926d@daynix.com>
References: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
In-Reply-To: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 qemu-stable@nongnu.org
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::102d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102d.google.com
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

work_around_broken_dhclient() accesses IP and UDP headers to detect
relevant packets and to calculate checksums, but it didn't check if
the packet has size sufficient to accommodate them, causing out-of-bound
access hazards. Fix this by correcting the size requirement.

Fixes: 1d41b0c1ec66 ("Work around dhclient brokenness")
Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 8f3097270869..755530c035e4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1687,8 +1687,11 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
 static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
                                         uint8_t *buf, size_t size)
 {
+    size_t csum_size = ETH_HLEN + sizeof(struct ip_header) +
+                       sizeof(struct udp_header);
+
     if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
-        (size > 27 && size < 1500) && /* normal sized MTU */
+        (size >= csum_size && size < 1500) && /* normal sized MTU */
         (buf[12] == 0x08 && buf[13] == 0x00) && /* ethertype == IPv4 */
         (buf[23] == 17) && /* ip.protocol == UDP */
         (buf[34] == 0 && buf[35] == 67)) { /* udp.srcport == bootps */

-- 
2.46.0


