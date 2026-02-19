Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850F6E9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswUw-0002iS-7T; Thu, 19 Feb 2026 00:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUr-0002dl-OD
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:41 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUq-0001S1-5K
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:41 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6630d0685abso366559eaf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478558; x=1772083358;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Uw7NUpG8mQ8Hy29wLEnaC/jzVIxmuSLQerVtDdNoCCY=;
 b=01Zv/vO5MGkTcIwrFrFatNiwWGjL2tBZzJsShIjkRLHrwIU2iAoHLagMxjkgvcbpRZ
 La7DUzsAUBMZ9NgFJToWcQYpxsxg9Xum8wEHUJt+lEi04u+tiK9tNgFQDPxEM9omLdSP
 y1Gvx0W7Qf6D4qDqGCieyffnufoKcH2IEA2Oe5YUvJfzQTuOr4K29SU56iuHJkaqYBjM
 EkkxhMlEyQ+p2QzeuwdSIjw/EhGaMPOhKMkGYNcUkc9Rdhah333VTsMiQxwiPbX8s5ct
 mx2Vcxooh+ZYthp/FRhyCK3Niryh+344uMqGSuOCNPuOp4OtFmyTngCra2wJEx2PC5+Q
 u/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478558; x=1772083358;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Uw7NUpG8mQ8Hy29wLEnaC/jzVIxmuSLQerVtDdNoCCY=;
 b=LAiihNhBpCZTTqKu83gAd2w3Eg4+yv1aaAMzdUUyR1vUk5XVbxuYcrenb2cDvIKSrU
 /ITqzaupAbIKhx2TISnDhcuzh2uFV2l3T+KannBrBK+aDCVGOALd8MKSks5d/B4yshcl
 4Ui0SpnLw8hovH4jatycJtac6q9QgXwmPUxW4aZzJNBijg+7bjTc8sUy9F5xpc09WnEt
 qFmC4Hhf0F+INEhVbMZzx9gy9iN2UwEHG79scfuMSrqipCbBCBl2nJo+6JB/9EgXJ/LP
 UrgmOtCtBCpjJsCbX9DNjS2oQqBx6N/0ztth+psACJrsOy4H4FBAOc/cNvNwAgO/gAFW
 5zTQ==
X-Gm-Message-State: AOJu0YzSHj/wkxNChqOxoE+vegXoNbXK4SKLe6f3tCqbj5z7pqkst/FB
 QLZlP5hpp2m7jeTsQdEZACpJuwYEFxlxRlpJod2znEAm1r/6C/J/0E5Dz/d1uVlHv5w=
X-Gm-Gg: AZuq6aJdcu9WVLkPVYbOxIGrXsGmZqn7PHxpAxShTIdMH9F2snQToaMG09TaHlzSlfc
 QdrsjqzcOwf/a6CAonQqBEQfLwDz2trHlUW26Q27bF/2KAHqm9MySEP81DN1hkiOWGj2gb9BXMi
 jeMhMje87zAfX4q7K4egXXYLQAYS/NwJk5X1zo/jjh3e9j3H2hyzxwxeSKE/WL87eUS7F1tHThN
 37FyJ0rzALghIs0JxBj/YQkNwnh6pE1tzIeW8/rOZ6V4CBuFvp9+CGbXapR3Fx0OaWDa8ANgA7Y
 CwPDZSqRLb+ajdlWUivHZ8rrWgh3AIPhDouQXqQMYAPBLIWe/mVTxiffWiC2yYjU5BLbL9slaYD
 0m0WX3UeYMxBlHG7HGkJn5ENIqRdSX1bOazcnRoft1uyf6UfGf1fU7aSfkvchFgzy6aDcbnVBIo
 ycRiufPa6syw==
X-Received: by 2002:a05:6820:2001:b0:679:a483:a360 with SMTP id
 006d021491bc7-679a71e1df3mr2435199eaf.24.1771478558595; 
 Wed, 18 Feb 2026 21:22:38 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:37 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:26 -0700
Subject: [PATCH v3 03/24] bsd-user: Add target_semid_ds and target_msqid_ds
 structures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-3-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
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
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4r3rBc1zbAWE7mm4/3i1N3g4BDRsHPulgJJ
 52FBZ2eyLuJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeKwAKCRBsHNEofbAR
 AFs4D/9d1D9DM7+kTFAspI6B5NJaTdmimatzipC6gO5jRwAKQIOCDh/Oro+ZzkULreE0iVFJVPw
 Qb/Pwpi332Id14JBD5TRS7Kq781D5BX21Vlh5AObF6oYiS4rCnf1L9UWJ6Y0GOZ0qZ9YiPJT1jE
 a/hqhYCzdrpUHkO/zgwJZ/p9K6jr4ZkH/vFJMUEiv279XS+gplqKqCCih3+eErX5WBZSwjc9rFH
 YAlDRMfCDC1IAqrFiMIR7As8iI4QDYxkU9oqoxDJQndRJCDmoaFtsyGlXoWYrAJDN00lUo4ijCU
 6E3RUwTYbgU/IizQXTZ9s+huLFm43naPjz1ZweqUG5GD1UtJjqA/dRAUcypV1wky5I/TVbuxiTo
 pdkGPeCQQxzIP41ihUQmqJQz+PYgm06UsUbSyNlUYFsHkKXgthw6l/mwM1E2/WwsdLOebfpiybw
 SydZLuZMhaSI7GtbttpR6wtdBffwKnoSppSiRxujLKa1ids5b6Ye1eYgeqzqeE3wIh0CjK/KVri
 vgm+gxztgDVrJMHYhtv/2y+46cjlGzA1BvDRXg4qFU1NZtzXHugzFmkZOufg4Z40D/Mz2vhVGaJ
 llqTJ6otiHICBjPuk+uF1ZDT8+Pcu0UPZYWAceddPCtyiA6bfiANxxOumuMlNTcCU25Jm7vbrN1
 A9sSfrNuY/oXRVQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c34;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc34.google.com
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


