Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BABBCCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH22R-0000lc-Pu; Thu, 06 Nov 2025 10:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vH22M-0000ix-Jp
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:36:34 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vH22L-0004VY-3K
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:36:34 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-27d3540a43fso11744275ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 07:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762443391; x=1763048191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VwA0RV+grU0SwvTFaw9mxNY1tj7GneKX5j6VPvaxFcs=;
 b=AX24XKF/Jw7vaddCb6z83ZJCsQqnI2QIGs+MjmvZNMbXezG9jNRZYD8he7gPDUcWxO
 yeQECO6oEwdur4D3FYn3SS5jGB+bi/7DWIFR9BVS0h2iua3j/sYtv8+rdTBxNWVKmQl3
 fRaN0jTwJcOSaDGfXI6VQo3kzudagGx3dOp2OUGZbkCVEPyL8STyef/jaFGRPqmhuYCX
 Kv/4m40YXhM9uhkGCifOtIkcj1kOwKdifGvDWNTrFjdugfEZG9qaS42HyAhKWxVOIIdL
 ZEKe6Jw8/g6jp8+IZmgf7uFDI++LYM+lhfBai6H4aiSj2UvVkdFbmJHcCg/8bonA6yCd
 1NAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762443391; x=1763048191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VwA0RV+grU0SwvTFaw9mxNY1tj7GneKX5j6VPvaxFcs=;
 b=k4ILs6wBzR+4P+IiHgRLXHpHqd+nEeML8DXT2+utiqf/Cw168jPt9cEh3S4YzY/P0+
 /9Ruvn9WGeyPV09FsHXDJydH+f659M7CgUwL3YOrqA0H6aiuweIHW/MQet4MqlEFjKUd
 Z4/gyfVCqPfUIVNswmFIsJ/wEpmwuHDuLio3KYaw8EYwSu/5mejSJ5V1TDs4sR+UqnHD
 cf6xFhHzwR4UOzjx3Do9xy8cIkLOrOKrbnLCwC0/3jlV/2fXRBVW1A/qdLbPlmzuVPBX
 YXZfv0UZei6CZ73gIrnzteKdZoiahzMyVqY34fhC4yDZcgPlYP5polFrpiVhKsABG5ED
 Fb8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmq08MWpS8UsmALd9gYGtevNJ0JRc5oYq1IqJAwBgkd9imwLhQY0J4BfYIgN6hHRa3tbQmEHwVjxjM@nongnu.org
X-Gm-Message-State: AOJu0YzujKkJ5Sg0ARwyEMuQXx5KOF5rBw7rToE+GVTJOcbdeucEAue5
 gBMKr0hGJkzaTbOkvNnSTXRN1l/hTvtPbaeVfk5BZM1GvAE1EgXECbU+
X-Gm-Gg: ASbGncuyGLTRm9Kr7jh03pHKv4QxWp+JXgszaO/DXzNhYuzDfeYmoCoRuRRDTweqQtW
 Q9WVKt2donrT/eYu9oyYTlaKBFct0UNkbweYhZX3D2ldT73HVRGS9HkhXMdCdjlYvqnV7K39Mdk
 2+vBVFQQTZZzEN4UKX5ZbU4h5OAYO2K0NtJyibUzHIDKJs2DXSg4hUQ4MZ+seHT6JU9s208nSL0
 3EmGYjgvYVPCY8uX1LIEI1I/fxVX0PuHMu3Rk7i1ZR4LpFJgN82Y0pZASjzJHz3y5Inx286az6t
 Kek79RI1e+a1Sa5y+iux+Xyec77DGZB+kNlM+0JeIze96pjLH2XsR+bcsxuJ+KvadKtJnOJQr2x
 XDVp3lljVnTRN3QnXQsa+6xClbYPbpgcuFwhmV1hdvb/+UQxMLpTF4mNLCamLCzmPldodMMG+8j
 QDeEvrSCavcsXDz/lRW6nF7Sc8Qg2oVe4SbAan08yTeTqJYp68bw==
X-Google-Smtp-Source: AGHT+IFQ4DG8A4GUr+83sXSQFMmSvkZfDPrtlgUA/iEBmuVQfzhd1NntyNLpl4D6LdZ/WpIWeahPzQ==
X-Received: by 2002:a17:902:ec90:b0:295:68dd:4ebf with SMTP id
 d9443c01a7336-2962ad26752mr109444795ad.16.1762443391059; 
 Thu, 06 Nov 2025 07:36:31 -0800 (PST)
Received: from fedora.. ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341a6993b43sm6643437a91.15.2025.11.06.07.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 07:36:30 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: mark.cave-ayland@ilande.co.uk, sarkarsoumyajyoti23@gmail.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org, deller@gmx.de,
 qemu-devel@nongnu.org, linux@roeck-us.net
Cc: Jason Wang <jasowang@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v4 1/2] i82596: Removing crc_valid variable
Date: Thu,  6 Nov 2025 21:06:23 +0530
Message-ID: <20251106153624.29424-1-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

While testing and developing for the HPUX 10.20 the crc_valid variable
was used in performing CRC checks for the loopback ,and expected the
CRC to be absent on specific condition and would skip some
functional checks for the loopback packet, so initially it added
a if-clause that would skip the checks preventing HPUX from
getting stuck at phase loopback.

However, we can remove it.

Signed-off-by:Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 hw/net/i82596.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 0d9129cb68..f0b22093f9 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -992,7 +992,6 @@ static ssize_t i82596_receive_packet(I82596State *s, const uint8_t *buf,
     size_t payload_size = 0;
     size_t bytes_copied = 0;
     const uint8_t *packet_data = buf;
-    bool crc_valid = true;
     bool out_of_resources = false;
     size_t crc_size = i82596_get_crc_size(s);
 
@@ -1155,16 +1154,11 @@ rx_complete:
         }
     }
 
-    if (packet_completed && crc_valid) {
+    if (packet_completed) {
         rx_status |= STAT_C | STAT_OK;
         if (is_broadcast) {
             rx_status |= 0x0001;
         }
-    } else if (packet_completed) {
-        rx_status |= STAT_C;
-        if (!crc_valid) {
-            rx_status |= RX_CRC_ERRORS;
-        }
     } else {
         rx_status |= STAT_B;
     }
@@ -1187,7 +1181,7 @@ rx_complete:
         return size;
     }
 
-    if (packet_completed && crc_valid && s->rx_status == RX_READY) {
+    if (packet_completed && s->rx_status == RX_READY) {
         uint32_t next_rfd_addr = i82596_translate_address(s, rfd.link, false);
         if (next_rfd_addr != 0 && next_rfd_addr != I596_NULL) {
             set_uint32(s->scb + 8, next_rfd_addr);
-- 
2.49.0


