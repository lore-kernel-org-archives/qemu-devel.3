Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC141CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQga-0005VQ-GH; Tue, 16 Jun 2026 06:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgS-0005Hd-HH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:17 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgQ-00036r-W7
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:16 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c8583b8fd89so2608550a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604373; x=1782209173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GECOZnyQvu/vqvqIW80YSRWKUQ0v7g3ixtrhK3igHzw=;
 b=pgzULMuLhOL11/9XjPcbWDGYYK3bLbVUMHkNq/FHxz7PHKHSRx8iurLYAZ9hgzLhy4
 Q1HLb9+4dl8jviA3ghuIgoe+pSoZYCRq3UMkXHWUrz6IJKSJOyRs4dPKsS6guNgBWkTg
 stKSDbAHSH4uwPVB72O0t4q3wWMP39HdssnbdmA7z4TTavoNv48FMVg7xfaVnTcR+sec
 D5+3fL3/aO7dyWWeBHo1bpTmPD6myf7qy/HGl6/w4ynn7dMNEuAAp73TYP/ni3+FWnlK
 UnOZ9RpA1H9AY57tagPQPaJqHNKAHLomjs8UcwVV1uCJwYCoB4NJmdZn3YmJcSD4Msmq
 4zaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604373; x=1782209173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GECOZnyQvu/vqvqIW80YSRWKUQ0v7g3ixtrhK3igHzw=;
 b=Q0wCqawnHa2KcgUprpL4zwe/9066p/oHhNu04Kprm/apG3mDX1kOhfhBkZCOzX2KNQ
 UdywD1LD1Gbhe2ewY9zxFLqt4laEsWjGjgRBitR7kvtDGf5GD3vXNamryzGdFMXb3qg0
 gsADPTZj1UIpoYvAclZN98ZU/qlPvtJr0JzsSG2Vo4Ddi6VCeQrMBcAxZ4IUbpgzTWnL
 Y07YaBdmq+i3chTDGc8J1tdqgauK92Vsq5RMsNsyvqrG289Nl7NKGNGUWRAHUyR+SRjD
 Ge5T8swXtzmLqWXqSjV9xRRzwEyBU77g/YXsn7Ekownfte04N/CFsOYWvjKNwr5iu9uh
 JbHQ==
X-Gm-Message-State: AOJu0Yw7NoYtXf8x/0WnoWqghdVAV+wl+UMt6wWQEDKdHjz0gA4F9MqI
 kzykCOp41ljueRtZyDOj0axnNOKhXKsGRZPWlii4ma7f6mOzDQJPFfrTxfBvD1bi
X-Gm-Gg: Acq92OHHObeJSH8hvyd378vQ6uFxljyDSfJKKldRc0G7KPSd0ZT1qMAmZuTcaNcgTGY
 Tv84nwvojP/Rq/5WBWjFPsUY3Ti+B2aGz9dZbKOutpuQPczDaPRin1nrm4S6rwUqRDQgqweZffb
 zxxIzV5QO+lS62TK35Cw3Xc0sfgNoHzksNHfLDulKYj0bEzdnoimp/XgRuea4Z1jAbU0PGKunFZ
 KIRhmbskmgMaZMY+R68VV92InIg78faRahmoxMNDa7hUwx8HplY6qJHPYsAFIZuAar65RyaHC9Q
 LsyLweC8rSS6sKjO0t69O6xnp5B0n/yrRIXyVphuDy8RLo/ZixjGcHs3/ctUVIz2kr0YPdPEIKN
 rQx+7L6NjxCC0ETBEjhzqBSEGgRtFFnCeS2nG7NDjlcLhCis/h5J42GkQSa9ZOuWyOGzgq2zCi0
 uvQ9GrEN2Y8Mfhecj48kJg3+lNtkznqMRHv6uRTQ6uqT9adBAt8Vc=
X-Received: by 2002:a05:6a20:2443:b0:3b4:b276:a789 with SMTP id
 adf61e73a8af0-3b7841ab01dmr20761532637.36.1781604373134; 
 Tue, 16 Jun 2026 03:06:13 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:12 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 11/83] target/riscv/cpu_helper.c: allow LOAD_ADDR_MIS promotion
 to AMO fault
Date: Tue, 16 Jun 2026 20:04:14 +1000
Message-ID: <20260616100527.1939565-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

promote_load_fault() is missing the promotion of misaligned AMO load
addresses, i.e. RISCV_EXCP_LOAD_ADDR_MIS should be promoted to
RISCV_EXCP_STORE_AMO_ADDR_MIS when RISCV_UW2_ALWAYS_STORE_AMO (i.e.
always_storeamo is true).

All other load AMO faults are already being covered.

Cc: qemu-stable@nongnu.org
Fixes: 98f21c30f5 ("target/riscv: AMO operations always raise store/AMO fault")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3503
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260522181353.429782-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index bc63713ddf..c3745cee19 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -2210,6 +2210,9 @@ static target_ulong promote_load_fault(target_ulong orig_cause)
 
     case RISCV_EXCP_LOAD_PAGE_FAULT:
         return RISCV_EXCP_STORE_PAGE_FAULT;
+
+    case RISCV_EXCP_LOAD_ADDR_MIS:
+        return RISCV_EXCP_STORE_AMO_ADDR_MIS;
     }
 
     /* if no promotion, return original cause */
-- 
2.54.0


