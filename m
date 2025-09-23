Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03ABFCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 20:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v19do-0002js-T4; Tue, 23 Sep 2025 16:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1v19dm-0002hz-ND
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 16:29:34 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1v19dj-0008G7-CK
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 16:29:34 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 5EEB560C1A
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 22:29:20 +0200 (CEST)
Received: (qmail 15652 invoked by uid 990); 23 Sep 2025 20:29:20 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Tue, 23 Sep 2025 22:29:20 +0200
MIME-Version: 1.0
Date: Tue, 23 Sep 2025 20:29:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <nenut@skiff.uberspace.de>
Message-ID: <f7f5cfabe46ede28ea57e49ce36c617aa774ec0b@skiff.uberspace.de>
TLS-Required: No
Subject: Re: [PATCH v6 23/25] tests: add plugin asserting correctness of
 discon event's to_pc
To: "Julian Ganz" <neither@nut.email>, "=?utf-8?B?QWxleCBCZW5uw6ll?="
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Pierrick Bouvier" <pierrick.bouvier@linaro.org>,
 "Alexandre Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour"
 <ma.mandourr@gmail.com>
In-Reply-To: <51342318ee32c932dc2a867c808989ea627d874f@nut.email>
References: <cover.1757018626.git.neither@nut.email>
 <073cad7dd8ae509ff64a2835fd146833b60c1f60.1757018626.git.neither@nut.email>
 <87segf69f6.fsf@draig.linaro.org>
 <51342318ee32c932dc2a867c808989ea627d874f@nut.email>
X-Rspamd-Bar: +
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.259042) MIME_GOOD(-0.1)
X-Rspamd-Score: 1.140957
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=nenut@skiff.uberspace.de; helo=mailgate01.uberspace.is
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Hi again,

September 22, 2025 at 12:11 PM, "Julian Ganz" wrote:
> September 21, 2025 at 6:46 PM, "Alex Benn=C3=A9e" wrote:
> > Julian Ganz <neither@nut.email> writes:
> >  + report =3D g_string_new(NULL);
> >  + g_string_append_printf(report,
> >  + "Discon %s PC mismatch on VCPU %d\nExpected: %"
> >  + PRIx64"\nEncountered: %"PRIx64"\nExecuted Last: %"
> >  + PRIx64"\nEvent type: %s\n",
> >  + pc_name, vcpu_index, expected, encountered, last,
> >  + discon_type_name);
> >  + qemu_plugin_outs(report->str);
> >=20=20
>=20>  I think we might want to flush here because
> >=20
>=20Yes we do. I probably (incorrectly) assumed `qemu_plugin_outs` alread=
y
> did that.

Sorry to ask, but is there any way to flush the associated output stream
from an plugin? Or in general? I didn't find anything other than
`qemu_plugin_outs` regarding output. And that calls `qemu_log_mask`...

