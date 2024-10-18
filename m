Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB91CD3DEA6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 18:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1rfF-0005Qv-J9; Fri, 18 Oct 2024 14:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1rf8-0005PM-Rn
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 14:25:23 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1rf5-0001zI-Ik
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 14:25:21 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20cf6eea3c0so20209955ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 11:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729275918; x=1729880718;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pyz0EFgYWp+Ectgauwm/SteapQn+DCIa+M0WuvsOpU=;
 b=ZYUnOvldQhgWNOp1oIMlbFl9V7EH3L+Ac3CVD9MocmO7UvRwEScPG5Q7aEXv/MhZIZ
 fPsDhWLmrj8liJ6g1x1eNbdXZDlmOnB6uf1IVhqlAStP5ePga/pxPwpFI28UjWTtyjo9
 6qokTTOBDBp0RjkYaRVTikQqaA+8jZ0yJKBfGrGGss06uC5F02+YPqjQoOjjE9sa8qHs
 ey4xPHEcNLt3yh+4KuNaJALulJFc9MhJZPcYah6e+f8KZbOTeIezovbRRI0z/kJ8mRcc
 gG5yqWkjfTZxd6uCA2ZnXhFscMas9KsehtPoWuIqOVaCFd2LMY7BGnUYcOnCisOX4t69
 WUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729275918; x=1729880718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2pyz0EFgYWp+Ectgauwm/SteapQn+DCIa+M0WuvsOpU=;
 b=Ls2zlvD49W4EdngODiWps+ssJY/NzB9nKeIdUVV4X5oFCrcWXbDNGJK9Cgs1vOWxJi
 O7eIcQTKxcPFvM4Jnqe4BrDozLdLwzK+erT3vPTgZ0J1IdkEv6d4zzanT40pZXU4pp9e
 RwYpp9R0p3giFwDTkMJtvsBtSBBMgEE/BGn9YIh/SBlQIuvqZoUh6mGIcdBFzDS0c8+f
 GVEg1W1S6zJbZ8Yx5Z/GxDazFdAEiL0TzNMA9ufUgyfZ2BmBeKr5JpVyPFSP+36ZHYNZ
 AB1zHVK3fHlU/dk5nL+gml/xk8dqEi+QKNCMF8i+UV9SnA78ODksJtm8ppOGB57fn6SY
 aC2g==
X-Gm-Message-State: AOJu0YwPB2ICPUMdK5u697K6/DvCzR/1T4RLYvu1HqxaODXomhjckX4g
 osSTMyD84uRmjNgtCOCBozLNNBj05klvGf5q3FA9HZ4i5yvFnQKqAqe6MzMlKOLbnbuRy82WpC8
 e9lXnQQ==
X-Google-Smtp-Source: AGHT+IEhNzSJ48glKIw/gGco0NbvDH1koK/rB1bN9TLW+O4aIeX2keEnOTZtpBY9MdCZH4Djjjd83Q==
X-Received: by 2002:a17:902:e80c:b0:202:26d:146c with SMTP id
 d9443c01a7336-20e5a71b6ecmr38963315ad.5.1729275917276; 
 Fri, 18 Oct 2024 11:25:17 -0700 (PDT)
Received: from localhost.localdomain ([118.114.60.204])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e5a8f2034sm15668475ad.193.2024.10.18.11.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 11:25:17 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v2 2/5] tests/migration: Make initrd-stress.img built by
 default
Date: Sat, 19 Oct 2024 02:25:04 +0800
Message-Id: <777e9f8e3fe4d0e565cf62efbef6cda83a6b06a4.1729275266.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1729275266.git.yong.huang@smartx.com>
References: <cover.1729275266.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The initrd-stress.img was compiled by specifying the target,
to make it easier for developers to play the guestperf tool,
make it built when dependencies suffices.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 tests/migration/meson.build | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/tests/migration/meson.build b/tests/migration/meson.build
index a91aa61c65..d9e5b0d241 100644
--- a/tests/migration/meson.build
+++ b/tests/migration/meson.build
@@ -1,18 +1,25 @@
+sysprof = not_found
+glib_static = not_found
+
 sysprof = dependency('sysprof-capture-4', method: 'pkg-config', required: false)
 glib_static = dependency('glib-2.0', version: glib_req_ver, required: false,
                          method: 'pkg-config', static: true)
 
-stress = executable(
-  'stress',
-  files('stress.c'),
-  dependencies: [glib_static, sysprof],
-  link_args: ['-static'],
-  build_by_default: false,
-)
 
-custom_target(
-  'initrd-stress.img',
-  output: 'initrd-stress.img',
-  input: stress,
-  command: [find_program('initrd-stress.sh'), '@OUTPUT@', '@INPUT@']
-)
+if host_os == 'linux' and sysprof.found() and glib_static.found()
+    stress = executable(
+      'stress',
+      files('stress.c'),
+      dependencies: [glib_static, sysprof],
+      link_args: ['-static'],
+    )
+
+    custom_target(
+      'initrd-stress.img',
+      output: 'initrd-stress.img',
+      input: stress,
+      command: [find_program('initrd-stress.sh'), '@OUTPUT@', '@INPUT@'],
+      build_by_default: true,
+      depends: [stress],
+    )
+endif
-- 
2.39.1


