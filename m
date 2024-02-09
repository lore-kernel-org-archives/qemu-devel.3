Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB35CC4829D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 15:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYSpB-0007yX-FV; Fri, 09 Feb 2024 10:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYSp8-0007y7-Oe
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 10:29:55 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYSp5-0007JZ-Oh
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 10:29:54 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-410708db221so4994325e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 07:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707492589; x=1708097389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0WR2qGC9tSUOfxj3WJAdR9JhzphmVmquXXP4yEufYvE=;
 b=A7Vem6a0TjG3ucKbANg4lMiKfRTec7dD9Bxaagnbl3s9Bg9zudBdTNlBPWHUV+smzn
 xcu/bJcSyfYU+Gz4b18h8qo7SuYuPteXwFdbhTWrRNpcj+xhdTKUrJir/FYfzHHydRsF
 ruOge7I0MZ1G73xZzy+/mOuVzcsBdAxVGKMQCh6NolBAfPaxd7n+3e/6lP16Kdzp3csV
 fyZrJ9+pkS9AfTMhS47o4eLEPzv08eP+4lqj/1JzyPc2kRtN1tn9V4JCkebBf49/EQwk
 +TLxSEtro4DwO5kdjj3watDjfTG4Lkf5Zdbgjo0BM6wPSeS4gbfi/3AfS2/ER/Yx5qqV
 qIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707492589; x=1708097389;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0WR2qGC9tSUOfxj3WJAdR9JhzphmVmquXXP4yEufYvE=;
 b=ikmL1LvHxF2JzOf8c4JOqU/o8tVaYLUzkABeqdJeNZgpABIaygLMLOj+ZsUiI3Z4o8
 /atTwFfeZBoEfWKu0zNgSpnA5QJEcQ76+rXl3/SFf/dWW6dYEof9qsG9q9husoAzgORb
 Yfhmmb/zEjgE11PPe+L17W4GFKzL5Y1ccLDtdnhXCFtt4LH8UBOrBEZzTPca1yAXPXrx
 XcTA1saId52vO+XAP9UByqKKffSgrykS0NM8/Kxfj+/qdLDjIgXHrkret2Uzv0pl7m/R
 R5j8MZBc8Q4f935OpXaKuPu6Ho65G2urzt9Bt+6XgPbdI5EdB4Dxd50BFrkz6nUWapEW
 1dfA==
X-Gm-Message-State: AOJu0YxCpM4PXntSJUspbIKSEJJMB33yHdmxpDCa6KSkBqJ0OELujzfY
 cgwY8HpG98+wVYleQmpnXVBPB9dge6AqCbtfTF+DNJ3pIJYLNsxjtjl4z4+1N73npLnrRr66mf9
 z
X-Google-Smtp-Source: AGHT+IH9R8eS2MI26/3h8T1KgEp3yfVAR4nWaTF4amXUDUTdL24bcSnCh9vRWwMpwFYl7yfW8FwXbg==
X-Received: by 2002:a05:600c:5741:b0:410:212b:c760 with SMTP id
 jw1-20020a05600c574100b00410212bc760mr1555018wmb.19.1707492589459; 
 Fri, 09 Feb 2024 07:29:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVjDpMcWWH15bdsb0HnGK3dLTSw9tXjkeFoYw6hIwVVqiP6OAA9ax+FOUUIxxnJGL09LtXgkLlfZvDDYEvP1b7BaxXlL5J0Ou7to7Z2JOAjIjV4H11Ow232qxc0bsAQ2Q/c7H7IVjZjHmU7yKO1cA4Y7H6KqIuwTsMZwaGhAJPQVTelza/agTkRZFoM2/q+XhCLPRmWxIlV5N7ITPJnJj+CoYr3CiC0UMEotPUtTJXFreTuW/we4+tkAJnvNRIG1ZNgXJBRe8F3EqQ2kmmI184yiSHYBw/dvJgzu/xsVp1z5997qByLBvRkuTPfQRmLvPPmou/KEyiF2qhxzYnKUs1k1GAgfoMbMrb8A1ZHdZtGNH5F0wI0suz9Dibj5Q3BfkSzCamaHmAZOAj40eWrFjgoogKkc/Gkq73iac6sOSz9j7ut+pUZf/T8LxbTC+WIjbL9+4IoXHByk3qmV/7PPiHOyM9rcMwcWV/4nWl8BTRbSIxTmfR6S705y15jMZcrdDwK81j/xJDMN3AMBZCANihZFRuLNdIXgGPRfk8XbP2KbJZgXoScQg9UpWq+r83KIDrKS2ChizV9dm47ZBNsg2pCzcmyPXxz5goIREp0JEoPDwbIVRXP0PtJE5oAUrYBm8qHCuOjLVdyddeayZ8bE59yk4oNvc1l0lF1Lg1L7rnGTDkWDkmr6Q6jIml6AMwSTdvfP9+gkozZ8RIUb8AqupbkLY/P6xIAsw==
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 g19-20020a05600c4ed300b004103e15441dsm1046603wmq.6.2024.02.09.07.29.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 07:29:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Amir Gonnen <amir.gonnen@neuroblade.ai>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Damien Hedde <dhedde@kalrayinc.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Beraldo Leal <bleal@redhat.com>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH v2 0/1] target: New binary to prototype heterogeneous machines
Date: Fri,  9 Feb 2024 16:29:44 +0100
Message-ID: <20240209152945.25727-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Almost 2 years later we got hundreds of cleanups patches
merged, so we can get this patch in. Building the 'any'
target has to be explictly requested in ./configure
target-list argument.

This binary will be use to rework QEMU startup code,
paving the way toward dynamic machines. It might also
allow experimenting with multiple TCG target frontends
and possibly prototyping concurrent HW/SW accelerations.

The corresponding CI jobs takes <5min:
https://gitlab.com/philmd/qemu/-/jobs/6138476547
Duration: 4 minutes 42 seconds

v1: https://lore.kernel.org/qemu-devel/20220215002658.60678-1-f4bug@amsat.org/

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


