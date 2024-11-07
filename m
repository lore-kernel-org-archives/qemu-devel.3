Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C30BD5AE5F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 04:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8tr5-0006E2-97; Wed, 06 Nov 2024 23:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8tr2-0006DJ-1k
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:44 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8tr0-0004zA-No
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:43 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7ede6803585so1248949a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 20:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730952641; x=1731557441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAj+A4mnSUh5INZ2zk/jr1EQV8+iiISuFmUPqvB9PIw=;
 b=FW4OGtpxc9B8gYhZaG5uLTA1QKu9RU2JSWi0s9bdDzl85+hteZkAtJCE9Hz/yd7gQp
 936iizymzTIPlls5pZOD7ZuLs4B63OhJwki+Hq2ITYWGuAyRl6Yx/XgwJVR5JvKcT/+m
 UDg5QvAeXTVA7FmkfT6VdBq/B7BurMNCpUcMT3zeq/OqYQmMskMe0SukzUjTpF3HA9Nj
 KiRPStzLOrHFdugD9Yl34lzXSOfWf4aqb+KzMBvQ/uFa0Ptvn/36Z4cFYFRvwvGKdDIK
 f4KsnCp1wEJlPhmokQNoWDF7pUvJ5V0pw1hpU42CHSaTWE29zD+QyH0n1dcdjJ833o+Z
 A3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730952641; x=1731557441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RAj+A4mnSUh5INZ2zk/jr1EQV8+iiISuFmUPqvB9PIw=;
 b=s4OJKHB3pkb4OES7i3hjR6JPbaAWf92AsIrMzOgmhr384scrM2sET+JBcnzFyziAzP
 TkVCZVJ5swrmWSi3sdyJORdyv4iY8hLGElwuV2O9pPLbQYQnj1/zETBAGSH1/x+piTgQ
 turYTvEkNS5uoyFT+wnmoqujqdkpzxbi0/15mbENjSR5s1sYsKfhxM0DPzAo4eRc4mvC
 kaXXzdPKbD1Cq+5pM6k6+383RDHguCEtkTrj2JiRC3MfDEPPaJ9SEpwcGacRmYohR51R
 Op6Vto3WLAVL119v51N8CFK5YzqXsRg9VV5zdVLXWmxiUux5Naa9jtTMGBIu9XOmtSpJ
 BmYA==
X-Gm-Message-State: AOJu0YxIzbWwk2rsAlM2j5/CW1HmyB8NdxadXaKHuc2KCr4/1/g8HqqO
 d1rHeHakYaO/s48A98kIBnqPIg4YlqLW+UfNcZ0xhMBsniCKiq3coJcOLg==
X-Google-Smtp-Source: AGHT+IFlKeKd1OeBdUvNC8sbFtZY/lIkxtlCOraDWKhvEYYPmvNkZvf1QgXEdSI5Dmh+gwj26f20yQ==
X-Received: by 2002:a17:902:f70b:b0:20c:7661:dc9a with SMTP id
 d9443c01a7336-21175c13accmr32834095ad.3.1730952641096; 
 Wed, 06 Nov 2024 20:10:41 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc3f12sm2789105ad.9.2024.11.06.20.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 20:10:40 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/12] target/riscv: rvv: Replace VSTART_CHECK_EARLY_EXIT in
 vext_ldst_us
Date: Thu,  7 Nov 2024 14:10:09 +1000
Message-ID: <20241107041016.40800-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107041016.40800-1-alistair.francis@wdc.com>
References: <20241107041016.40800-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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

From: Max Chou <max.chou@sifive.com>

Because the real vl (evl) of vext_ldst_us may be different (e.g.
vlm.v/vsm.v/etc.), so the VSTART_CHECK_EARLY_EXIT checking function
should be replaced by checking evl in vext_ldst_us.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240918171412.150107-3-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ccb32e6122..93cac23a13 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -277,7 +277,10 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
     uint32_t esz = 1 << log2_esz;
 
-    VSTART_CHECK_EARLY_EXIT(env);
+    if (env->vstart >= evl) {
+        env->vstart = 0;
+        return;
+    }
 
     /* load bytes from guest memory */
     for (i = env->vstart; i < evl; env->vstart = ++i) {
-- 
2.47.0


