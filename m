Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBDCC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a5T-0003Sh-SN; Fri, 04 Sep 2026 16:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5K-0003AU-2j
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5I-0008HM-9r
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PGC7AWWiRfT0nijYNQie4gpAMfiUv3PG/W7v3ZGTcOg=;
 b=YH9QweMHAHcymbk3KAnk3TuhJMsQj59Hj5Jh5gs3L+55JeYKlH+lmPfOjYfYw0FA0N3gn9
 X9Y+4ZpRtGuadh4o3Jm9DAevPueJTSV4/Y1QLLMEzyU6DyvLz0v147zEAG9IDFQkz7IUAo
 P4SwgSxHCGR0BrSHnki03uK1oGUH2s4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-AJyv8iijOZeIP_tmhaZakA-1; Fri,
 04 Sep 2026 16:00:21 -0400
X-MC-Unique: AJyv8iijOZeIP_tmhaZakA-1
X-Mimecast-MFC-AGG-ID: AJyv8iijOZeIP_tmhaZakA_1788552020
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7355118E9B28; Fri,  4 Sep 2026 20:00:20 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A2F24423; Fri,  4 Sep 2026 20:00:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:19 +0400
Subject: [PATCH v4 36/75] event-loop-base: fix property typenames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-36-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1646;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=CIXUVByGgj1bOy4pqQ3L2h+yhTR6wjLSQ4vTbUh0CWM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLK/dccNGoOhFaFJT7ECoia4UOMIuuzuCLrz
 M3/DI8H8LSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiygAKCRDa6OEJdZac
 5T5dD/4ycKchkl2QEN/a68qTxrsNopXeYiPYLvzxxvdqqgGJSgtx0QFafZyf4mvTI5WbFjeyZ7V
 83cOncvMmMQyf//YAJ6o5NiZVRAGQLJUAUNs+4WUDeHNlJrBPM1qRXxZggC1NLxsvdhtIjoO3hK
 MtklcnEyvcurUxf+U9PBkMokatA9XV7AcVHFsRkjiIOX/otCBUxBqNmyB9a35QBF8p7W3JnCiOd
 aVbrzln1RsI+8iwETcUUTCE7fzVT3A0Y3LOu/JMKYHgXJi+V+cJrjutc8vK3W6Yfk0zfkzfS3AI
 WK4GT4fv6ACSoj+7T+5oLdG2OrTvd1nLIVB+E62Cc89YE+1HbGu2bVOPoniV7E1n6dU+gkj86oP
 WfCW9H58/RdGN63JiYXqdPDI0NkCIqnWrs3kuCJahOZJl5gRPTN5QdDfMn1o0qWIxVi+CRmXpO6
 Gn418ADYVn2i2k9eQdEjvguEXB3wMatS4TPi2uKnBHz/xGIlE9T+xXDuJ8ntuCny/ndYV158+6A
 oyQrsPAzLRpZMx2jE65Lb3AZ6iNyoQpk4Ofps/7dPtlaiwIq113L8HmudIprrRyxNj3LLcMZr49
 4UKLVs5KZbqgZyU2JM2XGeHJRf+Z98YeoWm4JnlatKvmZVBrMU6jOOCv3CAdI4u8NB28ckBLWgq
 J+TU4lSBZ3gMdsg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The getter and setter use visit_type_int64, not visit_type_int.

Fixes: 7d5983e3c8c4 ("Introduce event-loop-base abstract class")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 event-loop-base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/event-loop-base.c b/event-loop-base.c
index ee5987ddbf64..23f554d92ce8 100644
--- a/event-loop-base.c
+++ b/event-loop-base.c
@@ -104,15 +104,15 @@ static void event_loop_base_class_init(ObjectClass *klass,
     ucc->complete = event_loop_base_complete;
     ucc->prepare_delete = event_loop_base_prepare_delete;
 
-    object_class_property_add(klass, "aio-max-batch", "int",
+    object_class_property_add(klass, "aio-max-batch", "int64",
                               event_loop_base_get_param,
                               event_loop_base_set_param,
                               NULL, &aio_max_batch_info);
-    object_class_property_add(klass, "thread-pool-min", "int",
+    object_class_property_add(klass, "thread-pool-min", "int64",
                               event_loop_base_get_param,
                               event_loop_base_set_param,
                               NULL, &thread_pool_min_info);
-    object_class_property_add(klass, "thread-pool-max", "int",
+    object_class_property_add(klass, "thread-pool-max", "int64",
                               event_loop_base_get_param,
                               event_loop_base_set_param,
                               NULL, &thread_pool_max_info);

-- 
2.55.0.543.g5ebe2ebe4ea8


