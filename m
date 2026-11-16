Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA7A606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jYfUrpgh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iSep7us3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSxPq-0002RG-D1; Mon, 16 Nov 2026 09:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSxPp-0002MT-4u
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 09:10:37 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSxPm-0005E1-UD
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 09:10:36 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGDrVIQ1727314
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 14:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VTflaTPUBUOe0Mv0uZNNxBnCDH6Sctb999ycWNo8FzM=; b=jYfUrpghGx78QApV
 FRpWlgb7m6+A+A6DLt1tdm3bF8DEFa0xwVS6rY02rbZ+pMLOdMwmfj5g6f2/GieH
 7yKUlFFBaEh96Am+DeGuVFw2F1fPtllMk71D1o7SKfAuKFHsnVIE8Z57Hw4aqEvc
 Dl+5nwYfRDNA6I03C+9Lxpa/TMUyHlSpzuVkp41/ItcUeWJcuyYvCzz+uI2ockLm
 JZPqYXBFMdHq1LNsVrmd0Mb4O9h30pZWpuWIFpcez/yaTzgowVdEf9EU17A2jyAG
 g2JeVkNQv4W+NoR8r9b6G17eAz/A0nnXXDnthvQZNaG/UM9wfJpt94T+wG0n0yaE
 NbFgiA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyrqgua6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 14:10:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f5844cb60so651612585a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 06:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794838231; x=1795443031; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VTflaTPUBUOe0Mv0uZNNxBnCDH6Sctb999ycWNo8FzM=;
 b=iSep7us3hlLG650URsufpKxXYvQdnlUzhcJAd7pJzb3CGeYZ1+UGLrZGfGoPNH9Jki
 Y7K9Hof73M/JssOci4dgNdnWSqS7DoTwTWykyjwsbd7k6glZcNXChSFJgVefnabVEGhY
 116q0v2zlLPeVqpTFJvCA043lZsZCrVGv+srQ3HSyXkEFP5Wb/BWSuTOkH3Md/f2i5Sj
 qojSjp8Fr/kiFuXbbSN6DzDMmV+MO8vGsPWfH7ea4D8U8S6bey9L4PbfLBa3w4rljcw9
 yMCIZOcRx6CD0bqpVtApdS+rRiGCHXwHpdGZr1d3mNjQE378JG7Oy5hH+0v18wlgVs84
 yQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794838231; x=1795443031;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VTflaTPUBUOe0Mv0uZNNxBnCDH6Sctb999ycWNo8FzM=;
 b=17gO/Ng7q7ojkbrAmRPjYiSfQT2xlyqi7jJtxi4WymLB71Tmn5lzFE3NNW2jLYKZ9x
 lZlC67Th8nKCoSajqfBCKUnoo6aePU39x5CtRxQLopUmGFOw6cgvIOUdRuyK6hX0+hyW
 vFkKV7r5LnuEkbp6ER8pRaHfzQLMCn4kblqybgZ/Boym0Wz3yTCbJqDzmErQA2UgE81r
 MEW2McZJHKWJ+UqubMpFvSFuXPzxvuwpMHeTArtHgoowma9hFFXwh1GmnHMSNTEJacdt
 duWLaBwC8SsuZP1VwNEvM1Al2m82e9sHTSBXbPCgo2USavqzDfXzMMAu5zivN8+i8Vbh
 CYag==
X-Gm-Message-State: APuU4Z/1Qm9r6zwtuLPqhNef4NIEfQ8wnrmebdK/xB5/uidlSEGChc19
 ynv2Lo/jyLp4tFUXTIV0YsykQIXFYJUhCaq97cH4CqP/GBUZj8WdfJPeJsodY9k1puE0ZFg2DHt
 9kkCj/bJ2OjFkd8n9uCkCYqQN7+jR6iWqb4dzPtUMhnfeBEOP2XHlaZLbCw==
X-Gm-Gg: AYBFou3HPojJ+9HlpMfXkNWyOcxWm4vjCkXk5K0tkOEBKSmHC4LHwp2QAJ5faKIYEVT
 5gl1bkIlmFQ1IEEFEEU1GMXakfWIqPQI7bOs4ZKmWMphLdgpkgOOWxCcv0r1BluSh0hQYfecQZd
 n5f4iF4S+M/00+OVehf4ukwGpvn0y2cYZ3Of0yyi/+MNZK6UEtpHflxE5e36H38nihL58wYn/uM
 9J0uZbQuB/yCD9oBJ0FbxcSOm5w0Ckm0+SA7/t9WcpEKanzQ1pl8/mrnRzmOB6TrETgufWmi+Hn
 BWRAQ7vo/xvlfoync5cIm5ziScV1O18SywggM6sU7Tp4BJmoQgAW6MkfKy0uo3tsfMQw3ut6+xI
 2dJu6T8APaVgX9ZJqknx3lVUJsnfgQfINHU2C7AC48emqjG6Ba1eJB/59FgDMfidFJ+wxYnCAdJ
 l0RoqHC0M=
