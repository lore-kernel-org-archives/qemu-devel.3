Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465FAC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 21:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujlWv-0007c9-PV; Wed, 06 Aug 2025 17:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ujlWs-0007Vm-67
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 17:18:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ujlWn-0000kF-V9
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 17:18:33 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576KP2dD019477
 for <qemu-devel@nongnu.org>; Wed, 6 Aug 2025 21:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=019fvAfvY61ubdLK+MJRK4Rc
 N/o8mBYoD+QUQMNohWs=; b=kevslk3mc+zK2YrcJL5PMQ6BYrPeWXoia8t3sbwy
 zHCw1W4zhSWgykRnnzlvk+YD9krnfOrN0eQCiGJT9dU7Oux8WZ1UrapOPyQcW/Zs
 YefJctcJs77ePz8t0r7DCbScKpdLaAi87TltRVjKWsL8TcGDFTHSRAh0Db2hkN6i
 DyqxhewdrXkXa8rTJMsTYhZWr5cyp1ad5QLxrWmS3twO0XCw0fSEmMtommuraCgW
 cf272DahODU2w58EZjyukJMzrdAlQQZ6EhrWNqRiORPXQqAMDqLO6vs3p4wpKq7H
 C2jYxiZ6znbXdlPtppFzTtWBNg1OF6fz3Cu85D1RFyjQWA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c5869psc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 21:18:26 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-71b70ee9d3cso4859477b3.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 14:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754515105; x=1755119905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=019fvAfvY61ubdLK+MJRK4RcN/o8mBYoD+QUQMNohWs=;
 b=nsUnyjMtYAxBoeFmQV7I3fGvIrNaG9vPLRndWtlMSX1zCiiHkyqyZYgypKcKBTXjF0
 qwEI6WMM5thG8Tuv/NV8LjHiEchr7BB1YEU3UGuor5wpyCibemkvP/lFt7vcvnLBL16j
 jc3E2k/lk3RKKn44f0poPK2sLqzu69f4YVNxsIg+Hk1IiOzzyvs243iclikzN0lN2YZr
 ompBxRJuqB8Kr+/TcpzWlgsDppxHAx8A3wt2ULl5q/fogBbxm0g1KtoccmHmrrGRPZAy
 m4CF2Nl0DXon3aVWxlA6mGNsvbeNluZlvSbWn6sVz9kGkevxSdFqDy8hMfmX0CUoplVp
 1AMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKUvcK3ayvPXT1Nodmeajb9OvLruZbGWykkmagCCWuX3McGsL8UNvWgJhgX9goNIRLABBwpdJXgDIZ@nongnu.org
X-Gm-Message-State: AOJu0Yw218taDwK4gonTL7x8SXzdr8k61yiU4zTqbzPdHbA2dXyeuBiF
 ajEGDYu29BmXrFSNEoMCofFfHXtW2lt4VtPddDPLCIqb8675KAwGftsQIYXnLdHOLxwZp9sxx7K
 fR/p/GgiRtMpvQQX39TevK+ajIzUIxH3+I2kkWw5pmZC8nTOJfV2Sncx3uE31Zn/d/DnLPzyGge
 F6PNhY8UouP8xHZAXCupoMH+arEGl/WnVh
X-Gm-Gg: ASbGncs+YUpuv9hoSOKrhY+a+sCQKTaDr3M3J/EbSMvpwJtLZcEFFfBxPzRy3PNk0J4
 zquTaJU2avSk7WgyWTQIJKZlgYmVZziKNB+rS+vIGHXBObo77cWLjr85y/PsytzVJqWBmbovBl6
 3ZkYk4V7q98r3CeqbxP7GDAQ==
X-Received: by 2002:a05:690c:4987:b0:71a:3f0:b474 with SMTP id
 00721157ae682-71bdbbadd27mr12415727b3.15.1754515105275; 
 Wed, 06 Aug 2025 14:18:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnQflGgEZMxrZPbFjhLzji/pQbl8kO3gUHh5rBfDffWO9e+HfwkWLJaDR7mxwTO0K6VPU4mWTjYc+Z3GuExks=
