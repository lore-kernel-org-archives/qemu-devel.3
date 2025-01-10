Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE5DE7719A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 00:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW2yW-0007Vn-VU; Thu, 09 Jan 2025 19:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tW2yV-0007Vd-NM
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 19:34:07 -0500
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tW2yT-0000kG-Pm
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 19:34:07 -0500
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4afd68271b6so551418137.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 16:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736469244; x=1737074044; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErBDF88llvD5BpQhDT3fPE6zw4oEyOaabERjoYtDxtE=;
 b=jn5+lCbY1aJqWhPI06GmPVxsbaMZqr0tQkPi9iLRxlz7Wr0S8YlJmwfZWxU9SXXt9K
 OnvPcwcLUrlkqllPRDr86R7ucsN6DU9lWsX2JOJYUOhhRX1BwdOROrS+thGEF7QjJsHn
 lpBJTQc0EVakcU6yVJ862aG2a6HScNLNGOgz6uKGJnZqJ7sUn8gQ17iqXM8r/lJBfmBm
 pNxR1sFFNdUnKbkcrrj3TKwzxdsudOw9AxhnkgURdkvj2dN8RDgYOkDZbOe/fAwEFdbv
 4xg9d1nBq5f2T9oRV/9JQz8UZHe0wL4tAtfXV0habS8t6BU7OqBwtWxeHLXyX2p/Dkz8
 nHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736469244; x=1737074044;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ErBDF88llvD5BpQhDT3fPE6zw4oEyOaabERjoYtDxtE=;
 b=qI7O3DP643YbYWltODiVjPdVlZY3tPRnEqbmIMPjXwRB85QYQUQ700rYWNje/iP28k
 hUdcSU8B+e9h7LX5ozI2URwqXqn3dO//mT8iLdLp8IJH/Jq1b1lVuS5r2ONkwVwBjEPT
 HWiWAvoRnVNXHbwHCWJVJJciAVr5sQ2GLTj4fgfnrKZY8ZqAuiDG82MNRtUxtNKdLz1i
 Gxbags8b+TTxnr36SnM7GBqqvKqTsraeD0IZwUwR7ShirPuXiI9U9Q7B+j0iKM7Qrg1N
 0wM766kLLhdJks23KcmFxgryvWzButirnTIEWezshOtTL6pZUCqiEafMjyEV2NLyKokP
 T+tw==
X-Gm-Message-State: AOJu0YyGN/Tw1lfxVFVYkoeKZ4gb1oLzK8/Xq5Nj/FfAKOoV4PxeUkjq
 0u0ZmuxRuC9EzYK9ouYD4AsmfIlimeAfSLUko2mgL5hvMupOgCotiZiDGuhfgX0Db/reqtQ8cZs
 bKZ5coMYB6gI5wb39AZylrNzuSVDAB/LG
X-Gm-Gg: ASbGncsk1VSPd9NgRgLI8W7IGOSgj2u00tjZoYZGukelfNYCy0c3ptv6SrfFzXoJv/n
 Dqk68qz3XUD8G4RaZqo4BUBpamffSo0fwMJ0b12CFJaKB0xDRcYbmZm2q4x3OsfMn6Ms=
X-Google-Smtp-Source: AGHT+IHxfesz+DqwibkmqwqPe/wLVirnp8ccDpdyBlyPAJQPlT6zC5sKmLog2UBE4MywdTtCiPXr/yOUztotjtkQIzk=
X-Received: by 2002:a05:6102:32cc:b0:4af:d487:45ed with SMTP id
 ada2fe7eead31-4b3d0ee6f09mr8006818137.4.1736469244058; Thu, 09 Jan 2025
 16:34:04 -0800 (PST)
MIME-Version: 1.0
References: <CAEekfLYJqvMDf5A_Yj=N6jMGQ4oj3rC+fv3xcCCfSBy8TDaY-Q@mail.gmail.com>
 <CAKmqyKPo=a=RHUvvgKZLB_DJnEXO=7u25MwNfXu5EDjak=y0vg@mail.gmail.com>
 <CAEekfLaW=-tpTo73or0Lv6zqOuCa67UoYSt9guyHFsw6yM37mg@mail.gmail.com>
 <CAKmqyKNeks-12czF7sWP7gr_t=WU9g309_y5Xk58iFBiVcAijg@mail.gmail.com>
 <CAEekfLYFsdzgRiscqJ4NsvpMsOaLrj_6QbjH-0f42mdggXbyDQ@mail.gmail.com>
In-Reply-To: <CAEekfLYFsdzgRiscqJ4NsvpMsOaLrj_6QbjH-0f42mdggXbyDQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Jan 2025 10:33:36 +1000
X-Gm-Features: AbW1kvbDY1zT-6khWwkf-tVFFX-qNYPrkFbDm90ijxJ1_c6mjWBg3kN30wWOLQc
Message-ID: <CAKmqyKPa2OnCvDPd8WqvyFWN3f9bsngSpF2io4ObJPoCTsx+dQ@mail.gmail.com>
Subject: Re: Subject: [PATCH] loader: Add register setting support via cli
To: Sam Price <thesamprice@gmail.com>
Cc: qemu-devel@nongnu.org, alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Wed, Jan 8, 2025 at 12:28=E2=80=AFPM Sam Price <thesamprice@gmail.com> w=
rote:
>
> I made the changes, and added documentation.
> https://gitlab.com/thesamprice/qemu/-/compare/master...loader?from_projec=
t_id=3D11167699
>
> I left it as [PREFIX]<RegNumber>
>
> I can switch this to just RegNumber if desired.
>
> I am still struggling with the email format sorry.
> ---
> docs/system/generic-loader.rst | 98 ++++++++++++++++++++++++++++++++
> hw/core/generic-loader.c | 46 +++++++++++----
> include/hw/core/generic-loader.h | 7 +++
> 3 files changed, 139 insertions(+), 12 deletions(-)
>
> diff --git a/docs/system/generic-loader.rst b/docs/system/generic-loader.=
rst
> index 4f9fb005f1..71d4aaa097 100644
> --- a/docs/system/generic-loader.rst
> +++ b/docs/system/generic-loader.rst
> @@ -117,4 +117,102 @@ future the internal state 'set_pc' (which exists
> in the generic loader
> now) should be exposed to the user so that they can choose if the PC
> is set or not.
> +Loading Data into Registers
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The `loader` device allows the initialization of CPU registers from the =
command
> +line. This feature is particularly useful for setting up the processor s=
tate
> +before starting an executable. By configuring registers prior to executi=
on, the
> +`loader` can mimic the state that a bootloader would leave the processor=
 in
