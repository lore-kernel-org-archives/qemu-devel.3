Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8A0C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwcVA-0007tT-53; Wed, 19 Aug 2026 05:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwcV4-0007kz-El
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 05:22:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwcV1-0001vg-F9
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 05:22:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-499ae1c6471so1280245e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 02:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787131338; x=1787736138; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WJwqaddlExuj8k565K3Q7CEWlxwfLdXIcKUzKJqIN0Y=;
 b=VnpmqvK6Rl5A0y3rzKCNGPhImM/jykJROmPZaUmMxDKM+Tpc1aMSjsbkCyNR8FA19C
 XvDaczi9mtbpM8CxJYFqBEyIll8wnvylvv3k0vBrQhdu4z4DPQddvKWpw6DdrxoHZ/px
 18G0JiwLePdbbFqjpWAURMtjrxQ/avwISvB9HPsYFqKMrM1kms7kxksQt4AszS8CtEAW
 ollq9hqGNFvJ/v5LkLHtjs++ftGcMO/oG3mRqqNvCyHCGxtHV7un5aHwCmYLeZiS12UA
 WvTJqoGoQz+zNMyv2bEFoGrQAhA7HncH9WbfMIJhjc8va+ySt8rRYmVgJeQjFuSUBbj1
 LYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787131338; x=1787736138;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WJwqaddlExuj8k565K3Q7CEWlxwfLdXIcKUzKJqIN0Y=;
 b=oXLRtkgHOUViNmEhk3uHEJQ9l4MgUO8oQCRXX5S4IyZM3EhEuL57IPxcFHzdd+Eg1q
 tmpgfhSIf9sqXnYscMSYtcY6yLzyKp8NTyYO9fd92pPPI0VFa4xy4Sdi5LyMsKEykMdf
 jhvy8GxoQCX26+rWTDCTHaHzHCOyGaU35KB7S4rhzj7i/xWSu3wJoCiA/gbvyv9dZNH2
 IKramdYIgt8pGDaj2V3mehdthdL8dM+YtWTb90oRVplfnXJOrmzkdvhuqHjRjK5emJcV
 t55IfPXR8ZJnzlDizl02p8954u40+6EjYXy7ZLDKUkjyFb+6LDQsDXmUOViC7xTvvDcG
 lbSA==
X-Gm-Message-State: AOJu0YyNkepeNaWd6dYIdL+MksYAJFKbtcIO0MuFvVm7TGl0E6yhQpw8
 JTAA7DQ+Y13DDfmKEAFcAmXO0nd682OAKjgo55iPm81qavIe5qdKzFTW5SFYKAJwmnA=
X-Gm-Gg: AR+sD12Lr5nWgIVPKK+oZYp/X/6dT58xFaGeZknBQHgYChy5Awfs9aEN1BUHLRYfFYt
 rgSwBnnC+4cRWIj0V4icdfUL1Kxw7pLPwedHhHmLLKaOIIJ2DuelUKKLdeVXtJ+r8EiLR90vA8Z
 52SIkutSlEJFV+eUV63tJ0w5L7oIH4tzXTwNyNSy+p8r/nlt7SMB9gR1fBTHY1o808bLzifm6in
 MqoQA5AfpRtndbtPVMsKU6KjwrUD2uWk7t0RQ43RtHTX1HGfDB8AVqi3aY0rcDJLiopNwLilRBE
 M0uR2qPe7VMc/SdfhTnNPoOlnWk6iUYFZRzoNULwgtnEH6gfY+jXrF8illsYWB+6AFok5V3tVai
 jeaeQr6jdRuLrEp5mHgTbjOxFwGawta+a2j/Cgz07oXMljRqD8O59n7xeku5sUSw4q2ZfgFcDdT
 obDniA4fvLMXqCXkVh6VSx9lJ+MC9r1ACdAt0E3p+cdvd08F5dyAFU8FiaVCSrtR5mgV36LzM=
X-Received: by 2002:a05:600c:3e0f:b0:499:a79a:694d with SMTP id
 5b1f17b1804b1-499aa155e7dmr61077895e9.4.1787131337958; 
 Wed, 19 Aug 2026 02:22:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111b2sm63713805e9.5.2026.08.19.02.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 02:22:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 688D55F94A;
 Wed, 19 Aug 2026 10:22:14 +0100 (BST)
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 19 Aug 2026 10:22:04 +0100
Subject: [PATCH 4/6] char-fe: implement qemu_chr_fe_backend_name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260819-fixes-for-11-2-v1-4-b7981c2cc371@linaro.org>
References: <20260819-fixes-for-11-2-v1-0-b7981c2cc371@linaro.org>
In-Reply-To: <20260819-fixes-for-11-2-v1-0-b7981c2cc371@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, devel@lists.libvirt.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4652;
 i=alex.bennee@linaro.org; h=from:subject:message-id;
 bh=16o9aOALfN4xkFpmwmkWkdn+kTLD6/M+CAi326lKzSg=;
 b=owEBbQGS/pANAwAKAfvQ2wlanipEAcsmYgBqhXXGvUdFInmClYy9aj06x8dzM9oZUdQQYHyOe
 pWOViXcoSmJATMEAAEKAB0WIQRmha6Z51FnvK/I3zX70NsJWp4qRAUCaoV1xgAKCRD70NsJWp4q
 RBkIB/9d0x7H9ilApVtTUBg2lCgecTkU/tdYtW5ma4ks4mrdMKsQetAmaO2VdVwT3Iull02ZaHJ
 rutM/W0cVyTZZioT43i33OM1ts1VlzFR526ZlqnPx4To5hHL5hVvrAm8YgDLbtS7g3qD9n94GGd
 YU6PVJD1iVA2XvxAPxXnkpDf28ezPhBq8ciHx1nuCJvPGdcwOC3LhU3mleEGCgHGmrgaNHqEpdm
 HfFEa2AUr2mpL+Pousp7qn8Uuvr02dN8lWd7IGtR1s6k7v8T8Y8w9c5HZ8itxgtYc79hoxzSysX
 Qj6VoLc5tjeqy2W0OB9zOZPqyy0//l2e+oxAmW9FxoIxq1eZ
