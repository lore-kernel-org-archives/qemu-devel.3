Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12935D59F5E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8l2r-0008Mh-Ih; Wed, 06 Nov 2024 13:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8l2p-0008MQ-Gm
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:46:19 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8l2n-0000u6-2W
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:46:18 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9ed49ec0f1so13035866b.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730918775; x=1731523575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XmhWRZXxp83O2InQlFonyaildfIoabED880hXmnDZ7g=;
 b=j47ycYpWQ3YhFePX+vwCAV89wIhbEs/zkAv8QjGPSxv6Peg2yZe197e6GsV0eUJVwZ
 BHksVttCG5SzHlxa9PAK67g6lt2Ivwh1fmblLKUhOZZcuxFOoJjaarzYSQ6XQHP6x8NK
 g4ZX+uLTTcUUP4RzkWV78oL/XHEd31hmaSDBaKpSqlf2MKVF2B2xoq8Pv7+Pk+yw9QGV
 JVm1s8oBZZuD+XUqEouPuL/pENNxKF3vkI/FsJ5iz9IYJHgwp1jE+ffngBsqw2QxlJNp
 DnoYWqgol+jIaxIGQjHF+A9X053+34YKNeuCxljUaT3NC8+etbgTiLLbvlyw4Zaq6E8y
 v+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730918775; x=1731523575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XmhWRZXxp83O2InQlFonyaildfIoabED880hXmnDZ7g=;
 b=UUpoNSK4PNZa5Nb1GzntTO/6yj9j7Ic72ao/v53BVZWbqDDmX4mhuypL1JtRZLFJZz
 pkr9Vsr1LyL6wumj43tBQ5jeBMuXUtSLgaiyXtpvFRceOduDLBbapmKaMxo1NDZj2FIq
 2PUHTeju5E5UvEOTfKMFCh1hOntBo7WWc+gVNWVD7KiB4Tp7oRuLF2OFZ77vSA/QO+UW
 zkb39TkYXtHI9fmOCFJBRzJnN2sHEDVp4mB6IMV/5UaEVcISdt+44eoVypstz/TZZ0LZ
 tBhj87mbHz0YxvYQS1UJAvrwSIM0blnYRv7LRI6UU+DdYD+SCf8y8a0K0cfHAcfS2RBE
 7gEA==
X-Gm-Message-State: AOJu0YxwRHhnDHmlGQi9bOEKMMKGU7ZBDERna/n7Dyuz3I9xuusont0Q
 5iAb66J8M5MdHCYb8ITlr8x0alj8Hhqhj0uxRDm4XDQb/5c9Kg1mC+o/pnU8rqnRElUMExV0PAd
 j
X-Google-Smtp-Source: AGHT+IF3aqIXCddVzxdTkCqTIT+QsXKTqG9THVwgPVGSC1f3F5fPhTl2w+fvLxGmqJxqNY6o2pGfbg==
X-Received: by 2002:a17:906:f34a:b0:a9e:c696:8f78 with SMTP id
 a640c23a62f3a-a9ec6969260mr306265266b.51.1730918775010; 
 Wed, 06 Nov 2024 10:46:15 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb16f8c5asm317692666b.90.2024.11.06.10.46.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 10:46:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anthony PERARD <anthony@xenproject.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <huth@tuxfamily.org>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Paul Durrant <paul@xen.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] hw: Mark architecture specific devices with specific
 endianness
Date: Wed,  6 Nov 2024 18:46:07 +0000
Message-ID: <20241106184612.71897-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

When a device is only built for an architecture built for
a particular endianness, we can simplify the device to not
use the "target native endianness" definition and directly
use the proper target endianness.

Philippe Mathieu-Daudé (5):
  hw/i386: Mark devices as little-endian
  hw/tricore: Mark devices as little-endian
  hw/m68k: Mark devices as big-endian
  hw/openrisc: Mark devices as big-endian
  hw/sparc: Mark devices as big-endian

 hw/i386/kvm/apic.c              | 2 +-
 hw/i386/pc.c                    | 4 ++--
 hw/i386/vapic.c                 | 2 +-
 hw/i386/xen/xen_apic.c          | 2 +-
 hw/i386/xen/xen_platform.c      | 2 +-
 hw/m68k/mcf5206.c               | 2 +-
 hw/m68k/mcf5208.c               | 6 +++---
 hw/m68k/mcf_intc.c              | 2 +-
 hw/m68k/next-kbd.c              | 2 +-
 hw/openrisc/openrisc_sim.c      | 2 +-
 hw/openrisc/virt.c              | 2 +-
 hw/sparc/sun4m_iommu.c          | 2 +-
 hw/sparc64/sun4u.c              | 2 +-
 hw/tricore/tricore_testdevice.c | 2 +-
 14 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.45.2


