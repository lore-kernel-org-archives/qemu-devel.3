Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881AECCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 17:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v40LT-0007vR-FX; Wed, 01 Oct 2025 13:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v40LN-0007p8-0r
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:10:21 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v40L5-00034j-1o
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:10:19 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e37d6c21eso354905e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759338591; x=1759943391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u0komx1VDBWrWu3LJvaJHmjHm69UbO44yc+hkmHvjlM=;
 b=cOMKT2jK8kEDxuQNF8KrMPXmkgIBcS97kxNR0EtckY/ezAiu/DC+32Lj7oaNEbb898
 IOiUOOiQoGPjdteKBAn0FT2FPKw3G58gewjbSmF73w1Q6zXM3rVxDVah3XK2Dw5tgtkl
 M8RyMsoSXCwn2UMf2SkZYJcUTmp68G8Xng8ysvhE3JrUJY6fmtk10fEXKk8BVrNSD7b1
 2XZYEm+J5eqIKohXs6Rk1MUUh0i4q363adKQnqXKy87jSzphoTJsmiich4e9mj0AQFgM
 QjyHfLYehrTVXtcyApMSoduJTBpkb9YT+Wl9b1qedvgdYAse6czN6fRd+IdA+1yrS2J+
 pXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759338591; x=1759943391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u0komx1VDBWrWu3LJvaJHmjHm69UbO44yc+hkmHvjlM=;
 b=dRK9/VkAckvVUO1ROIAxHOVx5FNTJmZ+2RyOhsZnMz0nr+pz0nbyCAwRw60dFB5sX/
 1fU5M0EFPegF2l9Qu8abZCNouw9s1bvRolzxE8IN/Rhr7XJE1WuYvbzJTZkCSuxMwlXg
 2pfxj7gp44+ciiBDDWMj3sg0uRdBAMqEtQJXYIVAvoV5g/GUC1nHGE7cIxs4ZmdK+rBh
 ioUnTyFfkhk6SnGQwcEytHdnPekdJHi3vTGbv+X7vvxdBZy0OzsVCUkCrFX/DmGL4fvW
 a58iNEzYB/wIzLLgPMzf8RqCNbZ53+BysabvyXOp3X/6oKXb4LGYyZoDHWMVh/3yN04H
 bfTA==
X-Gm-Message-State: AOJu0YzsWFgdUQAbCZyYlaC0Tvt6MB3dmgp6LbNlh9iipXQCLtW/dDj9
 ddnP5K/L70HhIcb40Kn+ikZXmc6fcWcrC17wkF/DhtU3BvUCyzIPavVm9V4pxBDYPfY=
X-Gm-Gg: ASbGnctATrtyWhhr/B3QwCGpI+P0ZKgL+KNRYRH2kNX0NPZBu9WxmgKczDbuEi5Hjkb
 /SI1SK9wwIrDQ+HYkq7QkT7bmUgPGRx1sAutnLPNFp8YOIChojATUDD3YntbydjvV98esvGAn2d
 6yOARA/ppz+PAg2xfzYRxgH7bRfnKGDElxtII3NGhdBwGm46wh0mwVDGeWQujc+HExoUl+3N0Qr
 IHasdf0YkI3ho4GUSlF2mNG/7EqyrC2VsQ1PL8IJwCksTmvDuEfcTerqN8/oqGmqHmFsQMJDNfN
 ggUlISKvOhJ+s6jenHkPcJw/3OTuiku645273OApIgjX/pV3nqVeYuBywpUofEG71zeV+QW7hnO
 drDfiVlrZKyx3U8VjaV5GhH5YyYmrROVAv2PKEmP2oJNODro=
X-Google-Smtp-Source: AGHT+IGMRI2qKBkPU+whpXopZ+psRkGnjoRCdoFZYnMRQ+KUenYoRbx40Ita3ZI2Vqjvt5ik6fa75w==
X-Received: by 2002:a05:600c:8b65:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-46e6127cccfmr36402925e9.10.1759338590990; 
 Wed, 01 Oct 2025 10:09:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602eccsm29529984f8f.40.2025.10.01.10.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 10:09:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7ACD05F7A7;
 Wed, 01 Oct 2025 18:09:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/7] testing and misc updates (docker, ansible, .git*, gitlab)
Date: Wed,  1 Oct 2025 18:09:40 +0100
Message-ID: <20251001170947.2769296-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

My first set of patches for the development tree. Should be mostly
self-explanatory. We still need to apply the upstream COPYING patch
the u-boot-sam460ex code but we should decide if its worth mirroring
or should we just treat the copy as fully "ours".

Hopefully I'll have the new aarch64 runner online by Friday and ready
for the switchover.

Hopefully I'll also be able to pick up Gustavo's reverse debug test
fixes by then as well.

Alex.

Alex Bennée (7):
  .gitpublish: use origin/master as default base
  .gitmodules: restore qemu-project mirror of u-boot
  .gitmodules: restore qemu-project mirror of u-boot-sam460ex
  tests/lcitool: drop 64 bit guests from i686 cross build
  tests/lcitool: bump custom runner packages to Ubuntu 24.04
  gitlab: move custom runners to Ubuntu 24.04
  scripts/ci: use recommended registration command

 .gitlab-ci.d/custom-runners.yml               |  6 ++--
 ...4-aarch32.yml => ubuntu-24.04-aarch32.yml} |  8 ++---
 ...4-aarch64.yml => ubuntu-24.04-aarch64.yml} | 32 +++++++++----------
 ...22.04-s390x.yml => ubuntu-24.04-s390x.yml} | 28 ++++++++--------
 .gitmodules                                   |  6 ++--
 .gitpublish                                   | 16 +++++-----
 scripts/ci/setup/gitlab-runner.yml            | 12 ++-----
 scripts/ci/setup/ubuntu/build-environment.yml | 12 +++----
 ...-aarch64.yaml => ubuntu-2404-aarch64.yaml} |  4 ++-
 ...2204-s390x.yaml => ubuntu-2404-s390x.yaml} |  4 ++-
 scripts/ci/setup/vars.yml.template            |  5 +--
 .../dockerfiles/debian-i686-cross.docker      |  2 +-
 tests/lcitool/refresh                         |  6 ++--
 13 files changed, 69 insertions(+), 72 deletions(-)
 rename .gitlab-ci.d/custom-runners/{ubuntu-22.04-aarch32.yml => ubuntu-24.04-aarch32.yml} (78%)
 rename .gitlab-ci.d/custom-runners/{ubuntu-22.04-aarch64.yml => ubuntu-24.04-aarch64.yml} (89%)
 rename .gitlab-ci.d/custom-runners/{ubuntu-22.04-s390x.yml => ubuntu-24.04-s390x.yml} (88%)
 rename scripts/ci/setup/ubuntu/{ubuntu-2204-aarch64.yaml => ubuntu-2404-aarch64.yaml} (96%)
 rename scripts/ci/setup/ubuntu/{ubuntu-2204-s390x.yaml => ubuntu-2404-s390x.yaml} (96%)

-- 
2.47.3


