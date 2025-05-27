Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859DAC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJpDg-0008HC-Fv; Tue, 27 May 2025 03:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJpDc-0008Gj-Dc
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJpDU-0002Vz-Tf
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748332756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5fWsQBAX4Cj+mQo6vjlzaDktXjbaWvDbaY+O9tZY19E=;
 b=H3QR4/5iTzqX6Um60D1cgPNgmkrHofuj0U+Qj8SwcAaq+RiBpKTjrCwz64IzdVcQ2GsXWr
 N++xMX1EpWiZaE5HH3SbzAIpk6BN/bDaLBTksclVpnlK+6Kn36ltZvPHNt3R7nETBI5I0O
 pXv+di4XYavmERzEb6iY9fMHd0p7/Bo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-lwm3fgwzOpeGOc3WmVD3qQ-1; Tue, 27 May 2025 03:59:14 -0400
X-MC-Unique: lwm3fgwzOpeGOc3WmVD3qQ-1
X-Mimecast-MFC-AGG-ID: lwm3fgwzOpeGOc3WmVD3qQ_1748332753
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-44b1f5b91c1so22999405e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 00:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748332753; x=1748937553;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fWsQBAX4Cj+mQo6vjlzaDktXjbaWvDbaY+O9tZY19E=;
 b=A6aJc59d7He1kdUEaZqwBGlEu90f+UDt7qnRRUF2kdTi9CfZ+ASI7AGMV5omwmNvY/
 mjV1aXGKH5Bo32dp0o5ZrNSGTODSuiAf8VkeZso/GsvCTNyMgywadqcTFONKF84Nah6u
 8fbJcPuZSnjQv7fDdVvUYkHHmhWf6mR+IHRZCyK/8TkLQfPyRxSP2Qn0PtGn4BPYHuHo
 XHNEzqxQye+O1Kp13sVXQfBJ84FMn5JS5vKCZBDVp/CAwpoj675rmJnKq1DH/bRNvnEi
 E7rQhYjKNpK0OEz4lsnaLiz/EnZWs3CMP55PaxA1RgRNFtS7pEjBzfzdjXo4QKc1HXCp
 G0yg==
X-Gm-Message-State: AOJu0Yy0tJr3NDOKlhDA3kmiDna4qCFf3GMdyedt0ZshYnsiX/2mNUfW
 aLvwfgL+oX9DQH99RnbP9G6ls8deHUPRqKdpApyRJZe2rc16DU/JDmKOFZBy0ljqcUbGje4+u2H
 RXCDElHp/ZnhAUvEy3SjQWOoaLWIVqfRM2UGB+0EVQSz0Uqd4FIC4zk/t
X-Gm-Gg: ASbGncsE4NFQtRVVFKYNdkXaQojNjxnsSeoIj4/hv6SA8bilEC1YaTQxcpnM8XPMrn4
 fuVOAFPNTQ55UWSFGU55yCv3WmKDlstE4PA87gL8l3MsKcAX7b/1Z1jVa336n6/qQ+La91GNV9R
 S7D7nVkZBNDsmuW4FeGKNGUkujY7Qp4EvWFnPFXgyMBPvLRqm2mrJLcuKZQaBKyPdvKdeDAHryB
 i14pwiyf1l5BTGM631l/FInuW6mCm37DpONxgI9I6ni3CrVzQGMZsT2gwgNDNd9zWQSAIDf4o06
 BPpv52WW3TjIhrlL6s3L52s5Oxt5nhrsjkZkr1oysd6w03Ck3w==
X-Received: by 2002:a05:600c:5396:b0:43c:f63c:babb with SMTP id
 5b1f17b1804b1-44c91607264mr92746745e9.1.1748332752869; 
 Tue, 27 May 2025 00:59:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM3vWve4Eevdrv/jzK2O316Flj3zpeEpC1Nl+xS9zBwHNwH7V3Y1XNEnNkSkrGIdhfsJ5SLw==
X-Received: by 2002:a05:600c:5396:b0:43c:f63c:babb with SMTP id
 5b1f17b1804b1-44c91607264mr92746465e9.1.1748332752439; 
 Tue, 27 May 2025 00:59:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44fcbd614a6sm18727365e9.0.2025.05.27.00.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 00:59:11 -0700 (PDT)
Message-ID: <aec0b72c-0c1e-4489-a96c-7fb3ce409e04@redhat.com>
Date: Tue, 27 May 2025 09:59:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/igd: Fix incorrect error propagation in
 vfio_pci_igd_opregion_detect()
To: Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <c.koehne@beckhoff.com>, edmund.raile@proton.me,
 Edmund Raile <edmund.raile@protonmail.com>
References: <20250522151636.20001-1-tomitamoeko@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250522151636.20001-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/22/25 17:16, Tomita Moeko wrote:
> In vfio_pci_igd_opregion_detect(), errp will be set when the device does
> not have OpRegion or is hotplugged. This errp will be propagated to
> pci_qdev_realize(), which interprets it as failure, causing unexpected
> termination on devices without OpRegion like SR-IOV VFs or discrete
> GPUs. Fix it by not setting errp in vfio_pci_igd_opregion_detect().
> 
> This patch also checks if the device has OpRegion before hotplug status
> to prevent unwanted warning messages on non-IGD devices.
> 
> Fixes: c0273e77f2d7 ("vfio/igd: Detect IGD device by OpRegion")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2968
> Reported-by: Edmund Raile <edmund.raile@protonmail.com>
> Link: https://lore.kernel.org/qemu-devel/30044d14-17ec-46e3-b9c3-63d27a5bde27@gmail.com
> Tested-by: Edmund Raile <edmund.raile@protonmail.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> v2:
> * Add Tested-by from Edmund Raile. Thanks for the contribution.
> * Rebased on vfio-next
> * Fix typos.
> 
>   hw/vfio/igd.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
> 

Applied to vfio-next.

Thanks,

C.



