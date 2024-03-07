Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6664BC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riA2z-0007H7-U9; Thu, 07 Mar 2024 04:28:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1riA2y-00076Z-48
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:28:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1riA2w-00063t-OZ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709803693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y6EcNAk1I8U6gvzXg9jc+omEmWXQ5YWMhsjVstaUZd8=;
 b=MO2WT/iKfhTNOtAL/oopDJxFC6YonK9Bu/QezXO1LgRIvqKi0Bxyfj6tGwqqnUp7Px0bae
 i00wS2lDHzLXOuoUrt08ackmQ/GBxM8T+d/zQV9Bt8KwukTjUSkpgpnTyFCDaXqsULJnDh
 lhrC/zcJKyHI/ccBfsk0+3neUSodOmY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-zwPKVdvKP6yES7wrsdHRDw-1; Thu, 07 Mar 2024 04:28:10 -0500
X-MC-Unique: zwPKVdvKP6yES7wrsdHRDw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33e67c6b7bdso185695f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 01:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709803689; x=1710408489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y6EcNAk1I8U6gvzXg9jc+omEmWXQ5YWMhsjVstaUZd8=;
 b=GedNaL4dlsjNivUbZYhFA+SGrH/7/A5o5kJoCIksRQo0yIbAUXqJix69WLcGjCHlce
 Aoq9Kil4Kx8IT3W0Aw8BTujIX8l3kKDRK+9v10hML1VqTUg4YhzXKJyYVr+No3pjVaGf
 34FLWyKxq8S4V6NZyLuNzPOs9HamiHvwaD/XKkiBVT1x5nAMwMpJPOwPmPzPsPUOpcF1
 oUZtKIQ/KMNtKRTa0i8rVTDtHk79mOKJ8Bix34pe2NsGPxrGagNon9R4Z02wxlTr7Rv4
 V5xhnG70jtsG51zB0vD+I8BbdJ2aI1J245XfQBSPTtMwSFEIsT/mZfgkNsFnmwKqNpeq
 F9tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZMemXggdvPdlx3eFNId0Ocv1/s9VI2spl6NtFCV5QbYsUQ8u+JGJ8N7l1kflhKKn2y0OTql6tzH+fgDE2rPSnRe+DgSs=
X-Gm-Message-State: AOJu0Ywm8AmqiyupEkuteO+pot/YTWG0CLfwbD6CwiOXw86eS77p+xbA
 e+nqYlGU/cUbNbId3diG2aYWHhpjLpB32ADDla0/obtsP0YMUwTAY3/9tHvYsXvtZCuLOFOJ7G2
 Y0eVoJp8lopqSlLoGM3d00/Nq4aVoUo7KeYlVE4A/KuHOpxpuPH+IecwPTKBh
X-Received: by 2002:a05:600c:4691:b0:412:c809:5421 with SMTP id
 p17-20020a05600c469100b00412c8095421mr13501145wmo.2.1709803689033; 
 Thu, 07 Mar 2024 01:28:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw1ISfbM5B7c7uu2lXBd9dyH/0aS6dZ/viXVbWeoxAE3VdHctUXJebjmYl3j6RW+Tuvb3tQQ==
X-Received: by 2002:a05:600c:4691:b0:412:c809:5421 with SMTP id
 p17-20020a05600c469100b00412c8095421mr13501128wmo.2.1709803688725; 
 Thu, 07 Mar 2024 01:28:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a05600c3b8900b0041310142e37sm1511672wms.47.2024.03.07.01.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 01:28:08 -0800 (PST)
Message-ID: <c7fec11d-284c-4134-95aa-d10cf7658f6d@redhat.com>
Date: Thu, 7 Mar 2024 10:28:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/25] vfio: Also trace event failures in
 vfio_save_complete_precopy()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-25-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240306133441.2351700-25-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 3/6/24 14:34, Cédric Le Goater wrote:
> vfio_save_complete_precopy() currently returns before doing the trace
> event. Change that.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/migration.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index bd48f2ee472a5230c2c84bff829dae1e217db33f..c8aeb43b4249ec76ded2542d62792e8c469d5f97 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -580,9 +580,6 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>  
>      qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>      ret = qemu_file_get_error(f);
> -    if (ret) {
> -        return ret;
> -    }
>  
>      trace_vfio_save_complete_precopy(vbasedev->name, ret);
it is arguable if you want to trace if an error occured. If you want to
unconditionally trace the function entry, want don't we put the trace at
the beginning of the function?

Eric
>  


