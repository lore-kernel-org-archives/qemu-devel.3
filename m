Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68373CD98F1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZpLT-0003MY-UM; Wed, 17 Jun 2026 08:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZpLT-0003M1-6y
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:26:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZpLR-000422-I6
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:26:14 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8UTZd3273532
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 12:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AxfZE1gPfb3A2rKqi8N+u+RT9xFooihvlI/FiUXZhrY=; b=cdJCcZ2RpEz9jImy
 k3fOTMgRyM3EjaYQADmKRKcl5O6GWb6XHdkTs5CQuRwPcLok09aiI8C27y6hHPvS
 NRmHFK2ssU/L2PKhQOn/10N5OIgabuV6fLOywP7wMvPinjyMgEb7pSUHTorysVwA
 vgIpAoU4NnC4mSujFm92uxsbAqsgKpzoYFJzTPAOCmS83i2s1QaoomjWA8jwOMT2
 AMDYV9kXIKPuipjmhzdqlyU9YE5p4OmBAhEsQgTSWOgGuz+xW4QLDHg9fRa0Fh+i
 QGEh8xYZN9vJwgaL8tSXlDMERGgZEJ9i1hw09o2xAr+GESRKq5EdOKDfnNrRakIz
 zFM4yg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euefbu30g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 12:26:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9156ceb551eso877390485a.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781699170; x=1782303970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AxfZE1gPfb3A2rKqi8N+u+RT9xFooihvlI/FiUXZhrY=;
 b=Qqa9+FRGxoisunRNwO7d39PrksoS68xWJkf9ToYYOH/xvS6CfEkorEzGMxFw2zJUJU
 4vkHix39JaD3p3nCfla3ctdkxSPxni5mjRlI5wotFBPa2RVtYFs9+rumFzA2C2jmIedW
 mxyvHuMnox/T7JjJBrEqgqM4kJe8EqPuBN6lv8VzMqYZuC3PYZwWiw4tYVbSm1M7vMnO
 p54JL7Z0d4tHhMc6/eoxnufHjxWkCbSCbJUzqZeBVHgyhUJKL7Ym+CEAJ94Op1451ZiZ
 /b0DnmC3+hJPn9o4pqhBUKFF54Gomt2zRzUbaio7pgMCsO3ZaRSDIh8s68YnDXrW/y1m
 MseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781699170; x=1782303970;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AxfZE1gPfb3A2rKqi8N+u+RT9xFooihvlI/FiUXZhrY=;
 b=lRjJXSLsyRN1W3PZuOxAD9PqVnOmJPo8TFVTKGM4qWaGGTHHgYggkDL18+UarWTieb
 2zzFQNIDOt4ez3dsFjDQcdCL6nuPTa1UlXgOlzSXvqdGvv42OyoZ+S1BjE0eD8BWnRDP
 t/b8qBCFehtTYykuBCgsnLizm6tFLpWWIRhaXTAbwjEG2F2CbpBgow+W4cVMRjuHLDVo
 QfapEu8lBmKbyMpOrvilQQsM8PEN60dJfuTVOLcTrnCySTNd8csMPwyMnDJPnNfab9EH
 rD/i+llljccZyWGVrvq1TyNDu1utCO6S3OEFsec2taKvERKMj/fQEyJT6+yFPhSwBWhg
 XYaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8br8C/w36/ciZIz5v0Pd72zdzMKWJ4b3qBFo/mnFEUflpg3/5FskTj41o7y/aFx+HC/8uyE/aMxNdp@nongnu.org
X-Gm-Message-State: AOJu0Yy8mUdTaervRFHfVrZAKeY9If1Le3v5kZ8czxGpEkCt30TA1ldD
 DOQTC1stlwI8vrNWwQUKjBeB1G/jTi+/8L073IH7IWKs2+XczE/9t7y2OUKzAnbuYglTBbGwNis
 A2eRLTABziMY0LynTx5JN0DK3Pr4/Unnp9JOfpeE8mRbn8BoTy7f0gqsXww==
X-Gm-Gg: Acq92OGx62utKhLVREtNPYODtG4SkZUzjpwF944ByQwde12u1Eqm7ndhViKdwxxH55d
 Y2n2Px4VpRoh4klVgBzXxm4Gnm7nJmy6SaIikHrysx+QH/t/jGxBRMRfKF+fonpfA3GK5/bCjKj
 g44nbxoCGZ0NySou0DZoYoF4tR5RsFezPuPfiOOE4xe6dFjlPfne3m9wA2dwdtlKoiG3t19eMRG
 rJB/uVAOAFyrWhoj/gJOrBPcRtj7z9uMTw9PcecggDFniPHathbMgUGrvD4V9wcHoz5V9LqDJLZ
 rIEWuSh6FNRBteambxHS57xEAHFQvG23XP7JrdWNfO71Wq6PzlU0S/CesMBDhx5o2lidaogIBVZ
 T4cIN930FHkoB0oE7rHgTg+4Qb1x0049x8UOJjanTbIneLDQ=
