Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6B9C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66mk-0003JM-Gp; Sun, 12 May 2024 06:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mh-0003Hx-GQ
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66me-000617-J4
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXhGQDPZfGkC+s8BiEwU/MjSAqm+dVULEK5Gka2d9us=;
 b=Gy662JP2bqCeFJ5R2bEq111Ae1Fb5PPo2sqkeL77vGHnslicquo5K95OSS7C1xUZ38KYBY
 TP/CMmwp69ZKxCvtH8w5kf3pxwnfP5F6QSi22DshsYCASW2+riTwhZGSlZsEpNLpCyf5wo
 avEkjJxF9cg71HD1Kc21lI1LjocUUkE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-plPLbWASN-ySfntO4xolvA-1; Sun, 12 May 2024 06:50:21 -0400
X-MC-Unique: plPLbWASN-ySfntO4xolvA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-572a203c05dso1800005a12.0
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511019; x=1716115819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vXhGQDPZfGkC+s8BiEwU/MjSAqm+dVULEK5Gka2d9us=;
 b=FH3APe0B2kR8GnhmdcWPOyvZuJlXnxURbRXrxaKKceTh9qyNzuOHjckELJDpXtFodM
 2j0cjTsV/2DxLMH/1h9MHNwQfiWVxatGQSEJ+E5taHC4uAbSE2EY+bEdVmesngCzOzX8
 bteO8zWT/rAj2jrs67GXMkK9MfE27r3VSP1mSgsVkbQLcnh84ThWicrT4uj+BWGs60Q9
 hwVRFEACai+OqsTBiazYgY6QBDI7zLXyhyt3YjQ+HiMGHFLvzTCBlIghH6DpNY6TMPVK
 02Znqsp8ea5jxx+OWQqfXFnKX4Hn3bY6EzDP9uhlkdA9gV2uZa/gqsMcFfdWJ9FFli+o
 +Q1A==
X-Gm-Message-State: AOJu0Yy04i753Cp4m/XLNrZ4W72T8PcgYcvJUuLiac4DC3h+ebHRuM19
 4XP2A5tcCZFm9/wEhd9F/yuGEQIXSN0HCDO82wyrVl89/Wn2oIn3UjxwAw7pGcJ/5/hjnKOW2iU
 +ifTpP27t4ETPgUDBcOjPRhEbMydc665nbw0141ez5gxas8LmFc1WnjAtRack/e68DU6VpEwnrJ
 nnCdpe1EjO4u31kqvfjFFRpf7Zn20Bc4ts5X0B
X-Received: by 2002:a50:9e61:0:b0:572:e7ac:eeaf with SMTP id
 4fb4d7f45d1cf-5734d5ccc9cmr4881395a12.19.1715511019708; 
 Sun, 12 May 2024 03:50:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgz7CA19EKkAhyGBPiJNen3umaPKNkWLOFPadFeyvftJq/qi5w71EXmPsC0Z3c56ie37InCA==
X-Received: by 2002:a50:9e61:0:b0:572:e7ac:eeaf with SMTP id
 4fb4d7f45d1cf-5734d5ccc9cmr4881387a12.19.1715511019338; 
 Sun, 12 May 2024 03:50:19 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c2cb331sm4570720a12.67.2024.05.12.03.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 12/27] s390x: select correct components for no-board build
Date: Sun, 12 May 2024 12:49:30 +0200
Message-ID: <20240512104945.130198-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240509170044.190795-5-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 4 ++--
 target/s390x/Kconfig       | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 786c8f92090..8ca3e0586c7 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -650,7 +650,7 @@ build-tci:
 # Check our reduced build configurations
 # requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblazeel,
 #   mips64el, or1k, ppc, ppc64, riscv32, riscv64, rx, x86_64
-# does not build without boards: i386, s390x, x86_64
+# does not build without boards: i386, x86_64
 build-without-defaults:
   extends: .native_build_job_template
   needs:
@@ -666,7 +666,7 @@ build-without-defaults:
       --disable-strip
     TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu m68k-softmmu
       mips-softmmu mips64-softmmu mipsel-softmmu
-      sh4-softmmu sh4eb-softmmu sparc-softmmu
+      s390x-softmmu sh4-softmmu sh4eb-softmmu sparc-softmmu
       sparc64-softmmu tricore-softmmu xtensa-softmmu xtensaeb-softmmu
       hexagon-linux-user i386-linux-user s390x-linux-user
     MAKE_CHECK_ARGS: check
diff --git a/target/s390x/Kconfig b/target/s390x/Kconfig
index 72da48136c6..d886be48b47 100644
--- a/target/s390x/Kconfig
+++ b/target/s390x/Kconfig
@@ -1,2 +1,4 @@
 config S390X
     bool
+    select PCI
+    select S390_FLIC
-- 
2.45.0


