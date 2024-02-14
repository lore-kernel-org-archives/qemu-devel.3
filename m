Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05278C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFM-0005Yu-6E; Wed, 14 Feb 2024 06:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEu-0004zP-Fw
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEr-0007HN-Nv
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7L7U5a8D5EylkKppdsLWG+1xzPDLzJY36FKng3qebqs=;
 b=dajjsAKuhVwOt30fz7sRRr1xdANmS+3YHDDj1GfVgR392Kk2jOPKGSeUMw1SfaqnUVMmJh
 LvVqkb4Qo8omsuKsN9JozCmEdaYPBnh8wwpPV/VSWGmafM0GaWvPrCMnOqy/FWFNwmNIpw
 4XmVqSo+SdhxeMvuHmfPJaXNS6fGPoo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-LVeiuTSxNV6LtCAYtyGhgA-1; Wed, 14 Feb 2024 06:15:40 -0500
X-MC-Unique: LVeiuTSxNV6LtCAYtyGhgA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a2bc664528fso403766966b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909338; x=1708514138;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7L7U5a8D5EylkKppdsLWG+1xzPDLzJY36FKng3qebqs=;
 b=PIDfwtaDtg0jn3VXs9S9kVYjj11N8eWO7F2inHMUC+QLNZEcjaxVTX6RZrlMQsCov+
 2ECR6+GCAPeHxncuY+USXF7mRFPb5m3bXSiCw/TWkVhvFSaNu649Fo2dlvEvcuUEDpPk
 x38NVVVZ85Pj5L0UY0TrdZs9xG5oekVor5DGSMR6qqNh6pNADcHOO5YDJ4D5iUc0l0rH
 0oxksmNd8kt47/PcQU+BW9y+vUk5BAwd+9LYISYzCgbkrbNdyjHgnt92i3bUChBUuxnq
 hwmDPKscTnSMSJqPMrubca7mFJtmQiex01gPpYxHiah9gcRHAZoitcyXNuK79P8sGzGZ
 2TeQ==
X-Gm-Message-State: AOJu0Yyg/qbSfpPLMKjHukWkjZAeOyjs71oQcxftDSbj/ZxxkhK+DUfO
 bzkp1cMDLryCxNSJ+JCVk4hZ78ZVlWVYItGRe68HHSAbmE/mQnoDewY0DFe9Ai4RqIbqPctC3Bq
 nVnQ5Q0nuUXwTzsmvykxIcGjnD4o+M1Ejf/ltaZl846/NYIs2jabmy6qf9MqssiKCGPiYODvbBg
 pf1Wf/A9T0jNoSkMyadmuXbSdJF0dcIA==
X-Received: by 2002:a17:906:a451:b0:a3c:930b:2d14 with SMTP id
 cb17-20020a170906a45100b00a3c930b2d14mr1598430ejb.9.1707909338390; 
 Wed, 14 Feb 2024 03:15:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2gx/PdD/d0yhvlIvbutYnhRfhxQvKnKfgCGu9ZamHq8OmbwH7vXrFgMl/OA2Zzs6SGewVMA==
X-Received: by 2002:a17:906:a451:b0:a3c:930b:2d14 with SMTP id
 cb17-20020a170906a45100b00a3c930b2d14mr1598414ejb.9.1707909338155; 
 Wed, 14 Feb 2024 03:15:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVjjwE5ZaDM8VgzWJx6EBQPGzPgT77eJRz+HjaEgFu+O8++l4x/TQ7faHj1clE45TGcgE2GX56ehxr+U5Ee/8ls+onZSYV/d3QNjum4ahl9JtE/SJpsPw/AtneYgVPLPRoZg7XvFkX9GVJjfHbY7qOP67xhWIcd
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 ss6-20020a170907c00600b00a3d17841204sm1232227ejc.94.2024.02.14.03.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:37 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 44/60] hw/cxl: Pass NULL for a NULL MemoryRegionOps
Message-ID: <f8b02dd655cc20ca7f321c42acbffb143eb8372a.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

From: Li Zhijian <lizhijian@fujitsu.com>

a NULL parameter is enough for a NULL MemoryRegionOps

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240126120132.24248-9-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-component-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 9dfde6c0b3..5ddd47ed8d 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -197,7 +197,7 @@ void cxl_component_register_block_init(Object *obj,
                        CXL2_COMPONENT_BLOCK_SIZE);
 
     /* io registers controls link which we don't care about in QEMU */
-    memory_region_init_io(&cregs->io, obj, NULL, cregs, ".io",
+    memory_region_init_io(&cregs->io, obj, NULL, NULL, ".io",
                           CXL2_COMPONENT_IO_REGION_SIZE);
     memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cxl_cstate,
                           ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);
-- 
MST


