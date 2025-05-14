Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5C6C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAdO-0005t4-Gm; Wed, 14 May 2025 07:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdI-0005s8-5j
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdD-00066N-A9
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xR5eYCaem9AyYnWoLzFT5QzAGvgnkNTXfUa8v1+CEvM=;
 b=XOgRezE883NSh7BnLmxgnFwg1nOTvcQqxvLMUxV2dwwqL/K9ZqbJipaWcdyqxmnGkBVN4X
 FZ4pkt2U6yUUgo2VzhllOMmQn6nF4ra7SM08UMsmKiBpHgMqN7nIFYLKwyeEl9SahrPNu9
 soEKLd4XpGKzw2WTUbIpdf6DLrVakOQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-sDs_NuWANc6ws1nnVQVVXw-1; Wed, 14 May 2025 07:50:37 -0400
X-MC-Unique: sDs_NuWANc6ws1nnVQVVXw-1
X-Mimecast-MFC-AGG-ID: sDs_NuWANc6ws1nnVQVVXw_1747223436
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0b7c8b3e2so4337101f8f.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223435; x=1747828235;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xR5eYCaem9AyYnWoLzFT5QzAGvgnkNTXfUa8v1+CEvM=;
 b=Z0i2FMRELdKMr4KMMm1JWwCcNlkTO+iKrlnhVH6IhwXEceBSIlXYLKNxDcAtNSI/aZ
 NykBTmimwKRj715BGFryaqrFbQEDG1vOIIQvnxKlMHOGASfflQn60LR81Up9cSl0UcBy
 J9yBHc/32P5b/dkP8vNVPs9TsAGhZlI8IPGS5UQbqz/WZ7fneGMARTqGh3b6MV1CfULX
 1SmVFZbT2uxwGrQyB91yFx0qPLblLqm7oDmZqo602lZDGHhAvvplyVMw1jztY3Wlxjs7
 MRBOEyoFRlNsBmuJOz3ax3kmYok8XqImsElOJgpBLfLn9k/uCOhZLckEinxWMZXbdcXi
 0DCg==
X-Gm-Message-State: AOJu0Yx4yB44f66LY9WgjD2m0Px92b2gJDC3aW5IvxPZCHdxPfeAL2Fj
 Q6ffViPa7i2KbTpQQBPVwQw7q6NI6DTMXc8O2GUHfp39VgBc91NwkfOe2NCBt/L2hIvlW/s+bc/
 QSKQVNgWS1aYChiipT/kqT+S6Tgt+gQ2/kBDpTDc6lz8Cqc7pEwCvmbV8xXdNWm0hYU2y8esstQ
 1b9dfC4Vc/LKTwKsZkAFVWZacBl1lbQw==
X-Gm-Gg: ASbGncvJc9dPt7ibtP8bYprXzatql4oKW5hFH177xDnipE2J7twO/zVqSbV4O/TeNlK
 3BPjU11ES3/V2VMiD89grxkxxzU/ND36r2fMbA0R40OuruCpKK4pHZWok8tzMjCmhl2lOI9WIzm
 FenN0Bj0MvcjsajI6wYUiLcqEFjz5J0YZuGPfZduteXj9HIRJdtuW4j3/Eq0tZdZlcseC5mtwtq
 ROvY3sBLldIWlfCJvRLgoTC9d9rw7SKoUATvEOpQBdMWZrJVFxGa9ac/VbVoGr/O9Qkxv1U29Ef
 ROGa/g==
X-Received: by 2002:a5d:588d:0:b0:3a2:38e:c0b0 with SMTP id
 ffacd0b85a97d-3a349922514mr2856688f8f.45.1747223435461; 
 Wed, 14 May 2025 04:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAXodGh27ySKFpzgU9uFSty+11zCvcQxC4GO56MnRBcJzg5TOweUrpiW3JTPmDXHlnwz3FXw==
X-Received: by 2002:a5d:588d:0:b0:3a2:38e:c0b0 with SMTP id
 ffacd0b85a97d-3a349922514mr2856651f8f.45.1747223434976; 
 Wed, 14 May 2025 04:50:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2a1dsm18986861f8f.43.2025.05.14.04.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:34 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Hyeongtak Ji <hyeongtak.ji@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 07/27] docs/cxl: Add serial number for persistent-memdev
Message-ID: <abde58f8644491503c058c2ff0775613f251c8e6.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

From: Yuquan Wang <wangyuquan1236@phytium.com.cn>

Add serial number parameter in the cxl persistent examples.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250305092501.191929-9-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/system/devices/cxl.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 882b036f5e..e307caf3f8 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -308,7 +308,7 @@ A very simple setup with just one directly attached CXL Type 3 Persistent Memory
   -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
   -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
   -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
-  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
+  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0,sn=0x1 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
 
 A very simple setup with just one directly attached CXL Type 3 Volatile Memory device::
@@ -349,13 +349,13 @@ the CXL Type3 device directly attached (no switches).::
   -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
   -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2 \
   -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
-  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
+  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0,sn=0x1 \
   -device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
-  -device cxl-type3,bus=root_port14,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1 \
+  -device cxl-type3,bus=root_port14,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1,sn=0x2 \
   -device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
-  -device cxl-type3,bus=root_port15,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
+  -device cxl-type3,bus=root_port15,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2,sn=0x3 \
   -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
-  -device cxl-type3,bus=root_port16,persistent-memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
+  -device cxl-type3,bus=root_port16,persistent-memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3,sn=0x4 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k
 
 An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
@@ -375,13 +375,13 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
   -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
   -device cxl-upstream,bus=root_port0,id=us0 \
   -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
-  -device cxl-type3,bus=swport0,persistent-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0 \
+  -device cxl-type3,bus=swport0,persistent-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0,sn=0x1 \
   -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
-  -device cxl-type3,bus=swport1,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1 \
+  -device cxl-type3,bus=swport1,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1,sn=0x2 \
   -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
-  -device cxl-type3,bus=swport2,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2 \
+  -device cxl-type3,bus=swport2,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2,sn=0x3 \
   -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
-  -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3 \
+  -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
 
 Deprecations
-- 
MST


