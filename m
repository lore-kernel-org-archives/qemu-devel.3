Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8897AC531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn1wS-0004YU-KE; Thu, 23 Jul 2026 18:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wO-0004Oa-GQ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:30:56 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wM-0001QG-Ty
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:30:56 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7dbcb505578so10172577b3.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 15:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845854; x=1785450654; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dn72UNvpMJmsMe5tRQU7u6qlwqtNn/DM1PthO2EpZ4E=;
 b=ifEoxnG17r485xJldp09YfYpMmugAxhgv628jkRLCcw8Fn+QT4jRlGBR9+DeAJboKN
 xpijI0aWhWsW+SA9LdXkk0wEMAt5uHhjJM2W5ukWi726kWs3ZENhTd7QYgWsWSXv+Tfq
 4kaWd9KG4bsWL9cwXju9DgvjzASUjrF+MQIzYKAFxZlf4SqFc3Yp8WK5NnMHbiJyFfgX
 f9mWGciW35gsfHx1Y/LfQVzhR3HOZgzxcvsMfVV92NVu3Yfo+IGDagmXB9ClFeB3n6y+
 zTg8u1lSk2BrQD2rJi981ZZSgwmT1Y7tB+H0sOS5baOcGqtUVjIyoM+0WoQwRzTcAdEN
 lYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845854; x=1785450654;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dn72UNvpMJmsMe5tRQU7u6qlwqtNn/DM1PthO2EpZ4E=;
 b=p+3BsK6JOOb5TxEc9YFnQCZFtWe0lCQRhd8xg0uyRE72GOhYOzIxZxEUBWI4MO74vB
 UfHGxm2wcdaw4yXP9UGPVSvj9HhSIL/7F0cqAf33edmsmtO1W4W5olrrXehU0nF8Vb4I
 yymZ2BDx0o9CPpASfNqVp/3y+dfa+JO9ghUfscyFG0pDIpA87pa0gqigGVlOgf+cTX5O
 Jn/wBR6fX7clvRoXJKOL/pUhcc5f5Zx6Xi6BcYai7P06KWke/ROryU+9d1KEcWRD/Hiq
 ZxRU8zslgc6w5LpB5FOJ9FZC3c2c5dDzWXAIMCPTgFSy0KRvFJmf5C0ocS2IrGCSkGGc
 TbKw==
X-Gm-Message-State: AOJu0Yw+XT8VON4WcXPtU7bFPwX+Kdz25XULbTbjPPhBMpSd8j/Ag1qE
 sFuDJTlJT7CGhqBmRbdZ5cTpfF6Q8YrSILeAzgxsA3UhPnXRa7Vc7s2X
X-Gm-Gg: AR+sD12KM+6YYdXMhIQqozrHWe5Q55DpvaGm0CurVNIXvC6It9FoLvEkEjv03OfZMFA
 DnA+FNcFWdfYu5QWKyj0AGXJiC92IO1jKGYD0td+PF9OzS+eroOUmEEkdD4FBQl9dJj0YsoA5h3
 siazzx+Cewk2pp5+sxFuJRm5Sj3LZrDRC3XO0o3Yw2ykOT9pgvFgTcBySRdqnUqdER5uvhUHyMI
 M3YnPuQKv6qahT8Wv4yf/SMPZFraG04KTwFGRrNyWd8WSwTKl2u8+GHr1r6YQP/ye85Kja6kjeQ
 HgB2jlrkwzFfB0BxFytI2Zo5R0LPk67eZRYEz+B1AFtSXkjFQyZwvkH1ZBrXkjVD90eqqqSXGSs
 JSsqrjya9tqI40YFs4zgzPm4xM1Hbgy9zYwLqYMRcnzqXJNt3xkjnZ0Od64cSFHsyT/xNSs65e9
 6Mac+DvNY=
