Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A1FCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOs4h-0001lX-UC; Mon, 18 May 2026 03:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOs4c-0001l7-SV
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:07:35 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOs4b-0007uZ-Bc
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:07:34 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-83975e992e1so678838b3a.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779088052; x=1779692852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0tPZf8B+25wJP/kubbDpbroe/eYfjrQzoUuV7XnmbvU=;
 b=HVUQt+ewn3hNo/YJBLuLu4mSONJHDTlz9nezaI1QzrBzeqdk2wmX9aatB9f0jpzTRe
 Es4lNtHBo5iTt6FgzkJWT6ruKRCVnl1j4yC9l/BIl8lvCk3shOjkqh7LaIGS0wvzZzNX
 71Hsg++uFcQnylxvqB/gnkVE1xa11uuJBgyN87bLpVXyGrNTbepyD2/OEXf6rcSu85S5
 vLBn2mkZKMdF5Cl6GQLWhfF2maxm1fC/X5TaIpsq7ONxVe4WuTkawuJOkkDp8NcIasWH
 VzjCXg9OrBG/RtpBveNHoPdFjpxktoexJ8Z8Zh2NnFxLGMRFibYp/vyJ4azVQ/+efXFE
 m+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779088052; x=1779692852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0tPZf8B+25wJP/kubbDpbroe/eYfjrQzoUuV7XnmbvU=;
 b=KdIcaRmuF+S7/ApCvGQZE1rqx+dbKALBu67OA8e52weUWQUaMzF2NH8MFq+ApmPvD5
 qPGlmXktHVReeW8kJ05KhrAG6whAYi7KTDi4MJn8/Sf5cPr1pobZaRF05cKzw8g7MBrD
 SMu37QMaM8FDfctfmaX840WRvoDP3fyLqT+EVxyZ/nrDmGH/azQnVTsog+WzahjzT/X1
 aqFIZ+n24YmI/yJrOvFA9rY0YgUoIQ7L243KpgvQ1NOcpBlAnEsl9BX6gqgBj7JQcBod
 h34MBbyXSLngm5QRjYlNASuVEMJqwp6pmM9mu5AJ5hwuo01VRcGfs2YfFulGm45t+rkq
 VNMg==
X-Gm-Message-State: AOJu0Yx1kMDhcKIm9L92PK8YHmhHgB3lF7Msg2XR/sghM86WcSzfMD9r
 3cBA0+vjSeuF7Cxoo5SBjzdRxLJ03W9AxovaJMcQ5B6g65icHV7yfTs2s/koHQtjxTuK15Ompyu
 Z3F1V6rbXpK3amEJTt2sXvU/V2CDkeYO/eTr0K5hMGqRNUpYcdAMDXkDX8ngU5LcATNY3AvWqix
 DqwNQLb6yDKQ+7Oyjtax5Shq19iZcvTfZY2JuOZYT6Q/8=
X-Gm-Gg: Acq92OHGkcq744Vr6kKt9l30LO2ST8Zf4Tn91Tp73Rz2rg8BL28n+zTacD+Rt9FA66y
 LTTmamurYpbNMre1/JsXTmeNn/adl6e02ypFkfNmoswwMGrDfNZcm9R16qPpum0rqEFB9GhmSIe
 PUu9xoFPi2gwcmet3DYYvPAl0op0xdhpClrm2Mb7czvCMZGMsZ7cQ/0XGqTEwVLx5O8OqlVzVbF
 cJgDKunKUfBvgtdi7Fx0Mr1FEfbLa5ZViYR/upWyF6X8iJfEcesCfOITiT9xdh/3wn8GwqsxT5Y
 EErhujA5hdh/ZJcCxdzj3mBsWq1HkLxD6GH1vV8/zNB8SSQ/I93aH4G/eXwZWNqM8Kj8LWGLpIJ
 uvfH/25UHDNoZf9Suh7foOGTNYgDRuVwPIwuWGJRI9vnpMuEDvf8EsrGBadG/GOM5lKGNFGhgng
 MGgtYOuDu1/+KYWXelgABuMU9jtIm85FVcfNmn4F192ffo6ezLw7dN4A+adQHO1wIukwTW1oTr
X-Received: by 2002:a05:6a00:808f:b0:81f:3bcb:af2a with SMTP id
 d2e1a72fcca58-83f33c60a46mr13199854b3a.26.1779088051416; 
 Mon, 18 May 2026 00:07:31 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.163])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5ceb3sm13411671b3a.34.2026.05.18.00.07.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 May 2026 00:07:31 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v4 0/2] target/riscv: Fix PMP address alignment 
Date: Mon, 18 May 2026 15:07:23 +0800
Message-ID: <20260518070725.9816-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This series fixes PMP address alignment to comply with the RISC-V
specification WARL (Write-Any, Read-Legal) semantics.

When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
value is smaller than the PMP granularity, it needs to be aligned
to the PMP granularity.

Changes in v4:
- Rebase riscv-to-apply.next

Changes in v3:
- Use ROUND_UP() macro for NAPOT address alignment

Changes in v2:
- Fixed commit message grammar ("it needs to be aligned")
- Use ROUND_DOWN() macro for TOR address alignment to improve
  code readability

Jay Chang (2):
  target/riscv: Align pmp size to pmp-granularity
  target/riscv: Use macros for PMP address alignment

 target/riscv/pmp.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

-- 
2.48.1


