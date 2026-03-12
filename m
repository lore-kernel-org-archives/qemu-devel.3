Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7422E106ACD3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 17:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0jkW-0003OO-LT; Thu, 12 Mar 2026 13:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0jkT-0003Nq-SP
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 13:23:01 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0jkQ-0004BZ-LJ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 13:23:01 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so8842435ad.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 10:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773336175; x=1773940975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FjFP2O/zsUPEaIJQtmE5s6LDLJbn95qWgCCqPtu4kc4=;
 b=T0dNp18yeBls/aNvR5+q4WH5cX9VFuwDkvETtZBhTvcWvRXOSfD2IItBD/vdvJKM6c
 ghjPHVMdjC1ok0EP+QBPA6x27kyccnwQ9MJjys+eCpFwbu9INQSLvqSkphbrX0Qg5QjL
 8AvfvxugG2CRM/4t9ry4pPopWaPIDIuseCJBk589kPKsh1fa0SNtUSd7WhLvRofLDWc5
 ZiXfLLRxNGCxNmZJ+YTcTc+1b8A4HT3N9qTHTyUYMDxeiOCa6gH/ejjMcm9RzS3rp1dd
 UuFUpGjASF2wIO8b6gxYHLEX0G/+zbzkY6mRbHSYlkAOwmG85S4PUKStFVbhie1mcNYN
 Ocgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773336175; x=1773940975;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjFP2O/zsUPEaIJQtmE5s6LDLJbn95qWgCCqPtu4kc4=;
 b=wEXxnRB90xPXl00wUphIMKAzwnBSs+2drcbir07jUeSQm7tdxZkGw43PmBP+lB5+E9
 1iirxJQfCWwpmFak/lh7e2DcrfdhP6yWPKv7y8fqrBMEXT8eLmWVCf8hlaiBDHYChy7+
 GCf58oidLgxOwKIAAbDG5+qE3ea97bJrVIHPmURiO3q12JQ65HHy0jlZ1y0GwSPIfRiq
 gfsvtwj0d+YLr8Jq2y1XqN/hQbc5L/qAp7FZjr9j+ZvQrHYrQSVCU50KcdxGaPFZdzRo
 O5xwjqy0EpMuuTvMJbzbzWyuVgb0ztPtD1jm2gX8tVycH+OFWNzteII7BdOwPMHQ7ilH
 E9Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqlkOjNA3z5lrDXo04Tc4zhYyqOnRJugOq8VW8FPoJxjxmjlBlVa8RrlhX9fq7n02cn7sYqMdYAk4K@nongnu.org
X-Gm-Message-State: AOJu0Yw0Owo/4mQk0KMsDkb8BlDxpGXxM45NSHBrgBP8X603rzWgxxsk
 ZPuYe4dERmYswGhvfD2aswPZ0xdKd78CYVW1qUkRdtDE5iXysavzBb/F4ncMYrKKCck=
X-Gm-Gg: ATEYQzy8Et8erkQ0YAPi9SBddaTHC5mlLawWsHnxykgbirjYvl4pkd+GTyuEbDwSMo4
 GyUCzj59USZif8byXdaNxtucfjy79l/dvo1SyDtsbJj5hZnbqcZUucdMTc/mEkXEAC6ux3hqToO
 mGMoa3ZNxfPjQMFn2CvQH6s4cSFsRnEOjZNjpeIw6TQ5O5z+4yxun2WzTZal4xhSfgaJiqngU7p
 LQsOlENuhpnM7lR7WQU/wHryrfqWJQyob7ZfFXJWCvBYWPdjGZTHeaKrgtQkf7tHT9QjuIfjs5m
 2s8Bfo/3HSjtnEqKedfWw2LXcCQcLTnFQOvoHuRLWtQ6rmxUgXQEQEp4RTfqaCMEzWA6YIcCR2F
 QB6CcRGKdVCidzzqgizltpXR3vgy7lg/oWrnFvYrIWBYMKS/BLSyiu49fDYne0S35BPPU2bKLc3
 bq+XITE3w7vPCMLcKcbZr7BsLnAiBTcjH2HR/Y20K8Cv908D3IN336vDAC5mrYVxA+YiNw
X-Received: by 2002:a17:903:94d:b0:2ae:483f:b23c with SMTP id
 d9443c01a7336-2aecaac1ec7mr2666085ad.36.1773336175172; 
 Thu, 12 Mar 2026 10:22:55 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aec3f53f8dsm20607575ad.79.2026.03.12.10.22.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 10:22:54 -0700 (PDT)
