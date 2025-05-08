Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE2FC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 07:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCw2Y-000275-49; Thu, 08 May 2025 03:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCw2W-00026Y-Eg
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCw2V-0003Ej-12
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746690689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PQhqnu4SJSMHUlUzyA7sL4tSONr92SxrcwQD3Cn6x9k=;
 b=KyqXVQl4hUSHki2Cvu1pG7yJimf83AfFOg6sqDHRcUONCL+VH84KtLfCwJcFodOveotZtM
 G0+J0WpMvQQzoRQb0pBeNR4UEBrBlvUNcdcqRuuxFneCNs7gjidpZBO5QoT3Lle7+509om
 rnc0Bknw+hE5vIQCkSTBv42NEW/4yC8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-4TVGCFyHOh-DPVp2Ml7NFA-1; Thu, 08 May 2025 03:51:27 -0400
X-MC-Unique: 4TVGCFyHOh-DPVp2Ml7NFA-1
X-Mimecast-MFC-AGG-ID: 4TVGCFyHOh-DPVp2Ml7NFA_1746690687
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0b7124b5fso414643f8f.2
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 00:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746690686; x=1747295486;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PQhqnu4SJSMHUlUzyA7sL4tSONr92SxrcwQD3Cn6x9k=;
 b=odSNUfqMseMrghp1AX0SFbVTLMPc/DsfSQbIKRMW3Cs6OFrxxeebF+oc0DlaFROjqq
 J4Wc6F1FL7eXDiarGFzNWj1OGQJhFoTPFt4/VUW+GwP1g1291+bJtRiymrhI3bSSoz3X
 FypuEOt+cBvyYys4x7ur1n7qe4HgzKdrspcJTRrKMzHInar9q/qthlzQGTSWB797CMlB
 wqba1dmgXvNkS/CeoiRw1yNbfd0i+1N3DR2EfdlOBIRilX6vzv1T4RbKRKuhzMcS2bSA
 2TMYyAqkkCQC6alq3UNXqLF0KdsvpTylOGfI0h0sEouR7WqFMEUWmGZlOFvf7jw1he4R
 LI1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn4NffKqm9RoQ3nAIDLwccg5kdTWSaya6mnkDXtU57Z58dsGuvN4HC0VXejoivnl2ogy71l03jsJIP@nongnu.org
X-Gm-Message-State: AOJu0YxK6FWvgUi3jgmZHKED4layEyo7Y2f54xUFYQV6uqTAW87pSsIe
 yyC6PsZzplGVQFPg2OedJGkzAv/ciKW0U79SZsL0nB2wgakF1d32V9yC3u43Y0jBU+ix1aj9+2r
 G2+ehWLDn8RH2xW0ZyHDdIUbKRMoO6hSwKPY0WChQ5GR0DaI+wNBA
X-Gm-Gg: ASbGncsCLhvF56NNoVcXm5sLG2VJiEgwfvCUZx6MFQd+ShnSbYlX06ElAsXWPORIuSv
 uW5DT2pdtOYfEBYJVXE/epS2FvRNw8JP+x3XLwim5cJGbixqTC2LqOUSUPoEA3y8+XQZwoLqQZP
 dciJMu/oSzn6dc3uXkThZu4+cOzMfDhyzDSzuo6xd5NLpXwiQbEKSGCy6QtNlXarM6GgmdEEjaP
 1Ki/hsWcumCaUgMlx195PD1GMrbx9PYaBR0fF5VVhkh3zJ0PwZxPexCAi3FQaqsT4HSsA5CIXdz
 ex4HCRqo+2Hp9x0MkIEM3g5vI1RhHhmPaiyAfk7aitg0XJkML7ab
X-Received: by 2002:a5d:5984:0:b0:39c:141a:6c67 with SMTP id
 ffacd0b85a97d-3a0ba0eed9cmr1739154f8f.45.1746690686636; 
 Thu, 08 May 2025 00:51:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFH8wdSO5rCnBQSXWhVJFFJWbi/QIohqew5/9VHcRgX9VYXRL+okISTqZCN6PQ327djUkdlA==
X-Received: by 2002:a5d:5984:0:b0:39c:141a:6c67 with SMTP id
 ffacd0b85a97d-3a0ba0eed9cmr1739118f8f.45.1746690686302; 
 Thu, 08 May 2025 00:51:26 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0ba0f4f2esm1863233f8f.55.2025.05.08.00.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 00:51:25 -0700 (PDT)
Message-ID: <ab4719bf-a577-4991-8243-037415ab700a@redhat.com>
Date: Thu, 8 May 2025 09:51:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/19] hw/virtio/virtio-mmio: Remove
 VirtIOMMIOProxy::format_transport_address field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <20250502185652.67370-1-philmd@linaro.org>
 <20250502185652.67370-11-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250502185652.67370-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 02/05/2025 20.56, Philippe Mathieu-Daudé wrote:
> The VirtIOMMIOProxy::format_transport_address boolean was only set
> in the hw_compat_2_6[] array, via the 'format_transport_address=off'
> property. We removed all machines using that array, lets remove
> that property, simplifying virtio_mmio_bus_get_dev_path().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   include/hw/virtio/virtio-mmio.h |  1 -
>   hw/virtio/virtio-mmio.c         | 15 ---------------
>   2 files changed, 16 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


