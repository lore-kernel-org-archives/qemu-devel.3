Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC99606A335
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gg5Nz/sj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWAlQ-00031f-JS; Wed, 25 Nov 2026 06:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWAlP-00031A-9W
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:02:11 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWAlN-000509-LC
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:02:11 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4a357b1c649so3252642f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795604528; x=1796209328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gqc+ueHs85xeCIkFazb+JV9F0oLwK5pxX10D5u3droY=;
 b=Gg5Nz/sjjdFaYQS6kENih5lc8ORVuNuTy6xpsS70zZAToxWcztiH3o3NoCBs9jsFBv
 51Z8+7xda7bZuTYM87jJqyMEJNZOswFAHwOwbeOLObHfXlgmycOKN4v7KAhO3wO9ndbc
 Yf1JY4Niw7FzZFVVBtBWUvzsKaZ/D0NwLg5KvIAloW18yunqvVse9YfibWzEbaqaTkC2
 QPTm7nG5p9f5oTrKZWrLqEezpWozYI4N7uKqf3pPTrshyFPMN6my9d6xSC09zNfvvQXU
 s1JTwXETPjKClGrI3QcScmIXuA+mkZveT2L5BhdaeAEaE0ZLte7CoH6LLSmmXAwTBee2
 FU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604528; x=1796209328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gqc+ueHs85xeCIkFazb+JV9F0oLwK5pxX10D5u3droY=;
 b=Ta3PlMu8kOYujvh46DMiik7Ie3TdX5ClATEzJ31Bz1mzrSsCJS41c/TmSwKAR5i349
 9kGfzJT0mHrhDoPNFh4o0h6ODrhMkXRVcecesnEEQwdj4eppy26rb7wmo2OHWC/2UzwP
 s/C8KR+9nm/nC7QW/jQozWKBebNulh+XKsdo0SP3Y5opzgLc3prDRK5JsiOa9cNjrS8t
 /PNXKzjWTz8/aKeJgX/uakI5EpVhjcrEXXu9fahgPteQ2+OdLe8W2YiNtFjqrcamVDeF
 nN/2n3pEp5DLf9db3Ta8frz74Eif8RkW42FazH/iaAQduQrvhTEuE954NCPY5sx11Dc+
 Wv6g==
X-Forwarded-Encrypted: i=1;
 AL+hErGyI9rXQfvx/8zflzf8cEMvA5+ijQYyyLKL387Rh5zjUvOeHKo85tdQvZ23mjksv3B3SmybN2RVoWGY@nongnu.org
X-Gm-Message-State: APuU4Z/0Vn5D3Yzt4Oln93Qz4gSUSKO9RRTBAyT42SdTUKU2ubK3t2mN
 wgNuhOiJ1zN8I9OA8o+5hce3Na7wer+p+R031dHDnkTwLZoTgPzJR4Kr
X-Gm-Gg: AZFdTZefQyZTCLh+DCd3HLeX6kCCulilouwW1XhGplB1IW6H2RpAi/O1ezwY6UNFLUs
 N3HssabT8JzJ+m3bIyGkNWCpn3lbQKjjoCY49cWDBcELkRy+BO/Rk7VlgRm6nwEBDuhcSBDiXxV
 LllXJTd/BSBun1We8Ohh3Cb/WYu2wY5hlJ2Phsd8i0Q3iGcynyv++IMz+ukcXiDTJiQNscGEDBT
 upF5rZbh5LPUdi/VKyT1m/RUBYYxv64GDNYDJhUbChsSLrrLnd5x0br8oLsgMNlQTBC4Sm3qJ7/
 cmLyzdmpCq/tfssaH31K4nwSb0xDDgE9NVBR/jHbTSWp4Js59EQinYG0MWmAcSplBVY6DAt2Tqg
 0waSPgi0uWd8BsKxjvTHs/wtzNR/p9mMlTkyZAEAi8T1tKA0z8w1HegkIrmGnS/M97Bfbv4Ur/Q
 jiS0N6rg+IqneQ53tVXRiBlBOE4u0nds+hPH1909FyCUvXVjO9BCG3Tu1QGgunAQng0oLR5OHYi
 6APjz9VyKBQFKwLiRUYZpMgKDTIvN//MgHR5xWk501OE1tYu/+HAH8P59qt82+dPdWWH8Hmw9c/
 pm5/wAjW3qzxV5F7B352zWDkiBMu/lltvbEa2B3gpI7BMXWFyMvwl89YE9+7aBQNRD/uVISgUdQ
 FUHlls1RGEInDGL38SZo7/rC6
X-Received: by 2002:a05:6000:29d9:b0:48e:bf0:30f with SMTP id
 ffacd0b85a97d-4abb2910fbfmr24246676f8f.34.1795604527915; 
 Wed, 25 Nov 2026 03:02:07 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c340df4sm38665459f8f.55.2026.11.25.03.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:02:07 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vgarhw@gmail.com>, qemu-devel@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 0/2] hw/net/can/sja1000: fix receive FIFO corruption
Date: Wed, 25 Nov 2026 16:02:00 +0500
Message-ID: <20261125110202.471181-1-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125083350.331457-1-haseebashraf091@gmail.com>
References: <20261125083350.331457-1-haseebashraf091@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

Hi,

RTR frames carry a DLC but no payload.  Storing DLC bytes in the
SJA1000 receive FIFO makes release consume bytes which were never
stored and misaligns the following frame.

Patch 1 fixes both PeliCAN and BasicCAN handling and resets the receive
write pointer during hardware and software reset.  It also preserves
the CAN identifier when decoding a BasicCAN RTR frame.

Patch 2 contains the Kvaser PCI qtest coverage separately from the
production fix.  It covers PeliCAN standard and extended RTR frames,
BasicCAN RTR frames, and hardware/software reset recovery.  All four
cases pass:

  - /x86_64/kvaser-pci/rtr-fifo
  - /x86_64/kvaser-pci/basiccan-rtr-fifo
  - /x86_64/kvaser-pci/reset-fifo
  - /x86_64/kvaser-pci/software-reset-fifo

Changes since v1:

  - Handle RTR frames in BasicCAN as well as PeliCAN.
  - Preserve the CAN identifier when decoding a BasicCAN RTR.
  - Add BasicCAN RTR qtest coverage.
  - Unmap PCI BARs before the system reset qtest.

Thanks,
Haseeb

Haseeb Ashraf (2):
  hw/net/can/sja1000: fix receive FIFO corruption
  tests/qtest: add SJA1000 receive FIFO coverage

 MAINTAINERS                   |   1 +
 hw/net/can/can_sja1000.c      |  12 +-
  tests/qtest/kvaser-pci-test.c | 258 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   1 +
 4 files changed, 270 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/kvaser-pci-test.c

-- 
2.34.1


