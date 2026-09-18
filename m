Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E69C982D0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7M7y-0006bZ-NB; Thu, 17 Sep 2026 20:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7M7w-0006av-Is
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:06:52 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7M7u-0004ql-U9
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:06:52 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so141036a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789690009; x=1790294809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dSdxLTVBDZLas3mi12fziPFTxITSX7k0t06YRU4w+ds=;
 b=MDrf+QI/ziY56Bn6Syi4l6c3mD6gvhTks3wsfNMexkAMPvxwVyqfKrpnqYeRiEeRGN
 KTR4lPljQwrzLBxXYhBNL0tWfZi0qmKtYmpo+0xcstDCx8DuVz2E4Q1ChAxSmMw18IM5
 XZqg1c/HD7rqfBvBnC2gL9ELNV/TOrzEvbhsrH2ql/SNV9FAhI3HK+jDEJBxwKEcEpd+
 h9hv7oaq6+EnaYh14WRpZWI/iFvj1siM/g16MRt/GRFoj8NslqttXdCrB5PurRHakeAe
 vR6hVaZQB8FQX7iGlvInbF25HuHvu688+grZLtXKzPnYVH1Q2tnrYKivJu472ylovnPv
 ne4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789690009; x=1790294809;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dSdxLTVBDZLas3mi12fziPFTxITSX7k0t06YRU4w+ds=;
 b=bm6BLsd6cXMOiNWm/l0EugkMGIuG5sh4NHXjkRKLPwrNrqM9RWAPL3n70DDl46zgot
 nM+z3g+9iw/5f8c86rQiL0OChbX+Gbo7cy0AgsbgQYroZ0KW0XS6QrPDZr48PuCEoiVK
 MgOowKtMUKtS790YRruJVX+cyWv++rTT4mra0xGcOyTdgmfuID7XtMADPnXfH0rGz2Oc
 SZ0xTP/6iCbc0hD69yWwnZ1WTURYxkyzWSlrVHV7PDIs0jv1yf/UujIE6eeo57CCIjMu
 fsGYlLlqrhnO2ZzoU9oGrlxXiK9rRU8Thj0vVHcbWH77AmBXQT0XGwF+VdpGKR34cuPr
 7NsQ==
X-Gm-Message-State: AFuF++knUvlPrugbavkTcKv7hDJFQoYP91xWMBm8f6APBk4ilPCDUIcl
 u1T7VgQGe2Dtz+eSIzkhcbckZ6Y+oxabvUE21fOkPdweOnEnFF7R3x53367F6pTy
X-Gm-Gg: AYBFou2E7/XWFybcGSuBaw4MvwFW+6qj19dlaEA+VSjP/kMeYy+QKLwN8vpphEkk8wU
 DCfGpE598POaG9KvxZotwTnSaRYobuseSDQbSoJwlGzW7L0MVNUNinViTzRmYYoYj1HfBcbatR8
 XRs6V8b5Oh63CiMHuELw9X5EFR1JX4w9ApsnTiUeLHUbK51diMuDxxAeTiDao0/RAxXWuyqD1gG
 fISYEHLZXVDrTbDkCJNXN58NxQHHeb5GnoPrMPuXEuOdIIEwxrZCSKICCr/tevB6JpWMfKMM175
 B9S44XGf1L/X6ZZ9CqSyVdkUEErIJCz3MAmfQRwg+TaF9xmzsflAzuWwT/spFsZQ/pSFVWHxESJ
 bN30zF56wvhEGAyppKa3dnNIpuTjWPVg6AYKlEk12GrFFGQFBQZ38ZPkh2PEq4Z9QG38y9UH/+/
 ayF4dcvmdxdULHV3VI8ws2Om9L+79aFGAIldY2PqEudSI2lLBvc1OU7zDFutaISjHJhO/adFI1K
 /ZLlMJm4KYeXcrzyZ6Poruh6GnS2r2O
X-Received: by 2002:a17:90b:58c4:b0:39d:e445:1d44 with SMTP id
 98e67ed59e1d1-39e361afbe1mr7537456a91.31.1789690009222; 
 Thu, 17 Sep 2026 17:06:49 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33bf5b1d335sm20328212eec.28.2026.09.17.17.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:06:48 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <17746591750@163.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Chao Liu <chao.liu@processmission.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/8] machine: uniquify virt QOM names
Date: Fri, 18 Sep 2026 08:06:31 +0800
Message-ID: <20260918000640.1001-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Multiple targets register a virt board as MACHINE_TYPE_NAME("virt").
Those QOM types collide if more than one board is linked into one
qemu-system process. This series splits the QOM type from the -M name
so each virt board can keep a unique type while -M virt, help, and
migration stay the same.

- Add machine_class_set_name() so boards can set MachineClass::name
  when it must differ from the QOM type. machine_class_base_init still
  defaults the name to the QOM type without -machine. Document that
  MachineClass::name is the -M name, not the QOM type. Sort -M help
  by that name so order matches the printed names after types are
  prefixed (arm-virt-11.1-machine vs virt-11.1).
- Give each colliding virt board a unique QOM type and keep the
  existing -M name via machine_class_set_name(): riscv-virt, arm-virt,
  or1k-virt, hexagon-virt, loongarch-virt, m68k-virt, and xtensa-virt.
  Versioned ARM, LoongArch, and M68K boards keep virt-<ver>. Latest
  ARM virt still sets mc->alias to virt.

Yonggang Luo (8):
  machine: allow -M name to differ from QOM type
  hw/riscv/virt: use unique QOM name
  hw/arm/virt: use unique QOM name
  hw/or1k/virt: use unique QOM name
  hw/hexagon/virt: use unique QOM name
  hw/loongarch/virt: use unique QOM name
  hw/m68k/virt: use unique QOM name
  hw/xtensa/virt: use unique QOM name

 hw/arm/virt.c               |  3 ++-
 hw/core/machine.c           |  6 ++++++
 hw/hexagon/virt.c           |  1 +
 hw/loongarch/virt.c         |  3 ++-
 hw/m68k/virt.c              |  7 ++++---
 hw/or1k/virt.c              |  3 ++-
 hw/riscv/virt.c             |  3 ++-
 hw/xtensa/virt.c            |  3 ++-
 include/hw/arm/virt.h       |  2 +-
 include/hw/core/boards.h    | 12 +++++++++++-
 include/hw/hexagon/virt.h   |  2 +-
 include/hw/loongarch/virt.h |  2 +-
 include/hw/riscv/virt.h     |  2 +-
 system/vl.c                 |  8 +++-----
 14 files changed, 39 insertions(+), 18 deletions(-)

-- 
2.52.0.windows.1


