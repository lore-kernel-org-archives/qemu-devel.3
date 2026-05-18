Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9164ECD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0QV-00010r-NQ; Mon, 18 May 2026 12:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wP0Py-0000MW-Cj
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wP0Pv-0005cm-Ci
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779120126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qyI/tzMp2ImDMh0+rZ0xpwtnUXHIjbxTzj+UiEn3P/Y=;
 b=K82c/Xvy1HN1BTavPiS8spLJJWOG/SJ9fAbILAZ/kOL6lOQppFlGW85TnupxOcPpAqEfje
 70kmaU5gmHpcH3rZpqFm0V4nKuLrrYvAOH4R4UA6LdK0rDJWGr88IPk9Pqw+kXCtcGgcbe
 ffcqmSUaL5oP2XBfR4/6TSdGYIfM6NU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-br1YuBOuMmaC0gfHP4FDqA-1; Mon,
 18 May 2026 12:02:02 -0400
X-MC-Unique: br1YuBOuMmaC0gfHP4FDqA-1
X-Mimecast-MFC-AGG-ID: br1YuBOuMmaC0gfHP4FDqA_1779120121
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12B04195608B; Mon, 18 May 2026 16:02:01 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3821530001A2; Mon, 18 May 2026 16:01:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v8 14/16] iotests: mark 185 as a flaky test
Date: Mon, 18 May 2026 17:00:49 +0100
Message-ID: <20260518160051.903616-15-berrange@redhat.com>
In-Reply-To: <20260518160051.903616-1-berrange@redhat.com>
References: <20260518160051.903616-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce a "_flaky_test" function for I/O  tests which accepts a
GitLab issue URL, and causes the I/O test to be skipped unless the
$QEMU_TEST_FLAKY_TESTS environment variable is set.

This is used by test 185 which currently fails in GitLab CI for
unknown reasons.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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


