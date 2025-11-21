Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAD0CFA753
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 09:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNb9-0005gH-0a; Fri, 21 Nov 2025 04:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vMNb7-0005fn-19
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 04:38:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vMNb5-0004FB-JK
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 04:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763717911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCTx1vGQpJAyDkxAYG8bg085KT683MX4FhT9ozWMuSE=;
 b=P5yEKS3r3/MZM+7jNJmktDAbjHY/US8agN/YKLVnG34uqX3TY3cH1dIK2MAGl+aQF8EFOx
 OddY4rlk603ImHoz3XBzUZAr6LQz+xnvNinKw1AyqT6oeMj3h8RW6D8DH1icPby8GaRBe3
 Q2hBivAagb4yXJ+BEuM4lyjw74p/a1g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-u8LyoA81OBmVcR5SlRzTsg-1; Fri,
 21 Nov 2025 04:38:29 -0500
X-MC-Unique: u8LyoA81OBmVcR5SlRzTsg-1
X-Mimecast-MFC-AGG-ID: u8LyoA81OBmVcR5SlRzTsg_1763717908
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24EA9180009D; Fri, 21 Nov 2025 09:38:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.78])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5578430044DC; Fri, 21 Nov 2025 09:38:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/10] tests/functional/x86_64/test_memlock: Silence pylint
 warnings
Date: Fri, 21 Nov 2025 10:38:07 +0100
Message-ID: <20251121093812.280911-6-thuth@redhat.com>
In-Reply-To: <20251121093812.280911-1-thuth@redhat.com>
References: <20251121093812.280911-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pylint complains about a missing "encoding" parameter for the open()
function here, and about a missing return statement in the "except"
block (which cannot happen since skipTest() never returns). Rework
the code a little bit to silence the warnings.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251119082636.43286-9-thuth@redhat.com>
---
 tests/functional/x86_64/test_memlock.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/functional/x86_64/test_memlock.py b/tests/functional/x86_64/test_memlock.py
index 81bce80b0c4..f970a2c3095 100755
--- a/tests/functional/x86_64/test_memlock.py
+++ b/tests/functional/x86_64/test_memlock.py
@@ -69,11 +69,13 @@ def get_process_status_values(self, pid: int) -> Dict[str, int]:
         return result
 
     def _get_raw_process_status(self, pid: int) -> str:
+        status = None
         try:
-            with open(f'/proc/{pid}/status', 'r') as f:
-                return f.read()
+            with open(f'/proc/{pid}/status', 'r', encoding="ascii") as f:
+                status = f.read()
         except FileNotFoundError:
             self.skipTest("Can't open status file of the process")
+        return status
 
 
 if __name__ == '__main__':
-- 
2.51.1


