Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B493EEF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpARW-0000iK-PP; Sun, 08 Feb 2026 14:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAQq-0000cA-30
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:01 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAQQ-0008Tp-9J
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:26:33 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-4044854464fso2422827fac.3
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578787; x=1771183587;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fL6lrNfThcObg925i6Peu73sz8BhpKL2ziR5Ww/VL04=;
 b=KljNj66deSUoKFyVyTZRYULOx1IPtJHBO0NT3PzAvZP73pxvJ3OTsdotMs7sDa/AJC
 li43D+J8yQs2FExIMi6rZLnycMfTV/AzUoIWxNAwdFpO+tqwWCiDpISFhvNWhF7qtA4L
 76d0jmML3zjFO78ZkW7Seq7LdFf7pMoS9HZu3eY2JIgkWRPbQXDOP8dli+Vn9lB3yy5Q
 mnAtO/ewfSzTLE0Ypn4mKNHVXngi+JJHqcBVFCqBrrZsFXkBMRFNa3I6qw+LNbV2YoCx
 JnaVfqut3wKW+Jc3Tr3TqmSARKdh2Cp/18cfoRqNJSo4bHtqZQm0+1jTQq0mtjFHy345
 toJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578787; x=1771183587;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fL6lrNfThcObg925i6Peu73sz8BhpKL2ziR5Ww/VL04=;
 b=WX4PJrq7Qz0FUCwXalscJ1yRQ6FFm+f48TSaspPO+cWl6A03da81lh/17z8pLtJokI
 OMqvxTxCXgAgqtQHZie9XUcdhO7Zob3/OaMichf4l4rHysGKWnRmO9rRUWe6icE+tZ6z
 bKX0GI/oRupI1hQeMcNsDfnBI3J16Bu1TaKH+PCEoGvTDerTY744P/D2wdGbS1Em23a8
 981VaEclydp2Kch7ppN4r9IkE4GCZEdmrNm1w9MzeMx0yEQn/yCYVaR/Y0/vmnO6/gZC
 yh1biKpRGn1z8yRBfpgE0Rfl6fK/ZOCBzk8mNFz6wdR5e/Q8gVLPUwlnRFWfMW/4zqfv
 PtwA==
X-Gm-Message-State: AOJu0Yw+PS1sXWnf6x4XV3hKwuqAGoNZqmTNqBRNJsBZluFW+4cPdSsW
 xauyiReot03ozuFNBMIIwlGF7NqwH3arRYmP9aN54nlZov5OeYOl0jIC+246ER9jWFg=
X-Gm-Gg: AZuq6aIGJOMMojkLa0jkUWmBtQG8XfuPMqhtvXX+u9va+yJZ8bh2EAEvZa+K+dWUgPH
 qbWWBqZQxP+S7lgxbm6fvV4Zk+LCSrTLKdjDR3Tm4JH9m7Z18HyQcTKhf9T38a9W9t0sEEnEoQi
 VyKJvE2mtQfLzTo2mLxHEnpbg9v8PpSYxLC4u6n9OUSZ9Q0lKrO4Kz7izd3nddfTcWlU3hhulPk
 Hw66GvjUWAMw3EJATnQ5lwlZs55rRpXS2hT7Qf8ajWQvU2ylCFDltEVvfu6epXceA8J7mz1wINb
 Y4RyibAcl5wQEy2pZeDTPTW2UcW0KogKrYd/Ilza+ODWv2AeD/NXTUFVpgzqPfmqLnUjCXso4p8
 Vr4ACNiLcWQqtRfalgtEZrKWDRJLsmNnWjhIhIIBDzmH540b2pV17MIVUSUiv81LAEXLc0Ex3bw
 86bSIVkJSl
X-Received: by 2002:a05:6820:999:b0:663:1239:9ecb with SMTP id
 006d021491bc7-66d3262b51emr3925411eaf.6.1770578787225; 
 Sun, 08 Feb 2026 11:26:27 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:26 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:12 -0700
