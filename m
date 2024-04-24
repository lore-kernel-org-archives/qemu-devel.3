Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28359C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 16:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzfVn-0001K4-PQ; Wed, 24 Apr 2024 12:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sameer.kp.in@gmail.com>)
 id 1rzfVd-0001I2-SP; Wed, 24 Apr 2024 12:30:14 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sameer.kp.in@gmail.com>)
 id 1rzfVb-0006V4-7r; Wed, 24 Apr 2024 12:30:13 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-de480576c3cso55121276.2; 
 Wed, 24 Apr 2024 09:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713976207; x=1714581007; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ovv+A4uxhaDrDl+Rv68DIOVlX2PfhXNLXW9JYdWX9EE=;
 b=BEDcPKodKGO6nXF4JT3ACMbSfQXolU4WtjSg8Cq2iBKY1NdJTESqrvqUIHfFfM03j2
 MwPs+IbDC3DJ74tQJN//lBJxr17+7EN4fI/3pmLkpgrbrmZlLFtEYrOzou6Nu3VIRJPT
 MdHbCrUa6MMyG6xex3ZfF7/kme2pKYmzgS79mmYwEcXoxpPCMv3pq2WaQitIubk1KmQH
 uFebcy15T198rOeJzph303KJzXryXTHP2eIKGjayLE1kOEKc4GdoY2CdHII/fplft2VA
 /mTX7RMlcdb+VUcFxTZgBHUvU1JPXEyLRsuTf85T+4ShIasfpjQ4KvyOsRZMzmakBlq0
 SMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713976207; x=1714581007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ovv+A4uxhaDrDl+Rv68DIOVlX2PfhXNLXW9JYdWX9EE=;
 b=SLYVHpMZyhKMU/SgnHPbaRtslTf3QS/ZCqQfA63+aXZi2RLIBvJF7dG4QtYF9ZGXAf
 MwSncSmyH2sgzR6jg+jkViYdxRzLgNO05Ef7Izf3o3e8+k5jnYh3lvxtFsz+D7g7+Hwj
 6vkElqMh1ps6pyBoAuLz6hMgANEUHQiafr2/F/oZ00a4O51W8/EFnhBeg2uqk9QNymL1
 KFJ7BxKehrnA4HM23FzYrR6c9OqAcfISFQrqUNnIH0+VyC+A1R5NG8YsZe6i6yAeperc
 2S//4SAtCXzVNVp4RyC2n/s/t6+TivMApot3/tONHqoHu4eJGKZLSkQPc9axzFCWDATK
 epzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuz/XIZ1BQTurRAfTJfyvHHhop9uq+fOGZK2/vXI7tMQVg8ElWYyTA6EdiS1byL/5R5tUAfvb6sZRt1oczvTRoRU+418tDVlvWtwcRxuRlYaOp5HVclt59rekFaRkC
X-Gm-Message-State: AOJu0YwWB/c1u9k2Kh9u2fWa7uFpaOJ3rfhDI+0IgJkRauFcEkpOi99l
 H4i6qWZnnUzgAZQKc7etwnrb81K69lo0AeTyEXvhKsPpULLhmPdQBoWL/JnqhwR4dtdIMZVE9Le
 8h2a/Kxnw5N9eUo7yZsmdZ6878uZEOwJd
X-Google-Smtp-Source: AGHT+IFzkkA9PG+gu5a1wB8y6L2czKdshIKqAbne0q5/JWUMkrFt2T/lweWMPGOt9H2BAYa6Om+KvqwJ2rY1Q+y17PE=
X-Received: by 2002:a25:b948:0:b0:dc6:4b66:2636 with SMTP id
 s8-20020a25b948000000b00dc64b662636mr2821217ybm.19.1713976206823; Wed, 24 Apr
 2024 09:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAAA2AK8p=RtqeNZXfnqprw+kqEBTvrQo1Va81+ctfYAT6k6jnA@mail.gmail.com>
 <07e79630-7171-4cb5-829d-a87a8165adc5@linaro.org>
 <gqzmd4roytmeq3hbtb4b4frhomqtcn4aje4wja7bwmbrvb5dfh@oumkvbg3uah3>
 <CAAA2AK-tMmG079EAuqmZ7QNWiP1yXNbCfk+4FW8ypgB4hmeDsw@mail.gmail.com>
 <2dmeztro45uitfbbpjlpekwv6zai2wntvvyfbggx2ps5ds2ye3@ij7eygqpw4x7>
In-Reply-To: <2dmeztro45uitfbbpjlpekwv6zai2wntvvyfbggx2ps5ds2ye3@ij7eygqpw4x7>
From: Sameer Kalliadan Poyil <sameer.kp.in@gmail.com>
Date: Wed, 24 Apr 2024 12:29:30 -0400
Message-ID: <CAAA2AK-3eH58WwOY-tmDaYD94Z7vWH3Hm24cNE0BLG62bNWLFw@mail.gmail.com>
Subject: Re: Qemu for TC377
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-discuss@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f61af50616da2eba"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=sameer.kp.in@gmail.com; helo=mail-yb1-xb31.google.com
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

