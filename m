Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88BF606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=q3pI1Fwo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU2jw-0003zK-Se; Thu, 19 Nov 2026 09:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU2jt-0003yW-ED
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:03:50 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU2jp-0000SO-Fp
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:03:47 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4a358881793so1211504f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 06:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795097023; x=1795701823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=20ZZPMEs1Mta7IBgztmsk/aVB/t8IiEIowQV5vkdB+w=;
 b=q3pI1FwodsA+XBZ6BaCw1tLbFXNUDgGUij4nO9UfTWfbqtM0qSlMNKWI8SQNEEKIf8
 rbp+t+SH2w1KEWoMV8nViSvqJqJm/8iR1RJ6+ZzvH3EIqMYvlOeDcCXDS4PSvrfjLwzD
 mYP5olSwXv6CjrbdBF7rDjnfbYRAnadqOPVEuQM5tu4zHpwTfxIjNTHB6UQbdRAfYxl1
 GltxMaJug/XTjRQULq05xb6KpP0kJp3norAcCS24dJhMnHLs3m+dnEhYOiut5q4X6r2r
 DieWFqIMn5k4UHn8VObxWcE6AKsq+0wfbROdkkxYboiGpPSn/zI2MQTMuVavb5dvvIwf
 eABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795097023; x=1795701823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=20ZZPMEs1Mta7IBgztmsk/aVB/t8IiEIowQV5vkdB+w=;
 b=E9lcxzPxliBPF2vKDpEVOi2oTP6d7vcgbk1VmfOuZujv+wCCcaUZIFh3As+6Y2kPQl
 YiRVD2u9RsK7twF2jDvMHHTtQUAl9LFZjPCVLZOUISFSgnEol9hlUiltooF0d23opKVe
 BcxcO70g95NZHiRGzgf/V1EvuJU5LprxT9wujFPcvDXvseTE3DIWJHNlv3d/IK92pIB6
 QRCA6z+18PKc/fdGzmNXuZW93gTGiwLfHm3KGYCuH/6ZoUkt4khV8U8gHmX46HfnGRCT
 VSJSqUh0LaFEn9pYFs+InTBymjaqpebgwfXqTDYwwcvqHuvQQsvIISJMqub5al/NE58K
 qsPQ==
X-Gm-Message-State: APuU4Z+VP6cPCarwpePHbxZKycLGWvZk44TGjctCy0YWg1Tvl+k0znPK
 thR1h7dgaXChkuTMlhwGgQpQZOpWZXO26j0tvYthuDr2KH5F4fxOq75X8jFXvY+rBkMw+yI9cli
 8S0tlQJ8=
X-Gm-Gg: AZFdTZcleD5pkV2F2QvtsGlmZygXHWSHRkXqapHsM9remhA6xbQM2vl1EJ2GDZatGWu
 404xFVOGKmanaqxhW0P2fjqmKeE5fn/CR74WpyyOtd+Cni1KwKKZwbwLc6H/jUAU45E56n50opv
 MxK7M5KazWNl3iaPS4XykZcPqQVUCT/602B14c0USv4L0zGlYwebi4yGFbFBJwOlp22LFrOnPVj
 umm6vjW0xpn641TryNpDT0MIIFFQm1GtNiAAK2Dtj2nTwFjJwlG5eaSc6wB2zAnBJQsxEnczZ2H
 J/mdf6HjL6q91gu99bU/zzX9E7i7GabZRGP/jFkrgkuqJr7vkp+PyDxdXURDNmA/Yyv+MXInFDi
 oRqJCc1YVFa6ovVrkDNteFxjZuVFAnKWVOosZnEyvAQjT4poI54sCIXftLL8Q/k7utZus4ikKaF
 52AghjP834RHUizAqOqE1VTFknVySZPIodT6ZcKInCiC28A04XmpxzQEzH9N6+ZRP61A59vF8QZ
 O8Dt6l2aCBtCZ8ht/B2Eb+vth7qwtqLY3fa3x1ZP8XSeq38T169x/oa5AF71juSOd92Rm35XKV/
 dABZ/R72hA7/bdgOVcAmj/d5dOUy09KhGp+RiuFMIDR+ONVnGmKafPO2zLAmV1FC8b/7wne/5Q6
 a1sSd7m8s1cFaom9EhEqMs5tyW7reP01NjzqWo05jNtVDDJzGQFZuaQv+
