Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D614CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNDHG-0004EQ-Fp; Wed, 13 May 2026 13:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNDHE-0004DZ-0b
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:21:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNDHC-0007ep-56
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:21:43 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DF32cS2887841
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 17:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +biUUK2ZC9UbiJLabirW8GvPWyTc7H6JazmWTW1RY/4=; b=fA3ROg7u2mNJVAAJ
 c8Qm7PjfufB4Hfz/bVM08szZsyBQaTQbBiBMaSA+9QiOp+igrkMpcR9nkqiAsuvV
 VRHOXrdzJkRaURBaod4GYvjIVxhEbM8/pfLGSAd2XrwSpwLUI4zsbzwFmURr4J6Q
 I+b8+jD2lqnldJGZ8C+CdkfCoQQt7k+KpKzUOYtD9FcFa/RsMMUQzkBnKDCUO0VM
 BN4MbU0D/+mqRi/pDiaIC6GMnPTfrXV8flO1V/+njBVMdLh7RG5N+JLuo+8WEz0a
 PRO/izZ99E7RvcaYswJS0oXduVKDLOAOQKPlC1Ke1mMEoDGMSFI+qj6Cn74Q6Lef
 RzdBRw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p4gj2bq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 17:21:38 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ee34588671so9621577eec.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778692898; x=1779297698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+biUUK2ZC9UbiJLabirW8GvPWyTc7H6JazmWTW1RY/4=;
 b=DDIBvgWNCcsci2xrDPYprBhTQdkYCecXr9AVmcWRvYfWhphLG0kLzhQsqu65yk9fqZ
 GvxNlokXE+PbTlPkKYtjTahxplSVDXLxjFwNVNGZoX4nrlDl+qwJ8A8ARO7L2dB7/nkD
 C+wT98nMcmXn5JoDy9/1WBL2Zy13kioCzM1WPsm/V0GDmkrig4iXCEkrvmUG/PtTix9n
 cI7JrOVX1nh7bQ8CsCTAicpUn9jAqFhfBXOFAmYLJgW+sIlo8EHFxQCRYlrPx4QiE547
 IZkYL422084IBY6XvSRp41PIzEMlyLryNgf/9aVvvyU2hLnWYmaUdrh165GgTUZMgZup
 P1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778692898; x=1779297698;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+biUUK2ZC9UbiJLabirW8GvPWyTc7H6JazmWTW1RY/4=;
 b=IMOEq5LoQmGvkIGBZJuJRQWQek/VnDeIaOyyrI7vZ9gDwAMczwP8gxWUZ72lfM3Awb
 Z5E5p3bYkkb8VNdn0IDrTtY7LbqwCanMfbib1ejNWXhemg4P9c9ObG2zIWFSR3tL88Yl
 802n79bZhn5mL5yhDG//G+cbWGbsX6miRLDBfqr55ZVJaCgx9ELUCqRXMXB9q3tOrDom
 Wj12ZivA1/WTXye3WXd8L1Gvy1DFBVIJFZc9Eh9a3T3+mOq6n7iTz4Fphdo6quSY4kNy
 moApnK22aeVHqv4ZUqzxSqXs0Kj6dX64wGBiluPcszfGgCteOSLvVgpORlb7ukoMbfhX
 3FZA==
X-Gm-Message-State: AOJu0YyG35jdyf4j0GpwAi7VmNnpRPAxRv6iyZmLVN7Ah3WrsZq79zS1
 Lauk1ycCUz4lfQVyaa+jvNpnwMMQwTD9xNzVKtND1TgxF1zSupNE7ujEmGklrX5z39xYIX0EYyO
 MAldCYdfDmAHfb3LRkeCSXnBUiJHezkBAn2dNilUIy+YqMQwkNIzMiX6ysg==
X-Gm-Gg: Acq92OEPW3YXr3qKbrTc52/6G12f0FmnhXwU/CjzypdHDc9/LUGst1MnMEFKWH6ez8a
 QJe7leZSO38fY9cxshcFop8FGwf4v1uRG/A1XaYsMmzGLZrnMmT6qHMKP9LIOR0e24fbtYrGvb/
 /gNnQL+FUXIhSbprZszTPyjyiNo0OnqiP1L2qvc5wVvsuRQX1j58y6raRxMKDotDDF0tJYTHhpp
 HtjU2Daey4PIo+k2yFbq4NhvP5nz4izQoun+rtYgJ132gT8s0HnX6UY9a6CJ0SxI4v8DvUXfIsH
 bTlf6M65Nbec35C0UeneZJFabSQbFFdgPSwEaX77NiYBzRvDrh2dXzB5PGLVta47EMX07W2aAyI
 OJWfqEEFG+mkNa2vKppayqi1g145gC2vYMcthbGsIjxsEmWR7klF1buxC4GRTMbRLJ5xbwrN5Er
 bP3ayXrtKZ8b08xP1S6/kZFYV2
X-Received: by 2002:a05:7022:6289:b0:133:39a6:2b8b with SMTP id
 a92af1059eb24-13440547836mr2796857c88.44.1778692897947; 
 Wed, 13 May 2026 10:21:37 -0700 (PDT)
