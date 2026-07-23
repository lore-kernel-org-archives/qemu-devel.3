Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F5AC531D1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn1wU-0004cZ-4Q; Thu, 23 Jul 2026 18:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wR-0004Z5-R5
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:00 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wQ-0001Qm-8e
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:30:59 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-80c5cb9a888so8517987b3.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845857; x=1785450657; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RRQE/saYJaaESTpo7p1Xp5FIXQbHxoLdzskT04Eqn0k=;
 b=gzl5LaV9yA7687TEQpsBYeyM6sS/UAEcPF7+agjykjzV3NPH+mHwDNurVPZmwzTL2J
 Qz4hvJ3xlOU5A/mv28eUdmyABUqc+FJvNfjWlmVQLV/2yGIQ4/TUz21nDJysmEfvpoCO
 oPxQiPVGms3nVtog0uOTx2Itg9jDOaHksEI/g95Salhq0r8XwhSRUcy38fd4J3sDHE2s
 JYCi5//IC7PeVl39/sR1tzrBVM3YXeagbg2pKzKeheqOmsPJnEgLZQtyNpQIw8Qnc+ZP
 X+J1dpvbPnDdCzVBl7EBLBb2mVp0DOo9MnT91RG+eKJqa17hIvw0bVG8fgEtc+ICM86N
 XtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845857; x=1785450657;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RRQE/saYJaaESTpo7p1Xp5FIXQbHxoLdzskT04Eqn0k=;
 b=kokchDB3cdYzKfn6Kil/MhJDPH+Ec0lCNSJSMQmZrRgerd+kQWXq+a93dxceJk/laJ
 vXpUa8pKL2hTP00ghRg1Khwdp3M3MJ1xwi2IW995Q924qXqlQBHvRDtmd4RgAQFaHAvf
 PiI9Y4NjC5FUfLyGiZGw3v5Sutastcz2M5B5BRUsEtADjybSf2r6SY/34ycOQ7wbE2Ff
 k6tfHqMnhgzhE4khJxnZZ6DssbWDJ76upEN98Owe9z1uyAu8mhB1J3Bb40baBwNaQlC6
 bzfWJhlWkbGpJ6ayrd2gIH80y8qWsBPsoc5JzVpfs4oVmDLNxv6zwJMWDKlbw0xhR2jr
 aC2w==
X-Gm-Message-State: AOJu0YwTU3bQ1boDlw9RZcm63a7p0R7r9JTxyXBA28WrZCWSfCnTTv57
 ezg3V+PoG/rG1TNcKuitMAKkMpAxe7lMG79b31a1V2XiOBWiVScHSXht
X-Gm-Gg: AR+sD12hwf9rsmwHhL/lE/Xpcv9xq5CIS5DkEMVX0B2zQb4OPGTArxgh0GTp/q3Y/bI
 xm2TTg2RT1NMY4bwV/GZ75owPl9a1rSzB4ZzO/LUgxqBBAz4f7VATcIcBHUCzd8nD70SkEXaHJQ
 2KtpjBY/QfQdkZBS3dIaq1EhcLEP6lyP6z90AD6BtCL/JIfw9O5DrwueiQaD5x7nz+S0T3z830k
 UeQ3gY3tYo+gBlvyU9aD8XqGA7H6OL3p9Grh3td1X5wt+se/VtnNxHekngrSjaCUcrmZGn4A2RT
 xsKJuhu7B+QxGjhlFTE0Ky3Z2kbuPhV+m5X48qIym4HHdzWPtVAlD9Cy07FBXHtlmyS0FA5/Jv0
 OBt9ZnZSocSn/knCdkHZm0Epk1/tbZ3i3rvG2qAL3SHcr4Aq0cMfbFKD9kJ0HcsmHTxnBMcEZTa
 f70UMxayc=
X-Received: by 2002:a05:690c:3182:b0:81e:782b:72dd with SMTP id
 00721157ae682-81f4c13eca6mr16234977b3.13.1784845857145; 
 Thu, 23 Jul 2026 15:30:57 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:446f:49ff:37bd:d45a])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33c3c1c5sm35766777b3.17.2026.07.23.15.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 15:30:56 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 23 Jul 2026 15:30:03 -0700
