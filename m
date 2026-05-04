Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08139CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 18:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJyT3-0004Hm-KK; Mon, 04 May 2026 14:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wJySx-0004HC-Gc
 for qemu-devel@nongnu.org; Mon, 04 May 2026 14:56:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wJySs-0004eW-Vp
 for qemu-devel@nongnu.org; Mon, 04 May 2026 14:56:27 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644ELtcY1960770
 for <qemu-devel@nongnu.org>; Mon, 4 May 2026 18:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kmc6iAw6lWkE3XCM6X12corYn555HiQu0IfLFVkdXSk=; b=kRcTdKJvdS4gFOiK
 2/pzX8Hnm7kNGaL/1yB+i8Jmcfvrr6pXoMWo6ip/VB9aFVI7TTzXp5qMx6SZK2sc
 PHOyQXeO7BhaasBHD20VbPvNmOZspX4+gLRfllCSJM73dkbcNO+5OEx/e18ckR0A
 kP5RdwlqwCI1oG5Ht/7lSXKEF10AuNSdVf+vp59/3iw/RpJbIcl1BCUAJnoPZtKK
 KJ0Ogz+lFNSPtFJ+P++Vq7GRaLo2nnQxXJjCnMxUzTW3WNItfVn1kXjPADNJplPz
 mt/t2CvqySEIQVbBWtq3HBTUM0gbECI/oFgLRkRTe+D8u9dfFKepM0v1vckj44tV
 4iHn8Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxw5ds3rv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 18:56:19 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b640ede74bso71356596d6.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 11:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777920978; x=1778525778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kmc6iAw6lWkE3XCM6X12corYn555HiQu0IfLFVkdXSk=;
 b=eQNiG/BF9JOtF+dDsbBkwqkmSG2JeoUIXF8macUSQO99Qn67YLCC9ZHJu9/zQnzcnK
 CVoSytdgzXkWUMWd7FBROVvHqdQoouetX+j7XNUQR9Zll4Q6eWam4hWXqLPlD+ZPWmFx
 qhoIYp4BTpmjuCzQRlgKcA1+9NoAS9ZJOj5PhzPjYTPyW5iMJBpU7JjBoRFBYeHRwnX0
 cTCl3pSWKblqHl7xivKlxYnaNWKmI2voPumOBiSpc/lbB/YN2zY7WlvwzUc0l91ftqaX
 uhUqk4ywjrn5BvkUR/RoALOnh5iZNJuiQT3fRnHTkC1iUPq95wm0tYe33WA/Oe/rqnHD
 qiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777920978; x=1778525778;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kmc6iAw6lWkE3XCM6X12corYn555HiQu0IfLFVkdXSk=;
 b=I7dieTkkNvTxhMzS0S7bwkKShkElEf5Z9SZVL5PuXQdcvvmTaiF8J2g0S1KxXLc7xm
 xgIwcwHXrPSIaSYOV2NfkAxdL1atUaiVeL4Oo16paW28YgtwDFLqfei/Ui++Ts/yZodw
 APDL/FcOaANagkw02RH0PE6l5EFJzS0RR0Xkm8ZXEdzilHoqpoQJFlwCfFP2+M99x9B9
 0JVQuuEpBKrVT6tpXXGVMs0d3E8uAnq4vDowMJRCuW0B1WuCe5WmD//j4ve7DZf/nvsI
 IHKIMy+yLjM2C0eUJAefftl+7t54HiZrooCPRrI61nzThA+4ta4bo+xnA/yoWar9T8YP
 cF8A==
X-Gm-Message-State: AOJu0Yzm+KIJayuEVfo6yHJ3jrER8Ba5/3oqk58PHV8zH+PeXjcyZA1q
 6HDOj+lyP64UY+qI9fNBPY8gUe17yfDapZjRRSzhP3bxE1SRz7mHPxzff+zCjpM/i2OI9iZnNKv
 MCxrpu7sroZv18HC2qiye4wkta4g2glXOJAL0igw5hNHvqX5EJWPypNFoPg==
X-Gm-Gg: AeBDies0WB1WRPq1v9Ee3aiNmqnIi82Avl5ArVIjnb4xe97frjXGhvEN1pmt8bgXeE0
 th4s4cRGUNvlxp9XoWHLIxdQpxsDA5ij5g0iaumzWayQ8DanxZh1jY6LoGnAyykvIzcwp1zCsDW
 ocCpBaR1Xm3l2Ca05XbIrbpb8bGMBXm8GHSiP2okvlzhPIT84CAh5OnjBSbiOXHYotbPM3qTkL6
 FcbQIo0q1yuxkJjU6op9dQH8QIwXBr4uM7bgVJDeLP7lrsJJf/h4gn09cfE9wQ+H3UfPKjx6RYF
 IYOqLg+F68RisqMwZbcjUxuWU410LBnZcS31lWZsCnG6QvoYp5bloGwl5YXJY9QkdVNzq+cJwKt
 /dJ3NJ+riPKFZaEaS2drg/qb3wWqPK8BQxKEvtIgzx/95pdIP2iVvSGWsFKsHAy+KmRO34A==
X-Received: by 2002:a05:6214:3a0a:b0:89c:8a0f:55a0 with SMTP id
 6a1803df08f44-8b6665f1f5dmr193340736d6.16.1777920978294; 
 Mon, 04 May 2026 11:56:18 -0700 (PDT)
