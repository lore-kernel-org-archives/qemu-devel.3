Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1C5CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcL8c-0003JL-Lm; Wed, 24 Jun 2026 06:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcL8b-0003JD-3B
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:47:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcL8Z-0001xV-Cm
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:47:20 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OANlE12586221
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hkR4IJSKEuCIzSX8PalMwKxB+AXbGXYpK1dFegbaPxc=; b=SN6btQsKEWb30Cqh
 yZVLdv7p23SNtDpimqAszGfeOOC82brBO/A52x0C/NO+54LE5r6RTyi7GDsr6AjU
 +gdyNle9H/Q/NhMe07YTpTc5C2VSZUuVyi/UQoQvYe4vGxjCKpIUo/VydTNaHA5I
 oW5DNmyEgBZQD8rmnk2VRLJl1mcHKhLQsRCVwcLcBqBlzlqoOLEveJY6qrxTwxvL
 10uAdgu39lBUW+Tj9IthkzJNSyQwd3hwN12SLZFB3/ogg1GLRAHiXzY9cdZbY297
 sNPGZuwDWLLRtx6Rl4RsI9eWIMuCq1ZkhLS7pDW3uZ/94BhR6WykYlq/5ilOh2+1
 dK0rUQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05aq9u17-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:47:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92045e86763so383371985a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 03:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782298031; x=1782902831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hkR4IJSKEuCIzSX8PalMwKxB+AXbGXYpK1dFegbaPxc=;
 b=OtpcINk5RwJKsfe4Rf7OOjH9j+++uXJCm/CivWn4+b43gXti+ztjax1TAnTBhPObTu
 Pm+BXb5I5agTqSYiEbAZdx+CUUQx2VN6oTtd7sEo+gIiDlgg0wlcP+BiKZ6/xMM/Up/W
 iECY2mv5mCZBgDttkOPk/Ya+26aCni9Vxr87p00u6QVDP3YuUf5u01Jq7yY8/jT/ZfEV
 NP9rYK8g37ic3L7EQB4RIMhyOVUj3JgSQChS/pAIVfROTRwIamUWo0u32JXiDjes394g
 1DS25hUJRkZf5/EL/jt3plksRfTB7ETTM5pnYVR97VFB63gd8W9Tt9HhT/8WGXXKwR0g
 7A0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782298031; x=1782902831;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hkR4IJSKEuCIzSX8PalMwKxB+AXbGXYpK1dFegbaPxc=;
 b=S4kAWQJd4UgV4Mtg733f8eoUILWyGRP+jTr7yLhGBm6rbh1ptfbi5V8F5JwWn6IGJz
 C3yuYbEeV4WIMdxSPrAroohL5XbIMneIUFNLwA7PNATRvDhYXiIqijpA9/1sSqac1hUy
 NHWrHa27glpJ/6YNAUwkV54hOC82xirvSyVWguW5EAQl0XAzIYA4hZaQYuKH0H1ZI+ND
 nDz2x2+Ef+LZDPcG5+xrxe8Be5FtLsIX1rzeViA9FPCubueJ1nUQXoUZz5NU5hxoEnui
 DY4ZsS/Hb7KlQFEQxWwvGf59sGoRhdIHA2emDp46KmoD6dYcuN5rDaran8oAB1DYN8oK
 ppQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WvF/0OVSVhHT94CO/RHjlHZGtpRN8j2+6OyDrxAoDv/Sh13gOFX6/y8W5w2zpaf1USw3FGuJA0Q3V@nongnu.org
X-Gm-Message-State: AOJu0Yw930K1B2EFBXX4EFceVIB7qclJODjNLJdbP71GS4nNaq3dm2+X
 diTGtD2Dvr8hnDoIGTOvzYueaxzEzuVtSY2KWIAvZYOrnC3ldDIMs5EpxD3qlsmR8cdl55zeT7c
 x7R3yVu+6DJu6BWF9hUjs8sob9ASFPSN8yJ/hq+B2IO6Tu35aqAFTQSkcBQ==