Subject: [PATCH RFC 04/15] net/vhost-user: add memory isolation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-vhost-user-isolated-memory-v1-4-6b97c439eb28@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784845839; l=3194;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=kCaV9zgYB27gebvzRUkQdZHWZmFFifXRqsrHtdiCBbU=;
 b=0rwPPZPPdLUldxXIPlmWzZZKsluRInnn0dnYpM4AJ/dOhHa4yxaSxJ4BSpQYjWCEEu9du1NIy
 NSRYlfAYsUBD2crLSqh5DlOL9rL4m+ACeFxCaFF7hB2iYgq71VY6upj
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=connorkite@gmail.com; helo=mail-yw1-x1129.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a memory-isolation property to NetdevPassOptions and
NetDevVhostUserOptions in net.json.  This property will
be used for vhost-user devices to disable access to guest
memory from devices.

It will be passed into vhost_user_init() in a future patch.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 net/passt.c      |  7 +++++++
 net/vhost-user.c |  4 ++++
 qapi/net.json    | 15 +++++++++++----
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/passt.c b/net/passt.c
index 45440c399b..ce80186883 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -735,6 +735,13 @@ int net_init_passt(const Netdev *netdev, const char *name,
     s->pidfile = pidfile;
 
     if (netdev->u.passt.has_vhost_user && netdev->u.passt.vhost_user) {
+        bool memory_isolation G_GNUC_UNUSED = false;
+
+        if (netdev->u.passt.has_memory_isolation &&
+           netdev->u.passt.memory_isolation) {
+            memory_isolation = true;
+        }
+
         if (net_passt_vhost_user_init(s, errp) == -1) {
             qemu_del_net_client(nc);
             return -1;
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 2d0fc49b4d..8fa303f901 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -459,6 +459,7 @@ int net_init_vhost_user(const Netdev *netdev, const char *name,
     int queues;
     const NetdevVhostUserOptions *vhost_user_opts;
     Chardev *chr;
+    bool memory_isolation G_GNUC_UNUSED;
 
     assert(netdev->type == NET_CLIENT_DRIVER_VHOST_USER);
     vhost_user_opts = &netdev->u.vhost_user;
@@ -476,5 +477,8 @@ int net_init_vhost_user(const Netdev *netdev, const char *name,
         return -1;
     }
 
+    memory_isolation = vhost_user_opts->has_memory_isolation ?
+                       vhost_user_opts->memory_isolation : false;
+
     return net_vhost_user_init(peer, "vhost_user", name, chr, queues);
 }
diff --git a/qapi/net.json b/qapi/net.json
index 1a6382825c..4588c7014b 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -213,6 +213,9 @@
 #
 # @param: parameter to pass to passt command
 #
+# @memory-isolation: enable memory isolation.  Only has effect if
+#     using vhost-user.  (default: false)
+#
 # Since: 10.1
 ##
 { 'struct': 'NetdevPasstOptions',
@@ -250,7 +253,8 @@
     '*ipv6':               'bool',
     '*tcp-ports':          ['PasstPortForward'],
     '*udp-ports':          ['PasstPortForward'],
-    '*param':              ['PasstParameter'] },
+    '*param':              ['PasstParameter'],
+    '*memory-isolation':   'bool'},
     'if': 'CONFIG_PASST' }
 
 ##
@@ -685,13 +689,16 @@
 # @queues: number of queues to be created for multiqueue vhost-user
 #     (default: 1) (Since 2.5)
 #
+# @memory-isolation: isolate guest memory from device (default: false)
+#
 # Since: 2.1
 ##
 { 'struct': 'NetdevVhostUserOptions',
   'data': {
-    'chardev':        'str',
-    '*vhostforce':    'bool',
-    '*queues':        'int' } }
+    'chardev':              'str',
+    '*vhostforce':          'bool',
+    '*queues':              'int',
+    '*memory-isolation':    'bool' } }
 
 ##
 # @NetdevVhostVDPAOptions:

-- 
2.43.0


