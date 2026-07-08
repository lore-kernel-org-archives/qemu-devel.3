Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17660C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUuX-0008PO-Kj; Wed, 08 Jul 2026 12:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whUuV-0008P6-Ge
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:14:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whUuT-0005Lr-F3
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:14:07 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668Er9M13101286
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 16:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TvDSfoTgarbwyjwzB//6b6MH2PRpXnMRAk6KmZq1CaU=; b=OA5UTGkByRJK92j7
 u3rv/2CvsySyMgrTvKbi+OqwkTWoszG1Yah087PLcH9oDsIQpV8kRYgQrTrj0xny
 LN6P9mMAJVgdOYbuxL9muahwBl7NBDWh4KFawNuoS/3qFopGNJBNjEfK/bQJ4p50
 MHDqn9/3yEL5oiL6lqMxJKgpKdOc+wONgxHE14Xzjr8bf3q5ReiC0cA4iHf3BUFg
 ezj9h31FeWQ82uyEYUwg/nDrUXkVxvm0YhSm9RkGaWlZMhmqUskoDfa1nC5vHdLf
 dp9ANooN4bHLqQ4athtzOeI3aEInciR72A3FgRHtSfmXG99jIxnRq8Zmj0tXhCWQ
 X6jAUA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9rq30cws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 16:14:03 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so891922a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783527243; x=1784132043; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TvDSfoTgarbwyjwzB//6b6MH2PRpXnMRAk6KmZq1CaU=;
 b=Zhp6wh43nW0FEp4iqC4phdwSxBfWone42Z6IQyyyHnjG1y4qxczTjQte3SZd4BsKnx
 59L/C4a+rolEED7mEMBfrXK+lWc4YnKBQ5yCTu06FQorMtm/6RYRrrAipYBW6GJuudHl
 g+0sB4E/etxkdZB0aQ74Kyufct8y5ZGJPUmMMTsXSrIkwgfXcUGBqTG7303ZRq+xAsAd
 0WDaT5NzHvwdpJMs36ZCHTB5QsB7v6vWdYIPWrAzWQxKvbu7Za1TO5Z5gCdIG5b2db2X
 gck9ef8b8hPlLEhSGpK3e1Bo/Cv8ID/IrQqihuykgmLitbSCHAhOBq+ySk9/IrT3261P
 WBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783527243; x=1784132043;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TvDSfoTgarbwyjwzB//6b6MH2PRpXnMRAk6KmZq1CaU=;
 b=JDoxp0Wj3cX1EmKCkqKWRiumQH4zrs1b/uZXVbjSSJS+ADRrhLVg4/TrLUbH1xYUwj
 FojtaxzznjSz9AuqasukuvGtIaQ+R9r5SIXf72/7WKJU5J5AuHXZ8iKq6Hp5jk0JRDWF
 D04zGL2p4ostgzyav+6D7jOMWKyfagAn6fn/dxnPqrz7ybQZ0CNpGkTNRPGKdOFD8kGc
 +6IMbJUZLuIyfSz/Rk9mAIt7B3xhRIoyQYQ/KZfbydJIFbOTxT+RgmXbmQsdV9i3m10P
 tsZLTOxNUZbOF38UHGPEQieK09FSgi9Yv9hHn9L912AAb0dt4jQGKitTLDhPFd0NeVzg
 5PJg==
X-Gm-Message-State: AOJu0YyqY71ubEXnaTFAhdClSfvjrmBxVk1P7eEuDFU8AT5pARzCVRsV
 3t1Vw4YLAprUveZFnZvoMRkjmoziFuSsLWUpAFT8ezhpTc3w3kU60atTlC+KXYwZjJfKRWUpckd
 oK/6/DREgkD5OleiJ+UYdjF0R8BhANYnsltosX6EDPB2cnVv0wruntrAHPdjMAqqcYQ==
X-Gm-Gg: AfdE7cnAUnt1s+cj9Hzv6vF/vM0Z7BWhUV4lw2VLhOSXoEHAdPKD2bwlzhohQ1QG+9L
 WniaE+d1mlkFR2iHW7PaZdveYgdaPz0gdjoaoCIvPYIPnSmig/wPpzrpfOTEn+CCuMFl0Sd0E3h
 DXyfetKoMWQxD8UgjA991b0gKBS+nO4x9QF2mpIhEFgtnAmxm0P0bTM8k0KGx00F0p/ML/zw018
 7DANAsiFAleHTo3QZp/eOnz8QJnRQjnxiDb53bNZWRvAKyltXsd7C0La274CyvBlm5MjDve9eok
 a4sXwAeBKDRTyOh5hmHUmAipIyf3ju8raa7PHq3Q+33PK/6JgFPN5zpBievmDJXJGSIdUCARDYo
 UgChH7VixTNQLT+MoRgEKFOAjQkcYJwHbyGtmQMq6MltKjMv1RtJpXWDVbNZk5g7z2Js60YzZH9
 JB7AY=
