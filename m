Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BBDE83847
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 01:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs9RC-00062Z-Rw; Mon, 16 Feb 2026 19:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vs9R7-0005yc-Hh
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 19:59:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vs9R5-0005jj-GW
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 19:59:33 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GL82wF1614018
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 00:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D+5ep5LF1wqwAwHOarLnCnbnHDWQN41UBk+lvecn/pQ=; b=OWFe4w/zHlBkpXF+
 6HY+lvUC0V8EzWNFJoiKBw0PhCCEsL25yZDQii9yMN+DEHxykxScM/RV9iBZoTHm
 w81hIQW6xGSw2Tr05eTQotpqXtgcv7vKHpg1pSjedC5t2FBuEt/Jr9sst0aoXnc0
 ea4xP4IlxUId6sl2DEfpzpQOy4R7RUibrfQ5XNBiMFm/36DkDWab8MMRX1GT8lYf
 Wu6IhF4u6HOe0wOp/lnGKdwua2J6Myuqf5TO7VbB5pN4UozoJVxsmoyNf9qTC/1n
 8KnXvieIj5kjgEQaA2qlUgJQW92g3OHMI2++b3scElBhMIqoi7HW1k33dmgk1HuC
 K5raPQ==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc662rws6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 00:59:26 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6445cf02fcbso4813424d50.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 16:59:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771289966; cv=none;
 d=google.com; s=arc-20240605;
 b=GNtcHbGMXoIxiRvU3EcWYX3i3wLuQC1Cuz1WwqehJ0p5mYxHUfIV0Kvm171tvro2P2
 3ZB1Iy/Xb0WjppYoM4NsdFen4rGpIOcoLgs6ccBnoqrSv0RqEhKt0Oy7rK4VYJt6D82f
 P09jV3nd5nM8mWxFwK7mdBhGvgI0sT4/wIRihW0QTMg6doD6PDIARSVBEQW32mFk1m5n
 fOuGupcYO35n0RPLaJsirEQ7K+00NGkBReACAV3ndemLFjzBQmGX9TI6HqnAWP5ObVID
 I9L+OL8GxD4wmlwzbyCjRaD8F/OfIfnZ87izA16CVQ2ZqunMyzjsFc8mPyWogSEe8RBg
 z02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D+5ep5LF1wqwAwHOarLnCnbnHDWQN41UBk+lvecn/pQ=;
 fh=xHga+j2HjOm4qNr9gBS2hjEzJrMXNSU71RV9t+Ku7b4=;
 b=NqwzUK2wQ5Sb8JrXPsLJi6PqIZxBoXQ6CZEOQNEdiwqSfFGnZCrsueYmSkJa3vtrQh
 K0qtKnSt5hfwNRoZoolmcMTkdpaA/QH9ykJ6gGkApt7cw3+yhikt47PtzXUrJFVOwFss
 o8KKVPY1nCwVuTkfUz4/x2zupp94dEiqhLmBSvAAh9i63swLmg5EhLUjsUCPuBvwHqsO
 zkbxW1MT57A0RWON4tWuW2Sfe3wFoKGk8TikEfP1o8WN+qjtqEqhhnKjvQF5CPYlCyqR
 cdp3sjg0dPRQlVfl3wklPy205CHk4Lsc7qFbOHosCPx20FF4e/GO4j4NjBUvCj1WUKbE
 tdBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771289966; x=1771894766; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+5ep5LF1wqwAwHOarLnCnbnHDWQN41UBk+lvecn/pQ=;
 b=Ge6RFIkw7vtzynHXuNk7uIuylagPjNmA0njMrj2fvHPSsHJBFarx8cXqXWBgZACWho
 LyuYPJow3G0SfuwThg15XAmNxs7xKMfWAAALeBKAHMANM78QQG1XcPSHNkKiiaQoxWJV
 0iEnPdKvmmi1KwIHzyPbTlLs28D3fsldujfs2dm86uxnajhdQsOYhWagh1UiuLcuCPJT
 vsPBmEGB3dqVlBPjE2crJTaW1pvIZCKt8yU5ptt1yiYgJ5cmbPupQIBXcphIlBAeZZdq
 AjMgKiwpdgH6sbbOxtJ3P1SBMxx1Ix4WS09wIzY7NCGfIfUEg3b9urdSB3LODKxPevOW
 Ikog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771289966; x=1771894766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D+5ep5LF1wqwAwHOarLnCnbnHDWQN41UBk+lvecn/pQ=;
 b=c8+eu7bPQ97Lf1DAG0TQhyOQdKkAzQiAA5pEv4anXxratEDFCa0pcmqOhNQFy4BSyu
 ltilB3qkVI5FEX+bGWSUWnvxD7cv7x9iU1ccs32Z0mKtsNSC8C0jjdsJvzCuuYQDd9CF
 vOVljW0Xz6xIHnjVqvcFDTJrZeIzwXKNR6m/8fAN80OGIkY6vnZ6Okuriu+jLMf9WWDD
 ibDOqPln4q1DObWM38tEaq6Kq4t5uDRrMHiuOTx0M6EigDN9EbpAaRlN4EV8hRGBb6Sx
 Zfb5XEa50z6l9LozmzZgstJyCnJYoZB/UGhLJhSdKc8Yk6qrT84wfb1IdL89kddHYTJ8
 laZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+tFw85bUOqgzWoEGRzN9tmoCOjGXB8OCGaPilG6CgAlbugbsMWwCrCDz/nU4ISyUhe6jqKtnyRujX@nongnu.org
