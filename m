Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE50606D801
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FNYdsNBD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kV7GgkIT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOCwK-0001gc-4w; Tue, 03 Nov 2026 06:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xOCwG-0001aq-If
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:44:28 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xOCwD-0007xh-3B
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:44:26 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3AAGgU2522040
 for <qemu-devel@nongnu.org>; Tue, 3 Nov 2026 11:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7oE7C9ea9MrvsIL7+8hO+dWJZKcgpjTcemHywl36nIo=; b=FNYdsNBDqGkBNxcs
 T4LoJj6uHW1aDZdrtNmVJ/GcjtWJQsT4b+VVnFjMg58cTl+VpTfTwZ7epaIuYJx2
 A7qgc1rCJUzHNwhALIypZ7s89t1aId7v/btj+lLQLc2w3vrHqZoYKFQv0mr3J3t1
 ny/Nk7Oy6zvuhTbA3Azam0cMgBpdZZQKbEuNHmmSX3eXAM0tVsBOJuJnj6DDQrHy
 T7typs2aA/rto6mBYU8Yyn5SHN3d9ZpSiEsnCDDAtgBSWTPE/F3tYv/GYd6f1bNN
 GAIECZONOMa8WBbWMRWosn3kjC4GXed8y5jVdHYVDQmqzr9V5SA2Ij/dsCZQNwYI
 QdKVfA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq4v5jfgv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 11:44:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ce7a85f04so803859885a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793706263; x=1794311063; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7oE7C9ea9MrvsIL7+8hO+dWJZKcgpjTcemHywl36nIo=;
 b=kV7GgkITk/iwlsd8Xhb7j7q/FQEC6xienQYKYuZmTetpKW6+NvIygbeCyY5RiU24c7
 i34bdul4vKO1nuk4k6XkjlvTAoOaka16lXvxGcllcou6APlUtlq+ASbkHgwIXIfkeGDB
 dRU/zoKsYsYv5HSTFg5z6e/iA5KDoLcf/TuJoAXM3Cby4PtdSGcOWr4ZI6B7CCyZ3Oty
 S70qorlPCaZXnewqMgTKtVNgUYw/Dgjb/beJESFEZtMonIvXD9nj++WhmvyHUG+fMLTk
 lL6+aApMTv13T72z15EEJpqdP+vbscQlTPvg6fNUXrgU3kqFM32Ywk8U3CcnRTDCTaag
 45Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706263; x=1794311063;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7oE7C9ea9MrvsIL7+8hO+dWJZKcgpjTcemHywl36nIo=;
 b=qJs4XxXEclkfD6MVKTz7N69ZmdMKAeLscxP6eER0tI4+fAHCik4CR3Bfrs+ZA737HE
 lS8J0D7f7McG296Q+Kms6dOr15ToyNSNap9CSmHQMSpxxf8XHIQCA+iKwei87oGqAs+/
 kZRB6v6moa8yITMcVP1kU7a1Nb8nqU+WzE8B0Ojzb7ebEc7eXlM01sZfwhSwaAgc2dl3
 vMdv05466wA5fCFzpRcN5+RvBHuveXKe1Upopnp/Usvxbejr9p2WWwA1uu+FzT84T88k
 aPIk781vF9BIohcGy81EkufC3mmps5FDG6j+Lu0rt7s0v6OjrLTT4Wizd1X/dk9KQa5O
 QEKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8XGCxi9YKBegDAJp7hfao0yb7jDlvkpdmgEecZ0MjZjDnq1NJCUL7khpWR3NZaX2Kvey1c8oYaozn@nongnu.org
X-Gm-Message-State: APuU4Z/ceJZwDVoczdsjZ6O2ESCD94visOM5l1xVa9XnE3rUFstm0LfB
 h1FH4sPsL+nj0gbWvVupySkHolKUuK5uDJdhn12ur5Mi99aYq+TMu3HMaEOK+iySnNVn6dbGOep
 05fpMCcsNrCohQ1ntC6xdSjasfgXqlspfrSR1YZx34PTwO/pRUhyGeojeDw==
X-Gm-Gg: AYBFou0PsZe73KFWD13R/hs8lKaP+NqHNpj0UqB7Bg77/8rQ0IcJy+395sJWXpi5PF8
 wCB5MpvyCIvIWRxqx5Ua5b25FxWov4yO9Yc+nW2OFkE3g4zgVFC6SUlrzcT2h3OozendH7KIx+t
 L0k2TnF67CdJFRbxY/YeXnVej0lttp7NlyGbGHkZIlVbBFEK5oLQsyn1gOu2E0sOUNJ5gyVQkvM
 cKBpyd0WDYI0vWPRqqK4A3dZ0cjKRtPUHv3XdicPu9LyT7twWnEBnyBBnQwXIPYmwdaZyL8qM6t
 +tCk9KqaDN1mgnKfb55tmVRpuOsOL7pn7HlijkkEe3jS08kHMRNbVwg6vUm0LPgtUVIcfWpWC/f
 xCDLLcyVU39b6S/Ly1yndeN/71YQf1NpmlHaZ7BODR8of14SVQiIlHk94yNahA6slvGj+nOpsxV
 En8iwPqg==
