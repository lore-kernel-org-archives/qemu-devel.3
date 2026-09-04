Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158E9C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a5B-0002km-M5; Fri, 04 Sep 2026 16:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a57-0002aH-Ku
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a55-0008El-Sg
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jljT0NNDMf+bBzLc8+ZCGqCh/IWJMadXoK6c2GGKq5Q=;
 b=Q1y3Q+UdG1pOY+tuwGx5OTAX5mS1tU39DZXrrhkCf0enBZUIkTg04zgtNJZHfUgDZZuqBY
 deCBochSMTSuW8vPaaQVDMWaSx1Jyu1DXtwNq8sNv4pA5z4MFZ9zQym99SumOh8tmcuSFg
 Q6Uem8B0a2BD69Th4aB5lR1eTjJgWJg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-sBmpUEB3Oj6-TqpiuMhmjw-1; Fri,
 04 Sep 2026 16:00:07 -0400
X-MC-Unique: sBmpUEB3Oj6-TqpiuMhmjw-1
X-Mimecast-MFC-AGG-ID: sBmpUEB3Oj6-TqpiuMhmjw_1788552006
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57B5019540D2; Fri,  4 Sep 2026 20:00:06 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 878421955F01; Fri,  4 Sep 2026 20:00:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:15 +0400
Subject: [PATCH v4 32/75] backends/hostmem: fix property typenames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-32-a985f168e938@redhat.com>
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
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FoUII7vTDJocTkLIY2sS2QSsmGOwJJb8/wNlwYKz2FI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLKeAyaAzvycT4tWausA0s5ZN32mdkyg0VE+
 kGfG/fUxr6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiygAKCRDa6OEJdZac
 5V1aD/9LZcDWQu6Z/rGFdfmc3kWVsaoBa9qWXwHXgjWpYnthupw6RcDUIBNoINU7d62aoUdi/s3
 zOvnrpbouuJnh6OLKiXW163BIEjj/NsbG0dXOWf2uEp916e5uAQ6NqdV/MWTNGpJu+ECzvHWXgT
 hJg8mZI2cqr7uOr4VE0MOZXATO4trziZAgMMl/UIN5VBwldq8ZJ5niHSkag3Nv4r4TK3xFmmdJI
 n0SwrZiTIVvCx0i9kpKf2w/GLXfHDLA/33IddXCm3FdoVoLLyauJti0eii1V6hN9WJgSroshEm5
 YQAKJqusU+rLg5qtJFYM0mbmNyqRB2PFbllb2//uWQovWaN283cQA0NQMlJVHBhtSeSNR4cG5/y
 ohRmzLy9ZmsM63iMmZFS0QcVPrGdldOZ2j5gCzODLCtYT5AMeSuBtQNughD0w4MPBWBo5ZpEhxZ
 /zFdT02+ZjUyWS7HqSCLj8pNX9hBcUpYHIjwuVsDU7riMFFSW5oSBpIc7hJk7LTih49qs10gQwL
 SGOmVE9u2xQcIe2BaCd6o15Fx+MzyYnIbT06X/N6NHxfgQrwn2gakWfl5BldZBRrqJHVEO9xTk8
 vwPnc2vO8Z1qrvW9Px+PbpDkf9AjvruysdUNvanziB6V4Xth/cMN/7rDgds8LpA34szCUu3xO3F
 Gs6D+Wdn6sry3cw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

The "size" property uses visit_type_size, not visit_type_int. The
"host-nodes" property uses visit_type_uint16List, not visit_type_int.

Fixes: e62834ca62a8 ("hostmem: Register TYPE_MEMORY_BACKEND properties as class properties")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/hostmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index ce82958050e2..e7f9b436a459 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -540,13 +540,13 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
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


