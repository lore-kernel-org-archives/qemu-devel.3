Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11327606E4B1
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lA1mwQBr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSufo-0004gS-0p; Mon, 16 Nov 2026 06:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSuee-0003vk-GR
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:44 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSuec-0002De-SS
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:44 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so26119425e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827617; x=1795432417; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3oLvKLNFfyQdIc5Ssx0Wha578zuNyp8H42uMNEjgyog=;
 b=lA1mwQBr3ovd9N+00SnHhixEhl0F7Zhxp7fJLqsWWHmDcISxIu2okTYvoQTuqlq6yj
 O7655KTPnq19lIErAMc/Lflj2Sv1xst50dnSS/xxEGOGfq7MvgwCRNLr5ipmzpbEs833
 Ypnr+M1C4VT1Nn+PcvIxSyJ3F/qsixjWWHIgM4fMUXbbPg2rE6dblA5uxlJa3S+5dIXD
 BDLautNBl/LIa5PHXxQXxRxtr18wCFP8Fkh452U0erAFzcqVYVx7Q67jS6srid//EFj7
 aKa0LGzsWp2msbYmRHjdGxhH9fasBYPM4OtNqKgAWU2XedbHJmntIwuGkkiY0wNKHbk8
 Kjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827617; x=1795432417;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3oLvKLNFfyQdIc5Ssx0Wha578zuNyp8H42uMNEjgyog=;
 b=JTT4lMFmGzOUa0/4Jn12BG9U6Fiy4vGGyUuWocay39V9jJHYm4X50J7Yp+ihqaHYal
 Wo0OHnmUAnZVWFTQW4RRjY7FNZl5FkMDmjEMfnUE1LGHdSa1mHUUkW3qrXVhE5ryKtq3
 tpVba14fI3J+ZV0x32+Myez5tDsm4CmaclS54BRkLGovEQuo/ddQ/MhZ1TZnzxrKYbw1
 mAoVpA28LJuXTF/N3ZsgOmBqpx8/Q2wMDPw5lEJBT2hYWPAnXolq4ayUlqSc+/thPf+E
 zujFKxxf0PY96zEl7Ub+UodDhrZkHciQvneqaDvkqGgGMld/CkHpF8J/SPzl5zeLNZzp
 9aVQ==
X-Gm-Message-State: APuU4Z+pYTHsD/lzZGk+YHKwQ/S4qekwbYQ4fLLGPDCpUdU9CW+9/HtI
 m9ev3jgiCuzgUFqVq2nT1UATLpP4yq/8zB4E43GYO0iXKWvKw/J5WNgE7f3WkCSARtv1pOr33QQ
 l0YOLhbg=
X-Gm-Gg: AYBFou3Ii9dfcUuXLchrvS+0MA7qe0Sry7qJUBOYjyhqo4ViWPfnywp4+tsmwk+oYuw
 lr1SyDNggeFumCqK3KfaJZ2Aj2Gtd8DKEcUB4S0XLGAsG4lAjeTsiFNeXrsVa9nM1X5aGsBCgGD
 6FFx5zMEL8B0YMRAvUsh4zDsEG6+DSUmqWdCjXU8x1n+Wr4ixzhYrXgRHhMQNphJBnSpjCELu3e
 2QUub/m8dOMP9nuaPFNg9HJyq3WaaIy5e/QECyDv7mZwE65WQZZwC6NaCcoPPAzkssVR0N3k9gW
 hc1SnNmGemZLB8kt7eW7bIk9QdAERHIOSoUPtCPHP9CYSUCyC4NfFBLmYlC+NopjwxFl+8FLyXx
 hfcNUXdiDvWUEKhHcq3Htf/2M/zQpQVNUcxgzXP3YMnYtNetzr89DFIDk9wIiKychx/h3VtRpeZ
 Ty3QtzDoF2TlZQBIA6iNTBnkr/HdEZA05bwdQ0ZJZzyUBpwyZdYyEh+Kg31DH174FBxGskASR26
 3mYUAGt+HRXH9+Kse3TD/M0JDZ7UXUxqlNVNuZO0vmFWCvruhxON9MTlgIrr6NoDWLvDj4Egn76
 m/xvVF5kn/Rpa6+aq5v0a6ayixldXPxsuoU0igguaHx5YarkK4jmf0E2PFs2UdFJmj/Rq3QlRqH
 cyvhEsI6O8LBwbPUaK4mdfeZrkzZueaoPbA==
X-Received: by 2002:a05:600c:4e8c:b0:4bb:60ba:49e0 with SMTP id
 5b1f17b1804b1-4bb60ba4a70mr144443695e9.26.1794827617567; 
 Mon, 16 Nov 2026 03:13:37 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/33] Revert ".dir-locals: include QEMU code in PYTHONPATH"
Date: Mon, 16 Nov 2026 11:12:59 +0000
Message-ID: <20261116111303.1692832-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261113004452.3027978-1-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


