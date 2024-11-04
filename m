Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EA1D132C8
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xQx-0007lu-Dq; Mon, 04 Nov 2024 08:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t7xQs-0007Z7-BM
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:47:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t7xQp-0003Nq-3Q
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730728065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mUOXhYgDdNB/8mVB0JJYBB6VCm/GLJGUzF1oVW0N8cY=;
 b=JH24en+tzuiqlXr1KrnSrx8y5bpUdZa16RU1BfA/Qaw61M9JNlaZeOtoCIBNdnGG4nDK5l
 sdBGYZT3hA3A2660IOlLhtB4YEc81OmtPMQ2bB0267wX0NlyTF6uFMulLzWpHx2Jr6ubc8
 McDrPBbwRM4+Cr+2/GYUoMd1taSGgy0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-G_TQFFc6Oj-j4YIKDZgwdg-1; Mon, 04 Nov 2024 08:47:43 -0500
X-MC-Unique: G_TQFFc6Oj-j4YIKDZgwdg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cbed928402so62688426d6.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 05:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730728063; x=1731332863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mUOXhYgDdNB/8mVB0JJYBB6VCm/GLJGUzF1oVW0N8cY=;
 b=gK/JhbOU8lNkZvM86qMes8z+j3AiEntTnfoGK6fb3c47UAQ4TI1N1pnXgPrbgqbZtW
 zkEt2xEysJc30pfIZvSUkiVxoBtrAl/qbDxI6L+DDx6oC7YfjPSRc00BAuc2jAxv3t91
 4TFwkOIg5UVRltd6dCYTdMXUrxxKYJ7l7leIHfQo+YyBe61tg4eejL79nQvT7v96ADZm
 +D0dmozE8VHGcQl2AuMEEExqldfM527xYmpA5ARhjHCcKRGSLTs2KyLlXzz8guhj/uXh
 xp1B4tpfW1CfAmmhZO0G4NDOJdO1ZVxtEHlappQKqryFTW8M/717Op3ApdYgghRZIHNI
 5CnA==
X-Gm-Message-State: AOJu0YxpCLsGiR6u83GOno5FfkblU6xQxFFKeFv+BhQBeZZ0fycN7Cgi
 /RgukxBaZ2APfHEw0xFF4MF74A9FCyK9JMCTXOoMuAEW3tuUm05gszOAV5CwBAiQpMVjDKzsC46
 ubRRH5UqRS7J5mlNezkWmGymNC+KUr+gnFpOj4GD8y05HeT5QwmYQgFJWJM+ljlof5zkOy9d906
 iopqCnX79eJ2iN3BsNBhgVRQQVBfQ=
X-Received: by 2002:a05:6214:2f12:b0:6cb:e99c:86a9 with SMTP id
 6a1803df08f44-6d18567455cmr445456056d6.1.1730728063158; 
 Mon, 04 Nov 2024 05:47:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6ocSNT7aZyt9SkCjj8ISLifu9WZG70Xl8G4d8ORrt+xWNjWsx2WhUlbFwtvNwsTWN7hBVrkJhd3cjXJJuvPU=
X-Received: by 2002:a05:6214:2f12:b0:6cb:e99c:86a9 with SMTP id
 6a1803df08f44-6d18567455cmr445455816d6.1.1730728062766; Mon, 04 Nov 2024
 05:47:42 -0800 (PST)
MIME-Version: 1.0
References: <m15xppk9qg.fsf@nimmagadda.net> <ZxYQKlkEGhEXY3O6@redhat.com>
In-Reply-To: <ZxYQKlkEGhEXY3O6@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 4 Nov 2024 15:47:31 +0200
Message-ID: <CAPMcbCpgHw98xLmvcWtqM1y_VeB07jw2Tc1hGd=CbPi65eDLuw@mail.gmail.com>
Subject: Re: [PATCH] qemu-ga: Fix a SIGSEGV on guest-set-time command
To: Sunil Nimmagadda <sunil@nimmagadda.net>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 michael.roth@amd.com
Content-Type: multipart/alternative; boundary="0000000000006265680626168733"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, MIME_BOUND_DIGITS_15=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000006265680626168733
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil,

