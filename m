Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06532CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 15:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xETFF-0001MN-TZ; Wed, 07 Oct 2026 11:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xETEz-0001FL-Mh
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 11:07:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xETEx-0005ju-2y
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 11:07:33 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697EtTQN1137367
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 15:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B+W7KHYZuPVF3EVK5S9nseD3ajgEDjtOWo14PodSc7w=; b=ZH1yf6lP8xyU8lRT
 +UGhNH00t7ZR6Luz5Mm9vtzO4oi/3neEGIaWCuBSwlROS/LVINqmNU0c6BiesuRv
 M1Jot6UBbH1TPXh55UHCznDCQXJD6FyHx72EBveHs4HxxeWB0yGJPLFKPeyTOrX0
 DFpmxRd9nhV2EFYoz27T9O992fxxFyQLjhnMwdJBNp0l7HOID7flGTBwiNfnPSY+
 M5lunhFdon2F2oVKNvG3Xj1eIG8aC53H7E0TCzPne3iarcEU002gm+l/ATRDzrKP
 tVKZClm5aTjeblrl4tUCB5KKsqAgXrDop8Dpak40I8tnieTIatHmLS3MVAp2egHd
 Q17YPw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c71bj55-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 15:07:28 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7bf853be08eso1057932137.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791385648; x=1791990448; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B+W7KHYZuPVF3EVK5S9nseD3ajgEDjtOWo14PodSc7w=;
 b=ZsSmZZNYNh+ntR8cpy1Fz8sw5RNIrtTYz6WPhQ7NZ8q88HruFOdgDiRKav7Trqm9+n
 F5eMwEEQsGWrRvBD5OqiNANejQJriK2+KF7JoudDfgO6lmXqJ1BUUZwiGf8ePaYDF//A
 HKtHfkjnqjfX2CtpXHKIF8fxCyy8Bxc/MkG5BLnXB0+PL+MAIWW9+bTB2bgkG5uqrLV6
 yJ4059aTUK6WXxvcgXBrPAO0ToqBzTGkAYRUXoGY/78EVJYd6fVT1uEAyDz9m+4d68iT
 XhRdqIAPF60TSKmWJWCajrkCI+KPhULVPSxX0OD4AfY98YMvMPlXZ8sf8QE9L/8ShybW
 IcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791385648; x=1791990448;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B+W7KHYZuPVF3EVK5S9nseD3ajgEDjtOWo14PodSc7w=;
 b=cSZDX+y2a5tletrbMq1sdarDHp9Cno6qFPUO45Swy3YWlqncxIBFa/ztbtVipv/VRi
 GXsyT0FBh2TEQ4wLSsWA7ps0MUCTDnvG0d8WB0yvElRlsoQ3WIn4iBRvy2O8DKnbQwQa
 HGCCFv01sWKQ14pWSY6o94z978yMZ21KNzibj5UoPhbTkjKMfH+zAl0XG5Re6rSN+CDC
 0rW1cSTpHz8Q7cz9voaAFBR6/07aZvQkuYfo840DJmdeP2fhz3VL18Wj8H/ug/aXHsYj
 UW3lr+Qb1ZIIEpx4NpRmEMJ+8vO2E6pnM/1RMQ7EcRkELMzIhz8OYZaHhuvKd9A0bQoB
 UD/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByg97uxvZH6BxmqSZ/2cbK4xfU3qiOw1ac9LyHNDUkOKouN4vSG0LYZ60gwUrfJAhEOFrv6LGb1VbRz@nongnu.org
X-Gm-Message-State: AFq9FYJzGnUE0x/PTSkipy4i6Y1245yxWGVeC9gqPMj2DWMfDRHTCcTK
 l2/vTjykWHEmSjyTgb63V+ZwNlDOaWJYAq/QnZrbjie2uxPXKLXjcVapxfdqM0hzHfwaovlJ3DK
 NW1mmSq8CzYnfPQqhFkyTAARtC/L0OImL8NOTyfELHb/n45QzJYRHCXfpnw==
