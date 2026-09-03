Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00333C624DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CRk-0006Nx-Je; Thu, 03 Sep 2026 14:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x2CRj-0006N5-82
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:45:59 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x2CRc-0005jr-UY
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:45:57 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-485843aeab8so204563f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788461149; x=1789065949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NXY/k4DXwnVEw0o5L8gqyMDmFU5CqfUmgmY2axvAzY4=;
 b=Sf+tcmihsnBRd5IkvTO2GBkk2YyQ+yKNjezZW2MEaQpB0aKqyMh+FVKGfH5B0GpuhA
 A1+b/EUosGcdMegaMj5QnCBtaiUms6nONH/QWfMTY6tn/TAt/6LHDdOUKR589r5J6OkU
 GjggFBY2rpsrGFCjd85mZzLW83A0sQwrYCC+P+c/QCj9Tt4NRV9zonj44mn9kqewS0Uo
 OrNUVq+J0725K97KDBSYLjJjLbaR/cM15zQan+RMA8vpdYXGKbSmEWAPVLUmozLi8CJm
 IJYe8RNnnD7/uDe++ef7nU30t8s+qro7zU7bRGVfYpjZPmB2nyAL4xzu+yja9MQPcrTm
 Zf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461149; x=1789065949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NXY/k4DXwnVEw0o5L8gqyMDmFU5CqfUmgmY2axvAzY4=;
 b=J/7NS4nyq1021mby1yxonFwnqMsQjEkaxl6liGoKCqnLjUZfaNQZE7Jxw/Xozu5zW5
 jQmSmMumHCPhO0PRtJTxK7tFHK0xv4Byvc9g/cZG6IO18xuOOcP8j8I6Z4+rvFI2GJHY
 wFSda+kf0RG/ZNf9o82Wtq+5CUJ8QiwNUatMOjoAt3WVhObxcKkRxft70faY1tirhOPY
 V0ntALYm+hH5V55vs+nOAosM6lM+Yc5AZXRMEfXewnojhHk38jTlEJEio4zR9FysO01X
 cJoNSENpCcO8iUKo7w4wNYcsrOW7TLeYcZq36xC2xLqKceVHN7/jKRRUrMKjF0256niN
 ZTVg==
X-Gm-Message-State: AFuF++lzSfqv0kymILAHXTjrJkrlyoypJAS+ys8DLlCuFyOUvgF06J/n
 lNw5MyeuqQNcAGt2xtIRfh0CJAXZl0SN+ZOeOilpPXUKtCHVE9mo9p5+dXF9EndTyGtbGFJvHCD
 37x96
X-Gm-Gg: AYBFou2Gf8yIuuhgnHo3IQnaPZkdBN5n6BsRp1/ODU2Yv9lzANmZJSw+EP1ObLtxIVQ
 6HgM+jdTgIu10qF2pa2E9ojGn+T6PKrly+8NKzBAO9k+5JN8UKlOFt9yB+8ro9QVC5FVlRaitwN
 2mbsvppxvDJggPawGSPdC/KQMAtkL2np6xVNx6Hacbk/k2XXNVwS3IbDeZ0UXQ5xgKx4yrbBRdT
 FjS30e1A5v+X5MvHeewuLmDEj7yBWQpCXighyaEFxbPySGmLu+g01iTWG8i50vUOEd+D+1oMZ+b
 KeZhgxX2W51hzVLiauTkT+bi3UNc5ZP6V+TWh9874X4y5f4OPegv6YD/gnlE3Ads3TvO4yb6Mk3
 ZLK+vL6oqMELp04K/rUeKLLyN8g4nqLA/nMSkZ2tyXdWxTRbRZM323dcv42Af0BBXdkb3U3RHuW
 +bDfuU85+FVdln68sjj5KA4mn5bUMkBSOwmR2RUBPoCvTO0NMEMd6TB2zJ
X-Received: by 2002:a5d:5f92:0:b0:47f:8f8f:db74 with SMTP id
 ffacd0b85a97d-4858705ac32mr2114460f8f.12.1788461149309; 
 Thu, 03 Sep 2026 11:45:49 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883953cfsm395557f8f.13.2026.09.03.11.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:45:47 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PATCH 2/2] pci: load a device's config inside one memory transaction
Date: Thu,  3 Sep 2026 20:45:42 +0200
Message-ID: <20260903184542.2629976-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903184542.2629976-1-den@openvz.org>
References: <20260903184542.2629976-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=den@openvz.org; helo=mail-wr1-x429.google.com
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

From: Denis V. Lunev <den@openvz.org>

Restoring config space remaps the BARs, updates the bridge windows when
the device is a bridge, and toggles the bus master region. Each of those
commits a transaction of its own, so one device costs several flatview
rebuilds where one would do, and the cost of a rebuild grows with the
number of regions in the machine.

Nothing between them touches an address space, so the three can share a
transaction. The saving scales with the number of PCI devices.

CC: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Denis V. Lunev <den@virtuozzo.com>
---
 hw/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 14c78e3c62..0efb4eb4bb 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -840,6 +840,8 @@ static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
     }
     memcpy(s->config, config, size);
 
+    memory_region_transaction_begin();
+
     pci_update_mappings(s);
     if (IS_PCI_BRIDGE(s)) {
         pci_bridge_update_mappings(PCI_BRIDGE(s));
@@ -848,6 +850,8 @@ static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
     pci_set_master(s, pci_get_word(s->config + PCI_COMMAND)
                       & PCI_COMMAND_MASTER);
 
+    memory_region_transaction_commit();
+
     g_free(config);
     return 0;
 }
-- 
2.53.0


