Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB4606A31E
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qvy+j6Jq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FSlUUusr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSdEb-0000yz-9u; Sun, 15 Nov 2026 11:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSdES-0000vt-FJ
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 11:37:33 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSdEP-0008M8-58
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 11:37:32 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AFFAvF64018834
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 16:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b++bwHxLjskIcni6HUhpCgY3sGssq+uOABEIIMb8JIo=; b=Qvy+j6JqAUcyvMCj
 2Fx1XQEOn41MfA4GDi7C3sJmbHFSbVDGLm4zBXTZAmknEIKdZZXN+vFPU0DO+u3H
 WhPUqAND0U369DujPcbxHoVAHLj16sD5i7ZT3vlCHW1SSuILCihXz77JR87z2uyT
 Kq5aFXyYjlzJEUolMvB3LV05kwOFZJSHYS0PW74G2nLLnYBy8XfyDQWkhgq7IJ2t
 9t3aAkIwKDeKes7cRPPPfazatSt+eZaDZOpMN6v5Xo9HqK1wWsuC94MWo+yaFfyV
 hUoP66SHd4VyftTjWyfd9tygab4koLETfpgH/CFGwByX2FcL2wxYYwutY0pFoHGZ
 FLv6UA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhduaxy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 16:37:22 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cdd769cc9deso1302182a12.0
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794760642; x=1795365442; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b++bwHxLjskIcni6HUhpCgY3sGssq+uOABEIIMb8JIo=;
 b=FSlUUusrhUGXdGW4KxGdZagtBIRkXzid5Fi/8W35yBegeodDi3o43HPt9KhV1ArnoK
 TZw1qi08aYAM7vSDwq2u7OlhtC1DaFz1C/XSvo6XRFaO13gmiMq3Ogpcruw7xmcODE35
 c13/C+DSJShFluRmyA+t43LGsOa5pOPQoxDJwZ8WzkmUC9ferMMng/oS/BS4GRxZgpnM
 mCcuyecDXecAy78m5nk7VPCLsnH+XK2prGc37zWOYehAF2uHjmJX95jbf/Xz8S3lgv8h
 5PXds4kxWGQzKaL/nFD44miBgXDR128+R83a4fbm0OCAvzyQr+vhcp5A8xzCxosl1erM
 mtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794760642; x=1795365442;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b++bwHxLjskIcni6HUhpCgY3sGssq+uOABEIIMb8JIo=;
 b=ICo6SrRZIJeqdvWNyg42Pt9eh6T47w+c0Aja6XObeXrRy2nCvwbr22JLdoSKVxQN/0
 TuTq6Jo9XFasO2w07dcRR7sKnEGK5aNqYZVBtvhFU6sPtPC2TI1O7ejnOsFNrco72+yY
 8VMqYYrl7XeXQm6xgDg4ERIP5cy4J2JGVUN/ur0OLPD4KDK9b0+47izFmz0aPoaQqFu0
 XA3KpzXnUpNXM0dda9v7Vk6dTzY/467LNL9OdjKJY1NK/u3ewvAFa8RGwFxb0eWg92/t
 dwP3yxG8R6FhF9Fml4hZE8eE8yIePPrEqLulXgW5HKWIthNp+/vAjrPQ7q6QcwUhPPuF
 o7pg==
X-Gm-Message-State: APuU4Z+ZK6ku528+IWAQvQoHcTM1+R62+/POpXr/P2di6MQpH6c+jQEi
 I6fMq8P2ehy42YaNtXXqfjIdJpMwbBPrNByeAnAS8lgfVaZXYb6TxcufVl4kmHSDslvhwbRrmPO
 qP3nuqkg90fpyA6Kf3gCoBccNY4eme2iIUEBixDgeVCcO7xN8SFKu0Rlsaw==
X-Gm-Gg: AYBFou2/plCaEU8Lm6529QVDPHbW7jpGHgSEQTzqzQpg/2ZNkr3br26Ob5ApmXDZ+0e
 JTUb26cvkLu69XDbjBSUfdHaebRNamm6uMg4eBBmulUHpVxAI4es/h3xdLkWQMcD4P/bi3Yn5mN
 ZqUJn7dp0tzJDAXpR/uMGTjkIcSOUE293RsdbHd4BsKLOJ52HS3iISzpRS5mp7yaReUSFmsXBFD
 UvC2EtLEWo4XfTHPshulR3Xv0pqGmM3WjzirSpt36/yXFFbXNAEqqplf/wh5B91D/LMVBva50dU
 hOnBPc7IxzX8LltW074D1fhIArbE7liJEgwGw6nTByU8kewT0UiPzqwlmQbmk0JblvX9qjm2vvv
 ht9B9VkP3Irjbd3lXPmTb19SvjfLUrD0usDRSzWOXVP0kqruwEAuiDipclFN6Ypy0QllTACszep
 4EED80AUUcwbj5glBWW8Af9qNiN3RKRw==
X-Received: by 2002:a17:90b:1b06:b0:3ac:b44c:2d84 with SMTP id
 98e67ed59e1d1-3b1b0a0e8d1mr8584718a91.13.1794760641497; 
 Sun, 15 Nov 2026 08:37:21 -0800 (PST)
X-Received: by 2002:a17:90b:1b06:b0:3ac:b44c:2d84 with SMTP id
 98e67ed59e1d1-3b1b0a0e8d1mr8584687a91.13.1794760640950; 
 Sun, 15 Nov 2026 08:37:20 -0800 (PST)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197ce55c1sm18322700a91.3.2026.11.15.08.37.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Nov 2026 08:37:20 -0800 (PST)
