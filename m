Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033E4C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPri-0000Hf-Rc; Mon, 12 May 2025 05:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPrW-00082t-Rg
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPrU-0000kP-Jf
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5XJUJRnrTiscZ1lpipSP6/oXqKd/h2Mos+s1lv9QW+I=;
 b=M0FdAfxmlnpxzz38ITjCZWHc2tdo+/N4+opQHxk3k/zmjyiLFOc1QYsn5utfKetJS+Pg2p
 bZHoedzicjww3gkJRlFc8GXDA2FZyILpydYp0hNXc57bkw4xmrpQUIn4OIk+Pr2paCHToB
 85+JNJ9Gu/raUITJL0WiYsjQ+9AOWjg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-aZ7zCe2KNaOXo4j-_zD9kg-1; Mon, 12 May 2025 05:54:13 -0400
X-MC-Unique: aZ7zCe2KNaOXo4j-_zD9kg-1
X-Mimecast-MFC-AGG-ID: aZ7zCe2KNaOXo4j-_zD9kg_1747043652
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-acb98b5b0bdso441475866b.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043651; x=1747648451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XJUJRnrTiscZ1lpipSP6/oXqKd/h2Mos+s1lv9QW+I=;
 b=sRNA2NCz6jPiqMgZJSZ1YI/9cgrXd9xApUqh50Ssotze4wiSe5AHNHYuWBhjVkQ247
 1UfvN/kzsOs5ZT9Xcv/KEX3jElqaMloCqzmQua5qbKZzn13dz29Eo2iJv81uTcLDiMFI
 YvgoE2xxgC1X8Jdf4Mp/uDj3Il2Iuln42Vd+YSI1ZsDmd/cA3w46dXqrLvrrpGdGeCxO
 c1+GoVLhE2ubnLEj14fi4DNDWXywn5B4wKx4HqcW43HuSHR7+uYgNFnkW3cuG/NlaPbB
 d32GznaKfVOKocBOuFkuQQN4edlzqziPDQNu7bL9wpVZqTAHHblf991eh2PtYSZ7v2Pt
 YQtA==
X-Gm-Message-State: AOJu0YzgGcrsS8oG2Dlb8hNM8gT1xfyNATHjFiKUJPQaoKw0vFSwjBiO
 sLwiKzS2hA4t6UmEBqTLM+h5vzz0AbRU9Oc1hFltXLMgkj/0K5t1bAiATxnEhc7W101NcKorUUp
 ReG3+BJcyDbMcFsySXu4GOqPv1Zax0YZO31fpp7jVt7fg9g4i4slvWUMYgRoAmjHGm/bJfjQe8m
 eML5Aq/hQ0RHK2sI1AIE5FlE+qYoByKIbhlwtH
X-Gm-Gg: ASbGnctYqnrrMfEmhJziVwUzSukCmgeLtkQopvkDz44mJBhT3biafJn4/XJ64MaMFCd
 MYnMLtptxpUpUdFuRprqc994K8xO41P13AHOGKtT6rnGhgnL/oNXoiXGlI2NXm1/ieug95pa6FY
 pmrszitJMyI3W7DmllOgHWCtH5kkU9DWuNWoaJaK3nkjO05O64xUv5cCfmRWwKl9UrsTQEfsZds
 ZFAjue8nlhr7jQs2C25dAFbUYZQp1u7ChvyYy+vM2HJwzNtUnwc7EH5kU9RquvSGrlh8k/Mya2s
 9i/eW8GzRzFOJxeBucP42M1nGvm8eEFZtwV3JPoKcVB/nMs=
X-Received: by 2002:a17:907:948f:b0:ad2:4ac1:abe3 with SMTP id
 a640c23a62f3a-ad24ac1b354mr485991266b.40.1747043651563; 
 Mon, 12 May 2025 02:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdC245fZAFpmHPHYbfAQso5gidLEms+OJIVR320hyx46oAT3IlF3m+W0+F7EoDJihuRJkoGQ==
X-Received: by 2002:a17:907:948f:b0:ad2:4ac1:abe3 with SMTP id
 a640c23a62f3a-ad24ac1b354mr485988766b.40.1747043651157; 
 Mon, 12 May 2025 02:54:11 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2197bd398sm590349066b.152.2025.05.12.02.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:54:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 19/26] target/riscv: th: make CSR insertion test a bit more
 intuitive
Date: Mon, 12 May 2025 11:52:19 +0200
Message-ID: <20250512095226.93621-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation for generalizing the custom CSR functionality,
make the test return bool instead of int.  Make the insertion_test
optional, too.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/th_csr.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index 6c970d4e813..969a9fe3c80 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -29,7 +29,7 @@
 
 typedef struct {
     int csrno;
-    int (*insertion_test)(RISCVCPU *cpu);
+    bool (*insertion_test)(RISCVCPU *cpu);
     riscv_csr_operations csr_ops;
 } riscv_csr;
 
@@ -42,13 +42,9 @@ static RISCVException smode(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
-static int test_thead_mvendorid(RISCVCPU *cpu)
+static bool test_thead_mvendorid(RISCVCPU *cpu)
 {
-    if (cpu->cfg.mvendorid != THEAD_VENDOR_ID) {
-        return -1;
-    }
-
-    return 0;
+    return cpu->cfg.mvendorid == THEAD_VENDOR_ID;
 }
 
 static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
@@ -66,13 +62,12 @@ static riscv_csr th_csr_list[] = {
         .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
     }
 };
-
 void th_register_custom_csrs(RISCVCPU *cpu)
 {
     for (size_t i = 0; i < ARRAY_SIZE(th_csr_list); i++) {
         int csrno = th_csr_list[i].csrno;
         riscv_csr_operations *csr_ops = &th_csr_list[i].csr_ops;
-        if (!th_csr_list[i].insertion_test(cpu)) {
+        if (!th_csr_list[i].insertion_test || th_csr_list[i].insertion_test(cpu)) {
             riscv_set_csr_ops(csrno, csr_ops);
         }
     }
-- 
2.49.0


