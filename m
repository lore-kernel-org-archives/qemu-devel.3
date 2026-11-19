Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2388A60A2616
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ft54kr/q;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jJkFDsso
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTykB-00062S-AF; Thu, 19 Nov 2026 04:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyjs-0005kU-PC
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyjp-0006OH-Ca
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795081648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rVPXIHgLkCZAN/2NUciKyob67FV+2LroMjDJ/Z9diEo=;
 b=Ft54kr/qa2qxFVrsZFVBqHli7SfwtA3dG4Af3kkVnZQzLBILJZVlWxS6wi853csqyP9vN4
 ZItPB1idrnEZx0HDPViSYPfrezVGZ3Kx2/urDakGyPjZLEbG5kVkHfjw7fjWoUAOQNTSjk
 X3s3yGj5eeWv9dBOBp3s62S4iZ/Lqa4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557--HhYP3FhMg-3HpbPzy4t9Q-1; Thu, 19 Nov 2026 04:47:27 -0500
X-MC-Unique: -HhYP3FhMg-3HpbPzy4t9Q-1
X-Mimecast-MFC-AGG-ID: -HhYP3FhMg-3HpbPzy4t9Q_1795081646
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e1d839ddaso1167338f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 01:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795081646; x=1795686446; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rVPXIHgLkCZAN/2NUciKyob67FV+2LroMjDJ/Z9diEo=;
 b=jJkFDssoWPCjqFyXmdoVUbnll8rXnsTaB8Bdoi+kcVcWbQllJOHHHcPJqMdVBhTe4b
 6cam/4mO1+pDuKnDgwLJarXDIVlG4WoJXtOJWGJzdLC1LbO3x7hpz10HddcjGFR7/OKN
 wc/ViU8lRM7x5NiK07w+XOyGm/Hor5rHwmO/PlW/mqlETT/9/EIDf6mp3TKusfhub1Wj
 J04o1t5k1erwb8APgX1JSdhrkzIenYpbphzFms4wbceFUoXPz7/NbK0fNHDsqCpWtJZD
 9xGimYuF0VTRDR+mAd1xYLcxMA4IJDExaTG3AEqNSOdz5/unKUQPfyRzqGfE8fap1PVX
 vl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795081646; x=1795686446;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rVPXIHgLkCZAN/2NUciKyob67FV+2LroMjDJ/Z9diEo=;
 b=XZNqQz24yH+yXicCH9/RQ3Dn/s6dWPc4U8RcsuLdrsWxHQfcJbjhgn1oPeVJDd11eg
 quMJfMzno3+2M3NCmP6UbpZhGMWT+5ChUhrb+tFqnWNXDuL1t2CFbSS2y6FWnSFYgHiP
 6tOhPmjvj2fwEqjHAdrmSBjQcp+AK8Oki9DOXio3x1J0PjUNlmZ3qujeXteFJILYu7+x
 ep2tPJTqgTz32QLfJEFo3tSTStIXQV7u8EHUtSZ1IcEEwrUaeL9sixtEBqyq/JdP6FHI
 GvRqrKNGK1es1r69oQzWyo0sKqmrRTnnVosa+jfER7Hw6cKjEBQs2x4AggmLsxT9Gs8v
 YeLA==
X-Gm-Message-State: APuU4Z9ZinXb47+jc7B7OvgZojvVzpbcazbnwq4Mxe2R8B5/sP0cTiiC
 w8kd8Az1eissTdSJef+TT4yhxWzrvFq/kpeNpuhHFvvqSuJMD/4cea7tu5qnApUZL6i4rA1AhnO
 NDyJzRKsaxkVyaBNX94spvKfITG9+1USQDf0WP7aW5CLJqdA0qohI49nmmeZs7OFf9eDUojp5m9
 8Zz5AuxRw7hPBhzfgMjwHnrA8WAf4VmSKRWw==
X-Gm-Gg: AZFdTZdKcWFq3RU17ZHws87ZGdR7kp57hhNh62GpLUAzsFtaUxbyBZBMuCN51obsT3I
 4wtIQo2zg0OrOa3bEdWtII/0Tr3WzK6VhnppIqv3l3zjjR7jyjTgNPQQWE4zSXuwVgIq3irHVwz
 urjr4bcf2VbvR9DfojBECbetvn1JUc9bnpP2T9VfIPXaAUTNKOow2YBEn1lP+Lpv2x03oOKpcl1
 l2l+ndVIRITb9F8U1j7AiASGdbhrg1EDJkEb1BY1zk7zZgoQciC2TvqPE6I7UJDYCiCBtEpJsRN
 ssOuxeUwS9qQOMZyIKSTkVWKDK0yBn6jpFRtc2War8hYq/XjmXgJl22Ch5xw4ggl4aHQO4egiBE
 MvACxHBZQXdUjAbyoxW5ZdM8b+3XFjEbUAUT55nw9sy4=
X-Received: by 2002:a05:6000:1841:b0:4a6:bc53:2478 with SMTP id
 ffacd0b85a97d-4a6bc626b9fmr11504286f8f.13.1795081645737; 
 Thu, 19 Nov 2026 01:47:25 -0800 (PST)
X-Received: by 2002:a05:6000:1841:b0:4a6:bc53:2478 with SMTP id
 ffacd0b85a97d-4a6bc626b9fmr11504209f8f.13.1795081645045; 
 Thu, 19 Nov 2026 01:47:25 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65541f3b3sm9699020f8f.23.2026.11.19.01.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 01:47:24 -0800 (PST)
Date: Thu, 19 Nov 2026 04:47:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-stable@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 7/8] hw/virtio/virtio-iommu: Fix IOVA address lookup
Message-ID: <bc1c13c212b906124ae068f2c822bb3aeb769efe.1795081539.git.mst@redhat.com>
References: <cover.1795081539.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1795081539.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Eric Auger <eric.auger@redhat.com>

The translation code checks the address to be translated
belongs to mapped segments by calling g_tree_lookup_extended().
This uses the interval_cmp() function. However the interval
is badly formed with the .low=addr and .high= addr + 1 instead
of both being set to addr.

As a result an attempt to translate an unmapped byte just before
a mapped segment will not fault as expected.

Example: only [0x2000, 0x2fff] IOVA range is mapped.
An attempt to translate 0x1fff will succeed

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4754
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261116173857.367638-1-eric.auger@redhat.com>
---
 hw/virtio/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 208815096fc..b9ecab01eee 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1185,7 +1185,7 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     GList *l;
 
     interval.low = addr;
-    interval.high = addr + 1;
+    interval.high = addr;
     granule = ctz64(s->config.page_size_mask);
 
     IOMMUTLBEntry entry = {
-- 
MST


