Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5737AD6100F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 11:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlQcR-0006H5-Ex; Thu, 29 Jan 2026 06:55:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlQcP-0006G2-AM
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:55:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlQcM-0004Wf-LL
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769687720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0eUnYO3wtkw14FQkU8BXjQrwVbpAQ/tmfrpfqp4hFFk=;
 b=bWL52+FLh2V+xCD0YKStMJCwoq9SAqlSobca40cQIeXRLhEf9ePwxpxzpYC/rv1pzolJrb
 P5vNOW9B+N4Rbubw1v/zv4V9S+hnO1i8Z0pBIV8h6K9jQfT2ExZUvhlULDKdHO2x0pWVZ0
 ULiNU6jNh0EVZ2Knwo41gnRlqZDqNI4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-jifP8c4lMdGSRLar60LXCg-1; Thu, 29 Jan 2026 06:55:19 -0500
X-MC-Unique: jifP8c4lMdGSRLar60LXCg-1
X-Mimecast-MFC-AGG-ID: jifP8c4lMdGSRLar60LXCg_1769687718
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47d4029340aso16067145e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 03:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769687718; x=1770292518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=0eUnYO3wtkw14FQkU8BXjQrwVbpAQ/tmfrpfqp4hFFk=;
 b=AFytlf23NXcSsJB7Gp3+Da6mKcwca/Z06JnHp6uUYfnHuSL3OYJfMk3kJiFTE8Vfvb
 pzSRxq9G9c+2UV4wXfN9/5vOprwTAfIJThgiOnvvpCi4WFQ3Qs21iNKM1Va7gG5y+6iC
 t3ix+zTtQpq0BJ9YA/n5+RP//E+oC4wzlj+f4FIzJHzi1x7ONlgDfRFH185c1a+Wkrxj
 HbMj1ZPD2xaGNI0X1KGTQARlv3rUkBplMr7FO1yJkjllp3lsDxNHwx6P65OfGgtpi/zN
 veQi8VanHAamTD7Wz2tiz4rI2wV5ZGk9t5sc7o/WshkZsLXsrsG7gUgG+qwEaceYumoe
 WRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769687718; x=1770292518;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0eUnYO3wtkw14FQkU8BXjQrwVbpAQ/tmfrpfqp4hFFk=;
 b=Mmtc9NhsnxqGa3Ngc6iLs/HJ4XJZTHMIAtoh/PkAIB6Vc56ob4dYxIliU2/Oxwp6zr
 8XXZEteIUghU26F/v5AocmCmypZ3t8mhEK76dp1563ds5w6NrVhFSaVAXa20LvhmG5EF
 UiZVPYShvYCKZS/eVz6ko+HcWjd/3FeXqYUg71mP1324JDMX5YdL1IvFnN/SGpcjNuED
 cFEGJLjqBThICnK2qhnrwsRPX83Cq4o8D+2em98mX7siLeZSzrd4wPAO1Po77ZjZHFQN
 MP5WkdsbNaAhlwCLaWXNAeDN76t0+vq6uM0RtFHSKCXf4M7NghtgdEjVQ11V1duc8XFV
 xCJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZifj0hC9c/Ymd7OQUGzr0EaK9R/xRzJmfksqDuioCqHoX75pktlcnfFlE0EQcIHrD73QiPEu4MGgE@nongnu.org
X-Gm-Message-State: AOJu0YwSqBBC8lYlkXBSQUcUHyKNbpXZxEU5HAQjyVEldYHQhYSbkQkR
 3prvbA4EkvL4F2CNWrt9ESj6rLrhtHoVoGkIxUpX7ODI63mFzTnxb7Uztr/JVLlU+iq3ORmlA28
 kjVD9AA60a6Stk9osGwkUz6RKHVTDhMErDw1bgss4KISYTzjGrUPXTlaM
X-Gm-Gg: AZuq6aIOdF/UVCW8NYX/5hrDh289ds2fXJy/XoiIwMtBTUW/cDaNSt9qJvAqKGZkJEj
 AYqpaTvObekYwZdHDFbEm3YlKg6FCsz/YjYQ4UBiWLZieH9DENOxBUtzgnLYaDv/YlUuvMWYRLt
 0iUpdE58SvUksfFrZv0djXn9e/2KReYWq1AaphtCwWgiuBOXIPlaoX0wNf9b3P5CItFyi8238Pm
 9bkG7M2AM8jSULdi6eF5DETSwk48kCgU9dZf4RDBq0U1KLqiiHdkBUColDSrlCwsKy4zGfaAmuU
 tyeyrQlM8Mi463rZO8FasbDxMqcpOIo0IBpC41bGxKU8UAA7TtzQ5RLdRihbxDPRrcQOxseccWd
 UWU+qbC8=
X-Received: by 2002:a05:600c:1da8:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-48069c165c6mr132559095e9.6.1769687718048; 
 Thu, 29 Jan 2026 03:55:18 -0800 (PST)
X-Received: by 2002:a05:600c:1da8:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-48069c165c6mr132558865e9.6.1769687717645; 
 Thu, 29 Jan 2026 03:55:17 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e135422csm14348293f8f.40.2026.01.29.03.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 03:55:17 -0800 (PST)
Message-ID: <ec1f77e1-4cde-44d2-962c-cec2b3522a82@redhat.com>
Date: Thu, 29 Jan 2026 12:55:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] pc-bios/s390-ccw: Store device type independent
 of sense data
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-5-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260127161547.459443-5-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/01/2026 17.15, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Store the device type (e.g. block) directly and an attribute of the VDev rather
> than assume all devices can be identified by accessing CCW specific sense data.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
...
> @@ -346,12 +346,17 @@ bool virtio_is_supported(SubChannelId schid)
>                   true)) {
>           return false;
>       }
> +
> +    vdev.dev_type = vdev.senseid.cu_model;
> +
>       if (vdev.senseid.cu_type == 0x3832) {
> -        switch (vdev.senseid.cu_model) {
> +        switch (vdev.dev_type) {
>           case VIRTIO_ID_BLOCK:
>           case VIRTIO_ID_SCSI:
>           case VIRTIO_ID_NET:
>               return true;
> +        default:
> +            return false;
>           }
>       }
>       return false;
It feels a bit weird to set up vdev.dev_type in a function called 
"virtio_is_supported" (I'd rather expect a function with that name to check 
only stuff, not to set values) ... but we're doing the same with  vdev.schid 
there, too, so I guess it's ok for now. In the long run, we should maybe 
split up virtio_is_supported in two pieces, one function that does early 
setup, and one that is checking whether it's a supported virtio device.

Anyway, for now:
Reviewed-by: Thomas Huth <thuth@redhat.com>


