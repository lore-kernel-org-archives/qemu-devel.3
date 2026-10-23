Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09D3606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eTbuyCJE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B2CBhv0q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2u2-0000eJ-IW; Thu, 22 Oct 2026 20:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK2tw-0000dw-Kp
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 20:12:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK2tq-0004KE-59
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 20:12:52 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMFCJg938006
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 00:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ViBtu5kK5ZujJA5JwgIKRrlsOjp8bfP7CB7qnj397+A=; b=eTbuyCJEFm1nbZpM
 b8U33FpPuX8PBXqDopC2MtuZmJs8ZsWM1lLibR0uEyXp7JddZy9wwQ/pSdGZziNf
 URXzgth/NIr/NQ2Km+KaXd9+sKOm3TRnI0HSOV4aq/zBNZy502Q+usASC1vwOEwf
 PMmFwXLqA77F9K8i8JSfiMUwrwvT5iQZpTzlB/DpKIykianfqDt4Hh7dPv90C9rX
 03fOb1x5dR5+SA4xAQNI0m8Kbk0dgPzf0bWLSqWut7pKrZBdPgpdR1BKVnwjZCcj
 glm0HP6GAri1gje98xsQF3p5fF5zaQeIj63a6uQCuNQPy+sjXoEMSVOp6Aig5lj8
 pdGiVw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hftyg8b3p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 00:12:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ac77c3ff6aso498201a91.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 17:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792714363; x=1793319163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ViBtu5kK5ZujJA5JwgIKRrlsOjp8bfP7CB7qnj397+A=;
 b=B2CBhv0qrJHS/NvBuOGjw1aoktQvSui3BuJ+h4AAYLKjHiezOEILOPSxt1aEFZK60y
 BEoLpTth2i9SIE+1rR2GCiknMO96bP34jwRUzQEaXWPmvSnJpr2iWD/hNI+jy0O7KtzK
 Vyfxq4xh7K/hqxPpQSf98dO2unRyGDmVL2rNiq/gx08/rnEQUsK0hBRJNedfj3WRSO9A
 kC9zSEi/8WkYHi7/7jqOCjnTn05b2gctxjQQd4GK6IBCwgNaq+XzkH9alod4xkcJAowu
 r2bBqM3CN/aIHuVLn/4/Fj5K0EbMQIO+8bv7RSjGkNsQa8XDn0LlEJt4Txz5ZMdwkokE
 vqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792714363; x=1793319163;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ViBtu5kK5ZujJA5JwgIKRrlsOjp8bfP7CB7qnj397+A=;
 b=r6MjsTdfFiMLmoGtRBO392n1uMzeo2vECrnLkI+HGlxcXHCdeg6R3t1VhD7f+Ct4ch
 D7I3BNiznXnc6u0qWGieb+jHP6gNK0DZWc7qQLemKcmpi8pgecrumyXiS2Q/bn8kdVVA
 1fTb3qkY8VP81/aJW2cUr+mquSqfdugVPFbmIfxPW1EmUlZsvejf0QdYlDbrMh/qj+YZ
 5O6li6rHJKnhJOkNSXezbtrd4/TN8vgLQjuMzaqFwpi4V1q7ce372FwO4ou+PfqBow/K
 LAGGkZjmgkGnmu7BysJMFLB8DW76meoDq9D++4pYlvFhz3GFTqqLBTELV4yDagtqQgab
 LYdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcBB+M1hKKf2JzSvR7sMHvYcj492M0R1jC7Wj6/lNRM6ZZ7WGWbcv5g5na0+zLk5vrcB7wUL4KoKoF@nongnu.org
X-Gm-Message-State: AFq9FYI67+Mxt+mfhrO6nDPet1nKmfIjI04tsAurHB7TIcFtNkUsDTvY
 WwhkRNZ5NSB6QXY+gT52CvRFAUqpnFfbLw8p55K+XGbe7tPyiznuY/9fnSpc2hYrJOkCupW2tCw
 pL85O8z6tQlVp9OeBLgXJt7W95aDmuANlxakMtR871ePxasf//DCCavC6Sw==
