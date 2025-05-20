Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0596DC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKp1-0003K0-0x; Tue, 20 May 2025 07:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKoE-00027Y-B8
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKoC-0003Qk-HG
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W6c7Gh9zf4CyzFRI/lQnZmHEbdkuz1V05X93m00FYA0=;
 b=G775hOV9GHrrJImkLAFQckofDgz/90qyUn/poEmVocrIdvKI5VQzYuNPLMvLOIFCSf0SFW
 3iEbhQv2xTD3FnjDJ438IagdJRd0wCnlFIRCnz2t86GXzJCQcNFwRQqAZzOQ1XSX7e1pVe
 zU2f5eYEFP7FaqKsVUuWqNKZt9tXFGc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-fiPXIFSfOjSxwy7YdEuWvw-1; Tue, 20 May 2025 07:06:54 -0400
X-MC-Unique: fiPXIFSfOjSxwy7YdEuWvw-1
X-Mimecast-MFC-AGG-ID: fiPXIFSfOjSxwy7YdEuWvw_1747739212
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad53aaae592so422557466b.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739211; x=1748344011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W6c7Gh9zf4CyzFRI/lQnZmHEbdkuz1V05X93m00FYA0=;
 b=RyYB+i0jGBKFuvbFtVeac6lVXswQ15O2TQ5wZyFNI49x4+SEx4Ne0ih/Z0PrQ/yWDa
 /Fnh5srGKtu8+k9x17zITWODx/nqKJ5EvWJYS5CRTYOZz2t0upoX5/wNWB9pE8TJ0vXA
 UNTGXK7pDJEu/Q/hlP+8b8AH3mtQ7hOu+BXoYE3XN/Df+A8ZzKEJQYgymg/aYZXMxAHy
 nTDyLajk1gNCuTBj8s2Q/BHex6vNhIaJ1oIb6kdAGqjlepihk46K2O+CmPdWAuew2BNs
 Bz4PuMpyCFx/ttVzjl6dyVrO0YmDSkVV7LIlJ4xtkoSrE7oyPcN+whvdgS+SopLcS3ug
 LA0Q==
X-Gm-Message-State: AOJu0YwRlM8HEUzXSX8nFEOPyONTz41V5oBqqOzILbu8RcMNo3PaN7k7
 lZkWQLkfYBH+9ZCUA6pSH+bj92o4GgwOJJu9l6g33zkGuIiAV2S+FNTskZiEV9OwrzPsYw0OyqL
 P7XU2X7ooHGbuDb8FS42dJjVt16/N/VNg5WFIe9UKOeLNqMijYNz+Qw9uOwX1e9v/QGnQsr2S8u
 0rconqzWQx9fe0Nxld1HmcqAMD+Mn2KomSr8/yRfgS
X-Gm-Gg: ASbGncuqmqIPmtyQPlo2KuNncul5JHZzBKa6Pv4ZbbpW2V9cBYd320yPv7SeXZq8qkQ
 IUtLucXu60KGLE67397cnLovyr/AwU4cJ4AKHrpzUtqYra9gqREa3BIpKbtOqM18AVF/2ohk+m9
 0kXXjJfY7c6LKtiPwHh+PT4CZ+4KIijf3d4PesHfXd/i1o+kCgu5syc2juyiTomzkMSfnDARJnp
 6pKqGYwLV5IhJGmaABdRcRc6u+QI98P6WVjkjtCWxYUPtOhOcirjGIfJtNZxkWdkNfoxJRcWZkL
 +I5+PmouMd/9Uw==
X-Received: by 2002:a17:907:9412:b0:ad5:69e7:181e with SMTP id
 a640c23a62f3a-ad569e71f30mr561319566b.61.1747739210991; 
 Tue, 20 May 2025 04:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6oKRQuB0egJSplQuA7Um/O8LL+NPNaI/1AD4GjYy+RWZp1O3sYm/Auw9nAOER1sn/3orCkA==
X-Received: by 2002:a17:907:9412:b0:ad5:69e7:181e with SMTP id
 a640c23a62f3a-ad569e71f30mr561317566b.61.1747739210160; 
 Tue, 20 May 2025 04:06:50 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4c516dsm711195166b.154.2025.05.20.04.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 35/35] qom: reverse order of instance_post_init calls
Date: Tue, 20 May 2025 13:05:30 +0200
Message-ID: <20250520110530.366202-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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
index 7b013f40a0c..1856bb36c74 100644
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


