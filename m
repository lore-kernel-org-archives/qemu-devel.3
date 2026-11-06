Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E61A606A32E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TtD3RxP3;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Mg6iPi7D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPIhm-0003xU-Vi; Fri, 06 Nov 2026 07:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIh5-0003u4-EY
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:05:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIgz-0005ie-Vz
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793966709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hyjqns5htKUY+IJdSt0djEtUfWUXLubOS6si5Rd/Xhw=;
 b=TtD3RxP3GMn3Jf07ZTemT9EPtQhdYNAUTAPXsWnwsOBqKj4+sLZynV3eBkz6JQGINlE2l8
 Nt406eeNFvDU4SkJsKMKng2X/XnoJgRkDo16EpwlR1Ar1DpipTaB6U2OxIzlvhHfe+1Bos
 XAa3vLN9sZAfZPpVUnPvHkuwqZi6TRA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-hYtHTZg8Ocm-KFb0LZLRCA-1; Fri, 06 Nov 2026 07:05:08 -0500
X-MC-Unique: hYtHTZg8Ocm-KFb0LZLRCA-1
X-Mimecast-MFC-AGG-ID: hYtHTZg8Ocm-KFb0LZLRCA_1793966707
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4901562b819so646006f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 04:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793966707; x=1794571507; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hyjqns5htKUY+IJdSt0djEtUfWUXLubOS6si5Rd/Xhw=;
 b=Mg6iPi7DrppGNFIwEZ3eINzLI9H6Wt/ILmGGrS0PFwfiT/d2WhnZi2co8+68gIDDSN
 Sf9ADkc5wCQZ2ntSbpHsxeQodyo2DUxqXEQ74gt8Z2c+P7DpDA27PsMuaHENR16QNZ1j
 bKDmiMgX1p8gDPFDv4BAfOUI8/W99mje13neh3sgPq6i/1xuY15Cw+88yhie7/eX6WaW
 F5u6j/mIu6jk1DB2QSgOEnLk9L7DuQaCJQQWw9aIWTDoCEjfPlVQRMjSArr0KLRVH4AC
 L6FQPeg9mzk4axthXHQ+sv+uN/iBf4WKzv9ARNm2bVPhWqPWNqcMedOlr5FRoDiSZobD
 5MJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793966707; x=1794571507;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hyjqns5htKUY+IJdSt0djEtUfWUXLubOS6si5Rd/Xhw=;
 b=vrtxClfwGcxYW2JnVjc5qzVJkTdKyP1OoixTshnmhU/Wg3wNdAq0Rs75DtcZSXDjAj
 wk6hniK0BvdndUtfFWWfEwfjbvYRqNakZ2lmk/TOdshF6WN/Om8DoMJ+/LBNoFqli+Lk
 1V/Lp2ohgwZW7KYdYAwWBj38aKGg/0MJSph3KSDDhfhQnUy9lxiseVIL4rVgqUkSmxrm
 vRlaFLSkHZTvaiX9XNbDkZmGAHp2OdnWKmL4F8SxD0AAMXrYl2WzEnZ0D9ecPYLBjpos
 RWmFnQ0m7sY6xzI7/gG/hw8tG+rEWp6n/dKWsSwyCiyqluxKN3PfrLcnQU0NdVyDYXc+
 Dm/w==
X-Forwarded-Encrypted: i=1;
 AL+hErGEdo7TrGrF1duTSkVFNkXnAynsYHV5AtO5icYO8WlclvHyBuRwXJKckV9siLpbLWfitvN926xrwKCm@nongnu.org
X-Gm-Message-State: APuU4Z/Xuih6+xlX7H/gIh4OPN23IYejpi0N1oahlvdN/dmPGPneDD1B
 JRvxKWY3z2zdRz3GZEeRISCBj3gXOHFmgdCN3QIiu1t9GvbTX+0c+W4r21j78kYCijN42AZkJmF
 PgWwNzRB9PvcvAK7bn79wHrkUfp3D+bB+kZba3g5zRVLOcxgKQzD/X+xb
