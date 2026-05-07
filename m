Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651E9CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11C-0003P6-Qo; Thu, 07 May 2026 11:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL116-0003OO-OQ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL114-0003jn-Q2
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso10530135e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169117; x=1778773917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=refkWTdHWDs8DEZOP5rbn+tFhpxCiAafNNrc4m7bQlE=;
 b=f8bDcUJZgHP99r9eK2UwJ5UmBTdoP/uWPEEH2xQR5crzg//KA7XaMZf1LJgukcX34J
 zkhj7xYxUGJhFkOOZDHfkSOWJpS9kFOEJqJn4Z+8D5YI/9I0/NnmkJuoeKvJ2L+BpGCk
 PNLpM3h5EF8rSfT7vacTjH9M+Rz7fi6KzoW5o0ZWaEQCrcEzXc/v9Av0auD2HO0xadI7
 lnn01YseQ/I7XhgSVZalpgEjcg+lkg1pdMIBswXeM4qLAR3sW94igAcFoTmQJn/VdQap
 AuCxy4rxXJcZIstWIfDojJCoIWjg6dQN3DV4MriFEFXL8G9Lr0GG0h0LnFQTrkqp8+Yn
 SjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169117; x=1778773917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=refkWTdHWDs8DEZOP5rbn+tFhpxCiAafNNrc4m7bQlE=;
 b=mPqVb/KXCmaVKq/dG+4SxUoluGKEUAV9q2+PN3cMlav+1Mlh6GWBSGRF9W2n8TM1i+
 SxBSW88oQ4Pg0CxzqG9rrEHq2vsTELAItWa3z9PzIntVO3j/2IyPBSTxLUh81YeK+L6s
 9UFO4YF4veNWzC5en44TxRAG1wLMlew6hIDGbn5XYXG/7iJIkwiw536m25/UXCBYyXpk
 M1BNH9WH0750pI+ZmiQMNAW1x5pzzFyOV8A9VQEFVFSLp2YhmtrVhLU5a7BoAcp8G39l
 nl5QJHO+MHik17fXpCGvpQZNx3CQZPQR2avgcNuf75zvkzHgdzFYw6V5SRdnZsdKrVsA
 fOgw==
X-Gm-Message-State: AOJu0YxI2Ebjh7kZIy8plQwyvurrEtCRvSwmpS+VfHsjnvnNsPm4hqh/
 Dd8bItaxMCHaPcJhyO1aMWfVMWaaGAdb0rqW6LfLTh4h61DSj7tRupz8D7MwhQUoL7aPymxrB0n
 myzJA
X-Gm-Gg: AeBDiesyfHoUL6Kek35wcBZnxIZ40zBlr1+tlaNWluDdEKJlkfpx4hqiGu6An9/ODpK
 6FPiDVoS9V/1puSQxEC3rgZiBJud9Ch/mBnMU2ZD4C1m9EUI73b2hqu+OWeYS4gUC754f3f8NVe
 PbiEXH4OWerbIf8OTLwjLH+lQYUX5yYZHGjp/DSNqQQ2L91QwtKQ0LiXNyekkOKkHatGimLdB0v
 JnoHlyhzWkR8wCmGvxnWmklPJ2AZ72Gg7ab1XxPyM5BprJ8PdJ4TzVVaFxlkIzpJjdCLpCiHw1J
 QWT08ptCRFzSBRoOuvf1ywdECub6ZLqDp/VLDcSOyeKKGi+fH6U+OJpiXJB4h1+lRAP9TWuwNNJ
 YW25Zr+vXSLMbe9MM0c2D4U0w+n7eyohlMM1JMuuUP6EkOd+GNxrmk3lexMpXnDTS2jo/yIET5g
 2KPkLEGM8Iqs9qr/c1rJ5481lPOjI6solNO3DSNtk0nj/5HkmvMoLBmPUCSWVFgkN4qqZu+vvDk
 xM6b8GS6RNdH5ky
