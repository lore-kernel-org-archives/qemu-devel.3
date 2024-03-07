Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B52AC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 16:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riGDZ-00055k-Q7; Thu, 07 Mar 2024 11:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riGDV-00054B-OY
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:03:35 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riGDT-00065A-Mw
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:03:33 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dd2c8f1204so7624275ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 08:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709827408; x=1710432208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2zdcROsQbOFiJxi4YFtPRy8krLPDKRLFmYJHbhltrk=;
 b=SjCc9f9F1+pm6HfPJDf05vYkYpw5o7OK84U6spGz0JyUTPWX2jH2FruCBQLv/TKGLA
 wFuvt/t03mSfrsQeGnbP0bUQoGFBf6AWf1WeA3JVmX60QVkX+1SdEezj4GQ+2zIPyZh3
 tzVvwSbf23ESTzeEM7K6E3WueMQtwyJD97cRxj4WyJ1pCgvTr8zFz9YD84GrZ/zaYa5A
 vmNAc+iK1QTmHX34LWXflGl1jrULrXgrWBnX5dI1sTB5ZUTYCS5pJ2mT3kqhcr7yFvk7
 b8sTqQF8ZgGRaLPPNp7doIcs+/UoxA4+OIVHdK0Jx+/cOg8quGO75CEyBOHuP3vXLLls
 c64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709827408; x=1710432208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2zdcROsQbOFiJxi4YFtPRy8krLPDKRLFmYJHbhltrk=;
 b=EZsDIvkuO17YkfRynxMGCtPqa07TmBS46HBdFnHyAqia01Xc/MBAI/izUXB6UpsVu1
 6twL7La11itUHCPBnEihVnTZv+sao20U3LltxNxaNPct8rWOkQq3hW1t2PoLiV6hON3W
 3XBA+FMhq40OAF85zTBVU0S8HrUidDCCG7XWljor/fAa/emQfzZatEjCLuqi/1l3lE1o
 O/i6tFTuN1Vw48Y2pjggXQOU6jB9fZAACH3UIq0E0M82kAFKuJAAtzWFHnne+XnA9JTI
 gZiffZ3fdZWa3csQwaV51dpEFaCQxqBqvsdHwgKG0M3qvfD/AMhdU2zVWrNudjqpgc03
 txAg==
X-Gm-Message-State: AOJu0YwVgOsyBt303viofPWfnQCP9p6qQD9MUceCR7RGS8v4315DnWKa
 EXbW4rgnAkANcal4Q3TR0hlt1Iv17Rg2CAM8M5btxcyo5OtVaIVNsbnCVciHs10iZLGHdLdh7mf
 +
X-Google-Smtp-Source: AGHT+IGOruu9QRefE1sWJ0Ke5tPBrLgdf6nv0d4Lcde4VeqKQ4XkxLEaAFYR+PXxHLbV8KzSc/Asxg==
X-Received: by 2002:a17:902:f552:b0:1dd:6092:743f with SMTP id
 h18-20020a170902f55200b001dd6092743fmr1261025plf.56.1709827408388; 
 Thu, 07 Mar 2024 08:03:28 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a170903124b00b001db2b8b2da7sm14663136plh.122.2024.03.07.08.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 08:03:28 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com
Subject: [PATCH v2 01/15] exec/memtxattr: add process identifier to the
 transaction attributes
Date: Thu,  7 Mar 2024 13:03:04 -0300
Message-ID: <20240307160319.675044-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307160319.675044-1-dbarboza@ventanamicro.com>
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
2.43.2


