Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D6E606A32A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZY6fzJIs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xV3WF-0001X1-7q; Sun, 22 Nov 2026 04:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xV3W3-0001Vn-TI
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 04:05:44 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xV3W2-0000xx-CA
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 04:05:43 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c4d581da0aaso295997266b.2
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 01:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795338341; x=1795943141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bka1YaGOsPoNluhHGo3bd3L4HCrXvksDn43R+0D6Aok=;
 b=ZY6fzJIsq1RF984w5wk4k5qtNN4m+XtiRsCwwsNFacfqJew9zZsDrhrFBD3J9QzBtQ
 GN08+hWnI1vA7ParAg6dn5F5Vf+7S7aQsQM7hkB5ab/WmBIhIoeP8RRSHvnZsQ8df+ED
 IcUIi9pQf102cYJ6hO79yj+Xl8CEh3tfhSV66U1HhxMw9xb89KaR90bgWn5L8DDJ+kDh
 +c+zvpp/zvgX5738cA3q2RzXs1qULbc/fb+tjdfIl3hw+hlW+soWhUigmQFUZ7iyr3M/
 BMbwd0f+xKm13aE/Co4f+MYdBTp5YFUtkXd0w8QunMdXE3pIto6kGy1vClzbbtdyibOe
 VHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795338341; x=1795943141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bka1YaGOsPoNluhHGo3bd3L4HCrXvksDn43R+0D6Aok=;
 b=GtMjq0ROIbTKvSfc5MamVGcRa2LkRBh4/bMhyy4YGYz4GQ+tETDS0h4sSlZhiFZgwu
 VEQBHSuSqSKZHRSo9xrde/qw6z7GwRrdI5qb9rwZwfrJKgi6PW+LsqoJqJjRqy2+2UtK
 x4yGQJFMKLHTkj134Jja+IbgKyBHDNVzgV6Y9EdRaEGBtyOmHg64GpkJW69uLVvz/zsn
 eO5oxj/4+GLfseoojP+B1R/jfeWUHwx/zsAaf4aq4dk0T4yxtm9rnbWOX/gJNfe17RUf
 0nHQn4U6tCXDqcxMC8aJjuO/XmnSPPICPuygg3/SfXMLnUomPwZgIMuqRjd6VaC2g5SQ
 Nz4A==
X-Gm-Message-State: APuU4Z/cFFr3E4Vhh1tuKVKs01GpIO8xPFBjPmxEHc7yxOuBrrXI7dwX
 CWc7JF4cTe1/A4dcEmVI0RRzCTvnMXAT266OqGDbteB3sSc8vW4FuibYA0K/w14s
X-Gm-Gg: AZFdTZdoUJrccXqcxyFzWPGlMyIjfiWWVCp+YWBgxYxZ1ijiG/OJQFOAdeLPzUwZnDZ
 E+tzIPFlwL0wi9D9rbFc5RRGVPjmWQPJ8N4pE6ylaJ8OF7W1JGuOf7nHUFwoLitQcUHI0M18Xb+
 onOOj5Et8o/PT+U6LfbUD7Wr9JBI1XiOlu6w7keH1Gg1RyOOR0HEqNZ9bXYSE88WrvcpVk2eS6j
 ryYe854g+JDyqzWPzu8W+mbntQaR+GIBu5gB66YtHFmH+r/p7NBGEjiGSPd1vepqM/SVb793Kft
 VTQ/i/OkkOQwkPRJ89aF/MN9UmiQTD5ErrCMhb5333sDCI1CekOkLvjZxr3J9ShlJjU+Kr67k6H
 RW2e6aQ71lPVu/wm9foJvbsOkNF596m/moIOmHuKQUyMbvtohNxvOUu708+juz+Aj1VKwWK9UtD
 T6C0Huj4QatjnOIyjcQnTLj1+DKcU4rFd/NvLNR8OxO526Rup89U8pnYQVnI92Q4tHC/r9/efau
 jkrITMU2sb4jYfjnRMhJNLuiEcr3uOTiVoz1ErvBe781IAjw2q5l1redfeWaT8WpYxNTc9cwMOM
 9xV7chzyzKTo9j9XCXa92ukpXxJYArACxgAWvrcMeJmoQl4fXL3WktUR+WFXjCbOIThmaTz2LWx
 +yUV/S+SWo8Vnvmnc3Bkl/pbCqYBkEsSwHQvLDb7SZjzCnfCQd6BT4vU/iZ/+
