Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C94FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINr3-0004vU-3m; Thu, 30 Apr 2026 05:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqr-0004gY-Hx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:33 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqi-0002Ry-TX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:33 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cf8d550bdso633762f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541893; x=1778146693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Axtq64X+5rSvIEqryvcspUpFF2IjRCQsS7/Lsf4JrE=;
 b=MPkuY9akhcw6HuHD7r3F2Oc8P/xcwX5Ognkvun23QXB+owtMpSQbDFkTE66EUd/Rpq
 rweqAnCbXKNwwJUzHdM6yF1M2caN3jeSE7EOoE/LEcyukyEIsB/X/Kl52olrgCyCyHDu
 eReW4EsGqi356/4/Jxw161ElNGZn54Z3YYn0hxg+6HtakTPYohBO9L/xZfLBxoxdRPtb
 SHADi/rI8I+Nt89O7bmYCPTmVSskD5iPIVyvulN1474Y7a+iFPsGiEv32+2liW5jmyCr
 b2zIvjE6SsJR3uIeACsdFGJHod76K7yZdBP+J2pxH5j251hVYnfpxzzX28X3aHAUCHo9
 zmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541893; x=1778146693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Axtq64X+5rSvIEqryvcspUpFF2IjRCQsS7/Lsf4JrE=;
 b=m/JCDPnDVmfcy54RgV9CJ4OTPip1Tx+88cIhWR7yBVpntz4hqLSQafsAJAcpinVIJE
 rrrV9Mf0nFPCfWbRD4qRnKth/+kZWrUqOQGNYSn6JnubL0SRBRfuw8VbHIeq9HebfxBV
 mHOncyCIvRXwE4mj9cnmrXdhIFkuHkig1d2oE3VLkOXzwLrwGQa3iG2HcsmDoKU57EJT
 hHQtpWAjgGg9wrLCWJ0RAa0vw/IwxskAXiQCvcP9OIuvXgVwfJ8iLpe9W8lYGXZfBPFo
 b86BeoYTXNcM6FwfAH0r9CcJzM/GXFoygFXzsj+/+lNCDkGaepUp6l1L5GFeGUd4GkfO
 M/8Q==
X-Gm-Message-State: AOJu0Yx6UVhcnZ137y5wMXMJ3pdyEvoBTLkzQFSlmKIgyugX4f3CFV95
 HPi1Ts2jgCG6MVf1+j63UmS00KCVh8bvxqjmYs5kJtTkOlY5iWxQ4zhCj4rp/7TpQFaXk0/wyJF
 rrSGm
X-Gm-Gg: AeBDiesoAvmICofKt+skP5LA1bhikQ+pFC5xlP5JgZjDxINFRzD5P3wBH1zm5f4zCgr
 +PKgIWjtwrHFLzixzRNbdrYEHZ69YlhHQC6Lf7dw4SFHbEgE/5Vamzr7cXTg/SInRJlFUtrm+Q0
 VOFLAgTcUw9tW/4x1koljfSrlgppLo0mctol7fLaTnKmcs7MTuOxhTBxJSj0PvvA0wDJLi2sPqo
 aq0PPRSSUnDXXqvi8/1baOpmIHi8qCXXsfgwGjwQVlndoqA8eNh2vBtsA8c9w5XuvFiF5KqS0ta
 Zvdwh7T+GHHdcE8flVUkkHufSPVKWHwwDbdR8gRqYdJb18XGSzViELghtxqbIgcl4AS+BMpW/HK
 MTRUwdjDkFkC+CpJnhe5ZI4exmIDOYwN7e0dH8lYkiyYI7+WQ1r8tB3AAvNNLvLvk6I7oY4Rsy4
 /83exM4ba6jJhiA3a5RegHxMHXVyF3vKBghbrn7gfPYKXiMjf6jXZO7emJgWkLCn3ux7nZkdz5Z
 oBRwpdIUBYGjC6ZVkOZgGikSwMOPvIEtLK7LgeZLA==
X-Received: by 2002:a05:6000:40cc:b0:441:1df5:480c with SMTP id
 ffacd0b85a97d-4493ffcdca0mr3451189f8f.42.1777541893235; 
 Thu, 30 Apr 2026 02:38:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:12 -0700 (PDT)
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
Subject: [PATCH v2 01/25] hw/i386/vapic: Cope with non-page-aligned return
 from cpu_get_phys_page_debug()
Date: Thu, 30 Apr 2026 10:37:46 +0100
Message-ID: <20260430093810.2762539-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

Currently the i386 implementation of get_phys_page_debug() always
returns an address aligned to a page boundary, and the vapic.c code
assumes this: it adds back in the page offset after the call.  Change
this to OR in the page offset, so that it works whether
cpu_get_phys_page_debug() returns the page address or the exact
physical address. This will mean the code continues to work when
we change the semantics to standardize on "return exact
physical address".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i386/vapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 1acb9f91b2..3738031a05 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -309,7 +309,7 @@ static int update_rom_mapping(VAPICROMState *s, CPUX86State *env, target_ulong i
     if (paddr == -1) {
         return -1;
     }
-    paddr += rom_state_vaddr & ~TARGET_PAGE_MASK;
+    paddr |= rom_state_vaddr & ~TARGET_PAGE_MASK;
     if (paddr != s->rom_state_paddr) {
         return -1;
     }
-- 
2.43.0


