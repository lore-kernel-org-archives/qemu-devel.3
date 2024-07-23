Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E88C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDBY-00075Q-Sj; Tue, 23 Jul 2024 06:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDBI-0006ps-Tf
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDBG-0001bQ-JH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hZD245xzKw4cLzLRxCGiV82CoDTUudcvSV2j3dFC7Ks=;
 b=D8ec92uoQvkCNvCNPjP+DnoxQQU04YBrkQ3+C/PqKvfQg+QG6mYFzhE/o/zZXbtjp0q9oz
 Gcp7jzW8m25qYMCsvYeSoV/QXSkQz91pqumCBFbGcOGqK7p5IOmWGzL0hPOvrKJpoOtNYt
 V9Ot+TsITN3EGIk6ez4SfOTR0bzQx2s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-iJ1wGkcEP5e-098yrsaRGQ-1; Tue, 23 Jul 2024 06:55:40 -0400
X-MC-Unique: iJ1wGkcEP5e-098yrsaRGQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a77e024eaa4so457928066b.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732138; x=1722336938;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZD245xzKw4cLzLRxCGiV82CoDTUudcvSV2j3dFC7Ks=;
 b=JXWNObgo5K70xT585NeIY0uq9BaefwsSQFeRLYFjgLRT7o2i3oFxouiKI37xblLnXO
 eaAzBf2F8M5i8w7++ycjmLMRx4WJxgKuVgJRKvubc3rBLz2dhNF4oLqnLNupCfLWZyCk
 YUdly5JyXEQh0RawlAabT4EYJByt3WWY0E6I2RenMtjbO3/RkBqNCFH5vd0YvVzGWKBa
 A3eT5qr4Wn1jb8fI41T4rLFR2z2HNWQsL+NGFv04FRnccOh1Yqqv9q8t3UMi/FPe8mm9
 +KcOLpntEJFfFoBM6DaQRjLs/E1eEC1Kp45lF0mWA+Ttc44P29RXEccr8wFl01LLwRRF
 N5iQ==
X-Gm-Message-State: AOJu0YytLHYqFKfDMmt7VGzCts4o/TzP2gfIyx+O9/0dRmNmGX4Bhf20
 aOumV4/wUczHXDl6aqZbgiR+ID+MHaGvob2ohE3CYYRIOpt46B2oGuVT5sBuypkZh3Es58+ec7T
 uhieMA7cHVwFddX2/rxSyF7XOCO3KctKWhMErb8Na31+iXrIBGixR7LDZnZ0hrlMDQ5GjgeaH1w
 Sqp+WuX3tqRmqiBNgET0cSwXzOhPUINw==
X-Received: by 2002:a17:907:3da5:b0:a6f:52db:7e5e with SMTP id
 a640c23a62f3a-a7a87c3c2camr214360266b.19.1721732138355; 
 Tue, 23 Jul 2024 03:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkYgoi+jSTMgVfZHdQoMeqYb5pIm3jrabdzUx7D3NnuJ2NQ8XzBLnQXM7L2S5D+Oh8GGtcfg==
X-Received: by 2002:a17:907:3da5:b0:a6f:52db:7e5e with SMTP id
 a640c23a62f3a-a7a87c3c2camr214357166b.19.1721732137698; 
 Tue, 23 Jul 2024 03:55:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c91713bsm527286966b.150.2024.07.23.03.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:55:37 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:55:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v2 05/61] hw/cxl/cxl-host: Fix segmentation fault when getting
 cxl-fmw property
Message-ID: <a207d5f87d66f7933b50677e047498fc4af63e1f.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

QEMU crashes (Segmentation fault) when getting cxl-fmw property via
qmp:

(QEMU) qom-get path=machine property=cxl-fmw

This issue is caused by accessing wrong callback (opaque) type in
machine_get_cfmw().

cxl_machine_init() sets the callback as `CXLState *` type but
machine_get_cfmw() treats the callback as
`CXLFixedMemoryWindowOptionsList **`.

Fix this error by casting opaque to `CXLState *` type in
machine_get_cfmw().

Fixes: 03b39fcf64bc ("hw/cxl: Make the CXL fixed memory window setup a machine parameter.")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Link: https://lore.kernel.org/r/20240704093404.1848132-1-zhao1.liu@linux.intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240705113956.941732-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index c5f5fcfd64..e9f2543c43 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -315,7 +315,8 @@ static void machine_set_cxl(Object *obj, Visitor *v, const char *name,
 static void machine_get_cfmw(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
-    CXLFixedMemoryWindowOptionsList **list = opaque;
+    CXLState *state = opaque;
+    CXLFixedMemoryWindowOptionsList **list = &state->cfmw_list;
 
     visit_type_CXLFixedMemoryWindowOptionsList(v, name, list, errp);
 }
-- 
MST


