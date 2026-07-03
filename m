Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63151C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfdqT-00024X-6D; Fri, 03 Jul 2026 09:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfdqQ-00023y-Sw
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:22:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfdqP-00025i-7o
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:22:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663D8dY63195271
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 13:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pVHuRStHudNkoKHplW8emHlKSlT6Mn8WyW3SNIHJhMQ=; b=k8zYZcdoNUYdboo1
 Esw3dLF12C0H5hRrfN2JOHjwIhB4GDNuPrp8AP27qkiOLkpNWD8lggRZ83OsHktI
 KLgIh3qRVViEyJCOtKn7Wp4oDk7aw810SDUqNOTJFjyBgbkOaFKjlry2CDF28nIC
 oke/3HzOGVebo86s71mcYaWOV8bX/HAhZWe0u2ZbN19bp99fpFkkONPDI/DyMBjv
 wh7IodkJW4tyfts/NAw0H8tfOKU2saPn/ZxZAsHdYWrkI1iLcW5myz8KYtIm017p
 4M4qN9lehGsKsc3vdK06G4aXqqMiiUrSaH+sbB7hg/QWB1OgnKtnkxrG+JtR4l8A
 GpmvJA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68jysbsm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 13:22:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92158791d14so49784285a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783084928; x=1783689728; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pVHuRStHudNkoKHplW8emHlKSlT6Mn8WyW3SNIHJhMQ=;
 b=VBO2ZgzrRrMVLQeh11sV8ipTDg+NcuSeDXRB+F5BhBkLgIBDDrED8Ep9nEIvpPexwt
 zHimz3p2ml+H4/oSjZQLfpVBYaakU7UmSAULePGrG6n11IXzdNeEjqSzUkmsmvvlOUny
 O2qw9upiVAe6khC2sLskXUMQszTkB6SChp1nmrnvbZuI/FkS4ygfyXI07xLwMCOj+Gf0
 JaDfJj/htt18m+DmG8M8xGcTorwtixH4YBjE2pMCQVHMJgRYuQdkA5E67hIX3P7FK7GW
 0bhv6l6Itq6jtLkkGsc2Zpt2RBeHXc899oUatSkPt2SobJkyzHUgkWUd9QeOe+ToMSyA
 JYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783084928; x=1783689728;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pVHuRStHudNkoKHplW8emHlKSlT6Mn8WyW3SNIHJhMQ=;
 b=GTdobuhEHmYr8qqDgJzBcXU4eRONNCgPBILkLX6Qitdvni+8zhsce3zrEJEplpM+Ss
 hfx4UNxX6I9Gxzv6UVWVDc5mYvhKEaO9asCiyHw/WoFKbTeutyvz1Ep/HpuUPayssv4d
 /XTvlR3HKEudtZONcacxznkV6JemRlL2DRgWV4WgJwOLnKkFN/OEssOZbF3+6I1KepDD
 +FP0bFeQqLYv40nilllXVSdJcBUCdLQt03pQpctTS40MPE3SomgVZ3HhIERj8gi8QpDw
 ToKxRlUy0eRVrUbAL+nSJr0cXQdn/M8yLsrCwW07kV2JgycKk2Oyox24mAqmn+Od25ww
 bYXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kJhBlU9oWUI2vjTDqGvCWSudg7BGNMM9zQY3Ux7Gsk1okQ7ZQjkOE3KF9weGzUqOV5ILP1IosRunj@nongnu.org
X-Gm-Message-State: AOJu0YyW3SrrLE9SoFYui/OxLliCR2srfVwjvAPZzT51jt97TGslFGAa
 hrQRrQuLcb8xQ9Q5+7QYyudyq+Srla4VrvDDlLiR9g4s0AVeWB/e2MJE4618N7PAuz/HnBQDOCL
 jMrN891DevepvE6z33hIEsXXIu+0s7izN4g5JkyRZPe1ZTHr8lcGz5sZJUw==
X-Gm-Gg: AfdE7cmQlYFD5Apmpxr8H1vWrM2yk6tjS6x/Z2ECepKdnvfqx0ps/1fHhgKISk0Tt7e
 JKJqw+EPG+KxFL37AZlSvc2kWjNgxAgcYHldFpvXTdfka0jYYa7RsJt7nNTxFdxykQsT9E8AU9F
 TV8hv38HK3C2CgZnfKBxJxHLo/n7H+1eekb+JY0CZQ55/2GKj9/ckf6tTREE4uLV7G3mxyshaYf
 BWj6tvzOM9vltmAqYSlpWLZ5B2VP4NXbO3fYg9/IOEebF/NIyE1iktyga2r5/dJLTcHTFktttIC
 T6iuYLbaf7VNgrAUDF+W9AHKFpW0ooVHmmQ2FSo0AowH4P6vKlTLXNgKGrxdZQ6aqU1sZCkreZq
 /Nkk2xiAjTjpeofCPJqmUDqLrlBgh0JMzA/We0OHZALIQ
