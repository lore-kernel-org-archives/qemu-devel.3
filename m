Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F90CD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVVza-0002q1-SP; Fri, 05 Jun 2026 10:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wVVz5-0002QW-Nl
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wVVz0-0005V2-0S
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780671432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWgkuD6J43RWVhhwNGFM/2u4gOFQlTN60r2vnD2CbTA=;
 b=e/txpq6tlk1TL+Ta6FqGVHsouOBm6GnMzBNFVQEvGjdaH7QdtYMMiRddgdrmcbIzN31ego
 Z0bFqSIPxLbVeCVSLfLODokDi5W0vheP9OnDADOwNpW9D5TjjxJPem9qUEioJ5gzCymhCW
 F4GhfqL6o1WBhTZ02ng3ILBSFrmA7Jk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-PHW2tNDTMhydN1qQ7gv2fA-1; Fri,
 05 Jun 2026 10:57:08 -0400
X-MC-Unique: PHW2tNDTMhydN1qQ7gv2fA-1
X-Mimecast-MFC-AGG-ID: PHW2tNDTMhydN1qQ7gv2fA_1780671426
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B34A1800350; Fri,  5 Jun 2026 14:57:06 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.48.119])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9644A1800351; Fri,  5 Jun 2026 14:57:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 5/7] MAINTAINERS: Fix s390x storage key/attribute device paths
Date: Fri,  5 Jun 2026 16:56:45 +0200
Message-ID: <20260605145647.272621-6-cohuck@redhat.com>
In-Reply-To: <20260605145647.272621-1-cohuck@redhat.com>
References: <20260605145647.272621-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Fixes: 56e34834029 ("MAINTAINERS: split out s390x sections")
Reported-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260519171240.97420-2-philmd@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ff33eb630bd..48db280e478d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2973,7 +2973,7 @@ M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
 R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
-F: hw/s390x/storage-keys.h
+F: include/hw/s390x/storage-keys.h
 F: hw/s390x/s390-skeys*.c
 L: qemu-s390x@nongnu.org
 
@@ -2982,7 +2982,7 @@ M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
 R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
-F: hw/s390x/storage-attributes.h
+F: include/hw/s390x/storage-attributes.h
 F: hw/s390x/s390-stattrib*.c
 L: qemu-s390x@nongnu.org
 
-- 
2.54.0


