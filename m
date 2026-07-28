Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D665C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZ9n-0003XD-RT; Tue, 28 Jul 2026 00:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dubdublan1987@gmail.com>)
 id 1woZ9P-0003VD-Oi
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:10:45 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dubdublan1987@gmail.com>)
 id 1woZ9M-0003hh-39
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:10:42 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cacf197759so48606705ad.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785211839; x=1785816639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1ZNFzEPH0Jg7uKKvrJCqD8ThwFjBxj0u025SyTmCZm4=;
 b=dFT03hKwXjQDHfReYtK8ug0jKWAAkKS1w0ZWBMwoYoLz++qj9y5s02x2aykBkCJ0cq
 oaJ3xxWxIDvbQAwtdPnn0NPdzFF0bcBfqFmeHZEib2ZVXUq+w2k2Xs4HIHSGTH14mdoz
 HOah+1POp2loY7AFt4oMwWtjqBBFlL+xPwGXgIOzDDWyIcU9werKZf7yB+ZfPjyE1mHA
 hJPx8mcQJ7Ih2PRtGGpvpGq4YVZMJ3MPlNnNwXsw2Mib7hP3r4LWDFBHmWjgMQ5sdjmy
 DMaqLN+NITo3J3KuFxdezhyFvubR54wWBQyeFHMGK66RK/ymFOPkXAoxfLClMrBz7ton
 GyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785211839; x=1785816639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1ZNFzEPH0Jg7uKKvrJCqD8ThwFjBxj0u025SyTmCZm4=;
 b=gCiXihM43k22FpDgGnCA+OQbNwz6ohO2qPFuXcx3sbQKpARRNQI543dHWedxMXaeTU
 47soa0G36jIF/sIMEMEtn7dzSd5Qg1r7XI/aJoRP9OI3HBqbLtvuQRExhufVKHMS93r5
 su0E0YeWuHcXwdZbfBY0u9y4wGm7qn9Q4mojFBMVHSKMMbTKtoGQl7Pri43eb3a+vabu
 TyvUd2H0PzfUZIqK0KbDvP4Nc6OWWboxXRLrlbENrFYzcynB5qq+jM1tdPwqqtSpYLou
 XHLvj+Q1GtVYwaCGo1eC6wBHstuXzN60ZuR3bafYj2iLkX8AQlufrTK50woA33pBzWfZ
 m1mA==
X-Gm-Message-State: AOJu0Ywxx5S8gq4smg2sGm8xYlyE82RqyqJe4t8nNguuKMWo1nJi9McD
 KGKE9B/lI2mLk2ZZ4MuUyRXOnSnEduB1j3Oheg6DoPOjQIwMOcXRqX/aDxsq/pDOlpY=
X-Gm-Gg: AR+sD112nxUUOqLwxFEs5/UPsNyYb6gvkyL77JGDBBR3OT7WdEBwAUk6KHU+KNUGjrn
 sWrWG5qRZrZWKWuxwwtaMwqgy9JQqMeNSXc+M306gachykOOYw+pdqOrgjQk7O0DCvNVQSNfQ3I
 ujlFAwX12IRfqCaDddkl9GFk5CBcBnJakTRfDFzrBx0+eIlVByp0l+F16iRoKYlOVzDJCZG0kSY
 rtdRCFSHrq39+QiKMxb1hsEt7LXnVdYWMm25dPwEr6W6eBk1GaX2pIowW7AKkaOk2UlJ27v3V6l
 PXGPM/dQCeCHjv9w9Nc1ROlaco3JynUAeaZIk6S+gCPMzFZVBmjHxjJ/wqWj2phzGvhqiwIJH6r
 j5lcV4A/Yk0yRAJcku0B7r8Rgh722Fc4ykV0yods+rITF5oaocmSdvhPuBA7RT03rLpWWRfeQry
 ktcVx9L7lzibUniO3MnzzFHq3+iirpEQ==
