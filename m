Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A1DFD88CE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06Nk-0000a7-C1; Tue, 10 Mar 2026 19:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06Ng-0000Zs-33
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:20:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06Nd-0008EF-Ie
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:20:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852fdb36a8so42558695e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184847; x=1773789647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5g/FeXZUDgVhqVd2S+hP2e5WaTTBdNua5vIYuBxxiso=;
 b=jAkQI3cxgaURsbGu4p15XB6xzJ+YJcWLveQoLq0ZdkCkm8NUmbaVSqahn4s5qBRcSI
 Bvd7/TbXMeq+bqchcohJYUOSST80SG8t53n+f2QYdLGxLN9cYDdQv63swdpovivhSfl2
 iAqZnA4E5duC0jp3GN+NUq250yF6wJkiNqMSaFkiO00QXEAgnqeYzPlze/Fjbdz52rEP
 stdYaZhNXKxcgMix/TDoRYyLKefO7c8Ngp0+u5ItgRhd9ft8NIuMx0F9Zb2Z+LExjQHK
 7xkz99kAFPaNRHw5o2Fk5QoMpIwlOK+ZhW53YrjCwpmgg6jYHwh+fNYAAe/kMFM04oNI
 7KWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184847; x=1773789647;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5g/FeXZUDgVhqVd2S+hP2e5WaTTBdNua5vIYuBxxiso=;
 b=tdy6KiVZH3eUn24KUFrzjNLE0mdLvi8mI25+Uk5F6uw7Yn0F4kfi4i94cuLwcxSPqO
 zoIcRUvF3BSi/Kwr1AwDxwOdPH0JgJKZ9PVC68zFtJUx2NJyjCZsa/YNVs4b0F6/CvgB
 wmcVai+0cvM/pa4kdmTpJFULWEsYGZeAhne+Y25nxQCBjHAB19osIUOcESYaSRhYaHhG
 G5bjdlVw5tGdvT1KOiLeN9hhDIsu3zc4R3CwlvcJgPc6eXF9JsynjZPbGB2Q9i4qvVEN
 KcmSH7VfGFYBNWxVDpKunmdRZce7aOOt7PaqVCbucSbNN571tb5EXMUhzIvxOqKJh0tG
 3sqg==
X-Gm-Message-State: AOJu0YwiDM1UEVLZzSYZRE16z4uA91qSejIQdZqoAX/WWFfDyds7wqNv
 FzuCMnHVjUhMIJTZWcnycM6RYl0UQPII5DLl8RDTaibmLY48qiMxcLxqUxOUDFi2sgStDjtxRfa
 QN/wrHCA=
X-Gm-Gg: ATEYQzyaI5k8R4dywD1ZV8AFWID55HBA7y31oV88/WxauT143ViXCHAxfmYJr+NgOZA
 MO04tSZcx/F6HXx3+vQ/xJZfwHHCZ7y4QSbXQtIYTpmuv9XanC6AIlDREjbMV//3H2Ow9pB8+mM
 ZQGEW2xBxl8DyyVdWdQ7cbeafoe6rKfLtCfNvLI+pSchLsfdsYy7ALocEMWIV/pcGZI59MiaJou
 BmvHH17UKj7wdxm/XAtK/s5p/W9uHF/Cs+lJFzTnd72GI5TyGO78ytuX8jHk5fyQBffiaEtSQIi
 prnx5+WdMEmXj/5Xj03FNYYjZWEqYCOuRbkVFPOaytQEgxk+/5GjR3gjxbXrCBT0AdcudNyqOjM
 /3juCnV43I3RfsACoZ2zZSOv/zIhR5kCChv6fSgHMfeCk17OVYdJl+RXiXLYGWlhS+9Bo/jpSs3
 OPDZO95/bUCWzvVq8l34AVuber+94lUaj9sIteHj6VUkZotG4BrumejmxcUjtZslLGVdalWZZ4
X-Received: by 2002:a05:600c:3551:b0:485:3f1c:d8a4 with SMTP id
 5b1f17b1804b1-4854b0d6c1amr8383865e9.9.1773184847073; 
 Tue, 10 Mar 2026 16:20:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0dc76csm3365535e9.24.2026.03.10.16.20.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 16:20:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 00/16] gdbstub: Always infer base register index from GDB
 XML
Date: Wed, 11 Mar 2026 00:20:28 +0100
Message-ID: <20260310232045.58440-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Generic fix for a latent bug reported by Florian:
https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/

Use the 'regnum' XML tag for feature base register index
(after fixing the incorrect m68k FPU ones).

Include patches from "gdbstub: Generate a single gdbstub-xml.c /
gdb_static_features[]".

v3:
- Correctly update @base_reg in gdb_register_coprocessor()
v4:
- Disable prot-note tests
- Add gdb-multiarch to run gdbstub tests on CI

Alex Bennée (1):
  tests/docker: add gdb-multiarch to all-test-cross

Philippe Mathieu-Daudé (15):
  tests/tcg: Temporary disable multiarch tests for PPC targets
  tests/tcg: Disable prot-none test on GitLab
  target/i386/gdbstub: Remove stale comment
  meson: Restrict gdbstub to user/system builds
  gdbstub: Simplify gdb_init_cpu() logic
  gdbstub: Add trace events for around XML parsing / generation
  gdbstub: Have scripts/feature_to_c.py generate more verbose output
  gdbstub: Make base register explicit in m68k GDB XML files
  gdbstub: Remove @g_pos argument in gdb_register_coprocessor()
  gdbstub: Emit base_register index in GDBFeature entries
  gdbstub: Consider GDBFeature::base_reg in gdb_register_coprocessor()
  tests/tcg: Re-enable disabled multiarch tests for PPC targets
  gdbstub: Remove 'gdb-xml/' directory prefix in TARGET_XML_FILES
  gdbstub: Move gdb-xml/ within gdbstub/
  gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[]

 MAINTAINERS                                   | 19 +++++-----
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
 meson.build                                   | 12 +-----
 include/exec/gdbstub.h                        |  4 +-
 stubs/gdbstub.c => gdbstub/gdb-xml-stub.c     |  0
 gdbstub/gdbstub.c                             | 38 ++++++++++++-------
 target/arm/gdbstub.c                          | 21 ++++------
 target/arm/gdbstub64.c                        | 19 ++++------
 target/hexagon/cpu.c                          |  2 +-
 target/i386/gdbstub.c                         | 12 ++----
 target/loongarch/gdbstub.c                    |  6 +--
 target/m68k/helper.c                          |  4 +-
 target/microblaze/cpu.c                       |  3 +-
 target/ppc/gdbstub.c                          | 11 +++---
 target/riscv/gdbstub.c                        | 18 +++------
 target/s390x/gdbstub.c                        | 15 ++++----
 target/sparc/gdbstub.c                        | 12 ++----
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
 gdbstub/meson.build                           | 23 +++++++++++
 gdbstub/trace-events                          |  7 ++++
 scripts/feature_to_c.py                       | 14 ++++---
 stubs/meson.build                             |  2 -
 .../dockerfiles/debian-all-test-cross.docker  |  1 +
 tests/lcitool/refresh                         |  1 +
 tests/tcg/multiarch/Makefile.target           |  5 +++
 129 files changed, 177 insertions(+), 168 deletions(-)
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


