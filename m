Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68343C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTFm-0004Es-Km; Fri, 06 Jun 2025 05:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uNTFk-0004ET-Ve
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uNTFj-0000Pm-ER
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749201641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3NGrwn/gRKcPkgS4QfdvKe7fsx4O+WSlyH7us22lwi8=;
 b=IrmiMLvilsZgxYxUpLxl0R9tknYiEH5bM65s0FjYMPZ/HOGIyc+9NDPfJGtvnQNr768Tef
 FYWF0e2aXRt8NrEWsB+QPjlwiXk3lIFwgnKZr93K7tScqsZMfiIjdOA0bhOJTRXG91xSY8
 LpldSs34W1RtY3iG8MevFqBc7QnYimw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-baBMBcj0NRisgFgvP7WaVw-1; Fri,
 06 Jun 2025 05:20:39 -0400
X-MC-Unique: baBMBcj0NRisgFgvP7WaVw-1
X-Mimecast-MFC-AGG-ID: baBMBcj0NRisgFgvP7WaVw_1749201638
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 832411956088; Fri,  6 Jun 2025 09:20:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.83])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9DD7F180049D; Fri,  6 Jun 2025 09:20:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] tests/functional/test_pc_cpu_hotplug_props: Set 'pc' machine
 type explicitly
Date: Fri,  6 Jun 2025 11:20:33 +0200
Message-ID: <20250606092033.506736-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

In case the default machine has not been compiled into the QEMU
binary, the cpu_hotplug_props test is currently failing. Add a
set_machine('pc') here to make sure that the tests are correctly
skipped in case the machine is not available.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_pc_cpu_hotplug_props.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/test_pc_cpu_hotplug_props.py b/tests/functional/test_pc_cpu_hotplug_props.py
index 9d5a37cb170..2bed8ada023 100755
--- a/tests/functional/test_pc_cpu_hotplug_props.py
+++ b/tests/functional/test_pc_cpu_hotplug_props.py
@@ -26,6 +26,7 @@
 class OmittedCPUProps(QemuSystemTest):
 
     def test_no_die_id(self):
+        self.set_machine('pc')
         self.vm.add_args('-nodefaults', '-S')
         self.vm.add_args('-smp', '1,sockets=2,cores=2,threads=2,maxcpus=8')
         self.vm.add_args('-device', 'qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0')
-- 
2.49.0