Message-ID: <f851308f-8928-401d-a8c1-5bc4f65f947f@linaro.org>
Date: Thu, 12 Mar 2026 10:22:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/16] gdbstub: Always infer base register index from
 GDB XML
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260310232045.58440-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260310232045.58440-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/10/26 4:20 PM, Philippe Mathieu-Daudé wrote:
> Generic fix for a latent bug reported by Florian:
> https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/
> 
> Use the 'regnum' XML tag for feature base register index
> (after fixing the incorrect m68k FPU ones).
> 
> Include patches from "gdbstub: Generate a single gdbstub-xml.c /
> gdb_static_features[]".
> 
> v3:
> - Correctly update @base_reg in gdb_register_coprocessor()
> v4:
> - Disable prot-note tests
> - Add gdb-multiarch to run gdbstub tests on CI
> 
> Alex Bennée (1):
>    tests/docker: add gdb-multiarch to all-test-cross
> 
> Philippe Mathieu-Daudé (15):
>    tests/tcg: Temporary disable multiarch tests for PPC targets
>    tests/tcg: Disable prot-none test on GitLab
>    target/i386/gdbstub: Remove stale comment
>    meson: Restrict gdbstub to user/system builds
>    gdbstub: Simplify gdb_init_cpu() logic
>    gdbstub: Add trace events for around XML parsing / generation
>    gdbstub: Have scripts/feature_to_c.py generate more verbose output
>    gdbstub: Make base register explicit in m68k GDB XML files
>    gdbstub: Remove @g_pos argument in gdb_register_coprocessor()
>    gdbstub: Emit base_register index in GDBFeature entries
>    gdbstub: Consider GDBFeature::base_reg in gdb_register_coprocessor()
>    tests/tcg: Re-enable disabled multiarch tests for PPC targets
>    gdbstub: Remove 'gdb-xml/' directory prefix in TARGET_XML_FILES
>    gdbstub: Move gdb-xml/ within gdbstub/
>    gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[]
> 
>   MAINTAINERS                                   | 19 +++++-----
>   docs/devel/codebase.rst                       |  2 -
>   configs/targets/aarch64-bsd-user.mak          |  2 +-
>   configs/targets/aarch64-linux-user.mak        |  2 +-
>   configs/targets/aarch64-softmmu.mak           |  2 +-
>   configs/targets/aarch64_be-linux-user.mak     |  2 +-
>   configs/targets/alpha-linux-user.mak          |  2 +-
>   configs/targets/alpha-softmmu.mak             |  2 +-
>   configs/targets/arm-bsd-user.mak              |  2 +-
>   configs/targets/arm-linux-user.mak            |  2 +-
>   configs/targets/arm-softmmu.mak               |  2 +-
>   configs/targets/armeb-linux-user.mak          |  2 +-
>   configs/targets/avr-softmmu.mak               |  2 +-
>   configs/targets/hexagon-linux-user.mak        |  2 +-
>   configs/targets/i386-bsd-user.mak             |  2 +-
>   configs/targets/i386-linux-user.mak           |  2 +-
>   configs/targets/i386-softmmu.mak              |  2 +-
>   configs/targets/loongarch64-linux-user.mak    |  2 +-
>   configs/targets/loongarch64-softmmu.mak       |  2 +-
>   configs/targets/m68k-linux-user.mak           |  2 +-
>   configs/targets/m68k-softmmu.mak              |  2 +-
>   configs/targets/microblaze-linux-user.mak     |  2 +-
>   configs/targets/microblaze-softmmu.mak        |  2 +-
>   configs/targets/microblazeel-linux-user.mak   |  2 +-
>   configs/targets/or1k-linux-user.mak           |  2 +-
>   configs/targets/or1k-softmmu.mak              |  2 +-
>   configs/targets/ppc-linux-user.mak            |  2 +-
>   configs/targets/ppc-softmmu.mak               |  2 +-
>   configs/targets/ppc64-linux-user.mak          |  2 +-
>   configs/targets/ppc64-softmmu.mak             |  2 +-
>   configs/targets/ppc64le-linux-user.mak        |  2 +-
>   configs/targets/riscv32-linux-user.mak        |  2 +-
>   configs/targets/riscv32-softmmu.mak           |  2 +-
>   configs/targets/riscv64-bsd-user.mak          |  2 +-
>   configs/targets/riscv64-linux-user.mak        |  2 +-
>   configs/targets/riscv64-softmmu.mak           |  2 +-
>   configs/targets/rx-softmmu.mak                |  2 +-
>   configs/targets/s390x-linux-user.mak          |  2 +-
>   configs/targets/s390x-softmmu.mak             |  2 +-
>   configs/targets/sparc-linux-user.mak          |  2 +-
>   configs/targets/sparc-softmmu.mak             |  2 +-
>   configs/targets/sparc32plus-linux-user.mak    |  2 +-
>   configs/targets/sparc64-linux-user.mak        |  2 +-
>   configs/targets/sparc64-softmmu.mak           |  2 +-
>   configs/targets/x86_64-bsd-user.mak           |  2 +-
>   configs/targets/x86_64-linux-user.mak         |  2 +-
>   configs/targets/x86_64-softmmu.mak            |  2 +-
>   meson.build                                   | 12 +-----
>   include/exec/gdbstub.h                        |  4 +-
>   stubs/gdbstub.c => gdbstub/gdb-xml-stub.c     |  0
>   gdbstub/gdbstub.c                             | 38 ++++++++++++-------
>   target/arm/gdbstub.c                          | 21 ++++------
>   target/arm/gdbstub64.c                        | 19 ++++------
>   target/hexagon/cpu.c                          |  2 +-
>   target/i386/gdbstub.c                         | 12 ++----
>   target/loongarch/gdbstub.c                    |  6 +--
>   target/m68k/helper.c                          |  4 +-
>   target/microblaze/cpu.c                       |  3 +-
>   target/ppc/gdbstub.c                          | 11 +++---
>   target/riscv/gdbstub.c                        | 18 +++------
>   target/s390x/gdbstub.c                        | 15 ++++----
>   target/sparc/gdbstub.c                        | 12 ++----
>   {gdb-xml => gdbstub/gdb-xml}/aarch64-core.xml |  0
>   {gdb-xml => gdbstub/gdb-xml}/aarch64-fpu.xml  |  0
>   {gdb-xml => gdbstub/gdb-xml}/aarch64-mte.xml  |  0
>   .../gdb-xml}/aarch64-pauth.xml                |  0
>   {gdb-xml => gdbstub/gdb-xml}/aarch64-sme2.xml |  0
>   {gdb-xml => gdbstub/gdb-xml}/alpha-core.xml   |  0
>   {gdb-xml => gdbstub/gdb-xml}/arm-core.xml     |  0
>   .../gdb-xml}/arm-m-profile-mve.xml            |  0
>   .../gdb-xml}/arm-m-profile.xml                |  0
>   {gdb-xml => gdbstub/gdb-xml}/arm-neon.xml     |  0
>   .../gdb-xml}/arm-vfp-sysregs.xml              |  0
>   {gdb-xml => gdbstub/gdb-xml}/arm-vfp.xml      |  0
>   {gdb-xml => gdbstub/gdb-xml}/arm-vfp3.xml     |  0
>   {gdb-xml => gdbstub/gdb-xml}/avr-cpu.xml      |  0
>   {gdb-xml => gdbstub/gdb-xml}/cf-core.xml      |  0
>   {gdb-xml => gdbstub/gdb-xml}/cf-fp.xml        |  2 +-
>   {gdb-xml => gdbstub/gdb-xml}/hexagon-core.xml |  0
>   {gdb-xml => gdbstub/gdb-xml}/hexagon-hvx.xml  |  0
>   .../gdb-xml}/i386-32bit-linux.xml             |  0
>   {gdb-xml => gdbstub/gdb-xml}/i386-32bit.xml   |  0
>   .../gdb-xml}/i386-64bit-apx.xml               |  0
>   .../gdb-xml}/i386-64bit-linux.xml             |  0
>   {gdb-xml => gdbstub/gdb-xml}/i386-64bit.xml   |  0
>   .../gdb-xml}/loongarch-base32.xml             |  0
>   .../gdb-xml}/loongarch-base64.xml             |  0
>   .../gdb-xml}/loongarch-fpu.xml                |  0
>   .../gdb-xml}/loongarch-lasx.xml               |  0
>   .../gdb-xml}/loongarch-lsx.xml                |  0
>   {gdb-xml => gdbstub/gdb-xml}/m68k-core.xml    |  0
>   {gdb-xml => gdbstub/gdb-xml}/m68k-fp.xml      |  2 +-
>   .../gdb-xml}/microblaze-core.xml              |  0
>   .../gdb-xml}/microblaze-stack-protect.xml     |  0
>   {gdb-xml => gdbstub/gdb-xml}/or1k-core.xml    |  0
>   .../gdb-xml}/power-altivec.xml                |  0
>   {gdb-xml => gdbstub/gdb-xml}/power-core.xml   |  0
>   {gdb-xml => gdbstub/gdb-xml}/power-fpu.xml    |  0
>   {gdb-xml => gdbstub/gdb-xml}/power-spe.xml    |  0
>   {gdb-xml => gdbstub/gdb-xml}/power-vsx.xml    |  0
>   {gdb-xml => gdbstub/gdb-xml}/power64-core.xml |  0
>   .../gdb-xml}/riscv-32bit-cpu.xml              |  0
>   .../gdb-xml}/riscv-32bit-fpu.xml              |  0
>   .../gdb-xml}/riscv-32bit-virtual.xml          |  0
>   .../gdb-xml}/riscv-64bit-cpu.xml              |  0
>   .../gdb-xml}/riscv-64bit-fpu.xml              |  0
>   .../gdb-xml}/riscv-64bit-virtual.xml          |  0
>   {gdb-xml => gdbstub/gdb-xml}/rx-core.xml      |  0
>   {gdb-xml => gdbstub/gdb-xml}/s390-acr.xml     |  0
>   {gdb-xml => gdbstub/gdb-xml}/s390-cr.xml      |  0
>   {gdb-xml => gdbstub/gdb-xml}/s390-fpr.xml     |  0
>   {gdb-xml => gdbstub/gdb-xml}/s390-gs.xml      |  0
>   .../gdb-xml}/s390-virt-kvm.xml                |  0
>   {gdb-xml => gdbstub/gdb-xml}/s390-virt.xml    |  0
>   {gdb-xml => gdbstub/gdb-xml}/s390-vx.xml      |  0
>   {gdb-xml => gdbstub/gdb-xml}/s390x-core64.xml |  0
>   {gdb-xml => gdbstub/gdb-xml}/sparc32-cp0.xml  |  0
>   {gdb-xml => gdbstub/gdb-xml}/sparc32-cpu.xml  |  0
>   {gdb-xml => gdbstub/gdb-xml}/sparc32-fpu.xml  |  0
>   {gdb-xml => gdbstub/gdb-xml}/sparc64-cp0.xml  |  0
>   {gdb-xml => gdbstub/gdb-xml}/sparc64-cpu.xml  |  0
>   {gdb-xml => gdbstub/gdb-xml}/sparc64-fpu.xml  |  0
>   gdbstub/meson.build                           | 23 +++++++++++
>   gdbstub/trace-events                          |  7 ++++
>   scripts/feature_to_c.py                       | 14 ++++---
>   stubs/meson.build                             |  2 -
>   .../dockerfiles/debian-all-test-cross.docker  |  1 +
>   tests/lcitool/refresh                         |  1 +
>   tests/tcg/multiarch/Makefile.target           |  5 +++
>   129 files changed, 177 insertions(+), 168 deletions(-)
>   rename stubs/gdbstub.c => gdbstub/gdb-xml-stub.c (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/aarch64-core.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/aarch64-fpu.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/aarch64-mte.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/aarch64-pauth.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/aarch64-sme2.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/alpha-core.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/arm-core.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/arm-m-profile-mve.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/arm-m-profile.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/arm-neon.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/arm-vfp-sysregs.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/arm-vfp.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/arm-vfp3.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/avr-cpu.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/cf-core.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/cf-fp.xml (93%)
>   rename {gdb-xml => gdbstub/gdb-xml}/hexagon-core.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/hexagon-hvx.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/i386-32bit-linux.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/i386-32bit.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/i386-64bit-apx.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/i386-64bit-linux.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/i386-64bit.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/loongarch-base32.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/loongarch-base64.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/loongarch-fpu.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/loongarch-lasx.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/loongarch-lsx.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/m68k-core.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/m68k-fp.xml (93%)
>   rename {gdb-xml => gdbstub/gdb-xml}/microblaze-core.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/microblaze-stack-protect.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/or1k-core.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/power-altivec.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/power-core.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/power-fpu.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/power-spe.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/power-vsx.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/power64-core.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-cpu.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-fpu.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-virtual.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-cpu.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-fpu.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-virtual.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/rx-core.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/s390-acr.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/s390-cr.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/s390-fpr.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/s390-gs.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/s390-virt-kvm.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/s390-virt.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/s390-vx.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/s390x-core64.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/sparc32-cp0.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/sparc32-cpu.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/sparc32-fpu.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/sparc64-cp0.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/sparc64-cpu.xml (100%)
>   rename {gdb-xml => gdbstub/gdb-xml}/sparc64-fpu.xml (100%)
> 

This was merged into master (769a37d8bd0c81c39128fc292352f01bad0769f4).

Regards,
Pierrick

