Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF27FDEE32
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxwT-0008Id-QJ; Thu, 23 Apr 2026 13:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=25737a9e56=yixinwei@meta.com>)
 id 1wFxwD-0008Gp-87
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:34:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=25737a9e56=yixinwei@meta.com>)
 id 1wFxwB-0008IK-9b
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:34:05 -0400
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NH8kZC2498376
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:34:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=s2048-2025-q2; bh=Ooz59i02CPXa9j+057cW
 DSrLn9dLEs0rB9Rgs3XbJco=; b=SrwrfVjzw7RYXb+/QEQImQm1rN6gVQ0eJJk/
 SA1yruUjpf3yrdJ4Ed0OuLfen02tOOsAwlIZjOtW9+L0IGRzeLKcRpmMftzoCRQi
 ZQnGvRwxswXuhuEImxcXiWu/kJlz8pMkpA0koDYwocHCC3KAXDXxUt796oSrUj97
 GX8xQx/zqS1pXBCTKLp3J9XUI6tavEpFOQxQQoWYnbf3U1T1+uc5C1dAd5nbhY0e
 GEVQNj1vdMMx9TyQ9JSJuB4/5iq7o5Jw8vePWKQgAWDaAgpea4Zr1B4K2N1EyPG/
 FtqboDDYT3JQsNiP+0HnlZmmZriHtkhM9g2qfy3MlMf0PxPxiQ==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepcxdsh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:33:58 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6948df7c598so10020306eaf.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776965638; cv=none;
 d=google.com; s=arc-20240605;
 b=gejHl2vUtY7ouy8tfQXoWugQ9wwEDEkAfLklz8Dd2QcsEu0/yQmsTaC1GozhmJAzhv
 NXYL131rdYYAhJjtq4fs3K8RWEDi5N4hVDmlvbTjHXvCDPkmVsFDtGQAEb5RdIGSjOTW
 ddV/u6H0w8Zu4QeV620rHjYPWT2DJMskkN6fmfEXqpjSxQ1QntJD4AoPLB/Z08iTsGo+
 TytXLY3Ehjzmr3kERmpu15jqA4UCiNM5Q08aYBQcWjhVf5P7gth6N8sSY1uTHraZaH5Z
 L4vWtfFuGndIMouSU522zwPPScuCZS4TV/eawvPxR/XAqWYQc08w9rWQCjyt/eG4K11I
 +GRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=3+423mg0sX6iyCpGb8oWV7d1HbihlUBR1oRDvbISVIA=;
 fh=ivpnr9SE5WhBgIRCJD1x0i+XyskY4giRBEpxphExA2M=;
 b=Gwt2kj4bFXQ2WSd+lmpMcV4FeFJY+t4Sae4VYJgCTEHCFY2Uln0/Lp/K4tUJGn6VLU
 burYzbiGYD3C7t20x+qBYvnSNdZcVGa8iuB11dNujRE1GBJNfyw8iEK/IVg852JsNFj2
 xjk7UibfmUmKpsZp7Y0fPzYv9+s9fQU6UaPFdpEHNc/ODHgtHiVAYezGDk6tSQZjo9D3
 TIwf3rSrX52A93Q0JGP8/lMFba5BOoZFh95Uq1PUK+a28FJ59uBZwuZD1/LR0psw+OLQ
 hHerBk6fcWfFc54gLjJPD9ODRX/EhQvQAWd3B2WMYpYRiedNW7rxQcdE6P2zMyKn/gsH
 EY4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776965638; x=1777570438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+423mg0sX6iyCpGb8oWV7d1HbihlUBR1oRDvbISVIA=;
 b=Q6xJlDLAH7tMVI/CwDCYRFQszlNte0a8xDOvU/oa/Vbbqo7L5dtz7pARChyujvSXin
 hbD59nzrWVo2hboKfx7ohf4OZ/C9ryezkeMRiUnYC15vFZZ3pUeZM2STo+T5eVUpf0a+
 zS5kDd/+4WNucspynTjR00g63YDmBw8RmrJmdOdjU0msERmRf4a5jg0ObWhcwco9cKwa
 e0CobuoJ1cXBOEd6dQOCNyuWc1fsJq4tBxOt+UXosBQdpwlVS3Q0OIQgyatJCmiHcpKA
 rsXsO819SbjiVAtxylnVteg3SekjyyMHCjC+ahK647FqUX0kVtuNza8qkmVUHqykABRg
 Y6Xw==
