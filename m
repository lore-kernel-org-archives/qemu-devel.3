Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE7A606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eaTLYHRr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L3QXXzuG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ4eS-0003BL-AL; Tue, 20 Oct 2026 03:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJ4eP-0003AS-Qe
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 03:52:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJ4eM-0006XX-PN
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 03:52:49 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tlhF186970
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 07:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7h/Fp0uZAUnKelahVQPL1JbNq4LMY3T9aR0GLRmuKV0=; b=eaTLYHRrZrQbbGbO
 JyTrP+vIlziDIMkoRS3BepTrGUoRdJrqeI2AEWrjGsOIqR1ImMIP7kiDwJQdPJqQ
 X6lHo7RYLsS+n7MY6RQCNKU0Glq80mEcu5tb927skpJxO14yyjhDBWRB3OkqSqE7
 TAQZnwt5GsoN2MivknIavwPkGZAq05FYCvihZoXJxKd9WU4Wz9yY0l2iKnabYWkt
 2ZtUS/uzE4ReYw/bpD4sfeMuJKO99R4Bly0k2RH/2EYuZ5H/lwrIveQrctOI/L6U
 hZXDVvnx9zUbejgz5wcpWv9FOJIngzrFPDbHNX3Fhfjc6uy5xk+dqptBTR3WLHEH
 jMb2UA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nsfsc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 07:52:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f33438950so765349985a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 00:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792482762; x=1793087562; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7h/Fp0uZAUnKelahVQPL1JbNq4LMY3T9aR0GLRmuKV0=;
 b=L3QXXzuGkzRacs1k81TYB1hmZ8w/OVaaa2LDp77WbBb3jg6feOD+nHdNFi2jjAJEor
 ku+QkXwzELvFmjvBvr03xpYoKDy2RzfdckzhkXzvvnRJSFpiUJIow5UviZCuCqb2YrUS
 jIuA+/JAxJdWUAHBsUJbWQ3MY2zaNy6ofv/7uIBXwx7FX4Ml0J7nDuROETYviWUxKY8x
 qln62F1SMP+63ei0mFI7uYjkUkS5wugkc6Y/7UAyo4rSg4gge7TvEduoxxWPBtYyVQXX
 Q7w64nFV9tLe71Uqb/j8ZGR6DbOLGqjHtC4kWF43yMZC0zUSVo1uaxp3uONiRIcSSYyM
 wMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792482762; x=1793087562;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7h/Fp0uZAUnKelahVQPL1JbNq4LMY3T9aR0GLRmuKV0=;
 b=Un+VcM+rQZ5I2jc4AeHq1qu9UHcqBJU88yuoOJpKb7CdbGt9pGsKVBRxcSStFN+4WZ
 +uNkY0Y3+q6YW4+fIxoDoDPYYoWLuKe/kxSQdZvFNq2+eHAVW3SvTfa/iwHry1YZH1WD
 /kev8jcM2mNzduU7uiHxvwe3sWg0/znJ0HtCDa1ZuJ9LSyhfzG+OpflpnxkcVkqvJI6L
 Ete2cWFaWRkgp1C/4kCwonJEk+/oXVDDoteCaF/8nrcxHZiQ8bq3BfqfR0ddV8KAhpnJ
 o+C/j2PwIR6LzLRYJAxYhDteQ4tLa2mb5Snv1N3iOR7Uw6aniV1savtyDCuOuvO9xs5h
 eeSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwm9QYOywDwdToMbyYSBE4txzYQnHt/+8jkYxAK+x+lyYgVGvzcTLa5HsK70WNSEjPuqLTYp44Al26n@nongnu.org
X-Gm-Message-State: AFq9FYIcGloC5WTsMZVubbrcY7V0oSYJFFEl2i6mEyXXgJfMbM4zpEBP
 xOzR4zH/dlohFqgVDxLOFXxl0rMz45WAeObAwhX09G6ziJXgCfzAixQGrN+pM+DeCrxpccehK7W
 Hr0wuib0RQxg+idpXvT+1XRPxN/PBSiz0+1QdTOC5Au+uN3FX0tt+84bhrg==
