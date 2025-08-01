Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F77C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 20:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvuU-0000ro-Ds; Fri, 01 Aug 2025 15:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uhuOE-0006Fo-29
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:22:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uhuOB-00058I-Kt
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:21:57 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571HfOBE028487
 for <qemu-devel@nongnu.org>; Fri, 1 Aug 2025 18:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=c1gJBxRMOnlLxN48ZNRfnJCY
 yB+8tSFR/+dte9eENno=; b=HE7HTNc36zUlbQj+C6EBOGp4R+Rp5Hfg4F5aIS81
 egRy0u39lB09gQtO0GVNx5FMW3CFeCwpbt+oJMncVpmPL7Ea2fgqccAmJCT4qjNY
 kWDPbkjvVK/wJalIvmF4V/tQ7wchPSTclUEYj8dMYOMa5Qa0QN/f7OnupG1g/K/z
 hKKLOM//dOt0FhK5j+7VMORqNgVCTJTM644d5qN7CTfZqg3bIKHfo8VzkMzhtfKL
 9WVuSvZRLz1YG5vLcwuoBiihBeS6abpvrgFj+AyShNBv4hoF+/HUKcA6aySyOXfP
 ae8Nlfz9vK1hXuGZxeAHsnVX/SBYdnR2L+zlw5Ofu+bN8w==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q86d74e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 18:21:51 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-713e879bd7cso35262017b3.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 11:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754072510; x=1754677310;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c1gJBxRMOnlLxN48ZNRfnJCYyB+8tSFR/+dte9eENno=;
 b=WMqoDiJGoDxg9gxBZioIeBqLdlwnQyUN7h9ziiR6ikK68U0OUVRfavdrf/Svb4hKg0
 /Zv3wMBN0BJGVdZvXjew0tEZnDeGJk1cAcENt4ofzNbhjrOZBTa+rS1lZKm0kALGV0A8
 fVKNphEGFUMONplg27pAKaISwPYRrT5FUMBajykdmnrC0D5SqUGcTvKdtOWoTnrL6tTU
 Zf5wj274DrhRVuILie+ZIDWmx0XEFv9zvTF/SwU0t3NMwlaFv7u3lWTrc68skg5WSY2G
 L0JIDVuH2eOEpdnBzJ9QI9NMc3pV/HphEm+yRrfk8DwjVWrpb4xR7jImgBEobeAzseHp
 oTZQ==
X-Gm-Message-State: AOJu0Yz1BC0uvoIdyLAeuq65d1fJ61CBjUbNmMHPOVMFa5ihPu40q4Kr
 /ISuj0RJi88Iy8++24PtkgMb/ioX2hDa2ybOZIwTEnK0JcvlA7x0CdlvGNhi7In+q07MePcMjiY
 lqGy63vjOvmWTARTsg1cwlO5SsSLIvrp/OBv4CdCIrPyaNhtpmmxQbHmM7RbMXc9QBdm37HZ3hV
 AAFyBZfEQPvuAot6AmMoKlrgPwi/u0w++x
X-Gm-Gg: ASbGnculLx/urdPlOzcfbEUNh0ocSw2wiwWvxT8fhz9/FCFKViBQD0d5BgjXvBdvhmo
 GnpjaTa46NlbduWWpt/z1qalvI9K1ntXIxrjTg5ea/cIecOBmJahlFVjjnvHkFUbR4nz9HcYwiM
 Q5V5T2AJIhhlaJNuvVLpfuRw==
X-Received: by 2002:a05:690c:8694:20b0:6ef:652b:91cf with SMTP id
 00721157ae682-71b7ef6672amr6345227b3.27.1754072509724; 
 Fri, 01 Aug 2025 11:21:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6YBEIXIeY3l+zU7RtKUdzq1WFM0ULIO4JqN+uNfVI+bdTfkfF6mAa10uUhT1qiwjOENHy6mHn2cnqtDB9IZw=
X-Received: by 2002:a05:690c:8694:20b0:6ef:652b:91cf with SMTP id
 00721157ae682-71b7ef6672amr6345017b3.27.1754072509401; Fri, 01 Aug 2025
 11:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250722173736.2332529-1-vacha.bhavsar@oss.qualcomm.com>
 <CAFEAcA8DqD+iBOaQu0M1_-1AiWna0pgf+gD39+x+nNx+9c45LA@mail.gmail.com>
