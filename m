Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30157CD5BB4
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUGD-0001Lr-Rh; Fri, 22 May 2026 14:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQUG6-0001GM-NP
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:06:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQUG4-0006f5-1r
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:06:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MHfU3i3601096
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JHMKS+WwFI27DqTvz7rK8g568l9DxjENSFAI1TTE7/w=; b=YdvegJ+brbLvikLi
 JeNL6TLz4hTv5vDidNBB201h4KVsa1QEn8+YNV2vyxXARv8RYnq4pIL/Q6WGiLgg
 Mr2PVnDnL1PVx34x+2qjeXU66tWyFLDDmAq5TzA6Sxki+EZkkzyKxm8m+sF/7eQu
 OLO+DI+0EBsmbW0q5rzTL2JmtY/Ltj0T3zEr/1QMshcsu+TaoHipfZoEgnnCBuw0
 aoBBFh6GiSycvOH1hlS9lbd1JMlAYEPGplFBGRIJKKLQcvFU3kK/RgUkXUZo7VY6
 gjZeh7eHpbhKN4dCqbuE/PQ6rqFHr3Z6J0ptPpY1STXWf/nQPbE3bbEUWDMC4d+v
 GyTpQg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaury037y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:06:02 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2f3ec2e8d07so3927935eec.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779473161; x=1780077961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JHMKS+WwFI27DqTvz7rK8g568l9DxjENSFAI1TTE7/w=;
 b=C/VpB9Mlb+gqOXpP9QSDj5ERsU373RWjj1Jne2amk58RhhS4+xQ0Kh8aB/UrF1xZ33
 5lkw3KH8CPliW7orE8PJTXWmrolRszbFTBOkmzKvoYmXo2dBHwnX/UlBQPKzDEqjtCZA
 zAhIhhK7ShGo8OpwzzgSHP7QwsN8KjxrGEBrM6BG7cKg1NZA7ofS8PWddo0cABs3keIZ
 zUErIJxrupMWeirL5fY05ofadt1zQIM7KfzYit+f7DiNvNo/sPpyAsQOCflIDL3tMwst
 ptXKPQBJRUQy5RofNYzJ9BjtwWaT1+e5pCNnS4jZDdDvIJrPK9ysC4cUSVkd0C+SmNYR
 1FEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779473161; x=1780077961;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JHMKS+WwFI27DqTvz7rK8g568l9DxjENSFAI1TTE7/w=;
 b=hWa44u7W1x98vnCvnPjL/YkLSfJBDSXccNGpubaG9/O0DpnNT1WOgAZU2qR+Ro7yZh
 CZV6P5NkAdcZRkOVtuXUz8KsmKUJHG9r8v1/gSMfYgrf3vGtbc/yJf4qcsHvwJUVpie5
 ZVjtMngClcPdTDM5XmrjQkkAVaSwSow3+JTwHuvVY/hmjDrAHngCAPq2/Voiw79zjcRb
 K7FgPC3gUNqFS8jWgtbmVKPmtxEnENcaZXF1kW/50LrnAypE9WX4AwUC3ICLkGR8f/iB
 jXQADYgmXZf5VJpbI0Z1GdV2Ped1s2qeThsrsPpaGz7hO6EoL6uMhj/ttvGsgWZ7fMYL
 z/gg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xOw/DgP7/v2rF5Heiu47oNqRh5XC0ZgOnL43Pamz8aV3NPmI6W1wC8/2CagNV1n6Yb2UD7eHVrZ/M@nongnu.org
X-Gm-Message-State: AOJu0YwFZCBDrlcdIvFlz3NZjea11FFqs/4tU39s43hwwPWzUVJH1CBS
 D3GqBJw6V/eIdu/y+2Cg25s+ooHQRtHnj/ZapHBXJe/yop84CsViQC6FAwu+dif+IAfHIoDY9G2
 dCR8uiVeBJCDaLbEpeLhELCJDtUVrOcxIUBzM8Y1xMwXkxeBlygKufBOvNA==
