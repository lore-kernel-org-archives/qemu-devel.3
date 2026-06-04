Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE889CD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 22:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVG7E-0002A1-Hk; Thu, 04 Jun 2026 18:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wVG7D-00029k-I8
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 18:00:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wVG7B-00016x-4I
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 18:00:38 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654JnvZ03111628
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 22:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lSNTVZmMtJ2WyQtW5QJZ1ec+mKOrTJa0bu5LITZjA2k=; b=OdkTFzw2eOXPBGxS
 ZXJ37Fg8sL7Eee67sVAlykE90hb6bYoHR18hI2gpZUKnqlclPH+FtKsMHkKh9Jvm
 gaWMNOW8JSTuMEvKuO1pD6yBFtzI1XKOwdTy4elT0SecAa0BL4Bf75a+9frU0Q1u
 HYx6p9SvpraEM+ZdVtbActSoC5MAyGtapKBraQ4Cx+Y1vwMOlaPTLDTbWyIvnY1h
 yesSW+fmANLLvQGVRIAuGt+5YH3ljeI9+mNO0h38mVMZPlb27Kh0/Z1AJArYzXbw
 apJJmrpSa67TG7r2mh49f9DYZkYf0iqZP2qaau9hroDZaPLZLgwy6MyxoOHZJHyn
 AQGsVg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekfv70eta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 22:00:34 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-59ec5a8fed0so2487991e0c.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780610433; x=1781215233; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lSNTVZmMtJ2WyQtW5QJZ1ec+mKOrTJa0bu5LITZjA2k=;
 b=PPMsBAZxbpeTVPTj4QgT5B1I6wdZJl4IvhKHYpc6VD+sULN3ll/zgpRzw+Cca58ax2
 4+N3mAvpyEP99FZxuYAySD47u6gw81OQ41iiIjyM06mHSnVfMT9hCKPH+uRus5vJcljZ
 lEl1en5AW24rgqwF3r4F4YWqut8f+7m7AbrgqMqT4hHr4lRCyVKS+B5JsRyg2lNs+Akj
 huE5Wp1sPxS/c2tPWKt+kfNpgz2w77fNb1cxYO92OgOaiGOit7TF7AybLAZsBmLip9zK
 GXYxhaliQ0gQcRN7Gu93R1UQpzJ60pklkUl0w0Evb7t7M4m6Gn+Vt0/Xm8WPrHl/VoLX
 w9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780610433; x=1781215233;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lSNTVZmMtJ2WyQtW5QJZ1ec+mKOrTJa0bu5LITZjA2k=;
 b=B7iZKb2SfdChthTCvTA4RdSH2o9vibzk46YWsez0DJ6g/IAZDFoU9MgPxb1ZpGUsN4
 zRZVeVIceQzUasIodhsgoBS4mYLP6j/UDebL2fuWaaLlaBMZvnctB7sA2z7yLqjaexlo
 vdVgNjGI0RP9zW2L4WjtBkxdYISHpGOLDywQsjFMOeS+xO0BEvPPuh7kp8vKpXmGzTBi
 mEDjOvkdYsoMtm8TNiAZ0fOvNI0alKJqsOmIv6AxZCP4atZurql2nacUohYiOCY2fmSD
 Jwxj9Qdi2FjWESQIOGpU4viCg9Plmqs+XTzqzlzFfQJFftQLNgyPcuyfzlySXKqvNBdJ
 XjAw==
X-Gm-Message-State: AOJu0YzK2gnrfChqDsn/3Ua1CKvfkbhbnyH07F4gtg6lZ54iR6l2BhyD
 rhvf4klLnpopn1d9gfSWVkVwOMza9runySQryiBIYIQ72UEhj5J1jbX9nXmg2zOXf6SZersqfU3
 RHbXuXgP5u6OuDGZBcGGOVviwZYRGubqm9iisLrp8rF0EVOEPVatK9+BA7A==
