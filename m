Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE0DCD129D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt83-000228-QA; Mon, 08 Apr 2024 13:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt82-00021i-Db
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:58 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt80-0003gI-Kw
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:57 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ecf3943040so3108979b3a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598595; x=1713203395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIaIEQSm9VCOv6FXtjW2b8GU4ZH5b2a473JIJYHIFaQ=;
 b=PoDgMi94+ir6aMg0BDnnv8r6Y3AvpzQocjyT2dVRhOyWxmnwjucjsFESWSwDMtrG5C
 5nNGP/H/L9HXBZPt/6xJ9sJ0S7RLFxZQzTC4sHHkCq58bj5Wat2gN8JBDjSq1G+0pDnK
 l/OKut9rkp+0lbol3k9rOWSMpQzA4Fe8BpHS6xBqKft1lmsq1aQm8zLkxfLIGo2KuCn6
 PtZSgbeduYW/oqXVZ2Y6kmX94lj2BzbnVttO1bE1wVelJVuZsSjzIKRNxLE6H8azDDXY
 kd2odTDWEDBlddtE/ijQIVETHtnzfBpiKyzQtnDEycU3n/tZX7RO8gJtvxUIfV6jxHT7
 nhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598595; x=1713203395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hIaIEQSm9VCOv6FXtjW2b8GU4ZH5b2a473JIJYHIFaQ=;
 b=V+yoMwIcjN/W1nnF0O/uA0X3u58du6Wq17kyfVYP4RabVc52LwJ9o+Y9cUqxJgz1YU
 +Wfo63gPlGAjWO9YNegpXWTIA4qDBHze3QfHIMidoEe9v3qRQLQ0MyqgxvvsXubFem1g
 LFUrA3JVQUrfQUjMm392w7DhkdYBqDD5avQTB8S3jNtxB78BXD9R7JYuKQ0McTDkJ4pT
 IQv0r9hw3t5Oz2gor1QcWYTxnK4+hytXz1c3e7kjgZsVo8bs6Y18SVKytl0zk8LKqSev
 wi6O82jUOvH/X6zn5b2krGNavYZzS6CRqo7CBvRmU4OW9huM1pnE3F9LkRRL6eD6Ab3M
 Z5ug==
X-Gm-Message-State: AOJu0YymZwiPCjcoVDjAJ6Pwek346u6IS9dqVFkz5ShaDfBJyhBPneJt
 imE1/gbjhtMSnwAOBJPzdJMNP/BMPDyQ+8RrYoElS3siMp68wfqnW3dZW9NpWJU1RM65MMjF7o1
 C
X-Google-Smtp-Source: AGHT+IHCUGskXtyKFxv47WbjHdePOITIscAICbnxwQNPgsQ25ExcBIEe9Cg2Pg1ge7p9W8FnX6pdYg==
X-Received: by 2002:a05:6300:8085:b0:1a7:3365:d8ed with SMTP id
 ap5-20020a056300808500b001a73365d8edmr8584269pzc.29.1712598595366; 
 Mon, 08 Apr 2024 10:49:55 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 16/35] target/m68k: Pass semihosting arg to exit
Date: Mon,  8 Apr 2024 07:49:10 -1000
Message-Id: <20240408174929.862917-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Keith Packard <keithp@keithp.com>

Instead of using d0 (the semihost function number), use d1 (the
provide exit status).

Signed-off-by: Keith Packard <keithp@keithp.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230802161914.395443-2-keithp@keithp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/m68k-semi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 546cff2246..6fbbd140f3 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -132,8 +132,8 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
     args = env->dregs[1];
     switch (nr) {
     case HOSTED_EXIT:
-        gdb_exit(env->dregs[0]);
-        exit(env->dregs[0]);
+        gdb_exit(env->dregs[1]);
+        exit(env->dregs[1]);
 
     case HOSTED_OPEN:
         GET_ARG(0);
-- 
2.34.1


