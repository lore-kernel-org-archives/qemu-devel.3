Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0B606A320
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NGsNMiuV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xV3WX-0001Xv-5b; Sun, 22 Nov 2026 04:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xV3W5-0001W0-68
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 04:05:48 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xV3W3-0000y3-34
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 04:05:44 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c506a231b88so327485466b.3
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 01:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795338342; x=1795943142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KvuCmFregauDwjWV7OMG1WO1pVSzPmv+w9JnbsPMbHY=;
 b=NGsNMiuVkhfaa/zNu610w65jA/3JNKVli5VH1UBEJB48U94HgUp/pKvEyBZM3Yy9HX
 iv4u+aLiusvnc5Mgpoa1DnZABwe961G1I0IdsqJRTO9pscXccM2pMr/yogCk94b6hLEl
 zNhELFkLuJ6qK3V3yJ2dUgto8GXZijbu0lARJ9EyfNfI4otZUet8fwdjV5nYNhwfeLc4
 X7Pt4tDxpJTouTuvPbvwl0ypTSCIBu722zLQP8xyC5RWq79kWZZhVlAG+Tow4CDSI1oC
 nweDFIGgDrwyw/V0cfEy2sr98uLB59dMpbyopuWRHav5ylI4QzelDY3OvIFt1YtMzVdO
 anjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795338342; x=1795943142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KvuCmFregauDwjWV7OMG1WO1pVSzPmv+w9JnbsPMbHY=;
 b=gcHkEbvjaU0Aff/C9VtVNtzU6grK1udwTgYNqq4aJZ1Bl9f8lWacf2X7lArOULM6Zk
 akqd126jtQiVhPf99riVuffUUgaHEtLTjlTexlzld//5Jg3Sd9rpiTa5EK+9EryqETcs
 YS6VHWzG+1TKtNQf/E1ljcmg5TDiJ9XDr7TdejX0qeDgAagL0KgXBfm+xuKu110d4/s6
 gKQnztEzoFOucNy4AqLK4iMY6OvW6o4nDIbi5E+ZVY9YS/odY0spaxrANMTi7O238ENk
 ipAjY32YCvwyWEXyFS096KGSFBBTRfcTbrIsIlDqCP7DWiWn6bI5cI88CzQI2fktTp/Y
 ec8Q==
X-Gm-Message-State: APuU4Z8gYy0K354z8FC7z3i71JTo7G0B167D+hiwYoD356qboyE93AHI
 BuGxbtE31oCb+IFxs4uLA18hYl8RothqyWJ/2RgFvxA1SwIVNUlMFAp6yQvOfkHD
X-Gm-Gg: AZFdTZeta6lsY79Xv5EZz/6u9oOJahZ48HZ+QsjHWxvJJv0CW+tdn1KNh1o9nMv+FNo
 PKL8mefyJImKdr8K54SvsGKWkvaQbB+fiZeMJp+jGHydMPKWFZKAm5+0vPi+vBhFFiCav3U5PDV
 cESYW7cffAqtZPR5XwK1ZPEZ/0T7DIKcyCkONBMXFNsfn2Jp0hzjY5SeijincJPr4KdcJOJLywc
 b20uga13vdnJYQFMTFw28colBzSZCKGzyf51JWTeooI4kWLVuJl0oT6QZfBDMjYO+kArIx83eTc
 S3mnCr/l31iRb7c1EWLhrx3dz25BdJjkJtntou46Pb9XTcukLSYsC/8gb/ilZ5YCUpvlTh8yTl9
 bHrDqc/ueND0WWvt/XLJ9jZ4tXNz2VkoTdADtUr5KpAiRaoIZGaAGagrMZ+V8mbGsd6B5v9/AIS
 vvLQFUJrJG0Aht7o4+ibuLRKzfpY7qV4SxjBpO0esXs1jSVL+TvnAPITtseAVTvG9FyixAK5d9j
 rdz8lg9K1hgFAALrOztqHFlGK+twtpwFdhz6ntZGzTKRd1+WYge2zNzd5Et6xIOq1G4NMFFJwq6
 Axx7L6Se9kginXQW3/zhQQhOEHVzW6/VV8CnrqcJ5R5wPz/KXe9BLIZvcO1mokujiqmP4A1vqfv
 qzTNeMwuYtMRZR3NOAGNnqOX8dVUlOimtK1QIAkc=
X-Received: by 2002:a17:906:9d04:b0:c44:9a32:b27 with SMTP id
 a640c23a62f3a-c513a846655mr549758666b.25.1795338341511; 
 Sun, 22 Nov 2026 01:05:41 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ad010a6sm298893666b.7.2026.11.22.01.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 01:05:41 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/5] qga: implement 'guest-get-cpustats' for FreeBSD
Date: Sun, 22 Nov 2026 10:05:07 +0100
Message-ID: <20261122090511.15121-3-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122090511.15121-1-bogorodskiy@gmail.com>
References: <20261122090511.15121-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x635.google.com
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

Currently, 'guest-get-cpustats' is implemented for Linux and uses
a Linux-specific GuestLinuxCpuStats. Introduce a BSD specific
type 'GuestBsdCpuStats'. Current implementation adds FreeBSD support,
but it's expected that the type could be shared for other BSD
implementations.

