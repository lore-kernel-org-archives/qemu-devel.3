Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A471AC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woj21-0004LG-Lm; Tue, 28 Jul 2026 10:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1woj1u-0004JW-VL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:43:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1woj1r-0001jK-DD
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:43:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so42402765e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785249814; x=1785854614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wCtAzg51hhstS+Gbl8wuHsxX6KoJDd8QSjWjrDQlyaQ=;
 b=dMGz1fvZKEJLLA5+aJhoTxTXB0EMllwovmHRim1CjFUT5HaYSMw69Y9ImMgAIoDoMa
 diN2P8crRliIFFzj83TDDc2vfbg3DupFesxr3KQYsCyh+oS59QSUbITKEMaUOXi4Mhiz
 RuzFMmWAI2jxiqPUtyDjw3Xi0w5Cfyqiqc5jLWRX/42mYUgT2Umzjcg0brCbrwHCIs6q
 Q6zHCknLXFs+CyMfXwXyz0bJxZlKspCz4cXykmWN4ESocUA6pgrlBhNq5cTdbFPAQxln
 hvCyuNhugyXVzkqT+yReIudeX/efYv3T5aUhWhiyP+p9sPchUc0qVtcOmDTxyO9OsJoF
 azWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785249814; x=1785854614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wCtAzg51hhstS+Gbl8wuHsxX6KoJDd8QSjWjrDQlyaQ=;
 b=P9PcAb+J8Y8Qw5HqSsVDiS03/09p8SRoFJrshr8PUJFuTrzNcce/FNyJBZkHLDtPoY
 9agt/50755A3I089fkmFe2M4Fl3kT2MiVVkcXnOUA3E+Bv5FgcYh/5Ok/kqL+lNvJytt
 cdtYTBfGOtaj5LaoUyI5TU2b5OzE9f+MD6C+kx3+WfGK0FyXgR8DrslpXdoxgzr+cDCY
 +gir7HVgTop9VflP4GeTHB8T04Mf/RVxWb6po3moqbh7Sez2f/wTktxLa7IdAeQUTDkw
 lglQqbOHAGFFhsuWHx6vATwCldyN1yx8alVwJir2+slh+6ybxI4eb0oYMfvcV1xuj2bO
 gHEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLc3i8UgTCqrftj36602BMFSu12jHSrijNHR1m0xdBJwQCGx0nJtaljjRzA71bCgA2JIY4cSahU+yZ@nongnu.org
X-Gm-Message-State: AOJu0Yx+ywdc4pBn+PLGkujqxkieht8gbo0T5Rn89E/CitYMS5opGuaB
 W6PpB8U4IS5z+cwACIxpVMBgdv6m9DlOJXdqDxsaM6VH9k7AVQlBYy3L
X-Gm-Gg: AR+sD11aoAgVOe30E0hzAUGul37RUgzmWAhAX9SdGK0g8wzFVxRU80r3yS4IXKH6bma
 Em7AS1cVf5yvnI6EECcYPcY0ZLn8rVPKfG2jEPPeaZ+WfWFJRSbS8TnNpq7ZNxZ+Ak/FCqn7TKN
 rQskPTlAoJnQ+AJrFQ14qUiYcd2CuXyZ7yuv7KLzMt1qKcKxvJ5Elex7WBTJnSfJHfFszEnQakB
 t1YngBNKDq32Y+GWi8iR0bAdMfwIxu9nay6gzAnYOutDNuP+Wdie1pfLpa3kmbAGHuDAx0qoPAA
 Gr9TJa69JfmDYVdm24V+3MY4QQfQsR3ur44h2xnzqnENueH+wHX5ORKSsgXvfB8yUPbIZ3BNM1H
 wniJBw41IWx4wyt9buevu8G6fsvTEnilGPR0TswXsQZ86MbW49MAJ1TuXeU8JIsQhb2hR+GjBAa
 8VugDv3l0X0NOrb1Qn3ehQJB5Zsfyve5LZCn0JiqJt6TIp2gQ7hh2QeZ/IbMTV8zTvcH9gVjg9+
 AReGrYZwaZxBUS9BOwu38hWtLoB7ho9hts1ETl1VaJx+an83uY=
X-Received: by 2002:a05:600c:638f:b0:496:bba5:33a9 with SMTP id
 5b1f17b1804b1-496c658ef41mr31120935e9.34.1785249813521; 
 Tue, 28 Jul 2026 07:43:33 -0700 (PDT)
