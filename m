Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F499CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 10:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0dWH-0000Gt-5n; Mon, 22 Sep 2025 06:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v0dWF-0000GO-8e
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:11:39 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v0dWC-0007U0-DW
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:11:38 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id BF2FF60B57
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 12:11:23 +0200 (CEST)
Received: (qmail 27313 invoked by uid 990); 22 Sep 2025 10:11:23 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 22 Sep 2025 12:11:23 +0200
MIME-Version: 1.0
Date: Mon, 22 Sep 2025 10:11:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <51342318ee32c932dc2a867c808989ea627d874f@nut.email>
TLS-Required: No
Subject: Re: [PATCH v6 23/25] tests: add plugin asserting correctness of 
 discon event's to_pc
To: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Pierrick Bouvier" <pierrick.bouvier@linaro.org>,
 "Alexandre Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour"
 <ma.mandourr@gmail.com>
In-Reply-To: <87segf69f6.fsf@draig.linaro.org>
References: <cover.1757018626.git.neither@nut.email>
 <073cad7dd8ae509ff64a2835fd146833b60c1f60.1757018626.git.neither@nut.email>
 <87segf69f6.fsf@draig.linaro.org>
X-Rspamd-Bar: +
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.000336) MIME_GOOD(-0.1)
X-Rspamd-Score: 1.399663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=zTtRtbb5ThRRaDTZZ8a4SvnVD2pktMvpvt/CeUQ9esk=;
 b=FlN8BKc9jCNF6H/shkPkwJ9AAF7o72jPFKHaz2V2Ktk44RLx70PcC++9S/xE4BgegcSKMkTm99
 frRvTeAjRQ6QxEwwOoGbmrgv9NUi0gHddM2dwfE60aYgEYjwxJ30yN1D+xcU4k1afiNTZv9jHhGG
 NohlGwvW0LdoRDB/bDU6XuuER8TWSUjYzjNs4N6ndMB/925Vo+c6GSYokPxnpdjDDjsVasMM6KBH
 d+nRz3vZX+vb9OlNCV6lGkFFsFIZFd45cQ4MI9gQEg+LMuVwMRDLrU3sFy5cJ4NH3Ys/XWtx76qH
 ZPRQgxiQQXT1gnr4Bwizljc6avFWfJ5c0AfB37hPOrbWkAQGLcKQLxlBqRNoe/NEx6cGTKmyInCt
 xhPM61aE095+e4I201oNAeZ6YEJQ9fdPAgNvklxcLJiC8eWiVZrTpd5HZO8/wXd7thFLGfDZzphh
 /Xd3n3iXI/EZ4MHFDn9sJE0UMIwpOYpx+EnxwJl5wasF2BvjnoY8uHyimSBKJ4uLThC68MupbduF
 1dJYNwsnFjsYbO72JnH8OxpzkzJ/E38HtOrqOmQDN0rs7ThVQNzeLy43+ne0UZImbiVgSfvz2NBF
 nxKPnLlwRX17akB9L3CWL89EDtqSd5cxVRUN8TSwP1TV2yQiwqb6idMPpppOVAue5gfrpEmX9ZPK
 c=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Alex,

September 21, 2025 at 6:46 PM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org=
 mailto:alex.bennee@linaro.org?to=3D%22Alex%20Benn%C3%A9e%22%20%3Calex.be=
