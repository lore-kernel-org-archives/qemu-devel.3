Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4995C3DA63
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgjj-0002aO-Ho; Sun, 21 Jul 2024 20:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgji-0002UL-0s
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgjg-0005hU-9P
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fgG/mkRDkzGxJm+xP/ZVe4hG5yYRqISPsjfYjXIDy78=;
 b=Qrm2VYQ/5n6m9w6OBlzSAr0/KudmrbrGaYo71brbBhmpPXQixw9Pp04Yi3sF66zdSevEz/
 9GfL5rabEC3czbFQtm9/cx0RwPvUGDeI0jZmLhSS/F451g5fFvxWo9NjZ9xcvx8yEiEQJb
 U+oTLsNLWtk1nQVCCHZ0gQhPE42Gkg0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-Wsl84XdrO2K-Th-HdTzQ7w-1; Sun, 21 Jul 2024 20:16:57 -0400
X-MC-Unique: Wsl84XdrO2K-Th-HdTzQ7w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-427e369f757so6935595e9.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607415; x=1722212215;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fgG/mkRDkzGxJm+xP/ZVe4hG5yYRqISPsjfYjXIDy78=;
 b=RZVRBUwQh4b6XBgRXgqNjh4cE2o8SD09OnErPXymrznraPfbpr1OnQ2xDKXaGRi5uA
 Lm3V48+sa56hqd+AjkTOWjtKPTvdaGjoXUHiDhtMepihO9t4Lx3pVwcubIquhKUuD5h3
 xjvs+vBG1o2TtsDi7CFbKAkj7WYgc2rLfCdHrzQLqYPzNrE+ox4SsKG0U2tVHHCufr0J
 FrXKl1f0+u/OzJAG62hxoSweSulToOPHs/1kDUwV5XBK6HExlVML1nnmna8jOT5qRgX8
 auOUXTcANq+T7tBQ43u4nW8VVu4XSK2sX//N9DMyoJbusd+8wFiv8K3vM46iKbiOtdZR
 cmUQ==
X-Gm-Message-State: AOJu0YweQbMgvvO4Gj3QlP1Jf6gvdaXgxk8wmNb/j7FMNc5z/YlN3tPF
 UnhDFYTaHlF+TO89X1vVBtJGZqYNveGyVA2x2X1gQkiA2v6k2CwjTy0rxukbHrhs9kYSAPWxS9M
 +J1p1MSJEjsSRRtDasbDuFVHw7JCYAnaLR90HTRVlVLA0Y3XpXlDaPOpL5Hwlpvvu7KSRjGAQGU
 0RlUeR4wnOWlqYdKIryIqNbPWiusOZ3A==
X-Received: by 2002:a05:600c:a085:b0:426:6f87:65fc with SMTP id
 5b1f17b1804b1-427dc527fcemr38494465e9.17.1721607415550; 
 Sun, 21 Jul 2024 17:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPnFDRryGdHj2f+jEDHtdDbCppv6tQ6L8GFqd/fm4YVJiIjnNt4v0Fz2vgQzXUwuJDgMxFGg==
X-Received: by 2002:a05:600c:a085:b0:426:6f87:65fc with SMTP id
 5b1f17b1804b1-427dc527fcemr38494325e9.17.1721607414987; 
 Sun, 21 Jul 2024 17:16:54 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a947fasm133276815e9.43.2024.07.21.17.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:16:54 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:16:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 02/63] MAINTAINERS: add Stefano Garzarella as vhost/vhost-user
 reviewer
Message-ID: <7967b7e0b17cb5e700ca040e0b68ba8fb0035c0d.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

I have recently been working on supporting vhost-user on any POSIX,
so I want to help maintain it.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240704081336.21208-1-sgarzare@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d9811458c..b7e9ced3e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2209,6 +2209,7 @@ F: docs/devel/vfio-iommufd.rst
 
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
+R: Stefano Garzarella <sgarzare@redhat.com>
 S: Supported
 F: hw/*/*vhost*
 F: docs/interop/vhost-user.json
-- 
MST


