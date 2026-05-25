Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD32BCD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRXWQ-000311-Ft; Mon, 25 May 2026 11:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wRXVt-0002zK-DB
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:47:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wRXVq-00062w-CZ
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:46:45 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64PBPgsa3263677
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 15:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9fT/d10fWIVU5cSKV6b36qad14JO2NSP8HJ6SWnDI98=; b=oSp7AC1D/fYg759g
 xQJ3AvtkR4eEn+yD7AXGxR/Fa/bA+0Q+Wbt0zoUr6hhCjIZmwz89s5qConOcBhP9
 tO746SpFaGgzrRsdtslqOqc/iNmnW8PloSa9NNgqH4zIXILzSQ93pFimnovAsqv+
 jlbPm5fHMrYzElRNaiTtu+xcOpzesHGuKr0v1mhcngswsbJsim89GqYVCVxt4U59
 3IHAnY8+0yGtiSz+MZMKU3yvo+l2h77q3IvPAcedyLWMZmknM8j6pdbIMHE+8Vba
 j7gL5E2OlRpR1N6QErIO6cGWlLrnL0oH0Cu856FUubhDb/UKiWQwPTU0Nc7zZWQ5
 Keqqjg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecnhs0v6d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 15:46:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304950e5901so267290eec.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779724000; x=1780328800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9fT/d10fWIVU5cSKV6b36qad14JO2NSP8HJ6SWnDI98=;
 b=f7E+05trEyLGO6Z7BPEvKBZWkZP7xog61VHbQJrVKnyIJeXawnke/2p+E6IVEzUqKm
 2Mw88QUA9jfyONPau3HSu+MzACHebSXi9xgtx5gyacgw5WuSUupryjJ3ll56ei2H1YIm
 pLGbilnfavieR7qeL84YEzmIamjX8KZmzE1rpR6Oet5LfHNvwY/psYx3jjaKSeOmPC0K
 gEiglXwOvPygyO/LrsAWzttqQT4VYm8vbCHji2wcxKjKYvnpByXz1huVJQ7G0U53f/ic
 CWGkHDkWCS2lk3Yg5AJWUjDJ5raV43vbSQkelTh0foV2UV1BhpeRcLysrDHo9k2hTQmd
 67ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779724000; x=1780328800;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9fT/d10fWIVU5cSKV6b36qad14JO2NSP8HJ6SWnDI98=;
 b=muU9zGufSv4uFs/cbpqdQxxCPHO7SmBdX1tXcqit+IXqc2AJhL9ctyOusEOkwIHHDp
 FZtVoNsH+57uhZFPFZ3aLcB4B0HXNc6D0kEVOHgpsY2+jUcA2OVGeN8eA1lceXKjsJxK
 umbcr55HMXCLEgau99IOG5ijU3rTkEX0c+DOn1ngUF5ItnXp/HCEBw16LA+ZIxcAF1m8
 6yPEldXvrefchFNkd8XxuUeycamogIqBarGw5Uk4YuUOJCKLUGa3gxVUM8ofm60BnsEe
 rJfmmqTZyf1Hy0BPBSvgocLuMNzAowdNjlIawBKagrydr/7XTsWoZYg7MIBkmTgTsjpA
 Riog==
X-Gm-Message-State: AOJu0Yy+kdo7npCnc9TshXFxbFGhFPInFya7Ap1bqySbgjjTHvIOThNC
 7iLWD70tqKpOGsAscHc08Q1E7yiIw/webeRQnj6b0pDX83jEkDRdzgtJ666zG18xMVLFfjtbRYS
 0wpV0eEhfLVg7imKsNwri2iTJ27yrLBKNCl0n6QJiXRH1bIw8b8Al/VELpQ==
X-Gm-Gg: Acq92OHjJdrt4DDLSNIvGZmqm2sobO9eYA/muvVdS+J8Hf5zVD7FAqpC1H+on0O806W
 eHotmDIFbDhcnvvwtyWhL+kbl1arYZEDKMsATAH02iyHnIqWmm2X9IgvhRqRG7bd0daZeybqf/A
 baLCB9wHZTi2lrQhWy3wa6dWW8Cx5HCyxLDtYxSQZlEPi3p7BIWOCgNM316XZg5T7GQvCoKcBM1
 cD2AWbH8EPwxAG0uyR+AmBcLkqRqvT+RX86Gh180jpsOuMfEti9Ropa6Ylhsf8EdScDuW4PK+Fr
 WhLmrn9NJiWPx58aZJBs5hGsIg0ICy0u9GNS73aEagjeKPkbwU7uREpDRkfTdXI7sZW9iGXuouK
 Z9rudIgcWUxbBheqKiQRlj2qlx42ZwhrDq9lSeVL/zdd/bRV6NuyhiPlK1MifZndMNqYjwvKOXX
 BjEf5yk2TjRO33VDsxcXRcNyrT
