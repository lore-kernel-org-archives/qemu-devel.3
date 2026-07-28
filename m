Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A21BC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocfy-0008Sp-92; Tue, 28 Jul 2026 03:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wocfu-0008PG-AV
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:56:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wocfs-0003A8-Rd
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:56:30 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S6YuNS1824433
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UTxjOR+fv+plHsYMJe5iTAAVa8OLrtKrVfs3vM5de5Q=; b=HAML7OhvNYMyUry6
 qaAA5qJ3N5eUcW+P7pau6xKjoCXZt7sWiIypgcugHHPhE4RK+6/9O/tQ4sDYtTR6
 Am/H9YGSpndD8RTVRTf3hsZoyt+nWWX7LFnbqfgcvxYTJ+RY2Ot7/4xhDQRGrH1m
 71e+RAfBfrGEw35RiqA4gVWaE0HeYd8Ly325ASXYoNkDkUWwOsuimb+4ChHFUE0Z
 4SJXoV8DR8rcrkgGwuYWRifHmk4w4fKK0rdu/K6PHyBHJTsCnGSfzSbVsQGGEo7C
 pr9igdDL7PglBPlvTQbXKrK8w7oeIWe8Z1tbrUfL53Wo8R0HDLHxnxtM4I/uqb1G
 DzmIuA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpq9hgap7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:56:27 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84e048a801dso5210223b3a.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 00:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785225387; x=1785830187; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UTxjOR+fv+plHsYMJe5iTAAVa8OLrtKrVfs3vM5de5Q=;
 b=eut0gfRVaRi9qZUroDrCAF9nu/eYb+EdnWso+jEz2gm0k7lKoqeRHkQVL2Og4S1vBh
 kaOI8/hLt7Y/lRVpPWKiUJCKjpc9vrb+M1RDbhTTm3rSJy24P1vPUe+u/6RVsIbp/gL9
 JPQWD1mayO/kB6rmGxJILnlLSuvNpNN38DiQAVcrCxpT7ifLU40MPGViUOzaymLe+rpD
 EcYRu8tOm2E3q6FZddPNtdLlXaQzRVH19lUz1tSi5L3dJplay2AboP5lJV5Shh/Kp05K
 QM3Ow4AEZTRVKNeH+DlkO4k0xB/8/aI5ap+eExJbZ5x75CSHfhlJJHnDG9ILjehj7m/a
 u44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785225387; x=1785830187;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UTxjOR+fv+plHsYMJe5iTAAVa8OLrtKrVfs3vM5de5Q=;
 b=LQdczErmwh5pNw2TnA2BP8PTFJDaIKWfJ1nvHNK4oPIvfc42bffh9mVc5LfKIN4d62
 TEHfx6lgpZJsVXRZju3KylYhpP4JktqQbybJK02ZKKVCPHoBVn0RoPxStnFmKKw0jmOp
 MhQjSwU7v/59XoLMVsqXVRimV783NyXsA3sbrU1gSf2QLwkjL/cTO/4kEkDL8GQoSXdY
 EjMqeOJWz6mBh4gACeFB9Odk1cxDQ+Mv2BY5go/2KSWnRWqADpMa9vainyXgNYSK6xZF
 0Xbnin124HHjq/cUt1DsTw+AkajKA7PrFC5soS1WVQCeqrzVIZ8pKUetX1lVVIBq8l8H
 ZP2A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqbb2hxiGrmjLN9azxhkIuSHGR4tttyXDuyUfbwxx0Nx+XftYGRDCgNfsyxG844gDvKBxqMYwzAA244@nongnu.org
X-Gm-Message-State: AOJu0YwST8vhUcbPjwXTU1/Hx9BD3+vQVz/FVuFiSh7iOjXpBWpTUace
 EanBHP9mgIblFKn6Ltim66Ce7cWi9hng4y8zOeDNpuYWbBOzjCP2whOGBAOVNcN98RMEnEc3Pbk
 CsrwzXiGCaKvmmFLdhSOOyi4840LXtu3qJh8uXvKVVhx1tuguasr1F40F/A==
