Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F8FCE8E78
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 14:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3yRX-0007CO-E7; Thu, 24 Oct 2024 10:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yRH-000792-6V
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:53 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yRF-0003xB-Hs
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:46 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a99ebb390a5so383654866b.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729778624; x=1730383424; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WITWBs3eKYPfFgEanUhD+BoP6AjEmCFyXtxJHZOASQo=;
 b=eQDGlCVyR+czNw0e67pIM8U3C414XJb/npqTkn/7jCLbgu9FEfeAD37DSDKFvYGSeI
 n+x0N4qC4f7iKhrteoVy+0Sha8u/1mHgrPLRVzb1AY5+FT1DTgEjjm9paS5TM7Y2PjP+
 wlmU6CZlAHBA1aZEkbY3aKuGdolOBOzyh0Cy9rKSdCCh/lkmuhhA8CgFUVuNDQ3bjwLD
 aBn2NKPdOtD4kt5m/sv2JaMS/QDdkh+R4i/OT7khSYfiR75hQTB7wVuZeF6icOdcwspb
 T2Hbv/6zYpHomx/ua4ckJDtIPAxR9PA+PJhdGIDnBIx8NYK1zHr3+wmrEKWH+SQHxFW4
 rXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729778624; x=1730383424;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WITWBs3eKYPfFgEanUhD+BoP6AjEmCFyXtxJHZOASQo=;
 b=eTOdGpuraLvzcgXeEd/a6G7ccCmR6nDXoOvc7OaELvznl4LLJ4QBYQ89u5fwcBGerQ
 latioMl2dbQmM0TVtjY/eWT+eivxfjJw9Oju85LQ5NIKMcbFUz2+JtlqNkLDRSUgr+dh
 arSGGCPrLCMz5/5hUxhIOuA/eBmCroqmIgJWX++G2egY84Evl2XCe9wm83G20Z3Pot6G
 KpkR20Ch4F24162JIBaycADPSdy2NWjnIN+YrHyNrFolxE+/aPRpWxMTccT8NzO4SYJU
 u7nJsEEiKkGWg/EqqRnbH3nvacDZroskVasRDZhzZ/LM9+aKi4KtjeVWjIkw4MKGkh/e
 YwHQ==
X-Gm-Message-State: AOJu0YxtUfQ/L7ZGa/OL0uiER6VMg4B1xaMn75dcUDb5BYWRWl/IZT5p
 3a2lCLprUQmQrz2S5lOJJ8NyXxvD+6Yokz8+p2HxsovdCDv9dn9xtwU/rt4ZhXY=
X-Google-Smtp-Source: AGHT+IEMYBiQMjr2BL3EoE9SxB2HcVAYOfP34g8IZx7/rITMhbDhJHUlXGemCYov7ZZm+VDQG/Bl5w==
X-Received: by 2002:a17:907:94cd:b0:a99:5587:2a1f with SMTP id
 a640c23a62f3a-a9ad19c145emr259934166b.15.1729778621456; 
 Thu, 24 Oct 2024 07:03:41 -0700 (PDT)
Received: from [127.0.1.1] (adsl-113.37.6.2.tellas.gr. [37.6.2.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6878sm621407566b.86.2024.10.24.07.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 07:03:40 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Oct 2024 17:03:04 +0300
Subject: [PATCH 06/11] rust/pl011: add TYPE_PL011_LUMINARY device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-rust-round-2-v1-6-051e7a25b978@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4216;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=hUIDgKKomo5D5BKIdaGye033FBHKY8t65zO/UI15g8k=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5HbE9qQ2lVMlh0SVNieTVIa2pFNGwwTjVIMDFBCkptQkZrTGU4U01GakV5aGN5
 d2FKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnhwVG93QUt
 DUkIzS2Nkd2YzNEowQTAzRC85a3NsRFlPelBPbll2RFdleFFkRnJTTXYwelllNytWMWFZOHh2Rw
 oyeUdNZDl5b2E3SGV1VTVTWjdqbTN0SDM4TUtrSE1qZVExWFFmVWYrTHVraEZNYjNBUWQ5TkNnM
 jJTNDJ1anBQCmt3bldxWldnY2YzcnUzMTlaRDIzMGFaUVB0RDVqNlY1MkpCbHdFR0o1SFhMWEEz
 eWQ4eDVjb3V5UzZJQXFLeTEKOFA2b2ZieFM0SnQ3WEhXMm9mL0p4VnVNS2wveWgzNkFRUzRVdEt
 FT2daSU1IQklaZzI0eTVWT01SeENPdW5zbQphZHlCMHg4clBlUUdIZmhRUkFxOG1GNGhHWlVpaH
 R1QlJPYjVXUi8zRnlCQmRsZGtmUk4wTGtROE9CK0xCczJTCjQ0ZmhDN3MxN251d2UwNlN4UVdxZ
 HNRdU96aUE0VXgyWCs5YnFqQ3dJY2JlYmo4S2dMWjNJK2U4UVdCWUdLcloKeElWd2FFRnkxNFRL
 L1FwejloNDE2Zk5mcHMybkMxYkV1Ky9PZm9TOXlIbC9SVHlWUitNTVAzckVwTUIxNUQ1NQpRWXh
 ReEphSm42Z2l5Y0cxSU9ZN3ZUblhVQnlmUWtYWFdZMEdVUzR6UTlIK3NtdHJlKzdjYm0vNm5oQm
 NsSm80ClBmNmd4cHJoNStKdXdPTUg4V3NwQzBsR0xOdk1oc1hHV0k1eUlCaTNtUW9XZTZ0dytCR
 2pqYmU1aytNV2V0TmYKaFNGMm9ZUDlvRzJ4by95NG5UNVF3bitINUZYaHVVUnZ4M2lZWWR6M1BL
 MVFyWkdINGtPRGpwMFpkM1RiWWI3aApmYVoxOU43dHVkdUh3NXFNUllnZG1hRFQ2SFZsdHNRRnh
 GbmJhQXpVbkZ4cWQ1UndvZWZ5TUhiWTEzRmZXbE5DCmhHMi9TUT09Cj1iT3FTCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
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

Add a device specialization for the Luminary UART device.

This commit adds a DeviceId enum that utilizes the Index trait to return
different bytes depending on what device id the UART has (Arm -default-
or Luminary)

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/hw/char/pl011/src/device.rs | 59 ++++++++++++++++++++++++++++++++++++++--
 rust/hw/char/pl011/src/lib.rs    |  1 +
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 115786f9fa7f03c16cd44462cb7df5623ba3a6d7..3aa055dee4b10866a624505a9d05ef1ab8182dce 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -20,8 +20,6 @@
     RegisterOffset,
 };
 
-static PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1];
-
 /// Integer Baud Rate Divider, `UARTIBRD`
 const IBRD_MASK: u32 = 0x3f;
 
