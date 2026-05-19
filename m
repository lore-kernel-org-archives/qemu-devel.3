Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031E2CD5BAB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDi-0006ig-6O; Tue, 19 May 2026 12:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDV-0006cq-PB
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:50 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDS-0000eH-Qd
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:49 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-43a2ad7bcc4so1587972fac.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207763; x=1779812563; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lf7g3NWu9At1XLoLVfrABfLqdMiHDWY7+mwRcC6wpBQ=;
 b=bJMutUUOAfm5uc6GnTOJgld4kfK6MZ7w4ajPB4YNRIJu0BzqlC+Zr9Dra/RNQed4mL
 htswpkmcRWz/LTjPYiho261SIUbovwovT4UMaciBLvUWULpy9R0mV2aZJbmcUh0HHd5T
 XjDwDag0Bf2e0T6vqeI0FuFznRFzZ8P3ucPI4q5rplSoH1cE27BlZ1LeJPHrZI7W5u6F
 bt9M7EVH8XzH08hR5bIaKi4NmcC2RCWSo7chIgWZXZmYy9279vX8cyiMrGnDXy7o7zvz
 3GwxxWK9ynDCZ5Ejc5Prov9Jaet1zoZgVQl/H7w4uUP20sWSAwTJb4eJI1OSKStvl2S1
 LRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207763; x=1779812563;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Lf7g3NWu9At1XLoLVfrABfLqdMiHDWY7+mwRcC6wpBQ=;
 b=LKZrn8PgKDik+N9YyeenEawYOEAHTcmI6jYSKKs0JTGD4yStmCKuOHD2tPyvP5NyD/
 pncRSJ9cnBe9wwVhYikmzRdF1Xmbeo/iEPyAIrjQ5jgON9VGnk3RmU0JPi4Yu05sVs43
 x2JRDSU7pILLnYX3XCO6EWR6a+RiuXcS8od2FG2MJhSI6xXr7jSuK0q3kcwDMxe6J/40
 MBtYzRWo7xEg2yZvA0gQ74c073m81DEAreCUcC+PWSMAkPIBqBXEpGiyBsH3FnKdJV7S
 h5ZZgPZh9fEGavYQIVunWJ4ZWv1Y7j3wOKRf27Ytr0GU/9EmlQLCuY6gqT0qyVB1ZjtU
 6JFg==
X-Gm-Message-State: AOJu0YxNE2CP6eD1tsK7V8hWltl+ayS0qQ7L9S5PtXtem7J/I6t3USR0
 s4NbSleZHHm49LxWbMub6VhInl43niBI1wIcYxSaplDlVFvv4Df8FV+h
X-Gm-Gg: Acq92OEFZo6PB0Cx0extRxle1ATSiGq/HKnw3mfDT607ojN98RqU3o2bjhVu5q63hML
 1c5vmVec1q91vgWz5A+QHNwWHx45RzGSE1efPS2ldCRn4P6Z5ctbln5iWcmlpHK7U3/JmWjTDOA
 14X6GXWMNWkOHtRfQTcNvHjzVUixQUmdIMd2zPKZmJRl/AqXyWaDYXVg35qmo89J2wZ6xmLtQ0R
 kl40bNzeWoGXZOW39mJfJyhSHyzOzrEvp9HKRZFCkmp1G62UeAweZn6cVsi+CxY4gwezUnd/+4N
 w+BuwYz1sGIbQ5QcEm/gb1f4/0xzcRfrgStTydkmssn/+v/c0/zeV0sShHQDNZ7gdbknd4mKtP5
 pTKJJzHbqhPNy8IOem9BEBvh5LmcSQU8Zu7fnEtWDr2F1wncrviY4IUX6ZugtbuJBtZHyRVn8nf
 JtoIMaOJPmoNcXpUwtlK9cODNksdYRzrYqUJjHadfhby5WYilW7Kw2/pcXjVi0o8IDUT9FhceRE
 AsxYB+ZGDweuD42AAL/lWsPjj/W1JbAFIj0ly3BP3wFgMduT6/4uFRvvuctd5AkayM6uj+tj9D+
 Myc=
X-Received: by 2002:a05:6870:41d1:b0:417:f38:f54d with SMTP id
 586e51a60fabf-43a2dda1925mr12977387fac.29.1779207763005; 
 Tue, 19 May 2026 09:22:43 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:42 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:10 -0600
Subject: [PATCH v9 08/40] target/mips: add Octeon LHUX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-8-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2f.google.com
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

LHUX performs an indexed unsigned halfword load from base + index and
zero-extends the result into rd.

Add the decode entry and reuse the common indexed-load translator with
MO_UW.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LHUX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index efb1a48b38..8a755075e8 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -48,6 +48,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
+LHUX         011111 ..... ..... ..... 10100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 451737cda1..f897b42807 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -164,5 +164,6 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
+TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LDX,  trans_lx, MO_UQ);

-- 
2.54.0