X-Gm-Gg: AYBFou1UIUIGLo5Ax2ETyjeEaKxXUWZRbPXCwW9jERXP37E7g6KNDWLy+n7bp3YlaQk
 d5aJqR4tj1MXbzG17KDAUGr935liZa6d2IHrbR3Vb48StT4VMzZ3UmXaMWKK00nvyNpPwUVMIAj
 Sqvc0Pu51TB9EPAJJX+YthtTIo87TvxO8SBDcCaDfo5OuQljA/q5jvmOc7XJ9naSzDN84f9vmjQ
 kHga26SJJXu6SBJHOXNVQnG0Xj0GJiglOtm+ZzR+hPuR3d5e5EQC8vqUza1SdIxNwPTIBRck/x1
 cq3ZJhAlvkcdrWXIw57n/g9h08cBNCUybJh2raWR+Wu2fNNZOeLrUlQF5jfTzca6QAOA0C+2hl7
 mYAWvfPgG1MhEeZk2PNJl/sglvVjG8eGWhg==
X-Received: by 2002:a05:6102:f87:b0:7a7:198a:c2bf with SMTP id
 ada2fe7eead31-7ca38f260bbmr592363137.29.1791385647693; 
 Wed, 07 Oct 2026 08:07:27 -0700 (PDT)
X-Received: by 2002:a05:6102:f87:b0:7a7:198a:c2bf with SMTP id
 ada2fe7eead31-7ca38f260bbmr592353137.29.1791385647133; 
 Wed, 07 Oct 2026 08:07:27 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f4480a4sm56331355e9.0.2026.10.07.08.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 08:07:26 -0700 (PDT)
Message-ID: <eb5da885-4ad5-4a3c-886e-a70f769f6622@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 17:07:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] hw/arm/aspeed_ast2400: Use unimp array and table
 for unimplemented devices
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
Cc: Maydell Peter <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
 <20260930072501.2612119-2-jamin_lin@aspeedtech.com>
 <941d7bb6-3205-44cf-8d76-ffbb322a6f4e@oss.qualcomm.com>
 <0cd87753-da91-44ed-a629-43099bfb820d@kaod.org>
 <1197c1ca-14d5-48c1-b497-0c03a781c258@oss.qualcomm.com>
 <330f9a96-4508-4db1-a8a0-fa36c57ed093@kaod.org>
 <672CD4C9-8FCA-4E5A-B610-3F9C51B986B6@aspeedtech.com>
 <0c9ae93c-cd18-4552-9969-0f01568800f3@kaod.org>
 <SEZPR06MB7362FB6E932EC8EEA123F2C4FC892@SEZPR06MB7362.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <SEZPR06MB7362FB6E932EC8EEA123F2C4FC892@SEZPR06MB7362.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA2MCBTYWx0ZWRfX1xm3gY+6mWaH
 649kPbjxlcGrTLNM2kFBSWr4DVT0RLBniZOUJ7dAMwvcrIuy9K6AjuSpf8YddueZYg7t+0ASr8M
 zM3zc3K28gOatDgwm5F+66f3CtDFjNA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA2MCBTYWx0ZWRfX8wAHBKlPm/or
 FH9hviZ4n+6aMvUt5hkjs9xmGfZotYGLf9lYkZKHBxypEGWMHn7KUuJlKac1eAcsIpqMMsw3o/n
 XJPLsLM/VEqn4FdCbETBwoHlXaP0+NSz9c92r7s27m0yxuucxK16PkYcFXTdqCEAwBrrW/5y4ej
 EYAKNfdVyslFrZfA0jOlCwRtmGXdb3IIrsEHjGYMBzaz7iBP8XBkJs9fQX7eMB9x8yQO1mVwULK
 /+xSZ5F9GlDzAD2geBCOFGLhrM1CpV5oJThaZe+smJmEEspxMyw7Ow2ZRsUllSMu8AyZSXB08jL
 bljOhFYRc9utURn712awtBanS9sgQ0WFrL/8naZFO4eOBrHEQC2Wz/spvM4VtxS9YwJtCcROy3l
 ZAvr62LDwjSGdb4AHfFcMW7hspucmUZFzk/HHhY/WZECI6hl4j2nfyFa+v8AVARiByrMu9zcjO0
 VsnZ+R6b9MdtBXuO8Bw==
X-Proofpoint-GUID: A_utJR2N4b7XjrHOFawg9NEJ6fIL3ZF6
X-Proofpoint-ORIG-GUID: A_utJR2N4b7XjrHOFawg9NEJ6fIL3ZF6
X-Authority-Analysis: v=2.4 cv=LvYHWXdc c=1 sm=1 tr=0 ts=6ac66030 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=aow-egSQAAAA:8 a=pGLkceISAAAA:8 a=PMEa7mulmaP2oMXib6QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070060
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

