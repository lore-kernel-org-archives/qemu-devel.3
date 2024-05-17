Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255F7C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 15:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7z6y-0005AY-Ap; Fri, 17 May 2024 11:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7z6u-00057i-CZ
 for qemu-devel@nongnu.org; Fri, 17 May 2024 11:03:04 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7z6i-0005Pp-AS
 for qemu-devel@nongnu.org; Fri, 17 May 2024 11:03:03 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a5a8cd78701so491995166b.2
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 08:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715958170; x=1716562970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFJQ8eXrLcyhgXUkRkABC/U14von2QfsgkjKz+WC79c=;
 b=gc2u0LsB9ul/DHWRO66ULOf7EZmlomg+FoaGtZ/jClqsnh28N8tGgG6XogugqCB1Y0
 iIK9SevZDGiWz3fdfW7WodfHl5pMa1LofoxFddt7Gh9oFX5+8Xduhs9vPIJUVGmvXrDp
 oNc09P8Vn21Y1m6AuFzGX9YT9rdlkLxIqM4RMMIInNNAC3VPEZE7GZWtnuyCOqWTUxwZ
 OghH9utl2D5y1DH/NQTBZZ7si6Ijk0VdX4ydOxfx5O9nv+JmWoNuONvCGr2QJ7nfEWCR
 h798O2S7ZljGkEGNkRRu1pW7oz5dyxHbJOPm4s6IRCCbGxGBtu3EU6Rzwat95OsXABWg
 KEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715958170; x=1716562970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RFJQ8eXrLcyhgXUkRkABC/U14von2QfsgkjKz+WC79c=;
 b=HEeJ3Pcp6fknE7SJoRKrUhI0ahY9SgXWTbaOGqixvZIvrplntuKFBQ55KGHnO15UEV
 j2Rj3EMqWyfdzgr20/Nmzr7S6Lsl3dGqg2vQFgviYKe44nyh/hkM3DTIDb8gGG+hUdGe
 T0q2d9S8BSsmWRBYMOO8znLThzeexakppXCRkOmdry+LjVdQsHu3KeSD4EjSgCAJPWXM
 1nuyu9tLpA00TcmiP2QuaY/WjKWCo5vhCwcbd/KI3f9KrTAwWcaDheKttRZDsufEimIu
 tZxJJCu8mI9Q9I+pqZpKePeB+M9xWJq0sFcTxMM0/d0WqjI6nF4z7oxU1/TslCPVOuvS
 WTzA==
X-Gm-Message-State: AOJu0YwdJjeRZTDQzlJCQLJH+zq2kjKzSoFbZo852SjsapmtuWkdyzg2
 Lnk7s1pTqcyKAZVriLOjlBFdS6TdyZVFvDw+rmSqy8Je5fa/8sawTvhFFSs1HqQPcniM6z3Pezw
 4
X-Google-Smtp-Source: AGHT+IFKrBMiYG7qlmBVaN5Hd2LIoLCh4V9QNWcZaoNDQcJfBWAU2doIOGLPdYHpQiynO6lK7trE/g==
X-Received: by 2002:a17:906:3a8d:b0:a59:be8a:bd6f with SMTP id
 a640c23a62f3a-a5a2d65f272mr1374782466b.61.1715958170359; 
 Fri, 17 May 2024 08:02:50 -0700 (PDT)
Received: from localhost.localdomain ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b17886sm1130572866b.210.2024.05.17.08.02.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 May 2024 08:02:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?J=C3=A1n=20Tomko?= <jtomko@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/5] tests: add testing of parameter=1 for SMP topology
Date: Fri, 17 May 2024 17:02:26 +0200
Message-ID: <20240517150227.32205-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240517150227.32205-1-philmd@linaro.org>
References: <20240517150227.32205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

Validate that it is possible to pass 'parameter=1' for any SMP topology
parameter, since unsupported parameters are implicitly considered to
always have a value of 1.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
Message-ID: <20240513123358.612355-3-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-smp-parse.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 56165e6644..9fdba24fce 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -330,6 +330,14 @@ static const struct SMPTestData data_generic_valid[] = {
         .config = SMP_CONFIG_GENERIC(T, 8, T, 2, T, 4, T, 2, T, 16),
         .expect_prefer_sockets = CPU_TOPOLOGY_GENERIC(8, 2, 4, 2, 16),
         .expect_prefer_cores   = CPU_TOPOLOGY_GENERIC(8, 2, 4, 2, 16),
+    }, {
+        /*
+         * Unsupported parameters are always allowed to be set to '1'
+         * config: -smp 8,books=1,drawers=1,sockets=2,modules=1,dies=1,cores=2,threads=2,maxcpus=8
+         * expect: cpus=8,sockets=2,cores=2,threads=2,maxcpus=8 */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(8, 1, 1, 2, 1, 1, 2, 2, 8),
+        .expect_prefer_sockets = CPU_TOPOLOGY_GENERIC(8, 2, 2, 2, 8),
+        .expect_prefer_cores   = CPU_TOPOLOGY_GENERIC(8, 2, 2, 2, 8),
     },
 };
 
-- 
2.41.0


