Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F5BCD8C90
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 00:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWNm8-0005iA-7T; Sun, 07 Jun 2026 20:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wWNm5-0005hv-TI
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 20:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wWNm3-0005ki-OP
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 20:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780878206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vm2zjuFL31XFvgAb6Tw4aXzH3ExlILwIQ7zUbyCuiu8=;
 b=MNqBY/hsvgAFu+IzH4IQR3HYBinxGFidxDiL4P9yvLJve/yQEnyVv8wwQsg05MTjKdpKDV
 iiQitI5zqtBpe4L45ukBUeBX0Y8EjGpkBz4eL7iUCcEMbRpMx+kEhKDtLrk3WCF5W0uwX+
 zKbFXJoOYLiJGAI+vfi+Yi5m3GdEZWM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-jeIYaM57Ml-RuxUTbE9jNA-1; Sun,
 07 Jun 2026 20:23:22 -0400
X-MC-Unique: jeIYaM57Ml-RuxUTbE9jNA-1
X-Mimecast-MFC-AGG-ID: jeIYaM57Ml-RuxUTbE9jNA_1780878201
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAB101800473; Mon,  8 Jun 2026 00:23:20 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.3])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D65130001BE; Mon,  8 Jun 2026 00:23:16 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peterx@redhat.com,
 philmd@mailo.com, shan.gavin@gmail.com
Subject: [PATCH] system/memory: Remove MAX_PHYS_ADDR
Date: Mon,  8 Jun 2026 10:23:03 +1000
Message-ID: <20260608002303.851456-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Remove MAX_PHYS_ADDR and MAX_PHYS_ADDR_SPACE_BITS as they're not used
since the addition by commit 052e87b073cb ("memory: make section size
a 128-bit integer").

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 include/system/memory.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d..c449c0385e 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -36,9 +36,6 @@ enum device_endian {
 
 #define RAM_ADDR_INVALID (~(ram_addr_t)0)
 
-#define MAX_PHYS_ADDR_SPACE_BITS 62
-#define MAX_PHYS_ADDR            (((hwaddr)1 << MAX_PHYS_ADDR_SPACE_BITS) - 1)
-
 #define TYPE_MEMORY_REGION "memory-region"
 DECLARE_INSTANCE_CHECKER(MemoryRegion, MEMORY_REGION,
                          TYPE_MEMORY_REGION)
-- 
2.54.0


