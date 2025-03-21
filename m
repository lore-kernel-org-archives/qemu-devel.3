Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447DAC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 13:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvcVe-0006Bi-0x; Fri, 21 Mar 2025 09:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvcVR-00069m-Ep
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 09:33:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvcVP-0001LW-TP
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 09:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742564026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bafnxYzDWd4pjZBXNWnbM/3IoRbrrmSrOXQQcOl8zXI=;
 b=FoVU5E0Oc5E7r5YR9oSCg0RRG9OKhv6l+n4tJUXY/hHFe0ceQ+XBaIS/S3Q9ESZSdVG7r1
 kcj2OZzQLH2Z3mHI1p7K8kp4LvK5NmFf/0D9VEbFXFve0k2GcbpFNIfw7fiVJzvkzoeNFg
 1PArUIjTAB3eCk9BWsmjoHeBqGA5C0o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-ZwKP27rWN2iVjtqYjgEBqQ-1; Fri, 21 Mar 2025 09:33:44 -0400
X-MC-Unique: ZwKP27rWN2iVjtqYjgEBqQ-1
X-Mimecast-MFC-AGG-ID: ZwKP27rWN2iVjtqYjgEBqQ_1742564023
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ceeaf1524so12009745e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 06:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742564022; x=1743168822;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bafnxYzDWd4pjZBXNWnbM/3IoRbrrmSrOXQQcOl8zXI=;
 b=Y7MC+Jkz/k13CFHfeGRrif8T1DzB9JtxF2kVhrnFUIRNee39SAwxH75/ZS79rtEwp0
 52fKFRZvDxhr/ypbCn5/kKTGxjaLjzwT0QTFKyTlKLE80R7iduUCEeUteBHM4WZEcvLI
 Bn7vbn9oRBi4Oo3dt4kLIXVHMW0ZFqGxauJVJOpzN81vLqzP54JQ6GyB0nqecBijw4ex
 d6fThzp+AIRICkQLc0MveWcERL+K2tVA4kexv1x6hEOmwtdF0YeRrG35zsWKcgtQqiTE
 Hc20XrudwDSCmJpLBmO/gLKEXl4ButXAXz+2j0Qomf23BUqODrPBJJI98hTZ9xnmhS8U
 xG4g==
X-Gm-Message-State: AOJu0Yzv71BCHYhbJIxZxKFvLeONjKUdQoHlZLfjg93jCsCLcmape3L0
 i9GeHZT/dn1WFDiWpB61OuLht76dpnnRmw/n5xTBiCTXa2qRW6EHcFaR/vRrgHFKA+vZC9hGNig
 ajwZRBYYFDV94FA4Eiatm4Tm0Npd9eo2TTeUINnYyX8GeVS4PLN27Q6T/yNSzyNQRI32U2+Iu6R
 3RjP7UFwPlTY7ikBMTpU1Yqrdb6X2xAlb42jqD
X-Gm-Gg: ASbGncs6RMFTchYcTZ+Ax7jND5o4FP1X5xvWknUH0kJWqfzEiGYiuDgMtqckbk+QMc/
 sV/r2n5UxSrkIQNmYK2l7EV/PqBYcqCcf46iVbs6z+bBvGWT97JVZHOFhqTG5j56ftRt/wFvtdf
 SuKvwpLGgVFdx8D6eZwcM3I1AY0OabbI7g76A6dzR3mk0kWgQZBFQBCGFgwzJ2CyM88mUe7MXb1
 mb6aLf5+cEkl+uYtPU0JoRcM3nghME2o6/bwycqr/ErAG+djwvfEpjwhrVqLh5L/uJCxFgGdT5D
 GzXAGNugfujop9xcwTAD
X-Received: by 2002:a05:600c:a3b0:b0:43b:c6a7:ac60 with SMTP id
 5b1f17b1804b1-43d5100fbe9mr20729395e9.10.1742564021862; 
 Fri, 21 Mar 2025 06:33:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdyVdhAo+o+hLDvd8vv8vYukHNK1BkrO74oNazJ2qy1uawHhw/2YbCr5S+yoc70qVGEB5bEA==
X-Received: by 2002:a05:600c:a3b0:b0:43b:c6a7:ac60 with SMTP id
 5b1f17b1804b1-43d5100fbe9mr20729125e9.10.1742564021306; 
 Fri, 21 Mar 2025 06:33:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd27980sm27433485e9.21.2025.03.21.06.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 06:33:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] rust: hpet: fix decoding of timer registers
Date: Fri, 21 Mar 2025 14:33:39 +0100
Message-ID: <20250321133339.116081-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Due to a missing "& 0x18", timer registers are not decoded correctly.
This breaks the tests/functional/test_x86_64_tuxrun.py functional
test.

Fixes: 519088b7cf6 ("rust: hpet: decode HPET registers into enums", 2025-03-06)
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/hpet.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 63c1971f0b5..3ae3ec25f17 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -776,7 +776,7 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode {
             let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
             if timer_id <= self.num_timers.get() {
                 // TODO: Add trace point - trace_hpet_ram_[read|write]_timer_id(timer_id)
-                TimerRegister::try_from(addr)
+                TimerRegister::try_from(addr & 0x18)
                     .map(|reg| HPETRegister::Timer(&self.timers[timer_id], reg))
             } else {
                 // TODO: Add trace point -  trace_hpet_timer_id_out_of_range(timer_id)
-- 
2.49.0


