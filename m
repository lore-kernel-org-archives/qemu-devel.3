Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48964C98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xABkz-0004JQ-Re; Fri, 25 Sep 2026 15:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xABkw-0004HW-2M
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 15:38:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xABkt-0001oS-4E
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 15:38:49 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PIoqo22335976
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 19:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9oILPz+ZbtO/SVpKilKXfofExYHT/pJhV3tTC+KJ4R8=; b=pseWw5CXzLQGtnpg
 BdjbgnnxleEkhsW+WIYWhO+NWrTawe1uunBALSb6g1CgliIr/9tTsighKLuJezJ4
 g6WIOKIRG/vrpI+0/EvGyTH5nc+HTsn/B8iVMHIpb0PEBOkOQDgl8Qv2bOpxT7Mr
 bLJtkoW8lmOSN9CSdnCmHSeac7R84+Krk+rFfADVSEIPhRH9/RIZ0I65cyFqnQi/
 c6gtBWgaczvCLyJ1fJta9y2AQmey4rgFGmJl6Xb6WbUdlYXMkZXtX7SlTtZQosAJ
 N+WqzaJipyw3jDqTH4rXQJr/I6HaKCvnv8UiuM5KNLkK+WzAbMdousFDOu+XHsyh
 Q7gfbQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwvw1gkuv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 19:38:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9308eafb465so319415085a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790365124; x=1790969924; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9oILPz+ZbtO/SVpKilKXfofExYHT/pJhV3tTC+KJ4R8=;
 b=G7gp1UZ45KZlZxI3jJ6pLLqaNg6KoDVt1Hw4uJJOlew8Q4pBXEmmw2PsLSPAlhiDbv
 sZWtmKabqDf94i+4xZdNR/Gra+XrJ8SOvQkeXGSFBtRXDqOrQN4pdcvtmpMa6eIpNOA5
 cj4uuKJtT7/igEkxneCM3XtFK5CjCagp23SgXoWQ36dpABicGJoHNv4b2FjfQfLaIH2q
 haHeOaAFDx//IR0YVoiTbZKVwRQCpKJN/ETKKsoLmLhubNXdUf/rQG9AA2IalT5xTDrV
 yY8nT6t6eFQsglq7x8+pHNgD37GlwGHlZaodNNSzL9rvelSrRPjoL7oJ8/pc5Deje1ol
 plfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790365124; x=1790969924;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9oILPz+ZbtO/SVpKilKXfofExYHT/pJhV3tTC+KJ4R8=;
 b=zu2mYmjZe2nRFgwx9XeJsvLweFv2a7Cs8MHjkEpqAKVnqgqbBW7r1o42J/pp4oWH7W
 oTpsbp1hoPJZTYRtXilE5+OVtE5jD4mL9d96Gm/Pvm0Nu9zTAzYmFi/flc2VPrbBoc+Q
 CuDJPTKqCxyh5q6r56ogmNcbEUbeouW4TKaqhk0SfpUlrqx5VXxBggyEcavu4KjxdxBE
 TxzcR41vZDMfDhJJXFbJTeD+f9u0cWQNoYKgyOYbNDdOIVA46ubFKgS1iEGo4O5lbe+k
 JXCHHdhVEOx9DFsO0NcXOmj4WkP30VNEjYgaM9T3EjLKXD7DAYdrEZoFXIK2cgMU8UPp
 n3Jg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRUxYOyWesTx179PhaAFbUp0Dk+C98J8M1f3xkhuCMoCYQUdaHcZ49yB34h30MPYjTXNyONplUjcxC@nongnu.org
X-Gm-Message-State: AFuF++nGOxoC9do1/p3Ze7miUmkujT/2y3Acq54v7bfjXEJXCF0RLI6u
 eyi63q8yJqWfB20I4tCT9wqWPgLrYw0PUX0Rchvi+MSS43cXCkJ06OamA6hPIOG4gjuxmIlI9zb
 ZGYkEq1Erb8uAH719Rc0pAqsAqUGRsHOQWistr91oFArRP8YpRHJyi3otAw==
X-Gm-Gg: AYBFou18GtArmy2k6teLGx9bN+LVjAaGKXTZHP2abBDcMesBtGcVmdg3OLzetJJ1mYy
 1nivkVTg4YWhAi9UEX/1KnvL1e+cpD17cc/HkE641DwYrTB87QPbZm14//HhzVAG7sFbrAwxBKy
 6xrrMKD1Bzu4U72+qMeWVkC7SjFFHPrAcl0qiQfSInO8h8QCnAmZGxFuTVhCKpPpCtfCalaus8D
 D4oTQ9Ppit2Qatq3lMh7fB/heW7gG8qo7h6jWacOhsHAReKa6FkJo6hfTV2vPFMN8NuwfD92nPP
 pHdjegiuy6gQu65PK7kwA/NZzCa1eaYfSwlJ/aZPCpBlO2LiGPQCM9HafQ8ESLoFSgUm0j7zwet
 67c0oWzudd6FyiyIBUgGbTewKT5Ixq/XjDQ==
