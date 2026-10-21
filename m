Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C76606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BZjVMneG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ft3jEfOc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJb2h-0006vt-0j; Wed, 21 Oct 2026 14:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJb2Z-0006v4-6v
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:27:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJb2W-000171-BU
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:27:54 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpPWj996491
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rJamz8/us03zg7ASzX+rAkQqwBTWo50jfFiKht9K5W0=; b=BZjVMneGA6goBUzj
 4aqMQbRWS4Vf+YKgGWjnUDZJnSeNZYY1tcve5BWJbyS9iXop2oRaPBTWDcDtBRRH
 Bh1Fpp0lxQkHa8KpJ6cHtMMGbFjlZ03gpFzr/Wq0Kesdd7288G1ZwCdaYT8l0fDi
 F6stl8lzjv7IP1GqEr0m1IneximCZ8mE0h8/OjfS1YHmXIn94OQYEIrwXdfIhX6x
 wQ8/jKjqLBVFSbDK/y2cYHyre85KHx5nczZhV9kDG0dChs1zEbPfxn6joxDomdlE
 9gVfrkpW9Z7lXW4i5zbpeysYl+NEu75JXgQrgkz5rNpi2IewSqir8/yBJr+MYIDg
 Hp1Mbg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex7vsbf9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:27:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf6c528aso171479885a.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792607269; x=1793212069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rJamz8/us03zg7ASzX+rAkQqwBTWo50jfFiKht9K5W0=;
 b=Ft3jEfOcf5YBdVoBGnQYkwJVEl25qRl2P/g8OfHQcsI6gHNTo6KSwQSyicLTaxSxoK
 fDnwpFAx780RJ/kz+vaodZpPmk9fk382ru9yf50pdheBB7+eSwlLP6ABJv1inP9O9HY/
 J9MPH9ywfL/DYTWtekQEgZgkGfszij8IFUPKVSRt1io4gniKAiULnm3QPUIS6RuQykD7
 E8iYWMf5ILAkveaRyz0RuxHwVryJD9Vv48GE0LWwy/JAo5THfLbmLQDG4NA1rqjhMZNk
 o7tpCryBoCGdV/frAlAEMB96E2pVb0Azo+vX2/AKBgVXURfc/IMWHlB73JrqRNHssD3S
 /FPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792607269; x=1793212069;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rJamz8/us03zg7ASzX+rAkQqwBTWo50jfFiKht9K5W0=;
 b=lGndNbl0YUKYUvyR+qmEJuc8J95e6eJMR4LT7yfWJIRemfrYIAX1ltt1RngJd1AU3v
 BwpUh6bDXRzadrHb9ws7N+mFPIMM+gf5i+73TFE4vnO1o1TkpcoMu4Ac9aPhm8UUPJoD
 PQpMkYnCnga8b3bmZy5wL3z9ex6d5Uj48trW2aLpj4xvISbJ6jugiTfKHc672tNMm4Fi
 DJTYe9q8v6oVh6lnCgygPbpvTnVyU6AyZWZfeRyMAqaZ48yxKaA2kYS65X2pIUKX7TE0
 L6aozvwLRaGwvoTvsvSPOn41X3mLwxbUhT/bNuQpnFV2JWrDgXrLmrpcqgDfHx6VE9Ya
 tKlg==
X-Forwarded-Encrypted: i=1;
 AKwUvByJC53X6Hgwwxn56A/9VWNWm0K/kONAa9QQY+/BGCGdbsoYDqeR/ELMmnp6dwznrc8N06tLi3O2PAS0@nongnu.org
X-Gm-Message-State: AFq9FYI8w4njwBaWaX50IQadv77Qhy9wbMI+mpm5KqJev8UlLqP4ub2s
 uDHuln5MoGVvHAx503QypKCF79HPdZIoY4tYlXcBA1SZuceukWoSpHYvH/qkUafeNAy3yVKLAGe
 KyLmPVnZkq4GBUseXD+doHL3z1RkAokUwIAeExPQreX6vnwKKYQuFS++g/P/pzeX0Qg==
X-Gm-Gg: AYBFou2yvFMa6ZCh06S3xOIpIpmXRyoHbspDiGYPPKn2qtKGirgtDceE/sttLflvzkj
 1l6Y+GjHXo26hIMdZziGOklKxiNiO2GoTw6o6gl/r4RG7rBHLGNq1yqHP+U/a7im9oy29UglQjk
 K2Un/g5gZkmOFVw0XzRiX2sPi9e1zAOtXo//OCYK5ic4Bm8u/QFFFYQkVuUKgCSbbjmSEsFrtUi
 kT+8c2Nxm3GNV+44ynZ/Vwl1F6GkJlJpd6ago9cE5a2FVkd9dRILBHVBRUdoXZsRJ4Zf/qfcRF1
 E2hwBzsrz4LUjPdK4K4Qu7EqtSUM0CalorLxEqvswiKQqhriox50rE4zyfZ2zPNYkg4QmHdNSNO
 mauH0cZ8gdU83xLifAztEZy6B6X1VN/Ps/g==
