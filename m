Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E24C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 09:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsIaO-0005HS-Nr; Wed, 12 Mar 2025 05:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsIZm-0004Oe-DS
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 05:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsIZh-0001E4-2A
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 05:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741772425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/siIg2usJhb6RLPIfveSTTjrYwyD1LG2BZiyr5XU6hY=;
 b=fwvhGlCBLPSx10qe18sB2dJ73ENT5RRMgeuiiHGXtCdiBVAqL6r0RZI6G08OW3vKrlb7Z1
 IWpxbbM3mHo5QGSFqaAFttjRXwOldM+wY/tr/EJPx+T+2d+s541LS3bTkvuB+fSk5DlZYI
 2ekwzgHyjzNR0kKKSS1hsa8HSDINvMY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-4EUBL-6JOp2IBB6eoGqx4A-1; Wed, 12 Mar 2025 05:40:22 -0400
X-MC-Unique: 4EUBL-6JOp2IBB6eoGqx4A-1
X-Mimecast-MFC-AGG-ID: 4EUBL-6JOp2IBB6eoGqx4A_1741772421
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so3160045e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 02:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741772421; x=1742377221;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/siIg2usJhb6RLPIfveSTTjrYwyD1LG2BZiyr5XU6hY=;
 b=bU3XAUXAtL/yciCGO+kmyg9zdEr1QMXjKOpri/+9NI1K3HfqTKd5IFtRGWJhPgUE1v
 XSdSCI3317ls68+QLrwkfYmjeIvUuu1rnU2LtdzN2PDjFFYyyrRt0h0UUucwVBzZLTKY
 cEz55xPB4xfJ4DKDDpvzIExSDbzhcKfH0gvwRWa40qgySaITPA75NLfYXckEByS++tb/
 jgsE4Rf0t07tEwN/NF9/Ezbrj/1eh+kO3b6v3zskp5UxSFEi+//nsUP/iVh2ObWZlJOQ
 Zxzdx2hPWQK9Z5hCDLr8vDjZ/4HkM+84nCtGkiUSMQoGC9oG/js3w54fKL7JjGfVmUxK
 ECfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ/TH0R0zN+LK0G6+61V7H5zBK7sFsEt1mkwAhmdLfDZXAWh3MCddYgqliXbpI55euPOGXkMjUsqHJ@nongnu.org
X-Gm-Message-State: AOJu0YyU3/SQZ53bMhiuj6XeDVicRB18Bh0c9K7kCBuoDrKjD+ZNwjWY
 rf0y/mW8v8Z5ka30aUwJd9AgoNWfVtioXyMACLdtOjLD5OsgCxs6XoF4fe7AEX6bfUMo3VRue1e
 UU/ohCupSSY02lWMAuBfNXU4BuCURYUoLTwlnd23/+s4Z3RM2ICXW
X-Gm-Gg: ASbGncv5/3DYPylKgiSMzHm726UDg71leVzWZNn6D1VV+rt0rldMV+hhUPRL4MSiu1i
 0bHuZNW9zZsM4hdFpceIMFGAYMBFw+idc6gDnFi2Br4tEVtDWjZ5mwsab1r2FAtDv/IOqUW83C0
 e1J3DYI8VuUVHBKc5Lq48x6zy0NMY+U1oy0NJzn6lXs8qbAsUgFOMzVqnZwoBR+b5GzwVXjlsSb
 HZzFZX5pdaI+MTFu9V8vNDEqcdIURiJR63M2YS7R63aOo/3kfCr/F/qsrlkq8ACmtujKskbTq4B
 t/zATd8EzCaGpB6ba1MjYhr+4g09VLruNYceIyJVLwViqQM=
X-Received: by 2002:a05:6000:402a:b0:38f:5057:5810 with SMTP id
 ffacd0b85a97d-39132d6e9c0mr18844619f8f.25.1741772421456; 
 Wed, 12 Mar 2025 02:40:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5lpUA9bpfBrKViqeXkzeAMyf++xIN0uB2lAzx9dCRXSr1i6ryKbApUjDHp/lWfyTYPnwu4g==
X-Received: by 2002:a05:6000:402a:b0:38f:5057:5810 with SMTP id
 ffacd0b85a97d-39132d6e9c0mr18844603f8f.25.1741772421112; 
 Wed, 12 Mar 2025 02:40:21 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-149.web.vodafone.de.
 [109.42.51.149]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a7310f7sm15662625e9.3.2025.03.12.02.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 02:40:20 -0700 (PDT)
Message-ID: <1cdb6643-8fcc-4bd8-93fc-fcc93589c9a3@redhat.com>
Date: Wed, 12 Mar 2025 10:40:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 31/43] hw/arm: Add i.MX 8M Plus EVK board
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
 <20250225180510.1318207-32-peter.maydell@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250225180510.1318207-32-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 25/02/2025 19.04, Peter Maydell wrote:
> From: Bernhard Beschow <shentey@gmail.com>
> 
> As a first step, implement the bare minimum: CPUs, RAM, interrupt controller,
> serial. All other devices of the A53 memory map are represented as
> TYPE_UNIMPLEMENTED_DEVICE, i.e. the whole memory map is provided. This allows
> for running Linux without it crashing due to invalid memory accesses.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Message-id: 20250223114708.1780-5-shentey@gmail.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> [PMM: drop 'static const' from serial_table[] definition to avoid
>   compile failure on GCC 7.5]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
...
> +static const TypeInfo fsl_imx8mp_types[] = {
> +    {
> +        .name = TYPE_FSL_IMX8MP,
> +        .parent = TYPE_DEVICE,
> +        .instance_size = sizeof(FslImx8mpState),
> +        .instance_init = fsl_imx8mp_init,
> +        .class_init = fsl_imx8mp_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(fsl_imx8mp_types)

  Hi Bernhard, hi Peter,

this device can be used to crash QEMU quite easily:

$ ./qemu-system-aarch64  -M virt -device fsl-imx8mp
**
ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread: assertion failed: 
(n < tcg_max_ctxs)
Bail out! ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread: 
assertion failed: (n < tcg_max_ctxs)
Aborted (core dumped)

Should it maybe be marked with "user_creatable = false" to avoid this?

  Thomas


