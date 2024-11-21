Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726D3E64006
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECl4-0006Rf-5d; Thu, 21 Nov 2024 14:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECl2-0006QJ-GS
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECl0-0002Y9-Sm
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732216946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZ5qJtjFMCsorpUx6DRRJUFzx5r4IsUySwfiiQk0TFQ=;
 b=Xn3q2VpLfxsP5yykp9NOzL4qzhN5Mfmcn8eER+N8C7exUIsrGINp78BghcerrIzpZ10qcP
 2P5dwg2fWxgIfUROLQylMKyCFwnL9Zt+Qu8894BiyNkpnRRF/EzNjje92Sgw2F7X/YhsUa
 BtdzbBkQ1EWTDLldnqiGvMv1BKjU5dY=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-sfjjxHg6PPyn3Vqal0XCeQ-1; Thu, 21 Nov 2024 14:22:25 -0500
X-MC-Unique: sfjjxHg6PPyn3Vqal0XCeQ-1
X-Mimecast-MFC-AGG-ID: sfjjxHg6PPyn3Vqal0XCeQ
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-83a9bd80875so129277439f.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732216944; x=1732821744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZ5qJtjFMCsorpUx6DRRJUFzx5r4IsUySwfiiQk0TFQ=;
 b=ipUCtwjNcVppH117d28ezFA0NnbrwZVosZA+zvUb2YmMloLn7cQynsYsxkfyjAQJCH
 YsKJhbxcAIbJABzb/L/jWhkD0nr0CyBdEOqsC0mfxF22hP453tk1NX9sxRGMSsG5eiNU
 mY691whK0WuwYVMB2MMLMQsQHtF0cP2XMod37V3q4CWRYxQSvFRhwMVFmxncU+S3H6ER
 rl7a5tWY5ZJn3K8AzCM9Lyam3/pnW9y4Cb/3sOgCVTymIwIAqiRUAxxKFuLqtPHsm8WE
 dz1ThPGYTx6KdbehyIU5x01dJqsmJqwYjBydaZRetwUSg2ro0Y8XJHxTEf+FEyEEiD06
 Dq3w==
X-Gm-Message-State: AOJu0YxtoyMx4UDVThmz1CoAz1mRNrgfj8RJMSwkiFwBhzxeXyz0L92f
 uYFG5QG7XuNhS6wJFqY7OKt1CcYekTrp7iO5WMFA9jPpABuYQB5rTCbBALkI9x2r4ORtldp0xXr
 pjQAZTVh7HALJzhRmlOwStqOahiOvuAiUbwjp+MUKEy7OaOqKcB0ZGhYO6TY8nmmU/VrnHOQb/a
 YvO1T8EjGE3V1dhJVAAZSkNNItDTfhOmsb0g==
X-Gm-Gg: ASbGncuB98DulXiMxco3Vsd18ffYAM2ErcZf8PhUf/fJ3HxadjRw+Ilrrqf39Z+LxbJ
 OgDiySSbhI8lMnNiPK4OypvIlAql8qZonOmoFthkamKKEonXJiLKi7aRMGNND2m+7/4X8A0mKFB
 GMa+ye9Kwo06X+hwKhuzLv7z/zm6073ZCRHaCVvk5Kzfv8rwPg8maKK6K/ZA6Hjiz4qGK63SjAc
 0JZ0cDmjFaemmlzNcppla/BjuscH15u7U5YyIhUERa3UIYDCB3abnvy7NoPHO13gwy457t2t737
 5w8U9iRwPRHE0FPwtdwE+ijRXQ==
X-Received: by 2002:a05:6602:6d8c:b0:82c:eeaa:b1e0 with SMTP id
 ca18e2360f4ac-83ecdcf2cecmr8576939f.11.1732216944037; 
 Thu, 21 Nov 2024 11:22:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESk0s/ydcqZLTxrRxL2JA2N1Dsl1nbSwzMslT2zl1q2FJY1o4ALENUViddyT6UwKP20Op0RQ==
X-Received: by 2002:a05:6602:6d8c:b0:82c:eeaa:b1e0 with SMTP id
 ca18e2360f4ac-83ecdcf2cecmr8574139f.11.1732216943572; 
 Thu, 21 Nov 2024 11:22:23 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe345f0sm102939173.45.2024.11.21.11.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 11:22:22 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 11/13] qom: Add object_get_container()
Date: Thu, 21 Nov 2024 14:22:00 -0500
Message-ID: <20241121192202.4155849-12-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241121192202.4155849-1-peterx@redhat.com>
References: <20241121192202.4155849-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Add a helper to fetch a root container (under object_get_root()).  Sanity
check on the type of the object.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qom/object.h | 10 ++++++++++
 qom/object.c         | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 597e961b8c..4eeee7f7c4 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1524,6 +1524,16 @@ const char *object_property_get_type(Object *obj, const char *name,
  */
 Object *object_get_root(void);
 
+/**
+ * object_get_container:
+ * @name: the name of container to lookup
+ *
+ * Lookup a root level container.
+ *
+ * Returns: the container with @name.
+ */
+Object *object_get_container(const char *name);
+
 
 /**
  * object_get_objects_root:
diff --git a/qom/object.c b/qom/object.c
index 2fb0b8418e..25316b9536 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1756,6 +1756,16 @@ static Object *object_root_initialize(void)
     return root;
 }
 
+Object *object_get_container(const char *name)
+{
+    Object *container;
+
+    container = object_resolve_path_component(object_get_root(), name);
+    assert(object_dynamic_cast(container, TYPE_CONTAINER));
+
+    return container;
+}
+
 Object *object_get_root(void)
 {
     static Object *root;
-- 
2.45.0


