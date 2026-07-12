Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496DBC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 11:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wis8y-00058Q-D2; Sun, 12 Jul 2026 07:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wis8u-000578-NI
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 07:14:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wis8n-00020X-5z
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 07:14:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493f25d47dcso17132055e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 04:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783854870; x=1784459670; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=txB549w4KR0PpzC0YxNe3SwaUOSzTzvBdT8zykEgehg=;
 b=s4zviEqOUbKtHEuHbtclD9C+Lj6i2uo6ATkMxFpNOPFV4G0+nQawiEs9Gz9I/as8SB
 CX7QWRjzwyUjKDS7YQHFkJ+5DqMxEP/eLg1kZlIcEDnn6jCcK8l6Hi8LSHvN/eCzi2dL
 1dZi276s5UEXdxvbO3lsTEgPueyMuUQlZlYOMGIXKPr3Xog5PU8dYR1H1W6JAU7YMEpT
 hI7ZzE+FlbEjKX0Dk/5adQ4hfYzeE0zvjYPDxkU8FUf3htZvTh6zFLtxfhixHJY77W3O
 KC0hMCjkb6WGEm90F5NKfivzaMm7yxXGK++cCH5CFGAlx+cjp3Ie3nEoqA6CH+XGA5P4
 XFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783854870; x=1784459670;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=txB549w4KR0PpzC0YxNe3SwaUOSzTzvBdT8zykEgehg=;
 b=mbzkOgZHdZEQ/uUg2vOKgi+igeh4qTtGYsq3HYCgaB/xP493Eu8f78oVWgt+xNa6bt
 uqV3X5ii00YLfEATZSa4WLIq3nkj5vF9/Blf/405PkmnGGBNhnhMOptaCmX4obgALQj+
 H/oqkT2da6HSQSCGhbkKEmmoWN+MJMcfINym4OBCj327gGMp88lIsRbPyZkxEIgclO0f
 BlqPuNy4YzpMmjsYCGSCWhbrfEcfiBwr+kl3eKqPLS9+MKkCYYixMZHDSRYLB2N9w5f/
 8npQVMNPwuY3awRTF2MyfrcYwvLf0oAbr19GysrW0fVUGk8cyUrCPWsl7J09nkWqSrZL
 aABQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDbWmb0Oaxx/o82IRB7A9o7AT+X3t/k+ijFnhfdlaSRjVlAB1NuIRtPTF+V/3aTSiOsOA0p7aVMBKb@nongnu.org
X-Gm-Message-State: AOJu0Yx2Akj5IaE1VURYBjmHPP+E66jyxkUEHCm8FEDhVMFE/oCMCIRt
 ERI8TvzBpdCpYQIwSZn5Hln1XUFJVN5kSmHLzIp/olHhbYrqs/G7Pm3a
X-Gm-Gg: AfdE7cnzxw7EuGsGfqFYV7/m2CHbcZLKJgOQ19Hj0j6As7WtoWKvxxHCpTnvE4+sQbq
 Riju3Ghci7c8j4EHMocLmfSnwOv7uvH5qLGsMVIuDO3Yteac3n8srEFTBzAUUuZ8I++s4Lt+tZ5
 I8eDBazyZZbKOQ0zPrF0sZki0ulh+DuhnW6nCHaStr/rrtwYhLbBhwFUuHwyB5HieJUw7pvcsVm
 6HLqpocSHGs2OHOsARgUMunSLTZsZyQCk9YkIoOUaf+UiuB5oHFgweWgSYMvfvzmLMauC89OrRs
 kRLP/5Ofnr+vqC4LgcJKEPsH0jLsFAbHA3dJGlzHDhVoUTogpv3WTUSqVr2cfMLmW/JyiFvhEOV
 eTCHX7I/Nk6Xe8ig1ldR1prig467PV1Fs3yMyVlHNyK8csHs7DfD+aWzKYKkwp79QqHF3L8mXv2
 gpbO7hRW1YSibxK2+B87XMP1xvIYZ9FQmmw5m17d95lhvbmYk=
X-Received: by 2002:a05:600c:1d0e:b0:492:68bc:3237 with SMTP id
 5b1f17b1804b1-493f88333c0mr51860835e9.32.1783854869333; 
 Sun, 12 Jul 2026 04:14:29 -0700 (PDT)
