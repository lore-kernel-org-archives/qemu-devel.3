Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A8CE77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB91-0000wa-Lv; Fri, 13 Dec 2024 14:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7I-0007Cb-0n
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:24 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7E-0007aH-IV
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:23 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3eb7edfa42dso1064065b6e.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117257; x=1734722057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgBXSP9FXNsZoJNxDWIf4VlbcOnRZTVxU/IcB0k/jaw=;
 b=XCC4Vo/LtVl6m92Q+zGZPtC4vuRueL/Uct97xqSgnUeVNtX8KMQ9JtcETaSwhtVXCb
 Oca0UnsEFFcsZQ/x3Wphwqztxwj+F1ukAJxqG9LhdZuHt5wVcDLmejiH5FZ6ILUcKsws
 zpIr8P+n50PsMYiVt7sD/ZKRk37Fff2xnsQEiCH17EkeeRtrqD6/EJVKuMRPMT0f6rNV
 VxflSOv4irLjMRSmtvIBiFKGFsqqnye+Dcv6w0z9IuQNE4QpSgTOC97/yBFSYxf5GcBp
 R5wpNzw91R2hv7B/6LsMBm0B9g59V0bODjOpGhmFGllZQObzcj8ws2VO3KmrwrXH+Dyv
 Yt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117257; x=1734722057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgBXSP9FXNsZoJNxDWIf4VlbcOnRZTVxU/IcB0k/jaw=;
 b=ATKOrOOSOVC0Njo5u8p0Oo7AWx7fKk7ZHYkFSa6of0xF+4M7ksUA645RWH9CRbiVSR
 uJlT7AjKNdIF9lCBqEsEZ1IDcnUB9nYK8TDPff8e02H+ZDJyiG98ITPHWsTlvnCyswvu
 aoNXz0QfFAruGo7m7ncE2YPsldWhgf91CNjDCTILkVPABjE0seW/hyr6Ev9r4c0lfTYS
 BVR6Q6gI2qT3EtCfAUaDoLkYibN+oHG3mac/5WKVGx8BnglUyzmlYYH5CU78qFa34mEJ
 bQ6TMJDsQyx8DHOyq6gUC7z1SRzEgvkDSzrv0sibKUfdBB3Wi8x5wUDO2AlaUzDXhaBG
 4g/g==
X-Gm-Message-State: AOJu0YyGR7L2R5VCPv1JRBpdzR25thjIKZ4/lZoZ3bOO1T21P0j7vwfr
 sacvtCBDzicS+CmVG2/0ITmNPV3uLdTKz9gusjMBbfp11fvFwNMdClZ/FSlhovlCjPPgEq+07vN
 Hv+MILb1s
X-Gm-Gg: ASbGncsZefSbOXKoJyDwsL0mRQDKYbPhesxR1nIl3/NmZHH9Qw8dbzmXwwXWe5cfPHn
 cqobo+dpiTI1UoJ3o5w24ZlFtSj5ynDmPaJuXCu8rh8zcgtQXBq8Af04w+bZmdhviRGpouER7eA
 Dd9ODPIhkz0tzCjjtwETOmL4T538ooMdEa4rnwtIMhavH5XGUQ8jceWzKUTij+1dAHE41rk1KEy
 YxtIkemdJhFsCPMUY6IcOZ4yJuBQlETGlPbFdPDNkyrEI5ne+mmPvgsYHw5nWYJ
X-Google-Smtp-Source: AGHT+IF6xJ9YwplBiPlVyQaE0cO10s3mBQ5ANS6Yqc4LzVYvpA/0q4/VsxFKqm/Sp4TR4Xh9JxZtSw==
X-Received: by 2002:a54:4082:0:b0:3eb:695f:5382 with SMTP id
 5614622812f47-3eba686467bmr2111806b6e.13.1734117257266; 
 Fri, 13 Dec 2024 11:14:17 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Anup Patel <anup.patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:Allwinner-a10),
 qemu-riscv@nongnu.org (open list:Goldfish RTC),
 qemu-ppc@nongnu.org (open list:PReP)
Subject: [PATCH 52/71] hw/rtc: Constify all Property
Date: Fri, 13 Dec 2024 13:07:26 -0600
Message-ID: <20241213190750.2513964-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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