X-Gm-Message-State: AOJu0YzAlfOYAey++dpWc3OupV4+40qNqBOR7UDy8n0tv59DvelfBkcI
 jZkAr66Ut1vQxabcG5AifBkWPz1JYMhCzpDCghUfgjVCWi1gYflDxhCtWN/UubwGEpkkEvvo+se
 7Ojlg4CLeurAf+mAPxQ7pPtoLJR0pBAk3NXBfrKzDEdA89LnnZwgIx4BNe66rWGnGH0S/Hob5uy
 XzzfS5zm3G4SW+SQqAc8UKu9Ytkn264zA2
X-Gm-Gg: AZuq6aLTW7FTNrq+Z48fzJBv6oL4tl+R8yUtD2oQiTvX5FV4pGyGgmnT5qz70Ee0psN
 sqzDm7IbwsbMxUU0XNYeSCovAx/1m5gb2qx0Y40kjDeDt5xgrUqFA93WzB+riF3sCzfWd1FERjj
 TWh3x4rbV+KB1sZdctjcNYLK6g6HmKGKKslu97rgUx640pt7MAjQ/SLi9rIKVTM0D/8FHyvfIOG
 t1HYwk=
X-Received: by 2002:a05:690c:34c3:b0:794:ed66:8696 with SMTP id
 00721157ae682-797a0bfaddfmr215365837b3.23.1771289966411; 
 Mon, 16 Feb 2026 16:59:26 -0800 (PST)
X-Received: by 2002:a05:690c:34c3:b0:794:ed66:8696 with SMTP id
 00721157ae682-797a0bfaddfmr215365607b3.23.1771289965901; Mon, 16 Feb 2026
 16:59:25 -0800 (PST)
MIME-Version: 1.0
References: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
 <20260215220422.212249-3-ltaylorsimpson@gmail.com>
 <aZMy2j7pxhNePNl_@hive.localdomain>
 <CAATN3NqDC_aHmsQ_yu-YkDw2OnjPyoi2_wDHeBWpEecn+pxn3A@mail.gmail.com>
In-Reply-To: <CAATN3NqDC_aHmsQ_yu-YkDw2OnjPyoi2_wDHeBWpEecn+pxn3A@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 18:59:10 -0600
X-Gm-Features: AZwV_QhJlFnXaFxAVh1aAMnnZ3gArcCeXpFXXh9OlTBr28zhJ33cqNlQPCWyAXY
Message-ID: <CAEqNhNa9QpO5jceh+Z6Qkz0fS1+Rp3kxN2g0cSNBMj8oZdeFnw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] Hexagon (linux-user/hexagon) Identify Hexagon
 version in ELF file
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, ale@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDAwNiBTYWx0ZWRfX9/X9/Z3JSyli
 5vCFwM6qi2AzA3E7H7lbl4OW30FV82opKu7512CkGZ+fJLwrr16cnYqBDwmxaa3sVmwKsbBGGJN
 3/Q2ClFFutJHtL1XOOH635kbqj2HPvJrFXvTHbowRd+mMA2wpNUqN69h3dTLCyt+aZ64npB+nAK
 bAvzDTtLit0zsCcB1m0JtpTPebhU4Akzzsds/l/Q4QLojVl7BxK0XV4RMsmU4tMa7GhDkS6+nV/
 01nNI6caSM8wsnKvx4ujnmMjAkViDQpvKFKBAlqdj0LOcVaTSQqktCcYVeSH11wc+7vZ0oja1Ih
 KGGC4kPEYeaWVoxHwC9SdVKiF30xv93HJPgghjpmLLBix347zI4jzX6v2tdNx46Y3m+jac5ozw4
 10Qc5frzbx6figzwnkPMwm0P6+RT4rtyDmqh3UcJMxmZkDYDiZBQJSwpRQyI5YVB/yChgfFiXMI
 DDuAuNWlsdXWlUknxbw==
