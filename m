Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E5BCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9QoG-0002yj-MV; Thu, 16 Oct 2025 12:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9QoA-0002vG-7X
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:26:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9Qo0-0004xJ-Aq
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760631975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O/css4uNLShECazgAKMC4h2UPl+GLrtsLpe+TFns7Ps=;
 b=LsDBQExxrlh1qg0Cq+CPUrSlCCM8LA7RRZLtuyEZS2Qs4LvpoGsQZXM9LQvl85lockmzz4
 CDGoEJLvy7kwSej/Z5D6nB45T3NmUoydRHuINJiju3CIN0F3S3AKys2IRiQpb/gSDaZFp9
 Yg7VnAOvjBgGcJAhSjUAdpmAZX1gD4k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-vWMilOqNPXCDbEwVlo59Og-1; Thu,
 16 Oct 2025 12:26:12 -0400
X-MC-Unique: vWMilOqNPXCDbEwVlo59Og-1
X-Mimecast-MFC-AGG-ID: vWMilOqNPXCDbEwVlo59Og_1760631971
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 110B21956094; Thu, 16 Oct 2025 16:26:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.163])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56C05195419F; Thu, 16 Oct 2025 16:26:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/10] tests/functional/aarch64: Drop some sbsaref_alpine tests
Date: Thu, 16 Oct 2025 18:25:53 +0200
Message-ID: <20251016162601.442557-3-thuth@redhat.com>
In-Reply-To: <20251016162601.442557-1-thuth@redhat.com>
References: <20251016162601.442557-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

test_sbsaref_alpine is one of the longest running test in our testsuite,
because it does a full Linux boot a couple of times, for various different
CPU configurations. That's quite a lot of testing each time, for a rather
small additional test coverage. Thus let's drop some of the tests that don't
provide much in addition to the other ones.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251006161850.181998-1-thuth@redhat.com>
---
 tests/functional/aarch64/test_sbsaref_alpine.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/functional/aarch64/test_sbsaref_alpine.py b/tests/functional/aarch64/test_sbsaref_alpine.py
index abb8f5114bd..be84b7adb0c 100755
--- a/tests/functional/aarch64/test_sbsaref_alpine.py
+++ b/tests/functional/aarch64/test_sbsaref_alpine.py
@@ -41,15 +41,9 @@ def boot_alpine_linux(self, cpu=None):
         self.vm.launch()
         wait_for_console_pattern(self, "Welcome to Alpine Linux 3.17")
 
-    def test_sbsaref_alpine_linux_cortex_a57(self):
-        self.boot_alpine_linux("cortex-a57")
-
     def test_sbsaref_alpine_linux_default_cpu(self):
         self.boot_alpine_linux()
 
-    def test_sbsaref_alpine_linux_max_pauth_off(self):
-        self.boot_alpine_linux("max,pauth=off")
-
     def test_sbsaref_alpine_linux_max_pauth_impdef(self):
         self.boot_alpine_linux("max,pauth-impdef=on")
 
-- 
2.51.0


