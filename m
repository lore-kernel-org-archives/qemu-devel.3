Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F833C3DA42
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 05:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSrVz-00078i-6j; Sun, 14 Jul 2024 01:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSrVy-00074f-4O
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 01:11:14 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSrVw-00051R-Iy
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 01:11:13 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70af5fbf0d5so2030798b3a.1
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2024 22:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720933871; x=1721538671;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NMhK6uTuK57+JHZcNgmphmlNuH9qRfUm5a2X1fq84kE=;
 b=GSydNIGoNYgC6UkhEVbRefSqx2+noEV5uh5yTGXrUxGXvZBAqUiRcAVtPyKaOs4wxC
 fLmmusNVYM+eRKsfN56IVCFAAAjGHCyPqt/6hxSoOMcAewVPsMeWY1rFaUex7qqVAuxv
 p1awfs9wU/APW4Fr17DqrGi6Ubx+FpPgbMUsUEwPCllq9hfHwkZr2lITMTsFr1DEBHGR
 /qAJhDaN+4NKZXG0CzA7kPQBIpFiNk+z7t8Bn9QpS5UZrnT0AtLGi60Nlla7P4fwY0E/
 C8xW/0u/xIA1diO0L8FThKeqoM3DT23FDoo4QKcj0Uldiqyk8o0QI/dJijEdPGYf6xH5
 kSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720933871; x=1721538671;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NMhK6uTuK57+JHZcNgmphmlNuH9qRfUm5a2X1fq84kE=;
 b=eag8aTJfznlwYWMUt3T1vo51Ncvml8lOs9rWWEum7bQBA2nqS4mhgYBbU3CSo+iFLr
 7dCNXYEsCfHuy/7ekkId/RTBQk5befbVObKQA0ji8xvVDqT7EWzX94g2hxaU7VyVresS
 /yhio84UswpOri40UuQe4ShiVy9XnmVAu++nNSJqoaK7UkVAL8dgoQkbIlSy999mz28O
 Ai1FLTfSTci+Fir92vRnagdz9Pg0ksIbYxOmmAp6NG2h1Bcxzvly6uD+QWln1QbYFls3
 j32NFzLvnai3yort+zOmqVJTCrxGWWumAigZgL2TV9XuoyJ3wO8n6CQLFvlYOEp7Zxcs
 GAbg==
X-Gm-Message-State: AOJu0YwNPkYe5+l8Wn1yEKse28jcC9EZBQaOnh+odm2suAYClOlDwQxP
 u9HQ7ySus6QQZxUHBimuTbnPhCqACUtiNXLyhVeG1JhI4daQxo86+tK/lUvm7jI=
X-Google-Smtp-Source: AGHT+IHAo03g0sPpBc4/5So4xvFiCA2GnIm/aTyr3gHmheaswAE6OV8f6hrDjQQX3VNfH2b9gqySRw==
X-Received: by 2002:a05:6a00:391e:b0:70b:5368:a212 with SMTP id
 d2e1a72fcca58-70b6cbb6c93mr10562067b3a.15.1720933871243; 
 Sat, 13 Jul 2024 22:11:11 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b7eba4540sm1988789b3a.43.2024.07.13.22.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Jul 2024 22:11:10 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 14 Jul 2024 14:11:01 +0900
Subject: [PATCH v3 1/5] qdev-properties: Accept bool for OnOffAuto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240714-auto-v3-1-e27401aabab3@daynix.com>
References: <20240714-auto-v3-0-e27401aabab3@daynix.com>
In-Reply-To: <20240714-auto-v3-0-e27401aabab3@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Accept bool literals for OnOffAuto properties for consistency with bool
properties.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/core/qdev-properties.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 86a583574dd0..f0a270bb4f61 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -491,6 +491,21 @@ const PropertyInfo qdev_prop_string = {
     .set   = set_string,
 };
 
+static void set_on_off_auto(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    int *ptr = object_field_prop_ptr(obj, prop);
+    bool value;
+
+    if (visit_type_bool(v, name, &value, NULL)) {
+        *ptr = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+        return;
+    }
+
+    qdev_propinfo_set_enum(obj, v, name, opaque, errp);
+}
+
 /* --- on/off/auto --- */
 
 const PropertyInfo qdev_prop_on_off_auto = {
@@ -498,7 +513,7 @@ const PropertyInfo qdev_prop_on_off_auto = {
     .description = "on/off/auto",
     .enum_table = &OnOffAuto_lookup,
     .get = qdev_propinfo_get_enum,
-    .set = qdev_propinfo_set_enum,
+    .set = set_on_off_auto,
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 

-- 
2.45.2


