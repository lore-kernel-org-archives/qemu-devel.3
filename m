Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08B8C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 23:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tugeY-0005Ku-0B; Tue, 18 Mar 2025 19:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tugeU-0005KV-QW
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 19:47:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tugeS-0005oo-OB
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 19:47:18 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IJNImM027198
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 23:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JobEIMI10j0pKFqdAhGVc6pA+5E3URbqxrN0kvj4kY8=; b=QRqCcdFx21LkGK3U
 wSQ2x51Jhq+Nm2H4SAtcLE0+WB2hpnBt/917CYYVNAKzHDe/7t6fU93MqGc5hCbF
 uQbfFGBmhRgkd9dDxRjq6b1FepusUGXrLWu/ooXtSNu35OMYX34Jb3ND5u7eMX1f
 cnKxY5IK91e9/R794qSigxG7BVfQsNstGGmQhTC7sxkLSzFTfEm2JNT48gvkNcsq
 J4Zv1orPzI9TxR4+dCBpEFnoqMr24glnl7MuPEltza0lpw6+uoIrBmyG4GKuFrm3
 LCLBuqm5wcD/awmH+cfQHLpafTBeJuGPJ/VbKxmhJTnaSkT74IKeHq6EetC5VCUU
 VNkX0w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwtkjr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 23:47:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2235a1f8aadso95813965ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 16:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742341630; x=1742946430;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JobEIMI10j0pKFqdAhGVc6pA+5E3URbqxrN0kvj4kY8=;
 b=PMbGuExp9kL9rSTYkuC+MHHlwuinAogp3j6tF1a08ylC1tLvYglBeQvPcD4CnRW3tD
 CvIrtX2omQm9EfBtwsiNbzojL49kp2wBcpfOnDsbPYN6S7E6Q4ZLoICcAJGKzeCt53PM
 NjWNqP7VZggVyXY0yltOd4MevjQx5R/fPtlMx87KLQ9SOTwkt2OUDXspf5LoS9DpEQTk
 dovRZk3xNmdMjxR4s2SPOQ/1MqtB2z+MSzhDFkVk9XmnVA2PUpLZuVd2IfRc6XSG7URq
 K+f8JX8VULf3nd/D9qTOIUUsjS0CkkwZz08HfUgUv6g+QjKKLEsimf151ILd/m2nstYc
 yaGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1Yl86IKXgRKxEj29/sm0c8DBF1V8pXtF/neywQP8CMjLnvsiLN3JWs0L+PNGJmz0YZVx8Syfuv8ny@nongnu.org
X-Gm-Message-State: AOJu0Yxfaw1yjgSaARfvPGAb0n6zJChIIo0sBsG7ein8qcsjuJV9YrcT
 1DW3zQOfFkjO0viYRP5bleKGC9PFYyUK2cX+uekX+6cNDcQC8tKP8A3MjTGUC+xFqgQZxOFn1Cy
 SlNwBfiAphWxMEy+Uhx4pg/uI7gevG/wuhrMnm7OPbT3CMbTtXsinNw==
X-Gm-Gg: ASbGncvESUHJIQgwyPbn90aU/ehsuLKsnc4zXR0hjhuKacJGKK1566h7UBvBVklVzlK
 v80lZGlLXknC81SiYCZz2LWX3W3G3myLtEfZTjyD+R6ZwdpFcnt4SenX5rsPeLjzSIzcKbxNb+L
 scBpGbUga1pf+HWzUEgUH5cUAhRXB9+O3dkUXmrPn/Jr5WMwbanULQPww2AI1I/kT+owrMz3fhc
 3M2VTYOX/MY5BVCegrDFJbILaE5lIVnXMVATfvCb7S6ZHSVoO2knmOlmj52DdGXCjBQBdjixYyj
 bhOoWIKlurmLnPr6/w79WUDDEJzynZh+63vTJKFIcnTISvdA7OsQoze2xaEwT83FPzckJDUqdc9
 P92FoOKL42+faBQSS
X-Received: by 2002:a05:6a00:2d87:b0:736:3ea8:4805 with SMTP id
 d2e1a72fcca58-7376d5fe460mr1047372b3a.7.1742341629809; 
 Tue, 18 Mar 2025 16:47:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW1oPsUCiIA1ZjHXEHMiPl9RbXuF1xqmrupYoTXEjsCvXxH64L0ceFs14h9ZdLDTF0DvRDzA==
