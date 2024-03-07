Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89842C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 17:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riHmr-0000t5-Uj; Thu, 07 Mar 2024 12:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riHmY-0000jd-G5
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:43:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riHmS-0003zc-NW
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709833422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y4QLOlLWMBW0KA/QcJchwb0FTomDYOH6O+n1qD5hyPk=;
 b=i1x/wO8YtsazGJxPoppo1y0xiH6ZhIic2MQQFYjOrOTcC3sXHG8Z5+t+Yq+vqz5o9v0WlW
 dDg7PZqc/1hCQcfJmyhIjjzf7InVMKGxns1OKLVGo0E/EOnTFwID9YQsKzlFwd8IVmagef
 THJajudU4ZmpjPhwcVZr79Is1qoeGv0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-JSa6KMUYOo-JbmFJlbsrqQ-1; Thu,
 07 Mar 2024 12:43:39 -0500
X-MC-Unique: JSa6KMUYOo-JbmFJlbsrqQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFADB3C000AC;
 Thu,  7 Mar 2024 17:43:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27022492BFC;
 Thu,  7 Mar 2024 17:43:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/5] target/sparc/cpu: Rename the CPU models with a "+" in
 their names
Date: Thu,  7 Mar 2024 18:43:30 +0100
Message-ID: <20240307174334.130407-2-thuth@redhat.com>
In-Reply-To: <20240307174334.130407-1-thuth@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Commit b447378e12 ("qom/object: Limit type names to alphanumerical ...")
cut down the amount of allowed characters for QOM types to a saner set.
The "+" character was not meant to be included in this set, so we had
to add a hack there to still allow the legacy names of POWER and Sparc64
CPUs. However, instead of putting such a hack in the common QOM code,
there is a much better place to do this: The sparc_cpu_class_by_name()
function which is used to look up the names of all Sparc CPUs.
Thus let's finally get rid of the "+" in the Sparc CPU names, and provide
backward compatibility for the old names via some simple checks in the
sparc_cpu_class_by_name() function.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qom/object.c       |  8 --------
 target/sparc/cpu.c | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index d4a001cf41..759e194972 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -158,14 +158,6 @@ static bool type_name_is_valid(const char *name)
                         "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                         "0123456789-_.");
 
-    /* Allow some legacy names with '+' in it for compatibility reasons */
-    if (name[plen] == '+') {
-        if (plen >= 17 && g_str_has_prefix(name, "Sun-UltraSparc-I")) {
-            /* Allow "Sun-UltraSparc-IV+" and "Sun-UltraSparc-IIIi+" */
-            return true;
-        }
-    }
-
     return plen == slen;
 }
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 313ebc4c11..651e49bfeb 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -316,7 +316,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Sun UltraSparc IV+",
+        .name = "Sun UltraSparc IVp",
         .iu_version = ((0x3eULL << 48) | (0x19ULL << 32) | (0x22ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -325,7 +325,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES | CPU_FEATURE_CMT,
     },
     {
-        .name = "Sun UltraSparc IIIi+",
+        .name = "Sun UltraSparc IIIip",
         .iu_version = ((0x3eULL << 48) | (0x22ULL << 32) | (0ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_3,
@@ -767,6 +767,16 @@ static ObjectClass *sparc_cpu_class_by_name(const char *cpu_model)
     char *typename;
 
     typename = sparc_cpu_type_name(cpu_model);
+
+    /* Fix up legacy names with '+' in it */
+    if (g_str_equal(typename, SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IV+"))) {
+        g_free(typename);
+        typename = g_strdup(SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IVp"));
+    } else if (g_str_equal(typename, SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IIIi+"))) {
+        g_free(typename);
+        typename = g_strdup(SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IIIip"));
+    }
+
     oc = object_class_by_name(typename);
     g_free(typename);
     return oc;
-- 
2.44.0