Received: from ip-172-31-13-20.eu-central-1.compute.internal
 (ec2-18-198-207-175.eu-central-1.compute.amazonaws.com. [18.198.207.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c444304esm80724215e9.0.2026.07.28.07.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 07:43:33 -0700 (PDT)
From: Rohitashv Kumar <rohit.kuma1313@gmail.com>
To: Jason Wang <jasowangio@gmail.com>,
	qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Rohitashv Kumar <roohiit@amazon.de>
Subject: [PATCH] qapi/net: gate user/vde/netmap netdev backends behind their
 CONFIG symbols
Date: Tue, 28 Jul 2026 14:43:03 +0000
Message-ID: <20260728144303.223207-1-rohit.kuma1313@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=rohit.kuma1313@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Rohitashv Kumar <roohiit@amazon.de>

Their NetClientDriver enum members and Netdev union branches were
unconditional, so query-qmp-schema advertised them even when built without
CONFIG_SLIRP/CONFIG_VDE/CONFIG_NETMAP. Gate them, and guard the matching
NET_CLIENT_DRIVER_USER/_VDE case labels in net/hub.c.

Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
---
 net/hub.c     |  4 ++++
 qapi/net.json | 19 +++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/hub.c b/net/hub.c
index ee5881f6d5..2a7c2bc6d7 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -294,12 +294,16 @@ void net_hub_check_clients(void)
 #ifdef CONFIG_PASST
             case NET_CLIENT_DRIVER_PASST:
 #endif
+#ifdef CONFIG_SLIRP
             case NET_CLIENT_DRIVER_USER:
+#endif
             case NET_CLIENT_DRIVER_TAP:
             case NET_CLIENT_DRIVER_SOCKET:
             case NET_CLIENT_DRIVER_STREAM:
             case NET_CLIENT_DRIVER_DGRAM:
+#ifdef CONFIG_VDE
             case NET_CLIENT_DRIVER_VDE:
+#endif
             case NET_CLIENT_DRIVER_VHOST_USER:
                 has_host_dev = 1;
                 break;
diff --git a/qapi/net.json b/qapi/net.json
index 1a6382825c..e9f1300629 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -922,9 +922,13 @@
 # Since: 2.7
 ##
 { 'enum': 'NetClientDriver',
-  'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'stream',
-            'dgram', 'vde', 'bridge', 'hubport', 'netmap', 'vhost-user',
-            'vhost-vdpa',
+  'data': [ 'none', 'nic',
+            { 'name': 'user', 'if': 'CONFIG_SLIRP' },
+            'tap', 'l2tpv3', 'socket', 'stream', 'dgram',
+            { 'name': 'vde', 'if': 'CONFIG_VDE' },
+            'bridge', 'hubport',
+            { 'name': 'netmap', 'if': 'CONFIG_NETMAP' },
+            'vhost-user', 'vhost-vdpa',
             { 'name': 'passt', 'if': 'CONFIG_PASST' },
             { 'name': 'af-xdp', 'if': 'CONFIG_AF_XDP' },
             { 'name': 'vmnet-host', 'if': 'CONFIG_VMNET' },
@@ -949,16 +953,19 @@
     'nic':      'NetLegacyNicOptions',
     'passt':    { 'type': 'NetdevPasstOptions',
                   'if': 'CONFIG_PASST' },
-    'user':     'NetdevUserOptions',
+    'user':     { 'type': 'NetdevUserOptions',
+                  'if': 'CONFIG_SLIRP' },
     'tap':      'NetdevTapOptions',
     'l2tpv3':   'NetdevL2TPv3Options',
     'socket':   'NetdevSocketOptions',
     'stream':   'NetdevStreamOptions',
     'dgram':    'NetdevDgramOptions',
-    'vde':      'NetdevVdeOptions',
+    'vde':      { 'type': 'NetdevVdeOptions',
+                  'if': 'CONFIG_VDE' },
     'bridge':   'NetdevBridgeOptions',
     'hubport':  'NetdevHubPortOptions',
-    'netmap':   'NetdevNetmapOptions',
+    'netmap':   { 'type': 'NetdevNetmapOptions',
+                  'if': 'CONFIG_NETMAP' },
     'af-xdp':   { 'type': 'NetdevAFXDPOptions',
                   'if': 'CONFIG_AF_XDP' },
     'vhost-user': 'NetdevVhostUserOptions',
-- 
2.50.1


