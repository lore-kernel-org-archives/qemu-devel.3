Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195D4D5AE5A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 04:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8tqy-0006CZ-Gc; Wed, 06 Nov 2024 23:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8tqv-0006C6-89
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:37 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8tqp-0004xn-BW
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:33 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20cbca51687so5258525ad.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 20:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730952630; x=1731557430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MyuwYGB8wMZUxgeUT+ckknuz3vZLk8MowszNge3L2/U=;
 b=ld1f9EKKXxd8mo5YXQjnBKWof2LH8GvL14ki8C/4EBBq3Hb0drsHXtvxxhxeVpxfUK
 cjTYho5MnkAVpCzKUGxX+jYbM3NsKzlGfMZAWuCx6HrkPPDsreE1/ZePqXwDa/IXBmep
 ZUAqmUfQiIwyqhoSqJZBwyz6bWb7ByYSLb0JZuR0yodZkdnSbx6sxUHgI35FHDQGwnam
 yj6vUOtsI8ZHkKfx+plN5yFN3+U1dF5h3czrQ7U8BkdTFiJzVFuNKzoXwZZI09Hir+Rb
 shBt1m6kET+UEpMI/sRCp6kpC8Y13rYAPBlJ3HpfDvOJNBw7tocwkmqJ8gQUzU4qNjT/
 G08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730952630; x=1731557430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MyuwYGB8wMZUxgeUT+ckknuz3vZLk8MowszNge3L2/U=;
 b=HNStgZ8KNYzEVofHcNDmVeQs1REo2SKwjTXPnJ2wasnq/e8FkIq+QxqeKqzg6a17FQ
 zA2oRknmX9AMo3VHJbgCVhzXRD6lIBL5WljrZLU4+gdZmTEPjkLlpK5v42vhGJFI3gd8
 ey9fHZRDyiamiQJYahMt54/689jicOdBlG1K+OefaH50o9Pe2bOhVKdWvm1oWClQVy+z
 jJP89xaA5GK1ffBwSW1ojCwRFxq8wHwsH5Y+pp+tj2HZ4OKlcQPeKowHohLd44x9TqTh
 sVZE408NVu/b5ZRozUpOYteSozFV8pYr5ZJ3JiMJYpodezG4drfk/cvb1c99RyNroL3e
 OhIQ==
X-Gm-Message-State: AOJu0YyNiHhSfnqYBgNj0tZCq8uY3Rd3LLVsc7ipXQrQRAoSzu8eeNZG
 p8zCA5aEvkUtvPLUQRc7H5CSHeOe/Wl9Uy/UKmzW61pCmMcZECbpn/e2pw==
X-Google-Smtp-Source: AGHT+IEhYZK/ALjQOp+R94DkKKM6PY+sKzDaIAxORGXtDbl9Myw4D7mzInDpDRe64THebGfvKSmVOg==
X-Received: by 2002:a17:902:9009:b0:20c:968e:4dcd with SMTP id
 d9443c01a7336-2111aec8494mr233076385ad.7.1730952629704; 
 Wed, 06 Nov 2024 20:10:29 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc3f12sm2789105ad.9.2024.11.06.20.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 20:10:29 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/12] hw/char/sifive_uart: Fix broken UART on big endian hosts
Date: Thu,  7 Nov 2024 14:10:05 +1000
Message-ID: <20241107041016.40800-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107041016.40800-1-alistair.francis@wdc.com>
References: <20241107041016.40800-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Thomas Huth <thuth@redhat.com>

Casting a "uint32_t *" to a "uint8_t *" to get to the lowest 8-bit
part of the value does not work on big endian hosts. We've got to
take the proper detour through an 8-bit variable.

Fixes: 53c1557b23 ("hw/char: sifive_uart: Print uart characters async")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241104163504.305955-1-thuth@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/sifive_uart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index aeb45d3601..5ae2a29ed6 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -174,10 +174,11 @@ sifive_uart_write(void *opaque, hwaddr addr,
 {
     SiFiveUARTState *s = opaque;
     uint32_t value = val64;
+    uint8_t ch = value;
 
     switch (addr) {
     case SIFIVE_UART_TXFIFO:
-        sifive_uart_write_tx_fifo(s, (uint8_t *) &value, 1);
+        sifive_uart_write_tx_fifo(s, &ch, 1);
         return;
     case SIFIVE_UART_IE:
         s->ie = val64;
-- 
2.47.0


