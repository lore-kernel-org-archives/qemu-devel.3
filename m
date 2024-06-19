Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE5CC2BB85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 05:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJnR4-00088d-FJ; Wed, 19 Jun 2024 01:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osandov@osandov.com>)
 id 1sJnQx-00086P-0p
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 01:00:36 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osandov@osandov.com>)
 id 1sJnQu-0002Ci-Sf
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 01:00:34 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5bfa5f9bbe6so1747433eaf.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 22:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1718773229; x=1719378029;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxOU2UBK31A2MsvvrU8KfdPolr+I7zX14JcLUR83OuY=;
 b=Kcailptvuz9013OyL/yyBltry2NtRtUxPj/AYkfzMMYsLRx/UY1CrsMl0RvMPfDToX
 BAp866SuY+x58k9JlsqgAL8XWWURgv0yOMDA1r2Vu63u7b8ILe+8LY+Zk7E7pkVPnd54
 iGAqfTJpbaHw+ooooFbcoKGOrlaZ7ok+dQEJCHt0UFJ2XCng/yE5dtGDy2jBkDwY7FRR
 uyRVRMCfiOC7hAJCzdqYwY0a6f3NEYjritc00xtRxyRNITrLCKE4XP1M1YpNOaPNeSo+
 SXDb/b7ygf9lhnUVOHggbpvawljbiUQuPYGY1uX1ghAIM0PYqx+tzoTWDPkLWXCP8DW4
 tyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718773229; x=1719378029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxOU2UBK31A2MsvvrU8KfdPolr+I7zX14JcLUR83OuY=;
 b=X+Dl+X7YFyBM6E6WU2mT2s5M5kkgL/6VQTqlIykee3p4qcgEIXyuSVbLd7jUi7zrqb
 9B9BPgZdsoiVKJ37mPK7ClVSxj04zeUQ2KcATR9RTb2DoZxHTnClkp6bH9rKf7XbgS0j
 2IHsjbVNma65tl78cy8e2rfQ4GUKGU149Xs/nPS4yNbyffLXeezSB5FKJiBgodfxPtO4
 Qxzp/EerXcpBfeQ0VfjgkJZTdLq+XZTdW00YURbdvm0w65FHkwWL77XwAF9vZEZHt1QD
 CNH8YCpTbM3JBawKFOGuCnpt4cXXTfkGVm136m2XGJRHxLFN+bmksfByNENGzi/eESAZ
 pb3A==
X-Gm-Message-State: AOJu0YzecMyHe3YaYu3ZQb22FTNMGUDMdcXJAinfwrtyDXle77zof/go
 ByrG0xrWPdRPPOdyGCKS7YMqjuplcgUU9Rf3KDHaqknWIyJcDhuvCFZLsOlYCI1i4NkvdF6pvjh
 MKjw=
X-Google-Smtp-Source: AGHT+IFnRK+olC27LLdSl+gitic7LAbd0SqQcny58N5Rx0UD++iUFr60Z1/P8h7FqL77+abhYXrbkg==
X-Received: by 2002:a05:6358:5207:b0:1a2:46b:9278 with SMTP id
 e5c5f4694b2df-1a2046b95e6mr48914055d.19.1718773228755; 
 Tue, 18 Jun 2024 22:00:28 -0700 (PDT)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::2f17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6fedcf36be7sm7457523a12.1.2024.06.18.22.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 22:00:28 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 linux-debuggers@vger.kernel.org
Subject: [PATCH 1/2] target/s390x/arch_dump: use correct byte order for pid
Date: Tue, 18 Jun 2024 22:00:12 -0700
Message-ID: <5929f76d536d355afd04af51bf293695a1065118.1718771802.git.osandov@osandov.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718771802.git.osandov@osandov.com>
References: <cover.1718771802.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=osandov@osandov.com; helo=mail-oo1-xc2b.google.com
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

The pid field of prstatus needs to be big endian like all of the other
fields.

Fixes: f738f296eaae ("s390x/arch_dump: pass cpuid into notes sections")
Signed-off-by: Omar Sandoval <osandov@osandov.com>
---
 target/s390x/arch_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 7e8a1b4fc0..029d91d93a 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -102,7 +102,7 @@ static void s390x_write_elf64_prstatus(Note *note, S390CPU *cpu, int id)
         regs->acrs[i] = cpu_to_be32(cpu->env.aregs[i]);
         regs->gprs[i] = cpu_to_be64(cpu->env.regs[i]);
     }
-    note->contents.prstatus.pid = id;
+    note->contents.prstatus.pid = cpu_to_be32(id);
 }
 
 static void s390x_write_elf64_fpregset(Note *note, S390CPU *cpu, int id)
-- 
2.45.2


