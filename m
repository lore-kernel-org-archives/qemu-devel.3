Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C32C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPN8-0007Nv-4W; Tue, 05 Mar 2024 02:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPMM-0006Hw-5t
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:37:13 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPMJ-0005sM-Ku
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:37:09 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so4541848a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709624219; x=1710229019;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ahxRZ3SD7lLMx3muKeGeJx9aSeKYvKbViQJskOgE7S0=;
 b=Oa/PNbwF0SKj7KXehM949DEN8a4XMJX3C4a7bnrxEimthsivB4hr4B6txDVxfXq5ta
 eIukSgo4nrRAcKVM2EoaC/eaL/n6ILPsESf0+r5c9WhU/Fi+jKBHJ9ttPYTg2dkAu/1h
 /8PcVBRZE/TYzJh7h8Waos2BG3DiyhJo8Od+1YpfO+XMwqB9/QHuj5U0uPs/qdDl+qW1
 JktzpLsHGqlThMnSoSuh8FUfcjz4sDNr9lm78HpG76jrE4w6XNAiZzsjW3Lzb069fno0
 xSCHveD+zsGVOO5xpWyen90xpfYkrAw22JfLMM0rJ3BF2Nf2524I3vgaGQIN1aQYxHVO
 fGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709624219; x=1710229019;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahxRZ3SD7lLMx3muKeGeJx9aSeKYvKbViQJskOgE7S0=;
 b=IKhW9Jr5Gi/19GBuNGiGj+c+gjBZmTuvF4BSUG8+fcY3VqoCM7G3Ldj6XCwwaCYcoE
 2PcMpEa0s+pHY+z7W0ldGNfQL3iGDkchVWKApbwz3Tfm6T2AelMsmRPuHiUzOkknkmfG
 t50bg/5MuVLlqh7F+4U5fNqfZYHqcvbKDBvI5LWIydAXucN42/qsn/t40oBq0tZr0cKX
 6LvRakjXQnScPMSGEVg1JARwrRzUudMZlmS1iRNPPR5E6SCauSRG8J3iAB8dNTtZ6Yn8
 BTUfuSBy+wUoIRoJBTuL/RTOzQklRO0EyE9tEyMyQqg7hjWC53uqe8ZFnco0+iukC2xy
 hLvg==
X-Gm-Message-State: AOJu0Yx/kVp1CG2sgw9greX6QjLpdfDTr1CHIvPU8a5hRN9oODWV63Pb
 Rwmd5+WJnABrexR8viUvZbLNSont2/7o6SJFb1xRLe6BiX57i5xx8YUWdbYS+CRvmv05dEYCPWZ
 E
X-Google-Smtp-Source: AGHT+IHjk9iVqVIqU6EKZxcZdf3M9FaxuxcKrK/ZhPjapLKmcZ8yCjDFAwcMKRLQTQs7g0ili6EX1w==
X-Received: by 2002:a05:6a20:394f:b0:1a1:4e6b:185f with SMTP id
 r15-20020a056a20394f00b001a14e6b185fmr1246781pzg.25.1709624219253; 
 Mon, 04 Mar 2024 23:36:59 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 y6-20020a17090aca8600b0029a78f22bd2sm8124675pjt.33.2024.03.04.23.36.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:36:58 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 16:36:27 +0900
Subject: [PATCH v2 10/13] MAINTAINERS: Add Akihiko Odaki as a elf2dmp reviewer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-elf2dmp-v2-10-86ff2163ad32@daynix.com>
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52b.google.com
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65dfdc9677e4..d25403f3709b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3583,6 +3583,7 @@ F: util/iova-tree.c
 
 elf2dmp
 M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
+R: Akihiko Odaki <akihiko.odaki@daynix.com>
 S: Maintained
 F: contrib/elf2dmp/
 

-- 
2.44.0


