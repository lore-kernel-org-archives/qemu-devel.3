Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FF7F8FA90
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 15:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFD8L-0002bM-UN; Tue, 21 Apr 2026 11:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=257143ecd9=yixinwei@meta.com>)
 id 1wFCpi-0007f8-Ep
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 11:16:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=257143ecd9=yixinwei@meta.com>)
 id 1wFCpg-0006qX-9l
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 11:16:14 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LEwGH42819882
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 08:16:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=s2048-2025-q2; bh=Q+HAqv1JoBYMaPYHZUz2
 DteKWUtUnV+GGccl7A2wc8k=; b=S3N7lL87Gd5eRIzruiu58SsuUzFSWWjviOo4
 UxYkF7FTG/5wkMfAvLyE4kuW+ULgflXsYOD3tKwqBh/XMEZyoOKorNdQHB1MTvlr
 hjvHrM4yzlvjc0lzGiRAna3nhbDoNtHrWhC3g1s25Z4uw0t4BpGUMH0FdoCoW5PX
 vK/Bk+XGG7yCg10v7GGD7ELvVvPiIA6TwtaXc7w7LzfFZ1kiuhz/MgA7R/oGkCax
 K4j+U5XfKvyw2j/JRg04C+ZbqXl0i1FSS+UMsZ0nfdno4iRVkTaF5uRiXdhJeVXk
 ci/UQGuSDu0XgaB9bkuo3HB+u8vnxjgOkWCywDWZ9YZ2SvUd5w==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dm7pb8qxm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 08:16:08 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-46ebf50edc8so5525838b6e.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 08:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776784568; cv=none;
 d=google.com; s=arc-20240605;
 b=Cv1B0IMuoNpVa/xgsLv6PjrMDoELipzRmELPSVygZn9Euhy4/tXEyTTgr71jGQ447Z
 inMvzzRGbn0u88VoBn5mksDjBxfMq/IlUqpY0JjB0Yr6elkQ5KcEiyQ4/Uw/558P3tl3
 fimzmkM7mhhAdLFpqJXQ9v93iAOcYzCkPYWmPdEm7cql0wAzPyipRKClif6IbvnKeCY/
 wld2/FTF0vrCuu9bQpKNcFlP2qHTWB79Tzq73TuSY/AU1Jz5sHf+cQI+jbeQWoUBM9FV
 5xhPCtWnNXoR1D5QxrPL3iUu21PkyQ2+ILoZtpocg60PLpOpC+6LO07daX4GMezLvF5+
 fVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=wzmZCxYgYAVa4UjOPldpZ1TIqJhm8gbbqO1IkHASY0g=;
 fh=72cBVFvKn6C13TF7yNqSscfcnt0VF/CETMnYhRwsXeI=;
 b=X1go//pN3hjnr1B+ULxAWmTA6YIU6t3Infl6l3k2dnBbJ0KagCHq4I3SxfjvtD/nBd
 XSyny3g4gL7Zh4QBgEzeeIT1VSGD7dg7GzFhUQQKnXT0UXLY5ktYRENg008NYpVdjvv2
 GLax924CZsYO4SpsJoeBo4Wauq0LT0VXH8UIqRenhDoxVmNFVCvD7ps79C6Fd9BKtFJv
 +q9YYNcZCkNMklI/ruokYrAp0Lff1eEQ7VcnzAJu7WhczrxsJMyQVY2vZoAkf5PzEvS5
 eIlH6TOh53hVen+kwxNTQODlu0Fu1q5j59cvD0bqmUDV5k/7v64zvq6fGP07xsuRAQ6U
 8AEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776784568; x=1777389368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wzmZCxYgYAVa4UjOPldpZ1TIqJhm8gbbqO1IkHASY0g=;
 b=hLOmJKLgMgHvGGLUHp7ArR6VjQzJ9ylDT0wbVAr4YPi4jOMvAP926DhCbVBimiTIUk
 JA4pPEDSklNxAq/3NbX+fP7aJGXWZneew1NTozg6bB6YVJRVocBmaf8v8ObuFSYnJ/6N
 5M94li15BWQRrvF0oADIow/xuHiIN054l2jgJToDwWqrjWLnvVa0Uwvjls0xxZbyCB7R
 yNNfkaGGbzYEIOgDhKo1JwQ4NxuN9/KXgbGtRbJBpClTZcNabmxtIGbgcVFQUYFPJgyn
 dtm8t9w7gsjpkEMgT8ns6J5JttTnHJiwkX91ecOlP5uSIJGtvSxgND/hVRTjjDMFyQHc
 V0nw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yfrCqwDci2U1SU+K/M9J+IwGqzs0ETIb8JDln/MNcjRGG8agUTIg/MAstbQGGbbtklAabGtuwlEos@nongnu.org
