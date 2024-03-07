Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938D7C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAAt-0001pw-AL; Thu, 07 Mar 2024 04:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1riAAr-0001kk-6J
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:36:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1riAAp-0000Ai-LF
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709804182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmaaWwuxq/lfzTEvDvx+mpfE5hUXUQVfEeIGv7ibXLA=;
 b=VREXABdoR0znOWkLNvdL82qoWgK3TKoCtNX70/UJ+K4U7/ONQdj+NUlV2df1g99mutLU/7
 YemSJi72zAR2Na11IPVczC6Lx+fExX+QEzK++EPkvROGtnaclUTxt/lTJqm8LGI5JEIf89
 8S5JWnNz5/xiW8zl6xfPG9Dn+fvbMCs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-aSTtK9BJNiKDfwUORgQclQ-1; Thu, 07 Mar 2024 04:36:20 -0500
X-MC-Unique: aSTtK9BJNiKDfwUORgQclQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a45bb7840cdso47826266b.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 01:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709804179; x=1710408979;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nmaaWwuxq/lfzTEvDvx+mpfE5hUXUQVfEeIGv7ibXLA=;
 b=XIaT710oTQ4emMF2CKrYk+Q6sOp5OwVpTizHY+9fFiycQs9MNSZrOyyF8AGRlaYeIA
 3iOlrffaTogJv0UBD/mNx5Cum3ySTI3t2cMOyOzmATeZfm99SeMaWbrnYSYjn8HL9tdL
 hyw9/XBV1yYoZqBHsrAZhys/M0yqLZpg5i3xiSYClmHBL9jj9mqp1UnBagpmFZz/Owlb
 rv4uvuQA++XXbSOiyyLjmckoPXQO1bZUeIrmIgGB0cHO1OlO0/x54+nwOv6g5+d3aOsM
 DwMLBtV+JhWdySQFyqV3X8FmAWFTnKlymtUMTN5zhcW7GAKMj6guj+3b8T1jg0TqxtB+
 GDJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZjFMfHqkFtoDnnWrx0lgEB+7m5BrdLmOBVnAfZ+RN45xy8ESyT0E3DKgsYPzJ0+IhgfvY9HBJnDVcXZG/H03jTfz352Y=
X-Gm-Message-State: AOJu0YxPzi30tWjeGk5RuV/xpcZOYwrUWpJ0bbWC/dKUdbzdiMQQz1tY
 mrtMRCkjsDogGMokJ1Bi23LlPyhWkD2DYxJB06/ixq54+aZoksJu1xODlu61HZRHRSPMkbY7CYB
 TRzygAkNDxoOoPgsI6oA9qCJFp8x3UElX8Oj6eMoXHrQXwrchsxEq
X-Received: by 2002:a17:906:6a89:b0:a45:902b:3cb0 with SMTP id
 p9-20020a1709066a8900b00a45902b3cb0mr5989995ejr.58.1709804179011; 
 Thu, 07 Mar 2024 01:36:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSRCsr20tPhjvyl0OvO3F0a1nylqSSq7WYUXVKNHCU5Nz/TdY8Gh4WNm6TnpH5S+D7y5sWzQ==
X-Received: by 2002:a17:906:6a89:b0:a45:902b:3cb0 with SMTP id
 p9-20020a1709066a8900b00a45902b3cb0mr5989979ejr.58.1709804178698; 
 Thu, 07 Mar 2024 01:36:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 v12-20020a05600c444c00b004129ed6f9cbsm2044469wmn.4.2024.03.07.01.36.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 01:36:18 -0800 (PST)
Message-ID: <ada4a094-f07b-4ef2-b81d-cd99430a5579@redhat.com>
Date: Thu, 7 Mar 2024 10:36:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/25] vfio: Always report an error in vfio_save_setup()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-7-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240306133441.2351700-7-clg@redhat.com>
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
> This will prepare ground for future changes adding an Error** argument
> to the save_setup() handler. We need to make sure that on failure,
> vfio_save_setup() always sets a new error.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
> 
>  Changes in v4:
> 
>  - Fixed state name printed out in error returned by vfio_save_setup()
>  - Fixed test on error returned by qemu_file_get_error()
>  
>  hw/vfio/migration.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 2050ac8897231ff89cc223f0570d5c7a65dede9e..330b3a28548e32b0b3268072895bb5e4875766a2 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -383,6 +383,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>      VFIODevice *vbasedev = opaque;
>      VFIOMigration *migration = vbasedev->migration;
>      uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
> +    int ret;
>  
>      qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>  
> @@ -397,13 +398,13 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>      }
>  
>      if (vfio_precopy_supported(vbasedev)) {
> -        int ret;
> -
>          switch (migration->device_state) {
>          case VFIO_DEVICE_STATE_RUNNING:
>              ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
>                                             VFIO_DEVICE_STATE_RUNNING);
>              if (ret) {
> +                error_report("%s: Failed to set new PRE_COPY state",
> +                             vbasedev->name);
>                  return ret;
>              }
>  
> @@ -414,6 +415,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>              /* vfio_save_complete_precopy() will go to STOP_COPY */
>              break;
>          default:
> +            error_report("%s: Invalid device state %d", vbasedev->name,
> +                         migration->device_state);
>              return -EINVAL;
>          }
>      }
> @@ -422,7 +425,13 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>  
>      qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>  
> -    return qemu_file_get_error(f);
> +    ret = qemu_file_get_error(f);
> +    if (ret < 0) {
> +        error_report("%s: save setup failed : %s", vbasedev->name,
> +                     strerror(-ret));
> +    }
> +
> +    return ret;
>  }
>  
>  static void vfio_save_cleanup(void *opaque)


