Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F05C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGe9-00026a-0Q; Tue, 21 Jan 2025 10:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1taGe8-00026O-70
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:58:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1taGe6-0002Li-Jv
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737475108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Biqi+HZGf/4jAY6+V/1fau6KWYfs4BVVRbGsvps+bFw=;
 b=HP2+DVh8Op7m28IaqLUPDy8s0cpCwCI5Evhm1g0kM/59xQdIFZJomVmsJweT3aHQQWppDH
 Oq7zVWc9Tqryx6YNB8POOGYZeHpp8jtNZMZ2ONWBh6qDnnFMa9wYn/qHF5yahNDHUSxm8t
 5PyTe4Y6aBkGOLArz2nQag7+sZNhIMY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-0EV3UqXIPwulef03p-kfHg-1; Tue, 21 Jan 2025 10:58:27 -0500
X-MC-Unique: 0EV3UqXIPwulef03p-kfHg-1
X-Mimecast-MFC-AGG-ID: 0EV3UqXIPwulef03p-kfHg
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab547c18515so255509366b.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737475106; x=1738079906;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Biqi+HZGf/4jAY6+V/1fau6KWYfs4BVVRbGsvps+bFw=;
 b=aXQJ3N6YJRjnIDj/h+9i8ZO7DevsxbP6003X/S+Ox9Etw60Uf64DRJefaktSjEu/D1
 ZLuKU4X1Sw0hBrb8yPBLGfvbZujKoKnRQxccNjlMkZhZkw7fk3Offdykdjxa14J43BI+
 HrabINdPXz8O0XVw+PTtKnrwM3x1kgy/A2zQ7wCfGXP6KNy/EUgEcYk1Rvx/OE9w9ZVe
 lQgzEN64a58OwLMMWwLAsKUViqswgv8OriT7y0+eZIzDY4mgM8YiNf1VXHSASZvenfZr
 RXZr9JfTolPi4bCSeEtCbRwYy06tbHJaJWuk39TN13slVH+ft0zVjaSvCaVr/Z3UPzWV
 GJ5w==
X-Gm-Message-State: AOJu0YwGGBLiGHctxUuUFfXKsdzTAyhS57L6GCC2fFow9qppaqr+gaBx
 sMGFxI/bGrKeQkebQmJAfsMAdVQ3PXNw/wC0jyJWGTUWBcjIar2+Q7NGjDD+r886iQ6gXPaD1QR
 OmP3HrQuj+n/TI9QB7cVDACZ3Qkj5XQKN7TWWGpLmPpYEj/HanMI6
X-Gm-Gg: ASbGncuengklAImxyIbBh2KjKzIRfw2boa+PqumE1kP1u88l7an474aLY+vwUJ8W+HL
 +C9hg9Jeo7m6Nqpw+GtDG4tN0+L0JF/orlTJSHc9Hx/7yizyY1M/xwoyGXj7uXM+mhIDTEMyKpl
 rDhHYndAJxiDprChuy6zy+UP2JOzDZUTsLIGZ9wNq7BEAHPqbGBZ/jvkZtkn61PdRd9ip8BkHUQ
 0dkA6sDTBznbevcv8cU3JHT6yEv3LGVXbSQec2uRUU1B/AUocSdl91xhpggNSRg6CO7x5ZfwA==
X-Received: by 2002:a17:907:6d09:b0:aa6:8935:ae71 with SMTP id
 a640c23a62f3a-ab38b0b7f21mr1641737166b.12.1737475105940; 
 Tue, 21 Jan 2025 07:58:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdU4RDNrviqmkSSPdqbbYX1sn9addc0FsY2g9H0hB6LAYlZ2O9Q32qDipIE4fY4ocXKzLasw==
X-Received: by 2002:a17:907:6d09:b0:aa6:8935:ae71 with SMTP id
 a640c23a62f3a-ab38b0b7f21mr1641735466b.12.1737475105583; 
 Tue, 21 Jan 2025 07:58:25 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ab384ce1eccsm772948466b.59.2025.01.21.07.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 07:58:25 -0800 (PST)
Message-ID: <9256513c-f42c-4102-b06d-b067d54a3f81@redhat.com>
Date: Tue, 21 Jan 2025 16:58:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/2] rust/pl011: miscellaneous cleanups
To: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=83?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250121140457.84631-1-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250121140457.84631-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/21/25 15:04, Zhao Liu wrote:
> (Resend the series since it was missed on https://lore.kernel.org/qemu-devel/.)
> 
> Hi,
> 
> This series includes the following cleanups:
> 
>   * Patch 1: Make realize() safe to only accept immutable self
>              reference, which is in prepare to introduce gpio bindings
>              [1].
> 
>   * Patch 2: Clean up `bindings::*` for pl011, which is inspired by
>              Paolo's comment on HPET [2].

Yep, me being lazy and not doing what I preach.

Queued---please forgive me for not posting again the series that are on 
the list, just with the "use bindings::foo" conflicts resolved. :)

Also, if you have to choose please review only the final 
qdev/MemoryRegion bits; the vmstate is mostly the same and the pl011 one 
has less impact on future code.

Paolo

> [1]: https://lore.kernel.org/qemu-devel/Z4h3Q%2FJBxtWxi+bK@intel.com/
> [2]: https://lore.kernel.org/qemu-devel/b107c5c3-9ee4-4939-a4e3-eff0cd92bad6@redhat.com/
> 
> Thanks and Best Regards,
> Zhao
> 
> ---
> Zhao Liu (2):
>    rust/qdev: Make REALIZE safe
>    rust/pl011: Avoid bindings::*
> 
>   rust/hw/char/pl011/src/device.rs | 23 +++++++++++++++--------
>   rust/qemu-api/src/qdev.rs        |  2 +-
>   2 files changed, 16 insertions(+), 9 deletions(-)
> 


