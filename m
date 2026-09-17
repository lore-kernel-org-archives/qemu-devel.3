Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0FCC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7FYy-0000vP-0e; Thu, 17 Sep 2026 13:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7FYC-0000VQ-PW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:05:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7FY7-0002Po-2M
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:05:28 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HFtFl42011091
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QpSOX1Ml1C28JfeCyezAtHptQqv70SAHwqg+eZn7Hzw=; b=T0C6qsxYyJ15EDS/
 13AQhC2T8sMXrvcWw7aF6RB7w352GqR2cQJaNyb+HQSvgii4tDRdR5Ljm1ClBx7g
 T4IA/lLozVyCu7C7d0GPdalAU42zJcAOiE/yFhFgYjsZ/N8U+dtX3VrI9t0AQUxd
 ckiPyx8BZeo4Z9XwseWplEDBSmVs5fm6IqCER8uW4Xw7vMHRZnpwm/k+8pk02kRB
 ZH9pttX1xs1tavLfMwFzqJ3pELqUXWifndDGf9jUJxrAHuSa3YVfP6MGuxp7T1Hd
 CxZsOw8UxvmFPtAmYwRfVkmvc3tgTBXuKlxy2GKuS55qOOUtVu2HUkWpFkb4N/St
 mGLSXQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grk97rbbs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:05:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so2422795a91.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789664724; x=1790269524; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QpSOX1Ml1C28JfeCyezAtHptQqv70SAHwqg+eZn7Hzw=;
 b=dJn1o8Rr8Dul6U2WbMwfdg4JpwIacJIdcvpIckOb2n/DF1bOaZNyUdWQu+32E2oVMk
 wfPpLQ+sLxT2mdNoKGWNlMf3S0W05wpY1OUsBQ6K8wqKD/UUq9Lop83kdbvDyUwA7wxi
 bGk657X2URCao+DTr3ZDl+MI2IjW1KNufv7meectjwF57ru5LRa8JVgVETlxWnTEaXtf
 9o/bSgkwOXeMuKTU1uJ4PhqPOhj4+RIEA8vX63egnBlzUps9xVoF7ZHu+jWhrp9DALRx
 9bzK0+DHFgk32Lxu+sYJzZX9ifGxpPOHJM8vzAgQCsqup1+OQRcrsFyYACZWoR6nJ6yC
 oI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664724; x=1790269524;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QpSOX1Ml1C28JfeCyezAtHptQqv70SAHwqg+eZn7Hzw=;
 b=IBZjwpFnfipRBdHebw+jbYnLmD86NIKGjidBmdWa1bxKfbzBgZXQgu1W/JYZ/dGmW0
 U+/fE8JBeAriJWhSKydbBcWKuz5nq9rVhXPObt+UwcU3MCDqw5MaD7EqRRnOeDSnvgsN
 8oD8aw6Q7XDp+hIgciBeU5OL1nc6+9SWfH37r3ac4c+jDJ9GYmiCYUNQSTTlVcAXt/lA
 dMYCwAne6GH2Wgn6DFNLTLH46NFDfK2rHroGoBBXiwVBQvQJ+U5Cuf5JjtJzhQnpms5J
 xdGAZw1LMh/wgDaz8pzFT/Q3lnD8ij+uibOsV5Pd/Ce5QL38l8Tiogy/XbTj5+i7F3AZ
 XT0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBws6W7T/H1aO8AVTJJxg0/FaMciXvncTS205OEFXJ5AjTnsAqdAKK+7MeiMckeSBf1yKGPt7fJX70+W@nongnu.org
X-Gm-Message-State: AFuF++k+za8/V2C2H4B+44AUHjk3Y7/spjnlSOxq+HkUca2JRs4xVvrL
 phFaxRP0G8E9rPdQtGHDlmwgZYPRnc07/Lb134cQQ4kFc98bIXQhGprSIm9pi6Zn5m8iG8CzDLs
 WPPBvc+6wAPCIBIQl53aTUZuHoZjmGlc3cUZVMDSn8vqtjJzc/t+AahwKlw==
