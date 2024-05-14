Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57BAC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 04:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6jsi-0006SB-TE; Tue, 14 May 2024 00:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s6jsg-0006Rh-F1
 for qemu-devel@nongnu.org; Tue, 14 May 2024 00:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s6jse-0008Kd-SG
 for qemu-devel@nongnu.org; Tue, 14 May 2024 00:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715661310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HWSS8mBHfDWCb+Y/OCfv0cO+PW4y+kFL4sUewh2w8UE=;
 b=HS6i5hwR6z1xxoPKHKQRbnPtN8gExE4ey/k3EdskwPadUbBUVJVivrRLxcu4YFtndf2oIW
 H2LQcBdG7QLaPxZsqLj+LDNPMHTYbThVTtNz8U445oeuuabdW0NhD5SCaplqsJA+Uuwilh
 RdQOTQwBHwj2TffcecIAf3KsRon5xG0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-wdENK5biNESdsWzubJ9aZw-1; Tue, 14 May 2024 00:29:05 -0400
X-MC-Unique: wdENK5biNESdsWzubJ9aZw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2b83ee6ef60so1198289a91.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 21:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715660944; x=1716265744;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWSS8mBHfDWCb+Y/OCfv0cO+PW4y+kFL4sUewh2w8UE=;
 b=S1fzqiSdWPFGwQsX76Sdzrm43iT7QUSAYKPrjJBf8S5ra5omhzmtjxcQ9Tv4fk5flI
 66iAdqodXJU0DBC/dByEm3rTWm3QZcpQh+ua68DrOohS0v+nGvOvgMZvnCEIz5cp4Zuh
 SCIVMVzorC11RiXEAZJONLiC1QHIhhfZWBH47EYtUyHKAThuN9x1Ul6gJv6dOSsIq95E
 cmlqdnN00uX3dTSleSj8aXHEPXlLEzMsHu0/HGUyFnkAoTNADGXF3NovfM2MYRVzFH2H
 diXe4udRTgyNe6EUJ6n71Io+5fp8sLv1lazJgT7RaXI0PGfh9uag7P9hFQjoAFxHXXTT
 +LMg==
X-Gm-Message-State: AOJu0Yz4QlPPgzoEW4S/3uxRJTRyR5wEmjXrX1SsR61awAOtvgajqHud
 RIHsnFtNbsYsooLprx0OW9dCmLG+g7oOR5+cKwRQX+yeTIKK7sS2WD2fhVbly/iaM7O4+zY2D+x
 JsWKw3ie5xdV9oTSsv4JrSq1cdOu//LPpMpXKCFHVGlYLcfm9P7zJ
X-Received: by 2002:a17:90a:8c7:b0:2b6:20a0:441e with SMTP id
 98e67ed59e1d1-2b6cd1f1b31mr10866034a91.4.1715660944333; 
 Mon, 13 May 2024 21:29:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKIFii//211rIZ/LMaKwpOSC+NvitE3L5nkW8a5E52b9dzck8ZTm+pBwgbSBhJVy/Chgcx4A==
X-Received: by 2002:a17:90a:8c7:b0:2b6:20a0:441e with SMTP id
 98e67ed59e1d1-2b6cd1f1b31mr10866024a91.4.1715660943834; 
 Mon, 13 May 2024 21:29:03 -0700 (PDT)
Received: from x1n ([67.214.252.166]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ca53c3sm10544674a91.46.2024.05.13.21.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 21:29:03 -0700 (PDT)
Date: Mon, 13 May 2024 22:29:01 -0600
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 3/4] virtio-gpu: add x-vmstate-version
Message-ID: <ZkLojVI4ZAKANIBr@x1n>
References: <20240513071905.499143-1-marcandre.lureau@redhat.com>
 <20240513071905.499143-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240513071905.499143-4-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Hey, Marc-Andre,

On Mon, May 13, 2024 at 11:19:04AM +0400, marcandre.lureau@redhat.com wrote:
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index ae831b6b3e..7f9fb5eacc 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1234,7 +1234,8 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
>      }
>      qemu_put_be32(f, 0); /* end of list */
>  
> -    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL);
> +    return vmstate_save_state_v(f, &vmstate_virtio_gpu_scanouts, g,
> +                                NULL, g->vmstate_version, NULL);
>  }
>  
>  static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
> @@ -1339,7 +1340,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>      }
>  
>      /* load & apply scanout state */
> -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
> +    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, g->vmstate_version);

[sorry for a late response; attending a conf, and will reply to the v1
 thread later for the other discussions..]

These two changes shouldn't be needed if we go with the .field_exists()
approach, am I right?  IIUC in that case we can keep the version 1 here and
don't boost anything, because we relied on the machine versions.

IIUC this might be the reason why we found 9.0 mahines are broken on
migration.  E.g, IIUC my original patch should work for 9.0<->9.0 too.

Thanks,

>  
>      return 0;
>  }
> @@ -1659,6 +1660,7 @@ static Property virtio_gpu_properties[] = {
>      DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
>                      VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
>      DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
> +    DEFINE_PROP_UINT8("x-vmstate-version", VirtIOGPU, vmstate_version, 1),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> -- 
> 2.41.0.28.gd7d8841f67
> 

-- 
Peter Xu


