Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0351CF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQmA-0003gt-Ab; Mon, 12 Jan 2026 17:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQlq-0002zK-Gm
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:23 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQlp-0003GZ-1Y
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:22 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47d3ffb0f44so48135485e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258339; x=1768863139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ogzIslneGYuEoNGuI1Jj5sYV/IxvfdvBB46hdhVM8aA=;
 b=f0m9MfWy3ewvfWUhl3CXlSAEndtQJHogK/ItwgAUpUx3Q9MXGh1aRgT7U3i3qwE3bf
 5B6K6LOZMiyKvPyM1ub7ru6D9GQewYm8qZhVKtJy7Ms1FvWU5EDGvgZe3mEicb7gdbmt
 SnHQCFzoKPPKHMuBC6sB/AxkA/x0sNih4kVqhOGyFaX50S9PQ5poR1QpITcD53mqHyE/
 ohaS1CvKgDjEdQfvWqw5zNOg0ZZ9GQImZbDD2K9/IwF060Ws9CDXW4lt0h4ZBTXuoYV4
 gZS75Y+le53aoHUIgkRPDzH9ycLHNpiowuw2wQw0TiFKIBKKd4gzhBnTFZscMvv0O3Hc
 AtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258339; x=1768863139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ogzIslneGYuEoNGuI1Jj5sYV/IxvfdvBB46hdhVM8aA=;
 b=dlidMc3DKynLlqtOIf4ClsLGC8uVayDvHBbK50rFEW002Hiqv9LmkchDhQog3BEO4F
 yeoc8TtAGILLh9/VFe967j5oqI/FGTtd7LxDpWedSH+/UwtlYWXroyVb61AGQXP8cHuk
 VTXgFe284r224MeRIPT5dvuFSF0qugH/xkLO5X94Ehn8BzN8Jw/2JW2a8j8GdprZRQkL
 AZSyq+KsS9pGFfsp+zjABCnxrSNlWop8iTx1ZyVL4py3FTQ6/+idiPA3CqMT3VF6HC9o
 NilBPVUQdlDlK4JkS4ZpNEKPTbb6QBgyjW31VKBCTBfg+WWuyvDz4WkAiLJXeEHYBwjj
 PFzg==
X-Gm-Message-State: AOJu0Yx032/j5wkdcLG+Dz5wIPZZCGckgXuCQxmaUdG9CBGU9WtWQIxk
 kMKvTFn/ZP8HxMRS4B3IH+KeXNufAgsCRy/fCiaxbL27p7RZycJvqkbTo9IfhJk9vt/e0695ru1
 HdwM9VG8=
X-Gm-Gg: AY/fxX7xZju1r9Fpgy/lQLtpSLWicyvOgo0STXxgm2b+790JqPmmhahReGZK+zlcgRq
 Gj4pXs3jLmPfbro49fs4vk/A2ohFhs4PSBkNddnmWJqKfrZkEmkWMo7eks2th5n3O8jfrIQJLjM
 yRCQN8s7khDqm1OWihJr/ig8DeLIm2z1hUPmaNXfVPzBkI9W5+saZTgBqARQbPn4weXDdOShQXZ
 LFI4ZOGzcxc/Hay7kkKe/RTV+RvIgGMI/O5nr4JyZMnsKU2eZgveCuhJGQLY63kyIYdTLBo9Lya
 2Z5OebkdatSnBIdxgv1zouu/yaz2PR5e5yxWtOhY+3yK3v4D7de1kI+8AiIU8trEfpcwwLTs/md
 N/+e2xNs4NtGfzJ+nzkkG07wh0DcpQFysFCa1erOEJyD+QWNvnwFIdOkF7N3vuzMoHvUnRlkQt7
 uRaPLEsrMhtKfwOOJxjPk1PNKb3ageOu+CR6hkRNTnhEj4L5OTlD45Y0G+h89R
X-Google-Smtp-Source: AGHT+IEQw60aGNdw0btNmCEiOIw7FTKR4RKr6HGqLBaR4ZNaiyc9WA32nLOvP5r3x6sxcbjvmGaqFw==
X-Received: by 2002:a05:600c:4ed4:b0:477:9986:5e6b with SMTP id
 5b1f17b1804b1-47d84b41b53mr235202805e9.28.1768258339051; 
 Mon, 12 Jan 2026 14:52:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f7035f2sm358382915e9.12.2026.01.12.14.52.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:52:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/61] target/loongarch: Inline cpu_ldl_code() call in
 cpu_do_interrupt()
Date: Mon, 12 Jan 2026 23:48:24 +0100
Message-ID: <20260112224857.42068-30-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

In preparation of removing the cpu_ldl_code wrapper, inline it.

Since LoongArch instructions are always stored in little-endian
order, replace MO_TE -> MO_LE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20251224161456.89707-6-philmd@linaro.org>
---
 target/loongarch/tcg/tcg_cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 9d077c56d9d..cb70692ace4 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -140,7 +140,9 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     }
 
     if (update_badinstr) {
-        env->CSR_BADI = cpu_ldl_code(env, env->pc);
+        MemOpIdx oi = make_memop_idx(MO_LEUL, cpu_mmu_index(cs, true));
+
+        env->CSR_BADI = cpu_ldl_code_mmu(env, env->pc, oi, 0);
     }
 
     /* Save PLV and IE */
-- 
2.52.0


