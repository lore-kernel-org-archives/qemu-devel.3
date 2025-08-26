Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C7ECA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 18:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqym9-0000wu-7v; Tue, 26 Aug 2025 14:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uqym6-0000ve-QN
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 14:52:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uqym1-00017G-96
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 14:52:05 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QBNUvP018802
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fRKpEZ5YCES8LRQs+X6Sx4tW
 19EXHEW6Rs+KA+pdNWs=; b=TtPujWkrdCmWy6WuLlhq8hZJ8NvQ5SdTkoTnQRKe
 Ow9UPwoA1AqxKfqGwaRHU4Q9M6tY8uUnUcXFj1JIiTZo1fQ2pwrbCurgs7GhuZnE
 g8NyiNX/SdgqArI+40TIZBxs1pnvjAvXsrQ71cky62uEeKE52VIjWd8KPUist3yl
 n9TYul/VmmSO1omotl7fjwUGUvyrw4Dl57Q++cV7y+Sk5VEbN7OHlAJANj81qLaR
 16QGHQbkQ27NaGFMqVeSJ1L2/w3Qp5jZLYrUf0fhbZ3mt71DAxr8EbXsFNJRiBk7
 lO18ViLgNCUidjPdIXkR6LmsecMDDhU306hpmc29rADW8w==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpt78a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:51:55 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7200af345a5so36614997b3.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 11:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756234314; x=1756839114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fRKpEZ5YCES8LRQs+X6Sx4tW19EXHEW6Rs+KA+pdNWs=;
 b=RdfbteugvzDlYvniBtr4IV48RcCLIUHyKafhqj1NnJoE7PHSnQKsrxwYs80XxMu2kN
 orvn9P8bgfhKde5PAIDVv3JHKjo2F/ZY3B0NQXryZ6jaEYIRXNd0SAw2FQVMtUbu5XAE
 50KFLg4rxe43YOIxrgrVBVwkxbQD+tmSWN8msXLeOe7gzAYk+tRzlTt0Dhe7OUcXFdh/
 F1/NsMp26WbftFUSUgXPPQB9p8SrHCyQnWZs7F2NaDr9xzszTecCWpIsiEH2QuZwbR8S
 OuIvBreoLJ5wxWAkE5QV7jD4m8Titin0I97lLelufws1ztg8S8Cc9J7m+OXAmRQDwIKa
 YfHw==
X-Gm-Message-State: AOJu0YyPnW8VBPMJ58yZWrgh+qzPx6n1iwCJ/XWs/TT7737sK810pX+t
 /yO5KsjMB9Ptpy1yljFDtKtnNOSd5ytjw+MEh0ol8IYrcMbUOw+CnuIBNes85q4YJDDUWIUeyDp
 VErYmxbm6mVONrPLkvA5EH34bv/GJ/Sl97ieDUaJu4VNsrOwQvJlXdfoc2+iG4B3+hqP6u9X2TZ
 gMCUPwWXAIIGVh9kgPxb6pasRiMN+wfTyY
X-Gm-Gg: ASbGncsOIAxxPTYIVwG7juJovNUvXMdC3RZ4y/jHMTMSmkgzlQltNhyXJJ1ZgUGFOj4
 m0FhPSeZ2SZNtN3OTuDSng/stwLTvNoOXMdUm84CoebhuzSvOHi247hphCqr8h7zOu+x2QEnl6S
 r39BPLBR2HZABx85arpU20XuA=
X-Received: by 2002:a05:690c:930f:20b0:71f:e430:666b with SMTP id
 00721157ae682-71fe430ae8amr135803587b3.32.1756234314348; 
 Tue, 26 Aug 2025 11:51:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsCTtMJgsaAQxQqRR+3uqfjL+8bJ1U1SrJJ+Aaau7vCbw43OIxUno8AL0u39W2hjtBnvCUSZRNVic8VfLmghE=
X-Received: by 2002:a05:690c:930f:20b0:71f:e430:666b with SMTP id
 00721157ae682-71fe430ae8amr135803337b3.32.1756234313843; Tue, 26 Aug 2025
 11:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250811193654.4012878-1-vacha.bhavsar@oss.qualcomm.com>
 <20250811193654.4012878-5-vacha.bhavsar@oss.qualcomm.com>
 <CAFEAcA8FchF06dGdixBwY8GWSF3kREuL72ZmeyG_cYqzAmuEjA@mail.gmail.com>
 <CAEWVDmsqgrnXgte0Sb+uzHmu=jHkXWvfHhYme-9hwng3XvrwVA@mail.gmail.com>
 <CAFEAcA9Bf7kWL20hzCQP5GSAN1AkX0FnqZv_TdTOpQFLSTCdeA@mail.gmail.com>
