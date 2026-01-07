Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D98D0D16D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdZom-0001Pi-P6; Wed, 07 Jan 2026 15:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZok-0001NP-C0
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:07:43 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZoi-0002F5-RS
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:07:42 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso6158635e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767816459; x=1768421259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+spEYlMsqJ+HI3zh7hLnIBw8PUdF2ekvSTK0wriqeqM=;
 b=EICGvobastRu309wNEhP6EYMV1JTsTunZGnPGcboCipxpCDqLg7e1EA0pgvyjPi1wy
 oJZWIjXG8YCoiho2ZaO1gtUsoarzSc59pKE3kRCX3fhXymEJoqciVJqdH0+IefjIhbO3
 6mTcq9yBNYBJ+oXAeUIDWZo0vsGjlBvmbxQGhu2gRvaSDaEOLPb8mVZRav0BNjdQbbFp
 /YnbTIdGZCsgZcGmusyBiMiOSCxaCjcqQsjbXc4y1tyhkYtHX8ms/Pdbe/GirDQCCQUg
 sZngXlPPfoG2tHgMM+SQmSlNSBw1+/DmQvSxWcddU7wadKjaOY2yJMPS7M/t8XvIYIBR
 TuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767816459; x=1768421259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+spEYlMsqJ+HI3zh7hLnIBw8PUdF2ekvSTK0wriqeqM=;
 b=ghW4jvi4o0bSb11NJtQseJLpRXmHd2R2n9afYlAGURhj+ePEFZsrx8Ff6TAarLkEoN
 TrvdzjHdtUCZJAimZiBLeFQRqyK94PunWEDWiOjh7f3GZUDWruvot6IURFm2aUltNkw+
 ppbWJkqhUAvyTiQXfcJkEzyrAe+Lic4Gpc8fNXBTPdPqumZ2w4sjJKb70qxqXmgXI5EI
 q8ODKr4pVCAHdd8UtYSownFjjeGl0m4lRslPjUcz/KUzAgAk7phenCb8qLRjvxjEzf94
 ZFydYJXeoc0pUMBdfnYaMd/ByITuBXsj8nPARdm/kadGvlLXbGU0knPG505OJDabkTA5
 2ckg==
X-Gm-Message-State: AOJu0YzfkyhDPcY6RbWO+4U6l+mWhJ1caS+vQPOjXdmKo6ydjK7Bpt/8
 jrYD8hIDzc2uWS2g5gDtpC8Y30A1ZCM0EOVlHLmMZFF9kl9+ds90+R0GL413h3jGpsm/EzdjG+W
 c4hxRN2k=
X-Gm-Gg: AY/fxX4bm4dCoRF40XfP+bMp8WfMMP06vh7yqKGpeEhGhK18Y0Ya/LPg48rtN/AypBO
 TT4DlQrCynhotlXdpowoWV//jus3pNWsz42cm8+5RhFpsm6GYN5kaGNQMcr6C8k4pawZAwUkQDr
 KDYD6zik8a1Xfh8YCwQGxgD3LQDnMkwYcWBcD97Lxy+OHZ1FdfwRp48CMLAMkUi4I3x0cJVS8+T
 neIR6eke62SZcBFLS535WES2TQBUze6ayMmnTdJKdqEZFBZxbtOKxqIKT8XUukmFp4Hl/vMmEnD
 cGJUw22wZ+YtrvQ3wMfGnpDD9QJJG7fs/C2NI0km+LtOQdLakI/zgyOa+7Z5N/wIB+fACiFuTqB
 bhPWoKUxF7esJ9F6mUQhfjGpPXe+t8d79xc+/W4BfW+cnrsPF+wwaHOGIY+0bfWhbMyYv2KB6zc
 pF8sSUTSTUuVSzz3eCAReIDddExPEy+0PuLadfa4VKCxTaRuvODFQWRLoTZuJ0
X-Google-Smtp-Source: AGHT+IEAawFOYHstOfR1cM8s0WMrEzlsXvgWuEVy5chdL8x8HwDPnW4CAckGNnh5D78q/yXMA/zrCg==
X-Received: by 2002:a05:6000:438a:b0:430:fdc8:8bd6 with SMTP id
 ffacd0b85a97d-432c37792edmr4825671f8f.31.1767816458964; 
 Wed, 07 Jan 2026 12:07:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dad8bsm12619677f8f.8.2026.01.07.12.07.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:07:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/9] target/openrisc: Avoid target-specific migration headers
 in machine.c
Date: Wed,  7 Jan 2026 21:06:58 +0100
Message-ID: <20260107200702.54582-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107200702.54582-1-philmd@linaro.org>
References: <20260107200702.54582-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

machine.c doesn't use any target-specific macro defined by
the "migration/cpu.h" header. Use the minimum header requiered:
"migration/qemu-file-types.h" and "migration/vmstate.h", which
are not target-specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index f2853674f0f..2d5ca16c511 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -19,7 +19,8 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 
 static const VMStateDescription vmstate_tlb_entry = {
     .name = "tlb_entry",
-- 
2.52.0