Message-ID: <ce14f379-af0c-46df-83a9-2a988414d825@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 09:37:19 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] accel: register CPU parent only for AccelCPU
 subclasses
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Chao Liu <chao.liu@processmission.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
References: <20261106023936.772-1-luoyonggang@gmail.com>
 <20261106023936.772-2-luoyonggang@gmail.com> <avXCZ6IxBXWEuugm@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <avXCZ6IxBXWEuugm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VOVIDNPX c=1 sm=1 tr=0 ts=6af9dfc2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=mDV3o1hIAAAA:8 a=pGLkceISAAAA:8 a=B1J7nxSkg31nvX5rniAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA2NiBTYWx0ZWRfX30Gs6CH7z6Z6
 dLKVOpR2LH8et+EgVsM/Hv4RJLmop0vW4QrJusGuVHD1kq/NzOSEUlW2dfO6FgWYXeIoZ8gfD+l
 Woa6cZn9QgVskteIYUlbl2kmjxAvPgw=
X-Proofpoint-ORIG-GUID: dSiUwMaquqSFfUkAQUv5FXW33tTCr8fn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA2NiBTYWx0ZWRfX5ohRbnrh/0DT
 YhUlUAp3Kx8sX7bHDSnb23kyL1yGVCR+VMf1vdRYjSIaRBWfIL8OaGEHiVwLbG1U7v6vsrx2I+P
 R9sp1NIhkylTfcFt2dvYpgn06XuTMcZGN5Z4kE7R+3jOVdwplVI0zlj7lVpFvppc2L6/YfqIWj/
 eqYX3ccOsxQ6ooYcoQyE3lKcArugF3uZDivKkr0ksWoxFjr2+7AwVbt2UuCcMusjzi9B099zu/o
 vAoimpsOHaHMDg3KZsjrUSLuBIDtLzm9zjNe9MXEYOM501rG3E8bf7bIAr6WOBULAmXYJoYy0GQ
 b4funAlzJaGOB/aSreRSYKgjJAALsCDcfyyJI/VA6FI5SxzFYVFnifusIukl4/GX9PvEw31aC4u
 GyvsT1R+Thr3dKQi8Tv8jiCO9W07wB2LNYv+bryeObDa235/+DfPhkqVObK+ffnrEz+5l4hZCxC
 UuA/H0jzJp1qhOshELA==
X-Proofpoint-GUID: dSiUwMaquqSFfUkAQUv5FXW33tTCr8fn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150066
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 6:43 AM, Daniel P. Berrangé wrote:
> On Fri, Nov 06, 2026 at 10:39:33AM +0800, Yonggang Luo wrote:
>> accel_cpu_register_type() creates the abstract parent
>> accel-<cpu type>. A subclass names that parent, and
>> type_initialize() aborts when the parent is missing. The old
>> type_init registered only target_cpu_type(), which is one name
>> in a multi-target process. Call the helper from the CPU type
>> init of each target that has an AccelCPU subclass.
>>
>> ARM calls it because whpx-common.c parents accel-arm-cpu on
>> aarch64-softmmu. i386 calls it for TCG, KVM, HVF, NVMM, and
>> MSHV. i386-softmmu and x86_64-softmmu each pass their own
>> CPU_RESOLVING_TYPE, so WHPX on x86_64-softmmu finds
>> accel-x86_64-cpu. RISC-V calls it for TCG and KVM. PowerPC
>> calls it for KVM.
>>
>> Other targets have no AccelCPU subclass. Machine init looks up
>> tcg-accel-<cpu type> or kvm-accel-<cpu type> and skips a missing
>> class, so those targets do not need the parent.
>>
>> No extra tests is needed, as these QOM types already be
>> tested by the existing logic instantiating all QOM types.
>>
>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>> ---
>>   accel/accel-common.c      | 6 ++----
>>   include/accel/accel-cpu.h | 2 ++
>>   target/arm/cpu.c          | 2 ++
>>   target/i386/cpu.c         | 2 ++
>>   target/ppc/cpu_init.c     | 2 ++
>>   target/riscv/cpu.c        | 8 ++++++++
>>   6 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/accel/accel-common.c b/accel/accel-common.c
>> index 00a400243f..441d1b77fa 100644
>> --- a/accel/accel-common.c
>> +++ b/accel/accel-common.c
>> @@ -130,9 +130,9 @@ static const TypeInfo accel_types[] = {
>>   
>>   DEFINE_TYPES(accel_types)
>>   
>> -static void register_accel_target_type(void)
>> +void accel_cpu_register_type(const char *cpu_type)
>>   {
>> -    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
>> +    g_autofree char *name = g_strconcat("accel-", cpu_type, NULL);
>>       const TypeInfo accel_cpu_type = {
>>           .name = name,
>>           .parent = TYPE_OBJECT,
>> @@ -142,5 +142,3 @@ static void register_accel_target_type(void)
>>   
>>       type_register_static(&accel_cpu_type);
>>   }
> 
> Is there a reason why we need to register this base class
> repeatedly for each target ? This class is defined in target
> independent code and the target specific behaviour is provided
> by subclasses AFAICT, so I'm not seeing why we need to
> duplicate the class per target.
> 
> I just proposed changing its name to "accel-cpu" so that
> it is always available:
> 
>    https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg02741.html
>
That seems to be the right move. I might have been confused in the 
beginning by thinking that a specific base class per target was needed 
to be able to override class pointers from AccelCPUClass.
After that, I didn't re-question the why and just assumed it was needed.

This predated the moment I understood that children class have their own 
copy of parent one, so can override base class behavior.

You're right, taking a fresh look, it does not seems to be necessary at all.

Thanks,
Pierrick

