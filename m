Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3463606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dLIJhaFA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eGMC0xmh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2ew-000279-N3; Thu, 22 Oct 2026 19:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK2ev-00026x-1G
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:57:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK2et-0001nw-Cv
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:57:20 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MNa5561083053
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LI/M8vgm8+jARMqex7tuM253rqhIo5Eg2U6VmeaVAfM=; b=dLIJhaFAQS7LmTw2
 PLZUHzg0u4vxQYM4Z5jktbkAC/4y+fWnkS3QExmpD/vIVHphqQx9pI+9Tqbo3Icm
 jGmZvwvF5vH5HAOjOj6sRJQ71l9gDCRYUopgSYLoVtbkDe29FpViFl+KTwcUS4SJ
 ZCBNhf0k8ggeWXa6yrX7IpVda9SUIzqoWSeyrhSF18OvsWbe5TARAV3UpMC7Po37
 geyby5EXJlqNWchdkTpKcra9qkoKkkQbF1lmC0/JcVLs0Mi/OawrEVy9aitX5x3a
 XonGOuHvELqQvJPc3A92aseK6tidoIyA+issZEL+vbsz84D9aVrEndwQFbgkd3+7
 UBzjrg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw1ksf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:57:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd3e7a65fa8so176280a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 16:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792713437; x=1793318237; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LI/M8vgm8+jARMqex7tuM253rqhIo5Eg2U6VmeaVAfM=;
 b=eGMC0xmhmVPuqtjQ2D4TeeWCD3q/h2Z8DENfjW/ScK1udtKeVX3Sb/SQci/mEtG2so
 kHX0foXcZxDSVF3pWTDsquwCIbjiS4yimFArBWITCloBYwHTpelw5ECD6cJK0el58Lc2
 L3YNwSztiMV9drDgS6Z7TsNZ4wKyDTO6Qi3w3KJnIoE+Q+4HqJRgPpvRQDmDoM7uDzf0
 ZcOPw1kabcr4sm2CM+PvCzzJ2y1Xi8bT0jNDiGPAtuduspnu9lRuNoHuwRx+D+lDCTNa
 NzZ13/MgMuC/wp0EG36MgY/0Gma9kxykc0ZhG7PXmMRO0q9ck/JnYmAtTxm5hnFN394B
 0c9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792713437; x=1793318237;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LI/M8vgm8+jARMqex7tuM253rqhIo5Eg2U6VmeaVAfM=;
 b=lU2roPC7xawg7b4jQCGMJ4DTONFqAHSlbTTVt/k+SStZ2a9KEF1LT0bAF529wBuCOp
 0CBfWJlTnKX7Hb9hNDJIGXE3EPoJQ1b33GqKqnIyUudTv6uGQwTMaj/7RkoXCu3xOCcI
 2gZxz/y4Lzj+f7LCE6IYePW1S4WMMLAqMJ3oMdvjDNkW1XQbaxNuvQpybmY9cfQBFuUk
 y+r9lUKScWI5QlY4DapcFc7M7TUnZs4abYVXolPctc7GnZ5JU2S817D357u7Ie7chDBI
 iNUOT7inyoDnrq/owbNkTGMzzqbQZARw+lBqGon4f4QD9g1fxVWo/be3QTOy52XThhsb
 4HNw==
X-Forwarded-Encrypted: i=1;
 AKwUvByiwpvdX9tTR2Tid5wczRX3UcCR9chrLBD26KSPheqLFaMf+qQZkpyaJuk4pjMAju9jSRyN5NOhC4nW@nongnu.org
X-Gm-Message-State: AFq9FYIkAdD1PPQyviapgzSqrM2oK7iK4oQpEDCveCqgjt3GsaqKTdS9
 JeY7OoCD5xq2dnIkczcQD4ObkP2mMPV7qFJF9VT6Gkq8Wo8woTK+s/qVO/TegfpzOS1KDXaqvAv
 jkulrEwi985IFAylDlfH0kK1Rmnr1ZgTuU5IGZnyPKcIb0EVKLSiVCvQBKg==
