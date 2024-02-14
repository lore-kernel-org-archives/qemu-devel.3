Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46504C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFD-0005GP-Py; Wed, 14 Feb 2024 06:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEg-0004BF-An
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEe-0007Et-MV
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2s6lqYMeUV26bl5P/Tb03gTeEl6FUUCG2Fkw3zLptU=;
 b=Oab3fYzCqQnYKh4EtL5CQJEpharT/DRwwkjiCAogS7l7hlztTLmAi+f0V9vsRilEpoLHgy
 SYg2l1OcOcSxp4C3lVpdvHu6aDb0cSfGBke84f0OUFafsthSYff0Wu4K6rGZms6/Bk/Z7X
 VMAlUVG5vhbAQv9k2/TXNo3yvCdIHfs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-k1Ih44GXOB-bYZ2UjcLdYQ-1; Wed, 14 Feb 2024 06:15:26 -0500
X-MC-Unique: k1Ih44GXOB-bYZ2UjcLdYQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a3d4cfc543fso24535566b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909325; x=1708514125;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2s6lqYMeUV26bl5P/Tb03gTeEl6FUUCG2Fkw3zLptU=;
 b=srgHPzSDbgSLOSuLaPLqpiCJIMsNqXjozQitVlQkZiuRFoKsw77jrKaDo3cJowXynd
 QUTBFh7fHhKXyLgrqmmJNsSxFdo7rX7eEhiwwY+oQKtaULMOx3PNO5DbxqIwlqCvhaRh
 uX9RErzWT/GSyHL5gOGq0da/yqOiZvaV2CdTIEgJt5Nx2rqAIOECpWEoV0I06ssLckMq
 Jb3GjByirsNEdLSg98Df1pPCOT/EP/tTwSjgKp21UbTdK1oG37qz6So0CWFn8nBGHHIk
 pNX0wQGZy2uy6Kiq5P4csOUZ2ZW09YLA3afWlyM21fM8eWmgCbrA01wnKRTnDWxPfuOR
 C+ZQ==
X-Gm-Message-State: AOJu0Yw5vt+kjrUa9k3BXSFQcIq7vfVFuA+fByuhLmjTTMyjbEbMy2vQ
 rYmpB+v2G9Ly2cwEuOQlVprh3qBuUI0YJrEdQqBf7Pm6qQkdtOmTbzLCa0izRv/g6bxkgczciu0
 xbEnn0gxhi1qV7KFVbOHPvKI8+llqjAXgaYlOIsC02Ui/zsY8CEZ1FQmBKoSPGRb/+V/9vdczzO
 5hX9GY8TTUNH6eoAQzdnbZ9ZO2rgQO4w==
X-Received: by 2002:a17:906:395:b0:a3d:6a0b:5bf0 with SMTP id
 b21-20020a170906039500b00a3d6a0b5bf0mr21769eja.63.1707909324990; 
 Wed, 14 Feb 2024 03:15:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHiSpQ4mN/0FBoiB+JLxMHGoDiBgllu+o+cXzcDQ2WFpm11bWh7Vi843TAF3hGxz08Y3Egfg==
X-Received: by 2002:a17:906:395:b0:a3d:6a0b:5bf0 with SMTP id
 b21-20020a170906039500b00a3d6a0b5bf0mr21748eja.63.1707909324709; 
 Wed, 14 Feb 2024 03:15:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXCzDaXBDA5RBi4ZChqZjr8oY05sR7JSAaUPHISUk+BH2cnub0GJ9rz4OYDdNwcW3OPM0QBqBRCVjGoka09boS+BfLVvkoRbrbiJGjVUAZ5Z7O1dG3BjQA+pUuuZcp/nsrr+zVpLRPdgIoj+5S6sQk3e8+fUhy3wd0WjwHy++aALl5FtGq0SigzAh+USs/UOJjYFBaxUmJ1xMWDsUqcxvUgWHuKrl7A
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 d20-20020a1709064c5400b00a3c598d6b74sm2212621ejw.54.2024.02.14.03.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:24 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ira Weiny <ira.weiny@intel.com>,
 Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
 Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 40/60] cxl/cdat: Fix header sum value in CDAT checksum
Message-ID: <64fdad5e67587e88c2f1d8f294e89403856a4a31.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ira Weiny <ira.weiny@intel.com>

The addition of the DCD support for CXL type-3 devices extended the CDAT
table large enough that the checksum being returned was incorrect.[1]

This was because the checksum value was using the header length field
rather than each of the 4 bytes of the length field.  This was
previously not seen because the length of the CDAT data was less than
256 thus resulting in an equivalent checksum value.

Properly calculate the checksum for the CDAT header.

[1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/

Fixes: aba578bdace5 ("hw/cxl/cdat: CXL CDAT Data Object Exchange implementation")
Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20240126120132.24248-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-cdat.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
index 24829cf242..2fea975671 100644
--- a/hw/cxl/cxl-cdat.c
+++ b/hw/cxl/cxl-cdat.c
@@ -49,6 +49,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
     g_autofree CDATTableHeader *cdat_header = NULL;
     g_autofree CDATEntry *cdat_st = NULL;
     uint8_t sum = 0;
+    uint8_t *hdr_buf;
     int ent, i;
 
     /* Use default table if fopen == NULL */
@@ -95,8 +96,12 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
     /* For now, no runtime updates */
     cdat_header->sequence = 0;
     cdat_header->length += sizeof(CDATTableHeader);
-    sum += cdat_header->revision + cdat_header->sequence +
-        cdat_header->length;
+
+    hdr_buf = (uint8_t *)cdat_header;
+    for (i = 0; i < sizeof(*cdat_header); i++) {
+        sum += hdr_buf[i];
+    }
+
     /* Sum of all bytes including checksum must be 0 */
     cdat_header->checksum = ~sum + 1;
 
-- 
MST