> >  This is firing on:
> >=20=20
>=20>  =F0=9F=95=9917:35:50 alex@draig:tests/tcg/i386-linux-user on =EE=
=82=A0 review/tcg-discon-v6 [$!?]=20
>=20>  =E2=9E=9C make run-plugin-catch-syscalls-with-libdiscons.so V=3D1
> >  timeout -s KILL --foreground 120 env QEMU=3D/home/alex/lsrc/qemu.git=
/builds/sanitisers/qemu-i386 /home/alex/lsrc/qemu.git/builds/sanitisers/q=
emu-i386 -plugin ../plugins/libdiscons.so -d plugin -D catch-syscalls-wit=
h-libdiscons.so.pout catch-syscalls > run-plugin-catch-syscalls-with-libd=
iscons.so.out
> >  Aborted
> >  make: *** [Makefile:226: run-plugin-catch-syscalls-with-libdiscons.s=
o] Error 134
> >  =F0=9F=95=9917:35:52 alex@draig:tests/tcg/i386-linux-user on =EE=82=
=A0 review/tcg-discon-v6 [$!?] [=F0=9F=94=B4 USAGE]=20
>=20>  =E2=9C=97
> >=20=20
>=20>  although it never gets to the point of reporting what failed:
> >=20=20
>=20>  Thread 1 "qemu-i386" hit Breakpoint 1, __GI_abort () at ./stdlib/a=
bort.c:72
> >  warning: 72 ./stdlib/abort.c: No such file or directory
> >  (gdb) bt
> >  #0 __GI_abort () at ./stdlib/abort.c:72
> >  #1 0x00007ffff630874d in report_mismatch (pc_name=3D0x7ffff630a220 "=
target", vcpu_index=3D0, type=3DQEMU_PLUGIN_DISCON_EXCEPTION, last=3D1345=
74955, expected=3D134574953,=20
>=20>  encountered=3D134574955) at ../../tests/tcg/plugins/discons.c:89
> >  #2 0x00007ffff6308c0d in insn_exec (vcpu_index=3D0, userdata=3D0x0) =
at ../../tests/tcg/plugins/discons.c:132
> >  #3 0x00007fffea431114 in code_gen_buffer ()
> >  #4 0x000055555577b0a6 in cpu_tb_exec (cpu=3D0x529000005200, itb=3D0x=
7fffea431000 <code_gen_buffer+200659>, tb_exit=3D0x7ffff49c9530) at ../..=
/accel/tcg/cpu-exec.c:438
> >  #5 0x000055555577c92f in cpu_loop_exec_tb (cpu=3D0x529000005200, tb=
=3D0x7fffea431000 <code_gen_buffer+200659>, pc=3D134574955, last_tb=3D0x7=
ffff49c9540, tb_exit=3D0x7ffff49c9530)
> >  at ../../accel/tcg/cpu-exec.c:871
> >  #6 0x000055555577d151 in cpu_exec_loop (cpu=3D0x529000005200, sc=3D0=
x7ffff483a740) at ../../accel/tcg/cpu-exec.c:981
> >  #7 0x000055555577d2fe in cpu_exec_setjmp (cpu=3D0x529000005200, sc=
=3D0x7ffff483a740) at ../../accel/tcg/cpu-exec.c:998
> >  #8 0x000055555577d4c8 in cpu_exec (cpu=3D0x529000005200) at ../../ac=
cel/tcg/cpu-exec.c:1024
> >  #9 0x00005555557bfc83 in cpu_loop (env=3D0x529000007dd0) at ../../li=
nux-user/i386/cpu_loop.c:215
> >  #10 0x00005555558ee3e1 in main (argc=3D4, argv=3D0x7fffffffe688, env=
p=3D0x7fffffffe6b0) at ../../linux-user/main.c:1038
> >  (gdb) f 1
> >  #1 0x00007ffff630874d in report_mismatch (pc_name=3D0x7ffff630a220 "=
target", vcpu_index=3D0, type=3DQEMU_PLUGIN_DISCON_EXCEPTION, last=3D1345=
74955, expected=3D134574953,=20
>=20>  encountered=3D134574955) at ../../tests/tcg/plugins/discons.c:89
> >  89 g_abort();
> >  (gdb) p report
> >  $1 =3D (GString *) 0x50300002bf00
> >  (gdb) p report->Str
> >  There is no member named Str.
> >  (gdb) p report->str
> >  $2 =3D (gchar *) 0x51100001fbc0 "Discon target PC mismatch on VCPU 0=
\nExpected: 8057369\nEncountered: 805736b\nExecuted Last: 805736b\nEvent =
type: exception\n"
> >  (gdb)=20
>=20>=20=20
>=20>  I think this is where it is going wrong:
> >=20=20
>=20>  IN: _dl_early_allocate
> >  0x0805736b: 89 c2 movl %eax, %edx
> >  0x0805736d: 8d 1c 28 leal (%eax, %ebp), %ebx
> >  0x08057370: 89 c8 movl %ecx, %eax
> >  0x08057372: cd 80 int $0x80
> >=20
>=20Thanks! I'll have a closer look.

I probably didn't configure the target I need for this test on my
private machine (which uses musl, so some targets are awkward). Could it
be that this doesn't run in system emulation mode and the exception is
somehow handled natively? I did not account for that possibility and I
don't think I'll get the testing plugin to do anything meaningful
outside system emulation.

I will keep on looking into this.

Regards,
Julian

