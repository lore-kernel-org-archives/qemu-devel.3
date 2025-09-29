Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A639ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3DVc-0002Uu-2g; Mon, 29 Sep 2025 09:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <valentin.haudiquet@canonical.com>)
 id 1v3CVC-0002f9-KO
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 07:57:10 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <valentin.haudiquet@canonical.com>)
 id 1v3CUm-0000g7-Fx
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 07:57:09 -0400
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 299C13F2C5
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1759146994;
 bh=SFghgQGJatviRfZ9+87Gkonq1exr2NEeNKOXqr4eExA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=mBkEqFeUuNp3UM+CiOxwTl0bNfz5ltAZTBKvYxn0Zf4C7lfGed+v2uh58xAF5oQiR
 8T9cmmiXPitw3ArDg9miRfNhwrlH9C/u60dlrtWFNttoIE81T7ch+ofYwiDKnAcO30
 58A8niQuYD7mA2+zrvO3uBhL4VQktJprHubNvDXeBu7yDvsVe+Fl7oEseTlutp2rzV
 HFAlSZoMuJAADS/D7/5osC/OjH1I3GyRA0Bv9GpbYAwSOtAh/KtMBGTv71GtvoiUXT
 i1KhG3xVseOIGzk1ivTI/pV6/oUUMFySCTt7dctaVfBU96Hg9fScCCGsJSi9DhkJte
 PAFGGVkKfFDzg==
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-336b9f3b5b0so2040439a91.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 04:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759146992; x=1759751792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SFghgQGJatviRfZ9+87Gkonq1exr2NEeNKOXqr4eExA=;
 b=OtJmZETlsDvxTyu8iqIo7m+66g5AjZl6zPKCY9cHeKz9BeXh8aO7PCW9TV557CZ4bu
 Oo2ebczsHltzsGe2doTAxXDYPiQ/WCYgVGQJHDf0wTePZhmous95Bphn4W6EkZz/+od4
 Rn/J7oAS6+JQ2oD38wAXOAxCScObDsu6xajlXVXeLoDG6zh+7bD2oBnFsHaaOfGLt4aR
 SpSLwsuU6XLewsc7KNPAxlGCWSOUljD8hubeyThkcXyrVN967k+WlgupnRQ4EUYLrUob
 HCXAPsmQKimmpXnChO9kf/aRojR1urDGzdHico6khsa1rmdVULGVjXuCk4VacL8gdwUX
 bFEQ==
X-Gm-Message-State: AOJu0YwopFlgFD1IRJ2FRlHYhgterxzGnvLrxyXBmDMac/1E9CP0PVqV
 x4QPePU+3bf7NlmeVIsWChl6MzknLLnh/keTmWE4hPQfdvlJ8w9L9tZT/ceAaKQfT8PF+2Kq2qO
 qXO2UdCPRMlq6z5bqxJY/P1is19POJ6HApkUzjTAWVDY3mVCN4w8O9eY4lRrQ2rCPDanO4Mb3bL
 GCZVn2L04=
X-Gm-Gg: ASbGnctuND8OYiLGc45u4GbgQevMnud6+KFjEp2S5uYiSRLtYxiTT5qWeroBKZAipEB
 g393pUOSWedgeiyVLM7HZxgTeSLj6kAggZmiLEi4genhXseTfDuPYp7OhxmMGjZrtpYqF8Z3iK4
 orUv0VYKoh2wpH8F1T/tGJdsjmQVAMwIQfl01S/S41HMOeQUp2CRZpxaRGoWsTYKS8DntwOTdHv
 cd717hFDzVhdSHRHgCtkgu4SMYHzUYtYua8X5FVk3lSYb4TpCaTXcrLHUsHXBGM8RXO9olrzDvy
 ci03a9HWw1FX+TU1ls4AETFCCxwn5apPGtwbQnBsbOC7KoJJfexTIhcWtdbQAQKBJYFhMTYBRDW
 a6Gigf5GBCfF0sicNw/S+oA==
X-Received: by 2002:a17:90b:38cb:b0:32b:ca6f:1245 with SMTP id
 98e67ed59e1d1-3342a2437ffmr16621741a91.5.1759146992388; 
 Mon, 29 Sep 2025 04:56:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFASDBh8G2c1FURRDxpcfFNRhozl7nqUuj2qICqIVNqXX5nmMxG/DEOjlkpOfcYc3xFqA66xA==
X-Received: by 2002:a17:90b:38cb:b0:32b:ca6f:1245 with SMTP id
 98e67ed59e1d1-3342a2437ffmr16621717a91.5.1759146992037; 
 Mon, 29 Sep 2025 04:56:32 -0700 (PDT)
Received: from k6.lan (atoulon-257-1-167-49.w83-113.abo.wanadoo.fr.
 [83.113.30.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-338387256cdsm1042425a91.20.2025.09.29.04.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 04:56:31 -0700 (PDT)
From: Valentin Haudiquet <valentin.haudiquet@canonical.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-trivial@nongnu.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair.francis@wdc.com, palmer@dabbelt.com,
 vhaudiquet <vhaudiquet343@hotmail.fr>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>
Subject: [PATCH] target/riscv: Fix endianness swap on compressed instructions
Date: Mon, 29 Sep 2025 13:55:43 +0200
Message-ID: <20250929115543.1648157-1-valentin.haudiquet@canonical.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=valentin.haudiquet@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 29 Sep 2025 09:01:38 -0400
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

From: vhaudiquet <vhaudiquet343@hotmail.fr>

Three instructions were not using the endianness swap flag, which resulted in a bug on big-endian architectures.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3131
Buglink: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2123828

Signed-off-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
---
 target/riscv/insn_trans/trans_rvzce.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index c77c2b927b..dd15af0f54 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -88,13 +88,13 @@ static bool trans_c_lbu(DisasContext *ctx, arg_c_lbu *a)
 static bool trans_c_lhu(DisasContext *ctx, arg_c_lhu *a)
 {
     REQUIRE_ZCB(ctx);
-    return gen_load(ctx, a, MO_UW);
+    return gen_load(ctx, a, MO_TEUW);
 }
 
 static bool trans_c_lh(DisasContext *ctx, arg_c_lh *a)
 {
     REQUIRE_ZCB(ctx);
-    return gen_load(ctx, a, MO_SW);
+    return gen_load(ctx, a, MO_TESW);
 }
 
 static bool trans_c_sb(DisasContext *ctx, arg_c_sb *a)
@@ -106,7 +106,7 @@ static bool trans_c_sb(DisasContext *ctx, arg_c_sb *a)
 static bool trans_c_sh(DisasContext *ctx, arg_c_sh *a)
 {
     REQUIRE_ZCB(ctx);
-    return gen_store(ctx, a, MO_UW);
+    return gen_store(ctx, a, MO_TEUW);
 }
 
 #define X_S0    8
-- 
2.51.0


