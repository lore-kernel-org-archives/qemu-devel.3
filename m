Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F92CD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4Wu-0000qP-Ck; Sun, 10 May 2026 09:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Wt-0000jt-7z
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Wr-0005Sm-P5
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ev1PeSHIFk2Iiuk7tPiVQatd/LOr8RRJQ84xO9C9mM=;
 b=Vm0NlfcDMurF63XibpUJQswTh9EY1ge9EXxgGAndpZCWARyT7mLJ6iTtuaNfMgDIN4pRZN
 wVtWn/+p3+JKp990qjQ0rCFpcFmWmP3Dvk1UGhwlLDYXpmjz1hwxJ5G3BcC4vr7H4Xngl1
 SVBpZRvnTP/g4npOjhJVIIOOGETro6Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-S0LRcpGWOYKGaE2N4ctL6A-1; Sun,
 10 May 2026 09:49:07 -0400
X-MC-Unique: S0LRcpGWOYKGaE2N4ctL6A-1
X-Mimecast-MFC-AGG-ID: S0LRcpGWOYKGaE2N4ctL6A_1778420946
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C739D19560B6
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:49:06 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0759318004A3; Sun, 10 May 2026 13:49:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:26 +0400
Subject: [PATCH 29/54] system/memory: fix "priority" property typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-29-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=888;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Xrt1FBAZRulDtkYOHNAjkH2vkSnHoHVfXqM5I051WW0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItwlCq44+i++irgLdqQFKvGMJ34t+iJ+9il4
 CXrieaHP1yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLcAAKCRDa6OEJdZac
 5QzjEACxtuwQHVTk7UCY1t3/AcMT1/EGABJtXY9T0+4683ocEG9ZR0LhcBhSnseAFIDSejtnUfx
 p+mRYEXXyMF6mJ4HlpUAy1gFqsS/XAQUMQhHvPPBsz7DXpaMPn6TbMKI8c0Gf7QYcidMiX9/onb
 64ZNWnB6TsMIqv6NDS5R2RO92QWn39cYSCsQVHCuJwE3ck5fINPh6PJRLuYK1tNgQryNDMbDJ1w
 nWo5da0Apvh72EOaSwukjmCJPzU/czqW5Ldwlvv0vendsDkHQksdJKIqAESX1OIe3aamwn2P/zD
 WskjOB10SDv/9lpYkpQ7ZLJ0gjfkbzygK7a0FBhv6XYf4enupqOqJUrhNr1FBVcsumtks8TG1tW
 BxFGSZMo3ZkRgD3pP6CY7ZvmXQE+ZN9YqUYWhuGRzplUYR0r4NQJ0fTY7FEczbvDEYLbrn5Lo+Q
 mZQL4wbbGoE3xJRVuDQne8+sKI9G/8l6LwnNUfv7+ZjgX7qH+oYwiT3RZRnC5K9BI1uv2d8zII6
 tmcvWBqMvo2k1L7051r6kITxAmyFVMEh7idj2ikT5OzcWmgIE26+2ZkWRG0Hi/8FmZn9McEVwnQ
 S3rR/Nrxz0mPgZhK8azRiTI4mDwElko+P7k3QluWRAaOiWcYyzj4uMaUyXRLCIsQ8Ku+La/b7tp
 BBJhiLqw49ZNWpw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The value and the getter are int32.

Fixes: d33382da9ab ("memory: MemoryRegion: Add may-overlap and priority props")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/memory.c b/system/memory.c
index 739ba11da6f..aaf5ec40230 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1316,7 +1316,7 @@ static void memory_region_initfn(Object *obj)
 
     object_property_add_uint64_ptr(OBJECT(mr), "addr",
                                    &mr->addr, OBJ_PROP_FLAG_READ);
-    object_property_add(OBJECT(mr), "priority", "uint32",
+    object_property_add(OBJECT(mr), "priority", "int32",
                         memory_region_get_priority,
                         NULL, /* memory_region_set_priority */
                         NULL, NULL);

-- 
2.54.0


