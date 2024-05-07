Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631CCC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4KOU-0004ER-0j; Tue, 07 May 2024 08:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4KOQ-0004D1-66
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:58:02 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4KOO-0004kY-99
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:58:01 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a59a64db066so780589566b.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715086678; x=1715691478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=84CWVTksX4h/M7O1LwW+PFJL3hrhBZAUXWlhUQbTp0o=;
 b=kYQee6UmDyW2zGsAFAfDwpXjVkMg/Jkqyee298voA9GZX+NDJOE17iDIP+sN8L1w1L
 PIUbSSWfKs1bRsuhm7CIcwuHPhlXBu2h/zbqiVSnYhQ2Xntlt3hlrjYfIdS1zOkur+aD
 hWVVkteXmuI1gw5zpxJcicvX2BowMifecAVNvHxWcq2h6Io2LGmYGC6/aFKsYXjK9xl3
 snNmUQwhoDgGva2kOo4EthrjK67dYIc3acKvZE/nY487uaEYkintD9C7XPhMpNebGwJG
 3EAu1naCg+m9c7h/M2bFrK7M8fGU1PREhIZn6Uuc0Hn81ibo3QVOoS6v1XWZHqe785dd
 /Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715086678; x=1715691478;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=84CWVTksX4h/M7O1LwW+PFJL3hrhBZAUXWlhUQbTp0o=;
 b=XRBjuSmbRKsHXHzxqA8gZ0D2769MEXJAEyuHtLnTPr0Tv4hg1VM2oYeZKJlHDu0uOZ
 ubNovqsn6sT7K/KYVrgFFAREttiA3ej19WtfTrvmX0rnI2taUiNaBIEG0DghjSkAI4CV
 PhYlEFp0nECMK7Vvpkhk3IVrM8h+PNNBTUgwvMLNNuqt8ARWa1VpefZaLjCfS5eJW+8L
 wiXzHfpoqKS2mcfmasAK21Rrv5cMDjxLmfbp2lPvLmtdXSW87JZtTDeDevqDPjUz1c3l
 caiMrJwYvcqvTHltMJFBm1wwwBU28L0IzCxxi+X3/1WkcrEeGIqeIpP1zNXbrp0tXdrZ
 auFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTUt/fELMgqEjRyeoBWqQoL+3Hez1FmIKpTxm65PDE4r+fSMYzIfR8LzOwSlvhU90vAphbAyTWPRmgpDtmCh+Ce3tXJlM=
X-Gm-Message-State: AOJu0Yz6VIKoi6YwWk1ztQcT4K1XKqXVdu5ryyDRsFVjVAsDaE0AAk2d
 Sts2HUdlAPlG3QwdA6S9ZeVpvAMWPNGZ+MJY0IhZsdmSCYv2K/ePaPOMF+oIl+Q=
X-Google-Smtp-Source: AGHT+IHXmKEq7m810FXhyCYqm4FTgukB9zY+P4NYoJ8yWZPSaiQ5B5XqQjX/4na3HtCE8Bsd7Zdt+w==
X-Received: by 2002:a17:907:96a2:b0:a59:b376:87b3 with SMTP id
 hd34-20020a17090796a200b00a59b37687b3mr6199534ejc.62.1715086678383; 
 Tue, 07 May 2024 05:57:58 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 ze15-20020a170906ef8f00b00a59ae3efb03sm3924561ejb.3.2024.05.07.05.57.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 05:57:57 -0700 (PDT)
Message-ID: <447ddc5a-ae1e-4fd1-b03a-dd7e1faa46e9@linaro.org>
Date: Tue, 7 May 2024 14:57:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/5] softmmu: Support concurrent bounce buffers
To: Mattias Nissler <mnissler@rivosinc.com>, stefanha@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, jag.raman@oracle.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, john.levon@nutanix.com
References: <20240507094210.300566-1-mnissler@rivosinc.com>
 <20240507094210.300566-3-mnissler@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507094210.300566-3-mnissler@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/5/24 11:42, Mattias Nissler wrote:
