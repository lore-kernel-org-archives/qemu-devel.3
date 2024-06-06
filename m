Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FAFC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFCBm-00061b-CJ; Thu, 06 Jun 2024 08:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sFCBR-0005j8-A8
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:25:35 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sFCBP-0007dZ-LR
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:25:33 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-702508bf0a9so738086b3a.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1717676730; x=1718281530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CiOn0d9Pa8+qXsbBr3wAGk2xL3bXuiI7sz/i/2tw7Go=;
 b=LMZfRE6l8W34JgRdv83j3SpBVX/ky8R4ErnOEl4Ov/cu+0fdPH/2+3aWOaSIhXwBXU
 yS/Xqqq+ivMvSupBINemh1ylm9l8uiyIuB3IxtjsvjZtnHNxUVbnBgDfon9N9fBe/nG8
 p6/B/ofBsmHCM7POBIIKIe4DOZ3wt8qvVvHOGZS54vrDwhycbYcSjpyiDpgMxu/cMwI9
 TewvB7Eq2uWEniPSUIzOOSYpfNpPR5AVrrZ8nI1NUN4tIf8eMKD4zHi1v/F/ehJdJ4cQ
 /kH8PRx4xNHwjSKiRONuoxcqQE9A0YtJWFsVU1VSqElIvwEd+RiE2BtTICfDLGJ2+T1J
 mnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717676730; x=1718281530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CiOn0d9Pa8+qXsbBr3wAGk2xL3bXuiI7sz/i/2tw7Go=;
 b=Vbc8iAhVP6h5vaMHnMopVjlHpBmtycS3h5QuRByqyUfSH8A2JqfmAZEp8pO+hCujcO
 OkLuqhp6ud9xIlwP+1V4iVMEcdINqudHMwUc6CxvFNY0aGxItM9e+fmDXZjjkw7PVmUY
 cs0SM/H4VSmP1dT9/LYKoRhISxvpak+xkcahueaCpt1xT5rn8hyyQpuhOUWhFahrd9lK
 /cygupSmN7wIrtWOuyziEifAshrulJxRIoBkp/S4SGBQEYIxg+0RSUdG0D0YcVGGrevA
 6kOdVmlCTLC4rpVZq4uX8cvPuy03yuAjrvZZd9qouixD6tSw/KxMeo9Qnwsfa++iQFI3
 hAVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR4IFU8aDnIFlaYW+b6rpzFBcngsDM29tndJK9CORSpYB0nDihB+USu7QGj0oYOGuyjnBnQDOQUoWpS6RGAMUz5rZupe0=
X-Gm-Message-State: AOJu0YzJ8UgKZp5vU+OLW4GBkXWXT5EQesi9mwh6aGxvfSH/ffiyimMs
 WQfhdLaSH6wzlZ1nmMt2RmqS/BtabBxgHmvS9OIY7ZXQivEGF6Nj9Hv7T5ATtkE=
X-Google-Smtp-Source: AGHT+IGLSp4xheFj7kusseyjRxGGCHT/DGp83bUKdFnc8umuKWFxwrKYsSAao5Pm3Ktx2NkVcyODhw==
X-Received: by 2002:a05:6a20:7487:b0:1b2:a899:e57e with SMTP id
 adf61e73a8af0-1b2b71542b8mr5851027637.59.1717676730198; 
 Thu, 06 Jun 2024 05:25:30 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.142])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c29c20d7adsm1459396a91.9.2024.06.06.05.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 05:25:29 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v5 08/10] hw/nvme: enable ONCS and rescap function
Date: Thu,  6 Jun 2024 20:24:42 +0800
Message-Id: <20240606122444.2914576-9-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
References: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit enables ONCS to support the reservation
function at the controller level. Also enables rescap
function in the namespace by detecting the supported reservation
function in the backend driver.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/nvme/ctrl.c | 3 ++-
 hw/nvme/ns.c   | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..182307a48b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8248,7 +8248,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->nn = cpu_to_le32(NVME_MAX_NAMESPACES);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES | NVME_ONCS_DSM |
-                           NVME_ONCS_COMPARE | NVME_ONCS_COPY);
+                           NVME_ONCS_COMPARE | NVME_ONCS_COPY |
+                           NVME_ONCS_RESRVATIONS);
 
     /*
      * NOTE: If this device ever supports a command set that does NOT use 0x0
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index ea8db175db..320c9bf658 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -20,6 +20,7 @@
 #include "qemu/bitops.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
+#include "block/block_int.h"
 
 #include "nvme.h"
 #include "trace.h"
@@ -33,6 +34,7 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     BlockDriverInfo bdi;
     int npdg, ret;
     int64_t nlbas;
+    uint8_t blk_pr_cap;
 
     ns->lbaf = id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
     ns->lbasz = 1 << ns->lbaf.ds;
@@ -55,6 +57,9 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     }
 
     id_ns->npda = id_ns->npdg = npdg - 1;
+
+    blk_pr_cap = blk_bs(ns->blkconf.blk)->file->bs->bl.pr_cap;
+    id_ns->rescap = block_pr_cap_to_nvme(blk_pr_cap);
 }
 
 static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
-- 
2.20.1