In-Reply-To: <CAFEAcA9Bf7kWL20hzCQP5GSAN1AkX0FnqZv_TdTOpQFLSTCdeA@mail.gmail.com>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 14:51:43 -0400
X-Gm-Features: Ac12FXwqjFbPfDngPa702eDT3jsqDdqoNVIQfxaPIoQivozbwa9oDvt8AovVrXI
Message-ID: <CAEWVDmvavpLTOMjrXvwMSg9kTB8FVgWZr-pF-sop3JKtfnwCdw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] target/arm: Added test case for SME register
 exposure
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006b68cc063d492a65"
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68ae024b cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=7DDb5M9h5expJl4u7yYA:9 a=QEXdDO2ut3YA:10
 a=IQeqcNvkk_iTUVU7tyUA:9 a=HLE15LPIrYoycJ2H:21 a=lqcHg5cX4UMA:10
 a=kLokIza1BN8a-hAJ3hfR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: W3wbV6-HOdSlN-Wb9UQU2oQsDYHtqkpw
X-Proofpoint-ORIG-GUID: W3wbV6-HOdSlN-Wb9UQU2oQsDYHtqkpw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXweqptOCmcCL/
 cxwCHiu8Z2I8tKvIXO6Hl909bILOBM7SI11L2wFq4dxXt3wei6Qle+hWZHWCPU2T3ZJCCsI3xZq
 4BZlVsmDmfdAVk/bf5/cyRUCqXncXtWwroXa77Y3+FB9nFM+gd06HsKxMcgjK8hmjMC1iQ4Rt5D
 uBKQd/Odut7TIjZPckdvWs2Cd1HMzNUZEvKf48RJXb1lwJKO/vf+bFrzOQ/dqC/bGPfDoZ4dIdh
 1anSF3z75WnIhuWPIsKV9o5CJg7dTsmg8mikoyg395z0X5eoa5DK+09qD8Ef3PWQUsQ/Q3eknC0
 yrwkN8oygwAqR8jmNVGUhDih3pl/3zT8p6fwmBsT4QeDSSho0112hadM0eMacCqhac+DW8nChW1
 g8NWf7aX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

--0000000000006b68cc063d492a65
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

It seems the test fails specifically for that version of
gdb (15.0.50.20240403-git) when a gdb.Value object
which is an integer of more than 8 bytes is cast to an int.
This is the case when we test reading the za quadwords.

To address this we have edited the test such that the int
cast is not used for the za quadwords when this specific
version of gdb is detected. In this case, the test is
performed without int casting (which still passes). To
declare this to users, we have added a warning message to
be printed in this scenario above the test results in
the output file run-gdbstub-sysregs-sme.out.

I have sent a new version of the patch series with these
changes, as well as the added spdx/copyright lines.

Please let us know what you think of this approach!



Thanks,
Vacha

On Sat, Aug 23, 2025 at 2:13=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Fri, 22 Aug 2025 at 18:32, Vacha Bhavsar
> <vacha.bhavsar@oss.qualcomm.com> wrote:
> >
> > Hi,
> >
> > We have tried to replicate this issue on our end and it
> > seems to stem from the int casting of gdb.Value type of
> > a 128bit integer. We have run the test with different
> > host architectures, gdb versions and python versions
> > both with and without the int casting. The results are
> > as follows.
> >
> > gdb     gdb target           python   host          int cast status
> > version support              version  architecture
> > 16.3 --enable-targets=3Dall 3.11.13   x86        yes        pass
> > 16.3 --enable-targets=3Dall 3.11.13   x86         no        pass
> > 16.3 --enable-targets=3Dall 3.10.18   x86        yes        pass
> > 16.3 --enable-targets=3Dall 3.10.18   x86         no        pass
> > 16.3 --enable-targets=3Dall 3.8.10    x86        yes        pass
> > 16.3 --enable-targets=3Dall 3.8.10    x86          no        pass
> >
> > 16.3 aarch64             3.11.0rc1 aarch64      yes        pass
> > 16.3 aarch64             3.11.0rc1 aarch64       no        pass
> > 16.3 aarch64             3.10.12   aarch64      yes        pass
> > 16.3 aarch64             3.10.12   aarch64       no        pass
> >
> > 15.0 multiarch           3.10.12   aarch64      yes        fail
> > 15.0 multiarch           3.10.12   aarch64      no        pass
> > 15.0 multiarch          3.11.0rc1 aarch64      yes        fail
> > 15.0 multiarch          3.11.0rc1 aarch64      no        pass
> >
> > 15.0 multiarch          3.8.10      x86            yes        fail
> > 15.0 multiarch          3.8.10      x86             no        pass
> > 15.0 multiarch        3.11.13      x86            yes        fail
> > 15.0 multiarch        3.11.13      x86             no        pass
> > 15.0 multiarch        3.10.18      x86            yes        fail
> > 15.0 multiarch        3.10.18     x86             no        pass
> >
> > Could we get some more information about your testing environment?
>
> It's just stock Ubuntu 24.04.3 LTS on x86-64; gdb is gdb-multiarch
> GNU gdb (Ubuntu 15.0.50.20240403-0ubuntu1) 15.0.50.20240403-git
>
> -- PMM
>