X-Received: by 2002:a05:620a:269b:b0:92b:7420:bd7b with SMTP id
 af79cd13be357-92e7b473345mr1225296585a.66.1783084928429; 
 Fri, 03 Jul 2026 06:22:08 -0700 (PDT)
X-Received: by 2002:a05:620a:269b:b0:92b:7420:bd7b with SMTP id
 af79cd13be357-92e7b473345mr1225286885a.66.1783084927571; 
 Fri, 03 Jul 2026 06:22:07 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90cc18f1sm153855585a.40.2026.07.03.06.22.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 06:22:07 -0700 (PDT)
Message-ID: <da9d6da1-bc2a-4108-a522-5e8e41ad9c6f@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 10:22:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/24] target/riscv: move pmu.h to tcg subdir
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>, Joel Stanley <joel@jms.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
 <20260702135128.1188021-7-daniel.barboza@oss.qualcomm.com>
 <374abf50-4593-4888-bb9c-2ef731b6d7a8@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <374abf50-4593-4888-bb9c-2ef731b6d7a8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzMSBTYWx0ZWRfX9W776CCPEaBs
 BC8QdN6dLC8YGjLw2UmlZNLn2lQi5Lt0ondjZqh9IQG4WoutKEfaMv23qilEcZzXyueBxg92Wzo
 +yrh0Vbf6b1JssD2iu1ev6HYOKJpLf62iV4s7kJku7oXfYrOYWN5bR7+hKxV/gcLjl/jx+GYpey
 M4apXpXTxueeiypJdGB0e1q7pHVL15t8XQt5iTcHqcM8DIns1J3B+70LGXSMMosmPaps5DmKBfw
 ARAi2Ytl2QjnMtsNAgm9eW+yY3cGIIklaKR6TNvnJevOTphjQ4XyZxIXm1d8vvfvunCNBwjRJ17
 ZreYj2JGTKvm1KEwdr1COzwikTjpnqdz+3u5vk/KSze0Nt1erS1fhtDFhX/Qkl8FVnT+SaPR39m
 bEEynX4BnVaUOYOZ6PehJMEQaWQ7JHjcFOA5rDU/sxQMjuRdDz8qOvvP04Z4v9WS9G0PwVfSdGo
 /H8CfdoAu8hU/EN7uKQ==
X-Proofpoint-GUID: 2X6yoqRHsW3coGKJDRgwpP4qUsXacPgm
X-Authority-Analysis: v=2.4 cv=QbFWeMbv c=1 sm=1 tr=0 ts=6a47b781 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=2aFWFHZrbJ7EhV8P2DAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: 2X6yoqRHsW3coGKJDRgwpP4qUsXacPgm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzMSBTYWx0ZWRfXxAkBi81Rnfkm
 RUKGxbb+oJ+7STezj9g+0C+mcmMMtZzCFmEvLhnvonhF8/+w6cAS3LBqpecSABKhwCaR6l1xEw7
 +h9JnrO8OFbAPjTzUr/EX6qEDDxdGpY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030131
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 7/3/2026 7:44 AM, Philippe Mathieu-Daudé wrote:
> On 2/7/26 15:51, Daniel Henrique Barboza wrote:
>> riscv_pmu_generate_fdt_node() can be moved to fdt_common.c since it has
>> no PMU TCG internals.
>>
>> With this change we can remove pmu.h from 'virt.c', which is now
>> becoming a tcg header since we're moving it to the tcg subdir.
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   hw/riscv/fdt-common.c         | 52 +++++++++++++++++++++++++++++++++++
>>   hw/riscv/tt_atlantis.c        |  1 -
>>   hw/riscv/virt.c               |  1 -
>>   include/hw/riscv/fdt-common.h |  1 +
>>   target/riscv/tcg/pmu.c        | 52 -----------------------------------
>>   target/riscv/{ => tcg}/pmu.h  |  1 -
>>   6 files changed, 53 insertions(+), 55 deletions(-)
>>   rename target/riscv/{ => tcg}/pmu.h (95%)
> 
> Preferrably before patch #2 "target/riscv: move TCG only files to tcg
> subdir" if not too much trouble:

Done.  The helper is now being moved before patch #2 and pmu.h is now being
moved in patch #2.

Thanks,
Daniel

> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 


