Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9C5C3DA4D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 16:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSJ7o-0005JF-WD; Fri, 12 Jul 2024 12:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJ7j-000583-Fm
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:27:56 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJ7h-00020G-Qg
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:27:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4277a5ed48bso16039885e9.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720801671; x=1721406471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=haoIBckcRPKFI1igV/tcFjqM0juY8TSEYfggrZriKRI=;
 b=k0XS1zphO2XQB86m/ufL94bWvNCNJSP3OX8vg5cXWj9Um7mICioFQUMXi/Tqu9ilfM
 55XpN6X2Z2nAHETr18USd4hZ8XkFVx3Kedye5ND1X0alH+NgkOsd7NO3/uR6SE4Q+ilk
 V2EKahkOBshXkcV+Q7mgB2LnlxllyiewQtWf97SlO1CAzO/89whkGPDxPcmemBoaRV1I
 5W42XoLdqlsoeglANWOcHDzbUJoduclr2XrzYr8l0iOgCgscbUFklthBZthjxwjUq1no
 88Ff4XfwZwzWuLPdKyCO020iPDEGg8U5aEX1kjAdKCJSxPj6lrYl4nTGQuh/vB2mzq4X
 197g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720801671; x=1721406471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=haoIBckcRPKFI1igV/tcFjqM0juY8TSEYfggrZriKRI=;
 b=vaBYVTWqMNFO0PxWxVm0Df3gTw72HARZC+/8muJRZ3VXUTxLGtRfxvbGjCHZIm9fPW
 mRYBx0cMQ8n28YRONzayM6gS6eiLqGz9wTCV0jKuTnbTo2yMTPFweUu+zVUz1kTDxeUP
 as7S5dtCHjhCJwcamy9vEcvPObY02le4oi8aBJEfNf1fsTzwdOErJZL95mIGDwgrj3vc
 2RoHXHOTXZT2SpcnpyCsLpxN1Brrzfcg2k+0OP+Wlmo3MkFnCko4yJMPPQUdXKSPC7NY
 FdlRicjFWjNXflY9JXpnltrRX97RgNoJBD7qSX7CtLm4SLxn5xJWIf9PBP/mI7seZeao
 NUGA==
X-Gm-Message-State: AOJu0YwkZ1auXIpN+AWsPoOVDu1YTSL7P3l+IBV3BbTocW272E7O+vb2
 ZBs+PcbPRcO/+dH/h/lKCMqF5IPIpAGqRsQMLzipxMNdPiKpj1gBihcMJPlibunuXBcDOmhnWp1
 n
X-Google-Smtp-Source: AGHT+IFAho8DxUlhnUWTZp/09Y/wduG+g1h37L4JyJ7JF+yWLcHaknanm594Rb+HV4ZtHKn5hW6oGw==
X-Received: by 2002:a5d:408d:0:b0:362:41a4:974a with SMTP id
 ffacd0b85a97d-367cead83eemr7223482f8f.66.1720801671703; 
 Fri, 12 Jul 2024 09:27:51 -0700 (PDT)
Received: from localhost.localdomain
 (nsg93-h02-176-184-54-152.dsl.sta.abo.bbox.fr. [176.184.54.152])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde890f6sm10542001f8f.53.2024.07.12.09.27.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 12 Jul 2024 09:27:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v49 05/11] hw/sd/sdcard: Fix SET_BLOCK_COUNT command argument
 on eMMC (CMD23)
Date: Fri, 12 Jul 2024 18:27:13 +0200
Message-ID: <20240712162719.88165-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240712162719.88165-1-philmd@linaro.org>
References: <20240712162719.88165-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Cédric Le Goater <clg@kaod.org>

The number of blocks is defined in the lower bits [15:0].

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ab502d19b8..09077f0154 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1533,6 +1533,9 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
     }
 
     sd->multi_blk_cnt = req.arg;
+    if (sd_is_emmc(sd)) {
+        sd->multi_blk_cnt &= 0xffff;
+    }
     trace_sdcard_set_block_count(sd->multi_blk_cnt);
 
     return sd_r1;
-- 
2.41.0