X-Received: by 2002:a05:6a20:c998:b0:3c0:9c19:b278 with SMTP id
 adf61e73a8af0-3c0bcc9d063mr3694631637.70.1783527242752; 
 Wed, 08 Jul 2026 09:14:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:c998:b0:3c0:9c19:b278 with SMTP id
 adf61e73a8af0-3c0bcc9d063mr3694591637.70.1783527242222; 
 Wed, 08 Jul 2026 09:14:02 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f5982sm23603642eec.5.2026.07.08.09.14.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 09:14:01 -0700 (PDT)
Message-ID: <253ec762-5325-4b11-bef3-07cc2b9eaea6@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 09:14:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests/docker/dockerfiles/ubuntu2404.docker: add
 missing apt update
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk,
 richard.henderson@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, mjt@tls.msk.ru
References: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260707214655.1138626-3-pierrick.bouvier@oss.qualcomm.com>
 <ak4H9Tn-t5rRH3oJ@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ak4H9Tn-t5rRH3oJ@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qlrzsMOfMh_1eGcNdocUFfP1Sxv4DYD-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1OSBTYWx0ZWRfXxcd8cg0tdMO7
 +jS+fGK74pT4LPsXYPYDiL1yvObgnkwTDFtjNHxdYUu93rzyBYldDDJAcrG538w1Al5rPlWPq4L
 z82dpkmuYSQdDhGyf6TEIbqSxgmj0Nw5DinQJbtJ5WURvprFyF97u3fnnlDkW4kp5En4vgHA8Wz
 7U63yBvwsVR8aZsyH3izR9qixYaPaXsZX1//Y2Hi1qOuU+sEl/2e9cfBW7lCqxQ9bziqInLdy/7
 clJRTDD9ZgKwlgCgu8RsxjuIz3d0kR6t5patXiF1L8r8MQTTF0AOb7FXD63twKG3oFNb6ZfIcNc
 F7pAwTfEZwtFnsKQXNP2XZwCaKak4i2wkwSG3yVLJHqLnhBQ1SNa7rzpq1QOMrOKpludPyUlqW2
 mvwwnKjuDjyNkf3tHUgnx96mGtiTqGkiPAFIKCvLSw5JH0S7NbDe40pNiCfgvNDUXlXhnDwluX3
 yaUytGMVz0x52yuZrlw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1OSBTYWx0ZWRfX2KZovwfW4tDR
 BlyXX81352S1Jrx7NXjAqdX18bsnqiol6uTwTZ2+DrfrhX5L+Nh+vUqZ6ta4BwOwL00OFm1MmLH
 QaL9mDL1ExougXnYgT/vs4/91cophSM=
X-Authority-Analysis: v=2.4 cv=PYPPQChd c=1 sm=1 tr=0 ts=6a4e774b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=n6MYwUk4AAAA:8 a=EUspDBNiAAAA:8 a=_EqNZgDTBKu0pThHyhkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: qlrzsMOfMh_1eGcNdocUFfP1Sxv4DYD-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080159
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

On 7/8/2026 1:19 AM, Daniel P. Berrangé wrote:
> On Tue, Jul 07, 2026 at 02:46:53PM -0700, Pierrick Bouvier wrote:
>> RUN statements should always use apt update && apt install together:
>> https://docs.docker.com/build/building/best-practices/#apt-get
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  tests/docker/dockerfiles/ubuntu2404.docker | 3 ++-
>>  tests/lcitool/refresh                      | 3 ++-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
>> index 26bc2dd94f4..27992e34fd9 100644
>> --- a/tests/docker/dockerfiles/ubuntu2404.docker
>> +++ b/tests/docker/dockerfiles/ubuntu2404.docker
>> @@ -160,7 +160,8 @@ ENV RUSTC=/usr/bin/rustc-1.83
>>  ENV RUSTDOC=/usr/bin/rustdoc-1.83
>>  ENV CARGO_HOME=/usr/local/cargo
>>  ENV PATH=$CARGO_HOME/bin:$PATH
>> -RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>> +RUN apt update && \
>> +  DEBIAN_FRONTEND=noninteractive eatmydata \
>>    apt install -y --no-install-recommends cargo
>>  RUN cargo install --locked bindgen-cli
>>  # As a final step configure the user (if env is defined)
>> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
>> index 1fdd37440c9..bbbc6d3c46a 100755
>> --- a/tests/lcitool/refresh
>> +++ b/tests/lcitool/refresh
>> @@ -157,7 +157,8 @@ ENV RUSTC=/usr/bin/rustc-1.83
>>  ENV RUSTDOC=/usr/bin/rustdoc-1.83
>>  ENV CARGO_HOME=/usr/local/cargo
>>  ENV PATH=$CARGO_HOME/bin:$PATH
>> -RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>> +RUN apt update && \
>> +  DEBIAN_FRONTEND=noninteractive eatmydata \
>>    apt install -y --no-install-recommends cargo
>>  RUN cargo install --locked bindgen-cli
> 
> So lcitool already ran 'apt update' earlier, but if we're trying to
> avoid caching issues, I guess running it again is needed. Should we
> also run 'apt dist-upgrade' though, as already installed content in
> the cached layer can be outdated.
>

upgrade/dist-upgrade are not needed, we just address the packages
listing issue, not the fact they are up to date or not.
In fact, if you want an updated container, the good practice is to
rebuild them from scratch. For our use case, it's definitely not needed
as we don't have security concerns to address for local containers.

> With regards,
> Daniel


