Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201ADC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1TPu-0001Qt-Ty; Tue, 01 Sep 2026 14:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1TPj-0001N0-Ki
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:40:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1TPi-0006Hd-1g
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788288053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7gMk7Rx10faxz3GbDzvUynoW3hAOa9Huij7TUgeAkM=;
 b=JxORQIGATPE9NmU8UK1MhuCCGHkb7rn2H0nqETRfC8v03wtZ7vPvBLtYKMPuUO9pJ3OJqQ
 qI4bfN4iQeHIc/r7kxHhZ6dNOZCPwNIVS/F8sfCZ/cjNqETZlm5qmWf79RVV968QnV2usE
 5uiWWKZEEbbX5pZ+iEyfIh4yco2UdLQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-jb7IUpCFOqeGqMnf3aZZRQ-1; Tue,
 01 Sept 2026 14:40:52 -0400
X-MC-Unique: jb7IUpCFOqeGqMnf3aZZRQ-1
X-Mimecast-MFC-AGG-ID: jb7IUpCFOqeGqMnf3aZZRQ_1788288050
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC1A018052F9; Tue,  1 Sep 2026 18:40:49 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 824BE18005B8; Tue,  1 Sep 2026 18:40:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 2/3] tests/../test_hotplug_blk: drop unused nic
Date: Tue,  1 Sep 2026 14:40:41 -0400
Message-ID: <20260901184043.728292-3-stefanha@redhat.com>
In-Reply-To: <20260901184043.728292-1-stefanha@redhat.com>
References: <20260901184043.728292-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniil Tatianin <d-tatianin@yandex-team.ru>

The test doesn't need any networking, so drop the net card.
Also the test will break if at some moment q35 aliase refers
to machine type with default virtio-net nic, which will clash with
virtio-blk in the test, and

   self.wait_for_console_pattern('virtio_blk virtio0: [vda]')

will not work.

Let's make the test a bit more resistant to experiments with
machine type.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20260629201332.1001055-1-vsementsov@yandex-team.ru>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/functional/x86_64/test_hotplug_blk.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/x86_64/test_hotplug_blk.py b/tests/functional/x86_64/test_hotplug_blk.py
index 7ddbfefc210..a9b43fe2e91 100755
--- a/tests/functional/x86_64/test_hotplug_blk.py
+++ b/tests/functional/x86_64/test_hotplug_blk.py
@@ -66,6 +66,7 @@ def test(self) -> None:
         self.set_machine('q35')
 
         self.vm.add_args('-accel', 'kvm')
+        self.vm.add_args("-nic", "none")  # avoid creating default nic
         self.vm.add_args('-device', 'pcie-pci-bridge,id=pci.1,bus=pcie.0')
         self.vm.add_args('-m', '1G')
         self.vm.add_args('-append', 'console=ttyS0 rd.rescue')
-- 
2.55.0