X-Gm-Gg: Acq92OHhsvfISHIe+wKyYcLXVKW3+aWUFPZRI0G/DacrcuUJJYD3pVCeVHd0p3rZG+H
 ZKGJdlF47BoJvFQw4pjP85+v4AIJdxsxFQXynRZKBRxh3nuA/4Aw58lUAt2u4fvZbRqlMTd3f9D
 hGVtypzqd239evFZfejV3ljcqaReapZGS+z31bqsxxWD2Nr+MwerjBalaWuqXe7QJj+VqDXTjqv
 QwlYaOuY61W1Z3uadcFD2AxQeLdejZqkMuk/8aHIpZEPZSf8nLFyqE79lpvGdAAD2v6gljm+yke
 og8+Qn5mrZAgMSqh9fx7JATLnVpcJIG+4uj3f9FBTlZNtNfn0YjM8nOpLPzt2uyvDTrXSGM4pOO
 oa6fYYmSQ2p70UZ7XwPyIP8i51fgQMAuSNHiZ3nr7yEL4YRTAuikbJNNUKom7SFYxxf5s
X-Received: by 2002:a05:6122:4b09:b0:575:39bc:c6d9 with SMTP id
 71dfb90a1353d-5ac82c9a633mr140164e0c.3.1780610432897; 
 Thu, 04 Jun 2026 15:00:32 -0700 (PDT)
X-Received: by 2002:a05:6122:4b09:b0:575:39bc:c6d9 with SMTP id
 71dfb90a1353d-5ac82c9a633mr140150e0c.3.1780610432400; 
 Thu, 04 Jun 2026 15:00:32 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a9752595a7sm3455217e0c.16.2026.06.04.15.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 15:00:31 -0700 (PDT)
Message-ID: <d0a19db7-17c6-4f2f-a9b0-262b33a6e108@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 19:00:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] docs: add riscv-server-ref.rst
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, leif.lindholm@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
 <20260604095244.3313259-6-daniel.barboza@oss.qualcomm.com>
 <6zbbuwhkns2v2nigvwsd2qpwp6pmtyayybrrar67xgma7tf5tk@gpif5wvll63p>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6zbbuwhkns2v2nigvwsd2qpwp6pmtyayybrrar67xgma7tf5tk@gpif5wvll63p>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lKWFJr37aoluVSNgIHTHHHBde77lsD89
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDIxNSBTYWx0ZWRfX/QaWPi8Sbk1w
 FEHndVfDFsCbBTIKgzpGeoX5y+2/SHncKnXPsGkt/Of317fkKz+7LyjrTR2RZlGLeORWV/HDC46
 g2iBvaNiDhfrs1W4J8ZZmtsjiEQ1rFPO5x8jntzGwdJ0v4s9hssrHdoDfM4t3LI6fZ7nakZJ9W3
 WHkFT91pc57bdaTRgC5WFbXeUiWHjfXlM3SNQ9okTWILMqBi5aymT40leGlOqEG8JWL1mCaX5YT
 QvAhh49WxuCF33n89+1n0n7Ri7EhIF3ukkmsY2p2wEDpb2XQOt09BIrj/m7AwCSUQ1JaX0qkKe7
 tESdjMIOspSDwZvPbcbE3qLlpWpo35mwxRy9EnI8L2J4QWlARSmHtWIuB4VKI3pOLH+CBafdX8X
 m+sAIP4oUiNwGrhkYwIh9Y5bwNA1KqfmJeQfawBe3iUCPkBPjHXjrEB1ghOmGBFoF79fHetXKD9
 Vy44E5NWgymCHzoaHMw==
X-Authority-Analysis: v=2.4 cv=JNULdcKb c=1 sm=1 tr=0 ts=6a21f582 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=zyDIbBgIJnxIjrKH1lMA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: lKWFJr37aoluVSNgIHTHHHBde77lsD89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040215
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



