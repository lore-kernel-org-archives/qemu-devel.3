Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C287C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 06:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2QNV-0000S6-IE; Thu, 02 May 2024 02:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abhi97.rajmane@gmail.com>)
 id 1s2QNP-0000R2-7a
 for qemu-devel@nongnu.org; Thu, 02 May 2024 02:57:08 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <abhi97.rajmane@gmail.com>)
 id 1s2QNL-0008Ih-Jb
 for qemu-devel@nongnu.org; Thu, 02 May 2024 02:57:07 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-234db9dde9bso3246836fac.1
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 23:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714633021; x=1715237821; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DtJevLNU5MfvnmlvzvbCE3rjt9cdpoUeFsbwRtaPukc=;
 b=O2BtYntXlu9L3ibQwrVSJmbdBoNSP8ZgLjf4HDiB39FFSWLO5CqFfYFR7kCwOZJb1C
 RS6v0M27WSOuzkY3HtCQHHUGIW3cmxNP2SZ05fAjQMEnWvlj2fAa4ftkmwX9a8KI0/TR
 FDXF4weQsPOnC5vn2MZhj1tZYflfUpvjHSOTXaXjAfq+jLsS45b7PIrXd4pU+kOY4fNY
 f4DrPM5Mo/aEegaQoIEFWJ27YN4aWvXJLKBYo1lkn37TsbMsvtcMS3t2qS+IKG/NsIW2
 kZzYjX8Mh5YYbWX0yqSASysZQBih3zv3OHsJHiOJvr1FmvF2JlSgKM9Yb/omlBZ9UpMJ
 O0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714633021; x=1715237821;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DtJevLNU5MfvnmlvzvbCE3rjt9cdpoUeFsbwRtaPukc=;
 b=faJhI6YUGR27uRKyx9WVSK8sdmaTUKWHB/G/zkoq3KfduY1hojO+FeuQ/WKxhLsmEl
 cvB72pEedBQNihTN1rHBan7/GboKk62sEazZbI5rhRvQno/bw75+oKg/4wcU2jHMarLJ
 7B6RP4q54Tv19HKbYT0Ezbj0qHGI+9y+GLPFsmReS8Udv5tFvszHl8Fng+84Fjg1nMJW
 0EHyKZeuXTZlHmfYbL0bdAczq1xsn/UB+7NQpbx0js2TBQMqRVDX6JOlBJNFwQxiRv2X
 bwXYCqebKeBV/TY8IKQfKIDiRIYItIGsx/ehs3M/r29JW5/B7qoxOQrzGFoCD4NkTAmT
 Lr1Q==
X-Gm-Message-State: AOJu0YyMPeGWH+VoDG/tBJfGJUeNFkpva0gOefIfRmZc0D5M3GW1sRjC
 lODgMTT/086RbYwEOn43akO7vQjB2ZtUhTYbGCG0uxs3SqT8ZOLcqmb5CPyYStoMgLAFBBrmnCt
 fTUElUqa6J89NKrDfTpN8WTQ1Kp7V5Jk=
X-Google-Smtp-Source: AGHT+IG/dabE4fKvx11yNVt7qfDEDPV9ClhHjc1b7kKW9POd9AI8Zd32eoxrb25V2hg1HqkjrgtbGnkthEPmtV+e8xk=
X-Received: by 2002:a05:6870:3926:b0:221:96b2:5a4e with SMTP id
 b38-20020a056870392600b0022196b25a4emr1559544oap.58.1714633020621; Wed, 01
 May 2024 23:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <CANJXYHH_CPc40eR6AWU0pKVgX9LkOg_2DbdOmZ=F1+cKaQwrsA@mail.gmail.com>
In-Reply-To: <CANJXYHH_CPc40eR6AWU0pKVgX9LkOg_2DbdOmZ=F1+cKaQwrsA@mail.gmail.com>
From: abhijeet rajmane <abhi97.rajmane@gmail.com>
Date: Thu, 2 May 2024 12:28:05 +0530
Message-ID: <CANJXYHGU2kdx0Qu7YvKS-Rv4Yc-6oTSiZfhi8pzCxtaPs6UJbQ@mail.gmail.com>
Subject: Re: xlnx-versal-virt machine in qemu
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001d4cb80617731cb5"
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=abhi97.rajmane@gmail.com; helo=mail-oa1-x35.google.com
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

