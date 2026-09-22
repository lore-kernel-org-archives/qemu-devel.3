Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F3CC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x953o-0002L0-NE; Tue, 22 Sep 2026 14:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x953T-0002Iu-0S
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:17:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x953Q-0003pI-Gf
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:17:22 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7Ce9368034
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 18:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d7exfQAQDnlNgELwZGB7Ldhld4RmVD2jr2BwbR17lAw=; b=Q8WjZ4uqhQfKoEdz
 pngB6DMmxjYqgSqSR9gtFv8cVmTtn+mObecLoWWqz6jj2tnBQDTM8FratPQnB6sX
 LUh3W3Ww+5sz3uD4jPL7eG1rXwZJ1yLY03rP6n/GkmIBLqen4LxgW/V05bnetESU
 PnuzHztD8j+spkIWrc0yfWzBYEiAJ3lEXOvhsf1ckyeN7jx1c+vsknmaGzE6Jsky
 j4xq+yU6rQYDdji3Ojg+EiSXJQtl/VOOrsRqc9H/KK/ndjiVrjIBCU/hEH2gSKsu
 IR7/fLD7ec9dCcK2ONRnLkkJQJfz/kjLqtudtVE32dA018olhHca8ZMhrldmlGi3
 tty9Kw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gurnta4cw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 18:17:18 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-338c2e27430so55433eec.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790101037; x=1790705837; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=d7exfQAQDnlNgELwZGB7Ldhld4RmVD2jr2BwbR17lAw=;
 b=SLEDkfMpTe/UJrdknf5dXi3Qd06fdeNoW+/RX09OIJP/IltVuqpTKwtQt0wpjvzBJP
 D2+WIdcnnNCfEqI5Xt2x2FSH1SNRc6D9le4csoDB9uUBvhkYzg056ESLG5Rkn7LV2SKp
 YrP9Noflr1X24g00ds/f4Hw2zg04AhkI45weP0Ayf9EyVbelSsar8EMM21gcpJPI+FRZ
 iP1P2kAj71M2i+bgRjGKxYzm0hZIrluCiceRFXGc+06x+uSb3n3m0jZg3d3n9AbYykCk
 Fcrwni3DQ/l9ezQju9B8RLZqRkknTEKLH9TDbPIT7ZGaSOpywvR8PQJp5WIo9QbBIU61
 8hTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790101037; x=1790705837;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d7exfQAQDnlNgELwZGB7Ldhld4RmVD2jr2BwbR17lAw=;
 b=FwN0FYviitnDrz7AbH3rBM5PFk9jguPo5hJywVN70fJYaEyhLkewjIOgZFs2mlqQih
 Pry9Eyqz5Fi8/suEqYTKXVt0KxvwVqCu1iM6W7sXVxvATBxS+k5WD18D/aP1DhrlKsnH
 NbC2Ep54zxFGxS1RA+mVpH83ZTQ3FxiC07rLPH875lX2D9l2MUB32z23WuDQmCHhX8hy
 yeJ70M9sUXTpOrPIWz6+vNS6isnsUnUBdPl1th3MqREC4KUGDzOaOhSMhtyG321wD4DO
 BkWgb5X0LI5pazyW2fUnS260vuzhzmZtcnJta0vVlgrK70rYqiV8A/JtxR5/N3MknUuo
 8cLg==
X-Gm-Message-State: AFuF++kcY2nsZ3Rn7325RsYtmkPvr3uD45OA5DQ9nPzxocefvHdUrPak
 XWqCgMHcwy/cWZiAqU02ky8W+skgdlZn7HwdGm6800pV0wTOX3qiW7P4FqKhBgEBrCXfs+rjtaf
 PvG9CJCBkJKkkMUTXDxpaSsgAYQkerLVInY0XOAWBByf8cfmMdNmm15cSGg==
X-Gm-Gg: AYBFou0pffYE9eQFYysgPQWtm1wntO+3qK30iB7DOVcoaL2cHEemboB12auwoBQPu4J
 Xz/4iHm4Z7ZWn8dRaCi3x8tYsYmFAOBswB70l11Ahn2Mg2b3AF/2zCnF2J6nBmL2bKygGOQCDVT
 q/jPz0I4+TEgNSlqAzmXe3mm+tsNrYEApcqtMo7+BDrX4oLOqp06crq3sCimX+r9IxuE4/5auk9
 9P+EqotJMIkJPA9DUIwcCWbNbcPuT1LhlMsu0M6/pheash6/CpXC7b8XhpmThxA4UYWAhQeYxXI
 lqp76m12PuHIVmeKdf6Z821IcKPJTMJOAQe2NvGUbH7PNkWwuEUjqPkAwlfDrU65+lumnm+wO/c
 yOdiKluBAcQtrFZ7wk9BLGaDJnT0EDyAhNKwvaVSxByX1sr8vGRlTsuo4SHkuK7w7e3U=
X-Received: by 2002:a05:701b:4206:20b0:143:72b1:9004 with SMTP id
 a92af1059eb24-144f91721cdmr166524c88.45.1790101037310; 
 Tue, 22 Sep 2026 11:17:17 -0700 (PDT)
