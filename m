Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD14FD88D8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08XS-00041L-Pf; Tue, 10 Mar 2026 21:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XF-0003wh-At
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:53 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XD-0004oD-Ll
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:53 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ae8979dbb2so28241605ad.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193130; x=1773797930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9C10LIWAfOe0XC8fgiYNc3OU4Za4i3xkiJTwKoX+IUY=;
 b=IMQeF+TxSiAFQ3dNPxTOy5ENLEznjBwfKe91/W9maV+Nx4SoYmc1G1+4pD+JZKsxiF
 R3yZ2kZ5M3+JlW+mFiSnZe8izUYZEYEdXWZ71up3G9fb95g+n8dMlxHFuMB/xMsE5Ao1
 9BlJgUS3+PfAVV+qyGzENElpNyNQyAB05xL8ch1p81wbqwq+NSQZbUlp2u0KoOFVTBNI
 ueqKS6/drORvA985ugzebtU5n+KAIx2Dnr5q5oyOEROil4fYWsHDzXfwzrHF1Eod4XX6
 H4MsWdY5HILYyhVXpM2Ay8xSdEz5mMY4aLeF7h51rp09oDnF5XMduWwGmUITrC/mJVi6
 fxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193130; x=1773797930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9C10LIWAfOe0XC8fgiYNc3OU4Za4i3xkiJTwKoX+IUY=;
 b=K99pUN8bklHvijf8iYFmmQwJAdffw/Mo/lIt0ER0Gmw9X3erSrQDkCcWbNl1Pc8Fl9
 Spl4cstXsLnJDUSj5K7vU7VBRzD9IdMMLQjMgSaFpiK25SZKrHMGBkmXSh+8O1w5LSlp
 6KhWqo6FCsAbhCYxcBIuutJ2rnDM84sAWBGQccVkM2pRc2jweACcbacehWXxFYQOH3v7
 EyqIHP21Zz9VdnEB+IoACAnANFZLParX8jY3S0R3j6hQH2PJD+cIcM2y6/2v35NkRYG5
 fzj3BAaNIS2F2wSAFoEp1VpxUDXvCvX+NbCSJczmv2UYn9ku4wxM9kJ00eY+1EAqd9U5
 Fgsw==
X-Gm-Message-State: AOJu0Yw2r1/cplUrbjEC4TwNvulwCp4fuL0G3Eumm2xDw0pgSM/QawEq
 aE6VOp9RhRtzJO/giJ6K+XXwisNnXxlNTG3K/Bda1PcxfjggyVBe6laaNUhh/8ancqGvmXsGIsU
 maarx
X-Gm-Gg: ATEYQzyVbvlCdBP8OkJf2za9fyM8AWg9Cj9xBpQueMVmxPYdNBnLwjyyM2Yo566ee+M
 BIrWctUmG2wfieyxYFxhVDhaQo9yTVIC6qoZ7YKFL2RxEwYsltyp66Iab/OerOJH283O5KpmDU+
 E+qpMU36l11GHcX+27IdooV6F/MztGh08XZ1NdwXDJxL7p6vXBBALqHN3TkK1GIv1ulF+fuBzzE
 l7A3ksE66Tl4p7sLuJm7zcmFO8RvflvNF9AGt1CeNIiZqhwXlIJI/2SaiLUJJZcYV9U9PTAaA5h
 8aetQYSNUiKAwraEzOfhh9czXSf97pE0ZVNBu8XqwjEFn0/6a5cueCgezu00Oa02lm2G9Y+5mtc
 iHx1ptgctoDbKPg4KOtmvcgyODlDuT9mRo4/8ZHNE7UlZqylN08NLzSlaIzQjfmUkwlXuVN4oWp
 yOuI+1Xc8LxHwMPMCsABAOOUbZ1YFk8/PbvbQAAuWrV9euUaak50SsdXrSbMtcu8d/ZgdtKWfLK
 Jib
X-Received: by 2002:a17:903:2385:b0:2ae:3e73:2b43 with SMTP id
 d9443c01a7336-2aeae7ea9efmr8359395ad.22.1773193130245; 
 Tue, 10 Mar 2026 18:38:50 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae2466d3sm5390175ad.22.2026.03.10.18.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 18:38:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 03/16] tests/docker: add gdb-multiarch to all-test-cross
Date: Tue, 10 Mar 2026 18:38:24 -0700
Message-ID: <20260311013837.69945-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-4-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
2.47.3


