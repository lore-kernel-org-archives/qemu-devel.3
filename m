Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78E606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D3lIfdZl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IGNa65Pn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWo8W-00082Q-E3; Fri, 27 Nov 2026 00:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xWo8N-0007mm-Ff
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 00:04:31 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xWo8L-0008CT-90
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 00:04:31 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwXTn361520
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 05:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RCCRPjJ4KTUzm+/xtxX7AZf7yRS5t2EkYAL+8RTS9Xo=; b=D3lIfdZl15Isb/jH
 9KrZg6CculrO7az4EQITNwP8ZCEOcP2t+YiafzGtV18eInsOZmcLvaSOSGroJKWF
 3tBsoGTFOgQqyoTzov8mibgwKiOxTCV5kaGJFnMgb9dwu04VZnkqJJaRqK2EoTyg
 UXYya0+NEaCKFbWB1F+XxWsdwElfLAfM5bH2k7R64HxChfAtCMeqoDSOkKxyMpqr
 S5WbH0C8uWj1h0WNQFLeHIJiXlZjUtvT6yDsVMl0md2rxhQf2ELNRNW03qyZWuXb
 y48r8xD84EP/Yq0HPQJj4FBSJGe3h/gczsdfYVm5hwMlNuGhTOWorhV7Z3doTOQH
 95JBgw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6f8rm0c5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 05:04:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-38531c1a566so3288658eec.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 21:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795755865; x=1796360665; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RCCRPjJ4KTUzm+/xtxX7AZf7yRS5t2EkYAL+8RTS9Xo=;
 b=IGNa65Pnz6rfIQZR4wLcd/ATrvdEUCqcgWf4iGaq4A7YUo94q6IMaSu3bSzVPdDzW1
 R3LGA9jsCuGsIqK1saZDfGOf1Qe2ljt4u6GxLbNmSMBOr7Tp+6dA6nVHXDf7PyrS2nn/
 9Rfot6zirf8/W5TV2MNKxr/Od2xQ/LdvPTb3r+2Azlh/bVV7c1hZzUr51Z3VpcL4cM7t
 IMC1+zDJQbHpXieGCNeJCtIjS3XPKp4iTXC9pIH77hbKU427lj3BJX9NT0qmYeLdyaiL
 l3Dhk1Vrm4AwUux3kdBVZerMOWw5SQD39MoUPja2k/cGf4Bc0BFpNwBTmiU0d9zqEHxH
 ZOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795755865; x=1796360665;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RCCRPjJ4KTUzm+/xtxX7AZf7yRS5t2EkYAL+8RTS9Xo=;
 b=Z39abd8HXfGNzYAOO/xieBb8juA4VEB2aWYOhQh0RJtIxBsZqRdGuHmm6bZnKtvJAs
 0LWtS85+0v89pHGJTUWdjgX9efe2xzz+SSIgud2MYSG4I06gkVWV5lDKMBE6OED7ys0M
 9EUED7pyGAc3CnceauTaU2MiNnzB9m9qfQY7RWWxAtwCMbjwqvm2glxXN1uZj0j+9dDy
 r1Zp85jSciFEq3rYF4oN/bCgU/ToDK6yeMNE2BqYVuswm8c4ZR5mnG3uNSrBxrE1l1jd
 TY8mAg9jyetZyGpTXkZg0mhr5AcJLXeo1uFEebNJ68s/vFV8qHVqxIkdeO75a3x2ZGHA
 4ezg==
X-Forwarded-Encrypted: i=1;
 AL+hErHblFRmsEB1K+yGHCES1uV2xVGaZ10qSqKXTPoiAl5K6wxYjUusrmhhu8K+VPfJT8mICPryldQr7s0r@nongnu.org
X-Gm-Message-State: APuU4Z9r/CwLVyswqcBhCOId4hODBOaZn0S3I+o8tzMMk2TnietfOvVU
 MWUiLh3oZEcPuPLBuOoiey6v2JJ3/5lTj+6lCBLytJpmb4wxnb1yXUN44tdhB2TFmaz/HvPaaRr
 72jk9tTNvvt78PML9n72dGPs730T1l24gtk6urpQjCogGzrikThHUd0Vovg==
X-Gm-Gg: AZFdTZdrj5s6dH5xm2kRy3k6tFDXIB6CC4+D2t0XazvJ6oOBebjY2ssK3kYDvUlKK3d
 Khm2w3WrDdT+g0gOJk8U/esl0m4ZDAEcSqHvf2iRHVWEWzth8wTuzD0tANBVZ4r1L3y5ziBen8v
 dhmwa30CM/6AfZbHyhp/AuJE9i5+6L5phDxbRGmAgclUVWsjBl7JDSA4GdClVNbu4P2TN3Cpsez
 5hOF256A2GA5bkdZE72H+ofl6LhNhdzZpaet6ujVb7NSAx3jKyx6gwduvCiUattALu2347hhFb3
 nwGFHo9nqeJGJC1lYjHfJ9w9V6DofidRZT89IYrQtoiNg6xqt2xLGKNIaA8CiIPrNs37hVgAsaA
 SqiKiwzo6wlB8lWo8ZD2qHDwpFmJ5RSVnqO53KEXvB836ag6y9/Tbodkkn/ak2jLgM13klPrwbH
 3YFjFgVlhHCjRYER/Oj426rrjMuNQW0MPKzocpqLbE9b76jSLPKkMH
X-Received: by 2002:a05:7300:6018:b0:381:9593:9984 with SMTP id
 5a478bee46e88-3857151d6abmr21020092eec.37.1795755864739; 
 Thu, 26 Nov 2026 21:04:24 -0800 (PST)
