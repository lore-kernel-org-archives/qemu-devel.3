Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67C9EDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soEQj-0006iR-3A; Tue, 10 Sep 2024 23:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1soEQh-0006hI-A4; Tue, 10 Sep 2024 23:54:07 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1soEQf-0003bR-KE; Tue, 10 Sep 2024 23:54:07 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-502af8a83daso1517255e0c.1; 
 Tue, 10 Sep 2024 20:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726026844; x=1726631644; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8I4r16otTzXYVh16RMJp0XYHDPiIoYT82Sd4n8rVgE=;
 b=FLb76FU2ZQ1MGTeQV46skQmTrHEpVWN6QjJwSVsqubFXhONAK89WA7LHhI3ZcEbzLD
 CEBfL2Tn7StikYjZ71ALUWFYwARpipuG168mAHARj5Nr9t3NuHDk/NtyTTw98BdG5iQC
 ktS9dCBII+2NQ/Q/axvytKg/R+WCMsiupktXhYCtmWoz7qYdvADjlCuqphQeR8OTCI8v
 6imQy6LGJTQSmqiYRNQfHBhQmvz9szjrC6+c4+6H3jJXyDhv5Gfo3MX5gw+2RQqcm+dC
 hKH+EakadoxxftHdpHXLm7gSt0qN7aLfe4oIseQ+jn0DPClTC1iVcYvz4IN2jgvEuoBJ
 hz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726026844; x=1726631644;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8I4r16otTzXYVh16RMJp0XYHDPiIoYT82Sd4n8rVgE=;
 b=YBOeq7h6eqPYrGdGjwoMN0MFZjanuwY22p05yGV2i/yUiUZYTQJkpvJ4hBzJBMAuaS
 l/nmyiPpgYbu6msiX4M7cgP1FkGDN9i8JkNCY/QBnIDreA79ggchNlriDe3ZCXzTc2pb
 18QG/fSTEebIFnAGz/EOeYCREQFbvzuNyAhNu3Bxp20M7JDg9L4N9fUY4nckndX1xS+j
 Hf8zSrxds1dSQE3x/iTZ/PrLQMed3CAWYJwz/ldvMNdxu3VrU5l1olYb3J5WKSIHqvGN
 QfyamR4hvvWa9mfN0AgNXC2bjm6V8yosIaYuz74C4BzCoJL8WD/jhKzN9Z9jqoSVAMZv
 slXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI+S9gbJt3iDCFqKvekJlWYfKXF8Z/gWHHy3CgSq+x4j96umIRTsFoYryIYZ9cdtls0e2JrSQqzb2k@nongnu.org
X-Gm-Message-State: AOJu0YxjJ2E3nPRlIlIUA7AHs/41jnQOqTuVVNi7cz/d0aIKXkrezykD
 BzMU7Q9LkWpnStNIT3F5HAzc4J/0bcEXL6+SevknqnkFsOGO4iZ8GRi/Uazyvc8olpsEvAz3tyB
 UF0XD5Bj6kkkSit/etzOIRMHiGRA=
X-Google-Smtp-Source: AGHT+IEonoeAPJpsIVdDNSaiNRJ6B63N4XEQ+H1A/rPaVXq1bp0rPwldylSk6j153tBExldVT7tPFETqHusaAzVQ4dk=
X-Received: by 2002:a05:6122:a14:b0:4f5:1363:845b with SMTP id
 71dfb90a1353d-502214235c1mr14890518e0c.9.1726026843560; Tue, 10 Sep 2024
 20:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240805210444.497723-1-gregorhaas1997@gmail.com>
 <CAKmqyKM_qgc+wwrDRzZM1yda=dZziM=1rGU2_SDeJU9PTnacVg@mail.gmail.com>
 <CAMqWt3oWGLaXBsM7inQkird0+VQcdbaQoZ-uF2Okmg4B2Q8uqg@mail.gmail.com>
In-Reply-To: <CAMqWt3oWGLaXBsM7inQkird0+VQcdbaQoZ-uF2Okmg4B2Q8uqg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 11 Sep 2024 13:53:37 +1000
Message-ID: <CAKmqyKPfgUmUnHbYjEViBUoJQn_bZOoHyus17w4Sg9dRykA8ew@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Add support for generating OpenSBI domains in the
 device tree
To: Gregor Haas <gregorhaas1997@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, atishp@rivosinc.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 11, 2024 at 7:08=E2=80=AFAM Gregor Haas <gregorhaas1997@gmail.c=
om> wrote:
>
> Hi Alistair!
>
> On Sun, Sep 8, 2024 at 8:27=E2=80=AFPM Alistair Francis <alistair23@gmail=
.com> wrote:
>>
>> On Tue, Aug 6, 2024 at 7:05=E2=80=AFAM Gregor Haas <gregorhaas1997@gmail=
.com> wrote:
>> >
>> > This patch series adds support for specifying OpenSBI domains on the Q=
EMU
>> > command line. A simple example of what this looks like is below, inclu=
ding
>> > mapping the board's UART into the secondary domain:
>>
>> Thanks for the patch, sorry it took me so long to look into this
>
>
> No worries -- thanks for your review!
>
>>
>>
>> >
>> > qemu-system-riscv64 -machine virt -bios fw_jump.bin -cpu max -smp 2 -m=
 4G -nographic \
>> >         -device opensbi-memregion,id=3Dmem,base=3D0xBC000000,order=3D2=
6,mmio=3Dfalse \
>> >         -device opensbi-memregion,id=3Duart,base=3D0x10000000,order=3D=
12,mmio=3Dtrue,device0=3D"/soc/serial@10000000" \
>> >         -device opensbi-domain,id=3Ddomain,possible-harts=3D0-1,boot-h=
art=3D0x0,next-addr=3D0xBC000000,next-mode=3D1,region0=3Dmem,perms0=3D0x3f,=
region1=3Duart,perms1=3D0x3f
>>
>> This will need documentation added under docs (probably under
>> docs/system/riscv) of how this should be used.
>
>
> I've just sent a v4 patch series which includes documentation! Please let
> me know what you think.
>
>>
>> I'm not convinced this is something we want though. A user can dump
>> the QEMU DTB and edit it to support OpenSBI domains if they want.
>>
>> My worry is that the command line method is complex for users to get
>> right and will be fragile and prone to breakage as parts of QEMU's DTB
>> changes.
>
>
> I've found this patch series really useful for programmatically generatin=
g test
> fixtures in an isolation system I'm working on, which is built on top of =
OpenSBI
> domains. In that sense, I've found generating the correct flags is easier=
 rather
> than manually editing or generating several dozen device tree files for e=
ach
> test configuration.

That's fair

>
> I take your point that these flags are hard to get right, and there may b=
e more
> user-friendly ways to do this. FWIW, I that this will only rarely break i=
f QEMU's
> DTB changes -- the only part that really depends on QEMU's DTB (rather th=
an
> just adding new information to it) is the device-linking part for memregi=
ons, and
> it gives a loud, direct error if it cannot find the user-specified device=
.

Maybe some unit tests would help here as well, to make sure we catch
the error when the change happens.

Alistair

