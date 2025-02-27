Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68098C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 08:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnZKM-0006rd-RZ; Thu, 27 Feb 2025 03:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tnZKG-0006lI-Kz
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:33:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tnZKE-0006CD-9A
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:33:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740645173;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sO0AOQHXEk+AUU//gjRf2eXM/vQ1iK5L3uwX9ujjo8E=;
 b=OjFMZQzVb6SX96c/TGjHPbPdkiVPPtdchr0kU27uglm/jEEEttSpv/uc3hUq1y7I9QtvTo
 iiinaE+2L//22GglRJ8WoAVuQG95THrhl1GrVqXQ91Dm87p0opltmWzZgyYU1xuZNs5rEe
 taTlZdYtaAjC3erUVT+21VFWQbq75DU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-OtclHmCAP1qG3rn08MuETA-1; Thu, 27 Feb 2025 03:32:51 -0500
X-MC-Unique: OtclHmCAP1qG3rn08MuETA-1
X-Mimecast-MFC-AGG-ID: OtclHmCAP1qG3rn08MuETA_1740645170
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f28a4647eso224809f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 00:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740645170; x=1741249970;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sO0AOQHXEk+AUU//gjRf2eXM/vQ1iK5L3uwX9ujjo8E=;
 b=Wz/bLKDLtV1uwrXr6S5afLEnZUxPI4Su5DXo49qKcfAFrsY4OrmaqNFAZTptWe/o34
 rIlJSIPgkCUxDH1wfIAEKMwY0NPMrkFfcLiEWiz66bFUof+Wovm95POtcBNeq2qVUrbp
 pb3Zrm/5ZdvB/U5xoJEDISNJZdLhxWxQDfJQR28MBMkQOu/QwK9EXrvoBAwHX/1l+M5w
 2nofC1p5LT3Lx6j3jqYO1AKsbkWUG4+XqcewlniFlySrrUoW1YaybT48pbYZxwvLRjW3
 G1ATiRWPlznIq0EIUhLyoh1n0Pb4pkcb3DtoC/w03qLuMciZQhNjgZW6izL9XarU/Lro
 kE2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLgXq9w28gcWN3Bjm5yew3YX940biw2RLs/jauM+zn5HdgMI+Pc2higwKcSziVduMoBcv+PV42Zna1@nongnu.org
X-Gm-Message-State: AOJu0YxT1bxDFeEuzHi560Bfgtj5nh82scJ0lGiecEbHJn7blJufQlAG
 YtMhO6eh+M+9wwpPwPPPXZCsPXBXrBXt1vAnsp+zxHPiF7U8hiM4nkXk2EOpFPmEBZR6uoTiyuF
 dTyTpndnVwGV+hjBmf2m6EkqSvdzfO+KZ1OivUnx2wcSsISeJs2zT
X-Gm-Gg: ASbGnctcg/0W3SNizZ01fzFv8UGbJIuq4N6jR6aRFiYYLUqUnXgVbM+6kQNsduke141
 dhbGu9jnUw1a3cnCHyJ0oULOQT4PTzgAbYx8lvehnkKAJ0NhXSAdPveSmVLlBFAU7TpjUX6sSj4
 SVYEZi1/fHAR86YyobrJkWKq5C+AFpHQZt8Ds/bdF9QAwycKoaKTS0AmamiRpSyaoIJSwFKcogs
 l3hJCOyd+lKItOX9+5phDngo6xX3JTxO+Guc+48KTM9eh2mnHUCu5Y0tk+VCif5OccSceKl4huP
 umjFEt7Oon6glwbCIozQNp4ItLWBornmYkRfz62OzoVGNNJZeX/aQYSsdFlRhxE=
X-Received: by 2002:a05:6000:1541:b0:38f:38eb:fcff with SMTP id
 ffacd0b85a97d-390cc60a682mr8613235f8f.29.1740645170269; 
 Thu, 27 Feb 2025 00:32:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhQ2MdADVBZU0gvZjAuSNuJjM2ZG/ZdX0TQslY7caKr2BOptl2wLrmycGrY6zwPnIgYSEUlA==
X-Received: by 2002:a05:6000:1541:b0:38f:38eb:fcff with SMTP id
 ffacd0b85a97d-390cc60a682mr8613216f8f.29.1740645169960; 
 Thu, 27 Feb 2025 00:32:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485e03asm1280559f8f.95.2025.02.27.00.32.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 00:32:47 -0800 (PST)
Message-ID: <291bf12d-18bc-444f-b09d-3fb80e0f144a@redhat.com>
Date: Thu, 27 Feb 2025 09:32:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vfio: Make vfio-platform available on Aarch64
 platforms only
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Will Deacon <will@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-3-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250226084721.232703-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Cédric,

On 2/26/25 9:47 AM, Cédric Le Goater wrote:
> VFIO Platforms was designed for Aarch64. Restrict availability to
> 64-bit host platforms.
>
> Cc: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

As an outcome from last KVM forum, next step may be to simply remove
VFIO_PLATFORM from the qemu tree.

We also need to make a decision wrt linux vfio platform driver. As I
can't test it anymore without hacks (my last tegra234 mgbe works are
unlikely to land on qemu side and lack traction on kernel side too),
either someone who can test it volunteers to take over the kernel
maintainership or we remove it from kernel too.

Taking this opportunity to add Will, Marc, Peter in CC

Thanks

Eric
> ---
>  hw/vfio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
> index 6ed825429a9151fcdff33e95d1a310210689b258..885630e8d30c656500fcd7dbb3f26a4c0113a17a 100644
> --- a/hw/vfio/Kconfig
> +++ b/hw/vfio/Kconfig
> @@ -19,7 +19,7 @@ config VFIO_PLATFORM
>      bool
>      default y
>      select VFIO
> -    depends on LINUX && PLATFORM_BUS
> +    depends on LINUX && PLATFORM_BUS && AARCH64
>  
>  config VFIO_XGMAC
>      bool


