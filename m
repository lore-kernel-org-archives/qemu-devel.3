Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98901C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsS6-0001ZP-F3; Tue, 13 Feb 2024 08:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsRy-0001Wk-Fl
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:03:50 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsRv-0005yg-HZ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:03:50 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d0512f6e32so60826431fa.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707829425; x=1708434225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vDDw2/aQZ8ggZU/OmceNEX0ZhQCmGtQNSBSFooIhLVI=;
 b=EIi0nu4SBHfXo54Wrk8sk+yFdX6mH6YiflCbKxR0wyqEhq+YXNSbqw47Ss91DEoYB0
 zMq6AnOaXWIeidbXV/a8Nll8bOW47A2pyhV+yod1RLggeKQTmnfJENHkttAUoxcjNLSB
 z+QxRqGowDbXuBRBMt8WjTUo5aubqDUlyr8XlDlNHisK0gJjUqrfjO2s4lYH0THsaP3j
 oWk359z5xAnUA94kWuM48vkVgyxMbNZYYAQThpkSqcx4vMiBG2PhPJxdwBZVULdkga0M
 h9LCXC50EQHpZ9fzZgV6hvUqPrWJ3+E+lWqkYiGCSMIVIpCD4+olzoWTWhZJDtNlLRH9
 TR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707829425; x=1708434225;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vDDw2/aQZ8ggZU/OmceNEX0ZhQCmGtQNSBSFooIhLVI=;
 b=wKzk4zPKY7+3hOq/B1vpufiCdaIeznmbI038EyTu3rUmNnOASZWgli1Cru1qSue+Ym
 stEF/vAHJ3bzccjbxdkYPIo6aSL0MkyVPf8ufv2VPIpR4KMWlj+1s2T76WPFPcwFDvAO
 GSDmJ5UrPugywQT9xuSKnWI7kvlq6o39Pl6SOGWucNApX6E4oatS0M6yirA6eMqDuvL4
 EBzK4N16yiFazRR1I5sjesKVwb6KezVTM5lnG1hyjw9CtqKPPZz+HeBE2uJBEizEQRbV
 X2CSy37qxc8ntdXkCWNN83kcwJ2oi3xjegWmJ5o/5PUPuIs5gUgoeeUTBfCTOSRLieaZ
 cBrg==
X-Gm-Message-State: AOJu0YzjzCPUAOY7GOOUdcCqVZL6NqJYaZDN0Qr7mb8HOLVyfSXfQdFl
 nR9DLbYQGXxatHI1aYvYc7o6LFHEhCYZjvkExBo+mqvvZ2grx3cSTKwq2PdzC10fhMNXcd+IdG+
 4
X-Google-Smtp-Source: AGHT+IFF9GbNw/cB9detBb+ybLYuuyLXG/5QY5sX4sXInu4qJXQ+F1vEi7Ma7KvHWwV2hOOFR201qg==
X-Received: by 2002:a2e:3603:0:b0:2d0:f13a:cad2 with SMTP id
 d3-20020a2e3603000000b002d0f13acad2mr4867450lja.1.1707829425289; 
 Tue, 13 Feb 2024 05:03:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVy4AuLSY+8kKVLTUSpWQ1K0ajfft860050lgMCPs1/sVHVUsdQHv4hOKTMOrVll4lmwLka2keuzPsH/wv0w9QrS8J/+o2JRWrHz/1W0ZnL914FOgAmsdZytV5oakcUlctjrA06Z4oKOMNo19y1CeFdfLKxR7x43PIX+efQWDmId7xwb4o0FGx1AKXoLLIf9+lV8C5HKgERoOhXSeMZqETTGzXERTVN7q9YxPhqNjSEyeRySAWi7h3R9unabgnKAirDpfyfiGSGbolnsyEjoGNLZ0oblref3z38SExzpTdP08a+FsG7y4WzAo86Mkkc7ke/pQOVBjk=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 bd27-20020a05600c1f1b00b00410d3b8c4c1sm6342803wmb.31.2024.02.13.05.03.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 05:03:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 00/12] hw: Strengthen SysBus & QBus API
Date: Tue, 13 Feb 2024 14:03:29 +0100
Message-ID: <20240213130341.1793-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

Missing review: 4, 12

Since v1:
- Addressed Zoltan review comments
- Addressed Mark suggestion
- Added R-b tags

Hi,

This series ensure following is called *before* a
device is realized:
- qbus_new()
- sysbus_init_mmio()
- qdev_init_gpio_in_named_with_opaque()

and these are called *after* it is:
- sysbus_mmio_map()
- sysbus_connect_irq(),
- qdev_connect_gpio_out()
- qdev_connect_gpio_out_named()

Patches from v2 enforcing these checks will be posted
in a separate series.

Philippe Mathieu-Daudé (12):
  hw/ide/ich9: Use AHCIPCIState typedef
  hw/rx/rx62n: Reduce inclusion of 'qemu/units.h'
  hw/rx/rx62n: Only call qdev_get_gpio_in() when necessary
  hw/i386/q35: Realize LPC PCI function before accessing it
  hw/ppc/prep: Realize ISA bridge before accessing it
  hw/misc/macio: Realize IDE controller before accessing it
  hw/sh4/r2d: Realize IDE controller before accessing it
  hw/sparc/sun4m: Realize DMA controller before accessing it
  hw/sparc/leon3: Realize GRLIB IRQ controller before accessing it
  hw/sparc/leon3: Pass DeviceState opaque argument to leon3_set_pil_in()
  hw/sparc/leon3: Initialize GPIO before realizing CPU devices
  hw/sparc64/cpu: Initialize GPIO before realizing CPU devices

 include/hw/rx/rx62n.h |  2 --
 hw/i386/pc_q35.c      |  6 +++---
 hw/ide/ich.c          |  6 +++---
 hw/misc/macio/macio.c |  9 ++++++---
 hw/ppc/prep.c         |  2 +-
 hw/rx/rx-gdbsim.c     |  1 +
 hw/rx/rx62n.c         | 17 +++++++++--------
 hw/sh4/r2d.c          |  2 +-
 hw/sparc/leon3.c      | 17 ++++++++---------
 hw/sparc/sun4m.c      |  7 +++++--
 hw/sparc64/sparc64.c  |  4 +++-
 11 files changed, 40 insertions(+), 33 deletions(-)

-- 
2.41.0


