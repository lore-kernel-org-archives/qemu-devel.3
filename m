Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988F5E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 05:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW7ej-0003wk-4T; Fri, 10 Jan 2025 00:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thesamprice@gmail.com>)
 id 1tW7eg-0003vo-Gq
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 00:33:58 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thesamprice@gmail.com>)
 id 1tW7ee-0004YV-8O
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 00:33:58 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ef70c7efa5so2427160a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 21:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736487234; x=1737092034; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLvTHN6z/6N+P7Fd+LSR4fgAX2mVcjWseop+h4E8G7I=;
 b=NvHGdmuFpmxxnJBMAQGPPnDFY6CwoKYD8PLEz2hOsbPyX6of0ZS70S6xtutmZmfi8R
 XLDDJ+fzyoYXA/PfUlxocwFFWrWDaJiJ0gOOBwbQ5rtSDvoXNjPnU8wLCnHDWHwGYqU4
 EpGQmchHwJJuv1OHZuJA0JEKO6/6g0qkWPT9ASWaDCno9sLOJSU0l6/usyiU9+8rTQL8
 OS0hDLZH4OYadneMId3SIXqLvhUlSK+Sb0fhEU7ZajL1G5RnN/IKcfHb5loAORn86Tpw
 bIAFqLoJp6+WIKWrKYUR0z4aCKd0HzXsq2DeSZln9JwqWPF94O0gArQRjLJ91t8BfHJW
 42vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736487234; x=1737092034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLvTHN6z/6N+P7Fd+LSR4fgAX2mVcjWseop+h4E8G7I=;
 b=u+w8WcMFWAPi7hcoZHxSas84Nkh5jS4CZQOGW/XiqGqZyiY+FmDOTqpDnBtHMOBLJN
 3uroxVHW4EFfWDA5E+qf8rUz3Jg9oW6w3b2S3dm5pexKGI+13hLFvkE2JsL3nZa7JVF9
 huF6F6a9ArQnERlIGdmBnU6HyIE3PnoNmlU4Y1sZrg8TVl7DSwriseZnzq+xtn6cxbzz
 fxm7ePG4+h544l6WnGr0Dt+DT7cKjlcwxmHabsIr//kmkDYUbkbJM8FgcmFHxTw9kFWk
 5zXknN5/NiKhogSymzxBtUIHErOzeUInP7KSmjwjjteCuPik+LjgmX5WZYNxq9Wv8PNM
 OWTg==
X-Gm-Message-State: AOJu0YzU0b8DExN/E9kFXQNBqM4SZA4jaghSuE7We4UMxOiMgpqtFXi7
 Q3kXDwg+owqsJS1Tf8QNl7Uv4NuiiSyDObqkl9Ut0natzbqLoBBB1gNdOXnoxRbaNcqLqZU+3EF
 rik4ELjAxSONw5BrfW0SQ3f7DGIg=
X-Gm-Gg: ASbGncsYPG7fdlxQilRpXVuaWXVxAG+Ye4mjcx4vdy3IhnNc0F9UdsnEPxix+c1HEsZ
 TiotQcXqBDymVmwSIuY0wr5rsZ9ymsFGaPSGlrQ0=
X-Google-Smtp-Source: AGHT+IHyLsjEnov9Gh6zCrPISiRqFDW9UNwaS87aFa5/wJku2ODucoz5f4J1icdjAgI2EKpdABFo+F/5OY5ThXzVJ1w=
X-Received: by 2002:a17:90b:1f8b:b0:2ee:bf84:4fe8 with SMTP id
 98e67ed59e1d1-2f548f1d44cmr13794018a91.30.1736487234078; Thu, 09 Jan 2025
 21:33:54 -0800 (PST)
MIME-Version: 1.0
References: <CAEekfLYJqvMDf5A_Yj=N6jMGQ4oj3rC+fv3xcCCfSBy8TDaY-Q@mail.gmail.com>
 <CAKmqyKPo=a=RHUvvgKZLB_DJnEXO=7u25MwNfXu5EDjak=y0vg@mail.gmail.com>
 <CAEekfLaW=-tpTo73or0Lv6zqOuCa67UoYSt9guyHFsw6yM37mg@mail.gmail.com>
 <CAKmqyKNeks-12czF7sWP7gr_t=WU9g309_y5Xk58iFBiVcAijg@mail.gmail.com>
 <CAEekfLYFsdzgRiscqJ4NsvpMsOaLrj_6QbjH-0f42mdggXbyDQ@mail.gmail.com>
 <CAKmqyKPa2OnCvDPd8WqvyFWN3f9bsngSpF2io4ObJPoCTsx+dQ@mail.gmail.com>