In-Reply-To: <CAFEAcA8DqD+iBOaQu0M1_-1AiWna0pgf+gD39+x+nNx+9c45LA@mail.gmail.com>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 14:21:38 -0400
X-Gm-Features: Ac12FXw7zkWiGU3sXXT0dzTU4mwmsLQX8ZoJ1_bXvOLfSIDBZq2217pZ67Hk6TQ
Message-ID: <CAEWVDmvCboVgiNnA7oSh30fXjy26bzXVd_9=AthnQEcjRtBJhw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] target/arm: Fix big-endian handling for NEON and
 SVE gdb remote debugging
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d55f43063b51d471"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE0MyBTYWx0ZWRfX3pfiNtEnZhx4
 +wwDpG96otzQkN41QVVGGqmUyHjYynI+ubJa6+wwb0RH+1t9OyebmEL3NSqOT4V3icf5yB9auI6
 sydxCyTLooTlr8C1zRxEYWJLyhxxlk4gOH8OJtaPWg6njSS8JHe+SSzkLP4/ZfaFMcsl1HOBb3M
 5FbRZM3fPoyZphEE97XFSyq7lNs0ynjb1J6s0UzRXeUz+fFaDMgiCGiputZp+cEqKgxtc1KXZbw
 CT1LS1PiHv5iDvOnVnBWo6H29sRM0SOpNJaRXHQ+Lk0fg/PJSYZa0YJfgbdW9a7lvUCGpBRilnv
 +Hy1N2OthPjRpftW3JvcDxGsIRneOYoHghxTsgC/mLbR6tFijGIal3kwQBsSws3NVnNSoFsuuqR
 waoLjyGenKU63ul9Yirct5x+OEHJKxRPWKQV9A5f66qwDt77Y+FhhMnvl5JYNRDck1WLklLy
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=688d05bf cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=mYSHRGT8X8VKU7nljW4A:9 a=QEXdDO2ut3YA:10
 a=hU-v9SCgZcRMa9aWDh4A:9 a=7ShhM-AnhAmYumqc:21 a=lqcHg5cX4UMA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: bSdEcFa5Q_TMMe8vMs0GCrZxQEyHDUcu
X-Proofpoint-GUID: bSdEcFa5Q_TMMe8vMs0GCrZxQEyHDUcu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=947 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010143
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

--000000000000d55f43063b51d471
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the update! Apologies for the error in the cover letter.

On Fri, Aug 1, 2025 at 10:01=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Tue, 22 Jul 2025 at 18:37, Vacha Bhavsar
> <vacha.bhavsar@oss.qualcomm.com> wrote:
> >
> > Upon examining the current implementation for getting/setting SIMD
> > and SVE registers via remote GDB, there is a concern about mixed
> > endian support. This patch series aims to address this concern and
> > allow getting and setting the values of NEON and SVE registers via
> > remote GDB regardless of the target endianness.
>
> Thanks; I've applied these patches to target-arm.next (with
> a bit of tweaking of the commit messages).
>
> Something seems to have gone wrong with the creation of
> this cover letter, by the way: it lists a lot of
> patches that aren't in it.
>
> > Glenn Miles (12):
> >   ppc/xive2: Fix calculation of END queue sizes
> >   ppc/xive2: Use fair irq target search algorithm
> >   ppc/xive2: Fix irq preempted by lower priority group irq
>
> [etc]
>
> thanks
> -- PMM
>

--000000000000d55f43063b51d471
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for the update! Apologies=C2=A0for the error in =
the cover letter.</div><br><div class=3D"gmail_quote gmail_quote_container"=
><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 1, 2025 at 10:01=E2=80=
=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.m=
aydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Tue, 22 Jul 2025 at 18:37, Vacha Bhavsar<br>
&lt;<a href=3D"mailto:vacha.bhavsar@oss.qualcomm.com" target=3D"_blank">vac=
ha.bhavsar@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Upon examining the current implementation for getting/setting SIMD<br>
&gt; and SVE registers via remote GDB, there is a concern about mixed<br>
&gt; endian support. This patch series aims to address this concern and<br>
&gt; allow getting and setting the values of NEON and SVE registers via<br>
&gt; remote GDB regardless of the target endianness.<br>
<br>
Thanks; I&#39;ve applied these patches to target-arm.next (with<br>
a bit of tweaking of the commit messages).<br>
<br>
Something seems to have gone wrong with the creation of<br>
this cover letter, by the way: it lists a lot of<br>
patches that aren&#39;t in it.<br>
<br>
&gt; Glenn Miles (12):<br>
&gt;=C2=A0 =C2=A0ppc/xive2: Fix calculation of END queue sizes<br>
&gt;=C2=A0 =C2=A0ppc/xive2: Use fair irq target search algorithm<br>
&gt;=C2=A0 =C2=A0ppc/xive2: Fix irq preempted by lower priority group irq<b=
r>
<br>
[etc]<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000d55f43063b51d471--

