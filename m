Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B52EDEC04
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 04:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxdYw-0000G8-OH; Tue, 03 Mar 2026 23:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vxdYu-0000FA-Hu
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 23:10:16 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vxdYq-0003Py-0H
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 23:10:14 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ae4d48dc2fso13102905ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 20:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772597408; x=1773202208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xHQb9nF8X8TllKNDQj/dUc+CSrLWcSUS93cO4vXTxRY=;
 b=CZL1uTXkYNRccKiaettQS6aWf8DIdDqI3TuaiZng2YX2sdq7xSSxeoXDImAeZENBob
 1s+c3BnFbGd8LPG2u96YUlTtSL2okVdvl3EOyqMK2fJFDjp8bfhAbKm722Mkhf7hevJS
 ftBfwB1vAmBrsvGRtVig0jOiY49oV269BcRsPxPHMlsznTIOuUcdmk46H7+BQqm9m/N4
 0kZkDK2VKVYsE3KuETQqe6rpcJfSGBu5vFDNEJmcMkktapkKH+F4/l3doau45Nk88bzR
 nn4Bums0xN9iY7QBh2M2qsjYThFKwxa3ftA8d7fhgMgdxWzvjb8QnlQGtGmhlkl9lQrw
 YE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772597408; x=1773202208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xHQb9nF8X8TllKNDQj/dUc+CSrLWcSUS93cO4vXTxRY=;
 b=OqEJr6ZBvlN1KAV5+nX44MJ9yyZ3MKdWBm1gKlBMWIwxp7RagiDZknRRSWiatiqUgh
 La0tRs9Fpqe2CLgwz+Q/+7xaRAmf0jPvwryy5WNWvf+Jrnf9tkD+gYkx973FGFCIfJrJ
 kC8EHIo7fTE/ifTnVG8/cHe7lTwiwpj2TMs6ILv6wGFuU4S7bgodXUgUwQoiCMar/Z6Y
 FddzCGjtllfLXr1ma7mcVubKmX8YYuwaJ3gK7dZAVFCbkoY2wChBvPAwvIGQPlYRWusO
 gIhVoREQcNftwVG5Plvwb2UFvvWhp7w7h923sTbVUItXReqtyDdBUZ4pHHdCkic7vwGY
 p2iA==
X-Gm-Message-State: AOJu0YxYnq4339m1vZt+kPDeEyLJ8aaCdmJGS7sXSUeyoQK1bi6Mh6y9
 YilzvPj858mZ/MbjH83iNduYC3VaROJaZ8hKEvPBwSwSf8wucD4jQDNcqrWR9tMqnnfCALqYqI1
 tlCjmyLDRs+RzFjQjdAlmw5l4pruJrHCurK5Bt5r/Q/hcM0NzjlgUbU2BG4QMCxnWHw5K5+QX2+
 eAFYuHXV2DSNEdMbtqU5JF/8cLyI+wElwWMS9MyL1aaWE=
X-Gm-Gg: ATEYQzwC7/n56ZsXxVurD1Q9CwjpgDBxFTfjh2KpPMvRIxvbcMoAvhc2mY3NxuugGIp
 HobLfk0rTBN6/JduJFsBiV/DZ7fLmLIkltoAC4L6FvTvf3DE9Ir6RjtNwDxdH6ek19yi5o0dsO3
 hz5NqIvMzJMXsbq4SKDpQUnJ4V5w3F72GlzASKTYOwrJRONgpOOGy6iNdwavUhylp97Ah1q0vtx
 CjOw0Mdm7B0zX6g7UbC1D09NqHFbl71bROSqB7QeVFIgmyFDqY38Yfj7uhKmt0l5AoHKBbC78v+
 I3fFE7Z7RGqew0WV6+a1BWl+ieGozpttPFcMtag6TTxGpLKtJRoNER9PcMIsMtu1a/G4kapsHNb
 0tqSVo0glJBFJoui0E4UnoBlTO7481o08jeUE55rm7nmftUbgWJHVug8tc0XyYJNGhW1ZERmr6/
 /3C1Pg7HT4Y5HecqOpH+/SyLUV3QKdU04PjJzR7jr8ze0lejq9fY9fZaSaZmDowg==
X-Received: by 2002:a17:903:1a43:b0:2ae:55bf:eac1 with SMTP id
 d9443c01a7336-2ae6ab9e443mr7985535ad.47.1772597407601; 
 Tue, 03 Mar 2026 20:10:07 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae54136b28sm71058815ad.73.2026.03.03.20.10.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Mar 2026 20:10:07 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 1/2] hw/riscv/riscv-iommu-hpm: Fix irq_overflow_left residual
 value bug
Date: Wed,  4 Mar 2026 12:09:58 +0800
Message-ID: <20260304040959.47267-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260304040959.47267-1-jay.chang@sifive.com>
References: <20260304040959.47267-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reset irq_overflow_left to 0 before setting up a new timer. Without
this fix, a stale irq_overflow_left value from a previous timer setup
could cause incorrect timer behavior.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 hw/riscv/riscv-iommu-hpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
index c5034bff79..e8d284ac8b 100644
--- a/hw/riscv/riscv-iommu-hpm.c
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -228,6 +228,7 @@ static void hpm_setup_timer(RISCVIOMMUState *s, uint64_t value)
     }
 
     overflow_at = (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + overflow_ns;
+    s->irq_overflow_left = 0;
 
     if (overflow_at > INT64_MAX) {
         s->irq_overflow_left = overflow_at - INT64_MAX;
-- 
2.48.1


