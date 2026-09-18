Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF290C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZeS-0003Ge-5U; Fri, 18 Sep 2026 10:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZeO-0003F3-MN
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:33:16 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZeN-00010y-6m
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:33:16 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485ac898fa4so705104f8f.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789741993; x=1790346793; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RwP+h7pDqlYb0NaLEwModw+C9+r42ewNCJmmzgjaCls=;
 b=T3EBEmbByW09LlYn3M7BtJsf3NZ9HNyOY9spUV8lbMYode7ACusQoZ1gMgpI0/0Y15
 bKapAwusJpZjT0jr7GyjsCazfTqTpZnCE/k/BmkSffa7UPWWQ4iNI0hVNeUorTde/S9m
 /9d3ke/Hkb9V5BnZqEXWWlUUifBnWCby4kEv/t/qDzmvNVhq+0UR6q06cxLBPHt3eWfD
 pU+NmbJeQZtrGTUpqoZzteZ0b9DnWq3M5+yoTs126/19CGXAgnZtQ6v7Y73T5eDSzXmm
 qse2L6DyAOwWahjSJPQFyo5zmk2PNopulzagndVaSV+uoPP4wsRVgO+szdklghRU/UaF
 L0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741993; x=1790346793;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RwP+h7pDqlYb0NaLEwModw+C9+r42ewNCJmmzgjaCls=;
 b=j1oR4aovD/qPtEIYLoPib9KIT3/dm26qguD1unkoW/HouAILwqsx9SpLON5oXxrKjC
 0H7ltoXx3UCM9TDYjmKhljkN8amQ+d9GyDuifO6f63+5FCY/sm5YwErkeknfMAdsy039
 3ta2toUA0b4l9pVeP3WDdbsSA7FRS0nwyM+UhPdnlFsWnsv8VlT3xLFs85aQpR/xVUjt
 B6l0+bZbnNeRVsvETxOYSFCZCp86/Wk1jQNpW+F7d8mhbYts0gsY7RcD1RzZKyh7noxG
 3XTm6Ay3jBsoi7Rtik2uBmUyyjV3G/bwh75euDISswHcQDhchzXf0B6p0L8p96CZaEly
 Wirw==
X-Gm-Message-State: AFuF++l59nCT4HTJ4mmpwR6on405McSQKaZ1KnJSBWwTAPxIBYRvznLa
 RD/ZjyitN4FsaaD8Lis/0/LX08bQBuwDEH9GISzmyJ/QZEfbYkgCtv4s2hIOABqReBM=
X-Gm-Gg: AYBFou3l3xRhNQHFCvfpA7uEzFlZjTPIGhVj386g0dVZIBFcTSMGHC8D0xDQp4MzlAn
 bNKFu/w2JPpOx6i4o80IeJm/c3xV++YC0Cw+rI/5LxOrnpbKVfbi28UJOoDdmiWkRz72wQm3exL
 nYWMIBUH4XKuiSH68dF7Zccf0MRiUfD+sDO9fJmVsjNY9g+MaBs/TOGNi/y1iJ86OVgOPl35hs6
 SWt6gIwR3TgdwiRkql3Va3jMa45igaz2He4zeJGy3ZRgwXsm7lgkxVCnXtqi8d+A+XLKhoc7gLD
 qC8FNcNspoGOWs2gz3BE9Ah8YWzfNJzl0plsUaS7dmS1F9GoTLTotmvEzfBe0WrM/yV/PEaVHrl
 nRDGFkOLBw7bE/S6ovxGqZ/fEL+bjqFKPea/x1+5odZTtrBnRjlEGyg6XqNN+b4XL+NefSTGzSU
 LA4oURdJwz7KMYe/gflQOi119MXV7orwhKOCamAwjH1LXx8OX3aUF694grVGhLLqr8MEnzi32Nr
 My8zn9UBQ==
X-Received: by 2002:a5d:5d09:0:b0:486:f770:787 with SMTP id
 ffacd0b85a97d-4871e266034mr3709025f8f.31.1789741993303; 
 Fri, 18 Sep 2026 07:33:13 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48720072501sm4457218f8f.22.2026.09.18.07.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:33:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4062A5FCC6;
 Fri, 18 Sep 2026 15:24:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 16/17] tests/tcg: Fix building outside of the source tree
Date: Fri, 18 Sep 2026 15:24:27 +0100
Message-ID: <20260918142429.336497-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142429.336497-1-alex.bennee@linaro.org>
References: <20260918142429.336497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Running TCG tests from a build directory that is outside of the source
tree fails with:

    [...]/qemu/tests/tcg/multiarch/libs/float_helpers.c:228:1: fatal error: opening dependency file tests/tcg/s390x-linux-user-float_convs.d: No such file or directory

This is because the build directory is not mounted into the container.
Add this mount. Do not bother with preventing overlapping mounts, they
are harmless.

Fixes: 27939ad414ca ("tests/tcg/meson.build: introduce cc_dockerfile and cc_docker_host_arch")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20260915110855.491985-1-iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260917165602.3405537-17-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 95f533b0ab5..a5e0462732d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -277,7 +277,7 @@ foreach target, plan: tcg_tests
       mount = mount + ':' + mount
       here = meson.project_build_root()
       cc = [docker_wrapper, 'run', '--run-as-current-user', '--',
-            '-w', here, '-v', mount,
+            '-w', here, '-v', here + ':' + here, '-v', mount,
             'qemu/' + cc_dockerfile, plan['cc']]
       has_cc = true
     endif
-- 
2.47.3


