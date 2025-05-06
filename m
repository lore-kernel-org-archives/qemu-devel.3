Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69FFC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKFh-0004T6-5T; Tue, 06 May 2025 11:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFA-0003rM-Ta
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKF8-0001zD-Pe
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3rTk5QqsJiLGicX/ZNrIaBcoFpzE0SDxObclyMNKwg=;
 b=UWRMjbgI8siuWVL9X3bwJUKUETYC4WR8V4fIy9taOIWyvrTs01jK7GMxeETcBD7CQNZKKQ
 IzrDA7/X3ivoqshMe/oPz++tFjZuBI1MPyBdKPE+pJLK5U127l28s18cOVnFueLN+pk0Qr
 gdRGMz7nXeEaSUm6WIwJKJY3wyIAKV8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-cdieWZqTN9qNbECaTduzKQ-1; Tue, 06 May 2025 11:29:58 -0400
X-MC-Unique: cdieWZqTN9qNbECaTduzKQ-1
X-Mimecast-MFC-AGG-ID: cdieWZqTN9qNbECaTduzKQ_1746545398
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d734da1a3so27177555e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545397; x=1747150197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K3rTk5QqsJiLGicX/ZNrIaBcoFpzE0SDxObclyMNKwg=;
 b=L2bQUJXxMrY/yeZwwDw/8p6u1f8OF3LdrVMpp4WXwez9mKhf++DDBPYjgQ0gFfwQ1t
 NydZNJPy2D6GmLoD1qfAyOJmAvShiDYfwtE4MR/T406g3vAS5s7s0oeS2zqD3sfNHbYy
 QjuZtuzaLIfkX7TW0mD7AuD8NMYmZBXJsiEDqhgUTuxyITbFYIlqfna/Bf1DDSrMc9zT
 hpyITcRmD4luKBIGSKoWplfHHb/UAL3Jp4wyDO5ub5FJLCqxf8RAzun7qpCOTHluP5i/
 GVaRr3+fr71poR4lCaaWyNV45CTIwYF9RjPizICSG3Lp9enM5bbDVnt4vXPTTi5ckw01
 WMxw==
X-Gm-Message-State: AOJu0YxfZt/Pp7UvG1enjNmeagt+VxvGfCjMuKFMn9KetCXHZYwM8fac
 Ax2+dwuTDlThURV7IETz0HqdRt60rXQyg7ymlbQWEbnBZ+9PONMWn3Of7WeA1eeDApeKHmNk/dY
 8NPrnbTZogX8pXjYsfmmYrFX8ovrVO+8dx+UgtiryelSpdVGTxVs37nmZLKGY/FtdyBdQEhO7t4
 OGCzyGHJ9FUMXJgAOhR8TjtOgLuNxb0J1lHz4R
X-Gm-Gg: ASbGncs0VMFOEfWMwBf5sxbPLGJy7DtbdA+vVU/ODqp1KOD60q2ZtZXhbB3KWkr6IMj
 iTuNwH6/EWaHufrvUJgIQD8lRHb+p4+8trZggWmdKw1Cxobxal6uVN9hjg+ZHVhEf9eaj+X3qql
 JQIrDQ7Q6puJkOSCVPq+ZfmSC2IjPkkGjn4oyKzlwW9dXF3N5p9OpE+ALZBN/vqNh8GqB9eWgcZ
 PiAuXM1643s0OMXgLcQc94ABjCmLIPP2pXnDQF5zT1oEmq6YgN24KvE38jm2A3cd2KC/B54b05J
 TbgdciHI7rlQoMA=
X-Received: by 2002:a05:600c:3e17:b0:440:59eb:bfc with SMTP id
 5b1f17b1804b1-441d0530c30mr31905315e9.23.1746545397270; 
 Tue, 06 May 2025 08:29:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnKLz1F3y4aosjymx1MGac8KnnqpDg/ZYKgrmn2Fjlj1sW/dW9IN4od38HGaMcl1CE2dxxxQ==
X-Received: by 2002:a05:600c:3e17:b0:440:59eb:bfc with SMTP id
 5b1f17b1804b1-441d0530c30mr31905115e9.23.1746545396810; 
 Tue, 06 May 2025 08:29:56 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2aecc89sm218058485e9.9.2025.05.06.08.29.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:29:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/30] ci: run RISC-V cross jobs by default
Date: Tue,  6 May 2025 17:29:09 +0200
Message-ID: <20250506152927.222671-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
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


