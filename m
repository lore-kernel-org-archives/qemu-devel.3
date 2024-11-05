Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B910D2B92F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 14:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8KOd-0002mN-DI; Tue, 05 Nov 2024 09:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8KOb-0002lc-Ew
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:19:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8KOZ-0004QW-Je
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730816338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N2nlu233cwqrEjQLxq1CdJEMNFrjZAKLO6cV72d2YWg=;
 b=eHOCb9eQNYrO9qJ05CU/2GkNRgcY/nZQef4ZgkongIaY/EkZLARHUECRLvXk7Rozohtw/7
 sNVmGTVre/0ZM8FQlxdV3FBizRw5/5h8Zp/dyC9IdtkZFiQyV6Gz+/qesBOfO5caXujkJb
 TvS0+DGjJjOzW1xgfElupKuL+tJ3UiE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Qw6ml4xBPaKbpsV9d2zr9w-1; Tue, 05 Nov 2024 09:18:55 -0500
X-MC-Unique: Qw6ml4xBPaKbpsV9d2zr9w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43151a9ea95so35894665e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 06:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730816334; x=1731421134;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N2nlu233cwqrEjQLxq1CdJEMNFrjZAKLO6cV72d2YWg=;
 b=c5NZM1r1RKPkB5v5g1PmbO0Yah2cAWflv2CIJboR+V4ATYJ9R8XgZqWoI2/0lPAOUm
 /2haM6wYGMoW/1NBUod1CGeN2iGd6Y+lJMlPwmBhnRKxWZ4Erts0GPOq+5Jc6xiXDXk0
 NNR9x6jpfDcvLeO5AR2o0qlK6mFTd34m2sQg8/wsTrYQdPk+yMIknSgaJizDudv7/UU8
 ayBkh0hMw7suWOEASp9C4+9G0xcBRpYO8dv6Ybxju5wJaKE7Ig71ar6zo3WT5QVG6/rE
 Qw6uXZotMyX18oLzCJGOkAUlPyhIcrWPJon95bQKb0qRBtFlDfwgqhUGaavj7mHD8ok+
 6U1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+Jf+C1P2AsvmXhMYJOP5Ii7n4X5p7zHRq4h3EXlJFtEycC5e7w87QGIF/Y88zBYXhmql0X3lYkao+@nongnu.org
X-Gm-Message-State: AOJu0YyWzhRtKqPprtsqMA2BQdpXGS783nC23Zb2bCJHp7jho7d+r/VN
 E/93SKAPrZtQVIVMlPxSy8DL0jGNs5f8YWYdOHbkFdE4w6nSkWiMaTaXcev2WW8Q8hSGnykXsLB
 cc06hM+x8+dBCr9n/BNMUf+x6HcSXKAKPzb9XBojIei6cUEhtzgE0
X-Received: by 2002:a05:600c:3b93:b0:42f:84ec:3e0 with SMTP id
 5b1f17b1804b1-43282ffedf3mr140804155e9.9.1730816334324; 
 Tue, 05 Nov 2024 06:18:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUcsnJLz7v2J8ANf+TFGoB7IsCctItr0AStMIIIJyPYpmGTgJQL+MaC3KT44s4e92DrW42Tg==
X-Received: by 2002:a05:600c:3b93:b0:42f:84ec:3e0 with SMTP id
 5b1f17b1804b1-43282ffedf3mr140803915e9.9.1730816333934; 
 Tue, 05 Nov 2024 06:18:53 -0800 (PST)
Received: from [192.168.10.28] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4327d6983c2sm195472605e9.42.2024.11.05.06.18.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 06:18:53 -0800 (PST)
Message-ID: <eae65cf8-af71-4b6d-8bfb-b22224f8496b@redhat.com>
Date: Tue, 5 Nov 2024 15:18:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] hw/net/xilinx_ethlite: Only expect big-endian
 accesses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-13-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241105130431.22564-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/5/24 14:04, Philippe Mathieu-Daudé wrote:
> The Xilinx 'ethlite' device was added in commit b43848a100
> ("xilinx: Add ethlite emulation"), being only built back
> then for a big-endian MicroBlaze target (see commit 72b675caac
> "microblaze: Hook into the build-system").
> 
> I/O endianness access was then clarified in commit d48751ed4f
> ("xilinx-ethlite: Simplify byteswapping to/from brams"). Here
> the 'fix' was to use tswap32(). Since the machine was built as
> big-endian target, tswap32() use means the fix was for a little
> endian host. While the datasheet (reference added in file header)
> is not precise about it, we interpret such change as the device
> expects accesses in big-endian order. Besides, this is what other
> Xilinx/MicroBlaze devices use (see the 3 previous commits).
> 
> Correct the MemoryRegionOps endianness. Add a 'access-little-endian'
> property, so if the bus access expect little-endian order we swap
> the values. Replace the tswap32() calls accordingly.
> 
> Set the property on the single machine using this device.

I don't understand.  This machine type is little-endian only and 
expecting inverted accesses, isn't it?  Therefore, all that you need is

> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_BIG_ENDIAN,

And removing the tswap altogether.  The big-endian petalogix board will 
start getting "correct" values (not swapped anymore).  That's a feature, 
not a bug.

Paolo


