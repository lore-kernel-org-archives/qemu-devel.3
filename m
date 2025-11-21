Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9E2CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcvF-000165-0f; Fri, 21 Nov 2025 21:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMbxH-0007rW-Ij
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:58:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMbvF-0001V2-Vl
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763772962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lhM6VNueuj3VtVBOzdDIFaT3P1rwvHo7X0l7rmJCF4s=;
 b=GFG50jtkdMrogslKZG02zzron2nm9C6rAtQ0CHEzqVnYfHEN+J/dhr+YRGa/e7sZNHKXeV
 ZoKXIz3t/N63Vqydm1txY+HWS6IQayQj07G2PbsByyfnbcWQX/v3MJuRvCbNeL1vkz9giS
 Jrqb3mMlFHUxxypH1TvOdwR3d8fypeo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-tFYG7y-qPd2gLtOuB6mqQg-1; Fri,
 21 Nov 2025 07:36:00 -0500
X-MC-Unique: tFYG7y-qPd2gLtOuB6mqQg-1
X-Mimecast-MFC-AGG-ID: tFYG7y-qPd2gLtOuB6mqQg_1763728558
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D71C51800447; Fri, 21 Nov 2025 12:35:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54D01180049F; Fri, 21 Nov 2025 12:35:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C684C21E6935; Fri, 21 Nov 2025 13:35:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, zhenwei.pi@linux.dev, fam@euphon.net,
 xieyongji@bytedance.com
Subject: [PULL 1/1] MAINTAINERS: update email of zhenwei pi
Date: Fri, 21 Nov 2025 13:35:54 +0100
Message-ID: <20251121123554.1255093-2-armbru@redhat.com>
In-Reply-To: <20251121123554.1255093-1-armbru@redhat.com>
References: <20251121123554.1255093-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

From: zhenwei pi <pizhenwei@bytedance.com>

I will leave ByteDance in the next days. Update email to stay reachable.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Acked-by: Fam Zheng <fam.zheng@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <20250528033156.1188531-1-pizhenwei@bytedance.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1c5080e50..1cb21cd0fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3381,7 +3381,7 @@ T: git https://gitlab.com/ehabkost/qemu.git machine-next
 
 Cryptodev Backends
 M: Gonglei <arei.gonglei@huawei.com>
-M: zhenwei pi <pizhenwei@bytedance.com>
+M: zhenwei pi <zhenwei.pi@linux.dev>
 S: Maintained
 F: include/system/cryptodev*.h
 F: backends/cryptodev*.c
-- 
2.49.0


