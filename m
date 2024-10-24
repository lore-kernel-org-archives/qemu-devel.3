Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967ACCE8E7A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 14:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3yRY-0007CZ-56; Thu, 24 Oct 2024 10:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yRD-00078r-JN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:53 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yRC-0003ww-55
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:43 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso120046166b.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 07:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729778620; x=1730383420; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hbU95iGb43ykjR6uVl1fMgZcXOfT8jfUmlrwgLmbMOQ=;
 b=X+iPHOIFgB8rwSu4oe5M/bIl1rtDoPymBneOA6eRH/SGvGyvOYlGn9Zer/6QEhO/bc
 Lmtk6ULwbBCOhwo6mOfWopwayFJ6Kwe0qj53zwrahnS40IqbJRCKxcVdiHM4UWQunIXK
 Zdq4W1oxNxhjlN7eySIzgy/F4b0/m5JhIJsXkd/AsTwd7xRgxrW8LHcXRMT7CxbkeWAY
 TG0eCyibaeuzGRsgCwZolIAns9DGJXnpST87XfVfPIo3lnnYgKTu1ifquT/GTW9J3sB3
 V1UDliBMO4v1P2L1nKKPw79LrRfUN5G9T71UqZG/oYDJrvBm7p8WxcSIjTbn8QnLbBKH
 u8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729778620; x=1730383420;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hbU95iGb43ykjR6uVl1fMgZcXOfT8jfUmlrwgLmbMOQ=;
 b=BT3yvV9/gGSyGR5apfSY0MHLZFlPA7rKagLdmkTpeaw80EuHrJOOC5xvBl8ibMFIWf
 zK3QOCSRbmdUs6Wm4GfJhVEU5TFLB+Nf72hYkbsrsX/ILztzf4tz3pHOaM70HBNsyoU6
 BLXWAuApnZaMXe55NFbZOjFDFxqXjmT0vU6sTtEM/d4fNT8rGpTQV8R1kH5J+S4YSiOl
 Urm7SfB1FlliHBIEHFZ1k5R1fU74T7PC3bR4eHs8bW9EKens8GWf4MRkOLCGgiGS5/O7
 48KD71MG+ewlmlMkh9MTFGzMimY+YTBc1QGIRimipWkHHmjq+R3s8V0e7E4IJVCTJO3L
 c45Q==
X-Gm-Message-State: AOJu0YwNxGiwuAViVhmLkuTZg5HHCaCc7BT4P8otjfz2AXeV4IXtiEAe
 BuOl+83/A/9arsOwkqERL8UhdgculCwwyH4u4a0eUS5FK1K0nht/IKP8YIhPRCo=
X-Google-Smtp-Source: AGHT+IGhCxLJqvJjntDHNM49xQFQgHimhRC45q6AuV8nHKxtr49b04s9hnT4dgW9VYj1o7UoyDb3PA==
X-Received: by 2002:a17:907:7e8d:b0:a99:fb10:128e with SMTP id
 a640c23a62f3a-a9ad275718amr213407166b.36.1729778618544; 
 Thu, 24 Oct 2024 07:03:38 -0700 (PDT)
Received: from [127.0.1.1] (adsl-113.37.6.2.tellas.gr. [37.6.2.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6878sm621407566b.86.2024.10.24.07.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 07:03:38 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Oct 2024 17:03:03 +0300
Subject: [PATCH 05/11] rust/pl011: move CLK_NAME static to function scope
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-rust-round-2-v1-5-051e7a25b978@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=aBBqr/qTxXGjUVQdy1uoZ/LYcMTQXrtSqv1QzWzz+ig=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5HbE9qZXdsVi9FOC9ONWVmUXJkQkJyenZIOEhaCm11d2xNL1k4blRaQXZiQVEw
 U1dKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnhwVG93QUt
 DUkIzS2Nkd2YzNEowSG1KRC80bHpOTFZDL3hMQTRyOE8yMWs5OVM1S3pWZWNXZUViOWJDbFAwMg
 p1ejd5V1IvMGxyTERCakdKbUJGLzFTQ3BQV2RBMWJVV1FybytwQVlsNE0rbzcxRUpuaVgyQ1EzQ
 085R1NHK015ClZBVWVoZERZVnF3TnNBYkgrN2NsemtxeTNwNlZBU3pRcStLUi9oOFlWYVNDTG5M
 cHlsd0R2L21abldQUHk3Q0oKNVh6UkRybnhHNDBnSkJmdHZTckhNY25HQm9jaVg0RDU3SjFlRDh
 TSFRsYU9HYjJTUGxaSHozQmdMdzkweEVxLwpaUFFHbUlldlZaWjl3MExKRGtES2ZlakZRc1FzZ1
 Z1eDVnUUFxSUxIaThuV1FCYjhxMkRyeGI4RDFqSFlVbFJRCi9Md2NQVmRaM05sZ2pFcDVWNEQ5N
 lNsbXZYV0xYQmpHWStadW12UDR6SnVVVmJQYWZCZU54c0h1US9MRmxtQUMKeWdNakNOaUtBQ0Nn
 OERwblNvamRUemF4VGxlanpGdmJJUGVnUVROWGhwRmhYOC9KeklQdm5UVnBkVHltcSs5RgpPUTB
 td21xeHcrcE42NlRMYzBBbW83ZFdCWE1CVEx6L1pQYmh2U1o1azN5S21xN01OeDFrOWM4WkdVMW
 IvTVoxCnNaYU41eFkyeFo5ektxUXNGZDVzODB4YkpvdEE0Lzc5L29RV3RHVW9nM1lobVlqUmFJS
 VFDQ1dWTDBKSjRlN1MKL0lBRGMyc2Y5WGxjajk0d0NnRGQvMUVzMjBWZ2hnVkxUczByUENzWndT
 RTNvYUFpMWpBUXQweDZhaUdndGNRMwp6azFtbjJPY3NobXNVbkdGRWVWU2tXMkJ6R3pQdU13Q1V
 oSjNpblpYK3BoZzRteStxYkVjb1FEeGNoR2gyNFJYCkF5QndzQT09Cj1iTEExCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x630.google.com
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

We do not need to have CLK_NAME public nor a static. No functional change.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/hw/char/pl011/src/device.rs | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 57dc37dadef631fbccfa3049a3d8701b4e62b5b3..115786f9fa7f03c16cd44462cb7df5623ba3a6d7 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -152,6 +152,8 @@ impl ObjectImpl for PL011State {
     /// location/instance. All its fields are expected to hold unitialized
     /// values with the sole exception of `parent_obj`.
     unsafe fn instance_init(&mut self) {
+        const CLK_NAME: &CStr = c"clk";
+
         let dev = addr_of_mut!(*self).cast::<DeviceState>();
         // SAFETY:
         //
@@ -255,9 +257,6 @@ unsafe fn post_load(&mut self, _version_id: c_int) -> c_int {
     }
 }
 
-#[used]
-pub static CLK_NAME: &CStr = c"clk";
-
 impl PL011State {
     pub fn read(
         &mut self,

-- 
2.45.2


