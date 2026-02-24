Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EBDF3C989
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutbL-0000xJ-Dp; Tue, 24 Feb 2026 09:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutan-0000IP-CE
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:55 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutal-0001He-Q8
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:53 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d4bc6a8021so4347276a34.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944050; x=1772548850;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1ybcbFI1+bWLheJn1D4q055qQBEYMdVh+FDDr2mQnLA=;
 b=qsR5pYY8zaXE0beCBtg+QAdol89txktL+sTlYLwHJtSoe4G4DWSBaPZSx8mcSfTgwX
 0PYCHPS2iBqFN82Zv6YX2I2GdnsiaSSkLEJhMCTYMymXyQ9nX23/90qpDz5fgk1eo8Ti
 J2bVkA0xGOQ9xfWFTWm/GShdCGE9UtXVPwGzbFOqapGJn6MIrRfgJeWcZd52TpWwoPkf
 xxFB8IoWJMME7YBJ+mlQdEqmZTEcvGMIlqVQ+jqG7hyIeZH6XyY3B1a6ytFZee1ZcEjV
 1Pv0Di9D8Ou/RHSGr/jbiiN3avaDZPxq3LzGnGKUFu/PjGow4JteI6Ml5GoOOt78mLD/
 zWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944050; x=1772548850;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1ybcbFI1+bWLheJn1D4q055qQBEYMdVh+FDDr2mQnLA=;
 b=U32aG6RjgL44JvnCjUbRUv8LTq2YIMgNMksm1P/wx2r08rDUbCRQfVpaB/VPMx4ccY
 Q47O/SjHo8Bk3g+UfWz1QXFe4LWoV8AaU1XTWK/jNdahQlrui3U+Y2IkPZ6lUCvrrFYW
 nTm9Ci55Z11kKU2GJEfmrCfYj0O+WWhn5By/wUe1GvQJAf2nqREJc6zIGNtsN8kRQNTp
 qeRwy+g29xindDOk/5wvFfBAQ1FIyvib3O/naADjlNApcC4D6xohRaZXqRaKaKVgTktS
 fsQwph7bBEA4CKkm0W8Mc6c12pb9m0XiUPTHp7xnXpVrYwN6oc8YFayzvkFgqkM+X10E
 Mphw==
X-Gm-Message-State: AOJu0YxgZt9bbNbiYGUohQm1BPf1cErz08QzRuo/1h4v1Uwk/zDYspfq
 OkLUw7oUYlivRfMG8PQvIvJr72uXcuEVRLqOwfRTcI3BguILIDM+2PCfUIeHM+LccH565ykYuwb
 81ujjtYE=
X-Gm-Gg: AZuq6aI+FGWWREGUOMNbCS+alSoIThrl13X9hczo6qgdXtiun10qd79dAhvk/TCcopi
 IEDqmdpKc8P0rB4Sxb15j/locy1vl4NzLN+3dicfYFEdAhXgM/8Zb5dTrDeApiNKW8m/DTZgL1k
 PJNp27RB5vz7mYFvoPSggHY+Tf9JWUAdS/XKHxgMyRoSaNr+oaguiY9NhZr5vQTjY3oxk4QxoB9
 fvkrQX/on6syj1V1GrdCdmURP+1U6UbE5L5CB/pO5uhf4bYEmCHPkKxdt8JwPeihhou6nAB07ZO
 FHzQCjFjPdnlHLCOXLIl+ctwb+fSmLOR1b4qr1XlA2PN7gl3VmfePE/BPSaRtGTcyAq+pJOuYSy
 uZUB3+vrNbWJo4uHvPZgxV0SWAvtX9ZJmab35yDVRZr+o+MxCyALkfsblKs2NvjNuizH8l01d+B
 iX8JJzYyDQDQ==
X-Received: by 2002:a05:6830:d13:b0:7c6:cedd:8bf8 with SMTP id
 46e09a7af769-7d52bf36eb1mr7352726a34.27.1771944050328; 
 Tue, 24 Feb 2026 06:40:50 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:40:49 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:31 -0700
Subject: [PATCH v4 07/24] bsd-user: Add target_to_host_semarray for
 semaphore operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-7-8ee5ae17056f@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1745; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=eU3/9GcsUmR7R6CZ+cId5a+3Dosb9k3GJT2jhlhOAhM=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhnGN+YwNESLy8mJMwQDw8EPCVFiMa9plLKn
 MJ66fajW3uJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24ZwAKCRBsHNEofbAR
 AAMgD/9UbkE1D8oGSSjnHW92+bMITWaw3bKeLfOm5rh9uywdNJ545vR9FzFxgZSmnJPlnWxRUgs
 eXuXcx3XkHZn5GGKvbpaqLfd0MZ8rG2raklLzSVna9iogVoIXuubDw1QDB1jKhqJ8EzjPZ9Kdr9
 xgmd1kuEEvtXUx3I1VahyabkvLaHoeZyjUEEs+ZubQ+QiNOcE3UWpU9MuAAe0FN25w2+Ur77/RK
 YKHitNl4zZkHwF1qBPeUts2GiTSaZ+dOqLlpYDDzbhdRDscbeXsaBe09cs5MUlK/Ybb3rK11hPI
 krSGd3EZ9P3MFxNg47oWyz7+PRhVynXDXIkbl30rrJ5bOiZzK8PL6GizsRBk6ar9acZM79mCNo9
 FsNOnt0ZuwOZ8kl0PtOcNV39IxQR4m3nSxbHALhqLPVz9wOOP2tdt5LxeBQCccki8G4qmf6uR7y
 kE+U1VBh5G3nlrhygC2YBY+Tj+V6L5XLBcGFlHTPPSEh9P2smqOi5xtmPF4wE36/aFgallr8n30
 uW0Rfr+3NW+R7ssyAR99xMvrxldzKhsmjOM5zzg4QdQYElfepOkCPCGLzx3NDmwxxH9EKOXhi0J
 eSxbFI0J0m5lsMnUN3eTjCMHCVBDRyD+972M7Ol41qMZz5b1zpWjYaKntZPH8XI5hUJ1v6FDxDU
 b8I7SEnOq13KhRg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
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

Add target_to_host_semarray() to convert target semaphore array to host
format for semctl(2) SETALL operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 68b67f37ba..d1645db46b 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -7,6 +7,11 @@
  */
 #include "qemu/osdep.h"
 
+#define _WANT_SEMUN
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <sys/sem.h>
 #include <sys/uuid.h>
 
 #include "qemu.h"
@@ -33,3 +38,33 @@ abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid)
     unlock_user_struct(target_uuid, target_addr, 1);
     return 0;
 }
+
+abi_long target_to_host_semarray(int semid, unsigned short **host_array,
+        abi_ulong target_addr)
+{
+    abi_long ret;
+    int nsems, i;
+    unsigned short *array;
+    union semun semun;
+    struct semid_ds semid_ds;
+
+    semun.buf = &semid_ds;
+    ret = semctl(semid, 0, IPC_STAT, semun);
+    if (ret == -1) {
+        return get_errno(ret);
+    }
+    nsems = semid_ds.sem_nsems;
+    *host_array = g_new(unsigned short, nsems);
+    array = lock_user(VERIFY_READ, target_addr,
+        nsems * sizeof(unsigned short), 1);
+    if (array == NULL) {
+        free(*host_array);
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < nsems; i++) {
+        __get_user((*host_array)[i], array + i);
+    }
+    unlock_user(array, target_addr, 0);
+
+    return 0;
+}

-- 
2.52.0


