Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A999C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZe-0004YP-O5; Tue, 12 Mar 2024 18:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZZ-0004Vp-Bb
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZW-0004Eo-HU
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MrO3S6qkYN4YcSINTZDLnuyG2BO2ocVcVpe9efTc8ao=;
 b=W4YaKiBlBADFfONC+I1KE5pzUHkHj1gBlk2WRiPC6AsP/OPX8URxgQwlFWb+gEYq/Zd8dt
 2fiqIZT4A5sOjL/zyNy2DX6W8Q+lZfr/l2nZCH5y5a7RjsABkF2NvDRwHwFoS3RYiqTv1f
 de7eXCkEFt1dH2bom3wqYQzlpLJ8R94=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-ewRgsndZNRGERW0y8Ny4vg-1; Tue, 12 Mar 2024 18:26:07 -0400
X-MC-Unique: ewRgsndZNRGERW0y8Ny4vg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d32656e8c2so3717401fa.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282365; x=1710887165;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MrO3S6qkYN4YcSINTZDLnuyG2BO2ocVcVpe9efTc8ao=;
 b=PX1JwgkRikJ9NEqSIUIF9hptZOaGKS+JN6hpz/yk8XhsZp7kK+yID+und11rmyhpln
 DPhUajbCV2a5ufZi51WuGKHreMW5TGaza3LnPuCDqulSkkR7/2pfypnJCWk6ibukujzJ
 xI4GcdZUoqSFC/BbrNmZZm0zMSyCo/E7sqjnN1uLHrFk3Ra/hCQx7w1wNrpKMCN6sfNV
 oCMWf/YK86zq/C2wZ+GfMBa95JuEwGJD2v+NasntjLnNxhquPNAu2gSNzrbpL0BLnhOy
 msGOK9KykSCB9XhflFTSk/FL3TzQaIRanF2gHf47L4F9Pzxk84BDgklGKfpAvnoEvctR
 bRpQ==
X-Gm-Message-State: AOJu0Yy4OB1n7x8nwBS8G2bdbYdYCOSaiFxlDZmQfkGgw1pEEt6++y1d
 Hhvcqj/DVNQdg1DszWil5DVgpxvxEs28D1n7hONC8XFgFY3sq3vqvBJnzCHWdhGrBAE1GJhMkMJ
 Xew+dFixSYaRIcwLY6h4pfSQNBfvTmzlk4S5oTMiofAvgDd2uqJst8Le6YMhg8rLnLWisQYodQE
 G2hcdkwILKEXX5VN7chIMx0Edmn/NUZkqG
X-Received: by 2002:a05:651c:1423:b0:2d4:68b8:adcf with SMTP id
 u35-20020a05651c142300b002d468b8adcfmr735454lje.5.1710282364934; 
 Tue, 12 Mar 2024 15:26:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl9z3lHOJqTNEGKEAgsRcik+9rCSIiBIn54XC/7Jl87Lqax72LCf95f8+2QGQXXWgxXrMkyg==
X-Received: by 2002:a05:651c:1423:b0:2d4:68b8:adcf with SMTP id
 u35-20020a05651c142300b002d468b8adcfmr735435lje.5.1710282364476; 
 Tue, 12 Mar 2024 15:26:04 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 s21-20020a50ab15000000b00568699d4b83sm1686322edc.44.2024.03.12.15.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:04 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 11/68] vdpa: fix network breakage after cancelling migration
Message-ID: <9ed62809b6e28ab0d887aff502ed24f77f1edafd.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Fix an issue where cancellation of ongoing migration ends up
with no network connectivity.

When canceling migration, SVQ will be switched back to the
passthrough mode, but the right call fd is not programed to
the device and the svq's own call fd is still used. At the
point of this transitioning period, the shadow_vqs_enabled
hadn't been set back to false yet, causing the installation
of call fd inadvertently bypassed.

Message-Id: <1707910082-10243-13-git-send-email-si-wei.liu@oracle.com>
Fixes: a8ac88585da1 ("vhost: Add Shadow VirtQueue call forwarding capabilities")
Cc: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index fc84cf6ec6..c968278e70 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1456,7 +1456,15 @@ static int vhost_vdpa_set_vring_call(struct vhost_dev *dev,
 
     /* Remember last call fd because we can switch to SVQ anytime. */
     vhost_svq_set_svq_call_fd(svq, file->fd);
-    if (v->shadow_vqs_enabled) {
+    /*
+     * When SVQ is transitioning to off, shadow_vqs_enabled has
+     * not been set back to false yet, but the underlying call fd
+     * will have to switch back to the guest notifier to signal the
+     * passthrough virtqueues. In other situations, SVQ's own call
+     * fd shall be used to signal the device model.
+     */
+    if (v->shadow_vqs_enabled &&
+        v->shared->svq_switching != SVQ_TSTATE_DISABLING) {
         return 0;
     }
 
-- 
MST