In-Reply-To: <CAKmqyKPa2OnCvDPd8WqvyFWN3f9bsngSpF2io4ObJPoCTsx+dQ@mail.gmail.com>
From: Sam Price <thesamprice@gmail.com>
Date: Fri, 10 Jan 2025 00:33:42 -0500
X-Gm-Features: AbW1kvbSscQ-ulHju_uGT-XoaapFTAQ_5MXdL1R6GFkl5Defb2i5tdPUns7FnTI
Message-ID: <CAEekfLZgVN2m9qUKygds88FgNtLqE-YgzL7R6jG9AYTSh0Nrog@mail.gmail.com>
Subject: Re: Subject: [PATCH] loader: Add register setting support via cli
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=thesamprice@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Yes that is true a boot loader will do more than just set registers.
Ill rework the text a bit on the next update.
In my case i need to set the r5 register that specifies the memory
location to the device tree.
I also use the device loader to load in a elf file to ram, and the
device-loader to load in the device tree to the location specified by
the r5 register

I could add a gdb call that would return an array of string mappings
to integers.
If the machine doesn't implement the function/  leaves it as null
pointer then you wouldn't get the cli support.
Not sure where you would document all the machine register names /
numbers at though.
This might be too much though?
I left the door somewhat open on this via the NAME_NUMBER format.

There was some checking logic where if data is supplied then it forces
a check for data-len.
I could relax that check if you supply the reg.name field.

I am unsure how to determine the machine register size.
I assumed the max register size on any machine would be 8 bytes, this
might be wrong.
the gdb call seems to just pass in the full 8 bytes, but I didn't dig
into it for all machines.

Ill look at this a bit more and try to configure the git email.
I also need to set up a docker container to build /test latest.
I have been building / testing on an old ubuntu machine.
(To test this I need to run it on qemu-xilinx).
My workplace has us on ubuntu 20.

So it might be a while before I have another version up.

Thanks,
Sam

On Thu, Jan 9, 2025 at 7:34=E2=80=AFPM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Wed, Jan 8, 2025 at 12:28=E2=80=AFPM Sam Price <thesamprice@gmail.com>=
 wrote:
> >
> > I made the changes, and added documentation.
> > https://gitlab.com/thesamprice/qemu/-/compare/master...loader?from_proj=
ect_id=3D11167699
> >
> > I left it as [PREFIX]<RegNumber>
> >
> > I can switch this to just RegNumber if desired.
> >
> > I am still struggling with the email format sorry.
> > ---
> > docs/system/generic-loader.rst | 98 ++++++++++++++++++++++++++++++++
> > hw/core/generic-loader.c | 46 +++++++++++----
> > include/hw/core/generic-loader.h | 7 +++
> > 3 files changed, 139 insertions(+), 12 deletions(-)
> >
> > diff --git a/docs/system/generic-loader.rst b/docs/system/generic-loade=
r.rst
> > index 4f9fb005f1..71d4aaa097 100644
> > --- a/docs/system/generic-loader.rst
> > +++ b/docs/system/generic-loader.rst
> > @@ -117,4 +117,102 @@ future the internal state 'set_pc' (which exists
> > in the generic loader
> > now) should be exposed to the user so that they can choose if the PC
> > is set or not.
> > +Loading Data into Registers
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +The `loader` device allows the initialization of CPU registers from th=
e command
> > +line. This feature is particularly useful for setting up the processor=
 state
