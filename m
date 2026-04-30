Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3DAFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINr3-0004vg-7t; Thu, 30 Apr 2026 05:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqr-0004h7-Us
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:34 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqi-0002Ul-UX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:33 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4480f9b5efbso626260f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541900; x=1778146700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKFk4CN3FBO853sFmh35BMyRf7rQp8uz5AZqJXrG9f0=;
 b=NlYoKLXOLrcQGAOlWDO5P6fan8m93Sk+39VuTYaxNIQhzI38rQ2LODJLfGp80ETUj3
 y5AjMOHcTymEY8aIMfRTsvacEP8w/8HvvJPZ9AB98l3ZlWnHsdWOAy7ODzexN1vgvU03
 YqdozUWiBeBVX6qvWdkJ++WqbQpVhXlnDiEtyeDIbDg5vruKFcXMVb2od+r30LQi2Pdf
 Lu36cqV99LOjLGLQHvsxo/Ulr3Ebf6m4eS+CBaHmZ5CIAXdyP1pFygH7LMM5Grn76xI/
 EEIM3AMgECgHyMcHIx5tcDCgy1IvrQSOgs2uCCr0nPJpJ0N8z1ofSxUA+aSc0ki7rodS
 W7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541900; x=1778146700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PKFk4CN3FBO853sFmh35BMyRf7rQp8uz5AZqJXrG9f0=;
 b=JC2vsllnhifGyYB00AhOEpvAo68rySZRWwZ1YN4ubwkWzz5JuNV0OpApMVUtdoD8xe
 S4NL7oknF9DIghNtSaauCXNL0H3PDJqtq8C/bhRArJyB9ILIRidtrzmbfgIKTvzoXPMD
 LK9Dv6cfZc1u+sHken+RVqu4kljDcppj3niX0robgfy4OhlcCJ51L6uXPiLIkhjc2GER
 yVw8+n+skJ4FT6m6Wxc6qPg9ZyWZv1k8mI9DATYsE7lKMpF2VhDjjsbd0T1KnvS96R4S
 fk4BwkE/VY85NYt/Zi8vWeBwL83zIGfRj8Hs2G1b9U/xoefE3l4VEwi9vF8a26xaegca
 AUqg==
X-Gm-Message-State: AOJu0YwqagTtndU2Wqho3laBn0nmUk1eB0eOUF+nKJvul5v/e4wgGr0F
 uQPaD0hma/ck1WURv7l+pvfAXv7fCSE7DN39f3bK3gQcMirhLxFyZz3E8jLDS7ENEfcBuEfSkE4
 /pYqX
X-Gm-Gg: AeBDieunzx1WyMRdbwQD2pCAMrfjBQPl1j4w4Nhkte09qocZtjW8xrFkAUQ5AzXinUo
 mXw02a7KUbv1yTt1Yugn7KFeEoUL/MBgdvZzF6uxerl6ZtCWvvIElrOIY8ZmMhKdO+arsS87/FQ
 NIPB8UNDAk23nwT5TnUnwpBAVjYElRLFIwLdo7XvIbi81nL/M6v1jk44jRCKJc/y2MoroycJ22H
 Zpc99R+JWOgyNKaOoaUNUHR87SiJr1JRP/38WCYPs/muJRh/Ila3du3qHWmdoVgv+J0gqpG0hqV
 k6skkXiWQ+8TJbG3KjMLCErhG+1+/6Vw23OWzVvywNe1oYVhaBiq+1ysb51YNyb2XQn2VVwSYV6
 C642VAusjCkHmzyZVINfXBsoePmlPk29J3uYmVud8TGyTaM8ytdIUZQkyrZ6vMUuBjhjRIM/i0j
 fKcRZxeB6xrvZoR1zdUFjhpXSC/Yiolx6493s3yg7/kDJniz6l6BVXCMzsqEnE6Q8oaTXcFWukh
 +CknYuommotGpECI6kE0UlReQneZ2IgfXhtd9jIRg==
X-Received: by 2002:a05:6000:144a:b0:437:711c:8754 with SMTP id
 ffacd0b85a97d-4493cb432dcmr3271035f8f.7.1777541899477; 
 Thu, 30 Apr 2026 02:38:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:18 -0700 (PDT)
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
Subject: [PATCH v2 06/25] target/x86: Make get_phys_page_attrs_debug handle
 non-page-aligned addrs
Date: Thu, 30 Apr 2026 10:37:51 +0100
Message-ID: <20260430093810.2762539-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

For x86 this is simple: we just need to stop rounding down the
input address to a TARGET_PAGE boundary when calculating the
result to return.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-6-peter.maydell@linaro.org
---
 target/i386/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index c397a6fde5..108b02396d 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -372,7 +372,7 @@ hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
 out:
 #endif
     pte &= PG_ADDRESS_MASK & ~(page_size - 1);
-    page_offset = (addr & TARGET_PAGE_MASK) & (page_size - 1);
+    page_offset = addr & (page_size - 1);
     return pte | page_offset;
 }
 
-- 
2.43.0


