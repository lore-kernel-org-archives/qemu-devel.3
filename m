Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE06DC38150
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 09:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ1jk-0008Rv-0d; Sat, 06 Jul 2024 05:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQ1jg-0008Pj-Un
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 05:29:42 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQ1jf-0006oz-CN
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 05:29:40 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3d928b2843dso32378b6e.2
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 02:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720258178; x=1720862978;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jiaYdGJdtPWsnfbPGe8XqhPOhb333O5wAJMSGqRo6p4=;
 b=FvcRwOdH+8skz6pW0F2TFm6R/EDBg7WI2160t05D5u4H4+rOlepjqp1eYvjAJ3ewL5
 mO7HBZnugCeNohwAceIAhL61vDG27PwgVBn5Ipqmrerlzx5t18rp8pKspfzoV602BCJc
 x9gJ+ab8V8shk8JzwtEEi8ZvAK6OnBomY8+oxiDKRDZdH5lu9qOw7e3DlEYv4wD8Yvha
 DaVbw++vP3obHtu+tkpgOJcoV1RzeFmMlupbPh1aBYDC93IveJ+sH3z6qrhqK6h45jrc
 EUvQ8jLfdd1TxXKJl02Ya5C/Is7KN9cJf0sk5pUiXWywVD7gloTeH2WlRoqr8wA6ku+E
 INmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720258178; x=1720862978;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jiaYdGJdtPWsnfbPGe8XqhPOhb333O5wAJMSGqRo6p4=;
 b=auTfE55RkmMS84sonXWirlC63sr/UE+OlTiLgQNAeOJM0/yJF2jXjh9TKYb7Y9DLYH
 qG8h4JjP9mlraxM3DIybRl8IoUDmoHpzGqm0cpcBNgOmLRyoA72HbNIIkdBMejAEdKG1
 AqmkoqVlHdfPrYf/RjQkSCuMBZ3q65Ta/uA0c53NQy63pu1EzrMs5eVZVyOfXPPZqKTf
 BjBftustfol4CQl2yt3vVuE+uiK4OLXRGaIUPyoTpYXLlHpl92IN6QoROmyWSCK3f3lb
 4yvipr20ppxN+TYIXQjvMQF0qf9iwepEwtfI/JPpsdGFuZs6F+VGEAGGTKW4KCXrKdbB
 lGpg==
X-Gm-Message-State: AOJu0YyzAAgZl3K07G+a83rzGsdPdDQxBjf1De9Hy45jbrz9Fx1JSYx+
 TtdGoOKXhko+qmYfjzvCq4/rUsPlT72t1TH71FSwGMqRUeXMhFux1JsvtcWulNK6GuGAqYuHHAl
 vZ24=
X-Google-Smtp-Source: AGHT+IF9neLvPkPJVUwqJamV3WTms4iS9iN6pwgUA2PkCasSKHD3PtXsqcmsJEyRDzQtLpwRbid1zg==
X-Received: by 2002:a05:6808:19a7:b0:3d6:2fb8:2905 with SMTP id
 5614622812f47-3d914cb4c7amr7416107b6e.42.1720258178266; 
 Sat, 06 Jul 2024 02:29:38 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b01193a96sm4346393b3a.31.2024.07.06.02.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jul 2024 02:29:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 06 Jul 2024 18:29:22 +0900
Subject: [PATCH 2/4] qapi: Do not consume a value when visit_type_enum() fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240706-rombar-v1-2-802daef2aec1@daynix.com>
References: <20240706-rombar-v1-0-802daef2aec1@daynix.com>
In-Reply-To: <20240706-rombar-v1-0-802daef2aec1@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::229;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x229.google.com
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

Consuming a value when visit_type_enum() fails makes it impossible to
reinterpret the value with a different type.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qapi/visitor.h | 5 -----
 qapi/opts-visitor.c    | 5 -----
 qapi/qapi-visit-core.c | 4 +++-
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index b3ae3188edfb..8e841b26428b 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -513,11 +513,6 @@ void visit_set_policy(Visitor *v, CompatPolicy *policy);
  * is an input visitor.
  *
  * Return true on success, false on failure.
- *
- * May call visit_type_str() under the hood, and the enum visit may
- * fail even if the corresponding string visit succeeded; this implies
- * that an input visitor's visit_type_str() must have no unwelcome
- * side effects.
  */
 bool visit_type_enum(Visitor *v, const char *name, int *obj,
                      const QEnumLookup *lookup, Error **errp);
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index e9fad756e189..d83434b95a56 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -359,11 +359,6 @@ opts_type_str(Visitor *v, const char *name, char **obj, bool consume,
         return false;
     }
     *obj = g_strdup(opt->str ? opt->str : "");
-    /* Note that we consume a string even if this is called as part of
-     * an enum visit that later fails because the string is not a
-     * valid enum value; this is harmless because tracking what gets
-     * consumed only matters to visit_end_struct() as the final error
-     * check if there were no other failures during the visit.  */
     if (consume) {
         processed(ov, name);
     }
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 89b52fc99202..1137d472290b 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -411,7 +411,7 @@ static bool input_type_enum(Visitor *v, const char *name, int *obj,
     int64_t value;
     g_autofree char *enum_str = NULL;
 
-    if (!visit_type_str(v, name, &enum_str, errp)) {
+    if (!visit_type_str_preserving(v, name, &enum_str, errp)) {
         return false;
     }
 
@@ -430,6 +430,8 @@ static bool input_type_enum(Visitor *v, const char *name, int *obj,
         return false;
     }
 
+    enum_str = NULL;
+    visit_type_str(v, name, &enum_str, &error_abort);
     *obj = value;
     return true;
 }

-- 
2.45.2


