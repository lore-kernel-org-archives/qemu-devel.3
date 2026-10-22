Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488BE606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pTA2MFSI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzwG-0002bh-PR; Thu, 22 Oct 2026 17:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJzwE-0002b3-IW
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:03:02 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJzwC-0002Pp-5R
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:03:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1dfd49525so1717065e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792702977; x=1793307777; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=R+rQuD/B0jIaS2gTYp4bXInpIwuDdYrdxm4BEHtE4JU=;
 b=pTA2MFSI6gBfQgmTeDqy7rHsukYWFvvzHRWoDdQ+fdTacDM+NGEICsKK81xqs/Nc0R
 MhDzBCO4Uis+kr++a84/yZdQw0lCbdFAUvI7srhmTu8TDKoj78b7nvGW3lwM5A84GevT
 EwlOPO7b4sGyXqObvFMRK5YFtYoFvT5L3u3gsPQDb6J+BLI3XuJThNyfVJdsezUBLONR
 85IZxgGafZgRMZ3AAgCW7HWU8X1EAUWgxC8ReVc/lcGpZlEdFyRB1Pr57SvgiqSAA5Uz
 mhA6to8GmBZjsB8hR3HFwk7H/1pHIhoZXMniVCe2JMi0ik3+AGa6X+ZrVxWbuewHYhrQ
 9rZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792702977; x=1793307777;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R+rQuD/B0jIaS2gTYp4bXInpIwuDdYrdxm4BEHtE4JU=;
 b=FSwiWQCRXHN6w2DVPKG7BQRQQMZow5mKkxpJxC70DNWAnup+0Ue0HqkroNgS75NKT7
 DMb1Mk1/HObYd2FE9+GvRXGHoQvwuCseK4kGlI2iES4xhDy9UiJq6MhEXpWkx+LaJXpY
 sd/wHcf471m+SX/JObLBpNYxbDmt+kTOYPrbXsnU9MEwXXoKOy5wMAeSUNpQQLZbzZaF
 6tsutMdiE2utngkfksW3u/B1w5zBrWB5hCi1BNmH8+JUpade8/zhxZ3S8xA6PDkq0i1G
 8yJGf6qB01j4RZh1mL6hv0SSVcwS8cr5e5rfDff4pPmzqL1byC9Hue88o8Wx1S4JwfUk
 xGGQ==
X-Gm-Message-State: AFq9FYJfSFW2S3c8kwZI72EAgis5rtX3NnChxpQyGP7w++7h9mN7sJ14
 VByjXr4hMZ15RiZUS5ByJZXT+BI4CO5NjvEbc9+/tbQ3FsNo8BZt8L/ZO+aZ+GKgqrQ=
X-Gm-Gg: AYBFou2xwsa32EEVZ+Y4drJaRoiK4cw+AGLW/aanrI4WhuDAS6BhM0yfEuXb8WGlrRU
 LemZVWwknNOEOYeoCmwDOMxpgEjpTTzjxFLhgPJFQcFAzBLIctR6hRSQiBKx19inO11mN3zcgxg
 pXMnK91VSLbIo4be6PV3Bvh0Hs3Jons8CIMMRZVuuDgRBAv/GHgXcNIhl9LUniWBLm238uL9X4F
 syYlNF45+vOfISr5kXSL6LCY6IOXJqWlnYU8Y3jc73paTU7SYQa42AAoYHLyRGbhie4NzbRo2Cp
 oDdP54WdUf3P6kk2zfBID/QruIGein0ME2C3fw8WGPfniylmpmfQexuqLS4bfywvFU5DugSmW6u
 4o4Z1w6tJ3WeLoph7Ef0caN/jMqylRzg4BZ4N/qmJgMfP5NIBdvrd1QGm2CjAx4lo5WrdSj18nr
 s37NxhpMGOovbRIXf8SnQfFaXK2yG/dXFiuMCl2ppxghVoPxT5P1X41GS4du4B8heBPAH1vJAK5
 Aivt2suzmqa5/hoqrmCy55lzg2hqLFo8u63zAjBqEyeB8I9m1cP70E=
X-Received: by 2002:a05:600c:4e8a:b0:4a1:d675:b031 with SMTP id
 5b1f17b1804b1-4a211eeea21mr3906255e9.6.1792702977040; 
 Thu, 22 Oct 2026 14:02:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38055da4sm422370f8f.43.2026.10.22.14.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:02:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7B0A85F871;
 Thu, 22 Oct 2026 22:02:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Song Gao <17746591750@163.com>,
 Bibo Mao <maobibo@loongson.cn>,  xianglai li <lixianglai@loongson.cn>
Subject: Re: tests/tcg: how should we skip a gdb test if the host's gdb
 isn't new enough?
