Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB81C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhat2-0000hs-Q5; Sun, 18 Jan 2026 17:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhasj-0000Mj-B9
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:25 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhash-0000Ru-1U
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:24 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso23000755ad.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773862; x=1769378662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4ISOpBxA1JivydnewaJ3ZoQ2prH+2Mfh7IWpc8xPQc=;
 b=QOZjJCV3Hth1Rg3Ya9uBpSA39L0mujSMUrEi5srrODt/xfwbDYrUMd6Ibl9H6sReju
 X8TX1BBv5YxA9MktrekQVu3Po6CIsn5D4mBLug879+Bi5x+nJn9KedVKVmc3rDMXrGc1
 TFd4HJ96v33bVMLfTgvBwaKk4qYnIY5Dqu4DHDHE7fgvEg2nQ64h8uUYIHp+l5ygiUlt
 /V4ZVACv5qPBAOY45fhsTIsvDLdRteT6XYM7aM+AzC09sP8OBmEmTMbHYuL+e/hsXBYV
 la5os5Vsxg6+VS6O1r6/03D2yEEeeBROqKAwRQlXxvYsQgG1sUwjFOXBnIfkCR5EwUBA
 sk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773862; x=1769378662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F4ISOpBxA1JivydnewaJ3ZoQ2prH+2Mfh7IWpc8xPQc=;
 b=nKKftYz1kaImy/kNXpRIJalU6uUgXqCctvR1ZA3pol/PiqOGzdegANv/YQlrmZD/gC
 lMZK+EL9K7mZLLBfOZzoAUi5UIe0bn1msRcx7OQkNoryETJGpitVrq6ipWorwJr1gqQ4
 j+mbrNZ7J7EbppI/s9X5CNM4O6XJWiFISFVaOqjTdxmyLQN14ivG1hnAgLwPEuMOVsoy
 cYEjw31x1aQilVNCk4fx4sFi+Ed1TZLCFYtln4bZgdPknTvfqjSHsQMiLipvLUSqxes8
 lwaWEVYcZKQh/GhI+YDXEWom7ofGvVEtdgFqJ3KxX1bMpoN8KrbOpqpqGYUnl3HgT0Eo
 uR5Q==
X-Gm-Message-State: AOJu0YwWOkCd3ici+bbPcFHY1UFTZKJ/0rvAIK3bQ5bkxjl76s+muS3Y
 GejXzVXUBIJjfPFJ6XuZ5e3kFDYJjprM/sNc5Hp1P9y2pGZkTQ20y08OUBn2St2pA5TKVkii7cU
 yhHtGFsMfZQ==
X-Gm-Gg: AY/fxX6A4ud+RpW57yxynJSGzYSW+w5ioMCcJ+99JA+PHtD0/FeCa0T/Vms+dXQJ72r
 fo34jfT7HBM75MnG+4r0xJzZqCHybEg76JGlXzhNIbo8GgFtVVthT1mpXzJ8lc1NxXNl5pvI1Pl
 q6MTkBZhxzfHzj6KKPsNy3fu1reRSX9h3GnyL0yZKo/useaRFfyVttI1XkPFrp7GPeuaasOJXT7
 OENLHpLCgIFXXLrlk5lkTuMb+edWBXx0rcp7YlVAAoDf8fjODDBAdtlmR12OHvM6dAMUjQuZbFJ
 0foVbGJJhyCd03TonTTYfxtQBodcaGIWWBeZC4GN6oE+pfXbjK+h+8Kby7CzioJ+j/+c39EG288
 Un9uO3MjEn03fkZpIddF3VotCugDIcIuhNYx/BDUUQJJ1DT4VG6qgHWR84GmoMfNy6OaAYkmp7p
 yKDunu3OvLfqcn9Al6z8c6Q4K6Tjb7
X-Received: by 2002:a17:903:fa4:b0:2a2:dc3f:be4c with SMTP id
 d9443c01a7336-2a71752aff6mr70695005ad.10.1768773861586; 
 Sun, 18 Jan 2026 14:04:21 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:04:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/54] gitlab-ci: Drop build-wasm32-32bit
Date: Mon, 19 Jan 2026 09:03:21 +1100
Message-ID: <20260118220414.8177-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Drop the wasm32 build and container jobs.

Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/buildtest.yml       | 9 ---------
 .gitlab-ci.d/container-cross.yml | 7 -------
 .gitlab-ci.d/containers.yml      | 1 -
 3 files changed, 17 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index ea0f5bb057..e9b5b05e6e 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -785,15 +785,6 @@ coverity:
     # Always manual on forks even if $QEMU_CI == "2"
     - when: manual
 
-build-wasm32-32bit:
-  extends: .wasm_build_job_template
-  timeout: 2h
-  needs:
-    - job: wasm32-emsdk-cross-container
-  variables:
-    IMAGE: emsdk-wasm32-cross
-    CONFIGURE_ARGS: --static --cpu=wasm32 --disable-tools --enable-debug --enable-tcg-interpreter
-
 build-wasm64-64bit:
   extends: .wasm_build_job_template
   timeout: 2h
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 7022015e95..6bdd482b80 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -86,13 +86,6 @@ win64-fedora-cross-container:
   variables:
     NAME: fedora-win64-cross
 
-wasm32-emsdk-cross-container:
-  extends: .container_job_template
-  variables:
-    NAME: emsdk-wasm32-cross
-    BUILD_ARGS: --build-arg TARGET_CPU=wasm32
-    DOCKERFILE: emsdk-wasm-cross
-
 wasm64-emsdk-cross-container:
   extends: .container_job_template
   variables:
diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index dde9a3f840..9b6d33ac13 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -58,7 +58,6 @@ weekly-container-builds:
     - tricore-debian-cross-container
     - xtensa-debian-cross-container
     - win64-fedora-cross-container
-    - wasm32-emsdk-cross-container
     - wasm64-emsdk-cross-container
     # containers
     - amd64-alpine-container
-- 
2.43.0