X-Gm-Gg: AYBFou2Cp+afkEO1ZBzE8n9gjJzIuaZxsPxpTcVtthksPvuQ4mB4ghobrSkwULSrV4o
 /WPA4p2GB9waD2H+PSkik0Rp1TpT4SAIVeHP7OQhfTA3xCDuMo3C8cPBLpFUVsKChUq7+qcOmmy
 LIyZi3JsYUyDD3T2nwyedUKZIiGGnJhGSRY5hxV98ieBD5UZc1plPS8h+F/YjJFfblWRx199T41
 WHSJkTu6OMowPcYIUhNDgS5VDkCIPY/bOZ5xsiK2a1pDe4hpCLS076F+15GYXfT5huRJdOSwIAY
 /Obu+PEY3ZrVg3obUoA/1Rg9qL2defevbICFF3Gip2b0ZplncNeidSWfIRXl33pZstulGNxckOg
 9ojaiv6Me1L/fECUFKGwYzxed7fxmb0yMtD9FZnbQSVTUC2I9UVBmsht99NquMIc3pjVudA==
X-Received: by 2002:a17:90b:4a0c:b0:3ad:b7d1:8631 with SMTP id
 98e67ed59e1d1-3adce7a65efmr386391a91.17.1792714362790; 
 Thu, 22 Oct 2026 17:12:42 -0700 (PDT)
X-Received: by 2002:a17:90b:4a0c:b0:3ad:b7d1:8631 with SMTP id
 98e67ed59e1d1-3adce7a65efmr386369a91.17.1792714362284; 
 Thu, 22 Oct 2026 17:12:42 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3add263384dsm15366a91.1.2026.10.22.17.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 17:12:41 -0700 (PDT)
Message-ID: <6ac3374e-93a0-4c9e-aa85-b4fe11c5f7de@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 17:12:40 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/16] BCAIN do not merge - gitlab-ci: enable CI
 pipelines on forks
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Anton Johansson <anjo@rev.ng>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
 <20261022230048.2160400-17-brian.cain@oss.qualcomm.com>
 <9a2c99f4-5f6c-4509-a473-6a124b0daed1@oss.qualcomm.com>
 <db423673-2a32-40f0-adab-07ccc816bebc@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <db423673-2a32-40f0-adab-07ccc816bebc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cZpHPXDM c=1 sm=1 tr=0 ts=6adaa67b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=W6xDZvSksBKK08BZuxcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwMCBTYWx0ZWRfX0wsrLzOS6VqU
 h9wKIvFVfre+nJjVcX3VUFHb+2qVd+sQ/2y7+rCm/l9ILd8pnV0/Vysij+HTx2DfnURZAogzukL
 OAEwV4PLr42xJDduGVzQAqfG4C7sE2c=
X-Proofpoint-GUID: RPMU89lB9zwTOlZieZkTa_c9vZUeF7Sx
X-Proofpoint-ORIG-GUID: RPMU89lB9zwTOlZieZkTa_c9vZUeF7Sx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwMCBTYWx0ZWRfX4NpN6+K27KdS
 BPZh0CBgcQwSZ4ekHOmjJMqXsE1js6ai94ONlt8Rpi9po1xO3oYV/+IspI6B/IQDLN+06F16p+y
 mgR52mxRzPKdiUBVXfU0Eqp1w20xCO4qvcNZjtcVOnRX7v0ONDsCFbi/3I7rEcQpY3fvvWOQw12
 5NMWbFzvE1H8vt9HCdQTRXDyjrWS4cYA0WFjOK0OXJG+UCf/W8piKdHciUNAHk+7asdx6kqE5bM
 FRMsSan5s8b3LgZxIldb0ZIJD9XGBDY6nZxTDKQMt6qVok4g5ZW36Luv1NNCHvqyBwW7qBUv8cw
 8zBzlDUa9I0uZswkZ6ITvtihD+3rDYrDZ+9xm9yaNHPoROlOadTjGeNOzfg9QwBxjo4+1nCN+A6
 sCh4kJMP2wuUUC9fmE1PGUJCaheTZWJigIx+y9QR7ZO9EKSr1rlIoJq4h385ZBpMTUQ5zPGkfty
 7p+npfF/9pK/zm0N3zQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230000
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

