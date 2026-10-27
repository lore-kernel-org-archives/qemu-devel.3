Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E4606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wg6AULDG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLags-0003LK-4M; Tue, 27 Oct 2026 02:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagm-00030O-VJ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:41 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagl-0008EN-7O
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:40 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cd5cd8d89a7so1147261a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082578; x=1793687378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RCQq3R5AFdKSB29GiZnMKmupH0O9QiBzGj1yWFSP8UM=;
 b=Wg6AULDG5vIpQseEoAWDleud1Cs1qBTHMWvdFhJvYz58M6vO7hHUHFkQXM8iOfgFBO
 J551SL0ZguO9gw4ZTYolfpzyA9Vtl2Ihh9VNskhNb2w3nOUBZg/9LHOoT6egyR+GKc9i
 zNrl9QfGBgZgYaAo8fsH4r7Br+sM9IWoeYW1SuOk16B7IWB89tB+v9vy3aO2UbYZjW2W
 juTz22GRsJcP307cN5hWZnBK71rm1zpZBjrXbwNnOCSFuLb5aY9ZoT7HDZP9dGdhIMzG
 n9wFoAxNbtQxbmvxUtQ3ml+cOWgtkWvt16jfkURHsm/w/D3IlK+bR3vkGtqS844+BIcm
 nN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082578; x=1793687378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RCQq3R5AFdKSB29GiZnMKmupH0O9QiBzGj1yWFSP8UM=;
 b=S+ThuSF4tw55bHAs/UOvce2ANU2AKdgQDrzeZx41tCwJsIYaxAQeWlahpZa5muoBAj
 WvqH6TgfPQA9kAB+iRstdGxFwvxvsDdx7rEtYaE02uY9CBKM/DNyS/q4D1cGoqfFunxw
 WcJZbsCclnBOowSvL10Aa/tfqvZ8SdqtsDNqGTKIlMIx0As2Jo9dcLVbyPW2cq0/SXvH
 aQGpehlrLjcdAxrBX4tn7UDJmi4IhgxWHi07576wA8Gq7E0+eD042oUF344ZSGUlnIes
 imHF+fBUyLRE9egHRaH2dorHdE0oQ5fkselYBr6YZi3W8WLVrkex2U4IrSxVVD8lmz03
 Pv9g==
X-Gm-Message-State: AFq9FYKW+SeB9UIs7BY2mel6tiYzRgO/ZzVMQ9F+De+w3hFUCOVAD7mJ
 0RkMuQOxHs59Tm8WkYTWwW53kilar4t8HBokTPIA6yOVJnJCcU/1GsdSpopP2w==
X-Gm-Gg: AYBFou3T3V2A2MJ7IOTlFQLKG9OOPh0fs+wY92oFQ3bXXOaU8BgHdRNLdn4qtvd/dzB
 +OMDXCNK0jAHaaD4s3cAynFY3mixM+hIIK6NGwyYLlsRrmmGCiZnjGYe9ARCQkTGkukctvSwijd
 Ldwcdj2FHBKXgSD0MHIfLtOTY+PCHaH+E8C7VGZb/64eD9NcnhuVrsSB3s6IPgAzDnAO+an1/Kx
 ejdYR2tCJNdYFSXseezCVi8+pc4+7236DvP9EfSlX3eg4H8E2xoxJw5515lH5y7UwUYYEOMUNbx
 TJNjFGuplktFJyhasL4uVsFTJYf20O2ZyWSXFPjSj9Hv8mdqbNLAlpBUcY6sd297WKiLmNh9D9p
 sE89h+pFsFNzzi2Tsrqvgaj3AYJZ0qMYhNTMWBx89P4AN98kdFRdexZ7U5fFJ7dpFwfiAZVqrrw
 H2dmkwVtwenRlAvFhE8SkoDzkWvJOb5FYQ9lpTqGqTHqC+vh9Bxj7JB9wnvqxPJOetPyAYyBh0V
 RjVpikXIfFAGN7YNmsNFmljLfjRIkaqu9QDRmtU93e6u3MPpJSER/bG5jENMZPkXkVbbSzQfErB
 Ko3no8I8tMmyWkZCC43t8R0lNNsPuH3A7Z67cPyf3OnqO1A=
X-Received: by 2002:a17:90b:1804:b0:3ab:4e4:e979 with SMTP id
 98e67ed59e1d1-3adead4fb3cmr7004083a91.36.1793082577568; 
 Mon, 26 Oct 2026 23:29:37 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Sebastian Alba Vives <sebasjosue84@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/29] target/riscv: pmp: reset the derived PMP bounds and rule
 count
Date: Tue, 27 Oct 2026 16:28:02 +1000
Message-ID: <20261027062808.1995205-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
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

The priv spec only requires the A and L fields to be reset, which the
previous patch now does for every implemented entry. QEMU additionally
keeps derived state next to the architectural registers:
pmp_state.addr[] holds the decoded start and end address of each entry
and pmp_state.num_rules caches the active rule count. Both are
recomputed from the pmpaddr and pmpcfg write paths only, never at
reset.

pmp_is_in_range() compares against addr[].sa and addr[].ea without
consulting the A field, and the partially-inside check in
pmp_hart_has_privs() runs before the A field is tested, so a range
left over from before the reset can still deny an access that
straddles its boundary once the guest configures any entry again.

Clear the derived state alongside the architectural fields so the two
cannot disagree.

Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20261022040258.1509306-3-sebasjosue84@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/pmp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index 061f0e078da0..04df53c23464 100644
--- a/target/riscv/tcg/pmp.c
+++ b/target/riscv/tcg/pmp.c
@@ -207,6 +207,14 @@ void pmp_unlock_entries(CPURISCVState *env)
     for (i = 0; i < pmp_num; i++) {
         env->pmp_state.pmp[i].cfg_reg &= ~(PMP_LOCK | PMP_AMATCH);
     }
+
+    /*
+     * addr[] and num_rules are derived from the pmpaddr and pmpcfg write
+     * paths and are not recomputed at reset. Clear them here so they
+     * cannot disagree with the architectural fields cleared above.
+     */
+    memset(env->pmp_state.addr, 0, sizeof(env->pmp_state.addr));
+    env->pmp_state.num_rules = 0;
 }
 
 static void pmp_decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)
-- 
2.55.0


