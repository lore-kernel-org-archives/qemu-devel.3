Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669C3C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 21:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujP8U-0001EA-6u; Tue, 05 Aug 2025 17:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ujP8S-0001CA-Jh
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 17:23:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ujP6f-0005pU-HE
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 17:22:03 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575I3A6n016655
 for <qemu-devel@nongnu.org>; Tue, 5 Aug 2025 21:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9LzegMz7+fePNTkzT0cy3i9f
 lPnj96KFXgTsuxHByzs=; b=YCKmcgw1DuLebAl7l4f9dm59oZHTlZcxSrlZDspq
 RF+K0lVaEUBfa0GX8er1PExpFre45HyYWOQhnvFdZR6Yr6pwKFdE6t0Bo/W4NObV
 JFhFpdj9++mzH24eNZ8Otl1pLTWvxQG2klfVrHnv7EoKKUp4cASh8+VPmiqQWKlc
 cx6jbnE5ETCo9wiJK+Eus3iRuKjWMW/N1ppptTVthrnMTkO4w3McORrKbdVS8ndh
 Bm109RVtSsQR57+Asw0jDKX7X7VGA6h1B/fOEfGybRKPPWiIZin1aveK1fm53JAm
 9wz4rqUjf8heEsKrKDkdOzErYSSaw/4DdHm3y/WOXsDn6A==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpvxrfw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 21:21:59 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-71b76c2f9dcso5437457b3.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 14:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754428913; x=1755033713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9LzegMz7+fePNTkzT0cy3i9flPnj96KFXgTsuxHByzs=;
 b=nX2nOwAKGvW4qRwTp4QTZCUUKLFuPeLDQWKnhAhjAQvySS/dVKLvGMBqqQuccoIZA4
 89+wp90qIyN/h82RNcIRVfVaSZTw1RMsns2OWaspJRhB3ZJaPwIy6cSldvHepZcTC6n8
 MaNgISVjGmCFEYm9+kkvR9gpSqIoIryPegFB1uVqMqDES68YP8zVTA4yoxwE1FttC/rx
 TLddWNlAsNhQttNtTiJo+qhQ2r1i+XYqBmNLBD2XwU39kJWdXQrd9xeVgzosXNds4ORi
 iK3OODEP8CfipzstiiieVTkF5wpZiVt9J7YWOh70ZTAG7sONV9JzYibeHGtHflR1OJTo
 NnSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJpenOVVQLtEqckeFl5iBg6nsJ2+wWGYKeoLno/NKv7gHeUzZbYbeMsAz+sYZxiqD108ARk/eLcLUu@nongnu.org
X-Gm-Message-State: AOJu0Yy98W8AkrjEAela7gjwmdCiQF7fYPqur6F8xWKDgR6kRD+QUluL
 4c1AnBisgZqmVDh9MzFS1MWfNMGUYqUcH6CxYnzKzP81rtfrxFTBBqB3fAM0cinc1ufT7WkhY0m
 UhYE8r8PaF3B/iLclmv2rkHACkenFL8/KMLFKGVwDT5h3uMuqh7+3cck61X0H2I7/UVq+UjzmfX
 oyz+/dc/7t2tETFIYwNuLZHDQnu1Zuwy0C
X-Gm-Gg: ASbGnctoTYEnHpXnckaRzL7QUwRFZ5+99JTM2AneVqpMlovOXgKJKd+zGLG/ROV+7yo
 ORaoY4oIYrsKWYpBVmXsgIiIM7YTPpej/CNxRWt+UWKxKvMK5XsNMOFivrlQwatTNxpAezn94kG
 jaUtsWeZzF7TjjjA+X80T92KA=
X-Received: by 2002:a05:690c:d8b:b0:71b:6a28:8625 with SMTP id
 00721157ae682-71bca7d5eb5mr7036567b3.4.1754428913509; 
 Tue, 05 Aug 2025 14:21:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPnwq3txD2jJyhsJOkO4oU8hmP3C7CgM0fWbuvyH8sgL+Yeb1D103Kpn82G3ntmVGGvkEsyiOBxtirva0wMz8=
