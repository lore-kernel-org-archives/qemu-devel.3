Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F83606A324
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CyiZGpXI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLagn-000334-Vy; Tue, 27 Oct 2026 02:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagj-0002lS-Tx
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:37 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagi-0008E6-85
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:37 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2e987b4a710so2717555ad.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082575; x=1793687375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xlbSVgmO7fyxbVew3ULaMAxk1dHnZlCGdOD737Opv+s=;
 b=CyiZGpXIUs94DCZcrZWKHke4o+zCiin4NT4hcojZ1E++qAChPR27q69KThXEMso7l1
 YxK7vt3GLqgz+CT627hggTnG1IapYdRs9Gfn24N3yIl35aRtt3JAJFMqGofJYZQTL9yK
 LUFRXntWHr8tps0j5MBjCa2GXVYazrQbzCuepJEcwVQZvvC6w8jBzfHMI4CiPLs4rpAH
 CzlylryLMuCheXfHwmDcHdEaKcW4fAxp9muAl7qQh3gX23NTZAjnfsag7h+iXdNgZ06P
 hPi8e93Ud/6oVE3YAUld8wUezH6uc7hVFd+DjYFrfdLiDQJYXtiyzlTcjmKKz4V660fG
 l8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082575; x=1793687375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xlbSVgmO7fyxbVew3ULaMAxk1dHnZlCGdOD737Opv+s=;
 b=KCCn4rXCRgC4lY0nkXEbor9k2gZchf0rxgb8FfqS+CW/d1uJdk7apl2NK/hmSST9Kl
 CDVbt1fLZ4UwyfBR7nqt236g1oLYSWuyfk8v48xZb/+L5wlFIZF46qiN+Wz39oGwULG7
 C46iLzsvlvAaqOezx8nh7pu+ipvKx+hRdyWqZP5pDMUZyxZeCJrCvhh8tEn0h1P86AJA
 tiYiuC6hx89/6x+LGWHWzBRVnSX4UP6IGY29vVOdnso9Uq9x9krusT6sKUbdhQmbo/Fi
 6WH0dEZZS0l1PSldd8DVU0PT9YCSc2O3BbB052D+Hm9FNoJTf0eiBovv7yazyJkjmIei
 dUqw==
X-Gm-Message-State: AFq9FYJ8hm/zvTfQ5BBFJZDBc8Rwt6uckpr+PDy/OTCct10Ntg7fJH+/
 GlOvIiCNzZeF/a5T0WOMXrAZTBlz3L/XXawZI0IhvXOsq+m4V3Yb+troWSI7cA==
X-Gm-Gg: AYBFou350Ot4lEYVzXsIqwglVKugHK5w4m1UtjDuDOHlUznTlflGfLIVW1daKQLASJT
 auZvctsJF+hS+gFXjRQ8uLwhxsyyfgGTZmA/7lNYT0mQejBsZPckI1le3xYGi2pWCSzCMUY4f27
 xYyIx+J5xiX9gOIC3lSuiSi2aL71PbrjTQbG/S1BNMHjvuw7ki+Sf8ufdqYZCEb2YaSQAJzNcP2
 BSNRFxHOD8U8D2maiveGQov5LVY4sbC2t7BwxsHnW3LKuJQ9RuZn8gD1lDt7Y9gbwKMh/KXM95V
 Yq8tTmQs0kQBChzX1/wjpAtW/OjO62HgO+TOVXpS2IZfLcPxKkIj8ignPovJ+27MGb/PHFZhEZJ
 m1oIrTjCnAnYfsn226Tcv/CZHQ/sUeC1IU/NYeihnCMdLLC9gnugjH1mPfWjmNbSSHnfe1T7J2x
 6mQLT+Q2g/Z6EK1i9tUQxZoVDOuESZf6t9REVYPViV9UkerT2BSln/kXqS8npU/Fl4IH8cfFs1h
 C9hYxpxTY4Co/FbeP0Ah/vw0FJ/RsKnow3DUwYsTZP3P+sSk9RpGqhhUPFGANRexYb0AdqPcw==
X-Received: by 2002:a17:90a:d603:b0:3ae:3e9b:5265 with SMTP id
 98e67ed59e1d1-3ae4029a8f9mr837355a91.26.1793082574821; 
 Mon, 26 Oct 2026 23:29:34 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Sebastian Alba Vives <sebasjosue84@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/29] target/riscv: pmp: clear A and L on every implemented
 PMP entry at reset
Date: Tue, 27 Oct 2026 16:28:01 +1000
Message-ID: <20261027062808.1995205-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sebastian Alba Vives <sebasjosue84@gmail.com>

pmp_unlock_entries() bounds its loop with pmp_get_num_rules(), which
returns the number of entries whose A field is not OFF rather than the
number of implemented entries. With a sparse configuration the loop
stops early: with entries 0 and 1 OFF and entries 2 and 3 locked,
num_rules is 2, the loop covers i = 0 and i = 1, and entries 2 and 3
keep their lock and address-match bits across reset.

riscv_cpu_reset_hold() clears mseccfg, and with it RLB, before calling
this, so pmp_is_readonly() then silently discards every subsequent
pmpcfg write to those entries. The stale rules survive for the
lifetime of the machine.

Bound the loop by the number of implemented regions instead.

Fixes: 4bf501dc0118 ("target/riscv: pmp: Clear pmp/smepmp bits on reset")
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20261022040258.1509306-2-sebasjosue84@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index 41b55519a8e4..061f0e078da0 100644
--- a/target/riscv/tcg/pmp.c
+++ b/target/riscv/tcg/pmp.c
@@ -201,7 +201,7 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
 
 void pmp_unlock_entries(CPURISCVState *env)
 {
-    uint32_t pmp_num = pmp_get_num_rules(env);
+    uint32_t pmp_num = riscv_cpu_cfg(env)->pmp_regions;
     int i;
 
     for (i = 0; i < pmp_num; i++) {
-- 
2.55.0


