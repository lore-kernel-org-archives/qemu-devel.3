Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82801C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9f1O-0007B7-74; Wed, 22 May 2024 02:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9f10-00075G-Lq
 for qemu-devel@nongnu.org; Wed, 22 May 2024 01:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9f0y-0001oM-S7
 for qemu-devel@nongnu.org; Wed, 22 May 2024 01:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716357590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUEsupehcX3SULyjnqZnWG49r7URleIogYc+rHF8K+k=;
 b=BSv7+ap1aLx0aVFtqs9keaeWsc6QTsWEOvdyOJ273GiLgpbjySCbVDBVd3YmBOYdVcEvsI
 9q6hgcmZ5xENc9D1UNO27cNzQMtgYcKO5QNMeMvnaiha2nleTmKmg3pufm4t70b58+Zi1A
 CpjtrpxsJaKJYiL9gtANSCGccOyq+XY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-c8U2GV5cNMaHBzgGcnx3NA-1; Wed, 22 May 2024 01:59:48 -0400
X-MC-Unique: c8U2GV5cNMaHBzgGcnx3NA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6ab8467e576so2740336d6.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 22:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716357588; x=1716962388;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tUEsupehcX3SULyjnqZnWG49r7URleIogYc+rHF8K+k=;
 b=Y1hkdrUboOTAcjTW/FbWXa+cCxy+o63aMLy3LmqX+T9LwJphLjqyTp3hR5VqTfC21/
 yAQcEa6/Dc7UCCAj8QBC2i9wqmNy5yd8tqJoTwEpaAg1V3WFWdCffqGdHlw3QxecLU2A
 oaM53r/egwt9lIZDfO34OsWVw3rXiMMB4fQhqJDv1qXPoDW3YSDh3COJu9J9UFfxdhRN
 zH4uqWKjl4ycb+/AAoTcPuYSV8ooce6iPxK+6q2pSoCv9s6RcyXr7znIADNwPBM9ruNx
 +Rw7E27U5FxmpfOXR+e2pOLBIwIRoBhAG4E0l7aUNfaRBztCt4KisJkdknSeGm7uDljs
 l9qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPgIRiDwfQR9r95BDa+zXoSJAI8197yMfyBgm93knch09es3GA7NwZAdw+7vtemH5fFv1L7lh25q8RHaMSf6kCk7tq2H0=
X-Gm-Message-State: AOJu0YzyyX8NpUEpM9RtinMFKvySjhNEMP6meJzxx7mw9MCVFekii0d1
 G91YqoxK/NKbAEsqrk/lzMvyuGCy6DktvAGKrVfUoZQUoPWKIcv2voXk9Gnwg9I01xFjhN6cY3f
 OfycA7DzuxbIG7Xq+OyK3vDlrKM4BG7D/CyWhbnCKozsIcREVz5xo
X-Received: by 2002:a05:6214:5343:b0:6ab:988:c7c6 with SMTP id
 6a1803df08f44-6ab7f35362fmr11273496d6.21.1716357588069; 
 Tue, 21 May 2024 22:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM3h5Hj9lFjb6LJBhulik7/T/ag1zlTXwhwBPy9loSTg9LgF1udnDdhHK2RUjXEnGopuhJGg==
X-Received: by 2002:a05:6214:5343:b0:6ab:988:c7c6 with SMTP id
 6a1803df08f44-6ab7f35362fmr11273366d6.21.1716357587593; 
 Tue, 21 May 2024 22:59:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1cd35bsm130344046d6.87.2024.05.21.22.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 22:59:47 -0700 (PDT)
Message-ID: <f302bb10-3070-45d1-a141-eeb66576ee04@redhat.com>
Date: Wed, 22 May 2024 07:59:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/20] vfio/helpers: Use g_autofree in
 vfio_set_irq_signaling()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
 <20240522044015.412951-4-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240522044015.412951-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/22/24 06:39, Zhenzhong Duan wrote:
> Local pointer irq_set is freed before return from
> vfio_set_irq_signaling().
> 
> Use 'g_autofree' to avoid the g_free() calls.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/helpers.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 47b4096c05..1f3bdd9bf0 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -111,7 +111,7 @@ int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
>                              int action, int fd, Error **errp)
>   {
>       ERRP_GUARD();
> -    struct vfio_irq_set *irq_set;
> +    g_autofree struct vfio_irq_set *irq_set = NULL;
>       int argsz, ret = 0;
>       const char *name;
>       int32_t *pfd;
> @@ -130,7 +130,6 @@ int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
>       if (ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
>           ret = -errno;
>       }
> -    g_free(irq_set);
>   
>       if (!ret) {
>           return 0;


