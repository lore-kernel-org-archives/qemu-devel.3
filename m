Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6926C606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jkL/59uE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoLR-0004NI-6v; Fri, 30 Oct 2026 11:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoKm-0004I4-39
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:16:10 -0400
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoKj-0008Ol-IC
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:15:59 -0400
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-35829219da8so2287188eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793373355; x=1793978155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1Rg4bi/F0EGsPeT/kaQ1mX1hyEceGiWztvW5JiOyGZA=;
 b=jkL/59uEsuYVDYuahuUzSicrnquI0Ks8Is/wr+vSwasljI18H86/BSbwMxdHV1PVPV
 aLWpgFLkdhEeQlcQ89xTP7im9XTxm97McJFwesm1nnikzo7z33nTRQWYJmgnzyNTVKCe
 RP865ndUnV4Fj3IS4WkKXzwmXr/rd391A+4GWT6xgJLbrcKtfmt7po9A8esjoCaQY7KC
 o1Wg6YPe1KQpY8JJVzQj6Yg7girVnu2GliDPZ7JP4Gh2Z4HRjzXCTdLrMdiLiHE4nQcd
 ds7pRiP1Hm02XPlTQKCgF0dKM6jMstfEjcxakJPg08yAUbXZOey2EH72vIMnQxiy7/oh
 zOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793373355; x=1793978155;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1Rg4bi/F0EGsPeT/kaQ1mX1hyEceGiWztvW5JiOyGZA=;
 b=PPYbZMikjpgYKFqJ/H4l2jDCh6WroKNqDr3gIQsB80b03O0Bkp/+Et5UpCVm18DEwP
 JucLj+622MQ/hNBVD/yYMcxbFd9GVux76+tZEJYlawHrhYSta1lza0PjBV6omY0wzeEe
 ZzlWoYfZiXaDPBYJyB3mIliTVatp+T5eA84iJab6BQvIm/bPuEuCD8ZKXTBafQirp7fm
 wxY0fQuWK/LJInXM5FrNc56wFwM4s1y++4eHkLkThFaXqZScHaaPnvJUca3xsxeFXKMT
 XX3MFejFXese3wXIYcq2z4Y9Y4kYi6E9xD9O75NgD8VFkbfNGLWMSexbw94w1br/cipP
 Nh/w==
X-Gm-Message-State: AFq9FYJMHz6DowbdL8utnyxxYg/OZoGb00ZJZ/RMnGstMpSia3kLL/Oe
 G+mbBs0yO/VrcL4JnFs5DcjLkSinTYICgfu/iFeoS8YMEkmio/s9MHAie40v5VctlS8=
X-Gm-Gg: AYBFou0dWNRFFYXvsM0xoMhAN0hUkkhmRkrhUuXEJLCCo+/uEbnLqqXLyY5LkU/4NQe
 nM0gS9OC8gJpOpltQKXbAZzBq/R7LFDsx2I0L12FGSsz6rmgva1VpqfkGIOVpMV441buNtI+/nB
 NIL9Kv5DaP3hUADny5DliREEWThCK2F+HNr49WO1SHvCT2uhiIzZzRMyNOLMAf//KtW3pJk8NmV
 ZYU41Ht8+6ingo8vcFxO9KgCtTSrh4AmjWyQjAMxvR2Q4Wsurtn3ct2Y2vZOB/Cr4905mM8kVwt
 rBu9u5Sg3HBy1pR7cEenuJbpMJRDQj954kGWOaqzjaJj/GpEUTlmjz8Y3gESH/tL9LVyegptGnv
 MTTSJm+HHAaxfgHKWY0UqtalwyTD3Z5KiJ9sW64fmX6RVVZdYynmVLI97lxHDuriqY+cmJxIpbB
 J+Dg71JxpgiqBlxs+qhHj568SFiHfctCXfHR1KLtRX18MuMzoNMq/DHPPVAf04VEkhMWoKvDeWr
 FLpuev9tuQJJLA/UpKR1M5p52D+gyvHiyv9ldIWTlh8jHHM/cVZPcQ33DGN9rGBLoMKVcXn7bqZ
 IlffMEzqMjsUeCBh7JAThSJ/CgnQf/3lzsNq9LaLa7XzPHcX
X-Received: by 2002:a05:7022:f90d:b0:151:7831:e403 with SMTP id
 a92af1059eb24-1ac5b027fbfmr2873959c88.13.1793373355336; 
 Fri, 30 Oct 2026 08:15:55 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac1854d925sm12770449c88.7.2026.10.30.08.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:15:54 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>, Felipe Balbi <balbi@kernel.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, xen-devel@lists.xenproject.org,
 qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 qemu-ppc@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH 00/15] hw: expand DEFINE_MACHINE to explicit TypeInfo
 registration
