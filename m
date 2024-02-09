Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD00AC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 12:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYQ3c-0007jC-VS; Fri, 09 Feb 2024 07:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQ3b-0007hu-0D
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:32:39 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQ3V-0001nf-0n
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:32:38 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41059577fc1so7482445e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 04:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707481950; x=1708086750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rtj1+LwGPN4+dLzrefXKgA29BK7xkfTmJBnAjE80Yeo=;
 b=lw2YzQ3TmKroPTj7mBF/PPhgJJrSDedZcbA/UWgofooGTuf9VffQ4PTe3YBR7Ha170
 BKzlwVoB+ftOEEWuOsDyULAqc5QNdTdjWxgFj90HCzcRtqxSOwX7d/PL1RpKufL0EA7z
 xPAPauNXHryqZ0kdLhLRdxJuiU/0FK3Ou2+i3naD0ZzeeVpDciePYiY6yZUhpOtHGquK
 obNFMF+f1PfweyUdJT10oCpUHrTiYJg7wvUUJd8kAbS+GjPH3RFSFFTSV2ZAYlyOUHbJ
 Q+WOF91Bvnj5ZhTRfnqYmo9GNrPsYWf9indLksPN2mdNJiG5GuRC1J0ghWYf97A/2JQh
 M5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707481950; x=1708086750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rtj1+LwGPN4+dLzrefXKgA29BK7xkfTmJBnAjE80Yeo=;
 b=dh53A0Mk8PTNVphJchjcLjwa0bOt2RjJUdp5cCXSQbXevOpc+zPTVlF7+PNojtL1n9
 w621xEp3w04AjB+M4gZHkg52lwj+ukpkzXBMSRh48C0/Q/6EixDnnYMpIYkWEl4vjWtk
 +tFZUPrSIoxTAFbtZrB7rUwdyglvnokhipQ7iFuGM8B75VbYm68gYueqLwDFndDAFZkv
 N5lStv+3zt+JKGGY6vfvKIG7eUNxXQ2sX3bJ/G1JjaLEcIz6SgYbkexqdk1EEOCZHdtP
 wSxuSStf4wK7l3uk+ffrqvmkwiomrXjnWMKtyKMJyWWAaApnWDYlcfgYEuu9qFpn9Whb
 QTBw==
X-Gm-Message-State: AOJu0Ywu64ncdfnZZF6cvj5MqETF5R9kddYf8lVqnzGNnhA+/c1oSsgk
 3WRXPS0c3cQ+3m8gafUUxpKDsU30134qyTAFOkatFt4LUIOlfS2uH7HrNCcS3rEIJYWKp2M0DEX
 O
X-Google-Smtp-Source: AGHT+IFTThMwdL+r7VOAT60OkFpuYrXiiySJee3GSsULtekRaUTkg5IaeQK9FnHtPiuIgJ204/GtTw==
X-Received: by 2002:a05:600c:4f44:b0:410:6cba:81bd with SMTP id
 m4-20020a05600c4f4400b004106cba81bdmr1133931wmq.30.1707481949719; 
 Fri, 09 Feb 2024 04:32:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW5Uq53LgbSdg/gLMr4RTcUxKIxKAne2S7RKbeLT/KR2mFek5WVwnnnrHEIiK+JwAynxpiUrsZsHdMwHp3xc+a2qxJIeiC88aCBlsZTeKoZWFPtn2xp0QSpDte19gcBeLGrW5gvoP9USuNB42pQ4Uego3/vstYJm2HSr5BD6+QUzC4G6ROTeDa3U3bEOzmTaxxh0smNk+C6Ev4euxApTp3+3OrmgCkg4u39RqUUGrdp4Ze2/OByHval6q8/x7cigvCSvKPWoXt8k3VjKUlRetuDhIXdRhT0+SUCjvMiieaNvotR60TldQTnCjW9w4nLSz0QFmZ6BziKBtuwt/iftp41TPmODHvpSIVvAb8NUD8mkNPlou5Y7YoawvtBMXJLTMG5HaHDCoJ1uGrl70+g5zcX2A3vIO9Z+3Ru2aM7KymmF84dQy7HvUpqAN0KLE4qyjVKOukOXisiQo2whpQba5CiwZV77wdePUMGki4JATkJIJAwJd1j1CULawX4Evtk5aREZfuvmZ33VzKY+y9YY3aeaKtDclwrJsTZ9g1EJidyikE2Ay4Une0FybunKRgRcsQOw2xGIBxqRjLGQzwdDbUgLozeePQdjPzD0D6r/Fd5BMb3J4mOGvwsOJes2EVt9B9+qxYqD9mFB8d8luA13tPAgOpJhwuIXB5KylUTIdmwApZPESYj3kBNqoGVNi/BXANighphS4OrghRhBk5ZxPda
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a05600c290500b0040ef95e1c78sm505947wmd.3.2024.02.09.04.32.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 04:32:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Luc Michel <luc.michel@amd.com>, Zhao Liu <zhao1.liu@linux.intel.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [RFC PATCH 0/7] hw/qdev: Split 'wiring' phase from 'realize'
Date: Fri,  9 Feb 2024 13:32:18 +0100
Message-ID: <20240209123226.32576-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

Various issues related to implementing dynamic machines have
been documented in [1].

