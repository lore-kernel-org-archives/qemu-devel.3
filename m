Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E95606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 04:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hcQeVliL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJk1T-0003pY-Tr; Thu, 22 Oct 2026 00:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebasjosue84@gmail.com>)
 id 1xJk1S-0003oP-84
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 00:03:22 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sebasjosue84@gmail.com>)
 id 1xJk1P-0006BX-OT
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 00:03:20 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-5ebf39def3aso25614e0c.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 21:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792641798; x=1793246598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=blifmjB3bz8B3ljsvWKzg0ctm7yw5Q0RBn0wK/bYCFg=;
 b=hcQeVliLNTaoP7oDDt4GMKceBUmbnYe3d1fK7RB3Pvx19/D2HdB3dTb5KQr6CYWi+t
 dsIB6qxufn9gIi5pjqpG/PxFgimI3uWwSy5c/kRABFd9YV7V/cJCpyiJiGNxltxtmORS
 NCkiu9YQjfBjd36OKlWKNYoeF3aiJgRlcGiWBzG0ymllJ1Z+f+cv1qqBLRmEWRr+o/u0
 AmSDRY4rkpZqY+8sKQTSKGhedKN2hLD1DITOFi8SicOvCWYJrklkuO9sYoqQ1zFxHTJh
 JrBJB13UQ+ldwM3dkqXVhM8OwUc/CGFFVIz7T0nBLhr3lRYIuuTeTzyIGjf5osv2rsg7
 kSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792641798; x=1793246598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=blifmjB3bz8B3ljsvWKzg0ctm7yw5Q0RBn0wK/bYCFg=;
 b=z67BvhDZaqoOVGOrDUWKy/ifMbSClOgrjlfbkDzCcvcuT96RicEkxqk/IJED3hKuQe
 LePdoUFfQcqTX5St1vkf8p/l2QafDSaW6J9MhmWVJCV4Qf1QygUxbi2dMqywk2/L0fEf
 rTL4D5cIwEDGdTW0/7Wqs/9tWDVAq60S9jmiga7X97nQtwDau87cYyXP8rAiSzbl1M3d
 bemkogO40JTwmsRON/XG/vwx3zGye0C2LrH4QTQMK7h3fnxvn+NAfLTZ/O4yV4TfmutA
 7QkcAb4xOSOV+EJZ8EnfQ/pp85DJ08TbsuSJr8C2IIQi+eOWrsBnvJKxPPc+UKz3nG9X
 sImA==
X-Gm-Message-State: AFq9FYKbwlFZIAuHbxigTFtQESN0XLbS+Xtq3V+QnvDS4WzQCnW090d2
 mrgKeH1ySB/yBYr8J0/qqoxIJx1ZQBoaWfexbgNmBriFMzTXijC0geeGl6YtCid2
X-Gm-Gg: AYBFou0g66Oqh/DlJjH29IvB2lreztj+PAvW4qH3BKf94hQw33973RIMKs/GQSq7cF1
 By3Uzmc7DkOma1He6Nm1gxpuNtSThKO9wVm+72NXJrYXAKu+LP2n9+fDaE4J74fEYJP+KwR7nzn
 uIZYE9UADExkLqd281Wb/0ToZNbU2zHXzz1ntiYXgU9SXlG1lbOUp5QTlnZzJhk3P7lLLjtljgJ
 bZKsIshqYD67aoQyzGUc8kgBNJ3JS0muMaw0R/ub1Gd4jl7canWjlECptVKfER7sylxp7CzR1mH
 U2K065mHbCX9xBn9ttXLyccxte+4Rd6d4k7zWxhGSXym3fFjOeKf1LyhKKyiXlJzHzJS7N1FwZ0
 2qyHxGeQqwwqVPhp/04KOmhJYc0KPy2smU6x8jVB/pvhxJVhNMnfunFyQvaIKWDXSw68v0y3/EG
 +Ps0qa5gMca5nZYOIvyDkbGoPH3nrrSlIr/K+w5zMpp0rjr/CSQlvvr/wI2rKZW9ou9/IRQmdmT
 AkzkMZ4+J/dIfOMHHz0nf1draO67tgk0Yp1ydiM7YvcwrKk3j7yKGj3S9MCuvyv1+cvOlQ8ROEv
 N3c6A2CRt8+YdVZhNIJjkFfTpOjq36wJ066k4hj0OfjF
X-Received: by 2002:a05:6122:3406:b0:5ea:d14a:ef8f with SMTP id
 71dfb90a1353d-5eaebdb1684mr1793766e0c.4.1792641798485; 
 Wed, 21 Oct 2026 21:03:18 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.62])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5eae969803dsm5859810e0c.2.2026.10.21.21.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 21:03:17 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 richard.henderson@linaro.org, Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v3 2/2] target/riscv: pmp: reset the derived PMP bounds and
 rule count
Date: Wed, 21 Oct 2026 22:02:58 -0600
Message-ID: <20261022040258.1509306-3-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022040258.1509306-1-sebasjosue84@gmail.com>
References: <20261022040258.1509306-1-sebasjosue84@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=sebasjosue84@gmail.com; helo=mail-vk1-xa33.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
---
 target/riscv/tcg/pmp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index 061f0e078d..04df53c234 100644
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
2.43.0


