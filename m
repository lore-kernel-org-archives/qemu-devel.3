Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11E8C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 06:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toGCD-0006YH-2P; Sat, 01 Mar 2025 01:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1toGCB-0006TL-HY
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 01:19:31 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1toGC9-0008LB-Fu
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 01:19:31 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e4d3f92250so3175160a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 22:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740809967; x=1741414767; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XsSxSAYrzzPnDc1tAweAZj8/eWqrUUQCcDLywHMV9+8=;
 b=fqeOVJU9l6xfVr5uZwsYjllhMAxkxo7oB28ubMYudMvlgPXvajEwcQ5LImwwhgUHNT
 aRwrlXRh3JLZpDbZKKvCNgdcIbyz9AuxU5tt77QNJElStdLWDSYJRan9YlCWsBfc/71D
 T0MOlCClU1T8nCtQONIYe2wY5IT8xW5p3fH86LqVWMQWS1s/5q8P8VoN8jzpaHRgljGf
 lxj02pyt2+1xBe3qBW1q68pUNkgEc4UmUWLiM+pwF+WvGkodcjBRhheKdnbkAKUqV6T5
 T9SoUE/R4A+19SLrnmp+/R5SEhT0At3U+HRCWFd/wB6hHvpqR8/5qnseDMR/jqWBr3Ng
 K5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740809967; x=1741414767;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XsSxSAYrzzPnDc1tAweAZj8/eWqrUUQCcDLywHMV9+8=;
 b=C1GJq2wiy3Tvdk0Xeg+/YiFhyD1mIr3FP6yfFCrNJN+UjA/LyAuNqeovrOsnAwCuA+
 X7rsIq101nx3VsbqI9I+EwyjY7uxDAaUf04///FrO5Qod+wBJ+XixZiQYTp8HMUCTuzM
 CNY+FeHXTRVTCkJPgdLalN3222pidBcUv9lWuchTciTo+EyeFYKOlxHj4RJzJqSvywtw
 mscVd2DHegqNBljxsa0NXxRHVqlBUUoIFKn+VCQCzdyEulDFS3/i1tv2VkT1waXYuRNk
 dMnYCfv3BxceeL7xyVWXNhDtTTeRR1qTXbFgnd9ItBky1MW/B6ou3P4ucLOV0w0Z0vLi
 Dsow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpw94fl0YAATbfpAjZQQf/iCm/Uqp3Lg3ezPYljDkbYU8wc/504GTzSNYzXWB3mOsx5QwKcHKq05Z9@nongnu.org
X-Gm-Message-State: AOJu0YxXqQS9r41oi35pGSoHzb/rur3sJ5sgRn+S7ieYixh/C05T9F3V
 lz1VVJi3VHWajxrLfdg5HL3xZ2ydY/2wld7nCylfgwrBzuWvUpHS5bbd4jdF21v6Ii+0k71DYHz
 oyr/jIel23zEMIpM/4f3ZjiPXxNI=
X-Gm-Gg: ASbGncvgiDjqbYw9Np7yv9s/WilJOHW9JNdymfVjidt7oPdHmD0XleeAC8ImwiMSOTg
 d0PrsZJ1p2URrZzZJoXmopHn2lWmORRBxQVJt6mTBt9SVuTD+ee4ctT/oEmDS+ZxGbh0jbBNJ+v
 IQeJml/GrHhQ3oFqiYKF8WMjSYow==
X-Google-Smtp-Source: AGHT+IFoRq6FRMqB9dylklwNFxI0AgaXPUA7b1MaGg2MRD/4/rnnMHL+cRQKof9FJbkoTkVjeOquTTV3m4ilJe7J12g=
X-Received: by 2002:a05:6402:5188:b0:5dc:c531:e5c0 with SMTP id
 4fb4d7f45d1cf-5e4d6b83d0emr5082919a12.27.1740809967091; Fri, 28 Feb 2025
 22:19:27 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 1 Mar 2025 14:19:15 +0800
X-Gm-Features: AQ5f1JqHAfe2Nt6yqAdnt8IuYXtLRpwDfvwNP0t3UxiQzJ3hHJS9qQhrqQs3jeI
Message-ID: <CAJSP0QUk77GViTBgBpfYH-AbAmQ5aUwi0K6UTH9iv=1mVb0Wbw@mail.gmail.com>
Subject: Kubernetes gitlab-runner jobs cannot be scheduled
To: Paolo Bonzini <pbonzini@redhat.com>, Camilla Conte <cconte@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,
On February 26th GitLab CI started failing many jobs because they
could not be scheduled. I've been unable to merge pull requests
because the CI is not working.

Here is an example failed job:
https://gitlab.com/qemu-project/qemu/-/jobs/9281757413

One issue seems to be that the gitlab-cache-pvc PVC is ReadWriteOnce
and Pods scheduled on new nodes therefore cannot start until existing
Pods running on another node complete, causing gitlab-runner timeouts
and failed jobs.

When trying to figure out how the Digital Ocean Kubernetes cluster is
configured I noticed that the
digitalocean-runner-manager-gitlab-runner ConfigMap created on
2024-12-03 does not match qemu.git's
scripts/ci/gitlab-kubernetes-runners/values.yaml. Here is the diff:
--- /tmp/upstream.yaml    2025-03-01 12:47:40.495216401 +0800
+++ /tmp/deployed.yaml    2025-03-01 12:47:38.884216210 +0800
@@ -9,6 +9,7 @@
   [runners.kubernetes]
     poll_timeout = 1200
     image = "ubuntu:20.04"
+    privileged = true
     cpu_request = "0.5"
     service_cpu_request = "0.5"
     helper_cpu_request = "0.25"
@@ -18,5 +19,6 @@
     name = "docker-certs"
     mount_path = "/certs/client"
     medium = "Memory"
-  [runners.kubernetes.node_selector]
-    agentpool = "jobs"
+  [[runners.kubernetes.volumes.pvc]]
+    name = "gitlab-cache-pvc"
+    mount_path = "/cache"

The cache PVC appears to be a manual addition made to the running
cluster but not committed to qemu.git. I don't understand why the
problems only started surfacing now. Maybe a recent .gitlab-ci.d/
change changed how the timeout behaves or maybe the gitlab-runner
configuration that enables the cache PVC simply wasn't picked up by
the gitlab-runner Pod until February 26th?

In the short term I made a manual edit to the ConfigMap removing
gitlab-cache-pvc (but I didn't delete the PVC resource itself). Jobs
are at least running now, although they may take longer due to the
lack of cache.

In the long term maybe we should deploy minio
(https://github.com/minio/minio) or another Kubernetes S3-like service
so gitlab-runner can properly use a global cache without ReadWriteOnce
limitations?

Since I don't know the details of how the Digital Ocean Kubernetes
cluster was configured for gitlab-runner I don't want to make too many
changes without your input. Please let me know what you think.

Stefan

