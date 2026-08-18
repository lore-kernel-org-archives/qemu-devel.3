Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218DDC5DF80
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwG3y-0004xx-QR; Tue, 18 Aug 2026 05:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwG3v-0004oA-0P
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 05:24:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwG3s-0001us-Cx
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 05:24:50 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I8Baen1271147
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 09:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HFG1xD/W6bg6YYmgkmDBDXih0WD7BOSMazuzc4renDc=; b=Ypl8fmXvtE83PsHn
 nQE+j+g3vS+x0HmkH1nct737tSFtsCeVJRiSs0Qug20Ww+E5gbcC6aPQnVo6HEcD
 Lr77lYT84nNp8uhnzHWxu7LSsulgMGI9YGnoEp9H4YyxkUEaj4AMTkfC7pcxUgzL
 uYcD+IqC6E1GZv8Nh0hYodpLsLCDY1wMmEbyRKBBqCz8koJnj0nCY9rL91WjV+J7
 QECXvbDsgHfqx1hr/vSuTEHZLGbq+VkAaHByXZDODiBiWjevomKV2EoW9FjJMSkB
 P3vQl06Lxra0Jp72RBrnDoOsQVspx7nwto8R5fzwr31ZqjFosJYMqgdxKl+EVxad
 vrbwXQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4dcn1wmg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 09:24:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e52306621so426657385a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 02:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787045085; x=1787649885; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HFG1xD/W6bg6YYmgkmDBDXih0WD7BOSMazuzc4renDc=;
 b=H0LO3ldc7Ng+SY17FwaVZLA857ufpe/4MvKZOBkrP8EQNxKYQxsookknGiTRn1W61b
 QnH2s/T6pg314ImyV2nysnt0CgLPNMSDnz1EHSaLuII7ReeMTuByoW0ysUeEle5YLs6q
 Jz/iOh2rDHsn23GMmAiJG4TL8BJzmkTULvYQ9+y/NGJO8ToGY+8t5QVxnv7a26VWI4Gi
 2u4kqjh2al6xjkUP8eIXp/2sbJnYlFBKd8yXi6aZ3WhFbQ36/obIKQDJk2X4u7QshjJj
 qpbxN/CoIcfM4iPjB+CIS6XsL7T3/ZOreOtIj8x4nl0zlf34//FhECdbHzwyQmuMk0Hm
 xpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787045085; x=1787649885;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HFG1xD/W6bg6YYmgkmDBDXih0WD7BOSMazuzc4renDc=;
 b=oPXb79amgSNLzzf8YkO4Xji9hjTJlpcRvRCpF2uNW2dOcspJBn/sOXiPKOPltP7BAk
 J5nRTnxTffroTwo71FGNB/wY5O911QV12kKlVKjjf/oyNkA80lnCmlCcJ52YShxJZd35
 SaSkiX2cn+aKyNQuB/LyOcIu7RnR54r0z6WnOkyxx10Ve63OGaIWwU13/XzSlRTBC0YS
 6W/f4tFbGH10chfB3VY9C6wtAW8WaMW0e0twV/cPVbaEkejO9qIqyHLexhIxf6yUHfdM
 vNk+atHFf42UyAc3HSkjb1YTk/az86COp3vBlfHsvrzmFCHImpNoEY3vx8JL7xGq2S5i
 5jZA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrczVEPn46Q/9ZJ18P9rZ2fiHYT5aonhhykX+Op/3RMns8LkeFdt3FJPLfcJAWIHMGVVXgEjuTCPzA3@nongnu.org
X-Gm-Message-State: AOJu0YwdSWQlxaSsQu5xXyyncU30ll/5rtPxAwsrF7l6ZyES4M3Fc96a
 zNuyfbHua9CW3P5+QmqpIm3DX23W0ItxEZQaic1LeefPAuXydWUHmY0RI0XMoMZTy4P7JJtNti+
 MiFqI6lUABS7P8+bcVoXK+u6P3l+SF2QBrj0uCzD8LN9Byzr+ij2Hw82A/A==
X-Gm-Gg: AR+sD11EbotG14mdtg/py2VWw7xZNd5Azgq3lpDyeYWCNaC7ATTifQZ7dx78moavMrx
 4KPTcytxePPFJPxUME7oqSekvTXb87Lkyyv0w0pJ9tuGO8po3P+HGTxuiKvm1kJ4pwY8qErlY1G
 sEkAEf9f/erqZPo4ZuyDNKoC7LSuF14Yvfl4bMa6RZP7RfeByNtp9Cbrd05Yyw+zWpk7UyYk11K
 RYsws0s6r1fveuTi+85EfXudEdt+12W2hprbou9iT0FAI8skcRxOvFswlHCdRKtPpm6IIYIfOd6
 Ezj71C9/u/4OZpbJVfR9eTS5kwpjVmnizTJYEPH1tzmUg/war4HU41scjb+OAT0zeBA1DRN7gPd
 Y57fR423uwEacc3VLOngcwHM67iJ17yXFUvQ=
