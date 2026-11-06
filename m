Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DA960A5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PXqHEfmD;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ma+YvLhl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPIEc-0004RK-S6; Fri, 06 Nov 2026 06:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIEZ-0004Pe-ET
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:35:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIEX-0002Rs-3m
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793964948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XTajrIAyKDOfB2dwO4EMUMbtjLgSZZ0pwZiKHhcN05A=;
 b=PXqHEfmDeGMDUIcgYBoWFZdzJaRPxtir++tXiaq+pr8noeDwVW9hs+xwXrkLNe6+0sTR1E
 ZZ8d74ILpFgYXrtVD4U4Shh5R1dRMiySaynAIvqgePhf9D2juifNSORIoGuj4uGGszveSY
 LZeIHh8cycembx79B6UzYYbXKoJ8mvY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-ZK2lY6_xMF-YC1DBVGyhRw-1; Fri, 06 Nov 2026 06:35:45 -0500
X-MC-Unique: ZK2lY6_xMF-YC1DBVGyhRw-1
X-Mimecast-MFC-AGG-ID: ZK2lY6_xMF-YC1DBVGyhRw_1793964944
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a214a5f8a1so6250565e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 03:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793964944; x=1794569744; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XTajrIAyKDOfB2dwO4EMUMbtjLgSZZ0pwZiKHhcN05A=;
 b=ma+YvLhli6jB0xD7CT2eCRxMWS1Ct5O4xLvLv3lUCdyip6i8ETP5da1Qq/anAWv+Oz
 ZN18T6U95sbOCOyZHd8XCQZTcQkTkfG2qllRL+sbweufYv+KG7hY+oT/+NJg45sFOoX1
 TbUVahM9dr+iovuBtb4c3lN5cuMUseLaT1DlN217D3hX51pwCVfCQMKYkEpiZhbKc1qv
 oibIsAQOapKj2x/kVdE269EXGhA+L6EJ9oQa8IeEd+Vlhr1Gd0pdEMbH2D3MS/K0hOXd
 lbpOqYDgA8xt5DEPrATXiA2NzYGouW+dtxIm1nVBEieddpo2g//uuT5W8K1JGUJPAGd7
 iVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793964944; x=1794569744;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XTajrIAyKDOfB2dwO4EMUMbtjLgSZZ0pwZiKHhcN05A=;
 b=UdqXXjgFpibYNymz2qKx3x3HOPkdJCb2V63HCJKBhs4R7h0erXOK+KDCXyQICIpnuU
 aUFpkJaITG0sdd1WbdrncqT4+YDgOTmF/jA+ITZOYCAZkg4GXp5fWt+hJ/uZoUz0xOQJ
 I5UXXr3Wx8VlMjlSqm0SKinOW65w2Fwv3yjXNsxiNHF2A1l8fzkc+xrgiqGheZK8hZnQ
 N1wLHj3h0tkquPl/VCFasSmzCxmnynsYi5lC2EGBI4REBp7y8rieh+f1ETzdCP+BsxRn
 Shj64PyoTIQeR1LtR+ULk5bZzJLbggJ/pq4Z9xJdC/cHvg3a00BT+56178KxAQRlr89G
 xWSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDKU27KGoKGzpLT2ZKAPf4ScC3RfhvXJVWMC8BLpo+BlGRKx48H2KWePswBDzuCnmldpQ6/VvgeO4w@nongnu.org
X-Gm-Message-State: APuU4Z+4Ujs0QjagZQ1Gg5NFTE4wWfgWwvIomSLZQNW3J6Pxw07XfkDS
 J62Cz7eBows35r+ovE6iwBPjV64dsB73F8JXoMi2bqz3IANcmCZQf331RVmcOSIbhd3X7cROuzW
 dABXYbSgLJwnrdcBT19riuNF+GQYC/NG2Vu3oqTDc3KueLR+ytB2MzpFK
X-Gm-Gg: AYBFou0DEI8P/6iHYkqx9zqkwr3XiJaqhacM0ZkMxqivYZrWKhmeU7Xd+Bgtv6AOvra
 pu0AQk/JCTDuCdknpkEemXzy7jl9JN5v7dXXEuo32ZXY7n6rJsvfuTccD6UFNlFL9PhZyWfIDs1
 +6NM5Lwkgrnkz//39V9eJl//b7BEgjw9I6toUEm/ofI6w2+tktM/xsdyBePsBA8nyf69tcOeZRW
 QXuKzLOT7hAEiyK5rr1nRJWGAZ6RuS9Y9r0mryIuSswK6+u8l7FevV/Fj5vAgAO4VpgAUV7+bSl
 5SI2haIZBmVimKVvlu4NkBYMKclRfLlY7KLme4YTx4tHrJpb5mWopk53I6bkdMNBva606RqBgWr
 MagqA+ExoEkYZlhzqRqFhBo6QFy7jOcamg9GMk1Fg6s7iQfi+M5rIJ/HP0gJm5FQhtcqFSTGRYX
 dxbQboe0Hozw==
X-Received: by 2002:a05:600c:4ecb:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4b6e0454e9amr35153305e9.32.1793964944182; 
 Fri, 06 Nov 2026 03:35:44 -0800 (PST)
X-Received: by 2002:a05:600c:4ecb:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4b6e0454e9amr35152715e9.32.1793964943791; 
 Fri, 06 Nov 2026 03:35:43 -0800 (PST)
Received: from ?IPV6:2a01:599:b03:7322:436f:1f3:b26e:91b8?
 ([2a01:599:b03:7322:436f:1f3:b26e:91b8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b573366ea6sm138412255e9.14.2026.11.06.03.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 03:35:43 -0800 (PST)
Message-ID: <7332fb34-656a-4690-92eb-0159f223228f@redhat.com>
Date: Fri, 6 Nov 2026 12:35:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/28] hw: mark all virtio PCI devices as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-2-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261029131241.2275706-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> These are all intended for use in a virtualization scenario and must
> provide a security boundary. This can be done for almost all virtio
> PCI devices by modifying the common type register helper.
> 
> The virtio-gpu-pci-rutabaga device is unusual in not using the common
> virtio_pci_types_register() method, so needs marking directly.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/display/virtio-gpu-pci-rutabaga.c | 1 +
>   hw/virtio/virtio-pci.c               | 3 +++
>   2 files changed, 4 insertions(+)
Reviewed-by: Thomas Huth <thuth@redhat.com>


