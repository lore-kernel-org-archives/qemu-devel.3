Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712BECCA471
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lFB-0005H3-1c; Tue, 30 Sep 2025 21:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lEz-0005EM-Eh
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:02:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lEe-0007yE-Vt
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:02:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so58161975e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280538; x=1759885338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OLSc1BapDuUxqkydDnJRDwQehgAHt3T/lFBNPXooIC8=;
 b=aKivOOSbNG1XL/3YT4EcSWRoc1Yqo0AOe0GDdaJIZvZAHMktR/i8XryyMKejEpfBU8
 4nXPHEl3OmWIAHt39pLQvJKKALWedL7gIjIpWxZG8orrMYQ6pv2ncKkXJhjR4KUb2NAw
 wzf87zZ9B/go6lfANpAM7I8HKNykcRM894o5WXHmXQjRYMwblNSc87bgtfJDcMpOzEB6
 /t5DHZEN1nPBJS/6Qdd5KwNylEnSv1+nMhjA7s3HGRTCig+DxmXVyPCAnIfbSAyBogXL
 ipJJTd6BuOIdYikpKBrV5bDfvqd8y4hM8dnYiCVqExYADiUh1xWGxe11qaYu+HAVXbrK
 T2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280538; x=1759885338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OLSc1BapDuUxqkydDnJRDwQehgAHt3T/lFBNPXooIC8=;
 b=D0eShl5J2pAvIRarQQ/7iUffFbNhiiuaOEgxPtRp6IfBObX81idHfComBR34iP/6/5
 aFZZVP6hfBT3JT1pAjOeAA+BbMKPYuABg2LVD/3Bl03umC3XWxTdpPUelZRQuOptaQRW
 cc9zed8Nrta6voIpkNt9VHaBPTpLYucZI63ZbPuFyM2v+2NUf5J/ESvwtvI86ODKG8bu
 mpjyKOq3A3PFOsombEgOZxJhnYZ8/URkfYHAeRt1hFP8C+06YPok/iRRE1CpgZUu9tN8
 vN+g/389gvsXw0Ip28sFTgiKLCiL0eSsuOpI5U0uah/b7QvMbi6yO8AZEuAXf4uoOy/H
 bFPw==
X-Gm-Message-State: AOJu0YzTbVHKCO2KNyJ0oj9eXrW0cyI9X8JQGr8a/0yRoUYy05C6LRdM
 6tfTJ0Iio6GgZEV9l2xeypA5zthcFtHLWahqE8VeeyikVXE02EPd/5GuSQ+kfzFdQwFMlF4dnDo
 4f9dghv9z9g==
X-Gm-Gg: ASbGnct1snAuekAx65xXsZr/fWHbhRdLqCaA9Y73HHaB8xNzqlD5Gpu/LWqDCRFkbhU
 +PvhJ/3k7jKM5kJU2JJ8nDARGzZuN1s4SXlfvev4A0+Ybn1OCgdsOUkhk0xyoLdk7fOjXM9pcM6
 oRxVekslOsHvGXwvnNQ+X6+VSj1Y0t9rH97GuMmRCOy5ofMYy6WP3mdu737C+DYm+F4i0lwvQCk
 KlmfdagUvWm/d1dYdzxpmb+eREQQf3rEBeIbI6BiNkArRSQQBenCIgl0dJKA6K6sN0f2xYaLuzv
 A8PYYoSG/oMfF/zyD7gSfZh2DSFyi+lxIMmkHZXk9QlT2Hvdw/ibb9eQMDNChKOPiED0yCbJO+k
 qpcDwYWKDzUu5R1U0B/sgXQDSOQ+j+gGTDUMHLRIFD2lbYXAweaE8idT+TeyAk+2U3xS85l6R3T
 9Tb0qwEP66MSB5QEvjMlVpyD9K20iHweic5u9fl3GUavg=
X-Google-Smtp-Source: AGHT+IGe4rGnkaCPkwTQQa5FttkzRVljkl57WR6TySYlUl9rhfMQBCUrtG4XD1ivmQN+nX3/6v41dQ==
X-Received: by 2002:a05:6000:25c6:b0:3fd:bf1d:15ac with SMTP id
 ffacd0b85a97d-425577f3639mr1328524f8f.20.1759280537838; 
 Tue, 30 Sep 2025 18:02:17 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:17 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 02/24] hw/core,
 qemu-options.hx: Introduce 'disabledcpus' SMP parameter
