Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE24FC5930
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 11:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZFz-0004TZ-QM; Thu, 26 Feb 2026 06:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvZFx-0004SX-Pt
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:10:10 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvZFv-0004WA-JZ
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:10:09 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso6585295e9.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 03:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772104203; x=1772709003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=niORdVMBkF5Yskm1B/tuSHWLaPwI2AWPSYXhBTsl7lQ=;
 b=P4Av2aRMVkrXIaWQ1eGFeagg3NnyfWs5kqHqcTuSrwIc9xUJWiGmZ12OgM6m6CBhqj
 gcJjAocTwdDs9HEGFDyyT4bg8LKhZ5cq+X+sdzM9N4kGEHHUUMoaOzUQ3VMaaRvMrVZY
 Gjxp/fuamTTIgpu7cMmI5icjdkIvLR9WH7D97WD5y6um7Q28ew6mwXdtvhrPUTisHBMd
 o/pN7npnG+aGErc/rSVOPX2syW1ZzHZLS+mxNuX+zNkHdFE9K8uRTyQ4fpOZvYSRTZvf
 co9yY1vnFuZraLUeqW5ArKhuFMNKi8wNIU3194YBIq7fWqx7+LnClRt6L/DTTn6gXHXq
 1bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772104203; x=1772709003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=niORdVMBkF5Yskm1B/tuSHWLaPwI2AWPSYXhBTsl7lQ=;
 b=QMRwLHzbk1QCM3+W2I72w4GGj7Otr0D+bnkETF0zmPsUgawNsdqCZ6VhY4mSUDj+NQ
 RMB5gkXCskQYEp6jhId6q7F+4JeAYRklFt+CbxsQMZTjV8c/TRHqOUCs/dpXUUEU5qFw
 VRdrv8ZZS9sBsBCRKZQUpQG3qQwRGxDxEkEuEmd6gFAwEfPLr8Se2zJzk+QYOVSvE6rq
 hLah30VKGUyLT0KJ693rqGbwAQ/VginOaJnBeEN8ktvm834WoSWDX0eKkp7adUx66+Ha
 EZJ4DS7o4HvnjBklTzAIHEMFiQI5/uvaYWwg/JxOQkojf75Mg55REPyfTryg2n5eigFQ
 o2Ig==
X-Gm-Message-State: AOJu0Yx6rfVfn1Eaf5xeupdtxnJB1SO1HXGXnjTFysuI9GU5AYASC4wH
 IEmD975v308F+YiX411lFmpmpEYi7ZT3c8XctBBVp6X/ZfpRLzM0WNLTKPCj08Tyct6elw9RtyG
 bwRFe
X-Gm-Gg: ATEYQzzpPkFr4khv3Y7OuMeOc+NSlsPfhilWKzjrHQijMTxcN+bhWwg0s2oK+wFblO4
 T1Pc22ucNPVjpL0qjQbvS9Tc0wLnw9AU98n9PkKuf69oGSY8OdZjWjX/UdtlbuLV5HV3dfIz0kN
 MbYV5QII9CvVF9Q3zfo3s21pRkIQFmIWEqIHQxLhNb85Ahj1ZDFSvoy3T/hFeFAjnLAhXUHqeu7
 47K1ktbqYiZtNnehXa2xhOVsHNbutlXn2fBQuz7TUI8hPvJqivtcrTk4hJvrqxCDSab9X3CWajC
 B2RUS/MZH1ZkKNEiz2vRQZn2gyanmr+NquA5UMKeTaJ+paMr+mSazSZxs+rjNPlLK04y58fJ3Pa
 /nUXgIe1H3NHM2QuK3lli/AO+vZHB6egGrrvyBznq+ZyUf8W0wI6k+QQZH+on4gg65vzNTvKIL4
 yrS5gIQA7xiGmLZexSki3cW1AjTWzh+QqSJwJdbLo+EGLA0aGpfsRIEBQ2AW3vcqwquwZVKf+vr
 7Qt4ejCYniNwO3gxZDMXmJkaTMK7E0=
X-Received: by 2002:a05:600c:a49:b0:483:7631:befa with SMTP id
 5b1f17b1804b1-483a95eb5e6mr369041415e9.5.1772104202815; 
 Thu, 26 Feb 2026 03:10:02 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d5463dsm37159861f8f.34.2026.02.26.03.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 03:10:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH] scripts/coverity: Drop --enable-libnfs from configure
Date: Thu, 26 Feb 2026 11:10:01 +0000
Message-ID: <20260226111001.1021810-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The environment we do our coverity build in (amd64-fedora-container)
has just upgraded to Fedora 43.  This ships with libnfs version
16.2.0.  We can't currently build against that: in commit
e2d98f257138 we added a requirement to meson.build that libnfs be <
6.0.0, because of an upstream API change that we haven't yet updated
block/nfs.c to handle.

The result is that the coverity CI job currently fails in
configure:

Dependency libnfs found: NO. Found 16.2.0 but need: '<6.0.0' ;
matched: '>=1.9.3'
Run-time dependency libnfs found: NO
../meson.build:1150:11: ERROR: Dependency lookup for libnfs with
method 'pkgconfig' failed: Invalid version, need 'libnfs' ['<6.0.0']
found '16.2.0'.

Fix the coverity builds by dropping --enable-libnfs. This means we
will no longer have coverage of block/nfs.c until/unless we do
that update to handle the new libnfs API.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/coverity-scan/run-coverity-scan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
index 43cf770f5e..9b89a3303f 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -424,7 +424,7 @@ echo "Configuring..."
     --enable-linux-aio --enable-attr \
     --enable-cap-ng --enable-trace-backends=log --enable-spice --enable-rbd \
     --enable-libusb --enable-usb-redir \
-    --enable-libiscsi --enable-libnfs --enable-seccomp \
+    --enable-libiscsi --enable-seccomp \
     --enable-tpm --enable-libssh --enable-lzo --enable-snappy --enable-bzip2 \
     --enable-numa --enable-rdma --enable-smartcard --enable-virglrenderer \
     --enable-mpath --enable-glusterfs \
-- 
2.43.0


