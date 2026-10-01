Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C63CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEie-0006fS-Q4; Thu, 01 Oct 2026 07:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCEia-0006ex-JH
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:12:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCEiY-0005pf-8K
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:12:52 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xmS71661068
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 11:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mjU1zgIqCdOifyq4ANWvguLxVIoQF5yPoPPNxz6Ts44=; b=ABpWgK0L+ifNQFTs
 Jr0vmCpILitcm1aIXx9iV/Q88LRfZ0+Azy3DrJPgxdi2EKz0CPRjwVqhe5mQqzzy
 a+WRJCfqAocRNhxJJfA+kniWNPxhSbaxnDmAiMU3mII3xZ5PIwzJFFQKDPoS423I
 oS2OJJnjbh655GeKISLo7WDpEq4Gzyzx8cPImdImXNw7NJNAO2ktp9Czt+fTYB/Q
 2D7NFZ4VHXWVI9xdi4CpzCIFiuo8ClxLe5sdv82bpPVw7pJEjEi5c3tOCflFdXu0
 laAPTH9lWXyQ77Dh6vlPy4fVGBM+Kl5ukzk128MPBuvHg+zX717IXK0PEyF5D72y
 ak8W/g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pm5yu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 11:12:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ca4a2b9c4so333399985a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790853167; x=1791457967; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mjU1zgIqCdOifyq4ANWvguLxVIoQF5yPoPPNxz6Ts44=;
 b=jY+CqsAhyfluHXmlkdTp0Cp8QZpVfyH6rUGesEcc6HfPA6p2vQI2Rw2o3ffyhLuT/1
 0Nfw38wU4ys7QVMAZIVzjTmaW0LWzD2DOoML4uikS2dZCF6Wq03Q34pDuiWHLaMVGj0n
 zwyrP3sQuslhIC2q/eEMzzKKBSOqebxzE1g6/ftJbDC8ZNAoON4IrFmd1XdrbGQeBkLq
 j5yi/nE7/uVqaMi46Rj6vQxzMnEGk6lpSG8XoWsjmZhN45qfM5XFY5CCPRoQ1L8gO+eQ
 a3bTaO6+c6R1IThYEdjgM6vzM+unyms7Vqj42csxBRbggYiJZlUqCdifS+7KDGTvGrht
 XKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790853167; x=1791457967;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mjU1zgIqCdOifyq4ANWvguLxVIoQF5yPoPPNxz6Ts44=;
 b=1YEsem00eMvwsxCwQYuwljm9rJIU2f2YNQh9V+oOOJhfsXc+aPLuiSDKZG2bsYPViO
 IE9DQNBLHygBwUGwMsColzs1FhnPGf/mv8fb7ZEn+6dLC7J7Xgpa/diSjofgOCwklfIu
 zXh8EdH15n7MQQgbnPsJ5/zXxEAgVxArpthbmEas5jsmGp67WiJr/yKgCYg1vVwfsXBL
 s4M6KKeEYXfCh1ZMjmNXTJx6Uqn3MaK9AhAAlKqnrY9Eidk6UtQAK39VYSu9BqhoO51l
 PUaOMHB9Jwompd15jeGtGw/ztWm7VMfp4hutQNtFt3VvifKsHkNcfk7Utn1Yeve1cgVN
 7rSg==
X-Gm-Message-State: AFuF++mLjcoPrzz9N9FJwVC9zc/15z4N/Sxxrqklk7IYQFOmcpN66/vr
 RVCslPXN9z0isgmYvUNYa/1HZJ/naE2omyvCJ7JvNMZ34gZlN+sXpEwOn3Cgd9ltjJiqaN0uo5T
 tD1M9d+AqURVWYxSbV4D7URIbSqLel++ejCn23kLfsy8z3pI+L7wzvbQS+Q==
X-Gm-Gg: AYBFou1pmb9K7rzh5K2as87MXMBiVobl8Fxz7s1B2KZrcl9tvxyjDoLDUiVVFECO9RK
 K3r+Lkjcq35f7vKTB65EyXhaiERNk782Ic9C6HFOwyAaWDEGQiLTljsAqOFOy9iBtKU5dHCl6/u
 DD8kX9OLDv4iOU2B6UEFYKLiot60ipl2iqASIrZ6v1N9FVkT3YBrHYjxMosDM8yuqdBhafkyEVG
 ks2PRpVPeY2HyJ+PtK4X9LwNU2jU6C2kJuF7gZc5y3/Ndxhv5k8jwEQcPhXD5UDN874uxF4N9IH
 QOxw9go3K0l6qu3wvb9StxbhR/uJSKmidIjIqjqaFvLQXL9hL4ctOBQMpAIKouv+7JOtmPcNQm0
 J9L/yeuNYLmlF+3NSTVzJasCzDsZGlmFXvA==
X-Received: by 2002:a05:620a:1d05:b0:93a:3d67:391f with SMTP id
 af79cd13be357-93ca95da7demr812472285a.7.1790853167237; 
 Thu, 01 Oct 2026 04:12:47 -0700 (PDT)
