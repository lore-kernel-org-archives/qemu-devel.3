Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F18606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R3IZ8Ssc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IKhztMTt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJG5e-0002kw-HL; Tue, 20 Oct 2026 16:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJG5X-0002cn-5S
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 16:05:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJG5T-0002wF-JS
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 16:05:34 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI7N0H3460915
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ro/ecdsWOS73GkEd2dXh6dLwXmWXnyOy/K6591ncy4E=; b=R3IZ8SscFIQ1EqwJ
 B4e1+E+OaGWnOwL2He/HpgJE/mCi0B/ys5TWkS1vYswS8lzzQtFxZ0IuCMv0Py2y
 xzqAjti0QC0DWpDB3aysOqlgXBaSDZwDaldDWjvHqDdgzzFF4qtxILJ+yHKefMX9
 R4htr7tQ+n+HMrqqEs+N7VXROjiDzk+nHNbg76EBO9iRlcEEJcLMIgRrYhCPOCZM
 pBYsuRIE+9mK23UH+tBGtRNtTKGyy2k81lpdYb4BtmyXDSCqWYAY9Z4uM08+jleV
 6yGyrQBYbfv560OP1mJRh+mf/vL+YfnKScrVyy72pIHEbTLGTLwyCVsYIwbsVjOE
 myayBA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4rd0j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:05:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f37c94ceeso203370685a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792526728; x=1793131528; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ro/ecdsWOS73GkEd2dXh6dLwXmWXnyOy/K6591ncy4E=;
 b=IKhztMTt9b6tOYs4SGP73yF8ss6uA7oDx7TCoLbDmdnHDm2G1yjLIM6hwzZinq79EO
 nzWHBPMv50k5MrBf74HXCW9weorDE9FpxRtnPGevKbP2S1Zp3gFX7wfB5yW0WFW4xGCv
 iaBlqBjxtzHY1uEiFjN3WAtp9G8TM/qKA/+WH4d1S9XE9WuqY1A8UrR1OFd7hQLu4dCr
 ypp6pg5Mhsy3mQLlxUG0Qj8CD42vz5VzqusptUaax5g/y498gzTTy3n93YmNmr4Rp8am
 5WDvNzAFW2rT596/ShZ4VaCw0TL7ENpfl591DPIsIAW5WX/aKx5vo5humMmd8UwfKQUC
 WJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792526728; x=1793131528;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ro/ecdsWOS73GkEd2dXh6dLwXmWXnyOy/K6591ncy4E=;
 b=CH3zj9N3uR32R0fWp/IZ5nO9j86+aQ3UQ2wmM0uOx3qHQNHyVrQIMHLfcCdvha82pE
 D2rgG7p7WQK5GgTybNOhmM5ghB5iDvZzcn5cfYIEGS+ZWmyvRU/gUC34MeCZgKnRk4PH
 kWicnBwFckCKgbY7+1Uk2xPqGDenh7UxnAsd0W2/T/pmaB4OZakD0PM4y9XS/qGESkEH
 oSCydp4CGqQRhpx3H5uyIf1t9fMB5ZQGlj7O7dXBTOwW98a/jbhUYyTzEWNyCZVzvO2k
 jY7Tb8VB6gluejCiDH+pVcapgNQQP7bPNrp81MXv2BRhW1KDP4mSXx3xb89c6OABlLPu
 s2pw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzw1YVlDLY2uZtDm3KRWpcbD9kt6KbOrQtBTe0GQnLKUlrSrEGWx23DQldSKeg+fG8qY/GXZ4okfQ+G@nongnu.org
X-Gm-Message-State: AFq9FYJGBi/L5ar2GyoFDG17+S4uhqkMG0T8ustcV4OHiQSpOIM9rACk
 P+b7M1Y9Q5Lh/dNyHtw/sYzdOi55YLWmLTBg3xe4QBp3AnvvLkVhbDElDu477Km30dZr7P5EjR+
 ZbkR5kNgxtVeAFDV1nsqKgpUIN8/Mhp2dK/ixPD5kI8Nl1DG13Xl989bfQQ==
