Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0095D74950
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B5D-0003fR-7v; Wed, 30 Oct 2024 11:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B56-0003b3-KA
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B54-0007o3-US
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZsscXx+KMHNJgp5Covv21rQwFJnGP8YdwoqwthrJBqE=;
 b=DwdyLrYrnTJ50FFgY18fJ49HKOTUNlV4vc4xMEBfFfReBN9wiBNmg+IqKTxjS90T+UJWIs
 X7irAI15w/A6A4mHXwcfZVTrTNP1eGKENFE90nkD+2hUx1c/rgWpA30YdFYRAUNItKUIKi
 oeAD59k+njg+KDvXGPNkoBscNIn1Shc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-P_v-HH6ROaCMcy_UNOxemA-1; Wed, 30 Oct 2024 11:57:57 -0400
X-MC-Unique: P_v-HH6ROaCMcy_UNOxemA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cbec7fbf1cso71916d6.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303876; x=1730908676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZsscXx+KMHNJgp5Covv21rQwFJnGP8YdwoqwthrJBqE=;
 b=Y4JCIMiE/ynkWou7y4gY/xo6C41syyhlMMS6hS1VZwqTD43NQfFHGrerKbi/tV/1Tm
 vQTgs3iD8i/dR8ISPjXAnPWHN8is5hiV8zNmBXfN4yRCDNemYgDt6PPaUfsjMn4cSbZd
 ANuU9qTFp6uV3mZqCbCo3TVIhClQevPv1IxLkVVE//hJXM2IxqTcuDGrd8MA847XNuso
 LIKVuaNWFGMYFHXRZ3ovyEKYBKh5QEK0U/7wlVsavAHjlVtDd1hP/wSMZd/PXc1I0aQh
 dvLzA4S5V9Twfth0g+HKBwU9nE2MMLyhL9zG0+zM4eBIi9ShLNPvLJ3kQgOcIvmCMvjh
 XoXQ==
X-Gm-Message-State: AOJu0YxZDN8jPV7UYCP8KrLf1fcIzQHKI3S/tZEnBJPGrduqqeT7rD1S
 E1xoYAcRbIlt0P9RtccvSG0ct43p2r+EKEBZxygpHFdcdrmKa7zMEJc49vFr18OSEO6i4HUXjIS
 IPGnuqB4EeNHewW5DIouGPPsjexIXSLktaacErSEoIBET/MDpbNs+iS9hMidUr7rtwqN7sbUeK0
 nVvsdwsf3070mrlvGv+Otf/evKlT4I37TLtw==
X-Received: by 2002:a05:6214:5348:b0:6cb:d583:3765 with SMTP id
 6a1803df08f44-6d345facebfmr52347476d6.1.1730303876292; 
 Wed, 30 Oct 2024 08:57:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV89Lpsp0exTp6uKtGZ47u1ViJp/BVjzdfYkAOc0jCBN2UveNjdDeX5ORPI2MOGxFUo+JNlA==
X-Received: by 2002:a05:6214:5348:b0:6cb:d583:3765 with SMTP id
 6a1803df08f44-6d345facebfmr52347116d6.1.1730303875899; 
 Wed, 30 Oct 2024 08:57:55 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:57:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 11/18] migration: Deprecate query-migrationthreads command
Date: Wed, 30 Oct 2024 11:57:27 -0400
Message-ID: <20241030155734.2141398-12-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Link: https://lore.kernel.org/r/20241022194501.1022443-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
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


