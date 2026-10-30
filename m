Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070B606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pGU3I1nT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jwKrMfAb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrGp-0003st-3e; Fri, 30 Oct 2026 14:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMrGn-0003sU-Q8
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:24:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMrGm-00024B-0h
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:24:05 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu2Hq4011229
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VFhzquaFoGCaGWh5YibZKrheSsitEP7fgYUCT44kQq4=; b=pGU3I1nTQRLmh0Rv
 7ZdPqs2jTOx7xiUwdmh+eH3Xa3baB0n6ZVwoBVAdAfqAlhwZi9fsW+0aNgCqOi2M
 WAfkDkJddnyQRNOmNuM5x86kGu1HIVOvtDoM2uRtiUMTUH4aEGpJ4ZdQnqDQGKGa
 L3dTdmoBf27QVy+rY66N5hrEqy1s8ipwu5WipFVZgzfe8x3i3xGTkB/5GxNQjq/x
 qSN4+bdoR4xErSJw+PhmUmGNO8T72o8XfUyfNKih21003JudoXg61IpPrGoLYOa+
 NvQxwS4hrN1s9BjYVJH4CuRRxZVXxgo6tbiEADyN0DxHd51Zwy5iH2rgnutEvP/H
 1tBlng==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmbxj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:24:01 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-193b5eb133eso1145975c88.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793384641; x=1793989441; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VFhzquaFoGCaGWh5YibZKrheSsitEP7fgYUCT44kQq4=;
 b=jwKrMfAbH89E/nj7U3o7b++PXZufNvmY4t/CxSDL6jbUDagn6bOdbIIWJTQ8msYC50
 DcYQvr6MFQVnWphOb1pJUnVmSqrA+cC4Y29yKvAohUhFOCjxPQSpl9AOW2GEgePbGYTc
 zWuyfLSXfsZp4MRa8aPW16Dx5eK36YcQ1NZiftGVZOnb2EWVzMj1YgALuiIE8l6yYESd
 nfcMbRIz+rm8hnfVv5fLVgb5nTLl2f+jKHiFlYcSOWX2Oc2TIOEkUhUPWk69tJyci44w
 VuXkjUVIfbEL97iLSozW/X8n6Zky7s9hEfgpR0tG5mzOdKjocsHMGBWVj6i8zOUbk6sS
 v4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384641; x=1793989441;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VFhzquaFoGCaGWh5YibZKrheSsitEP7fgYUCT44kQq4=;
 b=Y3/P6uUhS+2qWLpuB35S28T6CTcWtuZwkUJHwzxL9ftAbpqNtRBy5ImqH8riItJwdR
 A11cs2MRSakRY3Ao+eLdYVfhozYddy5wL7rCCPeeAakOnzowZ0sIrSFR0I6XplNRhUZI
 8EsXuQkUDrO5Ykrj+rsnnpzhrh3WFq1HCPj/vevYxiLv+EILaKNTREFNRYp8EoGGfMOE
 ulyyolr6kdhd3yZ3JA7eI7ew8jmEMp3coQlGWTMBFuZlWiWWAmyn7TcsF4tM09nn4ZHB
 0fsN2r9Zoh0SVjoc6wKKOwqVJpA/XBnkZbA/ujXhaBmM1Y9t2wrqtpA2SNP20Z0ECrKP
 +/iQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxl5m6+LSOh2KvxK+nIrgXSRxjWI8SPuEyWgQdl4VfOf8GPg9lkVUUv7k11mAXJRGB/P4Zp59nMl7CL@nongnu.org
X-Gm-Message-State: AFq9FYLtmvVitLYNkp96xeQ5KvP77hcNnxVHLVbmQEivSzukfUTD7pDL
 4iSuyji5EMK1rZvq3AkuFieUWmWyIGOnkcG5rFaQgzF7+Yan9Qqm/iInTaZfijekUhh4plIOQNg
 Rg4arjPvBMW9loK9Yt9vyD2jnOh/3GLho+sEcdCKhoSopkFQmcQbv+F5xYg==
