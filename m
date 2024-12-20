Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CD3E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSF1-0006LZ-6k; Thu, 19 Dec 2024 20:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEs-0006F5-D5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:42 -0500
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEq-0004Tp-IU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:38 -0500
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4b24d969db1so304737137.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659735; x=1735264535; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4x2FCmiOxk6fLxudGrqVnbndC66ZYpnwZTED1Z/jyrY=;
 b=AHxC5Hn59tidkVU16I77OrR93thC5GgAL7n3UG06lZJFZcWXlyz0bbYGI7KyILSVhN
 qxCi0dwxlwnZfyybDa31f84dPsy9sZEGlZpejEQARAGKA9v55kPm1sukDglEZkxrb/FM
 /Lz95ekgYyWuEKq49I0BNUsa+3/iL7EG3lchu053Nco1thH8km+WS9n09Sd9S2P2D8Xv
 7Xbm1hHR7lukY6V9REaNnF5tsFYutE1O1V+DF17Kpbh6vofptO/u8Acz6agnDHP75CSL
 LQk6Nh9bHY3tPAr/HGsImxA6E+i0tjpF7AC8v0z0jyPHNi3Sfo/Lp7KFdq2jgnFJ0jIX
 IGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659735; x=1735264535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4x2FCmiOxk6fLxudGrqVnbndC66ZYpnwZTED1Z/jyrY=;
 b=BaI4xWh1B5QWqz/AECEmfbOqFv1UeGraOEcsV+gZ/kGtBBW3wZOc2bHPaIlE7O6X7w
 71UOf0rslwZpaWmo2MVAWWzaKckoyzskcCXvFCchDa3GA22pL00vneD23c65hi9lkOUV
 HAfoNdnZ20KsJNxcqe1TBVVuODmSJqkYenhqcisiLQfKcBobrxqqfzdHplyS4WB49GcP
 sbfM8/m//oyZalZgu57nIuXDqtB3Xct+b+89LqYQGo+rvQpRAKOIoZjy4rCT6TfvTyq3
 bcp7gIJo3AoM4vcIBBDE9s4FTHd9Dl5hBHktpRxnJ4Purmb+JT+sSI7ktcy6TTu5LTDb
 MNfQ==
X-Gm-Message-State: AOJu0YzxZj3pQqbwQdeSJG3cLjxQ5ddNqexDHtNa/IQlwO1h6piir54H
 lxmJNwVyP7gMohn92yMcNCcRTrp0Kgdb3i6hQmEqny6MNR2I5mlxPAunftYT0yVcqjud+CL2xo6
 bN3XGrx7XlBhRlVFV0xowDH1B29s=
X-Gm-Gg: ASbGncvnTC8lyl3eD10DbfhcHYVSVpqV0Vv55MYVBNQTOSd40jFbkRTlUbsqwCcy9Co
 q3T/jiyRql8gpueCRbV6N8RmoODYK8K+Vuqpid6C7Qn74PsBME/LgHXdqhtkblwGuNV0n
X-Google-Smtp-Source: AGHT+IEeSgBp0BkaCphmxezLrPPCXc6OK1kNMaguHQorMVXjT3XcswnSL28GHe3D3XnwGxW6EiNjM5M9AVx+l/FZ1As=
X-Received: by 2002:a05:6102:950:b0:4b2:49ec:1b77 with SMTP id
 ada2fe7eead31-4b2cc494cdamr1685696137.23.1734659735226; Thu, 19 Dec 2024
 17:55:35 -0800 (PST)
MIME-Version: 1.0
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
 <20241219204549.GA724589@fedora>
In-Reply-To: <20241219204549.GA724589@fedora>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 20 Dec 2024 11:55:08 +1000
Message-ID: <CAKmqyKPOs6Vw=aYj9Zi+nXx+dy4PGz6w1FYxT084utDTVbGHQw@mail.gmail.com>
Subject: Re: [PULL 00/39] riscv-to-apply queue
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
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

On Fri, Dec 20, 2024 at 6:45=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> Hi Alistair,
> Please take a look at the following CI failure:
>
> x86_64-w64-mingw32-gcc -m64 -Ilibqemuutil.a.p -I. -I.. -Iqapi -Itrace -Iu=
i -Iui/shader -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/glib-2.0 -I/=
usr/x86_64-w64-mingw32/sys-root/mingw/lib/glib-2.0/include -I/usr/x86_64-w6=
4-mingw32/sys-root/mingw/include/p11-kit-1 -fdiagnostics-color=3Dauto -Wall=
 -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g -fstack-protector-strong -Wempty=
-body -Wendif-labels -Wexpansion-to-defined -Wformat-security -Wformat-y2k =
-Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self -Wmissing-forma=
t-attribute -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -=
Wold-style-definition -Wredundant-decls -Wshadow=3Dlocal -Wstrict-prototype=
s -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -Wn=
o-psabi -Wno-shift-negative-value -iquote . -iquote /builds/qemu-project/qe=
mu -iquote /builds/qemu-project/qemu/include -iquote /builds/qemu-project/q=
emu/host/include/x86_64 -iquote /builds/qemu-project/qemu/host/include/gene=
ric -iquote /builds/qemu-project/qemu/tcg/i386 -mms-bitfields -mcx16 -msse2=
 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-ali=
asing -fno-common -fwrapv -fno-pie -no-pie -ftrivial-auto-var-init=3Dzero -=
fzero-call-used-regs=3Dused-gpr -mms-bitfields -pthread -mms-bitfields -MD =
-MQ libqemuutil.a.p/meson-generated_.._trace_trace-hw_riscv.c.obj -MF libqe=
muutil.a.p/meson-generated_.._trace_trace-hw_riscv.c.obj.d -o libqemuutil.a=
.p/meson-generated_.._trace_trace-hw_riscv.c.obj -c trace/trace-hw_riscv.c
> In file included from trace/trace-hw_riscv.c:5:
> ../hw/riscv/trace-events: In function '_nocheck__trace_riscv_iommu_sys_ms=
i_sent':
> ../hw/riscv/trace-events:19:22: error: format '%lx' expects argument of t=
ype 'long unsigned int', but argument 6 has type 'uint64_t' {aka 'long long=
 unsigned int'} [-Werror=3Dformat=3D]
>    19 | riscv_iommu_sys_msi_sent(uint32_t vector, uint64_t msi_addr, uint=
32_t msi_data, uint32_t result) "MSI sent to vector %u msi_addr 0x%lx msi_d=
ata 0x%x result %u"
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ......
> ../hw/riscv/trace-events:19:22: error: format '%lx' expects argument of t=
ype 'long unsigned int', but argument 3 has type 'uint64_t' {aka 'long long=
 unsigned int'} [-Werror=3Dformat=3D]
>    19 | riscv_iommu_sys_msi_sent(uint32_t vector, uint64_t msi_addr, uint=
32_t msi_data, uint32_t result) "MSI sent to vector %u msi_addr 0x%lx msi_d=
ata 0x%x result %u"
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~                 =
                                                             ~~~~~~~~
>       |                                                                  =
                                                             |
>       |                                                                  =
                                                             uint64_t {aka =
long long unsigned int}
> cc1: all warnings being treated as errors
>
> https://gitlab.com/qemu-project/qemu/-/jobs/8691704969#L2578
>
> Once the issue has been solved, please send a new revision of this pull

Sorry about that, v2 sent.

Alistair

> request.
>
> Thanks,
> Stefan

