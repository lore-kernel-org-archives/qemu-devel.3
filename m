Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15083CD98F3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waABK-00008Z-6v; Thu, 18 Jun 2026 06:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waABI-00007w-El
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:41:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waABG-0001Ot-SE
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:41:08 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I8DkSf667674
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CWkSh0r9CExpB3rE0/hbQRRV60wM9Frq9tkmGml6IoU=; b=BrtmR4i+uVlL5Xs6
 RsE5yxAq2H9ZJciLsS/DVfJ0VZvr8vgM1Jwc8J/C1gRk8yZm8mY4s8kiikc41N0O
 lTpiuH0yrAxYRiVwHD95tAH9gG4HflmCQzhX20u8w+34QCTsVhLca2D+54LpPEnW
 KSpVsvIHreIdf/cNzO58K96lXiTCmfULC1OC85h2gPLHWjtLKg9OAFZmuBff8+aT
 fTQmpjPxWbaQhkvXOMm9NBVDVDjAzOb3xaQMKndbrrgnZtsT+U17NQJGlq8U0V0F
 VHK1dKPrg3G4xEBXa/nyt78HOCTidgLzEJUUMSPoRdd/DZqcEyiMI9Uy52AYFLn8
 otZhpA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vm321t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:41:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91579011fd1so140236385a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 03:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781779264; x=1782384064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CWkSh0r9CExpB3rE0/hbQRRV60wM9Frq9tkmGml6IoU=;
 b=AE/xiPRVwE71ih4hIybQA/F3wY7SVr9+n3/OkDGdUZ/gFFwNquyYcGqYvDmNK094oI
 LhVHvc1Bn33YmOcZa1gqmNXnkyNafp4dlG9Uq1jf1CY3cMQI5/0EOfedBnT1BT+ZL2PI
 liY/nRbw4UB7A0xEim85+wfrDNAO4qxIpC5O3tEjy7eZpu9skkzZjTpEtMDq8VKF6cFP
 va2m/zheJQOTh8pt241GQDmFqAru24eB+BsMjFCgqVHkPAR1QKjt1kfd/0mmquu3f7VV
 zFtmA9awQsNAMJhSTzeSMQSsXinKmxUZY+3yi84svY4nYoJbiG91FPnTi2neoh0UrlTD
 dZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781779264; x=1782384064;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CWkSh0r9CExpB3rE0/hbQRRV60wM9Frq9tkmGml6IoU=;
 b=nQPuoVLvnKJEWETtO095+SzKgzePjvNZYmYwU2i1i5eKkQ1ikwmdI/YbT++fZ9mriM
 ZWqAqWPcwpDQ9dCPozKsEBtKrz4mumLaLT8SsWxj5sWTefzP/l3d7963tSH+rbJIK1ol
 ltOIEeT6vjXBL4IyhoKtvbcxTb6U6bsLfY3jiDIpiL5T1NwJRqeKNTQaJdQmei98Idbg
 2KFdUWWBTVyMpa4F9ssR+jUvBEs07lwtmOV4JxZMdOyHqcRAqypg/lGqXXs/3eB9BRlQ
 UoY6w5ioRdlEKDzMLGwdrqGvt2wZ8oto7Rvpy2aQfWIJ1LAVZiG3Soud62Ds9EIG8xxl
 94xA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ox/FN+2dhdUQBTnPXN15SHzGQ0Fc1kBtf0s6FXb0PtjpAebu7eKMbIaaUZ/M4R1/67G5KrkvuYNA6@nongnu.org
X-Gm-Message-State: AOJu0Yzqr/I9Bw1SnYZvR4VCNXfE7lolQ/pmRKCL8GkU/GnhlKwYhUXE
 tvD3aIKCIuntnnY6HEZI0OeEl8kfpcLfQepQL2WlwBzcrwAN0efZhzTyPjSwR1vCarvDs1lADkE
 jQOq21o+zv5x7y+X6gL/ZHy80VSx6jQ1IxaIw9Ek9VHpQjfN8gHSZD9PlbQ==
X-Gm-Gg: AfdE7cnxlZ6Pd4nF43ekfZqmhL7WU69IoMyuXqYFWlfv83dkC3t+pbEUIKopErw1YWM
 9y42rnSt+2BgdwVvtHqjHvTnvPskiRb5WE4XtJ/QH2REqNbJnwHsGHMjfKf6UeYgg1U8PWYfqWN
 YxTsG43ikTH6km8DQvYSRhguBsZ6V7hiel1oMi1fnmSAPd5hwTrTk1ilpiLWiYZ2Bo7rtAikPpc
 GYRe38Lq/g97x11apoxWEoUkFHHSKgSUAhz1OBI7CPVQChU8zBphKE4/m8V8PP8R/1XTlVxVqPv
 P6iDo+qeYzmehUoEf+UDtw5WitvX9BMmBox4AmCCAnSpn0b/j/VYYxxjfWwK54QW6Gk6IOe/QLf
 SuQ6lkimvu1544wxdRITW1knj7hxLWsr2l0rK3n8YPs++8uXv1WeannevHuX/KQ==