X-Received: by 2002:a05:690c:4987:b0:71a:3f0:b474 with SMTP id
 00721157ae682-71bdbbadd27mr12415437b3.15.1754515104829; Wed, 06 Aug 2025
 14:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
 <20250722201404.2368507-2-vacha.bhavsar@oss.qualcomm.com>
 <875xf36qyk.fsf@draig.linaro.org>
 <CAFEAcA8o4wEHHDXVj0Fcc3i8g+49psY7YSf1AqGiGe9vNuXiQA@mail.gmail.com>
 <87ikj3545v.fsf@draig.linaro.org>
 <CAFEAcA-Y7utLb9cciGJOVAPF8Y0W4RxcOLDnNS7ptpHtYVG_EQ@mail.gmail.com>
 <CAEWVDmsOD-vNc6YbwfND9yzfz-G8kEsFfpEtJ5A+duhUzGU2Pg@mail.gmail.com>
In-Reply-To: <CAEWVDmsOD-vNc6YbwfND9yzfz-G8kEsFfpEtJ5A+duhUzGU2Pg@mail.gmail.com>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 17:18:13 -0400
X-Gm-Features: Ac12FXwSfH4n5PBuAfjP9UUy97IRpdxM2D-l9v0gBb_X0rw7fqmasLFY_ETNXY8
Message-ID: <CAEWVDms3R+_dv79GTdmzbJBJ3rb=hSi7rRj=f4rzRFwsHnzXJg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] target/arm: Increase MAX_PACKET_LENGTH for SME ZA
 remote gdb debugging
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000093a458063bb8e113"
X-Proofpoint-GUID: EJzRYlygfhUW7NS-47P1s7m50H-Rgz1h
X-Authority-Analysis: v=2.4 cv=MZpsu4/f c=1 sm=1 tr=0 ts=6893c6a2 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=2OwXVqhp2XgA:10 a=CCpqsmhAAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Y5IoXRAQ5wbCVYA3_6sA:9 a=QEXdDO2ut3YA:10
 a=cDrPwn1pVi0A:10 a=lfHhwvipLn8A:10 a=ysKjdEX-O2Rk5GybrLIA:9
 a=MDqUclHctDd_E8tH:21 a=lqcHg5cX4UMA:10 a=NcDAMoJu9mMA:10 a=u7sVq0hHrSIA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=ul9cdbp4aOFLsgKbc677:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: EJzRYlygfhUW7NS-47P1s7m50H-Rgz1h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA2NCBTYWx0ZWRfX2uKFyDwzGAZa
 75mx8XKXhl8FnUM7PIrSvX9b2X+nQc9OS9vFN9X4jCPCMWkZwkl7LvjlgSDr7f63M4FjAICB5UT
 +4FpsuH14rCTYBpOUKsklWSQ8OiPpNnLI8iy1FsxIBxQ8cHeenrxHbkbvCKnC6XdbxKhDrAe4UN
 p41U+qM0yp4tQJK4PWWiCoxGbsSBGegeROeuJbMZZEwMaBzBDgAV9oZBZv5fkinOB4pCT0/Sp2J
 tLYxaHY83W+53GSJrmi4kdWzoNHkIpdqBJ4cWSlWJqK5AK+IVKBZ/Q64USPxHPLxzuR48gP36qH
 MYHw4AO8sRphqPp/Jx6+t9HyIn2x9BiMJ+9Q4qeXHD8aPivFNX2U34QmGfiJXi2jPEkT0yewDq0
 l3B8i6Wy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060064
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

--00000000000093a458063bb8e113
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I reached out to the gdb dev team regarding these questions
on how to correctly handle the SME za storage. This discussion
can be found here:

https://sourceware.org/pipermail/gdb/2025-August/051858.html
https://sourceware.org/pipermail/gdb/2025-August/051860.html

It seems this approach of increasing the buffer size to above
131100 has also been applied to gdbserver as there currently
isn't support for partial data transfers.



Thanks,

Vacha

On Tue, Aug 5, 2025 at 5:21=E2=80=AFPM Vacha Bhavsar <vacha.bhavsar@oss.qua=
lcomm.com>
wrote:

