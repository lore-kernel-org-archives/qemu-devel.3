Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A69FCD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBi-0004GD-SG; Sun, 14 Jun 2026 15:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBg-00041W-Pu
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBf-00025O-4C
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V6hUAUjTOLpx6Ar8t3YIETcJ6oUZLH3lFxtItrYg4n8=;
 b=JXfx57Ha1yayniLJbebUbhtyJWcBOkl22zypCF9xvYhYekUwmg5IhZs/hZ2XTHj4GiKxPk
 CV8n8KCXyOXNRBFnezv47LUy7xqMVhT4qWtchDl6Muv2dOwUV+3CBNrxheJAP7/TSG6x1s
 zUgeC+MfbNorcviGOhmiLHYjh2KiWXg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-1V2wm3RhNVW0aJY5FJ_l-A-1; Sun, 14 Jun 2026 15:08:01 -0400
X-MC-Unique: 1V2wm3RhNVW0aJY5FJ_l-A-1
X-Mimecast-MFC-AGG-ID: 1V2wm3RhNVW0aJY5FJ_l-A_1781464080
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490aadb1386so18039865e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464080; x=1782068880; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V6hUAUjTOLpx6Ar8t3YIETcJ6oUZLH3lFxtItrYg4n8=;
 b=kPFG/bNJui9z+6arh2yvvAJOAhY+jPPVoJpD5k4+TTZtxLpsOcV13hCYnqivpTzIGp
 eL6M3VkuHTrdC2S91u9ZKLbf2RPkLV7lS9B20nPYJdMdkA2BIbsexQ9HoU78A1K1p0qt
 B4BbOiJLBhIIB8meEgL0RLdHUprY1mjvX9kN/OJsSLgZmYPM5q8hRlbjgmU3ER9bgHKD
 kaL3ceDhKjImW5Clsxxo6f7ZDs1Bkh5iGk7ys6D6eUB9+fSH8vPwT0UFCKxdjIr9Bo84
 4m0tmIt93unTUKh2WZ5xdI6JH850dAcoSzfHmscHRzPAmyyHlkCOhc5zYLyL+RKD93Yb
 aE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464080; x=1782068880;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V6hUAUjTOLpx6Ar8t3YIETcJ6oUZLH3lFxtItrYg4n8=;
 b=lSQaM+uG3uF3a+0Rv5IlN4BR+nwnnrE+USgQBjqmDnREYT1goPhKwBU81NnFCRP3C6
 STOJ8BWj67BF2khWdFOdNk2RJOlQ/5+kJ4A6zUuM+MubWtAw46HoJouowXZPFv8yXx2j
 wUj+ZSzRyk6DpP5W8uaKnfit+dPngIVZPBIBJ8GYHXphX1zRfCju0qeIYYbqtcdClD9k
 vbJgTRsmYRw54Gi8XnnBo8CNVAa4t8Wr8iJEAqWc1uKaZN5vITDxLFhA8xAw2QnoKx1s
 W8sKJIOPSGyF/114VZox2Xqz8H3G6T9xo4OqNKhsOEYlFoh7Wn8ejh/tCF8sqDy8pPNz
 MuVw==
X-Gm-Message-State: AOJu0YwjIMHlk+fdn5dW04brQFwC2KdKd6fF4Jt3RNJ1A2wcJIffse7e
 xPjTrhiz25OW69XL8vdqtThA6x0Z/LDnGEylG7DAl3fu1HcnxAIr1I9WV5tdkfe6vvqvZRtR3pb
 PI7kRC+NfIatgUcT8+CiGI3/yRs3y9dXHEwN+dB1g63+ske3UQEwGDDYxEnqVh/KJBiFNV3HUw5
 LuSwrPUR02sUg5EcRwLC9Ly4x/NoBIV6lg9w==
X-Gm-Gg: Acq92OFnpCRUVDAo9uU8A+ykhbDl1CecS+OdMIeUTOUpIj1i3ecoNVgmzDXH8IAKw87
 Ne+8W/WAwpElTDmxwxzAmovEkPxIz4BGJ5pJSM5Fr7XujVTS3admrP5D6nPW8OiiOARz4V3tN8Z
 BGTcHVCqPVp02aC1vJNAzZkUDXZ+iMSbSReUK0kCCISpoiGnYlGLs4YtKrNJR6ydGO7bbv6PSI6
 GXriQG50bPceaDmnS5SiuAG2FQ4H6ztGKA1liEIfHzPmR/+s+P9SDXX17o7kax8Dp1e4cPukjXk
 DnozRU8/uFeC+LGV4FKsxo+0IKbRKgWDpDsRRP7cPx147L1PRnDeQqJzhs8k/sbDeM9zUbgDVpT
 qBo0Zmn2McRX8FoJNmdH7GWfkfiNd16yMWX8lN8+8k24=
X-Received: by 2002:a05:600c:1912:b0:490:bbc1:c9be with SMTP id
 5b1f17b1804b1-490ec30f6aamr110711965e9.0.1781464079896; 
 Sun, 14 Jun 2026 12:07:59 -0700 (PDT)
X-Received: by 2002:a05:600c:1912:b0:490:bbc1:c9be with SMTP id
 5b1f17b1804b1-490ec30f6aamr110711765e9.0.1781464079394; 
 Sun, 14 Jun 2026 12:07:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492203d08bcsm184205355e9.13.2026.06.14.12.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:59 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 051/106] vhost: rename vhost-backend.c to vhost-kernel.c
Message-ID: <78bdeadfe60b051871f1ca3fffbce9ce1304bd4f.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

This file is totally about vhost-kernel implementation, not generic
code. Let's finally give it corresponding name.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420202032.714884-4-vsementsov@yandex-team.ru>
---
 hw/virtio/meson.build                         | 2 +-
 hw/virtio/{vhost-backend.c => vhost-kernel.c} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename hw/virtio/{vhost-backend.c => vhost-kernel.c} (99%)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 0ea89d8af4..3943e0d006 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -14,7 +14,7 @@ system_virtio_ss.add(files('virtio-qmp.c'))
 
 if have_vhost
   system_virtio_ss.add(files('vhost.c'))
-  system_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
+  system_virtio_ss.add(files('vhost-kernel.c', 'vhost-iova-tree.c'))
   if have_vhost_user
     system_virtio_ss.add(files('vhost-user.c'))
     system_virtio_ss.add(files('vhost-user-base.c'))
diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-kernel.c
similarity index 99%
rename from hw/virtio/vhost-backend.c
rename to hw/virtio/vhost-kernel.c
index caeadd069b..3390b48c6f 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-kernel.c
@@ -1,5 +1,5 @@
 /*
- * vhost-backend
+ * vhost-kernel
  *
  * Copyright (c) 2013 Virtual Open Systems Sarl.
  *
-- 
MST


