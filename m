Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EF9C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 13:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thTvv-0001kx-FV; Mon, 10 Feb 2025 08:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTtZ-0008RW-1L
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:32:24 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTtV-0006BA-Je
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:32:15 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso1796143f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 05:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739194330; x=1739799130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GB1YwrY+qaOJi+5vuXWHaBJPFs12eogUHsnzqNis+TE=;
 b=SKT1dJAGOxeUU8GwK+zq5DttnjtvMv3ESLokk0VsWXBpmHJQrJOaGf7eShzi5KCb30
 QQ3mif9Z+VO4engvIGAJ2lE+AHoWHGa9MJyaE8JCHue57JkWdz6dkXm7SmBuO3mqScbE
 hui2y1cYCJicfuRlq2DqZATMFFZ6d9GNFjuCGp9tcrKo4DxW9WwjsIaNsU41Ac+3fiDX
 SdcovBvo/GAKSsncMvof7aW2cguLuAUp6R1SBTxDL9IFV0WNJGRadQ7t4LHr0pBb71ks
 Xskfby7tx0EQHiAk7dDiYrPY5LaX4CdOsQmOVI81R65kjoz9UtPg1EqRrH5RTUCMIPb5
 ufaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739194330; x=1739799130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GB1YwrY+qaOJi+5vuXWHaBJPFs12eogUHsnzqNis+TE=;
 b=CzkQC456G14hjHLtmSeDr+GYXS4OVroZIhNJWm3vTjf+a8fUfYeDOXTt8CgPPgqWmR
 bheDk3yY5o1NH/VdnXBwZkOyvmYqXI5mIP5v41jPY4suAuA81Uwy2oYKTzMhonrVkNC2
 ij4xKaJ70RlzEPixjJsY44rxT39ef0E6J8dfktcNE0L0EU4QGwRO75YooB1jBO4S/JsS
 0cmnNPCwwcKkiQwd4Ljjg3wjuLxyFoZ9WjYVvAoy61tOkYMdn2ti74aU/yOLpNoLIMi7
 3BVoUJ2Q9B4Hnt4YIqFA9CV7hCOJBUq8kSELJN1T1sjapEDh6h9QQijYK2iWcvWA0zky
 62wQ==
X-Gm-Message-State: AOJu0Yw32QgJZYwgfXPwavAVU/IPB1rdoTlPWIAVhQ0SHN7Dj+MWd4Ew
 HzR49T3Iorq35Ll2kbdFkSkawtYHByAWa9+/BkMoIFe79cKAcSnWu1OaGcRMOnDhXaHiK/1oN15
 GL2o=
X-Gm-Gg: ASbGncvDuFe53fJE7MW5a4LXP9IS2A+QRHajEYiUe2aczTkTj70ESVTHQVHN/uu4EGc
 Zy15YPli9D3x2iChnoMXZk7uFvdBD69v9k4OP+WjxQRcnNxEF1FeHcDHNaUztUP1Ek+Ty9bOMkH
 zY2ZX3WyPICZnxQSoQANHYPLfTIaXd2fFdC09h93Ftwp/wEKeUCeUAiB/A/R/Y1TW6DtIF5UeVh
 LDTB0+N/H2S9738U22AA8eNaLtccbVCo3CJ4vtydwN1nDJ9ASqQL5hehrATyWGLtimpZMJJfgdV
 /nQolwpOKiOsvsld8iT8lHvuyPowl0MXsPihMQyj9Nac0kqNnz40CDfNyoaSdJbvleEr1hs=
X-Google-Smtp-Source: AGHT+IEwaY8ks3EpUYDDrOnVv7M9eBEuaK3LethIYcHqxjjsP3KlSEaALUYVi8lxEQ2kaf0lMg2x0w==
X-Received: by 2002:a5d:5f87:0:b0:38d:d222:ee70 with SMTP id
 ffacd0b85a97d-38dd222ef6amr8289000f8f.20.1739194330442; 
 Mon, 10 Feb 2025 05:32:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde1dfaesm12495372f8f.90.2025.02.10.05.32.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 05:32:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/11] hw: Make class data 'const'
Date: Mon, 10 Feb 2025 14:31:30 +0100
Message-ID: <20250210133134.90879-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210133134.90879-1-philmd@linaro.org>
References: <20250210133134.90879-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

When the %data argument is not modified, we can declare it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci-internal.h   | 2 +-
 hw/sd/sdhci.c            | 2 +-
 hw/sensor/emc141x.c      | 2 +-
 hw/sensor/isl_pmbus_vr.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 5f3765f12d2..9f768c418e0 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -322,6 +322,6 @@ void sdhci_initfn(SDHCIState *s);
 void sdhci_uninitfn(SDHCIState *s);
 void sdhci_common_realize(SDHCIState *s, Error **errp);
 void sdhci_common_unrealize(SDHCIState *s);
-void sdhci_common_class_init(ObjectClass *klass, void *data);
+void sdhci_common_class_init(ObjectClass *klass, const void *data);
 
 #endif
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 99dd4a4e952..1f45a77566c 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1542,7 +1542,7 @@ const VMStateDescription sdhci_vmstate = {
     },
 };
 
-void sdhci_common_class_init(ObjectClass *klass, void *data)
+void sdhci_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/sensor/emc141x.c b/hw/sensor/emc141x.c
index aeccd2a3c94..33c1bd330fd 100644
--- a/hw/sensor/emc141x.c
+++ b/hw/sensor/emc141x.c
@@ -265,7 +265,7 @@ static void emc141x_initfn(Object *obj)
                         emc141x_set_temperature, NULL, NULL);
 }
 
-static void emc141x_class_init(ObjectClass *klass, void *data)
+static void emc141x_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
diff --git a/hw/sensor/isl_pmbus_vr.c b/hw/sensor/isl_pmbus_vr.c
index 304a66ea8b0..c60282cfe77 100644
--- a/hw/sensor/isl_pmbus_vr.c
+++ b/hw/sensor/isl_pmbus_vr.c
@@ -233,7 +233,7 @@ static void raa228000_init(Object *obj)
     isl_pmbus_vr_add_props(obj, flags, 1);
 }
 
-static void isl_pmbus_vr_class_init(ObjectClass *klass, void *data,
+static void isl_pmbus_vr_class_init(ObjectClass *klass, const void *data,
                                     uint8_t pages)
 {
     PMBusDeviceClass *k = PMBUS_DEVICE_CLASS(klass);
-- 
2.47.1


