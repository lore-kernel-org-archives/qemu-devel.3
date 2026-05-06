Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70621CD3443
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 15:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKe5m-0008Hg-PZ; Wed, 06 May 2026 11:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wKe5l-0008HE-AX
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:23:17 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wKe5j-0006zV-RF
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:23:17 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35fbca04006so3419012a91.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778080994; x=1778685794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhQssBYQMmeyrt0z4nSeNS8ZaDglLFgTQMywUFeRrNc=;
 b=NdSFOI9ltmXd9YR1DQ9hdvpzJ97u5YkQM0tPMsLuR2reR6cjAdTJjzqYftaMh8IZCZ
 wTdFmo0dLQy6Q4zXNhXQtwHb4k32HO74g3nMQWe4oD4U6bsohWGjvxdonhbea97QifYi
 Vy2TcMOWmaWyJcW1fONdd4riW8Y/hpRthw7+ktNwykmWryuKLgTpAd046dOkonL/mMTh
 5dbN01v6xraqjKx9yuzW5qbuhIOumh1/aznasuGb/Ua1VWqb/xbsCYAx8zb2wYNJs9Xk
 wCUvTAx2BMgkQHZR8K0DtMe8wCfeJXfnr8MLk0hdmyCI9yfEY2ztckMbh0bl3DXO+DpA
 EBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778080994; x=1778685794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jhQssBYQMmeyrt0z4nSeNS8ZaDglLFgTQMywUFeRrNc=;
 b=C9SMz8CJrjM71zJcaLrQZnIxvQxLHcWKvtIBSyiQpZTSjOw0v2G+J60+yGgPAnD4dD
 48T4Tm3RVYS3yxhp5kBXTUNCHB56iwJNYn2H5mFF37VoS9SbiPKDYvYJ7uXJMLVKyW6k
 SPSYei953I90GXOSYiHDeSPH1a2Ua2eBAvxIzpKIpRrCclmTt4yMNaagAQjA4iSgSPcX
 vKwW2MeBV2hzUabq9bmWuyDmOcy6vc3tVjJLhi1ohE1RYdg5K9cDQLDd6YnyGbORgygX
 iYFAeSIX7JkdHQOL/MO8ACaz/oxbboJIL0BbAVzcoRQKTKgx8FwUsZiIwoSdGyUfuT7d
 aFvw==
X-Gm-Message-State: AOJu0YyaCWpH+mBM73hH845xuDA4bdMW8z2UzMnI1S4ekrHg5FsERSl8
 37aoZGa7mluEqTu1Yc6LOkWCX7LgZEj7RkQPly4uMLnFnGyUsynlulws5m5x+t6S00M=
X-Gm-Gg: AeBDietq0ZHmagAtoEDrK1Fmy5qPrkHOn/5keH7xg39E701K8obpAvkbAPDPSW0UEYJ
 G8QLqCgt+GZ5YDkQyzJpWbSjPKW2nyxeyLXx7MYkOL4PPg5nDubrdnJHKFiksWlsUUMxdgYJtO8
 pUROqcS6K/ttr8/QFtbr9DoT2V6dMkdImsKMrhdP17vzan2Ro6sVn+q0XpQA2jxNIjTVLwqfUEb
 P6We9Jjeg5JXtSQPPOObQ/LEo7N5klvRizjqdlqZeevS+2Bov9LIf4MASUh8o/38lM5YhKTAvbG
 gKRTyr9QL3iaGt/YEi6/wUOCP3auVlP6GQto8uFTq5vPErg3aI0s0Uh4UbzHOdFHVuhTaPkUwPI
 UnVA2rCeuNmeyfmZ/0BPOYZk+rKq+JSkc/yq2yfU1cLam9rT6+KsC6hZy+0FSdiK8bbXG5MVzpS
 HK4f5tKRPrgIAlvLc5kZ9tH85MJsmUgXG5sHF6/7dQ15zSUak0fxaghafp0hPxqimA90y1FdGhV
 Q==
X-Received: by 2002:a17:90b:3f45:b0:361:3224:2f5f with SMTP id
 98e67ed59e1d1-365ac7754dcmr3966222a91.22.1778080993448; 
 Wed, 06 May 2026 08:23:13 -0700 (PDT)
Received: from localhost.localdomain ([2407:6400:c000:f1c:edf4:b0bc:edd7:a9ab])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b4c8a8e7sm3800052a91.13.2026.05.06.08.23.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 08:23:12 -0700 (PDT)
From: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
To: qemu-devel@nongnu.org
Cc: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
Subject: [PATCH v2 2/2] hw/usb/hcd-ohci: Clean up USBPacket before freeing ISO
 TD packet
Date: Wed,  6 May 2026 23:22:47 +0800
Message-ID: <20260506152247.82336-3-munkhuu0825@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260506152247.82336-1-munkhuu0825@gmail.com>
References: <CAFEAcA93342r1oKDBDv=7LRoAqT4WpVEqRpb-ThM=OjJUZm=BQ@mail.gmail.com>
 <20260506152247.82336-1-munkhuu0825@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=munkhuu0825@gmail.com; helo=mail-pj1-x102b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ohci_service_iso_td() allocates a USBPacket and frees it after synchronous
completion, but it does not call usb_packet_cleanup() first.

Call usb_packet_cleanup() before g_free() so resources owned by USBPacket
are released.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3463

Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
---
 hw/usb/hcd-ohci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 8f4de0066e..40ebafb4dd 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -755,6 +755,7 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed)
     } else {
         ret = pkt->status;
     }
+    usb_packet_cleanup(pkt);
     g_free(pkt);
 
     trace_usb_ohci_iso_td_so(start_offset, end_offset, start_addr, end_addr,
-- 
2.50.1 (Apple Git-155)


