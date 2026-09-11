Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85B5C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x51Gf-0006VL-J3; Fri, 11 Sep 2026 09:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x51Gd-0006Uy-W1
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 09:26:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x51Ga-00057n-Nn
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 09:26:11 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BCjA7n4141125
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 13:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E+V50z1PgQVkqv+VGmuVZQZgaKAqwzksoIknc6P9Bw0=; b=QwGkgAPW28FbMcpG
 GSxjjepQDuHHjjWwCe9QNePC07oO/WuLYcNp6Ln8HyhiHedk7eOKLOr3JXCnbiOV
 e3aO3r5H36FgJ3oOE7kJTsxBC7Qlf3ImjpfuUyvJd78KZe0/kWW4iD0MoqBVc9aV
 AZUr3Ta+e7+rllUoASuglzSxl5acPDofQkJmrsrWjyvgAL4jY088SD34a7G9JXvJ
 9fWQEMNcQgzXkO5F5/xSIUtWpDV9Xk5npB6GujM1SFNSQMrQyNtavPz1TeGKl5Gb
 W/N9wS4mp+d/9phlGgAlA5Qo3QeVVIgdOchWoSvH8TnVhsH7tTUnex3RIuiIeYcq
 WmNswQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbdr9wu3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 13:26:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936aa34873bso143235585a.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789133164; x=1789737964; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E+V50z1PgQVkqv+VGmuVZQZgaKAqwzksoIknc6P9Bw0=;
 b=D1rfd3yTEeGdCuLvSL+tdfp0d6x0BfIxMEbqmITKZjE83zVQTniafiLxwoxM/YHJR8
 jopU4Mjmy029K5SjuNvZTDJSaeY7vneVntznJdHXcFBPD++e3J+7S1/ek3gy9GW+H2R/
 Avh0ynfEKOAMrGAWasgjTGKwu+I0kD4fHfsaQNwJu98oD1ktp3q3k1vjKqwWBaOULRUI
 gBxXeEExstqpWTRR1SE01MJt1M7BAq7thzg4Y50c/jFJOUfpJXHbwtJto2mXHwHKx3OU
 H0DTqUapecHTEt3x885PhZbucYlEsy4JxaSj8Qta9shulri1CeS32MHbi63yOAYCRDQy
 760w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789133164; x=1789737964;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E+V50z1PgQVkqv+VGmuVZQZgaKAqwzksoIknc6P9Bw0=;
 b=kD5c3reIN4urb/NXp+bwz4g3ONgKeagpAurZftIP4sU4stKFBCyQ/swIDoeKDTQbU2
 Ye5sgnR1AYiJugjGz8+n2p5Jhx7DxZF32+1lg/6Fs02DVMMSZRCkpsiqcQY/f0lM0fpx
 8rg8+RyRh4vdx2I/PNy2L4e4oZzjBf6l4wBg4mWxZwewDexfWHigJNYkztE0NCJSIZ2g
 RJSfKj6Nfwwv43vR/nUCAlzMXFu45Df5xbqsKx5MshORK9Xd3aB3SbPEgY7GwltHengL
 Y6mLvOK+hzZmGmjKo7dvAfFRkakp7EdjXmypB5pWo+Zuf2KolHmvj7AuPIivQmVzmbHy
 h8vg==
X-Gm-Message-State: AFuF++m4XxBTIuw5Nkrs2TydvEJHU9GKXzT+YO6ZCnH5cvmbst0p9QwV
 m0/x3/9aBMudnLcYHZoAI3xR75rN+Ra05I3XPo6fEhT5kb+YAQkCUHsGDoEGuLexCu9RNLsQ949
 uBcy+mGKxPV1PluUEe/UGRx/c/8r4zhR62+wMU0WCnDbBVpJBGz3UPwykZw==
X-Gm-Gg: AYBFou2NbJNqs1Yu9yHVXngFaB5vkK4AYdH2SRiNo48Y6r7dXahAwz5po3EJB4NfHG/
 JKVTl6W4P5fobF1V5PxLKGoc35aPul5mFFcesZgalewtysWJqb4RXCJ32s4R/UCT1Wk4r7OnQrK
 5K0Xo79aOMeF856oUu26LrBQAWenj89fgPyLN8QbpDmyAO6nq7nkhNv/qi36+uw0ZYGCCzE2D5C
 u7sYcCQcayAwJUuYE19kBcqkXcqDf/57qSPH6StRRWyIXAfvzOxER2OQDnjapv05P0RFMb8OE0c
 CQLqeKJhHug8qheuGQ/wHS2AJb/5Uaw4Z7z+hlLlRTXCrBQOuBzwuSFNrJqc6BafbflmpNz2Lbw
 WVTpJkfKBGfI1YnyBGsdeQmkFru+oJHE7P0nUguyty7AVuTbH0D6i/gYvrg2uCUvy
