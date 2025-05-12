Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E587C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPtB-0002cC-7F; Mon, 12 May 2025 05:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPsC-0001jY-FX
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPsA-0000nq-H8
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxOoNxhd5stUGLfgJ3v0gRchSts8AHfkfMqBe6/lwIg=;
 b=frJgqVVppyTw0QriDcMOpNhe82q/WK1JtkX0E6DFnEiFy9g0rjrlSO44fc2cFynD0xQl1T
 /SahPM3DR48FUr3JSIwqVdAu3b1UAyEZVINxJHn+1F2tmIV3EolZel6EwLz/1RFCXJZOYT
 zhnnCQCEocGwDjIFTuqlzTHlot4o3OY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-Zsdi47OEPLGXkEzHhGmULA-1; Mon, 12 May 2025 05:54:55 -0400
X-MC-Unique: Zsdi47OEPLGXkEzHhGmULA-1
X-Mimecast-MFC-AGG-ID: Zsdi47OEPLGXkEzHhGmULA_1747043694
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac79e4764e5so378361066b.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043693; x=1747648493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YxOoNxhd5stUGLfgJ3v0gRchSts8AHfkfMqBe6/lwIg=;
 b=t8YEl+VH2D9kk3C6Ql4DzOngPGcvCNF9FhQicO+04oDDONnSDqtUfQFFWcJgk26vbP
 jrnVFAIbVw7I8e2jZ4cjD5KPiRCKecYswFfB/Yfr0jn4yExQYmv58mRI1pSNVU1RYDwP
 PYGLhuBx1+PZVPOLHVznxAEHx6EncQ/W4I1biBKX/PAEPqeKZdFTiOcx5xePimew1E6R
 zavI205iDd98U6Wt/r+2xRLqw4RkN+0qNj1osdN4WVkaF+feZSN7OIk7KCcfZ/Ev2mMT
 3rqniXc4mgimyUvAg4stkYGDXhLKjPWrvclb+KybdK5fro3WqIVfoXuvupyc9lX5WsTr
 GB/w==
X-Gm-Message-State: AOJu0Yxt0IRlzqA6bwoyqoXjNQ8rqXCYvGz51famD5oC1d5B7xmhrIwA
 9nwP4yIKCOYCEScJsGMJiv3Xc2wm6ZVY6U6fzys1j8CUN6IGrHQtOHllcsxYH2XFydzoRq8MZxd
 0ArEZ2L5K8CAZYUIyt5Xvly6HM6YfGTtxGj+GGHY1YX/OBh6l/br6mjPdoaRAXR6tGS4zG35cTS
 MjwyZ0UTk3/gaufJjqX5YD6uoHTs4T0M4ECN3I
X-Gm-Gg: ASbGnctsxzNScCyyt0DA7Tf4QjUprJQBUrxWzUmWxoTvZlnsiuif9aqxvzU/lus/7w7
 kauwrhjJXdVNadIPut7Zd7ZezeRO3jzaZCGYiJGj30XyHAqsqjZrnfi9IIqbEGMd1TRCZFi7+8z
 2KxbbdDsCZunAc5ETUM6VUaHTpg8S/RCxcYtGJH2jYad6tVUtPB8MImSfakrVcI0L6qrtlGYjZp
 JwfHBG2VPQH6KUr7NTSRevO6iFzs6B1JYKVZxsjxBHWHmzdR+QMIUq/O4yv5AUErtzSR3N0qqCE
 r8ROah4wb5hSJYCFIu4V7RUT4bC9hzuTk+DxJYWPS5Dtgec=
X-Received: by 2002:a17:906:750:b0:ad2:2146:3b89 with SMTP id
 a640c23a62f3a-ad2214645f4mr821381466b.47.1747043693406; 
 Mon, 12 May 2025 02:54:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9WeTl0Gkn0vveJ0D04fLBB8/zrDyh9Bi5wsxbGoAQOCBlb1P8dQXVGM/BEKzew6RFxUIdVQ==
X-Received: by 2002:a17:906:750:b0:ad2:2146:3b89 with SMTP id
 a640c23a62f3a-ad2214645f4mr821378566b.47.1747043692888; 
 Mon, 12 May 2025 02:54:52 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad22fccc23esm433202866b.4.2025.05.12.02.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:54:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 26/26] qom: reverse order of instance_post_init calls
Date: Mon, 12 May 2025 11:52:26 +0200
Message-ID: <20250512095226.93621-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, the instance_post_init calls are performed from the leaf
class and all the way up to Object.  This is incorrect because the
leaf class cannot observe property values applied by the superclasses;
for example, a compat property will be set on a device *after*
the class's post_init callback has run.

In particular this makes it impossible for implementations of
accel_cpu_instance_init() to operate based on the actual values of
the properties, though it seems that cxl_dsp_instance_post_init and
rp_instance_post_init might have similar issues.

Follow instead the same order as instance_init, starting with Object
and running the child class's instance_post_init after the parent.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 3 ++-
 qom/object.c         | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 1d5b0337242..26df6137b91 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -445,7 +445,8 @@ struct Object
  *   class will have already been initialized so the type is only responsible
  *   for initializing its own members.
  * @instance_post_init: This function is called to finish initialization of
- *   an object, after all @instance_init functions were called.
+ *   an object, after all @instance_init functions were called, as well as
+ *   @instance_post_init functions for the parent classes.
  * @instance_finalize: This function is called during object destruction.  This
  *   is called before the parent @instance_finalize function has been called.
  *   An object should only free the members that are unique to its type in this
diff --git a/qom/object.c b/qom/object.c
index 664f0f24ae8..c819136eecb 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -431,13 +431,13 @@ static void object_init_with_type(Object *obj, TypeImpl *ti)
 
 static void object_post_init_with_type(Object *obj, TypeImpl *ti)
 {
-    if (ti->instance_post_init) {
-        ti->instance_post_init(obj);
-    }
-
     if (type_has_parent(ti)) {
         object_post_init_with_type(obj, type_get_parent(ti));
     }
+
+    if (ti->instance_post_init) {
+        ti->instance_post_init(obj);
+    }
 }
 
 bool object_apply_global_props(Object *obj, const GPtrArray *props,
-- 
2.49.0


