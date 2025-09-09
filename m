Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1287ECAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 16:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw0wT-0007km-58; Tue, 09 Sep 2025 12:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uw0wO-0007kK-FX
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:11:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uw0wG-0001n0-J3
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:11:31 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LQ0f009065
 for <qemu-devel@nongnu.org>; Tue, 9 Sep 2025 16:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=1S+8/GmANSsit+oC8iJ8NZuI
 Ic/8K6Qrgest0rjjDOY=; b=Mhb1oDNpV4uATpDgJupqcF8lTBA0mBWnQQ3vbJi0
 B9kL7lYWjS8DCOGwVA2w+v4M5xn4faoMigsOSyu79Lli3kL8IlBNU0m1slbDeHyu
 7XONJ/COJgnMQNFEecS6chwe3ijcBv5dUQbU1oZwBOz2aanRmBBlVEJje8pi70Xi
 FHRfRM4Mork7AMpzEOZYk3485zlDnEvT21RMm1yxNHcAp2hF4hRt+CxVYG7ZD++3
 CG6yXChXXyYbHRD2VCYhfOyieAReRZUkzhc0zv/kUj3WS4WooLa5FVAXUtprO0wN
 bEWHIsL7sh5b4PyWeQIUDTeMN4IwUgZ6FwmZ8Vy6ptKyhw==
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdwn4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 16:11:20 +0000 (GMT)
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e9d67ca7a23so6854316276.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 09:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757434280; x=1758039080;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1S+8/GmANSsit+oC8iJ8NZuIIc/8K6Qrgest0rjjDOY=;
 b=pPu8+eOSBt08t6JJ2Xqcz5oMjHQ06r54j0LQuLWeYCx+4+1B3HkbeszXIf+3XucJVN
 NKnwhA5IpktEBkMIXgvF0OUcQ6WepAAh8YQqaLlRUws24Sl+Alli4SjCLrDNQpO34t8I
 mNpt0KsNNYetWZI9H8+rMBKKKr43GpSn95PJ8oRlsmtj92v7MXR94RIS3MfJYv/eGCjL
 I+U+Vn266juJZg527q/Mg8xwvTiE9ktJqIidN/CZ6WiRjzdadWmVNt72IpbpE4u1Wx5W
 R4kPmCzxAPHJ/B+OY+EbsqjCjFlI9F0NHblhiX0TSObrViT8NWRoO/2gsxjsonHCpvNa
 YwTw==
X-Gm-Message-State: AOJu0YwjegW83dgTsW+g5AUWt2QG/N5S3vC5nqiiFGYo3RiGMh0EtHSJ
 ITLO4S/xNOXaEyxLi5tu21j4iRqyuzdK+wzpY+fadZZgGdzxEFlOHpAMSEDLxWH+qcAwWIr2aey
 WOt35gmwwUpZ9nCQisA56M1BSCgAutB68+sskzCsICJnhoB0OOSp/bLPsb7E6yHyFz3jtmPHdGO
 KGu27l99vuOx2nykOV1QgD/azWV85OZudU
X-Gm-Gg: ASbGncuAix8mR5Ova/F2lLQaM0FKB1dHOHQJhyLXmE+mpb02Ro82Bt9bu5I2p67w3da
 sqnI59qEJ3fUi8DkKOrS6sTFGqZiYWYyozhig6YUkmcWq6CXHMt/icKbLH+Vk0kK0YSjwO8cgVM
 YsroNKFXNB+fBnOWhKZWoF8Ms=
X-Received: by 2002:a25:9387:0:b0:e93:2d7c:96f2 with SMTP id
 3f1490d57ef6-e9f677a21ffmr8755306276.24.1757434278885; 
 Tue, 09 Sep 2025 09:11:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGwyzQ2OT7+CTlPjbvl6aLpQ/YirsPcNJxZFKkmdwdcdeReC5LZyblnetF+TIJfQdRM+45S7Y6gWKz9AroUnk=
X-Received: by 2002:a25:9387:0:b0:e93:2d7c:96f2 with SMTP id
 3f1490d57ef6-e9f677a21ffmr8755266276.24.1757434278384; Tue, 09 Sep 2025
 09:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250826184504.510279-1-vacha.bhavsar@oss.qualcomm.com>
 <20250826184504.510279-4-vacha.bhavsar@oss.qualcomm.com>
 <CAFEAcA9_wXKT6zfpCSty2bRjVpCSyzLcdfWuJofJEZcZuqRgYQ@mail.gmail.com>
 <CAEWVDmttumhB+kx7RExyTV1vUoUCY=ED_qbj=7tbBx0hDPeqUg@mail.gmail.com>
 <CAFEAcA8Qnv+_=-MeNuHuZm3DuAK7A-DqYo0GsArQCk62GF0jEQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8Qnv+_=-MeNuHuZm3DuAK7A-DqYo0GsArQCk62GF0jEQ@mail.gmail.com>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 12:11:07 -0400
