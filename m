Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F1BC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 06:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkHp5-0000Wb-In; Wed, 13 Mar 2024 02:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkHom-0000U9-ED
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:10:26 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkHof-0008PZ-On
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:10:20 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-29c572d4b84so200539a91.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 23:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710310215; x=1710915015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=MxHuuXQsSn/q5eGJQFnPod+0e040rSRLMxHBZ+nr8EU=;
 b=GsmfrDdja+veuCgxZYDXnDk2GxCZ2FfnaCKtRsWyWWfhSMXCktxqBCWTwO1n28MXse
 9EpzHZVxcFN1pd8wfeRm+0pcbbY1NPCTQ8VRgyLNW9G5j2wilMlm9BWlVzd3fov/n/hO
 WOR4dfOZoEpx+nFVmJ6PfzjyxK2rj1h0H7V26E1KGlz+4ORwI04LLk3cgJaqCWYHa/RS
 9I5De9oKp/9/hJjuO4RbkntTe68SzR19t4enlczcb63b6LrsGZhgo6rTvH6z1Cliy9MF
 1w6ec89KIfBlbM9+kd3aeqKX4/+f34VS8mTZRFGIcCNXssw6Aoz9v+qiDyRJg4SFvs5U
 Eo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710310215; x=1710915015;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MxHuuXQsSn/q5eGJQFnPod+0e040rSRLMxHBZ+nr8EU=;
 b=dRsr77lhGT9b7KlvBgQDiPTUk03kW+KVCBWgT/UJFg1uAVJnnL7VcSmJqfpMXHyjhh
 9zWlsmYtMIs3VfmOGHiel5C7e8Xu9/OprzJNyZZKHGgHe3SN9WkXyufjlVw5qlBhYsdA
 2GRSFkk3jBqROCq8pb/LQordQ16NaVgy2ux/PL6GJo4hupfwiCINrrV534EtYAG/iA6Z
 c0gAVAOBMBSB1yg5JuRvl4RbESx+XwzDbsa32cPhlVXGGErUnvPOghfvDGzd6AfiKrU9
 MWVTOM3QPjFuG9mVeJ9HolgtZprrv5ay21Q2mQCoSwxasgTKbej6fuQZe1uInZ7rTCxI
 Btpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQeQeso27Qx/Za5M08SROUE12CQvV59mbxyiGTxMkQsiY1AIZxfv+V/j4X23usHqtV7/eFqfgLxBsLzY45HK5uS9K9lXQ=
X-Gm-Message-State: AOJu0Yw1k8KsoNU6T8Mk3lj+bzgSUrULkBRf/JO3cqK/IXbmmfUn9i+f
 UrcbXW2MjUERrrV2SphcwnaJAAX/jVksuS6yXmuAk9aujzeIm2Y0jildIJ1HjgdLHXYqZ5ZDGDz
 K
X-Google-Smtp-Source: AGHT+IH4Fr+xxCfKD0he+0PTmrp9asZRiTU/FYBVr2JxHYkm9NpGuAD/fMcs36dbQPYjtw/nWGUrgA==
X-Received: by 2002:a17:902:d3cd:b0:1dd:528e:9b8 with SMTP id
 w13-20020a170902d3cd00b001dd528e09b8mr699947plb.5.1710310215074; 
 Tue, 12 Mar 2024 23:10:15 -0700 (PDT)
Received: from localhost.localdomain ([106.51.83.242])
 by smtp.gmail.com with ESMTPSA id
 kj14-20020a17090306ce00b001dd3bc79142sm7755402plb.264.2024.03.12.23.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 23:10:14 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 0/3] Introduce sdtrig ISA extension
Date: Wed, 13 Mar 2024 11:39:28 +0530
Message-Id: <20240313060931.242161-1-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

All the CPUs may or may not implement the debug triggers. Some CPUs
may implement only debug specification v0.13 and not sdtrig ISA
extension.

This patchset, adds sdtrig ISA as an extension which can be turned on or off by
sdtrig=<true/false> option. It is turned off by default.

When debug is true and sdtrig is false, the behaviour is as defined in debug
specification v0.13. If sdtrig is turned on, the behaviour is as defined
in the sdtrig ISA extension.

The "sdtrig" string is concatenated to ISA string when debug or sdtrig is enabled.

Changes from v1:
  - Replaced the debug property with ext_sdtrig
  - Marked it experimenatal by naming it x-sdtrig
  - x-sdtrig is added to ISA string
  - Reversed the patch order

Changes from v2:
  - Mark debug property as deprecated and replace internally with sdtrig extension
  - setting/unsetting debug property shows warning and sets/unsets ext_sdtrig
  - sdtrig is added to ISA string as RISC-V debug specification is frozen

Changes from v3:
  - debug propery is not deprecated but it is superceded by sdtrig extension
  - Mcontrol6 support is not published when only debug property is turned
    on as debug spec v0.13 doesn't define mcontrol6 match triggers.
  - Enabling sdtrig extension turns of debug property and a warning is printed.
    This doesn't break debug specification implemenation since sdtrig is
    backward compatible with debug specification.
  - Disable debug property and enable sdtrig by default for Ventana's Veyron
    CPUs.

Himanshu Chauhan (3):
  target/riscv: Enable mcontrol6 triggers only when sdtrig is selected
  target/riscv: Expose sdtrig ISA extension
  target/riscv: Enable sdtrig for Ventana's Veyron CPUs

 target/riscv/cpu.c     | 14 ++++++-
 target/riscv/cpu_cfg.h |  1 +
 target/riscv/csr.c     |  2 +-
 target/riscv/debug.c   | 92 +++++++++++++++++++++++++-----------------
 target/riscv/machine.c |  2 +-
 5 files changed, 70 insertions(+), 41 deletions(-)

-- 
2.34.1


