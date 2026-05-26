Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66284CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpZ6-0002hq-DS; Tue, 26 May 2026 07:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYm-0002ZS-2e
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:02:57 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYh-0005xn-GR
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:02:54 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4903974854dso42693385e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779793366; x=1780398166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n44wjKXx625REyJBiUubPzbuiM8HWento13fShSdVAs=;
 b=yKKqcqHz+DLfVwN74KhL6us+4SCJ1gFJBXIorxlJyIppmXMFNhgElHy/1bVb8oWXfg
 pyiAksb++TLQ5V91+uI20Hcfnwq1rCOBk4k6aph/MYn73Ff+E0EGALhHGIgvtpuNc0Zz
 e/2ykkmClv/REsKEe+QeYxqlcEnQsO/SB66txO3s/fgqCGAH08TP+Ly/7/XKUHhXdk5W
 gJxYktbQ05oj0v/pIdH3GJ2KDo1+SDT0ZS2GYS6+klP1O0TlaezZDqJU1QoTYP6g5VnT
 VT+HtJsWj0aAnTXneVhCDmiryYIXMzI9RZmxjWG8ylm+aDnuZNNFIfvViuei6HPbBhXg
 e8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793366; x=1780398166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n44wjKXx625REyJBiUubPzbuiM8HWento13fShSdVAs=;
 b=PbOZlRiJ49zEQlwEZsuEODR40PJBTbF7gvHZHcRsUPvIvwrHYM6+0nrGHlzqFQlM0U
 VHWsQf23S+eCWoiSiad2MNYAAcRWW6+cf3vIjQ1kaS6Bxb8MdlIPqFx/iU7A7bO/YBSl
 a56qPEIrCIzyK9FbXohZcka3UfK61HQO4UIMuJv5hSM+GokZrjQUZBFaj1B0xeVP/wDJ
 E8EyJira2yoW0W3EMuQtzzLt91Xl7Eer+pOvHTUI0z28KSzMzTi98uVX/41/bRae2JSi
 7Vpff/oHE0wGtE8jUwvSOmss6hKry3+wkGCIsCA7SxOGyUg9sEKwUh2HzUWP9V4Zp9k7
 tQRw==
X-Gm-Message-State: AOJu0YxX8Yw8rzgnrdclszz0MAtGFd89sFIXqDSO5Kd16R+K1F1/hR5z
 hrESDr4dkNBLedlGM+p1I/8HUEC6eg4ERjwATx+jKP4HdE/2jIZo5IsUu+Ea6oEROpQ=
X-Gm-Gg: Acq92OEWWNdDffqoFRHLmEHQcYgx1azvQ4zC+Sh2midhFeHi/MPzofo8XRtIbNZh16u
 q4c2Xaess/TJQkVHLKoRtSIm7iVD2gl1imlTC6i4Yk+eiMNPczBxjEqDjCs73klfi3VTPJ10+k2
 SA97QwQMjOlUoqCCZTp6R8Jkcf84+0EgDp9Xkti2FrbrfZJXETRXIHhwesRGhW+xJQxAqTNNPk3
 ALS8NugNusdDCAhNpXU3n/v3Daa9kfx305TJ7oi7HSxadLXskEWKPB/ZslbIAG7HFdsocdawozo
 fkr2eYMe4w25triuz280i1pP0twY2tJSRWx0dQqibuW58jZc+DRj6l5Kvy/m/xm6oqJo6vIdpq8
 ZcHnyFzXo0oouaCdD90d++ThVs4RAMay9a1m/1YdN1onG6AuaWXTil6Btc4UvS/eOgI4vOmnRy3
 FlHDxl1lzNfSRT9GnRTrS9UIc=
X-Received: by 2002:a05:600c:b99:b0:490:4ebc:b80a with SMTP id
 5b1f17b1804b1-4904ebcbac7mr263311885e9.11.1779793366464; 
 Tue, 26 May 2026 04:02:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527dbf3sm302417335e9.6.2026.05.26.04.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:02:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CB4A65F8C7;
 Tue, 26 May 2026 12:02:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Kyle Evans <kevans@freebsd.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 03/14] tests/Makefile.include: add binary dependency to
 run-tcg-tests-% rules
Date: Tue, 26 May 2026 12:02:31 +0100
Message-ID: <20260526110243.470002-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526110243.470002-1-alex.bennee@linaro.org>
References: <20260526110243.470002-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Explicitly set the appropriate QEMU binary as a dependency so we can
ensure they get built. This is especially important for MacOS which
otherwise only builds the unsigned binaries on a normal "make all"
run.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3b1af78ca1e..494d0109f26 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -58,6 +58,12 @@ RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TCG_TESTS_TARGETS))
 $(foreach TARGET,$(TCG_TESTS_TARGETS), \
         $(eval $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak: config-host.mak))
 
+# $1 = the stem (e.g., arm-softmmu or x86_64-linux-user)
+get-qemu-bin = $(if $(findstring softmmu,$1),qemu-system-$(subst -softmmu,,$1),qemu-$(subst -linux-user,,$1))
+
+$(foreach TARGET,$(TCG_TESTS_TARGETS), \
+        $(eval .ninja-goals.run-tcg-tests-$(TARGET) += $(call get-qemu-bin,$(TARGET))))
+
 .PHONY: $(TCG_TESTS_TARGETS:%=build-tcg-tests-%)
 $(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: $(BUILD_DIR)/tests/tcg/config-%.mak
 	$(call quiet-command, \
-- 
2.47.3