X-Received: by 2002:a05:620a:4809:b0:939:6dee:4b09 with SMTP id
 af79cd13be357-93c475129d8mr533563285a.51.1790365124119; 
 Fri, 25 Sep 2026 12:38:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4809:b0:939:6dee:4b09 with SMTP id
 af79cd13be357-93c475129d8mr533558985a.51.1790365123511; 
 Fri, 25 Sep 2026 12:38:43 -0700 (PDT)
Received: from [192.168.68.102] ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c44972febsm255429585a.39.2026.09.25.12.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 12:38:42 -0700 (PDT)
Message-ID: <797fa41f-4f74-4228-ac9e-26955b0b32d2@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 16:38:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: Use the host AIA MSI ID limit
To: Qingwei Hu <qingwei.hu@bytedance.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: sunilvl@ventanamicro.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, yongxuan.wang@sifive.com
References: <20260922122215.1619439-1-qingwei.hu@bytedance.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260922122215.1619439-1-qingwei.hu@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AgMStKb5ZWLat1fHnZFEkVtN-sLBxLnh
X-Authority-Analysis: v=2.4 cv=YqCa1IYX c=1 sm=1 tr=0 ts=6ab6cdc4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=968KyxNXAAAA:8 a=cbWReDcVF8Dxy-93n-YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: AgMStKb5ZWLat1fHnZFEkVtN-sLBxLnh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3OCBTYWx0ZWRfX6KwFlxTsaCBw
 OcbvdiSh7O5VJ10mkGh6uPtG4/7l4NUH/TMM7AdQ4emvvaUNGEWt26d2LxWD7GbeiigCk2G7BFO
 C02oHHWnWRSjQY1izUG2nYWb4NhLbVdU8ghmsrgVK9gwtapcO07E2EXn7vBZ7DXtpb8DCTTl8fq
 FoeN+uuOC+kE1DcHBir0TYttniCqo1xZ816RBxsiP4QVw4eIQHWTa3XDl7FyevDjg1pMae53lnx
 vHMvhb9EZfvM1v3ITZxk6R/YmpbsXuvcCEOBQ7qG6R0ZwkQcfGJmZz3S8hPm0qFiuWotPV2gxvR
 i35a5ioIqBbA5Wgzoi3hxbNRLQvOVhpJ+jCcEWxKYJBHPQw0aRNGWjGEC4CTYKnqqGxElu76ref
 4BsKrXt0eYf+UJsMd1/GzWu7AfNVgpaME9ZG5HObRUbaOg2NaQOUkD/+UlIkn9s6PShww7CsmaQ
 r/I69m9LQDyRwDNi4EA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3OCBTYWx0ZWRfX9/l3FjwSTHY7
 aZ2DVPX6TX9hewqgRCp5LZjoetm/1NzywfZX4QLY1NpqzQWL+Rzy9wKb9+sUxd4yuEr4oOPWtLI
 loxfhRtgv192iy48Mv52B9D7JsS67KI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hello,

If we try to build this patch in a non-KVM enviroment we'll have this error:

FAILED: libstubs_riscv.a.p/target_riscv_kvm_kvm-stub.c.o
cc -m64 -Ilibstubs_riscv.a.p -I. -I.. -I../common-user/host/x86_64 -I../linux-user/include/host/x86_64 -I../linux-user/include -Itarget/riscv -I../target/riscv -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O0 -g -mcx16 -msse2 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero 
-fzero-call-used-regs=used-gpr -fstack-protector-strong -Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-overflow=2 -Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=2 -Winit-self -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wredundant-decls -Wshadow=local -Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value -isystem 
/local/mnt/workspace/qemu/linux-headers -isystem linux-headers -iquote . -iquote /local/mnt/workspace/qemu -iquote /local/mnt/workspace/qemu/include -iquote /local/mnt/workspace/qemu/host/include/x86_64 -iquote /local/mnt/workspace/qemu/host/include/generic -iquote /local/mnt/workspace/qemu/tcg/x86_64 -pthread -fPIE -DCPU_DEFS_H -DCOMPILING_SYSTEM_VS_USER -DCONFIG_SOFTMMU -MD -MQ libstubs_riscv.a.p/target_riscv_kvm_kvm-stub.c.o -MF libstubs_riscv.a.p/target_riscv_kvm_kvm-stub.c.o.d -o 
libstubs_riscv.a.p/target_riscv_kvm_kvm-stub.c.o -c ../target/riscv/kvm/kvm-stub.c
../target/riscv/kvm/kvm-stub.c:12:6: error: conflicting types for ‘kvm_riscv_aia_create’; have ‘void(MachineState *, uint64_t,  uint64_t,  uint64_t,  uint64_t,  uint64_t,  uint64_t)’ {aka ‘void(MachineState *, long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)’}
    12 | void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
       |      ^~~~~~~~~~~~~~~~~~~~
