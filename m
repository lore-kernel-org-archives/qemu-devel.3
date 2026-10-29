Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE33606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c4jlnzbm;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cLiNyuXi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMM9F-0003SC-Vi; Thu, 29 Oct 2026 05:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xMM9D-0003Q7-0T
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xMM9B-0004X8-12
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793265007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MDsmhWpht7qmbgJJCEFAGEac06M0sveTBgwn7GaxY2k=;
 b=c4jlnzbmzoMfxZCdCB/3tWyAT5ctxbHGmgSCgu6oncXGYLuDcIfzEDSLzevP9rBlZZFFTy
 4TyDkwjSbiGEsERI6sULh+WVwBm5TRZUkgqQ0uQyyTHfXEngRxb/jR6RL3h85W5oqz1LdC
 4/6gl4XW3ramG6Rf9jEe8pa2rv674XI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-ek1kqzphMCSyNO0gpXYtBA-1; Thu, 29 Oct 2026 05:10:06 -0400
X-MC-Unique: ek1kqzphMCSyNO0gpXYtBA-1
X-Mimecast-MFC-AGG-ID: ek1kqzphMCSyNO0gpXYtBA_1793265005
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48df5b058ddso1243965f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793265005; x=1793869805; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MDsmhWpht7qmbgJJCEFAGEac06M0sveTBgwn7GaxY2k=;
 b=cLiNyuXi92Uc3zA9GmVJkMkF3Ye8JcL6Sdvx/S83u1JH4ADwCkwFyn62pFwWZbUvjw
 NpityMIID+hi8DB0/HvMKYpipBvJGZgEWOZ0Hr3CGmn07vHyL1ImPp4p9xTTCZWLn+mP
 SigmLWOeyNf35tiZF6SHYaNmkGXwN5s6fR4jffYCvNvKXcR4zBZGcztxgPnPLLFrOukU
 drWjPPu/14gCWZmSSg4rYNeJoeX8z6omIvSC0bzz00Njc7x3uiZwxHtlAh4KOqnxp4t6
 ffiVgVzPlmNYd3ks73emKGyJNGaGd6cIfAbRqUEKKeLlHdOYOu1vggS5K7+46bNA358h
 KR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793265005; x=1793869805;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MDsmhWpht7qmbgJJCEFAGEac06M0sveTBgwn7GaxY2k=;
 b=NRY6dduYE+R0QRbvSnc7Wn3FRyR4lITt1ouq8KyfUybxuqVr8wXVzU1w/IkAJtSw/M
 hAaIcjET3MU6MesbYg5x/eQOlqgGNhJ+NFfWvuc4tdKq75+5Jp5LB/69J3sN4B3NoDMK
 FWJ3Xd69IlwXQlt9Kx9VV0gYZ0k2za6boU1sUaSZqhnkBb+gMS8PN9fvTTkaYAj8IngA
 boTEiTQTuUvjoFZXJRC1o7aS84bVQ4rf4zK46qAjMHHi5rxW/HQb8+MXYqkTihL5/RTR
 snIMnC7kWqFTtBTsAhX4rJDs5562BGgUN1P5Ab68x4lt8o31A1vjemLR3qQNRHaVV7VJ
 pU9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByvLhpkM2zWT3g5YtPeBoW3lIbK4jJrTyooULDrA3USJgjpNllKNQ6DyY5K3px0ry3+OMlvZx2wjvIp@nongnu.org
X-Gm-Message-State: AFq9FYJCYMjLbwKqf4MCDyqOnxfFLN0yhN5MbJZb7ijcLl0pqI18CNmK
 6bKZXYBsSwPQHqiAwp+ZhtX/kv8KId1tJu3Y3FcDGAND/l+gUJVnJKk3hPM4A5B4Kt1m7u4FdUn
 SRA7MNoFULfa7CM50sZWpFP2I+ANOLAHn/bshqvxfqGitCCTmKZBwAKnb
X-Gm-Gg: AYBFou2NGLALXCndFuYhGroijdpxEATou559FHw1Jn8IWGxOhGT/3Qth2eNsjRGIvMw
 8tozao/gMfk/99j/T8o1XuUlXi6wRF4VTC1Nq6vs6RMdgrHXc7zdAq6dahpCaGcA+AVTjWbVW5n
 0FPmCuTjegBRsX5jLUt1zyqUnOM2IwWuZZKeYiQbhLQ0RNrWsEe73Pr/zIgHA+LZ0z2jLoDy9K2
 6t+1Bmm4UpDAlM1/oiE7+D9rRW7Om9cYnfLneiHLMwHE8H2FoQNaLK4RCr26o5FYvZhIAG1FSAV
 0yugZh1PfDjOdRhBjbON6m8wrK97tRS7TWyq+JcYZracVzuvcT3qz1wDsSEn9p8euBwJuQKelfI
 5nqD/NgWHNgZPawX4lqxfhROphgdLmB5gsA==