> > +before starting an executable. By configuring registers prior to execu=
tion, the
> > +`loader` can mimic the state that a bootloader would leave the process=
or in
> > +before transferring control to an ELF file or another executable.
>
> This isn't really true though. A bootloader generally will set more
> than the GP registers. A boot loader will configure devices and
> perhaps initalise memory.
>
> > +
> > +The syntax for loading data into registers is as follows::
> > +
> > + -device loader,reg=3D<reg>,data=3D<data>,data-len=3D<data-len>
> > +
> > +**Parameters:**
> > +
> > +``<reg>``
> > + The target register to set. Format must pass the following regex
> > + ``[a-zA-Z]+[0-9]+``. The numeric part corresponds to the processor's =
GDB \
> > + register index. For general-purpose registers, this is typically the
> > + number in the register's name (e.g., ``r5`` translates to ``5``).
> > + Special-purpose registers have specific IDs defined in their processo=
r's
> > + `gdbstub.c` file. Note that these IDs vary between processors.
> > +
> > +``<data>``
> > + The value to load into the specified register. The data must not exce=
ed 8
> > + bytes in size.
>
> Why 8 bytes?
>
> > +
> > +``<data-len>``
> > + The length of the data in bytes. This parameter is mandatory when usi=
ng
> > + the ``data`` argument.
>
> Do we need data-len? Why not just use the register size
>
> > +
> > +**Examples:**
> > +
> > +Set a general-purpose register
> > +""""""""""""""""""""""""""""""
> > +
> > +To set register ``r5`` to ``0xc0001000`` (4 bytes) on CPU 0::
> > +
> > + -device loader,reg=3Dr5,data=3D0xc0001000,data-len=3D4
> > +
> > +Set a special register
> > +""""""""""""""""""""""
> > +
> > +To set the Program Counter (PC, register ``32``) to ``0x80000000`` on =
CPU 0::
> > +
> > + -device loader,reg=3Dpc32,data=3D0x80000000,data-len=3D4
> > +
> > +You must look in your processor's `gdbstub.c` file to special register=
 to index
> > +mappings.
>
> That isn't really helpful for users, but I don't have a better idea
>
> > +
> > +**Special Registers:**
> > +
> > +Special registers are defined in the processor's ``gdbstub.c`` file
> > with numeric IDs.
> > +Examples from the MicroBlaze processor at one point looked like. inclu=
de::
> > +
> > + enum {
> > + GDB_PC =3D 32 + 0,
> > + GDB_MSR =3D 32 + 1,
> > + GDB_EAR =3D 32 + 2,
> > + GDB_ESR =3D 32 + 3,
> > + GDB_FSR =3D 32 + 4,
> > + GDB_BTR =3D 32 + 5,
> > + GDB_PVR0 =3D 32 + 6,
> > + GDB_PVR11 =3D 32 + 17,
> > + GDB_EDR =3D 32 + 18,
> > + GDB_SLR =3D 32 + 25,
> > + GDB_SHR =3D 32 + 26,
> > + };
> > +
> > +For example, to set the Machine State Register (``GDB_MSR``) on a Micr=
oBlaze
> > +processor::
> > +
> > + -device loader,reg=3DMSR33,data=3D0x00000001,data-len=3D4
> > +
> > +**Register Loading Notes:**
> > +
> > +1. **Processor-Specific IDs**:
> > + The numeric IDs for registers vary between processors. Always refer t=
o the
> > + `gdbstub.c` file for the target processor to identify the correct reg=
ister
> > + mappings.
> > +
> > +2. **Pre-Execution State**:
> > + This capability is ideal for initializing a simulated environment to =
match
> > + the state expected by an ELF file. For example, you can configure sta=
ck
> > + pointers, machine state registers, and program counters to prepare th=
e
> > + processor to run a bootstrapped application.
> > +
> > +3. **Validation**:
> > + Register numbers are validated by the `gdb_write_register` function. =
Ensure
> > + the specified register is supported by the target architecture.
> > +
> > +4. **Endianess**:
> > + The `data` value is written using the processor's native endian forma=
t.
> > +
> > +By using the `loader` device to initialize registers, you can simulate
> > +realistic execution environments, enabling detailed testing and debugg=
ing
> > +of embedded software, including bootloaders interactions and operating
> > +system kernels.
> > diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> > index ea8628b892..9408ecd150 100644
> > --- a/hw/core/generic-loader.c
> > +++ b/hw/core/generic-loader.c
> > @@ -55,6 +55,14 @@ static void generic_loader_reset(void *opaque)
> > }
> > }
> > + if(s->reg.name) {
> > + CPUClass *cc =3D CPU_GET_CLASS(s->cpu);
> > + int bytes_written =3D cc->gdb_write_register(s->cpu, (uint8_t*)
> > &s->reg.value, s->reg.num);
> > + if(bytes_written !=3D s->reg.data_len) {
> > + printf("Error setting register %d to value %lX expected to write %d,
> > but wrote %d\n", s->reg.num, s->reg.value, s->reg.data_len,
> > bytes_written);
>
> The line wrapping is muddled up here. Can you please send it with git
> send-email. Do some sends against yourself to make sure it works.
>
> You mentioned gmail in an earlier thread I think, did you follow the
> instructions: https://git-scm.com/docs/git-send-email#_use_gmail_as_the_s=
mtp_server
>
> Alistair



--=20
Sincerely,

Sam Price

