Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C93C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raXOd-0006DK-Jb; Thu, 15 Feb 2024 03:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raXOb-0006Cg-Jt
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:47:05 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raXOZ-0002SW-Io
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:47:05 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41211acfcfcso3617885e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 00:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707986822; x=1708591622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z3Yvd12ZTKEdeYnpZuZujgW5c5hDdepl6bEEcV+HKcs=;
 b=GjHa2qVfmRH8tR7ZAkL5D0KuUXvgBkK5mzxaSy1gQGe8SrBhZoAgzLkgPqs2d/Wwpa
 f6mgXvIM9RXqeEtGU64ArPK4IBSnLINAqEMJDeItcs+1gzld8B41hmTsOZTEfsTqiM4q
 IvIqxPU/4ckubtz3OSYtEvsBBvo9afID5ixIN1EB5pPdE05Jwj2laHRZDYbSIdbiXBXi
 OfUumhi80MaOeGikOIucb4lfAa1y04Or0WUcHC2ACw/mIuZNgR3wpdLGyQ3Hi1E/9kvq
 5Friyei9pT0vpVSwsX8X5efcIJcQWN56IywpWDdoUmwTcjHw5zRFnjCq8xRkN7z5gviz
 VXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707986822; x=1708591622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z3Yvd12ZTKEdeYnpZuZujgW5c5hDdepl6bEEcV+HKcs=;
 b=WQ9JMde8xYo9M5BtHMzkZelyvWs9c9/xlvD9HBwrkj8vI3SNOTT4VGEFK+1ZveFybU
 kGQfE6T0F63+kHXoWRds4XJv4/+NTFnov30/8ocXiB8Z787j/08ibKn3KQMxcD3nuqGh
 zxLXLXuMub/DVBRTsGpyNND+QqEKBil2wj/fQ6VFx/FWzH2NvBU2YcIGW5kQBP9znBY2
 9zoW4TB73GgHa0l+FgyDko+WB+EwHCkp4jESm0hCQrP0yLLeyFDlRO/2BMxp1NFuSpaP
 Ab97n521BulwWlCTLDhh2AuTtniA4KPaHitjNuvWf1ibfVvuHDeVkLVzsfIbYizEMT65
 J5Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhyGNd0tU5SKZxUOtsTtwcs6dyH1WsQsh6JfuNfPIP3w5yiYNM2A7ohsgcaRK9YVXaCndmPKlbxIUX+lTqnUpj5+yiqlk=
X-Gm-Message-State: AOJu0YxLtXgId/v7jYVJETaBvidV0xrcPrjLSLGVM5dua0AdhWp/6GnU
 moll4lnVcycVl/RYNRJN7aAmJw8bGsNakASsTpsT9l9uRCMOWx7FwQ1y3Zmx+GM=
X-Google-Smtp-Source: AGHT+IEyaf3wvoSXKVdC0NrXLog5FfzdzhYZBV3l6nkPSCCmhuf5z2GOs3XdT8pHJwWhbc0ZwY4zOQ==
X-Received: by 2002:a05:600c:3543:b0:411:ebf7:9a69 with SMTP id
 i3-20020a05600c354300b00411ebf79a69mr814356wmq.9.1707986821773; 
 Thu, 15 Feb 2024 00:47:01 -0800 (PST)
Received: from localhost.localdomain (14.red-88-28-17.dynamicip.rima-tde.net.
 [88.28.17.14]) by smtp.gmail.com with ESMTPSA id
 y5-20020a7bcd85000000b00410ab50f70fsm4250040wmj.15.2024.02.15.00.46.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 00:47:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Damien Hedde <dhedde@kalrayinc.com>, Zhao Liu <zhao1.liu@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Amir Gonnen <amir.gonnen@neuroblade.ai>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Luc Michel <luc.michel@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 0/1] target: New binary to prototype heterogeneous machines
Date: Thu, 15 Feb 2024 09:46:52 +0100
Message-ID: <20240215084654.56297-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since v2:
- Run check-qtest instead of check-unit in CI (Alex)

Almost 2 years later we got hundreds of cleanups patches
merged, so we can get this patch in. Building the 'any'
target has to be explictly requested in ./configure
target-list argument.

This binary will be use to rework QEMU startup code,
paving the way toward dynamic machines. It might also
allow experimenting with multiple TCG target frontends
and possibly prototyping concurrent HW/SW accelerations.

The corresponding CI jobs takes <3min!!!
https://gitlab.com/philmd/qemu/-/jobs/6177909577
Duration: 2 minutes 50 seconds

v1: https://lore.kernel.org/qemu-devel/20220215002658.60678-1-f4bug@amsat.org/
v2: https://lore.kernel.org/qemu-devel/20240209152945.25727-1-philmd@linaro.org/

Philippe Mathieu-Daudé (1):
  target: Add system emulation aiming to target any architecture

 configs/devices/any-softmmu/default.mak |  9 +++++++++
 configs/targets/any-softmmu.mak         |  3 +++
 meson.build                             |  6 ++++--
 qapi/machine.json                       |  2 +-
 include/sysemu/arch_init.h              |  1 +
 target/any/cpu-param.h                  | 13 +++++++++++++
 target/any/cpu-qom.h                    | 12 ++++++++++++
 target/any/cpu.h                        | 24 ++++++++++++++++++++++++
 .gitlab-ci.d/buildtest.yml              | 20 ++++++++++++++++++++
 hw/any/meson.build                      |  5 +++++
 hw/meson.build                          |  1 +
 target/Kconfig                          |  1 +
 target/any/Kconfig                      |  4 ++++
 target/any/meson.build                  |  7 +++++++
 target/meson.build                      |  1 +
 15 files changed, 106 insertions(+), 3 deletions(-)
 create mode 100644 configs/devices/any-softmmu/default.mak
 create mode 100644 configs/targets/any-softmmu.mak
 create mode 100644 target/any/cpu-param.h
 create mode 100644 target/any/cpu-qom.h
 create mode 100644 target/any/cpu.h
 create mode 100644 hw/any/meson.build
 create mode 100644 target/any/Kconfig
 create mode 100644 target/any/meson.build

-- 
2.41.0


