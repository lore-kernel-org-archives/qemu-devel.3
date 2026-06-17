Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496D3CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZt5a-0003GV-2O; Wed, 17 Jun 2026 12:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZt5Y-0003Dp-VC
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:26:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZt5X-0007re-6T
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:26:04 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFoaoa083451
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bEJo31SNuPJk+SJSKUmz49bFKzUaR8RK0cF2YdopJBs=; b=X5Ak6xFfKNO6caIl
 deQd6poEhRY6BvBssinjKa2u6rDnD0lkUbB4PjPfnVBiWO+MbV0kJuoFUoBJY20a
 n+RQZq0oY9VNaRnMk36rqlgwvrh27R/T0uZge10V/2AVLyjt/TVcqfX28yGBlSc5
 eLYS0eDBPfc2Z9+YcMPz67jbYTifUKuvJWVl0D9oGqTN/aa3GGWjQEuUHe5PMhXu
 hNLlCazhJ8zrOU0S2IhTqwqv3tcqba+nhCHC1bMM0CGLGF9SXikaiSQL0veYnc91
 tWlYXBR9BKOuWWhodBB2GBTS5I9M7a55qSkTm/SQJYlr5pSOIzFuebcVE1KwgFqE
 BqPs2A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euw9vgpxe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:26:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91565f8c589so218105385a.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781713559; x=1782318359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bEJo31SNuPJk+SJSKUmz49bFKzUaR8RK0cF2YdopJBs=;
 b=apU6DAA8NgHZMBdUeijFM2tyYWF+LkRAxE21RfCWRTUEaoJq6fIEUqMGyPUo9LJ/rK
 NS3nCp5kKoPG17Bucm/O27AfGvcnsoOLR6Jakr9MEbjTD4AM7uWBFBr7HcC2UTT5Qdpo
 GBo8MQghdH/ti8tmMQkJcWNADfHPzs/NxFZr3u0XUzJpfJXUd8oWzekQV/1r4/Gy0+Nt
 5pl+qsHS+O1VjGw/U8w7Tnt6cLfFouiP7WlzUa2921ec217Sovq055UT2bEJYueozFuX
 Edga4jQpbxfSQJJsDu5TQwE0ETnZjpsvedDnCQ0X+SxwvASewOyN+VAuCOJEGzMef7r2
 EmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781713559; x=1782318359;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bEJo31SNuPJk+SJSKUmz49bFKzUaR8RK0cF2YdopJBs=;
 b=fZ+y4/lrRkFk+1hS4N/9JCgZNfyvLIeEhCoX0IdsQpeDEYr8u2zsgB2c8MnHsupSuX
 4ZlRRuzIQFOjbbpGuMbIxn/4Qd+cLzLbwY37SXD+u5VF7M7JJLU8gSbsDVf8U0Op9u0N
 F4NBfMMovbTmdZOu/oZqZHmiHfgyZ5P9eUh1R6Q7ZuvE7odWpQUu2MFXMme/YWxWLPKZ
 minWLimrcoEXQwDFXw5V36p5dc4ktzOfO3/YtflVnf6YR2JxfZ/E3x0iZkqxfVkDlVRz
 iv8Ii4PQL1bMmW9VAHQcepH8mQz42SFjT+6clUlAbTPlyOFbPOTyJs2l9S8W27/R79du
 tBqw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ixzAREf2WJPlWj0tAwL9eApFIayaZuDQufXUZiz0lSlG4k/cso/wHyrAiTpNeZA2qdwsZYWv2iQA6@nongnu.org
X-Gm-Message-State: AOJu0YyejVxMC7P60tZF7b/HSNIbfEBhjIN5J0CgDd9bG3CphUmYiYlb
 ISi9RinIIlhiFfdXCgCyMBay8N4/bgYXfDt0ADZ6Sk5y9Z9SWZ/fnMbjzsec8OLoKmyBVMl5w/H
 ZuRjBa0EL3oUzPJshMn7YZWqAoPzEC8gb7uF/XWOiByEIyuTOTezur4lKMA==
X-Gm-Gg: Acq92OHLNCVF9kQyAluyCYrgQlCbJVv2IwwRVq8liu45DGVUFYi9OX/QPrCSKJNvhEK
 fz10Ztvkg10PWayST9Zg5miaOD4a1MVxEgm3cKTKyY6o6ChjOLbZpipTyU1ZtRX4U5EccNfbk/B
 fH3yjb2+OfsW6YZFqA6Jv1L2LN3AsHytZgMmA+GGkBS78sx42n/bItvIlvoOLEcDUsnqrYXsxb4
 qHj+VmwO5BKr5maeell8/C6Hzuhz4OvdDXCydJAkSxSb7j7TmcFoZ/7RFAcsWN4UV+XRFi7zxsF
 PUwrRJ+ypVN7FdanZgDZocXQcNpCHJidmxRY2uz2HtMwpXzqd5rCBO8TJwcc6+ChhOWm8934W2p
 1Ld0G3PdFNlv7R9ox73LxOo0StwyW+kobY0fa7emKqHh77x+5sS0ugGdsC9PcmQ==
X-Received: by 2002:a05:620a:d87:b0:915:9931:3a39 with SMTP id
 af79cd13be357-91f0a73e425mr31482585a.34.1781713559482; 
 Wed, 17 Jun 2026 09:25:59 -0700 (PDT)
X-Received: by 2002:a05:620a:d87:b0:915:9931:3a39 with SMTP id
 af79cd13be357-91f0a73e425mr31477185a.34.1781713558971; 
 Wed, 17 Jun 2026 09:25:58 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d70sm55666805f8f.19.2026.06.17.09.25.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 09:25:58 -0700 (PDT)
Message-ID: <dcd513f8-80d6-40ef-8b99-b232c507c158@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 18:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] accel/tcg: Have cpu_loop_exit_requested() take
 const cpu and un-inline
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
 <20260616191716.12932-9-philmd@oss.qualcomm.com>
 <8633117c-e2e7-4e68-8684-6b7bb6b6fc20@linaro.org>
 <1ed6596c-0e54-4296-a294-ce44e1008341@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1ed6596c-0e54-4296-a294-ce44e1008341@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -R3raM-q29qj6CjTPa4tZJ1-HbS53GIb
X-Proofpoint-GUID: -R3raM-q29qj6CjTPa4tZJ1-HbS53GIb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1NyBTYWx0ZWRfXyhSgn2L6wU7H
 YqGGmutZf22nVBAQuQ9Kj50DHUwdjmHk9qgEq4sBAvpDS1xhfBY6Z2nJwc/uOd+0evpV3tjglDj
 i2Yt+xuOCGlnJkw8wZ+fk00pFNbnPZ9MjbBVvDKyFGI3uH1doApWS4mpyOuJuVO6ifkZCNPN/AR
 TzcuOtRJUqdvmKYTTmbI+/CyzdPvxd7Gzsz7eepUytlChCODQ+pI11Dztrre/g7qPuLFqBDBORh
 UUnMnP5mIAE3gBsqAlp6MOrD2onoXj7aXFcD6CDKQJEn1tA6YRZ/HmV6GFMzE2INwhvpSBFWh3H
 /+CC/qh1cOQPOUWGYtuZdaQQ4IP9r9tVFd6Cd9zmHnwmVXXISwnkb0S11f8SSr4SZKCt/036mG/
 YnpIQwcHWLJdQ80504QXIfEZTWy2AjrJu9/PL2UXpXtrjSxVfHjazx27esIWZZ/auwhGHNT63nN
 ZBxg+cFbCM2DF2ioGaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1NyBTYWx0ZWRfX1DjZGjzEyJiR
 mE7zE5jSIJ++Y923OqqOT+BgOtbe707HIM7N0Lv/P9yBF7+jU9iUFYj2fR+8G2jNCIYV1P5GQ6m
 B9Y0BL3K8/qY/iZvUQVaEeEBqNn9j4k=
X-Authority-Analysis: v=2.4 cv=YJKvDxGx c=1 sm=1 tr=0 ts=6a32ca98 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=vlpRObNJ5hD0VqeC9S8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170157
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

On 17/6/26 17:34, Philippe Mathieu-DaudÃ© wrote:
> On 17/6/26 16:44, Richard Henderson wrote:
>> On 6/16/26 12:17, Philippe Mathieu-Daudé wrote:
>>> Of the 5 calls in our codebase, 4 are unlikely(), so not worth
>>> inlining in header. Since the CPUState is simply read-only
>>> accessed, make the argument const.
>>
>> Unlikely to trigger, but still called within inner loops.
>> Please keep this inline.
> 
> Why not inline all of them then? What is so special about
> this particular one?
> 

I'd really like to not pull the whole "hw/core/cpu.h" there:

include/accel/tcg/cpu-loop.h:87:38: error: incomplete definition of type 
'const CPUState' (aka 'const struct CPUState')
    87 |     return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
       |                                   ~~~^


