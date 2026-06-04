Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B448CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVDfp-0002Uq-1L; Thu, 04 Jun 2026 15:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wVDfm-0002UH-RW
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 15:24:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wVDfk-00014t-Vq
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 15:24:10 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654EpcuM528695
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 19:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=qzz4r/EFTIdWX1UKkGUhBasn
 SkM1hMYGIZSvT9DEkFo=; b=RKEOofC+Qx7sIZki/tFFMB1DlecvMgrWElJ8sODH
 YdLrPoJbDMgu7jx5Z1M3he0L+MbEt6EOXS4OxLKmVkOjlXv5yldf0JzXYukHTDng
 L9zQNlYoyZFMOCKPv8QPTcvtnQN1EMlF4gVTRsn0xT/lq226YQmNII4ZWT/aPCKA
 OIqzoLDJywHrUKGJjG6GYv6zQWReEcVXyeV4J3pi8tyDDFj3OD5iODcwvYr7a7nE
 ykFdcZwnfHFtR3NwrggAFvEOVlF5QQb9FLrvTGAp6p1lJ/kMFiU4esYXaynJkl8T
 7gO+zYkA1wdBFnLJii9qHBT0P9DF/5p7sRFLqfdm7b+EuQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekbgdsbn1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 19:24:06 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304d0d0b28eso2934249eec.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 12:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780601046; x=1781205846; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qzz4r/EFTIdWX1UKkGUhBasnSkM1hMYGIZSvT9DEkFo=;
 b=Tl2WaBt4iTD1YSjZ/0xR0u3Th3/0+gBZRGoil8eW+G1BwZ0qyLw7JQ2Ry0Iyk+WU01
 HY+Zbo/2Lb0JqrbaRueTaDNQvhX8FD3q1953uqCF5IlF024DUyhO8MRFuichzuBrV7up
 +oFRbwGuRRoqvVBebHYPpPoXTP5q4KWbVCkA0wQbprYZrMtZdnFOP4mGalkR3EqaiBD4
 Jw1JcU4T8UERhhMjO8DZVZ3i4dBkWHPNX3/9eS9+Pyfkkp+jpP6Rdh7uEnI16oHzauMC
 D/+G61Zdi7RDXTfeXtDBbBxiXAipRNZshcvH+QV6/Ad/EDRlkxrK3RxOO0cGXoKH5qYx
 j+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780601046; x=1781205846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qzz4r/EFTIdWX1UKkGUhBasnSkM1hMYGIZSvT9DEkFo=;
 b=p+yJ8hDLcfnqs02T7PqMANBz5HhRt8AiufQb0xm2lzLj3I+w1KWjfa1aahEl5cePGy
 PCa/hBRcO9IISOXQg2XkfLM/J0qqjKBymt1pA6lS51N5+AKAWpId573rEKb9Xr3roMl9
 KTFWv6dxvZU/A9K64azoNNZXi784QrZtun8myQ8O2FiSBc7Muj1SAhVY/7yawJ4EulFv
 tfPqx/Lfddx377r7NmtvRUZ7a9LDC8gEYNvJ2fD4JQsEEGubM3LYhkxc0aY9R3h0XITL
 2zNsfCVsosOVRLtQcD7rn1/JaDnzP4S57K2+gJNcvp5N8Y/X2S/MrLv23qFHhvbisXdH
 /JRg==
X-Gm-Message-State: AOJu0YzDf+J8sF2690ZqdGAjw/AAn86I3uXnKmHajnTjDE+0vsbC+w8I
 HyNGf0+4/7NEBtC44KLhufd2lGEhrqaux1ZLKDFiv6VkGIRw3GpChJsdHaCyxeVMt0HcbUtei1h
 0F/FWf7cZDDffbBLBQOZ3qQ1k9nqVTgWHjWpm89G5ONJFbU0Bjrm1FGMPHQ==
X-Gm-Gg: Acq92OHWE5rmb2A7+j+44WNKUJ9D+dkDU+GPRhtnEWv420I2iPVPsoPIHHTG807Il53
 rUyqBFSER6mPdm+XPIjNVlUsqvil9HM3HHgyR2WnLXDmwV7/4W0BEDaaEUQ0UpL4dikjsL0Wb9z
 yvJfZwSBdXakuBY8+qrpHLY6liF/uGnZ+Ijbw0KgHzrkarewPGwuuySiXawzcntI4S0kmTT8yOQ
 /Rnx/N1nTQpNSqGMj+WfpieMa4+bHBt054hTevhSTca1OGc9vfnioJRJEB+6uUr3L2T4m6fteSv
 KXyjVnvdj013IGPpbPURmDFCE7xF5SwAQ6I90Dj5HfQlsDR0Td3EglBuqxT3pOwSAODXeAFh3Gx
 aw8hEBeccPbxZs35Vx/WkBWPfTJ0N0OoD8jIqKOc3sg==
X-Received: by 2002:a05:7301:1010:b0:304:c651:bdfe with SMTP id
 5a478bee46e88-3077b753011mr62554eec.17.1780601045706; 
 Thu, 04 Jun 2026 12:24:05 -0700 (PDT)