This implementation is built on top of the "kern.cp_times" sysctl.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 qga/commands-bsd.c   | 62 ++++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json | 44 +++++++++++++++++++++++++++----
 2 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 99657b6796..0f97427d8b 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -558,4 +558,66 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
     return head;
 }
 
+GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
+{
+    GuestCpuStatsList *head = NULL, **tail = &head;
+    int maxcpu;
+    int maxid;
+    g_autofree long *times = NULL;
+    size_t size;
+    int i, j, empty;
+    struct clockinfo clockrate;
+    int hz;
+
+    size = sizeof(clockrate);
+    if (sysctlbyname("kern.clockrate", &clockrate, &size, NULL, 0) == -1) {
+        error_setg_errno(errp, errno, "sysctlbyname(kern.clockrate)");
+        return NULL;
+    }
+    hz = clockrate.stathz ? clockrate.stathz : clockrate.hz;
+
+    size = sizeof(maxcpu);
+    if (sysctlbyname("kern.smp.maxcpus", &maxcpu, &size, NULL, 0) == -1) {
+        error_setg_errno(errp, errno, "sysctlbyname(kern.smp.maxcpus)");
+        return NULL;
+    }
+    times = g_new0(long, maxcpu * CPUSTATES);
+    size = sizeof(long) * maxcpu * CPUSTATES;
+    if (sysctlbyname("kern.cp_times", times, &size, NULL, 0) == -1) {
+        error_setg_errno(errp, errno, "sysctlbyname(kern.cp_times)");
+        return NULL;
+    }
+
+    maxid = MIN(size / CPUSTATES / sizeof(long) - 1, CPU_SETSIZE - 1);
+    for (i = 0; i <= maxid; i++) {
+        GuestCpuStats *cpustat = NULL;
+        GuestBsdCpuStats *bsdcpustat;
+
+        empty = 1;
+        for (j = 0; empty && j < CPUSTATES; j++) {
+            if (times[i * CPUSTATES + j] != 0) {
+                empty = 0;
+            }
+        }
+        if (empty) {
+            continue;
+        }
+
+        cpustat = g_new0(GuestCpuStats, 1);
+        cpustat->type = GUEST_CPU_STATS_TYPE_BSD;
+
+        bsdcpustat = &cpustat->u.bsd;
+        bsdcpustat->cpu = i;
+#define TO_MS(X) ((uint64_t)(unsigned long)(X) * 1000 / hz)
+        bsdcpustat->user = TO_MS(times[i * CPUSTATES + CP_USER]);
+        bsdcpustat->nice = TO_MS(times[i * CPUSTATES + CP_NICE]);
+        bsdcpustat->system = TO_MS(times[i * CPUSTATES + CP_SYS]);
+        bsdcpustat->idle = TO_MS(times[i * CPUSTATES + CP_IDLE]);
+        bsdcpustat->irq = TO_MS(times[i * CPUSTATES + CP_INTR]);
+#undef TO_MS
+
+        QAPI_LIST_APPEND(tail, cpustat);
+    }
+    return head;
+}
 #endif /* __FreeBSD__ */
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index d74b94dc8a..4856a549a6 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1700,12 +1700,14 @@
 #     Guest operating systems supporting CPU statistics
 #
 # @linux: Linux
+# @bsd: FreeBSD (Since 12.0)
 #
 # Since: 7.1
 ##
 { 'enum': 'GuestCpuStatsType',
-  'data': [ 'linux' ],
-  'if': 'CONFIG_LINUX' }
+  'data': [ 'linux', 'bsd' ],
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_FREEBSD'] }
+}
 
 ##
 # @GuestLinuxCpuStats:
@@ -1751,6 +1753,34 @@
            },
   'if': 'CONFIG_LINUX' }
 
+##
+# @GuestBsdCpuStats:
+#     CPU statistics of BSD
+#
+# @cpu: CPU index in guest OS
+#
+# @user: Time spent in user mode
+#
+# @nice: Time spent in user mode with low priority (nice)
+#
+# @system: Time spent in system mode
+#
+# @idle: Time spent in the idle task
+#
+# @irq: Time servicing interrupts
+#
+# Since: 12.0
+##
+{ 'struct': 'GuestBsdCpuStats',
+  'data': {'cpu': 'int',
+           'user': 'uint64',
+           'nice': 'uint64',
+           'system': 'uint64',
+           'idle': 'uint64',
+           'irq': 'uint64'
+           },
+  'if': 'CONFIG_FREEBSD' }
+
 ##
 # @GuestCpuStats:
 #     Get statistics of each CPU in millisecond.
@@ -1762,8 +1792,12 @@
 { 'union': 'GuestCpuStats',
   'base': { 'type': 'GuestCpuStatsType' },
   'discriminator': 'type',
-  'data': { 'linux': 'GuestLinuxCpuStats' },
-  'if': 'CONFIG_LINUX' }
+  'data': {
+      'linux': { 'type': 'GuestLinuxCpuStats', 'if': 'CONFIG_LINUX'},
+      'bsd': { 'type': 'GuestBsdCpuStats', 'if': 'CONFIG_FREEBSD' }
+  },
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_FREEBSD'] }
+}
 
 ##
 # @guest-get-cpustats:
@@ -1775,7 +1809,7 @@
 ##
 { 'command': 'guest-get-cpustats',
   'returns': ['GuestCpuStats'],
-  'if': 'CONFIG_LINUX'
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_FREEBSD'] }
 }
 
 ##
-- 
2.56.0


