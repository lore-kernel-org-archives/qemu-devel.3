Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BF7C79FAE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xQ7-0003u5-Tt; Tue, 08 Sep 2026 11:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQ4-0003sj-TH
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQ2-0007bC-9F
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788880049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I45vBLy8mR9FO7QFOJ9NNNU2qKzB6oMkrFNeXIX3qdg=;
 b=VG+4DjFydi2uhk78YdyoS4t9pQIvBxzw3KA/+xBSnaRVN4I1Of99ccDwhva0zX32dUGtEB
 sN+ZdABBXL1KLKRp50ZFIDmOhM1jl3+EiQ3MtCVjhzb0eFZiRbOTykOOsSawOclbt7DYnz
 BAhWmmyQSk4BX4VN1Attw5ryeMVGwus=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-eOTMKOgVNZGApjwZjeEtKA-1; Tue,
 08 Sep 2026 11:07:27 -0400
X-MC-Unique: eOTMKOgVNZGApjwZjeEtKA-1
X-Mimecast-MFC-AGG-ID: eOTMKOgVNZGApjwZjeEtKA_1788880046
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAF4F195DE4F; Tue,  8 Sep 2026 15:07:26 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F13081955F0D; Tue,  8 Sep 2026 15:07:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 19:06:51 +0400
Subject: [GIT PULL 08/15] util/thread-context: fix property typenames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-qom-qapi-pr-v1-8-a4d75a2573cc@redhat.com>
References: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
In-Reply-To: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=06uELAnv7q0WduS1iwJjsed0nBZGdIUdjr/uI9WI748=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoCSPxcUGu9ATQsQ0WH2LR0MeJ96bkpa+U02R0
 VHFxUAKuvOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqAkjwAKCRDa6OEJdZac
 5e6DD/9f7IkUsvXcTr3fUwmidhRF2Qx3LeikRFdvUUguDWVIok+B50YFFD5l8lBwzN1cPKsjl8u
 TZeio7B/f77TxGpHVJtg1OZykB5dfOr9AImZjMxtcQg+bUP87VZGSWnHVap0dzZMTXqUDl/MaoP
 G8l2eVa0jIQTT7awjbG8bmsurhVwR5Y0YQWu3y+pwFDd/e8NKrzGDSBrxtEIH+rC+F5hsFeJjr9
 IiXrrRE8t+769EPNkAxhU8T/mURQ4A5Mcj7P9Qj2tFvw3/7KvRPQOA0m3BGUP+m3IPItIC0sbYb
 PNKEkQJVhqmJNp2L+yM4M//lvxomGW2FEVJ68wUdYFUT9xlm874vXlARAb5ncpUaAW9d976WIkz
 Yl6IscTirH0HRPJqWSOc6Z+MDcMwgsVR8c/jPBXski/7XMlq/TEThgT5a5ZgLwDfte53rBT9OmF
 cUVWUxaGzOxZamccQ8NB1E2geublV4ka2cUVbs1T8e5V4DGnXuCAvtqaU4rWiWfcKCRnkd6USjq
 T0O6w0+NrVKMwJKpbOsJ/fqBbVKBFsJ4TIcPuU4rWP34n/4YXii74kATLKrdhnquCodNBR4ks+V
 x2XL1aY0pdOyFBn67/g16fGblEmRIzYQh8CFzLmrXKSRrXN4VXy5/ZUHiQWdKJ7dnVqnK0HMdVh
 /uBRM+DYt31AKyw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

"thread-id" uses visit_type_uint64, "cpu-affinity" and
"node-affinity" use visit_type_uint16List, not visit_type_int.

Fixes: e2de2c497e57 ("util: Introduce ThreadContext user-creatable object")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 util/thread-context.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/util/thread-context.c b/util/thread-context.c
index 0146154fa56b..88d8f0a55a4e 100644
--- a/util/thread-context.c
+++ b/util/thread-context.c
@@ -278,13 +278,13 @@ static void thread_context_class_init(ObjectClass *oc, const void *data)
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
     ucc->complete = thread_context_instance_complete;
-    object_class_property_add(oc, "thread-id", "int",
+    object_class_property_add(oc, "thread-id", "uint64",
                               thread_context_get_thread_id, NULL, NULL,
                               NULL);
-    object_class_property_add(oc, "cpu-affinity", "int",
+    object_class_property_add(oc, "cpu-affinity", "[uint16]",
                               thread_context_get_cpu_affinity,
                               thread_context_set_cpu_affinity, NULL, NULL);
-    object_class_property_add(oc, "node-affinity", "int", NULL,
+    object_class_property_add(oc, "node-affinity", "[uint16]", NULL,
                               thread_context_set_node_affinity, NULL, NULL);
 }
 

-- 
2.55.0.543.g5ebe2ebe4ea8


