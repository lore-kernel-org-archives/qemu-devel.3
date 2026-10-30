Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFC606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UG7I8Rw9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XrraFywv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqug-0004d1-Pb; Fri, 30 Oct 2026 14:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqtp-0003Ym-SZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:00:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqtn-00007d-Ka
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:00:21 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu57n2414431
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VqKVrt1VW7cN9MhYV8oKJuv+A1SsWLccXT+QZ0qtsfw=; b=UG7I8Rw9qKWpVj0T
 QbhUWakVkiGZfePggbQE+XIEGfzqJENTjyQG57reNKRao+WHZbmQVLJ6sAR43bSx
 PHyXRojIB3qs5frd+i+rlIovAH2X3rozQSayAPDt3B5S9+9XTziuGnd55fP8LLW9
 NQR8zwzhMiJmy0Ck/+PmcmuY4PAKjpYH9iMfjTcCrm3lmQe971zirmUtGSBMIClG
 v8pJ8O+FWVf4BUCU+yqG/bNg9cW5nrGD7HEhilFNhCQ8WHH+Zqu0MVA+Bdpixx1d
 9VE+jDrX4dLQ3t2ODsNWzbDMuDkqij92aL7XWJznfPy8ySIjTHl1fgMWMNpAfbo2
 +dnijw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pmbux-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:00:17 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9913f410ba2so224753241.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793383217; x=1793988017; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VqKVrt1VW7cN9MhYV8oKJuv+A1SsWLccXT+QZ0qtsfw=;
 b=XrraFywvIPjOocDPmsYXsZ2P7JovEoOfDj2pyWNKSma4mGvDOsdXMD9h7tAUQYDtkO
 AZp/c6tFGWqpBY21GdwXF+WKFkNVKBVHGocmm+qLlWhNwS08g7iPwilBYyeaot4NiwPQ
 ILqUDV0INdbJ3Kp9VdP9/HtiOxDRo0ncYS32pNNhOW3qpM2wBU/QArT87V6ekXMCtN6d
 buuhE6yC1ad0LiwD1zATq5ipKQqEz4MkmxxicFu7VX6sKmexO9OhGFHzHsaMYwcIuokf
 LJQ4hi3E3/7yHKq9+auwLTqoNDTEZa8HSd5sC97LgiRBqF/Kngv6u4uF47iq6mdsSY1W
 1ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383217; x=1793988017;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VqKVrt1VW7cN9MhYV8oKJuv+A1SsWLccXT+QZ0qtsfw=;
 b=u5LBlx8SDCAzBc2dy8CAQdTfMznpEYqttf+7DT5jDJbGnelPrMJd396OATHxYRZfGU
 rMe/xdZGczCzbQHbnKPlLdnILmaQE7VrcRJhLeZTpIfm5OWsHksy2+pSWuJnuBtMOvkJ
 PcTnitjlTdtZdprWFYTaqzSyBx2HJmSRvmAQhgHRZH+GXHBVatCqLUpBMbIzFPIww3Pn
 YymmgU8SUBYn8JsiWUqIO8LVex35nETAS28SoFiLImL02j7OS0Mo193g0psqyr5YXxWj
 O1qVDHDq02q9M45JVs8Uy96EdZU1H6IBbjDo9PVLiaS0Ur/qeNvpVvYMHR7/grtd2Ook
 P90g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3R3EDVmG1NVkx/2nFwawn2itpxA0bEUfEg9vMnDIOWbi0ggV9w6GsBDJBNGRbYQmPsR2xhiLkUMhb@nongnu.org
X-Gm-Message-State: AFq9FYIomsBwLqb4Ea9OV3EaSST3QWPM78CWwE2csgqPIoLRVktxWMXa
 Tars+r7KElJJoLKIgSsIpfMLZlEIZ9oQJpCb33re0iQI+rf7LA8T00pP+BiMb3kSsw2DHQ+oOn1
 tS4BNNO1ncl7DRioVWQvP9f9lYI43KdrLuxCwi351oIBdXfNwoeqqPHHzPQ==
