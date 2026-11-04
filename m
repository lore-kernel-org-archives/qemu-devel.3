Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977FD606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MAoMZorx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gozxRTvF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOZ6H-0001cn-Ae; Wed, 04 Nov 2026 06:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOZ6F-0001c4-5n
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:24:15 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOZ6D-0003rJ-Ey
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:24:14 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4B5KWa1082226
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 11:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 16qNYKIP8RUViNdyWuZwni3i1blPecNaljxWIb8q1Jw=; b=MAoMZorxz8ooMlTE
 hvvIYy1nbKDx127y/AZAsgSHpMlWpbxbWxAppVGcehEm0yAC24XCv6TaYaYO6PB0
 Vrecr7tKHWUCOPKo8E4G/INwhyjTlYFs7F98vl4xDYQqct32Rtpz9mUz77FEQSwd
 b40Whtts2+NCfU+l6OR6FFyVmcd4duCyS5OFiPTNQa/9NsoxJus86txUZTIrHhEO
 ORMYVCloM8A2TOWg5SLWAmDpC1C+TLAoQgye009Avrog9l+qG5OqzklHca/13B72
 udcp4am+CBbr927MAVCHad+ygYkxXGFzcd+Vw3wON67XLOYE+obeUXu/RG8s0sCt
 SXi9jQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8y3fqe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:24:11 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-99939c0007cso101794241.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 03:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793791450; x=1794396250; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=16qNYKIP8RUViNdyWuZwni3i1blPecNaljxWIb8q1Jw=;
 b=gozxRTvF/913s2ValQd29rwu6BtU7sxWiKB3ElTdR4+wCIrCmnxid4OaWniyCsaCi7
 6S4tnJiTExO48hcDDvx/+lY3jEpAMT9I29mvgsz4bUWYllvP9iXxuO9L8RVMnvofh1mi
 eHHcdhoxcfOvBdEtUnUwdj24sakhfpxwIRbEptOfhdB9dpBtwebzrzQAVpsSh3imgfyy
 Zs++cEllXvgdhGoXedey9wylmPkLhnW1uNeHPNFS4H7nY/viFpYdsI1KPq++8EIv8KJv
 /qbpt+Aw4E6ZgM9bPbyMISKGgTZj5XFX0m6nTO/ot/TsNG+/K6ZFh7xFwS18wFgbsY0e
 TDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793791450; x=1794396250;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=16qNYKIP8RUViNdyWuZwni3i1blPecNaljxWIb8q1Jw=;
 b=SDQCAtA9RSNRlUbEsc4u3060vtvwLh/FT1Sa5DlIWMMcQCTpcO40HiYVM/WGJU2HsD
 0ibcUxdowBN7y5hhDYN+hoynej97VrBsrSi7uogDAAuW331HJhZDitTiRdOVfUNqvBR5
 3fa7UC1qImlXXgYd297rcPFvLohxeScu3WmUPd17fTDOAzlH7lbAxn/SsYMdFp0hRWGP
 p4CG563FrJRyDJE8d/xuO905LPvYimO/P/MIbT/hQDMhXgVhI4YGMiynSzftIubPd7d6
 6ZepVYF5yfFs07ha5JTQfFa8he3csEG7joF6lrZWxATGAFSukAOVRSguB0Dexa+/fMjv
 4U4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZNVxil12U7AS1Feqhtra+f7Fk5wN4kR0Qvy3nFANQHvhGDR8wFw4kLLBc+t/JVmfrY3yIadZjrDFg@nongnu.org
X-Gm-Message-State: APuU4Z9CmG0698m0SCK93zLlRa94Uqxo1nVmWPvqhF+fq4YZ2iHgbWgP
 y2jYnaL3wfhxgyB0AVrTM8tAVr7Yo2j9cvEfuN4IzHjOjw8VUkdHaBpoeT9DidhHUEmewem2X1Z
 52nNRu4ifB9PKBJgUpIOCGpcOUXxsgfoleNKZPh8iNJdzFgaKtJs8sij02ph5xbIoQw==
X-Gm-Gg: AYBFou1Ef214T2I7c9SRW1ryadFdzbpr1ToVE5lc0eNjCaCu1eNoLlhUg+Xb3SIFePc
 hevHKAkpkEoxwLNKub20w/PwUiONch6vrP2HiZexNp5qOR5VhMsCOnVHzMWW6WK/OmQJ+rnqT8f
 4qS7XGO74layC9fqLhx6XolCXWpkDeeFX7Eqqr5xLaJ+LpgzMjOt4FQqFjqCVCYGvHKMxWmCxRF
 3vS9dCw/OlCStToi3tG0QvtcFwy9U//A3sm87i0ZtiezVp50HQzhNUs2BIzyU2B7cV/64bDyMq7
 ijLC+7WwBgKKzQaoWaf/AquKjScOq+A8EsaltI1Wb9EW9tdi/wq2kFlXSCo8A+Y5Nw3A0aRaf+i
 5MPs12RKSl5zr9DCqruv1Q4hoR42EwovrKl3p1XaZbtOkv0a9SA6pgVxcePd4uTbrTAKePMF5p/
 ODToqgnw==
