Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8595DC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvMm-0008JL-Ad; Fri, 02 Feb 2024 10:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVvMj-0008Io-2Z
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:22:05 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVvMh-0004Sd-Ej
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:22:04 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d70b0e521eso16290035ad.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706887321; x=1707492121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GBbkUmGgx8mTUMw/EXn5Nhc9JPgfhYY/3fJIlzsS7fM=;
 b=IRlh5EGBEtx3Aji1C6SeZ/6m4jyeBtSck24hlaGZZLLWO07VbsEheSDlfoJIGMekmq
 czh9cupbCLFK3/n3E4iKyiuRd2dUayBgN9IQN+vI4vqsYxTUdkeWatwFb5wjnbWw2sC2
 qZS3innO6/dg/u1HlbQ4zFnisMVftBRtBbdxvLM8Fs8zMzi+GDF9+UXjpbsT2FTrwe1t
 XiaqBie3qicpfY9mE5pryRCNPydEJqBsRMwVcFrMVyGnXaTNYT70PenmCukC2rQuAEWx
 0xGc0pjbr13qbkp5fv6jjCMbaDXByyt7tBPfN5/AsP0rNUgL3P6h0tP9xi1y2pZat18Q
 IpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706887321; x=1707492121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GBbkUmGgx8mTUMw/EXn5Nhc9JPgfhYY/3fJIlzsS7fM=;
 b=KghUHcMba3JkfEwBc1LAenGBHUuZDuHLK1od5dNPCLVoKYPcwI3pQ3I3H2mLrsCgOu
 cu4LKuyVES8pEHu/ojuXqBVtCnlDeV4SWePQKUNW6gpSxe82ClyOeNmAJvkWN5RoL0Ve
 HqdHrsA/xNfYVnU+hUrUxCSQ2Hxt+GN2DWsCNiNH7Jr9mPHwcpcsprzwE0rZHfrlTAOa
 qMvUdlP5AFExfakaMG0UczgxSv5EmmKu5PvWk1kSgd1XtovwQRoAsLq+0dC1PeFlTfUq
 e2NOr3UQjXweab3z97OdmrooNq7D1kc9gtCJee3Mdns+R/ok0NaMX1v4hxsFxz6/9KRg
 WiTw==
X-Gm-Message-State: AOJu0Yzvy4y3G1k1c2JpRuevJIay2Huisnm8w+KFPqa87SeNm4wZInu+
 kf64GUQaF9P09ekptMf3EHzKtYhRWOx2q4LooZw1MgSyi89e8ODP0rLvjazEnKdylFzi5UfTxOw
 T
X-Google-Smtp-Source: AGHT+IE7yMUq6iJgFNRUllzhqmqmOsXME7PmjTg6U7gH17l7aVMqmKJn0lTznpcBAjEksyLpf/YNoQ==
X-Received: by 2002:a17:903:32d2:b0:1d8:e079:ce16 with SMTP id
 i18-20020a17090332d200b001d8e079ce16mr2569025plr.1.1706887321072; 
 Fri, 02 Feb 2024 07:22:01 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV9uKo/JE3Q5eSNps9IUhONs61rwHTSIAhqqg0vMC4tZU3tEKoocS9l57EwNlUsdTCO7VBCX5zu9UnsL5iaDoSYt/szQ2unqOMetBJ4Ci/U4o4Y3e7txlACFeWKSN8njasnixORATKyn2ckkfHBxwx7KtVWgnFgt7S7xeVwNFoL+d/n5OXEGL46tj7R+FpQ9YMuSA80BoF4tPPAzO1Tb9++sQzbyI7T6o/SXNrJE43HcWhjLYwnYVlM4ERm4MCX8+DKuNssHuDJw53yQZFBx5BgPtBMn4YBYQ==
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 j3-20020a170902f24300b001d714a1530bsm1734381plc.176.2024.02.02.07.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:22:00 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 0/6] riscv: named features riscv,isa, 'svade' rework
Date: Fri,  2 Feb 2024 12:21:48 -0300
Message-ID: <20240202152154.773253-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

Hi,

In this new version we changed patch 3 as suggested by Alistair in v1
[1]. Instead of creating individual always-true bool for each named
feature, create a bool flag will be always 'true' to be used as config
offset for these named extensions.

Patches based on riscv-to-apply.next.

Patches missing acks: patch 3.

Changes from v2:
- patch 3:
  - 'ext_always_enabled' bool added
  - individual always-enabled named features bools removed
- v2 link: https://lore.kernel.org/qemu-riscv/20240126133101.61344-8-ajones@ventanamicro.com/


[1] https://lore.kernel.org/qemu-riscv/20240125195319.329181-1-dbarboza@ventanamicro.com/

Andrew Jones (3):
  target/riscv: Reset henvcfg to zero
  target/riscv: Gate hardware A/D PTE bit updating
  target/riscv: Promote svade to a normal extension

Daniel Henrique Barboza (3):
  target/riscv/tcg: set 'mmu' with 'satp' in cpu_set_profile()
  target/riscv: add riscv,isa to named features
  target/riscv: add remaining named features

 target/riscv/cpu.c         | 70 +++++++++++++++++++++++++++-----------
 target/riscv/cpu_cfg.h     | 12 +++++--
 target/riscv/cpu_helper.c  | 19 ++++++++---
 target/riscv/csr.c         |  2 +-
 target/riscv/tcg/tcg-cpu.c | 34 +++++++++---------
 5 files changed, 94 insertions(+), 43 deletions(-)

-- 
2.43.0


