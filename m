Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64232D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Jc-0007Bd-OJ; Mon, 04 Nov 2024 16:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Ja-00072t-HL
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84JZ-0005Uc-3i
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ga8DS27Sfi7rjz6dDrgfoTT5hS6O0iJNoMqFy2shrM=;
 b=DsxF6axFSRqRzkBOg+gPQe32ZsNxOoh68zTs3MYsnE6xGR8IpsLdDO5pay7NeVZSRPH9lW
 9O8j6zg6OaKejYiMPhGos/TCYJjQ7QMO5bjfYpaj2tB6O4D/WB4rOX7hDm2DLTrckcQYDV
 pojrHhzyq2WHht/cIpvWHIySamYrERk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-YsywGLu4NKyM6y6xT5Pr5g-1; Mon, 04 Nov 2024 16:08:43 -0500
X-MC-Unique: YsywGLu4NKyM6y6xT5Pr5g-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539eb3416cdso4957872e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754521; x=1731359321;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ga8DS27Sfi7rjz6dDrgfoTT5hS6O0iJNoMqFy2shrM=;
 b=msLZNbScKG7jU/wcU2rqJVQiXAF693Ljm8BYSIIv3xxFsYrM0rg8PBsze8M49z4hEH
 JAWeAUuDB9MKBy9z/lLu2A/fkpxubrlZ/J1oWI6X2pn4xFpPFaLda0HdpQEc4A2sAd5O
 kemb9dZ3SEUv4+EfHAgX/hYhWovqLV+zcKUoNYXtjEyJBCE1fKcNQbD84bJKcV0Hepnm
 I3vO+N4JArqyQvGkCjGupjX9LhqEmTp6s/OcbikFXGGq2hNIHH/JEjuWLAxS67u3CEtT
 GzEYuzP//jLAUQ7CZUnuvTzDuQfLRepykAhZv1+KRnpPbYR5FmdhAvkpGTWTPOpzISfR
 BNig==
X-Gm-Message-State: AOJu0Yz2oxuUfF2Nxdz2PRaK98rJnLulriDbUp2OWYJkxgskq2bvCX9q
 uZqkG5t1rk1g2NCJFlUPq/vpY4NOqwPx1qC2QgEZMqcCnITWd3Zf+vtt54PbhzIGCD69PXJuxe2
 g8bUYJpXos00q2m5e50RFqB8FiA4irNU68xToJPT7vHKbjje+1C+LfB/N9pYrvd+EXWgQfIAhy6
 deTfS+8toUiJiJRpSyK4e/KG/rfVxDtw==
X-Received: by 2002:a05:6512:128b:b0:539:e5e9:2159 with SMTP id
 2adb3069b0e04-53b348e56eamr17436241e87.31.1730754520611; 
 Mon, 04 Nov 2024 13:08:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaPFMFEBs1G8FRUdZ8UdrkFfn+kD+IRU9PlCV4/st20rfyjFCmGEwrdwICNtzWTjpayV9JsA==
X-Received: by 2002:a05:6512:128b:b0:539:e5e9:2159 with SMTP id
 2adb3069b0e04-53b348e56eamr17436213e87.31.1730754520006; 
 Mon, 04 Nov 2024 13:08:40 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e67csm14150069f8f.75.2024.11.04.13.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:08:39 -0800 (PST)
Date: Mon, 4 Nov 2024 16:08:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 46/65] hw/cxl/cxl-mailbox-util: Fix output buffer index update
 when retrieving DC extents
Message-ID: <802671c37a6ab4de116866883841bcc8b2318124.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fan Ni <fan.ni@samsung.com>

In the function of retrieving DC extents (cmd_dcd_get_dyn_cap_ext_list),
the output buffer index was not correctly updated while iterating the
extent list on the device, leaving the extents returned incorrect except for
the first one.

Fixes: 1c9221f19e62 ("hw/mem/cxl_type3: Add DC extent list representative and get DC extent list mailbox support")
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241101132005.26633-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 8bb0d2dd29..97cb8bbcec 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2227,6 +2227,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
             stw_le_p(&out_rec->shared_seq, ent->shared_seq);
 
             record_done++;
+            out_rec++;
             if (record_done == record_count) {
                 break;
             }
-- 
MST


