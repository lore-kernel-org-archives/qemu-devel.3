Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0887CD129A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 19:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsT4m-0006ar-Nq; Thu, 04 Apr 2024 15:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsT4l-0006aR-3n
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:48:43 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsT4j-0000Of-IY
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:48:42 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d47a92cfefso18142701fa.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712260120; x=1712864920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=airsYYnzzrC3CGj9Ils0htz0QXpak8uFciduBNRfDcQ=;
 b=g8xnQQEJ43B5wdoV4A8yGr7GUkdwB97eeFnZvwbW72a707uFYwof31cwNT0c1ygneG
 0OL7/Bs4HXP1v4MIi7AUWscQAVwmaWxqjhxhY1Twj6+qa79dc5YukYcld2tdBQVgkAIL
 hG7wH9GG+WWIQEUrVDiHy4FuD3+kP5KwZnLZQULiwb0QrLJHyZBejIrjilDiGxWshiGF
 DeniYN1u/PQvpzhMoZV6jBftbPehvBdN4U/73gqV6obcDoIJ1Eqfk/P6Fg+ZKDz0ZM8d
 Cni09y6U2kuebGINGBguHcseVm/Ery14aOFj4TcAnj3RC2vrbPcGIqyILsz7UlZGQLXp
 60QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712260120; x=1712864920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=airsYYnzzrC3CGj9Ils0htz0QXpak8uFciduBNRfDcQ=;
 b=AqB8SqALV+PqqqwuT4vcjkOdZ5zAscYUC/DkWiGE9NqoE9JIjzmDGBaa4n2Qc/OyPN
 QDvohanLneWpAXn5GZoNBSpovHuheywdx3+cMMAzU0EBmMLMShlkbJCdcYsl+3GhshFO
 tkSsILa6oVqLcjR3Dr9bjbrlwCyRem7Qf5cCNCvcfNJvfimTHVzXOu7EoWf2lDgz2xuK
 W3RJ/MA7wirEPhm2f4tqjrNEURtk5F4d8dEZ1UgJFManptjo8R7yt3fXWsprMyRhtJT5
 Nfui39UZGMamf8YnfLDal21MevUgAr0pF3bKdCC+6d4UsMWGV1DiiHa4VQpB5o11uKLr
 8sng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1/8XSFVFywxKnLnsfS61ilLws5/XUg66desnl/UwF0jZ4I2RrlkiE2pCTlLisYdGDl6SckYKuawzUouK/dUAviO1q9Do=
X-Gm-Message-State: AOJu0YwaJ4xp0sxu1WpWBKrnV3RAarAACdtqZPIcM6rApW/5ZTL4RAuo
 JPGR13vyw6iw6GkDzdBA/WcZpTJzmjaNC03eXxUwxZbvq5dDmQyeLbiEvEnyXJ4=
X-Google-Smtp-Source: AGHT+IFh/n0g504mw7ncmbeJtMNi3J7fr8Lo+7xgpTuRxUFuIhe0R4hL2T8oeSQgGxubmfS52io2DA==
X-Received: by 2002:a2e:9495:0:b0:2d8:97f:451e with SMTP id
 c21-20020a2e9495000000b002d8097f451emr2517158ljh.37.1712260119852; 
 Thu, 04 Apr 2024 12:48:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a05600c450c00b004161bffa48csm223823wmo.40.2024.04.04.12.48.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Apr 2024 12:48:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH-for-9.1 7/7] hw: Include minimal source set in user emulation
 build
Date: Thu,  4 Apr 2024 21:47:57 +0200
Message-ID: <20240404194757.9343-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240404194757.9343-1-philmd@linaro.org>
References: <20240404194757.9343-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

Only the files in hwcore_ss[] are required to link
a user emulation binary.

Have meson process the hw/ sub-directories if system
emulation is selected, otherwise directly process
hw/core/ to get hwcore_ss[], which is the only set
required by user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index c9c3217ba4..68eecd1937 100644
--- a/meson.build
+++ b/meson.build
@@ -3447,8 +3447,12 @@ subdir('qom')
 subdir('authz')
 subdir('crypto')
 subdir('ui')
-subdir('hw')
 subdir('gdbstub')
+if have_system
+  subdir('hw')
+else
+  subdir('hw/core')
+endif
 
 if enable_modules
   libmodulecommon = static_library('module-common', files('module-common.c') + genh, pic: true, c_args: '-DBUILD_DSO')
-- 
2.41.0


