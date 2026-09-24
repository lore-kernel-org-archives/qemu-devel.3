Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEC1C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9j1o-0005dz-DY; Thu, 24 Sep 2026 08:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x9j1e-0005bV-Bj
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 08:58:11 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x9j1b-00025n-9W
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 08:58:10 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-486e1a044c5so1659990f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790254685; x=1790859485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eQ2jaUXxCLt695OCVjTC/hWwemBJGhyhOsi1Vj4dN3c=;
 b=lOf9ysU9ctT3PzyN1IqjlWjCZf2eVKxvRYO+kQXVLjvNOVmx9NYSZNE8WjuVgzU/dL
 zUvLYnqvUQnkZDgBrImiHXoRIWpMxskoTaRTkwhnS6zA9IKq9o/kvWkch3eYA+Xd4Kim
 m4UIepOKrDkk3bhLw4H2VWbSsda1AnqNXOtcn3mRq1ZX7KXOEE9QQoyKzAw3a95kTUnF
 xT742bO8Mxl+xA4cRJMbaE0TTJoKcB+V/+ZfUe6L4uKnaR5ljCRm/BeFTrvxbfkS/46K
 TndDvOofylOv8kxf1+d/Hqgx4w9dFp1ncBHErv0vBuyh79UvI8K6CqC+ejVvuafLKO8D
 lBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790254685; x=1790859485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eQ2jaUXxCLt695OCVjTC/hWwemBJGhyhOsi1Vj4dN3c=;
 b=SaEZybmx5FDNrfbiOwgOgsA+bhRldAiLpoggprdKoHXU+CWEcx097BAPwQjdxMuwkX
 rYBjVfQtB0f+r6IxVL92WXvZozXGrPpzJGRuMqSh0KESzE6Z8/HT1Tinj1NvXaZDVj9T
 yG8uOfjxhimcUFbVh8Ihm5ewWQ9+4KlC5xEKJVqsL6iuTiWO/bSijivr+SKEcGIEOGOH
 vEZbCMQQPvfyLEUZbO/mEQzC04Cq1s4q/czxqAQItlttDQfMq2rSRG10PoWCp836Fta1
 0JI8CaSwz4vCGlpZyDG8cO+3Cczjxlws6Fhl/8ndp+8I2631zaCcCKQl9vgrPW9lrkRH
 rz8g==
X-Gm-Message-State: AFuF++nmgykuig7dv6eWOMHPBkdEiWWcJUYnuqz74gWfm3D1L4/Qg8nT
 0IWC6RyFEsh9Agn8I8LyvczLZ14Fhcp6jd5hl2l5Pbu8kM5dUUS2akJqEduUBj2L12ToDxZaAqP
 Xe+zg
X-Gm-Gg: AYBFou3d0WUfKMJ9BlRKzu47ZxNNPz2EAy4ZD//ruiskNW5zvv7jNLA0VwCiZRmFeBz
 YwP+crbQCSgi5tto+IWU0vSy8WXNkJGQRzl1DTlTjxBYUk8hi6viQ1GJ1wHB9iq3munZ44a1z0R
 L/NP/iB0M1guMoUt43HAVxDoY0O98r7PvxbxAJrowGRO0TbLyfghrrBL7nN6ivL1edA7+WIqdX/
 E6sxCh1ay8VEwR+5y4lg9tbCC38YI3h8sZ2lPHlheCDsOYTuclL/NZ9K7eJLpLQwiQQo7kikeuR
 9Dxj2J8G5Fpur8BO68QIhDplY9QevmTlhkBACzHNxcohGvV8E8CZAociOCe2P6ZebdS3HBiPUwu
 8ZerMGp1fOluD1LVeMjqzO/v1hNLukwQ1nZKGDj16A/Bkruul+nV0bMIyEYmboAbezLfIw24i3z
 JHjGmtMRG31b5Q4cVGCOxXPyVlcHwCxKGh0l1ZUof6JafJAucLm4ENAzzRsQQMrPrxamk=
X-Received: by 2002:a05:6000:3102:b0:488:64d8:bf24 with SMTP id
 ffacd0b85a97d-48871725c6bmr4183256f8f.21.1790254685167; 
 Thu, 24 Sep 2026 05:58:05 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f9ec:9c2f:7d67:4ad8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868486408sm13260821f8f.9.2026.09.24.05.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 05:58:04 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-stable@nongnu.org
Subject: [PATCH 1/2] hostmem: fix cpr-exec of VMs with bound guest memory
Date: Thu, 24 Sep 2026 14:57:59 +0200
Message-ID: <20260924125800.4188406-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924125800.4188406-1-den@openvz.org>
References: <20260924125800.4188406-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=den@openvz.org; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Denis V. Lunev <den@openvz.org>

cpr-exec kills a VM whose memory backend has host-nodes when the cgroup
no longer allows those nodes. The old QEMU saves its state, the new one
exits during startup with

  cannot bind memory to host NUMA nodes: Invalid argument

and the guest is lost.

Guest RAM survives CPR: its fd is passed to the new QEMU or its backing
file is reopened, and the pages stay where they are. For shmem-backed
memory the policy set by mbind() lives in the shared object and survives
as well. host_memory_backend_memory_complete() treats the memory as
fresh anyway: it calls mbind() with MPOL_MF_STRICT | MPOL_MF_MOVE and
preallocates again. cpr-exec keeps the PID and the cgroup, so if
cpuset.mems has been changed to nodes outside host-nodes since the VM
started, mbind() returns EINVAL and QEMU exits. Where it succeeds, it
only walks or migrates pages that are already in place, while the guest
is stopped.

Skip the NUMA binding and preallocation on incoming CPR. The source
blocks CPR while any RAM block cannot be preserved, so every backend
created in this mode is an inherited one. This covers cpr-transfer too,
where the new process may be placed in a cgroup that does not allow the
original nodes. For a file backend outside shmem the VMA policy is not
restored, which affects only pages first touched after the update.
Memory added after the incoming migration completes is back on the
normal path.

Fixes: 2b7e9739fad8 ("physmem: preserve ram blocks for cpr")
Suggested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Mark Kanda <mark.kanda@oracle.com>
Cc: Ben Chaney <bchaney@akamai.com>
Cc: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-stable@nongnu.org
---
 backends/hostmem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 02846b597d..26c7fce1cb 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -24,6 +24,7 @@
 #include "qemu/madvise.h"
 #include "qemu/cutils.h"
 #include "hw/core/qdev.h"
+#include "migration/cpr.h"
 
 #ifdef CONFIG_NUMA
 #include <numaif.h>
@@ -365,6 +366,10 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     if (!backend->dump) {
         qemu_madvise(ptr, sz, QEMU_MADV_DONTDUMP);
     }
+    /* Memory inherited over CPR already has its pages and policy */
+    if (cpr_is_incoming()) {
+        return;
+    }
 #ifdef CONFIG_NUMA
     unsigned long lastbit = find_last_bit(backend->host_nodes, MAX_NODES);
     /* lastbit == MAX_NODES means maxnode = 0 */
-- 
2.53.0