X-Received: by 2002:a05:6a00:2d87:b0:736:3ea8:4805 with SMTP id
 d2e1a72fcca58-7376d5fe460mr1047328b3a.7.1742341629037; 
 Tue, 18 Mar 2025 16:47:09 -0700 (PDT)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737116b1342sm10235405b3a.163.2025.03.18.16.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 16:47:08 -0700 (PDT)
Message-ID: <2712e0cb-72a3-4c39-82a4-4b5f6d4914b0@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 18:47:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/39] target/hexagon: Implement modify SSR
To: ltaylorsimpson@gmail.com, 'Sid Manning' <sidneym@quicinc.com>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org,
 "'Matheus Bernardino (QUIC)'" <quic_mathbern@quicinc.com>, ale@rev.ng,
 anjo@rev.ng, "'Marco Liebel (QUIC)'" <quic_mliebel@quicinc.com>,
 alex.bennee@linaro.org, "'Mark Burton (QUIC)'" <quic_mburton@quicinc.com>,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-6-brian.cain@oss.qualcomm.com>
 <017101db9763$41ae4ca0$c50ae5e0$@gmail.com>
 <IA0PR02MB94862E1C5171AC300C64DA1CBEDE2@IA0PR02MB9486.namprd02.prod.outlook.com>
 <026201db9839$f4bb6040$de3220c0$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <026201db9839$f4bb6040$de3220c0$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -L_mc0pmcW11qgAgBVXuj1ECL9tKqvWG
