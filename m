Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53E9C5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwC8C-0005Rh-5e; Tue, 18 Aug 2026 01:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC8A-0005O7-2B
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:58 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC88-0003r9-BY
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:57 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cbb7926836eso2998608a12.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787029975; x=1787634775; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6J8o1AExw8TA5IVqQ+lEqAQiF7xrSW0tFYRCpllyDsY=;
 b=lnhp3RU/N86Hk+dWTOU2sssIYc2nv2pXQuhLl/q6pDeEgD2s1k94Us5AF08Df0hFwh
 WedBlpvMxZhqPbGrb7Ed3+scU4cT5i4sQUc8megUm9weKN+dujGu290YG+COCK66e5Z7
 f6Cy5dCOHdWxgj/lNvKvdp60oEOhRh8PrJj+YQSRqeRjsuSQm3Ajw53Rzv2GR3Wmw6bm
 Nt4KLIgTXJOWYmtCw41OtNjEzq6qHAbzej7ShK6fR30AQW1XOvnwPrGiIDznN4nOql0Z
 v/yn+yLt1TlQHyeGYGXHWK5Lo4v3FpIFgolJVqWYjB2hXBVZYdrY7qvmT9APyW1W6LVr
 hDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787029975; x=1787634775;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6J8o1AExw8TA5IVqQ+lEqAQiF7xrSW0tFYRCpllyDsY=;
 b=KKGn/zdYUqfiiEqAoELxnGpgBORNJQNxXog7Uva+ODZTobllc2qTJzY5QKFYiXngtq
 9MjXd+uPcBdbSQp2NPdvd6DW44Jw64g8s/8N4zdbLTVCWenh45ltV4fhHoT1XdjLBngw
 l+ZbHKPBdFbxamv29QujjrSAW7hsRN9S+VtR4wBi+ZSQ77aLCCJt8d2RDwQ6FYuKBnW+
 hr1MZU5KY6qDMCUNqN4eLtvvkuJEZ43IDCXqf+C9g8GZNP7WjQrFkFzhz2c3fGhJxiSN
 MMa7nmzXHgW654iPDN1b7uIORqOjXgEcOyFroSYVnke5KaohOc/CAWEJGS/f8o8p62sR
 iPxQ==
X-Gm-Message-State: AOJu0YwNLaRgZQFS4BRccJ3WhNGzYIergLRuI2p5573+ixs0iBgE2KY+
 xOH3tagS6xOXXhjkfZ350pT0Y2Dd8r3octRRe9kOh3W5Oh8HVdvpdNv3
X-Gm-Gg: AR+sD13PO0yzUeIksNItB6oPpqla+QhroeRgp2BppMdhAjfxNqcz4Ok0AtDRnJlyWUM
 SWUveSPcnN82AioWVJemqDygOWnNBCZD9dO/HSOmKt8kMC6nLwzvVoHJsYdu4pGEz1gzs5Ck+CI
 CsyGRkwoKZDwbP1C+A/RHRLyubliJ0dJ/abJzd2Eet2vbv1jtqz7cX3H9ybnQ4+cATfLBxzB+J4
 xVW/g6bBNySJRCSi4oSZnSv4TuCIPwqy7xd/1NWPEogRNeFEBRHLk2SQnWFPhSCMNoE+jqMncLe
 LZdgDgY8wv4jIt29s6fdWdxyvZb8lYz2bzMnTtzpx/goPdXz2VTbiRfK4Hx8igbNP6DZS0mXUrJ
 LPaaLrG3QWhGr3GjTHfvxvkHKBltpO34i0SU7lfNkHzjWALweqVNH0cMthhiy8Va05kph3NbUWd
 HxYpdjTk3fY7spGn4SfZUsWoqxIdTk+8jMsm8z3HMLgC3bq2nhkzYzAXA2ULgedndhs8g=
X-Received: by 2002:a05:6a00:950f:b0:84c:4b58:2cec with SMTP id
 d2e1a72fcca58-84fde3dcf0amr31788880b3a.15.1787029974889; 
 Mon, 17 Aug 2026 22:12:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:d043:a40d:25c1:432c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1031160b3a.43.2026.08.17.22.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 22:12:54 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 17 Aug 2026 22:12:28 -0700
Subject: [PATCH RFC v2 13/13] net/vhost-user: add memory isolation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-vhost-user-isolated-memory-v2-13-948aae960abb@gmail.com>
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
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
 Connor Kite <connorkite@gmail.com>, 
 20260817233147.2867623-1-connorkite@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787029936; l=2866;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=c1m9/46t7T/yFXDXSgz1vdQxYZX3+5KvcmxIw/DGGZM=;
 b=0OBe+eR1e1pPM+zCBkIkB6miAajDaB38ytMDFbdnB9eJvtfYmOO9BXrKbFt1bsCkL8dbpqiAh
 mlqwoGnl/VzARSTOyl20AImpQij7EOtVhDZS+xLZvgRjJACXJyRYvKI
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=connorkite@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
memory from vhost-user backends.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 net/passt.c      |  5 +++++
 net/vhost-user.c |  3 +++
 qapi/net.json    | 16 ++++++++++++----
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/net/passt.c b/net/passt.c
index 35ec6ad6de..7bcd47ad32 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -741,6 +741,11 @@ int net_init_passt(const Netdev *netdev, const char *name,
     if (netdev->u.passt.has_vhost_user && netdev->u.passt.vhost_user) {
         bool memory_isolation = false;
 
+        if (netdev->u.passt.has_memory_isolation &&
+            netdev->u.passt.memory_isolation) {
+            memory_isolation = true;
+        }
+
         if (net_passt_vhost_user_init(s, memory_isolation, errp) == -1) {
             qemu_del_net_client(nc);
             return -1;
diff --git a/net/vhost-user.c b/net/vhost-user.c
index b6ee9ed297..bd33decadf 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -477,6 +477,9 @@ int net_init_vhost_user(const Netdev *netdev, const char *name,
         return -1;
     }
 
+    memory_isolation = vhost_user_opts->has_memory_isolation ?
+                       vhost_user_opts->memory_isolation : false;
+
     return net_vhost_user_init(peer, "vhost_user", name, chr, queues,
                                memory_isolation);
 }
diff --git a/qapi/net.json b/qapi/net.json
index 1a6382825c..add7cb5408 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -213,6 +213,9 @@
 #
 # @param: parameter to pass to passt command
 #
+# @memory-isolation: isolate guest memory from vhost-user back-end
+#     (default: false) (Since 11.2)
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
@@ -685,13 +689,17 @@
 # @queues: number of queues to be created for multiqueue vhost-user
 #     (default: 1) (Since 2.5)
 #
+# @memory-isolation: isolate guest memory from vhost-user back-end
+#     (default: false) (Since 11.2)
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


