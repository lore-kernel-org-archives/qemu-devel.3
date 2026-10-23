Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44031606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 00:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=da3enMLY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OPM1lLR6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2mT-0007pb-Of; Thu, 22 Oct 2026 20:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK2mP-0007nW-DB
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 20:05:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK2mN-00031A-BE
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 20:05:05 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MNL8uw1051646
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 00:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VYZn9a13S6TtDgw1TWKAb1dfSFVH56WEpDEHomygc3g=; b=da3enMLYdafZE4Y+
 WjqIXkV72VzE4CDG64hkkFjD3WTckwPcCfEwrArLVJrOTWh5NpIJP8L+Xcy+U/9y
 pqeMjR/m9FWdp1beWt1dXwiZRtv20hjaZM3ezSvS0aJ8QHqIl6bW2RGk6qA+t+mA
 1IjrQE+yuU5bM9ylHK1w2Fe/fybzBAWi1ahQrj/nTA22vVTu8ICUvawwTH6NDI6s
 uqX40Z5IlwvyQ7RRt8no3aHEV0W661pgGGu694oheT1j5H280weeSJlAaPJAkvbB
 pSoffDLn60M5H+seom6As28xnxZ6U+pEE6xCXRiHzl/SX/957TovnuqThqSdARZk
 UKGkgw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw1mhs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 00:05:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5358515b4easo5887871cf.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 17:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792713901; x=1793318701; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VYZn9a13S6TtDgw1TWKAb1dfSFVH56WEpDEHomygc3g=;
 b=OPM1lLR6SE1UbRGP76CyZghs+udtvunr0sdEtEh3M1ECyzGVOlqpi7zxrSFVPOol+C
 OZcnpW8I289TL1SW3Cepy90/twlSvT9jTnSu8K4OCkYLDWpbRRskOX7EuL2ES2Ued7iL
 2GgpzDD29nLc5NDalhEVwQlUFxJuXPnfILLodVyfMKxQBupirnlcNk2TEo7X8h90zXx+
 QKYj6G71jGw3kZG8TNmcWobBwzXRx4UHMv7gspOkEsTElkKPjXTWT2YY9/XEIi/nslLI
 619dCV22+PKxvBLoakIvqE8Wt26aUmpwzsUyAb7N0wb5JxROw5BSCLMbaXimHJOl2Znu
 vx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792713901; x=1793318701;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VYZn9a13S6TtDgw1TWKAb1dfSFVH56WEpDEHomygc3g=;
 b=hzZB8E8GgtgpVOgRbz0+4fz22FQ2UsJwmD9QwNL1z+UI3t3QMhocSEW8Qd8UXdjqWE
 Ce5jII7fgu1g9ZdRMWx6e3gwSD8WpX+BMCbu5KIApQDHliPWOn5cXLdt9SgeKJPL1069
 QfR1Uod6J03fcKe7PMNPLaXTWduA2t3lKIfB8O5DGKWXu2GW+Ub8Y9maEZ+DETpDJhda
 tqKVGkIyEG4ccGMIou0UyxVHqwnDdnbkZvOTLTzsse2RlzpDOarlWIM6jf4w+yPuA3Yq
 rC0E0gwKrdH3PwOA63Duw4K8cyhJJmOgn78lZagBaA6ecAx+tMxzyzKvfBfo4LGK70p5
 2aZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKzm0HKSfG5mO7CU2AQgBFtspyFSjpsbYIhXLrmh/J4VNOzE05UYiHcZtT0lFO8MWQEmeRqOaitJak@nongnu.org
X-Gm-Message-State: AFq9FYJ4S/22mCjfk0GrfovMzbOhKsaj/J1Rd1+f3iGs/vXV7fl9Et0K
 HJTaofE1NmQ3xaRe2w1szvZRTGM777bKU8xpQx2ajaySZZ0c/+RqKlOYHHApcjs/uRDzPedtRFs
 QeYKOFbUDmmlKieyQVPEPa13KX7ndwuaUzwI3byCapzC5fCRAJ4E9qxlGwg==
