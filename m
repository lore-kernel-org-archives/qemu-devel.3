Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E050C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmYSe-00081M-Mx; Wed, 22 Jul 2026 11:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmYSd-000811-8O
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 11:02:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmYSa-0007nG-RS
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 11:02:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MDWXu9973951
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 15:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IMRGXBdNlmkMoOzVu4opBhQicmTHwC/vB7TTxGvk1SM=; b=GsUa88I9R8Ym2N85
 Di7DxeF9vwnOPhT14fpG9zQbelXXeoCc7N6oCTni0it1uf8pKEMCVJCLPMoEuzHi
 6lWAKYwc0I+M/mFcFLv7bLGp6J4/FUPlmJNvD6/w9+I0v//tG5zaIfds6F7lPrK6
 lRoDW8SQItD8WdvH+1MvknMCenkH7e0z7k1QwsNWpnplFnLpLRlqIg9E+EAzWYvg
 2MLg7P7/AIR0odJc6bKRNYCcSRAZVtn2jcl8ZDzvmqwh3m4XyPGk81Owp6/rF1Am
 UIu1C/AXb1ssy0k3V9gbAY3zmyZJLtPJ9SbRe0ithvAt0czNJ9K4POLFCtWDwxCk
 bWF0Lw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjuu794tf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 15:02:06 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-96966afe3d1so11490683241.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784732525; x=1785337325; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IMRGXBdNlmkMoOzVu4opBhQicmTHwC/vB7TTxGvk1SM=;
 b=GWBNClYC4oJcJeVIoRGwe1wO34nXCFTK+EGSyKggVQ5YuLnRCrrOaMg2lzKuZQFNP1
 3saTVw1jx6IFbr9u2uKmqm1/mcT7UMcFxcAsiRDB9caBPq2i5/pnGlj9/RwuDj/7Opmd
 aNLd9cz06i7Qm027C3c9oeSPYD2S2BrIJcofSpFRSlZO1wE1TNw1CpDsA7U04iw6O+2H
 wjIqz5iykAGLFrRAW9oRSBsgXeTRjRKdKhLO6anuexM7HGG4lBNu9stG1GEghmfGe47P
 nT/AKNJEjKQOUKn9KJnhXAJUv9NldTDiJf9WALQ8tFkkby+1mNI2ECRrkexXu4EH1jZ2
 lpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784732525; x=1785337325;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IMRGXBdNlmkMoOzVu4opBhQicmTHwC/vB7TTxGvk1SM=;
 b=M77CbocIZBu3vlPQri/t0TCUg1IEQjWtibXSjpKsQiPCe68Fv1CiWwpYl4spLH+rRN
 5267ncUJkNIDfrVdLFjaf3DFpyf5gGAgoTNs/68e/lFHg8Af7nZIvxZjfF6+s//xdFqA
 iSNsoHGiacfGnQkutADGd1N4ZOKWJ3D/rMWBGMs4lzrVzHcyBRrrcENr7sSzDVX6RNeN
 HYmKb/wjyvIsRs2RuZ4K/f9nzeLsKgMW0f9dN3LL/1rfD1xZFgABi5R3+ESxrLAgxTtC
 1EJOZoFv7gZ1DR1yRRG/ZPJnt0NDTeo1BApxaO3L+Ty8PVpRIIq327WkGAmdh3CV3Bn4
 4z2Q==
X-Gm-Message-State: AOJu0Yw3OG6d2DXy81tIfYYvq7QybnDZMvbJFQsbu/i5lAmoy+2rmRW9
 V9eIu9yP9kU4Z5bZOoTwhMzI72Je903UbL5oBpQqKghcoOUR6OxinOJmL9w5Lvd3qhVmxMqDIqs
 G/xUpqh1wQ3r+p3TakNnj9aM2/so83WDyGlFktS+LAJOmHPUsbUwjjVgPfw==
X-Gm-Gg: AR+sD104D6nb0MdBPjVfjd96DQw9Od3R7d6uU1MKzuV3su0Gf+74UWKb8tdCRnjypza
 5nCxb+jcyUUwlCT21s2pSn2qvjRJ4p0WCrysrV/W6889yfAfln49ZIJGSlJsDhYszLBVvqn04vG
 mykUkInf4KlZbgkl8W7+KcRgINcFCsIiGg8CRU9vt87biiTqmBtcPrOjnwKprN1UbOyRowHiZ25
 rxmNPN+hDSKY/YqPpVjcZUHQF9/EWUCtFdS9yCV85Z0rafKaaqC/OPSIvFC/z3zs9mtGIjh6W67
 U6nGVDL8+csmtmHttlaW6xbX/YS1Dt/f6140ia9G3tsScCNu8Sb9C5W7n6o14vLP7ZpjTSlAuK9
 REA52HHf4YIWK6UhFvS9Nn1uDk05KPDvaJ9Qy2lv0o9BBLBpaK8U=