X-Received: by 2002:a05:7022:6289:b0:133:39a6:2b8b with SMTP id
 a92af1059eb24-13440547836mr2796814c88.44.1778692897301; 
 Wed, 13 May 2026 10:21:37 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbed2232sm55411c88.7.2026.05.13.10.21.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 10:21:36 -0700 (PDT)
Message-ID: <ef465d07-d307-491e-822c-9a4fe9797514@oss.qualcomm.com>
Date: Wed, 13 May 2026 10:21:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/16] gitlab: add jobs for thorough block tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20260513120003.226790-1-berrange@redhat.com>
 <20260513120003.226790-16-berrange@redhat.com>
 <7729d729-a0b5-43d4-ba25-1b734faea269@oss.qualcomm.com>
 <agSyX4WuqV4jHq_M@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <agSyX4WuqV4jHq_M@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HvBqTrQcUH7ygsAYWYB_OjG1RXS7NpvF
X-Authority-Analysis: v=2.4 cv=DOS/JSNb c=1 sm=1 tr=0 ts=6a04b322 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=jgu--MCMT_PnSd4-uFkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: HvBqTrQcUH7ygsAYWYB_OjG1RXS7NpvF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3NCBTYWx0ZWRfX5g5CfI5Pa0C8
 urs/5gZGWE5FGgM/t0BrjgjDjugqRMMLoFAIHAVIO5Q/kp2QHoNECeZ5Gjf3KKqt0ugVDZtnh/9
 8Jj2XEHqNNBSpqKq8UFtaMXhzgOAKJXcHWTkHtjjPOw+oTkw0rgWIYikKnbzHuxPCvULPxZfUCZ
 ere9qdJVMl87NgQRdjMknwOJ0tOB4BGQ5c0WhpFTV1a/QLnqiA126KBYesvszHwVt6A9TBlV/nC
 OusWLbov5bCkVEdvjHQ2cKP2LIU0FIJb4+1Y+568fYxDKQIwewbPiUVfux4POvvhyCGpFfsJiyJ
 bZhlpmYuhDY8TSoMvzsNkEoaTaY66dmXzwjERQ80pbh2HYVlqnnqHesDtHJDi+SJBsw9RvdMtCv
 mXzSRVlii7aPMNPq9Jwoumf7HYgKkSglyN4of/BygfP16XJBeKMZ500P+Onwmz2tltLQyxRE9Xg
 ZGkFEdl3m10NVYn6YJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130174
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/13/2026 10:18 AM, Daniel P. Berrangé wrote:
> On Wed, May 13, 2026 at 09:00:28AM -0700, Pierrick Bouvier wrote:
>> On 5/13/2026 5:00 AM, Daniel P. Berrangé wrote:
>>> CI is only exercising the qcow2 'auto' tests currently. As a result we
>>> get no exposure of changes which cause regressions in other block format
>>> drivers.
>>>
>>> This adds new CI jobs for each block format, that will run the target
>>> 'make check-block-$FORMAT'. The jobs are separate so that we have the
>>> ability to make each format gating or not, depending on their level
>>> of reliability.
>>>
>>> The 'centos' image is used to run the I/O tests since several tests
>>> have an implicit dependency on x86_64-softmmu, and thus break with
>>> other architecture targets. The 'centos' build job is the only one
>>> that creates the x86_64-softmmu target in CI. Ideally this target
>>> portability in I/O tests would be fixed to avoid this limitation.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>  .gitlab-ci.d/buildtest.yml | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>>> index 4b1949a3a5..cf0281ecd6 100644
>>> --- a/.gitlab-ci.d/buildtest.yml
>>> +++ b/.gitlab-ci.d/buildtest.yml
>>> @@ -174,6 +174,24 @@ build-system-centos:
>>>        x86_64-softmmu rx-softmmu sh4-softmmu
>>>      MAKE_CHECK_ARGS: check-build
>>>  
>>> +
>>> +# NB: block-XXX jobs use 'centos' since that is the build
>>> +# job that provides the x86_64-softmmu.  Some I/O tests
>>> +# are currently buggy and blindly assume characteristics
>>> +# of x86 (such as PCIe) causing failures with other arches
>>> +
>>> +block:
>>> +  extends: .native_test_job_template
>>> +  needs:
>>> +    - job: build-system-centos
>>> +      artifacts: true
>>> +  variables:
>>> +    IMAGE: centos9
>>> +    MAKE_CHECK_ARGS: "check-block-$FORMAT"
>>> +  parallel:
>>> +    matrix:
>>> +      - FORMAT: [luks, nbd, parallels, qcow2, qed, raw, vdi, vhdx, vmdk, vpc]
>>> +
>>>  # Previous QEMU release. Used for cross-version migration tests.
>>>  build-previous-qemu:
>>>    extends: .native_build_job_template
>>
>> All good!
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> BTW, the use of "matrix" for defining jobs had a slight impact on
> the way the jobs results are presented. You only see an overall
> status for the psuedo "block" job and have to click to reveal the
> individual job results.  Not a problem, just a surprise if you've
> not seen it before. An example is visible here:
> 
> https://gitlab.com/berrange/qemu/-/pipelines/2522062147
>

Yes indeed, just a matter of state.
Not a big deal, as what matters is that you see it green everywhere in
the end. We could as well use matrix in some other places to simplify
yaml files or compact CI results view, but it's definitely not a priority.

> 
> With regards,
> Daniel


