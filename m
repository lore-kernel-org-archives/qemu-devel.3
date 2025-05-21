Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCA0C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmX3-0000Rl-8r; Wed, 21 May 2025 12:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmWx-0000NV-Rk
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:00 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmWu-00068A-HZ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:42:58 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ad55d6aeb07so352181266b.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747845772; x=1748450572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04euknF6hiqA68aLuG0ENQyvrvDpr8jpqKbpqudmzQg=;
 b=d/q3okzGMqhqPNOXMU4iLp6hsqwnFsrNu5wszs3D64jHOg8kN5hI27Tg0wBOe1T9es
 xXa9L5z285ut2ebSMvqSkG2et5Z02E0fXtUBO5yEm4317fuxPuuHE3LA2TtCUmJ1MFtU
 eeuZ1iUUgpSq9g2MAZ4zocGPqUJ2rI+0Tfyob2GZ8q7LW7kBB4LOHUqtS/2EFeYi+V0U
 FTAlrmW+8ZgIITKe5hJHEmt4aippMMRj9nnGAiVrthfiE0EqZw2x9py/g485dkDai856
 f4uJxDcR2XsrTHjB0yfKgOvSBCtZ5EExreopyuoBQhAzKhyanKTjMaYh2DzuseUFAejs
 gQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747845772; x=1748450572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04euknF6hiqA68aLuG0ENQyvrvDpr8jpqKbpqudmzQg=;
 b=NziqReBRNy2rchRlNem4n/c+v0fqtoE1NpMyYj5SMgchWBgL4KufiEShksklnARcLW
 QJLfAVnJjBaOb1irVgi+k/LRSQnx8bIa27+0ivR3WNHqikK9wdaSsUbDEzVt8T+JTgAS
 8zLTBJB39rriHq/E0bwHQ8oFRQ0G7GghJH1wSGjvVbJ1FAjFyFVPE6VnlnSnlvswZUTk
 cNXjUGJMwPjcj9MicrSsCGrCT7eoFS+ZDqrOW3WrqW0UcnLoxTgwnlMggl4ce++uryWv
 oyxP7nNRNnvjkq8YyQB8+IpK8LxmUbgyEemNILA5deQ9T7oh361mYvnR6I3GXjQcHJ1A
 vAMg==
X-Gm-Message-State: AOJu0YzwdfcSMyeC7i5Hw8OWGAxbTaCSlGLO05a11w8Ck2fAU+i3IbsD
 GBTxJyt5DMhZ8cWuoNzxobqfjv0g6T/mjcYjxjIovSKrn0anmqzCqp5y1Oo7x9bgxPw=
X-Gm-Gg: ASbGncsrvPzDhpJViWSTkI6rm+isyhnq3LV6rOL6bwIuVweoH8VHFliYjlpq2J3rCX5
 hOrohTvqNXNCq8xpi8HP+hiRgiLQcQBqw6BjlY3sqtPd7tlpppAMnT5u77IetDw3JVJpga18fZ3
 c569q/uWhFafyvXDMPmRM9dGyXt4fVTujpNNw4iiafFop/1jLn6L+/nFq8VNwCBZ/WRR6BtaDut
 Xb400vhANS22Rg9hyEBsioIPNhTocxDhblPQMPVGkEl7WmC0+tuco3PRNAHroOJul9fCLiJNHzq
 2ttx5T44i4t3U9nZm+1MH0tqvgzUnLjuBZkSJQzmslZOzkopGs62
X-Google-Smtp-Source: AGHT+IEyDJG1ivknWj8V2HWzfN+RKXW4ZVVvnu189k/2FQL2+fsx87GLzrgbKPC0kNm8wnMHRsUxYA==
X-Received: by 2002:a17:906:1306:b0:ad4:d9b2:6ee4 with SMTP id
 a640c23a62f3a-ad536f2816fmr1546499766b.49.1747845771659; 
 Wed, 21 May 2025 09:42:51 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d43770fsm941924866b.91.2025.05.21.09.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:42:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 444965F8AD;
 Wed, 21 May 2025 17:42:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 01/20] tests/docker: expose $HOME/.cache/qemu as docker
 volume
Date: Wed, 21 May 2025 17:42:31 +0100
Message-Id: <20250521164250.135776-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If you want to run functional tests we should share .cache/qemu so we
don't force containers to continually re-download images.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - Share a whole .cache/qemu path.
---
 tests/docker/Makefile.include | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index fa1cbb6726..3959d8a028 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -185,8 +185,10 @@ docker:
 
 docker-help: docker
 
+# Where QEMU caches build artefacts
+DOCKER_QEMU_CACHE_DIR := $$HOME/.cache/qemu
 # Use a global constant ccache directory to speed up repetitive builds
-DOCKER_CCACHE_DIR := $$HOME/.cache/qemu-docker-ccache
+DOCKER_QEMU_CCACHE_DIR := DOCKER_QEMU_CACHE_DIR/docker-ccache
 
 # This rule if for directly running against an arbitrary docker target.
 # It is called by the expanded docker targets (e.g. make
@@ -195,7 +197,7 @@ DOCKER_CCACHE_DIR := $$HOME/.cache/qemu-docker-ccache
 # For example: make docker-run TEST="test-quick" IMAGE="debian:arm64" EXECUTABLE=./aarch64-linux-user/qemu-aarch64
 #
 docker-run: docker-qemu-src
-	@mkdir -p "$(DOCKER_CCACHE_DIR)"
+	@mkdir -p "$(DOCKER_QEMU_CCACHE_DIR)"
 	@if test -z "$(IMAGE)" || test -z "$(TEST)"; \
 		then echo "Invalid target $(IMAGE)/$(TEST)"; exit 1; \
 	fi
@@ -222,8 +224,8 @@ docker-run: docker-qemu-src
 			-e V=$V -e J=$J -e DEBUG=$(DEBUG)		\
 			-e SHOW_ENV=$(SHOW_ENV) 			\
 			$(if $(NOUSER),,				\
-				-e CCACHE_DIR=/var/tmp/ccache 		\
-				-v $(DOCKER_CCACHE_DIR):/var/tmp/ccache:z \
+				-v $(DOCKER_QEMU_CACHE_DIR):$(DOCKER_QEMU_CACHE_DIR) 	\
+				-e CCACHE_DIR=$(DOCKER_QEMU_CCACHE_DIR)	\
 			)						\
 			-v $$(readlink -e $(DOCKER_SRC_COPY)):/var/tmp/qemu:z$(COMMA)ro \
 			$(IMAGE) 					\
-- 
2.39.5


