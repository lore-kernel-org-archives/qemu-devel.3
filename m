Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9321C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 18:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuwjf-0005lf-Px; Fri, 14 Aug 2026 14:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wuwjX-0005jl-S7
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 14:34:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wuwjU-0005b5-E2
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 14:34:22 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EGhjgd3360463
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 18:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U4G1uVGruvh0qZc8vFnL0duJ+btrTB22H6TndNU7u2w=; b=j8O8hpmqlpZooloJ
 7P4hwZzr7lJAic2HLilbuwN5l1DbPzINzoENedrZ6JesapzWuCtth35sKc2y196j
 8oyPM9Ziod/AA/jDQ7ewrSQm4Z7kHev2WksracgdvIKAIP5jE3/xQmx08E8xKfBV
 NWqcqaeyP9AdvYRlP7gO52yqSOJMIPFm+B7LBUGK/xr4TmjuIrdy4tHJzDngpGqr
 jQAmnxEWOeUPaN7ok2o4Dcm4p7G7QACOaLdhpib5doI+keMPg0bHh5N+ngJhSDdx
 kJMgxEdwtdsq29rko+jKQLMZxYI0/I+rGvVIcLl/YvLrY+hRjuja3XyHuGgPYpdS
 LTsLkA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g20sj28pa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 18:34:17 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7386e55c63cso15859137.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 11:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786732456; cv=none;
 d=google.com; s=arc-20260327;
 b=VUtV3AYRmLrMQM1cRPpMwKPL5DfT+ENBnTXzSzp/hDPrDKS7RBjZRWU+CMJzpBp95e
 rLw6ZHZ0dJPS6Kk+7E+qKY09xz0mKrK2utXOUGEnf9HJUTZwPRm60iJAtMvl7h8evu60
 1inVmpMzz99NDRepd3sXsbJS42DmO7gaVBuBXJpw8tVFGods8pzwrhVNvYLD04ba7i8i
 F8uH1LPPiG6i36q4L4f7nSKITZ4D+eUDqoJksPnWTf0fHYvMMEaym2uSlIbIS8O7HTgI
 Sm6y4pX2mGEgESsqkqgwdhtVdyUwFhzB2o7q6DqsB9cUXzXFyRXC1Ou8/Brkk7MkcK0Y
 jydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U4G1uVGruvh0qZc8vFnL0duJ+btrTB22H6TndNU7u2w=;
 fh=kz9l9BzKF9hG3UnZv0Y5GqSomLSnRNQZ9MtpgC7TJjU=;
 b=myail3WUNy27PdwCyOvmheMSi+zRGIM8WPJIzLYY19P0805Tj7ca394usF8nthlFbR
 eGTDOH4kWsYrn7QfahOAQyDfUnVK6FSdZRHZOsQgtw4dFSaiTV4oZarjbF12mqhFUdIc
 CjJenQK6r8gJkEFt8NgyF86FiXNY0XenX0ZyZjVAlpP87E6ACcHhqse62NCaxNMgMS8T
 2CNDV1g5tXG5Ts7+wGT/87hZemLiqzLFeOuj/0qXXrkJOyckmcGXCnrps/vCcbwDph9k
 30ZQWzmAFuG8FzD1E4DXLdT/sKPCY0rrSdqpMB1W4Lltv6p535OWympKoE4MThd+bylR
 TaMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786732456; x=1787337256; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U4G1uVGruvh0qZc8vFnL0duJ+btrTB22H6TndNU7u2w=;
 b=XbSrXN4/s4wLUOt+gNIRPBCheTmB769ZdP7DD/VnnygqSKyRCcS+7kSkcCAR4zV4V6
 d8SULUptiZIRwEMlDlNxadCxtUXkpbcyl5l6z5L+60WcN/xnBiji9R7Db/W+Rxs8kcl9
 nFj4uliqy9YBcNWcjAxr9PiHzSfnvZZn2yU+Tirtq5lquhN9BWnvkYmYf9ClbG5T2b0i
 /9+tFe1ZUrHKXnJtpSEPzFuqt+pnF6Q/dblMqO0YGvTqAkEKPEzCOEol9fyKzUGzCrqj
 TeVXJ+2XEAyKM7nF2JxVYoYeIayEv+gmUsgTVAKjGYSNxpAIOurQupQpPu9TeXSTuSrU
 Py0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732456; x=1787337256;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U4G1uVGruvh0qZc8vFnL0duJ+btrTB22H6TndNU7u2w=;
 b=TEwtsYsHeLdsfxp9CxUjbYat7vG0JOmqDH9Nkdy011lHuANoQkqWC6Oh8urLQ7/5Ga
 7gOw9bjdBYA1TBDxoo8Ezkkoue1n0gDg/xO5cTHr39eUZnubPPw08n/IaX3lAnz+xLtH
 WItWd0WSh64JtAq+PEDP6rq7xxNfyEtNNpmukpwSdzRzWHZ1S8lrEnf4YcZF8B/zJAKO
 GVahBdpa+0q3I1XEB6ehTy7IIUQ7ChbK2mRYL1iXRJ3neFkD6toib1s6UfXAkjt0Q5lb
 mja0i5Khtifof12q1siQOooO/g/C/xgYQTtfpEGUpXHEPlpGOmpx02E7L9lWjThpwK8J
 r1/w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYQwe7EIoQjNHcNchLF7jSw6FzEt7gAmcbq2T54K/FT3maYD1ZHCXbYZOkTAvAOViJJYI5D6dB7ni/@nongnu.org
X-Gm-Message-State: AOJu0YyaJDX1IeVC6jwpxy5568y1tIZvx3f4shFU/ZXiljTt1hr0c2+G
 8scb4R6sPIBl6F1EUl0EJTXPWk7Coa0+JtKF5k1gelKVmkHmw7IOk2uramRsEUUQIBzomAZdM8/
 pOMNnUVNj/NmZ0iGNRNGn41Pk1+VGku+Gpa2/Kh4sx3uRhmYLyj751qo29EWDH1XRusksEm2ExL
 DL3Dn1Oq8vVFTaFVwSwpnMInJacKdGj7Ex
X-Gm-Gg: AR+sD10S3Rj0F6/kDNCme95z/ycM5LuL5TIArv4HGu1jEprH2zEnIugw2/kL7RLrFbc
 NOK80ia+o4fnWHSlcDIHDyHpCeEGUqOSSAACDOpuOsJZPmtrSzXbxYrtJ1qtDE57MZ4NjPY//ek
 ESX59kea7LahZZ+35aGhhLXbkVEK4sn3f3vvLsiPdDS+FdHfooMYeyzKEFbg==
X-Received: by 2002:a05:6102:4188:b0:738:a78f:5483 with SMTP id
 ada2fe7eead31-76f2ce65b88mr684424137.2.1786732456322; 
 Fri, 14 Aug 2026 11:34:16 -0700 (PDT)
X-Received: by 2002:a05:6102:4188:b0:738:a78f:5483 with SMTP id
 ada2fe7eead31-76f2ce65b88mr684420137.2.1786732455921; Fri, 14 Aug 2026
 11:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260814045315.3416169-2-subrahmanya.lingappa@oss.qualcomm.com>
 <7c5a0b1d-12db-4be2-b20c-9d132b027a76@oss.qualcomm.com>
In-Reply-To: <7c5a0b1d-12db-4be2-b20c-9d132b027a76@oss.qualcomm.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 00:04:04 +0530
X-Gm-Features: AcwNN1UPug99xyeQLZmCXnQBRAhGbq4tYGvK2y0q-y-4rfGcZh2DnyZUkvKMl34
Message-ID: <CAPxK-6c5ucsJttV6WVTQSe=O3s+q-tL=-Mv42iJPUBftFAXFhA@mail.gmail.com>
Subject: Re: [PATCH v8 01/10] build: add optional librpmi dependency
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDE0MiBTYWx0ZWRfXyyvG5VZ1vvQG
 omOMbHJPh2Qrh4kadlHAt2e9eJd8TkoM237w94gtCRFDQLBPRdSXrp6wYwtow8HC+D5+AuOIky9
 R9/gAyMuTGwsLrIBXjI8wm6j5r5XJ9q5VV1Nh8fXtllI36Igodo/frIJKPdh4VBbI5yjvYLuR5d
 l/Z9Ti9yAoZ/w7YtUpzO/WJgNo+b9UXz1dyRqsa843pMoTs+99YaDesD0N3UjKD2we2Cq9UClhK
 Lrq9wPtnumifDeJzTWO8yMPc4M+T8oRy1pnsXPwdGj6QLMxTf4Nva/JnfniBvVIH/lXWXZVJZnP
 qD7La3k9BfDO8Wv5ffu+DdOBTxKg/7bluZNrw2Xt1qFdMqADjRDJS6pYEE2saZeqyG89GvWJwN9
 tb3q+6JeUQGzajdpGridtDm78FqNspG+zX4IjwbVP9hrEhiATc5oKeAteeS670GUF3oS+5thfD4
 dvwcYYdtVhp7ZUUmtPQ==
X-Proofpoint-GUID: lmFzufA_VVlOB4NJuduLjTAYZzzbdrTC
X-Proofpoint-ORIG-GUID: lmFzufA_VVlOB4NJuduLjTAYZzzbdrTC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDE0MiBTYWx0ZWRfX6u2QHyMu+GPR
 Pm0deRja6EesFcWGc/A+NJtLAWxuFjxjbY9QQpdKhJg/VFqWMqTMWtlbHaR4g9gkQxhR5V08Jf6
 pKhAEBMxW1JWBw+qAfK4oQKolA67fUI=
X-Authority-Analysis: v=2.4 cv=cMTQdFeN c=1 sm=1 tr=0 ts=6a7f5fa9 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=355me-iAcZ-xxilroeMA:9
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Philippe,

On Fri, Aug 14, 2026 at 11:14=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi,
>
> On 14/8/26 06:53, Subrahmanya Lingappa wrote:
> > Add a meson option and config probe for librpmi so RISC-V machines can
> > opt into RPMI support when the library is available. Keep the dependenc=
y
> > optional so default builds without librpmi continue to work.
> >
> > Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.=
com>
> > Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> > ---
> >   Kconfig.host                  |  3 +++
> >   meson.build                   | 14 ++++++++++++++
> >   meson_options.txt             |  2 ++
> >   scripts/meson-buildoptions.sh |  3 +++
> >   4 files changed, 22 insertions(+)
>
> Could you provide a cover letter so we can understand the changes
> with the previous versions? It is hard to figure out why we are
> at v8 and what we have to review again.
>
I was incrementally fixing issues and sending out versions.

This mail with subject line has the change logs from previous few
versions, you might have missed;
 as it was with all the previous versions' cover letters.
"[PATCH v8 00/10] riscv: add initial RPMI virt support"

Please let me know if you'd like it to list change log from all the
previous versions instead.

Thanks,
subbu

> Thanks,
>
> Phil.