X-Gm-Gg: Acq92OFDqdQHPKoUfYvqNDR9HKKwbXwo2wg2sfBSUkprSfsSYR/xnSIJLemGng6Quti
 XUpuXEJLpwGYAGb9UQZ+tLT7xqoLF/uZ46vjKmWPsGfzpraMJXP8QF4fObSf+JC0ObPBjSEEKOy
 UPj6W/3Vfz7GM97X/mNNEJjtuz6cpJpbzVOZ45Z4glarOX5vVDgyrOgBajYVVesVrh9Nd74MQeX
 QJHC8gdBKz1eKVBVV8Ekox7mt5QxOZppvm35tW1jSWGSKYFWbqElNbzQXR+4DUZen01o0pmcBek
 4CmWZChWzgHUCV2gITKVF3t23wuHi+kEWmEykmZ8z0RHJSQ/AuUVqrxvdunkhzNyKgtMSchRe3u
 47GyGtYITB4RRFzluLlX/fS9GGBXI4Kva9+sRRTbzscenI1xitoMO15Gm4CZVYZ8tGdrfUKxUKe
 ahMIONuNZGQwnoVt9Gb+wMljEu
X-Received: by 2002:a05:7301:2288:b0:304:18be:55a5 with SMTP id
 5a478bee46e88-3044914f732mr2387079eec.22.1779473161390; 
 Fri, 22 May 2026 11:06:01 -0700 (PDT)
X-Received: by 2002:a05:7301:2288:b0:304:18be:55a5 with SMTP id
 5a478bee46e88-3044914f732mr2387058eec.22.1779473160843; 
 Fri, 22 May 2026 11:06:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef4afdsm1558972eec.5.2026.05.22.11.06.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 11:06:00 -0700 (PDT)
Message-ID: <7cedb33b-5aae-4a82-b53f-82e8a5213e23@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:05:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/code-provenance: Fix formatting of *-by tags
To: =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>,
 qemu-devel@nongnu.org
References: <20260520-prov-v1-1-7a58af334b9c@9elements.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260520-prov-v1-1-7a58af334b9c@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4MCBTYWx0ZWRfX3GzYfG/i5OwX
 CvdfbB3t6qu5HHvneKHnjpVtUfdjxrMew9IL65g3Y1RjEiHxgOOPDyMKF1LYHNLHAmTPhPR27wv
 VJnT6OUOQmVvCHTJdykmp5szLIb4oGjwEUca7RywzVVr+y1SR5TrUq6t9b6VeTV0p6cIe8r3db+
 BywLI9H9Kdd2DtAMD9jSSo5MH7xdN6p0V4j6XhX+HtEYsY0VWFUE4Uo8pcvKTUUepBWkSDWj+Kj
 uREAKuhvQAFA2ES+TFlMx3c10b45KtOQOAF8W2xQVHzkJvB1MG0dAIHtV7u6GBWULiDoc/pf45H
 FvSfIovEgIKck8BGvd1NMG3KrKuexqR0TtrL/ps49ds2z+NHwH9beHPh9J9twuLvY/m6uuMtGiD
 f7v9JjmglomjoeV6TERqBMTfZ7UmA2CD2gZYRyVnbOYZsQr57799btcMHBB73BBo9KsVAMYfB8f
 jFPmHJQQNy9bdInttyw==
X-Proofpoint-ORIG-GUID: 7yHOAhwguPajDa48fOZ8IF3SZOturSIh
X-Authority-Analysis: v=2.4 cv=d8fFDxjE c=1 sm=1 tr=0 ts=6a109b0a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=PzGKxP3WAAAA:8 a=EUspDBNiAAAA:8 a=N8AWMYg7-tRfh8WN5ZsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=zCCnohV0i-_k6euCn0hJ:22
X-Proofpoint-GUID: 7yHOAhwguPajDa48fOZ8IF3SZOturSIh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220180
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/20/2026 4:25 AM, J. Neuschäfer wrote:
> Applying both ``code`` and **bold** formatting doesn't have the intended
> outcome, instead Sphinx emits the backticks into the HTML.
> 
> Use only **bold** formatting to fix the HTML output.
> 
> Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
> ---
> I'm fine with either solution, keeping the bold or code formatting, and I'll
> switch to the other if requested. They just don't mix well.
> ---
>  docs/devel/code-provenance.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

I'm good with this solution too.
I'll pull this through docs subsystem.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

