Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221F1D3B992
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 19:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3j3-0005X9-Mf; Tue, 09 Dec 2025 14:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3iy-0005WY-9z
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:50:20 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3iw-000725-Nr
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:50:16 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42b47f662a0so91943f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 11:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765309812; x=1765914612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S5KclRugUhpe0gGLdIp4CynNExEoxgkf2eOJYHWdI8Q=;
 b=cz/i4nSbVpLrgGOSQrOYpMHNR3c/DbOe9Wg90nSKdA5aDQAoI95jFnFr92qbA/v4Y7
 SOGfU3qWWDrK6RKB8ncIP7WLzcUjAWieTAK1y4HCkaJJ0yhn3yowynYtdSDs/yzZE3x3
 1Rl0ujPb57UVsBe7U1d3gIE8ODG+To1xRv8HcmN3g9H7ae5HK4B7clz4M5RUXQ9/jAqO
 APLw4GJKU7Xws1+KZviybNLSmjbKfd1ZGTQL31yh9zjnrcJgxcKa7/bTZ28IACY2CxOV
 WJPZ9gmHqrni5ShknpScDqOJvC76XiqiRpxCm3gq9eFNl3gD5fzEcDWhiN3djS/KMw7p
 JAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765309812; x=1765914612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5KclRugUhpe0gGLdIp4CynNExEoxgkf2eOJYHWdI8Q=;
 b=SbJ8pLXDXkdWgOwLUZ4rsJxaPM12mhT5vW2sew7ABIgVrDTNct/465pSfKjOC+HTLI
 a0kvP7GifwVQzC27s0tR+PkEqNhGIsc4No8y8DzYT94ovdHv3SG1kgh/jlCObRM2NylY
 RvdpQVm4AWj9KRr4qwUvqBvAtfXB40rDMQdJZsAlz/zQfL7DlEC0dWk4Wikvlvad2780
 AiKeDHLzKH41XlfAdKkxd1LaLpuBnIXvpLHWtOTNRh1amXht7D/dgvJBUboPLab2HsLw
 P1vq/B2yahBuIh0czTaWsqQ3iYKMndOPOUn6R+Qna2I3vc7CTjoUwptrw6l4+XPICwUT
 8wyA==
X-Gm-Message-State: AOJu0YyafD9cMdHjzSR6Y/Hxmw4rPVj9FMtLPrSMoUBWQXf0QeclQF+G
 hzn1LdGywldrGfdrEBYPPmGA+nf8ZFOK9Tkg0jwpntVwEO2VstYRJRKfZz6QTwH5guO9AP2cgUM
 DqL+5R4Y=
X-Gm-Gg: AY/fxX7uj11LsMdaMkTRBbIYEsyhMAz3PKz3jSM6g3e8cIP/2zM/xY9xoFTduyE7oWh
 aQzzJdPlcSTcUiP/89rsYdnwEdK98VzTIEM4TYj3LXcJT+CviL286u9iKu/L7tn7qt0YkvSwTM5
 wMaP74+KCfDECOgN2bOlvQdDZtEKuD2QGHqiRfn1ru6uibhPfcMIZYlOxHjcB91yuMun9oTf5Qt
 GFnXvRGzBY6us7bKPWU9/Vvg0dfM2SjQS2lLDH3JTFcTAanE4rFeeRBlDA8lMLp/CczLVloWvmG
 eInfjLyezjPsOCFcuRXgN/t7r3AY+RNcjCp2cPYkBriaFjQYq00i3YsMibnFZy3cx65QnXMadca
 msUAlrPTJmIs22dbq4ZF+iRZG3UgguI2bUrihPw+YI/x6fg6m/gZI+C5gJGpdk78KsQKL7NkTg4
 mSwkiDD+CX0XMPgEOP1WNvSS8tcxXzx+rTJwTThaaSIiOUibCm7v7a7WJ4rS+m
X-Google-Smtp-Source: AGHT+IEbOWVMCzCLk9mOi9c309f3pbDPHVd0ojyUNe37lFrQo0tjYF+5WFtfMIytdZZkkUHxEcFLiA==
X-Received: by 2002:adf:e2cf:0:b0:42b:48bc:498f with SMTP id
 ffacd0b85a97d-42fa09096c9mr2630141f8f.14.1765309812113; 
 Tue, 09 Dec 2025 11:50:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbfeadesm32831926f8f.10.2025.12.09.11.50.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Dec 2025 11:50:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Stefan Weil <sw@weilnetz.de>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] migration: Fix order of function arguments
Date: Tue,  9 Dec 2025 20:50:10 +0100
Message-ID: <20251209195010.83219-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Stefan Weil <sw@weilnetz.de>

This fixes a compiler error when higher warning levels are enabled:

../migration/postcopy-ram.c: In function ‘postcopy_temp_pages_setup’:
../migration/postcopy-ram.c:1483:50: error: ‘g_malloc0_n’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
 1483 |     mis->postcopy_tmp_pages = g_malloc0_n(sizeof(PostcopyTmpPage), channels);
      |                                                  ^~~~~~~~~~~~~~~
../migration/postcopy-ram.c:1483:50: note: earlier argument should specify number of elements, later size of each element

Avoid also a related int/unsigned mismatch by fixing the type of
two local variables.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMD: Replace g_malloc0_n() by g_new0()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Superseedes: <20251209125049.764095-1-sw@weilnetz.de>
---
 migration/postcopy-ram.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 7c9fe61041f..715ef021a91 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1467,7 +1467,8 @@ retry:
 static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
 {
     PostcopyTmpPage *tmp_page;
-    int err, i, channels;
+    int err;
+    unsigned i, channels;
     void *temp_page;
 
     if (migrate_postcopy_preempt()) {
@@ -1479,7 +1480,7 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
     }
 
     channels = mis->postcopy_channels;
-    mis->postcopy_tmp_pages = g_malloc0_n(sizeof(PostcopyTmpPage), channels);
+    mis->postcopy_tmp_pages = g_new0(PostcopyTmpPage, channels);
 
     for (i = 0; i < channels; i++) {
         tmp_page = &mis->postcopy_tmp_pages[i];
-- 
2.51.0