Date: Wed,  1 Oct 2025 01:01:05 +0000
Message-Id: <20251001010127.3092631-3-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Salil Mehta <salil.mehta@huawei.com>

Add support for a new SMP configuration parameter, 'disabledcpus', which
specifies the number of additional CPUs that are present in the virtual
machine but administratively disabled at boot. These CPUs are visible in
firmware (e.g. ACPI tables) yet unavailable to the guest until explicitly
enabled via QMP/HMP, or via the 'device_set' API (introduced in later
patches).

This feature is intended for architectures that lack native CPU hotplug
support but can change the administrative power state of present CPUs.
It allows simulating CPU hot-add–like scenarios while all CPUs remain
physically present in the topology at boot time.

Note: ARM is the first architecture to support this concept.

Changes include:
 - Extend CpuTopology with a 'disabledcpus' field.
 - Update machine_parse_smp_config() to account for disabled CPUs when
   computing 'cpus' and 'maxcpus'.
 - Update SMPConfiguration in QAPI to accept 'disabledcpus'.
 - Extend -smp option documentation to describe 'disabledcpus' usage and
   behavior.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/core/machine-smp.c | 24 +++++++-----
 include/hw/boards.h   |  2 +
 qapi/machine.json     |  3 ++
 qemu-options.hx       | 86 +++++++++++++++++++++++++++++++++----------
 system/vl.c           |  3 ++
 5 files changed, 89 insertions(+), 29 deletions(-)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 0be0ac044c..c1a09fdc3f 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -87,6 +87,7 @@ void machine_parse_smp_config(MachineState *ms,
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     unsigned cpus    = config->has_cpus ? config->cpus : 0;
+    unsigned disabledcpus = config->has_disabledcpus ? config->disabledcpus : 0;
     unsigned drawers = config->has_drawers ? config->drawers : 0;
     unsigned books   = config->has_books ? config->books : 0;
     unsigned sockets = config->has_sockets ? config->sockets : 0;
@@ -166,8 +167,13 @@ void machine_parse_smp_config(MachineState *ms,
         sockets = sockets > 0 ? sockets : 1;
         cores = cores > 0 ? cores : 1;
         threads = threads > 0 ? threads : 1;
+
+        maxcpus = drawers * books * sockets * dies * clusters *
+                    modules * cores * threads;
+        cpus = maxcpus - disabledcpus;
     } else {
-        maxcpus = maxcpus > 0 ? maxcpus : cpus;
+        maxcpus = maxcpus > 0 ? maxcpus : cpus + disabledcpus;
+        cpus = cpus > 0 ? cpus : maxcpus - disabledcpus;
 
         if (mc->smp_props.prefer_sockets) {
             /* prefer sockets over cores before 6.2 */
@@ -207,12 +213,8 @@ void machine_parse_smp_config(MachineState *ms,
         }
     }
 
-    total_cpus = drawers * books * sockets * dies *
-                 clusters * modules * cores * threads;
-    maxcpus = maxcpus > 0 ? maxcpus : total_cpus;
-    cpus = cpus > 0 ? cpus : maxcpus;
-
     ms->smp.cpus = cpus;
+    ms->smp.disabledcpus = disabledcpus;
     ms->smp.drawers = drawers;
     ms->smp.books = books;
     ms->smp.sockets = sockets;
@@ -226,6 +228,8 @@ void machine_parse_smp_config(MachineState *ms,
     mc->smp_props.has_clusters = config->has_clusters;
 
     /* sanity-check of the computed topology */
+    total_cpus = maxcpus = drawers * books * sockets * dies * clusters *
+                modules * cores * threads;
     if (total_cpus != maxcpus) {
         g_autofree char *topo_msg = cpu_hierarchy_to_string(ms);
         error_setg(errp, "Invalid CPU topology: "
@@ -235,12 +239,12 @@ void machine_parse_smp_config(MachineState *ms,
         return;
     }
 
-    if (maxcpus < cpus) {
+    if (maxcpus < (cpus + disabledcpus)) {
         g_autofree char *topo_msg = cpu_hierarchy_to_string(ms);
         error_setg(errp, "Invalid CPU topology: "
-                   "maxcpus must be equal to or greater than smp: "
-                   "%s == maxcpus (%u) < smp_cpus (%u)",
-                   topo_msg, maxcpus, cpus);
+                   "maxcpus must be equal to or greater than smp[+disabledcpus]:"
+                   "%s == maxcpus (%u) < smp_cpus (%u) [+ offline cpus (%u)]",
+                   topo_msg, maxcpus, cpus, disabledcpus);
         return;
     }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index f94713e6e2..2b182d7817 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -361,6 +361,7 @@ typedef struct DeviceMemoryState {
 /**
  * CpuTopology:
  * @cpus: the number of present logical processors on the machine
+ * @disabledcpus: the number additional present but admin disabled cpus
  * @drawers: the number of drawers on the machine
  * @books: the number of books in one drawer
  * @sockets: the number of sockets in one book
@@ -373,6 +374,7 @@ typedef struct DeviceMemoryState {
  */
 typedef struct CpuTopology {
     unsigned int cpus;
+    unsigned int disabledcpus;
     unsigned int drawers;
     unsigned int books;
     unsigned int sockets;
diff --git a/qapi/machine.json b/qapi/machine.json
index 038eab281c..e45740da33 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1634,6 +1634,8 @@
 #
 # @cpus: number of virtual CPUs in the virtual machine
 #
+# @disabledcpus: number of additional present but disabled(or offline) CPUs
+#
 # @maxcpus: maximum number of hotpluggable virtual CPUs in the virtual
 #     machine
 #
@@ -1657,6 +1659,7 @@
 ##
 { 'struct': 'SMPConfiguration', 'data': {
      '*cpus': 'int',
+     '*disabledcpus': 'int',
      '*drawers': 'int',
      '*books': 'int',
      '*sockets': 'int',
diff --git a/qemu-options.hx b/qemu-options.hx
index ab23f14d21..83ccde341b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -326,12 +326,15 @@ SRST
 ERST
 
 DEF("smp", HAS_ARG, QEMU_OPTION_smp,
-    "-smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets]\n"
-    "               [,dies=dies][,clusters=clusters][,modules=modules][,cores=cores]\n"
-    "               [,threads=threads]\n"
-    "                set the number of initial CPUs to 'n' [default=1]\n"
-    "                maxcpus= maximum number of total CPUs, including\n"
-    "                offline CPUs for hotplug, etc\n"
+    "-smp [[cpus=]n][,disabledcpus=disabledcpus][,maxcpus=maxcpus][,drawers=drawers][,books=books]\n"
+    "               [,sockets=sockets][,dies=dies][,clusters=clusters][,modules=modules]\n"
+    "               [,cores=cores][,threads=threads]\n"
+    "                set the initial number of CPUs present and\n"
+    "                  administratively enabled at boot time to 'n' [default=1]\n"
+    "                disabledcpus= number of present but administratively\n"
+    "                  disabled CPUs (unavailable to the guest at boot)\n"
+    "                maxcpus= maximum total CPUs (present + hotpluggable)\n"
+    "                  on machines without CPU hotplug, defaults to n + disabledcpus\n"
     "                drawers= number of drawers on the machine board\n"
     "                books= number of books in one drawer\n"
     "                sockets= number of sockets in one book\n"
@@ -351,22 +354,49 @@ DEF("smp", HAS_ARG, QEMU_OPTION_smp,
     "      For a particular machine type board, an expected CPU topology hierarchy\n"
     "      can be defined through the supported sub-option. Unsupported parameters\n"
     "      can also be provided in addition to the sub-option, but their values\n"
-    "      must be set as 1 in the purpose of correct parsing.\n",
+    "      must be set as 1 in the purpose of correct parsing.\n"
+    "                                                          \n"
+    "      Administratively disabled CPUs: Some machine types do not support vCPU\n"
+    "      hotplug but their CPUs can be marked disabled (powered off) and kept\n"
+    "      unavailable to the guest. Later, such CPUs can be enabled via QMP/HMP\n"
+    "      (e.g., 'device_set ... admin-state=enable'). This is similar to hotplug,\n"
+    "      except all disabled CPUs are already present at boot. Useful on\n"
+    "      architectures that lack architectural CPU hotplug.\n",
     QEMU_ARCH_ALL)
 SRST
-``-smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets][,dies=dies][,clusters=clusters][,modules=modules][,cores=cores][,threads=threads]``
-    Simulate a SMP system with '\ ``n``\ ' CPUs initially present on
-    the machine type board. On boards supporting CPU hotplug, the optional
-    '\ ``maxcpus``\ ' parameter can be set to enable further CPUs to be
-    added at runtime. When both parameters are omitted, the maximum number
+``-smp [[cpus=]n][,disabledcpus=disabledcpus][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets][,dies=dies][,clusters=clusters][,modules=modules][,cores=cores][,threads=threads]``
+    Simulate a SMP system with '\ ``n``\ ' CPUs initially present & enabled on
+    the machine type board. Furthermore, on architectures that support changing
+    the administrative power state of CPUs, optional '\ ``disabledcpus``\ '
+    parameter specifies *additional* CPUs that are present in firmware (e.g.,
+    ACPI) but are administratively disabled (i.e., not usable by the guest at
+    boot time).
+
+    This is different from CPU hotplug where additional CPUs are not even
+    present in the system description. Administratively disabled CPUs appear in
+    ACPI tables i.e. are provisioned, but cannot be used until explicitly
+    enabled via QMP/HMP or the deviceset API.
+
+    On boards supporting CPU hotplug, the optional '\ ``maxcpus``\ ' parameter
+    can be set to enable further CPUs to be added at runtime. When both
+    '\ ``n``\ ' & '\ ``maxcpus``\ ' parameters are omitted, the maximum number
     of CPUs will be calculated from the provided topology members and the
-    initial CPU count will match the maximum number. When only one of them
-    is given then the omitted one will be set to its counterpart's value.
-    Both parameters may be specified, but the maximum number of CPUs must
-    be equal to or greater than the initial CPU count. Product of the
-    CPU topology hierarchy must be equal to the maximum number of CPUs.
-    Both parameters are subject to an upper limit that is determined by
-    the specific machine type chosen.
+    initial CPU count will match the maximum number. When only one of them is
+    given then the omitted one will be set to its counterpart's value. Both
+    parameters may be specified, but the maximum number of CPUs must be equal
+    to or greater than the initial CPU count. Product of the CPU topology
+    hierarchy must be equal to the maximum number of CPUs. Both parameters are
+    subject to an upper limit that is determined by the specific machine type
+    chosen. Boards that support administratively disabled CPUs but do *not*
+    support CPU hotplug derive the maximum number of CPUs implicitly:
+    '\ ``maxcpus``\ ' is treated as '\ ``n + disabledcpus``\ ' (the total CPUs
+    present in firmware). If '\ ``maxcpus``\ ' is provided, it must equal
+    '\ ``n + disabledcpus``\ '. The topology product must equal this derived
+    maximum as well.
+
+    Note: Administratively disabled CPUs will appear to the guest as
+    unavailable, and any attempt to bring them online must go through QMP/HMP
+    commands like 'device_set'.
 
     To control reporting of CPU topology information, values of the topology
     parameters can be specified. Machines may only support a subset of the
@@ -425,6 +455,24 @@ SRST
 
         -smp 2
 
+    Examples using 'disabledcpus':
+
+    For a board without CPU hotplug, enable 4 CPUs at boot and provision
+    2 additional administratively disabled CPUs (maximum is derived
+    implicitly as 6 = 4 + 2):
+
+    ::
+
+        -smp cpus=4,disabledcpus=2
+
+    For a board that supports CPU hotplug and 'disabledcpus', enable 4 CPUs
+    at boot, provision 2 administratively disabled CPUs, and allow hotplug of
+    2 more CPUs (for a maximum of 8):
+
+    ::
+
+        -smp cpus=4,disabledcpus=2,maxcpus=8
+
     Note: The cluster topology will only be generated in ACPI and exposed
     to guest if it's explicitly specified in -smp.
 ERST
diff --git a/system/vl.c b/system/vl.c
index 3b7057e6c6..2f0fd21a1f 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -736,6 +736,9 @@ static QemuOptsList qemu_smp_opts = {
         {
             .name = "cpus",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "disabledcpus",
+            .type = QEMU_OPT_NUMBER,
         }, {
             .name = "drawers",
             .type = QEMU_OPT_NUMBER,
-- 
2.34.1


