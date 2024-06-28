Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483F7C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 04:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN3dJ-0000NZ-8q; Fri, 28 Jun 2024 00:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3cz-0008TU-Ge
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:54:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3cn-00012A-Hu
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:54:24 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42562a984d3so1762645e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 21:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719550454; x=1720155254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLGQaIGJKgcmO8Q0mlDn8rOb//ZdpOwWSY8cFandEdQ=;
 b=Y3CaqbJeXpnIB3ilJxyv90CVkxVjqwYgcy5Rh90JkMcU0zpHXvWu9vplkFrvsyaSHU
 KoxJ8Nt0dIGpWryr+KgQWkM/TXKBD1NfC8VdCzMziJ4ZRTsDcR7/pe07n0OCYJENPdON
 JIrfBg7fOivjDXmylZ7JSlsHNBDhVBmYez14zDn4U6e1NXJo1bzfqsLWrLRpKvyMdDnP
 z/JLqiBrWW/kpI9QZq1MragMWxh7fb+uu37W+6iyKt8cWOghHYXRi7vCpv9fZFtdQCe4
 YItczNC/zpMUL2iCJTMM56N4viiKniB58ked3dOrSZhbS1cqLSMxkKjVzLphJ5cEaodQ
 KvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719550454; x=1720155254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KLGQaIGJKgcmO8Q0mlDn8rOb//ZdpOwWSY8cFandEdQ=;
 b=mQm1j2y6xJ41h9lZanpQ4ZKV/zgVQhS8p8N2jOtTdIVkfGZyKPYnkZ52L5kBbjsXxz
 DWieY2RDFgi0X0rjlegn9FbnTCsUevt3IkQGGBMfuExxxZAT4P5PXQplREXykEiTr1Ig
 2sZVayIM4UB14ZqPlvjtpHQt9ypGa3nLYlSWpUmcJi6Gwb+mcAlgUiuget02Rxpg7El2
 XDEHx04X4OckCE9L8XMiU4zbinI5cPtluP0pcZuIuwJSqnURDYY0/llh7uBqfr02ocqm
 pEFfJbLFIi362qkwMIIWs2DC3kxIaSfGHBoycxhVhxcjaZk//y9YquHrwgEEu8KcxPBf
 vSVA==
X-Gm-Message-State: AOJu0YxjxnjqkW4rTg66ZjS723EUJEcMSZGT4Mf7Mhcr/pWYDv16q9Qm
 zhvq3oaO2YYC6zmflInhLC5L/0wYdbn/5PLhu2ZWKcU7od17AoElbT3d0TXZvC4CyYMuxFapsEa
 mRf01Gg==
X-Google-Smtp-Source: AGHT+IEzs4V1l7GJ0ciXSMktqi9UN+/b0nixvcq6WFqPsklpgTETUzMjmjeH/by1vNmbqk+DnsR+Vw==
X-Received: by 2002:a05:600c:929:b0:425:65c5:79b4 with SMTP id
 5b1f17b1804b1-42565c57b9amr26202885e9.26.1719550454028; 
 Thu, 27 Jun 2024 21:54:14 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5ba67sm17879975e9.19.2024.06.27.21.54.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 21:54:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/12] hw/sd/sdcard: Remove noise from sd_acmd_name()
Date: Fri, 28 Jun 2024 06:53:20 +0200
Message-ID: <20240628045323.86308-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164815.82606-1-philmd@linaro.org>
References: <20240627164815.82606-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

These ACMD names weren't really useful, "UNKNOWN_ACMD" is simpler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7f93d363c7..19322c558f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -259,23 +259,13 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 
 static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
 {
-    static const char *acmd_abbrev[SDMMC_CMD_MAX] = {
-        [14] = "DPS_spec",                  [15] = "DPS_spec",
-        [16] = "DPS_spec",
-        [18] = "SECU_spec",
-        [52] = "SECU_spec",                 [53] = "SECU_spec",
-        [54] = "SECU_spec",
-        [56] = "SECU_spec",                 [57] = "SECU_spec",
-        [58] = "SECU_spec",                 [59] = "SECU_spec",
-    };
     const SDProto *sdp = sd->proto;
 
     if (sdp->acmd[cmd].handler) {
-        assert(!acmd_abbrev[cmd]);
         return sdp->acmd[cmd].name;
     }
 
-    return acmd_abbrev[cmd] ? acmd_abbrev[cmd] : "UNKNOWN_ACMD";
+    return "UNKNOWN_ACMD";
 }
 
 static uint8_t sd_get_dat_lines(SDState *sd)
-- 
2.41.0


