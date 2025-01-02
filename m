Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EA7E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 05:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTE4i-0007rm-2x; Thu, 02 Jan 2025 00:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1tTE4g-0007rP-Le
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 00:48:50 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1tTE4e-0002ep-Eb
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 00:48:50 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ffd6af012eso155897091fa.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2025 21:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735796925; x=1736401725; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/Tp07To/zWk4vNVF6PoWd6I9ykaeDQEeBkgfTHIMSSI=;
 b=NOMqROvKQmzypwIQv4TXOHADUU7uYjMuWp8IlSF4qi5PibT3snXed8m+pTAUZ6MBCc
 yMBEuwTDckeHyP0bfUMEZcOL0gEuPQ2mmpqAOfWO3ZgI9xJO+wHnqvYbk0bWmRi/xcLl
 uEbfK7wAP/Zda5I2VKhOsMGQ7FPe/VT2erLyBv1obW9okRiJ8mPcFzBSjvlvoeFOXvz3
 W79ew1DaNpXSdEk8XdN9/G18Io8TQ65HAMP9chvY/vSR6VJMdfs8KVGLaEDQnMreWfqs
 IRVtOnxcWFGV0/JF7AQU0F0rVSVZ9q9ThZk0k5pJV4KFoTs7eEQ9Kxwj6O6gX7ROW1n8
 6v4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735796925; x=1736401725;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Tp07To/zWk4vNVF6PoWd6I9ykaeDQEeBkgfTHIMSSI=;
 b=tkRlZ0eZt2dsI0HCDt9A9ZvN5u2KA5BjH1jE4jfSK/h6JGlkaRQeQ1E+h0HzgLuKgm
 fovVJHlXmeFSVIrfUjOjfOqkd6DEh4gZ4hUhMcW/eDe93rCxmmQxGOI8YT7sQDqetEpw
 fsZJ0T94NGQ/QnoF824mlplztFlw/q6x8+bxAsvsosJsluVEdlqzRl4Msicq/MWHBvQI
 ANRJ2ikfNeEBrbyNSYkAuC5GX92+GdMKCNvdUx0jYU8Z8YCwrNI8bX/xVlSXSyzcmZpH
 6NsAMW3onvj6FywdPwbgkAje06uIjMqIQON7eevohCkXY4JVpdbt9CjL+ryhxB/INHBG
 ksqw==
X-Gm-Message-State: AOJu0Yye+lxKTbU+XMPiy6bntn0UyutqhaDIwZZ7R+QU9NHXyZvEzqau
 e6KV6di6YtV/jR1QkmZaiirMr2u1aWlXAc09Y2YDgqcc12xIEyZcWuyx60V0hyyz4p2uAU1vAmP
 9yJ2ymfp4IVJI9Oc4sWwVeJDn74fmkaElQ2/L8Tqbtw==
X-Gm-Gg: ASbGncsXUKeu/uWOZdSeFyRr5vo1K+kL+kJ+FA3VUa4KMO3aHubPOGRAb/BCs9tDh2w
 1ZF30GJwASD3veSzTsivfKxDCg1mAOatzlyt5CQ==
X-Google-Smtp-Source: AGHT+IHB+mi1du6PakMdv/PclVCfO7264jtGxk7oTupF5CzwLlxHvcD2V5qUp4fJ58Tm89C6GFuXkrDi0G3r6r8eFX0=
X-Received: by 2002:a2e:be88:0:b0:2ff:8e69:77d7 with SMTP id
 38308e7fff4ca-30468591d06mr143325941fa.20.1735796924946; Wed, 01 Jan 2025
 21:48:44 -0800 (PST)
MIME-Version: 1.0
From: Liu Jaloo <liu.jaloo@gmail.com>
Date: Thu, 2 Jan 2025 13:49:59 +0800
Message-ID: <CAOYM0N2sXVBkPz64J44kFGPhdSq+qvheQD-yy53trAjv0NDh0w@mail.gmail.com>
Subject: which test.hex is right for qemu-microbit?
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000001d2053062ab2b70a"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=liu.jaloo@gmail.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000001d2053062ab2b70a
Content-Type: text/plain; charset="UTF-8"

in qemu branch statble-9.2

> $ ./build/qemu-system-arm -M microbit -device
> loader,file=/path/to/heart-hearts-makecode.hex
>
Segmentation fault


about the error, gdb backtrace like this:

