Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E35C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcOtm-0006I2-PT; Mon, 27 Jan 2025 08:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tcOtX-0006Gy-Mu
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:11:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tcOtV-00021p-UL
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737983472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Xb6Qt0vSU9A+XbKdS+/m/b3WKYqpnikUarpmPrKgm10=;
 b=TqYv4yaLFCP/2W1c2zHDox1mhrUZ/DFjXXQh88xUZu0i7hfYiqCo4S/kX1LiJYgIwh4brr
 30CKZzg4Lu+eIs7/u7eYFTAFqBOHAObnUO1kZBK0Xa96UOuBRXXxtsQIo2WjQxLsSZ9CDW
 ANFSV/F/10Mm+LiP1rcHLSQXWNARldw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-SFBRxveJNcG96ps4VMOmcg-1; Mon, 27 Jan 2025 08:11:11 -0500
X-MC-Unique: SFBRxveJNcG96ps4VMOmcg-1
X-Mimecast-MFC-AGG-ID: SFBRxveJNcG96ps4VMOmcg
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3860bc1d4f1so2750281f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 05:11:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737983470; x=1738588270;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Xb6Qt0vSU9A+XbKdS+/m/b3WKYqpnikUarpmPrKgm10=;
 b=p1jIyrnRvuyTUO9T+SYKumDsIAjKLnEYJGaipoeL8qh3KyLB4t7qEzX8UhRZk/+GEl
 XpJv2nFLTuAk9mbYvj+JhRX2gbl68knf0yx3j9VrCswsODqPsmhZdSb2+7MH12f5kgOk
 JLR0fiZD3s6t/JVITXZNgAPrRp8My4Nj7bXgm9h0gg8hp8TbmvcDTjH6mUbernZDsBlm
 v/vx9zV7R72bD7B/L+VEuHbCiDzYVQ3VdNC3iTGN8RYXlIs5v1Tmp3BmwxipcbDa20Et
 7dR0GI2dX7P9SCixp2lh+aLb9SvE8V9MTyZ1DJLXcIekLr20QkScuibqhIpPm+/ZwWjw
 EsTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIvBzZQ/76RYcIkOl1BevMNCDgOBNRaUGtqT4iN3S8r3h5jugRIatoO2wQB65TiOjtfu1MlVGAJ6uI@nongnu.org
X-Gm-Message-State: AOJu0YzUAhLA0pE/R4ihru9ESK934knlVbGHwP6GTW8kjwFhZBwny6B+
 5ZHWOnoCt3/Ll4MRP5ROkVM/kRrC8PkHy67k8aeChjVJXBq+YnysqEubduqDmkptayr72s5+fdv
 9YAHYEbBx7R3qkYB1ECNbdW9H8sXKxxu6t+gkHtUM6TqD+vBJ/4vs
X-Gm-Gg: ASbGncsgMFdlw5jyIt3n5i3pxPdl+w5hWvxPlkBCF9zg5wzQdAVGxLZ7shPkV7pn34G
 gijZNxEO1Q2rSFZGUGHVuuVG/QFZhfA77ovhEuVcjTZcGHi9+hWUInbG1ApxBlFG+xdHFL62uwD
 l0QBcoi9YDn+Vw0fYaLEKIU5Ns8lbiL9j+hYUrP6sBBzL1Wi4+/zmt59Rs4Jhgr7FV/BjtMDofH
 Al9gyDVOnMJiCOregcPYRSJx5IctI8mod7NLDLO5NcjWe2exgGQy0UdK1L4qG7S+DLyQvt/3s3+
 JDiyXwwcQPMAhBjGIp5s7ZOw0S7FuYDqZMgOGdQvxNaxfldvqhxFAXopCE6N4pgO87TJyI+dATe
 8URlcdKgqYsJT+Cx2YvYhu9vYsMrg64/9
X-Received: by 2002:a05:6000:1567:b0:385:fd07:8616 with SMTP id
 ffacd0b85a97d-38bf55c4d1emr37229440f8f.0.1737983470201; 
 Mon, 27 Jan 2025 05:11:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErnfJWIEtMt26DL8hBsSnvD6vA5oBHsWQjgIjZtxB63dP5OjEIK90YW+2JaRpn6AYCp7DY5g==
X-Received: by 2002:a05:6000:1567:b0:385:fd07:8616 with SMTP id
 ffacd0b85a97d-38bf55c4d1emr37229409f8f.0.1737983469846; 
 Mon, 27 Jan 2025 05:11:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c736:ca00:b4c3:24bd:c2f5:863c?
 (p200300cbc736ca00b4c324bdc2f5863c.dip0.t-ipconnect.de.
 [2003:cb:c736:ca00:b4c3:24bd:c2f5:863c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c3ec83e20sm4363993f8f.23.2025.01.27.05.11.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 05:11:08 -0800 (PST)
Message-ID: <78f810b1-3a02-47b7-bdc3-4d61cac74926@redhat.com>
Date: Mon, 27 Jan 2025 14:11:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-balloon-pci: Allow setting nvectors, so we can
 use MSI-X
To: Reza Arbab <arbab@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
References: <20250115161425.246348-1-arbab@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250115161425.246348-1-arbab@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 15.01.25 17:14, Reza Arbab wrote:
> Most virtio-pci devices allow MSI-X. Add it to virtio-balloon-pci, but
> only enable it in new machine types, so we don't break migration of
> existing machine types between different qemu versions.
> 
> This copies what was done for virtio-rng-pci in:
> 9ea02e8f1306 ("virtio-rng-pci: Allow setting nvectors, so we can use MSI-X")
> bad9c5a5166f ("virtio-rng-pci: fix migration compat for vectors")
> 62bdb8871512 ("virtio-rng-pci: fix transitional migration compat for vectors")
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> ---

This patch enables the virtio-balloon-pci device to be plugged on s390x.
Before this change, plugging that device would fail with "MSI-X support is
mandatory on s390".

However, the device does not seem to be initialized by the Linux guest:

# lspci -v
0001:00:00.0 Unclassified device [00ff]: Red Hat, Inc. Virtio memory balloon
         Subsystem: Red Hat, Inc. Device 0005
         Physical Slot: 00000000
         Flags: fast devsel, IOMMU group 0
         Memory at 4001000000000000 (32-bit, non-prefetchable) [virtual] [size=4K]
         Memory at 4002000000000000 (64-bit, prefetchable) [size=16K]
         Capabilities: [98] MSI-X: Enable- Count=2 Masked-
         Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
         Capabilities: [70] Vendor Specific Information: VirtIO: Notify
         Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
         Capabilities: [50] Vendor Specific Information: VirtIO: ISR
         Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg


I tried enabling it:

[  343.718529] pci 0001:00:00.0: enabling device (0000 -> 0002)

Without any change. @s390x folks, is there something missing to make it fly,
or are there additional steps to initialize+use such devices from inside the VM?

-- 
Cheers,

David / dhildenb