X-Gm-Features: AS18NWAmeO83ueie5vbU9TYvI5nU4SulUn86kX9q93t0NTqgyKCioEk6WfARH6g
Message-ID: <CAEWVDmvwMUxYeU_130uThFUWByWt_6F=C+rpmaFyNFFM8Gc0_Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] target/arm: Added test case for SME register
 exposure to GDB
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e12baf063e608d2a"
X-Proofpoint-GUID: irt7sAzedhkA5Yupc8I5es_gor48PKZc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfX8o/EQJNW3U0n
 M3hbmQsJQlv1ZT6+EBZb4stVW/08GI74SKhzNuSC3+1cmZZmiq+lRa4nhc6HrMskLm+LAPa7cE7
 9rew6LIPdF22KpGgUpnAoU0qPDLYEITHDxTBYcVGhJysyFb/XxoCblBq3xanm2JMOHpPM2Tbz1r
 aNBHp4TB31F+jVQ+oAAoMFMksxypte1fewRRuOxa1Cc8e/CmSjy/H5iqXvzp6mYWDSLFx3Zk7EF
 6Vq8BgSqnuw3KtpENgp5+F7EldDQ2i9JpI8oXbeoZHvWteRyb1Q8Gy84cRTiCxMnWg8cmb+zv03
 O/eFBUiEzhlRY00khUJYBcFQa6vzazC4Z/8pYnPUO+8bJyGNJNGB4SPrJ5QQnwo95n87bRvPGuK
 7CdchPdG
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68c051a8 cx=c_pps
 a=OxDXTYJfYfhXdKRNwaci0A==:117 a=yJojWOMRYYMA:10 a=CCpqsmhAAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=dw954JRmwQRGsdTYt74A:9 a=QEXdDO2ut3YA:10
 a=xsCOeRy3ZukA:10 a=Y4SkpI06CHAA:10 a=1BFMoyKHhG91QSF6OGcA:9
 a=57FbZqFqGi0K-PKL:21 a=lqcHg5cX4UMA:10 a=cxVRdw0VslE0MYWkNwNp:22
 a=ul9cdbp4aOFLsgKbc677:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: irt7sAzedhkA5Yupc8I5es_gor48PKZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000e12baf063e608d2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Got it! I have sent over an updated version that avoids the
int cast and associated checks for an appropriate gdb version.

Thanks,
Vacha

On Tue, Sep 9, 2025 at 4:55=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Mon, 8 Sept 2025 at 19:32, Vacha Bhavsar
> <vacha.bhavsar@oss.qualcomm.com> wrote:
>
> > >So the only difference between these two branches is that we are
> > >checking "int(v) =3D=3D MAGIC" rather than "v =3D=3D MAGIC" ?
> >
> >
> >
> > >Is this a "one GDB only works one way, and the other GDB only
> > >works the other way" case? Or is there a real interesting thing
> > >we'd like to test involving the cast ?
>
> > Yes, the only difference between the two branches is the presence
> > of the int cast. This seems to be an issue limited to specific versions
> >
> > of gdb. This has been discussed with the gdb team
> > (https://sourceware.org/pipermail/gdb/2025-August/051868.html,
> > https://sourceware.org/pipermail/gdb/2025-August/051878.html) and
> > a bug has been filed. With additional tests I have found that the
> > int cast causes no issues with the testcase when running gdb16.1
> > or newer. Other than this issue there is no intention on our end
> > of testing anything interesting regarding casting as the int cast
> > was included to stay aligned with the existing SVE test.
>
> So if we can test QEMU's gdbstub functionality by writing
> the test in a way that avoids the int cast and which doesn't
> lose coverage, we should just do that. That would mean
> we don't need to have checks for whether the gdb can do
> the cast and multiple paths through the test code.
>
> -- PMM
>

--000000000000e12baf063e608d2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Got it! I have sent over an updated=
 version that avoids the</div><div>int cast and associated checks for an ap=
propriate gdb version.</div><div><br></div><div>Thanks,</div><div>Vacha</di=
v></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Sep 9, 2025 at 4:55=E2=80=AFAM Peter Maydel=
l &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Mon, 8 Sept 2025 at 19:32, Vacha Bhavsar<br>
&lt;<a href=3D"mailto:vacha.bhavsar@oss.qualcomm.com" target=3D"_blank">vac=
ha.bhavsar@oss.qualcomm.com</a>&gt; wrote:<br>
<br>
&gt; &gt;So the only difference between these two branches is that we are<b=
r>
&gt; &gt;checking &quot;int(v) =3D=3D MAGIC&quot; rather than &quot;v =3D=
=3D MAGIC&quot; ?<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; &gt;Is this a &quot;one GDB only works one way, and the other GDB only=
<br>
&gt; &gt;works the other way&quot; case? Or is there a real interesting thi=
ng<br>
&gt; &gt;we&#39;d like to test involving the cast ?<br>
<br>
&gt; Yes, the only difference between the two branches is the presence<br>
&gt; of the int cast. This seems to be an issue limited to specific version=
s<br>
&gt;<br>
&gt; of gdb. This has been discussed with the gdb team<br>
&gt; (<a href=3D"https://sourceware.org/pipermail/gdb/2025-August/051868.ht=
ml" rel=3D"noreferrer" target=3D"_blank">https://sourceware.org/pipermail/g=
db/2025-August/051868.html</a>,<br>
&gt; <a href=3D"https://sourceware.org/pipermail/gdb/2025-August/051878.htm=
l" rel=3D"noreferrer" target=3D"_blank">https://sourceware.org/pipermail/gd=
b/2025-August/051878.html</a>) and<br>
&gt; a bug has been filed. With additional tests I have found that the<br>
&gt; int cast causes no issues with the testcase when running gdb16.1<br>
&gt; or newer. Other than this issue there is no intention on our end<br>
&gt; of testing anything interesting regarding casting as the int cast<br>
&gt; was included to stay aligned with the existing SVE test.<br>
<br>
So if we can test QEMU&#39;s gdbstub functionality by writing<br>
the test in a way that avoids the int cast and which doesn&#39;t<br>
lose coverage, we should just do that. That would mean<br>
we don&#39;t need to have checks for whether the gdb can do<br>
the cast and multiple paths through the test code.<br>
<br>
-- PMM<br>
</blockquote></div>

--000000000000e12baf063e608d2a--

