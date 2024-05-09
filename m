Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24EDC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s578g-0002Ey-HG; Thu, 09 May 2024 13:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s578e-0002EJ-Q7
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s578d-0003WK-D2
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715274058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RkXh8iMmEX+Na8Ja+pj2VTtRvHtCubEpo1ctt3O6Hhs=;
 b=MhZhVEKFENSX81rsDoUr20BlQmJm3qseJA8PsprX1XvFs+1EbLhAjRmsaTIBgMYVsL6qBE
 vo1BkIPw5QzOVmh6ORm0ZpY6VQlvRRRwuoArXCje/oJqwRjwXR2X/eulrIosuGtxl1B/cF
 5MU9ldEkNoX7SwiR0p6WDdgPhAnDQLk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-DAoRk-L0MS6RuFU3c2C5iQ-1; Thu, 09 May 2024 13:00:56 -0400
X-MC-Unique: DAoRk-L0MS6RuFU3c2C5iQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-51f7d5c8500so938447e87.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715274054; x=1715878854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RkXh8iMmEX+Na8Ja+pj2VTtRvHtCubEpo1ctt3O6Hhs=;
 b=SJYiYHGbWXn86fEd5kszBO/XjKndFrM68admGI+tJI4OJL9JLnMwwfkE5xSNnu44Qd
 pntWFCx2kbK5+BjklY3wTvMQkZNEK3Gs0Zky0/YH1/JHfXqUV1jMsYkC7GhOaDNP91je
 bK3QsPfveEUZtOj6Uy6a2vaTaUIplNax0ZCvtUCF+SAnOtEuCBW0OLbnxtUCSoLIfKC/
 ItZxNvrNlaIrlzRqZO05ZEYa169ZZdqFx6x/kyC9DCgh9hq9ZDuG3fRWmnbJJX9ysECr
 XYvV4/mzjngsKQ/qyZuRtV5T27lA9/Tvxql2FzOXKVQTLnjP3Qk8GCi0dUqOZx+pJODr
 9dGw==
X-Gm-Message-State: AOJu0YwdMdm9apVhpHQoE9qzEg0B1AX6czqP/4z2YjCIgNQ6YT4JCCD2
 jIh9uTo+dcOM6wRebcIF1vDEVmgToziesgs6hEqY+qwX5wYvxFbTv6sscS7kUDZrgr1vahxAlhS
 SjzYsIBCZ1//EYwVJjfxRx2FHBUQ5u2VlCwlv0KfQLr4xezt74J82ZisvaArlMalXusVx+ZVOh3
 t5OqY2DwOp7mzQQLqVX9mzkddcDptZdN9oaYB7
X-Received: by 2002:ac2:53a4:0:b0:521:9963:3896 with SMTP id
 2adb3069b0e04-5220fc6da32mr65961e87.41.1715274054609; 
 Thu, 09 May 2024 10:00:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEENc/FoJpG8UOOXW9YEZx7vKcipAwsHN2AvdF1eKk+cE/YqVjHav1fnTel9hnfnQpBxj1Y7A==
X-Received: by 2002:ac2:53a4:0:b0:521:9963:3896 with SMTP id
 2adb3069b0e04-5220fc6da32mr65949e87.41.1715274054109; 
 Thu, 09 May 2024 10:00:54 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c350d9asm866698a12.97.2024.05.09.10.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:00:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH 04/13] s390x: select correct components for no-board build
Date: Thu,  9 May 2024 19:00:35 +0200
Message-ID: <20240509170044.190795-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509170044.190795-1-pbonzini@redhat.com>
References: <20240509170044.190795-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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
---
 .gitlab-ci.d/buildtest.yml | 4 ++--
 target/s390x/Kconfig       | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 13afd0df1f0..f8502905203 100644
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


