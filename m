Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADADC02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSSS-0007jC-5o; Thu, 16 Jan 2025 11:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vliaskovitis@suse.com>)
 id 1tYSRk-0006qA-I0
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:10:19 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vliaskovitis@suse.com>)
 id 1tYSRh-0003sN-1n
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:10:15 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso7412405e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1737043811; x=1737648611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GEWldn/GMK3xl84pELbqj9/jbZSGKnwPEb6qTgzibUk=;
 b=YdYRxYAlyz6QpvU0lgLQg8UKXU8bB9GJU4WpKpkQyDQWHcspxPoFR/wNnA7IAxqA6p
 FcMrcb2RiM+rjh9SIFuHt4jKUrLRzMgzJO6e+Q7GunFuhAVGJh4NaBHFPO13+y1P66nG
 DhmC4LbKVZgG7PdKRMgM9rTHG+AbzsIeS3Hq8VXwdzpYgWec2f/IGgUQn7ZLkVXtaPS3
 FqmSG9XSJGt/HS+4tDO++MAiGhVDgUIoRw59nBWtzarZ7sC34xBp82P9QpIeXfTi0x7O
 NkwifFosDTnQLW+GAltTC5gMBnCrExZ3ab9YkS0DCnSIkXV0CTu3wp8GHcbo1kPxAqY9
 7bDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043811; x=1737648611;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GEWldn/GMK3xl84pELbqj9/jbZSGKnwPEb6qTgzibUk=;
 b=kl21GsK2VBdIsRs/bff4CdyNYdIJrZ1+nYRthwsgHfkI9bKq/uBcjbPMmTRbx4pK8/
 VxPSb+QZetMoW1kiGqUGxKwic/z8Gxj0NaxL33ke+3VzsWCXiR8kooE1ds5XZ/MrRk1I
 gRllvQXVtbUkwSKNsC9h6M5KDSw3Oq2T8vEWFexgdT1IRqXRff7zfDjqTIeqpy/CDvXf
 FZeI9q+ZpLHSOfw/RKrRZ6Jo3JlF4B+smo7j0ho9Ckq2v08H3c/bpTLCGyHPjy+WGQ5B
 94YNruLN/yDK0sD3Xg4gf0ed9XbvqikBNb/exm5vJiI9AYgTTkVXkqMSR5yW0O0o8FFJ
 kYVw==
X-Gm-Message-State: AOJu0Yydg63YbOAr3ciWsA0hsLxYHGCC0twG5HjkXQWyPS0v7/q9hbYU
 30RHF/EhJYo9caFMy6B9nm73xsFRSBJ2N+P5GwB2iyhsvKnJG7nMG2i1sh/S/Ni5HoZKNe73Wko
 TtbsMYg==
X-Gm-Gg: ASbGnctoobLvnrf4uiPMdPpXkLUw44j8y46YLD2tBTH0FMSDVTAJJihptFh1WQ/fRjE
 FxQmiIO5I44nphz+bew/+/zM5uoIaxr5WAcVwwnBzyK4m8IyN5AcVr5JEuHYbG7l1c3zQVN4vdu
 sHgXhAVKnP6zML/zqQ07M5llg0eYvwOjXOEuA77FReYM2Y7BFVuvMNFF/Fw6yPiRGhfpU51Ulza
 dcYo8f/bfu9629I9AfaAFGEgd342516026lp2wvywMHqK52c+Q5fjemZCoFe8PDzhdFby6pawaL
 qIRvx9ul
X-Google-Smtp-Source: AGHT+IGEs5ZldKpKOPzsJdIV/PYK/jtP5uJe8daS7b/olvgKwpSmVh2yw4R/3tL6gBmyoVazpwLMmw==
X-Received: by 2002:a05:600c:3c96:b0:42c:b8c9:16c8 with SMTP id
 5b1f17b1804b1-437c6b1d2d0mr71836485e9.10.1737043810689; 
 Thu, 16 Jan 2025 08:10:10 -0800 (PST)
Received: from localhost (ppp-2-86-138-70.home.otenet.gr. [2.86.138.70])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43890417a76sm3651405e9.16.2025.01.16.08.10.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 08:10:10 -0800 (PST)
From: Vasilis Liaskovitis <vliaskovitis@suse.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, jason.chien@sifive.com,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 ajones@ventanamicro.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 philmd@linaro.org, Vasilis Liaskovitis <vliaskovitis@suse.com>
Subject: [PATCH v3] hw/riscv/virt: Add serial alias in DTB
Date: Thu, 16 Jan 2025 17:10:07 +0100
Message-ID: <20250116161007.39710-1-vliaskovitis@suse.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=vliaskovitis@suse.com; helo=mail-wm1-x344.google.com
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

Add an "aliases" node with a "serial0" entry for the single UART
in the riscv virt machine.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2774
Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 hw/riscv/virt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2bc5a9dd98..fb1928cebf 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -971,6 +971,7 @@ static void create_fdt_uart(RISCVVirtState *s, const MemMapEntry *memmap,
     }
 
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
+    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
 }
 
 static void create_fdt_rtc(RISCVVirtState *s, const MemMapEntry *memmap,
@@ -1180,6 +1181,8 @@ static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
     qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed",
                      rng_seed, sizeof(rng_seed));
 
+    qemu_fdt_add_subnode(ms->fdt, "/aliases");
+
     create_fdt_flash(s, memmap);
     create_fdt_fw_cfg(s, memmap);
     create_fdt_pmu(s);
-- 
2.46.0


