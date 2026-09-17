Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A6FC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7FQ9-000868-4U; Thu, 17 Sep 2026 12:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FPH-0007gG-50
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:56:20 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FPD-0000cs-1d
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:56:18 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso10392725e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789664174; x=1790268974; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aL25Ot0fmXEuSCVXG7iCqZEZr1JVeqTGJ9SnFpXQUgA=;
 b=E0khSj21ifawzCNcbxrhh0ihq+c7mR5urWAG5X0SBDjYrF4mhZFLLucq6L+rRFtlRs
 uub9sRxdsqJQL3MVlWeHXRb7JEWOT2bDZQZVYi2XqE3Ph6P4QUnzcnmC3ePnkGLP5bPi
 X8PeHpxA/LKZQK2aIpgrbzj4B3Po0PyLJA5WIUg7pBWo6ubmbBd9cFH0oyDstrPM2DUb
 HPGWgA+AFxubrYbg6wnpnLQ/N/SynU6chhH+wbK+RAD5LTi6OTGsz4poatsznnt75YYq
 cP6LRWZwsKGhjr0H3647t8wWzSbjf4f2/V+cRk7FlRhFycTBYjVHxgo8YWo/7uGwKZcM
 MY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664174; x=1790268974;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aL25Ot0fmXEuSCVXG7iCqZEZr1JVeqTGJ9SnFpXQUgA=;
 b=zZRdMpUgwsaQexHL97iyJC7vwySD1R5sQDk5A//oIogFKpzcLZi6wbHHTz+De3X5WN
 beSfT9z0TNytUinambVWNndmjw/rchJT2/LF/CzzeNmkJSlLdMktQCHa3GqUxo+Asyn7
 4imb6EGNuwZhrXaFR/csxMdZkxhgXddzxUqqLq3Vhd7NZKyOnXQCXE6KF7ojMOvCN7Y8
 mvUFNer3Y5fbSEqj3HeLucXP9PptXMtjVj+pQejWAIKpE3RyVHGKWTs0Lwg1LTiPFRq9
 MD9JFbZtKpO05C+LCHva7cHjC9/8Saj7WjLZ1LCU2q2YE6EP4RyVAejofhJZ/DcgoCoF
 w8oA==
X-Gm-Message-State: AFuF++ne1JxjQJCPl7Du8QgIagx9lcdtVJ4oL9lg/JoPxq8GLAv64Af1
 hX/V400g02Logr2b6lsXiywo5hkFmaM5wCaDxfC451qlUCVyHYcWK66UFb9EBIPUWwE=
X-Gm-Gg: AYBFou2raRP5S/09Yr6b1dhn7NUQ2MDbeui2kXxvZ/e+/qqzBVCeVUtskrTwLzLdUvG
 ehQGxe3hw9KtunWuP9rCW30gW5nFL5P92+oAyTNeB0lzyvVa6EVM61cySgSbzrkQOG3oIJbCnqP
 0NZMuWQCXMLAe9h0BwcoWmsnmLhudhhDL26ENQKgCBu+s5BcWPbQ65gmTdwg9a5laptEWBI1aZp
 hvCPJN0ep93b5b63pYr5J7qlXcOUiXHHvHePyFFHZSuit9T6mj9kLqsin7BiCBEiDQvMEiJ4gmZ
 zN62ofq6SvjFoAsV1S8p3jzEYazEw+XeUHsXTvULX3vgbcp1W5Pq8gtRgiNvEhxL3v0hOANNZAq
 9pKDpM6U5zxKbPSfJtEPUkZ9PCjk9lEnRbXNHS3AE6LLOB4UVU1SyY86QnFUdG1bZbGpAWpehRV
 fU+PbtfCHXAxByLcVECmxZn2cFOfyemnGLjXpbJvc8Dw4qnTVSwg8NJghpRqEuCYAbRTBGdaU=
X-Received: by 2002:a05:600c:1d29:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-49eb72fc10fmr96022345e9.15.1789664173673; 
 Thu, 17 Sep 2026 09:56:13 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd216028sm88178225e9.7.2026.09.17.09.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:56:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C6EF65FA8E;
 Thu, 17 Sep 2026 17:56:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Brad Smith <brad@comstyle.com>, Kyle Evans <kevans@freebsd.org>
Subject: [PATCH v5 06/17] tests/tcg: prefix meson built docker tags with qemu/
Date: Thu, 17 Sep 2026 17:55:50 +0100
Message-ID: <20260917165602.3405537-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917165602.3405537-1-alex.bennee@linaro.org>
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

With the meson changes we now build the images directly by calling
docker.py. However the Makefile.include builds prefix all the images
with qemu/:

  # General rule for building docker images.
  docker-image-%: $(DOCKER_FILES_DIR)/%.docker
            $(call quiet-command,			\
                  DOCKER_BUILDKIT=1 $(CONTAINER_COMMAND) build \
                  $(if $(DOCKER_V),,--quiet)		\
                  $(if $(NOCACHE),--no-cache,		\
                          $(if $(DOCKER_REGISTRY),--cache-from $(DOCKER_REGISTRY)/qemu/$*)) \
                  --build-arg BUILDKIT_INLINE_CACHE=1 	\
                  $(if $(NOUSER),,			\
                          --build-arg USER=$(USER)	\
                          --build-arg UID=$(UID))		\
                  -t qemu/$* - < $< $(if $(DOCKER_V),,> /dev/null),\
                  "BUILD", $*)

So to ensure we don't end up building every container twice make sure
the naming conventions line up.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d41a228fb3d..0604c4b90b9 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -255,7 +255,7 @@ foreach target, plan: tcg_tests
     image_name = 'image-' + cc_dockerfile
     has_docker = docker_host_arch_supported and docker_supported
     if cc_dockerfile not in image_targets and has_docker
-      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', cc_dockerfile]
+      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qemu/' + cc_dockerfile]
       t = custom_target(image_name, command: cmd,
                         build_by_default: false,
                         output: 'no_output_' + image_name)
@@ -270,7 +270,7 @@ foreach target, plan: tcg_tests
       here = meson.project_build_root()
       cc = [docker_wrapper, 'run', '--run-as-current-user',
             '-w', here, '-v', mount,
-            cc_dockerfile, plan['cc']]
+            'qemu/' + cc_dockerfile, plan['cc']]
       has_cc = true
     endif
   endif
@@ -279,7 +279,7 @@ foreach target, plan: tcg_tests
   if has_cc
     summary_cc = plan['cc']
     if not cc_from_system
-      summary_cc += ' (from \'' + plan['cc_dockerfile'] + '\' container)'
+      summary_cc += ' (from \'qemu/' + plan['cc_dockerfile'] + '\' container)'
     endif
   endif
   tcg_tests_summary += {'cc for ' + target: summary_cc}
-- 
2.47.3


