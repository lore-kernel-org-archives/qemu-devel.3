Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6F4C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 16:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBz2M-0006h8-9v; Mon, 05 May 2025 12:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBz2G-0006dT-Hd
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBz2E-0002Co-8n
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746463877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=K3rTk5QqsJiLGicX/ZNrIaBcoFpzE0SDxObclyMNKwg=;
 b=gIiB5k537U+xI3AxIROqcrNoUnpyEmtvfPhscRfx0R44TvJmEPMED+J6gr1Wce1laF5vXw
 v6Clyta9p5PkBokpgzMUxbK+/4yQ8b2SjwR9QaLW4OYWEhaQ3jcKDe5wrm/1vrvChN7laD
 sqYjgkA2C7HD6a/qGcp0n2TFnTSwu8A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-jWMXuRJkMHWvwkamuH8KnQ-1; Mon, 05 May 2025 12:51:13 -0400
X-MC-Unique: jWMXuRJkMHWvwkamuH8KnQ-1
X-Mimecast-MFC-AGG-ID: jWMXuRJkMHWvwkamuH8KnQ_1746463872
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-391315098b2so1566555f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 09:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746463871; x=1747068671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K3rTk5QqsJiLGicX/ZNrIaBcoFpzE0SDxObclyMNKwg=;
 b=l9QDzTZ3j/ARVUmuKc7BiUOEuQNfngLF+rK7eZIJHiJOMzNqjISpCO1WuKAuIj4FVK
 GenEkOCag/vQVq/Yh0rKvhEFo4xu2c+zQxe3FJZVNn5lfEcVQdH6SPgtz2hgfVlB70kC
 UXGv/cx2FfZ6lMwBuypEtZYAG3hi1G2uqJ5H0CFgPXt2CafNOsxByTZpzlzWkKYtZAYp
 suQLptGT/Rol51Cul7oD4Na7v2zuxjhD/JKv0ZdfRxZn/Gt3YUAPO8ngcKgwb8xUBiUu
 GuXMe3pYCo0hPK9Y7j7GztRE/3TjIRTAFbxLkaya+K/0BzmThVAvGkTzVBwpxdIwF9HF
 02mQ==
X-Gm-Message-State: AOJu0Yzp17IJapB7vFDJ1/ZSjNNi+fRXb7yhFNIDlSobUg0gKbX7frr3
 rLsVha5KIJkVjJoHvSWRhLNea4+e0x4fPJZjguYhygf2NCXI8cu+kpS0II0YeMhZNUP3XzGCOPM
 KyytyjoDO5AQtiKNKoQpaS+9NTSiW3QJiuaCm8zGUgc5oMeMrSVd7KS23MBT0F9PNweUFNz4otl
 vOyLxiyDVnALKgkxCJ+jaw3NGG9ibyKMwG/c9y
X-Gm-Gg: ASbGncu8BmLe/hWAQFV9DIQ5pYB6D0eoBP+DHhxxOgH18psFW10Egca4AYqsfd8C+Am
 pd5kUAUDX8bu2jG7aEhphS2uw7cJJuPIXi7AX5wX5A+PgC/g0Ql2zrNekTovw+JNEsonb/NjuBw
 zvwy0h75Jh4QtqH/8VQw/w3XwV9RBZGogLSyuj079k+IzhjLQWFCWUZlc7sXka8fYwWVJ4qVOnN
 bH4VHTDfJCsTs8eAYBCfdcwbM70jH9AbfgeuS5nTqC70U8KLFCY54wSpvWssMCKkPOGFXOj64u0
 akqcVkf5Qiuzu6A=
X-Received: by 2002:a05:6000:2912:b0:3a0:7a7c:2648 with SMTP id
 ffacd0b85a97d-3a09fd7c14amr7056397f8f.27.1746463871251; 
 Mon, 05 May 2025 09:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHS5lx0a3KqkxZ7WGqXtfUWSqZ9EzCFkuT+LJYH4GOM7j4f/xC/HoBot0crvZ41k84Her/pw==
X-Received: by 2002:a05:6000:2912:b0:3a0:7a7c:2648 with SMTP id
 ffacd0b85a97d-3a09fd7c14amr7056373f8f.27.1746463870773; 
 Mon, 05 May 2025 09:51:10 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b0f118sm10917680f8f.78.2025.05.05.09.51.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 09:51:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] ci: run RISC-V cross jobs by default
Date: Mon,  5 May 2025 18:51:08 +0200
Message-ID: <20250505165108.145222-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The riscv64-debian-cross container is based on Trixie rather than sid
these days, so it is pretty much as stable as the others.  Enable it
by default.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/container-cross.yml | 3 ---
 .gitlab-ci.d/crossbuilds.yml     | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 34c0e729ad9..e45ea17cf15 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -67,11 +67,8 @@ ppc64el-debian-cross-container:
 riscv64-debian-cross-container:
   extends: .container_job_template
   stage: containers
-  # as we are currently based on 'sid/unstable' we may break so...
-  allow_failure: true
   variables:
     NAME: debian-riscv64-cross
-    QEMU_JOB_OPTIONAL: 1
 
 s390x-debian-cross-container:
   extends: .container_job_template
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 7ae0f966f15..3f76c901ba8 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -118,12 +118,8 @@ cross-ppc64el-kvm-only:
     IMAGE: debian-ppc64el-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-devices
 
-# The riscv64 cross-builds currently use a 'sid' container to get
-# compilers and libraries. Until something more stable is found we
-# allow_failure so as not to block CI.
 cross-riscv64-system:
   extends: .cross_system_build_job
-  allow_failure: true
   needs:
     job: riscv64-debian-cross-container
   variables:
@@ -131,7 +127,6 @@ cross-riscv64-system:
 
 cross-riscv64-user:
   extends: .cross_user_build_job
-  allow_failure: true
   needs:
     job: riscv64-debian-cross-container
   variables:
-- 
2.49.0


