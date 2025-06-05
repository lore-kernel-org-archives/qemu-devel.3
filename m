Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E352BC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7eJ-0007pc-Nh; Thu, 05 Jun 2025 06:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7dx-0007RV-Bh
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7dv-0001L8-Vo
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749118575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MfaojDveYu66HwFkWgBRf71Aj3k7FgV+E+U33pqpFC4=;
 b=fh68R4tKmquwZgXvC3C7INSAGe3C7uPlmDqfp/sGuDPCZkVTfgUd4KK8JSJVt+8EB9bDXU
 sk1JmyRTBoGuI6M1rrmEE3I5pYRYDro05RSUVpMhOHOntoVjBE3Lk80l7cyWyfF6gJ/igY
 rniRCGpIAZuxnnE4M7JhR9YqrjkMyOM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-UXRDn7ldOAqQw4s_i6r-QA-1; Thu, 05 Jun 2025 06:16:14 -0400
X-MC-Unique: UXRDn7ldOAqQw4s_i6r-QA-1
X-Mimecast-MFC-AGG-ID: UXRDn7ldOAqQw4s_i6r-QA_1749118573
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f858bc5eso649819f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118572; x=1749723372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MfaojDveYu66HwFkWgBRf71Aj3k7FgV+E+U33pqpFC4=;
 b=pcjBXkCFUp6b20/g5WgqAne/DJxs8NAbD/Ffll5tmuTRjI9AA8xv566GD+eogaQE2S
 s2eXc3xZViaYf6+CMcdra8jVmB6BxJXwCE7Fwftm+hrvxWz9t3FOPA9uzXnpPsGBLh11
 UxTWBbBC506n7xbQMtCtBpuHjeylfpwX2Mo5F3rxaxjUvlIozzvlxXrI2/S5jDHlfDtG
 BeWJl9/Gx96Q/HDl9iS7RPgFoNO2E4kLnnuMNxV8UdoH5Kbv327TGM0FFsaDqdOwcaD0
 lepw8FIwWTAfcR6QB5gfKQNb1W/09ReukYXrr/a5h1j+6FJtb3ZKvNPwe4x1F8GqVbzQ
 RZ2g==
X-Gm-Message-State: AOJu0YwVL1i0YjCPtxPV1XxNoi+ZRtcvwgtcFzaMKTRxlPngyZUwYmlo
 naO4jP6mT+oQr6O0FNy8lHlkx7V3R3bVYuEonIISVLb1wudT2rReZ6eBErOkk9QjvxWXC7tEzB5
 culOiO86KYG1Vu+liOX4hnH7nVZFTkKkCV98R24VdevvQOlsxzRODPV/llkLRFnMy0Xv5GZiUSX
 zXF4XEAb+pXfUnMFkPCMkB85gn62upjVcU5lWL90ry
X-Gm-Gg: ASbGncvvjrjqby1VP+JW9qd0aHAf7sc8ycI3GELexoorIL9bgTpfySKXAQTAS5Bzh27
 cOpSOP4KQu7fdoaj3uJiTmwMQviYcbSX2n+OG4pT4Rjd06FprDRGrh6gs/qYqyC9GqG0UJt9iNv
 SyHyazprIsk8WVqcSyNN3Uwa7DtVEu3kNAo+KO/YBVag2sc8kaUCutF+IPlXvRo36oHNwlZN14W
 1Fr0mxVSeP65NhmOi7xwfvqMM9R2RVftKs68ZQ/rfZ699O544sRv1rYbnFRlJtIzBgbCTzgqmYR
 R3IXAXQmz+e9RyWkgmrPesyI
X-Received: by 2002:a5d:64e3:0:b0:3a4:dcb0:a4c with SMTP id
 ffacd0b85a97d-3a51d8ef83emr5433777f8f.12.1749118572190; 
 Thu, 05 Jun 2025 03:16:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHecX6UKB1pQHy8AQyvRee+1G6esV4U4Qrwt11W9elhthInTzfY2XNE11v1BWZApM5wfQB13A==
X-Received: by 2002:a5d:64e3:0:b0:3a4:dcb0:a4c with SMTP id
 ffacd0b85a97d-3a51d8ef83emr5433747f8f.12.1749118571725; 
 Thu, 05 Jun 2025 03:16:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6ca08sm24927666f8f.33.2025.06.05.03.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:16:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 10/14] hpet: adjust VMState for consistency with Rust version
Date: Thu,  5 Jun 2025 12:15:39 +0200
Message-ID: <20250605101544.368953-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605101544.368953-1-pbonzini@redhat.com>
References: <20250605101544.368953-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

No functional change intended.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 0fd1337a156..9db027cf76f 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -328,16 +328,16 @@ static const VMStateDescription vmstate_hpet_timer = {
 static const VMStateDescription vmstate_hpet = {
     .name = "hpet",
     .version_id = 2,
-    .minimum_version_id = 1,
+    .minimum_version_id = 2,
     .pre_save = hpet_pre_save,
     .post_load = hpet_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(config, HPETState),
         VMSTATE_UINT64(isr, HPETState),
         VMSTATE_UINT64(hpet_counter, HPETState),
-        VMSTATE_UINT8_V(num_timers_save, HPETState, 2),
+        VMSTATE_UINT8(num_timers_save, HPETState),
         VMSTATE_VALIDATE("num_timers must match", hpet_validate_num_timers),
-        VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers, 0,
+        VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers_save, 0,
                                     vmstate_hpet_timer, HPETTimer),
         VMSTATE_END_OF_LIST()
     },
-- 
2.49.0


