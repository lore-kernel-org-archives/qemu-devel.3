Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92832D0E6F5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 15:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNvEt-0007aD-UF; Tue, 25 Nov 2025 10:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vNvEs-0007Zb-9X
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:45:58 -0500
Received: from m228-31.mailgun.net ([159.135.228.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vNvEq-0000Yh-PN
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:45:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=yodel.dev; q=dns/txt;
 s=pdk1; t=1764085548; x=1764092748; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: From:
 References: Cc: To: To: Subject: Subject: MIME-Version: Date: Message-ID:
 Sender: Sender; 
 bh=Eg14pz0DS31DiqEjUDTKPaK6OXR6Qb8TXsECknBOq6M=;
 b=G+TwHW4NcDjplD8nBxzTX5+ZUqErP22dUjA13a1hjTWvf6JLB8hMknKCGKvtKsR49Q8GEj9maG4TbHqZmuZBXQK8omlouVyfPmjO2ewvhzjGwubn+n+5la9OM/Y/rH3bVLZrkHytEJ3eHAIgunS10q45um7PPDiw/vFAwiQ+wwdQC9oPIpNgjjP/euXAypRTgbNFXAknwA6WYNu63R5Rw57xD8eLMqyQ/j7GYFYX+7O9m3EnMQjuOfj8TXWLD7+p9vOMVKWNnvSB0N1nXIlAFSxuVOny79Q9Lz1dE+Cyw4d8o2koMNNtYLSRdIHCQs5vRHqzDWHhN6068Ty9+PkVCw==
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 6f211181d7c9a22e1f05529faadf728965d071630eae68ad10704bf94fda848a with SMTP id
 6925cf2c90568de74a18fb40; Tue, 25 Nov 2025 15:45:48 GMT
X-Mailgun-Sending-Ip: 159.135.228.31
Message-ID: <27acb992-b17d-42ed-b65f-bb8462a94f0f@yodel.dev>
Date: Tue, 25 Nov 2025 09:45:46 -0600
MIME-Version: 1.0
Subject: Re: [PATCH] hw/pci: Use correct bus aperture for device container size
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20251124114754.79831-1-philmd@linaro.org>
Content-Language: en-US
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <20251124114754.79831-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=159.135.228.31;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=m228-31.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Yodel Eldar <yodel.eldar@yodel.dev>
From:  Yodel Eldar via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi, Philippe!

On 24/11/2025 05:47, Philippe Mathieu-Daudé wrote:
> Before commit 3716d5902d7 ("pci: introduce a bus master container")
> device view of the bus address space was correctly sized to the
> bus aperture, but then it always used a 64-bit aperture. Restore
> the previous behavior, so devices on 32-bit PCI only see 32-bit
> address space.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/pci/pci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index b1eba348e06..64f33b9de04 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1375,7 +1375,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>       pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>   
>       memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
> -                       "bus master container", UINT64_MAX);
> +                       "bus master container",
> +                       memory_region_size(bus->address_space_mem));
>       address_space_init(&pci_dev->bus_master_as,
>                          &pci_dev->bus_master_container_region, pci_dev->name);
>       pci_dev->bus_master_as.max_bounce_buffer_size =

Acked-by: Yodel Eldar <yodel.eldar@yodel.dev>

Thanks,
Yodel

