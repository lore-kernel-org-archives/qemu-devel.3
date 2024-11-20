Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97EFD743E6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 21:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDshb-0008UI-75; Wed, 20 Nov 2024 16:57:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshX-0008R0-2Z
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshV-0006U3-Kp
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732139848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AlcX7vR9/mJZNCZh9j7iz8mHqKYU+1nKrqM52qsEyNA=;
 b=Pm/sLC3+6HTNnrUb0T1ePH+IfanHNBDwfUzfA8ZtVQPbtlytPQyaumkfqZdh/MdUmBCp3h
 x1jnYnTUZ8NBbel6w/VCwWKO5z96ruRI9UtyZFMnf/zNRPKrtQfzVaMib1QL4kLo79EXOC
 vvS2/VPK1ZnylNwdtC5/yHoCmO+JorU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-05MCBheKNgafiWWNFD1t6w-1; Wed, 20 Nov 2024 16:57:26 -0500
X-MC-Unique: 05MCBheKNgafiWWNFD1t6w-1
X-Mimecast-MFC-AGG-ID: 05MCBheKNgafiWWNFD1t6w
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e30cf48435fso325702276.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 13:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732139845; x=1732744645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AlcX7vR9/mJZNCZh9j7iz8mHqKYU+1nKrqM52qsEyNA=;
 b=Gom6Ot8n7p9MnbH03VE9fZ4fzr9xNfCxSN6ZZ+F6xyFGCeY19w9DKzR0kDXFGWonQm
 K8Zpg+ahLpGkFqrVqT51IheiWPG9+FjuqJFeY5ibmX7YlemzyD7S95CAU9UulM89AyYJ
 vEMATXUReBHkhtue0o5TtaaA7MPnBJmxUTVPnJoPkpVP1f9tM2keVnENnXkFFQWekK5R
 7cGjsv6V/qutt2AGupC471fv6UTAeOR1waFoiXQeUl6mRwfcogYjgC4EgYushTtK+9OY
 W92wkjnZCmgMSbmlkbmj2SeHHFfmilbkqcnLpp5VrUK56V45jAQ0lWxzqF3x9l+7HA9s
 baNw==
X-Gm-Message-State: AOJu0YwR+aeF89AYF47eDIst/dmUzG44CO5y49Cx7B9io+woaDihc7vV
 ohfhU6NEqABD6EKBudyTQkfX9S2nIH4pwngCaKad4XqbvVGoiOVxT1ScrwDYXWqBBfB9RPl3mYZ
 amSt3TyExSSgoOiVNrB+8J/RQgMfIFmkugQOLHtidzH1ucSH0dEcg18L7JBR0yenhcsqj9TQ1wV
 XVytnzW4B1foBqYog8AMMHa/nz7c1GOrsqQg==
X-Received: by 2002:a05:6902:2510:b0:e38:7b08:867d with SMTP id
 3f1490d57ef6-e38cb601d51mr3972711276.40.1732139845602; 
 Wed, 20 Nov 2024 13:57:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtMOwvJ/qXdCVBrXtKWx6hrxtSYuXOITngPAjEwqna7/9eE1JlnYujaPCAN1dqxHkCTlZnWw==
X-Received: by 2002:a05:6902:2510:b0:e38:7b08:867d with SMTP id
 3f1490d57ef6-e38cb601d51mr3972663276.40.1732139844873; 
 Wed, 20 Nov 2024 13:57:24 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-464680d6826sm14632881cf.15.2024.11.20.13.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 13:57:24 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 09/12] qdev: Add machine_get_container()
Date: Wed, 20 Nov 2024 16:57:00 -0500
Message-ID: <20241120215703.3918445-10-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241120215703.3918445-1-peterx@redhat.com>
References: <20241120215703.3918445-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a helper to fetch machine containers.  Add some sanity check around.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/qdev-core.h | 10 ++++++++++
 hw/core/qdev.c         | 17 +++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 5be9844412..38edfb1b54 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -996,6 +996,16 @@ const char *qdev_fw_name(DeviceState *dev);
 void qdev_assert_realized_properly(void);
 Object *qdev_get_machine(void);
 
+/**
+ * machine_get_container:
+ * @name: The name of container to lookup
+ *
+ * Get a container of the machine (QOM path "/machine/XXX").
+ *
+ * Returns: the machine container object.
+ */
+Object *machine_get_container(const char *name);
+
 /**
  * qdev_get_human_name() - Return a human-readable name for a device
  * @dev: The device. Must be a valid and non-NULL pointer.
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index c869c47a27..6cb4fe4691 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -829,6 +829,23 @@ Object *qdev_get_machine(void)
     return dev;
 }
 
+Object *machine_get_container(const char *name)
+{
+    Object *container, *machine;
+
+    /*
+     * NOTE: nobody should call this _before_ machine is created.  If it
+     * happens, it's a programming error.
+     */
+    machine = qdev_get_machine();
+    assert(machine);
+
+    container = object_resolve_path_component(machine, name);
+    assert(object_dynamic_cast(container, TYPE_CONTAINER));
+
+    return container;
+}
+
 char *qdev_get_human_name(DeviceState *dev)
 {
     g_assert(dev != NULL);
-- 
2.45.0


