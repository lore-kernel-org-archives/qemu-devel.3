Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03A4D743E5
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 21:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDshS-0008Gu-9H; Wed, 20 Nov 2024 16:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshP-0008Cm-0M
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshM-0006Nd-14
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732139837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ideNW5zodobmST7KFsD+Iz1+DW8emJAzcBwkBm7LdKo=;
 b=N9lgJ4PW4JTJAyXLNl0Slbr/QBPg6GsNFgXSWKk0iXznhGnLZVEhxrJ/LHHXGnQnBmcczN
 g+CknB1QpTBIQyc961mgTyPsj+U0Qfk4kEaGaYMcD7V9YXeA+Yl5p5ScBf2lsXnQMIoopQ
 lvFlwvAeW+vFxJmK9LTQcgsVVsAiO8c=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517--TogbWzqM0iacJhT8rYclg-1; Wed, 20 Nov 2024 16:57:14 -0500
X-MC-Unique: -TogbWzqM0iacJhT8rYclg-1
X-Mimecast-MFC-AGG-ID: -TogbWzqM0iacJhT8rYclg
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e388f173db4so361185276.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 13:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732139833; x=1732744633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ideNW5zodobmST7KFsD+Iz1+DW8emJAzcBwkBm7LdKo=;
 b=Il6zUfS9Kk+8AsBzFb7Bk/Vi8iI7OKHk6h9fsh7LYBk5U9IKxU2uXDabnCLzd2tbok
 4/SuTsYwYKWEL9mhajyShM4y/XsZd/nBNZueklpgr8TnAU/RICsyUhyoPJVmqrcXMlxi
 GbHF6umPZJKXb1xj+Yj3uhZpgYsbylVZ64Uv3iXDyWtepz5UbOu7bXwjaU9XzC4UhhrY
 cA8/m8R12GtaChNFUT+7gKVvGeEGIqi2XhEwyrC4IBNYGaluRemEUgHNWOewQpDxm/7F
 c2cOC162sg1B6tpO6rVckVh5jeFkdDTn4sAD0RTBUvuLLhrOApV3QaVvZpe+MEbailir
 CLfw==
X-Gm-Message-State: AOJu0Yzp+BDpv4V71ZRNZAKd5BYmMSNc5cxCMt8PQQrGbjSw+5hZAbpt
 5Ca+RJtor9y3iJlcvd/1uYCnNeOw/F8bECdy6T6YSm1IeMBjkAPD91CW8GqfYCd6ySoQyNd8UJT
 YFtaAoCzIDlz1E3ttBsO9YZCPpdOFWR2gOI203I1dNyM7ILTpn0OjTV6KsiqtUJlxKkAZzQ4TXf
 RXS6ee2t2Oec8/05Zx8//IO2yGjKSz2cqHnQ==
X-Received: by 2002:a05:6902:1009:b0:e2b:d75b:7630 with SMTP id
 3f1490d57ef6-e38cb5e33a9mr3322690276.35.1732139833158; 
 Wed, 20 Nov 2024 13:57:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1BItRPkLUdJUTgP6hk1zA1F/KXZsmd8BAS1Yqfkd0KQAqJ01UAGexIVkiAk9tFwacklJIaQ==
X-Received: by 2002:a05:6902:1009:b0:e2b:d75b:7630 with SMTP id
 3f1490d57ef6-e38cb5e33a9mr3322654276.35.1732139832680; 
 Wed, 20 Nov 2024 13:57:12 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-464680d6826sm14632881cf.15.2024.11.20.13.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 13:57:12 -0800 (PST)
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
Subject: [PATCH 03/12] tests: Fix test-qdev-global-props on anonymous qdev
 realize()
Date: Wed, 20 Nov 2024 16:56:54 -0500
Message-ID: <20241120215703.3918445-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241120215703.3918445-1-peterx@redhat.com>
References: <20241120215703.3918445-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

test-qdev-global-props creates a few subprocesses and test things based on
qdev realize().  One thing was overlooked since the start, that anonymous
creations of qdev (then realize() the device) requires the machine object's
presence, as all these devices need to be attached to QOM tree, by default
to path "/machine/unattached".

The test didn't crash simply because container_get() has an implicit
semantic to silently create any missing container, hence what happened here
is container_get() (when running these tests) will try to create containers
at QOM path "/machine" on the fly.  That's probably unexpected by the test,
but worked like charm before.

We're going to fix device_set_realized() soon, but before that make the
test case prepared, by creating the machine object on its own.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/unit/test-qdev-global-props.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index c8862cac5f..b2a1598f8e 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -72,6 +72,25 @@ static const TypeInfo subclass_type = {
     .parent = TYPE_STATIC_PROPS,
 };
 
+/*
+ * Initialize a fake machine, being prepared for future tests.
+ *
+ * All the tests later (even if to be run in subprocesses.. which will
+ * inherit the global states of the parent process) will try to create qdev
+ * and realize the device.
+ *
+ * Realization of such anonymous qdev (with no parent object) requires both
+ * the machine object and its "unattached" container to be at least present.
+ */
+static void test_init_machine(void)
+{
+    /* This is a fake machine - it doesn't need to be a machine object */
+    Object *machine = container_create(object_get_root(), "machine");
+
+    /* This container must exist for anonymous qdevs to realize() */
+    container_create(machine, "unattached");
+}
+
 /* Test simple static property setting to default value */
 static void test_static_prop_subprocess(void)
 {
@@ -295,6 +314,8 @@ int main(int argc, char **argv)
     type_register_static(&nohotplug_type);
     type_register_static(&nondevice_type);
 
+    test_init_machine();
+
     g_test_add_func("/qdev/properties/static/default/subprocess",
                     test_static_prop_subprocess);
     g_test_add_func("/qdev/properties/static/default",
-- 
2.45.0


