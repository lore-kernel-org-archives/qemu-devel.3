Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B9B606A32D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f9kQR8b9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DJ+C3+Eg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPN5T-0000ic-Op; Fri, 06 Nov 2026 11:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xPN55-0000eJ-ES
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:46:26 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xPN52-0007W4-1T
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:46:22 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6F005g044181
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 16:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j9xrAfBnrV873R0IOSb2QEX2y10W7aK2uL28ewY79DQ=; b=f9kQR8b9VZ/0FkoS
 H4SJ2Mc265i70ypIT8LoTElPYREPOUQWNQ9vSfeHBltft4T9XdKjXXvYlOKnX5nz
 s7A3nZ/G6wUBJVgGkeNrcyooqm2+YbxqEJ4/s3uv8neGCZuqCAOMdQ8SAbp6pexG
 quBv4cqOFt8jFa/JeGDKS6aXdFzZfwGv3yY1bkSKlFzDkpxUV1k99kqTRO4+W8ms
 VF5/5FB1g3i1maLIeoh2FGgss6Wkgt7odZssNJRKVrHRNxdyPYafd8gB3cvcs9u+
 qrLCFSXwFqrCPQ5VRxZ62MTWWLCwPr8Pq5YdnWB0BFV0TFY5pNiHvYcIc1/Qw4Vc
 WblX7Q==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa3nfr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 16:46:14 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7cc3a482af7so707280137.3
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 08:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793983573; x=1794588373; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j9xrAfBnrV873R0IOSb2QEX2y10W7aK2uL28ewY79DQ=;
 b=DJ+C3+EgJuGYWnz70S10BMTgMuq4mVdbcLn8l7VytUdWl2kQuhWIW88LH95EwnPIa3
 oPobFfrqBE7h7i1xM0i1SMDWD6SdNxxo9K9tfbSICiGPG6CM77jOQWCBFOA5RmG2Y19t
 FTYRThF5YINTP4k6lx99ZivrKqjKotsrzq1i6iCUA+z8oaXGIA7mfpz7QlMyBBa83vmJ
 mNB2rsVdMv5fDUsa3Pzm60DmJxyK7xUPgH6R6DMCiB0BaYBvvkG+1ytGe/+483dcXGcj
 akzNX2V4Kn81JigjweLHs30IUEWEvrjAYvoKD4SgYWcwjuyb6rV4LXThR76dQjSJtODy
 Jt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793983573; x=1794588373;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j9xrAfBnrV873R0IOSb2QEX2y10W7aK2uL28ewY79DQ=;
 b=QgL1ShTQjEPlvoKbWbV59Ya8P+FoapFbdTcxJNPA3FHb6kIwpXMcIYTID1rcQqj6JC
 8bjVMOzKzGYErA+M5ZW+0Rw2UDE29Pb5Al7tCz4mqUTU0b02m3rXZQGx2M0YmbVqUh0g
 FleW4Btd7Dxaqaews2gGVJpj8BJpQoanLqOQimuec1p2/Q29H9u8lNTL3G/xTKFTmEu4
 hoQZhwaCIRNVq/g7GnFRcl/SkF7GWkM5SqJTIIMu3kLxiorkbW7Rdo+Sdua8HyHWrW2K
 6l7eeg6Tikm1suVL9+Sf94c33B+y4192eWgtLSQkF1sX9a2QwHdrdF/S5MqN63PxhHI7
 WFzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9SR2kt4Bb5LIC6XTMStrioL4sGzvRShf0VC7zqxPa3JyLOLB8MtEdc+WIe5Z9vICkfNvSyQCVNj2Y@nongnu.org
X-Gm-Message-State: APuU4Z8doPohbyQ5CpXzxj+MBNZcRGutuL0VPJ0/XaD0fPiGub4X5cTi
 fI4ps4rPnO38wEkiap0AmZyxhgMuTX9/puroTVzu/HCi1EXwahBHb2U3wAm88G7/ftGRaWNoXQj
 n4Ue7oHcIDQpJEYSk4H5k82M1Si12Ug7LqPYXWS/Wqm+oI1ZGe7pe+Vb/JQ==
X-Gm-Gg: AYBFou2fUaPI5WVXiFa4ghbxqZNT3DbBPZXK2uuLRtSMfWmn7MTJp1l4mJi0OD6jLl1
 u8+iQhNQ7bR4HUh0pkPPYUAXuW5R6WLYVpKGzkk2qXE3Q+XmQ1Dt7iamZW9odfGmsxV4vcuk57l
 MnIAeSg0KDO8b/rk1IJ6FXmR3xqU4579psJeSKwDO6EoJ2KDSHFu5V7QzS6IbKifUY6DQjqCeN6
 M4v70tw+jh3kFxo38IKRduDh/UO4LB5hCXFj3fyIawfXYRDWs/Cm5TerUT6er0Mqxb3k3vF5m2t
 MWa1WBZ8QMHnZwdVEkB9AVdEBU9A36WUYlvvACGzq1PDiJRYqqzM7jtDJ9V2MbOVVJ+AO1U+atU
 sgfAyEevjB4miB/AftBWmrTFCvncTGbDjg44LmOHzsKgCp3A6BEooOqVAzqTRVUGe7csDt6Up6+
 kF4Y9EyFZME2plmpgmOGNpUyonVxagoB5X4Y47
