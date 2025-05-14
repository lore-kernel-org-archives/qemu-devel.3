Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB4EC3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 03:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF3CF-0003w3-Qc; Tue, 13 May 2025 23:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uF3CE-0003vW-7y
 for qemu-devel@nongnu.org; Tue, 13 May 2025 23:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uF3CC-0008Jx-Q4
 for qemu-devel@nongnu.org; Tue, 13 May 2025 23:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747194855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xLR8sU1BF5A6HcCAyYFe2oaaAHR40jdW0ueKmStF/tg=;
 b=ICZkuATraHEpdVf1na/6Qr6jBraRMhc0ujzdudLxGkuT4uAqwngzeTpZKOCILATL4zAo+f
 BYPZ5nn/Ez0ob73BdRYcKEsdnSeFY/0Ho/xNXwt7fdxCEM3caFVS94l/5DGGUus13/Qh62
 Un/h1cQCYZPxCiL0v6ufES91XJiESlg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-WYXgzILNOG6MB0rmBan-tw-1; Tue, 13 May 2025 23:54:09 -0400
X-MC-Unique: WYXgzILNOG6MB0rmBan-tw-1
X-Mimecast-MFC-AGG-ID: WYXgzILNOG6MB0rmBan-tw_1747194849
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6f541b32bffso165975036d6.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 20:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747194847; x=1747799647;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xLR8sU1BF5A6HcCAyYFe2oaaAHR40jdW0ueKmStF/tg=;
 b=aTyahOoNVJ/bCi/mkDiuhHHbHM/iWslDz3f6f+tE8RN2YW3XnW8j9ydpNRbeQ5P8nN
 FjpdPTo190JspWGGDPzPpC2zTnE06DbUBSoNuulzu+0nOq+GE9ePafb9iq6V48h33zjY
 Cs0evoFpoXoSes3xjvjYQrRO+vOHheX4QoUKVIX+86uifnZ16cRkGyRsc65HoP0K7w+m
 IN3K1JnwJfZof9LAfK4MUQaHIm4ti5kIdLYt8J5hEqtEzxRKy4xs5AQE+zkyIARuNbcK
 VLtUDV3idQNUCzfaAGJkKbAryGtNpCfYoft7KJhroY6KBrZF/TvQW5jGmncFHqNzHt3F
 XQqQ==
X-Gm-Message-State: AOJu0YxkSHhQ7BNc7S2q8S7hPcbc5tOE6kH3QsNEb5EnyvJ6qFplOUIm
 DIPLijbgB6nxgdmrmPwVSA+uPNbv4uewuETIQGs8MKw8j4K/Qy86iDFlymYyDwjc2vSWXoC7PQV
 eXdYz3kpzPJQ+5Bd1yPGjpv55c2uCVo9WLhgGvEzcwXv3cQAWsH72sqI++u+DJXicJpLeqt4BMu
 NGsLoquWmV3QgbmjxRnxAh3xT1Niz/Fh26B7uNoyWvtQ==
X-Gm-Gg: ASbGncuOGEU67o3UmVVtCHFO0eOVvJou9Ttoyu1nzpRkk5rer/kNE5/fBKB2cS9/vl7
 ghOFxUNy5+WpkV+ZmrAYfarD+wsQ8mcRBwikXuIDpWu3I38G9ynUi1o3vZla5bIjus8DM5rpso+
 rR7Vfq39IMFlv6FCi1FiRfYRoNgIN4iVjJtKJMYTekE9dXY9aJZ38bjFTxB/EJLz0gYil45CG0x
 f+y2zlv2ED7LeOL99qkrVUNqnMRIhW4w3gEhgJHS1/bmMp8P7XIt8PQTp4ZwcTwv7FVS2DjQqpx
 Xhev0YaBnUV4WeIW
X-Received: by 2002:a05:6214:1bc8:b0:6f2:b7d4:afb9 with SMTP id
 6a1803df08f44-6f896e2ee1bmr30069206d6.2.1747194847509; 
 Tue, 13 May 2025 20:54:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW3/xsSRD46qoyyXTs5q5myJ6g3Lolyb0nKC0BS4OkGNeCzwEVKxz4Pj0L67LiEMdmkbz2Mg==
X-Received: by 2002:a05:6214:1bc8:b0:6f2:b7d4:afb9 with SMTP id
 6a1803df08f44-6f896e2ee1bmr30069056d6.2.1747194847133; 
 Tue, 13 May 2025 20:54:07 -0700 (PDT)
Received: from [192.168.122.1] ([69.164.134.123])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f6e39e0347sm76029006d6.1.2025.05.13.20.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 20:54:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH] rust: hpet: rename hpet module to "device"
Date: Wed, 14 May 2025 05:54:05 +0200
Message-ID: <20250514035405.295861-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Follow a similar convention as pl011.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/{hpet.rs => device.rs} | 0
 rust/hw/timer/hpet/src/lib.rs                 | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename rust/hw/timer/hpet/src/{hpet.rs => device.rs} (100%)

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/device.rs
similarity index 100%
rename from rust/hw/timer/hpet/src/hpet.rs
rename to rust/hw/timer/hpet/src/device.rs
diff --git a/rust/hw/timer/hpet/src/lib.rs b/rust/hw/timer/hpet/src/lib.rs
index 1954584a87e..d4b6e015506 100644
--- a/rust/hw/timer/hpet/src/lib.rs
+++ b/rust/hw/timer/hpet/src/lib.rs
@@ -8,6 +8,6 @@
 //! Precision Event Timers) device in QEMU.
 
 pub mod fw_cfg;
-pub mod hpet;
+pub mod device;
 
 pub const TYPE_HPET: &::std::ffi::CStr = c"hpet";
-- 
2.49.0


