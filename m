Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E78FC19F4E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnq-0008NN-Ca; Tue, 23 Apr 2024 11:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnk-0007na-SY
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHni-0000QV-U7
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C8EZUwlLnYM4W49CBbIplSimkDLa0N6GmlrzgsYB0LM=;
 b=G/Fu1mL1QPYKmRhGBAyqu2Xysy4QyRFEXBlJcaAUNQ9lON492x8zcZ9zQxZVQlSAD1YQh+
 SmU959cEb9XVqNVuflIOMgAztEyweZLnTRH47iaXI/VLGYhfanQeb7kkqMfiDP2OLcda2u
 zoR+17TLXwbPss2AjYKoNnzXDJ/zaHE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-SJUmb5UTMO6d6rZstchlyg-1; Tue, 23 Apr 2024 11:10:13 -0400
X-MC-Unique: SJUmb5UTMO6d6rZstchlyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB2D680D0FA
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:09 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71758203397E
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/63] colo: move stubs out of stubs/
Date: Tue, 23 Apr 2024 17:09:03 +0200
Message-ID: <20240423150951.41600-16-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since the colo stubs are needed exactly when the build options are not
enabled, move them together with the code they stub.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240408155330.522792-16-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/colo.c => migration/colo-stubs.c   | 0
 stubs/colo-compare.c => net/colo-stubs.c | 0
 migration/meson.build                    | 2 ++
 net/meson.build                          | 2 ++
 stubs/meson.build                        | 2 --
 5 files changed, 4 insertions(+), 2 deletions(-)
 rename stubs/colo.c => migration/colo-stubs.c (100%)
 rename stubs/colo-compare.c => net/colo-stubs.c (100%)

diff --git a/stubs/colo.c b/migration/colo-stubs.c
similarity index 100%
rename from stubs/colo.c
rename to migration/colo-stubs.c
diff --git a/stubs/colo-compare.c b/net/colo-stubs.c
similarity index 100%
rename from stubs/colo-compare.c
rename to net/colo-stubs.c
diff --git a/migration/meson.build b/migration/meson.build
index 1eeb915ff63..f76b1ba3289 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -34,6 +34,8 @@ system_ss.add(files(
 
 if get_option('replication').allowed()
   system_ss.add(files('colo-failover.c', 'colo.c'))
+else
+  system_ss.add(files('colo-stubs.c'))
 endif
 
 system_ss.add(when: rdma, if_true: files('rdma.c'))
diff --git a/net/meson.build b/net/meson.build
index 9432a588e4e..e0cd71470e0 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -20,6 +20,8 @@ if get_option('replication').allowed() or \
     get_option('colo_proxy').allowed()
   system_ss.add(files('colo-compare.c'))
   system_ss.add(files('colo.c'))
+else
+  system_ss.add(files('colo-stubs.c'))
 endif
 
 if get_option('colo_proxy').allowed()
diff --git a/stubs/meson.build b/stubs/meson.build
index a4404e765ab..a252bffad00 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -42,8 +42,6 @@ stub_ss.add(files('target-get-monitor-def.c'))
 stub_ss.add(files('target-monitor-defs.c'))
 stub_ss.add(files('trace-control.c'))
 stub_ss.add(files('uuid.c'))
-stub_ss.add(files('colo.c'))
-stub_ss.add(files('colo-compare.c'))
 stub_ss.add(files('vmstate.c'))
 stub_ss.add(files('vm-stop.c'))
 stub_ss.add(files('win32-kbd-hook.c'))
-- 
2.44.0



