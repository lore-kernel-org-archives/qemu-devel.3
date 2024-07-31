Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D9EC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 09:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ5yE-00051M-RD; Wed, 31 Jul 2024 05:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sZ5y9-00050j-ED
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 05:50:05 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sZ5y6-0007u5-D1
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 05:50:04 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7a94478a4eso144234866b.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 02:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722419399; x=1723024199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ywDRHfZggrLOa3AidazXf0ImyOnlcAe2cGNjfEmiPEk=;
 b=yizHdTnAneyyyPbvqrpmMC5Yzhvz0l7VXXfhBRzrJVjl9Zyf2SbQCXkGr9yUCfcQ5J
 NiXT7nqFHftequtmgP56h5X0/xP/zp0Gi9i18MsriACyW3X7QuVf9oxfvalMkaXGNZbQ
 +VpvYD8fYokE6VuarjqqON6lTEYAb2WcvjXjyl5csiffQrYhDHEw6tiiBa0xCGOVQO5y
 N9acPFAf/cGIKz7L39fu+CPtCX3TjYCZK6EYDpDJRoWebQKVM6aQ7q5YFWK+I4oUKu9V
 OkEJ5PsvELkofDuRi3xXix7cZexx8vUDpuZoIw/1UoCDuzTLWY9/HdzucaW/ct6llO2j
 7D5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722419399; x=1723024199;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ywDRHfZggrLOa3AidazXf0ImyOnlcAe2cGNjfEmiPEk=;
 b=ejUHoHc8VMvdoq4ggI+73IaXybpxhlpAsJNo4KMygfGD80dwTWSW7EMiY5MFBREKCa
 3gMO1jdQKXbWKLYQqe+UgMGk7o3vouHkoqM6TvIpFumDuuhoYmaT629PvQ2Gp5bCalXW
 PTiL0L1fPWkCUSsnZC3/MOZm5Q+g3VADui69ZM2DSrU80uyZAVk8p8YuDMlg4Ax5s+kS
 Q10GmgUd+xHm/ZeWC0RfJhYajD8ExdwvrdM8msLpGYxjLoC5tdL8yq9ImYrECjU+3bAd
 DyEjYk9nZaGr4rsdDJAes4D+yZif4OFVpTwHKRSipIFt/8kJ9PYmXS8bHGxlv+ayRZO/
 0urQ==
X-Gm-Message-State: AOJu0YzKaAZj70c2LKyNQWNnjfNSSGwNBo8Od+kj8UQ9IAXl8EY21gXw
 q+sf8r55YHP5Jpc+TE8jiUuRDZJy53KHll8ytNbgn/O84KmivCeyohEI8jHjYPg=
X-Google-Smtp-Source: AGHT+IFoQLOQFIvtRDRHcx7MEvI7NZj7QFDCvnL9pro8ZTqYWUIC9/lADIvrU1pwxhs7LHLzdscLbg==
X-Received: by 2002:a17:907:7249:b0:a7a:b18a:69 with SMTP id
 a640c23a62f3a-a7d8590d130mr431073266b.10.1722419399443; 
 Wed, 31 Jul 2024 02:49:59 -0700 (PDT)