On 6/4/2026 4:00 PM, Andrew Jones wrote:
> On Thu, Jun 04, 2026 at 06:52:44AM -0300, Daniel Henrique Barboza wrote:
>> Add documentation for the new riscv-server-ref board.
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   docs/system/riscv/riscv-server-ref.rst | 52 ++++++++++++++++++++++++++
>>   docs/system/target-riscv.rst           |  1 +
>>   2 files changed, 53 insertions(+)
>>   create mode 100644 docs/system/riscv/riscv-server-ref.rst
>>
>> diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
>> new file mode 100644
>> index 0000000000..379b7ef76e
>> --- /dev/null
>> +++ b/docs/system/riscv/riscv-server-ref.rst
>> @@ -0,0 +1,52 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +RISC-V Server Platform Reference board (``riscv-server-ref``)
>> +=============================================================
>> +
>> +The RISC-V Server Platform specification `spec`_ defines a standardized
>> +set of hardware and software capabilities that portable system software,
>> +such as OS and hypervisors, can rely on being present in a RISC-V server
>> +platform.  This machine aims to emulate this specification, providing
>> +an environment for firmware/OS development and testing.
>> +
>> +`spec`_ is version 1.0 at the introduction of this board.  New spec versions
>> +might trigger a revision of the emulation itself, which will strive to always
>> +match the latest version available.  In case the emulation changes aren't
>> +backwards compatible we'll introduce a versioning scheme, probably via
> 
> Even in the case the changes are backwards compatible we'll introduce a
> versioning scheme. Because...
> 
>> +a machine property, to allow older SW to run with older spec versions.
> 
> ...we aren't as worried about older SW running on something than we are
> about new SW being tested on older machine models in order to allow OS
> developers to ensure changes to the OS to support newer spec versions
> don't regress support for older spec versions.
> 
> (And I think we're currently leaning towards a global property instead of
> a machine property in order to cover the cpu model too.)
> 
>> +
>> +The main features included in the riscv-server-ref board are:
>> +
>> +* IOMMU platform device (riscv-iommu-sys)
>> +* AIA
>> +* PCIe AHCI
>> +* PCIe NIC
>> +* No virtio mmio bus
>> +* No fw_cfg device
>> +* No ACPI table
>> +* Minimal device tree nodes
>> +
>> +There are multiple ways of using this reference board, some of them being:
>> +
>> +* BIOS: u-boot-spl.bin; SD-CARD: <disk_containing_FIT>; NVME: <distro_disk>
>> +* BIOS: fw_dynamic.bin; KERNEL: u-boot.bin; NVME: <distro_disk>
>> +* BIOS: fw_dynamic.bin; KERNEL: EDK2.fd; NVME: <distro_disk>
>> +* BIOS: fw_dynamic.bin; KERNEL: <linux_image>; INITRD: <busybox_initrd>
> 
> Maybe we need to point out that a firmware that generates ACPI tables and
> supports EFI runtime services is required for a completely spec conforming
> platform. I think that's only the 3rd bullet above.

Fair enough.  I'll remove bullets 1,2 and 4 and mention that we need a firmware
that generates ACPI tables and supports EFI.

> 
>> +
>> +Here's an usage example with a recent (June 2026) ``Image`` and ``rootfs.ext2``
>> +files from buildroot:
>> +
>> +.. code-block:: bash
>> +
>> + qemu-system-riscv64 -M riscv-server-ref \
>> +     -kernel ./buildroot/Image -append "rw rootwait root=/dev/vda" \
>> +     -drive file=./buildroot/rootfs.ext2,format=raw,id=hd0,if=virtio \
>> +     -nographic
> 
> This example does not generate a server platform that conforms to the spec
> since there are no ACPI tables and no EFI support for the OS/hypervisor.
> Also, how is the disk configured? It should be a PCIe device.


Since this is not the intended usage (bullet 3 from above) I'll remove this
example since it'll just confuse users.  We should document only the usage
that leads to a spec compliant setup.


Cheers,
Daniel

> 
> Thanks,
> drew
> 
> 
>> +
>> +The images QEMU is using for selftests of the riscv-server-ref machine can
>> +be found below:
>> +
>> +https://github.com/danielhb/qemu-machine-boot/tree/master/riscv/images/virt64/buildroot
>> +
>> +
>> +.. _spec: https://github.com/riscv-non-isa/riscv-server-platform
>> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
>> index afd86ca2ba..b2aeb39a8e 100644
>> --- a/docs/system/target-riscv.rst
>> +++ b/docs/system/target-riscv.rst
>> @@ -73,6 +73,7 @@ undocumented; you can get a complete list by running
>>      riscv/sifive_u
>>      riscv/virt
>>      riscv/xiangshan-kunminghu
>> +   riscv/riscv-server-ref
>>   
>>   RISC-V CPU firmware
>>   -------------------
>> -- 
>> 2.43.0
>>


