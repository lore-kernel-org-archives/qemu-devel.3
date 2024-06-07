Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFF3C3DA40
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 04:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFRB0-0004lq-7W; Fri, 07 Jun 2024 00:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sFRAt-0004jy-8D
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 00:25:59 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sFRAr-000501-DM
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 00:25:58 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3737b70a74aso8932365ab.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 21:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1717734356; x=1718339156;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2zQ1H8W44cIwmlfiKccsXCEnWSMDCd/sRf7MeOiKVM=;
 b=YO+52K5OJCTM6/7CF0EKys/rGGuBFNfAWuxKpj1w1KJR9QAHD0TWbEcx6hP59o4Hwi
 DxaN0YkZ0a4KgrsHLxB0x+1BMrf62hbo2ECeq0YO5/LNDAey9pgBO6smk20wCa4x/4YL
 w8AbLkhYpaFleg6wIpxa8kBe7FiLoILVXBwawcmhYRrM0bj6uQsLS2mC8EsxD3qd9Hdf
 nCBAQ83CF0ZXA3hOSlBi3U6WsQtRD/JdltgX2Q6RQ+kf/SRnMPmgD6Z7+xeggJ0RTckp
 R3VeQfNbEb2hhL6W6WLRKpVbKaPLTLZ3G+Hy2BE6Otoy7YaIkZ5MAx1ceFkUeLCalS2M
 m9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717734356; x=1718339156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e2zQ1H8W44cIwmlfiKccsXCEnWSMDCd/sRf7MeOiKVM=;
 b=Ke+9tPU9CZrIF5QloTtiCheXAFJDofKxwKpjoPA59k8wR8t7q8T74n7nZ25Ikjuh8U
 LcvcruHL8A1tlezAEKS6Inj4cz86h9w1hqAH2O6LivPDnf70z/ExKWJBw5XBoutGf2X4
 4NCO1S4Al+XtqSCrDuL909HjRYYnAypNylchlsLR7X5OoqGPx27qXKhVaXx4vJnsJNSS
 SJV7lpRZ/UM5PHnEdqIeXzsfA36d7jxqdDnjkxvWR+9SW5T0QNLJMRK3ownfdEh6ml+X
 8KyRbwNgKSRCwOpgqJxhwdiwa+aMjvm+q3KHsy10u7B5WcfdDsy2rQVQljrGkIIpOKDe
 mcjA==
X-Gm-Message-State: AOJu0YwAA/AH1Rfo5hKA67XLl4G6xFRTUROJoq2r6qvnmMfeeVdT7qqa
 Wm3/PiKkZdGcTXvoYoRMBjGnwIEZ/Vqpuc7mW3j5BaliiqHhQ8pa8SwA++iIt32ak0ijGDHI9VF
 YBYw=
X-Google-Smtp-Source: AGHT+IHth/zYOqbGg3Tp+Fv4sTisBfezBBQP0AOVkg/478ALyZIfaXqIXdQCFSangBLhrOtw5YYDLw==
X-Received: by 2002:a05:6e02:1a83:b0:36c:2975:a7f5 with SMTP id
 e9e14a558f8ab-374b97ca9f0mr25415025ab.9.1717734355706; 
 Thu, 06 Jun 2024 21:25:55 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374bc15d9d9sm6162585ab.37.2024.06.06.21.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 21:25:54 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH 1/3] linux-user: Adjust comment to reflect the code.
Date: Thu,  6 Jun 2024 22:25:01 -0600
Message-ID: <20240607042503.25222-2-imp@bsdimp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240607042503.25222-1-imp@bsdimp.com>
References: <20240607042503.25222-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::131;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x131.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If the user didn't specify a reserved_va, there's an else for 64-bit
host 32-bit (or fewer) target to reserve 32-bits of address
space. Update the comments to reflect this, and rejustify comment
to 80 columns.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 linux-user/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 94e4c47f052..94c99a1366f 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -814,10 +814,10 @@ int main(int argc, char **argv, char **envp)
     thread_cpu = cpu;
 
     /*
-     * Reserving too much vm space via mmap can run into problems
-     * with rlimits, oom due to page table creation, etc.  We will
-     * still try it, if directed by the command-line option, but
-     * not by default.
+     * Reserving too much vm space via mmap can run into problems with rlimits,
+     * oom due to page table creation, etc.  We will still try it, if directed
+     * by the command-line option, but not by default. Unless we're running a
+     * target address space of 32 or fewer bits on a host with 64 bits.
      */
     max_reserved_va = MAX_RESERVED_VA(cpu);
     if (reserved_va != 0) {
-- 
2.43.0


