Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A44C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 08:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI12w-0007QI-Hr; Thu, 22 May 2025 04:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uI12j-0007NE-3d
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:12:52 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uI12h-0003M1-9k
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:12:44 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso7192525b3a.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1747901561; x=1748506361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2AQTPTllC/YXTyTGWiVggK3t5QseTYdpGef7t2eK3FU=;
 b=b/sxdgdAY35tofwXfQ4yNd57ftj4MfwvcabNuqa0lGQUsF+rrjMFNGt1HHpOy4A4ll
 Ftfx10kACGwotaISoX/kfhMJzK/l/Oxqh+mt6kr+ijYH2yt6GeT4hIxeSiv1Gihz4B7j
 mrOMh1pV+jS+1RwK4+MtAIbN1qI9xDkGu3jpAoCG2ymuwvsa3stIFHRPtVuxF1YcLJL7
 WbNb+F3B0JWGmQ0GpVHu5GmIBPqLuDcZXyAj75lcQ6tm2zSWIvKKEekje5//2z89bsjU
 Si3j5gZS4pQhkC34dO3N/ybu9MchkNT0ACStYgUbkoxahmj8hg8a4gVVyK1JtaHr5Us9
 PPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747901561; x=1748506361;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2AQTPTllC/YXTyTGWiVggK3t5QseTYdpGef7t2eK3FU=;
 b=w0zZMT9MAfzfk8oY0T6+B91aVrGxQQ0qb/bzIlJbInYYJDPBSQQH3cr0GgOV7MqHn2
 ODhG1LymLTOftkhCWYoKyGsDxxBwPVJxdeu8KiGiHDzPVeUsC0LmBog89xUMbesiy+Ya
 ooHg+ODo60GrsCmlWpM2wO3EWHydhVi15Rr/Md3WyQus+J0nSq51O1w+ipabrQC1pabn
 0ZeJMuHhQbAr5+Fi4KLfSYInEX9IStvAq3ZifLyRVRSppHicWdPu8EAr1nmwqd4x8uO0
 Q7x5ALUS7BNxzxVIVhFUmQ9rR1pmG6O3ggax71R7QRojjsIQRVnCnX9a09jh2AEbS/Dd
 CYEg==
X-Gm-Message-State: AOJu0YwKWvgRznbfNexRnZdngXz7uKsUyh0U9qsuD/kGRQ5YP9YFK/z5
 o1BOzSxLT70zFhOVexX5ncPRvZ4yMGsfaRIKEXsktE0vkw8zbWFSMRCT/ny6SalNj86Mpbr1nPk
 Ym+SP+ObEYSgv+RZNdBjX21OyNxe3s0lEDV2eCCUh0d3wAWaVJnUH7uATkB1u+WowmisoMCA4/8
 cRdn9JKpYJetgz0slCbvdsOUy183A7NG/gei+t0rdD
X-Gm-Gg: ASbGnctrSe44j6nRWob5WfC0iqlwc7vda4Z1soYGynwk7Xfvoy2iGUtmC9L4eCXWHg5
 dw5jOH35pfTFQQ12RHlmDe3TyvkozK/6fjqUNtqLMU0A0zm/ICNLACmxnRcwDbcYrRCu2xptxdA
 HrNb6H78i2yrfycbcZVQOjAtUq4klVKgeeEOi8YezbFA4tpXj8mW3P8z3lMC8MD0Xz+o3JDDuec
 S2uujap7WE97vMJNc0qSe/rbHnO2UvHriddFyAVsrTkU/z6ne6xVvRupslAQBpiduk/nrHsIoJh
 CRkkdq38tjqn7otGuBVUNk1qPTXfnMIlHagGv/zE8q/1sH2OkY93Ky7uyGV1+RL5QLdW442P17t
 sXHK4k6gpjVHmRDAak7lScOXmwQ==
X-Google-Smtp-Source: AGHT+IEw2fGdePqrIK7OTux3b0zq4OOg0J3KMv/eYyVwhp9sbp/JInDBdyJEghAQA18ECEeGGfhYwQ==
X-Received: by 2002:aa7:88c8:0:b0:742:8d52:62f1 with SMTP id
 d2e1a72fcca58-742accc545emr36491022b3a.8.1747901561135; 
 Thu, 22 May 2025 01:12:41 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9829b87sm10775851b3a.114.2025.05.22.01.12.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 May 2025 01:12:40 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v4 0/2] Extend and configure PMP region count
Date: Thu, 22 May 2025 16:12:34 +0800
Message-ID: <20250522081236.4050-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x435.google.com
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

The first patch extends the number of PMP regions supported up to 64,
following the RISC-V Privileged Specification (version >1.12), where
RV32 can have up to 64 PMP regions configured through 16 CSRs.

The second patch makes the PMP region count configurable via a new
CPU parameter `num-pmp-regions`. This allows platforms to adjust
the number of PMP regions without relying on a fixed default value.
If unspecified, the default remains 16 to preserve compatibility.

Change log:
  V4:
  * Changed `pmp_regions` type from `uint16_t` to `uint8_t`
  * Introduced `OLD_MAX_RISCV_PMPS` macro

Jay Chang (2):
  target/riscv: Extend PMP region up to 64
  target/riscv: Make PMP region count configurable

 target/riscv/cpu.c                |  54 ++++++++++++-
 target/riscv/cpu.h                |   3 +-
 target/riscv/cpu_bits.h           |  60 ++++++++++++++
 target/riscv/cpu_cfg_fields.h.inc |   1 +
 target/riscv/csr.c                | 129 +++++++++++++++++++++++++++++-
 target/riscv/machine.c            |   3 +-
 target/riscv/pmp.c                |  28 ++++---
 7 files changed, 262 insertions(+), 16 deletions(-)

-- 
2.48.1


