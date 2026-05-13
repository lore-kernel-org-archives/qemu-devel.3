Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD0FCD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 16:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNC1T-00012D-Uo; Wed, 13 May 2026 12:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNC0l-0000vH-5t
 for qemu-devel@nongnu.org; Wed, 13 May 2026 12:00:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNC0i-0005qU-IG
 for qemu-devel@nongnu.org; Wed, 13 May 2026 12:00:37 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DF0Lxo3474767
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 16:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 knPXEx5Ka5VRSqLBzFIWmi9dY5I0NsUVH15STdOW+Q0=; b=O+hpNwZBzRGOb77s
 bBMhk7MMgHavvr5kQrv6QBxZ+YDyvu5QOPiREX1Jg9zzc8MQ59o4XkU/UvWPpsrW
 zgvdRdhF/aO1cq7YZxEmroPRl/JgNV3N7j+Yffl6LedND1Ow/AQ5/YmuQl7zx3RF
 Eqolyjd7zkKyCNgHDTMom+oWA3ozOeGZTtp9hXUaQ/KHQLfP2FxLoPH78Sr2dIDY
 SEJJUKncZk7alg+mye7WlpUJRjeKGk6RuLCsnhhUvtlySau51OKIGfAxn3E1YHHU
 VsHMcysmqnw66LVgI7THe0PeR0lcTuzow0FwTUBoCPwY6mItwMGdB3WYS0X2EQEq
 QLEasQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p419pq0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 16:00:33 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-132d631edaaso20015849c88.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778688033; x=1779292833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=knPXEx5Ka5VRSqLBzFIWmi9dY5I0NsUVH15STdOW+Q0=;
 b=azr0cBK3TM3SH0YYm74Y2yLpWhjR6P8EoaXOx2ePz95YKGQY82aklrYFTWDnXKU1Ps
 vSEx4QEzM5W0AnyR+8x4KENt3o/wyDg13yuqP7v1b7wMIakP8vLoRJe6+HfU6ckuhMUr
 QHvVXjyW0UHSid1gjcDNSa4nvUF6Ap2N2JpAL/fbeTnoIJJQ+60ZwrNhodpOm7UOGZ93
 hwh6MLsrLL/SwHCWm46mWt+FldLJFLo+MAE+jLk4niMTIGeTvh2HjInyUAftTZYUb+fy
 rMJE7o/deg/HAh567Nr3Dh1GpULYULHYZSW1TS6L5gmhH9fH7GpaOz3HciBBXuWgTN/1
 WBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778688033; x=1779292833;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=knPXEx5Ka5VRSqLBzFIWmi9dY5I0NsUVH15STdOW+Q0=;
 b=lo6aTTCDTGzEgvq+uVDa0wBHcbVm/h/Xpg8zYIwf0OmTsZZbUnXnN5rKfwQ9c4cDPC
 YXwHrjo67mzbHfyM6MSv36Qn9pu6ICglOcByuMtv0TBL+mxbyGZn+5TGyRUbtmuoxvsR
 vKwNf1AseNZnXt1IvKaHqEgOHxRl0NOP4DUpFTTnsdxoD0HVrQM+eqjjfzOYQSd2Yokb
 WskprQ5vNlqnNWZZLz7YZ4YvXkqnYyXysHidVKx2Npc9bVgDasisZHfwVE0VqRuEE94v
 lUFQMwtYrNQLL4WmMO/Vwrc8qkfPRJBv9FEZhuWb8AOnW4TU7Y56TkGRGMjzkHCk2XJD
 rF0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/By83cprqb5J0j1DzBhm6sSjWCzRt4vLX9APL0eOI4ASCrSgwZwTs99X72YVUOu46V1n8tv3KCSy9p@nongnu.org
X-Gm-Message-State: AOJu0YyfBLFRNGckc0Ik74F1HIU0ZuKGPaGDq8MVmyXoAK3vjD14i7cY
 P4l8fBwnEhJRDCI76m2hCNxC6Dh8idrJGxndjB1AjRHzN8/JRyUZu3WUOKeLI9tJJojkzBgdLES
 ECeR6+OEdDOQ/vFKTKEPhqMgW4q72ucjymxnXcxgp2TZsQZLVOYK7E4LzDQ==
