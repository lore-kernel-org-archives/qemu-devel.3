Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A097CC79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xPq-0003qc-5f; Tue, 08 Sep 2026 11:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xPp-0003qR-13
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xPn-0007WE-K4
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788880035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dVKrnX9hAZwY1mmeGIkMNAcTXkXbFnZjZRWuHSeTwPE=;
 b=AbQw8+sSi4PusoXXhmuE5bSZV+Yb8TeB0e5WAR1f27U7h3jiIjEYqHyfRiCE3E0a8rivPu
 pATQsqGlNo9uHxqY0MKoGs0ny0u0MysrHKpgJ2C8Ud2Ec9FSFT+YPXKzIr5vvhSBYc9kix
 BPKSgeSaQdV1ihJ9RLjD62k9LPQcF2Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-hFLTw2jOPF-XGLOcqTY2HQ-1; Tue,
 08 Sep 2026 11:07:10 -0400
X-MC-Unique: hFLTw2jOPF-XGLOcqTY2HQ-1
X-Mimecast-MFC-AGG-ID: hFLTw2jOPF-XGLOcqTY2HQ_1788880030
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8AD2195BDF3; Tue,  8 Sep 2026 15:07:09 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEE6918005AA; Tue,  8 Sep 2026 15:07:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 19:06:46 +0400
Subject: [GIT PULL 03/15] backends/hostmem-file: fix "align" property typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-qom-qapi-pr-v1-3-a4d75a2573cc@redhat.com>
References: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
In-Reply-To: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, David Hildenbrand <david@kernel.org>, 
 Igor Mammedov <imammedo@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1682;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=V5YJIVEMJtEhANcd2XfBTAYK5LxpxJarrO3nh2ujYwg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoCSPQwvnqBw64GKbd/JrDG5geS0z4iIEJQYvi
 DL3cgHBa92JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqAkjwAKCRDa6OEJdZac
 5Q/HD/9VL2sm4hT78orG9xWYUmMYXZhwLZpFA96BoLyf4q3toW27U2LzzRmJ/GxF/Li6qBtP32Z
 JmN+CxQ8giFlbkE/fX+FLXFW8QbNc33pZRkvqmQLih2iETfcShk5xodzMIgsmMcDfMUrU+1Vc5v
 SxIwAhhYfENE8aVrbIfDOQd82r9vS99u9dn9ldSyqcNy8Lg8wMOYMT9lXgvI+Qm/89A++xkL+0C
 MWlSYXNALfy5D/970C/Adrz5q9FwGNDoVJS3U2WZBfmo/g8EJCuVDX99mczSMB/ZlO90es6F94r
 g9M0N+r+bZYY6eJ3pLx8P2vOxuIqmz9ZHYqUz1gKvppMkyZue7fPEVk6p8kXoU5ADPMoAl8kLKD
 fX6GCk5g3tm6ppnxVgieFHs2lZW2ILK7XBMNHe2aabSmL/a686XcsUxy2Rp2yNT5vH+U9p4jtkb
 jvo4ZlNqJw9CagRj74bjqI7HSQw725gcJoApa9TRLlo9C43tOjQg0DHitJnjLcrl78PVQ1or9Gx
 NK9aWs9QWRGZLOsU5qwNEj1ToG9U/JlF3+tPJtVHnnD075EILmPgSUhwa+JRSdEqN9+pRNv83Ie
 jXQyr9PrW+hQjZ3SvdXbAsnEVulLrOfMwXlLrON4d0w/fjDAOuDUIO4Xju4F2eFIgHAivpZti1Y
 2gvIhN22NH7OEmg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

The getter and setter use visit_type_size, not visit_type_int.
Since the underlying type is uint64, change it to that.

Fixes: 983768431676 ("hostmem-file: add "align" option")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/hostmem-file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 8e3219c06172..8cf27ad67e13 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -134,7 +134,7 @@ static void file_memory_backend_get_align(Object *o, Visitor *v,
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
     uint64_t val = fb->align;
 
-    visit_type_size(v, name, &val, errp);
+    visit_type_uint64(v, name, &val, errp);
 }
 
 static void file_memory_backend_set_align(Object *o, Visitor *v,
@@ -151,7 +151,7 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
         return;
     }
 
-    if (!visit_type_size(v, name, &val, errp)) {
+    if (!visit_type_uint64(v, name, &val, errp)) {
         return;
     }
     fb->align = val;
@@ -281,7 +281,7 @@ file_backend_class_init(ObjectClass *oc, const void *data)
         file_memory_backend_get_discard_data, file_memory_backend_set_discard_data);
     object_class_property_add_str(oc, "mem-path",
         get_mem_path, set_mem_path);
-    object_class_property_add(oc, "align", "int",
+    object_class_property_add(oc, "align", "uint64",
         file_memory_backend_get_align,
         file_memory_backend_set_align,
         NULL, NULL);

-- 
2.55.0.543.g5ebe2ebe4ea8


