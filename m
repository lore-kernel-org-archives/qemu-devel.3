Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BBAEE6454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodhK-0004pf-52; Thu, 12 Sep 2024 02:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhJ-0004lu-6F
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:52:57 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhH-0003RH-L7
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:52:56 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cc43454d5so4409255e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726123974; x=1726728774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LFdQQyV2bmEsjuWxwcR0v9/S6TIwatMWxB854Zl8gYU=;
 b=QDrSJhFYYzRN/r++sEcuVCDm87wrU6I21xjiuoddNraTrx34+96RBt/2xjjiMBGqaw
 q5g+Q/D3hT4lph7Yb/+lB4wAeT1fdxWgVKPyfCoy7ghJf0iNmunfs+s3UQYZdikVXejh
 Sdf/kWcSew3Q6bO5zBQqtWf9j89t5pv0tCDfTyA/TSd2iyqJ7FL89CR9zOQrxrLckxMa
 7Lws9WKtEJPJ6WuseD0LOgMxnZpR5hqz1jy+Rz0Aft7pi4YrK4wXoZsWDYrNoPsJYzbB
 ussXI+UM1e4jioGM+/Z83YQ7ZsIKvnAXknHpJgdI4W+z2bpOAv4KFDZzlvijNSFEqI/J
 rGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726123974; x=1726728774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LFdQQyV2bmEsjuWxwcR0v9/S6TIwatMWxB854Zl8gYU=;
 b=tnHAGb9z0UT2qUjTdwA2Wkf0+YvacxLZM89MJ0BWzRKq0whisuma2MA3+yupMxE1Hc
 B3ulm5HAPI4nSAC1nORWEr/n9IGGtx6IGBZtTe1EBXicRw1PPWcOQMx9mx1Ayqdl19UA
 Y0YgK5JTbSYvR1FXvxH46mbhSIgsuRjPCiOIzCkuxsE/EAVOcU2LmJ47jrkEPh6+tH/x
 b5GEyZpIzkof9GPqj07P+4YgbJTxn193996fMUwkVbG06Rv7gnEStFPSs5qvj+lS/uCY
 keJ1quZ2CqDdeJmOBjv5E/kn3UWCqPHap8E7ud/lWSVgIHuJh15CPk+71y4LVNC4aDEV
 kD8Q==
X-Gm-Message-State: AOJu0YwAhh1Zx6Mqt4XVTnDUDKqZBjQmb3S0S6h5QxGVefZ3MWR7joXo
 ZBAZIE6BilC4qKIjE9A0uU4gtODB4Zgx+FkUzscIpp/VAx8SlcqhXHkAURVj8if7js6fowRCjVa
 1
X-Google-Smtp-Source: AGHT+IFV/adnIakW2Nl/d3TbR3dDLAbN8ZvxpXZjLQwBMBDsZJs4ottJA0AUAxbdMxyCmO+g1SRcuQ==
X-Received: by 2002:a05:600c:3b14:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-42cdb547d4emr9707885e9.19.1726123973680; 
 Wed, 11 Sep 2024 23:52:53 -0700 (PDT)
Received: from m1x-phil.lan (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb73ab096sm125266255e9.22.2024.09.11.23.52.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 23:52:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 47/61] hw/sensor/tmp105: OS (one-shot) bit in config
 register always returns 0
Date: Thu, 12 Sep 2024 08:52:18 +0200
Message-ID: <20240912065227.67848-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912065227.67848-1-philmd@linaro.org>
References: <20240912065227.67848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Per datasheet, "ONE-SHOT (OS)", the OS bit always returns 0 when reading
the configuration register.

Clear the ONE_SHOT bit in the WRITE path. Now than the READ path is
simpler, we can also simplify tmp105_alarm_update().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20240906154911.86803-5-philmd@linaro.org>
---
 hw/sensor/tmp105.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index 6740200aea..f5101af919 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -42,12 +42,8 @@ static void tmp105_interrupt_update(TMP105State *s)
 
 static void tmp105_alarm_update(TMP105State *s, bool one_shot)
 {
-    if (FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE)) {
-        if (one_shot) {
-            s->config = FIELD_DP8(s->config, CONFIG, ONE_SHOT, 0);
-        } else {
-            return;
-        }
+    if (FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE) && !one_shot) {
+        return;
     }
 
     if (FIELD_EX8(s->config, CONFIG, THERMOSTAT_MODE)) {
@@ -166,7 +162,7 @@ static void tmp105_write(TMP105State *s)
         if (FIELD_EX8(s->buf[0] & ~s->config, CONFIG, SHUTDOWN_MODE)) {
             printf("%s: TMP105 shutdown\n", __func__);
         }
-        s->config = s->buf[0];
+        s->config = FIELD_DP8(s->buf[0], CONFIG, ONE_SHOT, 0);
         s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
         tmp105_alarm_update(s, FIELD_EX8(s->buf[0], CONFIG, ONE_SHOT));
         break;
-- 
2.45.2


