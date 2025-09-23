Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E57BCAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 04:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0uYn-0004QW-KK; Tue, 23 Sep 2025 00:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1v0uYl-0004QD-PQ
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 00:23:24 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1v0uYh-0000kb-5j
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 00:23:23 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 06C0944D39
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 04:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2059C113CF
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 04:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758601391;
 bh=1/qrgHoa2j7ulr8oZ6R/RE8U3p0nUHGQ82rMg2R4iTY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=sfbWriOFUfhypypqCCKRwRd1vmi9fe5hWYbrb8OMmWwVuAprjihjqsWDimOv/6VbB
 ZrQRzDGZJWt6d1bDAQ5rU1pztVb7H4XiG7rQrXzMzlvEiW/StnRkvV3ErU2QreXsy1
 tlV3OpfLS0o8Eo1fVd4vsM38c6UASuaKOlU+8f75Xfvfhi3dkAjeq6Q6NU0dUfslri
 JBmAg2SwEa9yDI6v4fcpDm9ojRJ171q5EjHhTUV1GoLKm3o8KL0R27TD+F/rM2YQr8
 1Y9h315iDwYKaWhoiwsm8uWdV/A5tV0QnLWO5cqfHX0R/Jb9KoIP4QuBsltVZhD10D
 sfBb8xROr69nw==
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b07c28f390eso938456166b.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 21:23:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUVA4S2fwvvhBOmy+Sn1TdskWK0ExglyIiaM+braG02ZUuHZKXnAcEtEn0Uq3NBztmRfmHh+5hseMyC@nongnu.org
X-Gm-Message-State: AOJu0Yz2y4fGoBVCCvOlmOQAPrx0MKGa8At+fN4pVyWXeqdlTB7TlDI/
 Vo0HnZx+M80Cegrw/A305EPup8VQH27SWKANau1zJbWI9ea38zIr5s5ZdTKvoIhHwfpMTWp+Aou
 XfjtzguYPdQVepTpx20Y7TEHIpnZ8ps8=
X-Google-Smtp-Source: AGHT+IH3HnE9f3krQa8ccEnCQLAmt87nTWKPkmHvaxekKa9jZJIb+tkM4N/rrnG7FG5vTxbh8y0Hx83c0JUmGqBMgLs=
X-Received: by 2002:a17:907:c26:b0:b04:858e:c1ee with SMTP id
 a640c23a62f3a-b30260c9adcmr100389466b.2.1758601390386; Mon, 22 Sep 2025
 21:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250922141557.1939333-1-chenhuacai@kernel.org>
 <b8f1cea3-cd26-855a-b772-1f4d8b9b2fc3@loongson.cn>
In-Reply-To: <b8f1cea3-cd26-855a-b772-1f4d8b9b2fc3@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 23 Sep 2025 12:22:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4pONDCQSOg1rRO2Mu5ADHkpA8Pk2ep7Cf0OT72yg=YeQ@mail.gmail.com>
X-Gm-Features: AS18NWAR09zFaDbvp6Jw8tlYmKcb4_0ixoQ4n6Sdge_Gt0XXOP7rwzlEe129Ltg
Message-ID: <CAAhV-H4pONDCQSOg1rRO2Mu5ADHkpA8Pk2ep7Cf0OT72yg=YeQ@mail.gmail.com>
Subject: Re: [PATCH] hw/loongarch/virt: Align VIRT_GED_CPUHP_ADDR to 4 bytes
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 WANG Xuerui <git@xen0n.name>, qemu-devel@nongnu.org, 
 Huacai Chen <chenhuacai@loongson.cn>, Nathan Chancellor <nathan@kernel.org>, 
 WANG Rui <wangrui@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=chenhuacai@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, Bibo,

