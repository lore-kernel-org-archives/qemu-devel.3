Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D46DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 15:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sez1j-0002F5-Mb; Fri, 16 Aug 2024 11:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sez1d-0001ju-8r
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sez1b-00028R-Sl
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723822678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gMGrm7nlH0rCGmigogvtJNwkGhOH8i4UjZdh8E/gKWc=;
 b=KbJ7N4lhrCqP6DLLimswi3WCRUXjzc6HVlfASb8OJEBF7NRoP+qHe/raXlx1s2ttahIZ7m
 wXqveuhVRzCrmrK0unoGYicdoWfqv3Yx2JnSXNKIB4Qwm8hF0EmSG/YZjB3hPuz0GNcL89
 LyErT0+mN33q0Rm9ATR0BYtyyX3a9Hk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-y286bktTNmSwlDKOkEhLpg-1; Fri,
 16 Aug 2024 11:37:54 -0400
X-MC-Unique: y286bktTNmSwlDKOkEhLpg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16C4919560A6; Fri, 16 Aug 2024 15:37:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.75])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0802719560A3; Fri, 16 Aug 2024 15:37:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] .gitlab-ci.d/windows.yml: Disable the qtests in the MSYS2 job
Date: Fri, 16 Aug 2024 17:37:47 +0200
Message-ID: <20240816153747.319161-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The qtests are broken since a while in the MSYS2 job in the gitlab-CI,
likely due to some changes in the MSYS2 environment. So far nobody has
neither a clue what's going wrong here, nor an idea how to fix this
(in fact most QEMU developers even don't have a Windows environment
available for properly analyzing this problem), so let's disable the
qtests here again to get at least the test coverage for the compilation
and unit tests back to the CI.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/windows.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index a83f23a786..9f3112f010 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -23,6 +23,8 @@ msys2-64bit:
     # for this job, because otherwise the build could not complete within
     # the project timeout.
     CONFIGURE_ARGS:  --target-list=sparc-softmmu --without-default-devices -Ddebug=false -Doptimization=0
+    # The qtests are broken in the msys2 job on gitlab, so disable them:
+    TEST_ARGS: --no-suite qtest
     # The Windows git is a bit older so override the default
     GIT_FETCH_EXTRA_FLAGS: --no-tags --prune --quiet
   artifacts:
-- 
2.46.0


