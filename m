Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE0EC0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 00:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdetO-0006Au-0B; Thu, 30 Jan 2025 19:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdetI-0006Ae-Am
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 19:28:12 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdetG-0003jW-BU
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 19:28:12 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-85c5adbca8eso404182241.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 16:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738283289; x=1738888089; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yiFsDYlVX9NWnJR9yYXS/P9wgEfs6+nNe+VLoc3PZ1I=;
 b=G6TKrJkSX0Uli2mPBiZiNcxVa/V6N+H2deqxaE42SDnfZaUaqTkfZNrnuQaeuZ/Viz
 SuOaWtXRYmerrqoqjAelnsBou06zmuTL3ZQWoQEIJTsm8a71+hCFfcgyWXmYktcoeHks
 1IBGGL/30Nrkda7zLUyfjuAWu13w39oQaPr2yqlsI9l/yYhiMw8GJJKi8vCXtmdKzfLo
 EnhT60hkK3fX5Q8N3XB59mIRxW7oYoD9d8Ek6uXTZtCQhrdINo1exbv88xglsuUANyPC
 2vkstw+uO7blGKlWlRv7Yb0uDvZ8LSG090asJc8gX2F51xcxb7QeyuME/YhCwzAp0gl0
 oCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738283289; x=1738888089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yiFsDYlVX9NWnJR9yYXS/P9wgEfs6+nNe+VLoc3PZ1I=;
 b=lo94+Wcu03lPda4JBrdIcLCs+AoD196diosK71LDNZw/cuq1oCvPbUcEyF8DnFeOCz
 cVTRxGCrMVC4lfxHHaO72wWgGbMkNdU0sk8oLgp6NaVBAgfqARp/G3D8Mv4VvBE8PnZs
 gC1UsZoKBqtckUaNuQ5K/SdcJkpFT4KK0PioA2s6afRzye28EB06VTTJQSVdv4vitgDn
 EIOp0urvZjtDtqoifdG3SVdBLphVmNmfr/oDgsj7HtH9gXwosWULWOg+RX8jaTyyc1ss
 xkg4bML5rYH1I0lI0PdMVITUeCsZarRfeTkgT1bHQefJPr4DKiWw/cNFSwsOocagWnjF
 tq+Q==
X-Gm-Message-State: AOJu0YyAXEEvJQ7VElmoxDhgqD3vmjy7pQjUoeIr6bxV1vneMvgN+n4I
 eGZ+nfeD6fsRyJT7MjGMEHdxw9Jn3N5iesNM9DUl43lQvWRpmJU076Ties/WKCQehAMKQArmebF
 djdaq1bxM0TrvuigAQIdtgo021M4=
X-Gm-Gg: ASbGncuBGLTnXBEvm3b0f7dXsEb0Bcy2Yi/9Ypoo/umIy2S7MB5VahukFureiGiSDgq
 W8QMIb7yjeHcXIuioAk01gLklReMJsXZliwAdmYqJIm6PHR2JUfXUa0vE6k/yeCOy6yp+ir1NqM
 Jf2QXCAVYxe8D+69RBd+eULQQaxPQ=
X-Google-Smtp-Source: AGHT+IEcrs+Ua8IrWnA3HXngumW3zcYwSVnz8qJ9vRo3wZLEztjq9ZQr6apj89ccoPwwSu3ZPXwXE4dsdtmjVrGCpck=
X-Received: by 2002:a05:6102:3ece:b0:4b0:49ba:8278 with SMTP id
 ada2fe7eead31-4b9a52719damr8518921137.25.1738283288968; Thu, 30 Jan 2025
 16:28:08 -0800 (PST)
MIME-Version: 1.0
References: <CAEekfLYJqvMDf5A_Yj=N6jMGQ4oj3rC+fv3xcCCfSBy8TDaY-Q@mail.gmail.com>
 <CAKmqyKPo=a=RHUvvgKZLB_DJnEXO=7u25MwNfXu5EDjak=y0vg@mail.gmail.com>
 <CAEekfLaW=-tpTo73or0Lv6zqOuCa67UoYSt9guyHFsw6yM37mg@mail.gmail.com>
 <CAKmqyKNeks-12czF7sWP7gr_t=WU9g309_y5Xk58iFBiVcAijg@mail.gmail.com>
 <CAEekfLYFsdzgRiscqJ4NsvpMsOaLrj_6QbjH-0f42mdggXbyDQ@mail.gmail.com>
 <CAKmqyKPa2OnCvDPd8WqvyFWN3f9bsngSpF2io4ObJPoCTsx+dQ@mail.gmail.com>
 <CAEekfLZgVN2m9qUKygds88FgNtLqE-YgzL7R6jG9AYTSh0Nrog@mail.gmail.com>
