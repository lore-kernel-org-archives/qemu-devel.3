Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A3AC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xQ6-0003tm-Aw; Tue, 08 Sep 2026 11:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQ3-0003sH-K6
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQ2-0007aB-6t
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788880044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PGC7AWWiRfT0nijYNQie4gpAMfiUv3PG/W7v3ZGTcOg=;
 b=VzbD8j5GB1/r1kxrFt9RJFKDChHbiMqevZ7TCoEtIMiQe6yKSu8rMLo+B1W3zRPcfkX0om
 otZvofBAqYFTMrRNto1q2QRIIqQbL7W1fNO+Yo7HxnCTd9KN7i7hnplJHeL8fS1C9jtVcl
 h/E5lU7puB/zi2EgOSjX4nR0e7nJghk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-VDIH03QKMjOX5Vmz8XugXQ-1; Tue,
 08 Sep 2026 11:07:21 -0400
X-MC-Unique: VDIH03QKMjOX5Vmz8XugXQ-1
X-Mimecast-MFC-AGG-ID: VDIH03QKMjOX5Vmz8XugXQ_1788880040
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DB46195DE5D; Tue,  8 Sep 2026 15:07:20 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E0647D6; Tue,  8 Sep 2026 15:07:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 19:06:49 +0400
Subject: [GIT PULL 06/15] event-loop-base: fix property typenames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-qom-qapi-pr-v1-6-a4d75a2573cc@redhat.com>
References: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
In-Reply-To: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1646;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=CIXUVByGgj1bOy4pqQ3L2h+yhTR6wjLSQ4vTbUh0CWM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoCSPHTNkLvFlIklvnfMVzr+hOeNY1vn4YoAy3
 hefLaduhQWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqAkjwAKCRDa6OEJdZac
 5XWGD/0VpINm0eX0vd+vRYombX5NWgGP5QsR9Wh+yl6fKi/32LKDKMw9V+3/oTWHRmrSF0uPpeo
 bTgGe93eLKBJBd1Bxe1+Zl3XL2gCyH/io0F4RjjEbdkJj48UWZApyAC5M3XNB626tH1O4KJnO0G
 0gpVu+0Fby3FtizyqbfoQhLnGa6YyvXxEJw6DKmVrd9KVAqJ4ytrYeAmFBYioXP8YWXF9DLbwLc
 F9VGJqwDA/90Gu5SYQQ5yu5lQg1MNz1gfge7bSFZW9aH02Fa+pABtg3vyHkIghGUpEmfh2N9IYP
 nPM3y7cgmCXeLWwqnzfLB70bQdqZc3+5htMqlX566KOMhfc/e770IY82qsacbITHQO0wUC+7JCV
 vVGuOVBkntwIjyPo9vRPJpzDpG1GIkqRT1sbpxnx3BmEEG026LMEeawdd5BXRg6oHq23gEwgHUP
 OWAmIiRp0ypqXm86b9HdW4vHs1g32Pg9/6cmQYB17SulRB+ZLTzUFRLMdvIp9BYqoqXaa5NWkMl
 HVO8BMLBT7L+c5ghgJSlKc20joq9W5+kzKrWs/hEbabR+ukSrZofTdX/jec8NNvNjPiGp7kwNDX
 RbngGklR+2KVDtHpVFYlaQF1L/RXMMjnkHyT7NB4BYMcMESbqBFYwQNEfrkeCLkUkTXGf/vdzlz
 ktIxGua6pMVDAOw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


