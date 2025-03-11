Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D2AC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1fe-0002ns-Ih; Tue, 11 Mar 2025 11:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ts1fa-0002n3-Sv
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ts1fZ-0001Ud-8d
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741707443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=x+m1tB0IRmFUt0z/ZSeEkRtMNkQL+NVakxjQzeIsgc8=;
 b=QDzHzGo+xAaFG//n3+4w3pdLzBJ3nnrHXYY3/C78gCE72z5BsV/PjHPDcdGe7FZiNdsXxp
 T+cNZ/Jl3eRARppLr/4J7WbZMtCeCJx3dCTuyPDEqY42X0wL+4loNj6MvTfIZ2ydDPUr5H
 sCEO6+k68UtwQ2lh7E3B3UXY/+ysnMg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-bEJh3oqgPSiIIlTCCV0LOg-1; Tue, 11 Mar 2025 11:37:20 -0400
X-MC-Unique: bEJh3oqgPSiIIlTCCV0LOg-1
X-Mimecast-MFC-AGG-ID: bEJh3oqgPSiIIlTCCV0LOg_1741707440
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912a0439afso2201606f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 08:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741707439; x=1742312239;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x+m1tB0IRmFUt0z/ZSeEkRtMNkQL+NVakxjQzeIsgc8=;
 b=rsJTQZV/8T/fs/mJj+6YE1/Z88BEkeFc4560KoP2TQh3cL4ocFZl9BbxLlhC6MFFPT
 XlGvg0LpOXJBxY2R09r8vbmKBOG8U56jLa0ttUUU0EQCJ/CtrqCoBjp8oUDzBoWUA6aV
 hye5hz+fT7jpPz53xOB/fhmBZc3zdFjtcjEgQSAFjwt5Lwds4KBZN5BRxuXdeX6QQjHI
 dz/T+nY0EBqHmvzQbdjOMu+UJza27VisE0dQV2rC7fmf0kK6M5yN00eVoj84aGOGE/fS
 T+Hu00dlPH+gcV9yy4wRz35za8s8K+AAovCdHVnqmFEPXTu08cFY5+cBgSNwohCpxOaJ
 Q0BA==
X-Gm-Message-State: AOJu0Yx9ae8VpGfy1njKLRLxg1qZT96uKFyGWJahfT2VxlBTVMQOKyzj
 Aajk7+VGQMGJyyXbNoxCfPo1VQIQXQRJFKUZMJY5qtNMNLZwOS6XttXFE12bUT3SiXdWlQs2etG
 iYsHIJQzIFwOLdS5ExYFyIhjQbyAfxipG0732Kot4lL6bcxlWnNwc93gX6w8ekDq0gZuTySdSZ7
 AOQkm47+TPj+tzpEYTMJ04kwYxfs8JORJsAWl7
X-Gm-Gg: ASbGnctu02FIfbkccC2ZWiwbVtNhGWBFPs7qS00lgir1wR6c+7AwXjIE0MTkPtL9IdC
 8VhNIA9kuEsNeG9i2hl09OLLnRNQEhk1wEka72YVVcSTjQ8rnKKXO8qQ38ENYLarfanKHGSyoDf
 O6fO5z3xnYBTc1k2anSHXJaVgcJJkhj+8Tfi/2yIaBGBp3WYeZgUNVmRr9wh+De84bt97iHfpEN
 xcAsPZN2+ZKmrjaTk/c/Zkh59mkPlKWCVBNqntGETNij3Iv6DTEXdUdgu3c/tAaYovpnpX37kc1
 u0jDU+m1uPv7oTIWJwN0qg==
X-Received: by 2002:a05:6000:1842:b0:391:2e97:577a with SMTP id
 ffacd0b85a97d-39132de2e83mr12413115f8f.55.1741707438990; 
 Tue, 11 Mar 2025 08:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt/ohi4G6ThivEGm36gMYoLwNjQklh22TPvYIWtK9UZE04lUJqqzYM5XJzJQddF8afQQxkGQ==
X-Received: by 2002:a05:6000:1842:b0:391:2e97:577a with SMTP id
 ffacd0b85a97d-39132de2e83mr12413091f8f.55.1741707438497; 
 Tue, 11 Mar 2025 08:37:18 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e308dsm18873420f8f.67.2025.03.11.08.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 08:37:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] Revert "hw/char/pl011: Warn when using disabled receiver"
Date: Tue, 11 Mar 2025 16:37:17 +0100
Message-ID: <20250311153717.206129-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The guest does not control whether characters are sent on the UART.
Sending them before the guest happens to boot will now result in a
"guest error" log entry that is only because of timing, even if the
guest _would_ later setup the receiver correctly.

This reverts commit abf2b6a028670bd2890bb3aee7e103fe53e4b0df, apart
from adding the comment.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/pl011.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 23a9db8c57c..efca8baecd7 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -85,7 +85,6 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define CR_OUT1     (1 << 12)
 #define CR_RTS      (1 << 11)
 #define CR_DTR      (1 << 10)
-#define CR_RXE      (1 << 9)
 #define CR_TXE      (1 << 8)
 #define CR_LBE      (1 << 7)
 #define CR_UARTEN   (1 << 0)
@@ -490,16 +489,9 @@ static int pl011_can_receive(void *opaque)
     unsigned fifo_depth = pl011_get_fifo_depth(s);
     unsigned fifo_available = fifo_depth - s->read_count;
 
-    if (!(s->cr & CR_UARTEN)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "PL011 receiving data on disabled UART\n");
-    }
-    if (!(s->cr & CR_RXE)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "PL011 receiving data on disabled RX UART\n");
-    }
+    /* Should check enable and return 0? */
+
     trace_pl011_can_receive(s->lcr, s->read_count, fifo_depth, fifo_available);
-
     return fifo_available;
 }
 
-- 
2.48.1