X-Received: by 2002:a05:620a:4586:b0:915:8c48:497c with SMTP id
 af79cd13be357-91d8afcb0d4mr677448785a.28.1781699170471; 
 Wed, 17 Jun 2026 05:26:10 -0700 (PDT)
X-Received: by 2002:a05:620a:4586:b0:915:8c48:497c with SMTP id
 af79cd13be357-91d8afcb0d4mr677441285a.28.1781699170013; 
 Wed, 17 Jun 2026 05:26:10 -0700 (PDT)
Received: from [192.168.68.103] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9161a00ad75sm1765234485a.25.2026.06.17.05.26.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 05:26:09 -0700 (PDT)
Message-ID: <40422567-4917-429f-9fe7-b7fd8e987afa@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 09:26:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/riscv: Avoid NULL deref in IMSIC CSR write
To: Joel Stanley <joel@jms.id.au>, alistair.francis@wdc.com,
 Anton Johansson <anjo@rev.ng>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260617054034.1020724-1-joel@jms.id.au>
 <20260617054034.1020724-2-joel@jms.id.au>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260617054034.1020724-2-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pWH-5jwuPicGd679CZvAeEgX1M6M58ae
X-Authority-Analysis: v=2.4 cv=IeC3n2qa c=1 sm=1 tr=0 ts=6a329263 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=hClRAUHGN4GkA8EATyIA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDExOCBTYWx0ZWRfX7dVkF+wZYaVC
 6tRI3rKOC7q1irofSBVMNmQrRzqomLOt+DCraxZL149+ZNj5sDr3Dw7y6bCXH6HSVhpEFA6Qk3T
 PzPW9tbf0O3TtJKt2a4i0C+XGsSH9D4=
X-Proofpoint-ORIG-GUID: pWH-5jwuPicGd679CZvAeEgX1M6M58ae
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDExOCBTYWx0ZWRfX/d/RVjrqjuQ2
 ZsSZ3DiDmqKeAr1xN0Hbed9yRM+zF87UuyWFGSvmq9B0wWNKD20woBBgTinyYgJuneIHaMU8pkn
 j3ICS1WhSNDXQzdHNcWuQDhdqwFDipJcqHCvZpuYdyGznXodkGVOZYr9vkN37ujgaDqXqkS4qTo
 KPDylN0/7H5dhx4E8a6GPghANNiTTLykKchceE7cFkwGTGrdqCExDQj/MooVbKcdxmtGZDZqjaS
 bq1MJzBCEwJhWud/MC5HtRA1A9FDX2fOPKuhHnKlkU3cGftn54DajoS30JeY6mTz8Q12CFwsfMX
 Lbw2VVVeUiu6nOyLJjPJ59aIOyQp/HHg18pgrlu3aBQSE1d3vr1JKKkxADdOEo8hQ+/9NTxhmrU
 O391yxrDSTxE8TyDCNnd3Zf5hzbdrkdte0BoWjZUCyBA+Rm/BqJtB7/gb+b0lFXg2sKxlWT62/P
 hNVNsYXJlvjcFnQLo4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170118
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 6/17/2026 2:39 AM, Joel Stanley wrote:
> rmw_xireg_aia() and rmw_xtopei() were changed to store the IMSIC
> callback's value in a local before passing it back to the caller.
> For write only CSR accesses that pointer is NULL, causing a crash when
> guest programs write to xireg or xtopei, such as when the guest sets up
> the IMSIC.
> 
> This only happens when setting aia=aplic-imsic so none of the existing
> boot tests caught it.
> 
> Fix it by guarding the pointer dereference as done for other CSRs.
> 
> Fixes: 63469ad75dcc ("target/riscv: Fix arguments to board IMSIC emulation callbacks")
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/csr.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index ec931a8c3ddf..4502f2ab4788 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2732,7 +2732,9 @@ static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
>                                       AIA_MAKE_IREG(isel, priv, virt, vgein,
>                                                     riscv_cpu_mxl_bits(env)),
>                                       &wide_val, new_val, wr_mask);
> -            *val = wide_val;
> +            if (val) {
> +                *val = wide_val;
> +            }
>           }
>       } else {
>           isel_reserved = true;
> @@ -3008,7 +3010,9 @@ static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
>                       AIA_MAKE_IREG(ISELECT_IMSIC_TOPEI, priv, virt, vgein,
>                                     riscv_cpu_mxl_bits(env)),
>                       &wide_val, new_val, wr_mask);
> -    *val = wide_val;
> +    if (val) {
> +        *val = wide_val;
> +    }
>   
>   done:
>       if (ret) {


