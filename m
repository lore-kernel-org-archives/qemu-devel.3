Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B48CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKsT-0006NA-0G; Wed, 27 Aug 2025 14:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKr1-00053E-2S
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqy-0005tA-6d
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756319189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fqYri6BWcZQpyJK93BE5DMq9o6ryLgJFbTh9+wKuwAk=;
 b=JHcbkYCCKbgcO629rNrBPzVgzZ0SeYx2+RITXLrMuWipDGa45nw21JfO57IRk5X6AQlA+b
 nECAV8iYikWA4zU2rUZxQEaq0p7MwYakdKLNy0vRZN4mVZwZA+AhCTUX4O96NKVogVbDw0
 JfDK6mvZdOEn+7Mv8xmrkXbuM+Cfnco=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-Tk9lQ19BNGSn0IrG4MN_0Q-1; Wed, 27 Aug 2025 14:26:27 -0400
X-MC-Unique: Tk9lQ19BNGSn0IrG4MN_0Q-1
X-Mimecast-MFC-AGG-ID: Tk9lQ19BNGSn0IrG4MN_0Q_1756319187
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45a1b0c5366so477865e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 11:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319185; x=1756923985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fqYri6BWcZQpyJK93BE5DMq9o6ryLgJFbTh9+wKuwAk=;
 b=vmcmVljo8i13c8n7uKRR/TJIcq9w4LSjsRt9opuv0k0w9mg4M233Azkz784RVcHL82
 aQ8jwsSbHeGGEKYq5+ezr0tujnMPGPKjOTFd576vug45Tpx05aq9VJVrAQO2QZxMO1JV
 NT74bYrdN0w1u7ZgV4B3byewNOR0Iti0A9jrhn64AZ973NwRE+jLLbPXirQoqHvj+lhm
 G2O7RYiBjfoWUP3pUT8xLTnTFFySGCkR987HKbr7op+cDq5SbgPJaYdd1HiDWTcCh5Ko
 M853XjVS5vSobQqtsxhtRCnSN6Ejtr/QeFSrVzn8HR/8UczUAY6KRbafvFupMfcjJlpi
 1XNQ==
X-Gm-Message-State: AOJu0Yyd36jOuVxY2DDe64NMxcBiAwQZdosw/7UTiyiZgJfVg1o/RpoM
 4kgNIOZLk8oKd9hd049gvK3F2yF1ZnP9X3DxvX8dNu14D7KP9TEAZq+xFlIPZaNvh3fK8vxPxxs
 wqLTcfo9d/uGWbl0nWpIX4sAdJkgACss8KU779BFR3sz0PhXyUbLZK2xM00ByovKofTLxdA2C1M
 WMyB6YLq8bk5mBk/Ja+myLQsSsf8ZQyb5UMhnKH4tv
X-Gm-Gg: ASbGnct+oyqT+t/PglLhfoAnpCx6gsGy+tMjdSLY4TSkHjoQ9GTxnArG4oKRx+1iKgz
 m9SgkGGiYUPM/7Sp0CPa9qsFRJEIWmvySWPngxtjVjEAu6JDvJyFIW/LMnc/NTJJVfR/tew3ddN
 vQm4mvim4QjQN4LCw+BfNd1WcWhdMemZuk1UrG8YOZCn7w2yJriU4gVW8l5P3WpEqm96F6EyZ43
 NL9waiwVR615ZqGwXjxmFfP0kmP6m0jayPankTVx5dz663X+vKaNc+1qVLzBdFdctnuA8K8eWkJ
 4mpdBS6Oikl/braGaYbGGhLHb/4w8DC/dd7/cO5ldg9bxxaXNuHx+AIZ7CtQCdA3yHprVRb6mGj
 JkjjC9iJ0r0E+vlhsk+P/mIKZjHgYx2NgVoR+5tylDtA=
X-Received: by 2002:a05:600c:198f:b0:459:d709:e5cf with SMTP id
 5b1f17b1804b1-45b5179b710mr179534315e9.3.1756319185368; 
 Wed, 27 Aug 2025 11:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUXMoEJo1IMjF6tXa5IJ+ZayVhLQmhuCPa4ACRe/QXofH5nzZIgVDg9FNYnQI50S8UYCNwew==
X-Received: by 2002:a05:600c:198f:b0:459:d709:e5cf with SMTP id
 5b1f17b1804b1-45b5179b710mr179534135e9.3.1756319184916; 
 Wed, 27 Aug 2025 11:26:24 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c8bedsm42499075e9.1.2025.08.27.11.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:26:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 14/14] rust: move dependencies to rust/Cargo.toml
Date: Wed, 27 Aug 2025 20:25:32 +0200
Message-ID: <20250827182533.854476-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827182533.854476-1-pbonzini@redhat.com>
References: <20250827182533.854476-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As more crates start using the same dependencies, it's better to not
repeat the versions and move the dependency declarations to the workspace.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml          | 5 +++++
 rust/qemu-api/Cargo.toml | 6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 0a83db15356..6f8884eb30b 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -15,6 +15,11 @@ license = "GPL-2.0-or-later"
 repository = "https://gitlab.com/qemu-project/qemu/"
 rust-version = "1.77.0"
 
+[workspace.dependencies]
+anyhow = "~1.0"
+foreign = "~0.3.1"
+libc = "0.2.162"
+
 [workspace.lints.rust]
 unexpected_cfgs = { level = "deny", check-cfg = [
     'cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)',
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index db7000dee44..c07a17a28b0 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -15,9 +15,9 @@ rust-version.workspace = true
 
 [dependencies]
 qemu_api_macros = { path = "../qemu-api-macros" }
-anyhow = "~1.0"
-libc = "0.2.162"
-foreign = "~0.3.1"
+anyhow = { workspace = true }
+foreign = { workspace = true }
+libc = { workspace = true }
 
 [features]
 default = ["debug_cell"]
-- 
2.51.0


