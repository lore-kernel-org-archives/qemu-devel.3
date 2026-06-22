Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB95CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbgmd-0004i3-3D; Mon, 22 Jun 2026 11:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbgmJ-0004f8-BT
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:41:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbgmH-00067Y-HZ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:41:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490b8ac62baso288385e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782142896; x=1782747696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dYi9qbpIREPaLo0UpNm1/FXXAnbHR9c2f/rHOqLOgf8=;
 b=JNOnGW7eUpdmWkgtmLA8nw0qKGQSbdH/g2SvJrd5FyMYXc/eGzP/87LYPm2O3jCmG4
 UauEY0aMHQDSNHY1QcmsSm2ElQyy/V+UGmDmsm9AaeEjSVNKEUwp84Abk77B6Mp2adpo
 mMsGUGwrbpCW6vblShBMZNu9DV43qhliCz2Fx2z3JauXtT+Am4n5lDPS7QCu9GzbiFtk
 zMzxAo6/7amZhU/LkOcdtM8GsrNbcTDl/VZiS1AsK9yJlYWGLKyrnvfZHVHq2QJ1lRK+
 qD0WndIwn/Vg+Sa2Rf9HHLf7itskd0hJLiNWurOvjZKLXwECTOyDsDtepzKt4UdLZZtx
 JrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142896; x=1782747696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dYi9qbpIREPaLo0UpNm1/FXXAnbHR9c2f/rHOqLOgf8=;
 b=Ui7yW9zLTKWD8tjT4KMFtGWzBndEjcqKqeU2pypQyowHjuE5a//roenXNW1Js/6rLQ
 iH9KGYe7GSgaEvE4zF/je+IIwEvL98LbJeiW97Kk79te/Ir0HE3t7CmyU2YS7VR7m5yQ
 13RKoUrCQypnRnlqRe3qpiN5htAAd7iOdlZMCzyr0P7egc+1EnZKgv/QNtF2wUHbZjyx
 wAYdlodNFGCD/Iv+engNuldk0Xi8o/rX9fBge73WpIf495sl/cpMD0byILl2A6CUoNfT
 NN91gbODoghRN16S8uE3U91+rUEIEGyWTF6+g8v9td+Pq9g4E5CdJZwPoFTuw+7UX04Q
 ye1g==
X-Gm-Message-State: AOJu0YzBEsdAk8bEiMR2AFeP5MydnH2DE8J+7GBcC53m9mp/0D0VBCJn
 mFDobsoqH763Mrl/FjcgYMvt0D//pSWTkxvqQLgSO9fHHzRje/mjwPQw/oLFC4pZUrI=
X-Gm-Gg: AfdE7ckT2OG7d6h4bCKKZvsh7ZDU8SSzXUKNYMJcP2RVUGwmRAUu+L6LMJnVCxrar8m
 qdlwF8NGdD6fvNpyRq9i5CoU00KJE5y0j1owrshKrF6RckJPwHdlGgAQGTpuUj+tGxluqErgOir
 bSSFKOJF9SDs3PEbf8regjBZCkHAeZGrztdcAWQYqGVc+vvuu7TrHvfebNrmHLoxZc1M5aK4t17
 pEM1aWmT6Z5twQxz+AYn+yT1NfSfdo8ceTGKuYIWSZHdZ07XVzz+pQqq0JrvTVhvIep/6uSuHKu
 d3CMdAFj+WjllKGSWBuRklzztKZPgHmIZyuY/l+RfngTlpp+JJ5KoFTCUd3AwBLHdySPAPfqAyd
 TUyiLTFFJvQv7+IqS6gkYsY07MmgHIQ8tpEwW7TJ/hrBSXmKS/UHL1aXlvOZwU3v8AJcsy3fAet
 T9oVN8RgfUk8f1
X-Received: by 2002:a05:600c:a112:b0:490:7df7:9190 with SMTP id
 5b1f17b1804b1-4925a0a9c33mr507305e9.8.1782142895718; 
 Mon, 22 Jun 2026 08:41:35 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49249207dabsm383326895e9.0.2026.06.22.08.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:41:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9915B5FA02;
 Mon, 22 Jun 2026 16:41:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 4/7] tests/functional: tell pylint not to check c-modules
Date: Mon, 22 Jun 2026 16:41:28 +0100
Message-ID: <20260622154132.3166748-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622154132.3166748-1-alex.bennee@linaro.org>
References: <20260622154132.3166748-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

To fix:

  qemu-test.test_pylint "/home/alex/lsrc/qemu.git/tests/functional/arm/test_integratorcp.py:83: I1101: Module 'cv2' has no 'imread' member, but source is unavailable. Consider adding this module to extension-pkg-allow-list if you want to perform analysis based on run-time introspection of living objects. (c-extension-no-member)"

Manually running python3 showed I could indeed import cv2 and call
those functions. Rather than allowing pylint to introspect lets just
tell it to skip c modules.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260619155657.944220-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/pylintrc b/tests/functional/pylintrc
index 049c3e76f12..949bea611fe 100644
--- a/tests/functional/pylintrc
+++ b/tests/functional/pylintrc
@@ -58,6 +58,7 @@ confidence=HIGH,
 # no Warning level messages displayed, use "--disable=all --enable=classes
 # --disable=W".
 disable=bad-inline-option,
+        c-extension-no-member,
         consider-using-f-string,
         file-ignored,
         fixme,
-- 
2.47.3


