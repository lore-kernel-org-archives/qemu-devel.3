Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CCD606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 04:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kBw3iL61
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJk1T-0003pG-Dc; Thu, 22 Oct 2026 00:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebasjosue84@gmail.com>)
 id 1xJk1P-0003nJ-0a
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 00:03:19 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sebasjosue84@gmail.com>)
 id 1xJk1N-0006B1-5z
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 00:03:18 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-5eabf7d5bbeso1531376e0c.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 21:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792641796; x=1793246596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/uetjsA9Z42pxGQEPsZaIXxyPFdfdHALxEuTtBc7tAA=;
 b=kBw3iL61mp5l8/S1yhKSq06EpiE6m0YIJo1D7t/Ibd2vFiJgvOeH8YqjFmWS82ulVG
 2GtWW41gwDAo47BvJhKmjBJ8Xqo4Ec+Gesd8jivPr0Yhngt1NyeXSeRml7SBIi+QKvJ0
 IU4DaqGfICOnGV4PCCqal0LkmuU9Z9i8hoiXlU2IMb6L1whvaWF3+YvMiIAw14pgGQKp
 E05RQCZVO/CjViUdr+6DUMisf5Nu/F3DgxjoqI3QSBwPqsXD7osLr4rCWeKpsehFuKKC
 H398S0paVBVSTFKIldnm8CoDh4Z/DCqeMuX8K5bakLyC0jyv5qCagkk1k3o4jUrMpcWQ
 89Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792641796; x=1793246596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/uetjsA9Z42pxGQEPsZaIXxyPFdfdHALxEuTtBc7tAA=;
 b=OH4VJtqLQnIxiN/dZxu9nI2qX5y/u+gt36z5DaO3Kp+9KN4R6UYdFQ+BESCJaRYagn
 q5UAyPxoBrn0tbFNIHi2fvZxOLWLyJ+dokU84CIQ2UzdxhGuOP7pD7st1nT3ZkaD6WIz
 GzaupB5NDmCLycdgDwHnh4Q431k0i7hOFiivTEkqRwIsxk/uIS5jpAZQ3OFip0PWtMbU
 nEPMLA2TM56uNwSrxu1hQrrYwjdDqybfCqMrMP9sLKbHDuD+SD4Bf+B7IeQwZ0ZQxrcN
 m0b2A9JwlrgMMSPP5ZBknNrxeNdCWUB0gGWQMHK4Iu7v7TZmmkNynrcxVD+NfHC0b6xP
 WlLg==
X-Gm-Message-State: AFq9FYKEJwxiI4yt+45Ozp9jmiKI+rr3arFy8giAaGjdiskG8cFLshux
 IujQiP+v6rcjuhqtZAsFzgs7jDHh1vfS5L5oxi9PIN+9GxgBqTclWMWhcz1kirms
X-Gm-Gg: AYBFou0hyosFo2MvSlaq5nqXIEJiLjkgXnFrJTccXgk2qR6/DfprBHCNpdQIkdo8quh
 z++YHKeglvMkfkbnB0pcEafIoByBQD8GXyK7xxlHMWcvmNLQNkxMH8lqi2poZnW84jcIW5xYssD
 t4Eq06/Lk8dqrt8VkroHtfOf/yaE9T4lZQT2Nnbv28Pum0W1dtPUP+JUwH8yRERz1Se4KSG5uaz
 ROjg7T8GKClyblLajCpGjKPfjx2GF8AlHGy8h+RwLEhtLgfL46pcTAJer9VfKGrN4K/OIyUEIEA
 FIK180UZRBrjCUIHtCnxvQwd0DW0HCz68aBX/WKv9nhfwSW/xPczDbTn+YTARK/WqvIBH5UzZ8X
 StiSo3LYyKfcpJ4yAqfnnU3nZ7+r3XnAO4Hi7JGY8T0MbxRtqTk4ztMzT+3dOafMKuoGljJ4SNs
 kZb4W+wLcvODxCg36auSNRCUmFpTr5Rjjn16/vn8FWBhg0gSY4QvEHzlzKiH6bFKu7B9hbb6nQU
 bjzSFEzN0k5u13qrgr64IPKAtL4rmrUUydZeqt5SElY2q/1p+V3pLyGtRo1S7lQ6j6FsIr+NFeA
 Ehi5VUBRzHQEMEi76sY9emczIhFBfUrH2S/LArClH1o4
X-Received: by 2002:a05:6122:469e:b0:5ea:bfe3:6035 with SMTP id
 71dfb90a1353d-5eaebd6d4bbmr1751513e0c.8.1792641796129; 
 Wed, 21 Oct 2026 21:03:16 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.62])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5eae969803dsm5859810e0c.2.2026.10.21.21.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 21:03:15 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 richard.henderson@linaro.org, Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v3 1/2] target/riscv: pmp: clear A and L on every implemented
 PMP entry at reset
Date: Wed, 21 Oct 2026 22:02:57 -0600
Message-ID: <20261022040258.1509306-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022040258.1509306-1-sebasjosue84@gmail.com>
References: <20261022040258.1509306-1-sebasjosue84@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=sebasjosue84@gmail.com; helo=mail-vk1-xa35.google.com
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
---
 target/riscv/tcg/pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index 41b55519a8..061f0e078d 100644
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
2.43.0


