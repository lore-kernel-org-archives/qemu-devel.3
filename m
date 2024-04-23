Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F2EC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnF-0004vk-K2; Tue, 23 Apr 2024 11:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmg-0004NK-Vf
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmc-00005O-Q5
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jCSaFbKWPsN7IuafQoBh1Uc+SE9mpb4ii6bTyqjUCWk=;
 b=GL6s5mAOEr5/aAjS3WnGVfzJORtE0T523u64yeGdC2M8GkpQjacPe5D+5zrTC2+jqx29la
 KcpVPtSzyaUlgx0iChdP16lWgBllx5PwEjbOaya53L7edsw6HjNjSz71FfHDvEfyfi071t
 zfqz39UkyoRsSpVP8jh2jqstG9oeBlA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-Od9HXFmzNzK5D3NFio_3RQ-1; Tue, 23 Apr 2024 11:10:07 -0400
X-MC-Unique: Od9HXFmzNzK5D3NFio_3RQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37B43812C39
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:07 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C75E82026D0A
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/63] semihosting: move stubs out of stubs/
Date: Tue, 23 Apr 2024 17:09:00 +0200
Message-ID: <20240423150951.41600-13-pbonzini@redhat.com>
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

Since the semihosting stubs are needed exactly when the Kconfig symbols
are not needed, move them to semihosting/ and conditionalize them
on CONFIG_SEMIHOSTING and/or CONFIG_SYSTEM_ONLY.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240408155330.522792-13-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/semihost-all.c => semihosting/stubs-all.c | 0
 stubs/semihost.c => semihosting/stubs-system.c  | 0
 semihosting/meson.build                         | 3 +++
 stubs/meson.build                               | 2 --
 4 files changed, 3 insertions(+), 2 deletions(-)
 rename stubs/semihost-all.c => semihosting/stubs-all.c (100%)
 rename stubs/semihost.c => semihosting/stubs-system.c (100%)

diff --git a/stubs/semihost-all.c b/semihosting/stubs-all.c
similarity index 100%
rename from stubs/semihost-all.c
rename to semihosting/stubs-all.c
diff --git a/stubs/semihost.c b/semihosting/stubs-system.c
similarity index 100%
rename from stubs/semihost.c
rename to semihosting/stubs-system.c
diff --git a/semihosting/meson.build b/semihosting/meson.build
index b07cbd980f2..34933e5a195 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -9,5 +9,8 @@ specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: fil
   'uaccess.c',
 ))
 
+common_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_false: files('stubs-all.c'))
+system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_false: files('stubs-system.c'))
+
 specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
 		if_true: files('arm-compat-semi.c'))
diff --git a/stubs/meson.build b/stubs/meson.build
index 60e32d363fa..84ecaa4daa1 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -55,9 +55,7 @@ if have_block or have_ga
 endif
 if have_system
   stub_ss.add(files('fw_cfg.c'))
-  stub_ss.add(files('semihost.c'))
   stub_ss.add(files('xen-hw-stub.c'))
 else
   stub_ss.add(files('qdev.c'))
 endif
-stub_ss.add(files('semihost-all.c'))
-- 
2.44.0