X-Received: by 2002:a05:6102:41a7:b0:7cc:2712:cafb with SMTP id
 ada2fe7eead31-7d0726a8a89mr5449990137.15.1793791450406; 
 Wed, 04 Nov 2026 03:24:10 -0800 (PST)
X-Received: by 2002:a05:6102:41a7:b0:7cc:2712:cafb with SMTP id
 ada2fe7eead31-7d0726a8a89mr5449988137.15.1793791449859; 
 Wed, 04 Nov 2026 03:24:09 -0800 (PST)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda20935sm3309709f8f.54.2026.11.04.03.24.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 03:24:09 -0800 (PST)
Message-ID: <50dcaa06-1f02-4662-8c4f-9ce2ab5e923a@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 12:24:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 4/4] hw/intc/arm_gicv5: Use correct type for
 value in lpi_cache_get_hppi()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261103172616.2400758-1-peter.maydell@linaro.org>
 <20261103172616.2400758-5-peter.maydell@linaro.org>
 <CAFEAcA8X1ARhpncsz=kE2JxFjALGej4ycw3hus=m5kfcVSJXYw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA8X1ARhpncsz=kE2JxFjALGej4ycw3hus=m5kfcVSJXYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CIHXt5M975jC4RgUDZGMrUkxn3Xtw7EZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA0NSBTYWx0ZWRfXxXJsOagJ4lVK
 UV7lGsq4zRh54b4b0jU9R7J1E2bJ6LsdhAJ0EMwuNb3koF2eRssOpnuQWi0Z7tX7eWXhSSg6VEf
 yxDXPAjecIXEapOYtqzibWmeE+bht6GQEKrkFOKiJvk4e280di84m9gwT6ot+RzxRl9lOnceUXt
 f+UlJWB/AFd4agqKfLTopFycP8tHcdOp7+FsIMiWcfMGAF0pagglpx0afRYLi1H47xmmU3F6P9Q
 8isT3jU803YWNJ/InwLUir2R6bMJdi5r6jDf0dLXikWfNR0udLnUyzCm9JMDDm0J3N/fI3uotPn
 NVg+1LDfcCUXrB8+DYlsSmlTUEl+fpZbpEYIgbMIJaV8Bq+vl/j+yR2uz5z3XeiSB2ARWSEqXgh
 +aGWJ5ViQ7va3rDmZbDqlFRdS7h/p6z8hBMIi2mk+qT6LrMEFgLZnQViIctVUm2CrVcTS3tJ2ZS
 sP7wBm9TSzuGYnFygKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA0NSBTYWx0ZWRfX22MllLRY4gxX
 hqcnjDg/KrWWaCmEz+fIJgtut2cLIeoLvFxKcI0jwaqhSp6BZ5V3mOXgCGktNynKZP/7zSHTZUq
 BVCKibtWp9Dtz+Ro02K76FOUo9CsHn4=
X-Proofpoint-ORIG-GUID: CIHXt5M975jC4RgUDZGMrUkxn3Xtw7EZ
X-Authority-Analysis: v=2.4 cv=NP5AaE6g c=1 sm=1 tr=0 ts=6aeb15db cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=Id7gVtO8_quhM8CtL5oA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_03,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040045
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 3/11/26 18:49, Peter Maydell wrote:
> On Tue, 3 Nov 2026 at 17:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> lpi_cache_get_hppi() is a function we pass to g_hash_table_foreach()
>> to iterate over the LPI cache hashtable.  This hash table has keys
>> which are GINT_TO_POINTER(intid) and values which hold the L2 ISTE
>> value, allocated as "hashvalue = g_new(uint32_t, 1)".
>>
>> The function is passed the key and value as type 'gpointer' and has
>> to cast them to the real types itself, but it incorrectly casts the
>> value pointer to a uint64_t*.  This works on little-endian hosts
>> (since we only read specific fields of the L2 ISTE using bitmasking),
>> but won't work on big-endian, and trips the clang sanitizer.
>>
>> Fix the pointer type.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: a0562ada75e ("hw/intc/arm_gicv5: Calculate HPPI in the IRS")
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   hw/intc/arm_gicv5.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
>> index fd6456cd8aa..a362349e5ed 100644
>> --- a/hw/intc/arm_gicv5.c
>> +++ b/hw/intc/arm_gicv5.c
>> @@ -390,7 +390,7 @@ typedef struct GetHPPIUserData {
>>   static void lpi_cache_get_hppi(gpointer key, gpointer value, gpointer user_data)
>>   {
>>       uint64_t id = GPOINTER_TO_INT(key);
>> -    uint64_t l2_iste = *(uint64_t *)value;
>> +    uint64_t l2_iste = *(uint32_t *)value;
>>       uint32_t prio, iaffid;
>>       GetHPPIUserData *ud = user_data;
> 
> Looking at this again we could also make the local variable
> be uint32_t; but getting the type wrong on that doesn't matter.

Should we use GUINT_TO_POINTER() when inserting in put_l2_iste()
and recover here with GPOINTER_TO_UINT()?

