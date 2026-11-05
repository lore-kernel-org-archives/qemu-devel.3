Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0759606A32D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MQaSAd4X;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gmT2Pz1P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP0rL-0003Aj-GI; Thu, 05 Nov 2026 12:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xP0qr-0002s2-IZ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:02:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xP0qq-0005Fz-3h
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793898130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DeNRUymI+hhBlFBMHfet6Gh/vOYYrettb5uGMGfK+2Y=;
 b=MQaSAd4XltwTjJ/JriZf2MLX6NMKX3WMHelUt4C/tCvMUW7rgHxznQTaUnj+Lx4crg0RoX
 JqPGKkYgHJtaBktMX/Zmkp8xRHZG6tM7f4nZQNKOAsX0+apoWTtBuuHrSB/WDNgHJFzYI+
 plBIOy+/mQJS4QFMG8Hkj8ztcHa5KdA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-vLI__FaCOSGTHbYDegLj5w-1; Thu, 05 Nov 2026 12:02:06 -0500
X-MC-Unique: vLI__FaCOSGTHbYDegLj5w-1
X-Mimecast-MFC-AGG-ID: vLI__FaCOSGTHbYDegLj5w_1793898126
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48e1ad3cb66so1232758f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 09:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793898126; x=1794502926; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DeNRUymI+hhBlFBMHfet6Gh/vOYYrettb5uGMGfK+2Y=;
 b=gmT2Pz1PTTy4tOiLLvoAlgbGN6T2LpvosYnbHm0KW7EN1HwGQzO0c+diKzaV20iI0a
 QKukjwvsprE+YPw5SevY6fjt68A1LVir4DW29I5FD9eAXyddsS6gatjz6XIl4QxfEts0
 aQ6TMUUCxJtlI97Ptvf73aEtd+AQ7w6bU80Q5u7tOp4jVvqJD/w7DCmRShqVJTjozEOQ
 +Dwt1RXqUAOvu+qaH0lKLlVqA1J5eoXT05WVoHp20E6qdi+gSvxKkpDnbvrFttKNHOI7
 nM0HQvVgbzNsEZg24VCo2clY8fB3pOpYbFgH0reH0lxVTjiII4TDLREsRBY0j7P7YhD4
 UJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793898126; x=1794502926;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DeNRUymI+hhBlFBMHfet6Gh/vOYYrettb5uGMGfK+2Y=;
 b=cv6NS3ZJ8YAWv0K3XVtb8ZuBKVInOM8W8u3Gad4qyqYqQHqtnQc4usvEm23BnV4fa9
 9z3pJOXmVpYSRK4U50Zks2k+1NqmZQroCeJNUVcpYIrRxChutQgkFu4Y8rbzeUNFY6bJ
 xVZhJOcwUPBHRoNNO/Ptb+ZiElD75LddMDiNrmJJUPt3mutx1H/REffPggn5T+iEM3MZ
 JF4tQkgvkG5f917tW0KGHPMLHJ6MiwXN7pwgy1D6FRGjDxjR5PiPBsUt+rI2GXSr/GKh
 r/3E0y74FLVgiXv//hQWWdKIeeGmsarM0saYaTuyCvJXgfwTo2YruBQr2Dra3roNPcSe
 Fjbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBymH55W/5D+LjiU0aRzRywlXaRHT1rIhUEPJUcoq10z69E5RrHXFTyqoAJGbfVnMuSclLg/2Q1tOl5Q@nongnu.org
X-Gm-Message-State: APuU4Z+/M48lhjSZVgUEOAevvxaNsEb+jI3f8Hmu0X6LuvV49aOIEpj6
 psLoRUSdeJ+AxgemN09wUiCCOQQEBSqQ9PVi+UUUevimYj1lMLNTAytRItkaBhH7Y8cR81ZjKxe
 axGmNEdF8IHnFxRfY7qWGbzzDvY1WAFoJb2boC2EBoecZGhw8bUEf1EiH
X-Gm-Gg: AYBFou0/9Mm3QzxmC/rdxmRDDJRevWUfxGNLrnFZkyBTHDHCfBOjMjoVCKcw/CZdQoA
 IvS3GfZFBmItfojSZv8KJrvCRBFlF+/v/+UKm2RiJraRCcRYm59LotAJltOGKp7vYKpqIfSTR6g
 /uSuKNK+GxE2ZrZozFz5enYGPfv0ErA7iqYK3KSxqYUY77wBIW1OTtnojlC9jzVlUYRO1SeCn9M
 mWpz9fkgRLSMdjD+n7YhStKQikbyNyDlopSjpOpLn7tBx0QIsjLWql8cFDylkPNuKYFILxAE281
 idJ5iwklU+oqRvbhHw2w15zaMq8prlDoHOfq0Q0afm/4KbwKTNqBPkxY/uvHrkRRK9mo7LyJHnC
 L6sn8JYAS4HSGQqq3gnX3OWhwD3le38Cj
X-Received: by 2002:a05:600c:5249:b0:4a7:7f3f:6f8e with SMTP id
 5b1f17b1804b1-4ac1228b5bfmr436963355e9.0.1793898125729; 
 Thu, 05 Nov 2026 09:02:05 -0800 (PST)
X-Received: by 2002:a05:600c:5249:b0:4a7:7f3f:6f8e with SMTP id
 5b1f17b1804b1-4ac1228b5bfmr436962615e9.0.1793898125252; 
 Thu, 05 Nov 2026 09:02:05 -0800 (PST)
Received: from x1 ([151.41.153.165]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b571f46538sm73142785e9.5.2026.11.05.09.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:02:04 -0800 (PST)
Date: Thu, 5 Nov 2026 18:02:02 +0100
From: Gustavo Romero <gromero@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-trivial@nongnu.org, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] MAINTAINERS: fix typo in Gerd's name
Message-ID: <rrbbem53a4ssa5prqyuhz5jrwp523r3qipjanyp2zvly5x4uap@m2udisuzncf5>
References: <20261105152647.2458298-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261105152647.2458298-1-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alex,

On Thu, Nov 05, 2026 at 03:26:46PM +0000, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 198ed583650..3fac3e0f99e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2945,7 +2945,7 @@ F: tests/qtest/vmgenid-test.c
>  
>  VM Launch Update
>  M: Ani Sinha <anisinha@redhat.com>
> -M: Gerd Hoffman <kraxel@redhat.com>
> +M: Gerd Hoffmann <kraxel@redhat.com>
>  S: Maintained
>  F: hw/misc/vmlaunchupdate.c
>  F: include/hw/misc/vmlaunchupdate.h
> -- 
> 2.47.3
> 
> 

Reviewed-by: Gustavo Romero <gromero@redhat.com>


Cheers,
Gustavo


