Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D251FD591A9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5UD-0008Pq-Mz; Mon, 18 Nov 2024 12:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tD5U1-0008Mq-5s
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:24:21 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tD5Tz-0002ny-Cd
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:24:16 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-212348d391cso9370635ad.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 09:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731950654; x=1732555454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e4XkJsAE/EFpWJE1zVEboiYzZ4XYd9X73tpjRSnXg6Y=;
 b=fTWwrJxewdElbT3pHM3CeUgzp3dw1muouAKGT68PxerAs2SDYiSc7vRyN7KO21mp/1
 Ti4/D3gkk7Y9t/lu6Y19nunl2J0OXJwf24KscVIgzv8s5Z56k1peraBPxdWPE9hw1qV3
 1mFPRjJJJlIzPYK8y7sKYSYboldkJdxqXiKELkgt4jM4S5KwCslynOUiQj4itWnYCcxd
 6IDAmZQd/PRXXsI/ukLJzM/ONJ6pBTsWbWJf/c4FZaWK0W0UgFwYf2eLgtncsyMOeIC9
 l4bz7vtQdqEJpnM7r1OizhisuJi4bMKBnylVrR5Nu9JR6lNVF/lSUITlpYiaAAmisAmO
 0iMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731950654; x=1732555454;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e4XkJsAE/EFpWJE1zVEboiYzZ4XYd9X73tpjRSnXg6Y=;
 b=qJoaijlhK/1ZlefVWTezDAC6FnN3x3Z5gJgKhIWgW6+rNr+0hrTUPX82RirQqqhXcm
 y8bkG00suujhW2Q2eO4xCg+I5tmkqzP3FmJzU07xfMdIOgG+PWn7L/HEBzKj4neYaVZ8
 ENxeneW0GftHcK05XJXLmF8AhEcLja6VX2lCXdQAsvqywzl7qtBburBKnIoAu1hQzagq
 fqtY+1MBUEY33CMI672JsnipLSdTNXvh/rIuX6kyNatqUoE9/d4yr4+fMx+MsaF/Rxms
 J5ysvEYaBTPU6X5tBbYYvPqrbxnDA+vzRgcxY88fRLm6rvnmMbRj93/Yya4I+Eq8Mdxa
 hyFw==
X-Gm-Message-State: AOJu0Ywxn+mjJWdMtO157evnqjqwQifA0b8IwfOpZuJE1shLI4GLwFcC
 hq7+F1V6d3EAy0L9wB3iKcpdkHTbCRS8TTqOEl4Xf3rn9Z42r5WRlbt/YWH12q0tmxqL2J/LvCF
 j78lYnA==
X-Google-Smtp-Source: AGHT+IGCNPa5oEuHAc4+eGbiDJ9GjGH5o5xmHOYseloT5NM0kDwDS1L6jCoWMaLdELUpPJahY/WmhQ==
X-Received: by 2002:a17:902:e843:b0:210:f6ba:a8e9 with SMTP id
 d9443c01a7336-211d0d70e62mr184708445ad.19.1731950653665; 
 Mon, 18 Nov 2024 09:24:13 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f55d04sm59469765ad.264.2024.11.18.09.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 09:24:13 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 alex.bennee@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 0/7] Enhance documentation for new developers
Date: Mon, 18 Nov 2024 09:23:50 -0800
Message-Id: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

This series extends our documentation with new pages to help developers
onboarding on QEMU. It focuses on providing a big picture of QEMU (to a
modest extend).

As such, it was written to be simple, short, easy to understand, and pointing to
more details. It provides another way to dive into details instead of simply
hitting the "search" box.

The first patches enhance the existing developer section. They provide
information about b4 and git-publish, two important tools that I learnt from my
coworkers, and were not presented anywhere, and were really missing IMHO.

Then, we introduce a new Codebase page, presenting (succintly) the various parts
of QEMU, and what every folder of the codebase contains.
We then add a glossary with the most recurrent acronyms we hear in our daily
conversations on the mailing list.
Finally, we add an "How-to" page which present how to build and test qemu, and
how to contribute a patch. It's definitely a repetition of existing information,
but the goal was to have a self contained page with all the commands I run
daily personally, and that someone would be interested to have.

When reviewing, please keep in mind this is targeting someone who discovers
QEMU, and not someone who contributed to the project for several years. What is
obvious for you will not be obvious for a random young developer.

That said, please free to point if something is "false", or "really incomplete".
It can be hard to summarize in one or two sentences complex parts, but that's
the intent here.

Your feedback on content or organization is very welcome!

Thanks,
Pierrick

Pierrick Bouvier (7):
  docs/devel: remove dead video link for sourcehut submit process
  docs/devel: add git-publish for patch submitting
  docs/devel: add b4 for patch retrieval
  docs/devel: add information on how to setup build environments
  docs: add a codebase section
  docs: add a glossary
  docs: add a how to section

 docs/about/build-platforms.rst         |   4 +-
 docs/about/emulation.rst               |   2 +
 docs/codebase/index.rst                | 211 ++++++++++++++++++++++
 docs/devel/build-environment.rst       | 114 ++++++++++++
 docs/devel/build-system.rst            |   2 +
 docs/devel/control-flow-integrity.rst  |   2 +
 docs/devel/decodetree.rst              |   2 +
 docs/devel/ebpf_rss.rst                |   2 +
 docs/devel/index-build.rst             |   1 +
 docs/devel/index-internals.rst         |   2 +
 docs/devel/migration/main.rst          |   2 +
 docs/devel/multi-thread-tcg.rst        |   2 +
 docs/devel/qapi-code-gen.rst           |   1 +
 docs/devel/submitting-a-patch.rst      |  29 ++-
 docs/devel/testing/main.rst            |   9 +-
 docs/devel/testing/qtest.rst           |   2 +
 docs/glossary/index.rst                | 238 +++++++++++++++++++++++++
 docs/how-to/index.rst                  | 146 +++++++++++++++
 docs/index.rst                         |   5 +
 docs/interop/qemu-ga.rst               |   2 +
 docs/system/arm/virt.rst               |   2 +
 docs/system/images.rst                 |   2 +
 docs/system/qemu-block-drivers.rst.inc |   2 +
 docs/tools/qemu-nbd.rst                |   2 +
 docs/tools/qemu-storage-daemon.rst     |   2 +
 docs/user/main.rst                     |   6 +
 26 files changed, 788 insertions(+), 6 deletions(-)
 create mode 100644 docs/codebase/index.rst
 create mode 100644 docs/devel/build-environment.rst
 create mode 100644 docs/glossary/index.rst
 create mode 100644 docs/how-to/index.rst

-- 
2.39.5


