Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0147C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuF7D-0002gm-If; Wed, 12 Aug 2026 15:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuF7B-0002gY-RN
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 15:59:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuF7A-0003qQ-4B
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 15:59:53 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CI8sDN382650
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 19:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6sadnnLPKDRR6U9c8kSvnz+djFxdwrotm0Au4lBL/K8=; b=nyL310XNnlU+v8Ml
 frw9o98tkXKxT3LB3buNstHU0Pb2o28YjQ1JT1q/uaf6Na/LvaH4vIhQcEBMvU8t
 sJZ7DtlX4nype+M4R325orNm2AjuA6aR1m7cBEOafPQn2JsivhX0uFlJxVgTmj/C
 KIiz868rvhK1FPxpUbLKRhGf5stKlH7G+8LXXhYsq6r6AOppRseqKU7/l9eLKad6
 KAnvMMWbc1ZScPjbiq/TmQpBD6nuuBuISzHGPQlpzgyGr0hh3stjVWfKEArlQzkL
 vSo7HYokwmKCW9jW/KKCxvw+Ie2LS77LcVqik551RiKdcuttuBeYgXAETcRDTOAJ
 B6dG3g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0jgrkryh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 19:59:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbee8d434b8so217383a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786564789; x=1787169589; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6sadnnLPKDRR6U9c8kSvnz+djFxdwrotm0Au4lBL/K8=;
 b=BYI0VLytwAlWzlQGgTvS5A4Bv+6wsptQWLFTu6BHyL1uOgDSFtzt3dnFx7Q71/13qo
 MseHPYTSuV1a6ZNzTzeHfPMctsSj0iRSF7g961QdDzh6VEYdpd5eYamDGYiqzdNTnL4V
 SosvroZElSsnJ8xDFzvEjRqLZGfkeM2/9tcu+PVrcRg8Q4L5Zxxsl512De+9osGxtG//
 9/C7vSVG50t5sU+xPSK1R1H1Al5ga77L22f5T2t8vk4sn51RVPcm7nxFfv0EtUkWSo6o
 RDpdXss+sVh7PkTQAT1XI0x1OMwR3dxJqcU9kFxfVmGiHbsMlmh07L/L3Mrnu+4I9se+
 pPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786564789; x=1787169589;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6sadnnLPKDRR6U9c8kSvnz+djFxdwrotm0Au4lBL/K8=;
 b=ar8HLKbaMo1UwzCu3saOw+KVMtvlQgcAdxwqY5omufDTP84GKC3cyOVs7idJ+pMWw8
 fCY2LZvUyO3YzmCqbarK3H2JVwViKbHMoW20k2uqN3db6pgi3qa8zIMX7l2/MVNkS7tj
 uOpxndW6GiSANCpAPiPz46bbif0fuSZxtIRznOwlRS0XOnzOq/1ZGcswcd4w30yaxIXs
 qZBQdTC+TxIHikGOBibZa9DKc90jP4ioPgdfXiPxCiucX7C3uKAq1w9WGxdk0Ih6kNNJ
 43o3qQzSQGkgVAwbkJ+ZZvcfpCGRWA7rwRF2vWF04IZhmMrBYFlmxn3y/RVjF85coY5U
 UQXw==
X-Gm-Message-State: AOJu0YxJ3dI3lb/K7Vmx7neSQA+Dh0c/43eIVDAXSt6fplO2+lLYjeHT
 ojk+fk7KdSmdEkJTLhut2eXWRO4OXIkmZpsPyeOW+DJfCD4QnLbhnxjTmA5mm+7QnPMU2AzXtOg
 Xa1IxbHcjbiU3Efo5hks8HWt6v8InMZrFYi2TIoSKtf9ZwoNyOT8cruwwBA==
X-Gm-Gg: AR+sD126beQggWZwuc9QyEjXGGLIP7j99qlKm2USAskZNOI7ghQeJrVxRKCqnwDZX20
 ooTtXUrIOc+YMwd2R4rHTXJsDGDIz7CmTpxK7I5ymWpDwQd9H9z37lXdwbtIWC5uzAtj34gQGz1
 w33ECXXd76bJUSXZhW5QBcyJXtPBGC2Rb1D+d6M9SgwKArCBsVzSrrL1ssQ+HU161Je3lPPrbmR
 Loq6+wQ1gWM7FUXMyzoHmJSo+f+InrF8NYq5ZJtTe797efuBJTzrqPMF0rWgBMOpZFGx4NDM0Ia
 nfygeyJlV3h7G1VsvOcvhI1xA2fIZFMAmzjSukWudfTm8Xv3ORqrmx7GE9j2uhEM9a/7LtHgbb3
 UD7YwAiQLjKvISEC3F3iot1XAXCggIg/m8cEtGBYs9Ya7E1xIfAtfp8B+ReDRXUCpUgCI