X-Received: by 2002:a05:620a:480b:b0:93e:5fff:db07 with SMTP id
 af79cd13be357-9442175c1bemr2169317385a.40.1793706262680; 
 Tue, 03 Nov 2026 03:44:22 -0800 (PST)
X-Received: by 2002:a05:620a:480b:b0:93e:5fff:db07 with SMTP id
 af79cd13be357-9442175c1bemr2169313985a.40.1793706262281; 
 Tue, 03 Nov 2026 03:44:22 -0800 (PST)
Received: from [192.168.15.12] ([187.56.223.122])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94425a6b9b4sm1066774885a.26.2026.11.03.03.44.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 03:44:21 -0800 (PST)
Message-ID: <0c7318f7-5daf-4a8a-8a28-ba1d4cb27c62@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 08:44:17 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/riscv: Pass socket topology to KVM AIA
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
 <20261101031547.125591-5-tanchi25@mails.ucas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261101031547.125591-5-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Bh7vVpP9ZvimYLeuhlFlkakDPwU7Vn69
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NiBTYWx0ZWRfXwOOMPR/Oa9se
 WdzQSe7kkVahs+1TOVXU2T6wGbBge4jnen9numfwkOTFhIpse8VXvnSZLUqk8pBxJcFv7PU9mvp
 cFE44Kh6Ls/IaudkSc0CEkCnsPb4Pz1cFS2/mKDMxbBgUheSB9HdXgqZQnskNYYwNlV50izIGm7
 cG3sbwnyeq5Usgi0mGWyvAhz93wn214xlyuTIoEQiFtsQ0ZCd7GOTEwwNtRaih/uyBvChTYNb1l
 9t9FEHgW6bBj7G4Iq6G3zPXZMP1vr6ZHRTFKFIjDuRG0+NAm0sIY/u/JfwamMuzfbZ9J4u18CU/
 RaXgBPySciXZSz7edjwZbevg6fWLKz88hz6SMUyXz9nmKxq24L0G606ICixgJEbPsaUJScIUOhF
 yHBOybLkbAD9bU7A9mJ57ty7kGUfqMrmrUe13qBcQTTNfpfZsd2bm5b0pRAj/JSU+4MHD+oJxve
 0KKvZUnplUNbDeuuO+w==
X-Proofpoint-GUID: Bh7vVpP9ZvimYLeuhlFlkakDPwU7Vn69
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NiBTYWx0ZWRfX2sMUgLg4y7rA
 kjdy5CxEF0JNfmvSL8lnyvfC6+7wbu+PCfoA0t0WOPprwEZqLTxQSaSMShb9SuXmf/ozatSp9Pp
 FQ1n6mPmAOyjqKiqluOLaS29q5vPwI4=