> bash-5.1$ gdb ./build/qemu-system-arm
> GNU gdb (GDB) 11.2
> Copyright (C) 2022 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <
> http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> Type "show copying" and "show warranty" for details.
> This GDB was configured as "x86_64-slackware-linux".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <https://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
>     <http://www.gnu.org/software/gdb/documentation/>.
>
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from ./build/qemu-system-arm...
> warning: File "/home/jaloo/slackware/qemu/qemu/.gdbinit" auto-loading has
> been declined by your `auto-load safe-path' set to
> "$debugdir:$datadir/auto-load".
> To enable execution of this file add
>         add-auto-load-safe-path /home/jaloo/slackware/qemu/qemu/.gdbinit
> line to your configuration file "/home/jaloo/.config/gdb/gdbinit".
> To completely disable this security protection add
>         set auto-load safe-path /
> line to your configuration file "/home/jaloo/.config/gdb/gdbinit".
> For more information about this security protection see the
> --Type <RET> for more, q to quit, c to continue without paging--
> "Auto-loading safe path" section in the GDB manual.  E.g., run from the
> shell:
>         info "(gdb)Auto-loading safe path"
> (gdb) r -M microbit -device
> loader,file=../microbit/heart-hearts-makecode.hex
> Starting program: /home/jaloo/slackware/qemu/qemu/build/qemu-system-arm -M
> microbit -device loader,file=../microbit/heart-hearts-makecode.hex
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> [New Thread 0x7ffff228d640 (LWP 2380)]
> [New Thread 0x7ffff190a640 (LWP 2382)]
>
> Thread 1 "qemu-system-arm" received signal SIGSEGV, Segmentation fault.
> 0x00007ffff60e53d1 in __memmove_avx_unaligned_erms () from /lib64/libc.so.6
> (gdb) bt
> #0  0x00007ffff60e53d1 in __memmove_avx_unaligned_erms () at
> /lib64/libc.so.6
> #1  0x0000555556037ed9 in address_space_write_rom_internal
>     (as=0x555557afe160, addr=0, attrs=..., ptr=0x555557de8290,
> len=1313804, type=WRITE_DATA) at ../system/physmem.c:3040
> #2  0x0000555556037fa7 in address_space_write_rom
>     (as=0x555557afe160, addr=0, attrs=..., buf=0x555557de8290, len=1313804)
>     at ../system/physmem.c:3060
> #3  0x0000555555977704 in rom_reset (unused=0x0) at
> ../hw/core/loader.c:1252
> #4  0x0000555555986644 in legacy_reset_hold
>     (obj=0x5555576c12c0, type=RESET_TYPE_COLD) at ../hw/core/reset.c:76
> #5  0x00005555560a3938 in resettable_phase_hold
>     (obj=0x5555576c12c0, opaque=0x0, type=RESET_TYPE_COLD)
>     at ../hw/core/resettable.c:162
> #6  0x00005555560a2049 in resettable_container_child_foreach
>     (obj=0x555557a2a9f0, cb=0x5555560a3820 <resettable_phase_hold>,
> opaque=0x0, type=RESET_TYPE_COLD) at ../hw/core/resetcontainer.c:54
> #7  0x00005555560a3687 in resettable_child_foreach
>     (rc=0x5555578ced10, obj=0x555557a2a9f0, cb=0x5555560a3820
> <resettable_phase_hold>, opaque=0x0, type=RESET_TYPE_COLD) at
> ../hw/core/resettable.c:92
> #8  0x00005555560a38dd in resettable_phase_hold
>     (obj=0x555557a2a9f0, opaque=0x0, type=RESET_TYPE_COLD)
>     at ../hw/core/resettable.c:155
> #9  0x00005555560a353c in resettable_assert_reset
> --Type <RET> for more, q to quit, c to continue without paging--
>     (obj=0x555557a2a9f0, type=RESET_TYPE_COLD) at
> ../hw/core/resettable.c:58
> #10 0x00005555560a3494 in resettable_reset
>     (obj=0x555557a2a9f0, type=RESET_TYPE_COLD) at
> ../hw/core/resettable.c:45
> #11 0x000055555598696e in qemu_devices_reset (type=RESET_TYPE_COLD)
>     at ../hw/core/reset.c:176
> #12 0x0000555555cf5826 in qemu_system_reset (reason=SHUTDOWN_CAUSE_NONE)
>     at ../system/runstate.c:527
> #13 0x000055555597fb9d in qdev_machine_creation_done ()
>     at ../hw/core/machine.c:1689
> #14 0x0000555555cfd197 in qemu_machine_creation_done
>     (errp=0x5555575be0e0 <error_fatal>) at ../system/vl.c:2690
> #15 0x0000555555cfd30f in qmp_x_exit_preconfig
>     (errp=0x5555575be0e0 <error_fatal>) at ../system/vl.c:2720
> #16 0x0000555555cffce8 in qemu_init (argc=5, argv=0x7fffffffdd08)
>     at ../system/vl.c:3753
> #17 0x00005555562479f0 in main (argc=5, argv=0x7fffffffdd08)
>     at ../system/main.c:47


according to docs/system/arm/nrf.rst

> $ qemu-system-arm -M microbit -device loader,file=test.hex


from the page https://microbit.org/projects/make-it-code-it/heart/ download
the hex file :

> wget https://microbit.org/downloads/heart-hearts-makecode.hex

--0000000000001d2053062ab2b70a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>in qemu branch statble-9.2 <br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">$ ./build/qemu-system-arm -M microbit -de=
vice loader,file=3D/path/to/heart-hearts-makecode.hex=C2=A0 <br></blockquot=
e><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Segmentation fault</blo=
ckquote><div>=C2=A0</div><div>about the error, gdb backtrace like this:</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">bash-5.1$ gdb ./build/q=
emu-system-arm<br>GNU gdb (GDB) 11.2<br>Copyright (C) 2022 Free Software Fo=
undation, Inc.<br>License GPLv3+: GNU GPL version 3 or later &lt;<a href=3D=
"http://gnu.org/licenses/gpl.html">http://gnu.org/licenses/gpl.html</a>&gt;=
<br>This is free software: you are free to change and redistribute it.<br>T=
here is NO WARRANTY, to the extent permitted by law.<br>Type &quot;show cop=
ying&quot; and &quot;show warranty&quot; for details.<br>This GDB was confi=
gured as &quot;x86_64-slackware-linux&quot;.<br>Type &quot;show configurati=
on&quot; for configuration details.<br>For bug reporting instructions, plea=
se see:<br>&lt;<a href=3D"https://www.gnu.org/software/gdb/bugs/">https://w=
ww.gnu.org/software/gdb/bugs/</a>&gt;.<br>Find the GDB manual and other doc=
umentation resources online at:<br>=C2=A0 =C2=A0 &lt;<a href=3D"http://www.=
gnu.org/software/gdb/documentation/">http://www.gnu.org/software/gdb/docume=
ntation/</a>&gt;.<br><br>For help, type &quot;help&quot;.<br>Type &quot;apr=
opos word&quot; to search for commands related to &quot;word&quot;...<br>Re=
ading symbols from ./build/qemu-system-arm...<br>warning: File &quot;/home/=
jaloo/slackware/qemu/qemu/.gdbinit&quot; auto-loading has been declined by =
your `auto-load safe-path&#39; set to &quot;$debugdir:$datadir/auto-load&qu=
ot;.<br>To enable execution of this file add<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 add-auto-load-safe-path /home/jaloo/slackware/qemu/qemu/.gdbinit<br>line t=
o your configuration file &quot;/home/jaloo/.config/gdb/gdbinit&quot;.<br>T=
o completely disable this security protection add<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 set auto-load safe-path /<br>line to your configuration file &quot;/=
home/jaloo/.config/gdb/gdbinit&quot;.<br>For more information about this se=
curity protection see the<br>--Type &lt;RET&gt; for more, q to quit, c to c=
ontinue without paging--<br>&quot;Auto-loading safe path&quot; section in t=
he GDB manual.=C2=A0 E.g., run from the shell:<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 info &quot;(gdb)Auto-loading safe path&quot;<br>(gdb) r -M microbit -de=
vice loader,file=3D../microbit/heart-hearts-makecode.hex<br>Starting progra=
m: /home/jaloo/slackware/qemu/qemu/build/qemu-system-arm -M microbit -devic=
e loader,file=3D../microbit/heart-hearts-makecode.hex<br>[Thread debugging =
using libthread_db enabled]<br>Using host libthread_db library &quot;/lib64=
/libthread_db.so.1&quot;.<br>[New Thread 0x7ffff228d640 (LWP 2380)]<br>[New=
 Thread 0x7ffff190a640 (LWP 2382)]<br><br>Thread 1 &quot;qemu-system-arm&qu=