X-Gm-Gg: AYBFou2qYqcybepO/v2drbCfXwLVVZNLv5yGer0iuARJXQ/nkM2NiEWe8aYSx+Irx/Y
 d1J7T1zyvx2eHN1V7+ChwdYsvmsNz3WRdJtoZWMsD1wqNFPKsqcB/I4mPhRPt4Uk+bA/y5cZmTX
 l7qRxct26vpFCuXCe3JIuJonIXWd9WkW2drMJYJGWCmcY2n49Lq7m4PS+bI3o5cj/Zsz1mM24EV
 dmXNG17q60O3LfcqHZthaFaj6naoUmv7Q3IEkYDujZ0XAAgG9nwwAOh0JL2E9N31VqhWg7waH2T
 tRNWWPfPRMXvkMwOqa+Yz44dkbn4Xa4siHo1qufYUGPqRMXEHry8be+H0pgZM4P7LZ6GvW2/9ne
 6orkSCUq4pw4YbQWcdDDo1TkQbgHdzbNxyBRrnw3h/KYDKjaLYw/XD6ZvdQkxqMKq5C+q
X-Received: by 2002:a17:90b:3d81:b0:39e:4c80:44b7 with SMTP id
 98e67ed59e1d1-39e4c805a10mr1869668a91.26.1789664724447; 
 Thu, 17 Sep 2026 10:05:24 -0700 (PDT)
X-Received: by 2002:a17:90b:3d81:b0:39e:4c80:44b7 with SMTP id
 98e67ed59e1d1-39e4c805a10mr1869615a91.26.1789664723931; 
 Thu, 17 Sep 2026 10:05:23 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5970b1fsm16516101eec.4.2026.09.17.10.05.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 10:05:23 -0700 (PDT)
Message-ID: <ef62c7fc-9db5-43f2-adbc-e86a805757b4@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 10:05:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/12] target-info: Introduce target_riscv32
To: luoyonggang@gmail.com
Cc: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
 <20260916-hw-riscv-cpu-int-v4-10-babc367b60f5@rev.ng>
 <f692f936-550b-4e5b-90ee-399edf21de73@oss.qualcomm.com>
 <CAE2XoE9KkW+WPWL1g4hzT6OtkQhfYvaMAopBW4NfFMkXn9hjzQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE9KkW+WPWL1g4hzT6OtkQhfYvaMAopBW4NfFMkXn9hjzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LOzz05W9 c=1 sm=1 tr=0 ts=6aac1dd5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=JwowQFh8C_k-kpy-o64A:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI0MiBTYWx0ZWRfXxPxBvshtBPRv
 aLTy0a31pyH74RTlI4MTmWxQNgGdN0KfRParnKIm1EiR1GJDy949PJ8HF1NNTSCExT/yIqKLq0d
 9hmUm34eaXrNeVx5wMCg6oZAJe7Dxx7+oSJbPyUu8C9fzMYgh1SPrSwcVoC2MOlwltGkyRX8rW8
 DPYg0dDwmA3wkZEagp4J9QSPDzBCKfQN/CNPkYxwACtjovDsHJM+8exba0YQzLkTmY+qE331BCt
 H/B0+OCGi1yoN28n2sSCZvOc7eKYAiOmBvaqlhqaD2dLcUHKfsesWEnjioaYKGfk21wrwfE2STR
 Ld+O/hMgXVosA9UHy7gG4eNoCfhHbsKW3B1f0fwIonlonRMw6p67is1d7at7cyYEC1lNXt6/+xU
 wXqxoPz5CRg6xUjDriel4AzYeJ2L1rukQoQXeEjbk/Z4jnYp+441JOc9ldOeWMnZrdcAY5WDslV
 cgH3s5DPzRA4YePbsyA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI0MiBTYWx0ZWRfX8GQKjZJV1QER
 Sy5VrOSW8sYhFkoz2XIq9dvim0r8w1X2ZU8shkMt9xoTeTqr3AFpYc86XRsy0NLPm9kuIOtcx7g
 mfTo13dlVVr4Be5d82fjL70qW/2oTHM=
X-Proofpoint-ORIG-GUID: IwZlIqabAR1Wra-Rc3dEdDntJb6FmrU9
X-Proofpoint-GUID: IwZlIqabAR1Wra-Rc3dEdDntJb6FmrU9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170242
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