X-Received: by 2002:a05:6000:1a8d:b0:4a2:ee0f:4fa3 with SMTP id
 ffacd0b85a97d-4a6346da8e3mr13286867f8f.8.1795097022911; 
 Thu, 19 Nov 2026 06:03:42 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab53e891d8sm19118f8f.10.2026.11.19.06.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 06:03:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH for-11.2 2/2] tests/qemu-iotest: Add test for qcow2 image with
 empty reftable
Date: Thu, 19 Nov 2026 14:03:38 +0000
Message-ID: <20261119140338.2918386-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119140338.2918386-1-peter.maydell@linaro.org>
References: <20261119140338.2918386-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This test creates a qcow2 image, manually zeroes out its entire
reftable, and then runs 'qemu-img amend -o refcount_bits=64" on it.
This used to cause qemu-img to crash; now we will report that the
image can't be opened because it's corrupted.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qemu-iotests/315     | 59 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/315.out |  9 ++++++
 2 files changed, 68 insertions(+)
 create mode 100755 tests/qemu-iotests/315
 create mode 100644 tests/qemu-iotests/315.out

diff --git a/tests/qemu-iotests/315 b/tests/qemu-iotests/315
new file mode 100755
index 00000000000..ff1a22bddd5
--- /dev/null
+++ b/tests/qemu-iotests/315
@@ -0,0 +1,59 @@
+#!/usr/bin/env bash
+# group: rw auto quick
+#
+# Test handling of corrupt qcow2 file with all-zeroes reftable
+#
+# Copyright (c) 2026 Linaro Ltd
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1        # failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+# This tests qcow2-specific low-level functionality
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+# We are going to check changing refcount_bits from 16 to 64,
+# so anything else is not supported
+_unsupported_imgopts 'refcount_bits=\([^1]\|.\([^6]\|$\)\)'
+
+echo
+echo "=== Testing empty refcount table ==="
+echo
+
+# Create an image, then modify it to zero out the entire reftable.
+# Check that this corrupted image doesn't cause qemu-img amend to crash.
+
+_make_test_img -o 'refcount_bits=16' 64K
+
+reftable_ofs=$(peek_file_be "$TEST_IMG" 48 8)
+reftable_clusters=$(peek_file_be "$TEST_IMG" 56 4)
+cluster_bits=$(peek_file_be "$TEST_IMG" 20 4)
+# Cluster size is (1 << cluster_bits). Zero out the data starting
+# at reftable_ofs for (cluster_size * reftable_clusters) bytes.
+reftable_size=$(((1 << cluster_bits) * reftable_clusters))
+
+dd "of=$TEST_IMG" "bs=1" "seek=$reftable_ofs" "count=$reftable_size" if=/dev/zero conv=notrunc >&/dev/null
+
+# This should complain that the image is corrupt
+$QEMU_IMG amend -f qcow2 -o refcount_bits=64 "$TEST_IMG" 2>&1
+
+# success, all done
+echo
+echo '*** done'
+rm -f $seq.full
+status=0
+
diff --git a/tests/qemu-iotests/315.out b/tests/qemu-iotests/315.out
new file mode 100644
index 00000000000..91b718df5ca
--- /dev/null
+++ b/tests/qemu-iotests/315.out
@@ -0,0 +1,9 @@
+QA output created by 315
+
+=== Testing empty refcount table ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
+qcow2: Marking image as corrupt: first refblock is empty; further corruption events will be suppressed
+qemu-img: Image is corrupt (first refblock is empty)
+
+*** done
-- 
2.43.0


