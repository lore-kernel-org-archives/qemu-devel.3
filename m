Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AE2C624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0xGL-0006GF-EX; Mon, 31 Aug 2026 04:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1x0xGK-0006FT-4C; Mon, 31 Aug 2026 04:21:04 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1x0xGH-0007M9-3a; Mon, 31 Aug 2026 04:21:03 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4hYMQ10FWXz66Zb;
 Mon, 31 Aug 2026 08:20:57 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <liwei1518@gmail.com>; Mon, 31 Aug 2026 08:20:56 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.113.22])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hYMQ06SvBz1xv1; Mon, 31 Aug 2026 08:20:56 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 392AC1B43F5B;
 Mon, 31 Aug 2026 08:20:55 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R00471d0ea2f-0ef7-4459-8dcc-a0cee931210d,
 20713A92955D5A277E4AF24F7FE8A47CC1774BFC) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <bd0e113a-6495-4f4b-9ed7-bfd206a6acf7@kaod.org>
Date: Mon, 31 Aug 2026 10:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] hw/intc/riscv_aclint: Take a MemoryRegion for
 the created devices
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-3-joel@jms.id.au>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260831021500.82565-3-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 4136556258947017737
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFj/14Gu4I2wps2FLNz9Z5c0sv736XlXJJy0t1uNa4+DffTIO0tlCcBdV0yIL3CvYN+DoRpk/mBobvRLtK54meZAKHYS1l6jMHQIaKiQLGidLKRdq2nI/KwdYrDRTZtxgwNI0ZnBLoh3XUQS0fGx17C2/K5Dz0XpL/e/6pnN5BLVJmp4lsviw0NfCJMwrWEcLvIjHPm6oeIrKQcrP/bRJ8wZuzuIpubo61zTAGfWVYf2rgoY+619hruVlfz4fErdL6+CDWpeQ5dCS73k9DWR1zeHzOLGCNfVmH6cHodA2GQ2lU1VdOej3yZMWO0pbT5/G1iEK7Kb9avuKkAW0Y2+qDFfsxRmZWjA0sZBytevdnjIuu7WYrDadFoux3HuaTFbglqjC0hX5lpK3MNh28ErP8OSNcK9WG93QjXrsmo+wy394Th4o/wRxmuZtN/JSxigCu5VCdPzfUVu2hmcEQyt03CdshnoEMT2deruPu13fQUx3soH16NpfqwswN1HZLrJAkuz2JoZKB79+zN7ctVShZiErwzHDxF9dhiKBY+9a/vw5uDEgFZSO0w0wy9b9nXcjsKApXA52BaoDCR+SgNEy9Lq9Sdj7P6JU9T/gFNOjASBGEseOFyo5AgETEIpWF27/a5b80TmuybniWORH7xf215+M4Qi/Da9U/9G4fxAqJ9BA
DKIM-Signature: a=rsa-sha256; bh=tWhiNjIWMFrZkFoqJYajZAgANowrxQhZ7hTjbawwQH8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788164457; v=1;
 b=eCl5uJiK7O43dwLk6xVC2EXin84EpQuRCyOamOTY0wMJkBaI60G/pjgpbH+kjHeintO9V5wS
 SvWl36VlvmvfsZPPvuN3oITZSvItnDN7lcVlcs4SG9v1chxYj7+fJ8fKloLrMpneZsH1dJ8O5wm
 0yRimm35pCZE/pmAZHoM8IRAkjQtjiO1d4Tbeke3iyPPSeSgx5wl1cjlMMP/feUMRPD/3uJ5H19
 9E6fTxluDZuBzR/kD52A5Lwlqb5L/iin1abbyKRSrkIrut1j+9/mG4+4GYUpc0m5khxGoAQEhzu
 dsXQWd7K8MWRmNTVsG5c7822dcW0wKY4vtrdxxMX4uLwQ==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/31/26 04:14, Joel Stanley wrote:
> The riscv_aclint_mtimer_create() and riscv_aclint_swi_create() helpers
> map the device they create into system_memory, which prevents their use
> by SoCs that map devices into a memory container of their own.

Since these routines are going to be used later on in a realize()
handler, I would add a 'Error **errp' parameter.

Cheers,

C.

