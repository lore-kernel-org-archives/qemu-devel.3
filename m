Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A1DCD4F44
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpP7-0000zv-Lq; Tue, 12 May 2026 11:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpP6-0000zT-1Q
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:52:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpP2-0005AX-QL
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:52:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CCA3pt144552
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fMn5psT7Lu6/rN+9Lz6JiNYtGD31H+QBdEB2xGIrf4U=; b=ISPJfWaXUYTA0b80
 6Uzk5B5L93nomN4CINPJmXjbRA/u+JWiBmMvjZ4TZYRRDW+CMK+cBDW9E5uxu+tK
 tMp2yqb2Yi146HVXZZnTZYT1Tqz8tzwaJjkRFQn9NlOBB2L88hZolKRwHy0l6v5a
 0X0y7309KIl3S+uiMehpR+8Y0qv/ftDKS9iNnghXeFdeIT4kPP6QD9yCs8arcLWm
 A3e04RPzr6aWE9X0qJRXFjGxKCwxCDegZTNcPrU0lB7hh78bA5cPJJxr2mQNLhfl
 FD8oSiViQOK/ITypm3q8uQxwdjECwAGfe8Abp4JhGU6ZTln0Fd7CsOW+Ryy6OveZ
 VmBnRg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43yp8uq0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:52:11 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2f2d983d109so7572145eec.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778601130; x=1779205930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fMn5psT7Lu6/rN+9Lz6JiNYtGD31H+QBdEB2xGIrf4U=;
 b=jQltthwxr7sTTVkEDCeLfYKGNBS/C7sqWRZS9w1n4GuDDf6nIKBd3r0Ml8Ni7WCL6g
 nbarV1D2bHEOM/ClsRtLJ4YQt1DercrrNG81S3UIIMI5Jv1Ng45i2glZ4oPw16NfEUb1
 d18uDzGFqPIUGulVRoFhNoq0eEcQMFvdtxaJzS815CwZxac5WsKtk8FhMaRFfFbwUZ/j
 QC8ZF0Uv4qajjK/iqSZN3ymhsyInUF/wAc/CKbpjuCe05uoOOv7S/6Ia2f9bX/Bkj1wk
 17AVh6gmQtDT+pRNEYfR8AuWvRzkKUQePHBmRKU0FEEu/DUSjzBxVkBIucCvMeDJE5td
 WW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778601130; x=1779205930;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fMn5psT7Lu6/rN+9Lz6JiNYtGD31H+QBdEB2xGIrf4U=;
 b=DO+M6MYi9aDTZigz/igjgOssKZtPCcjGdj/ws7clvrBFQczCe8sgsJITSOMCvIk9CN
 xWwRF8tLONpSsqT6vb0gO7BH1xFrMghCZs0ERhVb60exTy5ef65t6h6Qy32SXeIF7wP7
 NqrQEwNzZQAARbpr3f+z54ftm98qbV+7x6/BDxChSq5NW8iL4PauwGblM6jHK4ey7xK8
 +8rfSGowEtiZwJdoqgMS37qHCsjwqr9QwHkongn2+GT170/6S76lj/VtPFM9ZZqm8XKW
 40fXYyR//YmySVTO0o+xfhH+iX5gTcdGuaXNdnHumEZNichkqTyUeEFTbkVt3+4Nfwup
 TQ1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DjmJScgEZM3Luq0jFdr08HekcstEo8uIEGa1Y18yivriU+5ce1kSBBK2R192KdX6z5Hd6OC1O+4kL@nongnu.org
X-Gm-Message-State: AOJu0YwC7SVWHryHJopD1rBov768XaWnXy4kbbA/BeTvAQq2FbFlclWr
 gG9iTRTdaYGqwCNtmQs0HK+reDMGEY5H76QY57JBQVdTdAVzKt3V0pKc53BvWEHStjOyFw1/1Du
 AuiJ7N6NYfBQwPmGCnnIpS6OLiso1BCuy8NHmqF/TfnPwdpUrZ2ZeyoXyOw==
