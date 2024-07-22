Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB88C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgjl-0002j1-NN; Sun, 21 Jul 2024 20:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgjk-0002dI-7A
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgji-0005j7-Iz
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hZD245xzKw4cLzLRxCGiV82CoDTUudcvSV2j3dFC7Ks=;
 b=d+VjAqvbVFdR7/xcIgJWXvJVhT8mCfuBBck9chqNKIjAnwV2tzs7ti27oPV214CcAW2PhJ
 Scan55/3kdOFbvjnKNntcrXnW5IM0iRvXKbWRcJaTZDbJTBEiJkMVlaW8JEaIJlZdmFgNt
 XloYIb/VBw4UUwc5iLJPNS1Rph+XhL0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-yBQfGQhBMH2cw1mc4TA_kA-1; Sun, 21 Jul 2024 20:17:03 -0400
X-MC-Unique: yBQfGQhBMH2cw1mc4TA_kA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36878581685so1839455f8f.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607421; x=1722212221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZD245xzKw4cLzLRxCGiV82CoDTUudcvSV2j3dFC7Ks=;
 b=avJaB5L5JARSxI45a5Dp7LN1p6ayshhEYg6RAUyKYCSJA8YuAhSnivVzqoNorP7Kee
 +lglCR1ADZHvpcmuSxMqBOzOlQqTzv3C10xzkGa6CzWuhwoaSZvVGaFn9okY85nnFW/y
 2qbKP3Um8p6y1ntLX1FPZN2rs97a4SLcfokx3vdQ1JSI7pKifATfO8I+5E7cl+2n/MC3
 7niiWpQA8ZQ9jHxwc21238YenGcdn52HovdJqn6oVE9l/ppALV8Yqf+V42yaFonFTD+s
 +tZXY1HTuBiYgyrL5LCj5eIlOy86eci2jsGTC7Ccd5fyj3SysakeuwSeSUN4pCBcdnMh
 E6Hw==
X-Gm-Message-State: AOJu0YybtIw/7hfPaQtLhphPF9wt1tbXgoIxLkkz+7VM53JoYg3Fk/8e
 GjBwif8R3c6rZwYfa0WwPG0cU7SK6msH6TG5wJiK7MA4T7+ErDcdJN9RdFSZ3QdDVURMGcaneZ0
 ynhQYPVUcEvdk1ReSduIESPeWEkjloAuxNCfCwtxo2PKW8RMWdfQGD3a4JOaYenh2uvQcZ1pfPP
 FWuysNQZPOLxHsyx1NAGL3bzjwpG8Xuw==
X-Received: by 2002:a5d:5886:0:b0:367:9d2c:9602 with SMTP id
 ffacd0b85a97d-369bb2ea299mr3680070f8f.49.1721607421671; 
 Sun, 21 Jul 2024 17:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIPN0bUTHueCCZAZkrvBfTTbWJUeBe160eDE0jW48zMtw3sia+t9s2jconmIjLbpfYc0gbiw==
X-Received: by 2002:a5d:5886:0:b0:367:9d2c:9602 with SMTP id
 ffacd0b85a97d-369bb2ea299mr3680052f8f.49.1721607421162; 
 Sun, 21 Jul 2024 17:17:01 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa493sm107385825e9.10.2024.07.21.17.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:00 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:16:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 05/63] hw/cxl/cxl-host: Fix segmentation fault when getting
 cxl-fmw property
Message-ID: <a207d5f87d66f7933b50677e047498fc4af63e1f.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