X-Received: by 2002:a05:600c:1f0d:b0:48a:93d2:60d2 with SMTP id
 5b1f17b1804b1-48e51dd9772mr130038515e9.0.1778169116717; 
 Thu, 07 May 2026 08:51:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.51.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:51:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/67] qom/object: Add object_resolve_and_typecheck()
Date: Thu,  7 May 2026 16:50:48 +0100
Message-ID: <20260507155154.1886557-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add a new function object_resolve_and_typecheck(), whose purpose is
to look up the object at a given QOM path, confirm that it is the
expected type, and return it.  This is similar to the existing
object_resolve_path_type(), but it insists on a non-ambiguous path.

We were already using this functionality internally to object.c as
part of the object_resolve_link() function, so this patch implements
the new function by pulling the link-property specific parts out of
the more generic resolve-and-typecheck part.

The motivation for this function is that we want to allow devices to
provide an array of link properties; for that we will need to be able
to provide the expected type of the linked object in a different way
to the single-item link properties.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260327111700.795099-2-peter.maydell@linaro.org
---
 include/qom/object.h | 17 +++++++++++++++++
 qom/object.c         | 41 +++++++++++++++++++++++------------------
 2 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 510885218b..f40d8ccd4a 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1742,6 +1742,23 @@ ObjectProperty *object_class_property_add_link(ObjectClass *oc,
                                             Object *val, Error **errp),
                               ObjectPropertyLinkFlags flags);
 
+/**
+ * object_resolve_and_typecheck:
+ * @path: path to look up
+ * @name: name of property we are resolving for (used only in error messages)
+ * @target_type: QOM type we expect @path to resolve to
+ * @errp: error
+ *
+ * Look up the object at @path and return it. If it does not have the
+ * correct type @target_type, return NULL and set @errp.
+ *
+ * This is similar to object_resolve_path_type(), but it insists on a
+ * non-ambiguous path and it produces error messages that are
+ * specialised to the use case of setting a link property on an object.
+ */
+Object *object_resolve_and_typecheck(const char *path, const char *name,
+                                     const char *target_type, Error **errp);
+
 /**
  * object_property_add_str:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index f981e27044..59fd79738d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1835,26 +1835,12 @@ static void object_get_link_property(Object *obj, Visitor *v,
     }
 }
 
-/*
- * object_resolve_link:
- *
- * Lookup an object and ensure its type matches the link property type.  This
- * is similar to object_resolve_path() except type verification against the
- * link property is performed.
- *
- * Returns: The matched object or NULL on path lookup failures.
- */
-static Object *object_resolve_link(Object *obj, const char *name,
-                                   const char *path, Error **errp)
+Object *object_resolve_and_typecheck(const char *path, const char *name,
+                                     const char *target_type, Error **errp)
 {
-    const char *type;
-    char *target_type;
     bool ambiguous = false;
     Object *target;
 
-    /* Go from link<FOO> to FOO.  */
-    type = object_property_get_type(obj, name, NULL);
-    target_type = g_strndup(&type[5], strlen(type) - 6);
     target = object_resolve_path_type(path, target_type, &ambiguous);
 
     if (ambiguous) {
@@ -1871,11 +1857,30 @@ static Object *object_resolve_link(Object *obj, const char *name,
         }
         target = NULL;
     }
-    g_free(target_type);
-
     return target;
 }
 
+/*
+ * object_resolve_link:
+ *
+ * Lookup an object and ensure its type matches the link property type.  This
+ * is similar to object_resolve_path() except type verification against the
+ * link property is performed.
+ *
+ * Returns: The matched object or NULL on path lookup failures.
+ */
+static Object *object_resolve_link(Object *obj, const char *name,
+                                   const char *path, Error **errp)
+{
+    const char *type;
+    g_autofree char *target_type = NULL;
+
+    /* Go from link<FOO> to FOO.  */
+    type = object_property_get_type(obj, name, NULL);
+    target_type = g_strndup(&type[5], strlen(type) - 6);
+    return object_resolve_and_typecheck(path, name, target_type, errp);
+}
+
 static void object_set_link_property(Object *obj, Visitor *v,
                                      const char *name, void *opaque,
                                      Error **errp)
-- 
2.43.0


