Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B10AC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LtA-0003P9-8H; Tue, 07 May 2024 10:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Lsk-0003BW-89
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:30 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Lsg-0001Mj-6U
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:25 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ecd9a81966so34885695ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715092399; x=1715697199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tacbeao5rfkPxJFPTQiS5odWwv69qO+6Pb46/LGm6jU=;
 b=DLPPs2kL9bHa5plRpZEu7OPEUY22LePlsUnjBDNY5vshifm6QPN8iOis3GnVLuktcK
 Ex+B5aTZPyosZdTh2f04fhKqBC/aMufke6oXVy2fB4uhAkZEUh/bSTxj4KBq4WDqltMW
 +/TWzVrnmBHe4j0BvLya9lDrj1rhe7bVsooR0jlopN3v0D/Wf7RQ6vwqJy+rM+CtL9gk
 avBfIWAZJBmoP1ONnACAa+GbHJS/VM9WoRVX/2ECtP+6luLoOjE0aIuinhmhQdqj6xvC
 pILqeY2iBA34FxoSAn+8s/az2VGAdnJ+AnLOAXIQdwoiusz6wqrFyUEXE1jr1ha/c9x7
 qZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092399; x=1715697199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tacbeao5rfkPxJFPTQiS5odWwv69qO+6Pb46/LGm6jU=;
 b=mY5MH8B6MIAOnT9T9dOBaZHiOo13CbRMxLZ4o42VzCsFy48r6AMSxZKMOCOJiNE4p8
 OLhIk4WfxdgqT0IHA6qUidl7ZK/Q+RD+459PKuw1SY4lTt4wSGQT+T0SoIzLrC1DWqhd
 CuOWC8cynFc5nCTjWpZbmleByMOorz3f/ozCx53SIf21g92fhxf4wUhNUfZKuPnqYRm6
 V35FoA37yN+2/OkluqFnjeEtXbvS01pUh61NUjNYf0oTxfSerj9lLZ+KJVvAEE+Z7f9H
 s/JD4yvkWSTM4ocmRaP8FzYUPF9jCoQ4XjM6nqKfVlhleCaU1ZFaUTUEVXxJs+5R+8th
 ETmg==
X-Gm-Message-State: AOJu0Yyf2Q53iA8TG5Aw/9CsR0nUr9+bb4nHnVwIsnC/3NukCnodkNZW
 WaF8u+CqjjaO9/dajdO6XdaL3mS2kzkDt6iEko021EvyfnKPLhgPnCsipYjQ3RD5oQJQDBMv7Pg
 Q
X-Google-Smtp-Source: AGHT+IFNUGW7y4URfvUftnCmdOepzCpwlxN2NmW0v+0aGlRU9b1J+j+dg070Jw0MXLemYh+bnOBKEg==
X-Received: by 2002:a17:902:ec84:b0:1eb:527e:a89e with SMTP id
 d9443c01a7336-1ee63463d05mr43662915ad.26.1715092398871; 
 Tue, 07 May 2024 07:33:18 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a170902780300b001ed2d84c1cbsm8690097pll.193.2024.05.07.07.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:33:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 9/9] gitlab: Streamline ubuntu-22.04-s390x
Date: Tue,  7 May 2024 07:33:09 -0700
Message-Id: <20240507143309.5528-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507143309.5528-1-richard.henderson@linaro.org>
References: <20240507143309.5528-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

We have one job to build user binaries and one job for system.
Disable tools and docs in the user job, and disable building
the user binaries in the system job.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
index 0a2d2bd332..25935048e2 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
@@ -15,13 +15,13 @@ ubuntu-22.04-s390x-all-linux:
  script:
  - mkdir build
  - cd build
- - ../configure --enable-debug --disable-system
+ - ../configure --enable-debug --disable-system --disable-tools --disable-docs
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc`
  - make --output-sync check-tcg
  - make --output-sync -j`nproc` check
 
-ubuntu-22.04-s390x-all:
+ubuntu-22.04-s390x-all-system:
  extends: .custom_runner_template
  needs: []
  stage: build
@@ -35,7 +35,7 @@ ubuntu-22.04-s390x-all:
  script:
  - mkdir build
  - cd build
- - ../configure
+ - ../configure --disable-user
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
-- 
2.34.1


