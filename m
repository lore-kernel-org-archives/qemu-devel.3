Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82702C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeER-0007Ua-RU; Tue, 02 Jul 2024 10:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeE0-0005Qe-DP
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDv-0000SQ-5Z
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C8uBwo3DHXNNhuf3rApspBTWgLSO8s/xdDqrmh63AMQ=;
 b=MKJEHjUhtZo/2JDsoxUZurLwteGMdDCXlTSRQ1zFAqfrAMc1F7h2c/MUcfv2gRx2k2U0AH
 Vlaccaajy8Gsryxl5gQb7DbmqQalTIsRyC9A+w1UytGehqPSFcjkwXEeMrZDZ/goXcXIwg
 roZHCL178WfeOFKz2v5Z1SpNMiuxtrU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-M-1pKNPLP7-eB7tk_SamZw-1; Tue, 02 Jul 2024 10:11:08 -0400
X-MC-Unique: M-1pKNPLP7-eB7tk_SamZw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4258675a6easo15724435e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929466; x=1720534266;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8uBwo3DHXNNhuf3rApspBTWgLSO8s/xdDqrmh63AMQ=;
 b=QmrZf949AZssGqEdXxPvIggdS12wQgvVpH2MAf90WWEAIAfLrSUlno5LWR+TeoJR+2
 iPF8oPn/3h1yi3nsO6lyZ+WNyB3xW3UCMmMnz4UoyEOhbhgJBi3f2F8SjPkEUs1RbrNK
 m0sBkfjL1MtQDW1kzXAB4bxhAtKqkcFTRpC+F8ktqmXZcXLERi5Ha3PV5HhvQW4aS2En
 CvxWiYi8+cchvV6Mftm+CYPRwx6qO6xDqBYzsigHFBVN8PdHm5JYESvO65+IGRxMzi5v
 +Q4ofe15SDrrW1Zh6KGtKJ2fGyJH9VCzO3fWq46zvOf5mmQ5w28HKRZhRGnF9T4Hps35
 OaLA==
X-Gm-Message-State: AOJu0YwFM8LcBLYqIvEXxTwmB5S/d0+HNeeKAUCGvOSDWkDsAsGTDzyi
 FxOO+KDL3HJN2mIsYqWAxCyMs4A+E0L6qh/xcKZM28G92f1E0oOp3Q3tBrkGbi5t41gOQxM//Pr
 rdUJLOkXFUyi4H86b6S7svaokjHpjc1HwSXFy3qvDlDxNmyCKum7QRfBjwYgi1oXttxdDkrD7Nw
 rbFKwljn+kH2cdI4IBHW7m0W3wVut46A==
X-Received: by 2002:a5d:47af:0:b0:367:434f:caa2 with SMTP id
 ffacd0b85a97d-36775627d4dmr7446142f8f.0.1719929466669; 
 Tue, 02 Jul 2024 07:11:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHKY9plRudrAM8VtduSOHgC4C+s5VO1zNktqEC3J7c/nKDgiuertTayR78pXo2Ab32GhjGSg==
X-Received: by 2002:a5d:47af:0:b0:367:434f:caa2 with SMTP id
 ffacd0b85a97d-36775627d4dmr7446113f8f.0.1719929466091; 
 Tue, 02 Jul 2024 07:11:06 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd6a6sm13530534f8f.24.2024.07.02.07.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:11:05 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:11:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 79/91] hw/cxl/events: Mark cxl-add-dynamic-capacity and
 cxl-release-dynamic-capcity unstable
Message-ID: <d44f59c82de89d2d1dff6e732ef29476d01c18f9.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
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