On 9/16/2026 6:00 PM, Yonggang Luo wrote:
> As I said before, we need the `const TargetInfo*` parameter to for
> is_avaiable.  I've get all accelerator and i386/x86_64/aarch64/arm/
> risv32/riscv64/
>

In general, on QEMU dev, we can't block other series to do a change
compatible with a current work in progress. In other words, the first
merged wins, and the second has to solve the conflicts. That's sometimes
frustrating, and having worked on single-binary for more than a year,
yes I confirm it's not always fun to "cleanup" behind people patches.
That's part of the work though.

In this case, this series is based on upstream, which doesn't have or
need this parameter yet.

Also, in the series where you introduced this parameter, the usage was
object.c: is_available(target_info()), which is strictly equivalent to
what we have today. We asked what was the goal but didn't get an answer.

> 
>  single_binary_supported_targets = [
>    'aarch64-softmmu',
>    'arm-softmmu',
> +  'i386-softmmu',
>    'microblaze-softmmu',
>    'riscv32-softmmu',
>    'riscv64-softmmu',
> +  'x86_64-softmmu',
>  ]
>  
> 
> On Thu, Sep 17, 2026 at 1:03 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
>>
>> On 9/16/2026 2:19 AM, Anton Johansson wrote:
>> > Will be used in the following commit to filter machines using
>> > TypeInfo::is_available, so a simple !target_riscv64() is not sufficient.
>> >
>> > Signed-off-by: Anton Johansson <anjo@rev.ng <mailto:anjo@rev.ng>>
>> > ---
>> >  include/qemu/target-info.h | 7 +++++++
>> >  target-info.c              | 5 +++++
>> >  2 files changed, 12 insertions(+)
>> >
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>>
>>
> 
> 
>  include/qemu/target-info.h | 30 ++++++++++++++++++++++++++++++
>  target-info.c              | 26 ++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index 0620a3db84..560d589bcf 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -239,6 +239,36 @@ bool target_is_s390x(const TargetInfo *ti);
>   */
>  bool target_s390x(void);
>  
> +/**
> + * target_is_base_riscv:
> + * @ti: TargetInfo to inspect
> + *
> + * Returns whether @ti is RISC-V 32-bit or 64-bit.
> + */
> +bool target_is_base_riscv(const TargetInfo *ti);
> +
> +/**
> + * target_base_riscv:
> + *
> + * Returns whether the target architecture is RISC-V 32-bit or 64-bit.
> + */
> +bool target_base_riscv(void);
> +
> +/**
> + * target_is_riscv32:
> + * @ti: TargetInfo to inspect
> + *
> + * Returns whether @ti is RISC-V 32-bit.
> + */
> +bool target_is_riscv32(const TargetInfo *ti);
> +
> +/**
> + * target_riscv32:
> + *
> + * Returns whether the target architecture is RISC-V 32-bit.
> + */
> +bool target_riscv32(void);
> +
>  /**
>   * target_is_riscv64:
>   * @ti: TargetInfo to inspect
> diff --git a/target-info.c b/target-info.c
> index 9083b7bca6..a9fcd1c07b 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -250,6 +250,32 @@ bool target_s390x(void)
>      return target_is_s390x(target_info());
>  }
>  
> +bool target_is_base_riscv(const TargetInfo *ti)
> +{
> +    switch (ti->target_arch) {
> +    case SYS_EMU_TARGET_RISCV32:
> +    case SYS_EMU_TARGET_RISCV64:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
> +bool target_base_riscv(void)
> +{
> +    return target_is_base_riscv(target_info());
> +}
> +
> +bool target_is_riscv32(const TargetInfo *ti)
> +{
> +    return ti->target_arch == SYS_EMU_TARGET_RISCV32;
> +}
> +
> +bool target_riscv32(void)
> +{
> +    return target_is_riscv32(target_info());
> +}
> +
>  bool target_is_riscv64(const TargetInfo *ti)
>  {
>      return ti->target_arch == SYS_EMU_TARGET_RISCV64;
> 
> 
> These are the helpers I needed, that are very important.for subsequent
> work, otherwise the latter work will be repeated again. and split 
> target_is_* out again.
> 
> Those is_avaiable should use target_is_*, that's differ from 
> target_riscv32 and so on.
> --
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo

Regards,
Pierrick

