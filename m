Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092D9F94CDC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSaM-0005nX-Gs; Wed, 22 Apr 2026 04:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSaL-0005nH-UF
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:05:25 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSaJ-0001Yp-U7
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:05:25 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso2771172f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776845122; x=1777449922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mnk3BqubVEuACPuXwlLrt9Klw27vCOHNdmtnzV5BMkc=;
 b=UJc1Ph9qiEqarFUkOpUfoiTy+wcH+7/lY7Tu65sMaWtcnWyTfII/k5NH7AzWYFIQEi
 I7voFRCmvgmL/EPCEo6vDRE0q7NrA0x6jqSeNYYqRB6ikhs0bGwp2b8/qjiTA0yZqdrH
 KAyn12CeodvFXBkXAM8ptFyguHFsPnDSEqVmktvdTljLJoua1Kc/IAGndrGPjnzf6N3t
 WK+N6SA8RdgYVSIkR25BuFJI/mN//D6szIybiE4gNtgTLdHAeUjyoxPOE7xcFpdQlqie
 sHu7xm6X4V7D/WibHPPJmux4DQNkfEVL6l2uWgNQw6LEeqFK7VqF4EG3HndsTuP4dTLx
 DEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845122; x=1777449922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mnk3BqubVEuACPuXwlLrt9Klw27vCOHNdmtnzV5BMkc=;
 b=nkWsmKYYAlXaTGBT/IL9clpmcUMOtO9Ofk3BSJzUGeAPnAotjhpooIYHaJRxKOS6BI
 Iv4ZH/Cc8OchBTjjVY8+0E1W2VeBuYsnpLrb2B8uYrzjIB2Nvt+17gPhfpGDm0F75lxl
 ZFd48eqo9/68jkO67GcvZ/BrgIZUFh4T87uAI5t/J8k6MPvGxxcCcgKqBfv/GuNtTTEX
 zaDuF/CUnxlGVoqZHdHQkOWHPwOqm+96GAQz1STTp9xHahfGrygeA/nfSw7Jj8AGIxOu
 UoD2nscJP86Fh/ApIRPsvWQVpruKiOXUvZGO/1Boh4tU/s5tgM9ZyB7J0h9oS4uPJqBW
 pSvw==
X-Gm-Message-State: AOJu0YwP3UWlpLdY4yRhWmnKTdTcqKhsRw0Np2XPhGGECWSKn1BrsMvA
 4/BkZqvtw/FIaQRuotXlwUcZvFAbPmq577KQ093zLQ0g9Li35DVwKVfG2/F7+F0l1XMNwstZGYq
 wBwg28zw=
X-Gm-Gg: AeBDies8t3uDTYnL+ym+/XgDaAMzZnlPUNExSm8WKtk3Ujs6vWypJ77reruTLJIs1Dl
 wdvDu9BWNe/vkRtQU6Iocfp3Abudijl8BgYwJpxZj0HEYOQV+5OryTXkWZg3UenJ4uCsEIai4Jc
 5k99MikbBzsjSw7TKkdeACyaLqdEH19hOQDLDzqvGNkt2/qazgkyxWyL6wmxue8W33iFUeOdq6+
 Syg/qfCYu2hUJg0JPsyo1giTPSUs/UuwMxk2FBHvhEYQYUjgYO2Lk8nhtOVryLak3qVl7ZGZQiE
 TEU6suddzWnHTUWn3h2x6AiXcy8OjxPXKzEMKjTPuU3S6a6HzKILYzAr87fav6DnZG3U7g5FR0m
 jDG8ndOJhSL5THJqPf5SFblnAt+lLL86q2udrSkRljmJoQHmylDh8yykfAf4bc3MEU9dVDM2qQz
 PmxnvzQn6lpfR6KNbvn618tGKokEg+sC0lZi8Qnae9qPu4HX0v0RUpXCCymevl0UzRdTEkl3JNQ
 ilAAAUSS6M=
X-Received: by 2002:a05:6000:230b:b0:43d:7cb5:43b2 with SMTP id
 ffacd0b85a97d-43fe3db3150mr32859706f8f.15.1776845121668; 
 Wed, 22 Apr 2026 01:05:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc07bbsm46481633f8f.11.2026.04.22.01.05.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 01:05:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 10/10] MAINTAINERS: Transfer CI maintenance to Pierrick
Date: Wed, 22 Apr 2026 10:04:05 +0200
Message-ID: <20260422080406.62638-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422080406.62638-1-philmd@linaro.org>
References: <20260422080406.62638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Pass the torch to Pierrick who does much better and useful
work in this area: https://github.com/p-b-o/qemu-ci

Remove me from custom runner files since I don't have
contact with OSUOSL or IBM.

Cc: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 242546498bc..39f20892d7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4452,7 +4452,7 @@ Build and test automation
 Build and test automation, general continuous integration
 M: Alex Bennée <alex.bennee@linaro.org>
 T: git https://gitlab.com/stsquad/qemu testing/next
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: .github/workflows/lockdown.yml
 F: .gitlab-ci.yml
@@ -4497,13 +4497,11 @@ F: .gitlab-ci.d/windows.yml
 
 Guest Test Compilation Support
 M: Alex Bennée <alex.bennee@linaro.org>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: tests/tcg/Makefile.target
 
 GitLab custom runners (HW sponsored by Linaro, OSUOSL and IBM)
 M: Alex Bennée <alex.bennee@linaro.org>
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
 F: .gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
@@ -4538,6 +4536,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 R: Marc-André Lureau <marcandre.lureau@redhat.com>
 R: Daniel P. Berrange <berrange@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
+R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: meson.build
 F: meson_options.txt
-- 
2.53.0


