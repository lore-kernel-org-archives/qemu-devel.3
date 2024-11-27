Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC009D609CE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 10:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGFNb-0004kt-Oj; Wed, 27 Nov 2024 05:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGFNX-0004kd-Dv
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 05:34:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGFNW-0000ai-0y
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 05:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732703675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wk13V1eC+URFQ8UpXp/cbMnObkm3r4GEZPd95udLbYc=;
 b=BbL5f9l+IR9DYYtOSknYQqkq7F+mgYuv8/2LBDHq5xNRW5dY8iWusAmu3DDTiDhemh+IF5
 nDrlZf3uxHnd5uT7xSwfRRU1Etm3V/chyv8wiGizpaTOh5eOdssGnob3HgKRRnaox0kIH/
 1sepdpQFbjGSIJkcuYcTBMo3cZ5lBio=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-7JxdchcMOAmPunJVF4L7FQ-1; Wed,
 27 Nov 2024 05:34:30 -0500
X-MC-Unique: 7JxdchcMOAmPunJVF4L7FQ-1
X-Mimecast-MFC-AGG-ID: 7JxdchcMOAmPunJVF4L7FQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83C3D1955D44; Wed, 27 Nov 2024 10:34:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.82])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7542E1956054; Wed, 27 Nov 2024 10:34:28 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/7] docs/devel/testing/functional: Clarify that we have to use
 the build folder
Date: Wed, 27 Nov 2024 11:34:19 +0100
Message-ID: <20241127103425.378289-2-thuth@redhat.com>
In-Reply-To: <20241127103425.378289-1-thuth@redhat.com>
References: <20241127103425.378289-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Make it clear that the commands have to be run from the folder with the
build, and use the python3 from our pyvenv to make sure that the
pycotap module is available.

Message-ID: <20241112115302.470527-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing/functional.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index b8ad7b0bf7..ae238ed3fc 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -59,11 +59,12 @@ To run a single test file without the meson test runner, you can also
 execute the file directly by specifying two environment variables first,
 the PYTHONPATH that has to include the python folder and the tests/functional
 folder of the source tree, and QEMU_TEST_QEMU_BINARY that has to point
-to the QEMU binary that should be used for the test, for example::
+to the QEMU binary that should be used for the test. The current working
+directory should be your build folder. For example::
 
   $ export PYTHONPATH=../python:../tests/functional
   $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
-  $ python3 ../tests/functional/test_file.py
+  $ pyvenv/bin/python3 ../tests/functional/test_file.py
 
 The test framework will automatically purge any scratch files created during
 the tests. If needing to debug a failed test, it is possible to keep these
-- 
2.47.0