On 10/22/2026 5:04 PM, Brian Cain wrote:
> 
> On 10/22/2026 6:57 PM, Pierrick Bouvier wrote:
>> On 10/22/2026 4:00 PM, Brian Cain wrote:
>>> Set QEMU_CI=2 so that pipeline jobs start automatically regardless
>>> of whether the project is in the upstream namespace or a fork.
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   .../dockerfiles/debian-hexagon-cross.docker   |  2 +
>>>   .gitlab-ci.d/buildtest.yml                    | 58 +++++++++++++++++++
>>>   .gitlab-ci.d/qemu-project.yml                 |  2 +
>>>   3 files changed, 62 insertions(+)
>>>
>>> diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/
>>> tests/docker/dockerfiles/debian-hexagon-cross.docker
>>> index e07a2be37e2..39f647c743c 100644
>>> --- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
>>> +++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
>>> @@ -28,6 +28,8 @@ RUN apt-get update && \
>>>           flex \
>>>           git \
>>>           ninja-build \
>>> +        clang \
>>> +        libclang-rt-dev \
>>>           python3-pip \
>>>           python3-setuptools \
>>>           python3-tomli \
>>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>>> index b1e95395d0c..1f12a5f1f64 100644
>>> --- a/.gitlab-ci.d/buildtest.yml
>>> +++ b/.gitlab-ci.d/buildtest.yml
>>> @@ -397,6 +397,64 @@ build-user-hexagon:
>>>       CONFIGURE_ARGS: --disable-tools --disable-docs --enable-debug-tcg
>>>       MAKE_CHECK_ARGS: check-tcg
>>>   +build-user-hexagon-noidefparser:
>>> +  extends: .native_build_job_template
>>> +  needs:
>>> +    - job: hexagon-cross-container
>>> +  variables:
>>> +    IMAGE: debian-hexagon-cross
>>> +    TARGETS: hexagon-linux-user
>>> +    CONFIGURE_ARGS: --disable-tools --disable-docs --enable-debug-tcg
>>> +      --disable-hexagon-idef-parser
>>> +    MAKE_CHECK_ARGS: check-tcg
>>> +
>>> +build-hexagon-ubsan:
>>> +  extends:
>>> +    - .native_build_job_template
>>> +    - .native_build_artifact_template
>>> +  needs:
>>> +    - job: hexagon-cross-container
>>> +  variables:
>>> +    IMAGE: debian-hexagon-cross
>>> +    TARGETS: hexagon-linux-user hexagon-softmmu
>>> +    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --disable-tools --
>>> disable-docs
>>> +      --enable-debug-tcg --enable-ubsan
>>> +      --extra-cflags=-fno-sanitize-recover=undefined
>>> +    MAKE_CHECK_ARGS: check-tcg
>>> +
>>> +functional-hexagon-ubsan:
>>> +  extends: .functional_test_job_template
>>> +  needs:
>>> +    - job: build-hexagon-ubsan
>>> +      artifacts: true
>>> +  variables:
>>> +    IMAGE: debian-hexagon-cross
>>> +    MAKE_CHECK_ARGS: check-functional
>>> +
>>> +build-hexagon-asan:
>>> +  extends:
>>> +    - .native_build_job_template
>>> +    - .native_build_artifact_template
>>> +  needs:
>>> +    - job: hexagon-cross-container
>>> +  variables:
>>> +    IMAGE: debian-hexagon-cross
>>> +    TARGETS: hexagon-linux-user hexagon-softmmu
>>> +    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --disable-tools --
>>> disable-docs
>>> +      --enable-debug-tcg --enable-asan
>>> +    MAKE_CHECK_ARGS: check-tcg
>>> +    ASAN_OPTIONS: detect_leaks=0
>>> +
>>> +functional-hexagon-asan:
>>> +  extends: .functional_test_job_template
>>> +  needs:
>>> +    - job: build-hexagon-asan
>>> +      artifacts: true
>>> +  variables:
>>> +    IMAGE: debian-hexagon-cross
>>> +    MAKE_CHECK_ARGS: check-functional
>>> +    ASAN_OPTIONS: detect_leaks=0
>>> +
>> Out of the modifications below, this could be added to upstream CI.
>> Also, it's possible to combine asan+ubsan in a single build, and run
>> both check-tcg and check-functional in the same job (or two steps, if
>> you don't want to mix output).
> 
> Ugh lol whoops :facepalm:
> 
> 
> Uh, okay, sure!  Maybe I'll do that, then.  I'll omit the "TARGETS:
> hexagon-linux-user hexagon-softmmu" so it applies generally.
>

I meant it would be ok to have such a job for hexagon only (for now), so
keep those targets.

> 
>>>   # Build the softmmu targets we have check-tcg tests and compilers in
>>>   # our omnibus all-test-cross container. Those targets that haven't got
>>>   # Debian cross compiler support need to use special containers.
>>> diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-
>>> project.yml
>>> index 72d02bc65be..fe638bc5fd7 100644
>>> --- a/.gitlab-ci.d/qemu-project.yml
>>> +++ b/.gitlab-ci.d/qemu-project.yml
>>> @@ -3,6 +3,8 @@
>>>     variables:
>>>     RUNNER_TAG: ""
>>> +  QEMU_CI: "2"
>>> +  QEMU_CI_FUNCTIONAL: "1"
>>>     default:
>>>     tags:


