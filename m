Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500CCCE8E7B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 14:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3yRX-0007CN-DO; Thu, 24 Oct 2024 10:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yRU-0007AI-EJ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:04:01 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yRS-0003y1-Q1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:04:00 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-539f58c68c5so1719687e87.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729778637; x=1730383437; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=10FS6ba90SAfmfgqA/GoqytJLsUTvwlTO03Bcs2OdSo=;
 b=t7E4R9dyiCoCeNrMyEfiuapGVXLjaVV3VMQVhXIJ1FVZLliNLUiAxWIGYduFtBS3M7
 enzpo9ndmAKvti2vr1MW1olYoJ06ArQw3yAx8kd/6//LQI9fLz+rpRnHBiWzbYagqomH
 BUTwyNHiBP5xmfM4fDkeEpVWHGCYl9AnDHkCFP7ltxlFFQdao+KJb9dQYQI9kyFuehz7
 hit1SLU7P+pNjbjydJJLZUftf9Xc4V/nUU/8ylm/QrKMLSz5Li8ghHv1bIxiClBpQUmd
 eDyFJewGX1axLd3WjPhPPa2ye4Yi6LbH76JHtn3X0os4qIneAc/vDT0ijT/5xs6P/eGY
 okVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729778637; x=1730383437;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=10FS6ba90SAfmfgqA/GoqytJLsUTvwlTO03Bcs2OdSo=;
 b=JiHXfpSj0P5GWmVW9eIaBsSVIvyUK7Hm5hRPWFNs3xwb6yTg+t9dtHoS5xAuc5AUqC
 bakr9T76yxU5Eig1ATARBNyCVjdHn/zlZysLfM/woeA4hzYduD0Aju/6icULRDlflrhK
 L2BVIhZeP2sTe2b/Vm1dtaXp6ORll/b9Bc5erZepEN2pyqDTXOcG1tQ8TsNroAVz7Gvi
 wuwugKBN5d8qa/4tdphwToh+V6v1AlrTafDsYC/RJ8uMYNcAjRoV+95UnULjGeoSq17i
 xYjrRuDAaetsl8xtfWrIsZREMoGf7/leS/p2zif9mOH0Mn3+heNOLJwgjx9kJSMLs9G+
 LATQ==
X-Gm-Message-State: AOJu0YxUgD6D77bW6h1cYY8n56GM/wFLXrH7JgXuJNTJNgAVnepVYKDs
 15GeJboLG+vSe4U+R8ZA5nF5U6vgEH6mqk53CI2eCV/vHtFG98EdzIi9iY8KTxU=
X-Google-Smtp-Source: AGHT+IF/X6Ld09RtROSNXWtaw4b8x85ob/Ww0GPDmQEOLwkcFq3XSO+EWSUbg/IhA25BoWQkhro2Wg==
X-Received: by 2002:a05:6512:104c:b0:536:53e3:feae with SMTP id
 2adb3069b0e04-53b1a315e5bmr5989441e87.11.1729778634976; 
 Thu, 24 Oct 2024 07:03:54 -0700 (PDT)
