Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF462C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6NWa-0006OL-Qw; Tue, 15 Sep 2026 03:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anders.roxell@linaro.org>)
 id 1x6NWX-0006O0-Ti
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:24:13 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anders.roxell@linaro.org>)
 id 1x6NWW-0003Cx-6E
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:24:13 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a8070899e8so576509a12.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789457050; x=1790061850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PN9DYhqXr99yWSGzKiet4fsFDqXEsJwJsGHy+AW1RAg=;
 b=F/DqiX9XNNB8TLRqWaEyGlzqICBSLpBgnyFkC8KCVralB64gSLww5Q/3IZVNBmpZDY
 0jWgddicWHfXIRNLfKtD1pHprRaBr0NqGwIz/n5cp2I1WuCGpxtAOsPcia/9mS1+sIyd
 vhbcKPonPLuyij0dKpbP3kbU8l/HOUxbxGyn4CrqAF8JiMZL8SJY4BIbV4nrOM0+OAYn
 hVJMe6JsXiT706fPiaiVkSMBacLVJVgKSA4Xf0Zr1U8IWwZ+Or2IzzUByus9FoC/sZPL
 xdPqXkJgeuR62rq5GkHUC/Os7Bz5zpDJx8WMTWiPOjAUoPuCEfr52zyRgMCWLCIQ1IXj
 XOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789457050; x=1790061850;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PN9DYhqXr99yWSGzKiet4fsFDqXEsJwJsGHy+AW1RAg=;
 b=GmuMeQINYGSpHe8ylopj95/KOoq3A0u26LRxsr2XDx2Jrk6HBlvg1Y9jlwsDiLPn/M
 oXx9Zy6FZ7do+rYh+XUtIRqHaREeVNp8Q4eZvXHtUZSYdOJyDTRmqDhEyJjGPrAfPwwn
 9o/IXYxBd6iRjSlR6SAvGLqitdUZO8hTC3CMzUAcfwpOhhwTx75LjOB2BgkCYNv/9kA4
 bgPTpVZUQ/ggqN/uOU1LXKSHaLR9p0zWB8YNX0g2EU8bg7aZ0ZEZVrSNzgnRyXrReBb7
 2QdMwIUEmpJcATo495nEuky3nccVq1dsuE/bhhcMUACZMM1v8XcosBPxqRl9pV7UxB4W
 uOAQ==
X-Gm-Message-State: AFuF++kR81gL5+x3mmT3g9TOq1uDNlQT+sK5GcUg5hJvM8n4qZUskYHm
 3B2sn3KfKg1bJFgtkBJvpL8pkkas6a4ugpn4aDNhNLDnjyQn7qWZ17UUm7+e+D0RKnU=
X-Gm-Gg: AYBFou3jtr9OLbXIQQTB5Oa8lWqEKsTGgRYQWFYOkOdRHjOw8Bgnjh0vWJ1DpQpUaAT
 3H/Rl3MYY6KP0asJsp6BOFkbDqXDGvNiKf5Mi7dWcPA/5GYidywgeKxCR/rnaR7LvLEBwngG8HJ
 +c4loKbDAGvkH0sAvPAORdUtuu3qYV6+UX0EXJCK8b/hisGR9TWRC611OpA3bt8DvTHqmCHQBAC
 +MoFPXbIzJKzMLcxYCAW2iuSrtDvjZGb/SV2zifCPsaqpn6zZ8tUsj5zO99XJ2AFGt9qRHsFApr
 R1kWEPFdcrQHN0umRcjrwlzBEcP/BttxrxXtiRQMyNxq+a2Ja+1OPRQ0EjbySTpBImdH4HX2tee
 3n6V+cQXUVCm2VlKwXn4tlDvyuxZ7VHwzqsCX9sGXgTPaex84QFTwydHNYFHis0ZS+v3yOGhvrj
 +0H7Fhc0cJ/T9jvVGjRNaRHnBQhI+0Ns24qKAbPTh/CrL1oDVDn74/5dRMRx/1T/6ZdSqG9Hsky
 Lsu1eUy4xGdRolr2LKAEfrTwxtdQ/8w1xg=
X-Received: by 2002:a17:907:8dcd:b0:c12:732a:fe52 with SMTP id
 a640c23a62f3a-c29b874a204mr379791466b.4.1789457049808; 
 Tue, 15 Sep 2026 00:24:09 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2966148d25sm527289866b.61.2026.09.15.00.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 00:24:09 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: alex.bennee@linaro.org,
	pierrick.bouvier@oss.qualcomm.com
Cc: qemu-devel@nongnu.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] tests/docker: fix ccache directory variable expansion
Date: Tue, 15 Sep 2026 09:24:03 +0200
Message-ID: <20260915072403.347639-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=anders.roxell@linaro.org; helo=mail-ed2-x10.google.com
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

DOCKER_QEMU_CCACHE_DIR is missing $() around DOCKER_QEMU_CACHE_DIR, so
$HOME/.cache/qemu is never created.  podman then fails to mount it:

  Error: statfs /home/user/.cache/qemu: no such file or directory

It only works if the directory already exists.  Add the missing $().

Fixes: 8a1975e4d44b ("tests/docker: expose $HOME/.cache/qemu as docker volume")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 0adddb6a5c62..e506add8aa8b 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -199,7 +199,7 @@ docker-help: docker
 # Where QEMU caches build artefacts
 DOCKER_QEMU_CACHE_DIR := $$HOME/.cache/qemu
 # Use a global constant ccache directory to speed up repetitive builds
-DOCKER_QEMU_CCACHE_DIR := DOCKER_QEMU_CACHE_DIR/docker-ccache
+DOCKER_QEMU_CCACHE_DIR := $(DOCKER_QEMU_CACHE_DIR)/docker-ccache
 
 # This rule if for directly running against an arbitrary docker target.
 # It is called by the expanded docker targets (e.g. make
-- 
2.53.0