I updated the commit message according to Daniel's comment and got this
patch to merge.

Best Regards,
Konstantin Kostiuk.


On Mon, Oct 21, 2024 at 11:26=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Fri, Oct 18, 2024 at 03:34:39PM +0530, Sunil Nimmagadda wrote:
> > qemu-ga on a NetBSD -current VM terminates with a SIGSEGV upon receivin=
g
> > 'guest-set-time' command...
> >
> > Core was generated by `qemu-ga'.
> > Program terminated with signal SIGSEGV, Segmentation fault.
> > #0  0x000000000cd37a40 in ga_pipe_read_str (fd=3Dfd@entry=3D0xffffff922=
a20,
> str=3Dstr@entry=3D0xffffff922a18)
> >     at ../qga/commands-posix.c:88
> > 88            *str[len] =3D '\0';
> > [Current thread is 1 (process 1112)]
> > (gdb) bt
> > #0  0x000000000cd37a40 in ga_pipe_read_str (fd=3Dfd@entry=3D0xffffff922=
a20,
> str=3Dstr@entry=3D0xffffff922a18)
> >     at ../qga/commands-posix.c:88
> > #1  0x000000000cd37b60 in ga_run_command (argv=3Dargv@entry=3D0xffffff9=
22a90,
>
> >     action=3Daction@entry=3D0xcda34b8 "set hardware clock to system tim=
e",
> errp=3Derrp@entry=3D0xffffff922a70, in_str=3D0x0)
> >     at ../qga/commands-posix.c:164
> > #2  0x000000000cd380c4 in qmp_guest_set_time (has_time=3D<optimized out=
>,
> time_ns=3D<optimized out>,
> >     errp=3Derrp@entry=3D0xffffff922ad0) at ../qga/commands-posix.c:304
> > #3  0x000000000cd253d8 in qmp_marshal_guest_set_time (args=3D<optimized
> out>, ret=3D<optimized out>, errp=3D0xffffff922b48)
> >     at qga/qga-qapi-commands.c:193
> > #4  0x000000000cd4e71c in qmp_dispatch (cmds=3Dcmds@entry=3D0xcdf5b18
> <ga_commands>, request=3Drequest@entry=3D0xf3c711a4b000,
> >     allow_oob=3Dallow_oob@entry=3Dfalse, cur_mon=3Dcur_mon@entry=3D0x0)=
 at
> ../qapi/qmp-dispatch.c:220
> > #5  0x000000000cd36524 in process_event (opaque=3D0xf3c711a79000,
> obj=3D0xf3c711a4b000, err=3D0x0) at ../qga/main.c:677
> > #6  0x000000000cd526f0 in json_message_process_token (lexer=3Dlexer@ent=
ry=3D0xf3c711a79018,
> input=3D0xf3c712072480,
> >     type=3Dtype@entry=3DJSON_RCURLY, x=3D28, y=3D1) at
> ../qobject/json-streamer.c:99
> > #7  0x000000000cd93860 in json_lexer_feed_char (lexer=3Dlexer@entry=3D0=
xf3c711a79018,
> ch=3D125 '}', flush=3Dflush@entry=3Dfalse)
> >     at ../qobject/json-lexer.c:313
> > #8  0x000000000cd93a00 in json_lexer_feed (lexer=3Dlexer@entry=3D0xf3c7=
11a79018,
>
> >     buffer=3Dbuffer@entry=3D0xffffff922d10
> "{\"execute\":\"guest-set-time\"}\n", size=3D<optimized out>)
> >     at ../qobject/json-lexer.c:350
> > #9  0x000000000cd5290c in json_message_parser_feed (parser=3Dparser@ent=
ry=3D0xf3c711a79000,
>
> >     buffer=3Dbuffer@entry=3D0xffffff922d10
> "{\"execute\":\"guest-set-time\"}\n", size=3D<optimized out>)
> >     at ../qobject/json-streamer.c:121
> > #10 0x000000000cd361fc in channel_event_cb (condition=3D<optimized out>=
,
> data=3D0xf3c711a79000) at ../qga/main.c:703
> > #11 0x000000000cd3710c in ga_channel_client_event (channel=3D<optimized
> out>, condition=3D<optimized out>, data=3D0xf3c711b2d300)
> >     at ../qga/channel-posix.c:94
> > #12 0x0000f3c7120d9bec in g_main_dispatch () from
> /usr/pkg/lib/libglib-2.0.so.0
> > #13 0x0000f3c7120dd25c in g_main_context_iterate_unlocked.constprop ()
> from /usr/pkg/lib/libglib-2.0.so.0
> > #14 0x0000f3c7120ddbf0 in g_main_loop_run () from
> /usr/pkg/lib/libglib-2.0.so.0
> > #15 0x000000000cda00d8 in run_agent_once (s=3D0xf3c711a79000) at
> ../qga/main.c:1522
> > #16 run_agent (s=3D0xf3c711a79000) at ../qga/main.c:1559
> > #17 main (argc=3D<optimized out>, argv=3D<optimized out>) at
> ../qga/main.c:1671
> > (gdb)
> >
> > The commandline options used on the host machine...
> > qemu-system-aarch64 \
> >    -machine type=3Dvirt,pflash0=3Drom \
> >    -m 8G \
> >    -cpu host \
> >    -smp 8 \
> >    -accel hvf \
> >    -device virtio-net-pci,netdev=3Dunet \
> >    -device virtio-blk-pci,drive=3Dhd \
> >    -drive file=3Dnetbsd.qcow2,if=3Dnone,id=3Dhd \
> >    -netdev user,id=3Dunet,hostfwd=3Dtcp::2223-:22 \
> >    -object rng-random,filename=3D/dev/urandom,id=3Dviornd0 \
> >    -device virtio-rng-pci,rng=3Dviornd0 \
> >    -serial mon:stdio \
> >    -display none \
> >    -blockdev
> node-name=3Drom,driver=3Dfile,filename=3D/opt/homebrew/Cellar/qemu/9.0.2/=
share/qemu/edk2-aarch64-code.fd,read-only=3Dtrue
> \
> >    -chardev socket,path=3D/tmp/qga_netbsd.sock,server=3Don,wait=3Doff,i=
d=3Dqga0 \
> >    -device virtio-serial \
> >    -device virtconsole,chardev=3Dqga0,name=3Dorg.qemu.guest_agent.0
>
> This bug isn't platform specific AFAICT, and will also hit
> other commands.
>
> Was introduced by:
>
> commit c3f32c13a325f1ca9a0b08c19fefe9e5cc04289d
> Author: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Date:   Wed Mar 20 18:16:43 2024 +0200
>
>     qga: introduce ga_run_command() helper for guest cmd execution
>
> and then affects multiple commands:
>
>     qga/commands-posix: qmp_guest_set_user_password: use ga_run_command
> helper
>     qga/commands-posix: execute_fsfreeze_hook: use ga_run_command helper
>     qga/commands-posix: qmp_guest_set_time: use ga_run_command helper
>     qga/commands-posix: qmp_guest_shutdown: use ga_run_command helper
>
> IOW, this is a regression in the 9.1.0 release
>
> >
> > This patch rectifies the operator precedence while assigning the NUL
> > terminator.
> >
> > Signed-off-by: Sunil Nimmagadda <sunil@nimmagadda.net>
> >
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index c2bd0b4..bb41fa9 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -85,7 +85,7 @@ static ssize_t ga_pipe_read_str(int fd[2], char **str=
)
> >          *str =3D g_realloc(*str, len + n + 1);
> >          memcpy(*str + len, buf, n);
> >          len +=3D n;
> > -        *str[len] =3D '\0';
> > +        (*str)[len] =3D '\0';
> >      }
> >      close(fd[0]);
> >      fd[0] =3D -1;
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--0000000000006265680626168733
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Sunil,</div><div><br></div><div>I updated the comm=
it message according to Daniel&#39;s comment and got this patch to merge. <=
br></div><div><br></div><div><div><div dir=3D"ltr" class=3D"gmail_signature=
" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</d=
iv><div>Konstantin Kostiuk.</div></div></div></div><br></div></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 21=
, 2024 at 11:26=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:be=
rrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On Fri, Oct 18, 2024 at 03:34:39PM +0=
530, Sunil Nimmagadda wrote:<br>
&gt; qemu-ga on a NetBSD -current VM terminates with a SIGSEGV upon receivi=
ng<br>
&gt; &#39;guest-set-time&#39; command...<br>
&gt; <br>
&gt; Core was generated by `qemu-ga&#39;.<br>
&gt; Program terminated with signal SIGSEGV, Segmentation fault.<br>
&gt; #0=C2=A0 0x000000000cd37a40 in ga_pipe_read_str (fd=3Dfd@entry=3D0xfff=
fff922a20, str=3Dstr@entry=3D0xffffff922a18)<br>
&gt;=C2=A0 =C2=A0 =C2=A0at ../qga/commands-posix.c:88<br>
&gt; 88=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *str[len] =3D &#39;\0&#39;=
;<br>
&gt; [Current thread is 1 (process 1112)]<br>
&gt; (gdb) bt<br>
&gt; #0=C2=A0 0x000000000cd37a40 in ga_pipe_read_str (fd=3Dfd@entry=3D0xfff=
fff922a20, str=3Dstr@entry=3D0xffffff922a18)<br>
&gt;=C2=A0 =C2=A0 =C2=A0at ../qga/commands-posix.c:88<br>
&gt; #1=C2=A0 0x000000000cd37b60 in ga_run_command (argv=3Dargv@entry=3D0xf=
fffff922a90, <br>
&gt;=C2=A0 =C2=A0 =C2=A0action=3Daction@entry=3D0xcda34b8 &quot;set hardwar=
e clock to system time&quot;, errp=3Derrp@entry=3D0xffffff922a70, in_str=3D=
0x0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0at ../qga/commands-posix.c:164<br>
&gt; #2=C2=A0 0x000000000cd380c4 in qmp_guest_set_time (has_time=3D&lt;opti=
mized out&gt;, time_ns=3D&lt;optimized out&gt;, <br>
&gt;=C2=A0 =C2=A0 =C2=A0errp=3Derrp@entry=3D0xffffff922ad0) at ../qga/comma=
nds-posix.c:304<br>
&gt; #3=C2=A0 0x000000000cd253d8 in qmp_marshal_guest_set_time (args=3D&lt;=
optimized out&gt;, ret=3D&lt;optimized out&gt;, errp=3D0xffffff922b48)<br>
&gt;=C2=A0 =C2=A0 =C2=A0at qga/qga-qapi-commands.c:193<br>
&gt; #4=C2=A0 0x000000000cd4e71c in qmp_dispatch (cmds=3Dcmds@entry=3D0xcdf=
5b18 &lt;ga_commands&gt;, request=3Drequest@entry=3D0xf3c711a4b000, <br>
&gt;=C2=A0 =C2=A0 =C2=A0allow_oob=3Dallow_oob@entry=3Dfalse, cur_mon=3Dcur_=
mon@entry=3D0x0) at ../qapi/qmp-dispatch.c:220<br>
&gt; #5=C2=A0 0x000000000cd36524 in process_event (opaque=3D0xf3c711a79000,=
 obj=3D0xf3c711a4b000, err=3D0x0) at ../qga/main.c:677<br>