X-Received: by 2002:a05:6102:f0f:b0:744:a3fd:410a with SMTP id
 ada2fe7eead31-747536c6edcmr9106298137.14.1784732525012; 
 Wed, 22 Jul 2026 08:02:05 -0700 (PDT)
X-Received: by 2002:a05:6102:f0f:b0:744:a3fd:410a with SMTP id
 ada2fe7eead31-747536c6edcmr9106232137.14.1784732524140; 
 Wed, 22 Jul 2026 08:02:04 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm7339851f8f.7.2026.07.22.08.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 08:02:03 -0700 (PDT)
Message-ID: <9e4b4c2f-1fc8-4e23-9462-56476e5974fe@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 17:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/microblaze/translate: fix reversed load/store
 translation
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>
References: <20260710072348.3575-1-luc.michel@amd.com>
 <7358d920-d631-43b0-8285-c162bd67df78@oss.qualcomm.com>
 <amDO4OyZk2rcRC9G@XFR-LUMICHEL-L2.amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <amDO4OyZk2rcRC9G@XFR-LUMICHEL-L2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0yfNW0SksvY7Bi_W9OsBU37uEj4Orz89
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE0OCBTYWx0ZWRfX5PM1F/srUSZj
 1Q/LZYjVlsuexCdQHbUcTWVkgTi4NOtplXOEZLm8EDGYbvVKDi7WGbrZoRFdjiQRduM1eg2gKss
 wZmnePOY3ySpO5pv3HILq+CUB38OBFas4wwiaFbh4IUM5bLT+O9BaudX1G9v0WLFDR7+rxEwXdU
 x25lhFBCOd6oGHb9lVzJfAjrIcV+s88HhNOJsoj/oXT38AusHSnu7G78VYNTzgP8A2e9qHwNYia
 7lwAj/shUZX+wBPFjASqM71wVVDD+BcibBp4jHrnzYU25pi8HhOQ2oBWojc7jmfFeRmVMZQK8Xw
 Wy8K8QlMcEPBuUjMVLCU1FVcB7kaoYgvty1NfnjdsVMcf3Xsil4IvntCrdVosIX+atoBRi3hhHe
 PF+6bOZKhDZkHCCg6ucPBrNoKktU1g==
X-Proofpoint-GUID: 0yfNW0SksvY7Bi_W9OsBU37uEj4Orz89
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE0OCBTYWx0ZWRfX9Pr7LHp77pDG
 7+mv47/MOHsBrs1ewHoTiLqG/kwPFmw+JMMDuAQ03ZGr6D/BX6/mpfFdPGqf8RzIU5ysZxFKMF/
 Ig2QAg5M5XB/Nl6EgJh0LtbNFKBdNgs=
X-Authority-Analysis: v=2.4 cv=JuTBas4C c=1 sm=1 tr=0 ts=6a60db6e cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=zd2uoN0lAAAA:8 a=o_38YVK4kF3bTkjkrsQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2607220148
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

On 22/7/26 16:08, Luc Michel wrote:
> On 14:02 Wed 22 Jul     , Philippe Mathieu-Daudé wrote:
>> Hi Luc,
>>
>> On 10/7/26 09:23, Luc Michel wrote:
>>> Since 36a9529e60e0 the TCGv returned by compute_ldst_addr_type{a,b} for
>>> the address can be a target register or a constant. However
>>> do_{load,store} might modify it in the case of a reversed load/store.
>>
>> Register are modifiable, aren't they? IIUC compute_ldst_addr_typeb()
>> is not used by the reversed opcodes and the only issue is the 0 constant
>> in compute_ldst_addr_typea(). Is that analysis correct?
> 
> Hi Phil,
> 
> The address registers are never modified by a load/store instruction.
> (See e.g., https://docs.amd.com/r/en-US/ug984-vivado-microblaze-ref/lw )
> 
> 36a9529e60e0 introduced an optimization that can return the global TCGv
> used for rA or rB storage instead of copying it.

Doh indeed we don't want to update these.

> 
> The bug appears in the reversed load/store case, where the
> do_load/do_store functions treat the `addr' TCGv_i32 as a temp and
> modify it. Since 36a9529e60e0, addr can alias rA, rB, or a 0 TCG
> constant. Those 3 cases are buggy.
> 
> Thanks
> 
> Luc
> 
>>
>>> Fix this by factoring out the reversed access logic and copying the
>>> address in a new TCGv_i32 if it needs to be modified.
>>>
>>> Fixes: 36a9529e60e0 (target/microblaze: Simplify compute_ldst_addr_type{a,b})
>>> Signed-off-by: Luc Michel <luc.michel@amd.com>
>>> ---
>>>    target/microblaze/translate.c | 56 ++++++++++++++++++++---------------
>>>    1 file changed, 32 insertions(+), 24 deletions(-)
>>
> 


