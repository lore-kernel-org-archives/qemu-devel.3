Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667E9C98314
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9j1i-0005ce-6Q; Thu, 24 Sep 2026 08:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x9j1d-0005b8-4N
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 08:58:11 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x9j1b-00025j-9R
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 08:58:08 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485b1d2874aso1616949f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790254684; x=1790859484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KOoZ+0mPYcxVyecjeLMEk6GcJA0aCj6x89UiNJaJbxc=;
 b=FwODxnnBjtbjGVLWFaIQc//CG2rVblE6lrdDuND5d/Y3fvgHw79utXlYGyMbwOPrY0
 F+zBha9p4l9AOjXTBnkYE0qiHhwNIch/rPOW+vriL24s9B/BZxhMHV5FqQ+bPj8c8cIi
 KV9rvgynhKh8uti/DCMcRplIM8PLfhwoHvyaSy+s6hU3EaNrMkrQg6EPAhGfxgDeGVIr
 cPYmTMAvYQU2RGFOCiWR82Eq+XM3Z4nlAHg8r6AmICRrkpOktIhp/krSw7TFDSCWVctm
 vRR/f+SfMuO/3Qz2yy8PiLH6YA6JNNP1tsjXeBhHUPeoNqTSYnvqLWNnnAQoH4MvMhSI
 viPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790254684; x=1790859484;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KOoZ+0mPYcxVyecjeLMEk6GcJA0aCj6x89UiNJaJbxc=;
 b=jZPMKmKGr+ZPcJz3APYsjt16p/aTaGBgxBEfHZbAk0/jY2aClfAKHY70lv2d0TdIzv
 Qx2RSd8Dr46lVEnYDbGwW2T0bcWFCPL+xWIjhTyVgHdR8CuWFSfvkJflIns2BtCYmRd5
 oLRtINDs3buZGYvvG9yTBFUXtx0M5UyIWRq28yLLhUC7pmdUNeyystCasxWBDvCTHNtf
 lw744EpodtyKujzUprTLoQSeVygW4o0DZn1KogeXL0kLxctdFZsy9FfG8qUu6lZReAvV
 UvsNAQ+w0efilOdPW8bKx/U7PfPC5dDBxfRtSiIm33GAh9muAWZc9hHbHvIifqz2z7RK
 IG5A==
X-Gm-Message-State: AFuF++mctUiDqKDqU3UnrqeBzDsk7N0RHT97yTTUgZlPBl8G/V5Cr+nq
 H7NTR0AmBDX1kpX3AR7Nz8qGGOC/cq5m8vmEAfMoUPe/ir/zuh87Fw7BTUp+Wn3iz6mwGhLFMg3
 6+2Es
X-Gm-Gg: AYBFou3jJB9+Ca2bWBxlVrZw6Z+GKkq4e6EEFyWM1IFKd7/wJmgYbV3GwQWcML/sbJT
 v9Xq3qt2MvUQqFKsFTtzyRk27hC9Jw9keME3A80x9xEi3+dx0o0GA+4q+MaecjzFjpldh/XF+XM
 0M98Rd3KbBsgPFt8iW1ip5ECFDbueKnGii2wgXotslDcZhpj7kRkY87obn6XDF95XEdxCPIFffc
 hnKv+z6ImdWcgp97EDz2ipQlPHEvOErbUOua+lK1snFxb5+DMHvTW68mz9DgC0QUK2FDo3Jbksb
 N2d/AEVVjv9d347VAjtAyiySLgFqPKGQM+or1A2Mg2IuDBlW5qM15V66o6EuuCO3RqoB7L6aHRz
 5UOLWsB0eSleBsCb+C7kvtqDIgogDqHA2e8ASKAbBOCgls5B1GdSfJnlL0s+UAGqkPQVUy3LLis
 K0UmsF4YPFzD42p9rAbXCnNw7Z5HA7N/pkYJLiQTryWsVE5QfGPo9YOu7eKHo9/nQGaKU=
X-Received: by 2002:a05:6000:2486:b0:487:27f9:829 with SMTP id
 ffacd0b85a97d-488716f6ec2mr4370719f8f.30.1790254683817; 
 Thu, 24 Sep 2026 05:58:03 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f9ec:9c2f:7d67:4ad8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868486408sm13260821f8f.9.2026.09.24.05.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 05:58:03 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, David Hildenbrand <david@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 0/2] hostmem: fix cpr-exec of VMs with bound guest memory
Date: Thu, 24 Sep 2026 14:57:58 +0200
Message-ID: <20260924125800.4188406-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We lost several production VMs during an in-place QEMU update. Each had
its guest memory bound to a host node with host-nodes. The new QEMU
re-ran mbind() on the inherited RAM, got EINVAL and exited, taking the
guest with it. The likely trigger is the host's memory manager moving
the emulator cgroup's cpuset.mems to other nodes while the VMs ran;
doing exactly that reproduces the failure.

Patch 1 stops the new QEMU from rebinding and preallocating memory it
inherited over CPR. Patch 2 adds a qtest that reproduces the failure
without root: the exec'd QEMU asks for a host node mbind() rejects,
which is what a narrowed cpuset looks like to it.

Tested with migration-test on x86_64: mode/exec/numa fails without
patch 1 and passes with it, the rest of the suite passes. A standalone
reproducer that moves a real cgroup v2 cpuset.mems between nodes while
the VM runs shows the same before and after on a four-node host.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Mark Kanda <mark.kanda@oracle.com>
Cc: Ben Chaney <bchaney@akamai.com>
Cc: Steve Sistare <steven.sistare@oracle.com>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Denis V. Lunev (2):
  hostmem: fix cpr-exec of VMs with bound guest memory
  tests/qtest/migration: add a cpr-exec test for bound guest memory

 backends/hostmem.c                |  5 ++++
 tests/qtest/migration/cpr-tests.c | 38 ++++++++++++++++++++++++++++---
 2 files changed, 40 insertions(+), 3 deletions(-)


base-commit: 942229961efea74b153c44c59188eb08375f10f1
-- 
2.53.0


