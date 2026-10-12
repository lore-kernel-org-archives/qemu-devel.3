Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AF3CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHW8-0002pZ-9J; Mon, 12 Oct 2026 11:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHW4-0002oX-Jf
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:00:40 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHW1-00064q-Qu
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:00:40 -0400
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48b02a2359aso1868320f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791817236; x=1792422036;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wDP5WL+nHMCrP+FkWkhyy3PeP+6u4U2NxCql/xvInIk=;
 b=2ug1uxW0X95R8I+I6rwYVRtCob1PAlJtN62vNTqzB8BxAl4nvcVjvBb8GUOSEwh2CT
 yWNtuJmEXFfsQTjvm9KncFUNm4QAbHzIOu7f7Sj24QO6er+6VmXoiRuCSsickrz4iimI
 tXrONiAT3MxDjokPSoBG7vE0xigdpE95BbS6Sqcyv+j1M//0OaHSSshSOkHWSCZDlxyu
 gzpkc5B0RWI9LupmFL+sxn2rTGJFnzlu4S4EaLMXPabEBwnGg3gSKX4tiOjebwQZvFAF
 uDLzobfeZiIm6glK01WKgXunySZGiY+CY77n/Nan3jUmv5TI4hqu19LhSAWh2WSsEXb0
 FVLg==
X-Gm-Message-State: AFq9FYJDGs8UN8BCy4rm+oGIT5JhFLt/eFLdXLbh/z0AzbxqxnGvJEhT
 fIeZmOzrTYAcAvZmjEN8ha/xo1RyoEzmq8L+n2DOc6SZL6LJ1RJiMx+92T7DBs7g
X-Gm-Gg: AYBFou3v7VB4IiNRwjogMxCcPQYXcq/LZ+tqzRN7euBY0MIDi6POKUuLSN1yL7SAscK
 OBiUZViAL7hginL7JK0tlx1OE3bTox4AkFciTF7krd4PE80MaQ5lOtn+kfJbEsGM1iOHjnJCVBU
 5C1AL0gH1H6J47Grl68NjKIcoepkMMyxfIrmwfOwd9pvIABtf81MCii7+zmK+gM7zFI4qTlKt6f
 DS8uOpxTJITl8TdVfhjE9/3WtEtYzrj1noC8U4QJ084nQ9XUTFpMz8NTNGIaYxBpsnHZcpWzIge
 sqPwH7Ovwx8JrRWHLLF8erxfSjz06h56xYrnxc6Q5wC5giQ2kOTld/0FlcI2UUtyNAS6Gtc4Jz0
 3dgzTYj1AtLlyUInQwGuXJnZW1UD5nDPBQU1vF3fMx1rx5+c0KFZ9yh1WrWI5gkOmD/Gj7JGhaX
 AhHfn2qODWGfe0p391FvvTaNjJPs+b4SrYUULo9PCPN65+u1dw/4jVrOnSlsu7LGqKJjbLZlof6
 x8/nG6d3tmmIi7Wy/qj1FOBkyQ5h+Fbb0t2mPf3v1W7ng==
X-Received: by 2002:a05:6000:2dc5:b0:48a:f4d4:e1f3 with SMTP id
 ffacd0b85a97d-48dbaaecd68mr16588887f8f.13.1791817235263; 
 Mon, 12 Oct 2026 08:00:35 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db94e33c7sm21497260f8f.10.2026.10.12.08.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:00:34 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:01 +0200
Subject: [PATCH v2 08/50] hw/rtc: ds1338: move TYPE_DS1338 to a public header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-8-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815519; l=1551;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=CHjHyVACEubRQ9qO4x11bxK9mverbnzeYmmxFnXvHD0=;
 b=yapktyvu/svjNL2CFX5Cpg6XHqC/ipce2Avu9bNxnA+14JfTypvk6lSLDsaLyy9OrJjH7QXfS
 qpkRvmEu7ULC40cJaIK3TCBUkHmftyYUc/s3lfaxWzcUgwE3XqQHnAs
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.53; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f53.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move the TYPE_DS1338 type name definition from ds1338.c into a new
include/hw/rtc/ds1338.h header so that boards instantiating the device
no longer need to redefine the type name string locally.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/rtc/ds1338.c         |  2 +-
 include/hw/rtc/ds1338.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index 5f1ee2e410..f8b3340bf0 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
+#include "hw/rtc/ds1338.h"
 #include "migration/vmstate.h"
 #include "qemu/bcd.h"
 #include "qom/object.h"
@@ -29,7 +30,6 @@
 #define HOURS_PM   0x20
 #define CTRL_OSF   0x20
 
-#define TYPE_DS1338 "ds1338"
 OBJECT_DECLARE_SIMPLE_TYPE(DS1338State, DS1338)
 
 struct DS1338State {
diff --git a/include/hw/rtc/ds1338.h b/include/hw/rtc/ds1338.h
new file mode 100644
index 0000000000..f4cfe6a8e7
--- /dev/null
+++ b/include/hw/rtc/ds1338.h
@@ -0,0 +1,20 @@
+/*
+ * MAXIM DS1338 I2C RTC+NVRAM
+ *
+ * Copyright (c) 2009 CodeSourcery.
+ * Written by Paul Brook
+ *
+ * This code is licensed under the GNU GPL v2.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_RTC_DS1338_H
+#define HW_RTC_DS1338_H
+
+#define TYPE_DS1338 "ds1338"
+
+#endif

-- 
2.50.1


