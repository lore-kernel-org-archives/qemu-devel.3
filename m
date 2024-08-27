Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CECC5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 15:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siyRk-0003Ri-AQ; Tue, 27 Aug 2024 11:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1siyRj-0003Pb-3Y
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:49:27 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1siyRh-0004mo-09
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:49:26 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7cd9e4f550dso1780663a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724773763; x=1725378563;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NGFZZzfnU9aEDN0fiH1YTSYbYKUYKCcBm7Y4zenqIsg=;
 b=pFbdGlpFZKZeW27qJxbmasOhQ+CA31AxV1MWIGyJHPyLt0awnZ002g9ounnUIUMKKV
 HLj5NdTed0naZ0Ba3DEUgpJCuh0fQvM4tSCZ6qVi2E0k64ZWT2CzyER5LbcoNYiJhXwK
 NmTJE+YsUSqd/LLMjXFnOHG+KgedR9Z33/mEWfgiqx8SFKzeMy4Z9HNRkEg+GpjWylkK
 dKDIa0eFOqrSXAhSNGk9aYUw8UQ1Y6gH5DcUO5+zFJwBQDzzP8ioEX0PmU8yCU1fzZi+
 OeRXjxiLeKeqRHaAhglcQWQbcGlKm/ZKMQabejtLlfwwEt6XqT7BdwHZh4/RNLmyYs+g
 QMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724773763; x=1725378563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGFZZzfnU9aEDN0fiH1YTSYbYKUYKCcBm7Y4zenqIsg=;
 b=h92+F/2h07deTLNw3CkVfT0/zIr478l0sUxRSjuezVI4Oz8LxVOw2VJq31MWj7+94A
 +EJdkrbx3VlCFqEXMTS8JKbKUcWVV2k3ngiRe1SyjcQTScC7TEYDKFzmVZJPuGHP5XKC
 QAjoZoBf27XvTfQHRPUPIqk7yzKfRW7RPKsP498A1PmlLrNOeSrdW/zHvX6agwXsNFWF
 z/aBCMbKDCCawwBafiJdqoFCg0uvKbSRqPo1ECFVgCZ+lff4rcWgf9vHDT8tlOrE4INM
 ADx0AA25R9vOWPcRhb6mJxkMqpzt2WwYh466N4UhIRxXVhEFsjsnTZvFvPZhA7yhvG/R
 Kb2w==
X-Gm-Message-State: AOJu0YyW1dQZVFj8x3uKSELaUtt3/YqlxN4sNQ1JwyN21oJQ8o6jaAod
 2IYX+k6IPT3pcr/7rXKNDuMqbMjVpr+zXAK6ODTc6EwXJy9tIZlnyeHJ8ijL7yBrLpnPPeKx/tR
 /73w=
X-Google-Smtp-Source: AGHT+IEUG8DcTDFZ+mJtyk36vbFQTW0DHxJ+giwo7IUxQTERl5axUdHT0YvxN2L4uPWZa6vellb1kA==
X-Received: by 2002:a17:90a:98b:b0:2c9:888a:7a7b with SMTP id
 98e67ed59e1d1-2d646c197eamr13142368a91.25.1724773763211; 
 Tue, 27 Aug 2024 08:49:23 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d5eb9037a2sm14624478a91.13.2024.08.27.08.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 08:49:22 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org,
	jag.raman@oracle.com
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, john.levon@nutanix.com,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v12 3/3] vfio-user: Fix memory region reference accounting
Date: Tue, 27 Aug 2024 08:49:01 -0700
Message-Id: <20240827154902.607926-4-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827154902.607926-1-mnissler@rivosinc.com>
References: <20240827154902.607926-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=mnissler@rivosinc.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The memory regions created for DMA regions where leaking the original
reference the object is initialized with. This happened since we insert
the memory region as a subregion, but don't keep the reference obtained
when creating the object. Thus, drop the reference after inserting the
DMA memory region into the address space.

This fixes auto-shutdown behavior: Due to the leaked references, the
memory regions would never be released, and indirectly keep the VFU
object as their owner alive. Thus, vfu_object_finalize didn't get
invoked, and qemu wouldn't terminate. With this fix, this is now working
as originally intended.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 hw/remote/vfio-user-obj.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 0e93d7a7b4..d347a96e39 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -394,6 +394,14 @@ static void dma_register(vfu_ctx_t *vfu_ctx, vfu_dma_info_t *info)
 
     memory_region_add_subregion(dma_as->root, (hwaddr)iov->iov_base, subregion);
 
+    /*
+     * Insertion into the address space grabbed a reference to keep the memory
+     * region alive. However, the memory region object was created with an
+     * original reference count of 1, so we must unref since we don't keep that
+     * reference.
+     */
+    memory_region_unref(subregion);
+
     trace_vfu_dma_register((uint64_t)iov->iov_base, iov->iov_len);
 }
 
-- 
2.34.1


