Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCC3EB107C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzOs-0002ba-A9; Tue, 10 Mar 2026 11:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzOq-0002ZL-BZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:53:36 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzOn-0005Vn-Rc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:53:36 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439c5b40f60so5852640f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773158012; x=1773762812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jBMSeytCbvEMl6e2nE5hy6HPjkCh4SeHurkcltJ1jD8=;
 b=ffy+ziJ4Z/rKJQJoYes35XUIdNNJE4fOk4F1gmdOAK1U2FL35fOreFGzbGUPStkskc
 sspoh7tJtD/pMfN1ODdY/QO07G0FCWq3Yis5qzlH1/NTRK+l4K96lpgRgNOK50Ctm7eP
 MfAdT+S1ZehgtecCv1I6sZkjtxlLy0t8bJ7V/2WGa2N1VAtHZKHZb6OszJfrfp2S30Ni
 3Fz54atOCM4Kyf/nDlXQIKOZ0xS8JAcC3rz5ePJQ5DOXIbK9jEQHyXXktVqNnBTsh+7F
 +g3hlDAtdhoIAG5g8pbCfcidnPeHEmmDTPrQdjywN+1mX3oNkngIJhjnmxzj9ElSgEDg
 +seQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158012; x=1773762812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBMSeytCbvEMl6e2nE5hy6HPjkCh4SeHurkcltJ1jD8=;
 b=iLp369d+R1iTSdSUiT0+TRyL+RhwSH9Zm9cPphJhIna/BgkfXl1tuyW+HwmAS4pjFD
 65WtNXT4KSMBMBHeJv0+sLYv2P4mMKiQUMiig2J8Bk94R8//ZBiavPaSO8DktMoSZfkC
 KqSC9FZFI2VaFyqbfcwsUhE7s2dBcwiDtvTCSNqkjNQDUlQYoe92XELKK2rbMVfJDicN
 Qymw3Aws8xK9yS6a4VEVe0b7og0JN8E6/CwOhEt0G/9yjtQUh7hl6YUdWyyNdgoDioGh
 fpft3uEmRoJie75yYxyk5CST/9qI6Gze8jpfR0hj6Wtw+9DYtx6y8B5/MDvPnOVgl18q
 RtuA==
X-Gm-Message-State: AOJu0YwjsnZp1DExP8iIsw1Zsma/bdjNaoCLXTrCxmY2G3BFtPMqDqJT
 SOKnDhflfj0CkSzFsaJQiG5qtLlFvfpoeQAolc2pxGO7otWt3kLkI51dD9kOE7EZtK4Rli0C32f
 0jF/jzq4=
X-Gm-Gg: ATEYQzwWyZeopbNyh3n4yovPneoxd8kD25jFVETQPqUZ1zBafC6YHurrX9Yqe0nq4CI
 bPjXAI8RMndJjYwFwKg5DKrVbBxYNPgu0yQGDZDEwKDT+xyw7FlgcYXiTWPgG69UJ+yoj9Ybl5m
 GjYT8qwDmYR3999KMnHi0hTETOIdi/DVMfmgwkm+3KwsXBwW/HvtwW/u2FmBaay933+1rbhKq5H
 p4ltSbEhFIK5qjRC44uOi10iIWJSu8ijuKR9ifkWaw36wsvNPsA082ScM0mChAdKH/irRHqJgRk
 w3i5uyruT71TOk5UmLXoQgXYU4kD+wK2cFOcgOEZJ1tFzK9tF55Jn/XDW7UPeGwji7WhZ/Y6GoU
 u5kHGkQK3plZbrXbvngYXLa7oTGth00YgFfyos0jWCSIcs7f6NXsd3mau8KbjWdqWlHlkT1FbvB
 kLWPbKkyvPgYS7bM5AebLCDoam2gl+RKZDIcQt8iVxv7xuKa3J9jNFyOJE/LiZB8TIYWOckm7H
X-Received: by 2002:a5d:64e7:0:b0:439:d769:ec56 with SMTP id
 ffacd0b85a97d-439da107fb2mr26442414f8f.0.1773158011659; 
 Tue, 10 Mar 2026 08:53:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae35cf7sm34835195f8f.26.2026.03.10.08.53.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 08:53:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
Subject: [PATCH v2 00/13] gdbstub: Always infer base register index from GDB
 XML
Date: Tue, 10 Mar 2026 16:53:16 +0100
Message-ID: <20260310155329.48772-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Generic fix for a latent bug reported by Florian:
https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/

Use the 'regnum' XML tag for feature base register index
(after fixing the incorrect m68k FPU ones).

Include patches from "gdbstub: Generate a single gdbstub-xml.c /
gdb_static_features[]".

