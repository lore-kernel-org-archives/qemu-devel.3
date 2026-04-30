Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE42FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINqn-0004da-Ka; Thu, 30 Apr 2026 05:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqj-0004a1-JD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:25 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqg-0002Sp-Bp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:25 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so350323f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541895; x=1778146695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbM3cM2bDzJO93KlH0zKhh0sYblzAm78jBIigZVtZpY=;
 b=cnpgdseOmEmem2a4jVGY6WNxdMGRES52bT2c4AKy582VMgCcSYclXF7cBgKqzJNfj8
 Onbu0CqFZvD/bJNC0Er+v5PQ8AfvlqYXwFjaZcwL7NG64qlSkCbpowHD39XY+HX60r6w
 anVJdeAaMukWKXwajyprueMEFyvpvztrHjI2HTZgRRdOS5bBVcV7PmJOOd21XrnK7GcP
 ke5N7gSOd0cHz5LlDL0wsDmGVxYmxDxpm9wUEgX9exxkNgxRb0WDTAs1NvyRN+cwgsbm
 6b05pS0AdkI1IH+zfVlXjI3sI9vxvLZHCztfOZtDSgPmCuQABS2b5ZW76h+FUbUL37D1
 Drsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541895; x=1778146695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WbM3cM2bDzJO93KlH0zKhh0sYblzAm78jBIigZVtZpY=;
 b=OMtx1LhivL4BTFBsK3LuFueRWiS78FK3YqiVjbNP090fqCi+mPI0fZBX171azlwBMH
 67OKG0PFzFbryBj5Dh6ibL/aph8eKasgUqsAu6DBgVTepyfBFcLuS+ewyo0r/QfnsyFg
 IdJ+AaZtOSOCLqBUJMGoWml/HY+JsR7bXR6j2zvpdap91J5xd3TRkxcxThLELtMXvZG2
 HRa2n6IrFltBttOE56LhZzj1SURJ36FBLTPdWvE/nJSVW+bdYF39zzmN3OiwqoFN0TMU
 o9sFFA3ualUoOoXDd9Et3qm6GtmMXzW4ka76U/zkAcGJBFth6cQn9sqhqweB2HDP5h0M
 /ZwA==
X-Gm-Message-State: AOJu0YxoNqFDmG14HfBPwUrL6ie/PDjX17upnKY1sU67WxIPeyJy40rl
 vwEwJVxfjrfgkATM/B2wAvcFnCWIQHi4aMgKn8PWJlSsz9761eZ/on5s13tym8ets2Lp5yMWrl+
 uoJVG
X-Gm-Gg: AeBDiesqmZlfjmjkJizZaFYWztNdPKRPdIlX5DXeGrrLyaF6eCqacl6GFXC8p4NT+rn
 QfqlOjlnWRGS8pp3hui5lXkRoj3bhAZz2idZFrXh2coFjrTnSNBfZ1NgqZ2qSwGPbxL93G86JUB
 FxEz17V0tBhtvRchjmxFwBnWaBzF5OAcI8vElbCpa4lyGivniK023ftZLtno4m+PsbwDeb427HS
 Rp6le/3ATA+vTy761k+Vu1mjGxgLilm9hm9R8RvpTg3zQF7CYY0UgIycS9lRrCkPJuh5z5lqB5t
 2+0rMFqgEhrT11SEXal35mHCsZZUmMRg5EwoTUPAd+LfqAbg3T4Ok//LuHm5r2I4RAwW3a6qygP
 66GmmPyJ2TPBQMC1cQe/h0ocFfgzZsUZ/Mn6+LjFG09P2Ho0JaSA84CrkoMDvcQ+0tcxxkRjiQX
 +2qskg4O3i/A9w3YhxdlbkoXqifee13AE60wLHW/pTIBEbi77Lq3ZrU8JyeFFbFMnsC3dwqS6/9
 m5NpzImC7BGBPPDTs0d3sl99A0nxJeUtxYG6hIjZw==
X-Received: by 2002:a5d:5f47:0:b0:43e:a70d:763c with SMTP id
 ffacd0b85a97d-4493f71a4f1mr3482410f8f.42.1777541894561; 
 Thu, 30 Apr 2026 02:38:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 02/25] target/riscv: Make get_phys_page_debug handle
 non-page-aligned addrs
Date: Thu, 30 Apr 2026 10:37:47 +0100
Message-ID: <20260430093810.2762539-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Currently our implementations of SysemuCPUOps::get_phys_page_debug
and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
non-page-aligned virtual address and returns the corresponding
non-page-aligned physical address" and "only returns a page-aligned
physical address".  This is awkward for callsites, which in practice
all want the physical address for an arbitrary virtual address and
have to work around the possibility of getting a page-aligned
address, and it doesn't account for protection being possibly on a
sub-page-sized granularity.  We want to standardize on the
implementation having to handle non-page-aligned addresses.

The only thing in the riscv implementation that we need to fix
is the place where we explicitly round the return value down to
a page boundary before returning it. Drop that.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-2-peter.maydell@linaro.org
---
 target/riscv/cpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dd6c861a90..475e9cfd57 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1677,7 +1677,7 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         }
     }
 
-    return phys_addr & TARGET_PAGE_MASK;
+    return phys_addr;
 }
 
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
-- 
2.43.0


