Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90BCCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 09:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUNl-0002WV-Tt; Tue, 29 Sep 2026 05:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBUNa-0002Vd-55
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 05:44:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBUNV-0003iE-Jw
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 05:44:03 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7TrCD3220742
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P9V3RsMED0hvWSpQ2uazwF2dW0m8dHFCUB7lTNN1M6o=; b=VtBADglaIAAswLxi
 kTyVg+IOSwjmwfWTZearE/MSB++mUnJOpArdNiQoIODa+/LmejmETJHyrzz2xIRo
 G1rMpuJergHYhfylC6JB0Lg6Gc6StRqF5tDZ4YAI3Y806t1GBC4SQNR7i9W/uqKI
 716UrQ9j8yOfAPE8ZkzjTFcNUONXQhFAsVPOMIlqVLrXQeDURyWBOs90ONPGYfex
 EH8uV1LTfSnFEZcIBBaXYYcErEpL6rzdKLTlX7xguT6+0itNRGunndpk9mznTQNV
 tVwqREiewwRaHP8fSU/QJT+9EMjAGVz0j47j/RsOHJW51ElKbw0TLo4t0r60Lxcu
 MIJOFA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvw23byp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:43:52 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91454ecbd2fso67312276d6.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790675031; x=1791279831; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P9V3RsMED0hvWSpQ2uazwF2dW0m8dHFCUB7lTNN1M6o=;
 b=CpcAUVyLkU5YuWjilfSyiIpWLGRT4QGvBsvfDZEPF7EsyLpZN5nF1qXuPQu3FElZQs
 3gbQzTk6rBl9Voj8o5WhroJhSbgAlTEp3NIFYYji1+U5ATYrwDjiqP461QLoObrBRiol
 f5m4MlLRynxguCbHJEXA1niOmjV8aTnES+HpfwJf/DZIwm/kykJT4y0plUHTN6TjhiSQ
 LWz2r851aGRzSyU2JhVNjLPVRC1KvqB7sjoiISgYmGnWogohCtG7JfAVmYtCJgqEfJEc
 3oRVDLbW2DLTIWgy0R+qlpZGCAx14yHGrXVgIv7Vx40IMLcTVWebe2qcAHIwkfku3yt2
 pgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790675031; x=1791279831;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P9V3RsMED0hvWSpQ2uazwF2dW0m8dHFCUB7lTNN1M6o=;
 b=RJE9y+/vNk279wGHiz9A071SXoOHC4T/JpS7tKhjVJYVobM6kB7EAw4kuPXvW8Jyjn
 UXD3WWGRplKZaNg1+Ua4kTE62l9HY5VL4DH++mrOIaW7PwhErtoUrXg4oxwCmyRd4j09
 0cY9SCiomzCPPrT0HQ7UWv0OU3lX67G15lyVQJuUwGagUV36FIewPZEOLHeIJsp/8Yph
 fYOamnqQBxajjGul9dRF4Qj9QKv+Napms6o5BraVop3uvbmQIzAKUpsJq8xUkw4MtFoW
 EboIztTlzUsuVTHqko5LKPY0ekqzexTv96HQkRpQc2tsXirVaSOPFUs2yGIM90Z4O4w5
 dphw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2WPmmRNOiDhzvBpv6gtGIGFJuosTmYhpuLT3aDxHCpH1aboB3CYuuKzMmYFWdREJXU8As5xYYhOo/@nongnu.org
X-Gm-Message-State: AFuF++m2nY/UEs5cz7fFPlNq6vYRwDs1UdCXOyO8w/EMRo5J3d+o/4Xo
 Hb2zESOe1sjMJBNPu8cqSit1ENuqA5QjkyPVz0eeekY44/mgup2nXYyI1KBaTqmAqEaGHg2pbbU
 5tktt3oGjjDsv/HYW1Yk4fcqlChk++UYpPT9w49vdFJFT5wD9KeDA6XncIw==
X-Gm-Gg: AYBFou0zQxN9BfbeS0XXHUmaoM+i2XEhHnQ+Maz4PBwcyRW0tSegMMPw36H0/qLpSOj
 UhXAiPhKfALUr6/Eb7NK+RXYd6KuguHEH265B4CQSK1Qo45riGPcZwVUgao0wOzSdfzfQH8P+st
 vugmcaVXnBFpYhhURl0C3l/1Q8vykOy0tRE/F/Yv5+t7xbhBt26tsvDLEYawmQhSpATq8WGjw6p
 ZpG0evUFMEsbo0J8itWIMiBMNYJxE8rBkNUoW4XVzkjP+9nyQtwDEGzi/6JL15D4s0seZ49sNTB
 e2kxZ7SwFzpQ4kS/Aj7yJZkwCgYMLHxYL/8mBOja93bt0X3WD0Fl/ZIqOedYTINYUzs3lg+dSYe
 Fd8OIfIAHeLIkXDw4cDkxL0ymEM6O0PVmkQ==
