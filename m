Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48D2C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFD-0005FZ-9n; Wed, 14 Feb 2024 06:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDET-000425-Go
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEP-0007CU-Us
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZoIzxN4wtVZC8VE/mIbpxC6DW0nDJt+pWpq7gnJFkLU=;
 b=X1K6p7wDT1w7oG7t3AJIBd2eA6UQWeD3y1lgkIOESSVxlZY+IZ8Ju4B/KQznhyQm0+qIOi
 Zp1BvEJGpZA85ivMkFt/d4DZ5gK9IUzwsx4bPcEUK8GRAhkUV0RojIB+EvCTr//dLcPrtW
 JcAU7j3HmrlPfaSG2rrtdF8g6fDMv+I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-FgGQase3MjqXVq8ItnoeJQ-1; Wed, 14 Feb 2024 06:15:11 -0500
X-MC-Unique: FgGQase3MjqXVq8ItnoeJQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5611e1da4c6so3589060a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909310; x=1708514110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZoIzxN4wtVZC8VE/mIbpxC6DW0nDJt+pWpq7gnJFkLU=;
 b=OfAa4fvbo8uM7Lv5DbmtAV51J+wIBxwhIT0DmdaPyyaUoTeYQTahIPCroN/iwpVvIA
 wH9W2GECnO16gGVI7jUsvZwPIt2+wPUGwxDtQGf7SWYuZ9LuRK634km1d4x/9956Hb04
 CvHP8jpMq7FghWubGSeehbTHofEUq315iX+YE5rEcjEHGKdiEho7nliqdfbXPCjV9DHD
 xJrnGnGAcUF0q1+cnm4pdd92oX1ASZibkuPyKeInJLTDd5CJ/oARZwEL4te+2E7aHntL
 WHR1R7X7UR2Z3xnGI2UrG2YNRhvRIy7bGjlTPNXZuSyT7meHca/IjoMfTPkFWpMMkj6E
 41dQ==
X-Gm-Message-State: AOJu0Yzkfmbm4CEoBVEQRWp48cmk1hKqDrQbfvfZlkvG9hTXbFgs9Kzi
 ehHOSj7oOlpa/OYnqIU1LThAADKgHJpOXrct1s5CLyi4IrNKeyPQQYlNGJQNhWclAGLgE3p2+1t
 EU4Ve1AWuerzrwORuOG4J3DAgFU4dLsGEgpCN2SoMV+sRgjef0BM481GRipQ1MFQ2EbJ8EG/qOk
 ko4+WSIkGRCDuj9Qk04VZMynxNqqjlGQ==
X-Received: by 2002:aa7:da0a:0:b0:55f:fba9:de8c with SMTP id
 r10-20020aa7da0a000000b0055ffba9de8cmr1705434eds.21.1707909310099; 
 Wed, 14 Feb 2024 03:15:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJK7n/YA0Gl2lZvV7a0zOZa7QGHzAXexi2mUK7V7/n5DJxtbKMvfS9GTZKGWE8QX9Bj8DZjA==
X-Received: by 2002:aa7:da0a:0:b0:55f:fba9:de8c with SMTP id
 r10-20020aa7da0a000000b0055ffba9de8cmr1705417eds.21.1707909309829; 
 Wed, 14 Feb 2024 03:15:09 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU1Fc1dZC9nuJ3DOptBHrZF/BOPp2m65fqkjj9dDxnAFgLD49vdYbYqBeQ7NPghzf/G62ZSSJPw7Ux+a4RNb7PUGWDgXmjyPCKb7fiF8Mjx6cy+ecqr5bwoxmHu0KFPr8JSzWBKJlz9bMGHhUWXjJeCSEC3xg==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 ca13-20020aa7cd6d000000b005638af177aesm171512edb.53.2024.02.14.03.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:09 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org
Subject: [PULL 36/60] smmu: Clear SMMUPciBus pointer cache when system reset
Message-ID: <8a6b3f4dc95a064e88adaca86374108da0ecb38d.1707909001.git.mst@redhat.com>
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
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

s->smmu_pcibus_by_bus_num is a SMMUPciBus pointer cache indexed
by bus number, bus number may not always be a fixed value,
i.e., guest reboot to different kernel which set bus number with
different algorithm.

This could lead to smmu_iommu_mr() providing the wrong iommu MR.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Message-Id: <20240125073706.339369-3-zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/smmu-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 9a8ac45431..f58261bb81 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -675,6 +675,8 @@ static void smmu_base_reset_hold(Object *obj)
 {
     SMMUState *s = ARM_SMMU(obj);
 
+    memset(s->smmu_pcibus_by_bus_num, 0, sizeof(s->smmu_pcibus_by_bus_num));
+
     g_hash_table_remove_all(s->configs);
     g_hash_table_remove_all(s->iotlb);
 }
-- 
MST