X-Received: by 2002:a05:6000:29cf:b0:48d:ea67:79d4 with SMTP id
 ffacd0b85a97d-48e5d311f62mr7929507f8f.53.1793265005126; 
 Thu, 29 Oct 2026 02:10:05 -0700 (PDT)
X-Received: by 2002:a05:6000:29cf:b0:48d:ea67:79d4 with SMTP id
 ffacd0b85a97d-48e5d311f62mr7929475f8f.53.1793265004694; 
 Thu, 29 Oct 2026 02:10:04 -0700 (PDT)
Received: from x1 ([151.41.153.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3418sm29758577f8f.41.2026.10.29.02.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 02:10:04 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:10:01 +0100
From: Gustavo Romero <gromero@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH v2 0/9] target/mips: Re-introduce the R5900 CPU (system)
 + sort tcg tests
Message-ID: <ys56kep6ekiznkykip2xbie4qcswlbl55vxsiezl77qdgabwcg@byega6a2h4qc>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <28e90058-6b1d-40ad-9aed-590107f3f77f@oss.qualcomm.com>
 <a3555348-c24c-4df5-95a4-b4ab0a7490c1@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3555348-c24c-4df5-95a4-b4ab0a7490c1@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Phil,

On Thu, Oct 29, 2026 at 06:39:49AM +0100, Philippe Mathieu-Daudé wrote:
> On 29/10/26 06:33, Pierrick Bouvier wrote:
> > On 10/28/26 12:25 PM, Philippe Mathieu-Daudé wrote:
> > > Add R5900 system tests, code is covered, CPU can come back,
> > > allowing to fix a bug on PCGT opcode.
> > > 
> > > Since [v1]:
> > > - rebased
> > > - added freestanding libc stubs
> > > - o32/n32 tests
> > > 
> > > [v1]: https://lore.kernel.org/qemu-devel/20210214175912.732946-1-
> > > f4bug@amsat.org/
> > > 
> > > Philippe Mathieu-Daudé (9):
> > >    target/mips: Re-introduce the R5900 CPU in system mode
> > >    target/mips/tx79: Fix PCGT* (Parallel Compare for Greater Than)
> > >    tests/guest-debug: Allow placing the binary within system QEMU args
> > >    tests/tcg/mips64el: Add bare-metal harness for R5900 system tests
> > >    tests/tcg/mips64el: Move R5900 tests to system mode and build with
> > >      meson
> > >    target/mips: Factor mips_gdb_read_value() out
> > >    target/mips: Describe gdbstub registers with XML features
> > >    target/mips: Expose R5900 registers to gdb
> > >    tests/tcg/mips64el: Add a TX79 instruction test in system mode
> > > 
> > >   MAINTAINERS                                   |   1 +
> > >   configs/targets/mips-linux-user.mak           |   1 +
> > >   configs/targets/mips-softmmu.mak              |   1 +
> > >   configs/targets/mips64-linux-user.mak         |   1 +
> > >   configs/targets/mips64-softmmu.mak            |   1 +
> > >   configs/targets/mips64el-linux-user.mak       |   1 +
> > >   configs/targets/mips64el-softmmu.mak          |   1 +
> > >   configs/targets/mipsel-linux-user.mak         |   1 +
> > >   configs/targets/mipsel-softmmu.mak            |   1 +
> > >   configs/targets/mipsn32-linux-user.mak        |   1 +
> > >   configs/targets/mipsn32el-linux-user.mak      |   1 +
> > >   target/mips/internal.h                        |   2 +
> > >   tests/tcg/mips64el/system/include/assert.h    |  15 +
> > >   tests/tcg/mips64el/system/include/inttypes.h  |   7 +
> > >   tests/tcg/mips64el/system/include/stdio.h     |  17 +
> > >   tests/tcg/mips64el/system/include/string.h    |  16 +
> > >   target/mips/cpu.c                             |   4 +
> > >   target/mips/gdbstub.c                         | 152 +++++-
> > >   target/mips/tcg/tx79_translate.c              |  10 +-
> > >   tests/tcg/mips64el/system/harness.c           |  66 +++
> > >   .../system}/test_r5900_div1.c                 |   0
> > >   .../system}/test_r5900_divu1.c                |   0
> > >   .../system}/test_r5900_madd.c                 |   0
> > >   .../system}/test_r5900_maddu.c                |   0
> > >   .../system}/test_r5900_mflohi1.c              |   0
> > >   .../system}/test_r5900_mtlohi1.c              |   0
> > >   .../system}/test_r5900_mult.c                 |   0
> > >   .../system}/test_r5900_multu.c                |   0
> > >   tests/tcg/mips64el/system/test_r5900_tx79.c   | 477 ++++++++++++++++++
> > >   target/mips/cpu-defs.c.inc                    |  45 ++
> > >   gdbstub/gdb-xml/mips32-cp0.xml                |   9 +
> > >   gdbstub/gdb-xml/mips32-cpu.xml                |  42 ++
> > >   gdbstub/gdb-xml/mips32-fpu.xml                |  41 ++
> > >   gdbstub/gdb-xml/mips64-cp0.xml                |   9 +
> > >   gdbstub/gdb-xml/mips64-cpu.xml                |  42 ++
> > >   gdbstub/gdb-xml/mips64-fpu.xml                |  41 ++
> > >   gdbstub/gdb-xml/mips64-r5900.xml              |  47 ++
> > >   tests/guest-debug/run-test.py                 |   9 +-
> > >   tests/tcg/mips/user/isa/r5900/Makefile        |  32 --
> > >   tests/tcg/mips/user/isa/r5900/README          |   6 -
> > >   tests/tcg/mips64el/meson.build                |   2 +
> > >   tests/tcg/mips64el/system/boot.S              |  23 +
> > >   tests/tcg/mips64el/system/kernel.ld           |  43 ++
> > >   tests/tcg/mips64el/system/meson.build         |  62 +++
> > >   tests/tcg/mips64el/system/test-r5900.py       |  30 ++
> > >   45 files changed, 1211 insertions(+), 49 deletions(-)
> > >   create mode 100644 tests/tcg/mips64el/system/include/assert.h
> > >   create mode 100644 tests/tcg/mips64el/system/include/inttypes.h
> > >   create mode 100644 tests/tcg/mips64el/system/include/stdio.h
> > >   create mode 100644 tests/tcg/mips64el/system/include/string.h
> > >   create mode 100644 tests/tcg/mips64el/system/harness.c
> > >   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/
> > > test_r5900_div1.c (100%)
> > >   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/
> > > test_r5900_divu1.c (100%)
> > >   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/
> > > test_r5900_madd.c (100%)
> > >   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/
> > > test_r5900_maddu.c (100%)
> > >   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/
> > > test_r5900_mflohi1.c (100%)
> > >   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/
> > > test_r5900_mtlohi1.c (100%)
> > >   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/
> > > test_r5900_mult.c (100%)
> > >   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/
> > > test_r5900_multu.c (100%)
> > >   create mode 100644 tests/tcg/mips64el/system/test_r5900_tx79.c
> > >   create mode 100644 gdbstub/gdb-xml/mips32-cp0.xml
> > >   create mode 100644 gdbstub/gdb-xml/mips32-cpu.xml
> > >   create mode 100644 gdbstub/gdb-xml/mips32-fpu.xml
> > >   create mode 100644 gdbstub/gdb-xml/mips64-cp0.xml
> > >   create mode 100644 gdbstub/gdb-xml/mips64-cpu.xml
> > >   create mode 100644 gdbstub/gdb-xml/mips64-fpu.xml
> > >   create mode 100644 gdbstub/gdb-xml/mips64-r5900.xml
> > >   delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile
> > >   delete mode 100644 tests/tcg/mips/user/isa/r5900/README
> > >   create mode 100644 tests/tcg/mips64el/system/boot.S
> > >   create mode 100644 tests/tcg/mips64el/system/kernel.ld
> > >   create mode 100644 tests/tcg/mips64el/system/meson.build
> > >   create mode 100644 tests/tcg/mips64el/system/test-r5900.py
> > > 
> > 
> > See some test failures, related to gdb:
> > https://github.com/p-b-o/qemu-ci/actions/runs/40776744817/job/123131480244
> 
> Ah hmm I had similar failures due to too old gdb, I might have
> missed to check the version in that container image. IIRC
> Gustavo had similar problem with ARM I'll see how he fixed
> that (I suppose check gdb version and skip the tests).

Hmm, I took a quick look at the failure, and it doesn't ring a bell.

It's also the first time I've looked at the 
tests/tcg/multiarch/gdbstub/registers.py test, so let me take a closer look at
the test. If I find something, I'll report back here.

otoh, I'm happy my email filters are better now and I can easily catch when
somebody cc's me :)


Cheers,
Gustavo