X-Received: by 2002:a05:690c:d8b:b0:71b:6a28:8625 with SMTP id
 00721157ae682-71bca7d5eb5mr7036267b3.4.1754428913098; Tue, 05 Aug 2025
 14:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
 <20250722201404.2368507-2-vacha.bhavsar@oss.qualcomm.com>
 <875xf36qyk.fsf@draig.linaro.org>
 <CAFEAcA8o4wEHHDXVj0Fcc3i8g+49psY7YSf1AqGiGe9vNuXiQA@mail.gmail.com>
 <87ikj3545v.fsf@draig.linaro.org>
 <CAFEAcA-Y7utLb9cciGJOVAPF8Y0W4RxcOLDnNS7ptpHtYVG_EQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-Y7utLb9cciGJOVAPF8Y0W4RxcOLDnNS7ptpHtYVG_EQ@mail.gmail.com>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Tue, 5 Aug 2025 17:21:42 -0400
X-Gm-Features: Ac12FXxEoK307_xclyylsffORrtGkWvQC6Dixng923kxQQIAE293gSnsVR2ufKY
Message-ID: <CAEWVDmsOD-vNc6YbwfND9yzfz-G8kEsFfpEtJ5A+duhUzGU2Pg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] target/arm: Increase MAX_PACKET_LENGTH for SME ZA
 remote gdb debugging
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000263562063ba4d054"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDE1MSBTYWx0ZWRfX8EMpu5ZAY35F
 q3oqSrtqlIjYorzOE0m4nJ4viRMoVbD5srLBVCbfRdcSxEBsW5ofj3wSrQseNTtRsW94djWvDiX
 tITYOOmIE32NeAJ8t8w483OOrhp+usZHyV9xFcW8ZVWX0UlZgDMELneM7o+PWpR8P/jdR5MvUBd
 tYcmf5yxsUp2N3jrcsaxXnTM5fqEwtKX7f1Yhf7n4IC9MkchYjtUn6E8xZHbtYXkJljh7D7BwEb
 /ld5ePg61Fisrs/+hM98tejx/5YWcdZlLX+7XmJYqNIdY2+TurIZGoYFhCpJbPtpf0uMVqTnZAW
 M5tlnWpVvVT5Qe7Pq6HvTYPZ/HV2dvqdFe/C1YNaOUxNNdyKp8jh+VDVY4SQguzBxacgEXKQTwy
 tk/75LJJNbNq2kzM1bgmZ7L0XlaEYoqcD1sGCAazLzgCEbExkc5zDSeo2zxlKQHGhZo5hSmO
X-Proofpoint-ORIG-GUID: 5rKNXDEbcnaWZdeLjeJxvs5L1BwvztK_
X-Proofpoint-GUID: 5rKNXDEbcnaWZdeLjeJxvs5L1BwvztK_
X-Authority-Analysis: v=2.4 cv=U5WSDfru c=1 sm=1 tr=0 ts=689275f7 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=ysKjdEX-O2Rk5GybrLIA:9 a=QEXdDO2ut3YA:10
 a=G7Fyde8CCOQofqUE0RsA:9 a=oi2fsgI5tDRuyCRK:21 a=lqcHg5cX4UMA:10
 a=kA6IBgd4cpdPkAWqgNAz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508050151
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000263562063ba4d054
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,



Thank you for your comments!



What exactly is the packet/response where MAX_PACKET_LENGTH is
causing problems? The commit message doesn't say.



The issue is that when we run something like set $za[0][0] =3D 0x01
in the gdb client, the client sends the entire contents on the new
expected za register value, at which point the client side gets stuck
and does not return the gdb prompt. The issue is found to be the following
code (line 2396 of gdbstub/gdbstub.c):



