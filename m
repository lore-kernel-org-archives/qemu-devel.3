Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E05C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrmd-0003vC-De; Wed, 20 Mar 2024 04:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmrmb-0003uE-H1
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmrma-000396-3p
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710925126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wQDZtMbY+JWVnRii+RiA+HNGn+8BKQoCCXR2CaoP1hc=;
 b=WaojCDGaUV45ecOc1fWdphxoP57h0ZYcr7rDa+baTi7QEzJ5YtrlvWEL9v98zz6i987A1h
 9vYZkXOTq6pQSGsnzfVVq/iUrtDB/ZHqP5hQGEhpU9XnOZeHbRbSHZnBNwOb3W24AUJozZ
 dY2/16aZnnw8UR1WpCf8ZRWv1+vYVv0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-n3tZiGisPpqLmSq7EptKVg-1; Wed, 20 Mar 2024 04:58:44 -0400
X-MC-Unique: n3tZiGisPpqLmSq7EptKVg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a469d3547c7so66937066b.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 01:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710925123; x=1711529923;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wQDZtMbY+JWVnRii+RiA+HNGn+8BKQoCCXR2CaoP1hc=;
 b=ea7apDOMzXQCWof4L8JDCZPjgsS3nGvgNPruEedSQofJrsqLTfAsjjSQbJfshJdDRO
 sCfRHlAOC7Lz95RRDXjwz9jBjVKT9BpQPyV74EL5+DXPRCkH+VNMJTxSlJ7LhYjufj8T
 b8q/rMt9nM5lHHc9S7IHxr61vEoyH8ish/AF2k3B7yHXcKH/9xGxpaMVyaG5Jgpi3aEb
 sKv3RxVJBKodNTYgXxxdffMasMek2h8vd70ZKq6A1HviTUHE8aKnuL56S+dxumbIfZJd
 JruNLaR9hP1f/Eb50KJjmJLLUTdMxFUNYx/+V/R5QgfweT8f2i7N/nYKVyfdV7PPZhpU
 zRDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH4Gido9VNJpf8IYTglFPHtRO8iujAGDaeqjFeqzekMkYtF5u8AxrygHucirGo3SZW+48Vc9xQuvr2Sdy9gBEQMop2n1k=
X-Gm-Message-State: AOJu0Yx7vgqa4KX82t1aIS0EcnpuTFgkt1yKkV9aRE/MkcfZ71n+k5g4
 +REZKWO5DbpNPJw90yyWfUXfu5SYWWQzH26+akPVtLuVks8GRan3KyAt0kPYSCI+2R6Wj8Cj1Up
 ycYCpmIilQms0TxLaKZYhB86MbSLzyFFj3Z+ElQ4O4hWmn5axJQap
X-Received: by 2002:a17:906:dfe5:b0:a46:a929:8432 with SMTP id
 lc5-20020a170906dfe500b00a46a9298432mr4558659ejc.4.1710925123382; 
 Wed, 20 Mar 2024 01:58:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe8y4Fy2LR8hpIO7lRb98twjhHE8d8mXCCtRkO7HKN7qyZkazprV2HxDS+OdjlvFLBc7gorw==
X-Received: by 2002:a17:906:dfe5:b0:a46:a929:8432 with SMTP id
 lc5-20020a170906dfe500b00a46a9298432mr4558644ejc.4.1710925123064; 
 Wed, 20 Mar 2024 01:58:43 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.googlemail.com with ESMTPSA id
 g17-20020a17090670d100b00a46a04d7dc4sm5104428ejk.61.2024.03.20.01.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 01:58:42 -0700 (PDT)
Message-ID: <af9cdba4-ef07-4b91-8371-94f3f3b46812@redhat.com>
Date: Wed, 20 Mar 2024 09:58:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 32/68] hw/virtio: Add support for VDPA network simulation
 devices
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Hao Chen <chenh@yusur.tech>,
 Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
 <cd341fd1ffded978b2aa0b5309b00be7c42e347c.1710282274.git.mst@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <cd341fd1ffded978b2aa0b5309b00be7c42e347c.1710282274.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/12/24 23:27, Michael S. Tsirkin wrote:
> diff --git a/include/standard-headers/linux/virtio_pci.h b/include/standard-headers/linux/virtio_pci.h
> index 3e2bc2c97e..86733278ba 100644
> --- a/include/standard-headers/linux/virtio_pci.h
> +++ b/include/standard-headers/linux/virtio_pci.h
> @@ -221,6 +221,13 @@ struct virtio_pci_cfg_cap {
>   #define VIRTIO_PCI_COMMON_ADM_Q_IDX	60
>   #define VIRTIO_PCI_COMMON_ADM_Q_NUM	62
>   
> +#define LM_LOGGING_CTRL                 0
> +#define LM_BASE_ADDR_LOW                4
> +#define LM_BASE_ADDR_HIGH               8
> +#define LM_END_ADDR_LOW                 12
> +#define LM_END_ADDR_HIGH                16
> +#define LM_VRING_STATE_OFFSET           0x20

I cannot find these constants in upstream Linux (what will be 6.9). Is 
there a tree that defines these constants, or should they be moved to 
include/hw/virtio/vdpa-dev.h (or something like that)?

Thanks,

Paolo


