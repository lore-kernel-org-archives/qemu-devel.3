Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345A606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TsPbdgfp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLagj-0002gC-6s; Tue, 27 Oct 2026 02:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagX-0002Jy-Py
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:27 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagT-0008Cq-Qs
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:25 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3acb512a7a0so2029770a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082560; x=1793687360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n9jIxm8YNDBwpOkIcvWxHVWyvvib5Axg4U3q1SQYKU0=;
 b=TsPbdgfpoI01GBU6c0++tLPYNqPvsgRWhEEeE8RJS1jR7GcWXsEsJJFblp8qZSaSOj
 ZvQtVHDJ8v3JZ+kJvlgjDntbGlLZjqf6pgS3WiQhVrSZjbEE+QIkKti6A6f5v9leu2F8
 714woW+daRWytEXh+xYk1lKbiEtK6Jizr/cy19JjNe7Ndka8MLXvvbgWVN0bSmpmEOh0
 QipJb/GusMQgxJce25QyZbS0x436QqMJ9g7+QaxMBDummc5FBzrhoGBQlxolJ1c7J6XF
 GUizW136qXJzHSu9G/zy8B2T5jtgY0Z1VrHsSAUV0z0hKjTxIdPsz+T2ZGaCF5QgauOA
 Im4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082560; x=1793687360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n9jIxm8YNDBwpOkIcvWxHVWyvvib5Axg4U3q1SQYKU0=;
 b=KRWB+Q4oPSJnq9nOmmmw6StwQ5HZkjd/sxjjOBcipqfCHz6ZgvW9NMvz+gTtXPr0a7
 7RczrwTL82iSXtjCYZK2HiwibI4UzNYF62BiLJUhIbIK20zYNZ2TdYTn6uHAkgqd6ZvY
 Ljnbr6ZNkisPmdXtjwzI20jMqvHZ+9asBLXLr1knqsAY4DQAWhNAz7dhvDvxax8m35Mx
 V3Wbnv9mIwz+dsPMCcTYlBnoM9appN6t04dTxyClh/s4ree61N4kyB0+8XSNo9AhGc94
 QQcU70eLid+GqjO5b+jQ6sB9CQ81PtIbk4LN2FMYbHNTnRwb08+rXqtGHetoLuYfkOfq
 Mlyw==
X-Gm-Message-State: AFq9FYIRN8cOhd9ZAP8ig3u1JkXKvGF0rZmvO5t7sLhAF+tVibUxqfE+
 3gjqiwQCGqwS/mmvPmllFHIxrAhi9effPRoaxFg/UCH+kceXV30uMDYkC6VRzA==
X-Gm-Gg: AYBFou2OblCwYnUdVY8Lk7RT+KrIzpD738EUPeuGhI55tMSc8LxRsClBqaz81cOOaWq
 RadEa8NRZVjGpjxAAwjKX8CNzg3lKGvEYggMtBU9sm+ixsW7yOiKLAbkeAQqpJYQUyluwvLJKBz
 WFQ014tPD3OnpkHeHQqzkLMja0DB4yx2cqe0rSCFBFP6xSSRIP1Hv4zaJCvDWW+4IMIyBDAENw4
 X26d9HH7myhRBVt/4rBEg0DdK8zr2XDGaWCNoDtTBBCCCQVPY5XxMJKHIkb+4nJge2Q2p/oHR9w
 GPnB/iC1KL4ipv0SPRSYIYPoxH0QTeEKXkcFiXp1YM7Bjb89LQAntFz4a/bISDypMe04udiML2y
 DWHbv3sTm3uMqa3MiIBkA7vgdEkxvkF4DPJqPmqUSseEBeSieCHljWLFpg7cvwnyRUnUT4Ho0hX
 m+Ki2rlT8vrkyNBIxzd45YwuEampjFnHdRN6LGyXxLb4r3GddlmYQpOrizzVVGa+XhVu2fQqr0U
 X3RjFp0O12lyHwKafD0KU9NAqte8LQMF/dGDn5C/dCiA1Dx67qPhTEtT0t6CKBsI2oGwCDV1AnB
 A08ftCJdGeaKDRFPBqDVJSVUAF2HfMaCKa6F59ol4TPe6aE=
X-Received: by 2002:a17:90b:1a87:b0:3ac:9f00:3bc8 with SMTP id
 98e67ed59e1d1-3adead28513mr7254235a91.36.1793082559976; 
 Mon, 26 Oct 2026 23:29:19 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:19 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/29] target/riscv/cpu.c: duct tape fix for QMP + RV profiles
 introspection
Date: Tue, 27 Oct 2026 16:27:56 +1000
Message-ID: <20261027062808.1995205-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Markus reported in [1] a problem with QMP introspection with
qemu-system-riscv64 that happens after querying a profile CPU.  QEMU
crashes hitting an abort during satp_mode logic that, somehow, is being
triggered via profile code.

For every profile CPU that goes through init we're setting an 'enabled'
flag in the static RISCVProfile object.  This sounded like an okay idea
back when profiles were introduced, but now we've realized that QMP will
querying CPUs without exiting the QEMU process while also going multiple
times through cpu_init() and friends.  The result is that we're in a
situation where we have runtime information being stored in static arrays
that persists between CPU definitions being introspected.

A proper fix is to get rid of profile->enabled and turn profiles into
cpu->cfg flags like we do with every other extension.  Unfortunately
we've been using profile->enabled for lots of things and a redesign
would be in order, one which I'm not comfortable doing right now - we're
too close to the QEMU 11.2 code freeze for such a change.

For now let's silver tape a fix in cpu_init() to reset profile->enabled
for all available profiles.  We'll do a proper redesign in the next
release cycle.

[1] https://lore.kernel.org/qemu-devel/87ld7rmdi6.fsf@pond.sub.org/

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20261021173138.2388231-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 916038e8e47f..c162d2803367 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1550,6 +1550,25 @@ static void riscv_cpu_init(Object *obj)
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
+    /*
+     * The way we're handling profiles does not cope well with QMP
+     * instropection.  We have a static array that stores RISCVCPUProfiles
+     * objs that hold runtime state for the lifetime of the QEMU process.
+     * Thus setting profile->enabled once, e.g. when instropecting a
+     * profile CPU, will leave the flag set for subsequent intropections.
+     *
+     * For now, clear all 'enabled' flags to avoid misleading QMP w.r.t
+     * profiles being set.
+     *
+     * FIXME: a better long term solution is to remove profile->enabled
+     * and just use regular cpu->cfg flags, avoiding static variables
+     * storing dynamic state.  This will help us not only with QMP but
+     * also single-binary support.
+     */
+    for (int i = 0; riscv_profiles[i] != NULL; i++) {
+        riscv_profiles[i]->enabled = false;
+    }
+
     if (mcc->def->profile) {
         mcc->def->profile->enabled = true;
     }
-- 
2.55.0


