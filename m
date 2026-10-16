Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBD7CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 17:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHlMv-0001in-Tb; Fri, 16 Oct 2026 13:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHlMt-0001iN-UQ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 13:05:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHlMq-0006ek-Hz
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 13:05:19 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5i0d1910949
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 17:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9/+/5B99LVZods7wXwBR/VwDMp6mCTH8e6O/1mnbAfA=; b=CY4Q7JeT/04o6gb6
 GH8Zdhx7/ROJFepgvuzPUCjy1s7AixxsTZO9NgzgxcKMxpS4uDkI1wclwjI7Gc3Q
 hJ51USrW34bbvHSueAQvhvsS0BL6VH7C7ogURZBzM1AhobQ77QX2fESfnjlmwl/X
 KlBZmy6QfN5tdvZpMEbokF0nUnI04NCbyGQH+Llb3s6sRy3SrcpaKxMa8HQa/Voy
 GWl6ZltGavA+wSwG+IM87HHukqx/QPPRXcATs4rJJRVAXcT+LTJO7Nm2vsBnxCwm
 P5NDBmImKwI8hMZ4XYV8ohl1FTNzePxGzLciDgpn7YpPobJhYefWK5O8pb31ErZW
 nDUrYQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbjmf9d3w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 17:05:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5363b06bcb2so2566571cf.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 10:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792170311; x=1792775111; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9/+/5B99LVZods7wXwBR/VwDMp6mCTH8e6O/1mnbAfA=;
 b=GEaAp4JFUo/x1OVczJiZ9gVbHEFE7DjJdmx8rV3YLqMv7YacCZf6FDfAYdpYSOxgYN
 8OS/y0N5l46HbHamGt6S2xa+4C1SHj0BIRxSm9t4drmnd8p7AddhWKLzuQStckpiJLsy
 mXK4i+XsWe/vM/x+QIUzAu8KvljqXX1KsgDRCIEGB6T5DcX0zluuwjvzKZKxB4hazG1m
 Cr+TcJkNap2U5yIKH00qpQvm8rXlv3/cy4Qe7oWcyk2ocibfS1immJxSqft8C/2p7Zjq
 PVd/tAMe427Vvvujech7ZofMYdm4Q1CdAJ8z/AyBg2xNnKD9mcsX25zBto/207s5GX99
 36tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792170311; x=1792775111;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9/+/5B99LVZods7wXwBR/VwDMp6mCTH8e6O/1mnbAfA=;
 b=F0za75koMIDwEZieJwfyuxyD1388fP6uZfWK7PbplEHfDU5COKO7dRnn/6ATzYMmpa
 a3mV/uP6PCfDoLKlaen6JEV9zLhf5YApiJiXyrNIvnWVCZIPNSCwXkO578sN4Z9WCrxP
 ErCt/GYcUoUTRmrTXIcFVesUmuKcciTd4OVQXRGKpgrwrlDizWkHXf7nsIvmhcaGxAMZ
 5IRVLWvHW7uURF7CpoJVZ5EM5nu8oXPPMBOgRyVZbirxnUgb1U19raBMqOQQdZ88YveR
 bkfJpXFUOnGIancrq/z8J2dlEmXv1bj/c5dRLbbnRfwkkuN9j6KdgaSSfXXZOGrfBTVo
 Sz4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQ/p1xBK9DLc9fvGb6CM97jY5EK8TzIsHPwwTYbyxwzchhur0CrkPPjgpsRQux+rbQEaxKeYi1sdgp@nongnu.org
X-Gm-Message-State: AFq9FYKU9rUXDFCIeeDj8ybtrPssOBgYdplNfUv3av43rNiP3E0Z7iL1
 kpP9MXEWgdl1Yrz+/vSgDlEhWm1Vmx+dhD/xD73gOWbTOx7xLJVPOWJAn1Y2VIclbdsKS2EEo14
 ExuVBTym6YFY3pMiyEfOgmJnT4Q7FT+XxwMQT3H5Il8Tf/9+4HMRAtZi0Ig==
