Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A0EC636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuAT5-0001BU-Jv; Sun, 22 Feb 2026 09:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASu-0000pt-Au
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASs-00073M-1f
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dGivE52lN7YTrWxIz+45vbVv648OVQoFgJW04Yu3Yy4=;
 b=JFQn2MgoLr8ecslRWQEmZZFAzsTX6ybzAB0g4272Mx0Yv3EKGzs1YygKlWi2tn8BF9HFOr
 K6lkiZUxIyX5K175wwR/Gk09lo180Xk6shgYNEwAUpv/waNN8klta8kqT6/cJ7cAIefqWT
 FqEo7nwP758Y74GBksS7dk1TErmqrM0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-Eos57rukNOagEmHq1mX17g-1; Sun, 22 Feb 2026 09:29:39 -0500
X-MC-Unique: Eos57rukNOagEmHq1mX17g-1
X-Mimecast-MFC-AGG-ID: Eos57rukNOagEmHq1mX17g_1771770578
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-435aadfaf4eso2582965f8f.2
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770578; x=1772375378; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dGivE52lN7YTrWxIz+45vbVv648OVQoFgJW04Yu3Yy4=;
 b=ZiL+RMRzkjEFqI8l6kbu6mnd0sLyMdQX6W5feSxLGFhH6/vQHcU+ZTI004kHtnXnem
 XY5FRZBYYVSXsNeTjzIu7UQcRFrldtAArygweNJyT63g05iasKxK8bHHgIR6bWtORDQc
 4ijVPHBIMtW19dxZfAPKVe8aQhbQGAnCfjz01ow6Y3yvO3iBA0AfcW0OQJ6zz84MyQ49
 VmwCvkh+j7ufMDBsOChesZAf+56ZzDNe1N8yQ6KuZviHxQjWug8p2KTUIcrlaPdwlj2K
 hC9V6HQVXUWNyKyMin7KJ1QVjkp7iStBl5Uo/vsdmwwkcGk9WX247PnL1nrk3XxYgkPZ
 nFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770578; x=1772375378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGivE52lN7YTrWxIz+45vbVv648OVQoFgJW04Yu3Yy4=;
 b=ZEQeY4+LfMTfwdIGhkEb24qHNyGedkMs0vfv47dOr0mM+M8syre6MOTIWrM24FhgIz
 OaSDK8krhakQhZyw7UNSG7rPJSaOR4U4wnD7X0+OzO6rZuiI8SMfu6h5NNFx5P8ZRcck
 yBr3DLf1eegCxZsn5mdtoEKM5xkpPwlRb6U/I03haTqJYmUazuEc6kyLX4mpO0eNpJUo
 1QJGHLlAW9vz86ckb5OIVc/TRMDfhdJrVOuwtGbH6eaSb/zW4/SKvsWlC9J3PJ0fbWa6
 LG7ykm9JgCZDETEB9RA3bgOTeb6tCP9XjJx8QDKjuGWwmixeuVJOvx3ZQMVYRVSwFKHV
 uU2w==
X-Gm-Message-State: AOJu0YytYv9knz6kCIRLlWk4pdS0yN3lTPJw9VpS650Ej4JUP296UeT8
 wkcN/Aig5UI9GoIg98WVY3ybUfwXQKkVNN6P/JKOcq/dqs22wcr8Hjxit85i0QAW2+MUktqd43G
 kVY0ORbZIxhjXlhfCXv5dDVJPhQv6g/Pk7SHd6gOiT4hwtHv1jDfHArIIwdxS52h0CAf8y2B4Xs
 9/SDw6ssibVQ0BodKB35dsOQo6b2ltbhH94g==
X-Gm-Gg: AZuq6aI6HYrx91rNaHiUUc9ysIwAWt/yNOIUYOX/rx3S1+6ARvaAaj+5er1/kD6n0d9
 eK+lpt6vm5ZPmki1gAFRHIUgezhGMBUfnu8oJjeIS6yJNyfXDbTpyMlxzJvc+NOBVqiYFwiRkfE
 Oztie/NJ6CV3AQUju2XKoGzgaJs//iwopfxShlXgIB448LKbZwfpXOAyKilN3UUeWejOe9v7qUf
 ZZaqW+LoQtc7lPToPy7ONp9hDcgpwszTW9X658e3Tyqs3urlp3Ibzfj8u09x0VAsWaK8B5ZcAE3
 Viz4rGgbijO8mUpGw7PPSa+p6FSzQVmX+SMw61rcJ6wQK80LoOzrtjq7qPDVCI6aeTdam0cs9kk
 qyMEiHOCMvUMdI2JlXKkYYtY+44PMsfXlLJuGAOM+CgbEDw==
X-Received: by 2002:a05:6000:4310:b0:437:712a:fac9 with SMTP id
 ffacd0b85a97d-4396f16d27bmr9780530f8f.23.1771770578024; 
 Sun, 22 Feb 2026 06:29:38 -0800 (PST)
X-Received: by 2002:a05:6000:4310:b0:437:712a:fac9 with SMTP id
 ffacd0b85a97d-4396f16d27bmr9780496f8f.23.1771770577501; 
 Sun, 22 Feb 2026 06:29:37 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bfa1bdsm11504703f8f.3.2026.02.22.06.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:29:37 -0800 (PST)
Date: Sun, 22 Feb 2026 09:29:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 33/33] vhost: fix vhost_inflight_buffer_pre_load
Message-ID: <72f663f575ab5e0f31320d7c9f25cc1f086313bd.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

While I was rebasing my series about inflight migration, I missed a
small issue in vhost_inflight_buffer_preload:

* fix wrong return type in function
* fix error check

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Fixes: tag pls?
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260220094800.276489-1-dtalexundeer@yandex-team.ru>
---
 hw/virtio/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 52801c1796..f83bdcaf8b 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1926,8 +1926,8 @@ static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
     void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
                                   F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
                                   &fd, errp);
-    if (*errp) {
-        return -ENOMEM;
+    if (!addr) {
+        return false;
     }
 
     inflight->offset = 0;
-- 
MST


