Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F6AC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Zwq-0005OT-Mv; Tue, 15 Sep 2026 16:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x6Zwo-0005Nn-W1
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:40:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x6Zwn-0006YT-99
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:40:10 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FItmPc638336
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 20:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DTSpDyyhMeaRp3+b1u/gwYr3WghI8oagLMKbTS+vfW4=; b=g6uEJp2JL+DdfIIg
 Kh20LzkGzZrdznSZKhvtvhCaqGcPMFP2cIwWYko11ampuM45Qt+rTk/tVtT9KYRi
 X3jhxGhFeaWxEqHh+FtiyO9jSYbJUBoNqB/y/ugt6vBYbFdCQtNvdTn49j1Ve2Rt
 OT5qBBb2eYLmhjqIHfT+06E34ngdPG0Ua5n9Pdfz2YglofZhpoQ7/ggrgQSKuICm
 ICN+srJ+tz7Zx3jpsLrBUi7Gv+hWoJis2wigDSTKoY7rEw1Sq/meY2at6kAoF1tQ
 CVLrWU3t1qYYtYUvEAun0zo9uPVfkxJymGb5g5DeEqp3YR0LWffb43rwP+vbXJOD
 Z9oi5g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3xtubgk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 20:40:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a1bffc2eeso750395985a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789504806; x=1790109606; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DTSpDyyhMeaRp3+b1u/gwYr3WghI8oagLMKbTS+vfW4=;
 b=RNAhnaHq5GGj5wmfdL7DtZiA/Ba4CiJpF00BuesWHupQVBMRbJjk5H6KwHMXESDhsu
 2oufLmhTIi1kyYKPJTBKFwjHDTGDSslKhmD55m0CmpWly8C4EBDCfYnZbm/qY0R18tJO
 KA96GQ5oJ/4fs7DneYJJhxgrF/9FE1kNXxxTzUizGyu3kVQXSOr8GU398dcqk1gWbHvD
 NHLyOUmNY4WR79dbr7jnoL1yhgRxSJ2yH4ZyengAj9YmhBajdme1SwFlRO/7ty+F1374
 /QLqdgawZ4usfma/JlK/Oup05inTXI7ZVDV3sR3qU0qKKsbCC8mdesg72797v1QvvVSb
 mz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504806; x=1790109606;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DTSpDyyhMeaRp3+b1u/gwYr3WghI8oagLMKbTS+vfW4=;
 b=re9dVcK0SJIKaN3wJVWS/4kRJbcpHi4khH2DQRlRYGDgdyFjkm9vRwq1YGb017FUs+
 eGijCi7dVEIZycrNjM9U5zraLINJnwKC28cchwTolEDSWA4oICIqW0QKJBhIoofgwybX
 nxeyEoEzUJhhhV7938g5dJh4sjadxvE726F4pbKay9OpDFwMS1uVqYmUeonkxvGlfAzM
 /LM1GT3UBoqXCg2Ij6dJ5Og45dvFDRSfsJhbZMAfzS24bSV9XfAfEYp4j8k4yHbEObDh
 eIHRPSPmYAJjldA5l3+jKmg78BDJXCrscdfpjbPdIMnJHqa5N6t8+uBJD1wGGSOQSgrg
 PthQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDgvi71xROkoiWVUUUMb/MrR3Xu1oACX+HgqTNU9UgATEMf1fSe512N9h9PXDFh1u5Q56JPYA3ELlq@nongnu.org
X-Gm-Message-State: AFuF++m0OqO8beAO12yJ9wfBRBDJxnuQWBix4t+lkpgCXOTCipAAmd4i
 jA0MDyy4UDu0vUq8LAQ5Ct1MvTBIRTd8pMFOaQVhrB9+9zyc15hF20NuzHn2WfavUAOViYi8iFj
 kHqHDpRvkhV/4IH1YM+YCMW/CJZ7JeB868E87dB1XYr0qufP/J1H9M0sboA==
X-Gm-Gg: AYBFou21eBYoN4ma69VwIybARx3WVCkgMiTB9mBPC9k2zY+IwwyD69uzkoKeJ22peoE
 BJqUd0tMUdXqH/w0pQ53BoKA3l241OsWPsVW126IhzspSX/nXaT3seKxULkUo1VqjqE7GjBM4i2
 65szpC2wKyskD7j15j9hEtgV09/Vtqt3YjhH3fFHlVMiLFNl2GAzvRRNOUcbdgcdomJ8oZCH5td
 mXktw74G4DPu0vSeOwYBwu+yrwAZ/kHOr2kLgc16C7G349Sn3EwmZabE9iWaL6dpRsv1QMAobej
 BPhTJ61IFllgXbotPUrreXpH2chBwq3T7Pzf3p5YPMJ7JaUNBtJ0mY9wERFN9QWaeb+HaE+eM4B
 uhDRDtXHTSX1E/Oen3fr2vGGYrodqrZUiGNBrVQ==
