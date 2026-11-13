Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6DD606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=E5Q1u95R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRfPk-0007QK-Bw; Thu, 12 Nov 2026 19:45:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xRfPh-0007Py-Rn
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 19:45:09 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xRfPe-0001j1-3K
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 19:45:08 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4922dbcee23so159604f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 16:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794530704; x=1795135504; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LkFVsACxNmnaGkiQMYuPXI9+5TvJNIJHvYGK7iS8924=;
 b=E5Q1u95RC53WAWpJnFd1siGBpmSuSY+nAmr3ISTpIiqPYWNc8KAIaFIr/BwkhuN3w9
 6VH51hlq23nrRf6SEnCJOyD5DYUMzHvc9ksFC/kVhZ+oKlVtDUVhcub87qKqeVM58xz1
 Hr7+u0JrmoLqr7m85R8qN5hTJ2n5rHtdXfCcIkI38GTSDmBLsodz7yrYD6WE75Nht2qi
 sV/GQOTB8E3TMCVziOOcI6pyuaDCMzXwPcyaSjzbSx41tncvyEskw+p2py5ZQ3ipg8iK
 ktYFEuKuQ92OTtVcioeaeMD7ZiZRLojsLAPbILZr3Lt358NoXa/YhZc+F5h2DX7PNI+x
 KFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794530704; x=1795135504;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LkFVsACxNmnaGkiQMYuPXI9+5TvJNIJHvYGK7iS8924=;
 b=dBrBQGH0uXk/rVI5Qu3oI6TzqiNxR+hnsH3SLjz5mCUUnUy+WBmtTtx5BWIyFbSEWF
 fXR4k6h4Kcii/woJyNdyauzdCDKd76iD3zdBVSE2tdvhbCjjx+KRwZbviQZLGvMaimUw
 b94BnPK3IE1/iF51gqax4DhEhS1qeProkGWJNlI1V5gS3vNhO9va10Vu59cqNOXJk0LJ
 uCxD4w3DEa3jg53Lx72vpan7aqkBu12ubRVm7515Jz/p1j16XH02x3unW5/9SxA9AM1S
 xGD6JqCxNPBOWcXRbeu97pWRV84t7ExezrgHuS9Lzi72EY1eL4Y/xXqZtNSMGBYkF0Os
 Tayg==
X-Gm-Message-State: APuU4Z/ZDgEV/buEoIHyxeGZoqaGNmQpOqdWroG1syQYKCAmCu/JcZuN
 z2UzA4FDeQC4tn+2TwQB6upEjEFNHOU/+0ZpMPtJsfTTz9MhMM4md6Q62/SxkwIelmE=
X-Gm-Gg: AYBFou2pIzX1K38G0gpOyL7YPd7W9naz9NQgn159S3aQBeKlf6Xh6AdgTtgIQP1Hm4C
 zLo63K1D40cOQ2+LrcfmlzO8l1mA65qowsqgTnFnrk0FcL62FtD0myNv92GOyGXB1T3O4yC/L82
 B2vIKJTG2Uxso30CcFh0Ie1a9YycOn/WLIQPq75mEQSGdqNm1gkqecmbRyyYlFSH0/Lj8L2xvsX
 ezAPGh4Ct9J0TVNb4endM4OdW5yZ6O89I552fQsaAw8lnkiX954vgTNYsBbouiXNAhMRj3GRmfj
 ICBR+YOTU/eOVkTktFi4z5mCymylKr/tD1Km3QgQHuuahxbedwYLne+DSQ1GVh38Kl1Fn8Klf0B
 PdSIcKRxxy4k0sx2fltRg+uu1W5FL/eL5KYcHTVxvrz8FT/3O0XWI2PQQWI3mFFpE8svDcBL4LT
 t/eN8VXnQBXQyj0WObZGA5GoIr8HLbNd6XD1viTq2tQdgXniITRsxxk8QJlhNzoqsqF/BDc1fnD
 +Qwo/CQ3+ci9g898UmL4YqrMVXhX7zTrC8RX8FQKYsLVPC2YweiK+JXvcbmPAGhw2pihY0DoIwh
 300IZR/xLutol66QWcI+ceFfuwzf
X-Received: by 2002:a05:6000:4553:b0:48d:bfd5:79c with SMTP id
 ffacd0b85a97d-49c73164944mr1333445f8f.42.1794530703647; 
 Thu, 12 Nov 2026 16:45:03 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6020bb7dsm1971566f8f.33.2026.11.12.16.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 16:45:01 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 62E7A5F8CE;
 Fri, 13 Nov 2026 00:44:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH] Revert ".dir-locals: include QEMU code in PYTHONPATH"
Date: Fri, 13 Nov 2026 00:44:52 +0000
Message-ID: <20261113004452.3027978-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Unfortunately this relied on trusting the source tree via the
safe-local-variable-directories otherwise users keep being prompted
that ".dir-locals.el contains values that may not be safe".

An alternative is for the user to add something like this to their
local emacs config:

  (defun my-return-source-if-in-qemu-tree()
    "Return the root of source when in QEMU code."
    (when-let ((src (expand-file-name (locate-dominating-file default-directory ".git"))))
      (if (file-exists-p (concat src "/qemu-options.hx"))
          src)))

  (defun my-set-qemu-python-path()
    "Set local python environment for QEMU."
    (when-let ((root (my-return-source-if-in-qemu-tree)))
      (setq-local process-environment (copy-sequence process-environment))
      (setenv "PYTHONPATH" (concat (expand-file-name "python" root) ":"
                                   (expand-file-name "tests/functional" root)))))

  (use-package python
    :hook ((python-mode python-ts-mode) . my-set-qemu-python-path))

This reverts commit 3112269be3ac92343a5f0e5d9eae919edd176a35.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .dir-locals.el | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/.dir-locals.el b/.dir-locals.el
index 51871619422..3ac0cfc6f0d 100644
--- a/.dir-locals.el
+++ b/.dir-locals.el
@@ -1,8 +1,2 @@
 ((c-mode . ((c-file-style . "stroustrup")
-	    (indent-tabs-mode . nil)))
- (python-mode .
-              ((eval . (when-let* ((root (locate-dominating-file default-directory ".dir-locals.el")))
-                         (setq-local process-environment (copy-sequence process-environment))
-                         (setenv "PYTHONPATH"
-                                 (concat (expand-file-name "python" root) ":"
-                                         (expand-file-name "tests/functional" root))))))))
+	    (indent-tabs-mode . nil))))
-- 
2.47.3