X-Gm-Gg: AYBFou2uZu7a/ZIYprAPv84pXBTMDUw3doPmbbyGXkXZAzJJL3ITAqRtqERjf3yk4xG
 MAM/np4uqHUi5DEqIiwjqN5/mzdQdqRV8QSzVqkz+49p/LpqHebZ6BR4WXAMGe9ZjZmnNuWMkO9
 h9cK9hhdvtG1+RB3arRoSZEM7G68jLsOuVGMb1WStcCVsDkUz+itw/OibQHmQ3ihCjPFDHBUHbJ
 mMv37szBfd+KmTWXz2DEb1WQBoo7/GcoYDlax+6T6TCGX6FsMU3tWWBps34v7Rih/vytRzONN7N
 Xd1i9fufrDzuW+/cXA5DnOENBVjfF/uw1SXHhqb1+DrK3QHKn5QbnDv+lzLq+cE6OPPQJlDlV9S
 uEK8qrz9KpWTl/UIbeUuCYx3hUHBWVAD/xJ+MnKnE+INEd/f8VogeklipHSXMJ65fnLaSUQ==
X-Received: by 2002:a17:90b:3805:b0:3a8:59d3:530f with SMTP id
 98e67ed59e1d1-3adce0df541mr393549a91.57.1792713436794; 
 Thu, 22 Oct 2026 16:57:16 -0700 (PDT)
X-Received: by 2002:a17:90b:3805:b0:3a8:59d3:530f with SMTP id
 98e67ed59e1d1-3adce0df541mr393536a91.57.1792713436284; 
 Thu, 22 Oct 2026 16:57:16 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada49314besm6095600a91.11.2026.10.22.16.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 16:57:15 -0700 (PDT)
Message-ID: <9a2c99f4-5f6c-4509-a473-6a124b0daed1@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 16:57:15 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022230048.2160400-17-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IFqpYdwrgTTXWtCPtku_xlC9Rgnk1ItA
X-Proofpoint-ORIG-GUID: IFqpYdwrgTTXWtCPtku_xlC9Rgnk1ItA
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adaa2dd cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Rqg3d0ghmPrR7fqlHcoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX+Yrk9hqRHnmI
 Wx1iS9s5mlbkQxXKFPBiSgSkxWH27CTxfLDK0RY556HtwnKAmz0RHPTjFVRxUbUmC4hIJ8/W75H
 CWwEnQk6c9qu1177CcRjVnUI7TxvbH4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX3xRO5i0AE4Ek
 Ic7rmiVNNaVBBsW05deS2xitU0pMgqoPRKUEtHwVMNBJh31nBxsyVu/fEWz9fnSZ4p6UleHEsep
 fVGLrDq4TTuegeSx7WVsO4Mpvp6ImQg0UFEF0axCtzzdaUARcp1km0ako3lW0Ufrrrp5VvVGQWI
 WCfo0wjbsdNXseOr9I29HlH2id5gTRzccfpabgMo1DKkFQ62tl8J8AzvyuuSiLMlRspLH/guyX0
 t/lmimMqQiOYHYqu1IgI/hCY5BjssdVFJXF8+zzN0nLopxB8YtBHQfmeBHP421IEB7EApGqKfVY
 nIlHISaUgYWru7je/5gHvwzGv+I9yeM3/aJqkBD6fOPjwyJ74R0hraltaaS5CWQustyu+NIusSw
 9bhxjNEX9dGMFAjoVfNnioX6lYbABeJy9xqf6rpjIQKRU4OK418F4JMijjLII5tU18zbvJj6+5q
 GEf0VGlRY5NlX1G2Guw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220095
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