In-Reply-To: <CAEekfLZgVN2m9qUKygds88FgNtLqE-YgzL7R6jG9AYTSh0Nrog@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2025 10:27:42 +1000
X-Gm-Features: AWEUYZkLEJsoCRv8Mjip82VfkOc1BrHIaFDkCpmamWiYo6eIipnWEzsvD3SdzHE
Message-ID: <CAKmqyKMwojdOo7cQdjd5A+EqGv1YGqRQUUY_WXOYO_9m76WH2g@mail.gmail.com>
Subject: Re: Subject: [PATCH] loader: Add register setting support via cli
To: Sam Price <thesamprice@gmail.com>
Cc: qemu-devel@nongnu.org, alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 10, 2025 at 3:33=E2=80=AFPM Sam Price <thesamprice@gmail.com> w=
rote:
>
> Yes that is true a boot loader will do more than just set registers.
> Ill rework the text a bit on the next update.
> In my case i need to set the r5 register that specifies the memory
> location to the device tree.

Should that be done in the machine instead? It seems tricky to expect
users to set this register

> I also use the device loader to load in a elf file to ram, and the
> device-loader to load in the device tree to the location specified by
> the r5 register
>
> I could add a gdb call that would return an array of string mappings
> to integers.
> If the machine doesn't implement the function/  leaves it as null
> pointer then you wouldn't get the cli support.
> Not sure where you would document all the machine register names /
> numbers at though.
> This might be too much though?

We probably don't need to document the register names

Alistair

> I left the door somewhat open on this via the NAME_NUMBER format.
>
> There was some checking logic where if data is supplied then it forces
> a check for data-len.
> I could relax that check if you supply the reg.name field.
>
> I am unsure how to determine the machine register size.
> I assumed the max register size on any machine would be 8 bytes, this
> might be wrong.
> the gdb call seems to just pass in the full 8 bytes, but I didn't dig
> into it for all machines.
>
> Ill look at this a bit more and try to configure the git email.
> I also need to set up a docker container to build /test latest.
> I have been building / testing on an old ubuntu machine.
> (To test this I need to run it on qemu-xilinx).
> My workplace has us on ubuntu 20.
>
> So it might be a while before I have another version up.
>
> Thanks,
> Sam
>
> On Thu, Jan 9, 2025 at 7:34=E2=80=AFPM Alistair Francis <alistair23@gmail=
.com> wrote:
> >
> > On Wed, Jan 8, 2025 at 12:28=E2=80=AFPM Sam Price <thesamprice@gmail.co=
m> wrote:
> > >
> > > I made the changes, and added documentation.
> > > https://gitlab.com/thesamprice/qemu/-/compare/master...loader?from_pr=
oject_id=3D11167699
> > >
> > > I left it as [PREFIX]<RegNumber>
> > >
> > > I can switch this to just RegNumber if desired.
> > >
> > > I am still struggling with the email format sorry.
> > > ---
> > > docs/system/generic-loader.rst | 98 ++++++++++++++++++++++++++++++++
> > > hw/core/generic-loader.c | 46 +++++++++++----
> > > include/hw/core/generic-loader.h | 7 +++
> > > 3 files changed, 139 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/docs/system/generic-loader.rst b/docs/system/generic-loa=
der.rst
> > > index 4f9fb005f1..71d4aaa097 100644
> > > --- a/docs/system/generic-loader.rst
> > > +++ b/docs/system/generic-loader.rst
> > > @@ -117,4 +117,102 @@ future the internal state 'set_pc' (which exist=
s
> > > in the generic loader
> > > now) should be exposed to the user so that they can choose if the PC
> > > is set or not.
> > > +Loading Data into Registers
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > +The `loader` device allows the initialization of CPU registers from =
the command
> > > +line. This feature is particularly useful for setting up the process=
or state
> > > +before starting an executable. By configuring registers prior to exe=
cution, the
> > > +`loader` can mimic the state that a bootloader would leave the proce=
ssor in
> > > +before transferring control to an ELF file or another executable.
> >
> > This isn't really true though. A bootloader generally will set more
> > than the GP registers. A boot loader will configure devices and
> > perhaps initalise memory.
> >
> > > +
> > > +The syntax for loading data into registers is as follows::
> > > +
> > > + -device loader,reg=3D<reg>,data=3D<data>,data-len=3D<data-len>
> > > +
> > > +**Parameters:**
> > > +
> > > +``<reg>``
> > > + The target register to set. Format must pass the following regex
> > > + ``[a-zA-Z]+[0-9]+``. The numeric part corresponds to the processor'=
s GDB \
> > > + register index. For general-purpose registers, this is typically th=
e
> > > + number in the register's name (e.g., ``r5`` translates to ``5``).
> > > + Special-purpose registers have specific IDs defined in their proces=
sor's
> > > + `gdbstub.c` file. Note that these IDs vary between processors.
> > > +
> > > +``<data>``
> > > + The value to load into the specified register. The data must not ex=
ceed 8
> > > + bytes in size.
> >
> > Why 8 bytes?
> >
> > > +
> > > +``<data-len>``
> > > + The length of the data in bytes. This parameter is mandatory when u=
sing
> > > + the ``data`` argument.
> >
> > Do we need data-len? Why not just use the register size
> >
> > > +
> > > +**Examples:**
> > > +
> > > +Set a general-purpose register
> > > +""""""""""""""""""""""""""""""
> > > +
> > > +To set register ``r5`` to ``0xc0001000`` (4 bytes) on CPU 0::
> > > +
> > > + -device loader,reg=3Dr5,data=3D0xc0001000,data-len=3D4
> > > +
> > > +Set a special register
> > > +""""""""""""""""""""""
> > > +
> > > +To set the Program Counter (PC, register ``32``) to ``0x80000000`` o=
n CPU 0::
> > > +
> > > + -device loader,reg=3Dpc32,data=3D0x80000000,data-len=3D4
> > > +
> > > +You must look in your processor's `gdbstub.c` file to special regist=
er to index
> > > +mappings.
> >
> > That isn't really helpful for users, but I don't have a better idea
> >
> > > +
> > > +**Special Registers:**
> > > +
> > > +Special registers are defined in the processor's ``gdbstub.c`` file
> > > with numeric IDs.
> > > +Examples from the MicroBlaze processor at one point looked like. inc=
lude::
> > > +
> > > + enum {
> > > + GDB_PC =3D 32 + 0,
> > > + GDB_MSR =3D 32 + 1,
> > > + GDB_EAR =3D 32 + 2,
> > > + GDB_ESR =3D 32 + 3,
> > > + GDB_FSR =3D 32 + 4,
> > > + GDB_BTR =3D 32 + 5,
> > > + GDB_PVR0 =3D 32 + 6,
> > > + GDB_PVR11 =3D 32 + 17,
> > > + GDB_EDR =3D 32 + 18,
> > > + GDB_SLR =3D 32 + 25,
> > > + GDB_SHR =3D 32 + 26,
> > > + };
> > > +
> > > +For example, to set the Machine State Register (``GDB_MSR``) on a Mi=
croBlaze
> > > +processor::
> > > +
> > > + -device loader,reg=3DMSR33,data=3D0x00000001,data-len=3D4
> > > +
> > > +**Register Loading Notes:**
> > > +
> > > +1. **Processor-Specific IDs**:
> > > + The numeric IDs for registers vary between processors. Always refer=
 to the
> > > + `gdbstub.c` file for the target processor to identify the correct r=
egister
> > > + mappings.
> > > +
> > > +2. **Pre-Execution State**:
> > > + This capability is ideal for initializing a simulated environment t=
o match
> > > + the state expected by an ELF file. For example, you can configure s=
tack
> > > + pointers, machine state registers, and program counters to prepare =
the
> > > + processor to run a bootstrapped application.
> > > +
> > > +3. **Validation**:
> > > + Register numbers are validated by the `gdb_write_register` function=
. Ensure
> > > + the specified register is supported by the target architecture.
> > > +
> > > +4. **Endianess**:
> > > + The `data` value is written using the processor's native endian for=
mat.
> > > +
> > > +By using the `loader` device to initialize registers, you can simula=
te
> > > +realistic execution environments, enabling detailed testing and debu=
gging
> > > +of embedded software, including bootloaders interactions and operati=
ng
> > > +system kernels.
> > > diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> > > index ea8628b892..9408ecd150 100644
> > > --- a/hw/core/generic-loader.c
> > > +++ b/hw/core/generic-loader.c
> > > @@ -55,6 +55,14 @@ static void generic_loader_reset(void *opaque)
> > > }
> > > }
> > > + if(s->reg.name) {
> > > + CPUClass *cc =3D CPU_GET_CLASS(s->cpu);
> > > + int bytes_written =3D cc->gdb_write_register(s->cpu, (uint8_t*)
> > > &s->reg.value, s->reg.num);
> > > + if(bytes_written !=3D s->reg.data_len) {
> > > + printf("Error setting register %d to value %lX expected to write %d=
,
> > > but wrote %d\n", s->reg.num, s->reg.value, s->reg.data_len,
> > > bytes_written);
> >
> > The line wrapping is muddled up here. Can you please send it with git
> > send-email. Do some sends against yourself to make sure it works.
> >
> > You mentioned gmail in an earlier thread I think, did you follow the
> > instructions: https://git-scm.com/docs/git-send-email#_use_gmail_as_the=
_smtp_server
> >
> > Alistair
>
>
>
> --
> Sincerely,
>
> Sam Price

