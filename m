Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D48606A333
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h5nNKNBH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUvE-0007Be-Ck; Thu, 12 Nov 2026 08:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUuG-0006Ar-M5
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:32:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUuF-0004Fd-4s
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fnIbsW+cV/9j7idU3AU7N80mYw8wzWasbeGrandoO6M=;
 b=h5nNKNBHerbGZ9PsYkLxqBBR91/e4Ln5OY3r/ThCn+gW+C66yquC+YXWr1f7L8aAobfHQM
 F8RoBDwPoZgV2W7FruxqDMpIGDsQLqcDN/y1o3QifK9bsKooYlSDjWCyM+9LpsmwX/Whj7
 go2bP/xkFA7Fhy0x9zFKyPzBeJUnX+Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-OKIfYtpuOdK3h8RTHUp2bQ-1; Thu,
 12 Nov 2026 08:31:53 -0500
X-MC-Unique: OKIfYtpuOdK3h8RTHUp2bQ-1
X-Mimecast-MFC-AGG-ID: OKIfYtpuOdK3h8RTHUp2bQ_1794490312
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7163A1899FC9; Thu, 12 Nov 2026 13:31:52 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 033051956087; Thu, 12 Nov 2026 13:31:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 30/48] system: put machine aliases in alphbetical order
Date: Thu, 12 Nov 2026 13:30:36 +0000
Message-ID: <20261112133054.1977618-31-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When outputting machines for '-machine help', the machine classes
are sorted by name, but aliases, are always printed immediately
before the machine name.

Mostly the aliases share the same name prefix as the main machine
so this does not look odd, other than 'q35' appearing in the
middle of a list of machines with 'pc-q35' prefix.

With the forthcoming patches to rename the 'virt' machine classes
to have unique names across all targets, the positioning of aliases
in the output list looks much odder.

Change to fully alphabetically sort the '-machine help' output
so aliases are subject to the sorting alongside machines.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/vl.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index a187d10ad9c..e822a30c8df 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1533,12 +1533,9 @@ static bool debugcon_parse(const char *devname, Error **errp)
     return true;
 }
 
-static gint machine_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
+static int sort_lines(const void *p1, const void *p2)
 {
-    const MachineClass *mc1 = a, *mc2 = b;
-
-    return strcmp(object_class_get_name(OBJECT_CLASS(mc2)),
-                  object_class_get_name(OBJECT_CLASS(mc1)));
+    return strcmp(*(const char **) p1, *(const char **) p2);
 }
 
 static void machine_help_func(const QDict *qdict)
@@ -1546,6 +1543,9 @@ static void machine_help_func(const QDict *qdict)
     g_autoptr(GSList) machines = NULL;
     GSList *el;
     const char *type = qdict_get_try_str(qdict, "type");
+    g_auto(GStrv) lines = NULL;
+    size_t nlines = 0;
+    size_t i;
 
     machines = object_class_get_list(TYPE_MACHINE, false);
     if (type) {
@@ -1560,23 +1560,34 @@ static void machine_help_func(const QDict *qdict)
     }
 
     printf("Supported machines are:\n");
-    machines = g_slist_sort_with_data(machines, machine_class_cmp, NULL);
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
         AliasedClass *alc = ALIASED_CLASS(mc);
         if (alc->aliases) {
-            size_t i;
             for (i = 0; alc->aliases[i] != NULL; i++) {
-                printf("%-*.25s %s (alias of %s)\n",
-                       (int)(strlen(alc->aliases[i]) -
-                             strlen(TYPE_MACHINE_SUFFIX)),
-                       alc->aliases[i], mc->desc, mc->name);
+                g_autofree char *name = g_strndup(
+                    alc->aliases[i],
+                    strlen(alc->aliases[i]) - strlen(TYPE_MACHINE_SUFFIX));
+                lines = g_renew(char *, lines, nlines + 2);
+                lines[nlines] = g_strdup_printf("%-25s %s (alias of %s)\n",
+                                                name, mc->desc, mc->name);
+                lines[nlines + 1] = NULL;
+                nlines++;
             }
         }
-        printf("%-25s %s%s%s%s\n", mc->name, mc->desc,
-               mc->is_default ? " (default)" : "",
-               mc->deprecation_reason ? " (deprecated)" : "",
-               object_class_is_secure(OBJECT_CLASS(mc)) ? " (secure)" : "");
+        lines = g_renew(char *, lines, nlines + 2);
+        lines[nlines] = g_strdup_printf(
+            "%-25s %s%s%s%s\n", mc->name, mc->desc,
+            mc->is_default ? " (default)" : "",
+            mc->deprecation_reason ? " (deprecated)" : "",
+            object_class_is_secure(OBJECT_CLASS(mc)) ? " (secure)" : "");
+        lines[nlines + 1] = NULL;
+        nlines++;
+    }
+    qsort(lines, nlines, sizeof(lines[0]), sort_lines);
+
+    for (i = 0; i < nlines; i++) {
+        fputs(lines[i], stdout);
     }
 }
 
-- 
2.56.1


