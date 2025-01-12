Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB74EE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6KQ-0004i3-G5; Sun, 12 Jan 2025 17:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6KN-0004b7-9o
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:21:03 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6KL-0006sl-9v
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:21:02 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso3161334f8f.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720459; x=1737325259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whxePkoV2Yp+9MA9t/3hISIV5oW+krMfOXhVnA0z9Fs=;
 b=MmNloycsHGBCEOGKpwHrMoqdICQ+BmY5akb/Z68dcxepkr1dxCRPJZjBMJQxvNN43J
 BSQCQkztcc05x7t2ljf9eDx650F8RGpnsHjKIcVXNxGhW/cJZIshFFEaOb4D2KzrEIbq
 VvSmf+pocfyk6GUN9G83uLwRRelErtmTscaHGjUd9ulhmvi1wN1+b8NRGJOQBd2/vonw
 WZDG2osy7Tr1xRFnNWRQ6nIt50UM3+FjBoWGvE2G8l2x2qU1TC7kFUX0BsbDcKDbxzrO
 i6q+QGK2m6JlsHVCYc35hF3H1dtRi8eG5CDO40Fo0uJcTjdjIRcVbM1LMTSp+ybOVwgq
 Q04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720459; x=1737325259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whxePkoV2Yp+9MA9t/3hISIV5oW+krMfOXhVnA0z9Fs=;
 b=aCXcGJyAsA7B8DQDCPxClDQHJ9Fxjsmrz/8vQbjZwGPaKgAMDQyeZscSrXFXi0ysNG
 mq3Pw/LCbtVDkLgrQmgPII9xiikemy9LHaWR7SYPIVgr+DNHtfiEamBEcJlIIbiSwtBr
 aO05R3M96iHoF0BY61dM4MrOJ090SV8rV0yp+1V6SVR82ovd6sGsV3GoLZ5nL7F9HsKT
 hzwuIlxrqqghsCnRtrr6s/OpC8BJWI9bgj5O2MGCiaIs67CUGXStMWmFvykN9ToAKmOT
 ikIY4820lw3cqP6w1HmmSEM9heq9lytPSGPdUxwHHf2qLtDxU9wNiMP3Z9UiO6Fhd7LZ
 7FQQ==
X-Gm-Message-State: AOJu0Yz4cSslqi2dHqOucDrLKHcdf4RKuB4ApD6NLZFBaGyF7hRs7LQc
 5MusM4b5i+bdwe3i1IJyZ/upq3hmI5YAbZBLdB+UK9URNzxbpwloIc90OzTRTgDV7yWgrDHKclR
 T7ns=
X-Gm-Gg: ASbGncs+C2KOSA/ZYLtNmvDvab6nxim3/eQeYTs5rNzu4mWBNXWJ6kaMiq2Sgd+l5cA
 dj0Re7NeVx/1UuY8R1Wyz/zENTEe2bnLwmx/sfSFo8zI2X8d9U4DjmOjvUFGOY2ii1Rlpu+UXR4
 MzB5Z3Z7IjyNVj4kZmQ6gM/nAW5qCgm4g1cwHhtIPlSM2/5UI6tGMWrYHuUreJ/I+tzYymWL8Gg
 6s8juULfYV+hPw7GE0Ij4ZGPr2X1+rm/7tSXYC2C5ubRHOy61zR7KEVWzQuZfMLePZM9hot2/0H
 32BBi+a8jXXSVgG/kFFM1BEU2XkBQmo=
X-Google-Smtp-Source: AGHT+IF6/C9fhGvIX3QhNV0F/zksRSkR7TU5fDSIYCIzVQSsxQ5TkK6eTdiFS+RPsenlf29hME5VZg==
X-Received: by 2002:a05:6000:490e:b0:385:ef39:6cf7 with SMTP id
 ffacd0b85a97d-38a872ec3c7mr15044296f8f.32.1736720459313; 
 Sun, 12 Jan 2025 14:20:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38378csm10521280f8f.25.2025.01.12.14.20.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:20:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>,
 zhenwei pi <pizhenwei@bytedance.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 43/49] backends/cryptodev-vhost-user: Fix local_error leaks
Date: Sun, 12 Jan 2025 23:17:19 +0100
Message-ID: <20250112221726.30206-44-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>

Do not propagate error to the upper, directly output the error
to avoid leaks.

Fixes: 2fda101de07 ("virtio-crypto: Support asynchronous mode")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2714
Signed-off-by: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>
Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <DM8PR13MB50781054A4FDACE6F4FB6469B30F2@DM8PR13MB5078.namprd13.prod.outlook.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 backends/cryptodev-vhost-user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index 43efdf97477..3295c6198a7 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -281,8 +281,7 @@ static int cryptodev_vhost_user_create_session(
         break;
 
     default:
-        error_setg(&local_error, "Unsupported opcode :%" PRIu32 "",
-                   sess_info->op_code);
+        error_report("Unsupported opcode :%" PRIu32 "", sess_info->op_code);
         return -VIRTIO_CRYPTO_NOTSUPP;
     }
 
-- 
2.47.1


