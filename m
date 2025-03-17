Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51336C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuCUR-0007Ce-MZ; Mon, 17 Mar 2025 11:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuCUP-0007Bh-Gh
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuCUN-0005AM-Me
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742225689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oERTspZ/fsJTWWF/rMl4Hx2sAbik4O4BpKUmYlKBips=;
 b=FsOM2FjNOux1AdALz0kr2nPWXufIlGw+TisjWCnMP44VFw+R4Q3mr+R+7jpEvWR2pUSJuF
 0/YidhF9t0XzLk9MsFCBrneyso3i9WAI12Q23X69S5mTKsOePdNr0Q3xtguGs3Lla9yu2G
 /6DObdIEvIcPicvdd+jm9e76qo53q/M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-3pPg5YCBO2eZSbhPPPko0A-1; Mon, 17 Mar 2025 11:34:48 -0400
X-MC-Unique: 3pPg5YCBO2eZSbhPPPko0A-1
X-Mimecast-MFC-AGG-ID: 3pPg5YCBO2eZSbhPPPko0A_1742225687
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39149cbc77dso3014943f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742225687; x=1742830487;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oERTspZ/fsJTWWF/rMl4Hx2sAbik4O4BpKUmYlKBips=;
 b=un0CqmonHwYlbXe8RAPy6MupO5pATP4/HT+EEpeB4QcInI1KdQf4lwRLSruaQkf3ho
 fK8O2D+tFh13A8g6KFu/SoJnThnL1iTbnS0rfP0RlDqfyVO69+o0u+oM9RIZAw+gEOp+
 1a5RWHGXXz9/y7p98GKdnz+QCMWHtUYgle5m+nVZnUKcE2NBSknoa85Cq0ZCMOKirhgX
 /caL2gMbjTpe9GBd7yIpeTm0PIqMCiyw3JzVoNvrMfcnnGkCtl1Kh9kR5zSpVZl9s/eg
 wYQoBvGFlEWzV+whnXQTc6iLFL9l7ZPYJa2XWgPq6NM6J5g8xHUhEph2oQ/SCc+9jmL+
 Wuvw==
X-Gm-Message-State: AOJu0YxRtvIoVMjK+uwaQr/gPCQXviMTcqfJjPSOwc2pnFA0L9CHB+bB
 XuzAvbvRsw8HYU4XW0eiHvVR2RU6S6QGTm6RSnP+ON0E6Gsfrq0RHq56v4z66GP8ta9vCecshiw
 4T9oumC0GNYNVv1fQ4kjM7IbZD7t00mgNsFhh1MP3Up37OF7onrh1zS2q0UEcH/TVNpxb8Xtgo/
 eKnt/BGsT94eaybHJ8hUU4unSG4M4TGx8w
X-Gm-Gg: ASbGncvvZyEyIivCoFjqw0HxqkpttTD/EffeA7oQJ4JGo5VYEr7pKFPzPwXEHk4Gmh/
 w8BK/Vu9RSCPPgufKoSBHeU3ekzghNsAxmT/3wSFiEyqPfdDYrvutL+IbZ+OUnwP9LFMcV1m60z
 ezSTSs90cSk5O5h1+O9LPwlEypYQidHOmIBSxhFsrBr88lx1JcELXvAzs5eM44Lsr49l8a7PVzJ
 Q3e8OSkqdq7WFsZfQe7eATSU56SqvmNY+deUTCmlMt7uyuEEWx4VvB9kF+Pu+43Q9/4Fu1zrHaL
 F7Ivfk378tq2CV1u+NX0X9WpoyUE1KJ5bHw3hWqftfh+VRc=
X-Received: by 2002:a05:6000:1786:b0:390:ee34:228b with SMTP id
 ffacd0b85a97d-3971e876832mr15447701f8f.24.1742225687301; 
 Mon, 17 Mar 2025 08:34:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1GmEs8XdhAy+PBYCjd1XKtbE6SX7414FcG26O5n6Qq9ULG6qQ3/pbUjZ4klrO100aO4S6vQ==
X-Received: by 2002:a05:6000:1786:b0:390:ee34:228b with SMTP id
 ffacd0b85a97d-3971e876832mr15447678f8f.24.1742225686921; 
 Mon, 17 Mar 2025 08:34:46 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de.
 [109.42.51.207]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe2a2c8sm108366595e9.23.2025.03.17.08.34.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 08:34:46 -0700 (PDT)
Message-ID: <98156415-9413-480d-8037-2e9b8824f7b4@redhat.com>
Date: Mon, 17 Mar 2025 16:34:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio: Also include md stubs in case
 CONFIG_VIRTIO_PCI is not set
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>
References: <20250313063522.1348288-1-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250313063522.1348288-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 13/03/2025 07.35, Thomas Huth wrote:
> For the s390x target, it's possible to build the QEMU binary without
> CONFIG_VIRTIO_PCI and only have the virtio-mem device via the ccw
> transport. In that case, QEMU currently fails to link correctly:
> 
>   /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-virtio-ccw.c.o: in function `s390_machine_device_pre_plug':
>   ../hw/s390x/s390-virtio-ccw.c:579:(.text+0x1e96): undefined reference to `virtio_md_pci_pre_plug'
>   /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-virtio-ccw.c.o: in function `s390_machine_device_plug':
>   ../hw/s390x/s390-virtio-ccw.c:608:(.text+0x21a4): undefined reference to `virtio_md_pci_plug'
>   /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-virtio-ccw.c.o: in function `s390_machine_device_unplug_request':
>   ../hw/s390x/s390-virtio-ccw.c:622:(.text+0x2334): undefined reference to `virtio_md_pci_unplug_request'
>   /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-virtio-ccw.c.o: in function `s390_machine_device_unplug':
>   ../hw/s390x/s390-virtio-ccw.c:633:(.text+0x2436): undefined reference to `virtio_md_pci_unplug'
>   clang: error: linker command failed with exit code 1 (use -v to see invocation)
> 
> We also need to include the stubs when CONFIG_VIRTIO_PCI is missing.
> 
> Fixes: aa910c20ec5 ("s390x: virtio-mem support")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/virtio/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index a5f9f7999dd..cdb1836580d 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -89,7 +89,8 @@ specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
>   system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
>   system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
>   system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
> -system_ss.add(when: 'CONFIG_VIRTIO_MD', if_false: files('virtio-md-stubs.c'))
> +system_ss.add(when: ['CONFIG_VIRTIO_MD', 'CONFIG_VIRTIO_PCI'],
> +              if_false: files('virtio-md-stubs.c'))

If there are no objections, I'll take this for my next pull request to fix 
the building on s390x without virtio-pci devices.

  Thomas


