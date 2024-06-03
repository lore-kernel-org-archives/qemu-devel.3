Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FADC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5he-0007K7-Qs; Mon, 03 Jun 2024 07:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hR-0006G2-RZ; Mon, 03 Jun 2024 07:18:01 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hN-0006PW-0y; Mon, 03 Jun 2024 07:18:01 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f661450af5so11830245ad.3; 
 Mon, 03 Jun 2024 04:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413475; x=1718018275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJgBJ0EmldlUzQtT/aivgrSis6Y1lAdujHeTStRACnA=;
 b=LbyP06f/AuQHpU3Uj6E0P67Djq4UPhwdT46a2MqCxqLzx21ycqovCryA9QQjWETZAe
 eDTMYHcNIYOgFw+VNPW67rbyftBdTbOaHZx3RQ0LwmI3axEFi+tw8C20eO4+oIauzIXa
 kccDygjoBHCIu5zruAd2pRxRvY7BKbkdBFSF4l2S89tJZfWOoppntAmXdGqwAKvrwZmJ
 5P8NnhiZS8rVttvxonDMnI/gcRKLRETG7VcPoXqxt4a5mo+Db2YyB1GQ9Hl9J+cqVdtR
 1QnFzf01HkjgiKlOzm0OWPH7ADRKKT1WJfanIL03R21q8fxoy1DF60yyU4atK3/NH3Ea
 xu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413475; x=1718018275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJgBJ0EmldlUzQtT/aivgrSis6Y1lAdujHeTStRACnA=;
 b=M/3Pc1bvsqefNdRYz4iIWZ+S0Dn9SI3tTNuAcw/DgMxw1kY/VIf4hCptIAte3aTyu/
 SBtJFjwsE2Fx3X3mxSegHxxpC70D3iHWa/Emy0NFZdVDWIsy4vyPD4mQHM4J7cx29hrg
 38XP7CK/CEIYzkm+gjXtf3AHBNpDheFIGj95AV4lo3sA3/GynXQHNmWK1ayvVjz/xTP0
 vPNEyIBR3sNUABFUIrlNGYeDUlkxKLqF11CvBMKEm6VK4Afqgb3nfNZgzkVA5qdX0Y+e
 95TOFNS5LliLxuo9Klti+SNqQeuKH3k7mmGmHWzAQnr25fMw/+FdHzdUNJI/Qz5vc/1o
 ftyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQJg2MN27Hhb/pm4BwpZQM/ThLPeqkmKqp4XYNxCIoYZw8Nw7cL9dlOqV/SVjK83y1yitxzn1p4KL0EiqZyU4wD+sKgsqL
X-Gm-Message-State: AOJu0YygYoB2O30CsPzImcOMfeFn4v56OofTAbhbGCMvvVJSwEZjhJTF
 RmkZHfTvdKWWZDV9tnDET0Xo4XsK6nFkqflEhiOz0mkfEu30yuiBA41v6A==
X-Google-Smtp-Source: AGHT+IGjSEWzb2DIRxiHUVGSTXYUmXPklETtPgdPbXcK3CUpyLhoKN0NHNRPd9wEQz/Td1wyQGGs2Q==
X-Received: by 2002:a17:903:603:b0:1f4:6986:720a with SMTP id
 d9443c01a7336-1f6370277f2mr70877095ad.31.1717413474888; 
 Mon, 03 Jun 2024 04:17:54 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:17:54 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 19/27] target/riscv: rvv: Check single width operator for
 vfncvt.rod.f.f.w
Date: Mon,  3 Jun 2024 21:16:35 +1000
Message-ID: <20240603111643.258712-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Max Chou <max.chou@sifive.com>

The opfv_narrow_check needs to check the single width float operator by
require_rvf.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240322092600.1198921-4-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index a7217aed4e..c3af38af80 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2817,6 +2817,7 @@ static bool opffv_narrow_check(DisasContext *s, arg_rmr *a)
 static bool opffv_rod_narrow_check(DisasContext *s, arg_rmr *a)
 {
     return opfv_narrow_check(s, a) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8);
 }
-- 
2.45.1


