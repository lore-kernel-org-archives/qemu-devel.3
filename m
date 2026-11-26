Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8B7606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SVEOEnAN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWbxG-0000Q2-VI; Thu, 26 Nov 2026 11:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andy0x48@linux.ibm.com>)
 id 1xWbxF-0000PY-AS; Thu, 26 Nov 2026 11:04:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andy0x48@linux.ibm.com>)
 id 1xWbxD-0003tD-Kc; Thu, 26 Nov 2026 11:04:13 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEYfQR422451; Thu, 26 Nov 2026 16:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=verv1F
 2qKUHrr9IHN1bQLlk1/s2lS1oCijPJcMAU6CE=; b=SVEOEnANY8FIP1PuRk33RS
 uo4JnU8D/Ir4dBrTUvtkrZuhXha+bwq7wewkY0tZv98a/PcxQYOoTdUTqbxX0lhf
 zNGGSltbfDzq1DKctfy1FCmC6sX9VKjnQeDbtZVYKwLbXxooNwlKU5tYwKZgmYkT
 ptAeHTv6t5dn/mpSAvVqk2YcgWFpulogWJuzOwKvuiuBKk+z/yySDN0NwZKHQsVC
 p/EYTLTg8F+Ap0IBCS2czLiGDkdFN/h/B32ZIoypPjdvr9wBpZ7PcvyzVeL1LEYs
 C5abTXFtENQ/bQLMbF9BSZI8DwazVnK0ueLvh/kRU8TkNaIjrJ8hnwe4MDBibexg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkt2gw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 16:03:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEYGgk3539962; Thu, 26 Nov 2026 16:03:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6mjg0pq0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 16:03:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AQG3rnA55443852
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Nov 2026 16:03:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0782F20043;
 Thu, 26 Nov 2026 16:03:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C01320040;
 Thu, 26 Nov 2026 16:03:52 +0000 (GMT)
Received: from [9.111.51.92] (unknown [9.111.51.92])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 26 Nov 2026 16:03:52 +0000 (GMT)
Message-ID: <b985b318-6a35-4dc0-b284-3507d44791a1@linux.ibm.com>
Date: Thu, 26 Nov 2026 16:03:52 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/s390x/tcg: update regs and IV/tweak per
 block in CPACF AES/PAES
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org,
 freude@linux.ibm.com
Cc: qemu-s390x@nongnu.org, richard.henderson@linaro.org, david@kernel.org,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com
References: <20261120131443.61606-1-andy0x48@linux.ibm.com>
 <20261120131443.61606-3-andy0x48@linux.ibm.com>
 <23756053-86fb-4732-bef1-397be6233c38@linux.ibm.com>
Content-Language: en-US
From: Andrew Holden <andy0x48@linux.ibm.com>
In-Reply-To: <23756053-86fb-4732-bef1-397be6233c38@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA2MSBTYWx0ZWRfX7S37n07zIBWG
 N91mXR9OOOx3Sz4sl0eg8iivafys2c1tr5Y4+7rM8aaWzmLyaek1T00nTu7nTSCZUU6QNLh+Owf
 NKBhv6Eds08jLQ8QWFHM/o63zCTiDDuueQvjsxaJ+ywIbG+g473NviYdzST+gHBFt3FTngXU3Wl
 /GXqqVs7UrWZy40lgnVTTVOWu3A865EfzpqfKAUKVkvtigkVcHz1bp3e2SoAAw3EMQosH2ilEyQ
 vpGTp+SXduH1YZx1x4rUxzTJKUdlb8dm9i3x4JzZexolvucDaq/7N6X4zdakKjflBVZxxlGx//Q
 k8WA272jnqWHtRN+ps4aBm2VD1gaKv+Zq0T9kmIT1qCjysJx2pTg5Ol/6UCgC+PNYZLgN2+FogE
 cwlKV4VeoGUrWs36fBnKDVvq6wxn6Yv8ltzxpVp2jnkrvVGAO6+AC+ZnG3avFuZyjJpWq/Nny7I
 be1pekwCrAWsXoo22YQ==
X-Proofpoint-ORIG-GUID: BRWE26SJEwAHWEHwPdUKst109o88FWLX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA2MSBTYWx0ZWRfXy61rbiF7zelK
 8Y9vTbLsWdunJGGi3lS7pirkf3uX4zkq/TTXHzditdAQEosdvrfGPtHUipYdCsFLPgMGn7R+Znp
 3GJ/GqV4NBjvPV5XfzqRcmLmvSkErpU=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b08586d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=8DlQGE6fn65XYDxTWSUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BRWE26SJEwAHWEHwPdUKst109o88FWLX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260061
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=andy0x48@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25/11/2026 16:32, Ilya Leoshkevich wrote:
>
>
> On 11/20/26 14:14, Andrew Holden wrote:
>  [...]
>
>>   /*
>> - * write exactly one AES block from local buffer to guest memory
>> + * read exactly one AES block from a prepared access into a local 
>> buffer.
>>    */
>> -static void aes_write_block(CPUS390XState *env, const int mmu_idx,
>> -                            const uintptr_t ra, uint64_t guest_addr,
>> -                            uint8_t *buf)
>> +static inline void aes_read_block(CPUS390XState *env, const 
>> uintptr_t ra,
>> +                                  S390Access *acc, uint8_t *buf)
>>   {
>> -    write_guest_wrap_u8(env, mmu_idx, ra, guest_addr, buf, 
>> AES_BLOCK_SIZE);
>> +    /* gather block */
>> +    for (int i = 0; i < AES_BLOCK_SIZE; i++) {
>> +        buf[i] = access_get_byte(env, acc, i, ra);
>> +    }
>> +}
>
> Can we introduce something like access_memmove(), but for guest-to-host
> and host-to-guest transfers in order to avoid byte-by-byte accesses?

Yes, seems like this makes more sense, will do!

[...]

>> +
>> +        /*
>> +         * linux-user: the accessors below use host pointers. Record 
>> ra so a
>> +         * fault from a racing unmap of the probed page is unwound 
>> correctly.
>> +         */
>
> I'm not sure we need this comment everywhere; the existing usages in
> target/s390x/tcg/mem_helper.c don't have it, and it also repeats what
> the function's documentation already says.
>
>
> The rest looks reasonable, thanks!
Great, I'll address these comments.

-- 
Le gach dea-ghuí,
Andrew H

IBM, Waterford IE


