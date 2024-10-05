Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7990CF887B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 10:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx1ce-00034a-FO; Sat, 05 Oct 2024 06:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sx1cc-00032V-5d; Sat, 05 Oct 2024 06:02:46 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sx1ca-00083X-Iz; Sat, 05 Oct 2024 06:02:45 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a93c1cc74fdso497589866b.3; 
 Sat, 05 Oct 2024 03:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728122560; x=1728727360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=in0VHzxFSDDDrMbuRFYfjXR4tb1sUlmcuzElyepMMf0=;
 b=DXflmIK4x/WKEQ3ZNLKrCb4cj07thtW+zHse976z9RX6wIBvJ2I9Zq73l8Yksp042V
 zJwngfN23wHXybIQWNJpIQBiekgd7pvb7HgANnUKGW1dfqqhfm5GFxysOVeyFoFAObyT
 aEFVhMMNVqdYz2CpuT8mAwY0ybZj54Aji2YsS8YUdJC8C5JZ2TXVzJI2E1EUhUaPdvWu
 ScrNHKupz/HfuxENyngVV3ypi1nsAle2uNl4XAhTk27yffo2OZB95Ja/Ku9roQXhdiv4
 V9GgH6p2Pp+tG5DPrvKBZSJ38Vko2ofs6Nr9Gwu18gtXMmlfuLmAQnltrlkhFkgTtn7x
 kbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728122560; x=1728727360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=in0VHzxFSDDDrMbuRFYfjXR4tb1sUlmcuzElyepMMf0=;
 b=X+n7Ln3763iUcOETf5HjuejYUKHFQrsWj+Ks30coUwyjiIfH2/S2N/nsjq5njwutMy
 YLpLj+iHIsci1l0ocNOT5E4MNczPwvAO05csNm/kVMDbejf8qw4CmQM//DJOaD+2ypTD
 sn8Eh+99AFcncHtZKvhEILeDf5lUSwzC49Vasc2OQ9+LsbKUZNijhBvI4PSOJqwNv/FG
 66tt1DUFl8ZOjWG7OxdFdZUkPAurysQiI4O6PV9cz8mIlUTCVN9jc6mHc3L8bEP1UYoi
 fJUzPAnVxrp2tO+FZOyIM5dHaLju6gMQxORhF35lat2ck+NhVpjiqTsFMlgs2ByUrAac
 qR4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaVXPqEd0TzvrEjTcEjwe7TqmApPEhi30z4IubVdKrR/my+d9rB3iyY6AyYMIOD/fx/dP+syJpWjs=@nongnu.org,
 AJvYcCV8jRiIGFAejCejmdkuO4ptri3vAuF3B1VS8ilevn7k7WgTUB42+QQvW3YknBSW6c0jtyze5hXCaw==@nongnu.org
X-Gm-Message-State: AOJu0YyRHnNaA6tQAwvVoGq1vBGcOpcMDVjighmd4bojkkfVH7YBAZLq
 xMfi4/uusrB0S8WCVXLQ1eMuql8OFE5j8k209wLT/TGWlui5m1moHGG/cw==
X-Google-Smtp-Source: AGHT+IHwBs8wvZQJ8BWYNJLmg1r+u69Iw9N3gdDB/gLrljFfP3IIqVC96XNMrtiJfZRz7Hiar2zFbg==
X-Received: by 2002:a17:907:6d26:b0:a99:35ae:3f0 with SMTP id
 a640c23a62f3a-a9935ae096emr163791066b.59.1728122559988; 
 Sat, 05 Oct 2024 03:02:39 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9932bf8a90sm99894166b.50.2024.10.05.03.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 03:02:39 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v2 0/2] Reuse TYPE_GPIO_PWR in ppce500 machine
Date: Sat,  5 Oct 2024 12:02:26 +0200
Message-ID: <20241005100228.28094-1-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Just like the ARM virt machine, the ppce500 machine implements a=0D
"gpio-poweroff"-compatible device tree node. So far, the implementations=0D
aren't shared, and in addition, the ppce500 machine uses qemu_allocate_irq(=
)=0D
which leaks memory. This series fixes both by reusing TYPE_GPIO_PWR.=0D
=0D
Testing done:=0D
* Build qemu_ppc64_e5500_defconfig in Buildroot, run it in the ppce500 mach=
ine=0D
  and issue the `poweroff` command. Observe that QEMU is shut down cleanly.=
=0D
=0D
[1] https://github.com/shentok/qemu/tree/e500-fdt=0D
=0D
Supersedes: 20240923101554.12900-1-shentey@gmail.com=0D
=0D
Bernhard Beschow (2):=0D
  MAINTAINERS: Add hw/gpio/gpio_pwr.c=0D
  hw/ppc/e500: Reuse TYPE_GPIO_PWR=0D
=0D
 MAINTAINERS    |  1 +=0D
 hw/ppc/e500.c  | 16 ++++------------=0D
 hw/ppc/Kconfig |  1 +=0D
 3 files changed, 6 insertions(+), 12 deletions(-)=0D
=0D
-- =0D
2.46.2=0D
=0D

