Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E954CCDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wby7b-0001mx-6Q; Tue, 23 Jun 2026 06:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wby7Z-0001lg-8S
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:12:45 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wby7X-00073J-0X
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:12:45 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso3737613f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 03:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782209561; x=1782814361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7iLdkUv2g8slzNNQ/D5KOj9cNcBhm/Ume7ZGggWnIyQ=;
 b=QO4KlYSuj/mvhZEbf4X0mUxV918Dkvfj/eQv0sFJ8l5VpurSZ6A6Y+TiRU938cses+
 oyESwXTXeOQFmIiMidaIlKuQSZeukgl/A+C0iTxvLdihUJb4sHCqj+m0+PzURTDA1bRi
 bXQAzexv+5K7hgM8SjrJlBFkhQ59EuloRcX6JppFzv3aeG3XXBiEU0owiLI2/RHMYqZa
 8Ie1dAGZnoHYtinvIDw3Cs4Rglu9MIJzPxXnjHfFsxJDfrA3ElCfeYMr3faBPSqPWRx+
 y62kO9qKEdGaRSvwzAYbcl4kfUEV66Paux4W9uVrT94U/Xo4LoptALlLEcKlu1SGFTuo
 ZW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782209561; x=1782814361;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iLdkUv2g8slzNNQ/D5KOj9cNcBhm/Ume7ZGggWnIyQ=;
 b=BGyyWhMEBr4RzsWBcNQWPwdHIYnAw8Gi+A2fMgaf5yaRwouMx3iIKyKAJFuVNscfVE
 X77eJK6FuoGJ59yf/TS8EzxGuGm15Td/C2Ga4ep+/5FtVNIlnNB8IZhkjOBJiHC3TFxY
 16MLgHshmttjS0+PBXNAyvn8OprI/bCoM0cDhq0HMvlOUzbhJeNPkwiJWd7K0kZ+FLAC
 7GOF92wLcj13TO+1pwfO+1IKBBQqswRrjD1G6KXw7mqLCr8u4br35uKd6MB9qucf8Kfp
 imsuo1b//TTCRIvGC10/QPoSrNXzjCnRme+p/sP14tlEkfnfTrxFe8gaixdGdBh86oFS
 JOiA==
X-Gm-Message-State: AOJu0YyzEqid3z9nn7FdBkBHInGnUMA4dcjq0UqeIYapoJWnbaOk+Eko
 g1VcdcWe3gN3bbmfVxtxWnpnTZTk65gKxfI6gSl55tmBofbd+Y2lBy/v7wakKjC/PFH6F6JvK7A
 ln91mKXY=
X-Gm-Gg: AfdE7clGp8YreUpWPM0N+ZtsJhOcatcYPd+0QuyAsQIx4GIfuvIBIWPrkDW/aIyp/PX
 RfPWk19JyIr7CwD/ODGLtQZbFmgNgx3q2/pCY3Bkh7rvyvLvC/TqHNTjurplBkX9u5fKCWOovpN
 nD7unPBbF6D9wX91xtSoAfCOg4Uwuv3AEXAt7DG6yUidJme9WSreJhpCRybhwEUFOURq9AM8CUG
 m7O4V2FC9nB2fJFRajkIhXv5LjYHUwvbkz5ysSFGed4M4DrQQuvKdBIQ5LfoMgc13V9AAJDyzWc
 mHGGINjjwZA5XMgkRA+XR4kEOCFDBXB3NqbC2O+CAC+M4hfOBPOnHuJfnyIlvaISsvmS9BGBfGq
 FMhPpmWSrkxBCXTmy5zgLnYcvprktfmtqREV5l66k52kfQKQ2XcJXWXGSR1EWgZADu511rsy7cf
 RodUDWPRxyWYtyqabOxc1hx8w=
X-Received: by 2002:a05:6000:4691:b0:45e:891c:648e with SMTP id
 ffacd0b85a97d-4650694fddcmr21575330f8f.8.1782209561078; 
 Tue, 23 Jun 2026 03:12:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46a63f9bab7sm6642125f8f.25.2026.06.23.03.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 03:12:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6E4775F80E;
 Tue, 23 Jun 2026 11:12:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 0/7] functional test and gitlab updates
Date: Tue, 23 Jun 2026 11:12:31 +0100
Message-ID: <20260623101238.3806547-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

The following changes since commit b83371668192a705b878e909c5ae9c1233cbd5fb:

  Merge tag 'pbouvier/pr/plugins-20260618' of https://gitlab.com/p-b-o/qemu into staging (2026-06-19 15:00:01 -0400)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.1-testing-updates-230626-1

for you to fetch changes up to 6aa02798bb517d99988fcf64a0afa0850d850c73:

  gitlab: update bug template for sec issues & tool assistance (2026-06-23 10:55:09 +0100)

----------------------------------------------------------------
testing and gitlab updates:

  - present a dev friendly cmd line in functional test logs
  - tell pylint to skip c-modules
  - widen the capture of functional tests logs in gitlab
  - remove workaround for MacOS build targets
  - update the gitlab bug template for security process

----------------------------------------------------------------
Alex Bennée (5):
      python/qemu: split arg between base and harness lists
      python/qemu: split console from harness args
      python/qemu: dump a developer friendly version of cmdline to logs
      tests/functional: tell pylint not to check c-modules
      gitlab: remove build target hacks

Daniel P. Berrangé (2):
      gitlab: ensure "check-XXX' jobs capture functional test logs
      gitlab: update bug template for sec issues & tool assistance

 .gitlab-ci.d/buildtest-template.yml | 18 +++++++++---------
 .gitlab-ci.d/macos.yml              |  7 ++-----
 .gitlab/issue_templates/bug.md      | 11 +++++++++--
 python/qemu/machine/machine.py      | 32 +++++++++++++++++++++++++++-----
 tests/functional/pylintrc           |  1 +
 5 files changed, 48 insertions(+), 21 deletions(-)

-- 
2.47.3


