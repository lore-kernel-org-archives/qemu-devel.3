Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A09C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ZbR-0007of-E4; Tue, 15 Sep 2026 16:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ZZl-0006tE-5u
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:16:22 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ZZc-0003JT-Hi
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:16:15 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48449f62b93so45306f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789503371; x=1790108171; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dM4u0r6eILzCbZESrBWVF/DDnjUwt9qXh1+CvKMqj6s=;
 b=XuqjymPAcHSzvA6yTHZkwnRwL6e5klvbuBcfWhrl41DPjUHkiKVg1KgNMCdf8H3WLT
 fqf0ae1r0GTIgBsub7dh357/EY8cG+0ue1kfoe/ocnItiJWa5f+/ZFbTlsvTEVpl3MQ6
 upATmzkWL9902VjSJDLsDhi7wCuze7ZsUoM8td9ewd0LNM8H0IJ3eKfPUIFZsXmt1g60
 YtkkXbfp0DC/PPQSflgs0ZdDy6dj4aSe5VOlEodwZ4DpHMwsg8m3nj8SpLEGmJCC5RWx
 FnV2ntziBN6J5ho7QQb2fR6F1aZjuVwVP+hRcCePNQ57N4Tf3p6j++PkE5cozVynwOW3
 YmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789503371; x=1790108171;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dM4u0r6eILzCbZESrBWVF/DDnjUwt9qXh1+CvKMqj6s=;
 b=SxuucFwiTmtaQz8YALJINzJimVywwQ168YdooAVibtZXBRg/rLdlIjMXwg+54n/t2z
 hc+j2oH1ogf30dgey7H9IjmHlfHxyUmQkUumz5WuN/TU4TZj4Q9B0d9l2D42XncXcwnB
 wTzk6EgAU7SEZcGi5uq7NmUY1Ygdgawer21SghfEN9DPAR7OBWscF+58BZbAefq1J+Ls
 tSTn2Dvw8/btWwF1tJpMoGQKGC6k73wV8xhUE44GdMFJ+UaXHnmFOirsb6QXAG5Esnhv
 GTn/AEa0fbwq+26uqeM0yDKLFdBtV+2qiuRiW4P3pZcPTK7HJnGCSAYiwVV/YWOUytRx
 cUdg==
X-Gm-Message-State: AFuF++nJExj+8iA48NbNzeGX5dQ4//6Yl125ZOOhDhuQJ4ntx0rBtaJO
 9k4XA0JKQTfBZBRG1H8ns84kiL9UPBU8nr+zYEo+0PsPdOVQDmpSyqcw3HCZBnPV6THFUHPlhHW
 MZdoDP90=
X-Gm-Gg: AYBFou3v5Unk8qwTFMZLHjC0P9Hj/FAtHceMZssYFvDpk9ty2+vA8+C1ejiyCcbDJmX
 S/UXahRV4cybmqfPcLq41Q8kZQngPzarTE0xQemkk3Wn5vsZFPouFYjQ6m678wk+E5e8hLBVnR4
 V2Kl/X8XQKxwIJRMyUOhvsvEhGOIcrmoSUpjc/w9v4uQCNbIDBc/Upgoq/yaQ9t8tIiXeHm0mqP
 YbWS9+QWF/OdKR2UYk+OMYFpWte2M8gzRE6dIaMa6C7e3vyfy36WJEXUHK8q66NTmG4FSrm6Feh
 SMG6sJGt1ahJnTDLes77IEB7/MLFWkrOCz+b7JPVh3DVq6Ryi0pFrRWEz8YilgpjQmbw0CYNMn4
 MnC5BTvvhw772o81U4oXpozd0aKeWxbgvU8jyLZl4CyWdWZqia+I2xRpz7dhWOhd/E/yhG9iMEx
 7KzDZmiyZYUR0mkiiT3XgW764iCyA0AcM9LvJjqZCa15vd8EkX65/6FGOk4GjNwklTsT9ahwi/
X-Received: by 2002:adf:e589:0:b0:486:f46d:e77f with SMTP id
 ffacd0b85a97d-48705a4fa47mr5817998f8f.15.1789503371019; 
 Tue, 15 Sep 2026 13:16:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf342a0sm1392279f8f.24.2026.09.15.13.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:16:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2333E61929;
 Tue, 15 Sep 2026 21:16:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 14/15] tests/docker: fix brown bag typo for docker-ccache
Date: Tue, 15 Sep 2026 21:15:59 +0100
Message-ID: <20260915201601.1207839-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915201601.1207839-1-alex.bennee@linaro.org>
References: <20260915201601.1207839-1-alex.bennee@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


