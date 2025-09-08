Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFC5CAC588
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 14:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvcfd-0001Vy-9n; Mon, 08 Sep 2025 10:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvcfE-0000yT-OJ
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:16:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvcf4-00007f-Vg
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757340957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Bl/TGPN9jya/voFmtsMmphkE0T1J4qhzJFKr5wOjRYs=;
 b=HqKCJDxomoFlLxUMu2ORenM4AK69FuqKGKrkiaKOEykfuxFr856J7uy+/0VoXUKMSUEU+a
 Ejrxqq9sW+9m+tevgTIsP1nhxoukR5k4ErT1wM5pNEWXuwUW4UYdhgKLNl6OKPtmOvDwJ0
 hksftDSjrkTyAcPWXqyae2adP+LhDYo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-1Uqo7oejN06AvFAVpmMLHQ-1; Mon, 08 Sep 2025 10:15:56 -0400
X-MC-Unique: 1Uqo7oejN06AvFAVpmMLHQ-1
X-Mimecast-MFC-AGG-ID: 1Uqo7oejN06AvFAVpmMLHQ_1757340955
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3df19a545c2so3428582f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 07:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757340955; x=1757945755;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bl/TGPN9jya/voFmtsMmphkE0T1J4qhzJFKr5wOjRYs=;
 b=nC7h4duW+++BHOV8LrqOTXQTRCfVTm25z9O2tYWMA9pZxNVuFiufIUlkDR+OgNXuF+
 s8B0UtEAjWxxB0ZKx/6UdvR2RDgWK2KKPMojDX3AJmjo1M4i639FVuFz4POVGkxeLykz
 5gysapsePujtPTehQQf41zDRA6OpS+yPEwxPNf8FKsWUWDDCxqKLYr+NVoenVpaVlTQ/
 OZgBELf+lKqrbL6FgBHDDB7aavax9kcrUD8V838bkJZwFyXxd2CFJjmKIlt+4IUslRps
 +v0IzZGFa/g4H2JuRgbv2+W0HNaNKvQPkaUuXvvnCwHGQVBAluER81CDr61zu9IQDaSK
 qu1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtQVYk3HSZhQOMJF3W8OkxI0Yup2KHQ5xXgxXte8yNgsG0dkwyAwK/4xmTIFkBkzrV/6JMteiQebOn@nongnu.org
X-Gm-Message-State: AOJu0YxHRw0GqbxfQvbR1NLh2pQ2bF/yNspHQBGqcBCGcDF6s977YfYs
 A9n9fUVu2TRtM1N0dia37598VsjUETHFP8AgMVPd2PwxwUChUu3B/FXCVlETstSM+RJJ+3GgyyD
 n7YJ64ofgQarUnSqPXhhSkFEYnLK+nH32em1UZnBnzWq9Y8T1mUjLSDEA
X-Gm-Gg: ASbGnctmmsj6X8qk34QUCKeHFP/qY5ZOewsNzN0qS+SSVclRfCd+qjRDMNEkwZ1noZd
 3X3FdL7+aLvichWD+DNePgA9CFHM8DYsivQzpXqaTg9+3CfQLaLLL7fjNqo+eu9EZ7kE86r63sH
 xpbdh9++1WABPWJPu6ZBTEWES9XvhO+F5at9lDyUC8OMQQmRR8RXlssIrdb2xlp1ITpdKv0yWEq
 V+jOoe9j6LLEF1+UIkWzWP4NghVyhQd/Xrdt0bGWsYk8owoR/TqgLVtimlgudtkjw7j5MrExtpK
 L9txO+EOwV1KNxxaDXjeBPwKDDpQhfHRbj0CEzWIMMxRKaurnOboTeCvlxcZrY6nHzbapSKUlFC
 wtUs=
X-Received: by 2002:a05:6000:1aca:b0:3e1:2d70:6785 with SMTP id
 ffacd0b85a97d-3e643ff7737mr6623010f8f.31.1757340954969; 
 Mon, 08 Sep 2025 07:15:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj4+gemzrpxu/u7CimqxIo9xf9O+2UaJ04GAMa8Ot1sJl62HGGcyC57oEb4hnFqpemi5NNQQ==
X-Received: by 2002:a05:6000:1aca:b0:3e1:2d70:6785 with SMTP id
 ffacd0b85a97d-3e643ff7737mr6622981f8f.31.1757340954536; 
 Mon, 08 Sep 2025 07:15:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e705508e22sm9032900f8f.49.2025.09.08.07.15.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 07:15:53 -0700 (PDT)
Message-ID: <60bb61bc-13bd-461b-a368-aa6753c15edf@redhat.com>
Date: Mon, 8 Sep 2025 16:15:52 +0200
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
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


Applied to vfio-next.

Thanks,

C.



