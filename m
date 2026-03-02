Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF7CD58E47
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwumz-0000zw-Vd; Sun, 01 Mar 2026 23:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwumz-0000zY-5V
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:49 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwumx-0006pI-KR
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:48 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d18f80b5c2so2660784a34.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425306; x=1773030106;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hx+/gdtLWNB9rjxJsdlIe5kmr094F/qIQlvquqXpjHU=;
 b=RMCDwpXKTibOpBx+Y4shERjmVeNJGkILpBzq6OvWxrl7C4BJ+A6UsvbpHwN4D2oNQA
 O9ROp6ngLbWqjb9ZZE0MuBswKTlxO8RRX2ZQvkSWNQ71gatffzHPe+8S0BOIHFu6U8PU
 pMWLGITAEkBqugh5GzpCFt2hNL9/+EQSDjfBXRNGIMKjx1NYaGDq7aozkLYdfu2T2/Gx
 zkGpvd3OMKZ7X+6dqeXgQO/d3EldA/erDkOsx6nebvFS7WT4GEZrcPiwNDw8hDQlX/I9
 ELf3OSE0CFrmXl2PUuwtmOBG7kK5ABMqoe87JvysHl4w11CH6hmZLLz1mdAUFSifkbF4
 29yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425306; x=1773030106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hx+/gdtLWNB9rjxJsdlIe5kmr094F/qIQlvquqXpjHU=;
 b=woGOtBJxhxf2X8//vz+r57SviqQRfQwYLmdYQuKBTwjoog4UPnCDjN8Xb+5xd3AxJC
 BcA2HhT/VpmOYhVb4WTLX61CB9sp5IGx9U2ynJdF4NrIJihJkp0QaiOfykprfTZQ0WW+
 wahvWMYypuCWaezWRxBfPqpFCZ+NJk3L6qAc6P4WxZfrLuah+Tlg5nQ2aq4007Bka/le
 UL7W7H7CW0hAH0QBJdp2LsfhAEfr+R4FVYPL7vpTWgC9KusjQBAf0CLQS3S/9cR3WWzH
 thGkiGJ8OdrffB9cs0i0T6fYLzSQn2lGFpS5XXqJPNCNxVFE0+Z/LM8DzUYiLb8U+XcV
 RVOQ==
X-Gm-Message-State: AOJu0Yw/7DTAZe30qc27xrPF7ClwSKEGHlOQoeYd2WwdLXGGYjmwEC2s
 gnv8C7JmxZ3ly7N7heiC+UETxSH4pTMKJxGGfKFP9pU46fnYSrahNqrnEPmif5nCIOoUksJ2dE4
 aRPou
X-Gm-Gg: ATEYQzzF/FDqHfEkZxGa3XkuYx31KNWUKRrwE0M7ueMXD67NSHjsuLSImdcXDzvwNFW
 zDHhr9+aNaRWW9LbAhA52f4XdseSfBqq0DOg3L88tp+gYZwlwldvEOI1VpFx2D7vSdK4Uq7Kr4H
 +Eydotm3QVFIZ4TSNSMng9vi11XagQXAQTR0ReQBN+iuJ7rJjtlbvtdmulqPXQRBou1eQetys73
 TsrTOPBQkIn5aLX7ptUrDBRdF2Bpa0QGJLdyer8hL6KeTsz6iNLgC/W1CqGoip2MnE0ZmYx9quP
 n6tCwvzzpdSnHPQ426BRIVMqQFpoAu3Ub0jyJmLjsFXv4tyAgnjoq3jOaKkKJ/BO5oI7z4Q0ERL
 388rCLUua7+Jr4iiBdPywAqW4yXemcct95SSv2bixY00aRKVG6NgJeHmBsirLxEGkmOjMkS/2+z
 7tjJutf0KqAg==
X-Received: by 2002:a05:6871:cd:b0:40e:e3f6:bc9d with SMTP id
 586e51a60fabf-41627102a5dmr7356143fac.43.1772425305858; 
 Sun, 01 Mar 2026 20:21:45 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:45 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/27] bsd-user: Add target_to_host_semarray for semaphore
 operations
Date: Sun,  1 Mar 2026 21:20:57 -0700
Message-ID: <20260302042115.83410-10-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
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