--000000000000f61af50616da2eba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastian,

Thanks a lot. I have downloaded HighTec IDE from (
https://free-entry-toolchain.hightec-rt.com/) and tried to run the TSIM but
no success. In web, I don't see any documentation how to run it. The doc
comes along with tsim doesn't explain how to start the simulator. Could you
let me know how to start tsim for a helloworld.elf for TC3xx ? is there a
Menu in highTec IDE to start it ?  I believe it is a cmd
tool(C:\HIGHTEC\toolchains\tricore\v4.9.3.0-infineon-1.0\bin\tsim)

Regards
Sameer

On Sun, Apr 21, 2024 at 6:18=E2=80=AFAM Bastian Koppelmann <
kbastian@mail.uni-paderborn.de> wrote:

> Hi Sameer,
>
> On Tue, Apr 16, 2024 at 02:26:10PM -0400, Sameer Kalliadan Poyil wrote:
> > Hi Bastian,
> >
> > Thanks for the information. I thought that I can do some prototyping
> before the
> > HW arrives. :)
> >
> >  Yes I am interested for your bare metal program boot_to_main run it on
> TSIM.
> > Is Infineon TSIM free? I searched it and I didn't find any download
> link. Could
> > you please give a link for that if it is from Infineon?
>
> I usually get it from the free entry toolchain [1]
>
> >
> > s it(TSIM)  trace32 simulator ?
> https://repo.lauterbach.com/download_demo.html
> > ?
> >
> > This page https://wiki.qemu.org/Documentation/Platforms/TriCore shows
> SCU is
> > under development.
>
> I should change that on the wiki. I was experimenting with a QEMU model
> for the
> SCU when I was still in University, but nothing usable resulted from that=
.
> Now
> my time for such developments is unfortunately limited :(.
>
> >
> > Could you let me know who is developing it ? is  it possible to take an
> > existing SCU and modify according to AURIX data sheet? I see that UART =
is
> > possible to for Tricore like the one developed for ARM versatile platfo=
rm
> >
> > Here is the link
> https://mail.gnu.org/archive/html/qemu-devel/2016-10/msg04514.html
>
> Sure, you can add a model of the Aurix UART in QEMU. It's "just" a matter
> of
> putting in the time to implement its registers and functionality.
>
> >
> > I have aurix development trial version and able to compile a UART
> project using
> > Tasking compiler and tried to run it on qemu, but I don't see any logs
> in the
> > qemu terminal as you said there is no peripherals implemented
> >
> > qemu-system-tricore -machine KIT_AURIX_TC277_TRB -cpu tc27x -m 6M
> -nographic
> > -kernel ASCLIN_Shell_UART_1_KIT_TC277_TFT.elf  -serial stdio -append
> "console=3D
> > ttyAMA0 console=3DttyS0"
>
> I usually add '-d exec,cpu,nochain -D /tmp/exec.log -accel
> tcg,one-insn-per-tb=3Don'
> to get an execution trace to see if the binary is executing.
>
> You can also try attaching gdb by adding '-s -S' to the CLI. And then run
> in
> tricore-gdb 'target remote localhost:1234' see [2]
>
> >
> >
> > Also do you know if there is a virtual UART framework to communicate
> between
> > two Qemu instances or two TSIM instances running similar OS or differen=
t
> OS? I
> > need to do prototype testing RPMSg communication between  MCU and SOC
> using
> > external physical UART/SPI which can be tested using vritual UART using
> two
> > qemu instances.
>
> No, I don't know of something like this.
>
> Cheers,
> Bastian
>
> [1] https://free-entry-toolchain.hightec-rt.com/
> [2] https://www.qemu.org/docs/master/system/gdb.html
>

--000000000000f61af50616da2eba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Bastian,=C2=A0<div><br><div>Thanks a lot. I have d=
ownloaded=C2=A0HighTec IDE from (<a href=3D"https://free-entry-toolchain.hi=
ghtec-rt.com/">https://free-entry-toolchain.hightec-rt.com/</a>)=C2=A0and t=
ried to run=C2=A0the TSIM but no success. In web, I don&#39;t see any docum=
entation how to run it. The doc comes along with tsim doesn&#39;t explain h=
ow to start the simulator. Could you let me know how to start tsim for a he=
lloworld.elf for TC3xx ? is there=C2=A0a Menu in highTec IDE to start it ?=
=C2=A0 I believe=C2=A0it is a cmd tool(C:\HIGHTEC\toolchains\tricore\v4.9.3=
.0-infineon-1.0\bin\tsim)<br></div><div><br></div><div>Regards</div><div>Sa=
meer</div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Sun, Apr 21, 2024 at 6:18=E2=80=AFAM Bastian Koppelmann =
&lt;<a href=3D"mailto:kbastian@mail.uni-paderborn.de">kbastian@mail.uni-pad=
erborn.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi Sameer,<br>
<br>
On Tue, Apr 16, 2024 at 02:26:10PM -0400, Sameer Kalliadan Poyil wrote:<br>
&gt; Hi Bastian,<br>
&gt;<br>
&gt; Thanks for the information. I thought that I can do some prototyping b=
efore the<br>
&gt; HW arrives. :)<br>
&gt;<br>
&gt; =C2=A0Yes I am interested for your bare metal program=C2=A0boot_to_mai=
n run it on TSIM.=C2=A0=C2=A0<br>
&gt; Is Infineon TSIM free? I searched it and=C2=A0I didn&#39;t find any do=
wnload link. Could<br>
&gt; you please give a link for that if it is from Infineon?<br>
<br>
I usually get it from the free entry toolchain [1]<br>
<br>
&gt;<br>
&gt; s it(TSIM)=C2=A0 trace32 simulator ? <a href=3D"https://repo.lauterbac=
h.com/download_demo.html" rel=3D"noreferrer" target=3D"_blank">https://repo=
.lauterbach.com/download_demo.html</a><br>
&gt; ?<br>
&gt;<br>
&gt; This page=C2=A0<a href=3D"https://wiki.qemu.org/Documentation/Platform=
s/TriCore" rel=3D"noreferrer" target=3D"_blank">https://wiki.qemu.org/Docum=
entation/Platforms/TriCore</a> shows SCU is<br>
&gt; under development.<br>
<br>
I should change that on the wiki. I was experimenting with a QEMU model for=
 the<br>
SCU when I was still in University, but nothing usable resulted from that. =
Now<br>
my time for such developments is unfortunately limited :(.<br>
<br>
&gt;<br>
&gt; Could you let me know who is developing=C2=A0it ?=C2=A0is=C2=A0 it pos=
sible to take an<br>
&gt; existing SCU and modify according to AURIX data sheet? I see that UART=
 is<br>
&gt; possible to for Tricore like the one developed for ARM versatile platf=
orm<br>
&gt;<br>
&gt; Here is the link <a href=3D"https://mail.gnu.org/archive/html/qemu-dev=
el/2016-10/msg04514.html" rel=3D"noreferrer" target=3D"_blank">https://mail=
.gnu.org/archive/html/qemu-devel/2016-10/msg04514.html</a><br>
<br>
Sure, you can add a model of the Aurix UART in QEMU. It&#39;s &quot;just&qu=
ot; a matter of<br>
putting in the time to implement its registers and functionality.<br>
<br>
&gt;<br>
&gt; I have aurix development=C2=A0trial version and able to compile a UART=
 project=C2=A0using<br>
&gt; Tasking compiler and tried to run it on qemu, but I don&#39;t see any =
logs in the<br>
&gt; qemu terminal=C2=A0as you said there is no peripherals implemented<br>
&gt;<br>
&gt; qemu-system-tricore -machine KIT_AURIX_TC277_TRB -cpu tc27x -m 6M -nog=
raphic<br>
&gt; -kernel ASCLIN_Shell_UART_1_KIT_TC277_TFT.elf =C2=A0-serial stdio -app=
end &quot;console=3D<br>
&gt; ttyAMA0 console=3DttyS0&quot;<br>
<br>
I usually add &#39;-d exec,cpu,nochain -D /tmp/exec.log -accel tcg,one-insn=
-per-tb=3Don&#39;<br>
to get an execution trace to see if the binary is executing.<br>
<br>
You can also try attaching gdb by adding &#39;-s -S&#39; to the CLI. And th=
en run in<br>
tricore-gdb &#39;target remote localhost:1234&#39; see [2]<br>
<br>
&gt;<br>
&gt;<br>
&gt; Also do you know if there is a virtual UART framework to communicate b=
etween<br>
&gt; two Qemu instances or two TSIM instances=C2=A0running similar OS or di=
fferent OS? I<br>
&gt; need to do prototype testing RPMSg communication between=C2=A0 MCU and=
 SOC using<br>
&gt; external physical UART/SPI which can be tested using vritual=C2=A0UART=
 using two<br>
&gt; qemu instances.=C2=A0<br>
<br>
No, I don&#39;t know of something like this.<br>
<br>
Cheers,<br>
Bastian<br>
<br>
[1] <a href=3D"https://free-entry-toolchain.hightec-rt.com/" rel=3D"norefer=
rer" target=3D"_blank">https://free-entry-toolchain.hightec-rt.com/</a><br>
[2] <a href=3D"https://www.qemu.org/docs/master/system/gdb.html" rel=3D"nor=
eferrer" target=3D"_blank">https://www.qemu.org/docs/master/system/gdb.html=
</a><br>
</blockquote></div>

--000000000000f61af50616da2eba--

