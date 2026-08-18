Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E16C5DF80
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHri-0006ZG-Ob; Tue, 18 Aug 2026 07:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHrg-0006Xx-N0
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHrf-0006id-Am
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbpKbIyL8tSDevf3zlwRUlxseo4SZM5m4N1usht1sFM=;
 b=XupvfaBGfWSv75UEKm7m1pXP7YOt0NZHKeQ0D8crjyrEZkYqAHqoZtmv4Fgg55+1z7FIIP
 aLX/KOhgbBPk8udOpyX/vFCU2T4gBq9A3Ee8cRvwRVP7OdkVKOygpB5ve5BSh/CBE/4yjt
 7+m+v5mE+G1LqZwc7Gghfgfb5Jl6K0U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-gJ86pOdZP8W_GO4c7v1Lkw-1; Tue,
 18 Aug 2026 07:20:07 -0400
X-MC-Unique: gJ86pOdZP8W_GO4c7v1Lkw-1
X-Mimecast-MFC-AGG-ID: gJ86pOdZP8W_GO4c7v1Lkw_1787052006
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D302195608E; Tue, 18 Aug 2026 11:20:06 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5019C434; Tue, 18 Aug 2026 11:20:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:58 +0400
Subject: [PATCH v3 31/74] backends/hostmem: fix property typenames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-31-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=C/Qe1xmfvc0qQvmF4aSB0ZNKceuJzHRadp8hB488LIw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD25vxuX7hdpSaM0QLo1sokwbhi/FfduiZIv8
 MP4rKszpG2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uQAKCRDa6OEJdZac
 5VdTD/9xVRATWB8+1QgwOaz3qKuZ+eOTqc6r0yEnZmFUiC5lFnSw2eiWa2rFpVOa6ODJmMGrktE
 TM/qaJYk805pfa4bWArMP/IL3UP5I4oAz3bluGADCUimVNZ5b8ZjsfHdtEXYgFLFXOlVApjF5oz
 fdJ8nGna/0BSvNuChXZ5vlYjlmOT275iskAMYu0VTR4Rkk6NtFWnSnL+crTR72qXZ1IF4RzRj1l
 B548wOWhuEG899BxInbhdZ1fA9C+JqDBUeo8OPHtyADxzD1zkRf3XKrPv7sZmLYNuPnCUus31Ph
 ZQTH+lN1wfIY7B+YSp2yXW+4KbpqaTSPTjJ/qruDXiCZrvfVacwWZjtMdbggRKKCYLyaRMBS7xH
 XTclbcQILzT5YDT31tZ0XfHGCGfqUGS1B3h59xxYkzd5+D4pBGB/OIjWWWBNMtIWILsriuFsb9k
 IeEIVRi8mAfq+oQV7wWgCBKXtNrGPp7qn3kJkcXRs9+jiHCFdG9/31dK629wbZtVxhTwQQ+YM6m
 NxVF4Q8y5o4JrfSKYhR8IYi2RURBkZiSXBaU5dLzdLUscXOnRX30Br9L9yOYNnQqhYj451Vos6K
 DPs15IkBRZgXwCVxBCTXFMm0TbhOdeLoTKFRc5tXyU8q7Q/iCNWSUd6f+ml3FnqumLybpKo0/Ke
 OI62Mh7eoNw5Pxw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

The "size" property uses visit_type_size, not visit_type_int. The
"host-nodes" property uses visit_type_uint16List, not visit_type_int.

Fixes: e62834ca62a8 ("hostmem: Register TYPE_MEMORY_BACKEND properties as class properties")
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


