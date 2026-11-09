Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529FE606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MoUckSRd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eAu013qE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQWA5-0000k2-UQ; Mon, 09 Nov 2026 15:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQW9l-0000QR-Vf
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:40:04 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQW9k-0008PN-Ed
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:39:57 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HH4jR1525214
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e1kJnBGvSYeg1cNVZAX7y49hMvH6+Fuu0kAyMBcsjUg=; b=MoUckSRdtF//mdz4
 y6Loz6jli4V1eat0EHSAJgaFHIDDpQqCWaxJQcELuRURvVUQbx6GHeBknxEvWYrw
 rzYnGhNsHvu7xo6DA6rrI9Q3/QoUiqcOhDNVjkpBOGOIFndkPlP3JgqG9IfE/fm0
 fmjXU2jmNAxI5r8gCdXvmA1EaKYGH0d12P12olc3Gz0TU0c7NwFeIOdRH6bDrbJm
 oRIPT6XvZM6mUo8DCThWDHUEMi7TKpi/Bco6Ld0FCUnneoUsst+OzuHjArjCsnaF
 KPmqgJ2VSXuNpTkNEtCywofdPAVJoPHqmx0pplZUBD+dLFV+4/DXYKL2jn8Zm6EK
 v4Chbw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hufx81dsy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:39:54 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91e987a4099so28368886d6.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794256793; x=1794861593; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e1kJnBGvSYeg1cNVZAX7y49hMvH6+Fuu0kAyMBcsjUg=;
 b=eAu013qEj5IaYfnFWd5CpFXgJCGuXBDT97bZGweTpmHSBWTufFe/aRnJGc78g9Budn
 CeWdqf/iIJA9TTPiw2XIQKHFd1OCIPgSr867EYveakrGVormIQP5kpYTLrZBnxrOu0g6
 ze8C91SDvumnCsgAM5QfDz+Kg6LaVWu5hH4PUPfQPGBjofjGJyWGrqtdr4xEn+bRIuhk
 UwX9Kd1CnUJVR8aM1sWwV87cBZYaYoHN28B26JhgdQAyU/1lBCJ7QHxLy9nInu+CwYDU
 fbE1pQE7uj7Bh0PQ7NsYW5pTSawmHBZCRoc7UcAIQcR2kbBGhB62EihTmgK+tZ/ckR+9
 aF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256793; x=1794861593;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e1kJnBGvSYeg1cNVZAX7y49hMvH6+Fuu0kAyMBcsjUg=;
 b=r5tPNEaf+goVjlPFON5XO4rg2W1OdX19/VN617uZhxyT8K1YnmUgk4uDHQYJca+nzP
 2tXo6FeWbX7GnB29Kz0q0Hx6sqym5BCgX5hI4B6PrINzTSBtWSvGaZd75mmxsLBlu16A
 LGicXGD6Soof+nuZUr6mQLh9j6G/ni6Vs2xCuD7GHSnd07rvohzJTdjC1EIliMbI7OIV
 vD970oOVZbqvxU6TaXBrg8Cs8lguJewZ55fhxnmODvSlg4FOO/GIMQ/0FjQInxQP0+ff
 BrO0V+3hoIW+/mAV2kdoLcdwt36BC6MKQ8AGoxe1rJuIcsC1R9OBO/46aVqhcXOe4ZgF
 C23w==
X-Forwarded-Encrypted: i=1;
 AL+hErFTZwTG4xNDvVj3jvh5WPKGosX1Hky+OvJaspAXQc9Ye/5anFBTe5IwgLfdK3sBLwhQ9IZhHV3C5+rb@nongnu.org
X-Gm-Message-State: APuU4Z/yBfEWVhacIBrtqAvlXJLN6pB4NkKS9/Ta+3bRnHPolujqTdhA
 kxypgDMfwgv2YNOKYYtgJ+bj1Vp4rP6DOYT8tcdqjui85NZZI7+SIYFXNHuaqmhQ2N6BkJYswNG
 v/oO8C84KkTohooKGrPzvT6GyJL2aif8duaE6YAOKtwEHKKwqvGQXbYeKVQ==
