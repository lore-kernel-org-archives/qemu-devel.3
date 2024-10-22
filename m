Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4744CCDD0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 19:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Koa-00024l-BW; Tue, 22 Oct 2024 15:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3KoY-00024L-QN
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 15:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3KoW-0002Bf-Dr
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 15:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729626306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CJmKddciWG00mUHJFoanaktpZdMQA9WdYHQvruA+mVs=;
 b=hBBC/zFTL1yMQsGFMH0PZrvj3Pq+ZRrAgQ0BBO02371XjWMTHRqIHb2y0ybN+7nLv4V96T
 NFTNjuskPuxzPqqSQIR+ztMzr3wJSxlTg7R8iCq3FQR6fCW0bXWH23RXOGS5uDd0bUng4a
 KGI/7MVOK7Mv0dDLCu5j7JHO9QK0/nM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-5IyAE3obPdK0dK4QmYgXLA-1; Tue, 22 Oct 2024 15:45:04 -0400
X-MC-Unique: 5IyAE3obPdK0dK4QmYgXLA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b16c9a84efso399959585a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 12:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729626304; x=1730231104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CJmKddciWG00mUHJFoanaktpZdMQA9WdYHQvruA+mVs=;
 b=R0vQP+RH2JmZg/pflZmpVSeZChh8VbfSNCNogZIJIm9LvqPJbW2Dv/qwPI49NzgoCr
 LqT10ksigQAUfe5io7kb6wgIK0ADOUHGF847JsDq8LGJjcCXNarco/7Ha8SLoTzHzxFR
 8P7omJtW25rRrifVQfaUk88FkamSPv6cEVYEgma6bnnZ7M4Z5RAm0MpZ8q0YR6cfAoOu
 H5IsYM8e+8KBZWNLmkUl8RPMc5t9p2ECYNxYkem4TdTEB0s4h6+7QAT94QQOSFU2166Y
 f/pHrbx0LyQuWef8R3L9Wx/1Hgfhjh18JPlnyGA1f0d4SimQOaewITatMzWbcV9fNRjP
 PcOw==
X-Gm-Message-State: AOJu0YyJ++U0Wwonif55Jz3O/UYySubrAPllPCklKxAzVJ569D6/P/mA
 CMmmP+dvuS9L1UyTTgojVJ9fkVcpYJ2Mng2CYawblChJLeQM9glKg6soOcu8x/Fj6Caj0cCco0W
 BkYna7JO6qnFmQaB/RlVIrTgMHTl9eJiyFJNxyUCqr7R15y8lQo5Xr+K7sOn9T/5a/sUwuq+H2b
 W/Wnilc5PL6G8wBQcjKPGeay90b9m93mi/3A==
X-Received: by 2002:a05:620a:371a:b0:7b1:5763:4ba5 with SMTP id
 af79cd13be357-7b17e5acc2emr19642985a.51.1729626303999; 
 Tue, 22 Oct 2024 12:45:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA5Lf0H3NqTvJnhRRT9jFjcMueKi+5rBglJMUe/kiIVj+dpLvQ4emCXo+D/HTorGXZowdpuA==
X-Received: by 2002:a05:620a:371a:b0:7b1:5763:4ba5 with SMTP id
 af79cd13be357-7b17e5acc2emr19639785a.51.1729626303636; 
 Tue, 22 Oct 2024 12:45:03 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1659bb8besm314663185a.13.2024.10.22.12.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 12:45:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Julia Suvorova <jusual@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2] migration: Deprecate query-migrationthreads command
Date: Tue, 22 Oct 2024 15:45:01 -0400
Message-ID: <20241022194501.1022443-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

Per previous discussion [1,2], this patch deprecates query-migrationthreads
command.

To summarize, the major reason of the deprecation is due to no sensible way
to consume the API properly:

  (1) The reported list of threads are incomplete (ignoring destination
      threads and non-multifd threads).

  (2) For CPU pinning, there's no way to properly pin the threads with
      the API if the threads will start running right away after migration
      threads can be queried, so the threads will always run on the default
      cores for a short window.

  (3) For VM debugging, one can use "-name $VM,debug-threads=on" instead,
      which will provide proper names for all migration threads.

[1] https://lore.kernel.org/r/20240930195837.825728-1-peterx@redhat.com
[2] https://lore.kernel.org/r/20241011153417.516715-1-peterx@redhat.com

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- truncate long '-' line [Dan]
- Remove warn_report() [Markus]
- Proper spacing in qapi/ after "Features:" [Markus]
---
 docs/about/deprecated.rst | 8 ++++++++
 qapi/migration.json       | 7 ++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ce38a3d0cf..100ba66fe1 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -147,6 +147,14 @@ options are removed in favor of using explicit ``blockdev-create`` and
 ``blockdev-add`` calls. See :doc:`/interop/live-block-operations` for
 details.
 
+``query-migrationthreads`` (since 9.2)
+''''''''''''''''''''''''''''''''''''''
+
+To be removed with no replacement, as it reports only a limited set of
+threads (for example, it only reports source side of multifd threads,
+without reporting any destination threads, or non-multifd source threads).
+For debugging purpose, please use ``-name $VM,debug-threads=on`` instead.
+
 Incorrectly typed ``device_add`` arguments (since 6.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 3af6aa1740..a605dc26db 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -2284,12 +2284,17 @@
 #
 # Returns information of migration threads
 #
+# Features:
+#
+# @deprecated: This command is deprecated with no replacement yet.
+#
 # Returns: @MigrationThreadInfo
 #
 # Since: 7.2
 ##
 { 'command': 'query-migrationthreads',
-  'returns': ['MigrationThreadInfo'] }
+  'returns': ['MigrationThreadInfo'],
+  'features': ['deprecated'] }
 
 ##
 # @snapshot-save:
-- 
2.45.0


