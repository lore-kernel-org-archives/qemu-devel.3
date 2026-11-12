Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FBB606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tnw5QDi/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUtf-0005p5-FD; Thu, 12 Nov 2026 08:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtd-0005nM-Tp
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtc-0001d6-FD
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WHmlrT6x2Z+e3pV4booPfzaFRLaAbFH/jbo3F2VkbBY=;
 b=Tnw5QDi/1mfPZZAbjhmTseLsMGi936FfP91BXVmx9pMaVAMF16i4JhEUq7fHYIBEKf6KSs
 UJb/g1kKhKbGIPCome0Vy0IOzEKhM4DtTEZTNIChWP8q5kNF3kEPR35P2oDiYUtQ2xKbQq
 VbuK42big3asR5A7Qui3tFlNogcxJWk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-lPIu499aM6SED3aA5D3_cg-1; Thu,
 12 Nov 2026 08:31:16 -0500
X-MC-Unique: lPIu499aM6SED3aA5D3_cg-1
X-Mimecast-MFC-AGG-ID: lPIu499aM6SED3aA5D3_cg_1794490275
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FA2219773EB; Thu, 12 Nov 2026 13:31:15 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F4F61956087; Thu, 12 Nov 2026 13:31:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 09/48] system: increase space for machine name in '-machine
 help'
Date: Thu, 12 Nov 2026 13:30:15 +0000
Message-ID: <20261112133054.1977618-10-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The 20 character space allowed for machine names is quite tight
and is about to be exceeded, so bump it up to 25 characters.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/vl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 8ddf306002f..daf0637fb5e 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1587,15 +1587,15 @@ static void machine_help_func(const QDict *qdict)
         if (alc->aliases) {
             size_t i;
             for (i = 0; alc->aliases[i] != NULL; i++) {
-                printf("%-*.20s %s (alias of %s)\n",
+                printf("%-*.25s %s (alias of %s)\n",
                        (int)(strlen(alc->aliases[i]) -
                              strlen(TYPE_MACHINE_SUFFIX)),
                        alc->aliases[i], mc->desc, mc->name);
             }
         } else if (mc->alias) {
-            printf("%-20s %s (alias of %s)\n", mc->alias, mc->desc, mc->name);
+            printf("%-25s %s (alias of %s)\n", mc->alias, mc->desc, mc->name);
         }
-        printf("%-20s %s%s%s%s\n", mc->name, mc->desc,
+        printf("%-25s %s%s%s%s\n", mc->name, mc->desc,
                mc->is_default ? " (default)" : "",
                mc->deprecation_reason ? " (deprecated)" : "",
                object_class_is_secure(OBJECT_CLASS(mc)) ? " (secure)" : "");
-- 
2.56.1