--0000000000001d4cb80617731cb5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am using the following command to boot "xlnx-versal-virt" board with
"canbus" and connect it to host machine using "canbus"

$ qemu-system-aarch64 -M xlnx-versal-virt -m 4G -serial mon:stdio -display
none -kernel ~/linux_kernel/linux-5.15.157/arch/arm64/boot/Image \

-device virtio-rng-device,bus=3Dvirtio-mmio-bus.0 -drive
if=3Dnone,index=3D0,file=3Drootfs.img,format=3Draw,id=3Dhd0 \

-device virtio-blk-device,drive=3Dhd0 -append root=3D/dev/vda -nic user \

-object can-bus,id=3Dcanbus0 -machine canbus0=3Dcanbus0 -object
can-bus,id=3Dcanbus1 -machine canbus1=3Dcanbus1 \

-object can-host-socketcan,id=3Dsocketcan0,if=3Dvcan0,canbus=3Dcanbus0



->I am using the cansend and candump application to test it.

->After sending certain packets the buffer is getting full. I am seeing
that while ":request_irq" from xilinc_can driver gets called it should
invoke "xcan_interrupt" function. I have added prints in those functions.
"xcan_interrupt" function is not getting called.

->If i check the interrupts on cpu for 'can' interface the count is 0.



Thank You in Advance!!

On Sat, Apr 20, 2024 at 11:43=E2=80=AFPM abhijeet rajmane <abhi97.rajmane@g=
mail.com>
wrote:

> Hi,
> I have booted up the xlnx-versal-virt machine using qemu-system-aarch64. =
I
> wanted to work with can device that has been modelled with this device. I
> have used the xilinx_can.c driver for this device and can see two can
> controllers. The problem is I am not able to see any interrupts in
> /proc/interrupts for both can devices. I have set them up and running. I
> have also connected the canbus device to host to transmit and receive can
> packets. I am seeing qemu_set_irq() getting called. Am I missing somethin=
g?
>
> Thanks ,
> Abhijeet, India
>

--0000000000001d4cb80617731cb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"box-sizing:border-box;margin:0px;padding:0px;c=
olor:rgb(51,51,51);font-family:Roboto,sans-serif;font-size:13px"><span dir=
=3D"ltr" class=3D"gmail-uiOutputText" style=3D"box-sizing:border-box">I am =
using the following command to boot &quot;xlnx-versal-virt&quot; board with=
 &quot;canbus&quot; and connect it to host machine using &quot;canbus&quot;=
</span></p><p style=3D"box-sizing:border-box;margin:0px;padding:0px;color:r=
gb(51,51,51);font-family:Roboto,sans-serif;font-size:13px"><span dir=3D"ltr=
" class=3D"gmail-uiOutputText" style=3D"box-sizing:border-box">$ qemu-syste=
m-aarch64 -M xlnx-versal-virt -m 4G -serial mon:stdio -display none -kernel=
 ~/linux_kernel/linux-5.15.157/arch/arm64/boot/Image=C2=A0\</span></p><p st=
