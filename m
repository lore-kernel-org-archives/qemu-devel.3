Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCC9CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 12:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN8Hc-0007xj-Dt; Wed, 13 May 2026 08:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wN8HN-0007vc-3O
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wN8HL-0005SK-H6
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778673690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fhTOJM/PLhL3y84nVBdx2ZstdYqGj6ygTmh2/FVVMns=;
 b=dWAd89Bi5UH9AeOGzskfiG4fWEjFzfDBAQvNIlU1g5xa9+nst4+dG8ytT7740mwty5WcUn
 NwPPOvQVtpgli0FIfrXySqNqDkq4p5nGmcxXDGb1B6e2WrJE4Nr1OPEZ/ZNAx0XFfJiDxu
 XDyXtJu4kaXRjKYiJ3qIU53OiDTOQQg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-CkegYOGzMuOwR62OlUn8Yw-1; Wed,
 13 May 2026 08:01:24 -0400
X-MC-Unique: CkegYOGzMuOwR62OlUn8Yw-1
X-Mimecast-MFC-AGG-ID: CkegYOGzMuOwR62OlUn8Yw_1778673683
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BFBF180062E; Wed, 13 May 2026 12:01:23 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.213])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40F5818001E8; Wed, 13 May 2026 12:01:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v6 14/16] tests/qemu-iotests: mark 185 as a flaky test
Date: Wed, 13 May 2026 13:00:01 +0100
Message-ID: <20260513120003.226790-15-berrange@redhat.com>
In-Reply-To: <20260513120003.226790-1-berrange@redhat.com>
References: <20260513120003.226790-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce a "_flaky_test" function for I/O  tests which accepts a
GitLab issue URL, and causes the I/O test to be skipped unless the
$QEMU_TEST_FLAKY_TESTS environment variable is set.

This is used by test 185 which currently fails in GitLab CI for
unknown reasons.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/185       |  1 +
 tests/qemu-iotests/common.rc | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 17489fb91c..a62ae8d329 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -50,6 +50,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+_flaky_test https://gitlab.com/qemu-project/qemu/-/issues/3270
 
 size=$((64 * 1048576))
 TEST_IMG="${TEST_IMG}.base" _make_test_img $size
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 731e4b2b99..298bc483e0 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -1088,5 +1088,21 @@ _qcow2_dump_header()
     fi
 }
 
+# This must be referenced after any _require_  lines, so that
+# test filtering happens first
+_flaky_test()
+{
+    if test -z "$1"
+    then
+	echo "A GitLab issue URL must be provided for a flaky test"
+	exit 1
+    fi
+
+    if test -z "$QEMU_TEST_FLAKY_TESTS"
+    then
+	_notrun "Test is flaky (see $1) and \$QEMU_TEST_FLAKY_TESTS is not set"
+    fi
+}
+
 # make sure this script returns success
 true
-- 
2.54.0