> Hi,
>
>
>
> Thank you for your comments!
>
>
>
> What exactly is the packet/response where MAX_PACKET_LENGTH is
> causing problems? The commit message doesn't say.
>
>
>
> The issue is that when we run something like set $za[0][0] =3D 0x01
> in the gdb client, the client sends the entire contents on the new
> expected za register value, at which point the client side gets stuck
> and does not return the gdb prompt. The issue is found to be the followin=
g
> code (line 2396 of gdbstub/gdbstub.c):
>
>
>
> else if (gdbserver_state.line_buf_index >=3D
> sizeof(gdbserver_state.line_buf) - 1) {
>                 trace_gdbstub_err_overrun();
>                 gdbserver_state.state =3D RS_IDLE;
>
>
>
> Since the current value of sizeof(gdbserver_state.line_buf) is 4096
> whereas the
> entire contents of the P packet coming in from the gdb client is at least
> 131072
> (twice the number of bytes in the za storage at max svl), the above
> statement
> eventually evaluates to true, causing the state machine to reset to
> RS_IDLE and
> treat the rest of the packet as if it's looking for a new command. This i=
s
> why
> the client side gets stuck until there is a timeout and then debugging
> continues
> as usual.
>
>
>
> For this reason, the MAX_PACKET_LENGTH value was increased in an effort t=
o
> increase
> the size of gdbserver_state.line_buf and avoid entering the above
> mentioned clause.
>
>
>
>
>
> This sounds like something to query with the gdb devs
> about what they expect the handling of the SME ZA storage should be.
>
>
>
> Will do!
>
>
>
> Thanks,
> Vacha
>
> On Mon, Aug 4, 2025 at 2:38=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org>
> wrote:
>
>> On Mon, 4 Aug 2025 at 19:32, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> >
>> > Peter Maydell <peter.maydell@linaro.org> writes:
>> >
>> > > On Mon, 4 Aug 2025 at 16:34, Alex Benn=C3=A9e <alex.bennee@linaro.or=
g>
>> wrote:
>> > >>
>> > >> Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com> writes:
>> > >>
>> > >> > This patch increases the value of the MAX_PACKET_LEGNTH to
>> > >> > 131100 from 4096 to allow the GDBState.line_buf to be large enoug=
h
>> > >> > to accommodate the full contents of the SME ZA storage when the
>> > >> > vector length is maximal. This is in preparation for a related
>> > >> > patch that allows SME register visibility through remote GDB
>> > >> > debugging.
>> > >> >
>> > >> > Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
>> > >> > ---
>> > >> > Changes since v3:
>> > >> > - this patch was not present in version 3
>> > >> >
>> > >> >  gdbstub/internals.h | 2 +-
>> > >> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >> >
>> > >> > diff --git a/gdbstub/internals.h b/gdbstub/internals.h
>> > >> > index bf5a5c6302..b58a66c201 100644
>> > >> > --- a/gdbstub/internals.h
>> > >> > +++ b/gdbstub/internals.h
>> > >> > @@ -11,7 +11,7 @@
>> > >> >
>> > >> >  #include "exec/cpu-common.h"
>> > >> >
>> > >> > -#define MAX_PACKET_LENGTH 4096
>> > >> > +#define MAX_PACKET_LENGTH 131100
>> > >>
>> > >> This is a rather large expansion for something that ends up in a
>> static at:
>> > >>
>> > >>     char line_buf[MAX_PACKET_LENGTH];
>> > >>
>> > >> I think maybe its time to get rid of this hardcoded define and make
>> line_buf a
>> > >> dynamically re-sizeable buffer along the lines of str_buf and
>> mem_buf.
>> > >> In fact make it a GString and we can get rid of line_buf_index as
>> well.
>> > >
>> > > What exactly is the packet/response where MAX_PACKET_LENGTH is
>> > > causing problems? The commit message doesn't say.
>> >
>> > I assume it would be the g/G or p/P packets. The docs don't seem to sa=
y
>> > anything about them splitting them across multiple packets.
>>
>> Probably because nobody thought about the possibility of enormous
>> registers. This sounds like something to query with the gdb devs
>> about what they expect the handling of the SME ZA storage should be.
>>
>> > > In general I thought the gdbstub protocol was supposed to handle a
>> > > fixed packet length (e.g. in handle_query_xfer_features() the respon=
se
>> > > packet indicates truncation via "l" vs "m" so the gdb end knows it
>> needs
>> > > to send another request to get the rest of the data). So if we run
>> > > into something which seems to be fixed by raising MAX_PACKET_LENGTH
>> > > I would first want to look at whether the underlying problem is
>> > > that we're not indicating to gdb "this data is incomplete, you'll
>> > > need to ask for more of it" or something of that nature.
>> >
>> > The docs reference "bulk transfers":
>> >
>> >   =E2=80=98PacketSize=3Dbytes=E2=80=99
>> >
>> >       The remote stub can accept packets up to at least bytes in lengt=
h.
>> >       GDB will send packets up to this size for bulk transfers, and wi=
ll
>> >       never send larger packets. This is a limit on the data character=
s
>> >       in the packet, not including the frame and checksum. There is no
>> >       trailing NUL byte in a remote protocol packet; if the stub store=
s
>> >       packets in a NUL-terminated format, it should allow an extra byt=
e
>> >       in its buffer for the NUL. If this stub feature is not supported=
,
>> >       GDB guesses based on the size of the =E2=80=98g=E2=80=99 packet =
response.
>>
>> We do advertise this.
>>
>> -- PMM
>>
>

--00000000000093a458063bb8e113
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi,</p><p>I reached out to the gdb dev team regarding t=
hese questions<br>
on how to correctly handle the SME za storage. This discussion<br>
can be found here:</p><p><a aria-label=3D"Link https://sourceware.org/piper=
mail/gdb/2025-August/051858.html" id=3D"gmail-menurb2l" href=3D"https://sou=
rceware.org/pipermail/gdb/2025-August/051858.html" rel=3D"noreferrer noopen=
er" target=3D"_blank" class=3D"gmail-fui-Link gmail-___1q1shib gmail-f2hkw1=
w gmail-f3rmtva gmail-f1ewtqcl gmail-fyind8e gmail-f1k6fduh gmail-f1w7gpdv =
gmail-fk6fouc gmail-fjoy568 gmail-figsok6 gmail-f1s184ao gmail-f1mk8lai gma=
il-fnbmjn9 gmail-f1o700av gmail-f13mvf36 gmail-f1cmlufx gmail-f9n3di6 gmail=
-f1ids18y gmail-f1tx3yz7 gmail-f1deo86v gmail-f1eh06m1 gmail-f1iescvh gmail=
-fhgqx19 gmail-f1olyrje gmail-f1p93eir gmail-f1nev41a gmail-f1h8hb77 gmail-=
f1lqvz6u gmail-f10aw75t gmail-fsle3fq gmail-f17ae5zn" title=3D"https://sour=
ceware.org/pipermail/gdb/2025-august/051858.html">https://sourceware.org/pi=
permail/gdb/2025-August/051858.html</a><br><a aria-label=3D"Link https://so=
urceware.org/pipermail/gdb/2025-August/051860.html" id=3D"gmail-menurb2n" h=
ref=3D"https://sourceware.org/pipermail/gdb/2025-August/051860.html" rel=3D=
"noreferrer noopener" target=3D"_blank" class=3D"gmail-fui-Link gmail-___1q=
1shib gmail-f2hkw1w gmail-f3rmtva gmail-f1ewtqcl gmail-fyind8e gmail-f1k6fd=
uh gmail-f1w7gpdv gmail-fk6fouc gmail-fjoy568 gmail-figsok6 gmail-f1s184ao =
gmail-f1mk8lai gmail-fnbmjn9 gmail-f1o700av gmail-f13mvf36 gmail-f1cmlufx g=
mail-f9n3di6 gmail-f1ids18y gmail-f1tx3yz7 gmail-f1deo86v gmail-f1eh06m1 gm=
ail-f1iescvh gmail-fhgqx19 gmail-f1olyrje gmail-f1p93eir gmail-f1nev41a gma=
il-f1h8hb77 gmail-f1lqvz6u gmail-f10aw75t gmail-fsle3fq gmail-f17ae5zn" tit=
le=3D"https://sourceware.org/pipermail/gdb/2025-august/051860.html">https:/=
/sourceware.org/pipermail/gdb/2025-August/051860.html</a></p><p>It seems th=
is approach of increasing the buffer size to above<br>
131100 has also been applied to gdbserver as there currently<br>
isn&#39;t support for partial data transfers.</p><p>=C2=A0</p><p>Thanks,</p=
><p>Vacha</p></div><br><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 5, 2025 at 5:21=E2=80=AFPM V=
acha Bhavsar &lt;<a href=3D"mailto:vacha.bhavsar@oss.qualcomm.com">vacha.bh=
avsar@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><div dir=3D"ltr"><p>Hi,</p><p>=C2=A0</p><p>Thank you =
for your comments!</p><p>=C2=A0</p><p>What exactly is the packet/response w=
here MAX_PACKET_LENGTH is<br>
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
Vacha</p></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">On Mon, Aug 4, 2025 at 2:38=E2=80=AFPM Peter Maydell &lt;<a href=
=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro=
.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Mon, 4 Aug 2025 at 19:32, Alex Benn=C3=A9e &lt;<a href=3D"mailto:ale=
x.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; wrote=
:<br>
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
</blockquote></div>

--00000000000093a458063bb8e113--

