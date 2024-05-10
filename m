Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E44C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 13:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Q8N-0005ss-UB; Fri, 10 May 2024 09:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s5K8c-0001kS-MG
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:53:50 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s5K8b-0004s1-2O
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:53:50 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-61bbb208ea5so1371395a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 23:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715324027; x=1715928827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yu8hvEmMVZKvLb7jw48LlBWGJrT9gAdbX9dylAP6AFY=;
 b=PpDd9I0FIjzje4R7Tok1GspNqyQ+wb0PJjourFYAvb3NnTpbFQhQEu4UGk+5T1rHix
 H3nbOEaMuya6iq4ZI8mHibuV36+ofqNm3dgdIeH6+v1BrI+nxTPKsTKiWbtGu/uJEnDE
 r84y489ic1/Ouwi7IBBmIrH9/1Ua2gF7Ooas9xAXeiGGR453r1oJps//1d70JyBBH3YV
 IFwXUyhG4XZbP/idmqjtiRhsvJOWeiSFLjjLTtXZxOP2B+UVIg7Vj8GOlNDwgDd73cXx
 pvTKiJGwXW/QdUGBfo5Lkr8Ge/7UrigO9GQOJqA0N528omLP3BMInloyIun0GmQ+6+4k
 jZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715324027; x=1715928827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yu8hvEmMVZKvLb7jw48LlBWGJrT9gAdbX9dylAP6AFY=;
 b=FrgNo60wNtKFVPw1KVEZLIG3KguzKPv6c8Ta7kfatIN4Vv+uQP1fFoA8m4TGtGYOoZ
 jhdX3bYIsAxVA4ncS1mJonQXpvsngaJILtPjifjlBWxpzrHnxZv3cAiDGB7sVCGRUA69
 nvBrTgd8hi6wM7Z//D3xv8HIDIkyBx+Tqg89SqRqLVtFLzRgotHjduWdVBpRv7rR9YAZ
 3uBtooP1jMpUUX246HD3bPm1py/axEEMXxyDUOhahGzAy/xQloJvR/ggkscxbPodRXUR
 ZFwierrYIMSMI2TTZ75At7RnDwGcjH6l+8xf10ull6GhOBwzA8yomnrAs1au1geGcsP1
 d4Eg==
X-Gm-Message-State: AOJu0YwVpaT2m89aU/8PzwDHraN/8M4vQCFOU8nZCqK7MBVFtWNz80Mn
 WdJTIauMPR69cFPOg3LRnqc726ivgEuLkDsnqIdwx2bJ/SKHDc5MzRgAKsRvxOGfwosJNfMQT6g
 9Az/H6fAudppyAiYoYMkdhVCxUiB2SpuFfa0VEg4VFp4R7kra3rXzMp+LAaka7gg2pMN72dHnxT
 hUWn3zBoHLJo+yZOVaGLwNRgTftbMKsZ7Zc7oC7A==
X-Google-Smtp-Source: AGHT+IHksYpxv8qPTXANxmC+6wogUEdNVPXf5rqfL896HpeuiV+WqRaXvrDW1t3r7R+MUvEcUE0m7A==
X-Received: by 2002:a05:6a20:96d2:b0:1af:d810:9d0e with SMTP id
 adf61e73a8af0-1afde1c57dfmr1838159637.49.1715324026803; 
 Thu, 09 May 2024 23:53:46 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bf31a7asm25579175ad.140.2024.05.09.23.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 23:53:46 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 5/5] target/riscv: Reserve exception codes for sw-check and
 hw-err
Date: Fri, 10 May 2024 14:58:55 +0800
Message-Id: <20240510065856.2436870-6-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510065856.2436870-1-fea.wang@sifive.com>
References: <20240510065856.2436870-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 May 2024 09:17:57 -0400
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

Based on the priv-1.13.0, add the exception codes for Software-check and
Hardware-error.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu_bits.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index f888025c59..f037f727d9 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -673,6 +673,8 @@ typedef enum RISCVException {
     RISCV_EXCP_INST_PAGE_FAULT = 0xc, /* since: priv-1.10.0 */
     RISCV_EXCP_LOAD_PAGE_FAULT = 0xd, /* since: priv-1.10.0 */
     RISCV_EXCP_STORE_PAGE_FAULT = 0xf, /* since: priv-1.10.0 */
+    RISCV_EXCP_SW_CHECK = 0x12, /* since: priv-1.13.0 */
+    RISCV_EXCP_HW_ERR = 0x13, /* since: priv-1.13.0 */
     RISCV_EXCP_INST_GUEST_PAGE_FAULT = 0x14,
     RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT = 0x15,
     RISCV_EXCP_VIRT_INSTRUCTION_FAULT = 0x16,
-- 
2.34.1


