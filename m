Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1723C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9oNR-0004nU-OB; Tue, 29 Apr 2025 13:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1u9oNP-0004lo-Mj
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:04:11 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1u9oNN-0004lI-VM
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:04:11 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b1a1930a922so3460588a12.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745946246; x=1746551046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z4EQlovBEYkCCeIWpZES84DVOSls20btDvbRWFk1AZk=;
 b=aC6uPakoXvYoOVZTK4C5Yzusd+tMzMWMge4MRf53SAJgmlA8QfeLvjtNH4ulkMTUW+
 LphKvpglV7AH1XWeSU3J1ka4zqZLxmB5bCh/t0rlWH0koJncmbe8R1Nyt7hS3KH/6VE+
 ml27lSwEHyiMCWWJGwdjn1UN/10GLiQdUjkTi0q+BQriAaz7+eIFuKIrIro2g/X+oL5F
 Qn3TwlGZvjsjpI/KMnjSL/ztiXREmneaKROdirFiwEfDvgEVkDkHiUOsiPFb1B0AXZLX
 XYkQPDHnyYyfYIZDb19GGIvXeJCLP3xioEQi900fK/GogVMPPaETen5VO8I5jZIklwuz
 24Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745946246; x=1746551046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z4EQlovBEYkCCeIWpZES84DVOSls20btDvbRWFk1AZk=;
 b=f5swWkMoxfxX8OojZeYcbROD7SY2oMbU/6f0kHgqbh1j9bXnHPR4XNJ5PbbdZ9cKq1
 CI6rYklt/VVS0g+NpXjwYxQgDkvtstCVQ6Au3kgbslmUuYuz8Q36unHhmMqOFkhVN1pu
 PHZ/zVPhBYV6I2qu9JokOGu3U0s0Ky4GF7GnVKsuup5v3ktO7fjMjcrlvM5Ri9Xl1oEE
 oyLxLmdstf9kK+TpZB7jzCbZd3SqD8TOrRpZPW9TlzXRAbpse6DiSSPptLioBydAw4Rs
 96A4QPiJgUAYC2iW2e5J8kBj47Fqoop8BKy3s4Unt/0RVyLQaHJQeyRlQLxfExR2yOck
 HPCA==
X-Gm-Message-State: AOJu0YxazFVlD/M3RM0QQuEP6ldRNk3Wa/9SimJMhA12noBwddk5miKj
 ki+92vzy+LYqSzId1T78kz8oXpqmITQnDNHIfKBkJFdnHKjIR+FDko9hjg==
X-Gm-Gg: ASbGncuJIWkWh6XnXGXQppYd4ENbv7PvIVSbTp6lL3WcAF9i+12gFs0X6ZXuyeLHQE9
 2IWJqvtpzC+xurD0xy1fnBwtMgU7X34VrC/gSakAltE4TqZpxRQijB80NIrYntBuaovQeDMfC/Y
 uG4XgL6GTJPzStt9c6n8lzLlOiUT2e177++KkjE70iuCiB3UTQDTcjHBVsiNhbkx8YhuXFZ1er2
 NqXnruHNI2q4mo0To69x6Da/nMESJtEM9IYVcBzX0NZ1X5a6+rqA7nr+h8CJ3aGmRRxwloFJKtH
 M435uSIJw8swMcE+61gKSHGx2z/gv2pWQTjS7RAUpdruFASV
X-Google-Smtp-Source: AGHT+IGyX9Ifrqi8yKrnYNwBmpi6mjJEmykqNz5ZvaCAJTWWDKkSxAKOlUvQ4C8SW9oN3CsRLatf5A==
X-Received: by 2002:a17:90b:254d:b0:2ee:f076:20fb with SMTP id
 98e67ed59e1d1-30a23de9182mr5102464a91.17.1745946246264; 
 Tue, 29 Apr 2025 10:04:06 -0700 (PDT)
Received: from blackjackal.. ([2409:40f4:2012:c135:ab3b:a163:4eeb:c538])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef03bb26sm12678043a91.6.2025.04.29.10.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 10:04:05 -0700 (PDT)
From: Rakesh Jeyasingh <rakeshjb010@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, thuth@redhat.com,
 balaton@eik.bme.hu, rakeshjb010@gmail.com
Subject: [PATCH v5 0/2] GT64120 PCI endianness fixes and cleanup
Date: Tue, 29 Apr 2025 22:33:52 +0530
Message-ID: <20250429170354.150581-1-rakeshjb010@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=rakeshjb010@gmail.com; helo=mail-pg1-x535.google.com
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

Changes since v4:
1.Introduced needs_bswap() helper for clean endianness logic
2.use the existing pci_host_data_le_ops.read/write from hw/pci/pci_host.c

v4:https://patchew.org/QEMU/20250331184820.34673-1-rakeshjb010@gmail.com/

Rakesh Jeyasingh (2):
  hw/pci-host/gt64120: Fix endianness handling
  hw/pci-host: Remove unused pci_host_data_be_ops

 hw/pci-host/gt64120.c      | 82 ++++++++++++++++++++++----------------
 hw/pci/pci_host.c          |  6 ---
 include/hw/pci-host/dino.h |  4 --
 include/hw/pci/pci_host.h  |  1 -
 4 files changed, 48 insertions(+), 45 deletions(-)

-- 
2.43.0


