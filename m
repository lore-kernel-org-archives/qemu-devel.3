Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AA6C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZb-0004Ww-5A; Tue, 12 Mar 2024 18:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZW-0004UD-Oy
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZS-0004Ee-MX
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bC0eTdSzwxwKSxJCZ+HWjFlnIeg3Of9nGwQJMYhFWrM=;
 b=ee1PggiJQJSFLAo1sI+zgoW8wOitr0I1Ev7isVEjsOjDVgFuv9jK7bvF6eUSh7fyJXBY4q
 kbJu+W1U1IMruAysmz9yGcrYnCh+CYpBVIc3WD+tIF45MIsbJY5Qf4sQpZq4O/uVvBBWi2
 K1dwEEPv0u5fyNLfWk5vDSRG9SfrqiM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-glI8KeiCPOWOtpPznw1Z7g-1; Tue, 12 Mar 2024 18:26:02 -0400
X-MC-Unique: glI8KeiCPOWOtpPznw1Z7g-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d45c7efcb0so8521191fa.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282360; x=1710887160;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bC0eTdSzwxwKSxJCZ+HWjFlnIeg3Of9nGwQJMYhFWrM=;
 b=Xoys0SHzUUUT6804ypRXigLLiJ6i1prK60I0IQ+0I97oGtM5GHqusZ4p9vy+FVCczX
 7jd8y9Ww7iobe5QpaGH1KrDyuu6cTZLXtL3KhRklII/Ty2SCbTJ5I9EfWiy9nNEP5PCn
 2i02Ht5xbxlGD+cjFgox+6/GYwDr8c5FDfYUVD1LFSwEwUotV7SsmXuUfBW3hSMVw4HP
 OfQBsTG6V3ziYQ0E2mlLIJcI+hvJUBO+gVSQHJ8FB7GbImkEbDKYA4yQIlHrc53FrYVI
 9Q95BoJt0aHh7d56Lb94+29jPB2PEM13UXUrG3qNGVywoJJpz5dl5oqMobsKwvOa2hlq
 MOuw==
X-Gm-Message-State: AOJu0YwZpgjFIG/YzZz27TAEhBeGmGVdxKjnb8dfVAJ3LJHnLYDLhuDY
 1qsklO01mjgpNioUfao0SKuu9BkicEnJ4NYzi6Xa+pJ9fxltZv227poCIzbnI/7wa+3A0nmlQKV
 KlOnlVejU/zSr/ipvR9t5ywDVUe5m0gd2+E5VXmEi1VBvUyrSvVV6EtkvvtlFQeWmWWjrGyqzHt
 wHopsRJ4xEWlA/0/M0yOVuoyEu88u9q4xm
X-Received: by 2002:a05:651c:19a9:b0:2d4:2b05:a671 with SMTP id
 bx41-20020a05651c19a900b002d42b05a671mr7666107ljb.32.1710282359603; 
 Tue, 12 Mar 2024 15:25:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAoIEyxTnZ9vjcVpxXXFeCb8/ssxZsQQlAHxBpPu2nwqEY8GXIzeBzrNE2FVCZr7MQ3HCRWw==
X-Received: by 2002:a05:651c:19a9:b0:2d4:2b05:a671 with SMTP id
 bx41-20020a05651c19a900b002d42b05a671mr7666093ljb.32.1710282359035; 
 Tue, 12 Mar 2024 15:25:59 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 j12-20020a170906474c00b00a45bd9ccb55sm4205619ejs.155.2024.03.12.15.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:25:58 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:25:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Si-Wei Liu <si-wei.liu@oracle.com>
Subject: [PULL 09/68] vdpa: define SVQ transitioning state for mode switching
Message-ID: <bb000fff0a1d9774444c431e0831550e99e159ce.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Si-Wei Liu <si-wei.liu@oracle.com>

Will be used in following patches.

DISABLING(-1) means SVQ is being switched off to passthrough
mode.

ENABLING(1) means passthrough VQs are being switched to SVQ.

DONE(0) means SVQ switching is completed.

Message-Id: <1707910082-10243-11-git-send-email-si-wei.liu@oracle.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 8f54e5edd4..0a9575b469 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -30,6 +30,12 @@ typedef struct VhostVDPAHostNotifier {
     void *addr;
 } VhostVDPAHostNotifier;
 
+typedef enum SVQTransitionState {
+    SVQ_TSTATE_DISABLING = -1,
+    SVQ_TSTATE_DONE,
+    SVQ_TSTATE_ENABLING
+} SVQTransitionState;
+
 /* Info shared by all vhost_vdpa device models */
 typedef struct vhost_vdpa_shared {
     int device_fd;
@@ -47,6 +53,9 @@ typedef struct vhost_vdpa_shared {
 
     /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
     bool shadow_data;
+
+    /* SVQ switching is in progress, or already completed? */
+    SVQTransitionState svq_switching;
 } VhostVDPAShared;
 
 typedef struct vhost_vdpa {
-- 
MST


