Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43631CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 00:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIyr9-0006Dt-Tl; Tue, 11 Nov 2025 19:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3qtYTaQcKCvUkXsfabjdlldib.Zljnbjr-absbiklkdkr.lod@flex--navidem.bounces.google.com>)
 id 1vIyr8-0006DH-1e
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 19:37:02 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3qtYTaQcKCvUkXsfabjdlldib.Zljnbjr-absbiklkdkr.lod@flex--navidem.bounces.google.com>)
 id 1vIyr6-00035o-BF
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 19:37:01 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-297b35951b7so3048075ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 16:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1762907818; x=1763512618; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wh09LpRgwj/9z9dmRAqnezjWcWWDnh9KoI98leDIQJ8=;
 b=up004HECv0poOmLBOWbj/ye3oZMzJ+ORd+hO56f0+DXTELdMVOecHO82r4R0sGhbBz
 eY3bKz1Q0TBZh/wct6Sy6cjk+3f1zxhqtqVSWUDQcg6pYHHMEZZ6dDmMZGpXylE46m0Q
 xunLsfV805gauHjfQp1FTtBo1+hMpQNcZjDHxhflb48H8vs8HT5s42FXcNCHSJhwPGrF
 iuDXNWWByu406G6u52hATrtwVo0JI2Z6l5ejSqE2//Wswf3OdvkRkQnZW7g/qWb/Jsqt
 pIV3Pgp5DuDqw76m4Z4UsJn1432eAm9lZlbz76/XRgREVkVfKO2fcrQ5uVsWin6wVr34
 ot0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762907818; x=1763512618;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wh09LpRgwj/9z9dmRAqnezjWcWWDnh9KoI98leDIQJ8=;
 b=VFn1ptAmeoQnDC8FrUBNv1cVAiS8hYkSD12GUQigZtZhiEPT37N3vRcyWMCt/HPddK
 c4rRdbVGgBQni4oWr9DhQ9beTwgIJkyZos8XTQLUifyHEKagjazeGBispsLYzn4uiRp8
 9ndUN170nu2OMLF948TrXfEfBCmJn2nYEDQJ7W0Z1zbaBlVXgHs0R9gwczC0yAlBf4MC
 M0z8G+neva357q6EvaepoOP0nlRcrfJLFc8O7lMXMsjNqs8tCphuHGHy1SaBP9+gSXxj
 oehVwDS9kZ7y2Fbu/7MDM8U/8NR4OvDKtRrilP1dgtZrhjUX7Wq2B4FMrhfxdPwRnf16
 Jq2A==
X-Gm-Message-State: AOJu0Yymzw+ylOb6sbBQT8/0Q9x3M4a1rVLczDpRwt7E4CwKHFcJ/OQO
 LhpYXASrWzuHGtfJzsO55nARz9W+4Ot3Ju/Tj0J+bbQ8boPAcjen+jFtck6853f7RQaGQLBGpK6
 Wjar/l8fjyR2YZGV5xV4Q3G037Q+JDloNECO3ESIZQTlWTe2ou1xs9S5kmqTjfDBZaY6se3fnrA
 pg8WQkvohkCfgT1FLnRauGWYEOl4o6903dnpJW0UFC
