Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32FBC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGv0-0006vU-Le; Tue, 21 Jan 2025 11:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1taGuz-0006vF-Kd
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:15:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1taGuy-0005TG-21
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737476154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AomZICEblHmS2tRR/TpaOZIzaerzgfZ1jQ2NFE9RpzI=;
 b=CpL70nSRyyNwkqWyP5wr7/szLJYp/1KGvM9kc7FXpvfz/Icrw1bwWgjQIAStwUWgI4aqKq
 fIZRLWXLTtjSr1p9A8jZALLCKS401eyuaFoTtf0TtHadfAkJitNGdqEpF09QiqyKiejneg
 i4Ms8PzRUh6PwxVgXwwEy+KWbPLZrsE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-wB4NRJGjOAKO0NmZaAFc0w-1; Tue, 21 Jan 2025 11:15:52 -0500
X-MC-Unique: wB4NRJGjOAKO0NmZaAFc0w-1
X-Mimecast-MFC-AGG-ID: wB4NRJGjOAKO0NmZaAFc0w
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5daa661ec3dso7009961a12.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 08:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737476151; x=1738080951;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AomZICEblHmS2tRR/TpaOZIzaerzgfZ1jQ2NFE9RpzI=;
 b=sGDC38vTn0Q0qP4fV4lQS6SXUmU/a1+rrc/F1aGSgoTK8dVsDNDTxBp2Gfq3YKaYXu
 c9e46y6XGGbAjc4E43s1xtdUgdz484onMQLv9nPkx7nr/44o0z3SNgdP3vKjghxE9uLg
 RbxKW+gzV6DLjDI8pWzX6YKjTJWP3hEktrfjq+Mihap2aQLBljUBOXR4y5l+GOVN5q1e
 qphuprp2T6b0hkJVgHffid9bPU2qzS0YLfk/92qfCKeVkUlm80oAPpKkEeCrHPMZUeK9
 qw/FBlgLjR+kz3ECBN3o05x7F7UPChaIumRSERSv4v4/atzv4HhbHuxRZlg/6EV8iBkN
 sc4w==
X-Gm-Message-State: AOJu0Yze9DcFz3pRrnT9B1eb2YOpwmbtwf9wneyKYa20bvyxurjhDJu6
 t7tvRCvpw1Wc+KFYCw4rGmuggcVm+NZst+zvHnVQv2q/tfq5qOVbH9d0QR/lpO2HufB3rwfvfue
 zqfzFvs2+rv2fTMe4u5KbvPbxIh4EjlPLbDErRb88xHsfHlHWlDYOMfDEgOm1fDm5qTImWf8QA9
 riZslsxL5PGO1+pWcCpCE2noZWM7PmTjgs1ZxuEyU=
X-Gm-Gg: ASbGncuC6RWXPF9Ukg77VMk0PeZtEGbWncMwmxIgudjQlWF7IZ636uVu43c0L7HWwEe
 2pnP3L6yxmsCy3De3Oa6/FlA2gQkghXZPvlzQ5xFeeIr6XfBY/+MLykF52l1h0B9sG1QcAeY/2k
 fkEPIoI+/A97DZTFIh4mHNGTUiv+aQhpgUeBIRzf0IxDr5D44STgFabO3ZX0uSSsYapvot/8gol
 1lmr9ipDFAzqe2OzdFzcC0XGNmXj68gxZ6HC3zSmkp3Bagzo5/TQU/6fo6obdHTOQUfeuWNcg==
X-Received: by 2002:a05:6402:5207:b0:5d9:82bc:ad05 with SMTP id
 4fb4d7f45d1cf-5db7d2f58c3mr16041510a12.8.1737476150799; 
 Tue, 21 Jan 2025 08:15:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHopTWTbupbzDs6KZOqTeKtPALXTbAsTN1hhb51iQQdhQisM7VgB1bsuqHoJ2TupyP7ZsjSIw==
X-Received: by 2002:a05:6402:5207:b0:5d9:82bc:ad05 with SMTP id
 4fb4d7f45d1cf-5db7d2f58c3mr16041467a12.8.1737476150268; 
 Tue, 21 Jan 2025 08:15:50 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73eb5b64sm7102643a12.57.2025.01.21.08.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 08:15:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH] rust: pl011: fix repr(C) for PL011Class
Date: Tue, 21 Jan 2025 17:15:46 +0100
Message-ID: <20250121161546.2233086-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index c95ab49fd62..4f1080ff19f 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -130,6 +130,7 @@ pub struct PL011State {
 
 qom_isa!(PL011State : SysBusDevice, DeviceState, Object);
 
+#[repr(C)]
 pub struct PL011Class {
     parent_class: <SysBusDevice as ObjectType>::Class,
     /// The byte string that identifies the device.
-- 
2.47.1


