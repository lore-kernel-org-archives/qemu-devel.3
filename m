Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2F9FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITsh-0002gA-ME; Thu, 30 Apr 2026 12:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wITrd-0008LB-8k
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wITrb-0007ID-Mm
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777565022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dDrtXQw8rbWKDXNmO/t+UeKG0DrRlla3ZJfTV7xhK+c=;
 b=S6G9yWuVEBhR1T3dfeogHO9Rp+nRb35LM8LyYkjzNFUFSYi+L0px8X2eI+lednjHMO21sm
 eiB63lO7lpX5JwBMxO9+YxrAImSg/9LHLzl0uUUV0UJPevWWaezT7QErMtnaUFgoxgqItj
 E6/e7ep+/ovoCP3mMoJSEYi9fC47Qe8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-viSdQ1kSOsWbv9ctkNPOmw-1; Thu,
 30 Apr 2026 12:03:38 -0400
X-MC-Unique: viSdQ1kSOsWbv9ctkNPOmw-1
X-Mimecast-MFC-AGG-ID: viSdQ1kSOsWbv9ctkNPOmw_1777565018
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAAFD1800601; Thu, 30 Apr 2026 16:03:37 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.50.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7AF101800446; Thu, 30 Apr 2026 16:03:36 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PULL v2 11/11] tests/functional/s390x: Update expected virtio-pci IDs
Date: Thu, 30 Apr 2026 18:03:07 +0200
Message-ID: <20260430160307.634093-12-cohuck@redhat.com>
In-Reply-To: <20260430160307.634093-1-cohuck@redhat.com>
References: <20260430160307.634093-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

Now that legacy virtio-pci is disabled by default for s390x, adjust
existing testcases to look for appropriate device IDs.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20260424132703.833249-1-mjrosato@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 tests/functional/s390x/test_ccw_virtio.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/s390x/test_ccw_virtio.py b/tests/functional/s390x/test_ccw_virtio.py
index 045533785670..1d4958bbe293 100755
--- a/tests/functional/s390x/test_ccw_virtio.py
+++ b/tests/functional/s390x/test_ccw_virtio.py
@@ -136,7 +136,7 @@ def test_s390x_devices(self):
                     r'0x1af4')
         exec_command_and_wait_for_pattern(self,
                     r'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_device',
-                    r'0x0001')
+                    r'0x1100')
         # check fid propagation
         exec_command_and_wait_for_pattern(self,
                     r'cat /sys/bus/pci/devices/000a\:00\:00.0/function_id',
@@ -203,7 +203,7 @@ def test_s390x_fedora(self):
                         'while ! (dmesg | grep enP7p0s0) ; do sleep 1 ; done',
                         'virtio_net virtio0 enP7p0s0: renamed')
         exec_command_and_wait_for_pattern(self, 'lspci',
-                             '0007:00:00.0 Class 0200: Device 1af4:1000')
+                             '0007:00:00.0 Class 0200: Device 1af4:1041')
         exec_command_and_wait_for_pattern(self,
                              'cat /sys/class/net/enP7p0s0/address',
                              '02:ca:fe:fa:ce:12')
-- 
2.53.0