X-Gm-Gg: AYBFou0vjRj9txQjkGaHA5s0YJTbZUwepGoR/BiLZ51QuxRdMzWBff6oV1PkbR2JTpd
 Z2OXbNasc2KrAEaYHte/7l5lOgSyczp6ADgqRJDpdtlrMzQDM9KhUbTaqYXKOHGKOm85AsPy2MP
 NIae//MbFy3Tkd5IHk/Cz4bPzuKn31C2Yq2pK2/aFJFj8EgnbvhdopiGekDoGQbjWBB1AaIMSt1
 dnsOeoS0ySnpRh55KCFkGbPvhPwqxT3oa0yPQsFYoiZILf8quKr4L8ROW0D6IQo6qkmo0klIL+A
 AY0D0wEk6uwz/U2kKsIBWtrZ3ITL7iqOub20TO+/Ep6G2np9h9nRJe7HOtuLwH/fvFTwi6VuFZw
 scK6coux2Xhz+spfEX462Q9zHSkmZiODJDw==
X-Received: by 2002:a05:620a:40d3:b0:93f:4921:6965 with SMTP id
 af79cd13be357-93f492169femr419265685a.61.1792482762050; 
 Tue, 20 Oct 2026 00:52:42 -0700 (PDT)
X-Received: by 2002:a05:620a:40d3:b0:93f:4921:6965 with SMTP id
 af79cd13be357-93f492169femr419264485a.61.1792482761560; 
 Tue, 20 Oct 2026 00:52:41 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d823cfcsm4385612f8f.39.2026.10.20.00.52.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 00:52:40 -0700 (PDT)
Message-ID: <cc020146-3217-4fce-a0c5-bb5a6998ca7c@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 09:52:39 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/bcm2835_cprman: Treat invalid clock mux source
 select as GND
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Luc Michel <luc.michel@amd.com>
References: <20261019161900.3271815-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019161900.3271815-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dCnxIAPUuAPGccD8YLjJOIlpR_gsbDMe
X-Authority-Analysis: v=2.4 cv=DZOCOftW c=1 sm=1 tr=0 ts=6ad71dcb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=nqzFHhKESNHY6nmyNdIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: dCnxIAPUuAPGccD8YLjJOIlpR_gsbDMe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMSBTYWx0ZWRfX+ewWMCrMjZ28
 u1Uc3hyoYcdFKktiSdBBX0GlRV0H6O2oH8gXk62CAb/U0KxOmV9+HNIm/Alg+2T8FODKMxv9RpD
 fcydktcxySJjoMFwvMT5+Iufonr4JxfoHJ+yHSlkdOhDedGTtSjnsrSxMArp3wRe5oZ1uwnZTNA
 0JBP5jenOxjOLZehvWDJKIB0QHHkTxlEj6fD0UIBPGw49zWHFary8lh4afUt/CQGAtWJ8XKJ+kx
 4GAvoC3VH9uVtzwjeOKHLNyFXi/DB644Vi2R+fGoPPqV+eRmH/1fb176SzABbp/QtJ17/oIRCz5
 kwEFe512nbuftnYA8Jl56QQhrxlUFgNnMdngUZ75guQUOzBAqzznbujEbpqgd81YuYU5kjWEYTr
 5mGKUPEgTsdwKlTOkHDXcViQkz6711HNl2qbeqOqknHh8O+5xCQm1CbZmmvsJijSrY3xaw88K9K
 SwvTxshufl3wU3hcDdg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMSBTYWx0ZWRfXzvHiGrLx6jeU
 sEdEieYb6JslZsQsuV85o9c7/+WZscdpuowFZpXxc3i14spCg/crcZRrh1fXPQt5+Kd6hc+9UC6
 agpnzXnHvgT3je9/TgI48UrhzB2N2io=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200031
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19/10/26 18:19, Peter Maydell wrote:
> The clock mux control registers in bcm2835_cprman have a 4 bit SRC
> field that selects the input clock source to use.  There are only 10
> valid SRC values.  Treat the invalid values as producing no clock
> output, as if the GND clock source was used or the mux was disabled.
> This avoids reading off the end of the mux->srcs[] array.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: fc9840850ba ("hw/misc/bcm2835_cprman: implement clock mux behaviour")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4695
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> ---
>   hw/misc/bcm2835_cprman.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> index f9a77ff9bb0..10cad07623d 100644
> --- a/hw/misc/bcm2835_cprman.c
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -271,7 +271,7 @@ static void clock_mux_update(CprmanClockMuxState *mux)
>   
>       *mux->reg_ctl = FIELD_DP32(*mux->reg_ctl, CM_CLOCKx_CTL, BUSY, enabled);
>   
> -    if (!enabled) {
> +    if (!enabled || src >= ARRAY_SIZE(mux->srcs)) {
>           clock_update(mux->out, 0);
>           return;
>       }