X-Forwarded-Encrypted: i=1;
 AFNElJ97wVXfluJXy70Zw7VUr9Q9GjRybqVQQBcAkP1wAjKTzQf9yKtq7XTy4xXdPoSlXvLzQc2MKiFZTrii@nongnu.org
X-Gm-Message-State: AOJu0Yzfn7re9PPGtkNvdMfo/Kovs/kvzIZLqthQ0nQB/0TI0ErU40zq
 WDcAJHpe9yRm/uwCkos765rVWo7xHUNSmSoVbVTnBMBh7tHbYH+Io3o/VwZbNfbZ52uT0LEwBeC
 Cnlw1vuOJ21Vkrt3KnNFGQu/+fM13hqowFVJRjdjWKBYvNEj7I5XkblKe1GJMO0fp1LmyREW1cR
 FfiTngY8csNPwPmQPFeHtU7+SJkpDZlQ==
X-Gm-Gg: AeBDiev/m4gEuoyqoc+fi1fHlUFR6RY5Z2JrCOL4NjTrT9B0bMvk/S9H56GUjoYbSAA
 SfSH0y3+3g9QZK4sUsxL/OJwMPiZiZwB2y/ch1a/OSZKjdWO9ZerhcNNJL3G9Yt16dP4odPNs3i
 VAb9d+RHmcxVOdnWT3tRZkJvMqaE1zHflrMaP9f30StWwfWbzlfPiMPZ+An7YVBEDCA73iAkklG
 sL+utFH+uZe9vfR5ybs8Q4/TZAUgHkg
X-Received: by 2002:a05:6820:8613:b0:694:93fc:9a0b with SMTP id
 006d021491bc7-69493fc9cd7mr5430748eaf.27.1776965638030; 
 Thu, 23 Apr 2026 10:33:58 -0700 (PDT)
X-Received: by 2002:a05:6820:8613:b0:694:93fc:9a0b with SMTP id
 006d021491bc7-69493fc9cd7mr5430732eaf.27.1776965637481; Thu, 23 Apr 2026
 10:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260409164938.6735-1-yixinwei@meta.com>
 <bf633e1f-f551-4c1c-abdf-e54d7e4136d0@linaro.org>
 <CABe+LnuRJNwa=qyUOOVmNh33v0VEPBT+ob9MmycvU+DVaRSw=Q@mail.gmail.com>
 <b3c4e048-6224-4492-ab6d-4dbd6a150e7b@linaro.org>
 <8a972330-4318-4bc2-9c0a-41f45afeb507@gmx.de>
In-Reply-To: <8a972330-4318-4bc2-9c0a-41f45afeb507@gmx.de>
From: Yixin Wei <yixinwei@meta.com>
Date: Thu, 23 Apr 2026 18:33:46 +0100
X-Gm-Features: AQROBzBLzDN0dDSvMOLOU_cIPTYMvfBA-ekw7DytxYwjXpy7anID8QNCW9nTvwI
Message-ID: <CABe+LnsDBv+0WBHuUFhBTxK_H7tH2VDXE1K1KMxKjLAh7c9R9w@mail.gmail.com>
Subject: Re: [PATCH] linux-user: fix off-by-one in
 host_to_target_for_each_rtattr()
To: Helge Deller <deller@gmx.de>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
 Yixin Wei <easonwei1998@gmail.com>, qemu-devel@nongnu.org,
 laurent@vivier.eu, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="00000000000099bf940650240df0"
X-Authority-Analysis: v=2.4 cv=VKLtWdPX c=1 sm=1 tr=0 ts=69ea5806 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22 a=p0WdMEafAAAA:8
 a=wU1BN6f2oAeVFZvCOBgA:9 a=QEXdDO2ut3YA:10 a=uVcs0kGPQhM9h2xS14oA:9
 a=GAf5B2QKJOPl_C_x:21 a=lqcHg5cX4UMA:10 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-ORIG-GUID: Ba-NC_1WiPasbs6lgbqdeiyZ8lGotSO7
X-Proofpoint-GUID: Ba-NC_1WiPasbs6lgbqdeiyZ8lGotSO7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3MSBTYWx0ZWRfX1HamRc9JD/Tf
 P/9zCM1R+JywSkG693RCjN7xLy7ElYTwLWQ4K+6eZSTU5BPmAynhhRtspT8lGHjQF4/8yt+Es11
 mRNzQf2P/QjHd5z6m3yuTIwQJnQUTaj+7Kkrzr6ccc7/PcZQ4womK6vsu3yw6Vxg17lIqw9NMbg
 hqF47d3iGfgF00GAQ5+ftlV3J61+Hbvq3DLQ8aG6hdw3tCD46igeNHsrhClZJAW0enFybBZCRMN
 7Z0iRYIJSc3YFczvYOEPZHK9RTOFWZ/ur7pwTOUPcdZmfQoHJs/doT6VMJUlgt40fnPFOHJpSjn
 9A6uGcjZl3tkJc0LEH39xb1lMkj+6SoOhFSRRGNtctqmsfv6Eu0hAHOTgmbI+T9xUwGTHjU1D01
 /ocjj6uWmQmW5zC27sa52NVaXyPCJ9TF1ICvMYlYzwMvMoPfop0udFMiwByCALiyBm73YGw0rS5
 hpdpRjW8kyOvsLKlp8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
Received-SPF: pass client-ip=67.231.145.42;
 envelope-from=prvs=25737a9e56=yixinwei@meta.com;
 helo=mx0a-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000099bf940650240df0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Helge for picking this up!
And thanks Philippe for the info, it's really good to know how the process
works.

Have a good rest of the day.

Thanks,
Yixin

On Thu, Apr 23, 2026 at 4:05=E2=80=AFPM Helge Deller <deller@gmx.de> wrote:

> >
> On 4/23/26 00:50, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Yixin,
> >
> > On 21/4/26 17:15, Yixin Wei wrote:
> >> Hi Philippe,
> >>
> >> Thanks for the review! Just curious about QEMU's typical merge
> >> workflow, trying to get a sense of how long this usually takes to
> >> land once it's validated.
>
> I've applied your patch to my linux-user-next git tree at
>
> https://urldefense.com/v3/__https://gitlab.com/hdeller/qemu/-/commits/lin=
ux-user-next?ref_type=3Dheads__;!!Bt8RZUm9aw!91NbIhGxhNbBVICaGq6ZzURChgxm5b=
Pi1-9X2ZU1-vPiep_6kp8S5qhrV5h0hQzc7S84HM-XX_8Sug$
> and will push soon.
>
> Thanks,
> Helge
>

--00000000000099bf940650240df0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Helge for picking this up!<br>And thanks Philippe f=
or the info, it&#39;s really good to know how the process works.<br><br>Hav=
e a good rest of the day.<br><br>Thanks,<br>Yixin</div><br><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On T=
hu, Apr 23, 2026 at 4:05=E2=80=AFPM Helge Deller &lt;<a href=3D"mailto:dell=
er@gmx.de">deller@gmx.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><br>
<br>
On 4/23/26 00:50, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; Hi Yixin,<br>
&gt; <br>
&gt; On 21/4/26 17:15, Yixin Wei wrote:<br>
&gt;&gt; Hi=C2=A0Philippe,<br>
&gt;&gt;<br>
&gt;&gt; Thanks for the review! Just curious about QEMU&#39;s typical merge=
<br>
&gt;&gt; workflow, trying to get a sense of how long this usually takes to<=
br>
&gt;&gt; land once it&#39;s validated.<br>
<br>
I&#39;ve applied your patch to my linux-user-next git tree at<br>
<a href=3D"https://urldefense.com/v3/__https://gitlab.com/hdeller/qemu/-/co=
mmits/linux-user-next?ref_type=3Dheads__;!!Bt8RZUm9aw!91NbIhGxhNbBVICaGq6Zz=
URChgxm5bPi1-9X2ZU1-vPiep_6kp8S5qhrV5h0hQzc7S84HM-XX_8Sug$" rel=3D"noreferr=
er" target=3D"_blank">https://urldefense.com/v3/__https://gitlab.com/hdelle=
r/qemu/-/commits/linux-user-next?ref_type=3Dheads__;!!Bt8RZUm9aw!91NbIhGxhN=
bBVICaGq6ZzURChgxm5bPi1-9X2ZU1-vPiep_6kp8S5qhrV5h0hQzc7S84HM-XX_8Sug$</a> <=
br>
and will push soon.<br>
<br>
Thanks,<br>
Helge<br>
</blockquote></div>

--00000000000099bf940650240df0--