X-Received: by 2002:a05:6102:6052:b0:7cc:2086:34c9 with SMTP id
 ada2fe7eead31-7d2a12f0b9emr1579893137.2.1793983572875; 
 Fri, 06 Nov 2026 08:46:12 -0800 (PST)
X-Received: by 2002:a05:6102:6052:b0:7cc:2086:34c9 with SMTP id
 ada2fe7eead31-7d2a12f0b9emr1579881137.2.1793983572375; 
 Fri, 06 Nov 2026 08:46:12 -0800 (PST)
Received: from [10.222.169.242] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99ba74a6964sm2232944241.0.2026.11.06.08.46.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 08:46:11 -0800 (PST)
Message-ID: <ab193f9f-50aa-4d9f-ac7f-4ddf50796904@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 10:46:09 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/hex-l2vic: avoid shift into sign bit
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261023084624.1063258-1-peter.maydell@linaro.org>
 <CAFEAcA-m9cLAOe8GhjKY35V2SX=pQCofJU9zwTydG77S=jCCVg@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAFEAcA-m9cLAOe8GhjKY35V2SX=pQCofJU9zwTydG77S=jCCVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aee0456 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EHGq2a_CH0hLNcorzC0A:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfX6VhPcMowo4qT
 2lqUHUzFwCrSwHw/fL430YLbZvtJP82CGadwS4VzFLo/zw+D0xpgfGgrh6ySTtBGz55z/N2jag2
 tWmK7jkdfcDls5ve3vqwe6aSpK24rOQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfXzMa4AVWjWpnT
 FAoSPV/mgm61n3Xj8EhVjLFqb5WIRbm7Fc+7JqtD4j36fC+FtcsALlLifsQsLbmtBK+ikc4gfjQ
 njH0IgoQpKAY0xL+O0un0dxhKT6qh336SC36UkoSECbmUHRfmqyWfZbxoJKJ+qf+NuDqmRAF07C
 XnCK1GU2bHKlVCxX9zMEvZ1DjAjRhGkzxDBkIU3DrcHBDhMGs+dVqX9Hkf+Gx5ibLPTjwiwPHnR
 EAAQ6whSAzXl/CERBbo+5gf7taHlcBeDpzivLqMxAT2Fb00ug6a+3xHQupRDI6g5GUn0X+78w6q
 U1195BrquDJYZtBkvbyLAfx+WeNWb69QZvDr5b1k8cW1RqaodFsZNLP80tIBW3YkvwSzE2zmM+0
 mZ8Vyv3IQQBMLz56gPgoecMkLL7r3WNUdbHRLhBjM7RkGcFV3yX/bOi/QRlEdCIt1bnkm6ep/OK
 RMLXy7CeAKH097y3mbg==
X-Proofpoint-GUID: 6HjVJdZtcvxs2jY3sFFXBkwAesDLIBKf
X-Proofpoint-ORIG-GUID: 6HjVJdZtcvxs2jY3sFFXBkwAesDLIBKf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060066
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


On 11/6/2026 10:12 AM, Peter Maydell wrote:
> This has been reviewed, is a hexagon maintainer going to pick it up?
> (I can throw it into my next target-arm pullreq if you prefer.)

Apologies - sorry for omitting it from the recent PR, Peter. Feel free 
to take it into your pullreq if you like.


> thanks
> -- PMM
>
>
> On Fri, 23 Oct 2026 at 09:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>> In fastl2vic_write() we do:
>>     val = 1 << (irq % 32);
>>
>> Because '1' is a signed integer, this can shift into the sign
>> bit of 'int'; the cast to uint64_t to assign to 'val' then
>> results in all the high bits being set. This happens to cause
>> no visible problems because l2vic_write never looks at those
>> bits, but it's obviously not intended. Use 1ULL so that we
>> do the shift as 64 bits unsigned.
>>
>> Resolves: Coverity CID 1685261
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   hw/intc/hex-l2vic.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/hex-l2vic.c b/hw/intc/hex-l2vic.c
>> index 736f1be3b1d..89b44200928 100644
>> --- a/hw/intc/hex-l2vic.c
>> +++ b/hw/intc/hex-l2vic.c
>> @@ -381,7 +381,7 @@ static void fastl2vic_write(void *opaque, hwaddr offset, uint64_t val,
>>           uint32_t cmd = (val >> 16) & 0x3;
>>           uint32_t irq = val & 0x3ff;
>>           uint32_t slice = (irq / 32) * 4;
>> -        val = 1 << (irq % 32);
>> +        val = 1ULL << (irq % 32);
>>
>>           if (cmd == FASTL2VIC_ENABLE) {
>>               l2vic_write(opaque, L2VIC_INT_ENABLE_SETn + slice, val, size);

