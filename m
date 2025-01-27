Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05095C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 15:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcR5n-0003Eu-Rs; Mon, 27 Jan 2025 10:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1tcR5l-0003Cy-16
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:32:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1tcR5j-0004yU-JY
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737991917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPqqrHhcml9ZsKE25nN8gjWYLOJ/GW3gK2W54pocaKA=;
 b=TYHszMfyy/h/IxBKTP/zdPb2OhVqdgVKLQWR571uFeSC1vk+Mye3doSu+Koct3cXRhH8qA
 qlEfLhI/umYI1wtb5ozkCzxDmb2/+STDi17j7/H5yUbs8Xngnh8pPUYhhF4WypkPE/CtQ4
 MTDSwaemxER5lNGB/Rxj2bZCZOFgcUM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-o1siBvSmMNqwh-_x6YycqA-1; Mon, 27 Jan 2025 10:31:55 -0500
X-MC-Unique: o1siBvSmMNqwh-_x6YycqA-1
X-Mimecast-MFC-AGG-ID: o1siBvSmMNqwh-_x6YycqA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-388d1f6f3b2so1915366f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 07:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737991914; x=1738596714;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZPqqrHhcml9ZsKE25nN8gjWYLOJ/GW3gK2W54pocaKA=;
 b=EGmPXAGQ8fD6ARit9rLqiFgmUdZ5fK51zHufe2esIkSD0ahEzKHqm7eCnqFskDg1Uq
 f6TutOF0R2ErddueoR+LA5ErTeIMgk4pkHe4RX6ZF4AcOOxeuVIih9Qv9zl7vcSrVzu1
 sIjN4X6KhbVxGdmIOHjOUd/0TqS/ZTL3U1/9sWRprv3JdXpRIDkf4F1556Ji/lAu5ekx
 Uce2JmuSe365bg+JlQ0jBJGX6+FDOr9u2xfMM+r30FQLsqt/CM2aBun+HbhumJBekK9Z
 Nwrbz3pD+DzpruoBcxRfP0UtS9gCkTrT6CjG2xvDTudgL72i+4RFxcgsUY6Bcgd8XCdm
 sqyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkRIrEYYqNcCfg1fmXs63cLE7syvaeLVidJf+yOh5ueWzAeZC75hFBC5axiSjGNaELgi/2YvewR+BB@nongnu.org
X-Gm-Message-State: AOJu0YxmyCzxgQQh7lzD04952POX/R0pqxGSfhMPOCNiBE/h2RZjVqS1
 fbomHyI+yCmLfWHfLCCw/WOCkS9kkwfiiZ7as6Vma+Rnn2rhkhftmn1SWK2NMCVEU8/38zVe0Ot
 hJvCCWIFG/559iW9TeUr71hP5Zkd+AXNsVllnX3RU+LAlvnr2thRh
X-Gm-Gg: ASbGnctoZZXsq92lwrU/RLZhIkw85NK/Fw49kq843qYYFF4Z5oqprmSN37lSp2KRLcR
 NKK1pQgFtoJRc41x7PbncTmUDfxOKBDH8zck+4RQkaPir+BN+dUnKgLG+BB1YqhGELpYwALCDar
 dKzm35DqiZDrZEJqM9+HH9j11Zao5lvywqCZm6vs2v5lR8RgMYbqCHWduikffUWGdxmII7STFUG
 toRvwTusgLSguz4HuvDIhZG/ZLARarX78/6mGVE3i5lIS+vSOH1yPPLLrCUznwxNc4QckoONSV/
 UxX8k/nrhjyJMEkBiaarGem4quEqGdI=
X-Received: by 2002:a5d:668b:0:b0:385:ed16:c8b with SMTP id
 ffacd0b85a97d-38bf5674631mr32065089f8f.23.1737991914067; 
 Mon, 27 Jan 2025 07:31:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERT46XsXvBWwRantKG26Mv1ofrlS75DkPifDFboLHzX6q05+UujQEgZt0aAxlgY6ytVn2IJg==
X-Received: by 2002:a5d:668b:0:b0:385:ed16:c8b with SMTP id
 ffacd0b85a97d-38bf5674631mr32065060f8f.23.1737991913681; 
 Mon, 27 Jan 2025 07:31:53 -0800 (PST)
Received: from [10.43.3.236] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188928sm11304666f8f.45.2025.01.27.07.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 07:31:53 -0800 (PST)
Message-ID: <270c3c94-185d-45d2-a8b8-34f8d21a9cb3@redhat.com>
Date: Mon, 27 Jan 2025 16:31:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] s390x/s390-virtio-ccw: Support plugging PCI-based
 virtio memory devices
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>
References: <20250127142824.494644-1-david@redhat.com>
 <20250127142824.494644-3-david@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
In-Reply-To: <20250127142824.494644-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/27/25 15:28, David Hildenbrand wrote:
> Let's just wire it up, unlocking virtio-mem-pci support on s390x.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 3af613d4e9..71f3443a53 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -554,8 +554,7 @@ static void s390_machine_device_pre_plug(HotplugHandler *hotplug_dev,
>      if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
>          virtio_ccw_md_pre_plug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> -        error_setg(errp,
> -                   "PCI-attached virtio based memory devices not supported");
> +        virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>      }
>  }
>  
> @@ -566,7 +565,8 @@ static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          s390_cpu_plug(hotplug_dev, dev, errp);
> -    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW) ||
> +               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>          /*
>           * At this point, the device is realized and set all memdevs mapped, so
>           * qemu_maxrampagesize() will pick up the page sizes of these memdevs
> @@ -580,7 +580,11 @@ static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
>                         " initial memory");
>              return;
>          }
> -        virtio_ccw_md_plug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
> +        if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
> +            virtio_ccw_md_plug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
> +        } else {
> +            virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
> +        }
>      }
>  }
>  
> @@ -589,10 +593,12 @@ static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          error_setg(errp, "CPU hot unplug not supported on this machine");
> -        return;

This looks suspicious. Do we really want to continue executing the rest
of the function in this case (though there's nothing to execute
currently)? OTOH, the statement can be put back should it be ever needed.

>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
>          virtio_ccw_md_unplug_request(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev),
>                                       errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> +        virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
> +                                     errp);
>      }
>  }

Michal


