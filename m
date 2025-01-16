Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1614C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 08:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLXi-0003hx-AF; Thu, 16 Jan 2025 03:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vliaskovitis@suse.com>)
 id 1tYLWr-0003Pi-WD
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:47:11 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vliaskovitis@suse.com>)
 id 1tYLWn-0007SO-Ee
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:47:05 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso3524415e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 00:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1737017218; x=1737622018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ubcG+QppDIx/jZMkDYBenA+AlXgLGAnXxSTUOAzYLiY=;
 b=LyeJW6CGG1Gmx/D4nJtLZ4NHd8VR/mP5lBcd4B66kCElnrfjIFu76UeOZ+TkJgJB3W
 /w9jTyCsBj7MlWaIjtypgmQ9elhgJbHmSwbyolI2UVj8ShRtAhRPy4T2UVLMGSECruG0
 lrqnsBQDdtJ93ZB+ENSfTN/xA5ExQrSZOgReYVsx2RmAYpR/aT9swsJBE+mNh5pg0Rgn
 hQxt+Bf3/GzcNntcRP2aDdUMvBF+uAxeNhuIhY264BUS2abgpXWVuxXHIwS1dhLHgAZ6
 KxW58NTuw0kqvETux2+xq4oSYpftpa1vQY8iiTf4Sl6abgWH9p1y8/EZsagQkTvfZOkD
 Me+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737017218; x=1737622018;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ubcG+QppDIx/jZMkDYBenA+AlXgLGAnXxSTUOAzYLiY=;
 b=aFd2Wn+tnrChFeWR93XU1Fc35OvBCzcjjVm0Ao2RT6gdf1ZqZ6/M0W9N6IMsEGwERs
 epVqz6w+BsuZgdxLahrH1peq2ohmiHu/pRQA5xf+TVja0te0Sut1eLSbK23Q5I7IVZxZ
 UbWp7mSMjt0yK4Ll3uaN7uDkTSxMr1DQlN1UUnTtd99VuZ4FzxeVe6gzEV/h1BI+cFdp
 bMJrYpR13ZhpR/aZjNsQvCz85ilTXvS90lXvaB5kQDkLBPKlh+xfqAXB9t7s1Hrlp4/Y
 kqp6Uvj4xoklreRFdurrZjXFtgZP0LGXnCEFwzIrAiMnRYHyfUQOdYcBICtZFixT3/oR
 W+6w==
X-Gm-Message-State: AOJu0YziHw1LCRB32gy+1Wed74jTu0n8xdRv+vmqHZZm6pOriTtBlIR3
 c/OAp3jhwlgC8EuciqB+eXue/GKnlL6kH1Gwe4vfwWQ7f5ucq+ZPpUlCV8S2UVWvM5dVjoAsIpt
 xorWnmhe5
X-Gm-Gg: ASbGncsQkLzYxJKiSaaWtjlOXGOE6hVoRJFxFGGmdDGcU6DChUCaGbJESpd+R3/2U0/
 WSWsUZJtwNIfQ6Xz+nJ/D3o6WZQOvaC4eVBz1tic5O0VsMGk8Ghmly2UPMW295QbamvwZDwRB9v
 8FEuN8RBdpQE70rtxvfbjp8JldfttLB0MYogZtzsMmbnqAZaZquNKKNUVOUS5PInKitIUsEgdLD
 qMWxjRb4/zmoLQOyLftosQ+TWeYtHjMserG8QG0jY9ucJdzexA3fr/il6wfyovLVarnN0BpxznV
 WP3vXEK5
X-Google-Smtp-Source: AGHT+IENMaoAUqAfcQ0CR0pDWEGtn8YlDJyp8bt/gm8HstNDpQganqvqF/tsu+4qVqf1M1SKac/dhQ==
X-Received: by 2002:a05:600c:4f81:b0:434:f1d5:1453 with SMTP id
 5b1f17b1804b1-436e2531ec8mr318843695e9.0.1737017217780; 
 Thu, 16 Jan 2025 00:46:57 -0800 (PST)
Received: from localhost (ppp-2-86-138-70.home.otenet.gr. [2.86.138.70])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-437c7499502sm51600425e9.4.2025.01.16.00.46.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 00:46:57 -0800 (PST)
From: Vasilis Liaskovitis <vliaskovitis@suse.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, jason.chien@sifive.com,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 ajones@ventanamicro.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 philmd@linaro.org, Vasilis Liaskovitis <vliaskovitis@suse.com>
Subject: [RFC PATCH] hw/riscv/virt: Add serial alias in DTB
Date: Thu, 16 Jan 2025 09:46:29 +0100
Message-ID: <20250116084629.19983-1-vliaskovitis@suse.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=vliaskovitis@suse.com; helo=mail-wm1-x341.google.com
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

This patch adds an "aliases" node with a "serial0" entry for the
single UART in the riscv64 virt machine.

This was requested in Gitlab #2774. However, since the machine only
has one UART at the moment, it's not clear that this addition makes
sense.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2774
Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
---
 hw/riscv/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2bc5a9dd98..67b80e9430 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -971,6 +971,8 @@ static void create_fdt_uart(RISCVVirtState *s, const MemMapEntry *memmap,
     }
 
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
+    qemu_fdt_add_subnode(ms->fdt, "/aliases");
+    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
 }
 
 static void create_fdt_rtc(RISCVVirtState *s, const MemMapEntry *memmap,
-- 
2.46.0


