Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DFE606A6E2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mg2y7Enu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUtN-0002ga-V0; Fri, 20 Nov 2026 15:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrP-0001AB-Ow
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:32 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrO-0001uM-6o
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:27 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4aa5833c263so1209870f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205125; x=1795809925; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JO79tS4Kaj2YYiEt7SOtl1SToVZSkgS2FK0imq6vEsU=;
 b=mg2y7EnuN150KwAdyhf822NJYu9EZpx2S6Az9HKFHYg8gELQUmFpaycwKzYDVcjLG2
 mBvtBNLs9f0fLpcIBBn6KijOz2uHefKBu2+yEtGAMIEjufkQCiNGW0a3nfpIlSq0niL+
 4FKwTCbTg6kn5RxJMBusWMCvh2otMjFxvbfmLJzLAhspDGuhjP+5gypE0zGzbI2uFUQO
 +fld0F8SL1ZeYs2ZFh1nlQ5eW4BfeSz7p4Fip/2wcXceB91uuC/vzurWngyG67tZZc1R
 bEccFpCmGY3rM08csBgGPsKZJh7jOpcVe8TOhDbIcAd4HCS76LkuXmBgPI+NMVWKdgoA
 d6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205125; x=1795809925;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JO79tS4Kaj2YYiEt7SOtl1SToVZSkgS2FK0imq6vEsU=;
 b=R/Sx7NQcItVi14doju1MYfCtLzszittTMz2Vp5DYdYZCI8X1cLBCqB2bOK5cNoFnMx
 9qP1FFgJl+IBdXG+aVZpAn3Z6zNAoGDff9X6MBs9xUMr6E3UqoqfAcdlRbn+D8xcwb3Z
 jgogUHdtenvB4KUxnIu5rjyYSwrFqnYP9AHpfi1DYiAjZubWORkpUTc8/wa68WW7Kl45
 lKyi5eH280LltrIeBlIM+s3EQ3U5Uecsv4CCXCbt23ILcuiclVg7hXAcZ6h3/LFYBbc2
 MFQ9znKoZHzfbYa5ym8pE+8RIZSds1P5cOjYtsKdTBNfNr4NKcPFrUE3WM1kvVgomwtB
 iCdA==
X-Gm-Message-State: APuU4Z/YY7pG7qHdGD6zd9yTTH+zGFi5kLzCod1c+fhbnh4hL5q9EHCN
 bM3rZljZ80O5ETJaUjkVUwM8K/3q7chMZr6EYRdgJu96RKmzNQlPWNBLZRQODIr/a6v52dAOdRv
 kiAxL
X-Gm-Gg: AYBFou1L7Q/QPWcH+fqgfLAs/z/kHNFDzY+A2HS16ql2B1Iz30VwjgT4gCfVxIBAReg
 T7XZ/cxhTpuqe5E0cizNIvUxVk4zBiGxRiQahS8Z4Qf2UWaUK30VxxhFq9dC4r7QZfQv1pnGzNh
 pMdgC5Bs/gXq1jApkOduZt1tMZlaEYpKVbVFi81Ao1bkxqyZzqvKy9RpA2A1gCUkTWs2Re8LQ1Z
 JwjN4+1gYI4/huTXUQey9vhGgiuEKmvG3JbcssvVSF1dvHfwGGil3VRYEDl0ou7/pbv2OO3Aj7c
 LWuYPO+CVZUR8/Fh9uXlx29Qsmz4Qdp8rEQhn5+JRxgpPgln0pYk/Z1V6wMafcjh7el1/fvGBmO
 ZYBIFtYx5TJgeq2/vEgwPftJCptApf0W/A2rhZajnKKM46CSFKthWLESDsFG5hsD/I/yS3P68rE
 MB1KYMTNDCBdxk/fBlSOWWRoZi3NEL9bPjk35yzKbj1A1/ENiBoxRRPZWhkhroTVCbTrKqHLd+z
 /Z3+NuATCUalb38sbMVzDdl8G8eqY/0WXnNoCnCtBMEQtboM5//S7ylTWhnalbwaswcKmioAiZo
 axPKAq05kpzhjjVDjcYxUZTCRuIA
X-Received: by 2002:a05:600c:3b1a:b0:4bb:875b:3d91 with SMTP id
 5b1f17b1804b1-4bb88820bfamr97530555e9.30.1795205123746; 
 Fri, 20 Nov 2026 12:05:23 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm209223845e9.13.2026.11.20.12.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:20 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 19F875FC32;
 Fri, 20 Nov 2026 20:05:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 17/22] gitlab: add a check-maintainers task
Date: Fri, 20 Nov 2026 20:05:05 +0000
Message-ID: <20261120200511.822573-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Now we have a more flexible get_maintainer script we can use it to
validate MAINTAINERS.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/static_checks.yml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/.gitlab-ci.d/static_checks.yml b/.gitlab-ci.d/static_checks.yml
index 568e56e1204..f72bd79e14e 100644
--- a/.gitlab-ci.d/static_checks.yml
+++ b/.gitlab-ci.d/static_checks.yml
@@ -23,6 +23,15 @@ check-dco:
   before_script:
     - apk -U add git
 
+check-maintainers:
+  extends: .base_job_template
+  stage: build
+  image: python:3.10-alpine
+  needs: []
+  script: scripts/get_maintainer.py --validate
+  variables:
+    GIT_DEPTH: 1
+
 check-python-minreqs:
   extends: .base_job_template
   stage: test
-- 
2.47.3