Date: Fri, 30 Oct 2026 23:15:21 +0800
Message-ID: <20261030151539.1872-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DEFINE_MACHINE and DEFINE_MACHINE_EXTENDED hide the TypeInfo and the type_init
function that calls type_register_static(). A later change needs to pass a
target mask into that registration, and the macros have no parameter for it.
This series expands every caller first, with no behavior change, so the
follow-up only replaces the type_register_static() call.

Each machine file gains a class_init function, a TypeInfo, and a type_init
function that calls type_register_static(). The last patch removes
DEFINE_MACHINE* and DEFINE_SECURE_MACHINE* from include/hw/core/boards.h.

Yonggang Luo (15):
  hw/alpha: expand DEFINE_MACHINE in dp264.c
  hw/m68k: expand DEFINE_MACHINE for M68K machines
  hw/microblaze: expand DEFINE_MACHINE for MicroBlaze
  hw/tricore: expand DEFINE_MACHINE in tricore_testboard.c
  hw/arm: expand DEFINE_MACHINE for ARM machines
  hw/riscv: expand DEFINE_MACHINE for RISC-V machines
  hw/core/null-machine: expand DEFINE_MACHINE
  hw/mips: expand DEFINE_MACHINE for MIPS machines
  hw/ppc: expand DEFINE_MACHINE for PowerPC machines
  hw/sh4: expand DEFINE_MACHINE in r2d.c
  hw/sparc: expand DEFINE_MACHINE in leon3.c
  hw/xenpv: expand DEFINE_MACHINE in xen_machine_pv.c
  hw/xtensa: expand DEFINE_MACHINE in sim.c
  hw/xtensa: expand DEFINE_MACHINE in virt.c
  hw/core/boards: remove unused DEFINE_MACHINE* macros

 hw/alpha/dp264.c                    | 18 +++++++++--
 hw/arm/bananapi_m2u.c               | 18 +++++++++--
 hw/arm/cubieboard.c                 | 19 +++++++++---
 hw/arm/digic_boards.c               | 18 +++++++++--
 hw/arm/imx25_pdk.c                  | 18 +++++++++--
 hw/arm/imx8mm-evk.c                 | 20 +++++++++---
 hw/arm/integratorcp.c               | 14 ++++++---
 hw/arm/kzm.c                        | 18 +++++++++--
 hw/arm/max78000fthr.c               | 17 ++++++++--
 hw/arm/mcimx6ul-evk.c               | 18 +++++++++--
 hw/arm/mcimx7d-sabre.c              | 20 +++++++++---
 hw/arm/msf2-som.c                   | 17 ++++++++--
 hw/arm/netduino2.c                  | 17 ++++++++--
 hw/arm/netduinoplus2.c              | 17 ++++++++--
 hw/arm/olimex-stm32-h405.c          | 18 +++++++++--
 hw/arm/orangepi.c                   | 19 +++++++++---
 hw/arm/stm32vldiscovery.c           | 18 +++++++++--
 hw/core/null-machine.c              | 18 +++++++++--
 hw/m68k/an5206.c                    | 18 +++++++++--
 hw/m68k/mcf5208.c                   | 18 +++++++++--
 hw/microblaze/petalogix_ml605_mmu.c | 19 ++++++++++--
 hw/microblaze/xlnx-zynqmp-pmu.c     | 19 ++++++++++--
 hw/mips/boston.c                    | 18 +++++++++--
 hw/mips/fuloong2e.c                 | 18 +++++++++--
 hw/mips/malta.c                     | 12 ++++++--
 hw/ppc/amigaone.c                   | 18 +++++++++--
 hw/ppc/pegasos.c                    | 21 ++++++++-----
 hw/ppc/ppc440_bamboo.c              | 18 +++++++++--
 hw/ppc/prep.c                       | 18 +++++++++--
 hw/ppc/sam460ex.c                   | 18 +++++++++--
 hw/ppc/virtex_ml507.c               | 18 +++++++++--
 hw/riscv/boston-aia.c               | 18 +++++++++--
 hw/riscv/microblaze-v-generic.c     | 18 +++++++++--
 hw/sh4/r2d.c                        | 18 +++++++++--
 hw/sparc/leon3.c                    | 18 +++++++++--
 hw/tricore/tricore_testboard.c      | 18 +++++++++--
 hw/xenpv/xen_machine_pv.c           | 18 +++++++++--
 hw/xtensa/sim.c                     | 18 +++++++++--
 hw/xtensa/virt.c                    | 18 +++++++++--
 include/hw/core/boards.h            | 48 -----------------------------
 40 files changed, 605 insertions(+), 142 deletions(-)

-- 
2.55.0.windows.3


