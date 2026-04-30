Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F607FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINrM-0005c6-MG; Thu, 30 Apr 2026 05:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINrI-0005RM-Gv
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:39:00 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINr4-0002rA-0V
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:39:00 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso7829535e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541923; x=1778146723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5r6sY4D7K54zH8grS/of9kRgg+UMxxamJYZ/28n8x8=;
 b=TsVL3RTWcEeeUZpcs82Ih0fsXtmNBmMMROZvE4P94Fm532pjX7EiTWHxOZCcD/Qe72
 qxHptBcxBHWssPJhNdxmCBD5ya3N0RsHZE1e/oXsyUFFmdpX+MNC/TA1Cs8wJEyqVNZu
 8sFaY0quLM6N98jZm5AsuJYX2+3U/CRURN9ZilP7c0yBbqE9WtJteAF61A0ifhSJyvl+
 PRuAXFfetpV11UR7elXhJ7km5Xc8/wdcKrCN7EesapcLP+iWmvVnnYDyXy0o4LbnJjTy
 W2Cr7s8KzpRg5QZxU5XvdnepgksGXG7iKXqimQ6ziz1tXOBsOVC8k55zohVGovgqvgXt
 x8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541923; x=1778146723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W5r6sY4D7K54zH8grS/of9kRgg+UMxxamJYZ/28n8x8=;
 b=pNoXsa3d6IjNw4AqMmA2p7glcpv5dY4iTYByTB+j9oNWrUx19AUfSSiky1GsC2FueR
 csh/V/HYbzUvo1TwMjybecumEjMSaGmb/c90EDlKUP/AKq4r7J2CBTpfU6KEejMoqtJx
 SOwvjNlgKHi2u418X4rb17SmQ3HKb45b0+LLkrQSRSH1HeXG8wVTDZcFG7c15H1Q/HtV
 QZaqDs9zKeVg6pETzOO6n+zoekiLffaNtQgl7f57s2tW9rUuUxHmv1IguvXdNeH8DDSs
 XtW589Fyze8C8SuleENbIZMiHBOkuUzJEiBb4LwRU4WMiFAJOa/K2VX0Ld8FIUEhy+1q
 VbQQ==
X-Gm-Message-State: AOJu0YzOFRXdyATHqmVIcZ6HUAZ/WXlH60z8X1UWC70z1xM0T7lok74d
 VewtxGCwjFzrLnpXPCszRH779kiyBog2DoqxReouAebdbne+/IyO8s5P/P5JolEHEv53wPtXzhM
 7O5ZO
X-Gm-Gg: AeBDiespyZMmnpJWbgnY/qmA/wOp9aw+AGq55LxhOsu9MDDZNsPgAfznFDuUFuh1fwo
 qEnt2TEY4vnMhe6Ap8GsoGAfqSpHGKlZzqbRo0TbuMaGcmmw0us8wEOUaiK//6ztLdBq95zeLpi
 LQPp+HtKdd6641Raq1JlLVvQ6bbVXxAnHYxVrzj0VcUFRtsTGczIBV19NMOnIS3gxQ0PRyy0/OK
 +t4xOamMS27HvIP8j5MPGwv2Wtx/1UL6pZATTvEHaJiHIc70jgPVxbUhHLCoSp6tJiOjz8FSCPu
 zpZD251tiDqy/k5p3sPd1UWpVdaGJ+xtAMFZEH23oTVElvk7L/Ij/qkN5OLqB+iJ+zMqxvzQ7oE
 Zd+CK04FQQg3y+yLF9TJaeI04zIPn8lo6SQADbUKDxn7RGhuM6KzBZo+b8AA+xGr7rNg7QLtF6F
 NG4qwx+XFUQYylmL4QpCLONV6bHIux2GsoTuZSrGFfLOyhVR9EnKf4iHlmVKMT784/HBpj+3791
 Vr03YoEftUqVlFHiOxiZsWPap1fnhUo3VicwY+Sp/LA3cqNIYek
X-Received: by 2002:a5d:438e:0:b0:449:9aee:4575 with SMTP id
 ffacd0b85a97d-4499aee464emr1142625f8f.30.1777541923127; 
 Thu, 30 Apr 2026 02:38:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:42 -0700 (PDT)
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
Subject: [PATCH v2 24/25] plugins/api.c: Use cpu_translate_for_debug()
Date: Thu, 30 Apr 2026 10:38:09 +0100
Message-ID: <20260430093810.2762539-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

We want to remove the cpu_get_phys_addr_debug() function; update the
plugin code to use cpu_translate_for_debug() instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 plugins/api.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index c97cc68882..2d5fe9327f 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -617,15 +617,15 @@ qemu_plugin_write_memory_hwaddr(hwaddr addr, GByteArray *data)
 bool qemu_plugin_translate_vaddr(uint64_t vaddr, uint64_t *hwaddr)
 {
 #ifdef CONFIG_SOFTMMU
+    TranslateForDebugResult tres;
+
     g_assert(current_cpu);
 
-    uint64_t res = cpu_get_phys_addr_debug(current_cpu, vaddr);
-
-    if (res == (uint64_t)-1) {
+    if (!cpu_translate_for_debug(current_cpu, vaddr, &tres)) {
         return false;
     }
 
-    *hwaddr = res;
+    *hwaddr = tres.physaddr;
 
     return true;
 #else
-- 
2.43.0


