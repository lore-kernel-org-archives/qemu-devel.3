Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0186BC54E41
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 01:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri2Ae-0003VK-A1; Wed, 06 Mar 2024 20:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuyb845@gmail.com>)
 id 1ri2Ac-0003UX-19; Wed, 06 Mar 2024 20:03:38 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liuyb845@gmail.com>)
 id 1ri2AZ-0000fw-I6; Wed, 06 Mar 2024 20:03:37 -0500
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-5cf2d73a183so1060313a12.1; 
 Wed, 06 Mar 2024 17:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709773412; x=1710378212; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3/FRIEolAf8UChjRh93kLurFdF1eCFnXs9B6ZoCzHqM=;
 b=C4AO9nVdWCMju+RDEL9vCZui8KlvbmOYHy9OL4WhbDO0RCKAYEmZhzoeRS+aHUx5aw
 59X6rQEiTAE9I1pwJ8oAe6TbE6wVterwy6BT7gu+74MRe+5VzGgBeznwo5KAEOTIWraB
 DR60A5iYOOA6faDvkMCpw+w9epi7vY9xJplr8qJvCf3GZh6APG8/l6kgKHXd1VGkt5Yk
 s3SF7Xz+DId7XYNgd16as6Z1KM1fpa+demyhhq482M1dp4MmO4VAhl5xqCQ+rwBIesNw
 4Hd0+dVHPcQh60CgxZPupU+VvbyBYhA42ip3mlhIoFaBuoB6liiDJ79wfndZF6deN17W
 SimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709773412; x=1710378212;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3/FRIEolAf8UChjRh93kLurFdF1eCFnXs9B6ZoCzHqM=;
 b=FDIfM5IF68/5tm38mrULy4lgGsQisC9e3ZpJ3YbSE8qmPtdyjbvL2DGXV8FR0aoHIJ
 ZToSY3fH2Ttza5BZHNeRW2BNIgkxMeDOuakzB/DqtonCWkMy7A/dL5deqTfjEk3JdrUk
 WaMhd+IgGIqshyXydw8qpSxf4nfC5qlEP1JzqGApkiKsB+9CKbdYGKG6NRGfDr/Me7J5
 JMDTBSp0bOpw/6XANrjBHFp3j4GWOY1ami7HnMvscPZWwU7WhOahvdFQhtXAVlWbYvvU
 GilVsc/DN/7w41taZy7nvrQkOq0PoMcuu7aoxomofzhBRQ/yCXc7/rGzcuN6nwtqqLI6
 z/0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcfKQPCiit7JJu/9NNScvuFvQCiTKuM34JWJG2k2wjr5QgvZEf8V3aBvlqsjFzfDnQlZ4EZsSn3iZzim55cuATHWFfZj+77Txl051PnOwaPecHiHHxE0mvJSo=
X-Gm-Message-State: AOJu0Yzo72KJ3UzjbuiNRfdBzh0pOTpiQMkO/J6LRiM9uRjshyt0DR6S
 KACfyIrd/t4ilSfYxRZf7gS7Rmct2XOGoxcyAaP8g2oNMPSoS0pmNUVQNEu0wKUnKcaHNKySJZs
 r9GwWSVcqLfrmXZYQ6CpPWaOxWa8=
X-Google-Smtp-Source: AGHT+IEZ4O8eR01dZGw/tLVwdgaKpdYxKZhVN2pz6cZk0/FvvmVKDH4ofS6Iey+19fFhVu9JLt+qvijBq2Tw6GfRjCA=
X-Received: by 2002:a17:90a:fb4c:b0:29a:6395:a67a with SMTP id
 iq12-20020a17090afb4c00b0029a6395a67amr28819pjb.4.1709773412187; Wed, 06 Mar
 2024 17:03:32 -0800 (PST)
MIME-Version: 1.0
References: <CAKstcpWLhcNswkippmDyQQz2bPKSN+w9F0jZzcZRGpuNWvW55g@mail.gmail.com>
 <CAFEAcA-eDU_As==Yzd5+xhAPKGzfUp2DH_Kj1owL3jvm8s+qWg@mail.gmail.com>
In-Reply-To: <CAFEAcA-eDU_As==Yzd5+xhAPKGzfUp2DH_Kj1owL3jvm8s+qWg@mail.gmail.com>
From: yb liu <liuyb845@gmail.com>
Date: Thu, 7 Mar 2024 09:03:20 +0800
Message-ID: <CAKstcpVT-swdej7ghk6Sc3Ngwb-ZSrVDUw1=4Rxq5EHOgfjPvQ@mail.gmail.com>
Subject: Re: QEMU Compatibility for Cortex-A55 AArch32 Firmware
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-discuss@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e14923061307a4c6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=liuyb845@gmail.com; helo=mail-pg1-x542.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000e14923061307a4c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot for you respond me soon!
The exact instruction is mrc, and the exception happended in early boot
process. I have no idea to how to debug this error because it happended in
code_gen_prologue.
I need to comform that whether QEMU A55 fully supports aarch32 mode. If it
need me to add addition instructions to support this function, I will
suspend this task for now.
I hope to get your respond as soon as possible.
Best regards!

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E 2024=E5=B9=B43=E6=9C=886=
=E6=97=A5=E5=91=A8=E4=B8=89 23:24=E5=86=99=E9=81=93=EF=BC=9A