yle=3D"box-sizing:border-box;margin:0px;padding:0px;color:rgb(51,51,51);fon=
t-family:Roboto,sans-serif;font-size:13px"><span dir=3D"ltr" class=3D"gmail=
-uiOutputText" style=3D"box-sizing:border-box">-device virtio-rng-device,bu=
s=3Dvirtio-mmio-bus.0 -drive if=3Dnone,index=3D0,file=3Drootfs.img,format=
=3Draw,id=3Dhd0=C2=A0\</span></p><p style=3D"box-sizing:border-box;margin:0=
px;padding:0px;color:rgb(51,51,51);font-family:Roboto,sans-serif;font-size:=
13px"><span dir=3D"ltr" class=3D"gmail-uiOutputText" style=3D"box-sizing:bo=
rder-box">-device virtio-blk-device,drive=3Dhd0 -append root=3D/dev/vda -ni=
c user=C2=A0\</span></p><p style=3D"box-sizing:border-box;margin:0px;paddin=
g:0px;color:rgb(51,51,51);font-family:Roboto,sans-serif;font-size:13px"><sp=
an dir=3D"ltr" class=3D"gmail-uiOutputText" style=3D"box-sizing:border-box"=
>-object can-bus,id=3Dcanbus0 -machine canbus0=3Dcanbus0 -object can-bus,id=
=3Dcanbus1 -machine canbus1=3Dcanbus1=C2=A0\</span></p><p style=3D"box-sizi=
ng:border-box;margin:0px;padding:0px;color:rgb(51,51,51);font-family:Roboto=
,sans-serif;font-size:13px"><span dir=3D"ltr" class=3D"gmail-uiOutputText" =
style=3D"box-sizing:border-box">-object can-host-socketcan,id=3Dsocketcan0,=
if=3Dvcan0,canbus=3Dcanbus0</span></p><p style=3D"box-sizing:border-box;mar=
gin:0px;padding:0px;color:rgb(51,51,51);font-family:Roboto,sans-serif;font-=
size:13px"><span dir=3D"ltr" class=3D"gmail-uiOutputText" style=3D"box-sizi=
ng:border-box">=C2=A0</span></p><p style=3D"box-sizing:border-box;margin:0p=
x;padding:0px;color:rgb(51,51,51);font-family:Roboto,sans-serif;font-size:1=
3px"><span dir=3D"ltr" class=3D"gmail-uiOutputText" style=3D"box-sizing:bor=
der-box">-&gt;I am using the cansend and candump application to test it.</s=
pan></p><p style=3D"box-sizing:border-box;margin:0px;padding:0px;color:rgb(=
51,51,51);font-family:Roboto,sans-serif;font-size:13px"><span dir=3D"ltr" c=
lass=3D"gmail-uiOutputText" style=3D"box-sizing:border-box">-&gt;After send=
ing certain packets the buffer is getting full. I am seeing that while &quo=
t;:request_irq&quot; from xilinc_can driver gets called it should invoke &q=
uot;xcan_interrupt&quot; function. I have added prints in those functions. =
&quot;xcan_interrupt&quot; function is not getting called.</span></p><p sty=
le=3D"box-sizing:border-box;margin:0px;padding:0px;color:rgb(51,51,51);font=
-family:Roboto,sans-serif;font-size:13px"><span dir=3D"ltr" class=3D"gmail-=
uiOutputText" style=3D"box-sizing:border-box">-&gt;If i check the interrupt=
s on cpu for &#39;can&#39; interface the count is 0.</span></p><p style=3D"=
box-sizing:border-box;margin:0px;padding:0px;color:rgb(51,51,51);font-famil=
y:Roboto,sans-serif;font-size:13px"><span dir=3D"ltr" class=3D"gmail-uiOutp=
utText" style=3D"box-sizing:border-box">=C2=A0</span></p><p style=3D"box-si=
zing:border-box;margin:0px;padding:0px;color:rgb(51,51,51);font-family:Robo=
to,sans-serif;font-size:13px"><span dir=3D"ltr" class=3D"gmail-uiOutputText=
" style=3D"box-sizing:border-box">Thank You in Advance!!</span></p></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, =
Apr 20, 2024 at 11:43=E2=80=AFPM abhijeet rajmane &lt;<a href=3D"mailto:abh=
i97.rajmane@gmail.com">abhi97.rajmane@gmail.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi,<div><sp=
an style=3D"color:rgb(51,51,51);font-family:Roboto,sans-serif;font-size:13p=
x">I have booted up the xlnx-versal-virt machine using qemu-system-aarch64.=
 I wanted to work with can device that has been modelled with this device. =
I have used the xilinx_can.c driver for this device and can see two can con=
trollers. The problem is I am not able to see any interrupts in /proc/inter=
rupts for both can devices. I have set them up and running. I have also con=
nected the canbus device to host to transmit and receive can packets. I am =
seeing qemu_set_irq() getting called. Am I=C2=A0missing something?</span><b=
r></div><div><span style=3D"color:rgb(51,51,51);font-family:Roboto,sans-ser=
if;font-size:13px"><br></span></div><div><span style=3D"color:rgb(51,51,51)=
;font-family:Roboto,sans-serif;font-size:13px">Thanks ,</span></div><div><f=
ont color=3D"#333333" face=3D"Roboto, sans-serif">Abhijeet, India</font></d=
iv></div>
</blockquote></div>

--0000000000001d4cb80617731cb5--

