Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F9ACD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpVv-0003T4-Cv; Tue, 12 May 2026 11:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpVt-0003S8-Hb
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:59:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpVr-0000Qi-7i
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:59:16 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CAkdXB740351
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DjwqEz+H0NYZAlT+8JCAf6E9WAUja7TU16Gn7AzA558=; b=iCPAGeOwJJ55C2lW
 s219ndGMYzE+R+QBUjJlRZkeEy3bmUpB3cQmLY7OoE1MOyx3O88ddYSyIpIJaYXJ
 WArwAiwNESKaMa4Ren0n3uAFV8SeGWnMVHToHw+rN0Q8d7f7AxQEVwBbVmwsCGWt
 afa2ZOlK6bAA9wqcZz/eWMCTzvUy9DxDIuIssFaIIO7uSzOQHc/EktVF/BaBKVKY
 AyBtED5M6ptMd/RdH4twJT3by+PrFa+uB/ppOAqoQCbx6mTi5Ru2dZ7Z22F1WgnG
 /TOPVwgZsDRoWNozV/6ghHoprk9RwNvM1mKS9hLQUjacKVIqPg4Q7RBmoD6Cr2BS
 B6hHlQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e42rhs9q7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:59:13 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12dd33dc337so3806186c88.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778601553; x=1779206353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DjwqEz+H0NYZAlT+8JCAf6E9WAUja7TU16Gn7AzA558=;
 b=G9ealkBgVwgxXEUSZ+CwlUvbGjL6hGAo/xs9F7a/7gVQUwNcS5hEdMJXVjkFnfjkNY
 uxxhmmY/UvoKVuSRSQ9rnt/ED1wrg74im66yaurdzAjGTt2C1Fy9PFTnSAqAu/qnp83w
 2QJprXhHGaoUq7ZO1TJW9PpiGnzQ8xMH4430+QKLPS0fEzogL2lsMFAbO46+NHCHEJ+e
 EecVB4GmAYj7rRftc2+M19XeVwgXNPOqLegKvSlWQql+JyPH2OhNS7fIsZXzrMbakNO/
 /qm4lbqRNofaJmIUlbkdZ71GDYlTA7pUm+ujvwgPwfNRX+vXjccA5RcyDmkr/X4qBI5k
 GICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778601553; x=1779206353;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DjwqEz+H0NYZAlT+8JCAf6E9WAUja7TU16Gn7AzA558=;
 b=b5x4Ud6jZlJikog+0+m9mrSQfrpFiPaUA4r+h27BFMymORY7QRZFQ7ysJd42ao0cmF
 laFyDsbJZy1ryqrynZrdHTqpLM6touIMrhfQZ1ALxxcqmRL7B4xjbRgsyeCZx27ERqoy
 o84v1HG1csnarUheHodV+vxki4gaogp4aZem1/fwkruMkBBHPiTmFQpx8XrXTn8B1Ckx
 Pj84rS3Fc0Uv9tF5aFNFCnb2PLEutb/Us/+LJAOYJkds5tOZjeeNaYePR+s722A8m9dl
 /oOYo6nA5Nkaa38fBf4I52FiAp6HJS9FIJGM2d2dyazJYeJ0e1J0R4I/JzFSbOJ4403K
 3m7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9yLQvGIqjHOCNEFEuw5fK+2CF/MC2mqQ/B6XTiaFak1sNWOagtXLCiCe/+heQ8SCQGt6BYNMNUAfIa@nongnu.org
X-Gm-Message-State: AOJu0YyFkOFTjs1KTBRFWpqZkPy2xqXwWkm9O680/8t8mdQInms4Xuv2
 FGbmRe6xELBc/2T5MG1fkhyG58Ah5p4SkY57BaJO1kGF+yvY8SbfwQvFIh0wAFZsB/BImgOZp/L
 0/cmUOusYGKkJjG9ggA9rJWRCPUZdfNsp8UAlHaHHcHUTSrBInjg2kfxVIw==
