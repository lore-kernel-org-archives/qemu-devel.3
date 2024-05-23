Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71385C25B7A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 17:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sACRb-00019h-Sp; Thu, 23 May 2024 13:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sACQa-0000c0-RL
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:40:34 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sACQQ-0001Sw-08
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:40:30 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f32a3b9491so15489415ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716486011; x=1717090811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7l0hoTJ7iFjvbNzeKREC+Ij2HQdhAEwhnOBTbzD//A=;
 b=Jw5Q5NUhM6CSk/W2UDIiNiHgTOTQcsdjpZhIyoF2SpG179lOiOHCUOg8lIfX28FMpu
 MJqXdoFxXmMovVXbN7QPY5Ycci2zKLHaSDsq2MTP9gC9B8kyqxkchlw46fXlSyyE6qb9
 LWelQFpJ1ebASLDMc5hBikDWwXQJ/kQ7xEKjZ30P4tva6FZqc1Lg+bG+GPUdqMQM+mcQ
 VFxt34TPPbf0ag3xcUPMajy5/zZ9KoLaqHJXHgG8uNhUs2XAZMyc7zWgP3xMCZn5dCWZ
 FZReiYGylLmfSrX2891pG/AcyGE/5ii0DgVZUHPUEx05mtSg3Vwpq7hrc2oICVUax7k9
 cjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716486011; x=1717090811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z7l0hoTJ7iFjvbNzeKREC+Ij2HQdhAEwhnOBTbzD//A=;
 b=xKe0nldHzX4A8rMHBAbLA/tLHxdmA7rvQ7eEbBCATyTgJV3srG9RQUzoRd+e041N57
 AE5HMBMNbsuFHet8cC7Lxf7ieNoNjJwyOT7Teihihsp2g/6NRR5vHrl5K2Gz+gUDiE14
 W+x3qBwO6ekRsP6ya0s+FA+I5MyN6i/H6NZ+D4Od2oFyrJ7N9Awmv4vPYDVi+UWyl3zF
 wG1FnMTRFihs3J4hVskI6A9o1GisPPTreOxBKhkldYb716bdEnaxGoftZwA5PPEt/RYh
 kydQEqsAR3QPEM8OO9zT0u1WdUuEy9jKmWCSdOtTejfnfhXh5kob8i/mCda7RbqYu5qD
 O/7w==
X-Gm-Message-State: AOJu0YzCzccMNKMPQHDNt8InCHdPFiklXCxXLQIL6rLq56UIZp3kWMFt
 O2FreeEoVMLuZjIvKoeijZOXyVg2NiW9To+ZqjWPgT6XzrMn+VbEWamPZbrugEiDvS8/JERJME5
 2
X-Google-Smtp-Source: AGHT+IHwDCdkGx4u9n3TkQ0Mn8M9WQ6mIRZMjon5kyrtc2cIz8DO4nd3iok1Q3A8zNkiDQrZ0RQWrQ==
X-Received: by 2002:a17:902:ea0a:b0:1f2:fd9a:dbf3 with SMTP id
 d9443c01a7336-1f4486d1fa4mr27115ad.11.1716486011313; 
 Thu, 23 May 2024 10:40:11 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2fb4ca0ebsm81246535ad.119.2024.05.23.10.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:40:10 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 tjeznach@rivosinc.com, ajones@ventanamicro.com, frank.chang@sifive.com
Subject: [PATCH v3 01/13] exec/memtxattr: add process identifier to the
 transaction attributes
Date: Thu, 23 May 2024 14:39:42 -0300
Message-ID: <20240523173955.1940072-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
---
 include/exec/memattrs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 14cdd8d582..46d0725416 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -52,6 +52,11 @@ typedef struct MemTxAttrs {
     unsigned int memory:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
+
+    /*
+     * PCI PASID support: Limited to 8 bits process identifier.
+     */
+    unsigned int pasid:8;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
-- 
2.44.0


