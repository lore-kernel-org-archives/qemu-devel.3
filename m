Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB5CC982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZWh-0006Eb-5g; Fri, 18 Sep 2026 10:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZWJ-0005oK-PZ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:57 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZWI-0007rz-4N
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:55 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso6528725e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789741493; x=1790346293; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X+YjhGcrQ+GJnmWZAYA/s/pZF92nX5g568920hp4YVI=;
 b=qnFhte+zRyy5CQ6W+AH6a+G1JX0BnOe7GuCxICuz9H11zWvCy2rh/QPX0LjCFEZ5jT
 KVQPfm6No9wbHSdXhpLPh+liYV5bs5Ic/ohyUPh8/kCmGhBxl4xpSJNd7DUwmC0cQFUf
 YhVhsMMD6SzkzRA5+pPcxqAJBIbT64BBdgQv7LwGjfGOLEOuQne3nM6HBfBbqfeZRjT9
 fUWI+QX740mGAxvbmzs3weAQrSNy4U1i2cncV+RdtYqKYumNyutgi3J2Q6/RfwtNZ6Yw
 Og2zrqbLNIaio4guADqpsAHdxhhpzMjHRaFIg209KeHaC3Ud76Ia76O2czCjieBjJnJs
 Ua2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741493; x=1790346293;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X+YjhGcrQ+GJnmWZAYA/s/pZF92nX5g568920hp4YVI=;
 b=1VYoecrDqJjY/IcFTt6sYSow498M9CcnhTkMXNqTEuICXSAKFFZPxm904tJ/Rw9I70
 VQa8XmLjAPSa/hEc3mgmL5+7kIMEO/hOb/s9lOybBv5bEj+sSXX58LDD1uq7E9xuBpVc
 Suqg10NRezsExS8lw1jgl4p1QSb6B9hLolOO2fEQ7AfqLUB26eD2Dz/NVEpOOp9ZUo52
 wU1tH3CDPMgYbyXxh4drrAxFfHwKOo/mdbwkDRqB5Tn7pByH6bZihD0yUg43AxZLWVQ+
 lOkdYAV1qh+/ry5GqTkH+sb0Dj1W1rwrT/uUhVq5kOT6VLxAfohxZ081eiDHCgJ6pN99
 8Bzg==
X-Gm-Message-State: AFuF++nfEkqTsN/6qc4KJ4Om8tiZMJMXNskKBNK58V4z/PbVjYgXM7/z
 xhaolDKqGULiRQlBe81qeuhhVyPXvAUkXjLCqO6UaEKFijLDzmuaCR8HJXKD3s6/gD1YGC4JOUg
 QNvaX
X-Gm-Gg: AYBFou3AYBdYhJ1qi0U/irUNzJPOyD5XgzYx8HARH6aTewxZoYlDack7WF/LlDofooe
 wqOdZOERZh84TY5WgVuyNXFmlpnSmJJHtAFp4BGg88b+zlril8WbPPdk0x40xLBx2almTm09BU5
 s6n4QEV6FlsMI23vaePCPeJSWLf2L/DiUDFi7bI04Jjl+7nLsEwi2Bm6LIQGAjmy7ugeHKXA0gZ
 tX/xYsZ+0yoRLOD9MeY9MhUOyh9IZsEzJNnF4WQ3odmh1RJVtxzCVvmgAwzZmNL+Y2y//GDMwUM
 vFD/2deYx1FLW2jtuEyUmg3U+8kf196LW9a7EFvXanjMKd5aXld4i/OI4zC4USpPzJXOBtcbTjS
 XBTomCUEaTC3FzWOxgHRXfpurrthFPzcpkIqi46f0M2JwBEWjeyAjfG1SbskhwkFHPDhVNJgYBh
 gEn7buBvKbOslSk5VPXYo6r0aBylwru1NL19pnekCFYvsWW1w1WzGNf7bwivDu2WvMROPK8mU=
X-Received: by 2002:a05:600c:1d29:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-49fc572b7afmr38102395e9.22.1789741492780; 
 Fri, 18 Sep 2026 07:24:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc471b9a2sm34670595e9.0.2026.09.18.07.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:24:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EE9725FCA7;
 Fri, 18 Sep 2026 15:24:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anders Roxell <anders.roxell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 13/17] tests/docker: fix ccache directory variable expansion
Date: Fri, 18 Sep 2026 15:24:24 +0100
Message-ID: <20260918142429.336497-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142429.336497-1-alex.bennee@linaro.org>
References: <20260918142429.336497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Anders Roxell <anders.roxell@linaro.org>

DOCKER_QEMU_CCACHE_DIR is missing $() around DOCKER_QEMU_CACHE_DIR, so
$HOME/.cache/qemu is never created.  podman then fails to mount it:

  Error: statfs /home/user/.cache/qemu: no such file or directory

It only works if the directory already exists.  Add the missing $().

Fixes: 8a1975e4d44b ("tests/docker: expose $HOME/.cache/qemu as docker volume")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <20260915072403.347639-1-anders.roxell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260917165602.3405537-14-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 74bf471f171..9237a0dbe7f 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -197,7 +197,7 @@ docker-help: docker
 # Where QEMU caches build artefacts
 DOCKER_QEMU_CACHE_DIR := $$HOME/.cache/qemu
 # Use a global constant ccache directory to speed up repetitive builds
-DOCKER_QEMU_CCACHE_DIR := DOCKER_QEMU_CACHE_DIR/docker-ccache
+DOCKER_QEMU_CCACHE_DIR := $(DOCKER_QEMU_CACHE_DIR)/docker-ccache
 
 # This rule if for directly running against an arbitrary docker target.
 # It is called by the expanded docker targets (e.g. make
-- 
2.47.3