On 2/10/26 11:02, Jamin Lin wrote:
> Hi Cédric
> 
>> Subject: Re: [PATCH v1 01/11] hw/arm/aspeed_ast2400: Use unimp array and
>> table for unimplemented devices
>>
>> On 10/1/26 13:51, Jamin Lin wrote:
>>>
>>>
>>>> Cédric Le Goater <clg@kaod.org> 於 2026年10月1日 下午3:41 寫道：
>>>>
>>>> ﻿On 9/30/26 14:16, Philippe Mathieu-Daudé wrote:
>>>>> On 30/9/26 13:50, CÃ©dric Le Goater wrote:
>>>>>>> Note to Peter: I really think keeping duplicating the
>>>>>>> UnimplementedDeviceConfig structure is a basic software
>>>>>>> development antipattern. Could you reconsider your objection?
>>>>>> What's the background ?
>>>>> I think that was discussed on IRC, the only ref on the list is:
>>>>>
>> https://lore.kernel.org/qemu-devel/CAFEAcA_ob6mHqfAAM9iAMae5vfxaYhmc
>>>>> qkk-gJH+s1mHuvFp8g@mail.gmail.com/
>>>>> create_unimplemented_device() calls qdev_create() and allocate on
>>>>> the heap, my motivation was to have another helper for in-place init
>>>>> (when the UnimplementedDeviceState state is embedded in the parent).
>>>>> Now we ended with such helpers like
>> aspeed_mmio_map_unimplemented()
>>>>> which realize in place, make_unimp_dev() and create_unimp() init and
>>>>> realize in place and Jamin adds yet another pattern. While all are
>>>>> valids, I'd rather unify.
>>>>
>>>> Could an array such as  :
>>>>
>>>> static const AspeedUnimpDevice aspeed_soc_ast2700_unimp_devs[] = {
>>>>     { "dpmcu",  "aspeed.dpmcu",  ASPEED_DEV_DPMCU,  0x0004000
>> 0 },
>>>>     { "iomem",  "aspeed.io",     ASPEED_DEV_IOMEM,  0x00FE0000
>>   },
>>>>     { "iomem0", "aspeed.iomem0", ASPEED_DEV_IOMEM0, 0x01000000 },
>>>>     { "iomem1", "aspeed.iomem1", ASPEED_DEV_IOMEM1,
>> 0x01000000 }, };
>>>>
>>>> be defined at the class level of the SoC and handled automatically ?
>>>>
>>>> I guess would need some kind on common SoC model in that case.
>>>>
>>>> C.
>>>>
>>> Hi Cédric,
>>>
>>> I will resend v2 and rework the design along these lines.
>>
>> Please wait a bit for Phil's feedback.
>>
>>> Defining the unimplemented devices as a class-level array and I will
>>> look into introducing a common SoC helper/model for this.
>>
>> This could be a start for a more generalized solution.

I was thinking something like (untested but you get the idea):

-- >8 --
diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
index 77a5077511f..d12774d6cc3 100644
--- a/include/hw/misc/unimp.h
+++ b/include/hw/misc/unimp.h
@@ -25,6 +25,27 @@ struct UnimplementedDeviceState {
      uint64_t size;
  };

+typedef struct UnimplementedDeviceConfig {
+    const char *qom_name;
+    const char *region_name;
+    uint64_t offset;
+    uint64_t size;
+    int priority;
+} UnimplementedDeviceConfig;
+
+/**
+ * create_unimplemented_devices:
+ * @parentobj: the parent object
+ * @container: a #MemoryRegion within which @addr is a relative address
+ * @devconfigs: NULL terminated array of #UnimplementedDeviceConfig
+ *
+ * For each entries in @devconfigs, create a TYPE_UNIMPLEMENTED_DEVICE
+ * and mmap it in @container at UnimplementedDeviceConfig::offset.
+ * @container is expected to be a QOM child of @parentobj.
+ */
+void create_unimplemented_devices(Object *parentobj, MemoryRegion 
*container,
+                                  const UnimplementedDeviceConfig 
*const devconfigs[]);
+
  /**
   * create_unimplemented_device: create and map a dummy device
   * @name: name of the device for debug logging
---

