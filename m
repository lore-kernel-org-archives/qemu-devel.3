Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647A9ECD98C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38C-0004TX-SX; Thu, 05 Feb 2026 12:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo387-0004QT-29
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:00 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo37w-0001Ou-Nt
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:26:50 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-45c9f47e1e8so455499b6e.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312407; x=1770917207;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bhy1f0c+HZTisyhqBwOUVXHMNrTynQQG5ARwdnUm0YU=;
 b=25MKIwTWwcMOq2FHOKQ+Cn7KVcvBVp+UZC+KNr4IJM2+R5gQJsE2H8wuBVZEUogZFm
 MsAmPzK8zCXOuqng1xzvh2dAboDJiuKICHuzqoq57fsXl1toVVSALka4G1qjNSRoAIBe
 iri00clQ/zFPCeLMyEkxuWzmwX9KHRB9zywJOS8L0weRjdlYOeKg93zp2hZL0Q4cqRpJ
 KGVJlVm4VfHXWR9Wf1Q+i2rJBXyOkiXidYzrM66DFEWJNUTDm6zoSqIa1EwjyZZEC/fV
 5BT5KOpO/6OWAAezG5x6snc2riremZUhctwUjjDhGYZbEEI1+ssvXmZwHc4bX6XvB74v
 C4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312407; x=1770917207;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Bhy1f0c+HZTisyhqBwOUVXHMNrTynQQG5ARwdnUm0YU=;
 b=lBpV/atQ83szXvSOwEi0m3jxG0VKYe3g5QaHJvyve1HQerokG+GI9pB9Q7AGXmUvi+
 I/wOuTVQvpKOFY6JvBoOn8kUBoz/gRfMduEF5Kcy/o3YABoYyXQZqNTLNU8wCFsWBEeh
 nmL95PLXtciRaHNvF9wM2MKnu7q0FoYchxDBIbkWDlXLybO6UPKHt/4DXPkSglyoa6rb
 PoLA+vWMt7j3iXFwpUpzrcJ22x+3UaY/Xkjl6zJ2sVr50ndPud/kdLxM2GNrghQcyl1+
 /2NpIp7a+51WUPZMiJXhn9FPNRMbbam982TXCc80RAbAwoABlRyjCJlx9XRVbiMXaYQw
 JGbQ==
X-Gm-Message-State: AOJu0YzL7UvfXTWXwNpZ4BIpTIKoU8xbhm8x6fGtchN5AbEu3/XIZQuc
 cbAvuzWYGDfQJTWx7h6AibmlYh6SNhXSbpWAEwXq8diuqPvIghH5eY4jxtqhp5ONRBQ=
X-Gm-Gg: AZuq6aLa4JFeGqPFO22QL9TR/vuvEJtJzxXscbtbrRUdwgxZdwNvUkrHt5s4YKlDblw
 AiC5/gqbqI0JI5Z/N8DOVa3XPiOSsjshDF3x5zgrfpXYiLFdYOOQ/u8pM2DvRLvB9zGrku2sqZq
 qzlib4XnT6lwC7kfXFIStdx7VjFjDeZKVOKj6FK80Yw+DoJNqkN7YuWSr0iX4mCYNsBJjcJyvqj
 t4LVZnUtzK1HOv+M/jeugPzlKgYNfNkx9TXVToVvu9WbqLN6947WRRPmu7NrME4FckjOPw1S++I
 koqB+aEq3T9dpl2PqKvyqJCtZyf6hl3U1j3E3TTJmT2w1O/vp2JbdO7JEBZa4o2pIxnfQYvbvFp
 edOp+f2H7Gr0C57Mzb/iknu1VkUzwprgiJKxTkRzq10zJnc2RAoaAW7ErRn7rpEJqwPoPBWZ9f7
 Y4C5R11DK5
X-Received: by 2002:a05:6808:10d2:b0:43f:5c61:448c with SMTP id
 5614622812f47-462fcadaacbmr5249b6e.39.1770312407567; 
 Thu, 05 Feb 2026 09:26:47 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:47 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:40 -0700
Subject: [PATCH 07/24] bsd-user: Add target_to_host_semarray for semaphore
 operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-7-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=STjzEl5y/tm0BWpXj8e94rx1YzlYS+5OQnHi7ZnffHY=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLaHqH6FlHc3GDTj8+Kw/2Xt0O9mJ/bWDdrV
 LI7+6jiZkmJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2gAKCRBsHNEofbAR
 AMYxD/0d+Bdt0FQZ1qSYKyVu7VdxvSigECMmGZT4stIwEmBbIIBzG1B47pWVJBg47brYzCaQHO7
 2OjYjWB63DFSJwbHNRatedt9YB1W8wCBX14J/lGvQw5yWW2cRVC+frIJAnU/uF4UBGNP6KS9NcV
 F9M25dSlPV6jp+tOoMfmJPdqXM+iIpdc8NhPRCqD5G+pr37dqQO0ZpHnluvn7Xo3kJ2SJJf3V8R
 m8bKK8FMtO3bqmS1JsjBF1HfffoPEjBRa1WH+F4CfAU3+zJvBZsw8YAXQ5MdkQJmwApTHK3YXOq
 pd2olcJRrWHVfjV2V5XdBnInardq8CmZMzuHiGt21p7tOAKkP5k1oJVf/NQ7Rifc0GEQwWCMP+A
 6Ac+hKm3Dqx+03KwKzVjYfwHKwE2zjjp3mblybaDaJ7M++gr+zgMOSrB3M26IgxCh7HiHOYMhMt
 aCtpjj+I1WE8jOuxCaIBqoMmLB0rSJRFDvasy6i98Fp73telY0rdRSHULyvxrcYaO4N3Fk7N0kb
 ksBhk/1bezTZKDPHrMaQYL6mex0qRHkKu+a4YejoGI0MOvMu4iPTn8MBgL84lr/lE0CmRes2Q7F
 9o0lFucstF9GFbq2Xq2Ji1KF+JgijEYPHb/0eELcafx57WTQWDLwW6/qOwQRO/hvrxQGfoFD7E4
 06Cqfsd4dKGYAFQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22b;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22b.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index d2107b2f85..07d8bf1304 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -18,6 +18,11 @@
  */
 #include "qemu/osdep.h"
 
+#define _WANT_SEMUN
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <sys/sem.h>
 #include <sys/uuid.h>
 
 #include "qemu.h"
@@ -44,3 +49,33 @@ abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid)
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
+    *host_array = (unsigned short *)malloc(nsems * sizeof(unsigned short));
+    array = lock_user(VERIFY_READ, target_addr,
+        nsems * sizeof(unsigned short), 1);
+    if (array == NULL) {
+        free(*host_array);
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < nsems; i++) {
+        (*host_array)[i] = array[i];
+    }
+    unlock_user(array, target_addr, 0);
+
+    return 0;
+}

-- 
2.52.0


