Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BD7CF884E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 15:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swkgf-0007Jt-47; Fri, 04 Oct 2024 11:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1swkgR-0007He-3p
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 11:57:35 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1swkgP-0000o1-Hd
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 11:57:34 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-207115e3056so21425815ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728057451; x=1728662251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmgSaVL8dhq5nP6b5OzdsZKAt0sQ4+L9Gnx6E+G/OOg=;
 b=RO6wR3ffKfrHU1k/reDiD1a7ilQiDieaQeDM5GYSWehFwsTAfzw9NUo3zXLgoHqO2d
 LmzKMJQHI8kOzLYkSy7qW4eNi+R86X6ZdvAHBG+yukRtX+yfgemzLX5Z9VTb5Mq2UD4f
 V3yb9hO2Y4MwHrXePpx+ZMU4/JayDgRIQ0JogqtqFHfgCJ5f8DbK/jGyoXuqoCretsxL
 81cECcVnI5JXDKouOyt0sT8W/0cNn1qc+8LMJUdvTj8tF6JtlsatU3GnfAz2AYvmcqkY
 XgJitjqieWbvP3xhPnX1k7UURv/YHxKtfiC6MNdlplcCZ3Qun5bNxLHxwkKgOMPj2/HD
 +FEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728057451; x=1728662251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmgSaVL8dhq5nP6b5OzdsZKAt0sQ4+L9Gnx6E+G/OOg=;
 b=U7FRbYvqy47pGKt1jIB29G82ibFu9Nh4W8HuTVwFkeKI6NnoTcbY2/Cqktl5UgJZTM
 8PFcYwQS8y90mZdew7p4o88wtwJWjRxMP0vLJkw7RuioZMZ94nNQnqdqfXr030+uk8GY
 EhaycLmmIlakkQelXq8YPNrWc+WRiSGpmyfV34e0mI8XvTo/UCfKk5MUjJlxoqOxUXOi
 4cFPF6Z78oXDfz2jAIEgY9LzUrsLvOc3H3qG0TC2cgdzTXm/z1r8vDqJeOkIIfJpyJed
 fhN0MSQCnDJGSNBHlEyVvrDx0wisXcxSdh32dkxt8AeLncctW1z5wvClnh5rST7jF6PX
 7Msw==
X-Gm-Message-State: AOJu0YzGccwsf7MQY0MbpvtcawzqKxSernAtG8/HYw/4uK7DCw1yDs5F
 FTIwJ+ubPjlJqebCal6Gy0VL5cQfD+/Di0RAqvy9clGjzZup+E6oud7f6JuiabK3Kln2zOsx/FF
 M
X-Google-Smtp-Source: AGHT+IFaXkupX/TkRTEwiaXNM9TOxRxtRJclKy8SR8UdDw8oKGmWDRg8hgOyHGMqiW9wiryYwFPEmg==
X-Received: by 2002:a17:903:187:b0:20b:54e8:8b35 with SMTP id
 d9443c01a7336-20bfe39ebf9mr43493705ad.33.1728057451444; 
 Fri, 04 Oct 2024 08:57:31 -0700 (PDT)
Received: from grind.. (200-206-229-93.dsl.telesp.net.br. [200.206.229.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c139306cfsm107635ad.170.2024.10.04.08.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 08:57:31 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Frank Chang <frank.chang@sifive.com>, Jason Chien <jason.chien@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 01/12] exec/memtxattr: add process identifier to the
 transaction attributes
Date: Fri,  4 Oct 2024 12:57:08 -0300
Message-ID: <20241004155721.2154626-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004155721.2154626-1-dbarboza@ventanamicro.com>
References: <20241004155721.2154626-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Extend memory transaction attributes with process identifier to allow
per-request address translation logic to use requester_id / process_id
to identify memory mapping (e.g. enabling IOMMU w/ PASID translations).

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 include/exec/memattrs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 14cdd8d582..e27c18f3dc 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -52,6 +52,11 @@ typedef struct MemTxAttrs {
     unsigned int memory:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
+
+    /*
+     * PID (PCI PASID) support: Limited to 8 bits process identifier.
+     */
+    unsigned int pid:8;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
-- 
2.45.2


