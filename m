Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E5CFD88CD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06O2-0000dW-Cc; Tue, 10 Mar 2026 19:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06O0-0000dI-PB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:21:13 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06Nz-0008Fm-7c
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:21:12 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-439cd6b09f8so4984935f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184869; x=1773789669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tW5qNw2kq4iAD+9Er8jcxRwl/XjqIvVO6z8tOwbhYrU=;
 b=VcUSYGz5pSFBpdclSWftrRAgu6VM/cFVn67zJtSKfpz9ParxiZroB9mkPJgQdL96r2
 kJPEmPvDlQH0mmUWb6gTxKWIs21PptbCvFLve103PB8TPGGB/kBpGkPUQ+vO5UbXYRA5
 H4318+YVF4a2wQecZQS0bMV69IJsjH1UyhGOn5vlpWrgKOaSGM71at8OfSWI+D5xjLEU
 gCgHBDv1xT5/kwS0JUN3kDqAoxYWHa4qfiHNQ09cZgKYdx0MPCpmKXmbN8d7AmdzWuui
 5ONQIeLiYqMr0MqOqbRresuLOrYA3eH9L3M3TBf2MjaKI+uJ1ylsqkyc7Ja13T33I7ir
 Z6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184869; x=1773789669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tW5qNw2kq4iAD+9Er8jcxRwl/XjqIvVO6z8tOwbhYrU=;
 b=htuaOvSV8oQiJpR7xDVW1xXmspOJEqf/UGZH16GYTQACQpQ6A05rfRwtxMZ66FjLmN
 6wJCOGfWFPFZfn9RVhMqFN0LfJcllvFnBRdjE2SdYLeeFwwHFE3GN10bO5HLDaFvYlnQ
 QTy+nVHfve/RQGZ0ItV21wu7j7KlPEujK9O9d+VIdMgfs+7fWeD287cy6nLhtaZjXBkV
 ma5nvQ3nsf6hVRmKzQrosK/3bAg92O706YSWlfhNja3DW2eeSDaCIq8twC2prVtuO5KV
 0nhuR4TevMG+qxq0uQhiaCn8Bd6BRHVy1sneSyg7gbcC2+xRSyvjsBqww05qh2g5FI5L
 HpSA==
X-Gm-Message-State: AOJu0YwWWnlIHxQ9a3iGo4jLsIXbxwIrx7uhdcNaJxeI0CAVBK0Y4MrU
 hqMFBRd24mUa+K2ZjfFdTRSZy4wJxgtylfgCFHq+wXzXaPvwuPdLSIwOu70HGXHqe57JM0K7tSb
 yTRE59oM=
X-Gm-Gg: ATEYQzyjsccMfVGtq9L+zAR6onVtu1KSSnLwe9RQQU+sJe7zq6xJ8OZpABRftpaUZkL
 278y4d7ElyVNVEPH+3p/VSUB7vlzafqxc/X6PobznN8XvWZBZqhzYEqNT7uGoecTeT289dRWmve
 NSoLLu9ibw45XSnOUuKZ6VCZIBMPfNf138c6wkb2FVT6PSLHU5kx4i97KrAe1pdZ+1DG5vFcJN4
 LMujy4Td2UA6K/FdVCECSjcRWiXgFAj/UU+vOnYiFA7/xkTXuF4z2oxGPRn0YmshQYk2Ss9kBuF
 HD9vRIL4w8cpqbD/jG/gQ3qOwaiWABDrTSF4OltMD4YbOYfPmxH1AjeiwKsQpbzSQzJkseV2R3y
 dEGMOqcTCivEUqCzOs6eqF+Itrgy+yZmsLCQHB+o9FEb3hk/CpWN9j9/aJlrQzhGIllQCA8NmOA
 Tf1VuGVzwt4XlU8q6MMtKOa4NY7hZlnEZ2oVgyJMyaXpKkkH+QN8ryCftuAa259uOCazSw+1Lc
X-Received: by 2002:a05:6000:2486:b0:439:c9e0:83a5 with SMTP id
 ffacd0b85a97d-439f8440ee7mr1016891f8f.54.1773184869294; 
 Tue, 10 Mar 2026 16:21:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f821ffb9sm1548824f8f.37.2026.03.10.16.21.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 16:21:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 03/16] tests/docker: add gdb-multiarch to all-test-cross
Date: Wed, 11 Mar 2026 00:20:31 +0100
Message-ID: <20260310232045.58440-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310232045.58440-1-philmd@linaro.org>
References: <20260310232045.58440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

This allows the gdb integration tests to be run as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260306161728.2657486-2-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker | 1 +
 tests/lcitool/refresh                                 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index b73776d95b5..287770a995a 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -59,6 +59,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends \
   clang\
   dpkg-dev\
+  gdb-multiarch\
   libclang-rt-dev
 ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 3e4b026035b..259e6ea0729 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -167,6 +167,7 @@ debian_all_test_cross_compilers = [
     "  apt install -y --no-install-recommends \\\n",
     "  clang\\\n",
     "  dpkg-dev\\\n",
+    "  gdb-multiarch\\\n",
     "  libclang-rt-dev\n",
     "ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \\\n",
     "  libc6-dev-arm64-cross \\\n",
-- 
2.53.0