X-Developer-Key: i=alex.bennee@linaro.org; a=openpgp;
 fpr=6685AE99E75167BCAFC8DF35FBD0DB095A9E2A44
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

A number of chardev users where calling qemu_chr_fe_get_driver() which
is discouraged as it blocks backend hotswap. As the pattern is common
and need for the string is transitory add a helper and keep
qemu_chr_fe_get_driver() for those that really need the funkiness of
poking around the backend setup.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260810153503.2652324-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - checkpatch fixes
  - r-b
---
 include/chardev/char-fe.h       | 13 ++++++++++++-
 backends/cryptodev-vhost-user.c |  8 +-------
 backends/rng-egd.c              |  8 +-------
 backends/vhost-user.c           |  8 +-------
 hw/char/imx_serial.c            |  4 ++--
 5 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 5f8a6df17dc..a82894e1d51 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -52,7 +52,8 @@ void qemu_chr_fe_deinit(CharFrontend *c, bool del);
  * associated Chardev.
  * Note: avoid this function as the driver should never be accessed directly,
  *       especially by the frontends that support chardevice hotswap.
- *       Consider qemu_chr_fe_backend_connected() to check for driver existence
+ *       Consider qemu_chr_fe_backend_connected() to check for driver
+ *       existence or qemu_chr_fe_backend_name() if you need the name.
  */
 Chardev *qemu_chr_fe_get_driver(CharFrontend *c);
 
@@ -70,6 +71,16 @@ bool qemu_chr_fe_backend_connected(CharFrontend *c);
  */
 bool qemu_chr_fe_backend_open(CharFrontend *c);
 
+/**
+ * qemu_chr_fe_backend_name:
+ *
+ * Returns: caller freeable string or NULL
+ */
+static inline char *qemu_chr_fe_backend_name(CharFrontend *c)
+{
+    return (c->chr && c->chr->label) ? g_strdup(c->chr->label) : NULL;
+}
+
 /**
  * qemu_chr_fe_set_handlers_full:
  * @c: a CharFrontend
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index cc478d9902d..3334e280a27 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -373,13 +373,7 @@ cryptodev_vhost_user_get_chardev(Object *obj, Error **errp)
 {
     CryptoDevBackendVhostUser *s =
                       CRYPTODEV_BACKEND_VHOST_USER(obj);
-    Chardev *chr = qemu_chr_fe_get_driver(&s->chr);
-
-    if (chr && chr->label) {
-        return g_strdup(chr->label);
-    }
-
-    return NULL;
+    return qemu_chr_fe_backend_name(&s->chr);
 }
 
 static void cryptodev_vhost_user_finalize(Object *obj)
diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index 1d92bd71cf7..c2207f40c5c 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -126,13 +126,7 @@ static void rng_egd_set_chardev(Object *obj, const char *value, Error **errp)
 static char *rng_egd_get_chardev(Object *obj, Error **errp)
 {
     RngEgd *s = RNG_EGD(obj);
-    Chardev *chr = qemu_chr_fe_get_driver(&s->chr);
-
-    if (chr && chr->label) {
-        return g_strdup(chr->label);
-    }
-
-    return NULL;
+    return qemu_chr_fe_backend_name(&s->chr);
 }
 
 static void rng_egd_finalize(Object *obj)
diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index 380d8250233..46dadb74800 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -152,13 +152,7 @@ static void set_chardev(Object *obj, const char *value, Error **errp)
 static char *get_chardev(Object *obj, Error **errp)
 {
     VhostUserBackend *b = VHOST_USER_BACKEND(obj);
-    Chardev *chr = qemu_chr_fe_get_driver(&b->chr);
-
-    if (chr && chr->label) {
-        return g_strdup(chr->label);
-    }
-
-    return NULL;
+    return qemu_chr_fe_backend_name(&b->chr);
 }
 
 static void vhost_user_backend_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index fb41ee2ac50..8ac4efbb5e9 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -278,10 +278,10 @@ static void imx_serial_write(void *opaque, hwaddr offset,
                              uint64_t value, unsigned size)
 {
     IMXSerialState *s = (IMXSerialState *)opaque;
-    Chardev *chr = qemu_chr_fe_get_driver(&s->chr);
+    g_autofree char *label = qemu_chr_fe_backend_name(&s->chr);
     unsigned char ch;
 
-    trace_imx_serial_write(chr ? chr->label : "NODEV", offset, value);
+    trace_imx_serial_write(label ? label : "NODEV", offset, value);
 
     switch (offset >> 2) {
     case 0x10: /* UTXD */

-- 
2.47.3