X-Gm-Gg: AYBFou11i2GW6GgVsbP8jZVgHutlNi6+mDOnb4S61M6kF+N1LNXtUrQ3QNV3JuKd1C7
 Mj1W0jjQAIE9399H4Y9UMSfjxBJnaM562OaR56nUAiltRX/xvoAA9f5deIG7rwp+572u0sB8IYt
 xwxkQJnU0XsDu+XWs2tzQOyHN9Y1QLUVKF1Ab+/hz8G5MHnEPiYdnF1Do4nPij/erqxrwvlNLf7
 b5pjHHTbOl016TyM478Lx+7rg+6fu4O5rM8vCDpVUg0R0VEvAVxWSI7yQZrOyHI7GtNlWQ+M8Bs
 AgTNuInhq/PN+NDhKItJyqJrMGCPnm4wQhb/I7sRxTtQhUNwQu4Xm2H7mzcHjj0mlBvAMzGN54u
 aJQMbT2QqAsYQx18zq5txrlij2t+d4yFOQb9fxCbTbsWZmk56YSxWZLIXaF91hRZErNJIfYD83w
 cct70FEjHMt2yVRSl0tZHoif0=
X-Received: by 2002:a05:6102:c13:b0:7ce:a69d:b020 with SMTP id
 ada2fe7eead31-7d072232e7dmr1483776137.5.1793383216844; 
 Fri, 30 Oct 2026 11:00:16 -0700 (PDT)
X-Received: by 2002:a05:6102:c13:b0:7ce:a69d:b020 with SMTP id
 ada2fe7eead31-7d072232e7dmr1483758137.5.1793383216314; 
 Fri, 30 Oct 2026 11:00:16 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b789ecsm4377781f8f.29.2026.10.30.11.00.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 11:00:10 -0700 (PDT)
Message-ID: <9eba935f-f700-441c-82c4-9f20aca3f99d@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 19:00:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] meson: Add the tcg_tests_cross_cc/cflags options
 for mips32r6el
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
 <20261029174434.27985-3-philmd@oss.qualcomm.com>
 <54734d4b-6b6f-45f2-a371-0abd2487afe5@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <54734d4b-6b6f-45f2-a371-0abd2487afe5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX4bZMGHwOmUCS
 6i4MSgQndyI5PWrQSPu3ony/GoGx+Ut1BI4S2FUS1VQIHVRh8qObd5BT9XPtWs48IChSPdD9v6t
 NhvN7RIZWXzkHEJgYHScRlUNIk4Fv6m5EpfNoX8cWsdrKmGb3cjER7KeHqrVJMSlIlCL8WuoLjt
 uYycVixee3rLHcf18KGVuA965hFpKcQ0kymxAcMTGUlGCD4ygenDpyV/QjEFl7mSQaNVybAt1iW
 +ckNPaxWrPzpE/tUhQhM5+oohlbI2FMe1cL7XiLngYPMeuCCFsmTWLc0/I/r9L8Ou4hhQyUL3XL
 8pXyY9oS1hHq8jvl6+zVfVGg42my+pAE1CMrn3WJmfnZJffgKGF1hRqSMonSOLcaJCYZ1MB8xOY
 Bf91LKNnnS/NboRD68v5dTH9DZrPruA3bunDPMz9EjVVmA7LtVKvIy/akGvI73SGvjSssQkQsZf
 8rdNC1PcbtGTq2geEvA==
X-Proofpoint-ORIG-GUID: yBQxUCFN44kFgc_Gjw2HPbQeMzo1Myv0
X-Proofpoint-GUID: yBQxUCFN44kFgc_Gjw2HPbQeMzo1Myv0
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae4db31 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=X2I21nbLxxgl6mdgj4sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXyFyI2Cit46xY
 TxWhpGjPy04RlEMkVMsc33TvDz/tRLMrYRLFND0C9sVweJwx2BjysJRiASeRN/SuApsCo2N+Oh/
 ++CFFbogUrSeoJcAX3PsKrAxnQadeQ8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300071
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

