Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67AAE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 12:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM4yu-0001Ut-Qs; Fri, 13 Dec 2024 07:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tM4yh-0001Tq-8R
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 07:41:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tM4yW-0007co-Lb
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 07:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734093638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dlcvBqzAsRciA7zwuGOZHFb0X2Ns2gVIw8fe9cGLmYM=;
 b=GyW+O5LsWNC2/5MOKZj/WN2XSJpXQZWBH3CIILD7927qO234uq8Rlltt+dYXqzfgGU9F0/
 fbT+jy4a7taqQlxpOjzsZcqFqPJoATHg4WnCeLyucgoOHHMlUeIMw/jOwc43XbZOQvYg8l
 CwNJMfwq1scTFktPcp+2k8FVbIwnSIk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-RkUVLa0SOqWbJdVz2PYFQw-1; Fri, 13 Dec 2024 07:40:33 -0500
X-MC-Unique: RkUVLa0SOqWbJdVz2PYFQw-1
X-Mimecast-MFC-AGG-ID: RkUVLa0SOqWbJdVz2PYFQw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385fdff9db5so209092f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 04:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734093632; x=1734698432;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dlcvBqzAsRciA7zwuGOZHFb0X2Ns2gVIw8fe9cGLmYM=;
 b=jajv+KAZOGNswb3Rx4zmG8RN4SS01qH6Fy7oU6mWjksuwV82748Dyzcd1voB8rDd79
 NiUvRJuVNGjNBv8tTS7OCHhsdd/vmgzvrDXeqxtELx8eYIMe+3r/K0jT7qnWnWNA0NvE
 4hGjMPHZ3Q8N31H5hsdbOjuFBMmRNG7AbzGXKgoerAH++H2jLi4oBAO+vs6zygwFk23x
 tyW8ShFrpwCXa1s3wjJ/+LswhgJoaArbCDbtrigCLyK651n/JL6rHDa9jGX+tpwsPUtx
 E8Z2C8rGgvwPDTHKEE8dmL/PztoL09JfXGENQq759/UHdUP5jHyfVnqTPg0L119d7vbX
 GQ2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6hrs6VoHMo0IFiiwM3uke+yp3kaoVMZlQuF/k8F2sIZBhnbVuKUAqFkmo3Fw2qqOa2ff4AJt5v7w3@nongnu.org
X-Gm-Message-State: AOJu0YyhqCdqMXkSkFcrhBhLWGrbbKBjzClw01KSoHCNLTwOY0xPK+dE
 npnZiTqX+6rSrXm47Xz/8vIp0sxMDkKRDJ0xiDfdtki1Ko8nL9vHkdW2nTcgv4/1P0ZzseUJpBR
 Ce8KeaKDzm50mHF9BsGHr84PXbSA1hjKel3h5O9qHT/ce7k42c6en
X-Gm-Gg: ASbGncvD8pmMKAAsRp10tnVXTw5yhZMdCjjv3wTCgESLJV4cEJf6yRuHJUgXkxVRBE5
 PLN6oJv88q7fA+M5SPanEKXZFNzpwUB2wnFJzCPG3ZrIANb0j3EEPPGTr1Pu/bq23JQ+TnUjwP+
 60s3OgCY2N2Q0VqVoJpUxmx4JxSXen8IBG8LplMFAuNaFKIAaJGYInVaZjW1aRsmAPbnJMEOs59
 Y22O3Zg6WIw0Bpp03dct1V9ZOcP2x6tZjiNvBZZmrBoCcz97Ly/3IuR6lHhxQaYvX8zv9ddTbw0
 t7r7Yg==
X-Received: by 2002:a05:6000:1882:b0:385:e0d6:fb73 with SMTP id
 ffacd0b85a97d-38880ad7765mr1886394f8f.15.1734093632399; 
 Fri, 13 Dec 2024 04:40:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgIeTvwlAyjQ7c4b7q2V4H8czwq/MkUpO1vrkYYzcQO2lOnHOtjfljLO4DUi+PQ23edFzaBA==