X-Gm-Gg: Acq92OEkdXYtM1D621RfIM4VlE9eGHIDl6lzwAoMC1IflxqRJ2OaGZUa1bcLRUpS+/4
 ychiHsMLEk+WiGWglK+9Hu25Vx/yjjU9oPS8Ms3eyP1Xsn3d+xSjw+2ti5Aj5qcc1O6csCwUpfI
 FFmdxLIDlripz0Ir5rdw+6Z5X4L5f90D/cxqQOgNQunapUgOKSLt38KUChqyPQ2gViDXS5G3TA3
 n3VNmIY8vZB0EVMlFC0n5FAUBi68BywxYFlEy4WHkGfx+7jwCjA3G78tgJggtooGbJiV10wWjoP
 2fOo/VsTEuGhjPVyISiwFdTDQWg8TVljo9GM19NNIc5As9islNyDzWbuLQ9deD1kDsAziM6FUoI
 oCfCFyT25gKi+TXlyJGcX1YxT2ph1mRMwi/ZyIIlotmafgBJXVK7iHJjA+Ow+MFjlA2vdXj27I5
 FyhB4o0XVheqNLzg==
X-Received: by 2002:a05:7022:423:b0:128:d396:f2ea with SMTP id
 a92af1059eb24-1333b0b1fb4mr2665991c88.11.1778601552747; 
 Tue, 12 May 2026 08:59:12 -0700 (PDT)
X-Received: by 2002:a05:7022:423:b0:128:d396:f2ea with SMTP id
 a92af1059eb24-1333b0b1fb4mr2665953c88.11.1778601552059; 
 Tue, 12 May 2026 08:59:12 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13278210ff2sm19741438c88.6.2026.05.12.08.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:59:11 -0700 (PDT)
Message-ID: <ee6cd468-3212-4050-9482-896ea8f916d6@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:59:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] gitlab: add jobs for thorough block tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-16-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424154205.364268-16-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2NiBTYWx0ZWRfX3nIVsM9fKXV5
 paWJBEcb8UeAHN9dawrQCXVWBub8jxsizTO+eFgdUafMCnLDHhNMSduduWBXSdMmJyRoG0siBAx
 CshfqB26er3Pw6BJVOR+2P7YUIpglVT6SRxVesLrcBk0c3nEXjRysgaADXTuDMEbF8cynyhgFIg
 +WynZVsRfXwlMUrB6KPET96/8Z2FGivI4/VK1Vnm9UU65cE9hdEF2c4MPP2N8hyVsWgy31vUnGK
 aH6a7hLNYvP1Kd/gSggTASJMxVvnVz5s4fSv0O1TwwBkmzuIIZ24ZOJm570lSb+NXt+wgtL95bN
 A2sQGw0Tafd+IwKAS4FyoDK1GFGLfXsQvNo2A2n9V+IJe/BIn+cVTGVsTBR1jub2ndxAi5Y3cM2
 v5tpMKlueZT/vNYq+uPgA8BF9F9JbKzXX//Vufi4H+tEJoaMK+0q4BJv0cQD3ICxKYgXmT/wamW
 f5GZJcL+i80CpG/Z/HQ==
X-Proofpoint-GUID: tL39t5zDdWYZ4aIsuiW-HV-6IUj26Is3
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a034e51 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=YKFVMrpXtpmcPPOEZukA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: tL39t5zDdWYZ4aIsuiW-HV-6IUj26Is3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120166
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