X-Received: by 2002:a05:620a:2804:b0:944:4e6:85d8 with SMTP id
 af79cd13be357-94932c86f28mr2343669785a.5.1794838231176; 
 Mon, 16 Nov 2026 06:10:31 -0800 (PST)
X-Received: by 2002:a05:620a:2804:b0:944:4e6:85d8 with SMTP id
 af79cd13be357-94932c86f28mr2343662685a.5.1794838230643; 
 Mon, 16 Nov 2026 06:10:30 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d22394esm23172556f8f.3.2026.11.16.06.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 06:10:28 -0800 (PST)
Message-ID: <ae1a4df8-e52a-45c8-b723-60d86931f286@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 15:10:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: make error message for -cpu host more
 informative
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Andrew Nguyen <xmphyr@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20261115-4836-cpu-host-error-v1-1-fdf0eb56ba8a@gmail.com>
 <CAFEAcA_dyd8Y5mJc_J7dtDwLL3eDaEo1P8fx01Rjkgah+q4Dvw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA_dyd8Y5mJc_J7dtDwLL3eDaEo1P8fx01Rjkgah+q4Dvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VcJir1p9 c=1 sm=1 tr=0 ts=6afb0ed8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=cvUIb4BVs8QHesCB_T4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: ygpM3n4lYI8zdOKbkF0103fskKXq_Bc7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1NiBTYWx0ZWRfX0eGFHvL+eJSe
 7bOvD+vFQS3gXidUdB3q8As+LUl13gUso7KLmF3yn6vbYf5qKfXiifK59bbMyfFbFuk/n0dkPF6
 XQhYEB8UILlRA2FxlIH2SYoR2nltiaOUyC/VB9L9YqEFgr36H9bOlue4i4b6nt/IFhWoHEqbq9a
 Is0Cio77cEcb6upLLTmztg9wWPFflkmgOJTgia5oa44VNkPJhSw8H6yK1btBYg4A5sli6ESqe8E
 x9Zap49zl8hSHNfkcbU87Z01PxjZMG/EDJ8rySyj7am2wDpYVKcxpUWVQEpA985hLc7Zkl+jlGB
 Uve/0jTQ4LxnGo1D3Ppg+8x0U4l+zey+PbxZC+0ygiGyRh3odlxECMRxza/ExBRvI3BD+jds9Rb
 3Bke9cK3R5nTgMAWoSs+3q5A8OYriBdaYRtj/8Pupfa7nH2+qb05XY+2vGaDlW6SkxZLXRdLSXH
 IuoFbKjFSfgWl5kEC0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1NiBTYWx0ZWRfX0pPMcIMrvfnd
 +Vm0w4YEJ7taPmaOA/hyW1tEIbnqp4Vu8xbRYXkOJsnfIDV6867aObq/MPVDJzbthaATJvvDxKu
 aJsrUsc4u487wmQTfK0FRrTAe3GXLVk=
X-Proofpoint-GUID: ygpM3n4lYI8zdOKbkF0103fskKXq_Bc7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160056
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

On 16/11/26 10:38, Peter Maydell wrote:
> On Mon, 16 Nov 2026 at 03:38, Andrew Nguyen <xmphyr@gmail.com> wrote:
>>
>> Included the mention of WHPX when the option -cpu host doesn't have
>> an accelerator option.
>>
>> Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4836
>> ---
>> This is a resolution for issue #4836: https://gitlab.com/qemu-project/qemu/-/work_items/4836.
>> "-cpu host" by itself is not permitted; an accelerator must be specified as well. For Linux,
>> it is KVM. macOS is HVF and Windows is WHPX.
>>
>> Previously, QEMU would only tell the user to use either KVM or HVF, essentially excluding
>> Windows users. This patch adds WHPX to the error message. A similar patch was made seven
>> months ago in target/arm/cpu.c:1861.
>>
>> Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
>> ---
>> Changes:
>> - cpu.c:10229: added WHPX to the error message when "-cpu host" doesn't include an accelerator
>> ---
>>   target/i386/cpu.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index eab0d5a4d4..7dd5535f80 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -10229,7 +10229,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>>
>>       if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
>>           g_autofree char *name = x86_cpu_class_get_model_name(xcc);
>> -        error_setg(&local_err, "CPU model '%s' requires KVM or HVF", name);
>> +        error_setg(&local_err, "The '%s' CPU type can only be used with KVM,
>> +            HVF or WHPX", name);
>>           goto out;
>>       }
> 
> The code isn't checking "is this KVM, HVF or WHPX", though.
> accel_uses_host_cpuid() is checking "not TCG" (also "not qtest" but as
> that's a test facility we don't need to mention it here). Listing
> an explicit set of accelerators means it gets out of date whenever
> a new one is added (as has already happened here once when the
> WHPX accelerator was added and the message not updated).

See commit f7fa2b88084c22299b347cea8fd9fadb0b136b22 for an example
of the hwaccel_enabled() method.