X-Received: by 2002:a05:6000:1882:b0:385:e0d6:fb73 with SMTP id
 ffacd0b85a97d-38880ad7765mr1886372f8f.15.1734093632031; 
 Fri, 13 Dec 2024 04:40:32 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514beesm7117551f8f.71.2024.12.13.04.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 04:40:31 -0800 (PST)
Message-ID: <6fcccb4c-6260-401d-aab9-3d77b7cf3cf5@redhat.com>
Date: Fri, 13 Dec 2024 13:40:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] s390x/s390-virtio-ccw: prepare for memory devices
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20241008105455.2302628-1-david@redhat.com>
 <20241008105455.2302628-11-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241008105455.2302628-11-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08/10/2024 12.54, David Hildenbrand wrote:
> Let's prepare our address space for memory devices if enabled via
> "maxmem" and if we have CONFIG_MEM_DEVICE enabled at all. Note that
> CONFIG_MEM_DEVICE will be selected automatically once we add support
> for devices.
> 
> Just like on other architectures, the region container for memory devices
> is placed directly above our initial memory. For now, we only align the
> start address of the region up to 1 GiB, but we won't add any additional
> space to the region for internal alignment purposes; this can be done in
> the future if really required.
> 
> The RAM size returned via SCLP is not modified, as this only
> covers initial RAM (and standby memory we don't implement) and not memory
> devices; clarify that in the docs of read_SCP_info(). Existing OSes without
> support for memory devices will keep working as is, even when memory
> devices would be attached the VM.
> 
> Guest OSs which support memory devices, such as virtio-mem, will
> consult diag500(), to find out the maximum possible pfn. Guest OSes that
> don't support memory devices, don't have to be changed and will continue
> relying on information provided by SCLP.
> 
> There are no remaining maxram_size users in s390x code, and the remaining
> ram_size users only care about initial RAM:
> * hw/s390x/ipl.c
> * hw/s390x/s390-hypercall.c
> * hw/s390x/sclp.c
> * target/s390x/kvm/pv.c
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 23 ++++++++++++++++++++++-
>   hw/s390x/sclp.c            |  6 +++++-
>   2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 749d46e700..2031c4cf29 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -156,6 +156,7 @@ static void s390_memory_init(MachineState *machine)
>       MemoryRegion *sysmem = get_system_memory();
>       MemoryRegion *ram = machine->ram;
>       uint64_t ram_size = memory_region_size(ram);
> +    uint64_t devmem_base, devmem_size;
>   
>       if (!QEMU_IS_ALIGNED(ram_size, 1 * MiB)) {
>           /*
> @@ -168,11 +169,31 @@ static void s390_memory_init(MachineState *machine)
>           exit(EXIT_FAILURE);
>       }
>   
> -    s390_set_memory_limit(s390ms, ram_size);
> +    devmem_size = 0;
> +    devmem_base = ram_size;
> +#ifdef CONFIG_MEM_DEVICE
> +    if (machine->ram_size < machine->maxram_size) {
> +
> +        /*
> +         * Make sure memory devices have a sane default alignment, even
> +         * when weird initial memory sizes are specified.
> +         */
> +        devmem_base = QEMU_ALIGN_UP(devmem_base, 1 * GiB);
> +        devmem_size = machine->maxram_size - machine->ram_size;

Shouldn't that rather be:

            devmem_size = machine->maxram_size - devmem_base;

instead?

   Thomas


> +    }
> +#endif
> +    s390_set_memory_limit(s390ms, devmem_base + devmem_size);
>   
>       /* Map the initial memory. Must happen after setting the memory limit. */
>       memory_region_add_subregion(sysmem, 0, ram);
>   
> +    /* Initialize address space for memory devices. */
> +#ifdef CONFIG_MEM_DEVICE
> +    if (devmem_size) {
> +        machine_memory_devices_init(machine, devmem_base, devmem_size);
> +    }
> +#endif /* CONFIG_MEM_DEVICE */
> +