X-Gm-Gg: AYBFou3qsUDXf6zmbDMzbLoiWgTZBRjoRo8liVIR1ytXq31VAGH2+qH/1V1HT9sAAvx
 H+LJBScKHNurAFwrDGUhIarYbtATgF56pCkqe6E871GTAEhbcNRxKOAej8lQYdCl03VRQQ7LQAG
 KJtaCx28TQXWyzBYi8f2ADpxYXayvF9HrSyn+YCn+KRhweH8h2c7G0IGnxP1XJ+ZpyuG/J1dyuJ
 hhvh32nRhKG85AIvADrARmxy+mvwNfJLh3eW5YZ0goSUxxi8QsEk7KwhAPxMbotsHbI8QLgdRke
 pyRrEDLjLrp6XzWUhIc9joA4MlZkCoKD/FyrD/QhoAcNNEMbk5CWOvplLqoxspfzyZKovcXJV8i
 yi1xbVmFo7Kq3o5hPCiYq9wadalpv9t/5D6e68+DSxUdO1axHye8pYHQpK5a8UC//iNEdJup06l
 KvmdlIweUWMiwIsALTWlspEazVauD+9sEJr1k6OzjM8KI=
X-Received: by 2002:a05:7022:b887:b0:143:2719:f800 with SMTP id
 a92af1059eb24-1ac5f742576mr3735011c88.40.1793384640905; 
 Fri, 30 Oct 2026 11:24:00 -0700 (PDT)
X-Received: by 2002:a05:7022:b887:b0:143:2719:f800 with SMTP id
 a92af1059eb24-1ac5f742576mr3734969c88.40.1793384640172; 
 Fri, 30 Oct 2026 11:24:00 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a4294419dsm8912458eec.18.2026.10.30.11.23.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 11:23:59 -0700 (PDT)
Message-ID: <51df8990-eab2-4d37-a63a-3fce70b57d93@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 10:23:58 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] meson: Add the tcg_tests_cross_cc/cflags options
 for mips32r6el
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
 <20261029174434.27985-3-philmd@oss.qualcomm.com>
 <54734d4b-6b6f-45f2-a371-0abd2487afe5@oss.qualcomm.com>
 <9eba935f-f700-441c-82c4-9f20aca3f99d@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9eba935f-f700-441c-82c4-9f20aca3f99d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LmEyyVyvZpSPs6qmz2-na31PTz1v_prB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfXwEDEl0R72GaZ
 ivo7KgFU+gWOQHxxMgZM4M05fI26JyZKFTpbbfgdQ0T3SZLHqgQdnU12mwwymTwV2KIw13vp9L1
 5YcJa7fSNKNWraw9ssPvPOExprmmefk=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae4e0c2 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=8lf-ybJ4Dmieux0006wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: LmEyyVyvZpSPs6qmz2-na31PTz1v_prB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfXwcLkPP16WjhI
 IYlYwgU0vcf2ydI2PRpSomoxDA9f+1oBoKz9T9y8lTHN8VT6uTAT3mBT3iwH2UetVfGIhYGvUUX
 Tu5kb4rg49zHgRlgxY8FfjqD4dJbGQrOXbfueWdIAv/zk2wyf6IGPYDqO9hio3TYR+oswG1gc+K
 JSc/e3JrzYD2fXlScTJXKRv4MQ5zzo6Zo06hMWvGTDnEQPcNwQbbADn1ZUHPAvTXXoh/o6/kqDR
 vT3561MrKHr3ljYVd6rguZTpWHJuscV6FSniaYzaO40hMDHrPFuOLu6PiNBIenarf1G4aCSpCHZ
 OtpuFEURXkyWL5ZRvqXrJsXD0CEgw10Nb2amoL4v15NSrBJ2vv+Z3y4nfILu887/OGigwuSdqGC
 E8efmzhTXUQnnEf07hBaZY8dxJno6H4s+uEXZYfp1wbbv5M2xCnmDTOUsTj5Wgh8zJ3J7MNYBRM
 IcMD3IulNM1mHahRAJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300073
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

On 10/30/2026 10:00 AM, Philippe Mathieu-Daudé wrote:
> On 29/10/26 20:25, Pierrick Bouvier wrote:
>> On 10/29/2026 9:44 AM, Philippe Mathieu-Daudé wrote:
>>> Add meson tcg_tests_cross_cc/cflags options for mips32r6el,
>>> similarly of the previous mips32r5el commit c7b1a7bc9d33
>>> ("tests/tcg/mipsel/mips32r5el: add msa tests"). This allows
>>> compiling TCG tests for the mips32r6el-linux-user targets.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>> ---
>>>   meson_options.txt             | 4 ++++
>>>   scripts/meson-buildoptions.sh | 2 ++
>>>   2 files changed, 6 insertions(+)
>>>
>>> diff --git a/meson_options.txt b/meson_options.txt
>>> index 895c6e63c28a..9ae8e44ab54e 100644
>>> --- a/meson_options.txt
>>> +++ b/meson_options.txt
>>> @@ -461,6 +461,10 @@ option('tcg_tests_cross_cc_mips32r5el', type:
>>> 'string',
>>>          description: 'cc for mips32r5el tcg tests')
>>>   option('tcg_tests_cross_cflags_mips32r5el', type: 'string',
>>>          description: 'cflags for mips32r5el tcg tests')
>>> +option('tcg_tests_cross_cc_mips32r6el', type: 'string',
>>> +       description: 'cc for mips32r6el tcg tests')
>>> +option('tcg_tests_cross_cflags_mips32r6el', type: 'string',
>>> +       description: 'cflags for mips32r6el tcg tests')
>>>   option('tcg_tests_cross_cc_or1k', type: 'string',
>>>          description: 'cc for or1k tcg tests')
>>>   option('tcg_tests_cross_cflags_or1k', type: 'string',
>>> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-
>>> buildoptions.sh
>>> index 14990966d31d..0f8b56bd7f8c 100644
>>> --- a/scripts/meson-buildoptions.sh
>>> +++ b/scripts/meson-buildoptions.sh
>>> @@ -539,6 +539,7 @@ _meson_option_parse() {
>>>       --tcg-tests-cross-cc-m68k=*) quote_sh "-
>>> Dtcg_tests_cross_cc_m68k=$2" ;;
>>>       --tcg-tests-cross-cc-mips=*) quote_sh "-
>>> Dtcg_tests_cross_cc_mips=$2" ;;
>>>       --tcg-tests-cross-cc-mips32r5el=*) quote_sh "-
>>> Dtcg_tests_cross_cc_mips32r5el=$2" ;;
>>> +    --tcg-tests-cross-cc-mips32r6el=*) quote_sh "-
>>> Dtcg_tests_cross_cc_mips32r6el=$2" ;;
>>>       --tcg-tests-cross-cc-mips64=*) quote_sh "-
>>> Dtcg_tests_cross_cc_mips64=$2" ;;
>>>       --tcg-tests-cross-cc-mips64el=*) quote_sh "-
>>> Dtcg_tests_cross_cc_mips64el=$2" ;;
>>>       --tcg-tests-cross-cc-mips64r6=*) quote_sh "-
>>> Dtcg_tests_cross_cc_mips64r6=$2" ;;
>>> @@ -566,6 +567,7 @@ _meson_option_parse() {
>>>       --tcg-tests-cross-cflags-m68k=*) quote_sh "-
>>> Dtcg_tests_cross_cflags_m68k=$2" ;;
>>>       --tcg-tests-cross-cflags-mips=*) quote_sh "-
>>> Dtcg_tests_cross_cflags_mips=$2" ;;
>>>       --tcg-tests-cross-cflags-mips32r5el=*) quote_sh "-
>>> Dtcg_tests_cross_cflags_mips32r5el=$2" ;;
>>> +    --tcg-tests-cross-cflags-mips32r6el=*) quote_sh "-
>>> Dtcg_tests_cross_cflags_mips32r6el=$2" ;;
>>>       --tcg-tests-cross-cflags-mips64=*) quote_sh "-
>>> Dtcg_tests_cross_cflags_mips64=$2" ;;
>>>       --tcg-tests-cross-cflags-mips64el=*) quote_sh "-
>>> Dtcg_tests_cross_cflags_mips64el=$2" ;;
>>>       --tcg-tests-cross-cflags-mips64r6=*) quote_sh "-
>>> Dtcg_tests_cross_cflags_mips64r6=$2" ;;
>>
>> Need to update also scripts/meson-buildoptions.sh.
>> make or make check-tcg should update it for you.
> 
> I don't understand what is requested here.
> 
> I ran that on both macOS and Linux, no change in scripts/meson-
> buildoptions.sh,
> could these cross-flags be filtered? What do you want me to add?

Please ignore my comment, I missed it was already updated in the patch.

>>
>> It's a pain, I know, and TLDR: it's a chicken-egg problem between
>> configure and meson.
>>
>> Regards,
>> Pierrick
> 


