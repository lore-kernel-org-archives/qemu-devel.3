Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB0DC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 17:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmHEW-0000VN-Oc; Mon, 18 Mar 2024 13:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmHET-0000Tm-Nm
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmHES-00077n-7m
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710784627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FdiF6Ay0Y//kEppiR8e/bNkgh8x74HG5F3qOJ903Cc=;
 b=W25HwQM5wKO3Ejco9q5f5YJk770JzKy1xzRNwXs9xq6b9D+8OR+rt1i+l9QjQUzPgzwzC5
 2Blv5ytXvQlUmv5wLZgC4LruWzR7Cowh29ZhIcnqqMixmjhqFPlGmWjwKy0jcn67RazVG/
 LbvuYtsT9gIh21SveWpCVmflSOAUFbM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-dWQPopGVOFSVcJpxmYIW0g-1; Mon, 18 Mar 2024 13:57:04 -0400
X-MC-Unique: dWQPopGVOFSVcJpxmYIW0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7B3B185A789;
 Mon, 18 Mar 2024 17:57:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 027892166B34;
 Mon, 18 Mar 2024 17:57:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Claudio Fontana <cfontana@suse.de>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/4] docs/s390: clarify even more that cpu-topology is KVM-only
Date: Mon, 18 Mar 2024 18:56:52 +0100
Message-ID: <20240318175655.756084-2-thuth@redhat.com>
In-Reply-To: <20240318175655.756084-1-thuth@redhat.com>
References: <20240318175655.756084-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Claudio Fontana <cfontana@suse.de>

At least for now cpu-topology is implemented only for KVM.

We already say this, but this tries to be more explicit,
and also show it in the examples.

This adds a new reference in the introduction that we can point to,
whenever we need to reference accelerators and how to select them.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Message-ID: <20240314172218.16478-1-cfontana@suse.de>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Tested-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/introduction.rst       |  2 ++
 docs/system/s390x/cpu-topology.rst | 14 ++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index 51ac132d6c..746707eb00 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -1,6 +1,8 @@
 Introduction
 ============
 
+.. _Accelerators:
+
 Virtualisation Accelerators
 ---------------------------
 
diff --git a/docs/system/s390x/cpu-topology.rst b/docs/system/s390x/cpu-topology.rst
index 5133fdc362..d5b506ee5c 100644
--- a/docs/system/s390x/cpu-topology.rst
+++ b/docs/system/s390x/cpu-topology.rst
@@ -25,17 +25,19 @@ monitor polarization changes, see ``docs/devel/s390-cpu-topology.rst``.
 Prerequisites
 -------------
 
-To use the CPU topology, you need to run with KVM on a s390x host that
-uses the Linux kernel v6.0 or newer (which provide the so-called
+To use the CPU topology, you currently need to choose the KVM accelerator.
+See :ref:`Accelerators` for more details about accelerators and how to select them.
+
+The s390x host needs to use a Linux kernel v6.0 or newer (which provides the so-called
 ``KVM_CAP_S390_CPU_TOPOLOGY`` capability that allows QEMU to signal the
 CPU topology facility via the so-called STFLE bit 11 to the VM).
 
 Enabling CPU topology
 ---------------------
 
-Currently, CPU topology is only enabled in the host model by default.
+Currently, CPU topology is enabled by default only in the "host" CPU model.
 
-Enabling CPU topology in a CPU model is done by setting the CPU flag
+Enabling CPU topology in another CPU model is done by setting the CPU flag
 ``ctop`` to ``on`` as in:
 
 .. code-block:: bash
@@ -132,7 +134,7 @@ In the following machine we define 8 sockets with 4 cores each.
 
 .. code-block:: bash
 
-  $ qemu-system-s390x -m 2G \
+  $ qemu-system-s390x -accel kvm -m 2G \
     -cpu gen16b,ctop=on \
     -smp cpus=5,sockets=8,cores=4,maxcpus=32 \
     -device host-s390x-cpu,core-id=14 \
@@ -227,7 +229,7 @@ with vertical high entitlement.
 
 .. code-block:: bash
 
-  $ qemu-system-s390x -m 2G \
+  $ qemu-system-s390x -accel kvm -m 2G \
     -cpu gen16b,ctop=on \
     -smp cpus=1,sockets=8,cores=4,maxcpus=32 \
     \
-- 
2.44.0