On Tue, Sep 23, 2025 at 11:40=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> Hi huacai,
>
> It breaks with compatible issue since acpi table is changed, and test
> case qtest-loongarch64/bios-tables-test fails to run.
>
> LoongArch VM compatibility is not perfect now, one method is to modify
> test case at the same time, another method is to add extra option in
> order to support aligned GED ACPI address.
>
> Does this issue must be fixed now? With ACPI spec, 5.2.12.20 Core
> Programmable Interrupt Controller (CORE PIC) Structure, ACPI Processor
> ID is not aligned also, its size is 4 byte and offset is 3 bytes.
They are different.

ACPI tables are probably packed (so the members may not be aligned),
such as CORE PIC you mentioned. Linux kernel defines two kinds of
accessors to parse members. You can see the code in
drivers/acpi/acpica/acmacros.h from the kernel as an example.

The problem mentioned in this patch is the alignment of a struct as a
whole. If the struct itself isn't aligned, Linux kernel cannot handle
it on hardware without UAL, even with two kinds of accessors.

>
> If it must be fixed, the test case should be modified also together with
> the patch. If not, it can be record as pending bug, will solve it if VM
> compatibility method is decided.
Generally speaking, I think this should be fixed, because it is
allowed for qemu to emulate a machine without UAL. I will take a look
at qtest-loongarch64/bios-tables-test (maybe you means
tests/qtest/bios-tables-test.c?), but it seeams a separate patch is
better?

Huacai

>
> Regards
> Bibo Mao
>
> On 2025/9/22 =E4=B8=8B=E5=8D=8810:15, Huacai Chen wrote:
> > From: Huacai Chen <chenhuacai@loongson.cn>
> >
> > Now VIRT_GED_CPUHP_ADDR is not aligned to 4 bytes, but if Linux kernel
> > is built with ACPI_MISALIGNMENT_NOT_SUPPORTED, it assumes the alignment=
,
> > otherwise we get ACPI errors at boot phase:
> >
> > ACPI Error: AE_AML_ALIGNMENT, Returned by Handler for [SystemMemory] (2=
0250404/evregion-301)
> > ACPI Error: Aborting method \_SB.CPUS.CSTA due to previous error (AE_AM=
L_ALIGNMENT) (20250404/psparse-529)
> > ACPI Error: Aborting method \_SB.CPUS.C000._STA due to previous error (=
AE_AML_ALIGNMENT) (20250404/psparse-529)
> > ACPI Error: Method execution failed \_SB.CPUS.C000._STA due to previous=
 error (AE_AML_ALIGNMENT) (20250404/uteval-68)
> >
> > VIRT_GED_MEM_ADDR and VIRT_GED_REG_ADDR are already aligned now, but us=
e
> > QEMU_ALIGN_UP() to explicitly align them can make code more robust.
> >
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Suggested-by: WANG Rui <wangrui@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   include/hw/loongarch/virt.h | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> > index 602feab0f0..be4f5d603f 100644
> > --- a/include/hw/loongarch/virt.h
> > +++ b/include/hw/loongarch/virt.h
> > @@ -28,9 +28,9 @@
> >   #define VIRT_LOWMEM_SIZE        0x10000000
> >   #define VIRT_HIGHMEM_BASE       0x80000000
> >   #define VIRT_GED_EVT_ADDR       0x100e0000
> > -#define VIRT_GED_MEM_ADDR       (VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_=
LEN)
> > -#define VIRT_GED_REG_ADDR       (VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO=
_LEN)
> > -#define VIRT_GED_CPUHP_ADDR     (VIRT_GED_REG_ADDR + ACPI_GED_REG_COUN=
T)
> > +#define VIRT_GED_MEM_ADDR       QEMU_ALIGN_UP(VIRT_GED_EVT_ADDR + ACPI=
_GED_EVT_SEL_LEN, 4)
> > +#define VIRT_GED_REG_ADDR       QEMU_ALIGN_UP(VIRT_GED_MEM_ADDR + MEMO=
RY_HOTPLUG_IO_LEN, 4)
> > +#define VIRT_GED_CPUHP_ADDR     QEMU_ALIGN_UP(VIRT_GED_REG_ADDR + ACPI=
_GED_REG_COUNT, 4)
> >
> >   #define COMMAND_LINE_SIZE       512
> >
> >
>

