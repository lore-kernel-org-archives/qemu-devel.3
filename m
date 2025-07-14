Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AA7C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 10:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubGRE-0006D1-34; Mon, 14 Jul 2025 06:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ubGON-0004X3-79
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ubGOK-0004PW-II
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752488793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yz4vOS2fmmgscDI3pPEkDat/uO4epkzlY9i37k2Fmm8=;
 b=APJrmiqbZILqEYT1mZ3CmUrr38gFtrX+rCo/aOzJ6I/vjg4Sd5/Iz2sZKqAJafn3FpfGm/
 2ETRbFQNtff9CUWei85LpBn7y1r3BbeIpjgw6fiiONyVz5LFmk1r7lXCR/7GEVw8po/YGS
 0fVFEiAo+ZHRTiZpkxp5NlM8nIcR7S0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-8fu9k7nrM_eMsCriJdppmg-1; Mon, 14 Jul 2025 06:26:31 -0400
X-MC-Unique: 8fu9k7nrM_eMsCriJdppmg-1
X-Mimecast-MFC-AGG-ID: 8fu9k7nrM_eMsCriJdppmg_1752488790
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso2684364f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 03:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752488789; x=1753093589;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yz4vOS2fmmgscDI3pPEkDat/uO4epkzlY9i37k2Fmm8=;
 b=JNEETwp7BinGu2J41QOSVO1o6+9OCY1I18IjiAr53SLimmbjC6WN4KapUGGftAuxp0
 jf9NcUje4T9wUa1ssirlO2mjdI8x9WKCj2ikgFhBjy+fWU7AOCO8TYQhrt0Jb0XIbrVJ
 zb6xmMrcbjBk966/p3Y67wqtcBTcJ/Tv6ZjXyISe3YgEBePcp2VsRAt1j2ylGpNtiMgr
 h29Yx6kojPLOmyJXzPzY1Mxu1Xydz6iPvB4vh5/Fs5vkRNuLntg7ezWHzeyJ4Jg7xCUa
 xm/rIJHjQpzj+gLhPelzJ/low6K5NVumYOZk+fAvS0SZXGfkMUYJruZ8A0VMUEz0lYbH
 aEHA==
X-Gm-Message-State: AOJu0YyM8r4nUw1lTeFuTSs1CLae6w7DcIaHyw+sBmsSwUi5KN4S509I
 Y/BRVjs7nxwJuM4uXwANNzd6SYM/JlA9Cc65iMg8acFYhCj+bhnIhiFPTUEzsklTOyusPr5kgkV
 GR2GVfpQo7QDa1TKLJoV/uzbpjgmByWjIQRN2xbjaAX+WtPxRjfuQKPoF4Vf9znnPQgS1QbEtsn
 3G4vFhdoXZyfmb+r4OvNHl3FBjGXVUQr4Xw5yF6yHd
X-Gm-Gg: ASbGncvK1siF7SJUt+gVOvoS4sbxWnVSWlH/4VZk3xNvPDVKZ77vzS2ZIkkVuD0oPI/
 TUOrUWM7kGfmbygpdGcVyq1b4foY3QhWra2YTen/ozN8uX8APemc7n6JR2p6J4GnZ6Ht+SQb9EF
 /vwE6GX8II0AYOVokF/v4DYf+4KGx89qZxxW5eIBHvRjxhR9OS+AWLLUCQajFY2nX+apCyZjlm4
 M0OmKHi9fDrNpfFDfnwMnPCaCYaz8Y13Xc/3s2yIsX4WET83v+yfOCIIlqSVyjX4qMzKiSl+uMW
 N1dz5fWoQCCezAMg9tJSsrrfgsLvgA+DjyEt
X-Received: by 2002:a05:6000:22c1:b0:3a4:e6e6:a026 with SMTP id
 ffacd0b85a97d-3b5f2e1b3d4mr10028768f8f.28.1752488789232; 
 Mon, 14 Jul 2025 03:26:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ6mcxeczwUVzP65wbzm9SbozOcYmPw7bUBGvyuQm74x4U7KBsjvaF7eyGnLGJt+CBoK4ocw==
X-Received: by 2002:a05:6000:22c1:b0:3a4:e6e6:a026 with SMTP id
 ffacd0b85a97d-3b5f2e1b3d4mr10028732f8f.28.1752488788619; 
 Mon, 14 Jul 2025 03:26:28 -0700 (PDT)
Received: from stex1.lan ([193.207.162.97]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e14cfcsm12193531f8f.67.2025.07.14.03.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 03:26:27 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] MAINTAINERS: add net/vhost* files under `vhost`
Date: Mon, 14 Jul 2025 12:26:23 +0200
Message-ID: <20250714102626.34431-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefano Garzarella <sgarzare@redhat.com>

net/vhost* files should be interesting for vhost maintainers/reviewers.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e88ed2c0a9..045a896d08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2321,6 +2321,7 @@ F: include/*/vhost*
 F: subprojects/libvhost-user/
 F: block/export/vhost-user*
 F: util/vhost-user-server.c
+F: net/vhost*
 
 vhost-shadow-virtqueue
 R: Eugenio Pérez <eperezma@redhat.com>
-- 
2.50.1