X-Received: by 2002:a05:7300:7483:b0:2ee:7b2e:8a3e with SMTP id
 5a478bee46e88-304304fbfa4mr8238694eec.1.1779723999681; 
 Mon, 25 May 2026 08:46:39 -0700 (PDT)
X-Received: by 2002:a05:7300:7483:b0:2ee:7b2e:8a3e with SMTP id
 5a478bee46e88-304304fbfa4mr8238672eec.1.1779723999016; 
 Mon, 25 May 2026 08:46:39 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f20561sm7447867eec.10.2026.05.25.08.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 08:46:38 -0700 (PDT)
Message-ID: <5bd51a1a-4079-4073-bbd8-f0206a1ad458@oss.qualcomm.com>
Date: Mon, 25 May 2026 08:46:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] tests/Makefile.include: add binary dependency to
 run-tcg-tests-% rules
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-4-alex.bennee@linaro.org>
 <74e8bc86-cd81-43f9-b5cb-7e3de3bcd3d0@oss.qualcomm.com>
 <87tsrzl138.fsf@draig.linaro.org>
 <093614fb-ced1-4b15-b1e1-5da755f87237@oss.qualcomm.com>
 <87cxymec7b.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87cxymec7b.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vd3H+lp9 c=1 sm=1 tr=0 ts=6a146ee0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=7nZTrR_V8b14Mc2b2hcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: szhA6rAlZH5Gg0pEOzBegjSCAUHy0JYu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE2MCBTYWx0ZWRfX4N/8I7DQHOzp
 Ldgd1RnOJKvvEcQPEIp00WLGvKMAeqCBtlHWy6DZHE9yv2wLy7mzjGueJyLHg2lXk7FeazPR4Wm
 EU04iAq1RQQ+VYRAclCnd8iGPWbOsOcoGjfzGIqeKVYP/hiMddjnZ+J/lCAvMBcfrhGpvPRh9xg
 WPXnBzu7nCy+LioR4vFvpeRFKV0xjor44YeWn++SAgDKoFSQm7wAs0y1rIYyiGnx2Mgqfw+TOlp
 pIiG49Oc+vxIMVUR6BqAe91Qt/e779QYzILfVA5JVoDyrJEZa3FJW0IblB/NKT+pI1K54/9tU01
 wwX1mFxya5gENbqdkThDXQgafKzf6YibZHRjku/JzegtfMOKiookBwWpIGDYcv83MAAz9YBinWq
 g3IeF+3EvWokK8gEs56VuDrnExQkAOPIRoNPztX9JrMWDuIUlZydkmnRyylWF311YSAikXUf00J
 EBOydwfEuVqXYTvsPew==
X-Proofpoint-ORIG-GUID: szhA6rAlZH5Gg0pEOzBegjSCAUHy0JYu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250160
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/23/2026 1:56 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 5/22/2026 12:02 PM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> On 5/21/2026 6:17 AM, Alex Bennée wrote:
>>>>> Explicitly set the appropriate QEMU binary as a dependency so we can
>>>>> ensure they get built. This is especially important for MacOS which
>>>>> otherwise only builds the unsigned binaries on a normal "make all"
>>>>> run.
>>>>>
>>>>
>>>> I'm not sure to see why it matters. tcg-tests don't make use of hvf, so
>>>> unsigned binaries are plenty for it.
>>>>
>>>> Which other binary is this building that is not built by default?
>>>>
>>>> In general, if something is not included in "all" target, let's make
>>>> sure it's included there (meson.build?) instead of adding a workaround
>>>> here. Not only tests benefit this, but anyone doing a build on a
>>>> platform that might have optional binaries not built by default.
>>>
>>> If you have a suggestion on how to make that work I'm all ears.
>>>
>>
>> I would be happy to help, but I don't understand what the goal is. I
>> have three questions that should help to provide a suggestion.
>>
>> Which exact test command do you run?
> 
> make check-tcg
> 
>>
>> ```
>> Explicitly set the appropriate QEMU binary as a dependency so we can
>> ensure they get built.
>> ```
>> Aren't they built by all?
> 
> Apparently not.
> 
>> It seems to be a dependency, at least for check-tcg:
>> .ninja-goals.check-tcg = all test-plugins
>>
>> ```
>> This is especially important for MacOS which otherwise only builds the
>> unsigned binaries on a normal "make all" run.
>> ```
>> Why do you need signed binaries for testing on MacOS (hvf?)?
> 
> In a previous iteration I made configure spit out the unsigned binaries
> to config-target.mak but the request was to fix the dependencies
> instead.
> 
> It all works on Linux so I'm not sure why MacOS is being so weird
> because the meson emulators target mechanism should be the same.
>

Just tried now, and it does not work on Linux neither (make check-tcg
does not build any target beyond tests). Maybe you forgot to clean your
folder?

>> Regards,
>> Pierrick
> 


