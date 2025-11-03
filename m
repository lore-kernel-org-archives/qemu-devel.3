Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFCACCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 14:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFvHi-0004cy-Dj; Mon, 03 Nov 2025 09:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vFryn-00072J-O6
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:40:05 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vFryk-000815-As
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:40:05 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EA7A541526
 for <qemu-devel@nongnu.org>; Mon,  3 Nov 2025 10:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00831C4CEE7;
 Mon,  3 Nov 2025 10:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762166390;
 bh=4jHwiL+1wC9HdU+GgZS3VLhOjPisvj2rwIR5l1J1/JI=;
 h=From:To:Cc:Subject:Date:From;
 b=VoEKfZ80OlRNzTSyQ3bjsw6qIbKhBo8IzZ2MJAi1Xmg2lqqT9WzDTTBclIY3SAGZ5
 uYNZrDhtxixgBn68e+rj08CoLg/J+3Bdn7KrGdKeTx96+h3vmiXFOauur4HKB1GUI4
 PbG+CnhBcIJ1K01SD49mgI2b8pvipqprC7Xgdaj4+wXJkRwhmxofAU5Zhjoywhl6F2
 n9GJhiCa+BIxtdxbrWcFxWVm8q7AiTB5BjrM1SPTYRAR/3uyUSdnyOQ5nyeX+8esg2
 AYqa2dJjkVxkPh9SpOHGiwrkRPWCEMJtJG11t2kaE/4tqanuKnxNdcx/XPWlttvM9e
 Vw7baaJFCdpbg==
From: David Hildenbrand <david@kernel.org>
To: qemu-devel@nongnu.org
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: [PATCH] MAINTAINERS: Update David Hildenbrand's email address
Date: Mon,  3 Nov 2025 11:39:46 +0100
Message-ID: <20251103103947.384401-1-david@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=david@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 03 Nov 2025 09:11:45 -0500
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

From: "David Hildenbrand (Red Hat)" <david@kernel.org>

Switch to kernel.org email address as I will be leaving Red Hat. The
old address will remain active until end of January 2026, so performing
the change now should make sure that most mails will reach me.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 .mailmap    |  1 +
 MAINTAINERS | 18 +++++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/.mailmap b/.mailmap
index 7f817d9f42..0690f7be34 100644
--- a/.mailmap
+++ b/.mailmap
@@ -82,6 +82,7 @@ Brian Cain <brian.cain@oss.qualcomm.com> <bcain@quicinc.com>
 Brian Cain <brian.cain@oss.qualcomm.com> <quic_bcain@quicinc.com>
 Christian Borntraeger <borntraeger@linux.ibm.com> <borntraeger@de.ibm.com>
 Damien Hedde <damien.hedde@dahe.fr> <damien.hedde@greensocs.com>
+David Hildenbrand <david@kernel.org> <david@redhat.com>
 Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
 Frederic Konrad <konrad.frederic@yahoo.fr> <fred.konrad@greensocs.com>
 Frederic Konrad <konrad.frederic@yahoo.fr> <konrad@adacore.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index a6a1d36f52..0c35509337 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -364,7 +364,7 @@ F: target/rx/
 
 S390 TCG CPUs
 M: Richard Henderson <richard.henderson@linaro.org>
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 R: Ilya Leoshkevich <iii@linux.ibm.com>
 S: Maintained
 F: target/s390x/
@@ -1861,7 +1861,7 @@ F: target/s390x/ioinst.c
 L: qemu-s390x@nongnu.org
 
 S390 CPU models
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 S: Maintained
 F: target/s390x/cpu_features*.[ch]
 F: target/s390x/cpu_models.[ch]
@@ -2383,7 +2383,7 @@ F: tests/functional/x86_64/test_virtio_version.py
 
 virtio-balloon
 M: Michael S. Tsirkin <mst@redhat.com>
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 S: Maintained
 F: docs/interop/virtio-balloon-stats.rst
 F: hw/virtio/virtio-balloon*.c
@@ -2531,7 +2531,7 @@ F: hw/virtio/virtio-crypto-pci.c
 F: include/hw/virtio/virtio-crypto.h
 
 virtio based memory device
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 S: Supported
 F: hw/s390x/virtio-ccw-md.c
 F: hw/s390x/virtio-ccw-md.h
@@ -2540,7 +2540,7 @@ F: hw/virtio/virtio-md-*.c
 F: include/hw/virtio/virtio-md-pci.h
 
 virtio-mem
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 S: Supported
 W: https://virtio-mem.gitlab.io/
 F: hw/virtio/virtio-mem.c
@@ -2918,7 +2918,7 @@ L: qemu-s390x@nongnu.org
 S390 floating interrupt controller
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: hw/intc/s390_flic*.c
@@ -3246,7 +3246,7 @@ T: git https://gitlab.com/stsquad/qemu gdbstub/next
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Xu <peterx@redhat.com>
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Supported
 F: include/system/ioport.h
@@ -3266,7 +3266,7 @@ F: system/ram-block-attributes.c
 F: scripts/coccinelle/memory-region-housekeeping.cocci
 
 Memory devices
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 M: Igor Mammedov <imammedo@redhat.com>
 R: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
 S: Supported
@@ -3369,7 +3369,7 @@ R: Ilya Maximets <i.maximets@ovn.org>
 F: net/af-xdp.c
 
 Host Memory Backends
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 M: Igor Mammedov <imammedo@redhat.com>
 S: Maintained
 F: backends/hostmem*.c

base-commit: 53b41bb78950912ba2d9809eef6b45e4df30c647
-- 
2.51.0


