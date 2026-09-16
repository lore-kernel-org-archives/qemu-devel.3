Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9684DC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lXy-000767-HY; Wed, 16 Sep 2026 05:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lXj-00075Q-Rx
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 05:03:05 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lXh-0006Ui-8M
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 05:03:03 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so3547485e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789549379; x=1790154179; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dM4u0r6eILzCbZESrBWVF/DDnjUwt9qXh1+CvKMqj6s=;
 b=z7E4vYTNKOZ6UXLu2wXnzrMS+fA7+b3rLt1WBZ1KT5rB+RsfyDjsEly406mn6XzQD0
 Ycycp5t2vi5BWuYdVGJftwDqfY97+jcj6Hc1fIa+aRg0sUe6FLlcNsMdhSC2Yx2uZ6PB
 wqevjMQmlSQEjO4iTBetqBWMvwpa8gpnKxB+NNFl07Fzna31c/Jg8+D5ugolsb5vjWEl
 cQXQxlrMxv1r9RMBVj79Hsbn/6fneftC2jRGu+Xj0lrhsrQESGgaAvbZmbcBugJO/XdN
 CaXgubrShYLi1ck4dxAo0Xm6F7anmSfU5n8wRvB0iihlIMzIMQzB3x7smiIS0Zsgzc7L
 aASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789549379; x=1790154179;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dM4u0r6eILzCbZESrBWVF/DDnjUwt9qXh1+CvKMqj6s=;
 b=so4rr5fu6tY6RxZIilYoxEsrEsGPOouHhsLdav/uyFO2O175TR5pHNVD0j7ZH+Qo3C
 94it1uSuEQgMV7Cvu69Z/bwmCLchyxMGSCb3ZXO6iS/YwOFnP43NX8PsV5P5FYjzc68A
 Q2RiAc1gHnCQW2dGwuSIFgM/KNROgibo/Nlr1gB0qtKZrX08jvz3DHdhSMfZ/XR70EvZ
 cUT0CygTHH7w5Xy9zoMyu7he1QXXIm8pLfV9aZKLIdX8XfedAY6ZOCW09V4ftHDOb1RW
 vgjcJHqGfKFxC4G9X2jxD+E7Svrb5rOhelszRZexJR5YpsCbh6+Dt1kpbO7PVULc+0eX
 Nb6Q==
X-Gm-Message-State: AFuF++lz8q/r8axMHgb2sUQhmmhAOn5AcuuMUeGA+lVAdmuAIjx8Zv8W
 QhZotSXjwD2pTywmIGw07uyM3neeBf0C3vFvByoRrXulEXBb3Lz/BdJHqbQRCmRmai8=
X-Gm-Gg: AYBFou009/3vjkuwhj70fn907dyVXUUmLponI9PUbGRmsqH3IdSOSR9k76Fktb3krSm
 y0F98adW0kmuiMSOfYa0VC9T5CCttmZIS+qhr9jxGH1DX5bA5WCI+fJ64d/lWaWS/BhJ3hB51EO
 hhiw4sKz0AzsQNOqTBl2TrNrt3hnX7CODJlyPuOVoVeM9sXF2jpEOrrWJD6gwhVpLPda1etnWXI
 N3A4ixREmbAEBrHaKhwXkO7AWH7NK8R28hgLqKZ17prSrmcw0wppMih7xUUTsNOSeQRGWXseE2A
 RjdgQSNtP+VZeX2VxZWuUzjigm8l0rvBJt1fEwXJqv/f8sBj3IKCdOUx2cCc6jI38Z7m2EOY809
 4snnzgHCb6zhNQYmXwXasA0cR/abn+wXG2zKeiydiDM4VmSiNbYQRWAzkyD1HGiKkSLfpsrVjBX
 HhSBXixig9jRl3fAqtfyMVoAk85/jarnLm/CuWSOuIYIE+AmcnMPclMB67CXyuLGswnXdHyJRe
X-Received: by 2002:a05:600c:8b30:b0:49e:7862:c09e with SMTP id
 5b1f17b1804b1-49eb72fd676mr18611905e9.14.1789549378914; 
 Wed, 16 Sep 2026 02:02:58 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83da99b7sm60584835e9.10.2026.09.16.02.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 02:02:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB22461929;
 Wed, 16 Sep 2026 09:53:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Warner Losh <imp@bsdimp.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 Kyle Evans <kevans@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 14/17] tests/docker: fix brown bag typo for docker-ccache
Date: Wed, 16 Sep 2026 09:53:37 +0100
Message-ID: <20260916085341.1692742-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916085341.1692742-1-alex.bennee@linaro.org>
References: <20260916085341.1692742-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 85825d74dfb..fa873e09b4f 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -197,7 +197,7 @@ docker-help: docker
 # Where QEMU caches build artefacts
 DOCKER_QEMU_CACHE_DIR := $$HOME/.cache/qemu
 # Use a global constant ccache directory to speed up repetitive builds
-DOCKER_QEMU_CCACHE_DIR := DOCKER_QEMU_CACHE_DIR/docker-ccache
+DOCKER_QEMU_CCACHE_DIR := $$DOCKER_QEMU_CACHE_DIR/docker-ccache
 
 # This rule if for directly running against an arbitrary docker target.
 # It is called by the expanded docker targets (e.g. make
-- 
2.47.3


