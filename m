Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B627C3ABA0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 16:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sprrL-0008WG-23; Sun, 15 Sep 2024 12:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexjlzheng@gmail.com>)
 id 1spqdK-0002Ve-Qq
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 10:53:50 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexjlzheng@gmail.com>)
 id 1spqdJ-0002d0-9c
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 10:53:50 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2053a0bd0a6so36369395ad.3
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726412027; x=1727016827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HnRBZVVsLc2RgPkyyuRiMWILDlwwxPSC4bPpaB3I5mw=;
 b=e6xd7z+cB3dR/wwxQUk8QeA86BiW872Rv9tF0/Tb/8GBvIKyoYb8OrnBzZPHkSavCp
 5mjqZI+YF+0wbofDRDDbJlHIqK98J5y8CD2qEtcXdyoN1GyVemET5Q9XCVKDxbNEYcWM
 76aTmpMcfrA0rKCUyOgyi9YJIFddv9C4Ey3brZ39LCkoYVkRmHES3Vc+eT9BSWYP1Bny
 a8gWZbIR0cV/q14dHvYcxfdMbqMarq7yJyeLyN/LSUZlPLtIOUIECRT5jdZlbRQWrhk8
 w0zLo3c/+ew44gxl+oiKq/Vd1swDeQWKYEnXblbCXS+caWnW5kYD56oX7PsUTiLJwoiq
 i0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726412027; x=1727016827;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HnRBZVVsLc2RgPkyyuRiMWILDlwwxPSC4bPpaB3I5mw=;
 b=Pkq98+nCFcW2/+BXTMAxh0IVwFgJnirHgDFIhNxsUxiiCl8H3fHO1O2SSVXtZW0xc/
 nhy/drTTayJVIy23n4iU1JWPKxnOUS4I2uCCtMMp92Jlu4+KKtNOsFNQNsq2AKol4kR5
 W0sX+atEqVZ5OP1iPn+L+JUCEr1+lMIPEBqIHv0VJKxUhvM/XZ6PVM6bLwsAAq4Y5Y7G
 aTRehJACqP5HhUMkmtoBOLtXTye973OZGNVOuKZILlW/fpSF/qCesJGUMvmM0Y6wyO38
 zMglG8CqSwY+YczLN+N7BsJYHNDWvaDr89YKTDi7Lkg7XNP+QgYrRmMaFtyz/47yBiwU
 Fpjw==
X-Gm-Message-State: AOJu0Yzj/k7Sfe4Xl3SkiACJAK9xQiuTLSShfzTUqCrBVj93HiX7+4Yn
 yUC8IaXjVuRKqDfcceFCheuCZ5iWWuRmBjPNk77DWcRc3Hv3wluN
X-Google-Smtp-Source: AGHT+IF0aOiJAlm78Qgt1wrHkVnN8EzE5u8tf7958w0SgWLsqYBYQy+zW8YWGgD6VtIhol5HbA3onw==
X-Received: by 2002:a17:902:e94d:b0:205:5f36:ffa0 with SMTP id
 d9443c01a7336-2076e393a75mr190707485ad.35.1726412027246; 
 Sun, 15 Sep 2024 07:53:47 -0700 (PDT)
Received: from localhost.localdomain ([119.28.17.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207945da80fsm22413005ad.5.2024.09.15.07.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 07:53:46 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: pbonzini@redhat.com,
	berrange@redhat.com,
	eduardo@habkost.net
Cc: qemu-devel@nongnu.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH] qom: fix NULL pointer in object_initialize_with_type()
Date: Sun, 15 Sep 2024 22:53:39 +0800
Message-ID: <20240915145339.1368029-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alexjlzheng@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 15 Sep 2024 12:12:19 -0400
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

From: Jinliang Zheng <alexjlzheng@tencent.com>

Currently, object_initialize_with_type() calls object_class_property_init_all()
before initializing Object->properties. This may cause Object->properties to
still be NULL when we call object_property_add() on Object.

For exmaple, if we extend DEFINE_PROP_ARRAY() to a version with a default value
other than 0:
	#define DEFINE_PROP_ARRAY_EXAMPLE(_name, _state, _field,	\
				_arrayfield, _arrayprop, _arraytype)	\
		DEFINE_PROP((PROP_ARRAY_LEN_PREFIX _name),		\
			_state, _field, qdev_prop_arraylen_virtio_net,	\
			uint32_t,					\
			.set_default = true,				\
			.defval.u = <non-zero>,				\
			.arrayinfo = &(_arrayprop),			\
			.arrayfieldsize = sizeof(_arraytype),		\
			.arrayoffset = offsetof(_state, _arrayfield))
We should have:
	object_initialize_with_type
	  object_class_property_init_all
	    ObjectProperty->init() / object_property_init_defval
	      ...
	        set_prop_arraylen
	          object_property_add
	            object_property_try_add
	              g_hash_table_insert(Object->properties)	<- NULL
	  obj->properties = g_hash_table_new_full()		<- initializing

This patch fixes the above problem by exchanging the order of Ojbect->properties
initialization and object_class_property_init_all().

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 qom/object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 157a45c5f8..734b52f048 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -556,9 +556,9 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
     memset(obj, 0, type->instance_size);
     obj->class = type->class;
     object_ref(obj);
-    object_class_property_init_all(obj);
     obj->properties = g_hash_table_new_full(g_str_hash, g_str_equal,
                                             NULL, object_property_free);
+    object_class_property_init_all(obj);
     object_init_with_type(obj, type);
     object_post_init_with_type(obj, type);
 }
-- 
2.41.1