X-Received: by 2002:a05:6a21:6da8:b0:3b2:8674:9830 with SMTP id
 adf61e73a8af0-3cc576936f5mr110738637.14.1786564788636; 
 Wed, 12 Aug 2026 12:59:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:6da8:b0:3b2:8674:9830 with SMTP id
 adf61e73a8af0-3cc576936f5mr110661637.14.1786564787930; 
 Wed, 12 Aug 2026 12:59:47 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef6a5947asm139872a12.12.2026.08.12.12.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 12:59:47 -0700 (PDT)
Message-ID: <d4918a76-23ca-4b1a-a823-9d77997fb39e@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 12:59:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 097/103] tests/tcg: remove remaining Makefiles
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-98-pierrick.bouvier@oss.qualcomm.com>
 <87ecg3za53.fsf@draig.linaro.org>
 <9a1d9f99-ef41-451b-a8fb-fd1fae500e22@oss.qualcomm.com>
 <2e675bbc-1163-4a8b-88c4-0e2875164965@oss.qualcomm.com>
 <87fr0jxgr4.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87fr0jxgr4.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2MCBTYWx0ZWRfX2sR7Kz3u4mWP
 Ypdy8kF20Iwd+qKhq6J9bZn3OWNTXJoi0SH4Q+T/9IrB4jWR8zzY7a3kNbpaq89KeQP38F2X7DG
 pl8Pxg2TAOnRAzKSE5inwykXllXEMmChrt8glhTPP6WyNsjZqksaPypADbqjlki2HODz4Ut33NT
 O9VCQdI8XZB2CSEo+U05HOePdXodmWHB/8wAfUeGv7TzcfBLkrX5P12VXbu4nIdDSo/65ki4ixi
 wN+WKDCewCn96TKuqNVh/Oz6Mb/4len89QjTwHscRrCDC5UJchMq/6mgse+W4bxDOUwSOaOlihN
 GxrdnL93YQcSBJgno9fzED2cd9PWYMGx6NuQ//RR9VWgTXzM+FwkAeEZqharAsUYnygeB4YKGGx
 VYheCvSYkp3bVdM766YlNJkdYvdkJxeyKEOTm+Wx+ylRK3SjwVEWOvQQ5gD5Uw95mQDbduNfT3E
 PqF9xrC6SaPuK/B65SQ==
X-Proofpoint-ORIG-GUID: oSmNDlGvNOe2h1vLzoFg4KS8Bc7R-Twp
X-Authority-Analysis: v=2.4 cv=TNJ1jVla c=1 sm=1 tr=0 ts=6a7cd0b6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=EvOwR-_Y5vprRaXiEn0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: oSmNDlGvNOe2h1vLzoFg4KS8Bc7R-Twp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2MCBTYWx0ZWRfXwledPWB0+HuM
 kIVr9VFrACk0Y7KnxPiman//cRJerXDbjZQHyUgEWKsHHKyE2lB0H+QRQGwPhamDseZZw2pifPD
 /7/HGjRgWoAfvoeDcmKMYaiTwhWZ2CM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120160
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

On 8/12/2026 12:47 PM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
> (Add Akihiko to Cc)
> 
>> On 8/12/2026 8:57 AM, Pierrick Bouvier wrote:
>>> On 8/12/2026 7:27 AM, Alex Bennée wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>
>>>>> tests/tcg/mips/user/ has extra tests that are not currently run at the
>>>>> moment. Keep their Makefiles until they are implemented.
>>>>>
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>> <snip>
>>>>> -else
>>>>> -# For system targets we include a different Makefile fragment as the
>>>>> -# build options for bare programs are usually pretty different. They
>>>>> -# are expected to provide their own build recipes.
>>>>> -EXTRA_CFLAGS += -ffreestanding -fno-stack-protector
>>>>> -
>>>>
>>>> Ahh here is where -ffreestanding came in. We should also check why
>>>> -fno-stack-protector was added.
>>>>
>>>
>>
>> https://gitlab.com/qemu-project/qemu/-/commit/580731dcc87eb27a2b0dc20ec331f1ce51864c97
>>
>> It seems like a specific setup on a specific machine will have specific
>> requirements. Not sure it should become the norm, but if you prefer, I
>> can just replicate the existing flags, and we can call it a day.
> 
> Was this a particular GCC build or the default for all GCC's post 13.2?
>

I have the impression it's the particular build he used. Else a distro
name would have been mentioned.

I still think it would make more sense to have this flag per test when
it's mandatory. Maybe we can just let people with custom compilers
discover where it's needed?
>>
>> Let me know what you'd prefer.
>>  Regards,
>> Pierrick
> 