X-Received: by 2002:a05:6214:3a0a:b0:89c:8a0f:55a0 with SMTP id
 6a1803df08f44-8b6665f1f5dmr193340146d6.16.1777920977747; 
 Mon, 04 May 2026 11:56:17 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.237.136])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53cd827c5sm150182316d6.40.2026.05.04.11.56.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 11:56:17 -0700 (PDT)
Message-ID: <c4709186-97ec-4ecb-804e-ac96d527c569@oss.qualcomm.com>
Date: Mon, 4 May 2026 15:56:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] hw/riscv: server platform reference machine
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, leif.lindholm@oss.qualcomm.com,
 Fei Wu <wu.fei9@sanechips.com.cn>, andrew.jones@oss.qualcomm.com
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
 <20260424191129.1494381-4-daniel.barboza@oss.qualcomm.com>
 <CAKmqyKNZiA=rYVD6ighyFO+qmhdYVk=UgbaznBHrZ2yt1ZvOtA@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAKmqyKNZiA=rYVD6ighyFO+qmhdYVk=UgbaznBHrZ2yt1ZvOtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE3MiBTYWx0ZWRfX8dAAI/lyYoCM
 ZMriMzVq565FUDNQbdvP7r18DskSglnKlkJlHF2RwNnNOZ3htJa3QhuYZJ7MvmiR4JATc8TpFjC
 H1e10CuAAppT0OAARPJGgt9zuLhleY/ibKTWTpPlMEJ7bR2oPg0fKtrZR9MjhwUwiYMLBPsyars
 4enmPeXU4eJPKpotqRlfPW7D8meFbpjIbxv7gqxAFKTd4WufBcTMVLK7u8Q0s9LplZ0PTUn3QkU
 P3LmOvxzR+DBP7zz9GASzSm1OBFIZshlppQv3dYm6D8nUPfXXcg7prwyqtE5j2S3+v727c0/h69
 19pmHVz+QXXmX1A9WbALxq/JPRqiVFfaXPAwp/EWc5F7yz/R9H49HHMDo+H2rVENxB/+UknR5nw
 l/EWBttOL6+YjImOAuyDrDBSg6fQ+U8wVz3eXhKmJEKitEnuXLufAE8JhcLDL7YmwBZ+O2tt1Gp
 x2sj246x1gcMTqrua2Q==
X-Proofpoint-GUID: YHnDsxQa8QtmgqTB-7Sfj6JFu9DCmlbs
X-Proofpoint-ORIG-GUID: YHnDsxQa8QtmgqTB-7Sfj6JFu9DCmlbs
X-Authority-Analysis: v=2.4 cv=HpJG3UTS c=1 sm=1 tr=0 ts=69f8ebd3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IZaa5BNpKBTNMhuJoHisKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=uTRCLKPYAAAA:8 a=tCHF0U2z__NgwREtqDkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=T-agBWn15iSmxapsA1lH:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040172
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



On 5/1/2026 12:27 AM, Alistair Francis wrote:
> On Sat, Apr 25, 2026 at 5:13 AM Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
>> From: Fei Wu <wu.fei9@sanechips.com.cn>
>>
>> The RISC-V Server Platform specification [1] defines a standardized set
>> of hardware and software capabilities, that portable system software,
>> such as OS and hypervisors can rely on being present in a RISC-V server
>> platform.
>>
>> The main features included in this emulation are:
>>
>> - Based on riscv virt machine type;
>> - A new memory map as close as virt machine as possible;
>> - An always present IOMMU platform device (riscv-iommu-sys) that uses
>>    IRQs 36 to 39, one IRQ for queue, similar to the 'virt' board;
>> - AIA;
>> - PCIe AHCI;
>> - PCIe NIC;
>> - No virtio device;
>> - No fw_cfg device;
>> - No ACPI table provided;
>> - Only minimal device tree nodes.
> 
> Can you describe why we actually need/want this? The virt machine
> already covers a lot of this and OSes and Hypervisors can pretty
> easily target that. I'm not clear what this buys us in QEMU. Maintaing
> a machine isn't that hard, but it would be nice to have a good reason
> to support it.

I'm late to the discussions but following up what Leif and Peter already
commented: this is a similar use case as ARM's sbsa-ref machine.  It is a
development focused board that adheres to a reference spec, it is not a
board to be used for overall consumption - for that we have 'virt'.

If the reference spec changes the emulation will follow suit, and existing
software that was working previously can stop working.  The assumption made
here is that, when a spec change happens, developers must strive to make
the SW work on the updated spec/reference machine.

Last but not the least, this design decision also spare us from dealing with
machine versioning.


> 
> Also we need machine docs that describe why people should use this machine.

I made an attempt of that in patch 4. I'll improve it to add more details
about the machine being a developer focused reference board, not suitable for
virtual machines for regular users because the board will follow spec changes
that can make existing software misbehave.


Thanks,
Daniel

> 
> Also, why no ACPI and why device tree? The spec talks about ACPI
> tables, but I don't see a mention of device tree
> 
>>
>> [1] https://github.com/riscv-non-isa/riscv-server-platform
> 
> The first line of the README says:
> 
> """
> This document is capturing discussions at the Server Platform TG.
> These are not official specifications and everything in this document
> may change.
> """
> 
> So this machine needs to start out with version support (like the ARM
> virt board)
> 
> Alistair


