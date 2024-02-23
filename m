Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375F6C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 05:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdOOp-0007IW-KV; Fri, 23 Feb 2024 00:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdOOo-0007IF-BK
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 00:47:06 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdOOi-0002CC-MP
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 00:47:06 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d38c9ca5bso253849f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 21:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708667218; x=1709272018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7EhJFnTniKSlK15ZJk4CIJhZZY/rKBVd/U4dhNAVJ+g=;
 b=XSI9EiEHndoixUuvqhYSPzofbMvkcCK62yJh6a0VTJAft9ognfAilenFWsl4juHsAY
 DAT+Cq9RLWwCEz4dPmCyvuqUvaNKGvhtMD0vFVcCRjJ9gGq0llejdD+MfGQqBB6dw7pm
 pm2VKROfkWGuimBnlVsxQbLnabf4lIUORU8Q6mIB2HZO4COBXUH33D4rY4kCdDtKrEx9
 H9CiphxU5uD3lAkMFRLVlIyIRsiVOg++DNDrsB7nqQUQjBhUTOXNYNfjlMTFIU9OlDVQ
 C55bUutjTfpftNn6jSRtZZWRBAXfPcGkvF4ByCS1EaG15NdyrJKeVlPyiJoel/6y3HOT
 f7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708667218; x=1709272018;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7EhJFnTniKSlK15ZJk4CIJhZZY/rKBVd/U4dhNAVJ+g=;
 b=nlmoab8QUkOt0af+GMdm9LjQdNKYzo7YgKt7WFq1Qd5oau59SILG6+CZOOJcRL/BP8
 gY+Gp2jSsiPmoHaO21zrzHI7tuOQ8Nu0Xr6lf/1+cM3Km7Zwm5eIrekb5oygelORVsbn
 urdXwqCKc4pHqgvl14Cx8xmB3jeDo1TAuOiHAK+6UKy4B4I8yF1Ayb2u9PyMCJzw1VMc
 88yPO37jh5BUtGqknMAn1eJr5lqdxFAic+eWjJhAIClVaJllYZ383M4KMROPu6sD9aU3
 Fhgvu5QCijA1NycN4rvaNamx77FaufD+XZM2RmHuU3iNXgTRofz3QvI8EVHRazdjCqH+
 VEWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjV8Hm7nVfzGBs+wmbF5jr0q3VUy0CNQB+k/1KFG5W0AR4+cAUwOnCqPlKntcugFpXY1+ZXF25Y7Dvb56P7PgJ/Fh/StE=
X-Gm-Message-State: AOJu0YypbPwxmlb4eomOI3hIkSPVYqLPXg4j6XnTN7y9M/I7/iLLZBJK
 iPrLsvJM1uoqT227VDPRjQMwdisTO6I4S6Ek2GmwdfOTeyznmJHSORAdt0CQrUo=
X-Google-Smtp-Source: AGHT+IHsjo6itbadFKhBE6ZXjNqgpX1775dfyJvFwZzNAIqNJh9VJKzrDAQTKvkv8Zs/Y4njoJHuzg==
X-Received: by 2002:adf:e0c4:0:b0:33d:28a9:2fd8 with SMTP id
 m4-20020adfe0c4000000b0033d28a92fd8mr572689wri.39.1708667218330; 
 Thu, 22 Feb 2024 21:46:58 -0800 (PST)
Received: from [192.168.69.100] (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 o8-20020a05600002c800b0033d56d43fbesm1378393wry.115.2024.02.22.21.46.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 21:46:57 -0800 (PST)
Message-ID: <62e08b11-81ca-40e3-a761-592f4c0b0976@linaro.org>
Date: Fri, 23 Feb 2024 06:46:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] virtio-pci: correctly set virtio pci queue mem
 multiplier
Content-Language: en-US
To: Srujana Challa <schalla@marvell.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, vattunuru@marvell.com,
 jerinj@marvell.com
References: <20240223052617.1867132-1-schalla@marvell.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240223052617.1867132-1-schalla@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Srujana,

On 23/2/24 06:26, Srujana Challa wrote:
> Currently, virtio_pci_queue_mem_mult function always returns 4K
> when VIRTIO_PCI_FLAG_PAGE_PER_VQ is set. But this won't
> work for vhost vdpa when host has page size other than 4K.
> This patch introduces a new property(host-page-per-vq) for vdpa
> use case to fix the same.
> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> ---
> v2->v3:
> - Modified property name, page-per-vdpa-vq to host-page-per-vq.
> 
> v1->v2:
> - Introduced a new property to get virtqueue mem multiplier for
>    vdpa use case.
> 
>   hw/virtio/virtio-pci.c         | 10 ++++++++--
>   include/hw/virtio/virtio-pci.h |  5 +++++
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 1a7039fb0c..f29e60830b 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -320,8 +320,12 @@ static bool virtio_pci_ioeventfd_enabled(DeviceState *d)
>   
>   static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy *proxy)
>   {
> -    return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
> -        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
> +    if (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)
> +        return QEMU_VIRTIO_PCI_QUEUE_MEM_MULT;
> +    else if (proxy->flags & VIRTIO_PCI_FLAG_HOST_PAGE_PER_VQ)
> +        return qemu_real_host_page_size();
> +    else
> +        return 4;
 >   }

Per our coding style, this code should use braces:
https://www.qemu.org/docs/master/devel/style.html#block-structure

Regards,

Phil.

