Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61444F3C986
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutar-0000KT-77; Tue, 24 Feb 2026 09:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutaj-0000HM-3x
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:49 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutah-0001GX-Cp
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:48 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d4c1d2123dso5594296a34.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944046; x=1772548846;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Uw7NUpG8mQ8Hy29wLEnaC/jzVIxmuSLQerVtDdNoCCY=;
 b=0heRmfwFdKEOJfQteqMQTZCTWBLg7Sz12hAtM/WxGUC2VqpatJYMheb4NekH1i7r5K
 S/Ovc8saUm20ptp2oH3llwE+/Yt6OFDflMm6W1cIiJZwMN9/QmTAMLKFJYows2qP7lcf
 wavCLdwR2IF/NQ3LNiMDqQurz1H0v3tNFI4aPuO2eAzYMMtcDfypwBCB0liii6vkwIsA
 art85ibCm4cd/Smb0ILeYyluA3yR9IHu/jdUMkg/D/3x4WI9wMRw6QfcgvyCUju+nL7n
 o+IPQc5YNb2MG7UAIoruxl+LIQ1Z8ZhHZQsJm8EF2j3mKD9vvKL+sV0r+jZ8pOqdKl8F
 zEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944046; x=1772548846;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Uw7NUpG8mQ8Hy29wLEnaC/jzVIxmuSLQerVtDdNoCCY=;
 b=m4E7WGK1VQNnsnquoGD3uKNLNlXG3PcKKo3E81vi38GU9cLhnkiJbBuLbL523whmPg
 gfGMqAO9gM+3YnfwihNM99E52MlptxANnJepb5dGFM1NJEDgr+PGsGp/p5HfKMWqbf/q
 PBQfeDDErdUHC8Ro3MKhbJKh2MxTeOl4lF3nUYofzmuYjXE5mWLM8mu5G1acaSf2O5QI
 dXfcHx+OotPKOmmsCDCQmYybqSgccM5yiB7va3O+0SBQpJlMjrSyN/OaZnSaFZHpYe17
 yJmUf3cbeuzOFSdVRBQ5J+Z7yuLaJ6aooHGfjmquCftO+GZJvRxiInHKL9XhCt9zY8f7
 oCFw==
X-Gm-Message-State: AOJu0YxI+MEQ2ZQ/3tQKkvXOLmFRAiGnB+mZtvp+995kpIGnrckVTiNp
 a7SR+mzmO2vqNXyl455PYtwsTxFEWaMvM1V3PXr0J0PnQo7uTAcUkcV8iria8yD8Lv3Y3UkYw15
 UeUoPFoY=
X-Gm-Gg: AZuq6aLeARCUPlzJVuS2WshLSmXC5XouAfN9tpyb/cG0cCaUqeRbrU/+N4jG1sYG5UK
 5Jt9+QmP3B8Cw1a/c7DATkO/0PDmJV7zyt5zu3Kr1KWDLSxc0KgcxhanbaptvBqhTw+R+VrxEB3
 6U6DibmT7OiuySsywrTfEUcsToYPbNkXtV/nusPQd6qA1eZD5L1AIcXbZ4qbqlcjsvI2Cou4pMG
 YniOlRSjzTi0at184tyHAONmECGHnimUPmk4JcUUsv09Lccn1YZEKNR+RZdWPEobJjgFEY8Nlga
 b7WWwJrJGn9FSt8DBU8omqloVl2zXXfIfqNiYumfWfWQt/xPkYrYYPjqfM3ohxppRxqj7Id5ZL+
 oFcOCEHx1eZZIyzFLhejwE37NBwc8u6hyVqYu//SiMdNIYqVz+m7abKHg6gQQ8U3uAgDNWa5Hl8
 YVp8bnYnrqwWByBA1P1vo0
X-Received: by 2002:a05:6830:4905:b0:7cf:ccf2:ebb with SMTP id
 46e09a7af769-7d52be3eeb8mr6735298a34.10.1771944045955; 
 Tue, 24 Feb 2026 06:40:45 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:40:45 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:27 -0700
Subject: [PATCH v4 03/24] bsd-user: Add target_semid_ds and target_msqid_ds
 structures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-3-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, Mikael Urankar <mikael.urankar@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2016; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=PgSl9fJ5kCN68rsWxwDK5Ght6mDDNXnPdfPQQtggdF0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhmTksXhS61ht3Ww4VaA2AQezw/7KZ6jDdtj
 zerC4kjQMaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24ZgAKCRBsHNEofbAR
 AI0rD/9tJakBmTW+7l5pXMUm7O3u+Nos8pmMbIRCJHg12Fjl9UR3aDu5SyYC7lNgMgwZ6bpZ6+V
 Eh+UbM8ns0v4re39Xc/Ji59XJ0K+oDeOsxzGMqNAnw66ZhB2UUV0MxmZnL5FPjIJEu0X50OfrLa
 vjncywa/dFm4S5VW6YfTixY8gLpi45J2gkvbBiIfUbGDg+/1Jp2nes8LViKxR6k5CXCIpw8A5Cr
 dPvbAmxVDXzqOkuNinvHquo5XwsYQBjB5NtWlwN1vyvckUpRiXXXKSl2xXGpSckNmUCGNL3bKx5
 1ZhXhJznsf742kAoBC3CYn4c4mnY16KIE6+LWcDDway7wnH9A6Eia0P704YXEUuli/VxxpxgXIA
 1DN5Mql9Ff5PC+/OvH4ZJL+05QtMuf/S4K+Mcl8+G2CWXt7kk6+UPPD30+okF0hLaH3I4+qXjzK
 xjb+bV21HGa+X100sm94X7X6vpYpt1tDfkhzzpwNivSYQW0CTdli+9agMk+bOQ/ZymEPDeLKURg
 aj+Hu7EP74CAv7nmbvVA647Xh6qo04mj4nnrDrmhYaiGjzDyAQ4dqTY+JLAc0tLwI+lNGharYJz
 ZiwF5d9SrEK5LB039oGsO4BQRecLsJmvsrZIvweMum2ImIGY2vkNUK2Ee45MLL6wvJy3/G55dld
 MQKQSOTXPwrT6zA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