X-Received: by 2002:a05:7301:1010:b0:304:c651:bdfe with SMTP id
 5a478bee46e88-3077b753011mr62535eec.17.1780601045221; 
 Thu, 04 Jun 2026 12:24:05 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df64eb9sm5015169eec.25.2026.06.04.12.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 12:24:04 -0700 (PDT)
Date: Thu, 4 Jun 2026 14:24:03 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, leif.lindholm@oss.qualcomm.com,
 Fei Wu <wu.fei9@sanechips.com.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v7 3/5] hw/riscv: server platform reference machine
Message-ID: <p46rd353bkxsqgialnjgzqe5tdmb4wsd7qork7p5zqcfjywdpn@afedujp76ee2>
References: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
 <20260604095244.3313259-4-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604095244.3313259-4-daniel.barboza@oss.qualcomm.com>
X-Proofpoint-GUID: 2NYRMqJ_LDcSBNofW6T3S73hrmQfuTl1
X-Proofpoint-ORIG-GUID: 2NYRMqJ_LDcSBNofW6T3S73hrmQfuTl1
X-Authority-Analysis: v=2.4 cv=a8cAM0SF c=1 sm=1 tr=0 ts=6a21d0d6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=uTRCLKPYAAAA:8 a=EUspDBNiAAAA:8 a=cTH1XDAxZFsYCEz_BOgA:9
 a=CjuIK1q_8ugA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=T-agBWn15iSmxapsA1lH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE5MCBTYWx0ZWRfX23tzpR+lsNNd
 AkG+zyVSC0HhvQwxWcAjBQO76UEc+y9AgiUty/PBmHUxIjA25k38XFoCpfggykWemvGE6QRU0cG
 8hXDAKVjrDBMNbedXxtmGKdoUDCmyu4gHv90H/54aiH+p4rRTGvlz4RVqrfFxirObkStLfU4rkV
 TjA0p8f48jHjl+9YkeHKAKWQvAModjjfjtydL8B5w7pHfWsWxJVIb181ONbrSQtdJDX2bEKYIll
 +Se2K189Q8MMfu6ICTBbphMtwPCJLHB2RpSvY3hEOnwGxzX54P7MZlRyFr+ltZR93I79r0qzQnp
 QZY0Bi58aXT2RjdSNnEdII74s55KvnhSe9wo99UFuODuyphfNetuTdiBTBuxgFfLfSFt9oAzMTh
 2NYql0uEo42BPYoVfvlbiB02UlgGLTN2ix/L/mV7OQ6YeRivCkHmGKc3YqaTbOELp+/hmixi7qU
 1aXbgJ76h7xs6rzBi4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040190
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Thu, Jun 04, 2026 at 06:52:42AM -0300, Daniel Henrique Barboza wrote:
> From: Fei Wu <wu.fei9@sanechips.com.cn>
> 
> The RISC-V Server Platform specification [1] defines a standardized set
> of hardware and software capabilities, that portable system software,
> such as OS and hypervisors can rely on being present in a RISC-V server
> platform.
> 
> The main features included in this emulation are:
> 
> - Based on riscv virt machine type;
> - A new memory map as close as virt machine as possible;
> - An always present IOMMU platform device (riscv-iommu-sys) that uses
>   IRQs 36 to 39, one IRQ for queue, similar to the 'virt' board;
> - AIA;
> - PCIe AHCI;
> - PCIe NIC;
> - No virtio device;

s/No virtio device/No Virtio MMIO transports/

Virtio devices, when plugged into PCIe slots, are fine. The spec doesn't
care about that and it's even possible to make real hardware that conforms
to the Virtio spec.

> - No fw_cfg device;
> - No ACPI table provided;

Maybe point out the reason there's no ACPI tables, even though the spec
mandates the use of ACPI, is because it is expected that the firmware
generate those tables.

> - Only minimal device tree nodes.
> 
> [1] https://github.com/riscv-non-isa/riscv-server-platform
> 
> Signed-off-by: Fei Wu <wu.fei9@sanechips.com.cn>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>  configs/devices/riscv64-softmmu/default.mak |    1 +
>  hw/riscv/Kconfig                            |   15 +
>  hw/riscv/meson.build                        |    1 +
>  hw/riscv/server_platform_ref.c              | 1373 +++++++++++++++++++
>  4 files changed, 1390 insertions(+)
>  create mode 100644 hw/riscv/server_platform_ref.c
> 
...
> +static void rvserver_ref_machine_class_init(ObjectClass *oc, const void *data)
> +{
> +    char str[128];
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    static const char * const valid_cpu_types[] = {
> +        TYPE_RISCV_CPU_RVSERVER_REF,
> +    };
> +
> +    mc->desc = "RISC-V Server SoC Reference board";

Is 'SoC' the right thing to call this? We're aiming to model the whole
specified server platform, not just the server soc (which has its own
spec). I also suggest adding 'v1.0' to the description. Do CPU models
have descriptions? If so, then 'v1.0' there would be good too.

> +    mc->init = rvserver_ref_machine_init;
> +    mc->max_cpus = RVSERVER_CPUS_MAX;
> +    mc->default_cpu_type = TYPE_RISCV_CPU_RVSERVER_REF;
> +    mc->valid_cpu_types = valid_cpu_types;
> +    mc->pci_allow_0_address = true;
> +    mc->default_nic = "e1000e";

virtio-net-pci would probably be fine. See my comment about virtio devices
above.

Thanks,
drew