X-Gm-Gg: AfdE7cmPXXCHQXDrTRrsSNjJRncf+EbrLNeGxyb8D5v3yFJUwpsSaqw1eZoKZqXHUD6
 IUW2Ke0xYLL6WCBXZ1k/2LpYrRU7d9q6ktVELbqd464r14kUPOol9G48ok0qdSrwWqXoVew3qqb
 FRwp5x1IXlQuDNRVO9XhlakYo6cQfZwZX6jFCZmxIxpUJ4s4eVgyqkXiXDkAHtK5mefS1DwRrWe
 u1O17hoiGtwGbMNDLtnuTRPDrGurwE1GIwkOXEIIB7I0qzrn97RseWyegDXOeTFV4gN/3EaA6Z6
 feVaQ1Nx6gZuijtpyQ0LKXtzgEMM0/AZ3WyU3zkE5J2tB4MXf2ps+uAL3YyU8bo+Qno/S3H2/O3
 tLKeb5im5B0SdvDHzbKIXLqPSu/RjxawvGRHSvhZCk7B3Q1Z4pucm9qFendqyKw==
X-Received: by 2002:a05:620a:2684:b0:924:eef7:d017 with SMTP id
 af79cd13be357-926029ee7c9mr1048911385a.31.1782298031609; 
 Wed, 24 Jun 2026 03:47:11 -0700 (PDT)
X-Received: by 2002:a05:620a:2684:b0:924:eef7:d017 with SMTP id
 af79cd13be357-926029ee7c9mr1048909285a.31.1782298031104; 
 Wed, 24 Jun 2026 03:47:11 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c221d93d8sm10328886f8f.23.2026.06.24.03.47.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 03:47:10 -0700 (PDT)
Message-ID: <76024e07-d14a-4808-a68d-07185ec4726b@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 12:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] accel/tcg: Remove pre-vCPU
 ignore_memory_transaction_failures flag
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260616153432.92939-1-philmd@oss.qualcomm.com>
 <20260616153432.92939-6-philmd@oss.qualcomm.com>
 <2cf33941-82f9-4497-b7be-2fd61c4275e9@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <2cf33941-82f9-4497-b7be-2fd61c4275e9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4OSBTYWx0ZWRfXwea6Ly1R8IMM
 aGFBkFXtpPiw0O+LpQs0xmyPZ93yrBBv0ISfTMnCoaftIMYynV/xgTEuPk5itMm3s7NWqq7esBg
 q9F0NWWDV9bwAzkhV9ENrYGg+DUa7fo=
X-Proofpoint-GUID: 2rls9uEiObt10GQgcfUq4zt_VBsSPW23
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4OSBTYWx0ZWRfX59hktkkjLtxh
 WGxBL7TNB8p9PxkOzV/PJ3XR6+/sLf22AdkQvV5kbd/hkG5Jd9nBTtKI5wi55+5LB0qL7ej5kOX
 BEhhiyKF5HA/jHo9AglRR6DtzgKsiLsnjqyIzo4qKqKDZVMF8YhdF39467Y+403wnCHOuW0wquL
 oyvTfy/NEsaxansjroUOTFkKdTWxZsSqRj4Kem81qSA4XC7pCkj2d3wfFavWZIWHlmUD5oFPLSM
 U1U84y8evGVdTSSTy3mbMs5udCrEwcTbi0ENaE54RBxSJlbaEsCRp781gk+sQiX+t1OImtlmSoi
 aPr2okB0dvYuG5vydWvVXqnem7f5nP2kvUDRSIFZdOBIF25olu0panPYqpscPwuU7dTKCky/sp6
 jXYRXftO91WAyopzSLGChYRoN8l8Vw==
X-Authority-Analysis: v=2.4 cv=UphT8ewB c=1 sm=1 tr=0 ts=6a3bb5b0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=ZaDHDpGZsxRR_M2j62IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 2rls9uEiObt10GQgcfUq4zt_VBsSPW23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240089
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 16/6/26 19:58, Richard Henderson wrote:
> On 6/16/26 08:34, Philippe Mathieu-Daudé wrote:
>> @@ -1291,8 +1294,10 @@ static void io_failed(CPUState *cpu, 
>> CPUTLBEntryFull *full, vaddr addr,
>>                         unsigned size, MMUAccessType access_type, int 
>> mmu_idx,
>>                         MemTxResult response, uintptr_t retaddr)
>>   {
>> -    if (!cpu->ignore_memory_transaction_failures
>> -        && cpu->cc->tcg_ops->do_transaction_failed) {
>> +    if (unlikely(tcg_ignore_memory_transaction_failures)) {
>> +        return;
>> +    }
> 
> Any reason not to pull this from MACHINE_CLASS(current_machine) instead 
> of a global?

Restrict this TCG specific handling out of CPU common. I'll see as
an alternative to defer the check to late TCG TLB init, allowing
to make the boolean non-global.