On 4/24/2026 8:42 AM, Daniel P. Berrangé wrote:
> CI is only exercising the qcow2 'auto' tests currently. As a result we
> get no exposure of changes which cause regressions in other block format
> drivers.
> 
> This adds new CI jobs for each block format, that will run the target
> 'make check-block-$FORMAT'. The jobs are separate so that we have the
> ability to make each format gating or not, depending on their level
> of reliability.
> 
> The 'centos' image is used to run the I/O tests since several tests
> have an implicit dependency on x86_64-softmmu, and thus break with
> other architecture targets. The 'centos' build job is the only one
> that creates the x86_64-softmmu target in CI. Ideally this target
> portability in I/O tests would be fixed to avoid this limitation.
> 
> There is currently an undiagnosed failure of job 185 with the qcow2
> when run in CI that is marked to be skipped, reported at:
> 
>   https://gitlab.com/qemu-project/qemu/-/issues/3270
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/buildtest.yml | 98 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 4b1949a3a5..d4591d30e9 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -174,6 +174,104 @@ build-system-centos:
>        x86_64-softmmu rx-softmmu sh4-softmmu
>      MAKE_CHECK_ARGS: check-build
>  
> +
> +# NB: block-XXX jobs use 'centos' since that is the build
> +# job that provides the x86_64-softmmu.  Some I/O tests
> +# are currently buggy and blindly assume characteristics
> +# of x86 (such as PCIe) causing failures with other arches
> +
> +block-luks:
> +  extends: .native_test_job_template
> +  needs:
> +    - job: build-system-centos
> +      artifacts: true
> +  variables:
> +    IMAGE: centos9
> +    MAKE_CHECK_ARGS: check-block-luks
> +
> +block-nbd:
> +  extends: .native_test_job_template
> +  needs:
> +    - job: build-system-centos
> +      artifacts: true
> +  variables:
> +    IMAGE: centos9
> +    MAKE_CHECK_ARGS: check-block-nbd
> +
> +block-parallels:
> +  extends: .native_test_job_template
> +  needs:
> +    - job: build-system-centos
> +      artifacts: true
> +  variables:
> +    IMAGE: centos9
> +    MAKE_CHECK_ARGS: check-block-parallels
> +
> +block-qcow2:
> +  extends: .native_test_job_template
> +  needs:
> +    - job: build-system-centos
> +      artifacts: true
> +  variables:
> +    IMAGE: centos9
> +    MAKE_CHECK_ARGS: check-block-qcow2
> +    # https://gitlab.com/qemu-project/qemu/-/issues/3270
> +    QEMU_TEST_IO_SKIP: qcow2:185
> +
> +block-qed:
> +  extends: .native_test_job_template
> +  needs:
> +    - job: build-system-centos
> +      artifacts: true
> +  variables:
> +    IMAGE: centos9
> +    MAKE_CHECK_ARGS: check-block-qed
> +
> +block-raw:
> +  extends: .native_test_job_template
> +  needs:
> +    - job: build-system-centos
> +      artifacts: true
> +  variables:
> +    IMAGE: centos9
> +    MAKE_CHECK_ARGS: check-block-raw
> +
> +block-vdi:
> +  extends: .native_test_job_template
> +  needs:
> +    - job: build-system-centos
> +      artifacts: true
> +  variables:
> +    IMAGE: centos9
> +    MAKE_CHECK_ARGS: check-block-vdi
> +
> +block-vhdx:
> +  extends: .native_test_job_template
> +  needs:
> +    - job: build-system-centos
> +      artifacts: true
> +  variables:
> +    IMAGE: centos9
> +    MAKE_CHECK_ARGS: check-block-vhdx
> +
> +block-vmdk:
> +  extends: .native_test_job_template
> +  needs:
> +    - job: build-system-centos
> +      artifacts: true
> +  variables:
> +    IMAGE: centos9
> +    MAKE_CHECK_ARGS: check-block-vmdk
> +
> +block-vpc:
> +  extends: .native_test_job_template
> +  needs:
> +    - job: build-system-centos
> +      artifacts: true
> +  variables:
> +    IMAGE: centos9
> +    MAKE_CHECK_ARGS: check-block-vpc
> +
>  # Previous QEMU release. Used for cross-version migration tests.
>  build-previous-qemu:
>    extends: .native_build_job_template

You may want to use a gitlab parallel matrix here, since it's basically
a copy paste with driver name changed.
And either you can set QEMU_TEST_IO_SKIP for all of them, or simply
remove the broken test from tree.

Regards,
Pierrick