X-Authority-Analysis: v=2.4 cv=Y6b1cxeN c=1 sm=1 tr=0 ts=6993bd6e cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=wKFDai2ckxtJ15ac0SsA:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-GUID: 1Utn-FJVd9GfITAhBbF9XJpVWCpu9xe4
X-Proofpoint-ORIG-GUID: 1Utn-FJVd9GfITAhBbF9XJpVWCpu9xe4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170006
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On Mon, Feb 16, 2026 at 6:47=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
>
>
> On Mon, Feb 16, 2026 at 8:05=E2=80=AFAM Anton Johansson <anjo@rev.ng> wro=
te:
>>
>> On 15/02/26, Taylor Simpson wrote:
>> > Return proper Hexagon CPU version from get_elf_cpu_model
>> >
>> > Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qua=
lcomm.com>
>> > Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>> > ---
>> >  linux-user/hexagon/elfload.c | 43 ++++++++++++++++++++++-------------=
-
>> >  1 file changed, 26 insertions(+), 17 deletions(-)
>> >
>> > diff --git a/linux-user/hexagon/elfload.c b/linux-user/hexagon/elfload=
.c
>> > index d8b545032a..39b0201814 100644
>> > --- a/linux-user/hexagon/elfload.c
>> > +++ b/linux-user/hexagon/elfload.c
>> > @@ -10,23 +10,32 @@ const char *get_elf_cpu_model(uint32_t eflags)
>> >      static char buf[32];
>> >      int err;
>> >
>> > -    /* For now, treat anything newer than v5 as a v73 */
>> > -    /* FIXME - Disable instructions that are newer than the specified=
 arch */
>> > -    if (eflags =3D=3D 0x04 ||    /* v5  */
>> > -        eflags =3D=3D 0x05 ||    /* v55 */
>> > -        eflags =3D=3D 0x60 ||    /* v60 */
>> > -        eflags =3D=3D 0x61 ||    /* v61 */
>> > -        eflags =3D=3D 0x62 ||    /* v62 */
>> > -        eflags =3D=3D 0x65 ||    /* v65 */
>> > -        eflags =3D=3D 0x66 ||    /* v66 */
>> > -        eflags =3D=3D 0x67 ||    /* v67 */
>> > -        eflags =3D=3D 0x8067 ||  /* v67t */
>> > -        eflags =3D=3D 0x68 ||    /* v68 */
>> > -        eflags =3D=3D 0x69 ||    /* v69 */
>> > -        eflags =3D=3D 0x71 ||    /* v71 */
>> > -        eflags =3D=3D 0x8071 ||  /* v71t */
>> > -        eflags =3D=3D 0x73       /* v73 */
>> > -       ) {
>> > +    switch (eflags) {
>> > +    case 0x04:
>> > +        return "v5";
>> > +    case 0x05:
>> > +        return "v55";
>> > +    case 0x60:
>> > +        return "v60";
>> > +    case 0x61:
>> > +        return "v61";
>> > +    case 0x62:
>> > +        return "v62";
>> > +    case 0x65:
>> > +        return "v65";
>> > +    case 0x66:
>> > +        return "v66";
>> > +    case 0x67:
>> > +    case 0x8067:        /* v67t */
>> > +        return "v67";
>> > +    case 0x68:
>> > +        return "v68";
>> > +    case 0x69:
>> > +        return "v69";
>> > +    case 0x71:
>> > +    case 0x8071:        /* v71t */
>> > +        return "v71";
>> > +    case 0x73:
>> >          return "v73";
>> >      }
>>
>> Hmm could we not add v67t/v71t to HexagonVersion and use the enums here?
>>
>> --
>> Anton Johansson
>> rev.ng Labs Srl.
>
>
> Brian Cain, please advise.  Aren't the "t" cores just micorarchitecture d=
ifferences that aren't modelled in QEMU?

Yes - that's the case.  In practice they happen to usually include the
audio ISA extension but I don't think that's necessarily implied by
the tiny core.

-Brian