ot; received signal SIGSEGV, Segmentation fault.<br>0x00007ffff60e53d1 in _=
_memmove_avx_unaligned_erms () from /lib64/libc.so.6<br>(gdb) bt<br>#0 =C2=
=A00x00007ffff60e53d1 in __memmove_avx_unaligned_erms () at /lib64/libc.so.=
6<br>#1 =C2=A00x0000555556037ed9 in address_space_write_rom_internal<br>=C2=
=A0 =C2=A0 (as=3D0x555557afe160, addr=3D0, attrs=3D..., ptr=3D0x555557de829=
0, len=3D1313804, type=3DWRITE_DATA) at ../system/physmem.c:3040<br>#2 =C2=
=A00x0000555556037fa7 in address_space_write_rom<br>=C2=A0 =C2=A0 (as=3D0x5=
55557afe160, addr=3D0, attrs=3D..., buf=3D0x555557de8290, len=3D1313804)<br=
>=C2=A0 =C2=A0 at ../system/physmem.c:3060<br>#3 =C2=A00x0000555555977704 i=
n rom_reset (unused=3D0x0) at ../hw/core/loader.c:1252<br>#4 =C2=A00x000055=
5555986644 in legacy_reset_hold<br>=C2=A0 =C2=A0 (obj=3D0x5555576c12c0, typ=
e=3DRESET_TYPE_COLD) at ../hw/core/reset.c:76<br>#5 =C2=A00x00005555560a393=
8 in resettable_phase_hold<br>=C2=A0 =C2=A0 (obj=3D0x5555576c12c0, opaque=
=3D0x0, type=3DRESET_TYPE_COLD)<br>=C2=A0 =C2=A0 at ../hw/core/resettable.c=
:162<br>#6 =C2=A00x00005555560a2049 in resettable_container_child_foreach<b=
r>=C2=A0 =C2=A0 (obj=3D0x555557a2a9f0, cb=3D0x5555560a3820 &lt;resettable_p=
hase_hold&gt;, opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/resetcon=
tainer.c:54<br>#7 =C2=A00x00005555560a3687 in resettable_child_foreach<br>=
=C2=A0 =C2=A0 (rc=3D0x5555578ced10, obj=3D0x555557a2a9f0, cb=3D0x5555560a38=
20 &lt;resettable_phase_hold&gt;, opaque=3D0x0, type=3DRESET_TYPE_COLD) at =
../hw/core/resettable.c:92<br>#8 =C2=A00x00005555560a38dd in resettable_pha=
se_hold<br>=C2=A0 =C2=A0 (obj=3D0x555557a2a9f0, opaque=3D0x0, type=3DRESET_=
TYPE_COLD)<br>=C2=A0 =C2=A0 at ../hw/core/resettable.c:155<br>#9 =C2=A00x00=
005555560a353c in resettable_assert_reset<br>--Type &lt;RET&gt; for more, q=
 to quit, c to continue without paging--<br>=C2=A0 =C2=A0 (obj=3D0x555557a2=
a9f0, type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:58<br>#10 0x000055=
55560a3494 in resettable_reset<br>=C2=A0 =C2=A0 (obj=3D0x555557a2a9f0, type=
=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:45<br>#11 0x000055555598696e=
 in qemu_devices_reset (type=3DRESET_TYPE_COLD)<br>=C2=A0 =C2=A0 at ../hw/c=
ore/reset.c:176<br>#12 0x0000555555cf5826 in qemu_system_reset (reason=3DSH=
UTDOWN_CAUSE_NONE)<br>=C2=A0 =C2=A0 at ../system/runstate.c:527<br>#13 0x00=
0055555597fb9d in qdev_machine_creation_done ()<br>=C2=A0 =C2=A0 at ../hw/c=
ore/machine.c:1689<br>#14 0x0000555555cfd197 in qemu_machine_creation_done<=
br>=C2=A0 =C2=A0 (errp=3D0x5555575be0e0 &lt;error_fatal&gt;) at ../system/v=
l.c:2690<br>#15 0x0000555555cfd30f in qmp_x_exit_preconfig<br>=C2=A0 =C2=A0=
 (errp=3D0x5555575be0e0 &lt;error_fatal&gt;) at ../system/vl.c:2720<br>#16 =
0x0000555555cffce8 in qemu_init (argc=3D5, argv=3D0x7fffffffdd08)<br>=C2=A0=
 =C2=A0 at ../system/vl.c:3753<br>#17 0x00005555562479f0 in main (argc=3D5,=
 argv=3D0x7fffffffdd08)<br>=C2=A0 =C2=A0 at ../system/main.c:47</blockquote=
><div><br></div><div>according to docs/system/arm/nrf.rst</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">$ qemu-system-arm -M microbit -device=
 loader,file=3Dtest.hex</blockquote><div><br></div><div>from the page <a hr=
ef=3D"https://microbit.org/projects/make-it-code-it/heart/">https://microbi=
t.org/projects/make-it-code-it/heart/</a> download the hex file :<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">wget <a href=3D"https://m=
icrobit.org/downloads/heart-hearts-makecode.hex">https://microbit.org/downl=
oads/heart-hearts-makecode.hex</a></blockquote><div><br></div><div>=C2=A0<b=
r></div></div>

--0000000000001d2053062ab2b70a--