Subject: [PATCH v2 03/24] bsd-user: Add target_semid_ds and target_msqid_ds
 structures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-3-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, Mikael Urankar <mikael.urankar@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1953; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=OQ3XHGw21pzuZykOWZfch9QxpJyXs91tyHIUzcuXzpQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONf5M8eHwikLP8qNyRjL4FvDAEnuQfopaqit
 v6i7aJ/dYOJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjXwAKCRBsHNEofbAR
 AL0JEADHfb5JuvGjoErzUlxQEW9EQpSsNvjdxSDSMJFfBHP7TdwxYuLHSHgzqnhi37u+YjXQdsG
 oCdQomv56Cyz65LSTGde07H/2XunFZSQuEnNYrZe3e+PZImAKrnSRHOMqF+av+qemB9u9p7tWcj
 ZH+3Nmv8nwuX9tj7E6WXPQHQRSIqw6tsGu1hM2snOImLUgbMPatR/stppPmK7YmzYIml/PjshVd
 R6xXMDVTwOLDWK9oU1fHUNQejCoSry4F4r6JpabgcxOPSqKrpWT+Bs4T3+w/f/OLfV9iZ2gg7Q3
 IYLqVClJGTaswupXfOSrH3HYOVzqILrf1szKP2rwSlk9k2zQ5DFsJCihSj9dqzubqx9AM5Uu+64
 ykgSb8xyvblydcecWMq/dCN0KsWy9hQU2R08DTdbrWQ2iKzhMRwIgV0aKv2YY2U6rIBp+x5bnLH
 CNN5cfYXf7AgzXiaxSux87s8ra69AmxtCOPt30weC58Wr4U98zNK5O1jOmbnJrcSjDxx3p8EK0I
 OPurWhzUSP+n6JsAOYZVgGGRkbt95JWmU3nN49vkgjgQO5sd84UBc7b+8R90GliTuMxoGbnckt/
 bUpmFOSwwpITHTmm1w81NNYNcITSNAjoKhwPBxASNbtWLLtdCHQlklnt5V68zA4WKR7aFoBYK+1
 3vcnxvaSuxdJELw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2f;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2f.google.com
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

Add the target ABI definitions for System V semaphore and message queue
data structures, needed for semctl() and msgctl() syscall emulation.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index cc4b484f3a..92fec12acd 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -92,6 +92,39 @@ struct bsd_shm_regions {
     abi_long size;
 };
 
+/*
+ * sys/sem.h
+ */
+struct target_semid_ds {
+    struct target_ipc_perm sem_perm; /* operation permission struct */
+    abi_ptr     sem_base;   /* pointer to first semaphore in set */
+    abi_ushort  sem_nsems;  /* number of sems in set */
+    target_time_t   sem_otime;  /* last operation time */
+    target_time_t   sem_ctime;  /* times measured in secs */
+};
+
+/*
+ * sys/msg.h
+ */
+struct target_msqid_ds {
+    struct  target_ipc_perm msg_perm; /* msg queue permission bits */
+    abi_ptr     msg_first;  /* first message in the queue */
+    abi_ptr     msg_last;   /* last message in the queue */
+    abi_ulong   msg_cbytes; /* # of bytes in use on the queue */
+    abi_ulong   msg_qnum;   /* number of msgs in the queue */
+    abi_ulong   msg_qbytes; /* max # of bytes on the queue */
+    int32_t     msg_lspid;  /* pid of last msgsnd() */
+    int32_t     msg_lrpid;  /* pid of last msgrcv() */
+    target_time_t   msg_stime;  /* time of last msgsnd() */
+    target_time_t   msg_rtime;  /* time of last msgrcv() */
+    target_time_t   msg_ctime;  /* time of last msgctl() */
+};
+
+struct target_msgbuf {
+    abi_long    mtype;      /* message type */
+    char        mtext[1];   /* body of message */
+};
+
 /*
  *  sys/mman.h
  */

-- 
2.52.0