We are trying to understand what means "a qdev is realized".
One explanation was "the device is guest visible"; however
many devices are realized before being mapped, thus are not
"guest visible". Some devices map / wire their IRQs before
being realized (such ISA devices). There is a need for devices
to be "automatically" mapped/wired (see [2]) such CLI-created
devices, but this apply generically to dynamic machines.

Currently the device creation steps are expected to roughly be:

  (external use)                (QDev core)                   (Device Impl)
   ~~~~~~~~~~~~                  ~~~~~~~~~                     ~~~~~~~~~~~

                               INIT enter
                   ----->
                         +----------------------+
                         |    Allocate state    |
                         +----------------------+
                                                 ----->
                                                        +---------------------+
                                                        | INIT children       |
                                                        |                     |
                                                        | Alias children properties
                                                        |                     |
                                                        | Expose properties   |
                                INIT exit               +---------------------+
                   <-----------------------------------
 +----------------+
 | set properties |
 |                |
 | set ClkIn      |
 +----------------+          REALIZE enter
                   ---------------------------------->
                                                       +----------------------+
                                                       | Use config properties|
                                                       |                      |
                                                       | Realize children     |
                                                       |                      |
                                                       | Init GPIOs/IRQs      |
                                                       |                      |
                                                       | Init MemoryRegions   |
                                                       +----------------------+
                               REALIZE exit
                   <-----------------------------------                        ----  "realized" / "guest visible"
+-----------------+
| Explicit wiring:|
|   IRQs          |
|   I/O / Mem     |
|   ClkOut        |
+-----------------+             RESET enter
                    --------------------------------->
                                                       +----------------------+
                                                       | Reset default values |
                                                       +----------------------+

But as mentioned, various devices "wire" parts before they exit
the "realize" step.
In order to clarify, I'm trying to enforce what can be done
*before* and *after* realization.

*after* a device is expected to be stable (no more configurable)
and fully usable.

To be able to use internal/auto wiring (such ISA devices) and
keep the current external/explicit wiring, I propose to add an
extra "internal wiring" step, happening after the REALIZE step
as:

  (external use)                (QDev core)                   (Device Impl)
   ~~~~~~~~~~~~                  ~~~~~~~~~                     ~~~~~~~~~~~

                               INIT enter
                   ----->
                         +----------------------+
                         |    Allocate state    |
                         +----------------------+
                                                 ----->
                                                        +---------------------+
                                                        | INIT children       |
                                                        |                     |
                                                        | Alias children properties
                                                        |                     |
                                                        | Expose properties   |
                                INIT exit               +---------------------+
                   <-----------------------------------
 +----------------+
 | set properties |
 |                |
 | set ClkIn      |
 +----------------+          REALIZE enter
                   ---------------------------------->
                                                       +----------------------+
                                                       | Use config properties|
                                                       |                      |
                                                       | Realize children     |
                                                       |                      |
                                                       | Init GPIOs/IRQs      |
                                                       |                      |
                                                       | Init MemoryRegions   |
                                                       +----------------------+
                               REALIZE exit       <---
                         +----------------------+
                         | Internal auto wiring |
                         |   IRQs               |  (i.e. ISA bus)
                         |   I/O / Mem          |
                         |   ClkOut             |
                         +----------------------+
                    <---                                                       ----  "realized"
+-----------------+
| External wiring:|
|   IRQs          |
|   I/O / Mem     |
|   ClkOut        |
+-----------------+             RESET enter                                    ----  "guest visible"
                    --------------------------------->
                                                       +----------------------+
                                                       | Reset default values |
                                                       +----------------------+

The "realized" point is not changed. "guest visible" concept only
occurs *after* wiring, just before the reset phase.

This series introduces the DeviceClass::wire handler within qdev
core realization code, and convert devices using the implicit
wiring to using that explicit handler.

QDev API assertions patches will be posted later as another series.

Thoughts?

Regards,

Phil.

[1] https://lore.kernel.org/all/87o7d1i7ky.fsf@pond.sub.org/
[2] https://lore.kernel.org/qemu-devel/20231127052024.435743-1-gustavo.romero@linaro.org/

Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: Markus Armbruster <armbru@redhat.com>' --cc '
Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>'
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@csgraf.de>
Cc: Bernhard Beschow <shentey@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Cédric Le Goater <clg@kaod.org>
Cc: Luc Michel <luc.michel@amd.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>

Philippe Mathieu-Daudé (7):
  hw/qdev: Introduce DeviceClass::[un]wire() handlers
  hw/input/pckbd: Connect i8042 GPIOs once mouse/keyboard are realized
  hw/ide/cmd646: Configure IDE bus IRQs after realization
  hw/ide/sii3112: Configure IDE bus IRQs after realization
  hw/ide/via: Configure IDE bus IRQs after realization
  hw/intc/mips_gic: Initialize IRQ array once device is realized
  hw/misc/mac_via: Have VIA1 child access parent IRQ once realized

 include/hw/qdev-core.h |  8 +++++++-
 hw/core/qdev.c         | 21 ++++++++++++++++++++-
 hw/ide/cmd646.c        | 12 +++++++++++-
 hw/ide/sii3112.c       | 10 ++++++++++
 hw/ide/via.c           | 10 ++++++++++
 hw/input/pckbd.c       | 38 +++++++++++++++++++++++++++-----------
 hw/intc/mips_gic.c     | 11 +++++++++--
 hw/misc/mac_via.c      |  9 ++++++++-
 8 files changed, 102 insertions(+), 17 deletions(-)

-- 
2.41.0