X-Proofpoint-ORIG-GUID: -L_mc0pmcW11qgAgBVXuj1ECL9tKqvWG
X-Authority-Analysis: v=2.4 cv=UoJjN/wB c=1 sm=1 tr=0 ts=67da05fe cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8
 a=7Ctv4c8MWIky3k21fBIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180172
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/18/2025 2:14 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Sid Manning <sidneym@quicinc.com>
>> Sent: Tuesday, March 18, 2025 1:34 PM
>> To: ltaylorsimpson@gmail.com; 'Brian Cain'
>> <brian.cain@oss.qualcomm.com>; qemu-devel@nongnu.org
>> Cc: richard.henderson@linaro.org; philmd@linaro.org; Matheus Bernardino
>> (QUIC) <quic_mathbern@quicinc.com>; ale@rev.ng; anjo@rev.ng; Marco
>> Liebel (QUIC) <quic_mliebel@quicinc.com>; alex.bennee@linaro.org; Mark
>> Burton (QUIC) <quic_mburton@quicinc.com>; Brian Cain
>> <bcain@quicinc.com>
>> Subject: RE: [PATCH 05/39] target/hexagon: Implement modify SSR
>>
>>
>>
>>> -----Original Message-----
>>> From: ltaylorsimpson@gmail.com <ltaylorsimpson@gmail.com>
>>> Sent: Monday, March 17, 2025 12:37 PM
>>> To: 'Brian Cain' <brian.cain@oss.qualcomm.com>; qemu-
>> devel@nongnu.org
>>> Cc: richard.henderson@linaro.org; philmd@linaro.org; Matheus
>>> Bernardino
>>> (QUIC) <quic_mathbern@quicinc.com>; ale@rev.ng; anjo@rev.ng; Marco
>>> Liebel (QUIC) <quic_mliebel@quicinc.com>; alex.bennee@linaro.org; Mark
>>> Burton (QUIC) <quic_mburton@quicinc.com>; Sid Manning
>>> <sidneym@quicinc.com>; Brian Cain <bcain@quicinc.com>
>>> Subject: RE: [PATCH 05/39] target/hexagon: Implement modify SSR
>>>
>>>> -----Original Message-----
>>>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> Sent: Friday, February 28, 2025 11:28 PM
>>>> To: qemu-devel@nongnu.org
>>>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>>>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng;
>>> anjo@rev.ng;
>>>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>>>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>>> sidneym@quicinc.com;
>>>> Brian Cain <bcain@quicinc.com>
>>>> Subject: [PATCH 05/39] target/hexagon: Implement modify SSR
>>>>
>>>> From: Brian Cain <bcain@quicinc.com>
>>>>
>>>> The per-vCPU System Status Register controls many modal behaviors of
>>>> the system architecture.  When the SSR is updated, we trigger the
>>>> necessary effects for interrupts, privilege/MMU, and HVX context
>>> mapping.
>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> ---
>>> What does SSR_XE indicate?
>> [Sid Manning]
>> If SSR:XE isn't set this thread doesn't have the coproc enabled so discard
>> additional checking.  Any coproc insn issued when ssr:xe is 0 will trigger a,
>> "Illegal execution of coprocessor instruction." error.
>
>
>>>> +    if (old_XA != new_XA) {
>>>> +        int old_unit = parse_context_idx(env, old_XA);
>>>> +        int new_unit = parse_context_idx(env, new_XA);
>>> Check that old_unit != new_unit.  Per the table above, different XA values
>>> can point to the same unit.  For example, if cpu->hvx_contexts is 2, the
>> XA=0
>>> and XA=2 both point to context 0.
>>>
>>>> +
>>>> +        /* Ownership exchange */
>>>> +        memcpy(VRegs[old_unit], env->VRegs, sizeof(env->VRegs));
>>>> +        memcpy(QRegs[old_unit], env->QRegs, sizeof(env->QRegs));
>>>> +        memcpy(env->VRegs, VRegs[new_unit], sizeof(env->VRegs));
>>>> +        memcpy(env->QRegs, QRegs[new_unit], sizeof(env->QRegs));
>>> What does the hardware do?  Does it clear the context, or is that the OS'es
>>> job?
>> Nothing would keep a single htid from taking hvx unit 0, doing some hvx-ops
>> , swapping to hvx unit 1 doing some more hvx-ops and so on.   We are doing
>> this because each thread has a private copy of the hvx register state.  Since
>> HVX units and threads are independent if one thread changes its ownership
>> from HVX context 0 to HVX context 1 we have to do this copy.  Instead of
>> memcpy should create a new object that represents the HVX units available
>> and change env->VRegs/QRegs to point to the one currently owned.
>>
>> Refactoring this will be an improvement.
>>
>>
>>> If the hardware leaves the context alone, the above should be
>>> 1) Copy env->{VQ}Regs to old_unit
>>> 2) Copy new_unit to env->{VQ}Regs
>>>
>>> Should you check SSR_EX before doing these copies?
>>>
>>> Do you need to do anything when SSR_EX changes?
>> I think you mean SSR:XE before doing the copies.  I think we have to do the
>> copy here regardless of ssr:xe since a thread could swap ownership, update
>> ssr:xa, without explicitly having ssr:xe set.  Maybe the OS disables SSR:XE
>> while changing hvx unit ownership?
> Correct.  I meant SSR:XE.
>
> Some refactoring is in order but need to understand the HW behavior more specifically.
> - What will the HW do if more than one thread claims ownership of the same HVX context?
> - What happens if a thread claims ownership without setting SSR:XE and then sets SSR:XE later?
> - What about this example?
>      1) Thread 0 claims context 1 and sets SSR:XE
>      2) Thread 0 does some HVX computation
>      3) Thread 0 is done with HVX for now so clears SSR:XE
>      4) Thread 1 claims context 1 and sets SSR:XE, does some work, then clears SSR:XE
>      5) Thread 0 wants to do more HVX, so it sets SSR:XE (still pointing to HVX context 1)
>
> We should keep the copies for the contexts and local copies inside CPUHexagonState.  This makes TCG generation easier as well as having common code between system mode and linux-user mode.

Good point that linux-user will need their own exclusive HVX context.  
But it doesn't sound right to me to have CPU state store both the system 
contexts *and* a local context for system emulation.  Our current design 
under review is better than that IMO.  Once we have some experience 
modeling the system registers as an independent QEMU Object, I think 
we'll be better prepared to model the HVX contexts similarly.  Ideally 
we can remap these via something along the lines of 
"object_property_set_link()" when the contexts change, without requiring 
any copies.  And ideally the existing TCG should work as-is, despite the 
remappable register files.

"What happens when ... " - multiple threads picking the same context is 
almost certainly explicitly or implicitly undefined architectural 
behavior, so whatever QEMU does should be appropriate.  However, we'll 
talk to the architecture team and get a definitive answer.


>
> Also, since check_overcommitted_hvx only prints a log message, add an early exit if LOG_GUEST_ERROR is off.
>
> Thanks,
> Taylor
>
>