X-Gm-Gg: AR+sD121uPyQ5Bb2ibjkG3q8ljWgXHdE0as0K6fqHuDN61awinE7HQy1Q/4yo+wT4rF
 IOSl0burKu1BWP1CYR6pMO3PetlayQYRabVasfgqrdD1MZOeorXOs27i3JT+81b+IdfNp+7TRT9
 qJeJH5ExdTmdDrCmo5WrP+Z5X+hg3m32uSJx88D6XT2pHodtxmnImTpunIIZ0l8cynC2v9stBNs
 Rh6QLBXGRVPwQRZ968NC5sqnfzjsVErZGYaJpV+gpG9ayt8iwY+8LnC8Cwx2qbTg5NxW6AOcb/k
 RR1i5LghBArne7dI/p7rqItnFTN9EZbJRXqUMpABQjvyVo+DiTjd8d51P8WfkqGv9ukCoxrj9i0
 LZnlX4TYT7ezAtF06ryEXr65iqHfEmIW6+1z2TOsYgXK2X4S41tdW5PU=
X-Received: by 2002:a05:6a00:398a:b0:84a:6540:3389 with SMTP id
 d2e1a72fcca58-84e9329fc29mr1344265b3a.10.1785225386701; 
 Tue, 28 Jul 2026 00:56:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:398a:b0:84a:6540:3389 with SMTP id
 d2e1a72fcca58-84e9329fc29mr1344245b3a.10.1785225386297; 
 Tue, 28 Jul 2026 00:56:26 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53254f6dsm4147517b3a.10.2026.07.28.00.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 00:56:25 -0700 (PDT)
Message-ID: <e1227756-4df4-434d-85a6-bf4087c1107b@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 00:56:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 060/103] scripts/probe-gdb-support.py: add mapping for
 mips architecture
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-61-pierrick.bouvier@oss.qualcomm.com>
 <2c415665-f86c-4640-b681-b5ee929ea184@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <2c415665-f86c-4640-b681-b5ee929ea184@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2NyBTYWx0ZWRfX3Vcwtqb3Cfbj
 9yce5Vfx6j8iTeFY2jX5BdwXRKu9eZO5mBeS5pk0eFGA+UGhXRhWJY5bHoJMiYMii+wRHIGfiNp
 szFFY0n1jMcT4eld6Wp4IE95hBjtH/o=
X-Proofpoint-GUID: XkvzTEKRiYEQWUHrvzfQmOw3w2Tz4oEI
X-Proofpoint-ORIG-GUID: XkvzTEKRiYEQWUHrvzfQmOw3w2Tz4oEI
X-Authority-Analysis: v=2.4 cv=Aa6B2XXG c=1 sm=1 tr=0 ts=6a6860ab cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=aIGIePy2LSgg3c6h0PcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2NyBTYWx0ZWRfX8OQNBpjp5yY6
 My+Go3lapQX94vvG+wG/Q2TVQ5EaU4jxhqxDqXB2MjnaemQxRUFr3vAFDwy7LTOOnPkFSTgVr6v
 aArTtoGkionJsO5Q7cgSRm8iJvfSipBSOuT/iCEqFBOAtZbN9pZ4X22lqAIecF93qH0g/yBkYso
 VVZTWIUQm0IBjXICvUiUzTvxfGhu7uiwxJYBAXGEBE5vs2sR63I/299eIvhj6jwn3CrcrunB6UE
 wIWrEk6tuivDVsRyyC2/m/tmGG84ISrJYO3K18O6IHcTLIsm4SH1VGrDjAdIZfp+TBRT2L+jgyu
 8qKkGYtZloEFYdNh6SixMm1md16zQrMm8Luips7D+LjK2HOPED1lGfhW22Bs0rFc7dTPyUCXdtK
 KGn2/gOggP3y9+YVjBsWGGymwJew6tfuGp+QT4gXLWRDGNsSVlFcqDP/e2jGV8kCte1dAsM6NN2
 xbUIO/ekB8PXn1fgIfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280067
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

On 7/28/26 12:39 AM, Philippe Mathieu-Daudé wrote:
> On 28/7/26 06:42, Pierrick Bouvier wrote:
>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>    scripts/probe-gdb-support.py | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/scripts/probe-gdb-support.py b/scripts/probe-gdb-support.py
>> index 43c70302873..6e3b2579770 100644
>> --- a/scripts/probe-gdb-support.py
>> +++ b/scripts/probe-gdb-support.py
>> @@ -35,6 +35,7 @@
>>        "Loongarch64" : ["loongarch64"],
>>        "m68k" : ["m68k"],
>>        "MicroBlaze" : ["microblaze"],
>> +    "mips" : ["mips"],
> 
> IIUC we want (for still few releases):
> 
>          "mips" : ["mips", "mipsel"],
> 
>>        "mips:isa64" : ["mips64", "mips64el"],
>>        "or1k" : ["or1k"],
>>        "powerpc:common" : ["ppc"],
> 

I can add it, thanks.