else if (gdbserver_state.line_buf_index >=3D sizeof(gdbserver_state.line_bu=
f)
- 1) {
                trace_gdbstub_err_overrun();
                gdbserver_state.state =3D RS_IDLE;



Since the current value of sizeof(gdbserver_state.line_buf) is 4096 whereas
the
entire contents of the P packet coming in from the gdb client is at least
131072
(twice the number of bytes in the za storage at max svl), the above
statement
eventually evaluates to true, causing the state machine to reset to RS_IDLE
and
treat the rest of the packet as if it's looking for a new command. This is
why
the client side gets stuck until there is a timeout and then debugging
continues
as usual.



For this reason, the MAX_PACKET_LENGTH value was increased in an effort to
increase
the size of gdbserver_state.line_buf and avoid entering the above mentioned
clause.





This sounds like something to query with the gdb devs
about what they expect the handling of the SME ZA storage should be.



Will do!



Thanks,
Vacha

On Mon, Aug 4, 2025 at 2:38=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Mon, 4 Aug 2025 at 19:32, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
> >
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> > > On Mon, 4 Aug 2025 at 16:34, Alex Benn=C3=A9e <alex.bennee@linaro.org=
>
> wrote:
> > >>
> > >> Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com> writes:
> > >>
> > >> > This patch increases the value of the MAX_PACKET_LEGNTH to
> > >> > 131100 from 4096 to allow the GDBState.line_buf to be large enough
> > >> > to accommodate the full contents of the SME ZA storage when the
> > >> > vector length is maximal. This is in preparation for a related
> > >> > patch that allows SME register visibility through remote GDB
> > >> > debugging.
> > >> >
> > >> > Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
> > >> > ---
> > >> > Changes since v3:
> > >> > - this patch was not present in version 3
> > >> >
> > >> >  gdbstub/internals.h | 2 +-
> > >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >> >
> > >> > diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> > >> > index bf5a5c6302..b58a66c201 100644
> > >> > --- a/gdbstub/internals.h
> > >> > +++ b/gdbstub/internals.h
> > >> > @@ -11,7 +11,7 @@
> > >> >
> > >> >  #include "exec/cpu-common.h"
> > >> >
> > >> > -#define MAX_PACKET_LENGTH 4096
> > >> > +#define MAX_PACKET_LENGTH 131100
> > >>
> > >> This is a rather large expansion for something that ends up in a
> static at:
> > >>
> > >>     char line_buf[MAX_PACKET_LENGTH];
> > >>
> > >> I think maybe its time to get rid of this hardcoded define and make
> line_buf a
> > >> dynamically re-sizeable buffer along the lines of str_buf and mem_bu=
f.
> > >> In fact make it a GString and we can get rid of line_buf_index as
> well.
> > >
> > > What exactly is the packet/response where MAX_PACKET_LENGTH is
> > > causing problems? The commit message doesn't say.
> >
> > I assume it would be the g/G or p/P packets. The docs don't seem to say
> > anything about them splitting them across multiple packets.
>
> Probably because nobody thought about the possibility of enormous
> registers. This sounds like something to query with the gdb devs
> about what they expect the handling of the SME ZA storage should be.
>
> > > In general I thought the gdbstub protocol was supposed to handle a
> > > fixed packet length (e.g. in handle_query_xfer_features() the respons=
e
> > > packet indicates truncation via "l" vs "m" so the gdb end knows it
> needs
> > > to send another request to get the rest of the data). So if we run
> > > into something which seems to be fixed by raising MAX_PACKET_LENGTH
> > > I would first want to look at whether the underlying problem is
> > > that we're not indicating to gdb "this data is incomplete, you'll
> > > need to ask for more of it" or something of that nature.
> >
> > The docs reference "bulk transfers":
> >
> >   =E2=80=98PacketSize=3Dbytes=E2=80=99
> >
> >       The remote stub can accept packets up to at least bytes in length=
.
> >       GDB will send packets up to this size for bulk transfers, and wil=
l
> >       never send larger packets. This is a limit on the data characters
> >       in the packet, not including the frame and checksum. There is no
> >       trailing NUL byte in a remote protocol packet; if the stub stores
> >       packets in a NUL-terminated format, it should allow an extra byte
> >       in its buffer for the NUL. If this stub feature is not supported,
> >       GDB guesses based on the size of the =E2=80=98g=E2=80=99 packet r=
esponse.
>
> We do advertise this.
>
> -- PMM
>

--000000000000263562063ba4d054
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi,</p><p>=C2=A0</p><p>Thank you for your comments!</p>=
<p>=C2=A0</p><p>What exactly is the packet/response where MAX_PACKET_LENGTH=
 is<br>
causing problems? The commit message doesn&#39;t say.</p><p>=C2=A0</p><p>Th=
e issue is that when we run something like set $za[0][0] =3D 0x01<br>
in the gdb client, the client sends the entire contents on the new<br>
expected za register value, at which point the client side gets stuck<br>
and does not return the gdb prompt. The issue is found to be the following<=
br>
code (line 2396 of gdbstub/gdbstub.c):</p><p>=C2=A0</p><p>else if (gdbserve=
r_state.line_buf_index &gt;=3D sizeof(gdbserver_state.line_buf) - 1) {<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 trace_gdbstub_err_overrun();<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 gdbserver_state.state =3D RS_IDLE;</p><p>=C2=A0</p><p>Since=
 the current value of sizeof(gdbserver_state.line_buf) is 4096 whereas the<=
br>
entire contents of the P packet coming in from the gdb client is at least 1=
31072<br>
(twice the number of bytes in the za storage at max svl), the above stateme=
nt<br>
eventually evaluates to true, causing the state machine to reset to RS_IDLE=
 and<br>
treat the rest of the packet as if it&#39;s looking for a new command. This=
 is why<br>
the client side gets stuck until there is a timeout and then debugging cont=
inues<br>
as usual.</p><p>=C2=A0</p><p>For this reason, the MAX_PACKET_LENGTH value w=
as increased in an effort to increase<br>
the size of gdbserver_state.line_buf and avoid entering the above mentioned=
 clause.</p><p>=C2=A0</p><p>=C2=A0</p><p>This sounds like something to quer=
y with the gdb devs<br>
about what they expect the handling of the SME ZA storage should be.</p><p>=
=C2=A0</p><p>Will do!</p><p>=C2=A0</p><p>Thanks,<br>
Vacha</p></div><br><div class=3D"gmail_quote gmail_quote_container"><div di=
r=3D"ltr" class=3D"gmail_attr">On Mon, Aug 4, 2025 at 2:38=E2=80=AFPM Peter=
 Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@lina=
ro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Mon, 4 Aug 2025 at 19:32, Alex Benn=C3=A9e &lt;<a href=3D"mailto:a=
lex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; wro=
te:<br>
&gt;<br>
&gt; Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=
=3D"_blank">peter.maydell@linaro.org</a>&gt; writes:<br>
&gt;<br>
&gt; &gt; On Mon, 4 Aug 2025 at 16:34, Alex Benn=C3=A9e &lt;<a href=3D"mail=
to:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;=
 wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Vacha Bhavsar &lt;<a href=3D"mailto:vacha.bhavsar@oss.qualcom=
m.com" target=3D"_blank">vacha.bhavsar@oss.qualcomm.com</a>&gt; writes:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt; This patch increases the value of the MAX_PACKET_LEGNTH =
to<br>
&gt; &gt;&gt; &gt; 131100 from 4096 to allow the GDBState.line_buf to be la=
rge enough<br>
&gt; &gt;&gt; &gt; to accommodate the full contents of the SME ZA storage w=
hen the<br>
&gt; &gt;&gt; &gt; vector length is maximal. This is in preparation for a r=
elated<br>
&gt; &gt;&gt; &gt; patch that allows SME register visibility through remote=
 GDB<br>
&gt; &gt;&gt; &gt; debugging.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Signed-off-by: Vacha Bhavsar &lt;<a href=3D"mailto:vacha=
.bhavsar@oss.qualcomm.com" target=3D"_blank">vacha.bhavsar@oss.qualcomm.com=
</a>&gt;<br>
&gt; &gt;&gt; &gt; ---<br>
&gt; &gt;&gt; &gt; Changes since v3:<br>
&gt; &gt;&gt; &gt; - this patch was not present in version 3<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 gdbstub/internals.h | 2 +-<br>
&gt; &gt;&gt; &gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; diff --git a/gdbstub/internals.h b/gdbstub/internals.h<b=
r>
&gt; &gt;&gt; &gt; index bf5a5c6302..b58a66c201 100644<br>
&gt; &gt;&gt; &gt; --- a/gdbstub/internals.h<br>
&gt; &gt;&gt; &gt; +++ b/gdbstub/internals.h<br>
&gt; &gt;&gt; &gt; @@ -11,7 +11,7 @@<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 #include &quot;exec/cpu-common.h&quot;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; -#define MAX_PACKET_LENGTH 4096<br>
&gt; &gt;&gt; &gt; +#define MAX_PACKET_LENGTH 131100<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This is a rather large expansion for something that ends up i=
n a static at:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0char line_buf[MAX_PACKET_LENGTH];<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I think maybe its time to get rid of this hardcoded define an=
d make line_buf a<br>
&gt; &gt;&gt; dynamically re-sizeable buffer along the lines of str_buf and=
 mem_buf.<br>
&gt; &gt;&gt; In fact make it a GString and we can get rid of line_buf_inde=
x as well.<br>
&gt; &gt;<br>
&gt; &gt; What exactly is the packet/response where MAX_PACKET_LENGTH is<br=
>
&gt; &gt; causing problems? The commit message doesn&#39;t say.<br>
&gt;<br>
&gt; I assume it would be the g/G or p/P packets. The docs don&#39;t seem t=
o say<br>
&gt; anything about them splitting them across multiple packets.<br>
<br>
Probably because nobody thought about the possibility of enormous<br>
registers. This sounds like something to query with the gdb devs<br>
about what they expect the handling of the SME ZA storage should be.<br>
<br>
&gt; &gt; In general I thought the gdbstub protocol was supposed to handle =
a<br>
&gt; &gt; fixed packet length (e.g. in handle_query_xfer_features() the res=
ponse<br>
&gt; &gt; packet indicates truncation via &quot;l&quot; vs &quot;m&quot; so=
 the gdb end knows it needs<br>
&gt; &gt; to send another request to get the rest of the data). So if we ru=
n<br>
&gt; &gt; into something which seems to be fixed by raising MAX_PACKET_LENG=
TH<br>
&gt; &gt; I would first want to look at whether the underlying problem is<b=
r>
&gt; &gt; that we&#39;re not indicating to gdb &quot;this data is incomplet=
e, you&#39;ll<br>
&gt; &gt; need to ask for more of it&quot; or something of that nature.<br>
&gt;<br>
&gt; The docs reference &quot;bulk transfers&quot;:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0=E2=80=98PacketSize=3Dbytes=E2=80=99<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0The remote stub can accept packets up to at =
least bytes in length.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GDB will send packets up to this size for bu=
lk transfers, and will<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0never send larger packets. This is a limit o=
n the data characters<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0in the packet, not including the frame and c=
hecksum. There is no<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trailing NUL byte in a remote protocol packe=
t; if the stub stores<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0packets in a NUL-terminated format, it shoul=
d allow an extra byte<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0in its buffer for the NUL. If this stub feat=
ure is not supported,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GDB guesses based on the size of the =E2=80=
=98g=E2=80=99 packet response.<br>
<br>
We do advertise this.<br>
<br>
-- PMM<br>
</blockquote></div>

--000000000000263562063ba4d054--

