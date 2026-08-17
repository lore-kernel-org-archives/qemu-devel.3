Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65927C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvodk-0002S8-K8; Mon, 17 Aug 2026 00:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvobj-0002M0-Ol
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:05:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvobg-0000fk-Dl
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:05:53 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLCN0c3656967
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k3WqcSAfnmBzh1piLTC1XHxZVUXHJPKltMbs6+hn7n4=; b=EIHn/dLWtLiFiZdl
 V8cvYEpZB5Ywh5iCkPtO9RcfV94ACnpsSulTxpsmY4MfYS/1Pr+oifL82FSsUdyU
 hSRSaPJe02bcJCDknhp3k0jiw+Q4CPk+7E2N2WJENdsCYsT+1QEaFWVtBbTxAFFz
 f0q236cMwrksdp4AG4500+NuHbqN0DOTVZgh3TCgdHh4pjn+pIBL1ObPEiL4VUiu
 fgNzG/vC0OLvXBOZgQMvS6jPxPupKHrHe+9lMHo5lxEDjQI4XN4cGs62gLGe5ayR
 i7nCH1HMfenECepXwJva5i3UYxjNq7O67AMVEUZjgkn5ARn+vYyjkTPi/FJiZv85
 KX6SRw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9gn0hc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:05:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e695a3b28so401570985a.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 21:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786939547; x=1787544347; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k3WqcSAfnmBzh1piLTC1XHxZVUXHJPKltMbs6+hn7n4=;
 b=X+h8/cKRruuVZVS5fgoyexMsqqfaxd/zbjG010CToHxDb7X0nevFw4AIGvoaWAviEO
 9//O9cmb7q2sHcLCKxNbq/ScI6bJMs6CAdn8ZsLxThfiiWXpvHTvH8NGXIxuXlA99Nr/
 TzrFNYb5F0mVKvrfJBrDLHS/i/LDDMO0+p+7OH5L5lqOuMwS95pX52lt3HKz7DztwBIs
 rQeg06tszdZOhuyO5C18qXe912tpsi/55nQN46NE4OrkwC/G0dgsPqH+wknHiN+bxILx
 tgReS0Ntan+vCKnrVlyWQ1iBHSZ7vzztry7bYcZredRH1+UEH2k18UKl/1SLM/5XhY/N
 B+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786939547; x=1787544347;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k3WqcSAfnmBzh1piLTC1XHxZVUXHJPKltMbs6+hn7n4=;
 b=qqnL73iVvkc6dXeKp/mM+53I9iELbvHhpUj5LqOOE5OUTqXPRA6sEhlKhEmSaIZITt
 oE9s2WDb+jZEhstq+vxp/oIwDMMxmr54DpKQk8rXOmsbDlcCM+IDwV3eDc7RmrtsSbwW
 ydSKkJhpxb4oL57rehvmDq6l9NTLJxAazT2hNkiVRaoCN2p6fQYMGXNrwoIBq7HxXT4r
 JtELUL8GULIjn0faHs9HkLQVG2EEdsTwSm7TW59o3HMzJabWgus4g/RevPGQj95Pa7MH
 IjUmFpvB7+Lk7xtX9CIGjgEhquylsf0tT4nOCIPZhczxmrEAsUHJwTQq2mxo2lse3iMm
 pG9w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpc88piCK6XwA+jE/hGbdG/D4SqkU9WL8xpUG7Nr32LMLfYDLp3BGjY8E2LgsS4xjZNasuyahyaAbsT@nongnu.org
X-Gm-Message-State: AOJu0Yw17d7DRVjT2f0AsX7wk4A1X7p7C0ROpMiB4THf47w+gbvFTHjR
 aZjVPjuZ1+OwqtvXbkJNqa47Y9oNV2I7UziBtrN0/VSYhl6owHUl87O0bHgd4+ZTBPYQBgMLu/g
 pL/xMGAxjaRrpsR71tcJ9XykSNtecmdP73d965Lb9cjYzMERYdLERjyib+w==
X-Gm-Gg: AR+sD12RFm7lx9lqzxB8T/PejCg+oTMUINF1boVmOo/VyfuNBYGUJvftbujTIvF508F
 eUsRSYWBfe0FJtweuGOJKYki4JkSIsTozk7sUafUwejImhusmUcC3k+TxnOTn3hDKiSgU9icrhX
 /XBFWOSe77wY+UoJYrQl4mlQ8TXx1G5rVCk1tZXzlIPlZLXhLQn6ALUpuSahzf+be/HKt20Pem1
 Sf7MXSbsgSGLIpNozWJgRUyuHJLMrxTY3idBYVJYSmkCKu5/k3JUmbKob3SRlojbHr+Laj18KvP
 2l4NQUQ1FAp231Nejmefb+G0IkUceNnVyYgxyRka7KYfG40KoJCCDdgDD9Vo2TU8VetgDTgPNND
 eFjpFNLflKRXZQYg62yK9xx9Fz+yDK/on+e8=
X-Received: by 2002:a05:620a:4442:b0:936:a8a0:cdf0 with SMTP id
 af79cd13be357-936c07231e8mr2899432185a.15.1786939547133; 
 Sun, 16 Aug 2026 21:05:47 -0700 (PDT)
