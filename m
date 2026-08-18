Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E56C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHsz-0000uv-Ap; Tue, 18 Aug 2026 07:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHsy-0000uF-CF
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHsw-0006uJ-Vt
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxfcwqLSIv13a5eubiOp32qB49quLWiBMCO9bEGm5wc=;
 b=CsU5SbyAFjQzjpYdUs1Ym//GP6zrdstgy3LGEd0uyyecaXBgnW7H9BdXGMS1axZDEvvVwC
 WltkHO3bBIMjVa2l6/oAxUG8LLVLsso/bFmp/2UQwKbI5XRzcZ8X+RYmEc7kvZQq0L6wNX
 Z5ltYZE6/pyMm5cgrWM98lGZjmPJ2CM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-5JmYgCiWP_OhVsZcO7wG1g-1; Tue,
 18 Aug 2026 07:21:30 -0400
X-MC-Unique: 5JmYgCiWP_OhVsZcO7wG1g-1
X-Mimecast-MFC-AGG-ID: 5JmYgCiWP_OhVsZcO7wG1g_1787052089
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16E351800879; Tue, 18 Aug 2026 11:21:29 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FCF030002E9; Tue, 18 Aug 2026 11:21:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:04 +0400
Subject: [PATCH v3 37/74] util/thread-context: fix property typenames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-37-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1CfAaStCFv0hN2KF9G0PH/YVSk9/tPyTQC7lgrOUIEI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD269vUdsrmRY24anjPThu7pmJzyTUbLT8UDo
 mAwHmCONbSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9ugAKCRDa6OEJdZac
 5dmhD/sFw+G7pz/ziCP8b8dy+DCvPEfpk9Ih0XVsRWAYVKY9jQ4a1fp8Ewerwp/RD12EbvWUEFC
 wQC5j2yLsE8cnP/RR4qyVwftC7YpmFw8mD5BhhznmPL10jjROvW6sROCTO2C0hcyT8p631oYWy9
 slZaSThXP9ntm7QyImcSrp+uFm5QnSdld6c04GkCB56ym24MluuIiRamIvu9s6dI5h87JDO6cQ1
 IW52J8vBnNg76YqbBZzKy2hY9jumvrO6YjNnQsraNnaYLYfmsAeKKtCJAtm4h4nRZLUnXpO03sl
 5BdOmSlN6Xp+G0Ha7VwAFhsItdP2BW0NVEQGnl4tZFViOQePQ5ZBZZclclafIRpLedb3/T1hf7V
 fly2M57rIvMU7k40KNP+m+GitfzBb0NtrJN82hLBIKCj9t0XK8y2XBJrZsydQ76eYSqeSZjOwel
 UUROVTiiRxplRVOTYf5PEQMwo5UNOHnJ+v+DliVCAyCY3yxGRcGpnxEfNuOmpOyHVvnhzqoOuru
 oMkbeL4GGrUVx5ivDqBhmjxY1QNKo8GxEjeS3MHQo8eHyi3MpUmAziSbfpUudaN45ZnVzqRVZSS
 TH5xSLJ9vD3oXXvVvW3Hcm5BpkSuxVgxJ+WlYZft0UQ6dOgKeHOkAfNbNdM0lqikfav4BOFkpbK
 ipCHsINpod1rNtA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

"thread-id" uses visit_type_uint64, "cpu-affinity" and
"node-affinity" use visit_type_uint16List, not visit_type_int.

Fixes: e2de2c497e57 ("util: Introduce ThreadContext user-creatable object")
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


