Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19022606A338
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q5BPEjZk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LH4P4pyR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPLoP-0003qd-Gq; Fri, 06 Nov 2026 10:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xPLoN-0003qU-LY
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:25:03 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xPLoL-0006SY-KR
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:25:03 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6F00hZ1039362
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 15:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OXmkqAgl5QAJOZdPbw6sPBv8wMOmWtNtpiEHnuVNaGU=; b=Q5BPEjZk5dcs/w/t
 pxl5R7uSYaRjHBg7rGzVtGf6rIb7cBazv6m4sgFXj7ett//1qCGZGH51v54cJuc2
 I6vpOLpXxe8Rp7aDh0f5evuHXBrLThwiClZmUnNGQu7bDH0yKeQqsgXty/W9EO0Z
 GgwpxWM9lWPtukrt+bZEQVGW+MSmlgyRVxEBhPgC252CRKIxW4FbQr3CuFrmNJ+N
 +UM3S/bSD/6Eg0bP7RvhviA6zzFEark4YSBaWsK1aNW8Z8R/HThErwSj6PFcva9v
 DHfpT4FZKo8ava7bP/1L/sYB1+gv/Nu54C6wgOeUu9L5S2qYJVrAzWMKitI15HM/
 ChMpiw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9ude1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 15:24:58 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91e98bada22so15553956d6.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 07:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793978698; x=1794583498; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OXmkqAgl5QAJOZdPbw6sPBv8wMOmWtNtpiEHnuVNaGU=;
 b=LH4P4pyRiW5zToijli9n7haTVwGp/YMOvs3QFXecby5WXTiyl0vjFuR8Z+f/3iKQzU
 Sk+7E+3X8baHSg8VrZwK8OizmrqEQ794HB1o/RaBYldwctWp268yYSYU30m4zvRdi2e5
 RWtv0r8BKXJmeItM0F+ke+GhRlGRZExWh6djCw74ah4XNpkCRt7pniXt9UjmrA8iQcZ1
 Otwys3Asd+TUGaj9NWgBRWOhk7jusEgZW13IFpfY4+uabbgCT6568TT4m9GiZf8xl8m/
 hVne0+/gZqZ3uULUqDmAqZQMwLzA0scv8OfoJo513Kx6FqAPQu50ItacbmnGuWgHAncj
 a/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793978698; x=1794583498;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OXmkqAgl5QAJOZdPbw6sPBv8wMOmWtNtpiEHnuVNaGU=;
 b=mzvPyWl9ErE/Sk8DgAJZ6dsGBSvyL1/EHEY/gISS/EG1uR3TzINTMHYdWULL4+FD1h
 AYSBINUv2c3+wVTFl2FXRilJJMAcPdfjdthey7fuKZAOQSonVUyBuGe+aGgXRim7AUOD
 D20xXx3QyJMY17GmUtw5hlLutvi67U1omkjk02/HvGNcW40knHAdnA0FbyBiPzQT/T9m
 9qcRrfuGABmQTjBqKmWXm/FLFDxAJ+NdIs2pG+bR019NkzFxZCZT2z2KrjUYti5AGkTN
 PQnBC+zxCdN56N/a7/2VJy1B4s9TQSFeBC6jju539Jx0kKnNiKf600FUpsh4nG/RE+m4
 NAbw==
X-Gm-Message-State: APuU4Z+mDbEV6U1YFcfY6pe0Lk9uwC7FcUVFQZMkBfEN7dyboJ+cCE2K
 IYCFhykpbI3VQG9PX8NYhLk8M1pYeCRb/VLirpQYu0q7ta71XotmouI59fuuV4rDoVXoItxBrgN
 uPNcZTpXAUMUQjp/uici3k3WpmwnC3z1xlAkdu6XJWFQHJCXFv4h15Q00wA==
X-Gm-Gg: AYBFou0FoLxUNFP9Jc5BhbEarwp52hmYMH8+kNils6orV/T7YdNYLJ3nbyEaUAIAOez
 UjKBwc7bTB1uN/Lhin7ySWM8yRCkTd+C0iNXbBGVyPzdShdiElk3HB2jEeCqngdATQVqZAChWX+
 DbFwhc1Nt1fqv3xupC56ixZojJrqZFiUF4TUBxP62Fl06TRhOuHPWaoMn7XcQiLy2zkZBwhMILn
 0/UpG8oJpgu9B+A5KsMKO6n6edmM6ZNWUCs1wkzA/B7wjEWeJbQ7s8QP6rhESyvVfCaSd3pDSCg
 zZviB18PDd3Tg7KG49hxuhkdmDZVxdV1hbjOdh7WC0Wofx3wtIk+zwUf6BoY/cCeBrxx6fmJz2a
 p5AoCfNvpqJsbCxsSTjYBP+RWfDrsCVt7xLiwta3zXnmFQfMXr18qpfrBRnq2XhGj8GgrqvBKjr
 iVMRSoUyCURPE6UYGQ8pJbu08OO62Sl3Y6Gtfc
X-Received: by 2002:a05:6214:5b88:b0:91e:899b:d21 with SMTP id
 6a1803df08f44-91ea95a783dmr42640126d6.9.1793978697470; 
 Fri, 06 Nov 2026 07:24:57 -0800 (PST)
X-Received: by 2002:a05:6214:5b88:b0:91e:899b:d21 with SMTP id
 6a1803df08f44-91ea95a783dmr42639476d6.9.1793978696702; 
 Fri, 06 Nov 2026 07:24:56 -0800 (PST)
Received: from [10.222.169.242] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ea6a2c11bsm22449866d6.8.2026.11.06.07.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 07:24:55 -0800 (PST)
Message-ID: <8f65cd89-2ced-47ae-81d7-c1338531b6e8@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 09:24:54 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] target/hexagon: HLX, search for .new values in
 pair high register
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, ale@rev.ng
References: <20261105114633.597-1-anjo@rev.ng>
 <20261105114633.597-3-anjo@rev.ng>
 <CAJ+KCYOjkoNu4aKf+py8GsdAB3aib7uB4kWXRV_L+CN+e=YZUw@mail.gmail.com>
 <106c2295-daa4-42bb-a58b-e9cf8680702d@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <106c2295-daa4-42bb-a58b-e9cf8680702d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MSBTYWx0ZWRfX6IvPFClURk1O
 HastiGVNj5L33X+Uo6EIe2Wvyw98TIzld6Q/3z7ZpxoIu30llduOgZ/sES8V3a1JUWtI7GRI4w9
 nLflvqtOLvEZ5cIHB/HqqwrxbEliS9Q=
X-Proofpoint-GUID: PV7yx8BaathigcISkqD07Z4JakLQmlYi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MSBTYWx0ZWRfX1MjoJXG7p/kd
 9PkVwHV0NKDru7CWn00R8vcIiUiFCkw8+ap3G9TZ56uNLaMSMGgV+D0SHcZGrvjgB6hRp/Y5iWq
 h8Y/96CQFeL7s+8+aOEmNrYgg3Tc4MBVfVtgb4onMS5BCnEK7pf2YHsY0KdRGIo5ewxGztfdAue
 1pCkCgwHJyljBACYx+nWD98JOayGXBCf81UDnCWZzZO6fJHsWZcwS/9qSLYp41Pel5TDAVKRYSA
 4tsRR7+VMRNWTFgzCBH8dYPPKsWR/FcPwjMG1Yr3ejzoBaZ+pb9v1kZkazO3+ZdsHbxIDALMpyg
 571hgTJlRHt4YMtqd5KD5RnggrZTx8CuhwPlY33Ra9wLeoSJotxwZaX+wi9/QYkV9UN+7ddHTQk
 5Djq/mioguq+QM1RIvF3PjULSiokS0ECoXWxtLbtocG/w0JSotnAanb+gYY18rHagmlWy2RFz8G
 nT3Nmr8gGEXpYDtXKxA==
X-Proofpoint-ORIG-GUID: PV7yx8BaathigcISkqD07Z4JakLQmlYi
X-Authority-Analysis: v=2.4 cv=ZIZCCn7b c=1 sm=1 tr=0 ts=6aedf14a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=6jeX4P8iS6UKqCbOCGMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060061
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/5/2026 5:12 PM, Brian Cain wrote:
>
> On 11/5/2026 11:58 AM, Marco Liebel wrote:
>> On Thu, Nov 5, 2026 at 5:41 AM Anton Johansson <anjo@rev.ng> wrote:
>>> Otherwise, the following packet
>>>
>>>    {
>>>        L7:6 = combine(L0, L1)
>>>        memw(R7) = L7.new
>>>    }
>>>
>>> results in memw(R7) being zero-intialized, compared to L6.new which
>>> would correctly write the lower bytes of the pair.
>> The packet in the test is combine(L0, L2), and the store is
>> mem(R7) = L7.new.
>>
>> Also s/intialized/initialized/.
>>
>> [...]
>>
>>> +        if (regno == lreg ||
>>> +            (GET_ATTRIB(insn->opcode, A_HLX_PAIRED_ALU) && regno + 
>>> 1 == lreg)) {
>>>               return i;
>>>           }
>> This finds the producer now, but decode_fill_newvalue_regno() then
>> overwrites the consumer's register with the producer's dest register:
>>
>> `packet->insn[i].regno[use_regidx] = 
>> packet->insn[def_idx].regno[dst_idx];`
>>
>> For a pair, that is the base register, so L7.new becomes L6.new and
>> the store writes the low half of the pair instead of the high half.
>>
>> Also, not all instructions that write a pair have A_HLX_PAIRED_ALU,
>> e.g. LX_assign_rw (Ldd16.w=Rt32.w). A high .new store from those
>> still writes zeros.
>>
>> [...]
>>
>>> +    hlx_put_v(0, l_lo);
>>> +    hlx_put_v(2, l_hi);
>> [...]
>>
>>> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
>>> +        expected[j] = VAL_A;
>>> +    }
>>> +    check_h("LX_assign_w (hi only)", buf_a, expected, HLX_HALF_ELEMS);
>>> +}
>> L0 holds the low halves of VAL_W (0x5678), and combine(L0, L2) puts
>> L0 into L7. So L7.new must store 0x5678, but the test expects VAL_A
>> (0x1234), which is the L6 value.
>>
>> The test passes because L6.new is used instead of L7.new.
>>
>> IMHO: Maybe we should have a mechanism that creates an error
>> if a .new value is used, but that .new value isn't even in the 
>> packet. Like it
>
> This sounds like it's either well-defined behavior that raises an 
> invalid packet exception or implicitly/explicitly undefined behavior 
> for which we can log a guest error.  If this condition represents a 
> problem with the decoder it can just be an assertion, but it sounds 
> like that's not the case.
>
It was a little unclear to me whether ".new value is used ... isn't even 
in the packet" represented an encoding problem or a design 
error/decoding problem in QEMU.  Marco and I talked in person and it's 
clear to me now that it's the latter.

"maybe poisoning it somehow" - yes, if there's an easy way for us to 
make such an assertion we should definitely do that.  That sounds like 
it may be worth a look (by someone, at some time - agreed not 
necessarily in scope for this patch review).


> For HVX many ill-formed packets are considered to be undefined and do 
> not raise exceptions.  HLX may be similar, we'll have to check.
>
>> is happening here. L6.new is computed, but it isn't even used in the 
>> packet.
>> Maybe poisoning it somehow. But that's just me thinking out loud, 
>> doesn't
>> need to go into this patch series.