X-Received: by 2002:a05:690c:7343:b0:81e:84dd:213b with SMTP id
 00721157ae682-81f4c36f62fmr13959557b3.71.1784845853861; 
 Thu, 23 Jul 2026 15:30:53 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:446f:49ff:37bd:d45a])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33c3c1c5sm35766777b3.17.2026.07.23.15.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 15:30:53 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 23 Jul 2026 15:30:02 -0700
Subject: [PATCH RFC 03/15] backends/cryptodev-vhost-user: add memory
 isolation bool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-vhost-user-isolated-memory-v1-3-6b97c439eb28@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784845839; l=2812;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=u55pm1DDJmv5TyBlbSFATydrnGuQo+DHFoyjUl5G2XI=;
 b=TKXB2eR8dH4lHlo1pG799OEHZtgpI+vA0TcqAB661T4YwOkzPCVblVNFBDayPTk2anqinPips
 qyvcLjbXIxLB5oSrVZfjuyh2gM4AkJZud/hWSQw6WX2d4QaC2o04ymR
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=connorkite@gmail.com; helo=mail-yw1-x1133.google.com
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

Add a memory_isolation property to CryptoDevBackendVhostUser and
add add it as an optional member of CryptodevVhostUserProperties
in qapi.

This is needed to be able to specify memory isolation for
cryptodev-vhost-user objects, and the bool will eventually be
passed to vhost_user_init() in a future patch.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 backends/cryptodev-vhost-user.c | 22 ++++++++++++++++++++++
 qapi/qom.json                   |  6 +++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index cc478d9902..e0547c5d40 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -49,6 +49,7 @@ struct CryptoDevBackendVhostUser {
     CharFrontend chr;
     char *chr_name;
     bool opened;
+    bool memory_isolation;
     CryptoDevBackendVhost *vhost_crypto[MAX_CRYPTO_QUEUE_NUM];
 };
 
@@ -392,6 +393,23 @@ static void cryptodev_vhost_user_finalize(Object *obj)
     g_free(s->chr_name);
 }
 
+static void cryptodev_vhost_user_set_mem_isolation(Object *obj, bool value,
+                                                   Error **errp)
+{
+    CryptoDevBackendVhostUser *s =
+                      CRYPTODEV_BACKEND_VHOST_USER(obj);
+
+    s->memory_isolation = value;
+}
+
+static bool cryptodev_vhost_user_get_mem_isolation(Object *obj, Error **errp)
+{
+    CryptoDevBackendVhostUser *s =
+                      CRYPTODEV_BACKEND_VHOST_USER(obj);
+
+    return s->memory_isolation;
+}
+
 static void
 cryptodev_vhost_user_class_init(ObjectClass *oc, const void *data)
 {
@@ -407,6 +425,10 @@ cryptodev_vhost_user_class_init(ObjectClass *oc, const void *data)
                                   cryptodev_vhost_user_get_chardev,
                                   cryptodev_vhost_user_set_chardev);
 
+    object_class_property_add_bool(oc, "memory-isolation",
+                                   cryptodev_vhost_user_get_mem_isolation,
+                                   cryptodev_vhost_user_set_mem_isolation);
+
 }
 
 static const TypeInfo cryptodev_vhost_user_info = {
diff --git a/qapi/qom.json b/qapi/qom.json
index c55776af7d..d7ca1b4203 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -350,11 +350,15 @@
 # @chardev: the name of a Unix domain socket character device that
 #     connects to the vhost-user server
 #
+# @memory-isolation: disables access from cryptodev to guest memory.
+#     (default: false)
+#
 # Since: 2.12
 ##
 { 'struct': 'CryptodevVhostUserProperties',
   'base': 'CryptodevBackendProperties',
-  'data': { 'chardev': 'str' },
+  'data': { 'chardev': 'str',
+            '*memory-isolation': 'bool' },
   'if': 'CONFIG_VHOST_CRYPTO' }
 
 ##

-- 
2.43.0


