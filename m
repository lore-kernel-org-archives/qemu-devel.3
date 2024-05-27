Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF29C25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 12:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBZF0-0005wd-MF; Mon, 27 May 2024 08:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sBZEr-0005uy-2h
 for qemu-devel@nongnu.org; Mon, 27 May 2024 08:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sBZEn-0001Qk-Mx
 for qemu-devel@nongnu.org; Mon, 27 May 2024 08:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716812039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HFnWa4Oh/sxKLAsVsnJmOuTlG52nQsXRZi2FWLNA3NE=;
 b=R8rLwO5f/OJEV2M7qDV57OfnLUMPBWVQIvLYHPj9QfrQwFFE0VdwObDGQYZpnygzAk+i07
 m2anQWWbTXdINf0xo0oGbeaOY74ZSUJ0byVDg0wQXmjZ/qH5pdxQzGttGJ3Q1G1upgfajR
 ce087VZYjqVO7xXZdUthBaX2vYgETnk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-NEXkIPhbNYOjIbVgXEvHSw-1; Mon,
 27 May 2024 08:13:55 -0400
X-MC-Unique: NEXkIPhbNYOjIbVgXEvHSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D9343C025BE;
 Mon, 27 May 2024 12:13:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B2B81C0654B;
 Mon, 27 May 2024 12:13:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] hw/s390x: Remove unused macro VMSTATE_ADAPTER_ROUTES
Date: Mon, 27 May 2024 14:13:51 +0200
Message-ID: <20240527121351.211266-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It's not used anywhere, so let's simply remove it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/s390_flic.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index bcb081def5..382d9833f1 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -35,9 +35,6 @@ typedef struct AdapterRoutes {
 
 extern const VMStateDescription vmstate_adapter_routes;
 
-#define VMSTATE_ADAPTER_ROUTES(_f, _s) \
-    VMSTATE_STRUCT(_f, _s, 1, vmstate_adapter_routes, AdapterRoutes)
-
 #define TYPE_S390_FLIC_COMMON "s390-flic"
 OBJECT_DECLARE_TYPE(S390FLICState, S390FLICStateClass,
                     S390_FLIC_COMMON)
-- 
2.45.1