Received: from meli-email.org (adsl-146.37.6.160.tellas.gr. [37.6.160.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad411a6sm739844866b.117.2024.07.31.02.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 02:49:59 -0700 (PDT)
Date: Wed, 31 Jul 2024 12:41:08 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v5 0/8] Add Rust support, implement ARM PL011
User-Agent: meli 0.8.7
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <bc27a983-f0b7-4803-96f7-060a4a331348@redhat.com>
 <h4gxy.dr366knvycy@linaro.org>
 <CABgObfZOqBogWQtzfghjKMsW-J_sp-iL5dt7mmYnvE5eQb9G5w@mail.gmail.com>
 <h61ku.ipxyjqsxu75@linaro.org>
 <CABgObfa-dxDD_oVGu8PrQffVhvP=MFifUUTinC-brzTnqdkK0A@mail.gmail.com>
 <h6cgm.o8scn84hx1ry@linaro.org>
 <CABgObfbyw0qPM_T=SpGyHYD02x2jOdSy5nfwKpOx-WruhkJe9Q@mail.gmail.com>
 <CAAjaMXY3jL=cVs=e+6kiJw_WrfG5vOaqaNFu74BdoK2-bO7ZLQ@mail.gmail.com>
 <CABgObfb27wbwgErFsMdsuSo1BxQVBoRfbrUmK2k-x5Ya3ez0TA@mail.gmail.com>
 <h7zb4.aog50x8tfxkp@linaro.org>
 <CABgObfbJjcwXcJ-=c7yfXQX=xLnqqVsvDqibrFgiLPm4C_uC6Q@mail.gmail.com>
 <CAAjaMXatq0jGrght=Fc-7TpZvuGzirhWyKsAsCRq1BW_U_CW=g@mail.gmail.com>
In-Reply-To: <CAAjaMXatq0jGrght=Fc-7TpZvuGzirhWyKsAsCRq1BW_U_CW=g@mail.gmail.com>
Message-ID: <hhfb9.99e4vl1r79fa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
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

On Fri, 26 Jul 2024 12:26, Manos Pitsidianakis <manos.pitsidianakis@linaro.org> wrote:
>On Fri, 26 Jul 2024 at 11:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> As I said, I don't see the point in discussing this more, and I'm not
>> going to unless you provide a clear pointer to documentation that
>> states the opposite.
>
>Same here.

Next patch series version is taking more time than I expected because of 
unrelated issues, plus I'm on PTO these days, so I am posting the 
resolution (which I hope satisfies everyone) here early:

It's possible to refactor this code (and any other similar cases) to 
prevent recursive mutable calls:

diff --git a/rust/hw/char/pl011/src/device.rs 
b/rust/hw/char/pl011/src/device.rs
index 3643b7bdee..449930e34e 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -104,10 +127,14 @@ pub fn init(&mut self) {
         }
     }
 
-    pub fn read(&mut self, offset: hwaddr, _size: core::ffi::c_uint) -> u64 {
+    pub fn read(
+        &mut self,
+        offset: hwaddr,
+        _size: core::ffi::c_uint,
+    ) -> std::ops::ControlFlow<u64, u64> {
         use RegisterOffset::*;
 
-        match RegisterOffset::try_from(offset) {
+        std::ops::ControlFlow::Break(match RegisterOffset::try_from(offset) {
             Err(v) if (0x3f8..0x400).contains(&v) => {
                 u64::from(PL011_ID_ARM[((offset - 0xfe0) >> 2) as usize])
             }
@@ -134,10 +161,8 @@ pub fn read(&mut self, offset: hwaddr, _size: core::ffi::c_uint) -> u64 {
                 // Update error bits.
                 self.receive_status_error_clear = c.to_be_bytes()[3].into();
                 self.update();
-                // SAFETY: self.char_backend is a valid CharBackend instance after it's been
-                // initialized in realize().
-                unsafe { qemu_chr_fe_accept_input(&mut self.char_backend) };
-                c.into()
+                // Must call qemu_chr_fe_accept_input, so return Continue:
+                return std::ops::ControlFlow::Continue(c.into());
             }
             Ok(RSR) => u8::from(self.receive_status_error_clear).into(),
             Ok(FR) => u16::from(self.flags).into(),
@@ -159,7 +184,7 @@ pub fn read(&mut self, offset: hwaddr, _size: core::ffi::c_uint) -> u64 {
                 0
             }
             Ok(DMACR) => self.dmacr.into(),
-        }
+        })
     }
 
     pub fn write(&mut self, offset: hwaddr, value: u64) {
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/memory_ops.rs
index 6144d28586..5e185b7cd7 100644
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ b/rust/hw/char/pl011/src/memory_ops.rs
@@ -29,7 +29,18 @@
 ) -> u64 {
     assert!(!opaque.is_null());
     let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
-    state.as_mut().read(addr, size)
+    let val = state.as_mut().read(addr, size);
+    match val {
+        std::ops::ControlFlow::Break(val) => val,
+        std::ops::ControlFlow::Continue(val) => {
+            // SAFETY: self.char_backend is a valid CharBackend instance after it's been
+            // initialized in realize().
+            let cb_ptr = core::ptr::addr_of_mut!(state.as_mut().char_backend);
+            unsafe { qemu_chr_fe_accept_input(cb_ptr) };
+
+            val
+        }
+    }
 }

When we iterate the APIs further we will find better idiomatic solutions 
that do not rely on devices themselves to do this kind of stuff, but 
offer interfaces from the `qemu_api` library crate.

Manos

