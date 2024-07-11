Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD56BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 11:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRrt1-0002B1-83; Thu, 11 Jul 2024 07:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sRrsz-00023M-6R
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sRrsk-0000Ho-7w
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720696956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YU7xs11XhRlHNIpzICKn4uyHn0I3g/6fy33p2Sv/Cqg=;
 b=IMQ+KtQods7TVkz8GLMmgoZKc/uEB3r2/6Z8EKv2GaWsgor262umfkpfXZpVKYxg18dcdj
 0cMqeSIRo3e6LYPwjbe/yr2v5VSW8a+zC8ugR3X7R/NvtNAXTliQOQBCg0Ltfo6O6zsunI
 4fo1O1Kz/5cqgefBq5n3FDpiZ/6stBQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-mz5mCdS1OFCBes5FPBLitA-1; Thu,
 11 Jul 2024 07:22:32 -0400
X-MC-Unique: mz5mCdS1OFCBes5FPBLitA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AC621955F65; Thu, 11 Jul 2024 11:22:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D25E3000184; Thu, 11 Jul 2024 11:22:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C07F521E6601; Thu, 11 Jul 2024 13:22:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, eblake@redhat.com, mst@redhat.com,
 berrange@redhat.com, marcandre.lureau@redhat.com, jsnow@redhat.com,
 imammedo@redhat.com
Subject: [PATCH 2/5] qapi/machine: Clean up documentation around
 CpuInstanceProperties
Date: Thu, 11 Jul 2024 13:22:25 +0200
Message-ID: <20240711112228.2140606-3-armbru@redhat.com>
In-Reply-To: <20240711112228.2140606-1-armbru@redhat.com>
References: <20240711112228.2140606-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

CpuInstanceProperties' doc comment describes its members as properties
to be passed to device_add when hot-plugging a CPU.

This was in fact the initial use of this type, with
query-hotpluggable-cpus: letting management applications find out what
properties need to be passed with device_add to hot-plug a CPU.

We've since added other uses: set-numa-node (commit 419fcdec3c1 and
f3be67812c2), and query-cpus-fast (commit ce74ee3dea6).  These are not
about device-add.

query-hotpluggable-cpus uses CpuInstanceProperties within
HotpluggableCPU.  Lift the documentation related to device-add from
CpuInstanceProperties to HotpluggableCPU.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index f15ad1b43e..50ff102d56 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -960,9 +960,7 @@
 ##
 # @CpuInstanceProperties:
 #
-# List of properties to be used for hotplugging a CPU instance, it
-# should be passed by management with device_add command when a CPU is
-# being hotplugged.
+# Properties identifying a CPU.
 #
 # Which members are optional and which mandatory depends on the
 # architecture and board.
@@ -996,9 +994,6 @@
 #
 # @thread-id: thread number within the core the CPU  belongs to
 #
-# .. note:: Management should be prepared to pass through additional
-#    properties with device_add.
-#
 # Since: 2.7
 ##
 { 'struct': 'CpuInstanceProperties',
@@ -1020,7 +1015,8 @@
 #
 # @type: CPU object type for usage with device_add command
 #
-# @props: list of properties to be used for hotplugging CPU
+# @props: list of properties to pass for hotplugging a CPU with
+#     device_add
 #
 # @vcpus-count: number of logical VCPU threads @HotpluggableCPU
 #     provides
@@ -1028,6 +1024,9 @@
 # @qom-path: link to existing CPU object if CPU is present or omitted
 #     if CPU is not present.
 #
+# .. note:: Management should be prepared to pass through additional
+#    properties with device_add.
+#
 # Since: 2.7
 ##
 { 'struct': 'HotpluggableCPU',
-- 
2.45.0