Received: from ehlo.thunderbird.net (p5b3df423.dip0.t-ipconnect.de.
 [91.61.244.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2a38b19sm146581545e9.0.2026.07.12.04.14.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jul 2026 04:14:28 -0700 (PDT)
Date: Sun, 12 Jul 2026 10:56:24 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
CC: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Aditya Gupta <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Farhan Ali <alifm@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Felipe Balbi <balbi@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?ISO-8859-1?Q?Cl=E9ment_Chigot?= <chigot@adacore.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Jan Kiszka <jan.kiszka@web.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Jared Rossi <jrossi@linux.ibm.com>,
 Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad <konrad.frederic@yahoo.fr>, 
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Samuel Tardieu <sam@rfc1149.net>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Ran Wang <wangran@bosc.ac.cn>,
 Hao Wu <wuhaotsh@google.com>,
 =?ISO-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_000/134=5D_qom=3A_Make_c?=
 =?US-ASCII?Q?omposition-tree_parenting_mandatory?=
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
Message-ID: <B1CF8FC2-114E-4B1C-9F45-3A41F60505A5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 11=2E Juli 2026 22:34:53 UTC schrieb Alexander Graf <graf@amazon=2Ecom>=
:
>
>Motivation
>----------
>Markus observed [1] that a device reaching realize without a
>composition-tree parent is a modeling bug, and that the
>/machine/unattached container that catches such devices today is a
>bug attractor rather than a safety net: it hides the fact that nobody
>decided "what is part of what", and it gives the object an unstable,
>implementation-defined QOM path that is useless for qom-get/qom-set and
>for management tools that want to address board-created devices=2E
>
>This series makes composition-tree parenting mandatory=2E  After it,
>device_set_realized() errors on a device with no parent,
>memory_region_do_init() asserts that a named region has an owner,
>qdev_connect_gpio_out_named() asserts that the pin being wired has a
>parent, and /machine/unattached is deleted=2E  Every board-created object
>has a stable, human-chosen path=2E

Hi Alex,

Thanks for the cleanup! I hope the series will eventually find its way int=
o the codebase=2E

>
>[1] https://lore=2Ekernel=2Eorg/qemu-devel/87jyr3w9tc=2Efsf@pond=2Esub=2E=
org/
>
>Approach
>--------
>Rather than add a parallel "parented" API and migrate callers over
>years, each creation helper is converted in a single rename->reintroduce
>pair: a tree-wide Coccinelle rename of foo() to foo_orphan(), followed
>immediately by a patch that reintroduces foo() with a leading
>(Object *parent, const char *id, =2E=2E=2E) signature=2E

Perhaps I'd have appended the two parameters at the end=2E This way, the m=
ost interesting parameters, especially the type, stand out most, helping me=
 mentally "parse" the code more easily=2E But maybe this is just me, so thi=
s comment shall be no blocker=2E

>The tree builds after
>every patch and never carries two spellings of the same helper=2E
>
>The bulk of the series then converts *_orphan() call sites to the
>parented form, one hw/ subdirectory per patch=2E  Most of those commits
>carry a per-callsite table in the commit message giving the chosen
>parent expression, the chosen child name, and the one-line reason
>("board init -> machine", "realize of X -> X", =2E=2E=2E); the smaller on=
es
>carry a prose summary of the same=2E  Those tables are the substance the
>RFC is asking maintainers to review: the mechanical part is trivial,
>the modeling decisions are not=2E
>
>Some hw/arm commit messages carry wide per-callsite tables that exceed
>76 columns; please view with a fixed-width, non-wrapping mail reader=2E
>
>Once no *_orphan() callers remain the _orphan variants are deleted, the
>enforcement checks are armed, and /machine/unattached is removed=2E
>
>Series shape
>------------
>  001-009   core API: object_new_child(); rename->reintroduce for
>            qdev_new, sysbus_create_*, pci_new*, isa_new*,
>            i2c_slave_*, ssi/usb/sd/adb/virtio/hda/aux/spapr-vio,
>            cpu_create
>  010-082   hw/*: convert *_orphan() call sites to the parented form,
>            one subdirectory per patch, each with a per-callsite
>            reasoning table (or prose summary) in the commit message
>  083-088   delete the qdev/sysbus/pci/isa/i2c/ssi/usb/cpu *_orphan()
>            creator variants
>  089-107   memory: give the remaining owner=3D=3DNULL memory regions an
>            owner, then assert on owner=3D=3DNULL for named regions
>  108-116   irq: rename->reintroduce qemu_allocate_irq*() with an
>            owner and name; convert callers; delete _orphan variants
>  117-130   parent the remaining non-device singletons and per-device
>            helper objects (main-system-bus, accel, reset container,
>            per-MR helpers, per-devfn IOMMU objects, board-created
>            CPUs, =2E=2E=2E)
>  131-132   arm the enforcement checks and delete /machine/unattached
>  133-134   docs/devel/qom=2Erst: parenting contract; MAINTAINERS
>
>The Coccinelle scripts used for the rename steps are included under
>scripts/coccinelle/qom-parent/ and referenced from the corresponding
>commit messages=2E
>
>Not converted in this series
>----------------------------
>A handful of long-lived objects are deliberately left path-less for
>now, each for a specific lifecycle reason called out in the relevant
>commit message:
>
>  * TYPE_MIGRATION is a TYPE_DEVICE that is never realized, per the
>    upstream comment "TODO make this TYPE_OBJECT once QOM provides
>    -global for objects"=2E  Parenting it under /machine trips the
>    qdev_assert_realized_properly() walk=2E  It can move under /machine
>    once it becomes a plain TYPE_OBJECT=2E
>  * RamDiscardManager is unref'd from memory_region_finalize() itself,
>    so making it a child<> of the MR would use-after-free during MR
>    teardown=2E
>  * TPM backends and VFIO IOMMU containers are user-configurable and
>    dynamically created; they belong under /objects/<id> or a
>    dedicated /machine/vfio container respectively, and are best
>    handled in a follow-up on top of this series=2E
>  * QIOChannel* and per-mapping virtio-shmem objects remain path-less
>    by design (transient, refcounted, no stable identity)=2E
>
>Verification
>------------
>  * The tree builds for 20 softmmu targets after every patch=2E
>  * Every machine type across those targets was smoke-tested with
>    "-M <machine> -S"; none abort on the new assertions=2E
>  * "info qom-tree" on q35 and on aarch64 virt shows no
>    /machine/unattached node after the final patch=2E
>  * grep -r 'machine_get_container("unattached")' returns no hits=2E
>
>AI-assistance disclosure (docs/devel/code-provenance=2Erst)

This series seems to affect migration=2E For example, it gives the "ocram"=
 memory region in various imx devices a parent which has been identified as=
 migration breaking before [1]=2E Migration isn't an issue for imx devices,=
 so no objection there=2E

How shall we deal with machines where we do care about migration compatibi=
lity? Or was migration always broken there due to unstable QOM paths, and s=
o far we were just lucky?


Best regards,
Bernhard

[1] https://lore=2Ekernel=2Eorg/qemu-devel/CAFEAcA9cfiDB3+=3DK+MsHptujVhcP=
exwaf+1y8kHaV692ORAdgQ@mail=2Egmail=2Ecom/


>----------------------------------------------------------
>Every patch in this series was produced with AI assistance and
>reviewed by the human submitter=2E  Each commit carries an
>
>    Assisted-by: Kiro
>
>trailer following the format documented in the Linux kernel's
>Documentation/process/coding-assistants=2Erst=2E  The tree-wide rename
>patches are Coccinelle-equivalent mechanical transforms; the
>per-callsite parent/name choices in the hw/* commits are the
>AI-assisted modeling decisions this RFC is asking maintainers to
>review=2E
>
>QEMU's current policy in docs/devel/code-provenance=2Erst is to decline
>AI-generated contributions absent an explicit exception=2E  This RFC is
>therefore posted to open that discussion: I am requesting an exception
>for this series (or, if the community prefers, will reauthor the parts
>the policy requires) and will not post a non-RFC v1 until that is
>resolved on qemu-devel=2E  The Signed-off-by DCO certification is mine
>as the human reviewer taking full responsibility for the contribution=2E
>
>
>Alexander Graf (134):
>  qom: Introduce object_new_child()
>  qdev: Rename qdev_new()/qdev_try_new() to *_orphan()
>  qdev: Reintroduce qdev_new() with a mandatory QOM parent
>  sysbus: Make sysbus_create_simple()/_varargs() take a QOM parent
>  pci: Make pci_new*()/pci_create_simple*() take a QOM parent
>  isa: Make isa_new()/isa_try_new()/isa_create_simple() take a QOM
>    parent
>  i2c: Make i2c_slave_new()/i2c_slave_create_simple() take a QOM parent
>  ssi, usb: Make bus-layer creators take a QOM parent
>  cpu: Make cpu_create() take a QOM parent
>  hw/avr: Give onboard devices a QOM parent
>  hw/tricore: Give onboard devices a QOM parent
>  hw/xtensa: Give onboard devices a QOM parent
>  hw/alpha: Give onboard devices a QOM parent
>  hw/nitro: Give onboard devices a QOM parent
>  hw/vmapple: Give onboard devices a QOM parent
>  hw/hppa: Give onboard devices a QOM parent
>  hw/microblaze: Give onboard devices a QOM parent
>  hw/sh4: Give onboard devices a QOM parent
>  hw/s390x: Give onboard devices a QOM parent
>  hw/or1k: Give onboard devices a QOM parent
>  hw/loongarch: Give onboard devices a QOM parent
>  hw/intc: Give onboard devices a QOM parent
>  hw/pci-host: Give onboard devices a QOM parent
>  hw/core: Give onboard devices a QOM parent
>  hw/remote: Give onboard devices a QOM parent
>  hw/ufs: Give onboard devices a QOM parent
>  hw/nvme: Give onboard devices a QOM parent
>  hw/vfio: Give onboard devices a QOM parent
>  hw/mem: Give onboard devices a QOM parent
>  hw/cxl: Give onboard devices a QOM parent
>  hw/hexagon: Give onboard devices a QOM parent
>  hw/xen: Give onboard devices a QOM parent
>  hw/display: Give onboard devices a QOM parent
>  hw/nvram: Give onboard devices a QOM parent
>  hw/dma: Give onboard devices a QOM parent
>  hw/misc: Give onboard devices a QOM parent
>  hw/scsi: Give onboard devices a QOM parent
>  hw/net: Give onboard devices a QOM parent
>  hw/ide: Give onboard devices a QOM parent
>  hw/i3c: Give onboard devices a QOM parent
>  hw/pci-bridge: Give onboard devices a QOM parent
>  hw/sparc64: Give onboard devices a QOM parent
>  hw/sparc: Give onboard devices a QOM parent
>  hw/m68k: Give onboard devices a QOM parent
>  hw/rtc: Give onboard devices a QOM parent
>  hw/i2c: Give onboard devices a QOM parent
>  hw/block: Give onboard devices a QOM parent
>  hw/char: Give onboard devices a QOM parent
>  hw/isa: Give onboard devices a QOM parent
>  hw/pci: Give onboard devices a QOM parent
>  hw/riscv: Give onboard devices a QOM parent
>  hw/mips: Give onboard devices a QOM parent
>  hw/i386: Give onboard devices a QOM parent
>  hw/ppc: Give onboard devices a QOM parent
>  hw/pci, hw/isa: Give VGA and slot-NIC helpers a QOM parent
>  hw/arm/virt: Give onboard devices a QOM parent
>  hw/arm/sbsa-ref: Give onboard devices a QOM parent
>  hw/arm/xilinx-zynq: Give onboard devices a QOM parent
>  hw/arm/xlnx-versal, xlnx-zynqmp: Give onboard devices a QOM parent
>  hw/arm/realview, integratorcp: Give onboard devices a QOM parent
>  hw/arm/npcm: Give onboard devices a QOM parent
>  hw/arm/versatile, vexpress: Give onboard devices a QOM parent
>  hw/arm/stellaris, musicpal: Give onboard devices a QOM parent
>  hw/arm/exynos: Give onboard devices a QOM parent
>  hw/arm/allwinner: Give onboard devices a QOM parent
>  hw/arm/strongarm: Give onboard devices a QOM parent
>  hw/arm/omap: Give onboard devices a QOM parent
>  hw/arm/mps2: Give onboard devices a QOM parent
>  hw/arm/imx: Give onboard devices a QOM parent
>  hw/arm/misc: Give onboard devices a QOM parent
>  hw/arm/aspeed: Give onboard devices a QOM parent (part 1)
>  hw/arm/aspeed: Give onboard devices a QOM parent (part 2)
>  hw/nvram/at24c: Give at24c_eeprom_init() a QOM parent
>  hw/i386/pc: Give pcspk a QOM parent
>  hw/timer, hw/net: Give i8254 and isa-ne2000 helpers a QOM parent
>  hw/misc/unimp: Give create_unimplemented_device() a QOM parent
>  hw/usb: Give -usbdevice and auto-hub devices a QOM parent
>  hw/audio: Give -audio model=3D devices a QOM parent
>  hw/xen: Give xenstore-driven backend devices a QOM parent
>  hw/nitro: Give the vsock bridge a QOM parent
>  hw/isa: Give the isabus-bridge a QOM parent
>  net, target/mips: Give -nic and CPU-with-clock helpers a QOM parent
>  usb, ssi, i2c: Remove *_orphan() creator variants
>  isa: Remove *_orphan() creator variants
>  pci: Remove *_orphan() creator variants
>  cpu: Remove cpu_create_orphan()
>  sysbus: Remove *_orphan() creator variants
>  qdev: Remove qdev_new_orphan() and qdev_try_new_orphan()
>  memory: Accept non-device owners in memory_region_init_ram()
>  hw/misc-boards: Give memory regions an explicit owner
>  hw/mips: Give memory regions an explicit owner
>  hw/riscv: Give memory regions an explicit owner
>  hw/i386: Give memory regions an explicit owner
>  hw/arm: Give memory regions an explicit owner
>  hw/arm/omap1: Give memory regions an explicit owner
>  hw/sh4: Give memory regions an explicit owner
>  hw/m68k: Give memory regions an explicit owner
>  hw/ppc: Give memory regions an explicit owner
>  hw/tricore: Give memory regions an explicit owner
>  hw/xtensa: Give memory regions an explicit owner
>  hw/display: Give memory regions an explicit owner
>  hw/arm/omap: Give lcdc and dma memory regions an explicit owner
>  hw/char: Give parallel and htif memory regions an explicit owner
>  hw/remote: Give memory regions an explicit owner
>  system, backends: Give named memory regions an explicit owner
>  hw/ide: Let ide_init_ioport() take an explicit owner
>  memory: Require an owner for named memory regions
>  irq: Rename qemu_allocate_irq*() and friends to *_orphan()
>  irq: Reintroduce qemu_allocate_irq*() with a mandatory owner and name
>  hw/pci, hw/usb, system: Give allocated IRQs an owner and name
>  hw/i386, hw/xen: Give allocated IRQs an owner and name
>  hw/arm: Give allocated IRQs an owner and name
>  hw/xtensa: Give allocated IRQs an owner and name
>  hw: Give allocated IRQs an owner and name
>  hw/core: Parent GPIO input IRQs and embedded IRQState via QOM
>  irq: Delete the *_orphan() IRQ allocation variants
>  sysbus: Parent main-system-bus directly under /machine
>  accel: Parent the accelerator singleton under /machine
>  hw/core/reset: Give the root reset container and legacy shims a QOM
>    path
>  system: Parent per-MR helper objects under their owner
>  hw/virtio, hw/display: Parent per-device helper objects
>  hw/i386/amd_iommu: Parent internally-created AMDVI-PCI under the IOMMU
>  hw/s390x, hw/remote: Parent per-devfn IOMMU objects
>  hw/pci-host/raven: Parent the OR-IRQ under the host bridge
>  hw/arm/mps2: Parent the OR-IRQ gates under the machine
>  hw/arm/digic: Parent the DIGIC SoC under the machine
>  hw/microblaze: Parent the CPU under the machine
>  hw: Pair object_initialize_child() with plain realize()
>  hw: Parent board-created CPUs under the machine
>  hw/pci-host/versatile: Use object_initialize_child() for pci_dev
>  docs, qapi, scripts, iotests: Update /machine/unattached path
>    references
>  qom: Delete /machine/unattached and error on unparented realize
>  docs/devel/qom: Document the composition-tree parenting contract
>  MAINTAINERS: Add scripts/coccinelle/qom-parent/ under QOM
>
> MAINTAINERS                                   |   1 +
> accel/accel-system=2Ec                          |   4 +-
> backends/igvm=2Ec                               |   6 +-
> bsd-user/main=2Ec                               |   3 +-
> docs/devel/qom=2Erst                            |  96 +++++++
> docs/devel/s390-cpu-topology=2Erst              |   2 +-
> docs/system/cpu-hotplug=2Erst                   |   4 +-
> hw/alpha/alpha_sys=2Eh                          |   3 +-
> hw/alpha/dp264=2Ec                              |  16 +-
> hw/alpha/typhoon=2Ec                            |  10 +-
> hw/arm/allwinner-a10=2Ec                        |   4 +-
> hw/arm/allwinner-h3=2Ec                         |  34 ++-
> hw/arm/allwinner-r40=2Ec                        |   4 +-
> hw/arm/armsse=2Ec                               |  13 +-
> hw/arm/aspeed=2Ec                               |  39 +--
> hw/arm/aspeed_ast1040_evb=2Ec                   |   6 +-
> hw/arm/aspeed_ast10x0_evb=2Ec                   |  12 +-
> hw/arm/aspeed_ast2400_palmetto=2Ec              |   8 +-
> hw/arm/aspeed_ast2400_quanta-q71l=2Ec           |  18 +-
> hw/arm/aspeed_ast2400_supermicrox11=2Ec         |   8 +-
> hw/arm/aspeed_ast2500_evb=2Ec                   |   7 +-
> hw/arm/aspeed_ast2500_g220a=2Ec                 |  11 +-
> hw/arm/aspeed_ast2500_romulus=2Ec               |   3 +-
> hw/arm/aspeed_ast2500_supermicro-x11spi=2Ec     |   8 +-
> hw/arm/aspeed_ast2500_tiogapass=2Ec             |  13 +-
> hw/arm/aspeed_ast2500_witherspoon=2Ec           |  34 +--
> hw/arm/aspeed_ast2500_yosemitev2=2Ec            |  13 +-
> hw/arm/aspeed_ast2600_anacapa=2Ec               |  51 ++--
> hw/arm/aspeed_ast2600_bletchley=2Ec             |  33 ++-
> hw/arm/aspeed_ast2600_catalina=2Ec              |  99 +++----
> hw/arm/aspeed_ast2600_evb=2Ec                   |   7 +-
> hw/arm/aspeed_ast2600_fby35=2Ec                 |  20 +-
> hw/arm/aspeed_ast2600_fuji=2Ec                  | 111 ++++----
> hw/arm/aspeed_ast2600_gb200nvl=2Ec              |  24 +-
> hw/arm/aspeed_ast2600_rainier=2Ec               | 188 ++++++++------
> hw/arm/aspeed_ast27x0-fc=2Ec                    |   9 +-
> hw/arm/aspeed_ast27x0_evb=2Ec                   |   3 +-
> hw/arm/aspeed_soc_common=2Ec                    |  14 +-
> hw/arm/bananapi_m2u=2Ec                         |   6 +-
> hw/arm/collie=2Ec                               |   6 +-
> hw/arm/cubieboard=2Ec                           |   6 +-
> hw/arm/digic_boards=2Ec                         |   5 +-
> hw/arm/exynos4210=2Ec                           |  70 ++---
> hw/arm/exynos4_boards=2Ec                       |  15 +-
> hw/arm/fsl-imx25=2Ec                            |   2 +-
> hw/arm/fsl-imx31=2Ec                            |   2 +-
> hw/arm/fsl-imx6=2Ec                             |   7 +-
> hw/arm/fsl-imx6ul=2Ec                           |  37 +--
> hw/arm/fsl-imx7=2Ec                             |  41 +--
> hw/arm/fsl-imx8mm=2Ec                           |   2 +-
> hw/arm/fsl-imx8mp=2Ec                           |   2 +-
> hw/arm/imx25_pdk=2Ec                            |   6 +-
> hw/arm/imx8mm-evk=2Ec                           |   6 +-
> hw/arm/imx8mp-evk=2Ec                           |   6 +-
> hw/arm/integratorcp=2Ec                         |  56 ++--
> hw/arm/kzm=2Ec                                  |   6 +-
> hw/arm/max78000_soc=2Ec                         | 107 ++++----
> hw/arm/max78000fthr=2Ec                         |   5 +-
> hw/arm/mcimx6ul-evk=2Ec                         |   4 +-
> hw/arm/mcimx7d-sabre=2Ec                        |   4 +-
> hw/arm/mps2-tz=2Ec                              |  27 +-
> hw/arm/mps2=2Ec                                 |  91 ++++---
> hw/arm/mps3r=2Ec                                |  20 +-
> hw/arm/msf2-soc=2Ec                             |  24 +-
> hw/arm/msf2-som=2Ec                             |  12 +-
> hw/arm/musca=2Ec                                |   4 +-
> hw/arm/musicpal=2Ec                             |  50 ++--
> hw/arm/netduino2=2Ec                            |   5 +-
> hw/arm/netduinoplus2=2Ec                        |   5 +-
> hw/arm/npcm7xx=2Ec                              |  95 +++----
> hw/arm/npcm7xx_boards=2Ec                       | 117 +++++----
> hw/arm/npcm8xx=2Ec                              | 147 +++++------
> hw/arm/npcm8xx_boards=2Ec                       |  19 +-
> hw/arm/nrf51_soc=2Ec                            |   4 +-
> hw/arm/olimex-stm32-h405=2Ec                    |   5 +-
> hw/arm/omap1=2Ec                                | 244 ++++++++++--------
> hw/arm/omap_sx1=2Ec                             |  20 +-
> hw/arm/orangepi=2Ec                             |   4 +-
> hw/arm/raspi=2Ec                                |   4 +-
> hw/arm/realview=2Ec                             | 113 ++++----
> hw/arm/sabrelite=2Ec                            |   5 +-
> hw/arm/sbsa-ref=2Ec                             |  76 +++---
> hw/arm/stellaris=2Ec                            |  99 ++++---
> hw/arm/stm32f100_soc=2Ec                        |  62 ++---
> hw/arm/stm32f205_soc=2Ec                        |   2 +-
> hw/arm/stm32f405_soc=2Ec                        |  88 +++----
> hw/arm/stm32l4x5_soc=2Ec                        |  88 +++----
> hw/arm/stm32vldiscovery=2Ec                     |   5 +-
> hw/arm/strongarm=2Ec                            |  27 +-
> hw/arm/strongarm=2Eh                            |   2 +-
> hw/arm/versatilepb=2Ec                          |  85 +++---
> hw/arm/vexpress=2Ec                             |  87 ++++---
> hw/arm/virt=2Ec                                 |  97 +++----
> hw/arm/xilinx_zynq=2Ec                          | 160 ++++++------
> hw/arm/xlnx-versal-virt=2Ec                     |   5 +-
> hw/arm/xlnx-versal=2Ec                          | 197 ++++++--------
> hw/arm/xlnx-zcu102=2Ec                          |  14 +-
> hw/arm/xlnx-zynqmp=2Ec                          |   8 +-
> hw/audio/intel-hda=2Ec                          |   4 +-
> hw/audio/model=2Ec                              |   5 +-
> hw/avr/atmega=2Ec                               |  24 +-
> hw/block/fdc-sysbus=2Ec                         |  13 +-
> hw/block/fdc=2Ec                                |   4 +-
> hw/block/pflash_cfi01=2Ec                       |   6 +-
> hw/block/pflash_cfi02=2Ec                       |   6 +-
> hw/block/xen-block=2Ec                          |   5 +-
> hw/char/diva-gsp=2Ec                            |   3 +-
> hw/char/exynos4210_uart=2Ec                     |   6 +-
> hw/char/mcf_uart=2Ec                            |  11 +-
> hw/char/mchp_pfsoc_mmuart=2Ec                   |   4 +-
> hw/char/omap_uart=2Ec                           |   4 +-
> hw/char/parallel-isa=2Ec                        |  10 +-
> hw/char/parallel=2Ec                            |   5 +-
> hw/char/pl011=2Ec                               |   6 +-
> hw/char/riscv_htif=2Ec                          |   5 +-
> hw/char/serial-isa=2Ec                          |  11 +-
> hw/char/serial-mm=2Ec                           |   6 +-
> hw/char/sifive_uart=2Ec                         |   8 +-
> hw/char/spapr_vty=2Ec                           |   6 +-
> hw/char/xen_console=2Ec                         |   7 +-
> hw/core/cpu-common=2Ec                          |   6 +-
> hw/core/gpio=2Ec                                |  24 +-
> hw/core/irq=2Ec                                 |  38 +--
> hw/core/null-machine=2Ec                        |   2 +-
> hw/core/qdev-user=2Ec                           |   6 +-
> hw/core/qdev=2Ec                                |  39 ++-
> hw/core/reset=2Ec                               |  13 +-
> hw/core/sysbus=2Ec                              |  22 +-
> hw/cxl/cxl-host=2Ec                             |   9 +-
> hw/display/cg3=2Ec                              |   2 +-
> hw/display/g364fb=2Ec                           |   2 +-
> hw/display/macfb=2Ec                            |   2 +-
> hw/display/omap_lcdc=2Ec                        |   5 +-
> hw/display/sii9022=2Ec                          |   2 +-
> hw/display/sm501=2Ec                            |   6 +-
> hw/display/vhost-user-gpu=2Ec                   |  12 +-
> hw/display/virtio-gpu-gl=2Ec                    |   2 +-
> hw/display/vmware_vga=2Ec                       |   2 +-
> hw/display/xlnx_dp=2Ec                          |  14 +-
> hw/dma/i8257=2Ec                                |  10 +-
> hw/dma/omap_dma=2Ec                             |   9 +-
> hw/dma/rc4030=2Ec                               |   7 +-
> hw/hexagon/hexagon_dsp=2Ec                      |  21 +-
> hw/hexagon/virt=2Ec                             |  29 +--
> hw/hppa/machine=2Ec                             |  96 ++++---
> hw/i2c/aspeed_i2c=2Ec                           |   4 +-
> hw/i2c/core=2Ec                                 |  22 +-
> hw/i2c/smbus_eeprom=2Ec                         |  11 +-
> hw/i386/amd_iommu=2Ec                           |   3 +-
> hw/i386/isapc=2Ec                               |  17 +-
> hw/i386/kvm/clock=2Ec                           |   4 +-
> hw/i386/kvm/clock=2Eh                           |   2 +-
> hw/i386/kvm/i8259=2Ec                           |   8 +-
> hw/i386/kvm/xen-stubs=2Ec                       |   2 +-
> hw/i386/kvm/xen_evtchn=2Ec                      |   6 +-
> hw/i386/kvm/xen_evtchn=2Eh                      |   3 +-
> hw/i386/kvm/xen_gnttab=2Ec                      |   6 +-
> hw/i386/kvm/xen_gnttab=2Eh                      |   2 +-
> hw/i386/kvm/xen_overlay=2Ec                     |   6 +-
> hw/i386/kvm/xen_overlay=2Eh                     |   2 +-
> hw/i386/kvm/xen_primary_console=2Ec             |   5 +-
> hw/i386/kvm/xen_primary_console=2Eh             |   2 +-
> hw/i386/kvm/xen_xenstore=2Ec                    |   5 +-
> hw/i386/kvm/xen_xenstore=2Eh                    |   2 +-
> hw/i386/microvm=2Ec                             |  34 +--
> hw/i386/nitro_enclave=2Ec                       |   9 +-
> hw/i386/pc=2Ec                                  |  96 +++----
> hw/i386/pc_piix=2Ec                             |  28 +-
> hw/i386/pc_q35=2Ec                              |  42 +--
> hw/i386/pc_sysfw=2Ec                            |  16 +-
> hw/i386/sgx=2Ec                                 |   5 +-
> hw/i386/x86-common=2Ec                          |  33 ++-
> hw/i386/x86-cpu=2Ec                             |   4 +-
> hw/i386/xen/xen-hvm=2Ec                         |  12 +-
> hw/i386/xen/xen-pvh=2Ec                         |   5 +-
> hw/i386/xen/xen_pvdevice=2Ec                    |   2 +-
> hw/i3c/core=2Ec                                 |  19 +-
> hw/ide/ahci=2Ec                                 |   2 +-
> hw/ide/ide-bus=2Ec                              |   5 +-
> hw/ide/ide-internal=2Eh                         |   2 +-
> hw/ide/ioport=2Ec                               |  37 ++-
> hw/ide/isa=2Ec                                  |   9 +-
> hw/ide/pci=2Ec                                  |   2 +-
> hw/ide/piix=2Ec                                 |   2 +-
> hw/intc/apic_common=2Ec                         |   3 +-
> hw/intc/exynos4210_gic=2Ec                      |   4 +-
> hw/intc/i8259=2Ec                               |   6 +-
> hw/intc/i8259_common=2Ec                        |   7 +-
> hw/intc/riscv_aclint=2Ec                        |  16 +-
> hw/intc/riscv_aplic=2Ec                         |  13 +-
> hw/intc/riscv_imsic=2Ec                         |   7 +-
> hw/intc/s390_flic=2Ec                           |  12 +-
> hw/intc/sh_intc=2Ec                             |  21 +-
> hw/intc/sifive_plic=2Ec                         |   7 +-
> hw/ipack/ipack=2Ec                              |  11 +-
> hw/ipmi/ipmi_bt=2Ec                             |   2 +-
> hw/ipmi/ipmi_kcs=2Ec                            |   2 +-
> hw/isa/i82378=2Ec                               |  13 +-
> hw/isa/isa-bus=2Ec                              |  44 ++--
> hw/isa/isa-superio=2Ec                          |  25 +-
> hw/isa/lpc_ich9=2Ec                             |   2 +-
> hw/isa/piix=2Ec                                 |   4 +-
> hw/isa/vt82c686=2Ec                             |   7 +-
> hw/loongarch/virt=2Ec                           |  56 ++--
> hw/m68k/an5206=2Ec                              |  13 +-
> hw/m68k/mcf5206=2Ec                             |   8 +-
> hw/m68k/mcf5208=2Ec                             |  32 ++-
> hw/m68k/mcf_intc=2Ec                            |   7 +-
> hw/m68k/next-cube=2Ec                           |  26 +-
> hw/m68k/q800=2Ec                                |  28 +-
> hw/m68k/virt=2Ec                                |  25 +-
> hw/mem/sparse-mem=2Ec                           |   6 +-
> hw/microblaze/petalogix_ml605_mmu=2Ec           |  40 ++-
> hw/microblaze/petalogix_s3adsp1800_mmu=2Ec      |  27 +-
> hw/microblaze/xlnx-zynqmp-pmu=2Ec               |   4 +-
> hw/mips/boston=2Ec                              |  32 +--
> hw/mips/cps=2Ec                                 |   5 +-
> hw/mips/fuloong2e=2Ec                           |  24 +-
> hw/mips/jazz=2Ec                                |  73 +++---
> hw/mips/loongson3_virt=2Ec                      |  40 +--
> hw/mips/malta=2Ec                               |  49 ++--
> hw/mips/mips_int=2Ec                            |   2 +-
> hw/misc/empty_slot=2Ec                          |   7 +-
> hw/misc/led=2Ec                                 |  15 +-
> hw/misc/macio/macio=2Ec                         |   2 +-
> hw/misc/sifive_e_prci=2Ec                       |   6 +-
> hw/misc/sifive_test=2Ec                         |   6 +-
> hw/net/can/can_kvaser_pci=2Ec                   |   2 +-
> hw/net/imx_fec=2Ec                              |   4 +-
> hw/net/lan9118=2Ec                              |  10 +-
> hw/net/smc91c111=2Ec                            |   6 +-
> hw/net/spapr_llan=2Ec                           |   6 +-
> hw/net/xen_nic=2Ec                              |   5 +-
> hw/nitro/machine=2Ec                            |  11 +-
> hw/nitro/nitro-vsock-bus=2Ec                    |   9 +-
> hw/nubus/nubus-virtio-mmio=2Ec                  |   2 +-
> hw/nvme/ctrl=2Ec                                |   2 +-
> hw/nvram/eeprom_at24c=2Ec                       |  12 +-
> hw/nvram/fw_cfg=2Ec                             |  16 +-
> hw/or1k/or1k-sim=2Ec                            |  25 +-
> hw/or1k/virt=2Ec                                |  43 +--
> hw/pci-bridge/pci_expander_bridge=2Ec           |  13 +-
> hw/pci-host/articia=2Ec                         |   6 +-
> hw/pci-host/astro=2Ec                           |   8 +-
> hw/pci-host/bonito=2Ec                          |  28 +-
> hw/pci-host/grackle=2Ec                         |   2 +-
> hw/pci-host/gt64120=2Ec                         |   5 +-
> hw/pci-host/i440fx=2Ec                          |   2 +-
> hw/pci-host/mv64361=2Ec                         |   4 +-
> hw/pci-host/pnv_phb=2Ec                         |   5 +-
> hw/pci-host/pnv_phb3=2Ec                        |   3 +-
> hw/pci-host/pnv_phb3_msi=2Ec                    |   3 +-
> hw/pci-host/pnv_phb4=2Ec                        |   3 +-
> hw/pci-host/pnv_phb4_pec=2Ec                    |   3 +-
> hw/pci-host/ppc4xx_pci=2Ec                      |   2 +-
> hw/pci-host/ppce500=2Ec                         |   2 +-
> hw/pci-host/raven=2Ec                           |   6 +-
> hw/pci-host/sabre=2Ec                           |  12 +-
> hw/pci-host/sh_pci=2Ec                          |   3 +-
> hw/pci-host/uninorth=2Ec                        |  11 +-
> hw/pci-host/versatile=2Ec                       |   3 +-
> hw/pci/pci=2Ec                                  |  60 +++--
> hw/pci/pcie_sriov=2Ec                           |   3 +-
> hw/ppc/amigaone=2Ec                             |  24 +-
> hw/ppc/e500=2Ec                                 |  70 ++---
> hw/ppc/mac_newworld=2Ec                         |  58 +++--
> hw/ppc/mac_oldworld=2Ec                         |  32 +--
> hw/ppc/pegasos=2Ec                              |  22 +-
> hw/ppc/pnv=2Ec                                  |  33 +--
> hw/ppc/pnv_bmc=2Ec                              |   4 +-
> hw/ppc/pnv_lpc=2Ec                              |   6 +-
> hw/ppc/pnv_psi=2Ec                              |   6 +-
> hw/ppc/ppc440=2Eh                               |   2 +-
> hw/ppc/ppc440_bamboo=2Ec                        |  17 +-
> hw/ppc/ppc440_uc=2Ec                            |  10 +-
> hw/ppc/ppc4xx_sdram=2Ec                         |  34 +--
> hw/ppc/prep=2Ec                                 |  50 ++--
> hw/ppc/sam460ex=2Ec                             |  72 +++---
> hw/ppc/spapr=2Ec                                |  37 +--
> hw/ppc/spapr_irq=2Ec                            |   6 +-
> hw/ppc/spapr_vio=2Ec                            |   6 +-
> hw/ppc/virtex_ml507=2Ec                         |  23 +-
> hw/remote/iommu=2Ec                             |   5 +-
> hw/remote/machine=2Ec                           |   6 +-
> hw/remote/memory=2Ec                            |   3 +-
> hw/remote/vfio-user-obj=2Ec                     |   2 +-
> hw/riscv/aia=2Ec                                |  12 +-
> hw/riscv/aia=2Eh                                |   3 +-
> hw/riscv/boston-aia=2Ec                         |  31 ++-
> hw/riscv/cps=2Ec                                |  14 +-
> hw/riscv/k230=2Ec                               | 127 ++++-----
> hw/riscv/microblaze-v-generic=2Ec               |  51 ++--
> hw/riscv/microchip_pfsoc=2Ec                    |  90 +++----
> hw/riscv/opentitan=2Ec                          |  52 ++--
> hw/riscv/shakti_c=2Ec                           |   8 +-
> hw/riscv/sifive_e=2Ec                           |  25 +-
> hw/riscv/sifive_u=2Ec                           |  39 +--
> hw/riscv/spike=2Ec                              |   8 +-
> hw/riscv/tt_atlantis=2Ec                        |  17 +-
> hw/riscv/virt=2Ec                               |  57 ++--
> hw/riscv/xiangshan_kmh=2Ec                      |  20 +-
> hw/rtc/ls7a_rtc=2Ec                             |   2 +-
> hw/rtc/mc146818rtc=2Ec                          |   6 +-
> hw/rtc/sun4v-rtc=2Ec                            |   6 +-
> hw/s390x/ap-bridge=2Ec                          |   6 +-
> hw/s390x/css-bridge=2Ec                         |   7 +-
> hw/s390x/s390-pci-bus=2Ec                       |  12 +-
> hw/s390x/s390-virtio-ccw=2Ec                    |  41 ++-
> hw/scsi/esp-pci=2Ec                             |   2 +-
> hw/scsi/lasi_ncr710=2Ec                         |   8 +-
> hw/scsi/lasi_ncr710=2Eh                         |   4 +-
> hw/scsi/ncr53c710=2Ec                           |  15 +-
> hw/scsi/ncr53c710=2Eh                           |   7 +-
> hw/scsi/scsi-bus=2Ec                            |   5 +-
> hw/scsi/spapr_vscsi=2Ec                         |   6 +-
> hw/sh4/r2d=2Ec                                  |  38 +--
> hw/sh4/sh7750=2Ec                               |  35 +--
> hw/sparc/leon3=2Ec                              |  27 +-
> hw/sparc/sun4m=2Ec                              | 167 ++++++------
> hw/sparc64/niagara=2Ec                          |  20 +-
> hw/sparc64/sparc64=2Ec                          |   3 +-
> hw/sparc64/sun4u=2Ec                            |  69 ++---
> hw/ssi/ssi=2Ec                                  |   7 +-
> hw/timer/arm_timer=2Ec                          |   6 +-
> hw/timer/sh_timer=2Ec                           |   9 +-
> hw/tricore/tc27x_soc=2Ec                        |  77 +++---
> hw/tricore/tricore_testboard=2Ec                |  19 +-
> hw/ufs/lu=2Ec                                   |   5 +-
> hw/usb/bus=2Ec                                  |  15 +-
> hw/usb/dev-serial=2Ec                           |   3 +-
> hw/usb/vt82c686-uhci-pci=2Ec                    |   4 +-
> hw/vfio/igd=2Ec                                 |   5 +-
> hw/virtio/virtio-mem=2Ec                        |   5 +-
> hw/vmapple/vmapple=2Ec                          |  66 ++---
> hw/xen/xen-bus=2Ec                              |   5 +-
> hw/xen/xen-legacy-backend=2Ec                   |   5 +-
> hw/xen/xen-pvh-common=2Ec                       |  26 +-
> hw/xen/xen_pt_graphics=2Ec                      |   3 +-
> hw/xtensa/mx_pic=2Ec                            |   8 +-
> hw/xtensa/pic_cpu=2Ec                           |   5 +-
> hw/xtensa/sim=2Ec                               |  15 +-
> hw/xtensa/virt=2Ec                              |   4 +-
> hw/xtensa/xtensa_memory=2Ec                     |   5 +-
> hw/xtensa/xtensa_memory=2Eh                     |   3 +-
> hw/xtensa/xtfpga=2Ec                            |  51 ++--
> include/hw/arm/aspeed=2Eh                       |   6 +-
> include/hw/arm/aspeed_soc=2Eh                   |   3 +-
> include/hw/arm/exynos4210=2Eh                   |   2 +-
> include/hw/arm/omap=2Eh                         |  11 +-
> include/hw/block/fdc=2Eh                        |   5 +-
> include/hw/block/flash=2Eh                      |   4 +-
> include/hw/char/mchp_pfsoc_mmuart=2Eh           |   2 +-
> include/hw/char/parallel=2Eh                    |   5 +-
> include/hw/char/pl011=2Eh                       |   2 +-
> include/hw/char/riscv_htif=2Eh                  |   3 +-
> include/hw/char/serial-isa=2Eh                  |   2 +-
> include/hw/char/serial-mm=2Eh                   |   2 +-
> include/hw/char/sifive_uart=2Eh                 |   4 +-
> include/hw/core/cpu=2Eh                         |  11 +-
> include/hw/core/irq=2Eh                         |  27 +-
> include/hw/core/qdev=2Eh                        |  50 ++--
> include/hw/core/sysbus=2Eh                      |  29 ++-
> include/hw/i2c/i2c=2Eh                          |  29 ++-
> include/hw/i2c/smbus_eeprom=2Eh                 |   5 +-
> include/hw/i386/pc=2Eh                          |   6 +-
> include/hw/i386/vmport=2Eh                      |   5 -
> include/hw/i386/x86=2Eh                         |   7 +-
> include/hw/i3c/i3c=2Eh                          |   9 +-
> include/hw/ide/isa=2Eh                          |   3 +-
> include/hw/intc/i8259=2Eh                       |   4 +-
> include/hw/intc/riscv_aclint=2Eh                |   6 +-
> include/hw/intc/riscv_aplic=2Eh                 |   5 +-
> include/hw/intc/riscv_imsic=2Eh                 |   3 +-
> include/hw/intc/sifive_plic=2Eh                 |   3 +-
> include/hw/isa/i8259_internal=2Eh               |   3 +-
> include/hw/isa/isa=2Eh                          |  11 +-
> include/hw/m68k/mcf=2Eh                         |   7 +-
> include/hw/mem/sparse-mem=2Eh                   |   2 +-
> include/hw/mips/mips=2Eh                        |   5 +-
> include/hw/misc/empty_slot=2Eh                  |   3 +-
> include/hw/misc/sifive_e_prci=2Eh               |   2 +-
> include/hw/misc/sifive_test=2Eh                 |   2 +-
> include/hw/misc/unimp=2Eh                       |   9 +-
> include/hw/net/lan9118=2Eh                      |   2 +-
> include/hw/net/ne2000-isa=2Eh                   |   8 +-
> include/hw/net/smc91c111=2Eh                    |   2 +-
> include/hw/nitro/nitro-vsock-bus=2Eh            |   2 +-
> include/hw/nvram/eeprom_at24c=2Eh               |   6 +-
> include/hw/pci/pci=2Eh                          |  19 +-
> include/hw/ppc/pnv=2Eh                          |   2 +-
> include/hw/ppc/spapr_vio=2Eh                    |   8 +-
> include/hw/rtc/mc146818rtc=2Eh                  |   2 +-
> include/hw/rtc/sun4v-rtc=2Eh                    |   2 +-
> include/hw/sh4/sh=2Eh                           |   3 +-
> include/hw/sh4/sh_intc=2Eh                      |   3 +-
> include/hw/ssi/ssi=2Eh                          |   3 +-
> include/hw/timer/i8254=2Eh                      |  13 +-
> include/hw/timer/tmu012=2Eh                     |   3 +-
> include/hw/usb/usb=2Eh                          |  13 +-
> include/hw/xen/xen=2Eh                          |   2 +-
> include/hw/xtensa/mx_pic=2Eh                    |   4 +-
> include/net/net=2Eh                             |   5 +-
> include/qom/object=2Eh                          |  25 ++
> linux-user/main=2Ec                             |   6 +-
> net/net=2Ec                                     |  10 +-
> qapi/block-core=2Ejson                          |  12 +-
> qapi/block=2Ejson                               |   2 +-
> qapi/machine=2Ejson                             |  12 +-
> qapi/qom=2Ejson                                 |   4 +-
> qom/object=2Ec                                  |  13 +
> scripts/arm_processor_error=2Epy                |   3 +-
> =2E=2E=2E/qom-parent/cpu-create-orphan=2Ecocci        |  13 +
> =2E=2E=2E/qom-parent/i2c-slave-new-orphan=2Ecocci     |  18 ++
> =2E=2E=2E/coccinelle/qom-parent/irq-rename=2Ecocci    |  14 +
> =2E=2E=2E/qom-parent/isa-new-orphan=2Ecocci           |  23 ++
> =2E=2E=2E/qom-parent/pci-new-orphan=2Ecocci           |  28 ++
> =2E=2E=2E/qom-parent/qdev-new-orphan=2Ecocci          |  18 ++
> =2E=2E=2E/qom-parent/ssi-usb-orphan=2Ecocci           |  18 ++
> =2E=2E=2E/qom-parent/sysbus-create-orphan=2Ecocci     |  18 ++
> scripts/qmp_helper=2Epy                         |   2 +-
> stubs/xen-hw-stub=2Ec                           |   2 +-
> system/ioport=2Ec                               |  12 +-
> system/memory=2Ec                               |  23 +-
> system/physmem=2Ec                              |   4 +-
> system/qdev-monitor=2Ec                         |   2 +-
> system/qtest=2Ec                                |   2 +-
> system/ram-block-attributes=2Ec                 |   7 +-
> system/vl=2Ec                                   |   3 +-
> target/mips/cpu=2Ec                             |   5 +-
> target/mips/cpu=2Eh                             |   3 +-
> target/xtensa/cpu=2Ec                           |  11 -
> target/xtensa/cpu=2Eh                           |   2 -
> tests/qemu-iotests/172=2Eout                    |  72 +++---
> tests/qemu-iotests/186=2Eout                    |  10 +-
> tests/qemu-iotests/common=2Efilter              |   2 +-
> tests/qtest/fuzz/generic_fuzz=2Ec               |   2 +-
> tests/unit/test-qdev-global-props=2Ec           |  17 +-
> tests/unit/test-qdev=2Ec                        |  12 +-
> 438 files changed, 4515 insertions(+), 3784 deletions(-)
> create mode 100644 scripts/coccinelle/qom-parent/cpu-create-orphan=2Ecoc=
ci
> create mode 100644 scripts/coccinelle/qom-parent/i2c-slave-new-orphan=2E=
cocci
> create mode 100644 scripts/coccinelle/qom-parent/irq-rename=2Ecocci
> create mode 100644 scripts/coccinelle/qom-parent/isa-new-orphan=2Ecocci
> create mode 100644 scripts/coccinelle/qom-parent/pci-new-orphan=2Ecocci
> create mode 100644 scripts/coccinelle/qom-parent/qdev-new-orphan=2Ecocci
> create mode 100644 scripts/coccinelle/qom-parent/ssi-usb-orphan=2Ecocci
> create mode 100644 scripts/coccinelle/qom-parent/sysbus-create-orphan=2E=
cocci
>