X-Received: by 2002:a05:620a:2697:b0:939:7f2f:b17e with SMTP id
 af79cd13be357-93a299491dbmr1273381485a.30.1789504806218; 
 Tue, 15 Sep 2026 13:40:06 -0700 (PDT)
X-Received: by 2002:a05:620a:2697:b0:939:7f2f:b17e with SMTP id
 af79cd13be357-93a299491dbmr1273375385a.30.1789504805797; 
 Tue, 15 Sep 2026 13:40:05 -0700 (PDT)
Received: from [192.168.68.102] ([189.110.107.170])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93b81cfe364sm43269985a.40.2026.09.15.13.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 13:40:05 -0700 (PDT)
Message-ID: <d4535ac9-449b-4829-a0d1-1eabcfc2c08e@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 17:40:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target: riscv: support TLB page flush for
 sfence.vma
To: Richard Henderson <richard.henderson@linaro.org>,
 Trevor Gamblin <tgamblin@baylibre.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
 <165fb72b-3cf2-4693-88e4-f9d36c5c498d@oss.qualcomm.com>
 <19735ac2-9357-4d17-847e-672781539b0f@linaro.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <19735ac2-9357-4d17-847e-672781539b0f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xS4Mu8pYWAjJuuOjWsr5s9Fz7f0NNasr
X-Proofpoint-GUID: xS4Mu8pYWAjJuuOjWsr5s9Fz7f0NNasr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMwMiBTYWx0ZWRfX8jhpDX9IStSo
 A8KQik59y2Dhhls8qR00QuEjlrHlp3xSH6hHtXIGylsa8EHSFnuxx3/lyHRi+QiDcmLTJQmNAYC
 x+fYoYav175veVQlGM7g39ctDhgscfA=
X-Authority-Analysis: v=2.4 cv=As97T+9P c=1 sm=1 tr=0 ts=6aa9ad26 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=arNgJ3JLhM/z8Vk/iMOFgQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=Ux0HaAIcEQ9x_9cGLTIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMwMiBTYWx0ZWRfX7YJY3lFTRkfs
 HQSNn6oLZQglJvUx3UbTb5znAtcg+ZekCDmAS4pSmXLMsKsua+fE86xMNPNJGYzvhWYX8W5n706
 gFlYRrldVH/Ezncwaa0j9T7l8/iDm+VGQVKhBfWtP3J7FxOdclyWRIzF1YKAag9nkjjuf4j58TS
 DDjG88OdInDTyKM7LzWZTRvUDCukcrRFjbcx67PvGLMR7/XwfFzksoK6AZqMP9Ui62DCG2SjvjI
 4rl3NYZhlD6ZJXnAToGEzCqWLzPaPKCKGjd/dnq2RTl3UKYUwhCHdl2AJPAF0ZdZCD5WQekONK9
 O6YzJ77LtyNuLtVbe5Nw2YmB3/oXcS9AEo2lxLU2VydLilLo0LSN0SBAmdq3BqGzxdilMlDfKS3
 swYPnHnugaGANtg7//vNzX/s8+gsZ9pjCsaMTFtw20ZaZlAdBAygtdwfu1Ubkh6Nh8DIf/vQlWj
 bdepgrO3wusKqerKgAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150302
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



On 9/13/2026 10:14 PM, Richard Henderson wrote:
> On 9/7/26 03:14, Daniel Henrique Barboza wrote:
>> Richard,
>>
>>
>> This tlb_flush change is giving a +20% performance boost in riscv64- tuxrun.  From
>> this:
>>
>> 23/23 func-thorough+func-riscv64-thorough+thorough - qemu:func-riscv64- tuxrun  OK   92.71s   4 subtests passed
>>
>> To this:
>>
>> 23/23 func-thorough+func-riscv64-thorough+thorough - qemu:func-riscv64- tuxrun  OK   73.45s   4 subtests passed
>>
>> Other tests weren't that affected - I take it has to do with the amount of
>> sfence.vma being issued.  They look fine in my own testing with an emulated
>> Ubuntu host as well.
>>
>> This is all fantastic but I wonder if we're missing something.  If you could
>> please take a look at these 2 patches and see if we're handling the tlb flushes
>> according that would be terrific.
> It looks good.
> 
> The only possible improvement would be to avoid flushing the PRV_M 1-1 tlb, using tlb_flush_by_mmuidx / tlb_flush_page_by_mmuidx.
> 
> You could also rename MMUIdx_M to MMUIdx_PHYS and use it in modes other than PRV_M when the mmu is disabled, simplifying the test at the start of get_physical_address.
> 


Thanks for having a look!  I believe we have a potential cleanup to do based on
what you said in patch 1.  Probably follow-up material since it'll be a bit
too much in the context handled here.


Cheers,
Daniel

> 
> r~


