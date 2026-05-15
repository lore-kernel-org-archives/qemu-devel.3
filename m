Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0825ACD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 19:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNycn-0006G9-Ac; Fri, 15 May 2026 15:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNycZ-0006Eo-Un
 for qemu-devel@nongnu.org; Fri, 15 May 2026 15:54:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNycW-0002PG-NZ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 15:54:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FJf75X2839587
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 19:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gMNVhNo4KVV0eX5rI5rZpAI6QXSNmLLYcTB7XF1zotg=; b=ajq1jVcUDOAPKTk2
 1Bf2axxAMJCYAZaQZJV8Uodz8EVfStseZJbF3hh9KQgbKPoJLQ+c2Z5Epm50RxbJ
 JwxjzNRx/T0SLtMK9PmBZJ1ZVc8T5SmvmpLX17E4P64IqHMk0mAgqbiUv3ue615M
 gjrhxmE3/p+JNPUX/j6X7PwjkXTzzRRlBdUjLqqr+PHlX5DoxPtkna01yegMRgCh
 DvK1WiiX17QgJdBN5TbCUqG4OOGZdxKrXMFDmdNHA+ozSZ9KFe3O18zdSOFzGvb7
 9EkB7HCUUMK58MLhJ3bwnzYcORBqDXAmnGCFHWi0pc6TUp6vDwbu82FX07q7Xe48
 CYsufA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e694n06me-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 19:54:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-90d6fe98316so67920685a.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 12:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778874889; x=1779479689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gMNVhNo4KVV0eX5rI5rZpAI6QXSNmLLYcTB7XF1zotg=;
 b=emwyx4Pa0CsRxujG8winmXIkvW+rc2ICl0xCo+kwQd1IMFNWoixUIns2ONmknqDYOl
 1ofoUl3DK8RDqITwX0nh1tCElY/hYffsbKsypBXzRitfsPC9dVIo4sHwuDpQsGe7f2ct
 MsayixrB4sd5axOJjW216+E/p8oz5FKr5L/pRL1lZGEITZw5ISMKXzsafnkOlgnko+cn
 Dt/MLfpGAlpotmrsj3QVRHWJ9XLcTkQg5e59m9d89TaIApxrqifk2cR3qBqIusuFIytp
 0YrLfWk1cEGVrMEGgkP4iJQ+LLjCKe9rphqlvyNQC9D2BPi/0Nddx+GRxagVRDqWqlGh
 n3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778874889; x=1779479689;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gMNVhNo4KVV0eX5rI5rZpAI6QXSNmLLYcTB7XF1zotg=;
 b=eY9QoPUCNlBVuVN2wUt5Job2oMZg8phjIlmQeQDsmq+OSt6KsThXZSOUNT6KTUyylv
 kmDa7oaFqWDxN3mAc4TDCnZ4mN7AI+BSW3+42wszTRXVsaJYl+AfEMe12PUgbvmR/lwW
 hrw6bs2Af+y0WWgWx6yDIUEb/GliuRqcX64vgaEbHTaCd9SK1OASQ6sNBsxX3tr/dhxj
 Av/p/MeVoffp3agPhEW45KKcY+/A02EXd1pRbw+rvTZlQ9grWRYnJVJHoRejEI2DGWn7
 1bmxMsTPNHrebQUx5uyOt2qzRjXoxSicPJZPdSdf3G+r/hwHa8NpBr4I4YSrXkAu9UJ/
 Gz2w==
X-Gm-Message-State: AOJu0YzJ42UByGdoWOUFeEo1BEyd4SSvoM5S0aCx7kO0JC/KtTPr+Qvg
 ELSm3Do9XNLKcz+W2o4ZR2kArtew3JMbE8v8cz8TAy6eXujL7Zsa7VAQUg6XHe6UAFq/NLTxOC7
 ZGw1nVSzY3qjyKu4JyW4H3u0dQI9FkU1/VVSrBcBU2Xgf8FVEnjxx4yxXSw==
X-Gm-Gg: Acq92OEjJtguFALmQqinM99mPTV+hsDWzvlo+kE3Z9BLN3ExW53PZDN3iqIwiSCc+MI
 Gx8i4nNbJ4J/wccwKDZibDz0IWGZZjZjg5HuHkMtWZOtPsfkjoR8J04H9uZhHnXFH2aeEMjDwJw
 gWcoJyI+huXJy7zKYttwXDdpWFfnxynqJgWdM1hQRK2SiQySNfRV+0Rs8ZwS2lhVBzGyd58pn0P
 X7W75lcc+V3+IGqn1HqiNKpKQv85yMlRCaCbYftwKaxuzg6nXRwxpkGyz/gVsXOkLcGPFPnvPVO
 skmQ/0oZzz5PWMlJHeuns4D5n1Llj+UIiFZxpGQssrD+V9RhwiVifwxCulcNn8vo8Y89F9ajTy2
 UcuiYWOm911WzFCR2/T5xgmdozvq3+9BIr8Xyov5Z29rYjh/fGdbpUGzTdWQ=
