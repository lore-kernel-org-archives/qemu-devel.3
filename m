Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884DEC52D72
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29k-0001yL-0R; Fri, 02 Aug 2024 19:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29e-0001im-M2
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:51 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29d-0004Hw-7n
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:50 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-81f8d644fe0so244061139f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643068; x=1723247868;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Z2vd5lroKGBHrik7P/5HRr5owaUTXoIaCHxzqNr690=;
 b=qhCGpuAdibP4XNbdwE92QWhyB+i56ZQVg1SbT2ZiPyyMI9iXatSuLeUdLl8s4ajXG5
 xB+mdGOIddbmfyqe38O08bVfrBawokFNaj1yXcbjU0BhHXSOs+C+rLpCx8odrY4olUQ6
 BHYLIZ2e8ViPnEL/erp4WQOfZrgZIrWndF9uHkKsR1to55klEk48z/GW2GOnJYpoH9dX
 TvDuAnsZXc/zPqWYm2okDAxa4aNlh0Uihj2Q2HypqTnqpwCrHW8OfDrL3rEIK/6ZtfTA
 mdnzQHwYVOe1EQplXywDCFKEzSDDo85L5YRUBAaUPjIGWqxB7X4cFyzXffUeTmBNIgAi
 3F4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643068; x=1723247868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Z2vd5lroKGBHrik7P/5HRr5owaUTXoIaCHxzqNr690=;
 b=h0c6PF3UfVC8RlSlOogYAJ9IwcURdZq9UKCqyySiUCA58yGjz1ubB43YSj0XsbeiYI
 zwa+di2U8TeBUHShZmOZp59tfSR1QsW3T7E5VPQnw9KVo26o6u9crOT149yzS5i5QC0+
 Gv7uXAFuiqbVTip7ALv7JmcvpQ+Y7mtLRtDuuWv3lPSk0pPz0SSh49FsX8J3IAXiNto5
 3C9pNBnriJHTWHx5vDwoknGoyaLFoPDVGku5zy5a4VObQN+9oDqnyrJ/SecvU7mNjEhB
 iz3YiGj0VKz8ClQxs3s/1p/ERyPhYy77U4dUiM5CYQ1dCP/HPH5a049wkrC6z7upshIc
 C3wA==
X-Gm-Message-State: AOJu0Yxtl8MjJk1BBL+xF3cGHO+h9KamlmBgv0uhSBFGACxe2FDlJPDs
 anLjee9Y7HrmmNCHdGCwqNNFsP6B5+VM2TSiuY8vn6DtwlNjbuSPzlDbPO61x/9KLucYYmVhoIJ
 GUIg=
X-Google-Smtp-Source: AGHT+IFopvDLL12aWDbRW2rUu2u/fJ2ptES83fR6pOQKS/EQQxVz/dSQbgCiu2yG+ePVF9jkTnCjIA==
X-Received: by 2002:a05:6602:341f:b0:81f:8bed:702f with SMTP id
 ca18e2360f4ac-81fd4353a65mr629795739f.1.1722643067821; 
 Fri, 02 Aug 2024 16:57:47 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:47 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 08/17] bsd-user: Eliminate unused qemu_uname_release
Date: Fri,  2 Aug 2024 17:56:08 -0600
Message-ID: <20240802235617.7971-9-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d36;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd36.google.com
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

bsd-user has never supported this, and FreeBSD make it easy to set this
on a per-jail basis, so that the normal reporting routines that we pass
through just work. Since this was never used, and never even in the
usage(), retire it to cut down on the clutter. It was literally just a
write-only variable.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/main.c | 3 ---
 bsd-user/qemu.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 709ab10ddc1..8c52fb43ff1 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -92,7 +92,6 @@ static const char *cpu_type;
 unsigned long reserved_va;
 
 const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
-const char *qemu_uname_release;
 
 unsigned long target_maxtsiz = TARGET_MAXTSIZ;   /* max text size */
 unsigned long target_dfldsiz = TARGET_DFLDSIZ;   /* initial data size limit */
@@ -390,8 +389,6 @@ int main(int argc, char **argv)
             interp_prefix = argv[optind++];
         } else if (!strcmp(r, "g")) {
             gdbstub = g_strdup(argv[optind++]);
-        } else if (!strcmp(r, "r")) {
-            qemu_uname_release = argv[optind++];
         } else if (!strcmp(r, "cpu")) {
             cpu_model = argv[optind++];
             if (is_help_option(cpu_model)) {
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index b97a902a4c2..ed6044cfdaf 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -122,7 +122,6 @@ struct TaskState {
 void init_task_state(TaskState *ts);
 void stop_all_tasks(void);
 extern const char *interp_prefix;
-extern const char *qemu_uname_release;
 
 /*
  * TARGET_ARG_MAX defines the number of bytes allocated for arguments
-- 
2.45.1