@@ -64,6 +62,29 @@ extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
     };
 }
 
+#[derive(Clone, Copy, Debug)]
+enum DeviceId {
+    #[allow(dead_code)]
+    Arm = 0,
+    Luminary,
+}
+
+impl std::ops::Index<hwaddr> for DeviceId {
+    type Output = c_uchar;
+
+    fn index(&self, idx: hwaddr) -> &Self::Output {
+        match self {
+            Self::Arm => &Self::PL011_ID_ARM[idx as usize],
+            Self::Luminary => &Self::PL011_ID_LUMINARY[idx as usize],
+        }
+    }
+}
+
+impl DeviceId {
+    const PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1];
+    const PL011_ID_LUMINARY: [c_uchar; 8] = [0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1];
+}
+
 #[repr(C)]
 #[derive(Debug, qemu_api_macros::Object, qemu_api_macros::Device)]
 #[device(
@@ -134,6 +155,8 @@ pub struct PL011State {
     #[doc(alias = "migrate_clk")]
     #[property(name = c"migrate-clk", qdev_prop = qdev_prop_bool)]
     pub migrate_clock: bool,
+    /// The byte string that identifies the device.
+    device_id: DeviceId,
 }
 
 impl ObjectImpl for PL011State {
@@ -267,7 +290,7 @@ pub fn read(
 
         std::ops::ControlFlow::Break(match RegisterOffset::try_from(offset) {
             Err(v) if (0x3f8..0x400).contains(&v) => {
-                u64::from(PL011_ID_ARM[((offset - 0xfe0) >> 2) as usize])
+                u64::from(self.device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) => {
                 // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
@@ -660,3 +683,33 @@ pub fn update(&self) {
         dev
     }
 }
+
+#[repr(C)]
+#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::Device)]
+/// PL011 Luminary device model.
+pub struct PL011Luminary {
+    parent_obj: PL011State,
+}
+
+impl ObjectImpl for PL011Luminary {
+    type Class = PL011LuminaryClass;
+
+    const TYPE_NAME: &'static CStr = crate::TYPE_PL011_LUMINARY;
+    const PARENT_TYPE_NAME: Option<&'static CStr> = Some(crate::TYPE_PL011);
+    const ABSTRACT: bool = false;
+
+    /// Initializes a pre-allocated, unitialized instance of `PL011Luminary`.
+    ///
+    /// # Safety
+    ///
+    /// `self` must point to a correctly sized and aligned location for the
+    /// `PL011Luminary` type. It must not be called more than once on the same
+    /// location/instance. All its fields are expected to hold unitialized
+    /// values with the sole exception of `parent_obj`.
+    unsafe fn instance_init(&mut self) {
+        self.parent_obj.device_id = DeviceId::Luminary;
+    }
+}
+
+impl DeviceImpl for PL011Luminary {}
+impl qemu_api::objects::Migrateable for PL011Luminary {}
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index f4d9cce4b01f605cfcbec7ea87c8b2009d77ee52..5516e018b4bfebe5175c515e5aa4598f54b39dfc 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -45,6 +45,7 @@
 pub mod memory_ops;
 
 pub const TYPE_PL011: &::core::ffi::CStr = c"pl011";
+pub const TYPE_PL011_LUMINARY: &::core::ffi::CStr = c"pl011_luminary";
 
 /// Offset of each register from the base memory address of the device.
 ///

-- 
2.45.2