X-Received: by 2002:a05:620a:1d05:b0:93a:3d67:391f with SMTP id
 af79cd13be357-93ca95da7demr812466285a.7.1790853166657; 
 Thu, 01 Oct 2026 04:12:46 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068ff95esm5287609f8f.12.2026.10.01.04.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 04:12:45 -0700 (PDT)
Message-ID: <9925dc2b-fa08-4025-98d9-3efbd2ea2388@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 13:12:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] target/arm: Kick vCPU after updating PSCI power
 state
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
References: <20260930174946.82195-1-philmd@oss.qualcomm.com>
 <20260930174946.82195-10-philmd@oss.qualcomm.com>
 <CAFEAcA81kUriHYPj2EBNYiBsJUMmgknCGRif0q0cc5sndro2dg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA81kUriHYPj2EBNYiBsJUMmgknCGRif0q0cc5sndro2dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OmFX6c-0a7LOKsvgozNBM11um-sKabq-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0NCBTYWx0ZWRfX9HqbHaZ+gtXU
 VEyscAVP8n5PPJDlFnYw8apappNCACvE+PttfjkQEUc0c+Rf0Pu4aAiThU1X1QjnnLGBh/AwMlQ
 gya8wfTVyISvngZueOJuGmfxSKU7eoA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0NCBTYWx0ZWRfX4w198ROAIC0Y
 +MRRGqrtvPGkNAV+nkHJ1lYqhQH82bk3ByIatAUpcjedMnSUr+xZtL8wPQO9HDa3A1RyyGrVM6v
 ccIDFbYP6H4VCen308JHym2Y1vhlIBYySvfjwm56GJFe1N0rYbHFiNtxty2KDknCLHCoNQ7Uvfr
 tVinK0mnJJpU6G+bTLUB8/ETgcXPKi+GPmCm4d04s4VBvrp+cRg1o84GA5vxemUP1RaOl0rsYxR
 ShR8K8qs84zcT24PngJw4AOKLwZrV8CFkFk85RiwrEFFJzAcv/JfxwroEiisemK/JVn8bwtXJLd
 xKN/reT75GA4bQLSL0AxsOsk3H7/qUi025gqaiiy8Rm9eIfX5BvUR+Y0mFIQwn51WvEs+uiPS65
 TlEIFU4U2M0I/EvCnpASqLVc30PxY7kiydEVA6ByQz5a6Fuz9beVvHKbjaVIoCzI9RtP1sjyVZh
 VP+xRdt6mVs5hcv+3ww==
X-Proofpoint-GUID: OmFX6c-0a7LOKsvgozNBM11um-sKabq-
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abe402f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=u2Ol0uY6ccU20tPPq4kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010044
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 1/10/26 11:53, Peter Maydell wrote:
> On Wed, 30 Sept 2026 at 18:50, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> PSCI can update the power state of a vCPU other than the caller.
>> arm_cpu_has_work() reads env->halt_reason to decide whether that
>> vCPU has work to do, and is called from the vCPU thread without the
>> BQL held. A remote power_state/halt_reason update is therefore not
>> observed until the target vCPU is rescheduled, so the vCPU stays
>> halted and a PSCI CPU_ON of a secondary vCPU can hang.
>>
>> Kick the vCPU after changing its state so it re-evaluates promptly.
>>
>> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   target/arm/arm-powerctl.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
>> index ef14a1f8a94..1ba5277b023 100644
>> --- a/target/arm/arm-powerctl.c
>> +++ b/target/arm/arm-powerctl.c
>> @@ -48,9 +48,14 @@ struct CpuOnInfo {
>>   void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState state)
>>   {
>>       CPUARMState *env = &cpu->env;
>> +    CPUState *cs = CPU(cpu);
>>
>>       qatomic_set(&cpu->power_state, state);
>>       qatomic_set(&env->halt_reason, state == PSCI_OFF ? HALT_PSCI : NOT_HALTED);
>> +
>> +    if (!qemu_cpu_is_self(cs)) {
>> +        qemu_cpu_kick(cs);
>> +    }
>>   }
> 
> Looking at the callsites of this function:
> 
>   * three places in arm-powerctl.c call it from an async_run_on_cpu
>     callback function which runs it in the context of the vCPU it
>     is changing the power state for
>   * target/arm/cpu.c calls it from within reset for the vCPU being
>     reset, so we definitely don't want to kick the vCPU
>   * target/arm/kvm.c calls it as part of the "sync the vCPU state
>     to/from KVM" function, which should only be running from
>     that vCPU's thread
>   * target/arm/machine.c calls it as part of an inbound migration
>     to set the vCPU's power-state to whatever it was on the source
> 
> So I think that in the cases where we're actually running the VM
> the if() check will fail and we do nothing anyway, and in the other
> cases (reset, migration) we don't want to be kicking the vCPU.

Indeed... Paolo identified a possible race problem when discussing
the generic sync changes around has_work() so I ran to address it but
failed to correctly audit the call sites for the ARM case, and this
indeed does not occurs. Hopefully the new comment added in commit
fbf08c0fbd5 will help reminding we need to be careful and not try
to protect unreachable cases.

Thanks for the audit,

Phil.

