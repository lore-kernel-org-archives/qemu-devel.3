Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018D3C636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASK-00089B-GF; Sun, 22 Feb 2026 09:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuAS3-00080b-9M
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuAS1-0006gl-Pt
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YQq2jEXU76sJtiThK7kgx3Pj3drtYSaaDPP/37DA9dI=;
 b=eLQ0KDxcZ2PS+KAYuEbvMCwgeWJ9jRD0GApdYbkOlzrUXQdL0qkqe4i+pf0/tX3dy9ozzD
 4VnkUDBSlUnYPYWSmC33z6E5MOPRo3bHA/kIt315iBFjPExtgAhyHTFrDcNaw/i8Bz4U8q
 /1YHtT9a5/rmxT3x4yXhvVOu45IePQI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-yV3U1EHnPjGCLgfAflMjiQ-1; Sun, 22 Feb 2026 09:28:47 -0500
X-MC-Unique: yV3U1EHnPjGCLgfAflMjiQ-1
X-Mimecast-MFC-AGG-ID: yV3U1EHnPjGCLgfAflMjiQ_1771770527
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43964455342so1755495f8f.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770526; x=1772375326; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YQq2jEXU76sJtiThK7kgx3Pj3drtYSaaDPP/37DA9dI=;
 b=aiqctDGddxCkzSOqRZgXU6MF4kfpwIIQO4g81rCIlabfoWgRe+W1WgCCE7+yaGzdr8
 ZhljOwCQ7+WMt3T+OSrXKhz/FvPCJWmVKSZLn+5+HCLMxqm65Tr8CN0uKTiEiUvmkaq5
 RrJfap2FlJ3hzyR6ifma70AubvjLgUfvvNMr3wGeSU8CcdAaCuZVtpeYkZVFwQepkGjP
 bWnPwqPZSg0e2UE7fL67A2PHRKcd4vgxtt08rUUOOwh528HVdrEVlmMRo848t6W7L9p2
 hZwh6rxW4ZqkTI4ACYGpMY943Q7mojRorkVE/OAX0ybezi/3hawCH3PTL9siKBlZAhrP
 0Xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770526; x=1772375326;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQq2jEXU76sJtiThK7kgx3Pj3drtYSaaDPP/37DA9dI=;
 b=nGcvg5Wip9viWhh+diokQQ8VKefJoPZmiMjJTu1EeuVQzsYKsuVN1PRAuSfUIxfjH2
 kE7UG2oi3Aak6YWhaN2cji2OnfAJL3PYoWODyxL0X2NuRLGOMfkiZNtPpVZNSDdsYl7w
 JK42y+0UKroCRJLmxDALA9riKiJY2PlNcz+Is3QmqfwoOsxHqdOO4osaUtr5sEj1MKdT
 +EElU6I4oA3J0bVv2Om8b6sJ+32ofh3oppkyE71zT7vScwTTpfa2y6CZr9zyue+k5nSb
 zEM/JE7H7RCqIafcK1mzpCYXiRkV7nvmSM7EZi/CzSU/eZDQFlLqIHLY2ZGpwbOpyuLU
 TZIg==
X-Gm-Message-State: AOJu0YwZaw9LxTjMVUQaVr9SH5/n7LVokAriHtJAnm1AmQjkekjy5KiD
 M+EuSYwo/KkDwhBo4A9qlsczTK+NDOXPPIMWkWbouoW8/HqidLXr3VROQe5ksKaQvGWFgzZz6Ud
 gwA8af8W0ufeUFiP134jb4z3IjTKhSPAYj6ewO1b2WhHK+fW/QijN8/2yPoW5QggjB5NmoeMYLp
 QqHQmmF4uBvzDzE1Qqr0zK6lirYHnVW2rw6Q==
X-Gm-Gg: AZuq6aJEFBd6ah2yAq0kBOZI2sm92Iu9QlxKppCRd8zL+wcpWh9B9s2OdCDApnWPf85
 TE6rXKWdk/h/oN/FnlHHG7cgqGd6nWcDeceCtCKK9/KHRXnZuwS0ekJN15AZ9npWO/9RV6XL16i
 4o+gKvrPibJ3NgROUNi8qBi359IdkFCSygmtWOqcinm58/+M3H/OEtmG4xycv6dhYVSYnTXVfhg
 AG7FQr+F6R2sKEMbzVsqW1U0jTtshMa2at8oB9wiMVb2HpTOqMSGf39ZgnNegnT6SNzXuM8x0HP
 IY8by0+pasCUihkj4T7wj9M8hhrsoSamTpAg/EmHBQQa85hoMPL485A0jUY5yxe9EoFQ6JgrbaB
 +YBQCFb+KZm/0c48yKnQTbHJZyztz9o8DCsqE//GGRQmv7Q==
X-Received: by 2002:a05:6000:40cc:b0:435:bcbd:cb29 with SMTP id
 ffacd0b85a97d-439625c9bbbmr22781752f8f.2.1771770526369; 
 Sun, 22 Feb 2026 06:28:46 -0800 (PST)
X-Received: by 2002:a05:6000:40cc:b0:435:bcbd:cb29 with SMTP id
 ffacd0b85a97d-439625c9bbbmr22781715f8f.2.1771770525772; 
 Sun, 22 Feb 2026 06:28:45 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bf9fb2sm13088199f8f.1.2026.02.22.06.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:28:45 -0800 (PST)
Date: Sun, 22 Feb 2026 09:28:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 12/33] hw/cxl/cxl-mailbox-utils: Move declaration of scrub and
 ECS feature attributes in cmd_features_set_feature()
Message-ID: <d2c428ecd4b680456d759f78d8b8a18cffd00faf.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
index 125f417aa4..8b471c7d93 100644
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


