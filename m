Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EED4CD6E69
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUgun-0008EL-PR; Wed, 03 Jun 2026 04:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>)
 id 1wUgul-0008E6-DK; Wed, 03 Jun 2026 04:25:27 -0400
Received: from msg-1.mailo.com ([213.182.54.11] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>)
 id 1wUguj-00033I-QZ; Wed, 03 Jun 2026 04:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780474329; bh=YzQHeGB9VmmE+QYWQ0/ppeLHLhcIL0n68r2ZSIfa2x0=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=JQ5kKFU0Bo5n3ifnhBMBw5yDSzS/MhlTq11W7AkFJPOv95jvwDgqRGB8L9qcJ9eK/
 AcMXE5Fn2Gwx7goaHDqcWL38EtlVlkoiN5IiBYmY9hZ8OeTDjY0OHxGaTirNEAHvJH
 ZD8vPVXfwE6GmhPN0BuTT770MyjOQwn+fPwqzJ3Q=
Received: by be1-5.in.mailobj.net [192.168.91.15] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 10:11:18 +0200 (CEST)
X-EA-Auth: WLy38N2IzwHpVzm4M/MjuekSf89OaGGlnlYc7VfXx/y4lhhivp7H6fsXhRv4vElbLJgo+q23cVeRY0fk5eyUuDZxvLdeX8q3
Message-ID: <876dbf23-c7ec-46f4-9232-816a3d0bf16c@mailo.com>
Date: Wed, 3 Jun 2026 10:11:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/12] hw/riscv/aia: Configure stride for the M-mode
 IMSIC
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260603065859.592063-1-joel@jms.id.au>
 <20260603065859.592063-6-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260603065859.592063-6-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.11; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 3/6/26 08:58, Joel Stanley wrote:
> riscv_create_aia() currently hard-codes the M-IMSIC at one 4 KiB page
> per hart and gives callers no way to widen it.
> 
> Add an m_imsic_stride parameter that supplies the per hart byte
> stride directly. The virt machine passes IMSIC_HART_SIZE(0)
> (= 4 KiB), preserving its existing compact layout.
> 
> The parameter only changes how the slots are spaced, with the rest of
> each slot reserved. This allows future platforms that have different
> layouts to control the stride.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   hw/riscv/aia.h  | 1 +
>   hw/riscv/aia.c  | 3 ++-
>   hw/riscv/virt.c | 1 +
>   3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
> index 5ad0a902be0d..452e78b9d7ad 100644
> --- a/hw/riscv/aia.h
> +++ b/hw/riscv/aia.h
> @@ -14,6 +14,7 @@
>   uint32_t imsic_num_bits(uint32_t count);
>   
>   DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +                             hwaddr m_imsic_stride,

hw/riscv/virt-acpi-build.c:74:    uint64_t imsic_socket_addr, imsic_addr;
hw/riscv/virt.c:532:    uint32_t imsic_max_hart_per_socket, imsic_addr, 
imsic_size;
target/riscv/kvm/kvm-cpu.c:1829:    uint64_t socket, base_hart, 
hart_count, socket_imsic_base, imsic_addr;

Why choose hwaddr for a stride (region size)?

Using uint64_t:
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>

>                                uint16_t num_sources,
>                                const MemMapEntry *aplic_m,
>                                const MemMapEntry *aplic_s,
> diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> index 82ea9d48ea75..840f84d26b98 100644
> --- a/hw/riscv/aia.c
> +++ b/hw/riscv/aia.c
> @@ -25,6 +25,7 @@ uint32_t imsic_num_bits(uint32_t count)
>   }
>   
>   DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +                             hwaddr m_imsic_stride,
>                                uint16_t num_sources,
>                                const MemMapEntry *aplic_m,
>                                const MemMapEntry *aplic_s,
> @@ -47,7 +48,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
>               /* Per-socket M-level IMSICs */
>               addr = imsic_m->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
>               for (i = 0; i < hart_count; i++) {
> -                riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
> +                riscv_imsic_create(addr + i * m_imsic_stride,
>                                      base_hartid + i, true, 1,
>                                      num_msis);
>               }
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 4cd941a6aac6..529bb2fc0132 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1549,6 +1549,7 @@ static void virt_machine_init(MachineState *machine)
>           } else {
>               s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
>                                                s->aia_guests,
> +                                             IMSIC_HART_SIZE(0),
>                                                s->num_sources,
>                                                &s->memmap[VIRT_APLIC_M],
>                                                &s->memmap[VIRT_APLIC_S],



