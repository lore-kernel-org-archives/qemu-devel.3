Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F530C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 10:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXIvv-0006uB-Hn; Tue, 06 Feb 2024 05:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIvn-0006sU-HH
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:44:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIvl-0003AK-Ny
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707216237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lui+zfEHwTa84G7gBv3rrXHn+tSC14NgRm7xXAbQH2A=;
 b=dlGSfRGXfE9cD+q4dSsWK4PnlBw1+OG6pwtPf7vo0YCX68qQfjGujrP5m9hu0jfuX8EqOt
 VLLtRF2hFiSADHhiIz4X484JOCIOBh7sAl7HUNW4yBM/fLUOAgxwTMrZqocdm2CCQsE+BP
 H7wXPUzDjtDSVzsoTmJcnx4gpy2cxd4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-msHKBc3cPTGQcRCRodFFPA-1; Tue, 06 Feb 2024 05:43:53 -0500
X-MC-Unique: msHKBc3cPTGQcRCRodFFPA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 181B4185A781;
 Tue,  6 Feb 2024 10:43:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84278492BFA;
 Tue,  6 Feb 2024 10:43:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 02/12] target/ppc/cpu-models: Rename power5+ and power7+ for
 new QOM naming rules
Date: Tue,  6 Feb 2024 11:43:37 +0100
Message-ID: <20240206104347.238825-3-thuth@redhat.com>
In-Reply-To: <20240206104347.238825-1-thuth@redhat.com>
References: <20240206104347.238825-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The character "+" is now forbidden in QOM device names (see commit
b447378e1217 - "Limit type names to alphanumerical and some few special
characters"). For the "power5+" and "power7+" CPU names, there is
currently a hack in type_name_is_valid() to still allow them for
compatibility reasons. However, there is a much nicer solution for this:
Simply use aliases! This way we can still support the old names without
the need for the ugly hack in type_name_is_valid().

Message-ID: <20240117141054.73841-2-thuth@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/spapr_cpu_core.c |  4 ++--
 qom/object.c            |  4 ----
 target/ppc/cpu-models.c | 10 ++++++----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 5aa1ed474a..0c0fb3f1b0 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -389,9 +389,9 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
     DEFINE_SPAPR_CPU_CORE_TYPE("970_v2.2"),
     DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.1"),
-    DEFINE_SPAPR_CPU_CORE_TYPE("power5+_v2.1"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("power5p_v2.1"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power7_v2.3"),
-    DEFINE_SPAPR_CPU_CORE_TYPE("power7+_v2.1"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("power7p_v2.1"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power8_v2.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
diff --git a/qom/object.c b/qom/object.c
index 654e1afaf2..2c4c64d2b6 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -160,10 +160,6 @@ static bool type_name_is_valid(const char *name)
 
     /* Allow some legacy names with '+' in it for compatibility reasons */
     if (name[plen] == '+') {
-        if (plen == 6 && g_str_has_prefix(name, "power")) {
-            /* Allow "power5+" and "power7+" CPU names*/
-            return true;
-        }
         if (plen >= 17 && g_str_has_prefix(name, "Sun-UltraSparc-I")) {
             /* Allow "Sun-UltraSparc-IV+" and "Sun-UltraSparc-IIIi+" */
             return true;
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 7dbb47de64..36e465b390 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -716,11 +716,11 @@
                 "PowerPC 970MP v1.0")
     POWERPC_DEF("970mp_v1.1",    CPU_POWERPC_970MP_v11,              970,
                 "PowerPC 970MP v1.1")
-    POWERPC_DEF("power5+_v2.1",  CPU_POWERPC_POWER5P_v21,            POWER5P,
+    POWERPC_DEF("power5p_v2.1",  CPU_POWERPC_POWER5P_v21,            POWER5P,
                 "POWER5+ v2.1")
     POWERPC_DEF("power7_v2.3",   CPU_POWERPC_POWER7_v23,             POWER7,
                 "POWER7 v2.3")
-    POWERPC_DEF("power7+_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
+    POWERPC_DEF("power7p_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
                 "POWER7+ v2.1")
     POWERPC_DEF("power8e_v2.1",  CPU_POWERPC_POWER8E_v21,            POWER8,
                 "POWER8E v2.1")
@@ -902,10 +902,12 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "970", "970_v2.2" },
     { "970fx", "970fx_v3.1" },
     { "970mp", "970mp_v1.1" },
-    { "power5+", "power5+_v2.1" },
+    { "power5+", "power5p_v2.1" },
+    { "power5+_v2.1", "power5p_v2.1" },
     { "power5gs", "power5+_v2.1" },
     { "power7", "power7_v2.3" },
-    { "power7+", "power7+_v2.1" },
+    { "power7+", "power7p_v2.1" },
+    { "power7+_v2.1", "power7p_v2.1" },
     { "power8e", "power8e_v2.1" },
     { "power8", "power8_v2.0" },
     { "power8nvl", "power8nvl_v1.0" },
-- 
2.43.0


