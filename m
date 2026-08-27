Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887FEC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSOK-00038i-2j; Thu, 27 Aug 2026 01:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSOI-00037M-JV
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:11:06 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSOF-0004A6-UU
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:11:06 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2d530328efbso3210845ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787807462; x=1788412262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0rPIO/eJ4fCcyXhjl8aHWuRIEQEoWUmTA8VQtKKUv40=;
 b=n2Lyj2rZXnhOCRDT/rYsGgsRP8Vg2zFrx1UkAtmTGvMONU8fxYTbW5LvUgU0DEPZgp
 yd1NGM3adHzHfWaeDntlMnsNrNmTQwVxcbDy4VwBVirpxS15ZKwSX93AG5kicp1XHY4L
 3JXqFwuV7ooohhOTY8BiA/RSsZZNOU7BNd9kXqUalUnSmyCc7d0odRsNxnnvJHtxtHT4
 UePvb/9LZjr9/Skn9HbZjMQd35/sPkdsPuq82i+6pLXI472kfj+X0QHxg1Yn6j4nylcd
 IxPusnRwcPhT3Z1dkd+4aueNZ028gD4alJBXAm1nfZ0/Q9pxAioVjE/WTNdDXg58uOSO
 abJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787807462; x=1788412262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0rPIO/eJ4fCcyXhjl8aHWuRIEQEoWUmTA8VQtKKUv40=;
 b=TfQAjnpQC8XQebLCyn/R1ywoDYubCZ+XNZJ/sGPuG1/vvUHiXFopX9uv5phx4eihxd
 VLU3D0sg71m3S2t9t6oiX266lQxIEn8DLlEceEwMzxo7ykb8ec0Sc91EKUSM3mMcukqy
 E+2uGoNvc8SoMeaCWtUdvVG+/enZii7LvZqDfZhjzTvquGZmUmd0FBPy6yCyPpt+iHLx
 nDOmwmNqEgnOXJwScw79xkHsBWg8CHidVuflyoOA157P8Aj8MjFBttb+d3RKb5+MZGwN
 WcWoAjr4ooxrxJZ/Y/iySfU59b6t0gwMFb/q5dYaF/IB0OYw3VmjOfRIoXXRuIfKMnVg
 /wSA==
X-Forwarded-Encrypted: i=1;
 AHgh+RouBN0vdBpsrExsjKTySr3tTDYlQshsvmlpD/0My4dZKsLy3C7WpCtf0F/7CsHKOS7BoUj+D0L/SoZ0@nongnu.org
X-Gm-Message-State: AFuF++kLiYB3RO6ngq7JUx3Yv1GRs6b8JNjBLl41jymO3RiU5HMghfNY
 fZVt5ltY66CHqwUGR7ROtbB5JicgOHy1kO3JoX92JCv4mMasqOv0ojwB
X-Gm-Gg: AR+sD112B9LYC8K+n8h1Oc6w8dubnV5d2oplKmzajv6ji97cGS8qLU2sHoiQ3hR5yxC
 BmDitJw6oEvujAieuytciwU2vE5UGPImzd6znrZCEjl2Ee2t/foumdQDLv+vEMIV/9uRkOY0kp1
 aOXHSmIFxee/UP/hVT2/PlHkn9/VbeAZqIjJwfofxb6z5kaGZ3zud79kBeTQ1x58EKi3PphpyDG
 jGe+hEtvB7q/XzQZDwfUFM/G4Hwy1N7jpBv+IrGl3zxvkvifWAUcNmRFRNoFHM3uM9Wt/azqRN2
 FOYBp1agCCywxdgJe8Pj4NGR/ZpF8CjtRY33GVRg3HUtP/kAm/jPGDOELNJxdOylHn6Xhn2Uq12
 f2bSmCUmKlCjC/FA8fl/e2MlEhu/muZcda+RAJE8CkXh4eQktn2t6zk3OYoz4E4VK99poHh5VwP
 49BPtCV2zdbzmaSj1+2I/Go335fIcaYRxEZ3ppx7v93UJTljJg3YbmS6Igd1UYknsD3ST3RdfXl
 SycMaqrlgoc22rSHPaViGjT6eUUwh5oJkeh7cXBZ36oYqhCwHYiRzNpN25Ec4Lg6Yk5CQoRmSGr
 wxG0nDTd3noLDNfoUywO
X-Received: by 2002:a17:90b:3cc3:b0:393:194d:5366 with SMTP id
 98e67ed59e1d1-3966d85de70mr26456394a91.10.1787807462371; 
 Wed, 26 Aug 2026 22:11:02 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39670599275sm2210473a91.0.2026.08.26.22.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 22:11:01 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 08/12] tests/tcg/aarch64: Don't leak memory-sve CFLAGS
Date: Thu, 27 Aug 2026 14:39:47 +0930
Message-ID: <20260827050953.67184-9-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827050953.67184-1-joel@jms.id.au>
References: <20260827050953.67184-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The CFLAGS are added to prerequisites, so if memory-sve causes a build
of printf.o and boot.o, they will be compiled with -march=armv8.1-a+sve
-O3, and the executables that link printf.o and boot.o after that will
also get SVE instructions.

https://www.gnu.org/software/make/manual/html_node/Suppressing-Inheritance.html

By marking the rule 'private' printf.o and boot.o won't be built with
SVE, which avoids SVE for other binaries, and is okay for the memory-sve
case.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 3f30be6c5d63..196a2afa50ee 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -51,7 +51,7 @@ memory: CFLAGS+=-DCHECK_UNALIGNED=1
 memory-sve: memory.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
 
-memory-sve: CFLAGS+=-DCHECK_UNALIGNED=1 -march=armv8.1-a+sve -O3
+memory-sve: private CFLAGS+=-DCHECK_UNALIGNED=1 -march=armv8.1-a+sve -O3
 
 gpc-test: gpc-test.c $(LINK_SCRIPT) vector_log_boot.o $(MINILIB_OBJS)
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) vector_log_boot.o
-- 
2.47.3


