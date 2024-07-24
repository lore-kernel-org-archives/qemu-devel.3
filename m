Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7865DC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 19:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWhxm-0002iU-SS; Wed, 24 Jul 2024 15:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sWhxT-0002Mq-C0
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 15:47:32 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sWhxP-0006EG-SX
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 15:47:30 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70d2e68f5a8so132173b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 12:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721850441; x=1722455241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ucSORz2rBXkcyoFZTinUQFpFQkuy8HGT8f+QogyIZA=;
 b=sijfMxejeupkFHDPtZmvC/7wOVoHKi6QgjOzuZ1yCuc96/nQCgoB/TjHABfz0wBJ2v
 Yr7usXmktdVFCAFMiVKSk6F6griuHpoWMwO4ddNXXG+5on3IidyfI8RQHF06OgC5BPch
 XwUh2QgoeU0yaJw1RM4MdhFSzIKpzsvea8jFfnyHphQZ1b0WpgfUXeM6AbOxDaWfuArO
 hOj9ibKFl6gLkrnF0vR6yYEQVlTAWGtpXkXdzhk0aEyhHO/sA3fEFkKakDBkWcv6m/4N
 myPB1yuGEAG6k73CMTOa7DOqiBs+ySXP+MhVoo25Xxt2OEt8z0FyTURviCpOclWtKLvr
 /2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721850441; x=1722455241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ucSORz2rBXkcyoFZTinUQFpFQkuy8HGT8f+QogyIZA=;
 b=NSZ1j88+mf/KT3lW4Syy6MDHmlKwItXvgqYIlOERCF5iqwEO/8FofcmO9J1ssf24fi
 1Z3cUPCrhyggHr/e09kGW7g0/XmGmpBOxkqn3YJE6f7aK5x1VEuRHimeYGc41Y0s5YIx
 a9hgNS7cMS+oOIm/VMIT9g1WMFh307Msde0yAid3TUsYaAx90ofyfz1Pj48AzcRGgtMS
 XzwPCxwDylSIZ1hyp7eP3iQSpayZXLfOaYDDGy2dsms0l0ZAwEXVJGyOG7iJTu8ew4kh
 oDuMO29PDnDwxsctTiBHeqGhMpF7GK8+9B0+FW//2ZJgNcwBSkIiXGxJBA7Wz635Itaq
 XnhQ==
X-Gm-Message-State: AOJu0YxDbxtrZ74JRRpt3PDVuHMWKNqzXfeCX/5Ctrz3PP3+P1Hc4M5B
 ufonI06wnV59KfYyX1Z2MswowNdXW4s2h7X4UDbKCi9Cd5FxltragV0mkJXxamGV+jI/d8F3VIi
 1aBU=
X-Google-Smtp-Source: AGHT+IFTencQtpbmZz0sq6Uq+0Bjkp5RAnal0Bi5/m0RkxF+8zqnk4+zsN2y6njNwmTpFH4AE8qdHw==
X-Received: by 2002:a05:6a00:c93:b0:70e:a6b5:d80d with SMTP id
 d2e1a72fcca58-70eaa94647dmr740536b3a.26.1721850440764; 
 Wed, 24 Jul 2024 12:47:20 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d19c52a62sm6339116b3a.124.2024.07.24.12.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 12:47:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v7 3/6] tests/tcg: add mechanism to run specific tests with
 plugins
Date: Wed, 24 Jul 2024 12:47:05 -0700
Message-Id: <20240724194708.1843704-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
References: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

Only multiarch tests are run with plugins, and we want to be able to run
per-arch test with plugins too.

Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/Makefile.target | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index cb8cfeb6dac..197d3de950b 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -152,10 +152,11 @@ PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
 # only expand MULTIARCH_TESTS which are common on most of our targets
 # to avoid an exponential explosion as new tests are added. We also
 # add some special helpers the run-plugin- rules can use below.
+# In more, extra tests can be added using ADDITIONAL_PLUGINS_TESTS variable.
 
 ifneq ($(MULTIARCH_TESTS),)
 $(foreach p,$(PLUGINS), \
-	$(foreach t,$(MULTIARCH_TESTS),\
+	$(foreach t,$(MULTIARCH_TESTS) $(ADDITIONAL_PLUGINS_TESTS),\
 		$(eval run-plugin-$(t)-with-$(p): $t $p) \
 		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
 endif # MULTIARCH_TESTS
-- 
2.39.2