X-Gm-Gg: Acq92OFLtQdG0Zq6pLfKDvjST5GhT7uQza6fhGLHxDTGa169j9e7flnPfj+8O3oO+3w
 3r00gJE8HfVh9tA8JnX66dCWk7fGsQGzSAASAmjWqpzzdtJG0ohBuUhNjwah+Y62sru0bAQQF+J
 1dionhQJ5sRwoAZ9DBCTc41l1NVI+hbkPCRUSSAadFFebtizKKq0uR8gvTnFy7akuZWf5eIhOG9
 G26qO0TaIMf6k9szFyFwr4B8UpJAdpMpkzpPE/cMf+VK3uSN7Yw5zduy4+4HEZmbDwQ2loayq74
 fa7zivliXOdKfDtfFDvbb9vu0VcFN9HAW60iastfYKQdherSVY+BcSctgCUXqybEYCfEanIesBD
 vT/GkTyH2NmOk5If7MdWJ/VbaEk6Nw2rkE5cEnBQ5h9Xz6VhbrPfNkL7iXsyZ3Wy9ECasVmuTO/
 ziE4LhPWcIiqAwSw==
X-Received: by 2002:a05:7022:23a3:b0:12c:6a24:a24f with SMTP id
 a92af1059eb24-13436aa59a3mr2203862c88.33.1778688032304; 
 Wed, 13 May 2026 09:00:32 -0700 (PDT)
X-Received: by 2002:a05:7022:23a3:b0:12c:6a24:a24f with SMTP id
 a92af1059eb24-13436aa59a3mr2203817c88.33.1778688031518; 
 Wed, 13 May 2026 09:00:31 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132787673ffsm31019427c88.15.2026.05.13.09.00.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 09:00:30 -0700 (PDT)
Message-ID: <7729d729-a0b5-43d4-ba25-1b734faea269@oss.qualcomm.com>
Date: Wed, 13 May 2026 09:00:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/16] gitlab: add jobs for thorough block tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20260513120003.226790-1-berrange@redhat.com>
 <20260513120003.226790-16-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260513120003.226790-16-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=df+wG3Xe c=1 sm=1 tr=0 ts=6a04a021 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=rRvdW54NBwtAPlD0LRQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2MiBTYWx0ZWRfXzsyN11ybJmiv
 RnbjPldE237FdBXvzRy8hdDZS/gstrvNMU1rAb6gdg5TBL8U8EW/qL0selw/blgtVSFn9TnowKG
 VXdCiQxbKTwKI6IuaYHYH7gi12vqYRfwdV3aYVvtp+M8RsUApx6BPCgtbMV5HPop/0H/ue1NW9F
 wy9aXBl1veEaslpJHvtt4zW7hudXu+y6lE9ogmd021X2euMtQE/tf4cLZcK1wwsfStH9pf5IbRJ
 17Gi3jyXcf2mohO5FAcsyFl1G8XqBWLIH+2Qyfh3WvG7iiRMxAEd5yPJitMh36YYFgle5dP+2Hf
 CQEgUqsd18kBLIHMPIrVxxOzSoqUy1HzBjnLTdOZX7cgJay46Aj0Olg9H9vZ4Z4mnAXc3NiqMMo
 R1mD79oFZO3UZ96sgOXSyP43Q9lOpo8EoTgv/ZyBfuUIDPYiNY6QC7dcq06P1rkEZ3Z2Qp3mXI5
 zXW9zc7vc4s+Cfz4C/A==
X-Proofpoint-GUID: 3Qm4dKX61S0ZRnFlbi1bvIga9cGq5hbY
X-Proofpoint-ORIG-GUID: 3Qm4dKX61S0ZRnFlbi1bvIga9cGq5hbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130162
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

On 5/13/2026 5:00 AM, Daniel P. Berrangé wrote:
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
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/buildtest.yml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 4b1949a3a5..cf0281ecd6 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -174,6 +174,24 @@ build-system-centos:
>        x86_64-softmmu rx-softmmu sh4-softmmu
>      MAKE_CHECK_ARGS: check-build
>  
> +
> +# NB: block-XXX jobs use 'centos' since that is the build
> +# job that provides the x86_64-softmmu.  Some I/O tests
> +# are currently buggy and blindly assume characteristics
> +# of x86 (such as PCIe) causing failures with other arches
> +
> +block:
> +  extends: .native_test_job_template
> +  needs:
> +    - job: build-system-centos
> +      artifacts: true
> +  variables:
> +    IMAGE: centos9
> +    MAKE_CHECK_ARGS: "check-block-$FORMAT"
> +  parallel:
> +    matrix:
> +      - FORMAT: [luks, nbd, parallels, qcow2, qed, raw, vdi, vhdx, vmdk, vpc]
> +
>  # Previous QEMU release. Used for cross-version migration tests.
>  build-previous-qemu:
>    extends: .native_build_job_template

All good!
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

