Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D3AEA7943
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vni9W-0005t6-Q5; Wed, 04 Feb 2026 14:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9V-0005rt-Bv
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9T-0007hO-Ny
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bD1aJbj8IneCRsibSK1oGwMvkujFVHWrwVolf2Dfjgw=;
 b=gIr2G98e/Js1/YTNz3YhwzxsIrD4Bh5LQPH2tZgpw3Dy6g05OjRu5HP++O6ooSL09paLW5
 a7u775ghJUsnNz3bGoo/OCfAuUKMw0h8t9dXxvlMfpBqrjAugfoOJTgugO/nP6dsvjJfBm
 2eAMjyAe5qW8jfGEAhTgNgVAHTmxVvQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-dz7j871rOwi7GmGgSo94jA-1; Wed, 04 Feb 2026 14:02:57 -0500
X-MC-Unique: dz7j871rOwi7GmGgSo94jA-1
X-Mimecast-MFC-AGG-ID: dz7j871rOwi7GmGgSo94jA_1770231776
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4806fce5ab1so749235e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231776; x=1770836576; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bD1aJbj8IneCRsibSK1oGwMvkujFVHWrwVolf2Dfjgw=;
 b=LGe5jqzv1a/TZsVSw6NFt+fz+h7xBVK4tqZgFLGQ0nJyuqtjwQyNwjeXSxzfD+4P76
 sGTNhKf95b55x1lDDt4fz908w3ew6l341X2yOKMaw/U/RKoaXCIl3o9gu+V7ttauZW8D
 rbYivorDa7GxL5dkhvqSyEHEoHk1UVp8MtU94m/zJpKPJXuHQTKzKLuK0v6IHGpaVRou
 B2Ne4T/UgGZjn5BbhYPEHAJ4TNC7hfOvQG0XPu41Y49/Y+9gzZIXlfbv1Mk8xRb8uQM5
 LHcVH5tyi/U4pqRgi7tcrvDsScMADaVHHbYtGcamznKQS6jBjZD4Z+y8PCApiY/Sp0y9
 B6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231776; x=1770836576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bD1aJbj8IneCRsibSK1oGwMvkujFVHWrwVolf2Dfjgw=;
 b=RHPv4l7bBi6JIEDdZLddJTSVXnyniozBRg5LRPcqsZoq5ChocMq5WTT3Psj0Kns1at
 0p1Xxfl1MBKrY6vsChHjT9ruFYq72u7F6ESTq2022yyR49kswgHPpYC17wl9zoA4u4++
 WxbdbpmmbAfFLab/jjFPYdHTAs4w5yQGjbkAR9vMgf3nS3Xk+MT8iE0MnW+CIbAB1SqO
 9mtJmJB0VDetHMuqbzfkFDpD7oX9A+NJfpn+RYTiIsXb0zBX3jfskLecXk1gE3VdpLDH
 WA4d97CSeURtJy2ED+eBKI8QrmFLCmriYjx845k9QtlhDYBkoumnMtafrEAENQXra2um
 X4NQ==
X-Gm-Message-State: AOJu0YzEx577k1J5XnFLV+RM8BCxFmv6Spn3CoSsUsdQn1xxy0a7gnhz
 PmgDFzBZpgbeNQN/WFiLzo5KQ1ZY5m+54obCadRZN6TnmnHT1orVyCv72wnK/j8GnyU9KXTFJSY
 wZPkeYfclZ6YScSv0H0Exrfqt0fW6VSSDJbH/FN9/uH1eJGroH4KK0a0RSxlI+p1x4vjVrmXEis
 RWZ5jP4KXBOArqnkw/p5swNxfmTE7SoDa9cw==
X-Gm-Gg: AZuq6aL0Xv6Bzqv32+KinhP3WdTt5+qF+3W+kZjqkradpu4JSnxrc5GjhYl1ypolT9w
 GLaU1rqxtdK8VBhoX73FHciUC0DJfGB9RYE9nDvDOQM3c5rlRK8abrjyuA13R84YgAYlN4DF25B
 nL+wUQJzhZTPlWy5D8lW5dtkDikBCkfG8klOm8dqf/1kzS3RVTHH47LSFa65RT/X4iWlrk4aDkL
 +ImzhcRRtWiU4Y3/79GyNN4MihpBadSLpQQ5JmFV9kSzOh3qD9q7qBdjtQXvqVTe1yc5JLLDTya
 ylS8g0EVcPf1RG4p+KVzfj74WqpH2nmEbhoKtD2mzMMAH7RaiLso0mblcH6a5WJGpaMsfMcvKUl
 937cJ2mZB45LX4k/PGtShbjL2afouR/8KGA==
X-Received: by 2002:a05:600c:19cf:b0:477:582e:7a81 with SMTP id
 5b1f17b1804b1-4830e93ea25mr51434785e9.4.1770231776139; 
 Wed, 04 Feb 2026 11:02:56 -0800 (PST)
X-Received: by 2002:a05:600c:19cf:b0:477:582e:7a81 with SMTP id
 5b1f17b1804b1-4830e93ea25mr51434315e9.4.1770231775540; 
 Wed, 04 Feb 2026 11:02:55 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e37e78sm9012143f8f.10.2026.02.04.11.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:02:55 -0800 (PST)
Date: Wed, 4 Feb 2026 14:02:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 02/51] hw/cxl/cxl-mailbox-utils: Move declaration of scrub and
 ECS feature attributes in cmd_features_set_feature()
Message-ID: <f6bbd6571821898ad598a8621e0a4926ebc1648f.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Shiju Jose <shiju.jose@huawei.com>

Move the declaration of scrub and ECS feature attributes in
cmd_features_set_feature() to the local scope where they are used.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20250917143330.294698-2-Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6cfdd98168..65b599f7aa 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1351,10 +1351,6 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                                            CXLCCI *cci)
 {
     CXLSetFeatureInHeader *hdr = (void *)payload_in;
-    CXLMemPatrolScrubWriteAttrs *ps_write_attrs;
-    CXLMemPatrolScrubSetFeature *ps_set_feature;
-    CXLMemECSWriteAttrs *ecs_write_attrs;
-    CXLMemECSSetFeature *ecs_set_feature;
     CXLSetFeatureInfo *set_feat_info;
     uint16_t bytes_to_copy = 0;
     uint8_t data_transfer_flag;
@@ -1396,13 +1392,14 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     }
 
     if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
+        CXLMemPatrolScrubSetFeature *ps_set_feature = (void *)payload_in;
+        CXLMemPatrolScrubWriteAttrs *ps_write_attrs =
+                                &ps_set_feature->feat_data;
+
         if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION) {
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        ps_set_feature = (void *)payload_in;
-        ps_write_attrs = &ps_set_feature->feat_data;
-
         if ((uint32_t)hdr->offset + bytes_to_copy >
             sizeof(ct3d->patrol_scrub_wr_attrs)) {
             return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
@@ -1423,13 +1420,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         }
     } else if (qemu_uuid_is_equal(&hdr->uuid,
                                   &ecs_uuid)) {
+        CXLMemECSSetFeature *ecs_set_feature = (void *)payload_in;
+        CXLMemECSWriteAttrs *ecs_write_attrs = ecs_set_feature->feat_data;
+
         if (hdr->version != CXL_ECS_SET_FEATURE_VERSION) {
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        ecs_set_feature = (void *)payload_in;
-        ecs_write_attrs = ecs_set_feature->feat_data;
-
         if ((uint32_t)hdr->offset + bytes_to_copy >
             sizeof(ct3d->ecs_wr_attrs)) {
             return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
-- 
MST