&gt; #6=C2=A0 0x000000000cd526f0 in json_message_process_token (lexer=3Dlex=
er@entry=3D0xf3c711a79018, input=3D0xf3c712072480, <br>
&gt;=C2=A0 =C2=A0 =C2=A0type=3Dtype@entry=3DJSON_RCURLY, x=3D28, y=3D1) at =
../qobject/json-streamer.c:99<br>
&gt; #7=C2=A0 0x000000000cd93860 in json_lexer_feed_char (lexer=3Dlexer@ent=
ry=3D0xf3c711a79018, ch=3D125 &#39;}&#39;, flush=3Dflush@entry=3Dfalse)<br>
&gt;=C2=A0 =C2=A0 =C2=A0at ../qobject/json-lexer.c:313<br>
&gt; #8=C2=A0 0x000000000cd93a00 in json_lexer_feed (lexer=3Dlexer@entry=3D=
0xf3c711a79018, <br>
&gt;=C2=A0 =C2=A0 =C2=A0buffer=3Dbuffer@entry=3D0xffffff922d10 &quot;{\&quo=
t;execute\&quot;:\&quot;guest-set-time\&quot;}\n&quot;, size=3D&lt;optimize=
d out&gt;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0at ../qobject/json-lexer.c:350<br>
&gt; #9=C2=A0 0x000000000cd5290c in json_message_parser_feed (parser=3Dpars=
er@entry=3D0xf3c711a79000, <br>
&gt;=C2=A0 =C2=A0 =C2=A0buffer=3Dbuffer@entry=3D0xffffff922d10 &quot;{\&quo=
t;execute\&quot;:\&quot;guest-set-time\&quot;}\n&quot;, size=3D&lt;optimize=
d out&gt;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0at ../qobject/json-streamer.c:121<br>
&gt; #10 0x000000000cd361fc in channel_event_cb (condition=3D&lt;optimized =
out&gt;, data=3D0xf3c711a79000) at ../qga/main.c:703<br>
&gt; #11 0x000000000cd3710c in ga_channel_client_event (channel=3D&lt;optim=
ized out&gt;, condition=3D&lt;optimized out&gt;, data=3D0xf3c711b2d300)<br>
&gt;=C2=A0 =C2=A0 =C2=A0at ../qga/channel-posix.c:94<br>
&gt; #12 0x0000f3c7120d9bec in g_main_dispatch () from /usr/pkg/lib/libglib=
-2.0.so.0<br>
&gt; #13 0x0000f3c7120dd25c in g_main_context_iterate_unlocked.constprop ()=
 from /usr/pkg/lib/libglib-2.0.so.0<br>
