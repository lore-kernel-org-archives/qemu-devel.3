Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBB4CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrJv-0001Gl-9o; Mon, 08 Apr 2024 11:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJp-0001FB-Eo
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJn-0001p1-Ax
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJPHrQ8+mHkfrSj8BF/mqVdGQxHQdb/HXh0jjzSiGaA=;
 b=XSvV66CKkAIKMATkC9MZXq2qoYQVkz+vzkUlJuhcQ4+ktq4Pn+QvNHiIBjrCj4CkLSiMAK
 fMPH6EVPdgP+SxOrmUD+r4NH44h+y5ql7tLjB4bYYB2taDFSjQjmWk5fFefqVlHf1ysh9k
 6XvsbUmDkGVjIszxgL+zVg42703llL0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-kOQl6fynNaquwfxDkwQyGw-1; Mon, 08 Apr 2024 11:53:57 -0400
X-MC-Unique: kOQl6fynNaquwfxDkwQyGw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4140225e68aso23372805e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591635; x=1713196435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rJPHrQ8+mHkfrSj8BF/mqVdGQxHQdb/HXh0jjzSiGaA=;
 b=jZVTair0QVpiN6/18+V4G5JmlsMunNPdO55UvaliR1lW/eIuv1Ie9kVINpuvnkLnQ3
 /mhShsQmMs/fZRv8AR5hmsQ0OmZpTvCuTJF981S02nAX8b7Owh/mSuIZgIa1Zk2M0w+J
 mH3zEJf7NPlhcN2ern7Obzya2jT1K9NSBlLaPlJXaBfePbRrWevw+SCQtFi9NW1Haj/D
 34GJc8QuwhPOqpSEkfHMraq8dCWp7xGupNmv/zCDAyAAguEkZXcaf0MZkXBBKXVoZfFw
 HrwbsXadrWibiwQfPIelBveqr23/SFSJMAAEMPMJQ81cV09Gf+Zs8HFy5e48uRUxW674
 iXdg==
X-Gm-Message-State: AOJu0YwlJ2S6Tjr958JWGKv1u9BmSttNyt+XfzLh/+lDFyLuFaAwyIN/
 VYNPtXvqpC/3u/enbK+m95fc/84zsYJz7afvjuCcPrtxC7xfqe7ZUnXlfG+vAkg9YKfrfjvuPnn
 05RVbIKKchU7eHJXPYdqDSHwn8XypofOIIYAal+RMtGLpLs4I3UYLzZrK53ZlTJWF4KgRYs4jeg
 QrP9acMwi2aILXVwQDKUYv1/HxEIIMXH9y/ukv
X-Received: by 2002:a05:600c:3584:b0:416:4933:c8be with SMTP id
 p4-20020a05600c358400b004164933c8bemr4374169wmq.28.1712591635491; 
 Mon, 08 Apr 2024 08:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5wYFu6MIfTnHU0R6dfjN/UNY4U1z9V1g6U1D7WJVIZAp2DTyo6EMgSNUMnthRVhSOznuEqA==
X-Received: by 2002:a05:600c:3584:b0:416:4933:c8be with SMTP id
 p4-20020a05600c358400b004164933c8bemr4374156wmq.28.1712591635164; 
 Mon, 08 Apr 2024 08:53:55 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 fl9-20020a05600c0b8900b004167df5ed4bsm2877348wmb.29.2024.04.08.08.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:53:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 07/18] hw/core: Move system emulation files to system_ss
Date: Mon,  8 Apr 2024 17:53:19 +0200
Message-ID: <20240408155330.522792-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408155330.522792-1-pbonzini@redhat.com>
References: <20240408155330.522792-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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

hotplug.c, qdev-hotplug.c and reset.c are not used by user emulation
and need not be included in hwcore_ss.  Move them to system_ss, where
they belong, by letting the linker pull in the stubs when needed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 {hw/core => stubs}/hotplug-stubs.c |  0
 hw/core/meson.build                | 14 +++-----------
 stubs/meson.build                  |  1 +
 3 files changed, 4 insertions(+), 11 deletions(-)
 rename {hw/core => stubs}/hotplug-stubs.c (100%)

diff --git a/hw/core/hotplug-stubs.c b/stubs/hotplug-stubs.c
similarity index 100%
rename from hw/core/hotplug-stubs.c
rename to stubs/hotplug-stubs.c
diff --git a/hw/core/meson.build b/hw/core/meson.build
index e26f2e088c3..f20d4143f7a 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -3,7 +3,6 @@ hwcore_ss.add(files(
   'bus.c',
   'qdev-properties.c',
   'qdev.c',
-  'reset.c',
   'resetcontainer.c',
   'resettable.c',
   'vmstate-if.c',
@@ -12,16 +11,6 @@ hwcore_ss.add(files(
   'clock.c',
   'qdev-clock.c',
 ))
-if have_system
-  hwcore_ss.add(files(
-    'hotplug.c',
-    'qdev-hotplug.c',
-  ))
-else
-  hwcore_ss.add(files(
-    'hotplug-stubs.c',
-  ))
-endif
 
 common_ss.add(files('cpu-common.c'))
 common_ss.add(files('machine-smp.c'))
@@ -40,6 +29,7 @@ system_ss.add(files(
   'cpu-sysemu.c',
   'fw-path-provider.c',
   'gpio.c',
+  'hotplug.c',
   'loader.c',
   'machine-hmp-cmds.c',
   'machine-qmp-cmds.c',
@@ -48,7 +38,9 @@ system_ss.add(files(
   'null-machine.c',
   'numa.c',
   'qdev-fw.c',
+  'qdev-hotplug.c',
   'qdev-properties-system.c',
+  'reset.c',
   'sysbus.c',
   'vm-change-state-handler.c',
   'clock-vmstate.c',
diff --git a/stubs/meson.build b/stubs/meson.build
index 0bf25e6ca53..f87f5c1110f 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -14,6 +14,7 @@ stub_ss.add(files('fdset.c'))
 stub_ss.add(files('gdbstub.c'))
 stub_ss.add(files('get-vm-name.c'))
 stub_ss.add(files('graph-lock.c'))
+stub_ss.add(files('hotplug-stubs.c'))
 if linux_io_uring.found()
   stub_ss.add(files('io_uring.c'))
 endif
-- 
2.44.0