X-Received: by 2002:a05:620a:1789:b0:936:ca57:25da with SMTP id
 af79cd13be357-939ea24435cmr531087885a.37.1789133164425; 
 Fri, 11 Sep 2026 06:26:04 -0700 (PDT)
X-Received: by 2002:a05:620a:1789:b0:936:ca57:25da with SMTP id
 af79cd13be357-939ea24435cmr531081585a.37.1789133163731; 
 Fri, 11 Sep 2026 06:26:03 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939fd7b14c9sm1735785a.1.2026.09.11.06.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 06:26:01 -0700 (PDT)
Message-ID: <6c5600c9-2a83-4fdb-8bd6-824ae0b24e88@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 08:25:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] target/hexagon: move the HVX register file into a QOM
 object
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
 <20260910153221.1674285-8-brian.cain@oss.qualcomm.com>
 <CAJ+KCYMm3KSVDX=HTT4uu=X5wpDFuPsM49ooDggjO_b7=XADeQ@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJ+KCYMm3KSVDX=HTT4uu=X5wpDFuPsM49ooDggjO_b7=XADeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BMzgTN_reU5Mv_IqBAO57IJfam4FRkxo
X-Authority-Analysis: v=2.4 cv=PLmaavqC c=1 sm=1 tr=0 ts=6aa4016d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=wNekOOZhgP0aY1_dpYIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: BMzgTN_reU5Mv_IqBAO57IJfam4FRkxo
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE4OCBTYWx0ZWRfX6JLR5Y53zmYs
 lQvf9yCgWIVYvtcb3LTS5mQDhEQwXFfjOzbj1DZL6Bw0jceAHEb6o/+SJxOwSHHYi8SI/LY+CWq
 3nH11xVeUmiQH85Nd5URYiaGhznClPU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE4OCBTYWx0ZWRfXykIdZI6T8+rc
 55EvBgBkhYeJGO1LOZAXPKv9xnTYsNCLTQQBnz2uxj4gKXrxewHiJLlXifEAhBiKlo6fYhKW/O6
 Va4netPT7QHBxrhgZh9C2KlKpB/5Fhfzc8U25bEJPYUt7S/Racu66GshcAHtAOIRzo8kkauzD+s
 HqEpKxACyayumzrdzvuq8cAxTVP58zFMaL+BoHtLwdq04s5Wg+0xK4qdCr2N9bnw5gY4J1xJUev
 LA998hPB+Yu4xM0y2IisjJunrYOsp5mTWqgzX0ZNEuph1J5KkIM23rZ1xHfJ9VrComqmkAsRKnk
 Q/oKbcIfGP34x/EaTXTw/TUthA2e9fiKCHVr8mYqz2AzifPVvX4Wca2qHLhGG5LCcB4UB2o8bM2
 w9iLZOvA9TCdoG93jeXnzw0Gxl1+0GzeVSE5zFho9Hql9iF4PBeywSFI6uGclI1I24PMaZNTfDr
 /8z4vLITl02+gGdnxdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110188
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 9/10/2026 6:27 PM, Marco Liebel wrote:
> On Thu, Sep 10, 2026 at 10:32 AM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> Each DSP ordinarily has fewer HVX contexts than hw threads.  The thread's
>> SSR:XA selects the one it's bound to.
>>
>> Add a hexagon-hvx-context device holding the register file.  The machine
>> creates as many as the config table specifies, linked to every vCPU.
>> The CPU picks among the links at run time.
>>
>> The linux-user side keeps one context per CPU, w/o need for a device.
>>
>> SSR:XA is not consulted yet, the CPU always uses context 0.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   include/hw/hexagon/hexagon.h             |  1 +
>>   include/hw/hexagon/hexagon_hvx_context.h | 27 ++++++++
>>   target/hexagon/cpu.h                     |  9 ++-
>>   hw/hexagon/hex-subsys.c                  | 36 ++++++++++
>>   hw/hexagon/hexagon_hvx_context.c         | 83 ++++++++++++++++++++++++
>>   linux-user/hexagon/cpu_loop.c            |  2 +-
>>   linux-user/main.c                        |  3 +
>>   target/hexagon/cpu.c                     | 19 +++++-
>>   hw/hexagon/meson.build                   |  1 +
>>   9 files changed, 175 insertions(+), 6 deletions(-)
>>   create mode 100644 include/hw/hexagon/hexagon_hvx_context.h
>>   create mode 100644 hw/hexagon/hexagon_hvx_context.c
>>
>> -#ifndef CONFIG_USER_ONLY
>> +#ifdef CONFIG_USER_ONLY
>> +    HexagonHVXContext hvx_ctx QEMU_ALIGNED(16);
>> +#else
>> +    HexagonHVXContextState *hvx_ctx[HVX_CONTEXTS_MAX];
>> +    HexagonHVXContext hvx_fallback QEMU_ALIGNED(16);
> Why is `hvx_fallback` needed?

Tsk, sorry - that's cruft left over from an earlier design.  It's not 
necessary, I'll clean it up in v2.