X-Received: by 2002:a05:620a:4712:b0:93e:c5eb:2230 with SMTP id
 af79cd13be357-93f57f1c936mr593765885a.33.1792607269486; 
 Wed, 21 Oct 2026 11:27:49 -0700 (PDT)
X-Received: by 2002:a05:620a:4712:b0:93e:c5eb:2230 with SMTP id
 af79cd13be357-93f57f1c936mr593761385a.33.1792607268918; 
 Wed, 21 Oct 2026 11:27:48 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203b63e35sm11154385e9.14.2026.10.21.11.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 11:27:48 -0700 (PDT)
Message-ID: <02b9b947-f5ad-4f7f-a5fd-d606cd38ffcf@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 20:27:47 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/21] hw/core/sysemu-cpu-ops: add get_dump_info
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
 <20261019212648.154493-6-pierrick.bouvier@oss.qualcomm.com>
 <18a22eb3-9e56-441e-9d1b-e1ecc9eb98a0@oss.qualcomm.com>
 <6e31d5f0-c2e0-4829-bf2d-85078d11b726@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6e31d5f0-c2e0-4829-bf2d-85078d11b726@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VPXTZVA51NmqwNWVBbJvPhwUIb3llomD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MyBTYWx0ZWRfX2lWK1PgdtNaq
 88V4iY2JFa+/5+vV68hfueOYr+jEvGmHp9PFvn5pPqNGKG4bJvtxgo9q9C6+NPFKmRzssX03UD3
 QjDaXtwLORzMXD9N0C8tH6SMG+lvbM4=
X-Proofpoint-GUID: VPXTZVA51NmqwNWVBbJvPhwUIb3llomD
X-Authority-Analysis: v=2.4 cv=e4uT2qp/ c=1 sm=1 tr=0 ts=6ad90426 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=aFKBbmax2zXKPqXaMSoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MyBTYWx0ZWRfXyIxeoYf5xwEe
 myl0nNspDmcypsp008fXdLa/w7ASeNwPylmMGaHAvZJl9P+VVvBou+1oh5ZCp2UcTPu7Cjh1Gfo
 iMM3YhF75MA7+U/1/5sOQp605h5w9MdyMDjGFX7ffndJZK1LHHyxFr7wZzIGxxbou7r2iMtEfTP
 EUdtVpP1oU7fQgj6TCyi7KmiKaDBFkv+bdj+0CJ4U6TXPimryIVKZb9QpZgmSZpW7k+BhujOqgi
 I4Qg5W52NQB+nwP3lOq/RCoGjm3/GjJJVGpB4NZqLinLZu0bHUKbKF4m/LiZjGtn9hHiCCAir6T
 HZ62Bn69SFj/G6MJAGKf0EhQidb/wWwH8k0DEa4fg0AkMGoXPrk/106gxZ0UWR9tzNP4tvO7Y3S
 kpfAP6bCpWkSYqavIAq+Qml4IRZ0Ls4n+J/UZjGxIl5UK0bebftiIu8VB1Lr15PA4DXoPnqWz17
 z81f68dS2UGpPm8aHoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 21/10/26 19:36, Pierrick Bouvier wrote:
> On 10/20/2026 6:43 PM, Philippe Mathieu-Daudé wrote:
>> On 19/10/26 23:26, Pierrick Bouvier wrote:
>>> This allows a specific cpu to declare its implementation of
>>> get_dump_info, needed by dump.
>>>
>>> Reviewed-by: Anton Johansson <anjo@rev.ng>
>>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>    include/hw/core/sysemu-cpu-ops.h | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/
>>> sysemu-cpu-ops.h
>>> index d125540262d..2c7d0b94767 100644
>>> --- a/include/hw/core/sysemu-cpu-ops.h
>>> +++ b/include/hw/core/sysemu-cpu-ops.h
>>> @@ -94,6 +94,12 @@ typedef struct SysemuCPUOps {
>>>         */
>>>        int (*write_elf64_qemunote)(WriteCoreDumpFunction f, CPUState *cpu,
>>>                                    DumpState *s);
>>> +    /**
>>> +     * @get_dump_info: fills @info with the endianness, class and
>>> architecture.
>>> +     * Returns 0 on success, or -1 if the guest memory can't be dumped.
>>
>> QEMU style is to return int when errno is propagated, otherwise
>> a boolean is preferred (bonus if error propagated in Error *errp).
>>
> 
> Taking a look at it from this perspective, we never return any failure
> from any implementation. -1 was just here to say "not implemented".
> So I'll switch to no return (void) for get_dump_info, and size_t for
> get_note_size.

LGTM, thanks!

> 
> Note: the global wrappers will keep on returning -1, only sysemu ops
> will be infallible.
> 
>> Getting the prototype right is simpler at its addition than later
>> refactors.
>>> +     */
>>> +    int (*get_dump_info)(const CPUState *cpu, ArchDumpInfo *info,
>>> +                         const GuestPhysBlockList *guest_phys_blocks);
>>>        /**
>>>         * @internal_is_big_endian: Callback to return %true if a CPU
>>> which supports
>>>         * runtime configurable endianness is currently big-endian.
>>
> 
> 


