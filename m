Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6D1CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 21:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJVC-0005KO-5x; Tue, 21 Oct 2025 17:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJV9-00059E-53
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:02:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJV6-0002zG-HU
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:02:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so28698685e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761080555; x=1761685355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0TgeVNPzv68JcCX04RBzBZ666mw+/NGDuzwlB8ZDgk=;
 b=bPh8kTCYkK6kBdm89zfTPffavFWuFUoUC4kIC2GLgohIXQC2u8WuYXzHF4PWAHoxgT
 HtGbykqAM09dfKPrVnLej7JhIOeG8/PQmOkHCtSNrbv4hno1rLdMa+Dp+w8ecPhM/ziy
 kcXkD0PCZgaETUSMPhlYdTh1m+U3qOLuFRriyRZ8CTLI5OtiKZToF34P9UGCYNrI9yq0
 sIgjxSLlfzhbbgZxywUwpV5lLW5m7eIaJuzm7dhx+/CKnt3/DRhV+m2gHgGG/xb1aksE
 4ueDCm69pZKR8wDwpOP5R7snXx71tqZxzg/UroXHSb4e5YtUYIY9T6pTTlWI6EpK4xVu
 QKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761080555; x=1761685355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0TgeVNPzv68JcCX04RBzBZ666mw+/NGDuzwlB8ZDgk=;
 b=FWOsJVk9oACXjXma77QffZzII1Z4NzxrbIV3K+DqitQYVV2B1ZRmVeJGguWhWGrxzY
 jeieTCo5CqtxOaY+1Ly4X4vnvmjTXsfloszsgNKdNTfn/6bIf2zhALlFzz3ncG+x9n/t
 tBah1rQ2JaylP/cbGY8lx/UhCM0hS1CYylOfOtdJalbhy8syI0FePEo5kS1j1QmxvAzf
 17u6Tv7bGqPqQtni3j5qRUc/ZXMCDbta8oQzs4dDdP9i6dTShZP8bZKk07VNtuKM97TL
 ldf4vqWgi1rTHYLwMoVfylGTGTGdFyXMhwBqBG59S8ABm8a0MFC2Z7coKH5NkI7rn2a+
 GIRg==
X-Gm-Message-State: AOJu0Yy6j/ljtKVwK6OdhpNPPE8IM1sGHt7TtjzPTT+lVQ/xt9ENNVnl
 VSi8vdTQqE2l5QfXlxPUZXWqGIMiu1aQMbg/Mqw8somJWov26s8ZnE7B2Yino4xQPZ7zylltUIa
 TD+YtRDQ=
X-Gm-Gg: ASbGncuddAkqd6JX5pQShziribApWNrOupIT/VUxfqEJ+N3CSFgBiTihLjVO1vZFyKv
 Dg8qdLapnTutNkPsStbb4suAYKKohLMNxaRaeKH87jUZfiTxOpWv4CAMgMOJFmU30BYUCZpkyIO
 zaQL+3taeLuy2XboPyGUvrq7O/bflns77r2rjTZyY3ekXjwjZaDwxSoQL+yVrNHZcsB5RXTiLTK
 ZHQCpuJen/EsCwHsYXOSzT87fW/Mak8qyDvfBfACKTL5vlvalkJNH/glFhkwg6xpOTizYvNobfJ
 2r7RINWIhy0Er7UrcHftQs6jcCJClI+mdIYmaNpkMaI5+Beg0gjFSs2B+4VevaEDZY93bZsVLjp
 z91xETiWyHaEtkV/IgyUyli3lb1ooxpKMM3O8LIk6rtXYUlspDnEOliH3PBkAYINYk4AiXXZb6y
 ay0OG0PlAUbWuTzzCaH7X6VyXgkrKysal25fWVRAnI8+RLrtcWyw==
X-Google-Smtp-Source: AGHT+IFqmyrOU0eYDWgzue5wNYagT+6suEDHVe2IA8YQ/1fqqQS5kcdt9rb2iAqFcCTBh231kXjK2A==
X-Received: by 2002:a05:6000:2f8a:b0:427:9a9:462b with SMTP id
 ffacd0b85a97d-42709a9471amr9361002f8f.18.1761080554568; 
 Tue, 21 Oct 2025 14:02:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4369b3esm9589355e9.13.2025.10.21.14.02.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 14:02:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhang Chen <zhangckid@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 13/19] hw/arm/virt: Get default CPU type at runtime
Date: Tue, 21 Oct 2025 23:01:37 +0200
Message-ID: <20251021210144.58108-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021205741.57109-1-philmd@linaro.org>
References: <20251021205741.57109-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Prefer MachineClass::get_default_cpu_type() over
MachineClass::default_cpu_type to get CPU type,
evaluating TCG availability at runtime calling
tcg_enabled().

It's worth noting that this is a behavior change:

- Previously only

  ./configure --disable-tcg --enable-kvm
  ./qemu-system-aarch64 -M virt -accel kvm

  would default to 'max' and

  ./configure --enable-tcg --enable-kvm
  ./qemu-system-aarch64 -M virt -accel kvm

  would default to 'cortex-a15'.

- Afterward, -accel kvm will always default to 'max'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/virt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index dda8edb2745..d07cfe16512 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3257,6 +3257,12 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
     return requested_ipa_size;
 }
 
+static const char *virt_get_default_cpu_type(const MachineState *ms)
+{
+    return tcg_enabled() ? ARM_CPU_TYPE_NAME("cortex-a15")
+                         : ARM_CPU_TYPE_NAME("max");
+}
+
 static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
 {
     GPtrArray *vct = g_ptr_array_new_with_free_func(g_free);
@@ -3312,11 +3318,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->minimum_page_bits = 12;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
-#ifdef CONFIG_TCG
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
-#else
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
-#endif
+    mc->get_default_cpu_type = virt_get_default_cpu_type;
     mc->get_valid_cpu_types = virt_get_valid_cpu_types;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
-- 
2.51.0


