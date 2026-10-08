Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D8ECA6013
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 23:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEx8W-0001Lx-Kn; Thu, 08 Oct 2026 19:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEx8H-0001Lb-Al
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 19:02:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEx8B-0002xC-Aw
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 19:02:36 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L0De3296621
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 23:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qsr4K17Dxc7VsJ/F/INZb6/6v5O5tavXW9JltmfvPGE=; b=F1Rp8bX3XDJKReXt
 7fX8BRUyCfFgrfo/1nDGCQL8evt7rSoAHDsSwk90Maqg8BBfPoUxJGlFJTXdn9T5
 IZ8D3BzhtfYaCLN3dhASSZDudstit8TcShQhxThsuwO3A4N4FwZcKM6K1uIf8QSg
 jmlKrmGz687qV4CjLk61zvJ1gSyNN+jaJh5qpmYoZXBurCinUqA/JfJrObncRHp0
 eUycYqYj/+jOPLiyOPwjo/Aa+0avD6jpHODgkF3knXXvhsWPpvHgnk02l+No0cjV
 OlAZAkUs7CI5t+LHYp3eU7hLVdjgygy33TLACFoB+vshZrGbs6yyF1r51+ThB7qW
 VQksXg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekv99yr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 23:02:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91961374299so162313236d6.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 16:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791500549; x=1792105349; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qsr4K17Dxc7VsJ/F/INZb6/6v5O5tavXW9JltmfvPGE=;
 b=e0D0mFj4s/CGLCJGRvslCbyuAqK3Bwkme1pqyQ+eTPGjffUFB3KMDTNiXHyy9W9l3O
 DGEKTGTWmDxB9vDP94DWJKsgCjzpVUYdU7UvKk4f9tKnibmdWvyIHqQBfJQfWtqiaCg3
 4AqchfIXMD1KIRjFVsfXi1lUBsbtNt+arII3ZxJHsOH37JqXYEw84kB8URq5WPIRJKMm
 yLvO78zMIHhZyXTUhFq99Jdh1rF0csT9UcgvNl8BaPpoIYc2VcbIHPGCcrTDGmSdmRsQ
 ihO1KySaTZU9jySfZ5Q9p5aCRSIWHoYY6JJNTTngvYlAbhUDb7vzGwSeyoeCWP8UH12k
 6i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791500549; x=1792105349;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qsr4K17Dxc7VsJ/F/INZb6/6v5O5tavXW9JltmfvPGE=;
 b=vB3tS4gkimJ7v73sJo+sgof1TJJpTM+YnRS36fzEQpQ3Ozkf6NF4ayfD5ayGUY0Blk
 sEGvYyBnEsTdV0xa2lOTXcr2gEpaFe7hQeE6mKKI7VDQb6mAwEC6zTtTCNwUdPzOwLIA
 AEt7FC8bB1dsHvpBQHgWfPvr5SS3v3/Xz9XYMt847luREa2/Io8oKQgn7Upx1TS4/sBV
 OPuh5QIOdoNeZbZEA8mmgcZlmSufGHDNda++fk6zvSD7PoqS3QqgdKlsQYBZQbeGV07D
 XOqhe0j8P/sF/t1bcfcS3yeVVxG+a8rZnaH6mYm93kbu42quQTaXJrbcnLV/EkLYOvrh
 tE5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVXLHL/q50xS/+ZuWXDwXfFR9yKxTcc6B4HLWTAIpLU21utFR4CNqyRmhXJktFbg4CEUBFbxlZkmvg@nongnu.org
X-Gm-Message-State: AFuF++myp/P0UCMC3cZEHtblOMyD9eJu1EtgE+92eDSnL44Ib8/THf1y
 zBdJL0MIqJwDfVFpNEpRHzSb4rq6Iq5oJ7u6n06zcYl3NvPQAwNbDV9zviwb9qS57mF+SD/Bqtp
 U3NTuAraLMtjPFhCrwBdLTV2dV4xmJa6fzt2YKssiMZanbCvL0mZD0NZgIw==
X-Gm-Gg: AYBFou1CR6DWbWTyG10mTMokTfRwBCJG8oVVeYiNDv2JpbuQTbD+MQEwjN/L/RZKwkZ
 zUJ4cgqGDGZ4btARcSZ46dfJxKybqw4lUAiOVHtQSfShQwd80asCXbqn8y5wphDJ+PZLHa+TSw8
 W0Fqs0FHhCROrOzR0e9E7/rDPgySlGwxOzU6as/WA9XOCGkRPykmtcGvEGTF4jJvtfoOVp+vnT3
 YM2vnbKsGhYSNxbHoaGw8PS/CzL1w76BRpGPXZhUBixUNGG2UzEZOWYZ8bsQqCb1pvjs8P4llLV
 +MPlNKbBkaW1NMSEuWhqcYSLAQCM5MaRuDnVe3MTvySrFad5NINg3rQKVsTQqdB+d3rkYEwVduH
 hN9POy0XYl+dBbZKsE2p92d+4uNbYPSMblA==
X-Received: by 2002:a05:620a:471f:b0:93e:62a3:f845 with SMTP id
 af79cd13be357-93ebd0a24f7mr23707885a.8.1791500548793; 
 Thu, 08 Oct 2026 16:02:28 -0700 (PDT)
X-Received: by 2002:a05:620a:471f:b0:93e:62a3:f845 with SMTP id
 af79cd13be357-93ebd0a24f7mr23693185a.8.1791500547393; 
 Thu, 08 Oct 2026 16:02:27 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bc6a48fsm16087775e9.1.2026.10.08.16.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 16:02:25 -0700 (PDT)
Message-ID: <b6fdd824-499c-4a4f-aaaa-04881381703b@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 01:02:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] target/hexagon: pass the packet PC to lock
 implementations
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com
References: <20261008211005.1853542-1-brian.cain@oss.qualcomm.com>
 <20261008211005.1853542-2-brian.cain@oss.qualcomm.com>
 <471263fb-bb06-47f6-83a9-764e603a7a68@oss.qualcomm.com>
 <6992a79a-96d8-4b73-8552-cae7d8102b17@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <6992a79a-96d8-4b73-8552-cae7d8102b17@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9ZH3NuhcS53AlKUwJe-17yGNMDVVLlX_
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac82105 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=_Zk0ComgZMIHcIhqqigA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA5MSBTYWx0ZWRfX1DrDewNwLN0/
 MDT3i9hY+wnRVnMBMG91ret/TgttOQJDfrz/ulS0EesRP7skLj8hzhnV03NEuyFKfe95+emQSKB
 hob1F3NYGu6SFMb4aipqtKCDe9qsdyVTPxOUPGu1BMvE+fHhxcFUQAhtk5XksPSoxQlzs9QipF3
 9wM6vxyPGM+mm0Xia8NyEu7oM7aiRTMP/w6fRRbBrpoDR6BPGj7L/+RwBd6Y+FCuObhlbtkDtHu
 h7s6doddn2+jcpmIwofT4vBC6gvEeNhG+SlNt/OmrFSWkxaYIH06LVoAqwKclx+Ep0mxoymOCOA
 6Gsz1UNkg4sRLqmfRY4tTsLRLqsDdbt8G4VQpWgFXhyp4aekS8Xj6vOgv5MS/hjzFa9T6yZDIFz
 gUPtxm1CBPHSHgXqT96lInPCXbjmcMDV+K7AGlSI4BKooLgIL5So6pSOOHi9FLosXmRxlbLxGK5
 KHEdnyQf2y0sxkv/zXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA5MSBTYWx0ZWRfX2LFxwjpGLqp5
 HSqMmMNIRbULx1FvmBO5zN9xAPdF6ontIoeBTycIKV+xemhDv2a5CT6twKwPVbttl70hoFblDlc
 XAmfi3jw+m7OmjKIWrWtrg3CEmuFw2k=
X-Proofpoint-GUID: 9ZH3NuhcS53AlKUwJe-17yGNMDVVLlX_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080091
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/10/26 00:53, Pierrick Bouvier wrote:
> On 10/8/2026 3:26 PM, Philippe Mathieu-Daudé wrote:
>> Hi Brian,
>>
>> On 8/10/26 23:10, Brian Cain wrote:
>>> Hand the k0lock/tlblock lock implementation functions the packet PC as a
>>> constant instead of relying on next_PC's opcode-dependent staging.
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>    target/hexagon/hex_mmu.h    |  2 +-
>>>    target/hexagon/sys_macros.h |  4 ++--
>>>    target/hexagon/hex_mmu.c    | 16 +++++++++-------
>>>    target/hexagon/op_helper.c  | 16 +++++++++-------
>>>    4 files changed, 21 insertions(+), 17 deletions(-)
>>>
>>
>>> -extern void hex_tlb_lock(CPUHexagonState *env);
>>> +extern void hex_tlb_lock(CPUHexagonState *env, target_ulong PC);
>>
>>> -void hex_tlb_lock(CPUHexagonState *env)
>>> +void hex_tlb_lock(CPUHexagonState *env, target_ulong PC)
>>
>>> -static void hex_k0_lock(CPUHexagonState *env)
>>> +static void hex_k0_lock(CPUHexagonState *env, target_ulong PC)
>>
>> Please do not re-introduce more target_ulong uses.
>>
>> @next_PC was converted from target_ulong to uint32_t in commit
>> 613653e500c ("Hexagon Remove next_PC from runtime state").
> 
> That's ideally "cleaner", but in practice, since hexagon currently has a
> single variant (32 bit only), it's not a problem.
> 
> In general, for targets having a single variant (only 32 or 64 bit), I'm
> not sure we gain anything from chasing down usage of target_*long.

I prefer to share my thoughs because some maintainers realize
"oh indeed this sed change will take me 37 seconds, let's do it now
so Phil will stop bugging me about it" and directly reply "Since this
series is fully reviewed I addressed that nit locally before posting
the pull request, all good thanks!". Anyway nevermind I'll redo the
audit in few months and clean that myself then.

