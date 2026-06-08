Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24554CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWW8Y-0008PY-0z; Mon, 08 Jun 2026 05:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wWW8O-0008OO-LS
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:19:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wWW8N-0004ov-B3
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780910342;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+zW08Pl7ILs1Vo32rmEYB2yCbBTXKjogUoZD02mssY=;
 b=OSELwO7s1QDU8l5EcvzRg0kQeaK0PCNXAYtmKmwXqkp8j9cPc+T/oOwkdUQWK2FAWull3W
 1Ccd9FhaWrpY2TpxkShphNXyTaiCcXkmXdWD+MLfdIQCWVpd87ZmcVR7CD97LYgd2BT2Kw
 X/IE9Sgp7iBdbXinACuz9KzbQngZdCY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-4XzU5xisPdOzz1lNNk64Xg-1; Mon, 08 Jun 2026 05:18:59 -0400
X-MC-Unique: 4XzU5xisPdOzz1lNNk64Xg-1
X-Mimecast-MFC-AGG-ID: 4XzU5xisPdOzz1lNNk64Xg_1780910338
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-bf473656dcdso174159666b.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 02:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780910338; x=1781515138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+zW08Pl7ILs1Vo32rmEYB2yCbBTXKjogUoZD02mssY=;
 b=l3seSPFWw0UEOa+s5ueieIb8pldCANubpvOQzi/paBAwIlHa8JJvLnobX1Rq/PU9dB
 Ra7YH3WL5K/GgMvDpomQ++hM7M7eOFOqSlfCktDni9qs5RqEWAzltXjHRre4L8nOsKUu
 pbGfEiegHfqQjciZWrXcF+/hlnoJdAR/7UgpAC7ruZh1mDJb2lQaW0MxJEU5A4Y7NPC1
 rPC2u5NZ+bhRK0VQuB+keGGRKRUmG1FEzBCI2Oer3B6tLG//1QHq1TGRdpZqL92mFmgN
 qUnPf5K3f+r9UwGB02hUbsJCum5Nat3s3KLO7kTQ18H5sSoXFREk/f8c77kR62j1yT0v
 VuPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bSH7y1+AUdtvcb58JeFiMJ/TqnnKslyHtVsszYsvzJNoNEE/VGzjIUytUrUbcwl6jNdcozsefJ1PV@nongnu.org
X-Gm-Message-State: AOJu0YyP8To5K1BcOgQqWqbKgKm7NKEvYZT9zygUe+58RiRojjIJXVt8
 u62OJNQbrP5LogXvye6mGgZkdXbqxz/RVcqbeDBrn7zrqirnJySS0Qt/iOU/iDcNsBujzD5d1P5
 mKc4IyZpsJbtZuvcvzEXi/OOp6vLGwe+vlpvbL/0LR3IysusFh8aePx76fpomq188
X-Gm-Gg: Acq92OE1rpUskuV1R7jEq4GXAumrK8lNP7rDvrbbylneMLxYb+e3QB3CVOxn4FVQJ8v
 TwrLt5LETGIYmzEEnDxgq6KBSo0FSccyWG/fBafL/PMFcKOPM7656kPUB1/izPvcjQxE7GhbIfg
 Hot2GBhy4FDtEKgNTEfb9ROf05/2TewwukOQNDlqCINT+lSdmcEIGHODM3IvO6HJoTcpz6+rt5E
 l1JtPg4bd7EoPma5ZsDrT8ML8Jb5FIK3G65BKpwFy90Wd39GytG2oVhrzHqOloy1nNUtWrTeH8f
 nhB/YkbWL43H/WVdDQsuQP3NYPRNiHacAp5r+J8wakzwXqduSX3FWbgzZNsGTGQIpJBeW7JT6Td
 otTu5YcxJKu99dGPjiAufPki4+eThQbHrBllYMg3OJCPJvwl87Ha/R1z6MoYJ/DfaBwvb8TCUaA
 wBf1Uy
X-Received: by 2002:a17:907:8b9b:b0:bec:894d:dd3f with SMTP id
 a640c23a62f3a-bf37164d6demr686680966b.14.1780910337675; 
 Mon, 08 Jun 2026 02:18:57 -0700 (PDT)
X-Received: by 2002:a17:907:8b9b:b0:bec:894d:dd3f with SMTP id
 a640c23a62f3a-bf37164d6demr686676766b.14.1780910336485; 
 Mon, 08 Jun 2026 02:18:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0553060dasm841276166b.44.2026.06.08.02.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 02:18:55 -0700 (PDT)
Message-ID: <de367a12-b814-4a65-97e2-ac7a63a9653f@redhat.com>
Date: Mon, 8 Jun 2026 11:18:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] hw/arm/smmuv3: Improve accel SMMUv3 usage
 documentation
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260605001712.1823737-1-nathanc@nvidia.com>
 <20260605001712.1823737-3-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260605001712.1823737-3-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nathan,

On 6/5/26 2:17 AM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Add a statement to clarify that the host SMMUv3 must support HW-accelerated
> vfio-pci device assignment when setting accel=on.
>
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/arm/smmuv3.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 0c65dc8c91..6b5035e11f 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2165,7 +2165,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>  
>      object_class_property_set_description(klass, "accel",
>          "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
> -        "configured in nested mode for vfio-pci dev assignment");
> +        "configured in nested mode for vfio-pci dev assignment. Please "
> +        "ensure the host SMMUv3 supports nested translation before "
> +        "enabling.");
>      object_class_property_set_description(klass, "ril",
>          "Disable range invalidation support (for accel=on). ril=auto "
>          "is not supported.");