X-Received: by 2002:a05:7300:6018:b0:381:9593:9984 with SMTP id
 5a478bee46e88-3857151d6abmr21020069eec.37.1795755864244; 
 Thu, 26 Nov 2026 21:04:24 -0800 (PST)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd40c5sm82786657eec.10.2026.11.26.21.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 21:04:23 -0800 (PST)
Message-ID: <b79a6b52-835f-4aed-9fd1-63ab059d5a7a@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 23:04:22 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 1/5] dump: fix e_ehsize in ELF core headers
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
 <20261125194855.3154845-2-brian.cain@oss.qualcomm.com>
 <e41fb31e-0e0a-436b-8303-b5492f7a717c@gmx.de>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <e41fb31e-0e0a-436b-8303-b5492f7a717c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAxOSBTYWx0ZWRfX/YRFStcswEUl
 yAcCGDju/96t9961+S6NDCz0iNEZiYBjYTmyKCqT8k9bKwI8O9oVmohKwMjn4pKmena44bajY2s
 ID1nXywh60iRQV4yDYOtgS6eSM0/5wlWwJDgsmCbCWYxrFOS+izA42upiNGfr/AiypFBNHXOxI4
 Dx1CM6dO0H2a6/HFpc9YoZLDA0HX1VdqFyU4zHkCLH/T9BeA6g3lyxfwLevYPIBA6TaB7BfDfSY
 i6lYPvzJ1ZkvAM9vy02UDbkXNF/S6o28Pxx+nCC9WORn86/RpvF5UtWZRpE8DJDKjpOXezIPX0M
 sj163eVVe8S9UR0UlVUWagkSwCUgWiOr1WW30s0MFChk/oSQMKpOkZ+Q4fPxOMlQxCpUNe5yj9J
 LBpi8hJiohlBflZlzFjtd10xcUF5lbIkeEgUpGIDxJ7Q3JgmzOv4YqrEhBaIc3b8jEOx62TP/yd
 hl6PuqaGEqZ1HivTU/A==
X-Proofpoint-GUID: 5F3DHtl8zvoCnYIm_2TR-cZmZGVKUTln
X-Proofpoint-ORIG-GUID: 5F3DHtl8zvoCnYIm_2TR-cZmZGVKUTln
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAxOSBTYWx0ZWRfXz+vIRexKUja0
 dhzLuPEmfEIbYZXuFX6uyt1DvJ6VMBuLpuP2jpzfr8A/66HoBtZWeHHkDrKur3atFbAk2zeiuEn
 vrGzNj2f7phfGqqO529ws1q+EzG59D0=
X-Authority-Analysis: v=2.4 cv=FuOQbGrq c=1 sm=1 tr=0 ts=6b090f59 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=8pFHWZ4-hIIVh97s21oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 11/25/2026 2:06 PM, Helge Deller wrote:
> On 11/25/26 20:48, Brian Cain wrote:
>> prepare_elf{32,64}_header() used the wrong size for the elf_header.
>>
>> e_ehsize field reads 8 on a typical host instead of 52/64 for ELF32,64.
>>
>> Use sizeof(*elf_header) instead.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   dump/dump.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> Reviewed-by: Helge Deller <deller@gmx.de>
>
> IMHO this specific patch is actually for-11.2 material....
>
I was reluctant to target 11.2/stable with this patch in case we stumble 
over a defective debugger that expects the baseline behavior.  If it's 
been broken this long (2022, 670e76998a6e), chances are that nothing 
QEMU users depend on care about this field.  So introducing this fix 
with 12.0 would give us time to react to my hypothetical scenario where 
a debugger misbehaves after fixing QEMU.

But I could be convinced either way.

> You may add for the rest of the series:
> Reviewed-by: Helge Deller <deller@gmx.de>
>
>
>> diff --git a/dump/dump.c b/dump/dump.c
>> index 23ac689907a..6b568516960 100644
>> --- a/dump/dump.c
>> +++ b/dump/dump.c
>> @@ -157,7 +157,7 @@ static void prepare_elf64_header(DumpState *s, 
>> Elf64_Ehdr *elf_header)
>>       elf_header->e_type = cpu_to_dump16(s, ET_CORE);
>>       elf_header->e_machine = cpu_to_dump16(s, s->dump_info.d_machine);
>>       elf_header->e_version = cpu_to_dump32(s, EV_CURRENT);
>> -    elf_header->e_ehsize = cpu_to_dump16(s, sizeof(elf_header));
>> +    elf_header->e_ehsize = cpu_to_dump16(s, sizeof(*elf_header));
>>       elf_header->e_phoff = cpu_to_dump64(s, s->phdr_offset);
>>       elf_header->e_phentsize = cpu_to_dump16(s, sizeof(Elf64_Phdr));
>>       elf_header->e_phnum = cpu_to_dump16(s, phnum);
>> @@ -184,7 +184,7 @@ static void prepare_elf32_header(DumpState *s, 
>> Elf32_Ehdr *elf_header)
>>       elf_header->e_type = cpu_to_dump16(s, ET_CORE);
>>       elf_header->e_machine = cpu_to_dump16(s, s->dump_info.d_machine);
>>       elf_header->e_version = cpu_to_dump32(s, EV_CURRENT);
>> -    elf_header->e_ehsize = cpu_to_dump16(s, sizeof(elf_header));
>> +    elf_header->e_ehsize = cpu_to_dump16(s, sizeof(*elf_header));
>>       elf_header->e_phoff = cpu_to_dump32(s, s->phdr_offset);
>>       elf_header->e_phentsize = cpu_to_dump16(s, sizeof(Elf32_Phdr));
>>       elf_header->e_phnum = cpu_to_dump16(s, phnum);
>