--0000000000006b68cc063d492a65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>It seems the test fails specifically for that v=
ersion of<br>gdb (15.0.50.20240403-git) when a gdb.Value object<br>which is=
 an integer of more than 8 bytes is cast to an int.<br>This is the case whe=
n we test reading the za quadwords.<br><br>To address this we have edited t=
he test such that the int<br>cast is not used for the za quadwords when thi=
s specific<br>version of gdb is detected. In this case, the test is <br>per=
formed without int casting (which still passes). To<br>declare this to user=
s, we have added a warning message to<br>be printed in this scenario above =
the test results in<br>the output file run-gdbstub-sysregs-sme.out.<br><br>=
I have sent a new version of the patch series with these<br>changes, as wel=
l as the added spdx/copyright lines.<br><br>Please let us know what you thi=
nk of this approach!<br><br><br><br>Thanks,<br>Vacha</div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 23, 2025 at=
 2:13=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.o=
rg" target=3D"_blank">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">On Fri, 22 Aug 2025 at 18:32,=
 Vacha Bhavsar<br>
&lt;<a href=3D"mailto:vacha.bhavsar@oss.qualcomm.com" target=3D"_blank">vac=
ha.bhavsar@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; We have tried to replicate this issue on our end and it<br>
&gt; seems to stem from the int casting of gdb.Value type of<br>
&gt; a 128bit integer. We have run the test with different<br>
&gt; host architectures, gdb versions and python versions<br>
&gt; both with and without the int casting. The results are<br>
&gt; as follows.<br>
&gt;<br>
&gt; gdb=C2=A0 =C2=A0 =C2=A0gdb target=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0python=C2=A0 =C2=A0host=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int cast st=
atus<br>
&gt; version support=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 versio=
n=C2=A0 architecture<br>
&gt; 16.3 --enable-targets=3Dall 3.11.13=C2=A0 =C2=A0x86=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 yes=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; 16.3 --enable-targets=3Dall 3.11.13=C2=A0 =C2=A0x86=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0no=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; 16.3 --enable-targets=3Dall 3.10.18=C2=A0 =C2=A0x86=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 yes=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; 16.3 --enable-targets=3Dall 3.10.18=C2=A0 =C2=A0x86=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0no=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; 16.3 --enable-targets=3Dall 3.8.10=C2=A0 =C2=A0 x86=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 yes=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; 16.3 --enable-targets=3Dall 3.8.10=C2=A0 =C2=A0 x86=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 no=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt;<br>
&gt; 16.3 aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.11.0rc1 =
aarch64=C2=A0 =C2=A0 =C2=A0 yes=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; 16.3 aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.11.0rc1 =
aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0no=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; 16.3 aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.10.12=C2=
=A0 =C2=A0aarch64=C2=A0 =C2=A0 =C2=A0 yes=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<b=
r>
&gt; 16.3 aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.10.12=C2=
=A0 =C2=A0aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0no=C2=A0 =C2=A0 =C2=A0 =C2=A0 p=
ass<br>
&gt;<br>
&gt; 15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.10.12=C2=A0 =
=C2=A0aarch64=C2=A0 =C2=A0 =C2=A0 yes=C2=A0 =C2=A0 =C2=A0 =C2=A0 fail<br>
&gt; 15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.10.12=C2=A0 =
=C2=A0aarch64=C2=A0 =C2=A0 =C2=A0 no=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; 15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.11.0rc1 aarch64=C2=
=A0 =C2=A0 =C2=A0 yes=C2=A0 =C2=A0 =C2=A0 =C2=A0 fail<br>
&gt; 15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.11.0rc1 aarch64=C2=
=A0 =C2=A0 =C2=A0 no=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt;<br>
&gt; 15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.8.10=C2=A0 =C2=A0 =
=C2=A0 x86=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 yes=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fail<br>
&gt; 15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.8.10=C2=A0 =C2=A0 =
=C2=A0 x86=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0no=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 pass<br>
&gt; 15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.11.13=C2=A0 =C2=A0 =C2=A0 =
x86=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 yes=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 fail<br>
&gt; 15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.11.13=C2=A0 =C2=A0 =C2=A0 =
x86=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0no=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pass<br>
&gt; 15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.10.18=C2=A0 =C2=A0 =C2=A0 =
x86=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 yes=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 fail<br>
&gt; 15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.10.18=C2=A0 =C2=A0 =C2=A0x=
86=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0no=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pass<br>
&gt;<br>
&gt; Could we get some more information about your testing environment?<br>
<br>
It&#39;s just stock Ubuntu 24.04.3 LTS on x86-64; gdb is gdb-multiarch<br>
GNU gdb (Ubuntu 15.0.50.20240403-0ubuntu1) 15.0.50.20240403-git<br>
<br>
-- PMM<br>
</blockquote></div>

--0000000000006b68cc063d492a65--