X-Gm-Message-State: AOJu0YxzvFELyNESDBaEE9FoKugiGoXIXNaMc3AyRne5ixclIWZzlVSc
 Vxj+bDTBn6dBpz4N8oHVUxZYOOVBq/RqC7D1N1LDH79TuCk1/r7CWs3uIxscmVlhl++p4IzSn6f
 kii5ZxGRvow+2ZioLHhwfw2gyxQuToNd+2ZI2cW+KLijmLQzGpgnvwWVlZH5f8HwXb47ZhpYCy+
 7P+hugD0yLMipCPUZgMzRmWAi0Dpxv1Q==
X-Gm-Gg: AeBDiet3cqH3boTBTRsnO8bSRrzI8M1rlhYee2+zSf0Tgxoizs5CESEas/yx3Urxk6E
 tYerTtCD2xNh968IYKADiiQDl2PgSwiw3mNm+kY5e234mjpI7ercCQfNHzV2EIH9kf8MRdS6Whn
 Q8fxoet3+eLiKvimxVNdRs6wKivrgpJSQ9sQF2C09yPVetlXmDRtN97s8ooXEDvWc7R/O99eH0V
 VnZBL0JyyM80BIBb1g4rsnCLWuhuF26
X-Received: by 2002:a05:6808:181b:b0:467:2926:1252 with SMTP id
 5614622812f47-4799c9893b1mr10880705b6e.30.1776784567538; 
 Tue, 21 Apr 2026 08:16:07 -0700 (PDT)
X-Received: by 2002:a05:6808:181b:b0:467:2926:1252 with SMTP id
 5614622812f47-4799c9893b1mr10880622b6e.30.1776784566841; Tue, 21 Apr 2026
 08:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260409164938.6735-1-yixinwei@meta.com>
 <bf633e1f-f551-4c1c-abdf-e54d7e4136d0@linaro.org>
In-Reply-To: <bf633e1f-f551-4c1c-abdf-e54d7e4136d0@linaro.org>
From: Yixin Wei <yixinwei@meta.com>
Date: Tue, 21 Apr 2026 16:15:54 +0100
X-Gm-Features: AQROBzC5I19P6jsFPU_RInRN1uoXuQr1_1y0J1v8mdxek1J3b8KBWxjohzwMrDs
Message-ID: <CABe+LnuRJNwa=qyUOOVmNh33v0VEPBT+ob9MmycvU+DVaRSw=Q@mail.gmail.com>
Subject: Re: [PATCH] linux-user: fix off-by-one in
 host_to_target_for_each_rtattr()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Yixin Wei <easonwei1998@gmail.com>, qemu-devel@nongnu.org,
 laurent@vivier.eu, richard.henderson@linaro.org
Content-Type: multipart/alternative; boundary="000000000000f2ffca064ff9e490"
X-Proofpoint-GUID: 5vTCye0Ocsc4pbKuyI6h6eu9QF6fKS9r
X-Authority-Analysis: v=2.4 cv=XPgAjwhE c=1 sm=1 tr=0 ts=69e794b8 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22 a=p0WdMEafAAAA:8
 a=KKAkSRfTAAAA:8 a=VabnemYjAAAA:8 a=qr7BarQ9KK_9UhEucG8A:9 a=QEXdDO2ut3YA:10
 a=rnmfkr0EUUdJWwBj8w8A:9 a=ZATobgIS3O8Tltc4:21 a=lqcHg5cX4UMA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22 a=cvBusfyB2V15izCimMoJ:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 5vTCye0Ocsc4pbKuyI6h6eu9QF6fKS9r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE1MiBTYWx0ZWRfXxeM2340M/wV9
 6MssYVyHPSXcCG3WRIVj+lpFoWgePhJxONyH/c0NY8ZAOuiiMtk3ArcD/NE3MVLqdw6/fXEWNQh
 aXvPAWke4n9VJ6zl8W/ehWWVpVNb4B9xe/thIBPBgOW+dvKcJNiV4cuMD2HC61mOzqjXqcUbs0k
 gOREDF9REcGRyHkq3Mh4CsY4UIz1Nkw4XgULPWaIOnnIoKHqcV3ACoEBYc2bnLq4ngTk4nVSG2P
 IvvDD7J6rXsrOCY6C1usJ2UNRMNzrAwj8whyJY58GToFA80LjPQfzLiGWdUsLjfyLOoxN2gprAZ
 8dgQaBCRck19B+QACgWDev6xlCn3mNO251aQ5bRuYupFuuqhqDnZqsqybqChs5I6vuzbK0f7tnw
 W3dK4pbHPhS03vE97W/cWuXSTMDaZd3jJ1yGtF14Tz3zv+FgcCyAUfUWe0YS1I5ED4934/by8LF
 +hauhN9ESL20nL96kxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
