Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDCFCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOrzd-0000nt-21; Mon, 18 May 2026 03:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOrzM-0000kp-1Y
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:02:08 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOrz8-00069P-Qb
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:02:05 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ba0714574fso9509715ad.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779087710; x=1779692510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0tbxKiRNW+18SY+CQFxPhwOFYHp/fQ4n8cxdDna93jE=;
 b=HBhGk9vNimjikG9fnvJU5yT063LBjiUykvS/Iy7GHxf8Ih9HNRfDq1Lvt3O/sa7E/e
 jEDHvUg1p2ATlM6pnTCqTUSQidk6aDG/WvuYbtBNyLufFCOZHmBvMpiOstLUd6IFzdzi
 bhTiY19ng1N2TfsI4OHeoczfS5ldnCutTuKExZjB4+QvQ6KIzH6eO6HdBGoqsKYYz1F0
 fasDCLG/ab6KH7R0/39TsagUp4IYVVaSJGtlwiNyVWjpYFO/OAXykEBYNcTADOwOyWKL
 ZbIqKPZ6eAxU15WVKMI2SCMZEk8xMAZAQOFIiQhSZgpcUldECHba8YKxvjZhDKmU7pdV
 KcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779087710; x=1779692510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0tbxKiRNW+18SY+CQFxPhwOFYHp/fQ4n8cxdDna93jE=;
 b=VvxbrJd7BPPWUGgLrQbzVMprumvglJQOuxKd/Mx0nIYFFTxkDh2ioh1nLxDrAIsZSG
 Jt4vCrbNdIZn1028joqNDgD0z2zgEDFSWfpCTYAH1ZHZtnpI8G+oN1qtIGXSzcVEz/kz
 mRu8ugc68p7uj7vvGAlxtN6IWUuFYdl6ASXMsgY6HQNRX5mi4z5zKKe/UO7sEpWm/000
 0d9sK833BOGDA07BsqfWpd5S5AGB9nV0hMLPHI2NCQGQoO7xrQVNDRS/0/KR5GGMkQVv
 Z5tk8bZrK7s+zo87EDFsoNCvwJwZBUeOfhGX+xAEQrsw9+9GXOJ3aWGXyS7Kw8Gc6nfj
 6n5w==
X-Gm-Message-State: AOJu0Yym9uc7hVWHFug3DVq7+KSCs3dRZUGoZU8NKCvgL+m7ZjHckcRZ
 r84qKW8WVGBI8i654f16Cj7DpLH0C2io6VKzN4aOL0ARsdBUXZFuCgs4Wzx+d8UCcz3quY2s+yp
 PkFXAs4qLl6BJDI7kVbdpfIoDLE1ms4BtfWBJh4xyszB1iFqS87kbw+YFKPLnak1FB41Y/ObMlv
 NUnppH4nlWZUFVTCBCQcwijqOFXwSUspnq5pA058e3T4U=
X-Gm-Gg: Acq92OFNMFflQJJxaRpnEuw679d0qAmgqwm0z8SW+uJnsHRJerkvRZERZwYgWkN1mBj
 oLmi0dTxRjK/9lK7xLoEZZIkHpmthXzzjSwYmVwPsPO+PIMo24iGRvG5m3m9ezoIuh1a+IbLE5k
 riLrbmpWcYRrhKA/6Wvr5ElffP2EdLbaOa8v1+vnLU+umGsvAtO2A+sRRUvb0uvCPMxkGvxZRL0
 +Bsx8ftd+PRNpKlJ/aJvS/ZrtgKt7RlsSef23vyGaSRVoXLvaI43OTVswQh/6JjXVAJ4iepjEx0
 2u5eF4PFcrYoccuXyP6jh5WuV6BlfdizPCQzTPzyLiLcJtBsdXbCfBtb2vHom+6KbMmLA1O/4kp
 9712SjeIsfgLnSdoyp+VKKeB/orf19X3A0U1HdqlVoE4/D+zgNPziGfk7hy+1JSF0uiOEiPsVSD
 TXrtL7PW8x7PSDTqBfSnETsaJKLVZEhyvZwtvYEl/hFyqiAfLch/qozMIoxiRoEA==
X-Received: by 2002:a17:903:3d52:b0:2b9:f55e:1c1b with SMTP id
 d9443c01a7336-2bd7e85fcacmr107430645ad.5.1779087709582; 
 Mon, 18 May 2026 00:01:49 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.163])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d0fbc05sm135715355ad.57.2026.05.18.00.01.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 May 2026 00:01:49 -0700 (PDT)
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
Subject: [PATCH v2] hw/riscv: riscv-iommu: Re-process command queue after
 clearing CMD_ILL
Date: Mon, 18 May 2026 15:01:43 +0800
Message-ID: <20260518070143.8405-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x630.google.com
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

When software clears CMD_ILL or CQMF error bits by writing 1 to CQCSR,
the IOMMU should re-check the command queue and continue processing
pending commands if head != tail.

Per RISC-V IOMMU specification :
If command-queue access leads to a memory fault then the
command-queue-memory-fault bit is set to 1 and the commandqueue
stalls until this bit is cleared. To re-enable command
processing, software should clear this bit by writing 1.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 5bc2472a83..1b8a8e9ef2 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2034,6 +2034,16 @@ static void riscv_iommu_process_cq_control(RISCVIOMMUState *s)
     }
 
     riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR, ctrl_set, ctrl_clr);
+
+    /*
+     * After clearing error bits (CMD_ILL, CQMF), if queue is still active,
+     * re-process pending command.
+     */
+    ctrl_set = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
+    if ((ctrl_set & RISCV_IOMMU_CQCSR_CQON) &&
+        !(ctrl_set & (RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CQMF))) {
+        riscv_iommu_process_cq_tail(s);
+    }
 }
 
 static void riscv_iommu_process_fq_control(RISCVIOMMUState *s)
-- 
2.48.1