On 10/22/2026 4:00 PM, Brian Cain wrote:
> Set QEMU_CI=2 so that pipeline jobs start automatically regardless
> of whether the project is in the upstream namespace or a fork.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  .../dockerfiles/debian-hexagon-cross.docker   |  2 +
>  .gitlab-ci.d/buildtest.yml                    | 58 +++++++++++++++++++
>  .gitlab-ci.d/qemu-project.yml                 |  2 +
>  3 files changed, 62 insertions(+)
> 
> diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
> index e07a2be37e2..39f647c743c 100644
> --- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
> +++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
> @@ -28,6 +28,8 @@ RUN apt-get update && \
>          flex \
>          git \
>          ninja-build \
> +        clang \
> +        libclang-rt-dev \
>          python3-pip \
>          python3-setuptools \
>          python3-tomli \
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index b1e95395d0c..1f12a5f1f64 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -397,6 +397,64 @@ build-user-hexagon:
>      CONFIGURE_ARGS: --disable-tools --disable-docs --enable-debug-tcg
>      MAKE_CHECK_ARGS: check-tcg
>  
> +build-user-hexagon-noidefparser:
> +  extends: .native_build_job_template
> +  needs:
> +    - job: hexagon-cross-container
> +  variables:
> +    IMAGE: debian-hexagon-cross
> +    TARGETS: hexagon-linux-user
> +    CONFIGURE_ARGS: --disable-tools --disable-docs --enable-debug-tcg
> +      --disable-hexagon-idef-parser
> +    MAKE_CHECK_ARGS: check-tcg
> +
> +build-hexagon-ubsan:
> +  extends:
> +    - .native_build_job_template
> +    - .native_build_artifact_template
> +  needs:
> +    - job: hexagon-cross-container
> +  variables:
> +    IMAGE: debian-hexagon-cross
> +    TARGETS: hexagon-linux-user hexagon-softmmu
> +    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --disable-tools --disable-docs
> +      --enable-debug-tcg --enable-ubsan
> +      --extra-cflags=-fno-sanitize-recover=undefined
> +    MAKE_CHECK_ARGS: check-tcg
> +
> +functional-hexagon-ubsan:
> +  extends: .functional_test_job_template
> +  needs:
> +    - job: build-hexagon-ubsan
> +      artifacts: true
> +  variables:
> +    IMAGE: debian-hexagon-cross
> +    MAKE_CHECK_ARGS: check-functional
> +
> +build-hexagon-asan:
> +  extends:
> +    - .native_build_job_template
> +    - .native_build_artifact_template
> +  needs:
> +    - job: hexagon-cross-container
> +  variables:
> +    IMAGE: debian-hexagon-cross
> +    TARGETS: hexagon-linux-user hexagon-softmmu
> +    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --disable-tools --disable-docs
> +      --enable-debug-tcg --enable-asan
> +    MAKE_CHECK_ARGS: check-tcg
> +    ASAN_OPTIONS: detect_leaks=0
> +
> +functional-hexagon-asan:
> +  extends: .functional_test_job_template
> +  needs:
> +    - job: build-hexagon-asan
> +      artifacts: true
> +  variables:
> +    IMAGE: debian-hexagon-cross
> +    MAKE_CHECK_ARGS: check-functional
> +    ASAN_OPTIONS: detect_leaks=0
> +

Out of the modifications below, this could be added to upstream CI.
Also, it's possible to combine asan+ubsan in a single build, and run
both check-tcg and check-functional in the same job (or two steps, if
you don't want to mix output).

>  # Build the softmmu targets we have check-tcg tests and compilers in
>  # our omnibus all-test-cross container. Those targets that haven't got
>  # Debian cross compiler support need to use special containers.
> diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.yml
> index 72d02bc65be..fe638bc5fd7 100644
> --- a/.gitlab-ci.d/qemu-project.yml
> +++ b/.gitlab-ci.d/qemu-project.yml
> @@ -3,6 +3,8 @@
>  
>  variables:
>    RUNNER_TAG: ""
> +  QEMU_CI: "2"
> +  QEMU_CI_FUNCTIONAL: "1"
>  
>  default:
>    tags:


