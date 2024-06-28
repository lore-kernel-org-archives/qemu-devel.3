Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDE8C30659
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 04:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN3dO-0000yk-L6; Fri, 28 Jun 2024 00:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3d2-0008V6-AG
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:54:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3cz-000135-1s
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:54:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4256aee6d4fso1582405e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 21:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719550460; x=1720155260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qw+zxMHTEIwsFcpzBJxdUQmKFi6OrynqizbQoSQ84sA=;
 b=dTrd7ZsAyUIBRbfatnGcOSRC9nE7bleqU04iGxbyKLHjmtiAwQhXiCvVeOKicrUMX8
 tmHkV2sXBkOsPqeRyB6q0SKFrNX2g67UTa3B0eCdBxfpeD5txWDE+frLny1AUrzMmP3W
 L8OsGsYqTrlLvruASYL5Ff7nVbhysE4v7/5zY3jo70avy5tiOvjFDztG9J+gUppuoM38
 6dIb75a1ScWUGauu4hGB166GROZeROel688NCcWc3QcpmNTLh7ZOs17B8QeVZ9+OxraB
 /ATQ5ZEMq3ZWiN2hCuigt3OE/BbRyO0qzaIRyc3FBVNwefmn1O5hHTTj1OPDMdoJT3PM
 SMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719550460; x=1720155260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qw+zxMHTEIwsFcpzBJxdUQmKFi6OrynqizbQoSQ84sA=;
 b=X4vi35ld1HuYhTw4aO5Z+EqluYLCl2HAwc27onX1YRNnwWnwajqppPeaEsC3pGkrvY
 uW7kMSATs/CmOmKgjdzE/WTX4z1Ew7CYYa87UEVQNFVWh6dRY5IJ8FWS/RHh+QvR/obj
 pHSC2r4igUWz39ROhe0tadYoksAkrWrOkAzSII1LGe8NbSulT+YT80WKUmo2fH0hMgSg
 fa6fOWE/ixrwnr9YeKX7iugF7XF0E7lm7rraz/ciprPUPpQJY2W8/xDzdfDjZcBx7UOx
 kErl9HLk5t5TuWFLg3To5VMS779DYaCY9q9KnR1xrT2eUOXOMwcLwkD7eDlkfpZtFfhB
 8AXg==
X-Gm-Message-State: AOJu0YwPFmr48eDiBw8cQVyFLaNcl5ijmNlH+P7UTquNtycUbjQQko7t
 FbhTwSlFyHPLtz5doiOi0SJjLxEEfbOCxEELRj7cUDPNahIet98Eyv5M4TITasi/81EUa2JAV16
 MUBjYxA==
X-Google-Smtp-Source: AGHT+IHPrW9G/FKMivbec7Oc3hjDbhQmupvP7KoNCLYPEIM+BcEnWTpPDR6qBOEhBIwZcgG+Tdk4mA==
X-Received: by 2002:a05:600c:511b:b0:425:6510:d8ec with SMTP id
 5b1f17b1804b1-4256510de8fmr25303495e9.23.1719550460708; 
 Thu, 27 Jun 2024 21:54:20 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3cff9sm18049765e9.3.2024.06.27.21.54.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 21:54:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/12] hw/sd/sdcard: Remove noise from sd_cmd_name()
Date: Fri, 28 Jun 2024 06:53:21 +0200
Message-ID: <20240628045323.86308-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164815.82606-1-philmd@linaro.org>
References: <20240627164815.82606-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These CMD names weren't really useful, "UNKNOWN_CMD" is simpler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 19322c558f..0a7b422b2c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -241,12 +241,7 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
         [18]    = "READ_MULTIPLE_BLOCK",
-                                            [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
-        [26]    = "MANUF_RSVD",
-        [40]    = "DPS_spec",
-        [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
-        [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
     };
     const SDProto *sdp = sd->proto;
 
-- 
2.41.0