X-Received: by 2002:a17:906:ccc1:b0:c29:5172:6151 with SMTP id
 a640c23a62f3a-c513ac9b721mr558048966b.45.1795338340687; 
 Sun, 22 Nov 2026 01:05:40 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ad010a6sm298893666b.7.2026.11.22.01.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 01:05:40 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 1/5] qga: implement 'guest-get-vcpus' for FreeBSD
Date: Sun, 22 Nov 2026 10:05:06 +0100
Message-ID: <20261122090511.15121-2-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122090511.15121-1-bogorodskiy@gmail.com>
References: <20261122090511.15121-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use cpuset_getaffinity() to get vCPUs. This function is specific
to FreeBSD, and other BSDs use other mechanisms, so just
put that under #ifdef __FreeBSD__.

FreeBSD does not support offline CPUs, so reported vCPUs
are always online.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 qga/commands-bsd.c    | 32 ++++++++++++++++++++++++++++++++
 qga/qapi-schema.json  |  4 ++--
 tests/unit/test-qga.c |  4 ++++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 830ad08ac0..99657b6796 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -23,6 +23,7 @@
 #include <net/if_dl.h>
 #include <sys/statvfs.h>
 #if defined(__FreeBSD__)
+#include <sys/cpuset.h>
 #include <sys/sysctl.h>
 #include <net/route.h>
 #include <net/if.h>
@@ -526,4 +527,35 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
 
     return head;
 }
+
+GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
+{
+    cpuset_t mask;
+    GuestLogicalProcessorList *head, **tail;
+    int bit;
+
+    head = NULL;
+    tail = &head;
+
+    if (cpuset_getaffinity(CPU_LEVEL_WHICH, CPU_WHICH_CPUSET, 0,
+                           sizeof(mask), &mask) != 0) {
+        error_setg_errno(errp, errno, "getaffinity");
+        return NULL;
+    }
+
+    for (bit = 0; bit < CPU_SETSIZE; bit++) {
+        if (CPU_ISSET(bit, &mask)) {
+            GuestLogicalProcessor *vcpu;
+            vcpu = g_new0(GuestLogicalProcessor, 1);
+            vcpu->logical_id = bit;
+            vcpu->online = true;
+            vcpu->has_can_offline = true;
+            vcpu->can_offline = false;
+            QAPI_LIST_APPEND(tail, vcpu);
+        }
+    }
+
+    return head;
+}
+
 #endif /* __FreeBSD__ */
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index de42dfe77d..d74b94dc8a 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -735,7 +735,7 @@
   'data': {'logical-id': 'int',
            'online': 'bool',
            '*can-offline': 'bool'},
-  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32', 'CONFIG_FREEBSD'] } }
 
 ##
 # @guest-get-vcpus:
@@ -748,7 +748,7 @@
 ##
 { 'command': 'guest-get-vcpus',
   'returns': ['GuestLogicalProcessor'],
-  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32', 'CONFIG_FREEBSD'] } }
 
 ##
 # @guest-set-vcpus:
diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
index b1c84c188b..a8387bd8e8 100644
--- a/tests/unit/test-qga.c
+++ b/tests/unit/test-qga.c
@@ -1117,9 +1117,13 @@ int main(int argc, char **argv)
     g_test_add_data_func("/qga/info", &fix, test_qga_info);
     g_test_add_data_func("/qga/network-get-interfaces", &fix,
                          test_qga_network_get_interfaces);
+#if defined(CONFIG_LINUX)
     if (!access("/sys/devices/system/cpu/cpu0", F_OK)) {
         g_test_add_data_func("/qga/get-vcpus", &fix, test_qga_get_vcpus);
     }
+#elif defined(CONFIG_FREEBSD)
+    g_test_add_data_func("/qga/get-vcpus", &fix, test_qga_get_vcpus);
+#endif
     g_test_add_data_func("/qga/get-fsinfo", &fix, test_qga_get_fsinfo);
     g_test_add_data_func("/qga/get-load", &fix, test_qga_get_load);
     g_test_add_data_func("/qga/get-memory-block-info", &fix,
-- 
2.56.0


