Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103C9C4829C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOeL-00084M-Tw; Fri, 09 Feb 2024 06:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcp-0006Sr-Vi
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:57 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOck-0000p6-Sx
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:54 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e062fa6e00so452053b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476449; x=1708081249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JdKBSyRMGDmDmRrmQnhhICKDBUjMSlO4/vsaP+eVNLk=;
 b=ahpJY54VazNQgBXlV8VDxQ3kC47qHCvRi6QJZFAqc+pNgA6faiI1fWne1IB4Y+21VH
 6XTFOne60Dc6kVXPt/k8xC6H4+A9rqTnCDwHt3K89b3LKg6xdyMLFCzfqcYVrQXVVogf
 cNlO3C8UbfoYo8UbBrku3HSrasDH+xrbwuzT8NRXqKdZf3dQmj4/j06ZyNDhukxNOUvE
 aIXGMyrOZTIQuM8gJ9PXP/3vsUO/n3urLtPngFc+5ARrysZbzZ4Avlx1T83jTEIVt7dS
 VJOhAsjVv+mAiWDLOrwZJvxNWOhNMyu7ylxFqZK8hODBbYxvMPNu6IKqPDEh3xSNqRov
 FIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476449; x=1708081249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JdKBSyRMGDmDmRrmQnhhICKDBUjMSlO4/vsaP+eVNLk=;
 b=bJE2X+3hTlEOpzQCHMW+bmofneh3HpONEXzlwmOe7oUkbMDhmccsUh5A9nfuxvnkh3
 CE3+9j6LfiWT1xRe7ySo24qu6G93UqcXLb9gI5W1osFOiW2maRKRXcdtKYDhsKxIGEEg
 7JYsDVKjoYsErI/nZnOgp1qvl2VwxSMKcy+Eg89Jw/rxgYM7qsSZHy+U0sHntqi3cq03
 64KwDr1fvbQAgre7T+ZPpuEwoxyiuQZgbv8ZqPhfmraxQ4E0OYqRNBGTAkHoPmLuO+w7
 dsZRFw/wWicAMpAA/9Cv59LezW4lJstYX4tfDZ+RpPGVuKiVEqxWx9733wawvRhMtSKV
 hK9A==
X-Gm-Message-State: AOJu0Yz/3VuTIElPPFIhoDb+0Jc0uTB2c9wW55z4FPRIQLhNXo6TnWiL
 WSkwrkhU6ruS0Aio51EhQUTvJKceQByarzwIN12/4l0mxTFhCY6rwOJYegXxxsEkTQ==
X-Google-Smtp-Source: AGHT+IE2P0aYNt2Ttzc32WvTBz4HZ17i+mvsFk4PcF+mKZNJAIyD1Qa5wv9HiVU+QxQW27HJ4FzQaA==
X-Received: by 2002:a05:6a00:1d9b:b0:6e0:8ddd:7421 with SMTP id
 z27-20020a056a001d9b00b006e08ddd7421mr938357pfw.28.1707476449274; 
 Fri, 09 Feb 2024 03:00:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUWvzvSFDERQuUyy+OoXHPOqek+1rtmbQs6Ixhy1tr0mEUFMk1IGMMBfCUX7Z0OVi5gaibyZcXraANlIRHuC0OQymv/xlbvgGKt1filj833Z37wXFeRcNOjHYrfj43mwY+Cdeo=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:48 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 44/61] hw/riscv/numa.c: use g_autofree in
 socket_fdt_write_distance_matrix()
Date: Fri,  9 Feb 2024 20:57:56 +1000
Message-ID: <20240209105813.3590056-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Use g_autofree in 'dist_matrix' to avoid the manual g_free().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122221529.86562-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/numa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
index d319aefb45..cf686f4ff1 100644
--- a/hw/riscv/numa.c
+++ b/hw/riscv/numa.c
@@ -167,7 +167,8 @@ void riscv_socket_fdt_write_id(const MachineState *ms, const char *node_name,
 void riscv_socket_fdt_write_distance_matrix(const MachineState *ms)
 {
     int i, j, idx;
-    uint32_t *dist_matrix, dist_matrix_size;
+    g_autofree uint32_t *dist_matrix = NULL;
+    uint32_t dist_matrix_size;
 
     if (numa_enabled(ms) && ms->numa_state->have_numa_distance) {
         dist_matrix_size = riscv_socket_count(ms) * riscv_socket_count(ms);
@@ -189,7 +190,6 @@ void riscv_socket_fdt_write_distance_matrix(const MachineState *ms)
                                 "numa-distance-map-v1");
         qemu_fdt_setprop(ms->fdt, "/distance-map", "distance-matrix",
                          dist_matrix, dist_matrix_size);
-        g_free(dist_matrix);
     }
 }
 
-- 
2.43.0