X-Gm-Gg: AYBFou0HHHY6aGCROeRRFZtq8Ga4Oh+ZUaf5+pKRAfJPrKnjX0mremMKJodnHlpYCN8
 3w+ayrTKg71LbMOKLYvQE7NYWOAUy693lZ88lau6B6tHPkbYlU5j33aXKJMK3Euj8McYdK6P/3p
 Bxq7MgWlA7yPraqmvbVAV5wCM23DNAnx8SMzhqP2kECAvR1531aOWVos0yAXLVBLUHCQK//csMP
 NI2N9Cbuppg9wg5WHZ9ADCUCJhhoqE+PfAugdPBjcr7Vc11D7CxQPcxwNYdWaTyOcvBUb7yyZ75
 qSpfJA1IXFFPJzCsyHGriBYwbSE4Js8R6E41p3JoJkMcQZKk8rBu/xgEcECfQjcW2Nd5WU2KPkb
 3MrQ92NHY+CBB+HVA79URINAop78vXKEN3cXwHXczRlFCQWuqIIe1rloL212aVtSsWgdOTDL6CK
 1cLo0=
X-Received: by 2002:a05:622a:2a0b:b0:536:725f:24d5 with SMTP id
 d75a77b69052e-536c28cc75cmr6749041cf.52.1792713900862; 
 Thu, 22 Oct 2026 17:05:00 -0700 (PDT)
X-Received: by 2002:a05:622a:2a0b:b0:536:725f:24d5 with SMTP id
 d75a77b69052e-536c28cc75cmr6748551cf.52.1792713900355; 
 Thu, 22 Oct 2026 17:05:00 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536c18af234sm4842971cf.25.2026.10.22.17.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 17:04:59 -0700 (PDT)
Message-ID: <db423673-2a32-40f0-adab-07ccc816bebc@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 19:04:57 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/16] BCAIN do not merge - gitlab-ci: enable CI
 pipelines on forks
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Anton Johansson <anjo@rev.ng>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
 <20261022230048.2160400-17-brian.cain@oss.qualcomm.com>
 <9a2c99f4-5f6c-4509-a473-6a124b0daed1@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <9a2c99f4-5f6c-4509-a473-6a124b0daed1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TMOT5pJwD26gcjsp3ftW_1CIbH7WeLcB