X-Gm-Gg: AYBFou3LZojr6/o6iiOse7Gwk4TyKl4NKax5cMBhid3zQAzio4plP4IcXvUIiAY9NDJ
 oeDdB9kx+Q5hrEEFSx/DZ8jvpEZoqCqMXsv631PNfzSDK+3xbaFwXkTztAfAOp0UYLCmkG5VglP
 uV7w056VOJ1WyoV6lay+D3CKhoCnw7EreEg6Tih7r8HvIe60SSAxrMotLkmwN53fZW1zgmpF/gO
 qflmFhTBtGUnvLkVaL6JkiBjIwgp/33o+Dzahh9+GDrfNAEcH+GL1l7igLOMkdhlDSlXs7fmkGq
 pFn2HCAxvQiBt3AvjfkyCWEQzxuLfzJsvfqiMi6czEVzrkWaaoYbGBakri4VYIC2d6MaxKM8R1E
 MkS6RuSV0tl4l0F0t1AhdA7S+qwhQmcC+RA==
X-Received: by 2002:a05:620a:4048:b0:93e:5677:317b with SMTP id
 af79cd13be357-93f4c78259amr538912285a.25.1792526728165; 
 Tue, 20 Oct 2026 13:05:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4048:b0:93e:5677:317b with SMTP id
 af79cd13be357-93f4c78259amr538905385a.25.1792526727548; 
 Tue, 20 Oct 2026 13:05:27 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm551985f8f.26.2026.10.20.13.05.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 13:05:25 -0700 (PDT)
Message-ID: <a3fd0dac-c3df-4060-a621-89cf25893e91@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 22:05:24 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] target/sparc: Add crypto feature
Content-Language: en-US
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261020145530.3385376-1-stian@itx.no>
 <20261020145530.3385376-2-stian@itx.no>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261020145530.3385376-2-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VpEQEREww6vJHwtjwA0Hi7aWHZB6I6ht
X-Proofpoint-GUID: VpEQEREww6vJHwtjwA0Hi7aWHZB6I6ht
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4MCBTYWx0ZWRfX/KRv6ShjIXBM
 myQEBoR9SCLUYa5y85d8mpIH/yoFjYUiS3T31ZEEjqlLxMqw7AeC+kNbEWXfcTdHNaOnEiTT5t8
 yZLTFt09ks/fp9HdN9cMXDVTZZxe8qM=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad7c989 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=M5Lxp_rwI3JBjKUYqKcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4MCBTYWx0ZWRfXymPbuPCLO6iX
 p28e/C/IUxGpqqvIZKzf4LfRitC773Ieo3d1UbGGYC4qYVb5avn3FkHyagwkDyc1rx1rl+3ae+a
 aAmSYStrwqY4jEdIqUvy3+eo9/1JnKSy00j39ekkZPc3AcvyyLvset5vp4xYgRBuj/VRSAGM3sO
 mki00czpxPbLmVUhTNzY3k3yPZ8KCv28pa+rLAQTHUIg/KaMiQQ0f55sghWnd8czbmI/sT7jZqp
 QYLID9ucWnL6POuTeqgdO/b41yLPh4PvUIgwuqVVE2nRlk7OqFO3N8ubVq0aY3LBrBiVEwPmM9+
 BQDHZMrwjVwwRawbZ053uF3TGB1XDvVuS2a08RpaeOCyzcvtj+n2QVAfeR0AU4Hw5R2JonyUNZ9
 scpD+OcKJa772x+P/uNy811q/wE3aHjOXUZJV9rliuzmTD7XAU3PsbhUxdh3d52z34ptXIbhcGn
 Y6FWVcyibvGKaG7c6OQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200080
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/10/26 16:55, Stian Halseth wrote:
> Adds a crypto CPU feature. Off by default.

Suggestion:

   Add a "crypto" feature bit gating the OSA 2011 cryptographic
   instructions (AES, SHA-1/256/512, CRC32C, CFR in ASR 26).
   Off by default; no CPU model enables it yet; can be set
   explicitly with "-cpu ...,+crypto". SPARC64 only.

> 
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   target/sparc/cpu-feature.h.inc | 1 +
>   target/sparc/cpu.c             | 3 +++
>   target/sparc/translate.c       | 2 ++
>   3 files changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

