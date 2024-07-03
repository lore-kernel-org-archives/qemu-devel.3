Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3F6C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8nl-0002Jz-3r; Wed, 03 Jul 2024 18:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8ne-0001zF-80
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nc-0007Db-6k
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720047003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C8uBwo3DHXNNhuf3rApspBTWgLSO8s/xdDqrmh63AMQ=;
 b=IgElybKm+ZA8n06MVeZ562pAhUutTo5/fyGX+DZaQJ9RLMdCNHNpvekAHUKYMhu5ypn7z8
 C+MRN4oqvWC3kDxvgsoW7NPOx0JjhPyIW9tFGO6UOnxRWzsvodmvA0Rc4YHk0DGol1kpnA
 ZPW64TTEEjXIGeSjyb5iVqbby/dtI/o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-HThBkHcJMpGbyxpfRUDUUw-1; Wed, 03 Jul 2024 18:49:59 -0400
X-MC-Unique: HThBkHcJMpGbyxpfRUDUUw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4257a75193aso41575e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046997; x=1720651797;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8uBwo3DHXNNhuf3rApspBTWgLSO8s/xdDqrmh63AMQ=;
 b=sRwNVMkHy9UamGPbB6ajaf3LD58XUDVgaiQutJRiNueCdv1YuyrMBrG+XbnNShrE9F
 swxeB4A5rh3v2MK7ruJkHFHU5l2ts72hOm1zzIGH5KScoY1eVfE/6+hbb4b0zVGvBLkD
 G0TYcHAlWvX2nzzSAPDu1WmagIFGYQQ32rZTSxpBf4ygSTQcewO3Cy24y13EzbdKIEaM
 qR3i+rGDhAQo1mk5btiLZE7uDxtYB6doTrIAnkcMiGjKQEmU3ou5UalSrcYCuAEz2Wsz
 /W9FIN5iu0qUKEjGcXtd0vi02XeYO7mwmH9ORSBc23o17fTRYHRC6/76RoYms6VHeYKl
 lMIw==
X-Gm-Message-State: AOJu0YwLu665DZXaRllvuciPGiiUM1uZ6XETFYKxUUsUy2E924EeHDCk
 JCxcu7zP/55LS+eYIt6MLdEvD4wP1fos3/E0MNMvn9ygBxvmOEnsC8J2MaSx59MrmDh5EU/uK7D
 2ZQQuEa63ZIOk7iN3I90DFaquE1GqCwnL4N1F4VSuu8X3/TF9M10KG9xoE+mAlh97jdVXA3faEo
 gO0afo2yqsAQmxWQOl+IRrUv46gegaZg==
X-Received: by 2002:a05:600c:63ce:b0:424:aa83:ef01 with SMTP id
 5b1f17b1804b1-4264a3d1e2emr354315e9.10.1720046997383; 
 Wed, 03 Jul 2024 15:49:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxeHLkFA9vFSVUs2nluB7hT2NCNMOHVvzFKql/6T+8kYJJHYwOs5zGw3Vabv0YclKur8iCbw==
X-Received: by 2002:a05:600c:63ce:b0:424:aa83:ef01 with SMTP id
 5b1f17b1804b1-4264a3d1e2emr354135e9.10.1720046996637; 
 Wed, 03 Jul 2024 15:49:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d1668sm1261255e9.1.2024.07.03.15.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:49:56 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:49:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL v3 73/85] hw/cxl/events: Mark cxl-add-dynamic-capacity and
 cxl-release-dynamic-capcity unstable
Message-ID: <5e3cd0a2f526c2e52dd513ee6b4385f1fb47a19e.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Markus suggested that we make the unstable. I don't expect these
interfaces to change because of their tight coupling to the Compute
Express Link (CXL) Specification, Revision 3.1 Fabric Management API
definitions which can only be extended in backwards compatible way.
However, there seems little disadvantage in taking a cautious path
for now and marking them as unstable interfaces.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240625170805.359278-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/cxl.json | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index a38622a0d1..bdfac67c47 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -453,6 +453,10 @@
 # @extents: The "Extent List" field as defined in Compute Express Link
 #     (CXL) Specification, Revision 3.1, Table 7-70.
 #
+# Features:
+#
+# @unstable: For now this command is subject to change.
+#
 # Since : 9.1
 ##
 { 'command': 'cxl-add-dynamic-capacity',
@@ -462,7 +466,8 @@
             'region': 'uint8',
             '*tag': 'str',
             'extents': [ 'CxlDynamicCapacityExtent' ]
-           }
+           },
+  'features': [ 'unstable' ]
 }
 
 ##
@@ -527,6 +532,10 @@
 # @extents: The "Extent List" field as defined in Compute Express
 #     Link (CXL) Specification, Revision 3.1, Table 7-71.
 #
+# Features:
+#
+# @unstable: For now this command is subject to change.
+#
 # Since : 9.1
 ##
 { 'command': 'cxl-release-dynamic-capacity',
@@ -538,5 +547,6 @@
             'region': 'uint8',
             '*tag': 'str',
             'extents': [ 'CxlDynamicCapacityExtent' ]
-           }
+           },
+  'features': [ 'unstable' ]
 }
-- 
MST


