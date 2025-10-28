Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE37CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDm8Y-0003hL-4h; Tue, 28 Oct 2025 12:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDm82-0003On-4W
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:01:03 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDm7w-00064O-GL
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:00:56 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4710665e7deso32686535e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761667245; x=1762272045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3VO5d5EAGo4wZzbvR3QkkqwC3BxWJb1UbGxi7v8NEQc=;
 b=kbEKguJmxspj9Yi7+1gTZ2seffz5uK1/a5R/FEfskQbd9klxcHDNmf5K0uSyUBmALO
 T2/DRgvpxQ1S19bI+oB75JC2xSZ89zRZquRpHMZskcx+z+AeR7POFBZhyDaa6W4+eiV4
 4LQccAxDIKieNukBkrtn0E08AFOu6zxPugM0mIYWA7mYMxASF0Lo8JWY253zFdLkK4oZ
 yH0a2z1LqahexfKw3gmfGfGbsqRG3WeViBCgGNEDRghK4lXWT59Au8j/0kBPUSencJPa
 Fnrth2zoTZol2kTMzaPE3Icw9EJHwdV3uJs10uHXgZ2e4GjRzpvvj2pWj0G4Tg6GgZj/
 0Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761667245; x=1762272045;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3VO5d5EAGo4wZzbvR3QkkqwC3BxWJb1UbGxi7v8NEQc=;
 b=tKCLziRDB78Sx2jUn5WoiagILfZHgyHB6wR5g3YT7p54ec6zKV1qaVTMafuTe8qNIx
 SkAB8zo13SsM1DgeLsz12BFrwVPWZLv3IoeeZojUZxcdH/K4+zT7jqF6aXSLDG+b3ekN
 In79KxaaV/4T4yzLHI/fVpdVKBnW5MTJD0V9ar8yy9SeuebgZEbr3xkgRaBKefvrHOeQ
 c2hdVIdURJzTCtVi7FlIPGmzox2AnBAySqvdwjgsG2hNX8dmgnCJbbPeWthuDsbWj7m/
 HWH4TLtJG8IlKfaiaoHtOB6xQFSzGN/sVOB5Mw7EbzsNZQ7F1RhFap6rVM0tZ1SnafdH
 uuSw==
X-Gm-Message-State: AOJu0YzU+4f3e12e7XqppnNn27LSu9EtuRw8lH3J2JXdiDNR+UwUPq/L
 MD/aP1imE9IAO7CPxIJ16oYJkDIQ97TjOFUE0sYD380YrTHmt+EJ4zuIxdT5ZxlHZudkytk4N1j
 h/Me8
X-Gm-Gg: ASbGncu/0zVL1J24AFwJtpYqFsH4RlPNXSFfCoBftzzDKtqHcwxeeM4roUm/OGe46Zz
 DUkn+W8UhSt09u1U0j7WaD0PvdYDpwJKBpyz4rnoD09B8lT9knwnaPwv7F3Ef58AgL3N5k3NOJX
 xCr0niT5NUwwm07ZIb8F0Vak4zxCtdQJjso4u+uGU6wV7ZSeQ2Eo2j6WwUkfP9tOg6yO9SSaz0H
 2au8EOPgQlW70FVG/yl2JKJanzOc9OzCm7eBFI0gldPiqxm+5L9v/8JDs8PRtXSvPJak1j9a/Tz
 I8+2FRmnMBQBQEStHQ5C58gLqrGrcO8TmadB+LL/gKs1KsicjnNhTlW8XbDw27HR3O9QzMz+600
 BE5DGU8duIKy4r+t4JdQstegMfI9Oufd6P/DY01YgWbWIYwHM/o7zgBwKdeaZfXULsHx6fwS1Gv
 VlFkYc5Q==
X-Google-Smtp-Source: AGHT+IFdEtd5mJn9ZwQUZlpnXD92xDMsuSzMIzWn+tbykOL4nXzE/Ma63P2HlZrSZlO2xnBG8pGDAA==
X-Received: by 2002:a05:600c:3d8b:b0:471:1d8e:3c4f with SMTP id
 5b1f17b1804b1-47717e4147cmr26891775e9.24.1761667245135; 
 Tue, 28 Oct 2025 09:00:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd374e41sm203109415e9.12.2025.10.28.09.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:00:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
	Bin Meng <bmeng@tinylab.org>
Subject: [PATCH] net: pad packets to minimum length in qemu_receive_packet()
Date: Tue, 28 Oct 2025 16:00:42 +0000
Message-ID: <20251028160042.3321933-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

In commits like 969e50b61a28 ("net: Pad short frames to minimum size
before sending from SLiRP/TAP") we switched away from requiring
network devices to handle short frames to instead having the net core
code do the padding of short frames out to the ETH_ZLEN minimum size.
We then dropped the code for handling short frames from the network
devices in a series of commits like 140eae9c8f7 ("hw/net: e1000:
Remove the logic of padding short frames in the receive path").

This missed one route where the device's receive code can still see a
short frame: if the device is in loopback mode and it transmits a
short frame via the qemu_receive_packet() function, this will be fed
back into its own receive code without being padded.

Add the padding logic to qemu_receive_packet().

This fixes a buffer overrun which can be triggered in the
e1000_receive_iov() logic via the loopback code path.

Other devices that use qemu_receive_packet() to implement loopback
are cadence_gem, dp8393x, lan9118, msf2-emac, pcnet, rtl8139
and sungem.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3043
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I think this is the right fix, but I'm not very familiar
with the net internals...
---
 net/net.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/net.c b/net/net.c
index 27e0d278071..8aefdb3424f 100644
--- a/net/net.c
+++ b/net/net.c
@@ -775,10 +775,20 @@ ssize_t qemu_send_packet(NetClientState *nc, const uint8_t *buf, int size)
 
 ssize_t qemu_receive_packet(NetClientState *nc, const uint8_t *buf, int size)
 {
+    uint8_t min_pkt[ETH_ZLEN];
+    size_t min_pktsz = sizeof(min_pkt);
+
     if (!qemu_can_receive_packet(nc)) {
         return 0;
     }
 
+    if (net_peer_needs_padding(nc)) {
+        if (eth_pad_short_frame(min_pkt, &min_pktsz, buf, size)) {
+            buf = min_pkt;
+            size = min_pktsz;
+        }
+    }
+
     return qemu_net_queue_receive(nc->incoming_queue, buf, size);
 }
 
-- 
2.43.0