In file included from ../target/riscv/kvm/kvm-stub.c:10:
/local/mnt/workspace/qemu/target/riscv/kvm/kvm_riscv.h:26:5: note: previous declaration of ‘kvm_riscv_aia_create’ with type
  int(uint64_t,  uint32_t *)’ {aka ‘int(long unsigned int,  unsigned int *)’}
    26 | int kvm_riscv_aia_create(uint64_t aia_irq_num, uint32_t *aia_msi_num);
       |     ^~~~~~~~~~~~~~~~~~~~
[1958/3154] Compiling C object libqemu-riscv64-softmmu.a.p/target_riscv_tcg_debug.c.o


The reason is, down there ...


On 9/22/2026 9:22 AM, Qingwei Hu wrote:
> KVM initializes CONFIG_IDS to the number of guest MSI IDs supported by
> the host. The virt machine currently overwrites it with the fixed
> VIRT_IRQCHIP_NUM_MSIS value of 255, which can be inconsistent with the
> host-supported guest MSI ID count.
> 
> Create the KVM AIA device before realizing the per-socket IMSICs and
> read the host-provided CONFIG_IDS value. Use it to configure the QEMU
> IMSIC devices and the guest-visible DT and ACPI descriptions. Complete
> the remaining KVM AIA setup after all vCPUs have been created, as the
> IMSIC address configuration depends on them.
> 
> Keep VIRT_IRQCHIP_NUM_MSIS as the default for non-KVM machines.
> 
> Fixes: 9634ef7eda5f ("target/riscv: Create an KVM AIA irqchip")
> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
> ---
>   hw/riscv/virt-acpi-build.c   |  4 +--
>   hw/riscv/virt.c              | 28 ++++++++++++-----
>   include/hw/riscv/virt.h      |  1 +
>   target/riscv/kvm/kvm-cpu.c   | 59 +++++++++++++++++++++++-------------
>   target/riscv/kvm/kvm_riscv.h |  9 +++---
>   5 files changed, 66 insertions(+), 35 deletions(-)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 8e516ec114..0ebfa10a02 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -576,9 +576,9 @@ static void build_madt(GArray *table_data,
>           build_append_int_noprefix(table_data, 0, 1);        /* Reserved */
>           build_append_int_noprefix(table_data, 0, 4);        /* Flags */
>           /* Number of supervisor mode Interrupt Identities */
> -        build_append_int_noprefix(table_data, VIRT_IRQCHIP_NUM_MSIS, 2);
> +        build_append_int_noprefix(table_data, s->num_msis, 2);
>           /* Number of guest mode Interrupt Identities */
> -        build_append_int_noprefix(table_data, VIRT_IRQCHIP_NUM_MSIS, 2);
> +        build_append_int_noprefix(table_data, s->num_msis, 2);
>           /* Guest Index Bits */
>           build_append_int_noprefix(table_data, guest_index_bits, 1);
>           /* Hart Index Bits */
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d4b501802f..ba0e74ce83 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -277,7 +277,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
>               .imsic_m_base = !kvm_enabled() ? s->memmap[VIRT_IMSIC_M].base : 0,
>               .imsic_s_base = s->memmap[VIRT_IMSIC_S].base,
>               .imsic_group_max_size = VIRT_IMSIC_GROUP_MAX_SIZE,
> -            .irqchip_num_msis = VIRT_IRQCHIP_NUM_MSIS,
> +            .irqchip_num_msis = s->num_msis,
>               .aia_guests = s->aia_guests
>           };
>   
> @@ -718,6 +718,7 @@ static void virt_machine_init(MachineState *machine)
>       DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
>       int i, base_hartid, hart_count;
>       int socket_count = riscv_socket_count(machine);
> +    int aia_fd = -1;
>   
>       s->memmap = virt_memmap;
>   
> @@ -733,6 +734,16 @@ static void virt_machine_init(MachineState *machine)
>           exit(1);
>       }
>   
> +    /*
> +     * Create the KVM AIA device and query the host MSI ID count before
> +     * realizing the per-socket IMSICs. Complete AIA initialization after
> +     * all vCPUs have been created.
> +     */
> +    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
> +        aia_fd = kvm_riscv_aia_create(VIRT_IRQCHIP_NUM_SOURCES,
> +                                      &s->num_msis);
> +    }
> +
>       /* Initialize sockets */
>       mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
>       for (i = 0; i < socket_count; i++) {
> @@ -826,7 +837,7 @@ static void virt_machine_init(MachineState *machine)
>                                                &s->memmap[VIRT_IMSIC_M],
>                                                &s->memmap[VIRT_IMSIC_S],
>                                                i, base_hartid, hart_count,
> -                                             VIRT_IRQCHIP_NUM_MSIS,
> +                                             s->num_msis,
>                                                VIRT_IRQCHIP_NUM_PRIO_BITS);
>           }
>   
> @@ -845,12 +856,12 @@ static void virt_machine_init(MachineState *machine)
>           }
>       }
>   
> -    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
> -        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
> -                             VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
> -                             s->memmap[VIRT_APLIC_S].base,
> -                             s->memmap[VIRT_IMSIC_S].base,
> -                             s->aia_guests);

