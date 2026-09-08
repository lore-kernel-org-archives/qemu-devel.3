Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0735AC79FAA
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xPl-0003q9-Tz; Tue, 08 Sep 2026 11:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xPk-0003pv-Ql
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xPj-0007Tf-Gm
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788880030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tiAXSxrzQf4kj8VV9H5x3vM7865KcRbS3wiiJRF8czw=;
 b=CW3GZQVfJLFPJrUCfUWS8CK0MHWiQ7vZJLekdarqyGPMQuTzLSDLN/Tn9NUxB7ZTLPwStD
 ybSgV3Hg8SHhAhpGsllXRFaotIO2XrXiFWP1kOXRaWw1Mb5sqvQyo9Qe6ALgoP9pvHpXIP
 UFVFFoUFJYfydeYrJLETP9g3/R8wdZo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-71B4Qf37PEWR87VttdKReQ-1; Tue,
 08 Sep 2026 11:07:07 -0400
X-MC-Unique: 71B4Qf37PEWR87VttdKReQ-1
X-Mimecast-MFC-AGG-ID: 71B4Qf37PEWR87VttdKReQ_1788880026
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 576141806D3C; Tue,  8 Sep 2026 15:07:06 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C6355B1; Tue,  8 Sep 2026 15:07:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 19:06:45 +0400
Subject: [GIT PULL 02/15] backends/hostmem: fix property typenames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-qom-qapi-pr-v1-2-a4d75a2573cc@redhat.com>
References: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
In-Reply-To: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, David Hildenbrand <david@kernel.org>, 
 Igor Mammedov <imammedo@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0hnOQNp6wqA+id+2lbnwI7IWEZfXqpryBhQOz3T6VyM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoCSP6MPuN+szpMAxZ+xfK3z8ieDYc+oNWgRF7
 OVndYOfg0mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqAkjwAKCRDa6OEJdZac
 5dzREAChmR0y9t0KjCzUoXytKGgFaTVBdRWfzm93pdPZF83UQ1WaT5oFyp7VQx+ViXme9e1vdss
 yhfa5YkAXMo7Zkd7i4OiriIjEGh6Qwggcwd3T5NRBBgD01UOJv2+2bmFGcPhOnWyOokznDep95l
 T3/01PVIdap1GkdWqb+hOKKvO2XJvR2QbUPxHIQl0MOMYljkW56DHfEXaobZgS8FH5CAA/gGIpY
 RbVfU96kcpFq1IskUFU7Nttc+gup2wNp9a0GwrRucgBdNg9Tsy7tQZdVJo+5NoKXPSxkEL1yBTJ
 Sbr+LdjBj492q2xQfyn893i1xDg0VEAPMdTlmiNXAVZPAM110dVE1GhuGr6ICPcikb15Y549URG
 m5DdieVgTBzgI+/OAFtaF3b0sqZbFnLyveCXdPRcjp67mBo1c12Vfq7V8fjuzitaP/3lOO/Rrt1
 65Iue96a/5mYbLgwGoOGLyHPq/nfUap6a3btFHbaiD4lrQ40xnSzlA3I556FBo0TABBHOcNXfQL
 RUnGtVmqijhjej+cMynNckufAadBZkK1LRRkvJwQeM1dhq+/qqYT2pOncYPj6PmzyhwP6Xna9TM
 QzbkaWPhFw3cN9Xs8qVGl7+P1gpPiZ4gbFIOkL63BZ4Q+NY7ehesnqP5FYhtY0I3SzHP40xCcSn
 U8xHLumhmGGh6Kg==
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

The "size" property uses visit_type_size, not visit_type_int. The
"host-nodes" property uses visit_type_uint16List, not visit_type_int.

Fixes: e62834ca62a8 ("hostmem: Register TYPE_MEMORY_BACKEND properties as class properties")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/hostmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 5dd5fb155c47..02846b597d31 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -539,13 +539,13 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
         object_property_allow_set_link, OBJ_PROP_LINK_STRONG);
     object_class_property_set_description(oc, "prealloc-context",
         "Context to use for creating CPU threads for preallocation");
-    object_class_property_add(oc, "size", "int",
+    object_class_property_add(oc, "size", "size",
         host_memory_backend_get_size,
         host_memory_backend_set_size,
         NULL, NULL);
     object_class_property_set_description(oc, "size",
         "Size of the memory region (ex: 500M)");
-    object_class_property_add(oc, "host-nodes", "int",
+    object_class_property_add(oc, "host-nodes", "[uint16]",
         host_memory_backend_get_host_nodes,
         host_memory_backend_set_host_nodes,
         NULL, NULL);

-- 
2.55.0.543.g5ebe2ebe4ea8