X-Gm-Gg: AYBFou1xk/h7GxWXXLWluaJCRgvNNpjHvEbwYZWw00GE9wXThxGksAECygIcMH7OQXU
 iEp46Iv7CCgwvHltvy9yJBbeUs6NVCKwxv7kpWT3A8Rfs2N7Mf+piaWrEefAdDlz4oSRDxJW5YI
 N8YhfW5nW67fiDAPgm0xTfkYR+iallShRyVJMdvAeUqGUAA6dZQtTTJrGgvLA/C63hOoRmisO5Q
 K89D0b8iJJQUzlPkXg4g6Ow7qsX8+Y07xogozf2gcQE+ZjPUeV7mh1pbF9w76ez2Y0NyKAo1mOT
 bLgMj57QloqH0aDuFZacoIuYeCzxrPQb9U3AGRAisGi/sPvouLy4Cqwuw/IPBgGwFFEqqV4TFyM
 r8HF8sdMnvXSaSCU20E8s7iFt5GREEeSdGmjEkT/Zqmj/HsuPhOtoRP9va5c/3rc6
X-Received: by 2002:a05:622a:4cc8:b0:536:41de:9c9a with SMTP id
 d75a77b69052e-53646022963mr754481cf.62.1792170310898; 
 Fri, 16 Oct 2026 10:05:10 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc8:b0:536:41de:9c9a with SMTP id
 d75a77b69052e-53646022963mr753691cf.62.1792170310202; 
 Fri, 16 Oct 2026 10:05:10 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91bcbab3716sm27409306d6.22.2026.10.16.10.05.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 10:05:09 -0700 (PDT)
Message-ID: <1c6f9535-a29e-4470-8456-549ac6281b50@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 12:05:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] tests/tcg/hexagon: add v85 scalar tests
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-13-brian.cain@oss.qualcomm.com>
 <14457301-e847-4d71-b4cc-3405e29b744d@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <14457301-e847-4d71-b4cc-3405e29b744d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1VpuOXowZ1CmevfPqixJ1JcMV-a0qlkH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2OCBTYWx0ZWRfX6/X5m83OQyvF
 gS9c7rxhIep7KhR476wfmG8OOA0n9IUrqMJOvLoIJBIqTFdl6bHuBpIqLPpIbSZ37K+GbOAkR+o
 VSQ39/LE2FA3qDUXBdDiYC9nk3SSikE=
X-Authority-Analysis: v=2.4 cv=SrAFe/O0 c=1 sm=1 tr=0 ts=6ad25948 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=2EszZil2-8S7u7c10B4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 1VpuOXowZ1CmevfPqixJ1JcMV-a0qlkH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2OCBTYWx0ZWRfX7HjFFOTofKcI
 h2NnhAVQDG05HqHdT2azfaI5aocvOqjok0KkQ9M9T9LXmkhPqbstakxQAUzKmlXabBV0xxARwR0
 NNI+V6HwMORM6YGqtB05dwb1SzFnSQJhzHawPHujmdtiz0qP0brqCgu/3MDKNJn1JFJTDJzGLqQ
 iMAXuXtoLCocmmVBjoNsX7VT/HsDsB0b2fQKYo+BOi8Kw+S2YW+dKyQkqihNzBERXriUKqn/Dip
 xAFenTMRK/7gj0WwDygZRiEBeaWsmt70dkNzDGz8y94nFb8GfApv4v2PpW6TVDi7ECpmWYj9Hlr
 4GljeZVjktqEc3hvzxs2k1gd0uxvEro1Y1RZ/pDAogXl7yRgTX2qeGNybPO9G7kzQRqATMhyIWC
 iWkh14E/NzBCQvzMikT26y8i7ayst0F2VAT1cztu1cIvDfCflYuaKQ77U6deWNbZs7aXk1TguPi
 ItEkyyot00lJAv5vM8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 10/14/2026 4:24 PM, Pierrick Bouvier wrote:
> On 10/14/2026 12:52 PM, Brian Cain wrote:
>> Add tests for: vallocframe, atomics, trap2, CFI/restricted branches, and
>> scalar fp instructions.
>>
>> New instructions not yet supported by the toolchain are manually encoded
>> with .word directives.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   tests/tcg/hexagon/cfi_tgts.h         |  16 +++
>>   tests/tcg/hexagon/atomics.c          | 102 +++++++++++++++++
>>   tests/tcg/hexagon/cfi_user.c         |  63 +++++++++++
>>   tests/tcg/hexagon/check_rev_gating.c |  10 ++
>>   tests/tcg/hexagon/invalid-encoding.c |  20 ++++
>>   tests/tcg/hexagon/trap2.c            |  34 ++++++
>>   tests/tcg/hexagon/v83_scalar_fp.c    |  98 +++++++++++++++++
>>   tests/tcg/hexagon/vallocframe.c      | 111 +++++++++++++++++++
>>   tests/tcg/hexagon/cfi_tgts.S         | 157 +++++++++++++++++++++++++++
>>   tests/tcg/hexagon/meson.build        |  19 +++-
>>   10 files changed, 628 insertions(+), 2 deletions(-)
>>   create mode 100644 tests/tcg/hexagon/cfi_tgts.h
>>   create mode 100644 tests/tcg/hexagon/cfi_user.c
>>   create mode 100644 tests/tcg/hexagon/trap2.c
>>   create mode 100644 tests/tcg/hexagon/v83_scalar_fp.c
>>   create mode 100644 tests/tcg/hexagon/vallocframe.c
>>   create mode 100644 tests/tcg/hexagon/cfi_tgts.S
>>
> ...
>
>> diff --git a/tests/tcg/hexagon/invalid-encoding.c b/tests/tcg/hexagon/invalid-encoding.c
>> index 639d7f24959..7c4dd244559 100644
>> --- a/tests/tcg/hexagon/invalid-encoding.c
>> +++ b/tests/tcg/hexagon/invalid-encoding.c
>> @@ -89,6 +89,25 @@ static int test_invalid_nonduplex(void)
>>       return sig;
>>   }
>>   
>> +/* L4_loadw_phys bit 7 was reserved beginning with v83. */
>> +static int test_v83_loadw_phys_reserved_bit(void)
>> +{
>> +    int sig;
>> +
>> +    asm volatile(
>> +        "r0 = #0\n"
>> +        "r1 = ##1f\n"
>> +        "memw(%1) = r1\n"
>> +        ".word 0x9200e080\n"
> Please add a comments saying which instruction this is encoding.
>
> ...
>>   
>>   tests += {
>> -  'atomics.c': {'cflags': cflags},
>> +  # The cross assembler does not know v85; v85 instructions in atomics.c
>> +  # are encoded with .word directives.
>> +  'atomics.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
>>     'brev.c': {'cflags': cflags},
>> +  # The cross assembler does not know v83; cfi_tgts.S uses raw encodings.
>> +  'cfi_user.c': {
>> +    'cflags': [cflags, '-O0', files('cfi_tgts.S')],
> -O0 is part of default flags for tcg tests, no need to set it here.
>
> ---

^^ will fix these in v2.

>
> Overall, looks good to me.
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>
> I guess we don't have yet a public toolchain available yet, but if there
> is one (even without source code available), it would be better,
> especially for cfi_tgts.S.


Yeah it's unfortunate - these instruction encodings haven't landed in 
upstream LLVM yet.  When it lands, we can replace these encodings with 
the real mnemonics.


> If there is a v85 toolchain available somewhere, feel free to update the
> hexagon dockerfile as part of this series.
>
> Regards,
> Pierrick

