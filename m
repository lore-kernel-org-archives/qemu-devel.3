Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B4EFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIjY-00086A-Rz; Mon, 27 Apr 2026 05:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIjX-000844-2s
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIjV-0008Aj-Ju
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777283909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILwZ7gBkC8za9+N5E8PGnU+HMw/r8pM+wU6P+mH1Bc8=;
 b=DRAgF48fzJM77CNzFrPiArfSsaV8Igkllk2otges4oaTpT0bQPPHu2qUcvplzrB3vcBKIb
 HNhEAHz2bDrc40eSxG4rqBkTCNEwu32zQSUHgoezByjh1nJ6xXqonKqJWfPy9qTVrkMlhR
 CTWeuOhyD5s6CW1ykwXkfkjkhQRZDvI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-G27-2xdwP0e7_weHpUrCpw-1; Mon,
 27 Apr 2026 05:58:27 -0400
X-MC-Unique: G27-2xdwP0e7_weHpUrCpw-1
X-Mimecast-MFC-AGG-ID: G27-2xdwP0e7_weHpUrCpw_1777283906
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 371B918004A9; Mon, 27 Apr 2026 09:58:26 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.146])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86F0D3000707; Mon, 27 Apr 2026 09:58:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/10] tests/functional/ppc/test_ppe42: Fix warning from the
 latest version of pylint
Date: Mon, 27 Apr 2026 11:57:47 +0200
Message-ID: <20260427095747.1070244-11-thuth@redhat.com>
In-Reply-To: <20260427095747.1070244-1-thuth@redhat.com>
References: <20260427095747.1070244-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Thomas Huth <thuth@redhat.com>

The pylint from Fedora 44 found a new issue in this test:

 tests/functional/ppc/test_ppe42.py:63:20: W0101: Unreachable code (unreachable)

And indeed, the "break" is unreachable since the previous self.fail()
always aborts immediately. Thus let's remove the "break" to make pylint
happy again.

Message-ID: <20260427080731.389061-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/ppc/test_ppe42.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/functional/ppc/test_ppe42.py b/tests/functional/ppc/test_ppe42.py
index 7b360a40a54..53958a7938d 100755
--- a/tests/functional/ppc/test_ppe42.py
+++ b/tests/functional/ppc/test_ppe42.py
@@ -60,7 +60,6 @@ def _wait_pass_fail(self, timeout):
                     self.log.debug(f"Execution stopped: {e}")
                     self.log.debug("Exiting due to test failure")
                     self.fail("Failure detected!")
-                    break
             else:
                 self.fail("Timed out waiting for test completion.")
 
-- 
2.53.0


