Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5350E7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu0b-00054y-RB; Sun, 15 Dec 2024 14:10:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzv-0002Nr-2j
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:47 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzt-0001W6-Ba
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:46 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-71e3284f963so1731399a34.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289784; x=1734894584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8s/OID5KE9oMd0XN+uqlFnMR3Q80aL2JeEILGul62oQ=;
 b=PEeEEEvD7dX14nDqFPDWqZhy4EioSj5z7FrIPQWOYF5U9oJ/77ozZTyBLPuGzaIDBK
 dZmxyoXpcszY06IaadnGs/9lg+CdNUzTIo58ksRgEQZFq9lz1BAhBOixT0w56Kv9/Kim
 PjaBpq2JSR/JI9rE3EN7MgAjg92kpcBciVqlHMW+hWyhTmX5l5Nah5zn773lC22q1s1K
 EiGRwDtr3Xfkj7aYDg9rx2bKMhHYC9VP+OmzfbAM+HL3Q2We1jfezuRSsJEkTo/fRyVf
 IHwt3YW/d4km0nBdiWI7lCTGmvnMFOZqgiNPQQVR2Oeq7WqysHZjhMHbzDnGMUNKCHJk
 FJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289784; x=1734894584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8s/OID5KE9oMd0XN+uqlFnMR3Q80aL2JeEILGul62oQ=;
 b=oT1KnJn1FlQkYKvAHR9x0a6viinQ1odilPWXy5mYmoOG5DSITOK1v5ka3GRAymMON9
 Gx/PU3F5SP60zP/2d5dG3DI87YE5VnoBVMEv2encpyo4nXEvL5Co0kB5Le4jQTxuSZKK
 Xy1JZFIVEnY2MWNTuY58vnFpa227nVf046OFENN8vQfXSVvhcdQQLTKR7Bjsk+6Rrf+8
 vFDud3V3e6OOF5s5s0BSsd3Nm0haH+8vmWmD5FFcXtsvu3hI37JJff7w3gPrfV7c3Uyk
 d1M2XOUzTvg3EpRE0zybgc7hDEbSzmbry9JPi8v/AlLDRsdiw4Fbl5NrGY07NyibOPy+
 xMEQ==
X-Gm-Message-State: AOJu0Yz1ZTG7zcwkoQ5jI2LHDhjZQ91+Ir+OrS4TBwr0AIC8bBhsUQdA
 uCLs+E2jxNkXMSCmxXKKpA20QcNljNZMTfqAKzX924AUqNHFYnSO9tWFbIrNTiqrOeZd/s58yUl
 2Ad6iY/dm
X-Gm-Gg: ASbGnctL5Pl7g5uKDGaVhNU7Hp59wAgtXv9DH1RR+4Mgr+d8WUxy+/d344vZGJdKJkH
 09hbVgsTuYOODvJxWs8BBhQ2Q3QRSV3VT8D4Uh1KpVKOIZJhPaYwycxmI09OKiQ8ZtWFf0HBhvd
 6n6Lz5Bqzt6y0y+WBnlVWvdPcUFcTiBIeEJbFqIFvcUApb1V93uaQqdtSTDCxuwiLg7ZZDfVdFa
 mW3NFVWwH82EatEhcF5J5ALwUm+nGyu/Dh+D7v5TtVFhGwuPk9ZGt1k1cgat2tASCLOFNOTtjDo
 0FHPerDcJhtit5epweotkjD4ow0De/8IZhUE02vz5aY=
X-Google-Smtp-Source: AGHT+IFG6edkwzKvdC/4pz+BakNrOf33Chq4NfoA/aUcggFgEyw3+ChOFWavfks0XHE08gJyxzIz8A==
X-Received: by 2002:a05:6830:6705:b0:71d:3e4d:becf with SMTP id
 46e09a7af769-71e3ba3a756mr6078411a34.27.1734289784325; 
 Sun, 15 Dec 2024 11:09:44 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 50/67] hw/rtc: Constify all Property
Date: Sun, 15 Dec 2024 13:05:16 -0600
Message-ID: <20241215190533.3222854-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/rtc/allwinner-rtc.c | 2 +-
 hw/rtc/goldfish_rtc.c  | 2 +-
 hw/rtc/m48t59-isa.c    | 2 +-
 hw/rtc/m48t59.c        | 2 +-
 hw/rtc/mc146818rtc.c   | 2 +-
 hw/rtc/pl031.c         | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/rtc/allwinner-rtc.c b/hw/rtc/allwinner-rtc.c
index 1057d6a57f..838db72136 100644
--- a/hw/rtc/allwinner-rtc.c
+++ b/hw/rtc/allwinner-rtc.c
@@ -311,7 +311,7 @@ static const VMStateDescription allwinner_rtc_vmstate = {
     }
 };
 
-static Property allwinner_rtc_properties[] = {
+static const Property allwinner_rtc_properties[] = {
     DEFINE_PROP_INT32("base-year", AwRtcState, base_year, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index a6dfbf89f3..389f192efa 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -286,7 +286,7 @@ static void goldfish_rtc_realize(DeviceState *d, Error **errp)
     s->timer = timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
 }
 
-static Property goldfish_rtc_properties[] = {
+static const Property goldfish_rtc_properties[] = {
     DEFINE_PROP_BOOL("big-endian", GoldfishRTCState, big_endian,
                       false),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index b642b82680..51f80d27ef 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -77,7 +77,7 @@ static void m48txx_isa_toggle_lock(Nvram *obj, int lock)
     m48t59_toggle_lock(&d->state, lock);
 }
 
-static Property m48t59_isa_properties[] = {
+static const Property m48t59_isa_properties[] = {
     DEFINE_PROP_INT32("base-year", M48txxISAState, state.base_year, 0),
     DEFINE_PROP_UINT32("iobase", M48txxISAState, io_base, 0x74),
     DEFINE_PROP_UINT8("irq", M48txxISAState, isairq, 8),
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 90299ea56f..5a2c7b4abd 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -618,7 +618,7 @@ static void m48txx_sysbus_toggle_lock(Nvram *obj, int lock)
     m48t59_toggle_lock(&d->state, lock);
 }
 
-static Property m48t59_sysbus_properties[] = {
+static const Property m48t59_sysbus_properties[] = {
     DEFINE_PROP_INT32("base-year", M48txxSysBusState, state.base_year, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 8ccee9a385..973ed9914d 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -960,7 +960,7 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus, int base_year,
     return s;
 }
 
-static Property mc146818rtc_properties[] = {
+static const Property mc146818rtc_properties[] = {
     DEFINE_PROP_INT32("base_year", MC146818RtcState, base_year, 1980),
     DEFINE_PROP_UINT16("iobase", MC146818RtcState, io_base, RTC_ISA_BASE),
     DEFINE_PROP_UINT8("irq", MC146818RtcState, isairq, RTC_ISA_IRQ),
diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index 563bb4b446..1dc8e6e00f 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -319,7 +319,7 @@ static const VMStateDescription vmstate_pl031 = {
     }
 };
 
-static Property pl031_properties[] = {
+static const Property pl031_properties[] = {
     /*
      * True to correctly migrate the tick offset of the RTC. False to
      * obtain backward migration compatibility with older QEMU versions,
-- 
2.43.0


