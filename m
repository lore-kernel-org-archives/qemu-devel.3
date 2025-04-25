Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0A6C369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L24-0006Y1-3q; Fri, 25 Apr 2025 11:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1u-0005hs-V7
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1r-00045Y-LJ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:54 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39ee682e0ddso1557630f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595109; x=1746199909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/dNYV9pYXgt9CiWoeZ7raRRHnU5OLtbyz8NfKzKm4I=;
 b=y5klToHBqO74zvWovmtCbfqS1Fh8keIHhNzUmyNTL6DG8OXUm3d03kmBJywT42DArn
 AYNeHicra56230vUbNy02KAKp+thQ9+r/bgYFlXWVOvJFcpJASHMBJtcLNDFH5i7ifvO
 zbqspZTKl4tjUb+cu3vkJ+zo75vKKojNYJ8NOE3bRxOSU2MxwNsQjuL1Xu+OvCPdepNX
 mQBGfX9QwepX2DUigHKGCGAov08qcRCt0eMunMQfvW7fpCPWLdT01a+aKvx1nU1mZNXb
 ic62DcSeSEfVDkKYzj8dERCmCwDXdWhlTVDtFpP9W71LfDkII5fd/SR+2zMZA7nr5vr/
 V0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595109; x=1746199909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/dNYV9pYXgt9CiWoeZ7raRRHnU5OLtbyz8NfKzKm4I=;
 b=sDpU66c10V7j8Rda1VDIVW+sd40LZx/Cw+Pzgpdmd80I3gN7fg3MCAuOOckV0BEl8m
 7et+wn+hpG3DMpT14Fn2R6g2NxUm8IJ/I0Ikhp79cSSDd+QysgfHMIswkHEu4YMo0ETJ
 1QFdKhW2C6zv/VtRBnm1Bc49vp+FQBL2nZBE7JAz+EU9J6Bk7fhGriBOR6hs+Wc3MCxa
 hkBj6i1daxM6gBHEsDhSNPY8Qj9VdJ1NF1/pPhlozrhJVvOd6Drsivr5dHANO3JJCtk2
 6c51LClZlwr28t8okDWcmg0D1bngNa8xx5D2ebsAs3Pz/ns2P3QtDP+ZuZ+aaBLrWQJ8
 q2eA==
X-Gm-Message-State: AOJu0YzhwmxNo0Mu84Yvcy6GgObzbCrLPOYIPXNpkpwigjLTK6FIYz+C
 5FF+zKDRveTlARvGJTcZCEtXRZixGXDCDk51+y+t0kswQiOVJztRQFY7aKn1bf8L+ajyqDGH7ls
 h
X-Gm-Gg: ASbGncuenjyu245Cr6/uJDDVwAvJH7pHwaDiwHkFzWjNa9eJm1B6VSjtN7O3Vrx/AJa
 rFWcoguSWa02EoRGVUIaGFmN4ITifHdi1w9fgZL+aN5sNG7Gq52z/5BgXjl8fesAg4PwFn1o/0P
 aY/mW7i018yoxmoQdcB1p0Sf7EYwlfob/qRPCnSMFlcegsm/zTmFD+y+Jvc6PkJeJYopqyLzwmz
 lGCnDwf3zkV/n8NYr/UFfzGo63sxwwwyCXnLI2xkSF6435w68zyXNyV5040+jEKB2Q0+IQVErqV
 ns74VYhRaxdQXcNA8dWQKYOgmBDmTNmn7dVq8AOMygfGBUL1QRwNS5MsUTzlzTfsdACNUO3Jlv+
 CsWk8Iw1kkz33fLM=
X-Google-Smtp-Source: AGHT+IGuToGSGwRyMea8QELQzjNXUIW94RTo6/+DqZv4j/S5O5Is0r4Ymz5/+IP4eWXMLUzDchaC/A==
X-Received: by 2002:a05:6000:144b:b0:39a:ca04:3dff with SMTP id
 ffacd0b85a97d-3a074f14606mr2560482f8f.40.1745595109125; 
 Fri, 25 Apr 2025 08:31:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d1e19e1sm60449215e9.0.2025.04.25.08.31.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:31:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/58] meson: Use has_header_symbol() to check getcpu()
Date: Fri, 25 Apr 2025 17:28:21 +0200
Message-ID: <20250425152843.69638-38-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The use of gnu_source_prefix in the detection of getcpu() was
ineffective because the header file that declares getcpu() when
_GNU_SOURCE is defined was not included. Pass sched.h to
has_header_symbol() so that the existence of the declaration will be
properly checked.

Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250424-buildsys-v1-1-97655e3b25d7@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index bcb9d39a387..f77a9ce569e 100644
--- a/meson.build
+++ b/meson.build
@@ -2635,7 +2635,6 @@ config_host_data.set('CONFIG_CLOCK_ADJTIME', cc.has_function('clock_adjtime'))
 config_host_data.set('CONFIG_DUP3', cc.has_function('dup3'))
 config_host_data.set('CONFIG_FALLOCATE', cc.has_function('fallocate'))
 config_host_data.set('CONFIG_POSIX_FALLOCATE', cc.has_function('posix_fallocate'))
-config_host_data.set('CONFIG_GETCPU', cc.has_function('getcpu', prefix: gnu_source_prefix))
 config_host_data.set('CONFIG_SCHED_GETCPU', cc.has_function('sched_getcpu', prefix: '#include <sched.h>'))
 # Note that we need to specify prefix: here to avoid incorrectly
 # thinking that Windows has posix_memalign()
@@ -2713,6 +2712,8 @@ config_host_data.set('CONFIG_FALLOCATE_ZERO_RANGE',
 config_host_data.set('CONFIG_FIEMAP',
                      cc.has_header('linux/fiemap.h') and
                      cc.has_header_symbol('linux/fs.h', 'FS_IOC_FIEMAP'))
+config_host_data.set('CONFIG_GETCPU',
+                     cc.has_header_symbol('sched.h', 'getcpu', prefix: gnu_source_prefix))
 config_host_data.set('CONFIG_GETRANDOM',
                      cc.has_function('getrandom') and
                      cc.has_header_symbol('sys/random.h', 'GRND_NONBLOCK'))
-- 
2.47.1