This call of kvm_riscv_aia_create(), even when guarded with a kvm_enabled(), needs to be
visible to the compiler in a TCG only build.  We have a kvm-stub.c file that declares it
like so:

void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
                           uint64_t aplic_base, uint64_t imsic_base,
                           uint64_t guest_num)
{
     g_assert_not_reached();
}

Thus changing kvm_riscv_aia_create() requires a change in its kvm-stub as well.

> +    if (aia_fd >= 0) {
> +        kvm_riscv_aia_init(machine, aia_fd, IMSIC_MMIO_GROUP_MIN_SHIFT,
> +                           VIRT_IRQCHIP_NUM_SOURCES,
> +                           s->memmap[VIRT_APLIC_S].base,
> +                           s->memmap[VIRT_IMSIC_S].base,
> +                           s->aia_guests);
>       }

And a similar thing is needed here for kvm_riscv_aia_init(). We need a kvm-stub entry and it
needs to be guarded with kvm_enabled() as well.

We need something like this diff:

$ git diff
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ba0e74ce83..4df8d7d441 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -856,7 +856,7 @@ static void virt_machine_init(MachineState *machine)
          }
      }

-    if (aia_fd >= 0) {
+    if (kvm_enabled() && aia_fd >= 0) {
          kvm_riscv_aia_init(machine, aia_fd, IMSIC_MMIO_GROUP_MIN_SHIFT,
                             VIRT_IRQCHIP_NUM_SOURCES,
                             s->memmap[VIRT_APLIC_S].base,
diff --git a/target/riscv/kvm/kvm-stub.c b/target/riscv/kvm/kvm-stub.c
index 64e39c96d8..b7e6504f5f 100644
--- a/target/riscv/kvm/kvm-stub.c
+++ b/target/riscv/kvm/kvm-stub.c
@@ -9,10 +9,15 @@
  #include "qemu/osdep.h"
  #include "target/riscv/kvm/kvm_riscv.h"

-void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
-                          uint64_t aia_irq_num, uint64_t aia_msi_num,
-                          uint64_t aplic_base, uint64_t imsic_base,
-                          uint64_t guest_num)
+int kvm_riscv_aia_create(uint64_t aia_irq_num, uint32_t *aia_msi_num)
+{
+    g_assert_not_reached();
+}
+
+void kvm_riscv_aia_init(MachineState *machine, int aia_fd,
+                        uint64_t group_shift, uint64_t aia_irq_num,
+                        uint64_t aplic_base, uint64_t imsic_base,
+                        uint64_t guest_num)
  {
      g_assert_not_reached();
  }


Code LGTM otherwise.  Booted a KVM aia guest and play with it a little bit
without any hicups.


Thanks,
Daniel
  >
>       if (riscv_is_32bit(&s->soc[0])) {
> @@ -972,6 +983,7 @@ static void virt_machine_instance_init(Object *obj)
>       s->acpi = ON_OFF_AUTO_AUTO;
>       s->iommu_sys = ON_OFF_AUTO_AUTO;
>       s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
> +    s->num_msis = VIRT_IRQCHIP_NUM_MSIS;
>   }
>   
>   static char *virt_get_aia_guests(Object *obj, Error **errp)
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index e516898f9a..f64a2a3448 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -66,6 +66,7 @@ struct RISCVVirtState {
>       OnOffAuto iommu_sys;
>       uint16_t pci_iommu_bdf;
>       uint16_t num_sources;
> +    uint32_t num_msis;
>   };
>   
>   enum {
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 68e1501b21..02af4e7723 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1859,19 +1859,11 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>                                       "auto");
>   }
>   
> -void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
> -                          uint64_t aia_irq_num, uint64_t aia_msi_num,
> -                          uint64_t aplic_base, uint64_t imsic_base,
> -                          uint64_t guest_num)
> +int kvm_riscv_aia_create(uint64_t aia_irq_num, uint32_t *aia_msi_num)
>   {
> -    int ret, i;
> -    int aia_fd = -1;
> +    int ret;
> +    int aia_fd;
>       uint64_t default_aia_mode;
> -    uint64_t socket_count = riscv_socket_count(machine);
> -    uint64_t max_hart_per_socket = 0;
> -    uint64_t socket, base_hart, hart_count, socket_imsic_base, imsic_addr;
> -    uint64_t socket_bits, hart_bits, guest_bits;
> -    uint64_t max_group_id;
>   
>       aia_fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_RISCV_AIA, false);
>   
> @@ -1903,6 +1895,41 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>           }
>       }
>   
> +    /*
> +     * Get the maximum MSI ID supported by the host from the CONFIG_IDS
> +     * attribute and use it for the guest-visible interrupt controller
> +     * configuration.
> +     */
> +    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> +                            KVM_DEV_RISCV_AIA_CONFIG_IDS,
> +                            aia_msi_num, false, NULL);
> +    if (ret < 0) {
> +        error_report("KVM AIA: failed to get number of MSI IDs");
> +        exit(1);
> +    }
> +
> +    if (!kvm_kernel_irqchip_split() && *aia_msi_num < aia_irq_num) {
> +        error_report("KVM AIA: host supports only %" PRIu32 " MSI IDs, "
> +                     "but the virt machine requires at least %" PRIu64,
> +                     *aia_msi_num, aia_irq_num);
> +        exit(1);
> +    }
> +
> +    return aia_fd;
> +}
> +
> +void kvm_riscv_aia_init(MachineState *machine, int aia_fd,
> +                        uint64_t group_shift, uint64_t aia_irq_num,
> +                        uint64_t aplic_base, uint64_t imsic_base,
> +                        uint64_t guest_num)
> +{
> +    int ret, i;
> +    uint64_t socket_count = riscv_socket_count(machine);
> +    uint64_t max_hart_per_socket = 0;
> +    uint64_t socket, base_hart, hart_count, socket_imsic_base, imsic_addr;
> +    uint64_t socket_bits, hart_bits, guest_bits;
> +    uint64_t max_group_id;
> +
>       /*
>        * Skip APLIC creation in KVM if we're running split mode.
>        * This is done by leaving KVM_DEV_RISCV_AIA_CONFIG_SRCS
> @@ -1927,15 +1954,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>           }
>        }
>   
> -    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> -                            KVM_DEV_RISCV_AIA_CONFIG_IDS,
> -                            &aia_msi_num, true, NULL);
> -    if (ret < 0) {
> -        error_report("KVM AIA: failed to set number of msi");
> -        exit(1);
> -    }
> -
> -
>       if (socket_count > 1) {
>           max_group_id = socket_count - 1;
>           socket_bits = find_last_bit(&max_group_id, BITS_PER_LONG) + 1;
> @@ -1987,7 +2005,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>           }
>       }
>   
> -
>       if (max_hart_per_socket > 1) {
>           max_hart_per_socket--;
>           hart_bits = find_last_bit(&max_hart_per_socket, BITS_PER_LONG) + 1;
> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
> index 61eaa12443..1499fb4487 100644
> --- a/target/riscv/kvm/kvm_riscv.h
> +++ b/target/riscv/kvm/kvm_riscv.h
> @@ -23,10 +23,11 @@
>   
>   void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>   void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
> -void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
> -                          uint64_t aia_irq_num, uint64_t aia_msi_num,
> -                          uint64_t aplic_base, uint64_t imsic_base,
> -                          uint64_t guest_num);
> +int kvm_riscv_aia_create(uint64_t aia_irq_num, uint32_t *aia_msi_num);
> +void kvm_riscv_aia_init(MachineState *machine, int aia_fd,
> +                        uint64_t group_shift, uint64_t aia_irq_num,
> +                        uint64_t aplic_base, uint64_t imsic_base,
> +                        uint64_t guest_num);
>   void riscv_kvm_aplic_request(void *opaque, int irq, int level);
>   bool kvm_riscv_has_mp_state(void);
>   void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);