> When DMA memory can't be directly accessed, as is the case when
> running the device model in a separate process without shareable DMA
> file descriptors, bounce buffering is used.
> 
> It is not uncommon for device models to request mapping of several DMA
> regions at the same time. Examples include:
>   * net devices, e.g. when transmitting a packet that is split across
>     several TX descriptors (observed with igb)
>   * USB host controllers, when handling a packet with multiple data TRBs
>     (observed with xhci)
> 
> Previously, qemu only provided a single bounce buffer per AddressSpace
> and would fail DMA map requests while the buffer was already in use. In
> turn, this would cause DMA failures that ultimately manifest as hardware
> errors from the guest perspective.
> 
> This change allocates DMA bounce buffers dynamically instead of
> supporting only a single buffer. Thus, multiple DMA mappings work
> correctly also when RAM can't be mmap()-ed.
> 
> The total bounce buffer allocation size is limited individually for each
> AddressSpace. The default limit is 4096 bytes, matching the previous
> maximum buffer size. A new x-max-bounce-buffer-size parameter is
> provided to configure the limit for PCI devices.
> 
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> ---
>   hw/pci/pci.c                |  8 ++++
>   include/exec/memory.h       | 14 +++----
>   include/hw/pci/pci_device.h |  3 ++
>   system/memory.c             |  5 ++-
>   system/physmem.c            | 82 ++++++++++++++++++++++++++-----------
>   5 files changed, 76 insertions(+), 36 deletions(-)


> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index d417d7f363..2ea1e99da2 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1117,13 +1117,7 @@ typedef struct AddressSpaceMapClient {
>       QLIST_ENTRY(AddressSpaceMapClient) link;
>   } AddressSpaceMapClient;
>   
> -typedef struct {
> -    MemoryRegion *mr;
> -    void *buffer;
> -    hwaddr addr;
> -    hwaddr len;
> -    bool in_use;
> -} BounceBuffer;
> +#define DEFAULT_MAX_BOUNCE_BUFFER_SIZE (4096)
>   
>   /**
>    * struct AddressSpace: describes a mapping of addresses to #MemoryRegion objects
> @@ -1143,8 +1137,10 @@ struct AddressSpace {
>       QTAILQ_HEAD(, MemoryListener) listeners;
>       QTAILQ_ENTRY(AddressSpace) address_spaces_link;
>   
> -    /* Bounce buffer to use for this address space. */
> -    BounceBuffer bounce;
> +    /* Maximum DMA bounce buffer size used for indirect memory map requests */
> +    uint32_t max_bounce_buffer_size;

Alternatively size_t.

> +    /* Total size of bounce buffers currently allocated, atomically accessed */
> +    uint32_t bounce_buffer_size;

Ditto.

>       /* List of callbacks to invoke when buffers free up */
>       QemuMutex map_client_list_lock;
>       QLIST_HEAD(, AddressSpaceMapClient) map_client_list;
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index d3dd0f64b2..253b48a688 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -160,6 +160,9 @@ struct PCIDevice {
>       /* ID of standby device in net_failover pair */
>       char *failover_pair_id;
>       uint32_t acpi_index;
> +
> +    /* Maximum DMA bounce buffer size used for indirect memory map requests */
> +    uint32_t max_bounce_buffer_size;

Ditto.

>   };


> diff --git a/system/physmem.c b/system/physmem.c
> index 632da6508a..cd61758da0 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3046,6 +3046,20 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
>                                        NULL, len, FLUSH_CACHE);
>   }
>   
> +/*
> + * A magic value stored in the first 8 bytes of the bounce buffer struct. Used
> + * to detect illegal pointers passed to address_space_unmap.
> + */
> +#define BOUNCE_BUFFER_MAGIC 0xb4017ceb4ffe12ed
> +
> +typedef struct {
> +    uint64_t magic;
> +    MemoryRegion *mr;
> +    hwaddr addr;
> +    uint32_t len;
> +    uint8_t buffer[];
> +} BounceBuffer;

Eh, you moved it back here. Never mind.

> +
>   static void
>   address_space_unregister_map_client_do(AddressSpaceMapClient *client)
>   {
> @@ -3071,9 +3085,9 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh)
>       qemu_mutex_lock(&as->map_client_list_lock);
>       client->bh = bh;
>       QLIST_INSERT_HEAD(&as->map_client_list, client, link);
> -    /* Write map_client_list before reading in_use.  */
> +    /* Write map_client_list before reading bounce_buffer_size. */
>       smp_mb();
> -    if (!qatomic_read(&as->bounce.in_use)) {
> +    if (qatomic_read(&as->bounce_buffer_size) < as->max_bounce_buffer_size) {
>           address_space_notify_map_clients_locked(as);
>       }
>       qemu_mutex_unlock(&as->map_client_list_lock);
> @@ -3203,28 +3217,40 @@ void *address_space_map(AddressSpace *as,
>       mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
>   
>       if (!memory_access_is_direct(mr, is_write)) {
> -        if (qatomic_xchg(&as->bounce.in_use, true)) {
> +        uint32_t used = qatomic_read(&as->bounce_buffer_size);

Nitpicking again, size_t seems clearer. Otherwise LGTM.