X-Gm-Gg: AYBFou3n7qjQkhExp622fvh1qZj6QF/9fTih0J45VaQrk3GMoNniLVcrkraYs3RDGyJ
 8bULfk5vgPJm1LeDi3G2QuMlWW2AZPkmzB3eAgTysz/X1eXcckpQuL5MSVFf0yMz47MZS2Hfs8b
 9HUcnd0UEsAEtPa0PFC+aibolOLEYQEvJh2fCzRPEAQlfOeaxc8vSKPftdMVHtKfDNI53IEhkee
 tFl7+VKkpIXzUSIwdmm+OMOVFTW+ykHNdS7UGKSLXk+TrJigSkBis5ziAG13LjO+pjoSAd16WgR
 MEprbwPA9s1o2DgiUzvLY7owRL6UTLgXEzAk7bvJ+dN7axUHMMSpiFbl1hFBykMj1KzsJepqtiF
 k3rIOecNe9JZXBgT+nBWsPkG9HpUMXKrB4+ClcPCGhEcHiw0CVIU2azLceA/qS9AzpkJ9I4JzCO
 eetbATBVg+qg==
X-Received: by 2002:a05:6000:4549:b0:490:1881:80ec with SMTP id
 ffacd0b85a97d-4927702e23bmr3389082f8f.36.1793966707306; 
 Fri, 06 Nov 2026 04:05:07 -0800 (PST)
X-Received: by 2002:a05:6000:4549:b0:490:1881:80ec with SMTP id
 ffacd0b85a97d-4927702e23bmr3389028f8f.36.1793966706841; 
 Fri, 06 Nov 2026 04:05:06 -0800 (PST)
Received: from ?IPV6:2a01:599:b03:7322:436f:1f3:b26e:91b8?
 ([2a01:599:b03:7322:436f:1f3:b26e:91b8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d72333f9sm3395074f8f.29.2026.11.06.04.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 04:05:06 -0800 (PST)
Message-ID: <31de7814-4be9-4224-9659-854cdffe409f@redhat.com>
Date: Fri, 6 Nov 2026 13:05:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/28] hw/usb: mark commonly used USB devices/hosts as
 secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-9-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261029131241.2275706-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/2026 14.12, Daniel P. Berrangé wrote:
> Modern virtualized guests are expected to be deployed with the
> XHCI controller which supports all of USB 1, 2 and 3, so should
> be declared secure.
> 
> The "NEC" XHCI variant is slightly non-standard, but since it is
> a trivial sub-class of the generic XHCI, there's no reason to
> exclude it.
> 
> The set of devices that are expected to be used is HID (mouse,
> tablet, keyboard), host passthrough, CCID (smartcard), hub,
> storage and the redirect tunnelling.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/usb/ccid-card-emulated.c   | 1 +
>   hw/usb/ccid-card-passthru.c   | 1 +
>   hw/usb/dev-hid.c              | 3 +++
>   hw/usb/dev-hub.c              | 1 +
>   hw/usb/dev-smartcard-reader.c | 2 ++
>   hw/usb/dev-storage-bot.c      | 1 +
>   hw/usb/dev-storage-classic.c  | 1 +
>   hw/usb/hcd-xhci-nec.c         | 1 +
>   hw/usb/hcd-xhci-pci.c         | 1 +
>   hw/usb/hcd-xhci-sysbus.c      | 3 ++-
>   hw/usb/hcd-xhci.c             | 1 +
>   hw/usb/host-libusb.c          | 1 +
>   hw/usb/redirect.c             | 1 +
>   13 files changed, 17 insertions(+), 1 deletion(-)
...
> diff --git a/hw/usb/dev-storage-bot.c b/hw/usb/dev-storage-bot.c
> index a7f8d80c17a..b156f1c5c9a 100644
> --- a/hw/usb/dev-storage-bot.c
> +++ b/hw/usb/dev-storage-bot.c
> @@ -52,6 +52,7 @@ static const TypeInfo bot_info = {
>       .name          = "usb-bot",
>       .parent        = TYPE_USB_STORAGE,
>       .class_init    = usb_msd_class_bot_initfn,
> +    .secure        = true,
>   };
>   
>   static void register_types(void)
> diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
> index 977151c4a08..7e0699cb518 100644
> --- a/hw/usb/dev-storage-classic.c
> +++ b/hw/usb/dev-storage-classic.c
> @@ -133,6 +133,7 @@ static const TypeInfo msd_info = {
>       .parent        = TYPE_USB_STORAGE,
>       .class_init    = usb_msd_class_storage_initfn,
>       .instance_init = usb_msd_instance_init,
> +    .secure        = true,
>   };
Can we exclude usb-bot and usb-storage from the secure list? I've never seen 
them really being used for real virtualization installations, and I think 
they are not that well tested?

With those two hunks being removed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


