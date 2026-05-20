Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043B2CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPopr-00056F-UR; Wed, 20 May 2026 17:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPopp-0004nJ-G5
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPopn-0004kT-MJ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OmN3Rq6q8nx3rcgb/VkzKyF1bVfGMUlyaVZDpJTV74g=;
 b=DeOo9K9v1ZZ7ashtY4Ezrmrz7AGXBY8hqFXpFFF1IbsYN9Vv2ravKlHWrGPU/ewS2H0KqL
 KkCGQdm+t/PETeCUwLW0utIGzAKXS+qruqLjCa83RO+oQd1cYDzDwyNYEDZbTus33fLS+V
 KsMZTba09y92ZgCFec35Z2gx2eK7UG4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-eb0gjaDmMhuRrKjLstBw9Q-1; Wed,
 20 May 2026 17:52:09 -0400
X-MC-Unique: eb0gjaDmMhuRrKjLstBw9Q-1
X-Mimecast-MFC-AGG-ID: eb0gjaDmMhuRrKjLstBw9Q_1779313928
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28B951956053
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:52:08 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B34AC1800576; Wed, 20 May 2026 21:52:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:21 +0400
Subject: [PATCH 20/40] tests/qemu-iotests: skip some 172 & 267 that require HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-20-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1641;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NGxmYJ1VFBEMXJFRX4TSmkJYX96YWqQbv5XRveZIpvY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyDVRYXgUkPsTKRz1OOzhO6pBsIkEz+sl8RN
 B8slV420W2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sgwAKCRDa6OEJdZac
 5VI4D/9EszIJE3XaphXpTssq+9BS+EbwC08gVnBPoFhOGm87eupidEVtNSkuJt97AL3j3dePzTa
 knlMwHh55jYrVgynxlMhQu4qTK13Zx3QHbOlCQeroxPCQMyaXLe4+0I8Hs0P45u4bpbj0AoYgs4
 GGej/P4uE94+bxYQZTkfvr7oLu3yaBCAwEkTy4XZAL6FdOtPcpbN946XnrShAZl1E4xJIFcVsS0
 eA1YMjeLesuvIYMK+qGGZOQbpiu0SEQlb8ReboDGbZGRqqBIEESkYYxhbJEEhHwv7QcYcAK8SQT
 uZvvHzdffbvQFjhet0ltMr4EAYfUACdZnQY4WUTJrLkNkPkkapzNyFR+Ubrts9UpZ1BYOxSn7al
 k45fqNKyhu2RYHIJuDL455CyxGJh0BSdsj6pAhD2NVU3szIYjumJ/yJSi1WqdowsDhLgZn/L9Ls
 pSYz+SGw0JunT5jTyewVrqnhSaGX2PzMbvohEP7kLkMZgi+eRQAq7CvXK/sPTECG5in2v0Mx44F
 HZklwoOcHevqA+w6C4apCgj55uGuFeHiNbVpRN6fAOi2zwx7q3GLRGNRvZ0oqoFLSQnYW6eMXc7
 mLFGwfv/WAdxoik32Hi8QLlM+JUmcLGMgYKahsy4E9SefViOZGyUsFeETZT3sJxDhK3fBHDsB4b
 kW3OTtU9uQXuJlA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/172       | 5 +++++
 tests/qemu-iotests/267       | 4 ++++
 tests/qemu-iotests/common.rc | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 4da0e0f2e29..40298c0d7c3 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -39,6 +39,11 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
 
+# HMP: info block & info qtree
+# rewrite with qom-list/get + query-block is possible,
+# but hardly in bash
+_require_hmp
+
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
index 2e2afdad9c5..ff8eed0a44b 100755
--- a/tests/qemu-iotests/267
+++ b/tests/qemu-iotests/267
@@ -38,6 +38,10 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
 
+# HMP: savevm/loadvm, info snapshots
+# TODO: rewrite with QMP snapshot-save/load
+_require_hmp
+
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 731e4b2b998..4f51a22f8df 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -1067,6 +1067,13 @@ _require_secret()
     rm -f "$TEST_IMG"
 }
 
+_require_hmp()
+{
+    if ! echo quit | $QEMU -M none -monitor stdio > /dev/null 2>&1; then
+        _notrun "HMP monitor not available"
+    fi
+}
+
 _qcow2_dump_header()
 {
     if [[ "$1" == "--no-filter-compression" ]]; then

-- 
2.54.0


