Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DA3CA5FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxD8-0003c1-4q; Wed, 30 Sep 2026 12:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxCw-0003b7-Ea
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:31:02 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxCu-0001UG-OJ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:31:02 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4887f690df6so4018664f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790785858; x=1791390658; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Juo4bcLqrQUUFEh3pZaW3NN7y0nrcKKzTJu1FUmbulY=;
 b=s4vY9OB6ZQrHvaslk10fcLE8d77C2yH7UHzhOyo9G4TNzAml666zRooytLE2Cf9uMx
 qLXkcqwuVusoMPmu9HyxSQJJ6do9w2SRMb7q3nn8CBTKO0aXfhKYnlHqLpAR5tL/MRQE
 IIwLH513FnXslyeoNCO1dbUqmqno3UMN62TKbx9M2toa27RW77uv7w2S94mgaev45oi1
 s51IHBabq+C//eNjP3ERkkpAg0/ZZPr60pDh4FuYTe+/ACiiVFQUGHyDd9plMdUNXpxT
 ZaEQ8X5xNPCsOnV8Fj5t05ZjFOv93STAlWmZ+wv5C49LYaAa/YDDBHVlT7HqwcUC4l/H
 vmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790785858; x=1791390658;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Juo4bcLqrQUUFEh3pZaW3NN7y0nrcKKzTJu1FUmbulY=;
 b=iDX6uOy4NZ7GBJm58Qr0MYeiK/J0BY15ll8EZdagIoLWbSosuB+gl1jVwfVmhp52oM
 qEBCiRE7HNhkvpJsB//JGtJRoXzgGTFfR5BrbfrdwxDo5PomgEhegfhy6XDBpm9h7oI8
 1kcR+7fuBuuNg/taDGEBo1Rn3821Q+GsZGPgbAe3c04LG9hp5WJGT01SLyVTgYM9CFlO
 hinmXbMpf9DMznw1q5GzsOYLz0HMvldxXNQnHSvRT7adSnR/Xpt+q5xNlLw2ZgHB7Evu
 p8Qk0c4qNwRCZ3RFNlyVOQ3mPUw36/uzot/3rC66dDA30aqD7l1VGTBSU0q7RdKjFKbX
 2kkQ==
X-Gm-Message-State: AFq9FYLkMqlb2sFUFWZZ/k7jkAV3uIp28lhnfFtZCD12T0XD7it8799s
 +nghMt+wxGnKM9ZvjXqJrRWiWLw2cLVF0SHat6Qr1vmoZmQF4kAn/HcF5k14jgo1U2c=
X-Gm-Gg: AYBFou3Sr4Vf3r4Y3sqiCyQfNwriX+NcbMqVGJVw15MgUUM6lM60D1rkCTZk8eWWkgE
 HBAypQWqSJXbPELAu5SUSNoVlpX1jYOsYjDyc0U2K07ZO+yekK60kpgAEsBDDtI/BBqPgv8Ti5+
 HZEho9dxDiR+FFJyVwvbEOXdSJuU1LEbUl9ZqIgLxv7vHrmTgd9uzBEvtE/+EPQ7Rs3o1Wdy54F
 YuLcoFenpF92k/Kx4Vv+E2OYsipQgjlwdH60skHNzyEpZWIIWBaqwGmGkrArP5i56wlsleUrLUH
 trag8GpEhry5HIvOpUktOare0Oiz3+bO7Fc3MrBLOPhdi0h79rpfuBUZ0cLZseIXKE40jb7LC/B
 OFFNU0lSeNo3/1ZYgKCTaOucLdPjKnqhii4H2vR72OIuVINb06JlWpE6Qovvz/f6f4Y+LxuzY0x
 L8SN7UryTJNVS2RvGDYRuLTOzrd3zsZpTkx/YALfMuujpYm3ebcd+G1a7P0o0MZqvEEUz85A==
X-Received: by 2002:adf:e00d:0:10b0:487:22d5:955e with SMTP id
 ffacd0b85a97d-48b0419ebeemr2312662f8f.7.1790785858390; 
 Wed, 30 Sep 2026 09:30:58 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b0692b5d7sm135097f8f.28.2026.09.30.09.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:30:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 510CB5F8D0;
 Wed, 30 Sep 2026 17:30:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH] .dir-locals: include QEMU code in PYTHONPATH
Date: Wed, 30 Sep 2026 17:30:50 +0100
Message-ID: <20260930163050.426737-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

When editing python code the linters tools have a hard time with our
imports as they can't be found. To ease this we can expand a
PYTHONPATH in .dir-locals so at least Emacs users can have less
warnings in their editor.

I still get complaints from python-mypy about missing library stubs
that mean it can't do proper type analysis though.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .dir-locals.el | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/.dir-locals.el b/.dir-locals.el
index 3ac0cfc6f0d..51871619422 100644
--- a/.dir-locals.el
+++ b/.dir-locals.el
@@ -1,2 +1,8 @@
 ((c-mode . ((c-file-style . "stroustrup")
-	    (indent-tabs-mode . nil))))
+	    (indent-tabs-mode . nil)))
+ (python-mode .
+              ((eval . (when-let* ((root (locate-dominating-file default-directory ".dir-locals.el")))
+                         (setq-local process-environment (copy-sequence process-environment))
+                         (setenv "PYTHONPATH"
+                                 (concat (expand-file-name "python" root) ":"
+                                         (expand-file-name "tests/functional" root))))))))
-- 
2.47.3


