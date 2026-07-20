Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D24CC4452A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlnIv-0004CU-44; Mon, 20 Jul 2026 08:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlnIp-0004Be-8p
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:40:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlnIm-0003O3-A4
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:40:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAvUFp2430532
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NcK2lD80IW58EG28I3el0j7EYsxuzJRrUYu7Z7vsjWc=; b=kcbk4AOFmjGhYfLb
 lhhUubZ7qK9XvT4iVgcnoPmXhOIbPnsSs5rf9+67S64riU2louQH6/f53VZcZx0h
 /T33lr0yI6qjAR5NQYMgHj96cD/s+4Pj59rx+b2L963mTSco8CkOYReRiAUPpYsu
 8fFskLR638m0k7jVTAVoKrbeN7VpG+0hikZZCQ/vhBgo/N+s0csElGgGrMJAEGNA
 vk6CosQB5u/ccsfNa3SgkSFrdgL4EJsBHQXwG80ObHDTMltWuhUoeC8H/MVNIIm5
 YMticXRfvOp2ynwa84IEEdG5iJFSutGyzE43cZKDezKsGjcMX7pxfDdZdPAr6gH5
 e6EUnw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhhgyrmr1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:40:54 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f1e4e0eac1so173153696d6.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 05:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784551254; x=1785156054; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NcK2lD80IW58EG28I3el0j7EYsxuzJRrUYu7Z7vsjWc=;
 b=ZxqgxX5/UMnsVhzFdpSJHY0o/J6HSNB/xUD5ai+8N5dtebZ0EjsSy/fJeO20N9b70p
 iiYYoKaEftqJVCJm+8IZ3zk4I7Wie8y63r/F+uxBAOhoJ8SUSs8B4ILNDhFGToEhaQDa
 LMBcJPgJBxKG8jeW48PQsoGbkmPd8cSiz+vb8GssTELB58DAkZW/bwwhRw1nIn/ZHXI2
 JRhLlDfkHLKs/mN1c0LxojVxVQjOGVDFxZadmw8OKCbTqJ+tqsd6estG4LCK2+DRrtPy
 M7PjBUYgCBy4+Ab6vJIwlPOzmftX6Pgq6E2rzcZBxZhBac6yDi9tmXDAofwDJesCE2QC
 ofgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784551254; x=1785156054;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NcK2lD80IW58EG28I3el0j7EYsxuzJRrUYu7Z7vsjWc=;
 b=bn6fJJmcYBKkLA4PKqq0gm/3Mw+mnxD5DkX+Y4jrysauNrBfY+6B6BYC3wZ1pMO1ib
 53wtDX0yeY36iN9/bQGMjkO0QPTOYh/0m6nMs+e1oL/XDhALDf3dG81awJrAVtvxOJw6
 xTh9IcTbKVjxqrDhHx/UBUjzesHignqFphi5VubRA8ES6heEFlcBKXJjpJltIqFpgX46
 j4EJYJGRD5kgeq1VMeNYq61vV8y09ZfctpLac2b3d+bxbwHgl2xy6rVuT0NraDePZGYy
 vxla8WOBv4CEMCcDK76ZRoVp+E5xStbbLKnPrW0otnooyj7ljpXqnsUVz/M15nbuEAHI
 Hkvw==
X-Gm-Message-State: AOJu0YwvkeQhOsHgkYytVQsCWF0o2GLFHWVp0+DVLQd83Xa3IJbGBjRx
 L90j5KynjF9pZUZm58O3f3XTwyZYvGJrPu3TT9qBT/A2s4GlXYHfX/05aKwJUm8MUITzKCIz3Fi
 Uhn3/mz3sBLvfJplF7cg2Fu9ugdYLMPmzSdPW0c/x5wrD2oYekXUuWH6nww==
X-Gm-Gg: AfdE7ckQm6lOPXPrVVcXoFPRVeXVsK8TcxZW1QJ29UQVGdOylyKsnY7XAjY71KQk+Te
 sh/BzHhliZ0yRU3IN6JKgruL+tuhsjcejZtUni52npD08b1Y7VDGZhXBuFN0/wCckkZkefNuxY7
 IvBRBYeEYI/PNJEClFVwBjbbAVF6e9dx2RRlIaAAoAIzElfM8EFZ1PE77hvHR2b4zaR9LXk9yCM
 VNMNJ0C8ErZbyjGtNoxCqOvgp2MjAI9bbrwUzn/DbWGzNO9QuSy2hoCqMrUdzXC/7Hqe3OdlDfg
 X0NQCi77/8wBkkzK99adKhn0ffBF8sEhmcpOxy1yCTwXWKyd4RyKIM90DEBchzzfZS8gqcUP3xg
 XIciraeBNyT/KYqlaEcHEIgqqNdiGiGBYIc3TYGIUVAmWE1zbErA=
X-Received: by 2002:a05:622a:401a:b0:51c:868:899d with SMTP id
 d75a77b69052e-5213bf113b2mr129462361cf.15.1784551254161; 
 Mon, 20 Jul 2026 05:40:54 -0700 (PDT)
X-Received: by 2002:a05:622a:401a:b0:51c:868:899d with SMTP id
 d75a77b69052e-5213bf113b2mr129461851cf.15.1784551253375; 
 Mon, 20 Jul 2026 05:40:53 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e52aa4sm30280010f8f.10.2026.07.20.05.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 05:40:52 -0700 (PDT)
Message-ID: <ff3d5146-2322-4fc1-8615-a162fc838984@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:40:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/xhci: clamp interval exponent to avoid UB shift in
 xhci_init_epctx()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Feifan Qian <bea1e@proton.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <sXJQOREScD4G6fYInirO2wbLtvZf6EK1yuTrP6U3GQBM5dIq7dhRnCm9uxSSiRRK0b4m7OEZRqEgjzHCTFoS0DruFvYUXh-UUXhkY0x786A=@proton.me>
 <CAJ+F1CK=jxw1Nf8UYa6jx344HknSXyj5A4MaoUWr5xJSK-ohjg@mail.gmail.com>
 <f8f6b689-eb5f-442b-ae69-f09c226ea9f2@redhat.com>
 <56a25874-cb6f-4510-8946-bd60e11fde43@oss.qualcomm.com>
 <d815f5a5-f3bd-422e-98fd-eeb12f8bb91e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <d815f5a5-f3bd-422e-98fd-eeb12f8bb91e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE0MSBTYWx0ZWRfX8ExDoXxCXiR7
 ZjcCqr3DfSin07W4VvwsMy5UfKSlx2equnw1nGud+z5m473cGGlCQxbkFCHLvssL9Rj71LZsK6n
 ds3824x273NOLgUkmIyXvIT6+m9geT4=
X-Authority-Analysis: v=2.4 cv=LK9WhpW9 c=1 sm=1 tr=0 ts=6a5e1756 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=dfoUiL5mPq-3FJnU9voA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: zkD9yZw_i3Cvkq6eZ5gCCyw-zLKnm6sl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE0MSBTYWx0ZWRfX8gcXcLdk5dsd
 oN/oj7I1TKkN68uxzfrw5jvdllfF5CAr6m+USCL3MiDZKNNrm3+fyvnU95o9yf05J7CiKwctUCl
 CD7qdsT2M3Ccl9WppR9L9DcFle6kxDtiyZfeuU+ROWinRYzIDp2NJMmo5TGCx24eTR76qrJGoR9
 N8ZYPXF3OMns6q8JSfeyUvrqDdMm/ljNCdOY8xQN1OxB+G2d8RrYpmxRYoY4bXHYIggsP2KoxdB
 pwknLB9ALDVcvKmqAZsPnkTM7PK/jibAk0GOdxcpMAFdX5MuIUlKpHlvpvKS1S0XJDTyB4J0zV1
 WNxGemHvB3jn6oqS4wb6wEgvvNzwSGTCx4kf1Dtli2R6ON3w5X+KGGTqmUkhKfulUA4EmP59+Eo
 oeLQTXvtTmX5dWHsny9DaJPnjpHHdo+idfUiaigzHJByrNu/YQdUo9gqhrUnIujhusNonVis+xP
 AGEGKnLFlcGBOOSeopw==
X-Proofpoint-GUID: zkD9yZw_i3Cvkq6eZ5gCCyw-zLKnm6sl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200141
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

On 20/7/26 14:03, Thomas Huth wrote:
> On 20/07/2026 13.42, Philippe Mathieu-Daudé wrote:
>> On 20/7/26 10:37, Thomas Huth wrote:
>>> On 24/04/2026 16.54, Marc-André Lureau wrote:
>>>> Hi
>>>>
>>>> On Fri, Apr 24, 2026 at 4:37 PM Feifan Qian <bea1e@proton.me> wrote:
>>>>>
>>>>> The xHCI endpoint context dword 0 bits 23:16 ("Interval") are written
>>>>> by the guest and passed directly as the shift amount in:
>>>>>
>>>>>      epctx->interval = 1 << ((ctx[0] >> 16) & 0xff);
>>>>>
>>>>> The shift amount can be 0-255.  Shifting a 32-bit `int` left by >= 32
>>>>> is undefined behaviour under C11 §6.5.7p4.  With UBSan
>>>>> (halt_on_error=1) this causes QEMU to abort; with aggressive compiler
>>>>> optimisations that assume UB is unreachable the result is
>>>>> unpredictable.
>>>>>
>>>>> Clamp the exponent to [0, 31] with MIN() before the shift, and use
>>>>> `1u` (unsigned) to avoid shifting a signed integer.  The xHCI
>>>>> specification defines a maximum meaningful Interval value of 15 for
>>>>> most endpoint types; clamping to 31 is the minimal safe fix that
>>>>> preserves the full unsigned 32-bit range for any compliant value.
>>>>
>>>> I think we should clamp it to 15, to comply with the spec.
>>>> Otherwise, the patch looks fine.
>>>
>>> Some endpoint types seem also to allow up to 18, so I'm going to pick up
>>
>> Which ones? I agree with Marc-André they are using illegal values.
> 
> According to the XHCI spec, the "FS Isoch" endpoints are using values up 
> to 18.
> 
>>> this patch with 31 replaced by 18.
>>
>> If we don't want to report the illegal value as GUEST_ERROR, I'd
>> just clamp to the spec and call it a day:
>>
>>      epctx->interval = 1u << extract32(ctx[0], 16, 4);
> The spec says that the interval field is 8 bit, so this is certainly 
> also not right.
> 
> I'd say let's fix now the undefined behavior with the current patch, and 
> if someone feels like implementing the spec more precisely, this can be 
> done with a separate patch later.

Sure no problem.


