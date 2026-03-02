Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4728D58E4B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwunB-00013s-17; Sun, 01 Mar 2026 23:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwun9-00013C-CO
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:59 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwun7-0006rj-Sm
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:59 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d598f4c618so1761413a34.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425316; x=1773030116;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LliWkK6+U8IwyeJKNvGi32KWzYUv+A4wlSXc60OygLY=;
 b=dMoYsSSklX1c12MklZwqoEdeymML+yO081KLgd65Xj5Uppl+pwLvhLb9+9zxVb88cP
 5Duqy0cdDjrBsyIHLf/wPF7vjg8z8npMZmAV+p7a2aXJhQRur+acYe+ANu+0wWWWBlQ4
 wcJ79+1ySR8+zRuwNrnCj46i/2ZBV9AyL3sB7LFb0zNU4JfL0vcQt6wYhIw4Pv5mgTwE
 oZiPbXAUHK5rMifRasu23M0krXZZ8a2Oc6WgHd2er/zvVXI81DwHQWN3ZonDYl1cKehy
 Vzil34gDryHvgO+ZG10UNTfi4j+x9xW9Zd29PxXUMTRuwMd3cjmt4COc7gDrnDabbL7E
 ceTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425316; x=1773030116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LliWkK6+U8IwyeJKNvGi32KWzYUv+A4wlSXc60OygLY=;
 b=Wf997wXbj1BrplpDE5WfJmdYaTzmSOi/jA81YgouxMIeLOS1buqUBJ/bCJZlc8gec9
 rqxmKpnh6ZzCk++42XH5oH6m9StcS77BSzSlfS/XnQ7EI6h07JEu8oQ5Iz5KR/Ggqbf4
 P+sJMOHhLfuWD2Efc9Nr9Y3buVq5tidbB6KOB/LJ3f5fOY63J1peHXCshuuiLLgzE2Qp
 qU0rmptCp7t+S0H9cZimHnYmoOOdYAUag6gOoSguMva//gpwtVSuPryHllLOissmkw4x
 3pCQgwq+TmqTPvDc9hFPLSZhjCjoPuO5KFTVUnCjb/9OVoG751mmKXKD83TZjmasreT5
 rmOw==
X-Gm-Message-State: AOJu0YxEKY/cMddcVADMLqHrs504y1QuI1GW9/QA1CkhB7oOlSgduBbq
 M2ph6iliTeCRgkNNxOBLmhFV2xa4a8JtQW85c1RUdXlQoHMRNZ8i6orH3Fvwh4TrO+ncwnnzZ3A
 3VSLH
X-Gm-Gg: ATEYQzxkZlZXcAKqxHlYNLvBmAVc6w/bsKOeBEwRBlP1b1wmo3QOB+3nECCnx7teFDy
 PoASrTc3ai9ib4bVHhgLntjOh+Sz/izc43jhh363Q0JYXRwSoyEi1+QLJPXq+6ZNFHWr/76Nxai
 RB8gEUCfFPeVGZUvtRg8aNyqIbASbLPoNQ/HWID9fb8QbK2abui0XXxAhFlQg2oARjttM9/bVzo
 K618EUPnL3rkZ+RhOXvcFU2i4+ECQLOXhfNZSwvw+fOD9rGo6BlnscepeWFV1PcHWdPTj7Mj1+4
 5fglrrDrFqdAR9QfAf9kEq0G+0GyTMEWiwXBZt8GXWmhr4217awlajl+l/UlS9AakL086uBxDe2
 01SNZGcp6Fn6T/bBr9eAiGOf2ir60TTZwdR5tnhu1egeBdPOJbfiZzp6+21hogNzRJzRuhURZUm
 hVElH2J1vESQ==
X-Received: by 2002:a05:6870:63a8:b0:409:61b0:fd28 with SMTP id
 586e51a60fabf-416270692d5mr7425002fac.46.1772425315733; 
 Sun, 01 Mar 2026 20:21:55 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:55 -0800 (PST)
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
Subject: [PULL 15/27] bsd-user: Add semaphore operation constants and
 structures
Date: Sun,  1 Mar 2026 21:21:03 -0700
Message-ID: <20260302042115.83410-16-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32d.google.com
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

Add System V semaphore operation constants (GETVAL, SETVAL, GETALL, etc.)
and the target_sembuf and target_semun structures needed for semop(2) and
semctl(2) syscall emulation.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 84a3837b6e..4dbd90c2f1 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -93,6 +93,26 @@ struct bsd_shm_regions {
 /*
  * sys/sem.h
  */
+#define TARGET_GETNCNT  3   /* Return the value of semncnt {READ} */
+#define TARGET_GETPID   4   /* Return the value of sempid {READ} */
+#define TARGET_GETVAL   5   /* Return the value of semval {READ} */
+#define TARGET_GETALL   6   /* Return semvals into arg.array {READ} */
+#define TARGET_GETZCNT  7   /* Return the value of semzcnt {READ} */
+#define TARGET_SETVAL   8   /* Set the value of semval to arg.val {ALTER} */
+#define TARGET_SETALL   9   /* Set semvals from arg.array {ALTER} */
+
+struct target_sembuf {
+    abi_ushort      sem_num;        /* semaphore # */
+    abi_short       sem_op;         /* semaphore operation */
+    abi_short       sem_flg;        /* operation flags */
+};
+
+union target_semun {
+    abi_int     val;        /* value for SETVAL */
+    abi_ulong   buf;        /* buffer for IPC_STAT & IPC_SET */
+    abi_ulong   array;      /* array for GETALL & SETALL */
+};
+
 struct target_semid_ds {
     struct target_ipc_perm sem_perm; /* operation permission struct */
     abi_ptr     sem_base;   /* pointer to first semaphore in set */
-- 
2.52.0