X-Authority-Analysis: v=2.4 cv=NeZzRGD4 c=1 sm=1 tr=0 ts=6ae9c917 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=bus90iwuyia7r0C3gDGjVg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KZXVDKXym9UjMoJUBKgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030046
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/1/2026 12:15 AM, Tan Chi wrote:
> KVM AIA initialization uses the RISC-V NUMA helpers to query
> the socket count and per-socket hart topology.
> 
> However, KVM support can be enabled without CONFIG_RISCV_NUMA.
> In this configuration, kvm-cpu.c is built while numa.c is not,
> resulting in undefined references to riscv_socket_count(),
> riscv_socket_hart_count() and riscv_socket_first_hartid().
> 
> The virt machine already determines the hart topology when
> initializing its hart arrays. Pass the socket topology directly
> to KVM AIA instead of querying the NUMA helpers again.
> 
> This removes the build-time dependency on CONFIG_RISCV_NUMA
> without changing the IMSIC address configuration.
> 
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/aia.h               |  5 +++++
>   hw/riscv/virt.c              | 10 +++++++++-
>   target/riscv/kvm/kvm-cpu.c   | 10 +++++-----
>   target/riscv/kvm/kvm-stub.c  |  3 ++-
>   target/riscv/kvm/kvm_riscv.h |  5 ++++-
>   5 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
> index e4dcc5aae0..ed9b613f3c 100644
> --- a/hw/riscv/aia.h
> +++ b/hw/riscv/aia.h
> @@ -12,6 +12,11 @@
>   #include "exec/hwaddr.h"
>   #include "qemu/bitops.h"
>   
> +typedef struct RISCVAIASocket {
> +    uint32_t hartid_base;
> +    uint32_t num_harts;
> +} RISCVAIASocket;
> +
>   static inline uint32_t imsic_num_bits(uint32_t count)
>   {
>       uint32_t ret = 0;
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 7ec7596b24..f1b1353647 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -853,7 +853,15 @@ static void virt_machine_init(MachineState *machine)
>       }
>   
>       if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
> -        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
> +        g_autofree RISCVAIASocket *aia_sockets =
> +                g_new(RISCVAIASocket, socket_count);
> +        for (i = 0; i < socket_count; i++) {
> +            aia_sockets[i].hartid_base = s->soc[i].hartid_base;
> +            aia_sockets[i].num_harts = s->soc[i].num_harts;
> +        }
> +
> +        kvm_riscv_aia_create(aia_sockets, socket_count,
> +                             IMSIC_MMIO_GROUP_MIN_SHIFT,
>                                VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
>                                s->memmap[VIRT_APLIC_S].base,
>                                s->memmap[VIRT_IMSIC_S].base,
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 45ad5e1525..1a74b9a37e 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -46,7 +46,7 @@
>   #include "sbi_ecall_interface.h"
>   #include "chardev/char-fe.h"
>   #include "system/runstate.h"
> -#include "hw/riscv/numa.h"
> +#include "hw/riscv/aia.h"
>   
>   #define PR_RISCV_V_SET_CONTROL            69
>   #define PR_RISCV_V_VSTATE_CTRL_ON          2
> @@ -1897,7 +1897,8 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>                                       "auto");
>   }
>   
> -void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
> +void kvm_riscv_aia_create(const RISCVAIASocket *sockets,
> +                          uint32_t socket_count, uint64_t group_shift,
>                             uint64_t aia_irq_num, uint64_t aia_msi_num,
>                             uint64_t aplic_base, uint64_t imsic_base,
>                             uint64_t guest_num)
> @@ -1905,7 +1906,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>       int ret, i;
>       int aia_fd = -1;
>       uint64_t default_aia_mode;
> -    uint64_t socket_count = riscv_socket_count(machine);
>       uint64_t max_hart_per_socket = 0;
>       uint64_t socket, base_hart, hart_count, socket_imsic_base, imsic_addr;
>       uint64_t socket_bits, hart_bits, guest_bits;
> @@ -2006,8 +2006,8 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>   
>       for (socket = 0; socket < socket_count; socket++) {
>           socket_imsic_base = imsic_base + socket * (1U << group_shift);
> -        hart_count = riscv_socket_hart_count(machine, socket);
> -        base_hart = riscv_socket_first_hartid(machine, socket);
> +        hart_count = sockets[socket].num_harts;
> +        base_hart = sockets[socket].hartid_base;
>   
>           if (max_hart_per_socket < hart_count) {
>               max_hart_per_socket = hart_count;
> diff --git a/target/riscv/kvm/kvm-stub.c b/target/riscv/kvm/kvm-stub.c
> index 64e39c96d8..f929161628 100644
> --- a/target/riscv/kvm/kvm-stub.c
> +++ b/target/riscv/kvm/kvm-stub.c
> @@ -9,7 +9,8 @@
>   #include "qemu/osdep.h"
>   #include "target/riscv/kvm/kvm_riscv.h"
>   
> -void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
> +void kvm_riscv_aia_create(const RISCVAIASocket *sockets,
> +                          uint32_t socket_count, uint64_t group_shift,
>                             uint64_t aia_irq_num, uint64_t aia_msi_num,
>                             uint64_t aplic_base, uint64_t imsic_base,
>                             uint64_t guest_num)
> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
> index aef681f0a2..bad78e28f4 100644
> --- a/target/riscv/kvm/kvm_riscv.h
> +++ b/target/riscv/kvm/kvm_riscv.h
> @@ -21,6 +21,8 @@
>   
>   #include "target/riscv/cpu-qom.h"
>   
> +typedef struct RISCVAIASocket RISCVAIASocket;
> +
>   void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>   /**
>    * kvm_riscv_set_irq:
> @@ -29,7 +31,8 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>    * @level: %0 to clear the interrupt, non-zero to set it.
>    */
>   void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
> -void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
> +void kvm_riscv_aia_create(const RISCVAIASocket *sockets,
> +                          uint32_t socket_count, uint64_t group_shift,
>                             uint64_t aia_irq_num, uint64_t aia_msi_num,
>                             uint64_t aplic_base, uint64_t imsic_base,
>                             uint64_t guest_num);


