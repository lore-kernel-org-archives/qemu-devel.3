Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86750C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lOu-0007qO-LX; Wed, 16 Sep 2026 04:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOp-0007l7-KZ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:53:52 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOm-0004zG-Gy
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:53:51 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350f91so334682f8f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789548827; x=1790153627; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Oc6yr6zbpyTI1sBnf60D2N+15kHWjne7Pv8s7CbUCQc=;
 b=KDSOOGQFM4DHYFlcAivzMKZ3KQ1KmVxQ3wKew9NsU97K0N4oWW7dJbQWDm/ioqhLRH
 zjI8HmcS8BL1eygxladKMppmnnLAedhwjxOupjWAXpVz8eyt6Dc7p21vvnOkRav7CXiR
 +CgYlqXpwS26gsNVcNe/m+1FMrQq7Q9TMfYC9PEcUG3Xa3wSNrLSHMyy5n2AVbXB10ix
 B7MTvAuUFpqOD0IgqPMR2JY1l3e268k//7bniHXWJ3QU22GjIWhCt1RGUFXk7BDt+Kk4
 gHMkLeXSB/lugKxWbpuaGCrrb18gKjRIWY5JedoBimSdQmFS2kfhJ0SHZ9hAlRla8Yeo
 u5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789548827; x=1790153627;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Oc6yr6zbpyTI1sBnf60D2N+15kHWjne7Pv8s7CbUCQc=;
 b=f8bbPBHLs3aJhAv/DTj0NANmxsqy+aUFM8iFmUsKygg1ZORYQ5Z6nKxBGgt7Vy/mY9
 wBEK9ulYThiqUz1WnF3H4V43IeZIi1G2g/x975cewvrqDlF+gxcITOGIFokoBWMq5kPI
 OhL0etsUdzhBoaH03xr2rpeaG88ZKMpVoZAZtBr6E/E1thOuNJIR6bdAxWUUteLmN5Jo
 MpJUzQR7/jgGHCIdtZkhwqwh7zSlJdRigZpsYFzyUPewid0Fe7+u4xcYayefsUzDL60S
 n8+T6cwJt0hluJHSdWmvRezeL1ROTd4Vyv96+p9BomDiLBC5CXmER/S3ud2CnShV1UPM
 TVtg==
X-Gm-Message-State: AFuF++lkCnAxnHPFWCyECXjlz0aGyRPxmRGrAfhL48b4Ji/rXSAVEr4O
 Lglx2SK2oz3EeHfwE8pD3TQ/RDRONqBKrgYbBPiEn9HO8OwkhmJV8OpiLNCbR3huFno=
X-Gm-Gg: AYBFou2ltFcJiQP6XGzQCDwVvjQc7EtVet+f+rmXOyG0AK+tus1xmdXvhNHB+bpH9eC
 Fs451WPUAX4bjjYAghhCg22kiNsjqNx0ik3riHp14gywYRpKx296aNniQ5eoGpJYbb72SpXNe8/
 lCKgORbO9tVMEc8HAQHve5Np1Nah2BAh6kuh+QNbgiuCgAfh7nXV4Hzp17ap3we2mGQDhx/BNal
 r/K4O6V/ltkKE8o2Q2vyIcC+StyQpQhP8z4dYbCNxcZEqXskE5d6JS98tes/rwLmBUA7GePctJm
 dSH/avQJJ966+aDq4WjQBsOiYxVPdVYhjTxaTrY21qjhvGftnDcLVEz8u5ENuYY7oFhz80fcRRZ
 ExTnBCvAfevrnuu/hIS4rsPNa8Un+wu/CUgFTshC5csTLAnGmujjc2gxdBTgSw7M8cccEkmbjEi
 LTscD4lzAxxfS7iy+pFtHSFHFmw4VuJW3cRbeGAFxi9eE2Y21Ej16aGY6ZQ4Ucu14MzBw4eV0=
X-Received: by 2002:a05:6000:46c6:b0:487:363:d8d9 with SMTP id
 ffacd0b85a97d-4870cf20995mr1608042f8f.18.1789548826910; 
 Wed, 16 Sep 2026 01:53:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf26c8dsm5868377f8f.14.2026.09.16.01.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 01:53:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2CD3F618C3;
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
Subject: [PATCH v3 07/17] tests/tcg: prefix meson built docker tags with qemu/
Date: Wed, 16 Sep 2026 09:53:30 +0100
Message-ID: <20260916085341.1692742-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916085341.1692742-1-alex.bennee@linaro.org>
References: <20260916085341.1692742-1-alex.bennee@linaro.org>
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index e966774c8c2..5e2ee3e6e3f 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -217,7 +217,7 @@ foreach target, plan: tcg_tests
     image_name = 'image-' + cc_dockerfile
     has_docker = docker_host_arch_supported and docker_supported
     if cc_dockerfile not in image_targets and has_docker
-      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', cc_dockerfile]
+      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qemu/' + cc_dockerfile]
       t = custom_target(image_name, command: cmd,
                         build_by_default: false,
                         output: 'no_output_' + image_name)
@@ -232,7 +232,7 @@ foreach target, plan: tcg_tests
       here = meson.project_build_root()
       cc = [docker_wrapper, 'run', '--run-as-current-user',
             '-w', here, '-v', mount,
-            cc_dockerfile, plan['cc']]
+            'qemu/' + cc_dockerfile, plan['cc']]
       has_cc = true
     endif
   endif
@@ -241,7 +241,7 @@ foreach target, plan: tcg_tests
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