X-Received: by 2002:a05:620a:698a:b0:8cd:8884:2509 with SMTP id
 af79cd13be357-911cf2f0e0cmr890118585a.55.1778874889151; 
 Fri, 15 May 2026 12:54:49 -0700 (PDT)
X-Received: by 2002:a05:620a:698a:b0:8cd:8884:2509 with SMTP id
 af79cd13be357-911cf2f0e0cmr890113485a.55.1778874888666; 
 Fri, 15 May 2026 12:54:48 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c908562931sm61375056d6.3.2026.05.15.12.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 12:54:48 -0700 (PDT)
Message-ID: <174f03b2-b979-47d2-aec8-645d797ab758@oss.qualcomm.com>
Date: Fri, 15 May 2026 16:54:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] target/riscv: Add server platform reference cpu
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, leif.lindholm@oss.qualcomm.com,
 andrew.jones@oss.qualcomm.com, Fei Wu <wu.fei9@sanechips.com.cn>
References: <20260514204640.2540054-1-daniel.barboza@oss.qualcomm.com>
 <20260514204640.2540054-3-daniel.barboza@oss.qualcomm.com>
 <agdgwnLqvEeMoeqk@lima-default>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <agdgwnLqvEeMoeqk@lima-default>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ba3oFLt2 c=1 sm=1 tr=0 ts=6a077a09 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=uTRCLKPYAAAA:8 a=guGPkx341sKFB3NjViQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=T-agBWn15iSmxapsA1lH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDIwMSBTYWx0ZWRfX1E8ZFh5WS9q4
 rcKYyw0BntMEESav+esRYbJCUHUiHLQUguTIvT7DF+dLtEMx8ObJKAvzSDlCwecDWKP7Y1VHwil
 tIaVeD88pxrbRqqP6pbomo+L4rDKNmNuccihKOnIzk4gjQoJQPmmFtSkjGeV2I+geiRhVjQwPoq
 tUSJjd2Eq4T2STBFCcmzeiA/O77m/KYQ7wI4gg5o9w8FvUmDcYkNbbV7cq9sub2O+AwJmb7/Jwq
 u9o+RusBIeJmswo0iNxhLBcZkEaFInTUwG9ZjdJGBic28H9c99n+DoyRMVuuQC7AD0XngS50WS2
 CJNdLlC7tuLK7soLtf3ImaQqyk2yfvflLXgOooPVyrHjT4UjPir6Az74BCLmCpU3qDR3kuVI70A
 bIHIkVC2MY0eaSqOsEnp5x9n2XU2+uc0yYNmlKjaWJN79B6KeUNcqxAE8r05zVaGE4tW9/AmYMc
 ljegmgZCQ7q6oQz10Ow==
X-Proofpoint-ORIG-GUID: AHh8GyLmkRiwDi0hZDCTP241zurS3h09
X-Proofpoint-GUID: AHh8GyLmkRiwDi0hZDCTP241zurS3h09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150201
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 5/15/2026 3:15 PM, Nicholas Piggin wrote:
> On Thu, May 14, 2026 at 05:46:38PM -0300, Daniel Henrique Barboza wrote:
>> From: Fei Wu <wu.fei9@sanechips.com.cn>
>>
>> The harts requirements of RISC-V server platform [1] require RVA23 ISA
>> profile support and others.
>>
>> This patch provides a new "riscv-server-ref" CPU to go along with the
>> future "riscv-server-ref" board.
> 
> About compatibility, if we get a server platform spec v2.0 that requires
> a different machine and RVA28 + Sxxx CPU. Is the plan to update these,
> or add a new CPU and machine types? If the latter, then perhaps a
> version in the names like riscv-server-v1.0 / riscv-server-v1.0-cpu
> would be good.

Good question.  We can get away with machine props to change the board
behavior based on spec version but not sure if this makes sense with
a CPU.  I suppose we could live with:

-cpu riscv-server-ref,spec1.1=on

to change the CPU setup to v1.1 and so on, but creating a new CPU with the
spec version in the name like you suggested (e.g. riscv-server-ref-v1.1)
seems cleaner.  In particular if the spec doesn't change that much - which
I guess it's fair to assume given that a reference spec wouldn't be much
of a reference if it keeps changing/updating all the time ...


Thanks,
Daniel

> 
> Non-versioned names could be aliases to the latest one, but I don't know
> if that is really worthwhile particularly for non virtualized system.
> 
> Thanks,
> Nick


