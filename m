Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1057C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 20:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXoLl-0003C0-HX; Wed, 07 Feb 2024 15:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoLk-0003BW-NH
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:16:52 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoLj-0006br-7M
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:16:52 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a3510d79ae9so129788366b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 12:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707337009; x=1707941809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yuMs4atNuAlSfjHW16r6i7n3j4Q0SU76OI+2jOBmN1M=;
 b=ZH2BqaImYRBKecjs2/JpYa1GmLTch3KlQ7s/U3sjStj4S6Mp2zyK7dixrAfbK/9bE1
 iqP30cpBnCTs1arwsPwM9wiB3/Edxt+Jz9RPiZMYZ7xK/iD08PBlPfQGmoeDWdL2WMcI
 iQbeeHj4Ezdk6jb4RK0cBUvGg80Su7pvmQSnfHaH79STABLBxtQc+HcjXDsJGd6VNuA4
 5Fgrtvpfh2pXyaImRD+T6WS44y1N1Dwla78jOeB9OeoDJ7m+S7JIVKrRpi+HDKQ3FyGv
 XioaCsNXT4KdfYK91i0wPfM3/OIZBhZ73LTxALLonuC3kbOkslm9F79+uXmspd21r5Xy
 YCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707337009; x=1707941809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yuMs4atNuAlSfjHW16r6i7n3j4Q0SU76OI+2jOBmN1M=;
 b=n6NyKws4mtS+xPR6jT9EpKYvMS9punmRJyVwt1ZYPBcPmmatW7ITSf3OuaptYAbDrK
 A1ZJ2c0iYc+JFMRwuP4PJNnwdW1UHGdIpBhntUHwZDGSjElBnAPQIpiWZ9ZzdagV/S30
 Uf01ZzuuW2XBNaQ8GiBOr+3QUFUqE199/9+cv0DJ3F20/vfl/2J5jnOE87SRv4MfUfS+
 Lft1knjB0wlOWAzbe02k0GhbV0EXjA3PWb68n7nV0v9hwT/iwFdCiu81Q90TdRUb+GAl
 bW8GKTWWvsnvH2l25BrFR+g1ME7ZbzgDU+u1tzvFqiXwtCiBoTucev7Cf+s5B6p/WmEq
 o2yA==
X-Gm-Message-State: AOJu0Yx92vJ0a5woC71TbEmKL05Mb7lAJlEEUFc0P4j6ojD1rz6KdOJo
 buBHrh+LOi1PDU1G01G5J6stD2J+Rm0JuewCol8SklxEONKq4CXYZGtdkXepMLQ=
X-Google-Smtp-Source: AGHT+IEuyTgAta7iNLIzmW4ZOfO98qD2ciDQTZWZAA3PRDQo0Y9s3WgX+v2+T2Q5lFLVwWtB4DAe7A==
X-Received: by 2002:a17:906:f356:b0:a37:bca9:45d0 with SMTP id
 hg22-20020a170906f35600b00a37bca945d0mr4544792ejb.72.1707337009547; 
 Wed, 07 Feb 2024 12:16:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX8dzNOdPMRzwGTPoPAbuOcwAVaGijKjjF7C/uXPYHGL15THoH4sxoCWbEriGFEAY5Ecyb0VUul8vkrVh55VBA/GgnD3hNkRQk6IlU4Xl4WlCGk0rVnmFXud2CtcayvR6K0DxNwAQcoxtXzOJr/Nsrvxso=
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 hw16-20020a170907a0d000b00a36f28baa8dsm1108764ejc.111.2024.02.07.12.16.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 12:16:49 -0800 (PST)
Message-ID: <8d528c75-a254-4cfd-8512-344acb6308dd@linaro.org>
Date: Wed, 7 Feb 2024 21:16:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] vfio: Add Error** argument to
 .set_dirty_page_tracking() handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-6-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207133347.1115903-6-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/2/24 14:33, Cédric Le Goater wrote:
> We will use the Error object to improve error reporting in the
> .log_global*() handlers of VFIO.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/vfio/vfio-container-base.h | 4 ++--
>   hw/vfio/common.c                      | 4 ++--
>   hw/vfio/container-base.c              | 4 ++--
>   hw/vfio/container.c                   | 6 +++---
>   4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index b2813b0c117985425c842d91f011bb895955d738..f22fcb5a214be2717b42815371346401bb7fce51 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -81,7 +81,7 @@ int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
>   void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>                                          MemoryRegionSection *section);
>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
> -                                           bool start);
> +                                           bool start, Error **errp);

Since here, please document modified prototypes, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                         VFIOBitmap *vbmap,
>                                         hwaddr iova, hwaddr size);
> @@ -122,7 +122,7 @@ struct VFIOIOMMUClass {
>       void (*detach_device)(VFIODevice *vbasedev);
>       /* migration feature */
>       int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
> -                                   bool start);
> +                                   bool start, Error **errp);
>       int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
>                                 VFIOBitmap *vbmap,
>                                 hwaddr iova, hwaddr size);