X-Gm-Gg: AYBFou3sFiDuaR9Bo06VVUAGP3EYkb3/3uV52YZP5PhZkq0fCmBQUnFG/NYduW116K+
 bpx+M6H3Iwom/ZotW7LWcP7LC8nYunIRzKXpvT3B61YMKjlIMkwEspW3G6g0Y3dVWlsrpJeCc0g
 CGrePPth9T/T/9ppaU1MwdLEfMDV1Pdzyp03CQPzrFcaafGmbHpnTOVvCTGQQwdhk3BWoI6Dg71
 60Aqqew7crnDjG5Mm5otmak34rWrz/y5NO5LESfHS9ZElBTSvtOZB/dOphz0exCW0e+nsmv2Xno
 51pBws789bYY4o+Q1j+lWTH7Ty41hkVakfCACgVoXCLIcSsJwpdujzXkTi0gDqxGErZzh/SAPtS
 wWNDAJpAELo3/WLevV8n575hxoFwSeALWtY7GrbvPbQ/UERbqE4wodLOli3FsG+Zmops40B056f
 nwbWmespau
X-Received: by 2002:a05:620a:6f0a:b0:93f:3829:8492 with SMTP id
 af79cd13be357-9479f3f45efmr94412985a.78.1794256793363; 
 Mon, 09 Nov 2026 12:39:53 -0800 (PST)
X-Received: by 2002:a05:620a:6f0a:b0:93f:3829:8492 with SMTP id
 af79cd13be357-9479f3f45efmr94409785a.78.1794256792697; 
 Mon, 09 Nov 2026 12:39:52 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef03161dasm4759086d6.6.2026.11.09.12.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:39:52 -0800 (PST)
Message-ID: <9a876cdd-45f3-4016-a484-82aa6184a00f@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:39:48 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 27/38] target/riscv: Add implied rules for
 Zvfwbdota16bf extension
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
 <20261104194155.679241-28-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-28-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AbYkjHXG c=1 sm=1 tr=0 ts=6af22f9a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=l4tOesgx5NEs24bu9rEA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-GUID: Axbhgz4AMR--YgdGAtZHvoebtX2LWm2q
X-Proofpoint-ORIG-GUID: Axbhgz4AMR--YgdGAtZHvoebtX2LWm2q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX4+TzzQ/YRVGP
 fzkfZMjgWAGAEqXfk4m4FOvgjzNM39sRlVcqdKSFsRhwrPSR1UPiEm9GGRFeKuapJLdvMFydaXc
 idstuboUpzW3nRvCJtjyqPMLW01LgIE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX0g0vk6oB254H
 cpBKmcPf4UJ24p7Mm1Vpmyx9iNl1xf5rBEWj+7l8UDgT85HkcpXWX6OOKDRT3lt6tfVQjFraeHy
 QeVB7VdVGXJAjRRTB8zvYhySkQb+r84SpIqrJ5IGcOM5b+GB/N65jb87hwJ/cCAUQD4PRJQSMGq
 XpOK30iCmDzEbOCEg7m2AzaLO2ui8EhzBrg47XDeQIEZWfID1rgWFL6MpulqLXh/FDdmaMuE/eQ
 iX2C/Z/6jY1Q2U/AAPB7fw4xheApbjEw7xI2xbB7EtUjrlEVBUhXLx5lQH45K/jQCJUBG3i9JWW
 KQwzhM2Nw1NN+Tkfj09R006ZOnHIMpjDj4xnU0ry1iwRd7WhOm4+IJm/oWkf0Fooq/3boRwTEVI
 HaxDFB6/QE/BBTbkPuXUhmTZ1gIsA8u45hjcTVJJ3XuRI8OGqV6XKX5lJ+tOBtBd20QJ/oJ/zct
 cf15w6bq8PzOjxOLXYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 11/4/2026 4:41 PM, Max Chou wrote:
> Add implied rules to enable the implied extensions of Zvfwbdota16bf
> extension recursively.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c33885542f5..566e2e835ae 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2890,6 +2890,15 @@ static RISCVCPUImpliedExtsRule ZVFQWDOTA8F_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule ZVFWBDOTA16BF_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfwbdota16bf),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32f),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   static RISCVCPUImpliedExtsRule ZVFWDOTA16BF_IMPLIED = {
>       .ext = CPU_CFG_OFFSET(ext_zvfwdota16bf),
>       .implied_multi_exts = {
> @@ -3115,6 +3124,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       &ZVFH_IMPLIED,
>       &ZVFHMIN_IMPLIED,
>       &ZVFQWDOTA8F_IMPLIED,
> +    &ZVFWBDOTA16BF_IMPLIED,
>       &ZVFWDOTA16BF_IMPLIED,
>       &ZVKN_IMPLIED,
>       &ZVKNC_IMPLIED,


