Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36819C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5k3-00084T-10; Fri, 28 Jun 2024 03:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5k0-0007mT-HN
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:52 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jz-0004ZH-1b
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:52 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42567ddf099so2329635e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558589; x=1720163389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KLGQaIGJKgcmO8Q0mlDn8rOb//ZdpOwWSY8cFandEdQ=;
 b=UcJAqT1oPpAD++RPxZGtLkREnChaPGoDTh+6R7PZA394OpCC6+PzTzKQs3mKhmpA0i
 8CTXQPGrHfNi6SLNAwhebgU0Xc6uL/zPF4mG1vfbSxySGtSKx/73+EboO/jTRbgr/CIc
 81uhWhcNZb5aC0KK1YYv/KUNOpsDD6zlfGIue6yn8aNeUSYCW65CsIu3luHOCL6A8Yq3
 zZn063lTsZ54B3nkUUVBTGiYIF7gPEbCZFQop70YwRiLK15og7+hg/BqZV5H4/DFB/Y7
 5ARSLi/5sKr1D19DJi2OH3ZGPYRISQlxXmjoYUXthn4+hbXCTDH7NWcLkxc1bBzkZEL/
 tDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558589; x=1720163389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KLGQaIGJKgcmO8Q0mlDn8rOb//ZdpOwWSY8cFandEdQ=;
 b=nGg3s6Pes8DjvFghYbx4kKyUWQ8uBFUkbhLNYZp3VrB1NIhmYly2cE1oYb6cwq2cB5
 A8WGxKw3fw4mG6OLtGsElczWWcyJdYk8tyrFHQ1iXTKHSJorhFfRnpBnp5lmLd85bsR4
 vI4zXjbD+k6nRCwPsJAxI+aGXQoNOwKg4tGKfdjJvzSfxJfLf/F3Kn3eszQvZr56yTN7
 G1Ev1nl6TSXC8j8sMy/213Fm/6ATQiIM1YtYmiRJRAZG1Sw6MXNLZJaAVq2M2UkWmkUq
 pHn8m/QWVIpW8m+1Qxiw4t6pvT6JAoqJgF+O60QH0Xdej3hdsiCNdtjEGlZWVk2f8CEu
 36gg==
X-Gm-Message-State: AOJu0YxLZgLDg9N9AdIVU5Ale5H1RTcXa0/beWjfFM5tNsSW6r7DUb0r
 hrgrsUGzsrfAHHQ/qDz5eqb0WD0jNK3Hw+Zq5tAXSmJ9Pm87eXciCBirpGptYoBzV6MVnfRmX+B
 XYEg=
X-Google-Smtp-Source: AGHT+IHIXF7kVsNkfso66LGhA5TWl6hbV4LnREf6C8nAzqxsYJqBGTJkiO6ATixm5epsWv7PDZzEqw==
X-Received: by 2002:a05:600c:1c8f:b0:425:5eff:7182 with SMTP id
 5b1f17b1804b1-4255eff7411mr44231665e9.31.1719558589218; 
 Fri, 28 Jun 2024 00:09:49 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3f14csm21768485e9.6.2024.06.28.00.09.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:09:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 76/98] hw/sd/sdcard: Remove noise from sd_acmd_name()
Date: Fri, 28 Jun 2024 09:01:52 +0200
Message-ID: <20240628070216.92609-77-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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


