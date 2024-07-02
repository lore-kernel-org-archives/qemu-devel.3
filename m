Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AE0C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjzO-0004cM-B1; Tue, 02 Jul 2024 16:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzH-0004OF-NM
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzC-0001Zc-BB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C8uBwo3DHXNNhuf3rApspBTWgLSO8s/xdDqrmh63AMQ=;
 b=P+tTwB9P2LzcpBFuxtXOprMubvURZnLUYClXr3H+h8dOX87ZcyMAxm51MsN5PWtR394K4B
 ZIe6ofL6z/dPV5T647kCqeP5GZyGaTgS6vOR8/ZSVTzEuNF2CoU+Lz++APh/xPsCXoPaIv
 9FrReLoVwXaI2l6FsNYTgQd0RKf1/UA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-EHDqGvjFPeuKRiBq-s66Tw-1; Tue, 02 Jul 2024 16:20:19 -0400
X-MC-Unique: EHDqGvjFPeuKRiBq-s66Tw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52cd8314430so4479672e87.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951618; x=1720556418;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8uBwo3DHXNNhuf3rApspBTWgLSO8s/xdDqrmh63AMQ=;
 b=aSy2XnyPCdwRhclZszP/phv8iaNpd1RsI/CGptz/E4k4cptDDvvXwsjbuhomXBbbUz
 wInOsOBmqUS/z240P5JevUMhP1Jw95w1hnJ7VjFC9K87g/pe/NfHbcZ6n4t1bUeF4w3x
 i4hFGRXHVADb5UNS3UIMK/wYgBYg2YsX6ZKgpCZPZxFx8t5RblJcT3Wwxeg6ojFrud/K
 Rfmg0ggLHSS9ol5TRwHljoKojtRmoN7IUIdBD7JmDNaSR+rU4Ds72pMQWg3Ei+JU1OQe
 hBRXkMhdqAa+jtYZu3ndXeuZbpfha1HCcbRZn/RKDogwtOZEj4MVYZrrr9stE4bcR/Pp
 mVfg==
X-Gm-Message-State: AOJu0YxWukWqVNlWUZKg0/WRKStQUmC0QbPEfX/CT0ClHhhfdvZKoL4m
 9QG4kpyME0NyYK6uRuuaICS1q50nhfMewKmn0VjGp3EbLasqylt0uxH6TYeyG5oQTH1QV1HM1mp
 sJF8yIKiOZvAbF4ABES7WsKFHmvO9U332BXypuGnJ+/TXdDf5xvWSn+KD+vDrb9XOY3jVw64TfE
 aE5Z+wmCvBlVLEbj8UbPRBpXp45afarg==
X-Received: by 2002:a19:7511:0:b0:52c:dae5:6511 with SMTP id
 2adb3069b0e04-52e826663ecmr5012661e87.23.1719951617752; 
 Tue, 02 Jul 2024 13:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQwG1rnA0lVtomvl94zoMOHd5zY6hkPMoVsAtreoFWOC3qWMw6kkhoZOpWnTA4qOdR1Zw6gg==
X-Received: by 2002:a19:7511:0:b0:52c:dae5:6511 with SMTP id
 2adb3069b0e04-52e826663ecmr5012647e87.23.1719951617085; 
 Tue, 02 Jul 2024 13:20:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e1412sm14091257f8f.53.2024.07.02.13.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:20:16 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:20:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v2 76/88] hw/cxl/events: Mark cxl-add-dynamic-capacity and
 cxl-release-dynamic-capcity unstable
Message-ID: <916c21cf2da36f288b89ab3aaba509a4d84323a2.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
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