X-Received: by 2002:a05:701b:4206:20b0:143:72b1:9004 with SMTP id
 a92af1059eb24-144f91721cdmr166510c88.45.1790101036676; 
 Tue, 22 Sep 2026 11:17:16 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e96d46f48sm27086eec.23.2026.09.22.11.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 11:17:16 -0700 (PDT)
Message-ID: <7497ba9e-542a-4952-b533-af18666c9584@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 11:17:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] tests/tcg/meson.build: force use of linux/amd64
 platform for containers
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-2-pierrick.bouvier@oss.qualcomm.com>
 <arLElaXA4vLEPL6h@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <arLElaXA4vLEPL6h@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: E2dw0gjdhEuvWMdJsJFNIr--CyW8SDiN
X-Authority-Analysis: v=2.4 cv=eauo7LEH c=1 sm=1 tr=0 ts=6ab2c62e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=u7qdMP0F_pIMJZYq3lcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI2NyBTYWx0ZWRfX+kH5uWBIofDn
 Lba3uBr+bVXxKSG76j54A0/aXEuYWHYHSswrr2U3VNmg+dZ774BM+JTlZ5u7GjidaRUJesOY2cO
 3MEgQe9UG1Pcf+ahK6RFBY9pWvJc3V2h8NRyJ0ykK5zce/nvgu8gm0zlWFG9bF9yjzmjjzphOkS
 KEZhpxUCoA/twH3EMginOcdfsjfyiLNY9F5xdntV32AjFBsR7Oyb+gDDwqgvRWmCeUC1ugKAZUN
 CspaKJNFPIEQmTVxRNpvSMGpWax/HWGOWutASVx/LkA7QZEELKsnHxAdwIP2AboX5sUsYKUdpMQ
 zofv27W6/8Exg7M4BNFHMQlNGiidQ1XHTgTigp8rAqhSs6axHkstSd5ABTyRI+2BHaerC/Lz9mJ
 Epx1W0s7W/42dplH9dCYxZ+EqwZCpt2idO0iD7RAAVTBcMb5WZRNq2oRcDdewxu5dYWHnfS/dIx
 RLjhwOUUKHYUM4y9YYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI2NyBTYWx0ZWRfX8UsptGfotGWE
 b9aQrss/AlLPQKD0T8E2ahTbhdHmN0rRIKKbN0PcX8fDIVM8t8Vm7uHQ9JAroJ+a8MrcuSL9laB
 Pgq1nawhR3HWydX+Cd/5gfKBgdp+DzA=
X-Proofpoint-GUID: E2dw0gjdhEuvWMdJsJFNIr--CyW8SDiN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220267
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/22/2026 11:10 AM, Daniel P. Berrangé wrote:
> On Mon, Sep 21, 2026 at 11:14:52PM +0000, Pierrick Bouvier wrote:
>> On hosts != x64_64, we detect if host can run amd64 containers (usually
>> through qemu-user-binfmt). If not, we deactivate container support.
>>
>> We could technically stop here and force container engine to use this
>> platform. Since existing base image (docker.io/library/debian:13-slim)
>> is multi platforms, container engine will enable this variant by
>> default.
>>
>> Now the problem is that if user reuses this image for their own
>> Dockerfiles, they will run into unpleasant surprise that now, their
>> container engine is using x86_64 variant by default, on any host.
>>
>> So, in next commit, we'll change base image we use to x86_64 variant,
>> which has a single platform: linux/amd64. This ensures we don't generate
>> any unwanted side effect when building our images.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  tests/tcg/meson.build | 19 ++++++++++++++-----
>>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
>>
>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>> index 75f0a52fd22..4cf4865461e 100644
>> --- a/tests/tcg/meson.build
>> +++ b/tests/tcg/meson.build
>> @@ -81,6 +81,7 @@ tcg_tests_summary += {'gdb': gdb}
>>  
>>  docker_supported = false
>>  container_command = false
>> +docker_platform = ['--platform', 'linux/amd64']
>>  if get_option('containers')
>>    if get_option('container_command') != ''
>>      # make sure command is working
>> @@ -99,6 +100,15 @@ if get_option('containers')
>>                          container_command]
>>      endif
>>    endif
>> +
>> +  if docker_supported
>> +    docker_supported = run_command([docker_wrapper, 'run', '--',
>> +                                    docker_platform,
>> +                                    'docker.io/amd64/debian:13-slim',
>> +                                    '/bin/true'],
>> +                                    check: false).returncode() == 0
> 
> IIUC, this is checking that  podman/docker is capable of running
> (potentially)  foreign-arch containers ? ie that qemu-user is
> setup on the host.  If so, would be worth a short comment here.
>

Correct.
I'll add the comment.

>> +    tcg_tests_summary += {'x86_64 container support': docker_supported}
>> +  endif
>>  endif
>>  tcg_tests_summary += {'container command': container_command}
>>  if get_option('container_registry') != ''
> 
> None the less:
> 
>   Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> 
> With regards,
> Daniel


