Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC4FC624D3
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 12:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2pLx-0004La-4I; Sat, 05 Sep 2026 08:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1x2pLv-0004Kr-Fv
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 08:18:35 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1x2pLt-00019p-QN
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 08:18:35 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd82be878so351815e9.1
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 05:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788610712; x=1789215512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7tRBabswupRFvrvdHEi0e+0gjy/CDJyaMjOCL1Iau54=;
 b=UWGHAdsWx/FXfJYmYFpKZyPQhuh5UAaSVz92FOXV23E2UswJKqzKtLlTeNnxnM1Uba
 eH/drE+Pp12iInN6oQaYye19eNsLLB4ZgJdMtUTCVh0Bgr2GoFlrJr5c7J50CmuEBwDz
 kxa0mkI/GugO40hAKtDJ8fFAGo1eRoWCfOlqlhsn1Tn3XJI3AyWAEsUAme2Sm6bIsu9a
 UyPn8sq0u6s9zRbWHk00M/n9JBI64b25u4c0ImnbIFngaQD5mTdf6tSzLdpQJ4H9+RBN
 AjO1URbrxQWo5+xaA58yY72TjNV8s4Tp4OEbMkmo9zbYiSQHO97YURCZbyxinPjIbmqc
 n4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788610712; x=1789215512;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7tRBabswupRFvrvdHEi0e+0gjy/CDJyaMjOCL1Iau54=;
 b=IjBM0jJR7aXFSjSsNNScUVOSZaTL3YRxKFU2CCdS1cEUWjonWZwDb0DCY8fDUWQ9wX
 ggl47wXotUlI0HKfvz9/aus4q5iE+AdZ3iuz5c2CpCW9nthhBFb2vedZi9wzPWstaSIH
 r9mpyVi/4vt/Tnu7bQuyA5KlW3SOLktZBjSqlNgjO26E8asWGFi845GP6M7FJPhdcdLj
 Zx5QYu4Z5acnRLaDGlonLDSDmCZFBOc+LzXcH0MVpsILd/pmyLVenuo17VHp3Wv1HTvH
 0eOqWozFOXhRbdKAUDmzzqUjZS0i21xt2f6wcz2GFpipg0ApgHlaFI5T4YkfiLZpLvFU
 wO0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnnjK/Zz0F6GruMtL/arBd2S/5wgx4cHtHFjQvmLUaDtldCXj81vlXD9MKPcQyssWzdvG/Z6NZ5XZn@nongnu.org
X-Gm-Message-State: AFuF++lefJR3unESh5D7+jjbbaxuN0jkbMYch0HWXNeWkwZDXJ0T6nnV
 v10HyyNZSBhp4EyJCAhd4WTy8dTokXmap8aU6z5nubuGC+Cy5ouBrExU
X-Gm-Gg: AYBFou0t9dPPSbwiMvmKf8inmoL8EqnKF/pALRqUKn7mOVbVphA6NYyhI7eSHBUR3cr
 Bjd4EWlUSKhfidP+wFgZgur1adOvRxFA55t6xvpDhrKq/Zy4ENVW1s9kgmfJRAHZ9qU3u4GaH1P
 WVtKofWq+UBFxioWi75PemuGMJtKuT6kK4Fb9DBt406tyEl4k2Bsoa9dRoo0Axk3cQD6npi6PaY
 /8U0Jj7zlW7/apeXt/gCdBcIbDbrAADYeUsTaxHP4zrpOhcYima8q0AiZgcd2FSEQTy/WM5G5hX
 9NfrTU0AJZbmmeScA5pZwCudWWsN1pte9SOvtm6PMbOxDu1yXhs9WcwGGe18SSsk9KZj+WQqS2j
 w2XkbxLv6P+vqI7TNgQ6QIhRDZLu8Wefkh4expdEpghYRptP0sYfAatxBZOrLlscNFViAi9xJgC
 J9iPKwxc/f/V3tsYHkJcCnbD4k92slNEGJoAajZt9xck/nxrz+mA8ibfzDBWt71sKv7llA
X-Received: by 2002:a05:600c:c494:b0:499:d95a:41f with SMTP id
 5b1f17b1804b1-49d010c3969mr40290255e9.0.1788610711795; 
 Sat, 05 Sep 2026 05:18:31 -0700 (PDT)
Received: from AtiePC ([79.116.0.198]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f912esm234546625e9.4.2026.09.05.05.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 05:18:31 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 0/2] hw/nvme: sr-iov hotunplug fixes (assertion failure,
 memory leak)
Date: Sat,  5 Sep 2026 14:18:10 +0200
Message-ID: <20260905121812.47816-1-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As the subject suggests, in this series an assertion failure and a memory leak
are fixed when hotunplugging a nvme controller with virtual functions.

The patches are exactly the same as
https://lore.kernel.org/qemu-devel/20260805124519.30054-2-danielpaziyski@gmail.com/
("[PATCH 1/3] hw/nvme: fix assertion failure on sr-iov capable nvme controller removal")
https://lore.kernel.org/qemu-devel/20260805124519.30054-3-danielpaziyski@gmail.com/
("[PATCH 2/3] hw/nvme: fix memory leak on sr-iov capable nvme controller removal")

posted in the series at
https://lore.kernel.org/qemu-devel/20260805124519.30054-1-danielpaziyski@gmail.com/
("[PATCH 0/3] NVMe hotunplug and PCI SR-IOV fixes")

I split the patches here, as a separate series, since the other patch is
unrelated to these ones and requires a fix, and it was a mistake on my part to
put patches for different subsystems in the same series.

Cc: qemu-block@nongnu.org
Cc: qemu-stable@nongnu.org

Daniel Paziyski (2):
  hw/nvme: fix assertion failure on sr-iov capable nvme controller
    removal
  hw/nvme: fix memory leak on sr-iov capable nvme controller removal

 hw/nvme/ctrl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.55.0


