Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09CEC3DA49
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2024 15:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sY64P-00055S-NY; Sun, 28 Jul 2024 11:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sY64N-00054q-Qv
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 11:44:24 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sY64M-0000FQ-19
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 11:44:23 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-70942ebcc29so916995a34.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 08:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722181460; x=1722786260;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e53FMPb19wWcxjqG/h95PXdgfvOVKtT4UcfRB7TXDmE=;
 b=FKxx0McV8ubKAD90Z53suI0xLIFm00ZPXzrqcWIWBekXxFPx6tTho/+EcefFSQej7u
 v7+PoWlJpXerH0pRA/+dPksdrnCld2SFCq3cDSi+bo9ow1+ggDpQaBcTNXvY6qIbF2H7
 HgOz/qn/7fmJinh0iMkpDAkJ6y8pA1bU2sKzBD0qy0UweHIL1Mhm0DBK8SG7f03FlE59
 f65yNmlvsXejIEb7JWthkgzIt0brEr7YV8qLuyMz4hhb9LzHrzGyRZWIp2iyLLZDKRyK
 ur8V1oY5xgltnNUukykPJSbEy3sU3+BTDj+5fxplAKEItQSatdR2r8hNKffWrDqIKjmn
 ebrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722181460; x=1722786260;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e53FMPb19wWcxjqG/h95PXdgfvOVKtT4UcfRB7TXDmE=;
 b=XZbn3QzruJvvkSW+M7lUt24pqL+ZmGWRZjIDUX8uc9ZM3nDQMIbzCdLpzxMJMqeuPJ
 BIrYLjt12HzcvBPJUhrf2KVLqes2wuKJDr3q1XXfaAlRrTFLHjTP3Jpoweb11yvrgnmh
 QXVpevaCPggdsCHioIvPs1t3MI42dF89suMKEOj84Fd2Yqqlzak9D2LneHOcQUDTagza
 u6egH4W6Xs8F89RwHg2z2yn29hcrLi7vGGGbD04w7XxllxZcSi7XGgDFjNAGh+9ztW2e
 12tA89dDNnrwOXlFb/WxmzxAZgM6B0wKfCMrk8rk94ShwblZ03TGcn7iIu1/Z2yHwiAm
 Z3kQ==
X-Gm-Message-State: AOJu0YwLm5MaqI/Sh10g9kNBvf0z3WJqKlysPiOd25BqP2KSYP/KtEW6
 eBrtnYT7TgGDfmx+L3i0QKR0aZcFG1xFTl9QfIMQ0WTUBQnAzs+hn0KB3fUBN/g=
X-Google-Smtp-Source: AGHT+IGuxn0sQezBe7+LHuEb7XDxEUlmxTkkPgpqxCoO5nFsqPA4TrlfPi+FNL0B9vtC2ZQ2BtIUpw==
X-Received: by 2002:a9d:5f09:0:b0:703:fdda:fe2b with SMTP id
 46e09a7af769-70940c0e09amr6112517a34.11.1722181460217; 
 Sun, 28 Jul 2024 08:44:20 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2cdb73ea9afsm8891872a91.26.2024.07.28.08.44.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jul 2024 08:44:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 29 Jul 2024 00:44:12 +0900
Subject: [PATCH v2] meson: Use -fno-sanitize=function when available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-function-v2-1-2401ab18b30b@daynix.com>
X-B4-Tracking: v=1; b=H4sIAExnpmYC/22MQQrDIBAAvxL2XEt2ExB66j9KDrqaZg/VoqkkB
 P9em3OPMwxzQPZJfIZbd0DyRbLE0IAuHfBiwtMrcY2Behp7jaOaP4HXFintBmJNg7GWoeXv5Gf
 ZztVjarxIXmPaz3PBn/0zKahQMZNhO6JGa+7O7EG2K8cXTLXWLwywv2qhAAAA
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Commit 23ef50ae2d0c (".gitlab-ci.d/buildtest.yml: Use
-fno-sanitize=function in the clang-system job") adds
-fno-sanitize=function for the CI but doesn't add the flag in the
other context. Add it to meson.build for such. It is not removed from
.gitlab-ci.d/buildtest.yml because -fno-sanitize=function in meson.build
does not affect --extra-cflags due to argument ordering.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Dropped the change of: .gitlab-ci.d/buildtest.yml
- Link to v1: https://lore.kernel.org/r/20240714-function-v1-1-cc2acb4171ba@daynix.com
---
 meson.build                | 1 +
 .gitlab-ci.d/buildtest.yml | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 5613b62a4f42..a4169c572ba9 100644
--- a/meson.build
+++ b/meson.build
@@ -609,6 +609,7 @@ if host_os != 'openbsd' and \
 endif
 
 qemu_common_flags += cc.get_supported_arguments(hardening_flags)
+qemu_common_flags += cc.get_supported_arguments('-fno-sanitize=function')
 
 add_global_arguments(qemu_common_flags, native: false, language: all_languages)
 add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index aa327824052d..d83e50abd933 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -430,7 +430,6 @@ clang-system:
     IMAGE: fedora
     CONFIGURE_ARGS: --cc=clang --cxx=clang++
       --extra-cflags=-fsanitize=undefined --extra-cflags=-fno-sanitize-recover=undefined
-      --extra-cflags=-fno-sanitize=function
     TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu s390x-softmmu
     MAKE_CHECK_ARGS: check-qtest check-tcg
 

---
base-commit: 93b799fafd9170da3a79a533ea6f73a18de82e22
change-id: 20240714-function-7d32c723abbc

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


