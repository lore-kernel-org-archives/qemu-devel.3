Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79324C88E5A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkH3A-0007Mk-Rz; Mon, 26 Jan 2026 02:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGgV-0003Rn-V7
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:07:03 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGgT-0004l8-Ei
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:51 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-81c72659e6bso3920532b3a.0
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411186; x=1770015986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2wRRRhpw2QeH+ly9lZWVccsQ4eVHSDC2ik4WsoAFuw=;
 b=ErZYfxC+xvpgb8miCD776VPjcUhq9wvF+r/dPKbzpa0bHrb0IZkGwU+PJJEe18wHAw
 IVbifgS1lV1vXKbnqlHxftwy1S022y7344z1xkTjMow0iKTK+m0KpPqo3IORs0r7AUju
 PifBz6BY3GbSlMqlB4ZFuxBo2rks8hdMPLGgyV9PtMHqRz9zyq50iw18rFGKADsNl6Ak
 o6IZVb+Vv5V9nSzC3Xnn7L5nZJB6HehhGWop5E1dy+/7XvBSMJgbdIOkMls31BQjnpvl
 Io2og1YfELSda6T33vjRl1HRQ62I3vsOxmzhcj3NRnj7C1Hh2FVfGL66zu/ZwR5uIH89
 9Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411186; x=1770015986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j2wRRRhpw2QeH+ly9lZWVccsQ4eVHSDC2ik4WsoAFuw=;
 b=fdfpaLq2E8Ru0v2fLVqYmkSIsx8kTbuWh/E3eCKJGKjKHUP9Mim8DMoCnPeUB8Sc3s
 k1sB6thhxlF70XAgyiwNIbaGbm/Jtcu5G+Zh6uWeabLSCuxEu9k7XhY+zHBXzZyE5eNR
 voqeen8ZWPzTSisKXBoezNUAHFizUv9vbAMv5qyYSKogAP1J2BD9foLne1jKkDKTXlvt
 EexUGbzxaAE5KCAsVmay4dMtVR8Ix8RJdMGDFo+cGKeO2tXn8CQOTdPZhE6FUgV8N96A
 ghhO1PP/c7/xqCDlz2ZqOLuF1M9xVkF+EppGwSd+sPqy7beLy9gMraCQP9F2sbqOGzOh
 ZjWg==
X-Gm-Message-State: AOJu0YxwEc+cPW5Xni7SQFAyKKNtBuUyZvlcC8KS//hn94FzZUm/tfOL
 EPx1E/kp7abv/BDAW+zh0mzMoFoCc3IixZardutHN9h4jwuqOjwoXZG7t19nzAVv
X-Gm-Gg: AZuq6aKuruiuA+KR7JZXkke1OvhhoJvO9IuzGDI/87/6OAHOa/xMA0pMxKsHfh/Eu/T
 V7bfOc5pAva8wfhy8eRP2xhqK/LpLE6iM5fdwq1r9qlclwYZDbjglIqOlj2Io0jaWPHRb6UvTzi
 WPVX0bq2jbgZzPOf/5/NSUTVeP3CdQpb3Gyq6abLJm0g4KEVZ67HlbvRAIMmi2s+i1U/Ph9KKGE
 7AKVVsaoCScjmITsapl6mL2BhHRpupHn2OwVKu7E/Hts3f9ntxeD6iHPbOfYljfF6NV6h4x0bcI
 hNzq0/upLDIQ0dgp86F0sPLKyuK9UW0YptF/1J4mj0tN/y7SYBbtvhtQf8bBw4x9g5/X9eKDMv+
 WNcvDZagyHD2L29N07IiboAix3O6j1lApdaNL9KYENBW0O119ZTagjwXjdf0BqzcPtU80nFLjcw
 GrUeu6QFfCmNxUAsDXgA02uYSk1/gmKjeAqDjkcR2qxQ==
X-Received: by 2002:a05:6a00:3a05:b0:81e:c5a:8c25 with SMTP id
 d2e1a72fcca58-8234129e435mr3211981b3a.44.1769411186608; 
 Sun, 25 Jan 2026 23:06:26 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:06:26 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 31/33] .gitlab-ci.d: build wasm backend in CI
Date: Mon, 26 Jan 2026 07:03:44 +0000
Message-ID: <e3c1a6d8112ae8aca34d8a55a0a077026f6dde12.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This commit adds the build tests for the wasm backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 .gitlab-ci.d/buildtest.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index f9a2d4de74..f7843e6e5a 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -792,7 +792,7 @@ build-wasm64-64bit:
     - job: wasm64-emsdk-cross-container
   variables:
     IMAGE: emsdk-wasm64-cross
-    CONFIGURE_ARGS: --static --cpu=wasm64 --disable-tools --enable-debug --enable-tcg-interpreter
+    CONFIGURE_ARGS: --static --cpu=wasm64 --disable-tools --enable-debug
 
 build-wasm64-32bit:
   extends: .wasm_build_job_template
@@ -801,4 +801,4 @@ build-wasm64-32bit:
     - job: wasm64-emsdk-cross-container
   variables:
     IMAGE: emsdk-wasm64-cross
-    CONFIGURE_ARGS: --static --cpu=wasm64 --enable-wasm64-32bit-address-limit --disable-tools --enable-debug --enable-tcg-interpreter
+    CONFIGURE_ARGS: --static --cpu=wasm64 --enable-wasm64-32bit-address-limit --disable-tools --enable-debug
-- 
2.43.0


