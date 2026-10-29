Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E2F606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yJTh/d1y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMSkw-0005ie-3c; Thu, 29 Oct 2026 12:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMSkk-0005cC-BJ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:13:23 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMSke-0000Wk-Cv
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:13:19 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso1875444f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 09:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793290392; x=1793895192; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=woVmwsyvDlCmkyZgqC5zSuMkvRNOYByorzJBxOcFY00=;
 b=yJTh/d1yD2bU23z5lzEp8dvLwYPjCDk3ozQDccr9UpS9i0p8hnf3NxRLbOpbzqb17/
 BVSEfoiky6imyvsq7XandMFNQdTcj2xmfZgXO9sRZGfs3cXSO1rJ2dZ+56q0D9JpYkc6
 uaAfJ8qoH+ROf/Wuu70bQ6kKMI4lSyKQToouE3bVNaO4QnxN0ociGw5kZrIrLcfhMRqi
 LwUS65NmcZoCXuCP3RILXFO2MFF2NVnwIfPqIyBa0w2y7J1K35q1I08V/o2v1g6702Ud
 RZEvTE7hxgn3IokTvz2PR2qQ9pI6qhfS/E6RQfWg6ZiGmDqkM1IJOQKg38EBZbyYIoI8
 jxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793290392; x=1793895192;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=woVmwsyvDlCmkyZgqC5zSuMkvRNOYByorzJBxOcFY00=;
 b=L9frnqal/ohfwv/MFY7lFS8exIBxf0oikF5n4tTZ4zQMa3JpFKgnOsnQaaNIsp3plg
 7G9Veo5X4Ql+voKuqB5zbfha9ylV/EhZgyQ/CV5hduWHngjFYe71pS3Qye7BapgCrQEg
 Amncs5ikaEajkdVWsVlDHXasT2PI5ml9UuZWVsh7V7TF65Dj/edhdoZT7qnRUTySA/cs
 1dCnAvq1XkiYSH0Nt6lunEdbum5ZucQ7R/jlkzJY0qZVKGe6sQDgCKCrBvfKuR7d67H9
 B7QxDX5bMzplYx+BFUNXky8ocJwvPekrDMkshczISh1geKn/ToWx4luOeER9jOBFihJZ
 I4ZQ==
X-Gm-Message-State: AFq9FYKO8xZw9lMCnIhU08gxkcXZtmh6Y5KGHxcPU+7M+BC43sneSVSx
 yJLnhbZh5l7dNkeeRWi6Nms/vU48lF7BH3c7yW93s8saPrpz2j7f37Ui5xfoNJB0x24=
X-Gm-Gg: AYBFou1Cx18vhrLCZt6L2XTldIwX6PWvb0uIHvoWeOid/tKwB9D6P/AQCRdII1KLKhr
 bVtOKJSkHffrYES7bkbdlggV+XMdZXkq4J+A+9ZZ6ogogUDEzFGCpC/u2SVnICw9bYJFQxYKE64
 EuVVIvwMu5GK1XsCcIR7OSdthpGV5vAxEqX5Hvw7y7bNIbCmcMW1vg7vqaKiZyctxjKbpPiDCJR
 xdJUIrDe/gLDiMM/5llZLtLI8GJQpMp6SjB4JIyQw4k6OWRDTxJbJ56Ir7C1G+TFQMjXjzav/05
 6WgZQeMNh12WuQxahbtkmK5jCs4PBOXgtrVqhj+wseIgi6JPYUkKFZFPKM97DWUYw3zAQPKej+J
 T6Fn2nPn143RQ/3E2f6GWAeTUjmzr7fHJPm1z46K32ANcVzVpVoXBDmO3ArCcWnbx7aLKSyCGEc
 QQE/JCBrnH761M4Rizz4ew8dVkFzcnwTe9CX3B5kCSae0cckcLbL95WYDRc6g7TPN1ky8E2pxir
 TSCmxOMqkUYC1yE44GAqyUbahCC+279dkXA3r9Z7zZ88gIO9M31/2pn8tUcuLRZ1XBkcYxwZEVJ
 dzjY5EagYBIxQYHfr01T8Ygco+w9
X-Received: by 2002:adf:ed91:0:b0:48d:fd1f:9a9b with SMTP id
 ffacd0b85a97d-48e5d2f9535mr10358256f8f.34.1793290392498; 
 Thu, 29 Oct 2026 09:13:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df87f26sm91409f8f.17.2026.10.29.09.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:13:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2DEF05F8AF;
 Thu, 29 Oct 2026 16:13:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/8] scripts/checkpatch: validate fixes against origin/master
Date: Thu, 29 Oct 2026 16:13:03 +0000
Message-ID: <20261029161310.2065290-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029161310.2065290-1-alex.bennee@linaro.org>
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The current check for a referenced fix commit relies on the developer
keeping their master branch up to date which is not always grunted. If
you create your branches directly from origin/master this will keep
failing.

Given that origin/master should always be up to date (module the
developer eschewing convention) lets use that in the test instead.

checkpatch complains about the line lengths but this seems to be
standard for the perl script so I didn't try and fix it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 82f62f60212..60e8b6bf7bc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1913,9 +1913,9 @@ sub process {
 				}
 				if (which("git") ne "" && -e "$gitroot") {
 					my $hash = defined($cid) ? $cid : $orig_commit;
-					`git merge-base --is-ancestor $hash master 2>/dev/null`;
+					`git merge-base --is-ancestor $hash origin/master 2>/dev/null`;
 					if ($? != 0) {
-						WARN("Fixes: commit $hash is not an ancestor of master\n" . $herecurr);
+						WARN("Fixes: commit $hash is not an ancestor of origin/master\n" . $herecurr);
 					}
 				}
 			}
-- 
2.47.3


