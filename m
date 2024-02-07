Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9831AC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 09:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXdzR-0005Lc-Ln; Wed, 07 Feb 2024 04:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXdzL-0005Gq-EX
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:13:04 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXdzI-0008G6-49
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:13:03 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a3856588ba8so51963466b.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 01:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707297177; x=1707901977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rvshgmdAA5Z9fVAd8EoKdPZKSfsy5+D49z9WZdIL5PU=;
 b=fn0IJFAy4hz2NvFbjIl20vS5YaFXFFj9U0ENHLDX+gKUn6y9hN1Y5xeKoJItWpl7Af
 5SgA5gaC2w3EZu5kM3JPR7H4yFeoW0q1hKMxIwr7HbabQ5FJQOoaHLtqhw1fmEVeMNMn
 uFbE0rYu524gBvz0jAmsc1+wEbMnECDHZWfgDf0eBC/4doYT8+MYmfIRK87lV4jYStFl
 sUSWdbpXzCf+UZQ4rlMh13tloJ3FTOhmzi0pvKsMCdPywHO1xJZvS1jjhWoiUqoST8Ak
 eZHSVIYkpNdOlCiX35DWVLRC3MiWlszWa0zQQfcARip8k5TXhgQga/jxO4y3N5tm/rba
 XvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707297177; x=1707901977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rvshgmdAA5Z9fVAd8EoKdPZKSfsy5+D49z9WZdIL5PU=;
 b=I3F6wPzL7V+sWKjVhdS7xuMBzjR/3LjFTzcPl5uFPp1WduBWbKsLb0OR0QnYyyq5Zx
 jXNEJl70Co9jprEmRg1fzA1NwxPLlDWwtWabqizFmkRjInaMYTk2sROCc/Aj8RH+b+it
 +Tsf+1uWz58sgoP9uuOSCwVZg7rNZpqzfG9kQab7ZTA2S8nK+2EbybbXnRao10tWoQn/
 rBuXBeiYWSHIPPUfMt4ruduTUNWz6wAT2EsW5k2PmhKARqa69Zo+EWSqZSDUKVYW7etl
 iLugM6q5QRKsr0LanqA4fd30yCAsAMZuRHyqh4xZeVfzRGuwU+DKKLZ8TtmKcAptZDBC
 z9Mg==
X-Gm-Message-State: AOJu0YyKTws22/E3MdLzKEB2e4FnOkUxFGFxAJRugE7bUYZWUEEq45wG
 esU2NVEVkk4Cc2MQu8noEeGKG4nSDi3oZ6lfItfT8TsD7Z42F/pQSAUksM4rq/H1WLALZqd0KSa
 4
X-Google-Smtp-Source: AGHT+IHNMYZk+V/O6fQf41F0iFdaCOv7uI2VzrZvI9FKwP1lujtaiauR35LWSG5wbnCAyzQey1d6NQ==
X-Received: by 2002:a17:906:41:b0:a37:1e9a:c549 with SMTP id
 1-20020a170906004100b00a371e9ac549mr3500501ejg.49.1707297177466; 
 Wed, 07 Feb 2024 01:12:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWCe3UDrq6s5tcsXGZgNF5pNKpgM13WOo4pOhE6uA/m5wWnknHG5Bn0PzwUqZ5rvZdjz5IL//K/DN08Q4dI8mPjpca5Dxzo1trsn3CITGZofsL1S5yhi+onC5ex0kIRqi3ig9xmWVhj6AulTPg0AbEdoHjV40LEljG535LB+5YyxQ4AuYOanpl8QPGxmy9LxG4ZYPah0rIdsLjU5T//F4JQ6CSETgP9vXRWvcdaq5IQecbwwdWVQ3Q=
Received: from m1x-phil.lan ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a170906b30b00b00a35920de35dsm521234ejz.188.2024.02.07.01.12.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Feb 2024 01:12:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/4] hw/pci-host: Build ppc4xx_pci.c/ppc440_pcix.c once
Date: Wed,  7 Feb 2024 10:12:50 +0100
Message-ID: <20240207091254.1478-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

v2:
- Squashed 2 patches (Zoltan)

v1:
- Move ppc4xx_pci.c/ppc440_pcix.c from hw/ppc/ to hw/pci-host/
- Build them once for all targets

If it is convenient for PPC maintainers I can queue
this via my misc-hw tree.

Thanks,

Phil.

Philippe Mathieu-Daudé (4):
  hw/ppc/ppc4xx_pci: Remove unused "hw/ppc/ppc.h" header
  hw/ppc/ppc4xx_pci: Extract PCI host definitions to
    hw/pci-host/ppc4xx.h
  hw/ppc/ppc4xx_pci: Move ppc4xx_pci.c to hw/pci-host/
  hw/ppc/ppc440_pcix: Move ppc440_pcix.c to hw/pci-host/

 MAINTAINERS                        |  4 +++-
 include/hw/pci-host/ppc4xx.h       | 17 +++++++++++++++++
 include/hw/ppc/ppc4xx.h            |  5 -----
 hw/{ppc => pci-host}/ppc440_pcix.c |  3 +--
 hw/{ppc => pci-host}/ppc4xx_pci.c  |  3 +--
 hw/pci-host/ppce500.c              |  2 +-
 hw/ppc/ppc440_bamboo.c             |  1 +
 hw/ppc/ppc440_uc.c                 |  1 +
 hw/ppc/sam460ex.c                  |  1 +
 hw/pci-host/Kconfig                |  8 ++++++++
 hw/pci-host/meson.build            |  2 ++
 hw/pci-host/trace-events           | 12 ++++++++++++
 hw/ppc/Kconfig                     |  3 ++-
 hw/ppc/meson.build                 |  3 +--
 hw/ppc/trace-events                | 12 ------------
 15 files changed, 51 insertions(+), 26 deletions(-)
 create mode 100644 include/hw/pci-host/ppc4xx.h
 rename hw/{ppc => pci-host}/ppc440_pcix.c (99%)
 rename hw/{ppc => pci-host}/ppc4xx_pci.c (99%)

-- 
2.41.0