> On Wed, 6 Mar 2024 at 14:33, yb liu <liuyb845@gmail.com> wrote:
> >
> >
> > Dear QEMU developers
> >
> > I hope this email finds you well. We are currently facing an issue
> related to QEMU and the Cortex-A55 architecture. Specifically, we have
> compiled a firmware for Cortex-A55 and would like it to run smoothly on
> QEMU A55 in AArch32 mode.
> >
> > Despite our numerous attempts, we continue to encounter an "undefined
> instruction" error when running the firmware in QEMU. Our question is
> whether QEMU supports this particular use case=E2=80=94specifically, whet=
her it can
> handle A55 running AArch32 firmware.
>
> We have Cortex-A55 emulation, but you may be running into one
> of a few problems:
>  * we might have a bug
>  * firmware sometimes does very low level stuff that no other guest
>    code does, so it might run into something we didn't get round
>    to implementing (eg it is trying to touch one of the implementation
>    specific system registers: we tend to implement these as "does
>    nothing" stubs, but it looks like we didn't bother for the A55,
>    presumably because Linux didn't care)
>  * your guest code might be doing something that works on the
>    real A55 hardware but which is architecturally UNPREDICTABLE:
>    QEMU doesn't try to exactly match device-specific IMPDEF
>    and UNPREDICTABLE things
>  * your guest code might be assuming the presence of some feature
>    that your real A55 has but which QEMU doesn't implement
>    (for instance we implement only the absolute minimum RAS
>    support required by the architecture, not the full RAS
>    that hardware implements)
>
> The thing you'd need to do is look at exactly what the UNDEF
> instruction is (and what the guest code that causes it is
> trying to do) to figure out which of these is the problem.
> Some of these might be easy to fix; some would be harder.
> If you're in a position to be able to modify the firmware
> image then that would also allow you to work around missing
> QEMU functionality if necessary.
>
> The more usual reason guest firmware not working in QEMU is
> not the CPU emulation itself but lack of a model of the
> device/SoC/etc hardware that the firmware assumes it's
> running on.
>
> -- PMM
>

--000000000000e14923061307a4c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">Thanks a lot for you respond me soon!</=
div>The exact instruction is mrc, and the exception happended in early boot=
 process. I have no idea to how to debug this error because it happended in=
 code_gen_prologue.<div dir=3D"auto">I need to comform that whether QEMU A5=
5 fully supports aarch32 mode. If it need me to add addition instructions t=
o support this function, I will suspend this task for now.</div><div dir=3D=
"auto">I hope to get your respond as soon as possible.</div><div dir=3D"aut=
o">Best regards!</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">Peter Maydell &lt;<a href=3D"mailto:peter.maydell@lin=
aro.org">peter.maydell@linaro.org</a>&gt; =E4=BA=8E 2024=E5=B9=B43=E6=9C=88=
6=E6=97=A5=E5=91=A8=E4=B8=89 23:24=E5=86=99=E9=81=93=EF=BC=9A<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">On Wed, 6 Mar 2024 at 14:33, yb liu &lt;<a href=
=3D"mailto:liuyb845@gmail.com" target=3D"_blank" rel=3D"noreferrer">liuyb84=
5@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; Dear QEMU developers<br>
&gt;<br>
&gt; I hope this email finds you well. We are currently facing an issue rel=
ated to QEMU and the Cortex-A55 architecture. Specifically, we have compile=
d a firmware for Cortex-A55 and would like it to run smoothly on QEMU A55 i=
n AArch32 mode.<br>
&gt;<br>
&gt; Despite our numerous attempts, we continue to encounter an &quot;undef=
ined instruction&quot; error when running the firmware in QEMU. Our questio=
n is whether QEMU supports this particular use case=E2=80=94specifically, w=
hether it can handle A55 running AArch32 firmware.<br>
<br>
We have Cortex-A55 emulation, but you may be running into one<br>
of a few problems:<br>
=C2=A0* we might have a bug<br>
=C2=A0* firmware sometimes does very low level stuff that no other guest<br=
>
=C2=A0 =C2=A0code does, so it might run into something we didn&#39;t get ro=
und<br>
=C2=A0 =C2=A0to implementing (eg it is trying to touch one of the implement=
ation<br>
=C2=A0 =C2=A0specific system registers: we tend to implement these as &quot=
;does<br>
=C2=A0 =C2=A0nothing&quot; stubs, but it looks like we didn&#39;t bother fo=
r the A55,<br>
=C2=A0 =C2=A0presumably because Linux didn&#39;t care)<br>
=C2=A0* your guest code might be doing something that works on the<br>
=C2=A0 =C2=A0real A55 hardware but which is architecturally UNPREDICTABLE:<=
br>
=C2=A0 =C2=A0QEMU doesn&#39;t try to exactly match device-specific IMPDEF<b=
r>
=C2=A0 =C2=A0and UNPREDICTABLE things<br>
=C2=A0* your guest code might be assuming the presence of some feature<br>
=C2=A0 =C2=A0that your real A55 has but which QEMU doesn&#39;t implement<br=
>
=C2=A0 =C2=A0(for instance we implement only the absolute minimum RAS<br>
=C2=A0 =C2=A0support required by the architecture, not the full RAS<br>
=C2=A0 =C2=A0that hardware implements)<br>
<br>
The thing you&#39;d need to do is look at exactly what the UNDEF<br>
instruction is (and what the guest code that causes it is<br>
trying to do) to figure out which of these is the problem.<br>
Some of these might be easy to fix; some would be harder.<br>
If you&#39;re in a position to be able to modify the firmware<br>
image then that would also allow you to work around missing<br>
QEMU functionality if necessary.<br>
<br>
The more usual reason guest firmware not working in QEMU is<br>
not the CPU emulation itself but lack of a model of the<br>
device/SoC/etc hardware that the firmware assumes it&#39;s<br>
running on.<br>
<br>
-- PMM<br>
</blockquote></div>

--000000000000e14923061307a4c6--