X-Google-Smtp-Source: AGHT+IH6kziuc0/wbNxAxbfReAVM5YKRVKlYY8KEPXwob3dXoi1lJjJNzs8yr4XU3DNJKvu6WUG/JuVTHIFG
X-Received: from pldt12.prod.google.com ([2002:a17:903:40cc:b0:295:50ce:4dd])
 (user=navidem job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f541:b0:295:82b5:73e9
 with SMTP id d9443c01a7336-2984edac653mr15626515ad.35.1762907818286; Tue, 11
 Nov 2025 16:36:58 -0800 (PST)
Date: Wed, 12 Nov 2025 00:36:37 +0000
In-Reply-To: <20251112003637.1984547-1-navidem@google.com>
Mime-Version: 1.0
References: <CAHUE=o9+kYVzWmHbHkJ5FKDpJhekhBCW8j+vwFm0yQCJrQGveA@mail.gmail.com>
 <20251112003637.1984547-1-navidem@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112003637.1984547-2-navidem@google.com>
Subject: [PATCH v3 1/1] tests/qtest/fuzz: Add generic fuzzer for VNC
From: Navid Emamdoost <navidem@google.com>
To: qemu-devel@nongnu.org, alxndr@bu.edu, berrange@redhat.com, 
 pbonzini@redhat.com, bsd@redhat.com, stefanha@redhat.com, farosas@suse.de, 
 darren.kenny@oracle.com, Qiuhao.Li@outlook.com, lvivier@redhat.com, 
 zsm@google.com
Cc: Navid Emamdoost <navidem@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3qtYTaQcKCvUkXsfabjdlldib.Zljnbjr-absbiklkdkr.lod@flex--navidem.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add a new generic fuzz target for the QEMU VNC server. This target
exercises both the standard VNC protocol and the VNC-over-WebSocket
transport layer, increasing coverage of a primary remote attack surface.

To support parallel fuzzing (e.g., with oss-fuzz), the VNC unix
socket paths are generated dynamically. The fuzzer harness inspects the
command line for placeholders and replaces them with unique paths
created by mkstemp() before execution.

---

This new target increases code coverage in the VNC subsystem
and related networking and I/O code.
The baseline coverage below was generated by running all existing fuzz
targets with the oss-fuzz corpus. The new target shows significant gains:

----------------------------------------------------------------------------
File                       New Target                Baseline        Change
----------------------------------------------------------------------------
vnc.c                      339/3212 (10.6%)     3/3212 (0.1%)        +336
keymaps.c                  91/184 (49.5%)       0/184 (0.0%)         +91
net-listener.c             76/198 (38.4%)       3/198 (1.5%)         +73
channel-socket.c           73/575 (12.7%)       19/575 (3.3%)        +54
qemu-sockets.c             44/1019 (4.3%)       0/1019 (0.0%)        +44
vnc-jobs.c                 41/219 (18.7%)       0/219 (0.0%)         +41
dns-resolver.c             28/145 (19.3%)       3/145 (2.1%)         +25

Signed-off-by: Navid Emamdoost <navidem@google.com>
---
 tests/qtest/fuzz/generic_fuzz_configs.h | 50 +++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
index ef0ad95712..9c46e106a4 100644
--- a/tests/qtest/fuzz/generic_fuzz_configs.h
+++ b/tests/qtest/fuzz/generic_fuzz_configs.h
@@ -29,6 +29,52 @@ static inline gchar *generic_fuzzer_virtio_9p_args(void){
     "writeout=immediate,fmode=0600,dmode=0700", tmpdir);
 }
 
+/*
+ * Global variables and cleanup handler for VNC fuzzer sockets.
+ * These are needed because the socket paths must be available at exit.
+ */
+static char g_vnc_socket_path[sizeof("/tmp/qemu-vnc.XXXXXX")];
+static char g_vnc_ws_socket_path[sizeof("/tmp/qemu-vnc-ws.XXXXXX")];
+
+static void cleanup_vnc_sockets(void)
+{
+    if (g_vnc_socket_path[0] != '\0') {
+        unlink(g_vnc_socket_path);
+    }
+    if (g_vnc_ws_socket_path[0] != '\0') {
+        unlink(g_vnc_ws_socket_path);
+    }
+}
+
+/*
+ * Dynamically generate VNC arguments with unique unix socket paths.
+ * This allows multiple fuzzing jobs to run in parallel without conflict.
+ */
+static inline gchar *generic_fuzzer_vnc_args(void)
+{
+    static bool cleanup_registered = false;
+    int fd;
+
+    strcpy(g_vnc_socket_path, "/tmp/qemu-vnc.XXXXXX");
+    fd = g_mkstemp(g_vnc_socket_path);
+    g_assert_cmpint(fd, !=, -1);
+    close(fd);
+
+    strcpy(g_vnc_ws_socket_path, "/tmp/qemu-vnc-ws.XXXXXX");
+    fd = g_mkstemp(g_vnc_ws_socket_path);
+    g_assert_cmpint(fd, !=, -1);
+    close(fd);
+
+    if (!cleanup_registered) {
+        atexit(cleanup_vnc_sockets);
+        cleanup_registered = true;
+    }
+
+    return g_strdup_printf("-machine q35 -nodefaults "
+                           "-vnc vnc=unix:%s,websocket=unix:%s",
+                           g_vnc_socket_path, g_vnc_ws_socket_path);
+}
+
 const generic_fuzz_config predefined_configs[] = {
     {
         .name = "virtio-net-pci-slirp",
@@ -247,6 +293,10 @@ const generic_fuzz_config predefined_configs[] = {
         .args = "-machine q35 -nodefaults "
         "-parallel file:/dev/null",
         .objects = "parallel*",
+    },{
+        .name = "vnc",
+        .argfunc = generic_fuzzer_vnc_args,
+        .objects = "*",
     }
 };
 
-- 
2.51.2.1041.gc1ab5b90ca-goog