&gt; #14 0x0000f3c7120ddbf0 in g_main_loop_run () from /usr/pkg/lib/libglib=
-2.0.so.0<br>
&gt; #15 0x000000000cda00d8 in run_agent_once (s=3D0xf3c711a79000) at ../qg=
a/main.c:1522<br>
&gt; #16 run_agent (s=3D0xf3c711a79000) at ../qga/main.c:1559<br>
&gt; #17 main (argc=3D&lt;optimized out&gt;, argv=3D&lt;optimized out&gt;) =
at ../qga/main.c:1671<br>
&gt; (gdb) <br>
&gt; <br>
&gt; The commandline options used on the host machine...<br>
&gt; qemu-system-aarch64 \<br>
&gt;=C2=A0 =C2=A0 -machine type=3Dvirt,pflash0=3Drom \<br>
&gt;=C2=A0 =C2=A0 -m 8G \<br>
&gt;=C2=A0 =C2=A0 -cpu host \<br>
&gt;=C2=A0 =C2=A0 -smp 8 \<br>
&gt;=C2=A0 =C2=A0 -accel hvf \<br>
&gt;=C2=A0 =C2=A0 -device virtio-net-pci,netdev=3Dunet \<br>
&gt;=C2=A0 =C2=A0 -device virtio-blk-pci,drive=3Dhd \<br>
&gt;=C2=A0 =C2=A0 -drive file=3Dnetbsd.qcow2,if=3Dnone,id=3Dhd \<br>
&gt;=C2=A0 =C2=A0 -netdev user,id=3Dunet,hostfwd=3Dtcp::2223-:22 \<br>
&gt;=C2=A0 =C2=A0 -object rng-random,filename=3D/dev/urandom,id=3Dviornd0 \=
<br>
&gt;=C2=A0 =C2=A0 -device virtio-rng-pci,rng=3Dviornd0 \<br>
&gt;=C2=A0 =C2=A0 -serial mon:stdio \<br>
&gt;=C2=A0 =C2=A0 -display none \<br>
&gt;=C2=A0 =C2=A0 -blockdev node-name=3Drom,driver=3Dfile,filename=3D/opt/h=
omebrew/Cellar/qemu/9.0.2/share/qemu/edk2-aarch64-code.fd,read-only=3Dtrue =
\<br>
&gt;=C2=A0 =C2=A0 -chardev socket,path=3D/tmp/qga_netbsd.sock,server=3Don,w=
ait=3Doff,id=3Dqga0 \<br>
&gt;=C2=A0 =C2=A0 -device virtio-serial \<br>
&gt;=C2=A0 =C2=A0 -device virtconsole,chardev=3Dqga0,name=3Dorg.qemu.guest_=
agent.0<br>
<br>
This bug isn&#39;t platform specific AFAICT, and will also hit<br>
other commands.<br>
<br>
Was introduced by:<br>
<br>
commit c3f32c13a325f1ca9a0b08c19fefe9e5cc04289d<br>
Author: Andrey Drobyshev &lt;<a href=3D"mailto:andrey.drobyshev@virtuozzo.c=
om" target=3D"_blank">andrey.drobyshev@virtuozzo.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Wed Mar 20 18:16:43 2024 +0200<br>
<br>
=C2=A0 =C2=A0 qga: introduce ga_run_command() helper for guest cmd executio=
n<br>
<br>
and then affects multiple commands:<br>
<br>
=C2=A0 =C2=A0 qga/commands-posix: qmp_guest_set_user_password: use ga_run_c=
ommand helper<br>
=C2=A0 =C2=A0 qga/commands-posix: execute_fsfreeze_hook: use ga_run_command=
 helper<br>