> 
> Add a MemoryRegion parameter and map the device into it instead of
> calling sysbus_mmio_map(). All callers pass system_memory, so there is
> no change in behaviour.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   include/hw/intc/riscv_aclint.h |  7 ++++---
>   hw/intc/riscv_aclint.c         | 12 ++++++++----
>   hw/riscv/cps.c                 |  6 ++++--
>   hw/riscv/k230.c                |  6 ++++--
>   hw/riscv/microchip_pfsoc.c     |  5 +++--
>   hw/riscv/shakti_c.c            |  7 ++++---
>   hw/riscv/sifive_e.c            |  4 ++--
>   hw/riscv/sifive_u.c            |  7 ++++---
>   hw/riscv/spike.c               |  4 ++--
>   hw/riscv/tt_atlantis.c         |  3 ++-
>   hw/riscv/virt.c                | 17 +++++++++++------
>   hw/riscv/xiangshan_kmh.c       |  6 ++++--
>   12 files changed, 52 insertions(+), 32 deletions(-)
> 
> diff --git a/include/hw/intc/riscv_aclint.h b/include/hw/intc/riscv_aclint.h
> index 0e0b98acb08a..a8c5d4eb5895 100644
> --- a/include/hw/intc/riscv_aclint.h
> +++ b/include/hw/intc/riscv_aclint.h
> @@ -46,7 +46,8 @@ typedef struct RISCVAclintMTimerState {
>       qemu_irq *timer_irqs;
>   } RISCVAclintMTimerState;
>   
> -DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
> +DeviceState *riscv_aclint_mtimer_create(MemoryRegion *mr,
> +    hwaddr addr, hwaddr size,
>       uint32_t hartid_base, uint32_t num_harts,
>       uint32_t timecmp_base, uint32_t time_base, uint32_t timebase_freq,
>       bool provide_rdtime);
> @@ -68,8 +69,8 @@ typedef struct RISCVAclintSwiState {
>       qemu_irq *soft_irqs;
>   } RISCVAclintSwiState;
>   
> -DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
> -    uint32_t num_harts, bool sswi);
> +DeviceState *riscv_aclint_swi_create(MemoryRegion *mr,
> +    hwaddr addr, uint32_t hartid_base, uint32_t num_harts, bool sswi);
>   
>   enum {
>       RISCV_ACLINT_DEFAULT_MTIMECMP      = 0x0,
> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
> index 361a8d1bcb45..972c6c99b044 100644
> --- a/hw/intc/riscv_aclint.c
> +++ b/hw/intc/riscv_aclint.c
> @@ -371,7 +371,8 @@ static const TypeInfo riscv_aclint_mtimer_info = {
>   /*
>    * Create ACLINT MTIMER device.
>    */
> -DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
> +DeviceState *riscv_aclint_mtimer_create(MemoryRegion *mr,
> +    hwaddr addr, hwaddr size,
>       uint32_t hartid_base, uint32_t num_harts,
>       uint32_t timecmp_base, uint32_t time_base, uint32_t timebase_freq,
>       bool provide_rdtime)
> @@ -392,7 +393,8 @@ DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
>       qdev_prop_set_uint32(dev, "aperture-size", size);
>       qdev_prop_set_uint32(dev, "timebase-freq", timebase_freq);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> +    memory_region_add_subregion(mr, addr,
> +        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
>   
>       for (i = 0; i < num_harts; i++) {
>           CPUState *cpu = cpu_by_arch_id(hartid_base + i);
> @@ -556,7 +558,8 @@ static const TypeInfo riscv_aclint_swi_info = {
>   /*
>    * Create ACLINT [M|S]SWI device.
>    */
> -DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
> +DeviceState *riscv_aclint_swi_create(MemoryRegion *mr,
> +    hwaddr addr, uint32_t hartid_base,
>       uint32_t num_harts, bool sswi)
>   {
>       int i;
> @@ -569,7 +572,8 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
>       qdev_prop_set_uint32(dev, "num-harts", num_harts);
>       qdev_prop_set_uint32(dev, "sswi", sswi ? true : false);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> +    memory_region_add_subregion(mr, addr,
> +        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
>   
>       for (i = 0; i < num_harts; i++) {
>           CPUState *cpu = cpu_by_arch_id(hartid_base + i);
> diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
> index 86172be5b3ca..5cfb54aa27d2 100644
> --- a/hw/riscv/cps.c
> +++ b/hw/riscv/cps.c
> @@ -151,9 +151,11 @@ static void riscv_cps_realize(DeviceState *dev, Error **errp)
>                              false, false, s->aplic);
>           /* PLIC changes msi_nonbroken to ture. We revert the change. */
>           msi_nonbroken = false;
> -        riscv_aclint_swi_create(cm_base + AIA_CLINT_OFFSET,
> +        riscv_aclint_swi_create(get_system_memory(),
> +                                cm_base + AIA_CLINT_OFFSET,
>                                   hartid_base, MAX_HARTS, false);
> -        riscv_aclint_mtimer_create(cm_base + AIA_CLINT_OFFSET +
> +        riscv_aclint_mtimer_create(get_system_memory(),
> +                                   cm_base + AIA_CLINT_OFFSET +
>                                      RISCV_ACLINT_SWI_SIZE,
>                                      RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>                                      hartid_base,
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 558f30b97e9d..1ef4260c5391 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -196,9 +196,11 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>       s->c908_plic = k230_create_plic(C908_CPU_HARTID, c908_cpus);
>   
>       /* CLINT */
> -    riscv_aclint_swi_create(memmap[K230_DEV_CLINT].base,
> +    riscv_aclint_swi_create(sys_mem,
> +                            memmap[K230_DEV_CLINT].base,
>                               C908_CPU_HARTID, c908_cpus, false);
> -    riscv_aclint_mtimer_create(memmap[K230_DEV_CLINT].base + 0x4000,
> +    riscv_aclint_mtimer_create(sys_mem,
> +                               memmap[K230_DEV_CLINT].base + 0x4000,
>                                  RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>                                  C908_CPU_HARTID, c908_cpus,
>                                  RISCV_ACLINT_DEFAULT_MTIMECMP,
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 4017129c8304..a6026776d4de 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -250,9 +250,10 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>           memmap[MICROCHIP_PFSOC_BUSERR_UNIT4].size);
>   
>       /* CLINT */
> -    riscv_aclint_swi_create(memmap[MICROCHIP_PFSOC_CLINT].base,
> +    riscv_aclint_swi_create(system_memory,
> +        memmap[MICROCHIP_PFSOC_CLINT].base,
>           0, ms->smp.cpus, false);
> -    riscv_aclint_mtimer_create(
> +    riscv_aclint_mtimer_create(system_memory,
>           memmap[MICROCHIP_PFSOC_CLINT].base + RISCV_ACLINT_SWI_SIZE,
>           RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
>           RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
> diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
> index 835b1f879b7f..86ff8f8fcaab 100644
> --- a/hw/riscv/shakti_c.c
> +++ b/hw/riscv/shakti_c.c
> @@ -127,10 +127,11 @@ static void shakti_c_soc_state_realize(DeviceState *dev, Error **errp)
>           SHAKTI_C_PLIC_CONTEXT_STRIDE,
>           shakti_c_memmap[SHAKTI_C_PLIC].size);
>   
> -    riscv_aclint_swi_create(shakti_c_memmap[SHAKTI_C_CLINT].base,
> +    riscv_aclint_swi_create(system_memory,
> +        shakti_c_memmap[SHAKTI_C_CLINT].base,
>           0, 1, false);
> -    riscv_aclint_mtimer_create(shakti_c_memmap[SHAKTI_C_CLINT].base +
> -            RISCV_ACLINT_SWI_SIZE,
> +    riscv_aclint_mtimer_create(system_memory,
> +        shakti_c_memmap[SHAKTI_C_CLINT].base + RISCV_ACLINT_SWI_SIZE,
>           RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, 1,
>           RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
>           RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, false);
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 71925583bd97..0ea444f43bc5 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -225,9 +225,9 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
>           SIFIVE_E_PLIC_CONTEXT_BASE,
>           SIFIVE_E_PLIC_CONTEXT_STRIDE,
>           memmap[SIFIVE_E_DEV_PLIC].size);
> -    riscv_aclint_swi_create(memmap[SIFIVE_E_DEV_CLINT].base,
> +    riscv_aclint_swi_create(sys_mem, memmap[SIFIVE_E_DEV_CLINT].base,
>           0, ms->smp.cpus, false);
> -    riscv_aclint_mtimer_create(memmap[SIFIVE_E_DEV_CLINT].base +
> +    riscv_aclint_mtimer_create(sys_mem, memmap[SIFIVE_E_DEV_CLINT].base +
>               RISCV_ACLINT_SWI_SIZE,
>           RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
>           RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 57a57c96e16b..58b4744318f8 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -788,10 +788,11 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>           serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART0_IRQ));
>       sifive_uart_create(system_memory, memmap[SIFIVE_U_DEV_UART1].base,
>           serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
> -    riscv_aclint_swi_create(memmap[SIFIVE_U_DEV_CLINT].base, 0,
> +    riscv_aclint_swi_create(system_memory,
> +        memmap[SIFIVE_U_DEV_CLINT].base, 0,
>           ms->smp.cpus, false);
> -    riscv_aclint_mtimer_create(memmap[SIFIVE_U_DEV_CLINT].base +
> -            RISCV_ACLINT_SWI_SIZE,
> +    riscv_aclint_mtimer_create(system_memory,
> +        memmap[SIFIVE_U_DEV_CLINT].base + RISCV_ACLINT_SWI_SIZE,
>           RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
>           RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
>           CLINT_TIMEBASE_FREQ, false);
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 630b65f56977..a227e0eca147 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -163,10 +163,10 @@ static void spike_board_init(MachineState *machine)
>           sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
>   
>           /* Core Local Interruptor (timer and IPI) for each socket */
> -        riscv_aclint_swi_create(
> +        riscv_aclint_swi_create(system_memory,
>               memmap[SPIKE_CLINT].base + i * memmap[SPIKE_CLINT].size,
>               base_hartid, hart_count, false);
> -        riscv_aclint_mtimer_create(
> +        riscv_aclint_mtimer_create(system_memory,
>               memmap[SPIKE_CLINT].base + i * memmap[SPIKE_CLINT].size +
>                   RISCV_ACLINT_SWI_SIZE,
>               RISCV_ACLINT_DEFAULT_MTIMER_SIZE, base_hartid, hart_count,
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index d69851df0a01..3f183db5c302 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -509,7 +509,8 @@ static void tt_atlantis_machine_init(MachineState *machine)
>                                     TT_IRQCHIP_NUM_MSIS,
>                                     TT_IRQCHIP_NUM_PRIO_BITS);
>   
> -    riscv_aclint_mtimer_create(s->memmap[TT_ATL_ACLINT].base,
> +    riscv_aclint_mtimer_create(system_memory,
> +            s->memmap[TT_ATL_ACLINT].base,
>               TT_ACLINT_MTIME_SIZE,
>               0, hart_count,
>               TT_ACLINT_MTIMECMP,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 22a607ed10bf..6e4b39315aaa 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1370,7 +1370,8 @@ static void virt_machine_init(MachineState *machine)
>           if (virt_aclint_allowed() && s->have_aclint) {
>               if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
>                   /* Per-socket ACLINT MTIMER */
> -                riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
> +                riscv_aclint_mtimer_create(system_memory,
> +                        s->memmap[VIRT_CLINT].base +
>                               i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>                           RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>                           base_hartid, hart_count,
> @@ -1379,10 +1380,12 @@ static void virt_machine_init(MachineState *machine)
>                           RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
>               } else {
>                   /* Per-socket ACLINT MSWI, MTIMER, and SSWI */
> -                riscv_aclint_swi_create(s->memmap[VIRT_CLINT].base +
> +                riscv_aclint_swi_create(system_memory,
> +                        s->memmap[VIRT_CLINT].base +
>                               i * s->memmap[VIRT_CLINT].size,
>                           base_hartid, hart_count, false);
> -                riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
> +                riscv_aclint_mtimer_create(system_memory,
> +                        s->memmap[VIRT_CLINT].base +
>                               i * s->memmap[VIRT_CLINT].size +
>                               RISCV_ACLINT_SWI_SIZE,
>                           RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> @@ -1390,16 +1393,18 @@ static void virt_machine_init(MachineState *machine)
>                           RISCV_ACLINT_DEFAULT_MTIMECMP,
>                           RISCV_ACLINT_DEFAULT_MTIME,
>                           RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
> -                riscv_aclint_swi_create(s->memmap[VIRT_ACLINT_SSWI].base +
> +                riscv_aclint_swi_create(system_memory,
> +                        s->memmap[VIRT_ACLINT_SSWI].base +
>                               i * s->memmap[VIRT_ACLINT_SSWI].size,
>                           base_hartid, hart_count, true);
>               }
>           } else if (tcg_enabled()) {
>               /* Per-socket SiFive CLINT */
> -            riscv_aclint_swi_create(
> +            riscv_aclint_swi_create(system_memory,
>                       s->memmap[VIRT_CLINT].base + i * s->memmap[VIRT_CLINT].size,
>                       base_hartid, hart_count, false);
> -            riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
> +            riscv_aclint_mtimer_create(system_memory,
> +                    s->memmap[VIRT_CLINT].base +
>                       i * s->memmap[VIRT_CLINT].size + RISCV_ACLINT_SWI_SIZE,
>                       RISCV_ACLINT_DEFAULT_MTIMER_SIZE, base_hartid, hart_count,
>                       RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
> diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
> index 384624d69ad5..94f9d02a00b9 100644
> --- a/hw/riscv/xiangshan_kmh.c
> +++ b/hw/riscv/xiangshan_kmh.c
> @@ -116,9 +116,11 @@ static void xiangshan_kmh_soc_realize(DeviceState *dev, Error **errp)
>                      115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
>   
>       /* CLINT */
> -    riscv_aclint_swi_create(memmap[XIANGSHAN_KMH_CLINT].base,
> +    riscv_aclint_swi_create(system_memory,
> +                            memmap[XIANGSHAN_KMH_CLINT].base,
>                               0, num_harts, false);
> -    riscv_aclint_mtimer_create(memmap[XIANGSHAN_KMH_CLINT].base +
> +    riscv_aclint_mtimer_create(system_memory,
> +                               memmap[XIANGSHAN_KMH_CLINT].base +
>                                  RISCV_ACLINT_SWI_SIZE,
>                                  RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>                                  0, num_harts, RISCV_ACLINT_DEFAULT_MTIMECMP,