Received-SPF: pass client-ip=67.231.153.30;
 envelope-from=prvs=257143ecd9=yixinwei@meta.com;
 helo=mx0b-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 21 Apr 2026 11:35:05 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000f2ffca064ff9e490
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Thanks for the review! Just curious about QEMU's typical merge workflow,
trying to get a sense of how long this usually takes to land once it's
validated.

It's a niche use case but it affects anyone using qemu-user on big-endian
targets, so would be nice to get it into a release at some point.

Thanks,
Yixin

On Thu, Apr 9, 2026 at 9:48=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> >
> On 9/4/26 18:49, Yixin Wei wrote:
> > host_to_target_for_each_rtattr() uses "len > sizeof(struct rtattr)"
> > as its loop condition. When the last rtattr in a netlink message has
> > exactly sizeof(struct rtattr) (4) bytes remaining, the loop exits
> > without byte-swapping its rta_len and rta_type. A big-endian guest
> > then reads rta_len in the wrong byte order and fails validation.
> >
> > The companion function target_to_host_for_each_rtattr() correctly
> > uses ">=3D" (added in commit fa2229dbf8). The kernel's RTA_OK macro
> > also uses ">=3D". Fix the host_to_target direction to match.
> >
>
> 10 years old bug, nice!
>
> Fixes: 6c5b5645ae0 ("linux-user: add rtnetlink(7) support")
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> > Resolves:
> https://urldefense.com/v3/__https://gitlab.com/qemu-project/qemu/-/issues=
/2485__;!!Bt8RZUm9aw!8GbeoUxJTV2Px--RJ27lNOg6O6xYuOKOwEP614qzPEoNam2D2rtWkp=
6O6vvuf1vAnD2-g02GCUsn$
> > Signed-off-by: Yixin Wei <yixinwei@meta.com>
> > ---
> >   linux-user/fd-trans.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
>

--000000000000f2ffca064ff9e490
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Philippe,<div><br></div><div>Thanks for the review=
! Just curious about QEMU&#39;s typical merge workflow, trying to get a sen=
se of how long this usually takes to land once it&#39;s validated.<br><br>I=
t&#39;s a niche use case but it affects anyone using qemu-user on big-endia=
n targets, so would be nice to get it into a release at some point.</div><d=
iv><br></div><div>Thanks,</div><div>Yixin</div></div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Apr 9, 2026 at 9:48=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D=
"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 9/4/26 18:49, Yixin Wei wrote:<br>
&gt; host_to_target_for_each_rtattr() uses &quot;len &gt; sizeof(struct rta=
ttr)&quot;<br>
&gt; as its loop condition. When the last rtattr in a netlink message has<b=
r>
&gt; exactly sizeof(struct rtattr) (4) bytes remaining, the loop exits<br>
&gt; without byte-swapping its rta_len and rta_type. A big-endian guest<br>
&gt; then reads rta_len in the wrong byte order and fails validation.<br>
&gt; <br>
&gt; The companion function target_to_host_for_each_rtattr() correctly<br>
&gt; uses &quot;&gt;=3D&quot; (added in commit fa2229dbf8). The kernel&#39;=
s RTA_OK macro<br>
&gt; also uses &quot;&gt;=3D&quot;. Fix the host_to_target direction to mat=
ch.<br>
&gt; <br>
<br>
10 years old bug, nice!<br>
<br>
Fixes: 6c5b5645ae0 (&quot;linux-user: add rtnetlink(7) support&quot;)<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
<br>
&gt; Resolves: <a href=3D"https://urldefense.com/v3/__https://gitlab.com/qe=
mu-project/qemu/-/issues/2485__;!!Bt8RZUm9aw!8GbeoUxJTV2Px--RJ27lNOg6O6xYuO=
KOwEP614qzPEoNam2D2rtWkp6O6vvuf1vAnD2-g02GCUsn$" rel=3D"noreferrer" target=
=3D"_blank">https://urldefense.com/v3/__https://gitlab.com/qemu-project/qem=
u/-/issues/2485__;!!Bt8RZUm9aw!8GbeoUxJTV2Px--RJ27lNOg6O6xYuOKOwEP614qzPEoN=
am2D2rtWkp6O6vvuf1vAnD2-g02GCUsn$</a> <br>
&gt; Signed-off-by: Yixin Wei &lt;<a href=3D"mailto:yixinwei@meta.com" targ=
et=3D"_blank">yixinwei@meta.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0linux-user/fd-trans.c | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
</blockquote></div>

--000000000000f2ffca064ff9e490--