> +before transferring control to an ELF file or another executable.

This isn't really true though. A bootloader generally will set more
than the GP registers. A boot loader will configure devices and
perhaps initalise memory.

> +
> +The syntax for loading data into registers is as follows::
> +
> + -device loader,reg=3D<reg>,data=3D<data>,data-len=3D<data-len>
> +
> +**Parameters:**
> +
> +``<reg>``
> + The target register to set. Format must pass the following regex
> + ``[a-zA-Z]+[0-9]+``. The numeric part corresponds to the processor's GD=
B \
> + register index. For general-purpose registers, this is typically the
> + number in the register's name (e.g., ``r5`` translates to ``5``).
> + Special-purpose registers have specific IDs defined in their processor'=
s
> + `gdbstub.c` file. Note that these IDs vary between processors.
> +
> +``<data>``
> + The value to load into the specified register. The data must not exceed=
 8
> + bytes in size.

Why 8 bytes?

> +
> +``<data-len>``
> + The length of the data in bytes. This parameter is mandatory when using
> + the ``data`` argument.

Do we need data-len? Why not just use the register size

> +
> +**Examples:**
> +
> +Set a general-purpose register
> +""""""""""""""""""""""""""""""
> +
> +To set register ``r5`` to ``0xc0001000`` (4 bytes) on CPU 0::
> +
> + -device loader,reg=3Dr5,data=3D0xc0001000,data-len=3D4
> +
> +Set a special register
> +""""""""""""""""""""""
> +
> +To set the Program Counter (PC, register ``32``) to ``0x80000000`` on CP=
U 0::
> +
> + -device loader,reg=3Dpc32,data=3D0x80000000,data-len=3D4
> +
> +You must look in your processor's `gdbstub.c` file to special register t=
o index
> +mappings.

That isn't really helpful for users, but I don't have a better idea

> +
> +**Special Registers:**
> +
> +Special registers are defined in the processor's ``gdbstub.c`` file
> with numeric IDs.
> +Examples from the MicroBlaze processor at one point looked like. include=
::
> +
> + enum {
> + GDB_PC =3D 32 + 0,
> + GDB_MSR =3D 32 + 1,
> + GDB_EAR =3D 32 + 2,
> + GDB_ESR =3D 32 + 3,
> + GDB_FSR =3D 32 + 4,
> + GDB_BTR =3D 32 + 5,
> + GDB_PVR0 =3D 32 + 6,
> + GDB_PVR11 =3D 32 + 17,
> + GDB_EDR =3D 32 + 18,
> + GDB_SLR =3D 32 + 25,
> + GDB_SHR =3D 32 + 26,
> + };
> +
> +For example, to set the Machine State Register (``GDB_MSR``) on a MicroB=
laze
> +processor::
> +
> + -device loader,reg=3DMSR33,data=3D0x00000001,data-len=3D4
> +
> +**Register Loading Notes:**
> +
> +1. **Processor-Specific IDs**:
> + The numeric IDs for registers vary between processors. Always refer to =
the
> + `gdbstub.c` file for the target processor to identify the correct regis=
ter
> + mappings.
> +
> +2. **Pre-Execution State**:
> + This capability is ideal for initializing a simulated environment to ma=
tch
> + the state expected by an ELF file. For example, you can configure stack
> + pointers, machine state registers, and program counters to prepare the
> + processor to run a bootstrapped application.
> +
> +3. **Validation**:
> + Register numbers are validated by the `gdb_write_register` function. En=
sure
> + the specified register is supported by the target architecture.
> +
> +4. **Endianess**:
> + The `data` value is written using the processor's native endian format.
> +
> +By using the `loader` device to initialize registers, you can simulate
> +realistic execution environments, enabling detailed testing and debuggin=
g
> +of embedded software, including bootloaders interactions and operating
> +system kernels.
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index ea8628b892..9408ecd150 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -55,6 +55,14 @@ static void generic_loader_reset(void *opaque)
> }
> }
> + if(s->reg.name) {
> + CPUClass *cc =3D CPU_GET_CLASS(s->cpu);
> + int bytes_written =3D cc->gdb_write_register(s->cpu, (uint8_t*)
> &s->reg.value, s->reg.num);
> + if(bytes_written !=3D s->reg.data_len) {
> + printf("Error setting register %d to value %lX expected to write %d,
> but wrote %d\n", s->reg.num, s->reg.value, s->reg.data_len,
> bytes_written);

The line wrapping is muddled up here. Can you please send it with git
send-email. Do some sends against yourself to make sure it works.

You mentioned gmail in an earlier thread I think, did you follow the
instructions: https://git-scm.com/docs/git-send-email#_use_gmail_as_the_smt=
p_server

Alistair