X-Received: by 2002:a05:620a:29d4:b0:93c:6507:a6e2 with SMTP id
 af79cd13be357-93c6507a97amr1483095385a.65.1790675031245; 
 Tue, 29 Sep 2026 02:43:51 -0700 (PDT)
X-Received: by 2002:a05:620a:29d4:b0:93c:6507:a6e2 with SMTP id
 af79cd13be357-93c6507a97amr1483093885a.65.1790675030733; 
 Tue, 29 Sep 2026 02:43:50 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00d58054bsm38966545e9.3.2026.09.29.02.43.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 02:43:49 -0700 (PDT)
Message-ID: <960b62a4-7398-45ed-a4a9-f11c639ab702@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 11:43:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] tests/tcg/mipsel: add float reference files
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260926010053.2840-1-pierrick.bouvier@oss.qualcomm.com>
 <20260926010053.2840-5-pierrick.bouvier@oss.qualcomm.com>
 <17d2b653-e32a-4c0a-b035-ada9e9762360@linaro.org>
 <ba38f0cb-e9a7-4aee-9d10-f6d5fa22c333@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <ba38f0cb-e9a7-4aee-9d10-f6d5fa22c333@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=N6i8hG9B c=1 sm=1 tr=0 ts=6abb8858 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=No6e5BS5D--qhVeCrDUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: oDpfttIhVknPFqnGgmn1RhnXBWVQZ6D6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzOCBTYWx0ZWRfX4LpuwfVxRBc8
 h5fhSSGF8aU14qG5fWWjoZE8qGCkV7EhiRl6oM3uV1+Iw+v0b+6Hjwa+XDhOPnfEDG+0lpYFGF8
 FRSdDtnpMzc2kRdplicXYShOhDJGh/KewlxjKa8ghEAl9683ezNtWTTvFAnT7r7t3bPWtluOkeZ
 YVHoq/C6jtF6PPlK9eH8Gh26QIkdJLgaKYkKaQ95EvNPXCITS//ZZtA7jSY88ASdLaOh+hr8wCj
 fdR73Z50DK++4w8JdX9PQX/G60G/QILPJZtZaFRt2trDplDw48x/M5LA3sKyvuV5WKWbwI5/V+j
 2Z/aw0Hta2HIFJFU1An5URM+3D8ZH2MnmH0kZiT7zJQICQCRVHmVymwwR54J5cuXda9h1mZVkoK
 ZmpfL8HQVfGuiLuEUVPhb0zrApn60hOZTaahxCDAWhOsbOAsu1LPMdRhVBMVyP7Hbkvb8oaQynS
 OwLndGRP90jmgtu22fA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzOCBTYWx0ZWRfX1UwsKIXFwfuK
 NyB2z9EBMrMMfJGAWAk8dZiD6t7kglYVj+b8tBqs4l1GAwPIVARNE+fi7W/mXW587MUFoqed5gP
 7g3tGRWPmVT1zVQ76MZuJBvNOSmLLuI=
X-Proofpoint-GUID: oDpfttIhVknPFqnGgmn1RhnXBWVQZ6D6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290038
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/9/26 19:22, Pierrick Bouvier wrote:
> On 9/25/26 7:35 PM, Richard Henderson wrote:
>> On 9/25/26 18:00, Pierrick Bouvier wrote:
>>> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>    tests/tcg/mipsel/float_convd.ref | 988 +++++++++++++++++++++++++++ 
>>> ++++
>>>    tests/tcg/mipsel/float_convs.ref | 748 +++++++++++++++++++++++
>>>    tests/tcg/mipsel/float_madds.ref | 768 ++++++++++++++++++++++++
>>>    3 files changed, 2504 insertions(+)
>>>    create mode 100644 tests/tcg/mipsel/float_convd.ref
>>>    create mode 100644 tests/tcg/mipsel/float_convs.ref
>>>    create mode 100644 tests/tcg/mipsel/float_madds.ref
>>
>> What are you using to generate these?
>> I noticed that you did the same for other targets.
>>
>> If the answer is qemu... that's bad.
>> This really really should be from proper hardware.

I concur. To test emulation fidelity, we need to compare with real
hardware output. In the absense of such valuable set, testing against
QEMU-generated output still extends coverage and assert we do not
regress. It shouldn't be problematic to re-generate when fixing issues.
This series (and previous .ref added) doesn't make our codebase worse.

Maybe we should add metadata to annotate dataset gathered from real
hardware and what is QEMU-generated.

> Yes it's qemu. I understand the consequences of generating this with the 
> tool we are supposed to test, instead of real hardware.
> 
> My point of view is that if we can't get access to this hardware, having 
> a self-reference is better than nothing. It trades correctness for 
> stability, and allows to catch any change to review them.
> 
> In case this approach is proven to be wrong, and changes are too 
> distracting, I would be happy to remove them. It's easy to isolate 
> concerned tests in a specific list, and include them only if target has 
> the reference file. Just saying this to explain that it's not a decision 
> based on "it's hard to express in meson".
> 
>>
>> r~
> 
> 