Philippe Mathieu-Daudé (13):
  meson: Restrict gdbstub to user/system builds
  target/i386/gdbstub: Remove stale comment
  gdbstub: Simplify gdb_init_cpu() logic
  gdbstub: Add trace events for around XML parsing / generation
  gdbstub: Have scripts/feature_to_c.py generate more verbose output
  gdbstub: Make base register explicit in m68k GDB XML files
  gdbstub: Remove @g_pos argument in gdb_register_coprocessor()
  gdbstub: Emit base_register index in GDBFeature entries
  gdbstub: Use GDBFeature::base_reg in gdb_register_feature()
  gdbstub: Remove GDBRegisterState::base_reg
  gdbstub: Remove 'gdb-xml/' directory prefix in TARGET_XML_FILES
  gdbstub: Move gdb-xml/ within gdbstub/
  gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[]

 MAINTAINERS                                   | 19 +++---
 docs/devel/codebase.rst                       |  2 -
 configs/targets/aarch64-bsd-user.mak          |  2 +-
 configs/targets/aarch64-linux-user.mak        |  2 +-
 configs/targets/aarch64-softmmu.mak           |  2 +-
 configs/targets/aarch64_be-linux-user.mak     |  2 +-
 configs/targets/alpha-linux-user.mak          |  2 +-
 configs/targets/alpha-softmmu.mak             |  2 +-
 configs/targets/arm-bsd-user.mak              |  2 +-
 configs/targets/arm-linux-user.mak            |  2 +-
 configs/targets/arm-softmmu.mak               |  2 +-
 configs/targets/armeb-linux-user.mak          |  2 +-
 configs/targets/avr-softmmu.mak               |  2 +-
 configs/targets/hexagon-linux-user.mak        |  2 +-
 configs/targets/i386-bsd-user.mak             |  2 +-
 configs/targets/i386-linux-user.mak           |  2 +-
 configs/targets/i386-softmmu.mak              |  2 +-
 configs/targets/loongarch64-linux-user.mak    |  2 +-
 configs/targets/loongarch64-softmmu.mak       |  2 +-
 configs/targets/m68k-linux-user.mak           |  2 +-
 configs/targets/m68k-softmmu.mak              |  2 +-
 configs/targets/microblaze-linux-user.mak     |  2 +-
 configs/targets/microblaze-softmmu.mak        |  2 +-
 configs/targets/microblazeel-linux-user.mak   |  2 +-
 configs/targets/or1k-linux-user.mak           |  2 +-
 configs/targets/or1k-softmmu.mak              |  2 +-
 configs/targets/ppc-linux-user.mak            |  2 +-
 configs/targets/ppc-softmmu.mak               |  2 +-
 configs/targets/ppc64-linux-user.mak          |  2 +-
 configs/targets/ppc64-softmmu.mak             |  2 +-
 configs/targets/ppc64le-linux-user.mak        |  2 +-
 configs/targets/riscv32-linux-user.mak        |  2 +-
 configs/targets/riscv32-softmmu.mak           |  2 +-
 configs/targets/riscv64-bsd-user.mak          |  2 +-
 configs/targets/riscv64-linux-user.mak        |  2 +-
 configs/targets/riscv64-softmmu.mak           |  2 +-
 configs/targets/rx-softmmu.mak                |  2 +-
 configs/targets/s390x-linux-user.mak          |  2 +-
 configs/targets/s390x-softmmu.mak             |  2 +-
 configs/targets/sparc-linux-user.mak          |  2 +-
 configs/targets/sparc-softmmu.mak             |  2 +-
 configs/targets/sparc32plus-linux-user.mak    |  2 +-
 configs/targets/sparc64-linux-user.mak        |  2 +-
 configs/targets/sparc64-softmmu.mak           |  2 +-
 configs/targets/x86_64-bsd-user.mak           |  2 +-
 configs/targets/x86_64-linux-user.mak         |  2 +-
 configs/targets/x86_64-softmmu.mak            |  2 +-
 meson.build                                   | 12 +---
 include/exec/gdbstub.h                        |  4 +-
 stubs/gdbstub.c => gdbstub/gdb-xml-stub.c     |  0
 gdbstub/gdbstub.c                             | 61 +++++++++++--------
 target/arm/gdbstub.c                          | 21 +++----
 target/arm/gdbstub64.c                        | 19 +++---
 target/hexagon/cpu.c                          |  2 +-
 target/i386/gdbstub.c                         | 12 ++--
 target/loongarch/gdbstub.c                    |  6 +-
 target/m68k/helper.c                          |  4 +-
 target/microblaze/cpu.c                       |  3 +-
 target/ppc/gdbstub.c                          | 11 ++--
 target/riscv/gdbstub.c                        | 18 ++----
 target/s390x/gdbstub.c                        | 15 +++--
 target/sparc/gdbstub.c                        | 12 ++--
 {gdb-xml => gdbstub/gdb-xml}/aarch64-core.xml |  0
 {gdb-xml => gdbstub/gdb-xml}/aarch64-fpu.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/aarch64-mte.xml  |  0
 .../gdb-xml}/aarch64-pauth.xml                |  0
 {gdb-xml => gdbstub/gdb-xml}/aarch64-sme2.xml |  0
 {gdb-xml => gdbstub/gdb-xml}/alpha-core.xml   |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-core.xml     |  0
 .../gdb-xml}/arm-m-profile-mve.xml            |  0
 .../gdb-xml}/arm-m-profile.xml                |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-neon.xml     |  0
 .../gdb-xml}/arm-vfp-sysregs.xml              |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-vfp.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-vfp3.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/avr-cpu.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/cf-core.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/cf-fp.xml        |  2 +-
 {gdb-xml => gdbstub/gdb-xml}/hexagon-core.xml |  0
 {gdb-xml => gdbstub/gdb-xml}/hexagon-hvx.xml  |  0
 .../gdb-xml}/i386-32bit-linux.xml             |  0
 {gdb-xml => gdbstub/gdb-xml}/i386-32bit.xml   |  0
 .../gdb-xml}/i386-64bit-apx.xml               |  0
 .../gdb-xml}/i386-64bit-linux.xml             |  0
 {gdb-xml => gdbstub/gdb-xml}/i386-64bit.xml   |  0
 .../gdb-xml}/loongarch-base32.xml             |  0
 .../gdb-xml}/loongarch-base64.xml             |  0
 .../gdb-xml}/loongarch-fpu.xml                |  0
 .../gdb-xml}/loongarch-lasx.xml               |  0
 .../gdb-xml}/loongarch-lsx.xml                |  0
 {gdb-xml => gdbstub/gdb-xml}/m68k-core.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/m68k-fp.xml      |  2 +-
 .../gdb-xml}/microblaze-core.xml              |  0
 .../gdb-xml}/microblaze-stack-protect.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/or1k-core.xml    |  0
 .../gdb-xml}/power-altivec.xml                |  0
 {gdb-xml => gdbstub/gdb-xml}/power-core.xml   |  0
 {gdb-xml => gdbstub/gdb-xml}/power-fpu.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/power-spe.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/power-vsx.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/power64-core.xml |  0
 .../gdb-xml}/riscv-32bit-cpu.xml              |  0
 .../gdb-xml}/riscv-32bit-fpu.xml              |  0
 .../gdb-xml}/riscv-32bit-virtual.xml          |  0
 .../gdb-xml}/riscv-64bit-cpu.xml              |  0
 .../gdb-xml}/riscv-64bit-fpu.xml              |  0
 .../gdb-xml}/riscv-64bit-virtual.xml          |  0
 {gdb-xml => gdbstub/gdb-xml}/rx-core.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-acr.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-cr.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-fpr.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-gs.xml      |  0
 .../gdb-xml}/s390-virt-kvm.xml                |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-virt.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-vx.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/s390x-core64.xml |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc32-cp0.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc32-cpu.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc32-fpu.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc64-cp0.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc64-cpu.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc64-fpu.xml  |  0
 gdbstub/meson.build                           | 23 +++++++
 gdbstub/trace-events                          |  6 ++
 scripts/feature_to_c.py                       | 14 +++--
 stubs/meson.build                             |  2 -
 126 files changed, 179 insertions(+), 181 deletions(-)
 rename stubs/gdbstub.c => gdbstub/gdb-xml-stub.c (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-mte.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-pauth.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-sme2.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/alpha-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-m-profile-mve.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-m-profile.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-neon.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-vfp-sysregs.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-vfp.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-vfp3.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/avr-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/cf-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/cf-fp.xml (93%)
 rename {gdb-xml => gdbstub/gdb-xml}/hexagon-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/hexagon-hvx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-32bit-linux.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-32bit.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-64bit-apx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-64bit-linux.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-64bit.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-base32.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-base64.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-lasx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-lsx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/m68k-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/m68k-fp.xml (93%)
 rename {gdb-xml => gdbstub/gdb-xml}/microblaze-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/microblaze-stack-protect.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/or1k-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-altivec.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-spe.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-vsx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power64-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-virtual.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-virtual.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/rx-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-acr.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-cr.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-fpr.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-gs.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-virt-kvm.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-virt.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-vx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390x-core64.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc32-cp0.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc32-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc32-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc64-cp0.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc64-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc64-fpu.xml (100%)

-- 
2.53.0


