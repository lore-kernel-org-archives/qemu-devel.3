Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCF4CAC588
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 14:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvcfA-0000n2-MP; Mon, 08 Sep 2025 10:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvcet-0000YF-Ua
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:15:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvcen-00005g-Lb
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757340941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ewvUTHg4npejcx2GKhTHbwQ3z+wOBpIN5iKEqdMOebo=;
 b=hXxwhE179iOL+ZuuIMlPUox0K3FbKYeLnefVCX527tLpMymJ6NOfUAfhLpBFcDBcuigCm6
 BqitSuyBXgrINMnTPZKItszMTyEnO4aQXoAEPgc6TyXHGxe4j0r4cNWEbDXCBVvtovwxDC
 pXTKk3kEh71h1iVLKQ5klY+EWBmPYPk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-c0HAUtTuMH-OP1KWBU749Q-1; Mon, 08 Sep 2025 10:15:39 -0400
X-MC-Unique: c0HAUtTuMH-OP1KWBU749Q-1
X-Mimecast-MFC-AGG-ID: c0HAUtTuMH-OP1KWBU749Q_1757340938
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45dd66e1971so29663305e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 07:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757340938; x=1757945738;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ewvUTHg4npejcx2GKhTHbwQ3z+wOBpIN5iKEqdMOebo=;
 b=j6UK94JSDaDaLzsjphx0Xsj4pQQMNGR5B5jyBieTgf0vsxAtyQhAV5iqE2c1mQvsYi
 iEjW0uH7fvSUgtKG6df+azLQGSk/3oeYTvGaYizljPrqkbbLH6fUmyQLcm8vDHLJT8Lg
 UqU891bq3poNSkz14znwUe/WBpqETWrE7DpnQhg2dwtNRBFgojlktUgK6YkdUDNtRQJj
 0dggyHowdqA9M/aOheDH+bZLfOBx3xbRFCNDUfIMHXWvh4w1NfPbzE3L7AfirDoPLzFm
 ZCcH3WSKYiYcIjhw+iOcSndRMHXseRgzZKm3MjxXudImPrDjT0kEZM0nBs7/B7rnryB8
 5SmA==
X-Gm-Message-State: AOJu0Yz/lb0wMuzSeejgtLaS9btxkzBsTi9X0xflCAZY+pwSg4ilZhe5
 40Et8tRDPOQEE2avz39nKiDl4YGuKx8Gof9OzrL+5KmsPkjSHoTExLVpXrhO3YeeGmsUQwFD97o
 Krvogd5kXeVGTJjXE9RaQK253hxQVwFmZXBowwWgqciWald8UNLpV9+n2/9rbKRZNXxp8ZsVXzh
 zYv2zRqT9GDx//h5fV0DENlWWQEVgwBrNp/A==
X-Gm-Gg: ASbGnct2Z899/v1GPvvK6r53xx2JvLspKSXLCFOW3J++bwed3avr0QuET4svIWX05EM
 D2HJRnHw82kJ1KvWrOur3RxYzKJ/UgwafwgC5RywZHS+NcfcGqFcCk0JKIsjPlUIre+OgAbn+rt
 +JKERyGxCBeV1mIt2cFOkNAKCLMTWht5lWDrehgkYkzFl0QhxJZxVvKdk+/hFVbr74NFIzkbKJU
 33Znjvg6XXZBJvZRfiiN+qjZup1VpuAO8K4MBX+NuELisOEs5lq+1v4fZUveDdjXJ7XHd42ONfY
 fPOUAUYAJa4oDxV1QmhFOtntsJYzLA+MCJ3ohcHSrMTLcAq54jRslIh2StOrNie90oD9TqOMba7
 0xSw=
X-Received: by 2002:a05:6000:1acd:b0:3e4:f194:288f with SMTP id
 ffacd0b85a97d-3e643e09089mr6249390f8f.62.1757340937683; 
 Mon, 08 Sep 2025 07:15:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/dVVz82JJ34EiHf5l8BX/a3WKjr6nCwAoT/HSu4+rwFfxL5xm93r7kKePCImLgS9zA7xUsg==
X-Received: by 2002:a05:6000:1acd:b0:3e4:f194:288f with SMTP id
 ffacd0b85a97d-3e643e09089mr6249355f8f.62.1757340937193; 
 Mon, 08 Sep 2025 07:15:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e74f848b10sm428857f8f.34.2025.09.08.07.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 07:15:35 -0700 (PDT)
Message-ID: <2990436e-e623-4daa-bcb1-6c6e03954ee1@redhat.com>
Date: Mon, 8 Sep 2025 16:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Report an error when the 'dma_max_mappings' limit
 is reached
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20250814153419.1643897-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250814153419.1643897-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/14/25 17:34, Cédric Le Goater wrote:
> The VFIO IOMMU Type1 kernel driver enforces a default IOMMU mapping
> limit of 65535, which is configurable via the 'dma_max_mappings'
> module parameter. When this limit is reached, QEMU issues a warning
> and fails the mapping operation, but allows the VM to continue
> running, potentially causing issues later. This scenario occurs with
> SEV-SNP guests, which must update all IOMMU mappings during
> initialization.
> 
> To address this, update vfio_ram_discard_register_listener() to accept
> an 'Error **' parameter and propagate the error to the caller. This
> change will halt the VM immediately, at init time, with the same error
> message.
> 
> Additionally, the same behavior will be enforced at runtime. While
> this might be considered too brutal, the rarity of this case and the
> planned removal of the dma_max_mappings module parameter make it a
> reasonable approach.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/listener.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
Applied to vfio-next.

Thanks,

C.



