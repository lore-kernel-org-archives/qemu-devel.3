Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8B9C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Lt6-0003Nj-9U; Tue, 07 May 2024 10:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Lsj-0003BH-NR
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:30 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Lsd-0001Mc-BO
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:24 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e3c3aa8938so20057135ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715092398; x=1715697198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfE/asCDMv/fqU/grGA1GfwBU0TPNElhgaA02CsVIwg=;
 b=ZTCFUDrSFtNalm9xtenYTRX41eARmADXagudJfyTycJ/cTT6b+Zz588uFGrGhUC+zZ
 j3Jtrj15qnhZqxjOKVKQK3hjAPTThuKI30zmA7wvemSvlMD9n/G53qeyM5ZpslhsKVHj
 IgKy8DIBt+zvLzjPUwKaHWT/gJSdyTd+MYhl+657DShjPLLcqHRhmRU7l1i1C/hAyaJD
 7lmM1ijctm2jG8JVen3mWsvJOnDdmprLUX1ag4gvzUuE4M+fGJaxi/634L4wUm0KJ9fy
 rIYG8haljFCQzZFuAVXt64PGbLdNFT85h9APJCvewN0VwQmWwDYl1gX3gY+8q+acXUhi
 fwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092398; x=1715697198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wfE/asCDMv/fqU/grGA1GfwBU0TPNElhgaA02CsVIwg=;
 b=S2XX9TYD77PWAytYtjv33CVEx8vmjVbYb+RBLv60c2o/+1aBWhgAIfaEAYV539F+kB
 HkpD3W7Ksr2M+ETTdz9k9lNLoQLRisBpc5ldaF+cv9rA7R2FgbimI+WToCKZv5hJ2+br
 GKJD8fsBRvoc4+Uwdh/67nbURb8162fFbZQ8BdhLc7iulNpZAlz+3MyRg3qapGBbzUbj
 KYOFgiVW40IzNjCQBW/YXD6Dhg/c7Pq3jtq7SwP6ExNZZcw8r+aVNekJI3d28XSHqMEo
 Pfr3/g8WaTIRXuBttTmtFGDYOGcaE7118jtigYmoq7yBVoUz2uTp9Khg0tq+4NiC6L5z
 kpOA==
X-Gm-Message-State: AOJu0YwlSZGhf82BqUFLNfGyPt0iP64769SPMlAcRTuz6aG3O/LR6nPi
 Mef/Sa7ghPOqGielsuG60IiUjbS/xf9Q4n3nPbPuGS9tAy+bAWtABLGK711iO8ZDzZb/hh6IK/d
 t
X-Google-Smtp-Source: AGHT+IG/YFZ6PHDYiQxWCfSJGMSQs7oy8LxscRwCSF1EsthMIulCmq86r25cCQWUI3HuCG2dxvv1Cw==
X-Received: by 2002:a17:902:ea8c:b0:1e0:bae4:48f9 with SMTP id
 x12-20020a170902ea8c00b001e0bae448f9mr12107686plb.32.1715092397966; 
 Tue, 07 May 2024 07:33:17 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a170902780300b001ed2d84c1cbsm8690097pll.193.2024.05.07.07.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:33:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 8/9] gitlab: Drop --static from s390x linux-user build
Date: Tue,  7 May 2024 07:33:08 -0700
Message-Id: <20240507143309.5528-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507143309.5528-1-richard.henderson@linaro.org>
References: <20240507143309.5528-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

The host does not have the correct libraries installed for static pie,
which causes host/guest address space interference for some tests.
There's no real gain from linking statically, so drop it.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
index 2b9e1ff749..0a2d2bd332 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
@@ -2,7 +2,7 @@
 # setup by the scripts/ci/setup/build-environment.yml task
 # "Install basic packages to build QEMU on Ubuntu 22.04"
 
-ubuntu-22.04-s390x-all-linux-static:
+ubuntu-22.04-s390x-all-linux:
  extends: .custom_runner_template
  needs: []
  stage: build
@@ -15,7 +15,7 @@ ubuntu-22.04-s390x-all-linux-static:
  script:
  - mkdir build
  - cd build
- - ../configure --enable-debug --static --disable-system
+ - ../configure --enable-debug --disable-system
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc`
  - make --output-sync check-tcg
-- 
2.34.1


