Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE0606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ACK2wGOk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnQM-0002Wv-Nv; Fri, 30 Oct 2026 10:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMnQD-0002Sm-Uq
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:17:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMnQC-0002pI-DW
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793369851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hg4m0qnP4zApKR9oX18gAhUpWkWXdYL/ayjjVX4YKRI=;
 b=ACK2wGOkD7qTclGPRufQKJwb1R7+oVqkQOulTpXBeLeN0pgSLec/dZ+wTZ/mpA3EwlXHLE
 ibFFQJqeI0dad0zG2dp/oRj7FZGAOR1InyZQN2kq7ws/3FqouQAWlf8/QZZJ3foPJ4kST7
 5NBGuVyTjEv4A97gAEa/XNCGh8cC/r4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-1nNWhZZ3OYOuS1vTvqXyyg-1; Fri,
 30 Oct 2026 10:17:28 -0400
X-MC-Unique: 1nNWhZZ3OYOuS1vTvqXyyg-1
X-Mimecast-MFC-AGG-ID: 1nNWhZZ3OYOuS1vTvqXyyg_1793369847
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D68818021F7; Fri, 30 Oct 2026 14:17:27 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FD5318004D2; Fri, 30 Oct 2026 14:17:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 5/8] qapi: rename compat_policy_check_security method
Date: Fri, 30 Oct 2026 14:17:10 +0000
Message-ID: <20261030141713.2841710-6-berrange@redhat.com>
In-Reply-To: <20261030141713.2841710-1-berrange@redhat.com>
References: <20261030141713.2841710-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rename to compat_policy_security_ok to match the naming convention
established by compat_policy_input_ok.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qapi/compat-policy.h | 8 ++++----
 qapi/qapi-util.c             | 8 ++++----
 qom/object.c                 | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/qapi/compat-policy.h b/include/qapi/compat-policy.h
index df87d716439..b7b543ffe74 100644
--- a/include/qapi/compat-policy.h
+++ b/include/qapi/compat-policy.h
@@ -24,10 +24,10 @@ bool compat_policy_input_ok(const CompatPolicy *policy,
                             const char *kind, const char *name,
                             Error **errp);
 
-bool compat_policy_check_security(const CompatPolicy *policy,
-                                  const char *typename,
-                                  bool is_secure,
-                                  Error **errp);
+bool compat_policy_security_ok(const CompatPolicy *policy,
+                               const char *typename,
+                               bool is_secure,
+                               Error **errp);
 
 /*
  * Create a QObject input visitor for @obj for use with QMP
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index e8ecc7346bb..806533c7b3d 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -64,10 +64,10 @@ bool compat_policy_input_ok(const CompatPolicy *policy,
     return true;
 }
 
-bool compat_policy_check_security(const CompatPolicy *policy,
-                                  const char *typename,
-                                  bool is_secure,
-                                  Error **errp)
+bool compat_policy_security_ok(const CompatPolicy *policy,
+                               const char *typename,
+                               bool is_secure,
+                               Error **errp)
 {
     ERRP_GUARD();
 
diff --git a/qom/object.c b/qom/object.c
index 96498f3d001..ceb8e9eebec 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -3276,10 +3276,10 @@ void object_class_property_set_description(ObjectClass *klass,
 
 bool object_class_check_security(ObjectClass *klass, Error **errp)
 {
-    return compat_policy_check_security(&compat_policy,
-                                        object_class_get_name(klass),
-                                        object_class_is_secure(klass),
-                                        errp);
+    return compat_policy_security_ok(&compat_policy,
+                                     object_class_get_name(klass),
+                                     object_class_is_secure(klass),
+                                     errp);
 }
 
 static void object_class_init(ObjectClass *klass, const void *data)
-- 
2.56.0


