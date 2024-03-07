Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5A2C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAt9-00068V-HN; Thu, 07 Mar 2024 05:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsz-0005lS-0X
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:22:02 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsu-0007GH-3N
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:59 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dcad814986so5879215ad.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806915; x=1710411715;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vWeSXxnvukh1qTIQXUJcznaqlBnX6VJYT1GjqHDMtek=;
 b=PbGIfVCeCfzPdQgGreLjHsucCnWtlVZBBsVqRXg/HUBiF9n4O43UsyXL7Zjn3icMgG
 PlJ5lHGg4fnhwNtzIwW9lLaiVprIpOZbohIoBiVH8eXfogXVt+KsnTXr7eKyTd7LoIuh
 9rq+6YJZHojt2tEFerfvHuayVJFpqnYEsAtioSv+6akFN5I6Axf4x1LqB+FeylYulsxT
 M5aWWA+FZVw9O9zmP6V1R2OP4wNxphwVdriVP9jvyoyoSgTihuAbCCtIdQ2hPFkPKs2D
 u4GCP7MCjscQsnGHMTBvp5whr2RvAGdPHFOxouCLSR43aWxhJV9QbaHYGlD6DxM9M7lt
 SG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806915; x=1710411715;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vWeSXxnvukh1qTIQXUJcznaqlBnX6VJYT1GjqHDMtek=;
 b=i1FvLDIC+4ErBs2yn5zO9y3RZc5G9Mq5gLkpm5pdao/lfZKZxT4eLUSQJsD8JYFSWJ
 cTAhx3wo5JjCymFgqmnIKvmHIG+IWSL7FFcTtws/SVXTFmOpX078TwbNmbmBPHZrmJuA
 EAo3FZKyt46o516LFo7/1qzc2Fky3er+JWIRMSHfHCwo7AIQDs91j3V5dcbE/4owU1kS
 A/QqbVUaC6qeYiJrCXn6hsEWrBCgQ+9QJ3nWLSG+gSp8BqK6krWFTqeUI9lebEuQATQ7
 amw+N8SxfLMNgyDv5aHj64ZNGTNj7FtN3Mnw75Bol8gyNW9ez1xF9+ZQ/yjNX6b8VoSU
 ETbQ==
X-Gm-Message-State: AOJu0YyRAetHFO2cxSL02sjGIKInMnM4KLbyEnBOoYgCEBjBF7x/prrw
 YZDm9OkB6iwLG7csWCckU7V7T64RuFq5ri4dkkUnq9f5/v8mWJeFwMHT8nW3i6M=
X-Google-Smtp-Source: AGHT+IGcyD8Lye81gYG8MZAUVsbPTvmgN9XANVoQ+SxJafkoSETTxGYx7rySuiXeNOO/FyoNVPaU8g==
X-Received: by 2002:a17:902:f684:b0:1dc:b6bf:fae8 with SMTP id
 l4-20020a170902f68400b001dcb6bffae8mr10002174plg.59.1709806914784; 
 Thu, 07 Mar 2024 02:21:54 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 kz12-20020a170902f9cc00b001db8f7720e2sm14228261plb.288.2024.03.07.02.21.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:21:54 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Mar 2024 19:21:02 +0900
Subject: [PATCH v4 19/19] contrib/elf2dmp: Ensure phdrs fit in file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-elf2dmp-v4-19-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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

Callers of elf64_getphdr() and elf_getphdrnum() assume phdrs are
accessible.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2202
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/qemu_elf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index 8d750adf904a..c9bad6e82cf3 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -132,6 +132,7 @@ static void exit_states(QEMU_Elf *qe)
 static bool check_ehdr(QEMU_Elf *qe)
 {
     Elf64_Ehdr *ehdr = qe->map;
+    uint64_t phendoff;
 
     if (sizeof(Elf64_Ehdr) > qe->size) {
         eprintf("Invalid input dump file size\n");
@@ -173,6 +174,13 @@ static bool check_ehdr(QEMU_Elf *qe)
         return false;
     }
 
+    if (umul64_overflow(ehdr->e_phnum, sizeof(Elf64_Phdr), &phendoff) ||
+        uadd64_overflow(phendoff, ehdr->e_phoff, &phendoff) ||
+        phendoff > qe->size) {
+        eprintf("phdrs do not fit in file\n");
+        return false;
+    }
+
     return true;
 }
 

-- 
2.44.0