X-Gm-Gg: Acq92OFlYhsPOf7JORIZypgmEqPLQgOYKHvUWNwoWn+KieTzsa7JnBcIHJJIZ2l0+zW
 WCWI69j7cnONj6gidNzrJYnArxp4h8BWVV6kilJdcyUCCMPfKa1qvwf0mLt9Oaq0G2mj2LFmegs
 BXT3U+xeOXfdC5MAqucJG1v7AHTNfaPm6bQqFX4E6sOPs01xlu6Zr/9FwonOumdFFabikh6Zfee
 u+RytUJ3XDYue3a5nqQhrdvuZc6mWlcyXhfvXFSbw6qtVQNm9nIszLD3H5oFXVX1A8NeUh9sQ7m
 4La6ephbW4Ld59MwO7/OoA2/+r8NOwvdJ+tQPl4k4tYP6s9R8XpD/98NMQ7jz9wca9Vcmam6w16
 maix2XzWjwgVCJ1WUZxcZjvnP3GVcoCdxe0gN75aLByVc1YoizpbFByTbm3FrgwgMYrJQ0JzbwM
 1K4Bm+0gvQeRQBBQ==
X-Received: by 2002:a05:7301:1291:b0:2d9:fa9c:87a9 with SMTP id
 5a478bee46e88-2f85bb73889mr10123572eec.5.1778601129907; 
 Tue, 12 May 2026 08:52:09 -0700 (PDT)
X-Received: by 2002:a05:7301:1291:b0:2d9:fa9c:87a9 with SMTP id
 5a478bee46e88-2f85bb73889mr10123530eec.5.1778601129192; 
 Tue, 12 May 2026 08:52:09 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859eafc2sm23050266eec.4.2026.05.12.08.52.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:52:08 -0700 (PDT)
Message-ID: <79eb0bf0-a814-43dc-840f-cf57c2545ed1@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:52:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] tests: use 'driver' as collective term for either
 format or protocol
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-12-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424154205.364268-12-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rjH2c1HQ7WUXI1Rl_6I9iLkhflcXpyAT
X-Authority-Analysis: v=2.4 cv=R5kz39RX c=1 sm=1 tr=0 ts=6a034cab cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1HMigtOKAOQ8PblGD4wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2NSBTYWx0ZWRfX/KxrjanAswnh
 Tl4vcZm8vdIKJyOjxYSn3HkYDxxDJ1PC923POtLjVwkcfLJbfMKwXTzmBxta8TtwCuwMsEbwcFu
 Nf3a4UtMmwAJNor/g3/hJZAiwiCTPzgPQWeMoQO+Am3DImA/E/7H7AJT4qStTPx3XsT6arlHBf1
 vGHlZgR6hv+54bAuFVSlJwF6IoHqYLEoMD05gUCVcPSfif39lRyhGmmCctuMrAORzbk1GSIrUfX
 /8xWAUZYtK+5jxSXQo8QDpPc3j3wkBrvbozUmYNKWqpFuIrrwYHy1FOlt0qCw1uDuWnIKVhaOGO
 bAPrToyIpWwJpEy1mYp9g1j1uOrJjGNxi+RPtoW9+aGj+oAr46VbdIKPGvjo+0lWVQo7ejeTlD/
 Kjsm0R9pu46WBLl5tMILEQB+99CqaSMwIll6OPJdUks7R8KuqsgLGLX7jgjbbXtluCbxW+4sM5H
 Xb0h2YhRbm0HYfQ+SNw==
X-Proofpoint-GUID: rjH2c1HQ7WUXI1Rl_6I9iLkhflcXpyAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120165
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