nnee%40linaro.org%3E > wrote:
> Julian Ganz <neither@nut.email> writes:
> >  +static void report_mismatch(const char *pc_name, unsigned int vcpu_=
index,
> >  + enum qemu_plugin_discon_type type, uint64_t last,
> >  + uint64_t expected, uint64_t encountered)
> >  +{
> >  + GString *report;
> >=20
>=20This could be:
>=20
>=20 g_autoptr(GString) buf =3D g_string_new(NULL);

I wanted to avoid doing an allocation regardless of whether we do have
anything to report or not. But I guess a performance plugin isn't
performance critical enough to worry? Anyway, I will have another look
at g_autoptr.

> > + const char *discon_type_name =3D "unknown";
> >  +
> >  + if (addr_eq(expected, encountered)) {
> >  + return;
> >  + }
> >  +
> >  + switch (type) {
> >  + case QEMU_PLUGIN_DISCON_INTERRUPT:
> >  + discon_type_name =3D "interrupt";
> >  + break;
> >  + case QEMU_PLUGIN_DISCON_EXCEPTION:
> >  + discon_type_name =3D "exception";
> >  + break;
> >  + case QEMU_PLUGIN_DISCON_HOSTCALL:
> >  + discon_type_name =3D "hostcall";
> >  + break;
> >  + default:
> >  + break;
> >  + }
> >  +
> >  + report =3D g_string_new(NULL);
> >  + g_string_append_printf(report,
> >  + "Discon %s PC mismatch on VCPU %d\nExpected: %"
> >  + PRIx64"\nEncountered: %"PRIx64"\nExecuted Last: %"
> >  + PRIx64"\nEvent type: %s\n",
> >  + pc_name, vcpu_index, expected, encountered, last,
> >  + discon_type_name);
> >  + qemu_plugin_outs(report->str);
> >=20
>=20I think we might want to flush here because

Yes we do. I probably (incorrectly) assumed `qemu_plugin_outs` already
did that.

>=20
>=20>=20
>=20> + if (abort_on_mismatch) {
> >  + g_abort();
> >  + }
> >=20
>=20This is firing on:
>=20
>=20 =F0=9F=95=9917:35:50 alex@draig:tests/tcg/i386-linux-user on =EE=82=
=A0 review/tcg-discon-v6 [$!?]=20
>=20 =E2=9E=9C make run-plugin-catch-syscalls-with-libdiscons.so V=3D1
>  timeout -s KILL --foreground 120 env QEMU=3D/home/alex/lsrc/qemu.git/b=
uilds/sanitisers/qemu-i386 /home/alex/lsrc/qemu.git/builds/sanitisers/qem=
u-i386 -plugin ../plugins/libdiscons.so -d plugin -D catch-syscalls-with-=
libdiscons.so.pout catch-syscalls > run-plugin-catch-syscalls-with-libdis=
cons.so.out
>  Aborted
>  make: *** [Makefile:226: run-plugin-catch-syscalls-with-libdiscons.so]=
 Error 134
>  =F0=9F=95=9917:35:52 alex@draig:tests/tcg/i386-linux-user on =EE=82=A0=
 review/tcg-discon-v6 [$!?] [=F0=9F=94=B4 USAGE]=20
>=20 =E2=9C=97
>=20
>=20although it never gets to the point of reporting what failed:
>=20
>=20 Thread 1 "qemu-i386" hit Breakpoint 1, __GI_abort () at ./stdlib/abo=
rt.c:72
>  warning: 72 ./stdlib/abort.c: No such file or directory
>  (gdb) bt
>  #0 __GI_abort () at ./stdlib/abort.c:72
>  #1 0x00007ffff630874d in report_mismatch (pc_name=3D0x7ffff630a220 "ta=
rget", vcpu_index=3D0, type=3DQEMU_PLUGIN_DISCON_EXCEPTION, last=3D134574=
955, expected=3D134574953,=20
>=20 encountered=3D134574955) at ../../tests/tcg/plugins/discons.c:89
>  #2 0x00007ffff6308c0d in insn_exec (vcpu_index=3D0, userdata=3D0x0) at=
 ../../tests/tcg/plugins/discons.c:132
>  #3 0x00007fffea431114 in code_gen_buffer ()
>  #4 0x000055555577b0a6 in cpu_tb_exec (cpu=3D0x529000005200, itb=3D0x7f=
ffea431000 <code_gen_buffer+200659>, tb_exit=3D0x7ffff49c9530) at ../../a=
ccel/tcg/cpu-exec.c:438
>  #5 0x000055555577c92f in cpu_loop_exec_tb (cpu=3D0x529000005200, tb=3D=
0x7fffea431000 <code_gen_buffer+200659>, pc=3D134574955, last_tb=3D0x7fff=
f49c9540, tb_exit=3D0x7ffff49c9530)
>  at ../../accel/tcg/cpu-exec.c:871
>  #6 0x000055555577d151 in cpu_exec_loop (cpu=3D0x529000005200, sc=3D0x7=
ffff483a740) at ../../accel/tcg/cpu-exec.c:981
>  #7 0x000055555577d2fe in cpu_exec_setjmp (cpu=3D0x529000005200, sc=3D0=
x7ffff483a740) at ../../accel/tcg/cpu-exec.c:998
>  #8 0x000055555577d4c8 in cpu_exec (cpu=3D0x529000005200) at ../../acce=
l/tcg/cpu-exec.c:1024
>  #9 0x00005555557bfc83 in cpu_loop (env=3D0x529000007dd0) at ../../linu=
x-user/i386/cpu_loop.c:215
>  #10 0x00005555558ee3e1 in main (argc=3D4, argv=3D0x7fffffffe688, envp=
=3D0x7fffffffe6b0) at ../../linux-user/main.c:1038
>  (gdb) f 1
>  #1 0x00007ffff630874d in report_mismatch (pc_name=3D0x7ffff630a220 "ta=
rget", vcpu_index=3D0, type=3DQEMU_PLUGIN_DISCON_EXCEPTION, last=3D134574=
955, expected=3D134574953,=20
>=20 encountered=3D134574955) at ../../tests/tcg/plugins/discons.c:89
>  89 g_abort();
>  (gdb) p report
>  $1 =3D (GString *) 0x50300002bf00
>  (gdb) p report->Str
>  There is no member named Str.
>  (gdb) p report->str
>  $2 =3D (gchar *) 0x51100001fbc0 "Discon target PC mismatch on VCPU 0\n=
Expected: 8057369\nEncountered: 805736b\nExecuted Last: 805736b\nEvent ty=
pe: exception\n"
>  (gdb)=20
>=20
> I think this is where it is going wrong:
>=20
>=20 IN: _dl_early_allocate
>  0x0805736b: 89 c2 movl %eax, %edx
>  0x0805736d: 8d 1c 28 leal (%eax, %ebp), %ebx
>  0x08057370: 89 c8 movl %ecx, %eax
>  0x08057372: cd 80 int $0x80

Thanks! I'll have a closer look.

> >=20
>=20> + g_string_free(report, true);
> >=20
>=20so we could drop this... or..

As aborting is optional, we should free.

Regards,
Julian

