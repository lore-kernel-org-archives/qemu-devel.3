Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57E0C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAAX-0008B8-Tq; Tue, 07 Jul 2026 14:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whAAV-0008Ag-DQ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:05:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whAAT-0004d1-Er
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:05:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FT4Pl4130338
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 al+dUcCdN/9pRElMkzGDTIwh7T2vneJbRkVVsCOaB70=; b=ejmL6Jibre1Flhdr
 5Pz6vQcp7sRj41feEUoNCvxr0LHyaLvXRtn5zs3QDhsyWaZFc6fl8F+v7vLloivD
 qNbAMGRcBiPcuCG5cNjP7r6UYcqJomz+CY8K4iKgETWHAxYNVhvjuoDu74vggmTv
 EjwffSV70EXktOeenwQwMrCOAxwyhD6uIlMsDJRh7ysoFrxJoNObknRYL+kZngTU
 qcvC5U4BVFeRk7rcbYSiOTzIpvXUYv6BmymFpeG5bVLMkhHr0d+H3wn+EEpGMIts
 bBS2dnXoRhNcTL/oSFxOzSewyL0DvLcVYE6cSbEoeKm8Pvkh4vCklL/RHnOsUBYQ
 Hsip3g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t15bfs9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:05:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-381ed6616f7so6787070a91.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783447510; x=1784052310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=al+dUcCdN/9pRElMkzGDTIwh7T2vneJbRkVVsCOaB70=;
 b=MH+MeFG6JgdkZoKD/W+oe5DcNUYNbAWfCTeblXgqK1B+Srd5SvJYGtzYM0/8YGRqxK
 c8V53uaRZVGnfLtdd7z6ptpVfK3NH/MoKV8mchf5uQUDvD3W4x5ttX05Y+tQDdi46q+L
 85lYczCWrtJ/1WLfX2mIPKPD9M9JwYjFshG9NHszK3SYLMBjH9q/0rU4QKrd3rACScRQ
 0fwDI3QIJkK2bAg7daFLpsf9bdM9sP+jvEs4W04r0OUagboySs1In/VnA6sIFWcauIuk
 ORFSkdPmKEpoaiJRbtq8HOS72BS8LofnNhzDWBuv0j/twfDCJZulNjJvb1cwMCECSdiY
 on3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783447510; x=1784052310;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=al+dUcCdN/9pRElMkzGDTIwh7T2vneJbRkVVsCOaB70=;
 b=Plm/9HFLpsDrZeVBTaQUA2khiIhViqGiSbmq2QKm6a3YVG67OOWviYWgzHdgcfMwXZ
 9ODiLlVq2HcpeY7HoQLefzZAiSZs5AERRszCInTgrfGXTM6smU4+m/wbjtgtB/sxQAR3
 ynjMvBgRVv1bKGX3te2RfU9eqjQh1Q2yu0xxpWHbXoIgQcWiyn5vxy6YAgKU8W+PXcqh
 7a7jWmkaJ7VPXt/PYAFqdIYQxC2CCL5cpDqueJBPYZ9L5PxWkLgPj8CqryULSm9fOR8c
 UXKf/hiCQTc672iHYGu87MnHUmIMKkNPjbd2li6lhe0lHvWuNxrtniirqbURJa29Hr0n
 qE7A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpvoxcTWcYExzBS8wL78vCJfOMWAf0UlBaEil7j5D1BCeVm98SXu/KDSFUzQ4PXZNbiGUOlZ5Ljhlol@nongnu.org
X-Gm-Message-State: AOJu0YyPyZcCnjmEHkKJNklmkLdHLkCiqmnmRIOFyXVCbiLNgR1Vn1QB
 ryjPhDeGeYJLyasfJEBIGOlNZtu5uJtv0rJYcgrvI0q0ULY2OrGXzanuQNaEKjWmM9V4JgAxCWH
 sJEg21bvGj11vy2paDnVighnS4ST4iOPFileYKtzZ2z1lZSXgOwLIOUdXzg==
X-Gm-Gg: AfdE7cnROJtqic1iOHJyQEdZGkHdyQ2XatS3+/hv5yKICF9CGwPd8YZL+eJCZB8R72m
 72Lyp5/q5nCHaX3kpsaPXGwd085A8yJqVw3h6incTjZv+Y/2es8fUXcx81ddDNODxK0YeV3avK2
 v0j+ex5SmImSS/IiIzaAUHm3P9O9cZKzzoJJ8wdHrWWFv/gPCQ9QXg61Ptz79/Y/WXdynU8MyXt
 2f52YESBAWmJ95AEY2vFfZ2nz3Zi7PNKN80W+HyWoj27a1mHjHT4kJNeOLCB31LxdbQr+edBRNY
 DwqlqY61JfPAVtOtZA6rcSf+A+7xY7/iGBesaeYoN1qmzhJ4D8d/1rK9roe8T9hvGDdrnJkTd7w
 M9HlXHS1rEdWepNpDfJjig+/W5TrAl+0mty3YqH1r0jgwxImTdXUnUHIM33ByHGtaNtgx2VQAUF
 0Sd4Y=
