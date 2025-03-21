Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C30C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhFr-0006R0-1H; Fri, 21 Mar 2025 14:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEw-0003PZ-Mx
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEt-00078o-OK
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pkTHz2UWHPEbKgcpzU9XTX788FOigDaRZo+GExD3JvE=;
 b=RGnyu4j2jHPSrvD4lbhrvWnf6PJcqw8NVPe0mNQ9vf0iOUTX7/6/wOuOrkV31wdbQxx6gB
 R8Td0sgC1HmAi+sDaxfQoJiYJ10IySQhVooBMTduV/rY8mMDEWsRt9//h+fYTQ4lkPQKu1
 a85njhCBNpaIVzRTYsgIr1Tyf7T7Nxg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-8qUzDaZBP7KoylLwJlDs7g-1; Fri, 21 Mar 2025 14:37:00 -0400
X-MC-Unique: 8qUzDaZBP7KoylLwJlDs7g-1
X-Mimecast-MFC-AGG-ID: 8qUzDaZBP7KoylLwJlDs7g_1742582219
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912a0439afso950358f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582218; x=1743187018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pkTHz2UWHPEbKgcpzU9XTX788FOigDaRZo+GExD3JvE=;
 b=XWf1/sAgH/6NmAvWILZVTC6CIp2BMZhagi3S8sowC08VBf6gDLomVxuZn/uFffcagR
 EMwlSz5/xxkeVDs50qyj3fGiAhpqsPbL1ttD5TBBB4N/GJD8Q+iV3PdtQ2p2uBDV0yDt
 qJY/mKQHFevQOoa/vtau///Tlkfm1qLIBQdDxiLe4SMKiwhTfff6lYZnzkRmoAeE1CHR
 oD6wSOh74Tbnn0Qly0SsEKCKZhhnL9IZJ6cf68MnGgye2wC8VXAHDsCF3uuBGrPn8SrC
 IP7sMZfED0JRdK5oUf6QTFsaH1ZS5mI0spjXlENycWkOpK43yQVOvUkRNc2KMxzvl3xS
 qiig==
X-Gm-Message-State: AOJu0Yxq7ShKVhDkHXuguUfLKyyrKYkwe63fBtADQS9lKQiOHrPJ49fz
 QrGCmyK6DKIqUZYrRn4qiFSBYlveARrsOlK0AIUD038lvBkhta65nZPOmHS2o4yO2hIfciewr5p
 zfI4ZAkU2IYfHFKq0qGT9f7m963q1gI39frRWCZ9LOoXQxOkd0PphRFPz8sVEue9c3U+1wwUNBl
 +IJdL+mmWtVDyYXb/6GqzSpyRbmlxg0e3roVg2
X-Gm-Gg: ASbGnctxflj+NOIXAbt+Nx2LEhUJILm/KoClmy/9uFfDgGt+eTJw/p6PO1SM2lw2nEW
 tQnVs8eODuM4FBdbmoTpq3TtYSr3knZwFEFAYKGI0eIaLZ9kptcBEfFBSMYRYLS/0PG5WpkEeNt
 VcsaOMk6ix4GvjSvYOG/tDjL86isK+nE4AnWgExCFH0YqH4vTs99uOITwXo89OlEiNVuk1nI+k+
 4aUNnzGtPzZ7whWsXtjQyUbwO4K/Bbe1SoArFeSFnfQCnzZ6rWeI/znKl5ZT1YBNPhO9IzPDt+i
 wmScV5XvmslP5m/jhz1G
X-Received: by 2002:a05:6000:1ac8:b0:390:f6aa:4e80 with SMTP id
 ffacd0b85a97d-3997f937b82mr5515251f8f.53.1742582217631; 
 Fri, 21 Mar 2025 11:36:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXoyhleQ/SIfmXuTMQHSrnyF2Lw4iHtK5E3qJHzUUdmu8ZWaYTj4u9wlI7Y1s33FjxnkapJQ==
X-Received: by 2002:a05:6000:1ac8:b0:390:f6aa:4e80 with SMTP id
 ffacd0b85a97d-3997f937b82mr5515225f8f.53.1742582217112; 
 Fri, 21 Mar 2025 11:36:57 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9efc9bsm2968491f8f.87.2025.03.21.11.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 24/24] rust: hpet: fix decoding of timer registers
Date: Fri, 21 Mar 2025 19:35:56 +0100
Message-ID: <20250321183556.155097-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Tested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