X-Received: by 2002:a05:620a:4442:b0:936:a8a0:cdf0 with SMTP id
 af79cd13be357-936c07231e8mr2899430285a.15.1786939546749; 
 Sun, 16 Aug 2026 21:05:46 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d06167csm5127035e9.3.2026.08.16.21.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 21:05:46 -0700 (PDT)
Message-ID: <8e376be3-446c-4783-9081-a633ddbc7a74@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 06:05:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] kvm: Provide explicit error for
 kvm_create_guest_memfd()
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 jmarcin@redhat.com, david@kernel.org, pbonzini@redhat.com,
 chenyi.qiang@intel.com, farosas@suse.de, aik@amd.com, xiaoyao.li@intel.com
References: <20260812201938.198915-1-michael.roth@amd.com>
 <20260812201938.198915-4-michael.roth@amd.com>
 <cc83a207-c89f-4ec7-864a-db0115c4f641@oss.qualcomm.com>
 <an8Nn5cb52ev4MF2@x1.local>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <an8Nn5cb52ev4MF2@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HR1Nqc18c1Bsv3Y7IxD5_q8sEYP2T6AP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAyOCBTYWx0ZWRfX7Ika4SDAuF9B
 vHp8PEK2FJ7L3SSUKZSaAx9okHHW9g4p+4hGAJi3iKsR7Irt5eq7kARG+vYle0lVIou3rNperYN
 mRNCcipzxpD/mqNLU0dJEVehwpkOPdY=
X-Proofpoint-GUID: HR1Nqc18c1Bsv3Y7IxD5_q8sEYP2T6AP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAyOCBTYWx0ZWRfX8nbyvIH0H8yW
 CLz86F75AYb+dkpzblN2U6npi09XAfJmQICPRT2imMAqbfl27rGPBk6KHzQqfsxUqo43VpZr2BQ
 lUhvG/vlvF32ks2H6EkdUfTDc3yq2mC8WxQ7y4/JayH8jmtL14IIRu+hNoLckJvr0h7jR1Mp4zJ
 5A7SYtRGsWOwGpawymZ91I2PC10vXXnrUJAvha4BAM5nD2M0bA03HdCS6ksMOrIZQVLoQ/xypy7
 sIdVvSoNCW/4s9LpPoi5r/mODtCk8HJYKEygrh4fiuX24IZvnUrqkARI5LjWlxE4SDYdIXxSXtG
 tDiEWwbjAmzA0OjK1YkziYNWIqeYBCtfRy7ni2x8oJ48ZWtcbnsNWGE31tww5RjtpaFKJCMbWxi
 r9G7tCIBSkuyTtoQLKPNGXLMyedY2Wx7EgJino5zMOzylPXH5KxJzEz1gROrUARY03ecti33+bt
 wAQXmeTr5g+qilQf4BA==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a82889c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=zd2uoN0lAAAA:8 a=R0W7oxC2TBocBvmClHUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170028
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14/8/26 14:44, Peter Xu wrote:
> On Fri, Aug 14, 2026 at 07:56:42AM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Peter, Michael,
>>
>> On 12/8/26 22:16, Michael Roth wrote:
>>> From: Peter Xu <peterx@redhat.com>
>>>
>>> So that there will be a verbal string returned when kvm not enabled, or
>>> kvm not compiled.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>> Reviewed-by: Michael Roth <michael.roth@amd.com>
>>> Signed-off-by: Michael Roth <michael.roth@amd.com>
>>> ---
>>>    accel/kvm/kvm-all.c    | 5 +++++
>>>    accel/stubs/kvm-stub.c | 1 +
>>>    2 files changed, 6 insertions(+)


>> So maybe what we want is:
>>
>> -- >8 --
>> diff --git a/system/physmem.c b/system/physmem.c
>> index b97016b1303..66ff74541aa 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -2824,6 +2824,8 @@ int ram_block_rebind(Error **errp)
>>   {
>>       RAMBlock *block;
>>
>> +    assert(kvm_enabled()); /* Only supported by KVM so far */
>> +
>>       qemu_mutex_lock_ramlist();
>>
>>       RAMBLOCK_FOREACH(block) {
>> ---
>>
>> Or less aggressive:
>>
>> -- >8 --
>> diff --git a/system/physmem.c b/system/physmem.c
>> index b97016b1303..2988d1dd6c9 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -2824,6 +2824,11 @@ int ram_block_rebind(Error **errp)
>>   {
>>       RAMBlock *block;
>>
>> +    if (!kvm_enabled()) {
>> +        error_setg(errp, "guest-memfd requires KVM accelerator");
>> +        return -1;
>> +    }
>> +
>>       qemu_mutex_lock_ramlist();
>>
>>       RAMBLOCK_FOREACH(block) {
>> ---
>>
>> WDYT?
> 
> Fine by me.
> 
> IMHO it's normally more of an issue the other way round, if we used an
> assert() where we should use error_setg() (hence, user triggerable
> assert()s).  Here we expect it to never happen, so either way should not
> happen..
> 
> If so, we could also assert() in ram_block_rebind(), as it's only used in
> kvm_reset_vmfd() only, so I don't see how it can be reached if KVM is not
> enabled first..

I'd rather avoid kvm_enabled() checks in kvm-specific API (accel/kvm/).

If ram_block_rebind() is KVM-specific, why expose it as RAMBlock API?

