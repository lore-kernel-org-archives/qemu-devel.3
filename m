Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DA5C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 08:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnZGB-00043M-PL; Thu, 27 Feb 2025 03:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnZG9-000438-KU
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:28:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnZG7-0005GZ-23
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740644921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0GbEhZH6Be8IYrABq2wy/IvkfDwsIUpHCdvJoV+uoO8=;
 b=PNMjLunc6+VOp1lIJwLTx+BUSDwnJscBioAo/SThfpJMZVmO52GqujHRt4oHsHb9djQ0C0
 3V3lEyCsaeBpVjVAu4ty7vAjBKKOst+vFKIVHLt4bUz6G4MME81eDlHI0eOFUmEeSbhrNt
 Cv8snoa+RBIZwNJEzUJ65OWxSHcOT5g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-d-oUxVjSP_qRz9uU6E-GNQ-1; Thu, 27 Feb 2025 03:28:39 -0500
X-MC-Unique: d-oUxVjSP_qRz9uU6E-GNQ-1
X-Mimecast-MFC-AGG-ID: d-oUxVjSP_qRz9uU6E-GNQ_1740644918
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4393e89e910so3257145e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 00:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740644918; x=1741249718;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GbEhZH6Be8IYrABq2wy/IvkfDwsIUpHCdvJoV+uoO8=;
 b=rRTUQLdTZKNGQpTWbXmkeRL5glkAGviOgHT2XglNt53Azwbcv4YMDD8Ri0LSkRFX+D
 eCXUNKuy5oTgMGf7KX6JuznMqdfJHe3Q0IWaMSCiq9g/fW88aZfs0qLfe8ipBaIcRKZl
 W1UEqr5Ah2ErHQ3z7b9/NnIk5vwK1znftYiJDiz8litqigH6GlMYFcGBHgq0gaUGpHgs
 +x38B9fWks15UoWLnqWJqIO0JHLe6WecJJBkB161j6JGDO2RFeazY+yaqSntXvygsLsL
 HSNAw8hPyxPEXECNRi88Tgr1GbURqtqWiWFUlzkUBwchuRfU/c75ws7Nwx/2EVYklpid
 AB1Q==
X-Gm-Message-State: AOJu0YzWHl3DIztl5xOcvZHssmTgRDtxB89H8dSH94ZTmlZ4nXkDdG1s
 j7MBjmoZ1apZFKqt3J0OGbLHd/RJ2qBeBVReqpjcHcvksRmjmE33iOKIbPSRr5oQI3N1uP7GFsW
 OeId750a5IK6idIpe1Ldg5T1YO121NBPJU/KWl27ULUC7+lA31NRW
X-Gm-Gg: ASbGncsywiIlThMgfH7gNy0EJnOE9nVvD5azlTvrRXZqEmconSzjUwSX1ncWIVNtSmr
 AbAG5kA8z1Tsnh3EpC7sfI0T4ujabkPm2dowRi+G15UY3tOYUG9Ofkqdh+Vmy996NTMk35sJlDt
 xpWlFtWnUOIBmSVNDQw5tZXEVINsR7rQsrGiPM/HJEKHj7IcmnBokWS3HoLE9q7aL2/WOobKYB1
 SoR3dcQOG/UEF+Vr7h0QNrpj+G2G7suVAAf+zzXzztxopZHl5d8NjarrHojiHo1Q/wAWSwjjhXD
 7y71Stb9ARbKvd1SqaL79GwUtRd8EYcr3icKtxjYjBw4nxlf7bKXQi83kUE=
X-Received: by 2002:a05:600c:5246:b0:439:9c3a:bba7 with SMTP id
 5b1f17b1804b1-43ab0f8dab7mr86553485e9.28.1740644918052; 
 Thu, 27 Feb 2025 00:28:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK5IlJtnsrA4MgxT2j6Ouse4taOI8gVGOTXuGrXIp7koALKm4QBMFQn1GqQ/wNuhRIjjmWCQ==
X-Received: by 2002:a05:600c:5246:b0:439:9c3a:bba7 with SMTP id
 5b1f17b1804b1-43ab0f8dab7mr86553285e9.28.1740644917679; 
 Thu, 27 Feb 2025 00:28:37 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b736f74f3sm15003135e9.8.2025.02.27.00.28.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 00:28:36 -0800 (PST)
Message-ID: <4a8bcc23-8090-4877-86b2-e5ac126a6cb4@redhat.com>
Date: Thu, 27 Feb 2025 09:28:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] vfio/igd: Remove legacy mode
To: Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <corvin.koehne@gmail.com>
References: <20250224182927.31519-1-tomitamoeko@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250224182927.31519-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hello Tomita,

+Corvin

On 2/24/25 19:29, Tomita Moeko wrote:
> This patchset removes some legacy checks and converts the legacy mode
> implicitly enabled by BDF 00:02.0 into x-igd-* options, including:
> * Removing PCI ROM BAR and VGA IO/MMIO range check before applying quirk
> * Using unified x-igd-opregion option for OpRegion access.
> * Introducing new x-igd-lpc option for the LPC bridge / Host bridge ID
>    quirk. Currently this is only supported on i440fx.
> * Extending quirk support when IGD is not assigned to BDF 00:02.0
> 
> The first 2 patches of this patchset was taken from a previous one,
> details can be found at:
> https://lore.kernel.org/all/20250124191245.12464-1-tomitamoeko@gmail.com/
> 
> This patchest was mainly tested on Alder Lake UHD770, with Debian 12
> (kernel 6.1), Windows 11 (driver 32.0.101.6458) and Intel GOP driver
> 17.0.1081.

Did you try a Linux guest ?

Could you provide the QEMU command line please ? I would like to
reproduce on the AlderLake-S GT1 system I have access to.

Also, since you spent quite of lot time on IGD support, would you
mind adding a vfio-igd entry in the MAINTAINERS file and propose
your self as a maintainer ? The aim would be to keep you informed
of the proposed changes on the vfio-igd device, not to handle PRs.
  
> If the design is good to go, I will update the documentation also.

yes please.

> A open question is whether the old legacy mode behavior should be kept
> or not. Checking if all the condition of legacy mode were met and
> toggling correspoding options is more complicated then I expected :(
> Any ideas would be appreciated.

I will let Alex comment,

Thanks,

C.

  
> Tomita Moeko (10):
>    vfio/igd: Remove GTT write quirk in IO BAR 4
>    vfio/igd: Do not include GTT stolen size in etc/igd-bdsm-size
>    vfio/igd: Remove rombar check for legacy mode
>    vfio/igd: Remove implicit VGA access enabled by legacy mode
>    vfio/pci: Make vfio_populate_vga static
>    vfio/igd: Consolidate OpRegion initialization into a single function
>    vfio/igd: Move LPC bridge initialization to a separate function
>    vfio/pci: Add placeholder for device-specific config space quirks
>    vfio/igd: Refactor vfio_probe_igd_bar4_quirk into pci config quirk
>    vfio/igd: Replace legacy mode with options
> 
>   hw/vfio/igd.c        | 476 ++++++++++++++-----------------------------
>   hw/vfio/pci-quirks.c |  51 +----
>   hw/vfio/pci.c        |  33 +--
>   hw/vfio/pci.h        |  12 +-
>   4 files changed, 166 insertions(+), 406 deletions(-)
> 