X-Proofpoint-ORIG-GUID: TMOT5pJwD26gcjsp3ftW_1CIbH7WeLcB
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adaa4ad cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=B163mHFVUwy9kq1Px0kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwMCBTYWx0ZWRfX9ELupkIDiQvQ
 HL3BMgmAGJKSHIRXiGF0rKOIrL1ihGSBfHWLVx1cUnfw1XVrM+mPirF5uNgW+UjifjUPJ4xP13m
 O32tSTN/aWrttMkGtfR/GVQ8r71lEEU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwMCBTYWx0ZWRfXzmIuihnTcFEF
 1veMMyeEufjJRNV10hNDjxTGOfNIZzu+Na9+Y+5JUqVgdYcDFYwBi2m9R90hfx3VrKDyWL7b0Y7
 gcblYBD4aAxNGifKUzjGH825CfbKOkE4SFSTx01gbdHzRceI/GUIWvJwKhsBZPj2RKEc1P8QBST
 baF7DmXZA0xTqIdp+uCyJTEQgc4ET/nAIa3MQZ7KDtliuUmriXexwh+XTQAHl4eEZUCq6l6sw7/
 GO5T2u6703LukyfERMkiTE7TR0uvQk3oy9v+YqKB/CZ1cvQgzY6S2c+TmHqmmMpwDpqruY94GQi
 kyI5b01dvYc5G9U2GlkOYvD3muUDc61qA7QCdSOxNlp/4zl+QbCdM2qwFpjE2ALNPz17iEVnHo+
 7T6F0odJwkH6PgMH16I/KCd5KmHLobln5K7HlC20N88l05DAVXk+kxcZa0H3LPEobX3H3uithe/
 +e2igQWnhLA5szJpP2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230000
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 10/22/2026 6:57 PM, Pierrick Bouvier wrote:
> On 10/22/2026 4:00 PM, Brian Cain wrote:
>> Set QEMU_CI=2 so that pipeline jobs start automatically regardless
>> of whether the project is in the upstream namespace or a fork.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   .../dockerfiles/debian-hexagon-cross.docker   |  2 +
>>   .gitlab-ci.d/buildtest.yml                    | 58 +++++++++++++++++++
>>   .gitlab-ci.d/qemu-project.yml                 |  2 +
>>   3 files changed, 62 insertions(+)
>>
>> diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
>> index e07a2be37e2..39f647c743c 100644
>> --- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
>> +++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
>> @@ -28,6 +28,8 @@ RUN apt-get update && \
>>           flex \
>>           git \
>>           ninja-build \
>> +        clang \
>> +        libclang-rt-dev \
>>           python3-pip \
>>           python3-setuptools \
>>           python3-tomli \
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index b1e95395d0c..1f12a5f1f64 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -397,6 +397,64 @@ build-user-hexagon:
>>       CONFIGURE_ARGS: --disable-tools --disable-docs --enable-debug-tcg
>>       MAKE_CHECK_ARGS: check-tcg
>>   
>> +build-user-hexagon-noidefparser:
>> +  extends: .native_build_job_template
>> +  needs:
>> +    - job: hexagon-cross-container
>> +  variables:
>> +    IMAGE: debian-hexagon-cross
>> +    TARGETS: hexagon-linux-user
>> +    CONFIGURE_ARGS: --disable-tools --disable-docs --enable-debug-tcg
>> +      --disable-hexagon-idef-parser
>> +    MAKE_CHECK_ARGS: check-tcg
>> +
>> +build-hexagon-ubsan:
>> +  extends:
>> +    - .native_build_job_template
>> +    - .native_build_artifact_template
>> +  needs:
>> +    - job: hexagon-cross-container
>> +  variables:
>> +    IMAGE: debian-hexagon-cross
>> +    TARGETS: hexagon-linux-user hexagon-softmmu
>> +    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --disable-tools --disable-docs
>> +      --enable-debug-tcg --enable-ubsan
>> +      --extra-cflags=-fno-sanitize-recover=undefined
>> +    MAKE_CHECK_ARGS: check-tcg
>> +
>> +functional-hexagon-ubsan:
>> +  extends: .functional_test_job_template
>> +  needs:
>> +    - job: build-hexagon-ubsan
>> +      artifacts: true
>> +  variables:
>> +    IMAGE: debian-hexagon-cross
>> +    MAKE_CHECK_ARGS: check-functional
>> +
>> +build-hexagon-asan:
>> +  extends:
>> +    - .native_build_job_template
>> +    - .native_build_artifact_template
>> +  needs:
>> +    - job: hexagon-cross-container
>> +  variables:
>> +    IMAGE: debian-hexagon-cross
>> +    TARGETS: hexagon-linux-user hexagon-softmmu
>> +    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --disable-tools --disable-docs
>> +      --enable-debug-tcg --enable-asan
>> +    MAKE_CHECK_ARGS: check-tcg
>> +    ASAN_OPTIONS: detect_leaks=0
>> +
>> +functional-hexagon-asan:
>> +  extends: .functional_test_job_template
>> +  needs:
>> +    - job: build-hexagon-asan
>> +      artifacts: true
>> +  variables:
>> +    IMAGE: debian-hexagon-cross
>> +    MAKE_CHECK_ARGS: check-functional
>> +    ASAN_OPTIONS: detect_leaks=0
>> +
> Out of the modifications below, this could be added to upstream CI.
> Also, it's possible to combine asan+ubsan in a single build, and run
> both check-tcg and check-functional in the same job (or two steps, if
> you don't want to mix output).

Ugh lol whoops :facepalm:


Uh, okay, sure!  Maybe I'll do that, then.  I'll omit the "TARGETS: 
hexagon-linux-user hexagon-softmmu" so it applies generally.


>>   # Build the softmmu targets we have check-tcg tests and compilers in
>>   # our omnibus all-test-cross container. Those targets that haven't got
>>   # Debian cross compiler support need to use special containers.
>> diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.yml
>> index 72d02bc65be..fe638bc5fd7 100644
>> --- a/.gitlab-ci.d/qemu-project.yml
>> +++ b/.gitlab-ci.d/qemu-project.yml
>> @@ -3,6 +3,8 @@
>>   
>>   variables:
>>     RUNNER_TAG: ""
>> +  QEMU_CI: "2"
>> +  QEMU_CI_FUNCTIONAL: "1"
>>   
>>   default:
>>     tags:

