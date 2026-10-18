Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47E9CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIRam-0005lj-At; Sun, 18 Oct 2026 10:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xIRal-0005lS-0R
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 10:10:27 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xIRah-0004z5-TY
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 10:10:25 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-ccce6d9abfeso936858a12.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792332622; x=1792937422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K0UGJW5Rv06EbtkyisWOX7L9CvnlmTwxonH0Dbtr3Pk=;
 b=EW0pKmN1iaL3/j3Eqrii+++eAn6tojJr5XbM50n3njxnv3vef0U7difU4DMUtSARAR
 KV9TB9AUmCiH3ttFisxm1Umo6o+3OcLcWM0ectYVwPiivMhlvH7GLbWyVJf36NX7ZhwA
 iG6YI0ZOxkoIPMCgAtTrWYSrtDz39d5n+3KqQVtWxYa6C9Yg/qsnS9Ofkyl12mq83o9u
 HQRSWwK8R5lKi8L0FF7sbhnVaC1U/XkcDE1RlWSLuXwSttn0Rk5TCHpATHCisG9oGxC+
 1KuXMqasM+vZRqIcWVj9uhQ8WurkcgKaPGLNjgiIcD90//ybXMRBwnJjZtV6Fy76NKgJ
 98zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792332622; x=1792937422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K0UGJW5Rv06EbtkyisWOX7L9CvnlmTwxonH0Dbtr3Pk=;
 b=w3gOpRbPqzS6+c6nu5Flc6NuiIFGg2GCbtYerTAKWCEmdhCTU5P1Zn8so2dBdugIbU
 /7/OqWUryk8Xmsw1ZndaIW8JVAo2CJz0kAW1iytz/tLmqYvSgNZ+VH+65l4i4OhdX3I1
 dz0pnbZjaxXrVmmuqJHSLMJQ6zlTmmFRVUgg4hyWK9UMPmTlFLEPY2kIkjaAmOc95ute
 rCeUew4jlqcuDZ98eBKhWOomyCI948vq3G8mddWYyyFoOqcsrO5eMYFziLoSqBFWuQlm
 mSlLXhSIoxJQuP+I3Lezbaa0LOKJfrL9S7jxsvqdNbapziO6gBN0Yd66weasgP+9BCgM
 LTNw==
X-Gm-Message-State: AFq9FYJW/8VR1bHGL2gmdguftUIomvw3MGzTGzWe/HT2HUKduVKRyMb1
 4aZfZKvNdrJIEbHQ0gxYGPTpWsg8P1PEHYXqnpSjIwvRMpCVBoBXB81baQ5mov1O
X-Gm-Gg: AYBFou1lMn23c2oJRUf30cXEPKUPwMwYi6Jm3gMW3bdWBu04ZX6VvM8Hf2fbh7rtneW
 qEepl3j7qOUg6RgTzcPoBiCHHIeli0sPvKfPEO+rZ8h150i0eiXyysrwlqU0H1MyqqAb2ro4HrD
 Ns6QOlVt83g6DCefMjqZiWsgWSbg3MG+Uyo27zAzHCXhHTURq/B5dY/WH+ltgO1BcfCZ9zmpKw1
 WSMhcoeFocrpzO0Jdvs4c8N9G4dE/hktNDfgj13B3gR0JZpDRgtrIJjsCn2+wq/ceC77LmC0Tt8
 6dMfDdFEEdGD53W347JSnrtxBRmUCpVDf2qJZ1mCStFEkDXNUikZbF2DK8AtpQyLVtn59JHZS54
 egQZECcw9tJTYrlWr8Xzlb8obIl/R6iZYLhaY6gvuicoN0O3uH4ctya7wIIXOjjbYha8ZGsAnzN
 3chv9TolJDrYXeMQvNk5+rOI60OzMjS7N2U+ZZElb4Lr7zG+wdzhznhUhuEvh86MzOnlzXJAIEc
 VyGxMDGrUvNqD0usg==
X-Received: by 2002:a05:6a21:4683:b0:3dd:a196:53a7 with SMTP id
 adf61e73a8af0-3e22614121emr3900144637.73.1792332622184; 
 Sun, 18 Oct 2026 07:10:22 -0700 (PDT)
Received: from dt-VM.localdomain ([101.204.150.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f57653ea9sm2949430b3a.32.2026.10.18.07.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 07:10:21 -0700 (PDT)
From: Tao Ding <dingtaodtdt@gmail.com>
X-Google-Original-From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, Alistair.Francis@wdc.com,
 Tao Ding <dingtao0430@163.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 1/5] hw/misc: fix calculating output address overflow in
 k230_decomp_gzip
Date: Sun, 18 Oct 2026 22:10:02 +0800
Message-ID: <20261018141006.16398-2-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018141006.16398-1-dingtao0430@163.com>
References: <20261018141006.16398-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use hwaddr for address calculations to avoid 32-bit overflow.

Resolves: Coverity CID 1685515

Reported-by: Alistair Francis <Alistair.Francis@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/misc/k230_decomp_gzip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/k230_decomp_gzip.c b/hw/misc/k230_decomp_gzip.c
index 0d8a3b2d2e..ac06cc1571 100644
--- a/hw/misc/k230_decomp_gzip.c
+++ b/hw/misc/k230_decomp_gzip.c
@@ -53,7 +53,7 @@ static bool k230_decomp_gzip_write_mem(K230DecompGzipState *s, hwaddr addr,
 static hwaddr k230_decomp_gzip_output_addr(K230DecompGzipState *s)
 {
     return K230_DECOMP_GZIP_SRAM_OUT_BASE +
-           s->output.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
+           (hwaddr) s->output.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
            s->output.current_offset;
 }
 
-- 
2.43.0


