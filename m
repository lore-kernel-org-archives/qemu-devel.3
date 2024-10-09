Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E31CEDD8F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syW1o-0004jM-NH; Wed, 09 Oct 2024 08:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1n-0004jB-Lw
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1l-0005SI-Uf
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728477773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jk0pKj9VCu3al6N68FkKLk/v4exRbcGJT+XXNWXH8Sw=;
 b=C5xjV+l83RMiEfqfjLBIFIUlY/SRRyIga6QI5pOgYfGV29+pUPKRg6C/V2gcEKk0nYTMmt
 PwLNoKSl8YyOyjtxwxPRwZO+jI+h2DDvZZoEzql6o+lAAQwQDwosBuW4yisvj9FwqxsdN9
 s70bVk77Rc2ejtmOExe40emHVzeazco=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-9w0rMEd-OMic_2vnroH6cA-1; Wed, 09 Oct 2024 08:42:52 -0400
X-MC-Unique: 9w0rMEd-OMic_2vnroH6cA-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-82cdb749559so1175908439f.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728477770; x=1729082570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jk0pKj9VCu3al6N68FkKLk/v4exRbcGJT+XXNWXH8Sw=;
 b=VzBgTCSMmpQwHpjBrIB8MNFapAfacIBU63/F8Gzvi4PR+cD4xO3IaxGAxQL207HKW+
 S0PWwvPuwycMvoT2DC/KZscgL4oGRPEIJQIX7gPkcf3vylapJzYGst/9VQ9Rh0WcNeiU
 8baBAc11zEBq2j5vD+0qRiBjt4YrXuuqH7LvLgKREE8bsuUwkuiqDIZ1TnRhjvle+K49
 Pu82fgFWTqVs0pT2iZLEwq3OrCsknv3iQ8UhQuAe4D5xFH68nJ7MAqUMHbDscfvrZG+p
 CotSG3IxPZKi8r8AVaKwQ0b3upBQbn/wAnS5mE3BxBqPCcUL4wLAd2FTz/fAb9jsm5uF
 dIJQ==
X-Gm-Message-State: AOJu0YwmcfAZM98/zBSToX2IOqWeLmd7fa4pdBsEK0MoS9ba5HHaS8Z9
 yoYjypGkAD5N3oLJfqVThT07pcuIL0rdD3wr3BNBhyYVmQwvcYoV7ZOuG1QIcyMNnKoz05+tW6S
 H840j1OhoMmsU18fIQouXgAjWDNlldvAW408zgP60kMG32CKiUY/+tlO4FJ5Q3Be2xNC6xqtYm8
 WmQAOYNBihR2VZK2RGbKaak/5o68+5yBZtiA==
X-Received: by 2002:a05:6602:6c04:b0:835:42ce:933d with SMTP id
 ca18e2360f4ac-83542ce9439mr127156239f.1.1728477770594; 
 Wed, 09 Oct 2024 05:42:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPihQ1fnKB662fomcWUObYdo/c2JzIDukLZHlNaqfEiNJJ63s+y5HaNwDhBeNP+6VanGR2mQ==
X-Received: by 2002:a05:6602:6c04:b0:835:42ce:933d with SMTP id
 ca18e2360f4ac-83542ce9439mr127152639f.1.1728477770098; 
 Wed, 09 Oct 2024 05:42:50 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503aacb18sm220272039f.30.2024.10.09.05.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:42:48 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PULL 05/12] migration: Deprecate zero-blocks capability
Date: Wed,  9 Oct 2024 08:42:31 -0400
Message-ID: <20241009124238.371084-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241009124238.371084-1-peterx@redhat.com>
References: <20241009124238.371084-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

From: Fabiano Rosas <farosas@suse.de>

The zero-blocks capability was meant to be used along with the block
migration, which has been removed already in commit eef0bae3a7
("migration: Remove block migration").

Setting zero-blocks is currently a noop, but the outright removal of
the capability would cause and error in case some users are still
setting it. Put the capability through the deprecation process.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240919134626.166183-4-dave@treblig.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/about/deprecated.rst | 6 ++++++
 qapi/migration.json       | 5 ++++-
 migration/options.c       | 4 ++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index c02bbb66f7..33ce4f9536 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -467,3 +467,9 @@ usage of providing a file descriptor to a plain file has been
 deprecated in favor of explicitly using the ``file:`` URI with the
 file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
 command documentation for details on the ``fdset`` usage.
+
+``zero-blocks`` capability (since 9.2)
+''''''''''''''''''''''''''''''''''''''
+
+The ``zero-blocks`` capability was part of the block migration which
+doesn't exist anymore since it was removed in QEMU v9.1.
diff --git a/qapi/migration.json b/qapi/migration.json
index b66cccf107..3af6aa1740 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -479,11 +479,14 @@
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
+# @deprecated: Member @zero-blocks is deprecated as being part of
+#     block migration which was already removed.
 #
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
-  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
+  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
+           { 'name': 'zero-blocks', 'features': [ 'deprecated' ] },
            'events', 'postcopy-ram',
            { 'name': 'x-colo', 'features': [ 'unstable' ] },
            'release-ram',
diff --git a/migration/options.c b/migration/options.c
index 6f549984cb..ad8d6989a8 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -450,6 +450,10 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     ERRP_GUARD();
     MigrationIncomingState *mis = migration_incoming_get_current();
 
+    if (new_caps[MIGRATION_CAPABILITY_ZERO_BLOCKS]) {
+        warn_report("zero-blocks capability is deprecated");
+    }
+
 #ifndef CONFIG_REPLICATION
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
         error_setg(errp, "QEMU compiled without replication module"
-- 
2.45.0


