Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C41C52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29h-0001jt-3H; Fri, 02 Aug 2024 19:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29Z-0001TG-Bw
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:46 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29W-00048l-IF
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:44 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-81f905eb19cso432310239f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643061; x=1723247861;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pyqu+sSEKz2WONWccyrlSdXXuq+wJEyOvfRZMJHkZxE=;
 b=QJu96iQc6MS66pOpp06vULg2O+4v4aavlqnrNuzgg235M9cW9MR7KwvYy5xyPjVm/k
 zxU4Yw0ExfWwvBQFr6o5KCb7o+2zIZ2PFXmoQm/X/Q+P1J112gVy11WaqurGZUBvfnHq
 VgwOXbj/jYNs+3IjcDS19evwrclKLCVn5/S6m2CApPlGD7dBmq8cZoX09mKiStzajZLK
 gqLkHniTyVlNNfmAI/Xf8BoicN0srBA/8ZWxeWnyA36WLi5C1Oc03nBE2KkMiXq2F0aq
 AxRdHJIyfpPGkvj6896uUW1foUXqeG6h5kB8UNqjqq727/XUGST0CbLKU75H1jLv7Fkm
 Pb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643061; x=1723247861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pyqu+sSEKz2WONWccyrlSdXXuq+wJEyOvfRZMJHkZxE=;
 b=N68G6VblazzvqoW8w4eclVLAmRk7NBbGF4wnBlVuIuEU5Qh2sq/JyGVyanJWiNKTVR
 InTIhUzerMDBHkeC1OYmb5bAl7hboCjpf+3EI4oSmPpYfdK+9zbAurs7Pg4z1uOtozoI
 +f4VhL6p7vVjZZYDbolSFgsdJ/X1bZf+2wzjIJmVIMDHm06n5A00XQ+8sJ8KfRTJ9n95
 Qqmn6hWYRErLEfSi1j03h4/MKyClKGhyZDKDaqqzyW8oChKTDCqi2jn+rD8DGMjqQEIr
 ddvMiEa7UptbE10e86nIxxqQFgt3tjIb7DCrhT+RsGLBfo4jYvl3VK1MarWe5q4vKZ8g
 2Seg==
X-Gm-Message-State: AOJu0YwRH12PVQ+/xLUb9vXTj5FIxVdnNf93SYQjXNER96oHWeDDGB+9
 hxAjoWL8euAuWpN205IPn+4dN6u7FM+RJ3UQ6VMzqqt8yj5POjPdhV9RMnhCIuNrq5G0sBIIpsL
 HJcY=
X-Google-Smtp-Source: AGHT+IHHhNhfLXIek+dc/cEjJNjaZTHitp9FJAU3pzJdGWBjv3VxjdTjw7vSZsH4uEp7wR9FW/hdXg==
X-Received: by 2002:a05:6602:6c07:b0:81f:922d:b3b9 with SMTP id
 ca18e2360f4ac-81fd4399516mr761525539f.14.1722643060897; 
 Fri, 02 Aug 2024 16:57:40 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:40 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 02/17] bsd-user: Make init_task_state global
Date: Fri,  2 Aug 2024 17:56:02 -0600
Message-ID: <20240802235617.7971-3-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d30;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd30.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Restore init_task_state to its global status. It's needed for threading
support outside of main.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/main.c | 2 +-
 bsd-user/qemu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index cc980e6f401..4d29e13a8f5 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -213,7 +213,7 @@ void qemu_cpu_kick(CPUState *cpu)
 }
 
 /* Assumes contents are already zeroed.  */
-static void init_task_state(TaskState *ts)
+void init_task_state(TaskState *ts)
 {
     ts->sigaltstack_used = (struct target_sigaltstack) {
         .ss_sp = 0,
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 4ccbee265a1..c7f78096734 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -119,6 +119,7 @@ struct TaskState {
     struct target_sigaltstack sigaltstack_used;
 } __attribute__((aligned(16)));
 
+void init_task_state(TaskState *ts);
 void stop_all_tasks(void);
 extern const char *interp_prefix;
 extern const char *qemu_uname_release;
-- 
2.45.1