X-Received: by 2002:a17:902:fd87:b0:2c9:e9c4:82c1 with SMTP id
 d9443c01a7336-2d015f02158mr8104815ad.26.1785211838668; 
 Mon, 27 Jul 2026 21:10:38 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([27.115.61.146])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde80ee56sm44378785ad.76.2026.07.27.21.10.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Jul 2026 21:10:38 -0700 (PDT)
From: lanxiaoyun <dubdublan1987@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 lanxiaoyun1 <dubdublan1987@gmail.com>
Subject: [PATCH v2 1/1] hw/intc: resample level IRQ on PLIC completion
Date: Tue, 28 Jul 2026 12:09:22 +0800
Message-ID: <37c3604b0cf28f07f006aa40e7c20a5b12e34184.1785210445.git.dubdublan1987@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785210445.git.dubdublan1987@gmail.com>
References: <cover.1785210445.git.dubdublan1987@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dubdublan1987@gmail.com; helo=mail-pl1-x636.google.com
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

From: lanxiaoyun1 <dubdublan1987@gmail.com>

When an interrupt completion message is received, if the interrupt is
level-triggered and still asserted, forward a new interrupt request to
the PLIC core.

This updates the SiFive PLIC IRQ handling so completion rechecks the
current source level and reasserts pending state when the input remains
high, matching the RISC-V PLIC specification.

Signed-off-by: lanxiaoyun1 <dubdublan1987@gmail.com>
---
 hw/intc/sifive_plic.c         | 5 ++++-
 include/hw/intc/sifive_plic.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 9c84ff06a9..3927684bcf 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -246,6 +246,7 @@ static void sifive_plic_write(void *opaque, hwaddr addr, uint64_t value,
         } else if (contextid == 4) {
             if (value < plic->num_sources) {
                 sifive_plic_set_claimed(plic, value, false);
+                sifive_plic_set_pending(plic, value, !!plic->source[value]);
                 sifive_plic_update(plic);
             }
         } else {
@@ -276,6 +277,7 @@ static void sifive_plic_reset(DeviceState *dev)
     int i;
 
     memset(s->source_priority, 0, sizeof(uint32_t) * s->num_sources);
+    memset(s->source, 0, sizeof(uint32_t) * s->num_sources);
     memset(s->target_priority, 0, sizeof(uint32_t) * s->num_addrs);
     memset(s->pending, 0, sizeof(uint32_t) * s->bitfield_words);
     memset(s->claimed, 0, sizeof(uint32_t) * s->bitfield_words);
@@ -353,7 +355,7 @@ static void parse_hart_config(SiFivePLICState *plic)
 static void sifive_plic_irq_request(void *opaque, int irq, int level)
 {
     SiFivePLICState *s = opaque;
-
+    s->source[irq] = !!level;
     if (level > 0) {
         sifive_plic_set_pending(s, irq, true);
         sifive_plic_update(s);
@@ -379,6 +381,7 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
     s->bitfield_words = (s->num_sources + 31) >> 5;
     s->num_enables = s->bitfield_words * s->num_addrs;
     s->source_priority = g_new0(uint32_t, s->num_sources);
+    s->source = g_new0(uint32_t, s->num_sources);
     s->target_priority = g_new(uint32_t, s->num_addrs);
     s->pending = g_new0(uint32_t, s->bitfield_words);
     s->claimed = g_new0(uint32_t, s->bitfield_words);
diff --git a/include/hw/intc/sifive_plic.h b/include/hw/intc/sifive_plic.h
index 32973dbf28..627a418ba1 100644
--- a/include/hw/intc/sifive_plic.h
+++ b/include/hw/intc/sifive_plic.h
@@ -54,6 +54,7 @@ struct SiFivePLICState {
     uint32_t num_enables;
     PLICAddr *addr_config;
     uint32_t *source_priority;
+    uint32_t *source;
     uint32_t *target_priority;
     uint32_t *pending;
     uint32_t *claimed;
-- 
2.43.0