X-Received: by 2002:a05:620a:f11:b0:915:9f87:eae0 with SMTP id
 af79cd13be357-91d8b4bd6c0mr1380046585a.45.1781779264181; 
 Thu, 18 Jun 2026 03:41:04 -0700 (PDT)
X-Received: by 2002:a05:620a:f11:b0:915:9f87:eae0 with SMTP id
 af79cd13be357-91d8b4bd6c0mr1380042785a.45.1781779263723; 
 Thu, 18 Jun 2026 03:41:03 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4ff67sm245455575e9.6.2026.06.18.03.41.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:41:02 -0700 (PDT)
Message-ID: <537a01f8-fd9c-478a-a118-3b6c6457b1b5@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 12:41:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/arm: use correct base address when setting CBAR
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Arnd Bergmann <arnd@linaro.org>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 "open list:Nuvoton NPCM7xx" <qemu-arm@nongnu.org>
References: <20260618093615.3793919-1-alex.bennee@linaro.org>
 <42927637-2e5b-46eb-9d25-8315cd36fda8@oss.qualcomm.com>
 <CAFEAcA9EUJrmdjee2PiLzObN0JagR2swd5x_fydDf6PVvD64Hw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA9EUJrmdjee2PiLzObN0JagR2swd5x_fydDf6PVvD64Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5OSBTYWx0ZWRfX5GKQq9Ti7KA1
 kY4JfUe8XJzYPQlFMidJF9KH8jfimkZb5taDahJU1saa8aLBuKxsdxW//JD21eZ9UIK5P5OvC4L
 W9j+jCUlYGhYRxunB01AUzRbh1Dv5tnrm6Vdk5rJHbVYYxjT+Mikj+o6lrKu5wdXVLwhXnORzO/
 jqo32H8E/TsGHHwgLOWWa/7syLVpYK7ngf2C9D3vZm0rx4qtuI3MDMLEXq5xW1+FK/jvp79BDT0
 mSmAW+ZMEsu0vPzAImv0uoCVtm16q0Tw50Ee/edKm/nLEGAR/2USOe9DtL2pPmMt7sNphExMMMF
 A5nf9JdCTJ8W0yezFGO310NvSOLc6Q/1K8H/NYlRxTTnW9Ks+C3hA2HkRHQhyJH6nwA6TpijQ24
 q+QWWq0SRX1GH/sWnO41VPmeaM/ejUBVHOQhqCqRY4R6GwOLn7ZfHKqw68iJfIiHi9+zxlO6wdj
 Jm6GvAhpQB+zOSstboA==
X-Proofpoint-ORIG-GUID: UVA7dGiNXaqQdcFa_qoWuQAc3mzamqRW
X-Authority-Analysis: v=2.4 cv=UrRT8ewB c=1 sm=1 tr=0 ts=6a33cb41 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=LnXgRUtFVs6qHmRbv0QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: UVA7dGiNXaqQdcFa_qoWuQAc3mzamqRW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5OSBTYWx0ZWRfX/ThhBQQp/+lo
 pyCN6E72RsxdIXuuFdsaR32HNorOg6yxn6XKrdM5STYUuzKL/Y89bEkgFSKvrjgHcqfb2GRywKA
 SKjnp0sQ8o5XdUvVZr1e+2uRhhsQ6PM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180099
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

On 18/6/26 12:17, Peter Maydell wrote:
> On Thu, 18 Jun 2026 at 11:07, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 18/6/26 11:36, Alex BennÃ©e wrote:
>>> This should point at the base of the Cortex-A9 MPCore private address
>>> space. If it doesn't we will confuse the Linux kernel as it probes the
>>> SCU registers and erroneously assumes the system is a buggy Aegis SOC
>>> and nerf the emission of SEV instructions, deadlocking any WFE's in
>>> the kernel (or QEMU smpboot code).
>>
>> I'm confused...
>>
>>     The Configuration Base Address Register holds the physical base
>>     address of the memory-mapped GIC CPU interface registers.
> 
> Where did this quote come from? Note that the CBAR is an IMPDEF
> sysreg, so its exact behaviour varies depending on the CPU model.

Oops I was looking at the A57 TRM, not A9:
https://developer.arm.com/documentation/ddi0488/h/system-control/aarch32-register-descriptions/configuration-base-address-register

> 
> The A9 TRM says:
> 
> https://developer.arm.com/documentation/ddi0388/i/system-control/register-descriptions/configuration-base-address-register?lang=en
> 
> In Cortex-A9 MPCore implementations, the base address is reset to
> PERIPHBASE[31:13] so that software can determine the location of the
> private memory region.
> 
> and then in the A9 MPCore TRM
> https://developer.arm.com/documentation/ddi0407/g/Introduction/Private-Memory-Region
> 
> you can see that the private memory region has all the per-core
> devices; the SCU happens to be the one at the start.
> 
> -- PMM
> 