On 4/24/2026 8:41 AM, Daniel P. Berrangé wrote:
> The I/O tests integration previously exclusively tested block formats
> and now also covers the NBD protocol. Replace references to 'format'
> with 'driver', as a generic term to collectively apply to either a
> format or protocol.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/devel/testing/main.rst    | 13 +++++++------
>  tests/Makefile.include         |  4 ++--
>  tests/qemu-iotests/meson.build |  6 +++---
>  3 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> index 8067d0a3ed..797111009a 100644
> --- a/docs/devel/testing/main.rst
> +++ b/docs/devel/testing/main.rst
> @@ -222,7 +222,8 @@ check-block
>  ~~~~~~~~~~~
>  
>  There are a variety of ways to exercise the block layer I/O tests
> -via make targets.
> +via make targets for a selection of formats / protocols (collectively
> +referred to as ``drivers`` below).
>  
>  A default ``make check`` or ``make check-block`` command will exercise
>  the ``qcow2`` format, using the tests tagged into the ``auto`` group
> @@ -231,14 +232,14 @@ only.
>  These targets accept the ``SPEED`` variable to augment the set of tests
>  to run. A slightly more comprehensive test plan can be run by defining
>  ``SPEED=slow``, which enables all tests for the ``qcow2`` and ``raw``
> -formats. The most comprehensive test plan can be run by defining
> -``SPEED=thorough``, which enables all available tests for the formats
> +drivers. The most comprehensive test plan can be run by defining
> +``SPEED=thorough``, which enables all available tests for the drivers
>  ``luks``, ``nbd``, ``parallels``, ``qcow2``, ``qed``, ``raw``, ``vdi``,
>  ``vhdx``, ``vmdk``, and ``vpc``.
>  
> -Each of formats also has its own dedicated make target, named
> -``make check-block-$FORMAT`` which will run all available tests for
> -the designated format and does not require the ``SPEED`` variable
> +Each of drivers also has its own dedicated make target, named
> +``make check-block-$DRIVER`` which will run all available tests for
> +the designated driver and does not require the ``SPEED`` variable
>  to be set.
>  
>  See the "QEMU iotests" section below for more information on the
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index a820980bbe..a063a1d60f 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -14,8 +14,8 @@ check-help:
>  	@echo " $(MAKE) check-unit                    Run qobject tests"
>  	@echo " $(MAKE) check-qapi-schema             Run QAPI schema tests"
>  	@echo " $(MAKE) check-tracetool               Run tracetool generator tests"
> -	@echo " $(MAKE) check-block                   Run block tests (all formats)"
> -	@echo " $(MAKE) check-block-FORMAT            Run block tests (only for FORMAT)"
> +	@echo " $(MAKE) check-block                   Run block tests (all formats/protocols)"
> +	@echo " $(MAKE) check-block-DRIVER            Run block tests (only for format/protocol 'DRIVER')"

We had two words for this, now there is a third :)
I would suggest to remove format/protocol at all, and assume it's called
a driver.

>  ifneq ($(filter $(all-check-targets), check-softfloat),)
>  	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
>  	@echo " $(MAKE) check-tcg                     Run TCG tests"
> diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
> index 744d0b6e88..5d6b0b5ed9 100644
> --- a/tests/qemu-iotests/meson.build
> +++ b/tests/qemu-iotests/meson.build
> @@ -12,7 +12,7 @@ qemu_iotests_binaries = [qemu_img, qemu_io, qemu_nbd, qsd]
>  qemu_iotests_env = {'PYTHON': python.full_path()}
>  # If altering this definition, also update docs/devel/testing/main.rst
>  # section on 'check-block' targets to reflect the changes
> -qemu_iotests_formats = {
> +qemu_iotests_drivers = {
>    'qcow2': 'quick',
>    'raw': 'slow',
>    'luks': 'thorough',
> @@ -33,8 +33,8 @@ endforeach
>  
>  qemu_iotests_check_cmd = files('check')
>  
> -foreach format, speed: qemu_iotests_formats
> -  # Formats tagged 'quick' get the subset of tests in the 'auto'
> +foreach format, speed: qemu_iotests_drivers
> +  # Drivers tagged 'quick' get the subset of tests in the 'auto'
>    # group, run by default with 'make check' / 'make check-block'
>    seen = []
>    if speed == 'quick'

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