On 29/10/26 20:25, Pierrick Bouvier wrote:
> On 10/29/2026 9:44 AM, Philippe Mathieu-Daudé wrote:
>> Add meson tcg_tests_cross_cc/cflags options for mips32r6el,
>> similarly of the previous mips32r5el commit c7b1a7bc9d33
>> ("tests/tcg/mipsel/mips32r5el: add msa tests"). This allows
>> compiling TCG tests for the mips32r6el-linux-user targets.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   meson_options.txt             | 4 ++++
>>   scripts/meson-buildoptions.sh | 2 ++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/meson_options.txt b/meson_options.txt
>> index 895c6e63c28a..9ae8e44ab54e 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -461,6 +461,10 @@ option('tcg_tests_cross_cc_mips32r5el', type: 'string',
>>          description: 'cc for mips32r5el tcg tests')
>>   option('tcg_tests_cross_cflags_mips32r5el', type: 'string',
>>          description: 'cflags for mips32r5el tcg tests')
>> +option('tcg_tests_cross_cc_mips32r6el', type: 'string',
>> +       description: 'cc for mips32r6el tcg tests')
>> +option('tcg_tests_cross_cflags_mips32r6el', type: 'string',
>> +       description: 'cflags for mips32r6el tcg tests')
>>   option('tcg_tests_cross_cc_or1k', type: 'string',
>>          description: 'cc for or1k tcg tests')
>>   option('tcg_tests_cross_cflags_or1k', type: 'string',
>> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
>> index 14990966d31d..0f8b56bd7f8c 100644
>> --- a/scripts/meson-buildoptions.sh
>> +++ b/scripts/meson-buildoptions.sh
>> @@ -539,6 +539,7 @@ _meson_option_parse() {
>>       --tcg-tests-cross-cc-m68k=*) quote_sh "-Dtcg_tests_cross_cc_m68k=$2" ;;
>>       --tcg-tests-cross-cc-mips=*) quote_sh "-Dtcg_tests_cross_cc_mips=$2" ;;
>>       --tcg-tests-cross-cc-mips32r5el=*) quote_sh "-Dtcg_tests_cross_cc_mips32r5el=$2" ;;
>> +    --tcg-tests-cross-cc-mips32r6el=*) quote_sh "-Dtcg_tests_cross_cc_mips32r6el=$2" ;;
>>       --tcg-tests-cross-cc-mips64=*) quote_sh "-Dtcg_tests_cross_cc_mips64=$2" ;;
>>       --tcg-tests-cross-cc-mips64el=*) quote_sh "-Dtcg_tests_cross_cc_mips64el=$2" ;;
>>       --tcg-tests-cross-cc-mips64r6=*) quote_sh "-Dtcg_tests_cross_cc_mips64r6=$2" ;;
>> @@ -566,6 +567,7 @@ _meson_option_parse() {
>>       --tcg-tests-cross-cflags-m68k=*) quote_sh "-Dtcg_tests_cross_cflags_m68k=$2" ;;
>>       --tcg-tests-cross-cflags-mips=*) quote_sh "-Dtcg_tests_cross_cflags_mips=$2" ;;
>>       --tcg-tests-cross-cflags-mips32r5el=*) quote_sh "-Dtcg_tests_cross_cflags_mips32r5el=$2" ;;
>> +    --tcg-tests-cross-cflags-mips32r6el=*) quote_sh "-Dtcg_tests_cross_cflags_mips32r6el=$2" ;;
>>       --tcg-tests-cross-cflags-mips64=*) quote_sh "-Dtcg_tests_cross_cflags_mips64=$2" ;;
>>       --tcg-tests-cross-cflags-mips64el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64el=$2" ;;
>>       --tcg-tests-cross-cflags-mips64r6=*) quote_sh "-Dtcg_tests_cross_cflags_mips64r6=$2" ;;
> 
> Need to update also scripts/meson-buildoptions.sh.
> make or make check-tcg should update it for you.

I don't understand what is requested here.

I ran that on both macOS and Linux, no change in 
scripts/meson-buildoptions.sh,
could these cross-flags be filtered? What do you want me to add?
> 
> It's a pain, I know, and TLDR: it's a chicken-egg problem between
> configure and meson.
> 
> Regards,
> Pierrick


