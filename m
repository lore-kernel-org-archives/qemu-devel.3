Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03429C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes1x-0000oh-0J; Wed, 01 Jul 2026 06:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1u-0000en-Uo
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:55 -0400
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1t-0004iN-Bz
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:54 -0400
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-13986d61b4fso570032c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901132; x=1783505932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aiwqoaj9pmINfvTHtlLj8JSF1X1sY/RBHu9JHSWZZ6I=;
 b=YhovlQ7JDe92i8EmHsKTIm0iQfNapIXEyYE/3QszlJji8hlnBF8Cm8qWIz9qiJilGa
 BnzKTuxULkSMeLHF4t2Hj9tQBqEbHQhc75+LoI6CHaSbEUBFRepqBPdKYISJhJswBObA
 /Byo5whCOmWmXtAT+WLwMAHBgvONRIr7h7tO9OouAQtVUnfDcIuwhA3YiRt+QiLWMN/Z
 4mRu4weg8uLHqh5zzqrLm4V0QP3VK55rEafdwtdywuqwbZvWfkSkOOFkoFec5q5g1LHt
 xwWqKfeyIzyxtvMVbkpH4XxHFplBuxQW5dunwT3rhtMjWSHm19v00PQBy4b9SIDsuI3M
 8n8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901132; x=1783505932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Aiwqoaj9pmINfvTHtlLj8JSF1X1sY/RBHu9JHSWZZ6I=;
 b=HmvI3YjuqgIgOQN1iVHmIsYPkp1ok0DTgULOT4JZ3HqIX1lpS9Ke045m4HDydnVShv
 IJUDdX2gcgwqeTbBVZ82M+i6wTWbNJaLr6JW8oJGOBgc0S+y8CydMhs00e1BOD7eVrnE
 cHQ3SjOBEWklfsGi3YIJs1L6anl4xvZNMZyc6s5fMvDZR+YAhIc9Zq8BxwSbFboy/2h6
 KSFSCTXzWZFtQ8uWmrBVW+IgCNfSVrVjd+aAaOPykjBw7Ci7GmG1vVFgzHqA/ApuA4kx
 j3hnn5+VQNMwe0hJaxewAxbYIDFfalpyKnuwosULX6ODBc+oDCXIxXcFR0keP7tnpgpc
 SI5w==
X-Gm-Message-State: AOJu0Ywfpier+zCaY30n4d8fbPzqd0TnIWam+4Fr4KViEvpcUEdI92v3
 Ps4/yiwzQ4mKi5tKov1BYAzwzwXhUda37d87U43TvjY2UYd5gPBbV9/LU4HkiQ==
X-Gm-Gg: AfdE7ckKfSodEl2RAr0Nm4RJ/pg764m177ElN1g70zAdgnrFi4YGcoWdMHn/d43A6t9
 YPd37VFFuOfMLOzmyuw19IredgtxUhy6+j2pQq/ot5ejAchZKKhI149lk7u2zq4A7eBEGMH63qM
 pRoc9U0PRBD9FMDgtmOeQpH2dkHhZdnYeflriBiJyQVeJmYsi3XXbmZJf6KS4k5zaRC2QWZpYky
 XNIO1JMj8nKgfn5DVm7VOFuFcC5PXh+PWtR/Bc4YJ40A7ijsvLc8u15G7AvG4dpuN2HPaBT4J3I
 F8yiOGXaPGGbfST6UPvHepDK8VTyJRu4BtuZpDjDOMNTZ9sOhvLuzoAygWA41R06q/m/TLpKx9S
 fbobJijiVYw5Nl3Y9DzQV0kx/lyOaAxHrb8cszTpIs4p6nXC+sw/pG1tgAHf6wC2j9XH4jVp7oI
 xAYpN2grdyz/eFsEnvoO9pF/A5Poirs60nq2JOWSJe7g==
X-Received: by 2002:a05:7022:ea23:b0:139:f15d:63d3 with SMTP id
 a92af1059eb24-13b36d74c8dmr1016192c88.10.1782901131842; 
 Wed, 01 Jul 2026 03:18:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/39] hw/riscv/sifive_u.c: use intc_phandle in plic creation
Date: Wed,  1 Jul 2026 20:17:27 +1000
Message-ID: <20260701101752.2522962-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1232.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The info about intc_phandles for each CPU is already stored in the
intc_phandles array.  We don't need to fetch them again using
qemu_fdt_get_phandle().

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260616235939.1358663-3-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index fda9a09f06..b3468254f5 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -199,20 +199,16 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     plic_phandle = phandle++;
     cells =  g_new0(uint32_t, ms->smp.cpus * 4 - 2);
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
-        nodename =
-            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
         /* cpu 0 is the management hart that does not have S-mode */
         if (cpu == 0) {
-            cells[0] = cpu_to_be32(intc_phandle);
+            cells[0] = cpu_to_be32(intc_phandles[cpu]);
             cells[1] = cpu_to_be32(IRQ_M_EXT);
         } else {
-            cells[cpu * 4 - 2] = cpu_to_be32(intc_phandle);
+            cells[cpu * 4 - 2] = cpu_to_be32(intc_phandles[cpu]);
             cells[cpu * 4 - 1] = cpu_to_be32(IRQ_M_EXT);
-            cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
+            cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
             cells[cpu * 4 + 1] = cpu_to_be32(IRQ_S_EXT);
         }
-        g_free(nodename);
     }
     nodename = g_strdup_printf("/soc/interrupt-controller@%lx",
         (long)memmap[SIFIVE_U_DEV_PLIC].base);
-- 
2.54.0


