Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F237C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrb0q-0007xF-FO; Wed, 05 Aug 2026 08:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wrb03-0007mf-6p
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 08:45:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wrb00-0006cw-Ml
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 08:45:34 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4955c545a94so518535e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 05:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785933927; x=1786538727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dvva29nG9UfqB+SziYpLU8FRb8QcTUTfX5p8zrSNX3s=;
 b=E7e9jVh7XD9POPBgZf2aXm6O3M8+v3kOipCLxlBBcgdXSTMgBGLbZvEqTlzqzrUbV5
 QHix8qHdWPYxgp9YF0/bxSe47MwEd27OkRa5MTN54zRunD8VpGIe7VaCOPAN/OgKGbOa
 KQPodw+iMQVT1kdJcoV0mtUYVU6EG5vw3i5UUDGC3KN0qk2lGwbkqon4Dvi2ZeRM/tMm
 hJMqz8QkDooAymXGqmnieDZZOkL9/qEjorRqqbEokTpxGuZjiQxqxRQ3LoilQW/Erorb
 nKLL/gITPlKP5wpc0ZlBzEg6Y/7FStVftmSfGdFI2aX9OFWGzeYSgckthvitACOit4Vy
 Re5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785933927; x=1786538727;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dvva29nG9UfqB+SziYpLU8FRb8QcTUTfX5p8zrSNX3s=;
 b=aVLJtRG+BGwGDpiUmCBVBY3MgTml/ilaS2UhbmzYdFWayJfitY2vJI4VUWIMgBJuol
 XkJFZyKJU0cCj/sSjPe+bT9UZX9taGg/RLKg963GGzucMg7oftIm7i8474+Zj1GrN2nH
 X7YxwsqtWuvjJlSV9i0QglRnv39f0eIg7lEeBnNsrdYT0e5dRbSTzxABJaekOPP/HsHw
 Y/buCtpwVFkX0L1cebMjkMajkHyK79mUX0cYqqhs6djr0LpBgh14PtOHtagLkdz4qE5u
 H9i/TezJ3tyB5IGLh4gPCszgRiIiV9FQHmYnqdZXV6iB/AY0oJVWb1BXoSG81J/DwBY9
 hGiw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQlS410Eo5m9kTOfy6hCPlm6hBNAw4GuLrDL1rPqoCAJ0h+t+rkS0MOz1RTk81lCI/Iw2OYd/W/dFw@nongnu.org
X-Gm-Message-State: AOJu0YwINsaKBddRhdwGhHnF3yl73nBS7X3lklPCFE33tcgMWk0PCMcS
 mz1ioh9lRoyCdGrUmyRITdN50TRmSxlb2JvBmjRcoJEjN9+YURfEcJ8o
X-Gm-Gg: AR+sD13UtOIbCy/b1WAOo4tJsmMerLstWGICOvo6QJ+WbvVfLPmRn9ckZrT5Z112fiU
 jKIxppiRxIv9ih1Fd1GaKyQBybLDQZSzIHKubraypU3Z+5rHfMTyMWfLMMBQR9QYwCWPOMBrtVq
 icdNHH8vgcK4TlPbL0jwE0kkQFF4Fg/1RKhR7IdlVdpnDEPvdYZGT7vUhahtyZ8e/iRAqqTnArG
 K9Lpg+JZg4/4bbVPRWl00LBhX7j+VyItx3QLSrv6OA+IBKOoyik35+6hY1q+VE5Ba4GIvzwnqzZ
 6IMQNYPeVRvZa1GeH3lXnxXDS+bber05qLZq6XQV4CdJR7Kqtc0nsoeqV47Vpm2NmJqrrBrGEDI
 eQynzzIOU66+bZIBR/EOfEZ0LHs65ULdVednpRlZsIVgD3UPFubgSEV+WgeIcXU8AzEqJjtZMO5
 TbbBuCWdTGio1meumy1eGL6sUNnlybBZwYKQRIFnpZlttlALWG4dQfbJfduw4hskTmex6JX3r/p
 SvApwYcag==
X-Received: by 2002:a05:600c:3b9e:b0:496:bbce:ef with SMTP id
 5b1f17b1804b1-4994e7c3321mr49574185e9.3.1785933926594; 
 Wed, 05 Aug 2026 05:45:26 -0700 (PDT)
Received: from AtiePC ([79.116.13.250]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994a100e14sm166453775e9.14.2026.08.05.05.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 05:45:26 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org,
 Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org (open list:nvme),
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 0/3] NVMe hotunplug and PCI SR-IOV fixes
Date: Wed,  5 Aug 2026 14:45:15 +0200
Message-ID: <20260805124519.30054-1-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In this series, an assertion failure and a memory leak are fixed when unplugging
SR-IOV capable NVMe controllers.

The third patch fixes a null pointer dereference that occurs due to a mistake
in the SR-IOV capable device realization logic. I discovered it while testing
the code for these patches, so that's why I am including it in this series.

Cc: qemu-stable@nongnu.org

Daniel Paziyski (3):
  hw/nvme: fix assertion failure on sr-iov capable nvme controller
    removal
  hw/nvme: fix memory leak on sr-iov capable nvme controller removal
  pcie_sriov: register user created virtual function before realizing it

 hw/nvme/ctrl.c      | 12 ++++++++----
 hw/pci/pci.c        | 11 ++++++-----
 hw/pci/pcie_sriov.c |  6 ------
 3 files changed, 14 insertions(+), 15 deletions(-)

-- 
2.55.0