X-Received: by 2002:a17:90b:3912:b0:384:5dbc:cba5 with SMTP id
 98e67ed59e1d1-38757b81e11mr5974067a91.26.1783447509542; 
 Tue, 07 Jul 2026 11:05:09 -0700 (PDT)
X-Received: by 2002:a17:90b:3912:b0:384:5dbc:cba5 with SMTP id
 98e67ed59e1d1-38757b81e11mr5974020a91.26.1783447508960; 
 Tue, 07 Jul 2026 11:05:08 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a8bc08sm14161067eec.24.2026.07.07.11.05.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 11:05:08 -0700 (PDT)
Message-ID: <fd9ee9cb-10df-4474-929d-3d525b23aafa@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:05:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/91] tests/tcg/meson.build: introduce cc_dockerfile
 and cc_docker_arch
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-29-pierrick.bouvier@oss.qualcomm.com>
 <1275323c-ccee-4ccf-9ce9-3f18bb20e407@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1275323c-ccee-4ccf-9ce9-3f18bb20e407@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HxnKXrgSLovNUTZNIwx6to8h377hLVKC
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4d3fd6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=5Bv--Yq83ko-hCrwR7EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: HxnKXrgSLovNUTZNIwx6to8h377hLVKC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3NyBTYWx0ZWRfX92zEWyD9Nmvs
 6FDHuqHnBqnnSMbybqxZyPgN2v//MGdUjp4nEO0YFulVfnDys90ckIc3vXdvSiUG3aSDIs45Z+0
 F6UGHQv98tpOv3jm2P2bVWvc1AMpJYw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3NyBTYWx0ZWRfX+J7PGhPCtWmj
 TsKBubedtJsZmgDcOil0pKPxtgo0jNIITn/FSDMI/ksEryKxz3NweCYSapvmZRin85KUNEpLzSr
 NinuWQJMlG6oYY5s8htul614zxjQFQcwuNdHRgLAcz1W6isBoGaMAQhwof8y1vl27g8mscQJWxJ
 mvL0lc9HwJSkMxgu4IaeUlCsKQiFiWCKC+c385iKRwzj+Jh1NAUSVWDog4QhhBf3VyeWNo0us8O
 j/A8td3BJC/e9/6XXo8Sd5XV9DO3DF4C5gq24wcgwhUGrzTTTkmc8Z1tdFHS2YVvepCnkQz1TuO
 LAbGlv0pbWD+BjgoA9b9JQxjENf4lwOTIn/XSyFPkIhmRfTpHvwvcNxETyHkU2Os3+MWwayvzUV
 t43aQaBCwtcOcYNkd8rUb2f922mgtjareMAxd0E6TTVIxh1OBPk8IE2HbhJ16DrpL9AHw6yPe5O
 CCEjKIUQ8+NucIaCGjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070177
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

On 7/6/2026 11:15 PM, Philippe Mathieu-Daudé wrote:
> Hi Pierrick,
> 
> On 7/7/26 00:32, Pierrick Bouvier wrote:
>> We allow target to declare a dockerfile containing required cc. We reuse
>> tests/docker/docker.py, and correctly set dependencies for tests on
>> original dockerfile.
>>
>> We specify list of hosts for which image can be built and contains
>> required cc, using cc_docker_arch.
>>
>> In case we rely on docker, we do not build tests by default anymore.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   tests/tcg/meson.build | 61 ++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 57 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>> index 0d2fefe8f51..57e7c3f8801 100644
>> --- a/tests/tcg/meson.build
>> +++ b/tests/tcg/meson.build
>> @@ -1,6 +1,7 @@
>>   cc_check_args = ['-xc', '/dev/null', '-o', '/dev/null', '-c']
>>   env = find_program('env')
>>   +docker_wrapper = find_program('../docker/docker.py')
>>   gdb_progs = ['gdb-multiarch', 'gdb']
>>   if config_host.has_key('GDB')
>>     gdb_progs = [config_host['GDB'], gdb_progs]
>> @@ -21,6 +22,8 @@ tcg_tests = {}
>>   # {
>>   #   'name_of_target': {
>>   #     'cc': 'cross_compiler',
>> +#     'cc_dockerfile': 'name_of_dockerfile',
>> +#     'cc_docker_arch': ['host_arch_supported (meson cpu)', ...],
> 
> This variable confuses me while reviewing the other patches in this
> series. What about naming explicitly as 'cc_docker_host_arch'?
>

Good for me if it helps!

Regards,
Pierrick

