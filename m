Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8EEC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Aoy-0001kz-H3; Wed, 15 May 2024 05:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s7Aot-0001jZ-IZ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s7Aor-00065C-BG
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715764863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WsDWJa6VGVi+6mwMFhWtGEImbbZg8quH+TAej9dXJTw=;
 b=eWT83Zn+KIc8F5Ce8vgc7e61qJwjyaZlA8CXBUWSlgm4Ody37plSOkzwrzJapPC000Zqgn
 5z1FB3Bpeu+HTigwXniALMDEFxrtN2pFW7onF1jKpYimhdsbZNwdygeEiaKUMw3Kf4CVOT
 i39yo/QA0G9Zp7XikWcjKjITOQvyt30=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-I0dJ5-jAOZm28LSsXWHxBQ-1; Wed, 15 May 2024 05:20:52 -0400
X-MC-Unique: I0dJ5-jAOZm28LSsXWHxBQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-de54be7066bso11562006276.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715764852; x=1716369652;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WsDWJa6VGVi+6mwMFhWtGEImbbZg8quH+TAej9dXJTw=;
 b=TGDeb5DbN8FeIleCjeTR+GYHTpYCQIw9fdn94KYxd9YUpJu9qdIiwBjLjUrhtFbONV
 8mhjX/Wt6uH/NcKLdM+PFbIhSvnrlM3z4fZdkJm/HlqD+C6SAE/Xod9BQdA9Uc/WvrQD
 eQcDuWZ+9o+g+fbjsOsn3CAza/mSjkFv+GD+izIujMwCKNMlWb9Ci1lo7r5qEsMQOqQi
 yvn4xzqj9oHs/CBKgTrnYc6wDF6MfLz+yus6ZwmnvPRXjlLjwETVO/OXVnE28QCl2iu7
 2YuDHuOpTlBoeyts5yIl6eM13xYLQS9yRZbVQmMHQFFapIojGpTTs9TtX7fcuQjsE54N
 62hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb0R46pCj5d7RVNxgP4UO+dPczXKbbWUNPOIfsA4ufa+TQryLMn1jsj12gjRt1M/6aGLG0jAnFqiCgEIMOR/765R7Bn34=
X-Gm-Message-State: AOJu0YwBFUybfIdVA9QXvMk6/edUQJZ0CGqpA5HzGS68igJabkR8OU8N
 jv33U52N+e4UgeIrePJnO5xJEIzhx07TqtJVOc43/njSamwVVPixzo0U03mImh5P349+1Jxqtiy
 I2nkKsuPG2lKu0JtFfWApHEzxVh1Jsg7Nb7Nleb6ugHKpQHDerQNU
X-Received: by 2002:a05:6902:110:b0:de6:3d8:3deb with SMTP id
 3f1490d57ef6-dee4f2cfb46mr14543513276.21.1715764851779; 
 Wed, 15 May 2024 02:20:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUdP8N/HN0Wb4NYBKxuwvSiRpkQCCubm5S75jesu8pc0BkeE2eQn2zGQEafDY9UV/fHpqykg==
X-Received: by 2002:a05:6902:110:b0:de6:3d8:3deb with SMTP id
 3f1490d57ef6-dee4f2cfb46mr14543488276.21.1715764851327; 
 Wed, 15 May 2024 02:20:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1cd282sm61760836d6.78.2024.05.15.02.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 02:20:50 -0700 (PDT)
Message-ID: <215af6fa-6dfa-492b-81f1-6c83d1744f8a@redhat.com>
Date: Wed, 15 May 2024 11:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] vfio/migration: Add Error** argument to
 .vfio_save_config() handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-6-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240514153130.394307-6-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/14/24 17:31, Cédric Le Goater wrote:
> Use vmstate_save_state_with_err() to improve error reporting in the
> callers and store a reported error under the migration stream. Add
> documentation while at it.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>  Changes in v6:
> 
>  - Modified title (Avihai) 
>  - vfio_save_device_config_state() : Set errp if the migration stream
>    is in error (Avihai) 
>  - vfio_save_state() : Changed error prefix  (Avihai)
>  
>  include/hw/vfio/vfio-common.h | 25 ++++++++++++++++++++++++-
>  hw/vfio/migration.c           | 25 ++++++++++++++++++-------
>  hw/vfio/pci.c                 |  5 +++--
>  3 files changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b9da6c08ef41174610eb92726c590309a53696a3..46f88493634b5634a9c14a5caa33a463fbf2c50d 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -133,7 +133,30 @@ struct VFIODeviceOps {
>      int (*vfio_hot_reset_multi)(VFIODevice *vdev);
>      void (*vfio_eoi)(VFIODevice *vdev);
>      Object *(*vfio_get_object)(VFIODevice *vdev);
> -    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
> +
> +    /**
> +     * @vfio_save_config
> +     *
> +     * Save device config state
> +     *
> +     * @vdev: #VFIODevice for which to save the config
> +     * @f: #QEMUFile where to send the data
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
> +    int (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f, Error **errp);
> +
> +    /**
> +     * @vfio_load_config
> +     *
> +     * Load device config state
> +     *
> +     * @vdev: #VFIODevice for which to load the config
> +     * @f: #QEMUFile where to get the data
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>      int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
>  };
>  
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index bf11135167ebb162dd41415656bdacfa0e1ca550..d089fa9b937e725307c1a56755495d5b8fae2065 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -189,21 +189,30 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>      return ret;
>  }
>  
> -static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
> +static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
> +                                         Error **errp)
>  {
>      VFIODevice *vbasedev = opaque;
> +    int ret;
>  
>      qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
>  
>      if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
> -        vbasedev->ops->vfio_save_config(vbasedev, f);
> +        ret = vbasedev->ops->vfio_save_config(vbasedev, f, errp);
> +        if (ret) {
> +            return ret;
> +        }
>      }
>  
>      qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>  
>      trace_vfio_save_device_config_state(vbasedev->name);
>  
> -    return qemu_file_get_error(f);
> +    ret = qemu_file_get_error(f);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Failed to save state");
> +    }
> +    return ret;
>  }
>  
>  static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
> @@ -588,13 +597,15 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>  static void vfio_save_state(QEMUFile *f, void *opaque)
>  {
>      VFIODevice *vbasedev = opaque;
> +    Error *local_err = NULL;
>      int ret;
>  
> -    ret = vfio_save_device_config_state(f, opaque);
> +    ret = vfio_save_device_config_state(f, opaque, &local_err);
>      if (ret) {
> -        error_report("%s: Failed to save device config space",
> -                     vbasedev->name);
> -        qemu_file_set_error(f, ret);
> +        error_prepend(&local_err,
> +                      "vfio: Failed to save device config space of %s - ",
> +                      vbasedev->name);
> +        qemu_file_set_error_obj(f, ret, local_err);>      }
>  }
>  
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 64780d1b793345c8e8996fe6b7987059ce831c11..fc6e54e871508bb0e2a3ac9079a195c086531f21 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2586,11 +2586,12 @@ static const VMStateDescription vmstate_vfio_pci_config = {
>      }
>  };
>  
> -static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
> +static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
>  {
>      VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>  
> -    vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL);
> +    return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config, vdev, NULL,
> +                                       errp);
>  }
>  
>  static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
Looks good to me
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric




