Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767BEC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 01:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfT3R-0003uw-Jl; Thu, 02 Jul 2026 21:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfT3O-0003to-Nh
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 21:50:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfT3N-0001vY-66
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 21:50:54 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66319eEo2350837
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 01:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RXYfmwbcIWxRuFjhhZ/BzZQe4eA1g9Ze/Z6/fWdLjDE=; b=BWhFw2IUyvuMrEcz
 B4Ooq7WVb8ESHoBQ89J4M0LlWPSRCNn+5VsgxfdBel+q4iDezYebEwsAwTXJQ6la
 EZOOxNFyS7jPjaQkqz+uu9aLNKiqu8MQtI+N12TPT8gxxq7Eu/7JNH1dyjSA1azy
 bep5KgdUHgaCPm1oODBriIs6Qy8rYOOhMkNea+icqoWcH65yzWJzpCrpICx85MHp
 XTTOoJRBL3sCdgAfzQHrrEz/U7aJV96VBVyV0d10bhLQsAyV9ao+5mc4tRntHLlf
 HurLI9iKemi/B0SKSIWmGYA7B5MSzCe3+iTn5OXKo7/SrOC14hyYPlvjnU3p1vmN
 PIY2hQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qnpax9h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 01:50:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91ed0e140c5so16033385a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 18:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783043450; x=1783648250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RXYfmwbcIWxRuFjhhZ/BzZQe4eA1g9Ze/Z6/fWdLjDE=;
 b=Ej/WohpYQcL4ThIJTzMdAgIOJJY23H3+/yEAb7V6TBj0+uoUG0MPLM5XQDRfyogTIs
 YH6uoTfMw6cBpGcqZKBbgCSbwg5rjqU+vUVE/XRnAGYmye3faZgDofblbKR/8Nvt11B5
 1RCubGPNuEhJeUpfhVVB6cKJKw+s/8kT6m3VxkZLvXQM0UYLnnlhK5vG1h/Mj8V57dFm
 8DPAqv9CdjucRV6S6C3Em7T0Osjb3RhbtMDxDZaHH5Stv1qntHBY4fKzv9lWs/5uHMO/
 n+OGpfKNZse66iw+kWzEexWRkjqrVArr0uwQGIH80BqaO7stOged5Ycc3QSrI9bM+owk
 9eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783043450; x=1783648250;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RXYfmwbcIWxRuFjhhZ/BzZQe4eA1g9Ze/Z6/fWdLjDE=;
 b=fx78u77tqU/+c7Cb3/WghurqY1ceor+BSAX4wto+wlP9dq4reC42eHIYBZAhkvJIO4
 xNzTGWwDff3aNd7Cr6jtr1s2KXl0QH+teP5Y8wzDsKszTWGIHiWL1XFmSLGde79/YRIc
 AIjGWWjk5ZN+ud1vlXENWBnLAznokiqtFavO4F09iBaT521fFNKxjFnOmvoClo7g3Qgu
 YJmDgGD1oECTdg0qdDt3DK01y7KIFN+ASbBGx/6enxLRT41tqZsx9bHhUTItxSBa2Vjj
 EhcfMVUlUIxRZUVZe4U92wriIIVI3H29yiXqmpTqavpACJ95gb2/X7wRE4WfdFP/V3BU
 BBng==
X-Forwarded-Encrypted: i=1;
 AFNElJ+h5y+0WsB3ri174iTiQVwElidUZRkUgVQ9Y9uI9WcYa/mbxkVWp4vEVi8Fr9lSMiqC4P1lkffb5ZDx@nongnu.org
X-Gm-Message-State: AOJu0YweUa/4GFPbexO1r6+I8T8wwb1KQ9s7hwwP4q5lMgecasaoMeQm
 QTM/bL17s/hwPKdgNZfYJucMy4qQPq1mRh9yefPAx7Pl3OnmTnaU4IrOhyKQrV5ijdsGpm/DpwF
 T0DaWiVkVXwxV7MuOpA7aIuBU4oxo76aQluzXQ8t2Y2z7LPwDJkELWx5hcQ==
X-Gm-Gg: AfdE7clZLJErjT8o7kBlig0H8jIG4bjaVxhthbbVka0bLaVfHYBbszlcxoNQPsQ8NIQ
 ebMAheYieh/1AsSimoCQM2Ac9wjUxgg2FPxE39ZQCgKCefw2azmkKZqNdGWFZ46X+yj/vh71Aub
 fKC4b90tCstaBo/SFNfQB/MiQj4mFf/+Dj0OtPE34sHhMOJQVDkipPvwNtXJLCMmVCSI5/rWRrG
 fVl5lKrUZZ90ps573fbMartnZZSmWkVmJCQqgEurv0C0Mct8gztIc4IcsrAqnQj3K/s8ukWdc8a
 aKcXaXD5WMOy/tSiKvg9tUD8tdfRpVdxXLCX3Mau6BvXM6s6iqxFS/8ZNxkE4IHQQpdn7ytNEQr
 97OZ6u7m6BHesj1p/zLHJz0A8ySyjDuQl8e7MuJ3GgE2D/yWtzqMoJ42kJPO61w==
X-Received: by 2002:a05:620a:318d:b0:92e:6b16:6a0a with SMTP id
 af79cd13be357-92e784d1671mr1149061385a.40.1783043450234; 
 Thu, 02 Jul 2026 18:50:50 -0700 (PDT)
X-Received: by 2002:a05:620a:318d:b0:92e:6b16:6a0a with SMTP id
 af79cd13be357-92e784d1671mr1149059385a.40.1783043449752; 
 Thu, 02 Jul 2026 18:50:49 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477de3dc77bsm14302088f8f.33.2026.07.02.18.50.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 18:50:48 -0700 (PDT)
Message-ID: <3919de88-1247-4057-916a-b9eae4e3fe9b@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 03:50:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/33] cpu: Rename CPUState @singlestep_enabled ->
 @singlestep_flags
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-33-philmd@oss.qualcomm.com>
 <7a32f990-4789-492a-b851-03658989fa70@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <7a32f990-4789-492a-b851-03658989fa70@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAxNiBTYWx0ZWRfXxExAOcZQqUNK
 OHcfG6rN11UCQXyMCSRWz9aBwuYe+JIOkxTqZYiq+WUmBLf7DtqCnqV7GCiFDrJUwOwtSp3rDhW
 4T4tJ+el//HCkmkD2q0rpflQaCnUtRM=
X-Authority-Analysis: v=2.4 cv=FoI1OWrq c=1 sm=1 tr=0 ts=6a47157a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=_IpcT5jvKFtfOkqrLEwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAxNiBTYWx0ZWRfXymBpL1K+KM18
 k1KowHbvS26mu3wX3ZUNKuNsgNVh3mYOf1qrKhWxM+KWyQPdQp4Pt7fo25CYOEv0zqtIMQG0AkL
 n1up90n+JCvbnPEibI7HwlP283XYDpetIqRjbvJYenQuVvivZC0T6cCmlvF1dGOHHuhBeA9JN6L
 1lUPAU2/XZzGPNGIKEjO4ndm2gsJJpoZRAYjLSU3uDKMJLQCbWWq3LbNF9qCRKJifKmwo6TSXtk
 vUmq94a1b3f2ZUEqbjZUc1lCJy6RsJZOQUot//KVeHsviC8Zad7Nd8dg7sN511P6X0YoscTHOBf
 sUKuXkJPspRqM+NeeNxpuWKd0ETtOEbeQo50GVDKfK5IskzVRDfvXIlduAKv0n+G7qZ/YNK+BHo
 jY5mj4vWJvVgs562vz1ThYw7YBLLWDW9JxJwpZTniCzLJyOUSzrTqSGS27grGFzYd2EfCopQP5X
 c8JcBqspCqkqN7p6g/A==
X-Proofpoint-ORIG-GUID: ApZL4Yz1RWhWVPeHBz8aHSqdjJ8zOoP4
X-Proofpoint-GUID: ApZL4Yz1RWhWVPeHBz8aHSqdjJ8zOoP4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030016
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/7/26 03:27, Xiaoyao Li wrote:
> On 7/1/2026 6:00 AM, Philippe Mathieu-Daudé wrote:
>> CPUState::singlestep_enabled contains multiple flags since
>> commit 60897d369f1 ("Debugger single step without interrupts").
>> Rename to avoid mistakes.
>>
>> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
>> ---
>>   include/hw/core/cpu.h        |  8 ++++----
>>   accel/kvm/kvm-all.c          |  2 +-
>>   accel/tcg/cpu-exec.c         |  2 +-
>>   accel/tcg/tcg-accel-ops-rr.c |  2 +-
>>   cpu-target.c                 |  8 ++++----
>>   target/arm/hvf/hvf.c         |  2 +-
>>   target/ppc/translate.c       | 16 ++++++++--------
>>   7 files changed, 20 insertions(+), 20 deletions(-)


>> @@ -505,7 +505,7 @@ struct CPUState {
>>       int exclusive_context_count;
>>       uint32_t cflags_next_tb;
>>       uint32_t interrupt_request;
>> -    int singlestep_enabled;
>> +    int singlestep_flags;
> 
> can we also change the type to uint32_t?

Good suggestion, sure.


