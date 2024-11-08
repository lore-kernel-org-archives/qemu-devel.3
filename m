Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF477D5E149
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 08:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9KhB-0004gU-C7; Fri, 08 Nov 2024 03:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1t9Kh8-0004ei-Gb
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:50:18 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1t9Kh6-0000xC-Tj
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:50:18 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-720d14c8dbfso1721502b3a.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 00:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731055815; x=1731660615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEmCxbl+Y3HZznqa/XZg2IpCkVrU8IkpAKmlqF/0zpY=;
 b=AMMSaP+I/ATKXPgWZgTF0UB9UJ9fXUicpLmD9kSNl7mCWe2L4+92bvKhMg4FOFI6Bm
 58h0lOEEwqs/rX0PEiRRQKWPd7LB71ZysgaBrlXW0shtXBpWEb5wkjE3+++1VnpkqCAd
 vZ1SCPs/NPfBMHi5Ay+yeBSqy7a+lZFfVqEiY/wjpQj2dv5SaszlP9axCFtUDpLRbU3N
 d3jxg1pOgld9rJaqA/BfIsZ+11diKDIXmlXAXmFWxs7Rs34tllUIcDRHrckTQQ6xWjWY
 3DrsDNfiX1YHUHf8ixXNaIn0ilCF/etR89L144v1iXfdnUmB7RD6frETQcVPl9QWQjrd
 UgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731055815; x=1731660615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sEmCxbl+Y3HZznqa/XZg2IpCkVrU8IkpAKmlqF/0zpY=;
 b=PAreb6O5Cw9JU+gwMi6T+k4hDuzQtz/RQ4a2eM7x27GX0gKxSbC/Lq6tbvnekNKc5O
 hRvDAz3BadOWlRYUM9FhGUV+/eFJS6BKzNb9TUCeSk1zUpwb+D2bB0kQoujy/Y5tmfxd
 otwe2P4nBhKzYOw9aHjR1KOXWJNP434QI6STVz8tS+KS9Z/lUavjZZ9RnPFPqt7KKfvA
 WWcn116EfcMYSHimPpmHfsZ71nwNKcRpCLX9UHSpsKlQStndH/rmBBtl24ZPw37cVeMo
 o7tcafcP5c6AtsIraDmaTKMBA/CTwG8z1NYlOY0rBFX0D/HBgamV7FDgaC5lnKZc/VKj
 K3aw==
X-Gm-Message-State: AOJu0Yx6dJdo+oS7iHMmKy93bmzYVRI4oKIQFTEeAzK1afSqEai5qnbx
 JT+xlTSgl1xuZy46EE76/o0OEgVBsKv5fWzfxYbwi3Jnsb0eZwHHeBjFSR5ntTOC2WqIRZBsNij
 8bhBeVKpOKo4gQdj9/XlpjxfXNBbVy516tVs1Ak/mQ7jT1W3p0DmUmkeKr5FP+WX0ncznlUizNH
 VSZjnwG/qRQNaMZ6z7X/wY3gxBnUt6cy9/I5c=
X-Google-Smtp-Source: AGHT+IEjy6IEj9WlZJHNrKAJbCmBarUhx+MLwOk/TkQKLLM0Jj1woJHEsXc6paHNj/BUSA0PkaMcug==
X-Received: by 2002:a05:6a20:a12b:b0:1db:e5ac:3d5b with SMTP id
 adf61e73a8af0-1dc22b92926mr2584016637.39.1731055814892; 
 Fri, 08 Nov 2024 00:50:14 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a541da0sm5540135a91.13.2024.11.08.00.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 00:50:14 -0800 (PST)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 1/5] target/riscv: Add svukte extension capability variable
Date: Fri,  8 Nov 2024 16:52:35 +0800
Message-Id: <20241108085239.2927152-2-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108085239.2927152-1-fea.wang@sifive.com>
References: <20241108085239.2927152-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x42d.google.com
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

Refer to the draft of svukte extension from:
https://github.com/riscv/riscv-isa-manual/pull/1564

Svukte provides a means to make user-mode accesses to supervisor memory
raise page faults in constant time, mitigating attacks that attempt to
discover the supervisor software's address-space layout.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 59d6fc445d..d8771ca641 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -84,6 +84,7 @@ struct RISCVCPUConfig {
     bool ext_svnapot;
     bool ext_svpbmt;
     bool ext_svvptc;
+    bool ext_svukte;
     bool ext_zdinx;
     bool ext_zaamo;
     bool ext_zacas;
-- 
2.34.1