X-Received: by 2002:a05:620a:8084:b0:936:883d:89c6 with SMTP id
 af79cd13be357-93704b7d0e8mr704379085a.28.1787045085476; 
 Tue, 18 Aug 2026 02:24:45 -0700 (PDT)
X-Received: by 2002:a05:620a:8084:b0:936:883d:89c6 with SMTP id
 af79cd13be357-93704b7d0e8mr704375485a.28.1787045085074; 
 Tue, 18 Aug 2026 02:24:45 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996176b95sm174896245e9.10.2026.08.18.02.24.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 02:24:44 -0700 (PDT)
Message-ID: <3ec603ff-65bb-440b-8ed8-72ae4e6c5a41@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 11:24:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] accel/kvm: Consistently return CPU halt state from
 process_async_events
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Alexander Graf
 <agraf@csgraf.de>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
 <20260813181640.6537-12-philmd@oss.qualcomm.com>
 <55cc8357-daeb-4315-9f3a-8be7a59c355b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <55cc8357-daeb-4315-9f3a-8be7a59c355b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: q4r66snRzDemFO723OZJ3i_GOcSn5dSt
X-Authority-Analysis: v=2.4 cv=Gs5yPE1C c=1 sm=1 tr=0 ts=6a8424de cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=9aCaMZ_IbkuWgEbMIRYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: q4r66snRzDemFO723OZJ3i_GOcSn5dSt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA2OCBTYWx0ZWRfXzjQ2zfTyha54
 L36p54J5nH265xwrPfdmODjSYIiECMHN9gUoBQDNBB2gyiiHjnuQGJZ7hFwajQQCTqTVbxa+3HW
 GvnojsO4Bh7i3RpWiggB6CNt/r7+DwfYhK1gXE7YBUOju7O0IyZAJmzewGkdSGyUa9UCaVqbL4W
 hKdvJ3BPpmYJC0mNNgshPhRL1Fc3jG7RdXMcY41f6ykS/SeyRxyhtpxB2aFcqwHllobLXP0DzYV
 xpldEKcWbjOE/690wNan6C8ax0xCkQ3LiJIg9CH6jIl2CY4p76PC8cVYk+sILiyy6w3JIV/ZPMR
 95uGXVApHF6jq+ojmnzuDJNul2OT8wGqIQVyESKh0loUtJcjFjrMb0gIpxKdDwGU00Qr7f0fIlW
 TZQQ3ZZlbmXOqtYLnuo6wvzSNK/DSCB7VZONUVG4aZLWhHK+8VN+A8nzjSOgm4pujy/SbL98FuA
 NKxIkugI1ic36/K+zvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA2OCBTYWx0ZWRfX7/RqL/J3NsNz
 1gYc9nypv+PrrBElLfb16eH0qhWZaRuw5wEkl51ci6/64xlDyDQ/KgDveL98nHJVbYYIvrSf1dC
 KfWgE8dJ29/HglDG5pDEgHAYn5UMZR4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 17/8/26 17:59, Paolo Bonzini wrote:
> On 8/13/26 20:16, Philippe Mathieu-Daudé wrote:
>> When comparing the KVM implementations, RISCV and ARM differ
>> from S390x / PPC and LoongArch. The caller expects a non-zero
>> value to return pausing execution with the EXCP_HLT exception:
>>
>>    3427 int kvm_cpu_exec(CPUState *cpu)
>>    3428 {
>>    ...
>>    3434     if (kvm_arch_process_async_events(cpu)) {
>>    3435         return EXCP_HLT;
>>    3436     }
>>    3437
>>    3438     bql_unlock();
>>    3439     cpu_exec_start(cpu);
>>    3440
>>    3441     /* Inner vCPU loop */
>>    3442     do {
>>    ...
> 
> Your patch is correct because, even if cpu_thread_is_idle() sees cpu- 
>  >halted == false, the flag could become true during 
> process_queued_cpu_work() because it releases the BQL.
> 
> However, I think the better fix is to remove the return code, and check 
> cpu->halted in kvm_cpu_exec().

Looking at it, even better would be to move *process_async_events()
from inner loop to outer loop for all accelerators. For HW accels it
seems quite trivial; for TCG I need to figure if it is safe to call
icount_prepare_for_run() with the BQL taken, due to the replay_mutex
uses -- here the win is cpu_handle_halt() ends restricted to system
and we can remove the odd EXCP_HLT handling in user emulation.

> 
> Thanks,
> 
> Paolo


