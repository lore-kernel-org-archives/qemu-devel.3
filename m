Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E26EF06E2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 13:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vp4r0-0005q9-8G; Sun, 08 Feb 2026 08:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manishyoudumb@gmail.com>)
 id 1vp4qq-0005pK-EY
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 08:29:24 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manishyoudumb@gmail.com>)
 id 1vp4qo-0001Hw-LI
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 08:29:24 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3562258142fso477842a91.3
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 05:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770557360; x=1771162160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hVaj8lSk2x+ox2BqGp0oGSbNfcP5O7ZC/H0c7Il1T4I=;
 b=jcf689p7E1UV7SWkyK70toDilgFLyACrVs6Z4/Wqvg1Q1/G9dSr+fPbMTx2AERcGhB
 IKe95DYEpG9tKkdBkHL9PEdpwBavnyBuw8OluTmBfATyiAUnWxYnaZoGVGzdOEsVTGnE
 ZRGqdVxkLDWTKZ/WlZUq1uIv3DxQ+zHnVItmEz7JJYR4/nHPwU6PD/+syg8OFvYi+o9T
 tXjuhj+S8eWSVGQW8qmhuuvE1/WlyI6dGcVISfGkPSkudH80UxXf84CSIeRPatjI6mEh
 mUS1eZMfq4vVsNa6+RxWBaCM43B5rwIrr/xkIu24rAsjZuzbcBOK7aouDTpeS0QyRN8Q
 AE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770557360; x=1771162160;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVaj8lSk2x+ox2BqGp0oGSbNfcP5O7ZC/H0c7Il1T4I=;
 b=osU/P2F24nkdoQ7wrYwYWUwA9eY8J45LL2mTMKJFGK48uJcryqqu/FGoz9Om83dZrX
 KSqka5WVIT8IUJ4si2NAeiri0h40zKZdxBXeAo/ESHPgdR/aFq25mKXSbLGhBADwW2YZ
 4mlXwQYAr01Kn8XKyjld7CUZwn0Qlq2JCRTNE7+HrT2Vcm8L/8La+AEd5ukeUUNcp94o
 z9FMSIK6Rk01wDQQhaXA2D3uE5gRyUsB6Kjhb0e96rrf+ljZqLS0tYYJskZ29KeLHOko
 6YxvuUyChxh29LRhXWg/ciCnXDJb4QWzwF9z3mDmMU2a6u8F2qZOKlsnJ3E8VMi6D6Qi
 HkCw==
X-Gm-Message-State: AOJu0YyMRpeIHolqima+yf0vwYqXViupJDtScxxY7z4XD5EeaeZg7855
 b4mG3D2Q1BcDED80E2GKHaQQ3Vg7Kx0+l9hk9jMMY0CLKABqZz6FgUCVqYhehzkd5JdS1g==
X-Gm-Gg: AZuq6aIj+aQm003m+Jb/O+l6hkqSgjQvYfkIWUw3MEnsD7qkbNVO/TxAjmepmnDZD6j
 fCHdv/PaL8ku0R7qHDZZTddGEGL/ejUaYERtiJi7MUlkCHDxtTqUVx7T1CntEo1Pk5cNsYrRO9a
 WKllhUKqUaw4zb9YmYg2OUOVURTBfmM9qFFCl4nOuwOdKGZiBDrNTglTyXSSCAMowcLR6crYi9I
 3bL9jhTojX353sOA0dyIvuTC2UjUAk59iCIIjjbj6PcB1307tgJKH2P47+R4S2cPwe0nSSpgzWD
 N72iRZl8z465K8xexT1h/n1Aju0MnFeCH8yDDA4NjVwnevW8m2WV6J48fMaTfkilVwxdKUTPrpP
 R4ygN5KdGl5Ei2QRgs9wV0Kg0zYLRbs/iDzWRvIDZbq8IXL0BYoynXTj3fj+NCC+o8x+VfE01B5
 bl8zk1TZSwQzoOMFjLx9QrqoSWVJvADyLhv1YQ5uM7+FQQN6Lfw64oM9mMwx9IhPYviO/ucqSEw
 YGmMRB68NTW+MWj7Qpau2bIbDpN9dRgd4RJ7gysPCvni2nZIg==
X-Received: by 2002:a17:90b:1d85:b0:353:49f2:1e7a with SMTP id
 98e67ed59e1d1-354b3e2be90mr8213515a91.17.1770557360449; 
 Sun, 08 Feb 2026 05:29:20 -0800 (PST)
Received: from localhost ([2409:40e2:1008:bc1d:9205:403a:2318:6cbc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b2253c70sm8003747a91.17.2026.02.08.05.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 05:29:19 -0800 (PST)
From: "Manish." <manishyoudumb@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
	"Manish." <manishyoudumb@gmail.com>
Subject: [PATCH] hw/xtensa: convert calloc to g_new0 in mx_pic.c
Date: Sun,  8 Feb 2026 18:59:13 +0530
Message-ID: <20260208132913.41498-1-manishyoudumb@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=manishyoudumb@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Convert the calloc allocation in xtensa_mx_pic_init() to use
g_new0() for consistency.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1798

Signed-off-by: Manish. <manishyoudumb@gmail.com>
---
 hw/xtensa/mx_pic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
index 07c3731aef..ab308c9490 100644
--- a/hw/xtensa/mx_pic.c
+++ b/hw/xtensa/mx_pic.c
@@ -316,8 +316,7 @@ static void xtensa_mx_pic_set_irq(void *opaque, int irq, int active)
 
 XtensaMxPic *xtensa_mx_pic_init(unsigned n_irq)
 {
-    XtensaMxPic *mx = calloc(1, sizeof(XtensaMxPic));
-
+    XtensaMxPic *mx = g_new0(XtensaMxPic, 1);
     mx->n_irq = n_irq + 1;
     mx->irq_inputs = qemu_allocate_irqs(xtensa_mx_pic_set_irq, mx,
                                         mx->n_irq);
-- 
2.52.0


