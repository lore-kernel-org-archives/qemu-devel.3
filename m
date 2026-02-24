Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A5FF3C986
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutay-0000Nc-Lo; Tue, 24 Feb 2026 09:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutam-0000II-7X
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:53 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutak-0001HS-Kp
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:51 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d4c1d2123dso5594363a34.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944049; x=1772548849;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NJxocUqXTT7QeMisQeTRzyeyHRAwhOt7frlLYccIkys=;
 b=eSGlq4ssXUzXF43i4lEGjW93qQde9PTHjaC6+hvV0xPrPvFg2dK66XJARiexR7lDUM
 p+uTHxUw+uuA7GMuk8y9jARa/4kwquUx839VyxfR7jSqqxNQRJR5I9GwfkQLxgIKkpyX
 vGgGCvGMnWeSZUIj9y5kASZHlp5Su/oXwMkIuFXxLqg3grMROfffb2kodsP+8KVD1ggy
 SXzfmLtiX/oT9PULHZVRBN4F5OUduIwMJTBeI9ANH20i2uj5LBUdFPMcg9HKMeeTp2XN
 68XBYQeTf2UBwOl5wntnYGjuGSBT2TXW03cqKKTfXWOq8SIyoQZBChoo4sJc0Uvl4zi6
 Gubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944049; x=1772548849;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NJxocUqXTT7QeMisQeTRzyeyHRAwhOt7frlLYccIkys=;
 b=YsfqdNdwmGeCkA8axoYdpSpvxIawvW4tkcepveb+rGUdWR8oF2O1VmR3cokBTP5/GL
 WRQVM/ae5KbmVXGHML+2y+d7Ya6mIE+KN/1loiliujMGfGeLul7LUaWMg8ttGPHcx50L
 ST+MrOGqHhk/3F6zwE0kD8w3+mTPH+YaLbsna6pILoSxQoQ5h6VurwQc3ppLgPdHOqPL
 kwOA09hanmUoAe8QtXgA6/TTIcN/5fZn5X3kuzZn+90nGVHqmDSj2E5zNgGuwO1CNyRC
 ayU7MKhmst/d5f6MwLRlJgTG2bOSCSKlIH2DX2pUzBCgpwBjxCF6UIFAlZvLknboa9CJ
 OfpA==
X-Gm-Message-State: AOJu0YwWjNJNoZD7lGL2mwr/4L7htfu3EHjf/g2agXIo3PIoMDUcmArA
 ZNoN6Zka1DmHOEXbefA/6b3W0rQZ5H1Rw3NyqqkGjdLJLCkFH8zqMj2wwcsLqIzYBXz4IADmYYz
 Zt9qZ6Ps=
X-Gm-Gg: AZuq6aKgc91MnTecjTKdepzIPL5fAT/9KW0gNPfny1AiNNNk+Y9Uk8SdTScCrBaHQHZ
 a4ShtZh6bZQVwasV8WPhyMrFjDSpwJDfreMSmjjHxHvzx9FtwI4LkwiovBf04JUZOZvbmQUcSQJ
 9uIavVzNADkeQwPa94rCWaQW8YP/5OnyGSSGwM7v6ZBiq48GnjPfqV65MLlW62Tf4xo69PeYXbU
 TdomYCFQqP/hxfQja6uQUAy265yfHZWN86viUyaITxFLEF6VNHirBjK/lNpZeq2JtFZFrir2/Q0
 O89KHJVBfc4YRXACq9aw5km4PeL43z64dxLg8cg2qLwzVsC5TrFUlONYpgl3oTaZR4CjD+J5mOc
 jIV4nhPMRA6RauRE27pl1Tl3oMMaDshpJ1gTI4IgS2tk57IWdir/LZ94aLbnWIgA3gI3MQrSCfg
 FbqXFImJUSvA==
X-Received: by 2002:a05:6830:6c11:b0:7d4:9d6f:2b5c with SMTP id
 46e09a7af769-7d52be444admr8682332a34.12.1771944049248; 
 Tue, 24 Feb 2026 06:40:49 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:40:48 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:30 -0700
Subject: [PATCH v4 06/24] bsd-user: Add host_to_target_uuid for uuidgen(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-6-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1615; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=xKJk3b3JTdaNoZfGVMupFKiv5n9kwceqv8tWNt1MXEw=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhnFiqURtrReA1IZOgd2t57qYaYiRL9vSjyN
 gZQncewXKqJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24ZwAKCRBsHNEofbAR
 AFqbEACjU3SlaX/IjlkGX3+PPv67rXBQGQuwwGE1WkssxrAufPKJx+ggokYFKGPKB4HOYUBwWue
 KlGQQcEXlH0PM+me4X9Hbpght44zjirXq4hAuvUj1yrt8OZ56x5MRkqlSnclkS3cO0hxEiZAJLP
 ae0+6at93owYzvFsn0L58GYS5K6bct2OX/JH+cIQkFfQCvy6GNJkOynnHlCGt+GnascptlVbmhF
 HF89rY3xK1hKojzsjZp34ai5VCBkPlCAnehNTpN8j8uc7EG63cqvLbpZYzHtaV064cS8W4QiauI
 pQ/qSF3DldvBEPgNaytVeoshek4tjCrGl5TZ8wkRTpmUwzES0jmCtARzyG9uX/Njk6znd2GVw58
 tmDn7LRyx/vAxIrypDVoKcpP0mQN/ZPF75ibwnwPbS/9tfwguWUGM8wxnwQHZr8SsjH5yEozUPX
 kDPH7MwY1J2BXlrq5ovR9HXNYw9AL0JkKv2LKC2CMM5tuRZb15xIrvnRo2TsbOaUu4b09P9XXEP
 MMaWPhwx4kxip1sKp2+4vgHv1mMWeWATr7L5qnC9TVO9F+ZbuBZ6s/pYYku9kZfn8FghyMsbhKf
 VUad0ePqRoHe0j4MOYkYSj3Aeg70rDf0tj8C5KhcG9/5xtW/BqeVMORPaTLavPDR5H1kV0SdOUd
 ZdO0MVZ4X+CUZkQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Add host_to_target_uuid() to convert host struct uuid to target ABI
for the uuidgen(2) syscall.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
new file mode 100644
index 0000000000..68b67f37ba
--- /dev/null
+++ b/bsd-user/bsd-misc.c
@@ -0,0 +1,35 @@
+/*
+ * BSD misc system call conversions routines
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+
+#include <sys/uuid.h>
+
+#include "qemu.h"
+#include "qemu-bsd.h"
+
+/*
+ * BSD uuidgen(2) struct uuid conversion
+ */
+abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid)
+{
+    struct target_uuid *target_uuid;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_uuid, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_uuid->time_low, &target_uuid->time_low);
+    __put_user(host_uuid->time_mid, &target_uuid->time_mid);
+    __put_user(host_uuid->time_hi_and_version,
+        &target_uuid->time_hi_and_version);
+    host_uuid->clock_seq_hi_and_reserved =
+        target_uuid->clock_seq_hi_and_reserved;
+    host_uuid->clock_seq_low = target_uuid->clock_seq_low;
+    memcpy(host_uuid->node, target_uuid->node, TARGET_UUID_NODE_LEN);
+    unlock_user_struct(target_uuid, target_addr, 1);
+    return 0;
+}

-- 
2.52.0