In-Reply-To: <CAFEAcA846O2jbpDvy+zUnxrpfxKLQpjhHq14zBOGQMC6caXOJw@mail.gmail.com>
 (Peter Maydell's message of "Thu, 22 Oct 2026 16:51:42 +0100")
References: <CAFEAcA846O2jbpDvy+zUnxrpfxKLQpjhHq14zBOGQMC6caXOJw@mail.gmail.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Thu, 22 Oct 2026 22:02:55 +0100
Message-ID: <87wlr9xxc0.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Peter Maydell <peter.maydell@linaro.org> writes:

> I noticed that the gdbstub/memory.py test hangs for me when it tries
> to test the loongarch64 architecture. Running it as a standalone
> test (which is what "make check" does) hangs too (transcript at
> end of mail).
>
> I'm guessing that the fundamental cause of this is that my host
> gdb doesn't like talking to the gdbstub, and reports in the log:
> "warning: Architecture rejected target-supplied description".
> (The hang seems to be because we continually re-execute a
> store insn that provokes a debug exception -- presumably the
> gdb is not doing what it should at its end and reporting
> and then deleting the watchpoint before continuing, so we just
> keep reporting the watchpoint hit to gdb endlessly.)
>
> The gdb is the gdb-multiarch Ubuntu one; --version reports
> "GNU gdb (Ubuntu 15.1-1ubuntu1~24.04.1) 15.1"

We used to check for 9.1 but all checking is done in meson since
00eb02b4f5f5 (configure: directly pass gdb path as a meson option). I
think you want to look for stanzas like:

  gdb_feat_version =3D {
    'sme-tiles': '14.1',
    'mte': '15.1',
    'mte-baremetal': '16.0',
  }


>
> How in the gdbstub test framework should we detect "this gdb
> isn't good enough for this architecture/test" and skip tests?
>

We could also do some architecture feature checking in
scripts/probe-gdb-support.py but version introspection is aboutthe best
we have these days.

>
> =3D=3D=3Dbegin=3D=3D=3D
> $ /home/pm215/qemu/tests/tcg/../guest-debug/run-test.py --gdb
> /usr/bin/gdb-multiarch --qemu
> /home/pm215/qemu/build/loongarch-dbg/qemu-system-loongarch64 --qargs
> '-display none -serial stdio -kernel' --bin
> build/loongarch-dbg/tests/tcg/loongarch64-softmmu-memory.test --test
> /home/pm215/qemu/build/loongarch-dbg/../../tests/tcg/multiarch/system/../=
gdbstub/memory.py
> QEMU CMD: /home/pm215/qemu/build/loongarch-dbg/qemu-system-loongarch64
> -display none -serial stdio -kernel
> build/loongarch-dbg/tests/tcg/loongarch64-softmmu-memory.test -S -gdb
> unix:path=3D/tmp/tmpodrh2895qemu-gdbstub/gdbstub.socket,server=3Don
> qemu-system-loongarch64: -gdb
> unix:path=3D/tmp/tmpodrh2895qemu-gdbstub/gdbstub.socket,server=3Don: info:
> QEMU waiting for connection on:
> disconnected:unix:/tmp/tmpodrh2895qemu-gdbstub/gdbstub.socket,server=3Don
> GDB CMD: /usr/bin/gdb-multiarch
> build/loongarch-dbg/tests/tcg/loongarch64-softmmu-memory.test -q -n
> -batch -ex 'set pagination off' -ex 'set confirm off' -ex 'target
> remote /tmp/tmpodrh2895qemu-gdbstub/gdbstub.socket' -x
> /home/pm215/qemu/build/loongarch-dbg/../../tests/tcg/multiarch/system/../=
gdbstub/memory.py
> warning: Architecture rejected target-supplied description
> 0x000000001c000000 in ?? ()
> ATTACHED: Loongarch64
> Checking we can step the first few instructions
> 0x000000001c000004 in ?? ()
> 0x000000001c000008 in ?? ()
> 0x000000001c00000c in ?? ()
> PASS: single step in boot code
> Setup catch-all for _exit
> Breakpoint 1 at 0x220000: file
> ../../tests/tcg/loongarch64/system/boot.S, line 24.
> Breakpoint 2 at 0x2015ec: file
> /home/pm215/qemu/tests/tcg/multiarch/system/memory.c, line 510.
>
> Breakpoint 2, main () at
> /home/pm215/qemu/tests/tcg/multiarch/system/memory.c:510
> 510         bool ok =3D true;
> PASS: break @ 0x2015ec <main+16> ({int (void)} 0x2015dc <main> 1 hits)
> Hardware access (read/write) watchpoint 3: test_data[128]
> Test data start: 0x238000
> Test data end: 0x23c000
> Filling test area with u8 (238000):.
> Hardware access (read/write) watchpoint 3: test_data[128]
>
> Value =3D 0 '\000'
> init_test_data_u8 (unused_offset=3D0) at
> /home/pm215/qemu/tests/tcg/multiarch/system/memory.c:77
> 77              *ptr++ =3D BYTE_NEXT(count);
> PASS: awatch for test_data[128]
> Hardware read watchpoint 4: test_data[128]
> .........................................................................=
......................................................done
> 16384 @ 23c000
> Reading u16 from 0x238000 (offset 0):.
> Hardware read watchpoint 4: test_data[128]
>
> Value =3D 128 '\200'
> read_test_data_u16 (offset=3D0) at
> /home/pm215/qemu/tests/tcg/multiarch/system/memory.c:213
> 213             word =3D *ptr++;
> PASS: rwatch for test_data[128]
> Hardware watchpoint 5: test_data[128]
> ...............................................................done
> 8192 @ 23c000
> Reading u32 from 0x238000 (offset
> 0):................................done 4096 @ 23c000
> Reading u64 from 0x238000 (offset 0):................done 2048 @ 23c000
> Filling test area with u16 (offset 0, 238000):.
> =3D=3D=3Dendit=3D=3D=3D
>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