=C2=A0 =C2=A0 qga/commands-posix: qmp_guest_set_time: use ga_run_command he=
lper<br>
=C2=A0 =C2=A0 qga/commands-posix: qmp_guest_shutdown: use ga_run_command he=
lper<br>
<br>
IOW, this is a regression in the 9.1.0 release<br>
<br>
&gt; <br>
&gt; This patch rectifies the operator precedence while assigning the NUL<b=
r>
&gt; terminator.<br>
&gt; <br>
&gt; Signed-off-by: Sunil Nimmagadda &lt;<a href=3D"mailto:sunil@nimmagadda=
.net" target=3D"_blank">sunil@nimmagadda.net</a>&gt;<br>
&gt; <br>
&gt; diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
&gt; index c2bd0b4..bb41fa9 100644<br>
&gt; --- a/qga/commands-posix.c<br>
&gt; +++ b/qga/commands-posix.c<br>
&gt; @@ -85,7 +85,7 @@ static ssize_t ga_pipe_read_str(int fd[2], char **st=
r)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *str =3D g_realloc(*str, len + n + 1=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(*str + len, buf, n);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D n;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 *str[len] =3D &#39;\0&#39;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (*str)[len] =3D &#39;\0&#39;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 close(fd[0]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fd[0] =3D -1;<br>
<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div>

--0000000000006265680626168733--


