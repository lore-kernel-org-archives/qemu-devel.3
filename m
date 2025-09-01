Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B2DCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 07:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyb6-0007uJ-Vu; Mon, 01 Sep 2025 03:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1usyb4-0007u7-Sp
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1usyaw-0006ht-P0
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756710282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=m24GhDPSAr322GT714RT9udZTOeL8TOSUZSyKOuv9Jc=;
 b=Z/xRh0Iwr5ajpmacnyV97/BNu7lqgExi1fn8PIiD/PPWAYrSmrKVaTx5WFMewA8MROADBr
 YFM5Q5k5pdnb3MidhN6W4/u0mLgKAPiweUhd4h6iIK6MLIiNbpJYv4puUHvSlbDI5lD9EC
 tZ+beynXtAf0g4q6il8aqknOB3cmszA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-XvsUvNM1NHyv_clzkdJ84A-1; Mon, 01 Sep 2025 03:04:41 -0400
X-MC-Unique: XvsUvNM1NHyv_clzkdJ84A-1
X-Mimecast-MFC-AGG-ID: XvsUvNM1NHyv_clzkdJ84A_1756710274
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3cd821eaac8so2439143f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 00:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756710274; x=1757315074;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m24GhDPSAr322GT714RT9udZTOeL8TOSUZSyKOuv9Jc=;
 b=OUcXh7OvRyt4Ei2XZBnomKXd3WjoSwlvRzdtK6DYi384Iq95V82NIaZx6C7m9nYWXZ
 Lzk18tUGlcqjCDs9cOhe2jRKhnUd37XnPqF4wDPRJcFD7cdj8aoZcpRiL9XUIHpLzUSk
 4PBpgAhk0Pbqn1OF5TLyD+kW4OUTPubbSlpAk/ObTRbIpd4N+/DLG5sV6Y5h+rSycTXy
 /kJB1wob7o7MTDA16fJuFqtWMPFWd2+OPS9d+6bQihtC6iGnXuvFoyKbT7ytoAMWEjCv
 jiDKwgYy9QolwQr8i5DXw9UyZpOwZZF5laIAUOWmrzSuYpnnQWeNrjZcI/I8cVZWPq7u
 1rJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiLfeJ+0bA66yBuveO2i/4KZHLI/8/efqrywwMBal1Y2jmhtUEPvaI6bbu9jK4BSMAbCl54GE1h/iE@nongnu.org
X-Gm-Message-State: AOJu0YzbRuQfL7dlrbFpSZTYEZcBXoNwj7Vd53RuUdbcfT0IDSOVtFoQ
 MRyGuwj2iU4OF1bZDrBivDHfeMBZS85sJx3qzs2qlefYtZeXJz7OO5ZL4lS5D6oWMcUZsYm5sHm
 /bKgEJ7ZZGBVY12dUaa2KoOp4qPHF4iVmQtnhha3WLtXAJmZNO78viktV
X-Gm-Gg: ASbGncvnZnC3Z1vYUY/5dcYOK/mKL8i8zbGemdxY1MYHhtkZoq5SoGcRN28Wej7WjYZ
 EFbqgeWsfWQGZW7Zl82iLULRY9QzaISAb88HdhB8fwOFRoWcOuCYjbGHGoqspTETODtB9OU6F3E
 XBQUrA9kBJQiJEaKZ936KFyctaRaGhFViTl2WBIvCfGC+kmVB5r+cVXl3AuKgLjS40iGOvm5m8o
 5SHIW10zYvzFnSN66w5cdhnIiEKvE1C+xzEfaNlv16Pg08bbW9kKPwyzdPYwnjWG6sspYcS46cv
 7t+PAWXRsuJG4bXzOPUTxdNXA1fs2vWG4bgmAJtqQGwQsWEIvCLw7g3XjDAQc4hVOS2ptNTBtLt
 083w=
X-Received: by 2002:adf:a350:0:b0:3d2:52e3:920c with SMTP id
 ffacd0b85a97d-3d252e39ae7mr3530581f8f.44.1756710273883; 
 Mon, 01 Sep 2025 00:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxThdDNRvILH04Xbyo2zhiacPQJgP6L9q5wiBMdnnY7dCdXbpwc1ymBGlLcrVJaNKI9s3rvw==
X-Received: by 2002:adf:a350:0:b0:3d2:52e3:920c with SMTP id
 ffacd0b85a97d-3d252e39ae7mr3530566f8f.44.1756710273404; 
 Mon, 01 Sep 2025 00:04:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d45daf3293sm6193172f8f.48.2025.09.01.00.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 00:04:32 -0700 (PDT)
Message-ID: <3c123e09-cc0b-4918-8761-8f17d2973f2b@redhat.com>
Date: Mon, 1 Sep 2025 09:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio-user: add x-pci-class-code
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>
References: <20250827190810.1645340-1-john.levon@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250827190810.1645340-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/27/25 21:08, John Levon wrote:
> This new option was not added to vfio_user_pci_dev_properties, which
> caused an incorrect class code for vfio-user devices.
> 
> Fixes: a59d06305fff ("vfio/pci: Introduce x-pci-class-code option")
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/pci.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index be71c77729..dfaa89498d 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -406,6 +406,8 @@ static const Property vfio_user_pci_dev_properties[] = {
>                          sub_vendor_id, PCI_ANY_ID),
>       DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
>                          sub_device_id, PCI_ANY_ID),
> +    DEFINE_PROP_UINT32("x-pci-class-code", VFIOPCIDevice,
> +                       class_code, PCI_ANY_ID),
>       DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
>       DEFINE_PROP_UINT32("x-msg-timeout", VFIOUserPCIDevice, wait_time, 5000),
>       DEFINE_PROP_BOOL("x-no-posted-writes", VFIOUserPCIDevice, no_post, false),



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



