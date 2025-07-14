Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31B2C83F21
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSMd-0004A9-KM; Mon, 14 Jul 2025 19:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJS-000600-L6
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJR-00063E-0U
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h9YR5w450ZjJ0pBgGMl41SlLEhDoh07LQFY/a0XBD2c=;
 b=W5Jl/npBER6KTJayFrIXR0Y3Y0gv4IAiUoqR6ZBfmErOpLPDMFARfoCGQ/hIvjONLn1jp2
 JCaGvnXgpzO0LmunFuUoOiKXN3Yvan04vTxoBpJ4JwQpc35mp2hTdKqPbyIqkoV5bxTyP4
 /AWpUi3Qzb/Cv/UBrth13ndlYvO5Dwo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-4eJClQlBPXu-qbMjEXMKlg-1; Mon, 14 Jul 2025 19:10:18 -0400
X-MC-Unique: 4eJClQlBPXu-qbMjEXMKlg-1
X-Mimecast-MFC-AGG-ID: 4eJClQlBPXu-qbMjEXMKlg_1752534617
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a50049f8eeso2120717f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534616; x=1753139416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9YR5w450ZjJ0pBgGMl41SlLEhDoh07LQFY/a0XBD2c=;
 b=m/FMkCY5l/YXWSxtIAd+dmV3UZYd7BwEilzYcEE/+2VYD+ahbCunRQqjaPQYbpvLyP
 EmG7t26xjIUByvajmA015A3KHp1yV162vl0Ht/D50KGZNx/U5k27Pt9da8ZflE9LcC2C
 GepFgtzPMlC4IAPGbDHBnFItPZJIBjfEp9NCKJlwNWySfVZQtkjECxSs7kwOt6Mxiv2h
 OxJt4zMBUERdPfGYCxmqhIUwIYjLkrzXeQC6JNI2iHji+3MY1D91bGKIjtPejlzcuk7i
 4XT4gsAsW0ZpWQPxvcDElyw/FbEaEoAoilLvApJHdGh7Jq5eQKeTudfwkPyYc79UnpHV
 K+1A==
X-Gm-Message-State: AOJu0YxNGXKFqVRp5qpbD4gcjKhixlaDcMgY/Ml+vX0g6gzo9zxwBICS
 x9hwGO10Ff52EdPtR3+upp+hH2uWthYWCqKdLeKtpw8mANh0VOQbK9CqhDQ121kdVQmf9TctXUn
 Y1suWQB5MdvoeyOzttDYtxMzoicWNMfeaFuThmDJmTGlttI3OnLcl7nw13+BCbEJBmn25+f1yJK
 COMSuPSSUdcy22RXUcVTUJT5GqYaFbN/9+Ug==
X-Gm-Gg: ASbGncvZ4N1nk5JUVb65EjC5mQDbXuCcfJYQmIoFmFIrb/mcESx6Kz285ZUt2TuAAWF
 e0tWoRJP3hhRFV1IBzBklvb4mvwgxAsAh1rpLNtTZJZBB5TltgIsN/UzxjcQP5TpUjKE9QK1juz
 mkp+aR9mwl272FJR3NrbpGWRJzsEi5gl9I2W2Phb9+pjQ0yLCip/YUgx9GWxPlj8xAVq37ZQBc1
 OYqnRyq6RDnIskgUyDE+lE++iFLzeqRN4uE+Fg3KSb1HgvEi8AQEU6QUuIApJvxbhk3Ob6zyfKh
 FtO2cPRlFWWiJHV3NPinD935xRyIrbMV
X-Received: by 2002:a05:6000:d12:b0:3a5:8d0b:d0b8 with SMTP id
 ffacd0b85a97d-3b5f18e7af8mr10881984f8f.54.1752534616622; 
 Mon, 14 Jul 2025 16:10:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyaJCJ6DeYwyDTrWsLhB1aMaEjo9ElFl2Uj0Z0y5ylSRUUqZJ1jGH7FkjN8RhDftwYEXuDaQ==
X-Received: by 2002:a05:6000:d12:b0:3a5:8d0b:d0b8 with SMTP id
 ffacd0b85a97d-3b5f18e7af8mr10881967f8f.54.1752534616188; 
 Mon, 14 Jul 2025 16:10:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc3a54sm13747494f8f.39.2025.07.14.16.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:10:15 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:10:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Anisa Su <anisa.su@samsung.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 91/97] hw/cxl: Move definition for dynamic_capacity_uuid and
 enum for DC event types to header
Message-ID: <cea6073998e96235893b65894d9896494773fda6.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Anisa Su <anisa.su@samsung.com>

Move definition/enum to cxl_events.h for shared use in next patch

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250714174509.1984430-6-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_events.h | 15 +++++++++++++++
 hw/mem/cxl_type3.c          | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 38cadaa0f3..758b075a64 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -184,4 +184,19 @@ typedef struct CXLEventDynamicCapacity {
     uint32_t tags_avail;
 } QEMU_PACKED CXLEventDynamicCapacity;
 
+/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
+static const QemuUUID dynamic_capacity_uuid = {
+    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
+                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
+};
+
+typedef enum CXLDCEventType {
+    DC_EVENT_ADD_CAPACITY = 0x0,
+    DC_EVENT_RELEASE_CAPACITY = 0x1,
+    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
+    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
+    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
+    DC_EVENT_CAPACITY_RELEASED = 0x5,
+} CXLDCEventType;
+
 #endif /* CXL_EVENTS_H */
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6b0889c9ae..52d3910ed9 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1876,21 +1876,6 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     }
 }
 
-/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
-static const QemuUUID dynamic_capacity_uuid = {
-    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
-                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
-};
-
-typedef enum CXLDCEventType {
-    DC_EVENT_ADD_CAPACITY = 0x0,
-    DC_EVENT_RELEASE_CAPACITY = 0x1,
-    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
-    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
-    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
-    DC_EVENT_CAPACITY_RELEASED = 0x5,
-} CXLDCEventType;
-
 /*
  * Check whether the range [dpa, dpa + len - 1] has overlaps with extents in
  * the list.
-- 
MST


