Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882B5E68953
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MIE-0006gP-Bp; Wed, 30 Oct 2024 23:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MI4-0005X7-IC
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:56:09 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MI3-0004Hi-2n
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:56:08 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20ce65c8e13so6045505ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346965; x=1730951765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f8Zz+Kse6TIUA+P8z+LFTfIC7op8OwD/N4ZO0gt+jmY=;
 b=JqDPiMNgBskjPITMrDhwS25+3mKwVMqPfz1uTC74KBVQv6rElK4SATsMvXj/hMGLLe
 mhIA6RAw52GuQHHEDJQjDXO6el+wR4ZtccsQibGncwnd1Mp0BQ9wxu555205UWmVokV/
 U6r10H9rKdTYg6sbtYjDnHPGQsRoyisb4q5YXt3BQz49VhCNgpChUxh88pTS8tsDFFXq
 uKLpVOUXnNpnfB9h/zWa5DxdwJdhRXiX8CNd+K1cpt8E3imuHzV/CQttCu0mz1KvqB65
 c3ibQ+qO1II8FVp+977tonVJJeLuTDufRHE2XhMFoFtU+efN5VX6k/9Zew/dKrgqEKGF
 vZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346965; x=1730951765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f8Zz+Kse6TIUA+P8z+LFTfIC7op8OwD/N4ZO0gt+jmY=;
 b=u0EuvBC/Ya7fgF0fEVe1TMwX0GJaIlEVn6DZ+tmnwoqWbNXotWg/WxVMBQfQ18rU9V
 IoYP/EfhzD5axntq2pOBr/LONsOgrG6rl7pZleVh8YjkBtHRvFwVJkW4JjY+zwaZu5lK
 UwOaMTjM4NTjjoPorfzJk4WruovOY7OHhfM8AoaN0Fm3KdPuUtkRfQLy58+vgdEhxUTn
 6zvVe+UA3vdhUC7b3i1dKcygf9tOimnlpLBhYzXq9eyhl3dCtz8VZ5Jdk1vmLpWLQhOH
 vpAH54QR4nD+y2K9PFQIJiCWwh2AN1MYSjJOhIypjetBbTAQwOe5nfM827KbOnyIa5QX
 oxXQ==
X-Gm-Message-State: AOJu0YwC+ztK/tUdrw0oJKa5ea6qIU23A9Vmc5w9Rhu6PUc4zk2E3r0i
 PHzWIzLlhDZ53uiUH2VY8pUkYAEctDucbEC+50ij+HkqVpC46mDWxLl5zj7L
X-Google-Smtp-Source: AGHT+IEK02abrvO8IZCYLg22bAfLi1mJ/teppqSzxjxRwb3C7Vq8ElvDQVkBWuATBeYweMKSyudNrg==
X-Received: by 2002:a17:902:ce07:b0:205:709e:1949 with SMTP id
 d9443c01a7336-21103cc0a4emr18580765ad.57.1730346965319; 
 Wed, 30 Oct 2024 20:56:05 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:56:04 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Blanchard <antonb@tenstorrent.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 50/50] target/riscv: Fix vcompress with rvv_ta_all_1s
Date: Thu, 31 Oct 2024 13:53:18 +1000
Message-ID: <20241031035319.731906-51-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anton Blanchard <antonb@tenstorrent.com>

vcompress packs vl or less fields into vd, so the tail starts after the
last packed field. This could be more clearly expressed in the ISA,
but for now this thread helps to explain it:

https://github.com/riscv/riscv-v-spec/issues/796

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241030043538.939712-1-antonb@tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 072bd444b1..ccb32e6122 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5132,7 +5132,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     }                                                                     \
     env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_elems_1s(vd, vta, num * esz, total_elems * esz);             \
 }
 
 /* Compress into vd elements of vs2 where vs1 is enabled */
-- 
2.47.0