Received: from [127.0.1.1] (adsl-113.37.6.2.tellas.gr. [37.6.2.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6878sm621407566b.86.2024.10.24.07.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 07:03:54 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Oct 2024 17:03:09 +0300
Subject: [PATCH 11/11] rust/pl011: log guest/unimp errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-rust-round-2-v1-11-051e7a25b978@linaro.org>
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
In-Reply-To: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>, 
 Junjie Mao <junjie.mao@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: b4 0.15-dev-12fc5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3497;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=7/quJHuk1AVNPeKw9d+kvD8KhgiKTwdd6ez7kP/JrJw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5HbE9rMGpsSGgzQ1FTLzI0UEliREVZTTB0WTlFCjNsaXBqempXNjhrcFN3N25G
 M0dKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnhwVHBBQUt
 DUkIzS2Nkd2YzNEowQVRYRC80eGduSlhmcEkvWTJrL0lEWitIVUZSRlFyWHRQNExWWWxkUWxyQw
 pnSXZjclVEelErdmlabkdTQkVMcGE5c1dYajFIUk9lSGVoRFZGMCsyZ0o3NlFhSkFjL05UZ3Fvc
 GQrNTVweDZKClBDbDgrWHdJU2FBZjFJWkJqZlA0anRobzhvZzZCbWJTcTNOVlB3WmkvZ3A2M1BE
 YWc2Q2U3SGwzbkxOa3EvVCsKcGNJOWNobU5YS1djUThvd0ZCS0VIMkt4ZGFvYlpZeHB0dy8zUjQ
 0VTZ4SGM3eXJnNW9jREp4dkpaRGwxM3BsegpndFhHOEpaUUNCWmZ1K3dOUjFWQWlMcmZhbG9UbV
 JzRWZncGNrK2ZHZ0FkRzR0Uzk0bWpWVGltd2RoS2owbTBCClB2QVNlY3ZpNWh2N0ZOdGVZVWhOd
 2Z3OERCeExDcEg3WXA1dENwZEdvZWtJYW81UHhTMUZlTXQydDNJYys0djUKM2RSVE1uUXY2UXBE
 WlRvWGxpa1E2dWVJWHBPMENPTTJrcDNpVjRVd3kxRDdmVThrVURCYWZVWU5MTjVMRlh4aApGaWE
 wV3Fsc1V5OWYrQjkrRVdHQ0xZV3ViQXZ1YytWTmRMUW84dXpvRktkaW1GNCtBZ1p5SEVHaVRNS0
 1yR1VwCmFqRGpZT3Zia3BkTXg5eFEySiswSzJTdXk1SElaV0MvTmkyMDFSRkVPemxsKzB4bEh6a
 ExjMVByK082UWovYngKYmptQUtGZ2FVKys0QW93VFM3YzJuRkszend6T2ZtWTlhMXhTcVNFa3Vz
 UlpPUnl5aGNHSGg5L1d0M0xOYkwzQwpMdzhKL2Y0dDBKOTcxMVdaYTdsNS9wbElQcFQvczREeW4
 vbTdtZFdDcFcrTHRQWCtUdU9jWkdvb2xwZFJKcndqCmRyVTMvdz09Cj1xanY5Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12d.google.com
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

Use the qemu_log_mask() functions introduced in previous commit to log
errors like the C pl011 device does.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/hw/char/pl011/src/device.rs | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 6d1353dafc14bfe73703b5cff7e1ff7659de220e..57b38f44f90d74d0c1a94bb9144eff08db94fadf 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -9,6 +9,7 @@
 
 use qemu_api::{
     bindings::{self, *},
+    log::*,
     objects::*,
     vmstate_clock, vmstate_fields, vmstate_int32, vmstate_subsections, vmstate_uint32,
     vmstate_uint32_array, vmstate_unused,
@@ -343,7 +344,14 @@ pub fn read(
                 u64::from(self.device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) => {
-                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
+                qemu_log_mask(
+                    LogMask::GUEST_ERROR,
+                    &format!(
+                        "pl011:{file}:{line}: Bad offset 0x{offset:x}",
+                        file = file!(),
+                        line = line!(),
+                    ),
+                );
                 0
             }
             Ok(DR) => {
@@ -389,15 +397,30 @@ pub fn read(
     }
 
     pub fn write(&mut self, offset: hwaddr, value: u64) {
-        // eprintln!("write offset {offset} value {value}");
         use RegisterOffset::*;
         let value: u32 = value as u32;
         match RegisterOffset::try_from(offset) {
             Err(_bad_offset) => {
-                eprintln!("write bad offset {offset} value {value}");
+                qemu_log_mask(
+                    LogMask::GUEST_ERROR,
+                    &format!(
+                        "pl011:{file}:{line}: Bad write offset 0x{offset:x} of value 0x:{value:x}",
+                        file = file!(),
+                        line = line!(),
+                    ),
+                );
             }
             Ok(DR) => {
-                // ??? Check if transmitter is enabled.
+                // Check if transmitter is enabled.
+                if !self.control.enable_uart() {
+                    qemu_log_mask(LogMask::GUEST_ERROR, "PL011 data written to disabled UART");
+                }
+                if !self.control.enable_transmit() {
+                    qemu_log_mask(
+                        LogMask::GUEST_ERROR,
+                        "PL011 data written to disabled TX UART",
+                    );
+                }
                 let ch: u8 = value as u8;
                 // XXX this blocks entire thread. Rewrite to use
                 // qemu_chr_fe_write and background I/O callbacks
@@ -474,8 +497,10 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
             Ok(DMACR) => {
                 self.dmacr = value;
                 if value & 3 > 0 {
-                    // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemented\n");
-                    eprintln!("pl011: DMA not implemented");
+                    qemu_log_mask(
+                        LogMask::UNIMPLEMENTED,
+                        "pl011: DMA functionality is not implemented",
+                    );
                 }
             }
         }

-- 
2.45.2


