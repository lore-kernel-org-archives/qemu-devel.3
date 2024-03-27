Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C26C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 10:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpQpH-0007Ts-3e; Wed, 27 Mar 2024 06:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rpQpG-0007Sl-2i
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:48:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rpQpD-0005H5-Qx
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711536484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXBxrCu5SpyrX8b+VhoQcqNOoW1fSO7h2QZ8FVVrEr4=;
 b=YkvovDN1lDVsYDDcVgzjswWfjtw/YYCqZd02Nvab/A+K+s/uJB4OKwXbZtRDmTDtoFgoDC
 PDwi56u5EObyVdBnB3M69fDaV3Okn3L8ppout6Vb2jAbdnvWAo6Qrfeg0CcNr5QopBNe4R
 7/qqemqcUqMB7fFFr/JvtJDkdf5sLuA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-4_CiNJjHPzqJ6uGt8iHoEA-1; Wed, 27 Mar 2024 06:48:03 -0400
X-MC-Unique: 4_CiNJjHPzqJ6uGt8iHoEA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a4698fc37dfso418471966b.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 03:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711536482; x=1712141282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXBxrCu5SpyrX8b+VhoQcqNOoW1fSO7h2QZ8FVVrEr4=;
 b=nsDQQytrVpEFrzwCVWrAJzOOFVGe/OkNvlV/m08TPOfN5u3U4gwDf7RV/4csYPAvcC
 lDoNk06BCjx4+1z54HUTtmF9muOugZdw+QtVsvtuhCpfUL2Q8XbZsnCg7ekTnk6F6BXH
 HK4HSFWeTvQw+1y2Z+qpOg5X5pDVpAF5IT1EbjbHsFduutSOauvWbwOXO9mAFatmDfrx
 wYUqbc5Gh5MwuOhQkz9FZkvBPF44WCZlYDrPQEd1pCqJczRgiEl5mcbe3IVUgZSDCgZL
 K4JI0fRsVxVAsr8tWBC2DSK7LiTrKj00MpuhVRxzpL3i5GBhix4NSQolmGQBTYXRBYY6
 OSmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPXYeWeYkiJYDPNYpgdV3gqBcsm5Z8IqtXEjYb7uzLY9YrGH5dK+lZQhcd+HisAt5Tuclf6V0Kn0Ed3X/8jQInO6Hzpxw=
X-Gm-Message-State: AOJu0YyENYMZDV4aGI5w1qS1IhBi3D3m+w9fQYhkGkWK0ZsOyNwJwTHa
 iP+Dz4jBgEiigYjBYjZVMyMLxNPetu89huEcHLwCJ1dIUo/QWkxuuGrZIGIO+9doOj1VPRAsRlo
 n6ClwI6s62Imo8AXJUVs1iZHXcQ7nizTF7a/ud3kPSCmsnnr2DPGe
X-Received: by 2002:a17:906:b30a:b0:a4e:16f:73b6 with SMTP id
 n10-20020a170906b30a00b00a4e016f73b6mr1248822ejz.61.1711536482027; 
 Wed, 27 Mar 2024 03:48:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC6iHiWdA8j6919j4Exb7t6E04fRUSwJEho/7HL8QefjauRTNf4JugZ12APv8neOsTYDC5WA==
X-Received: by 2002:a17:906:b30a:b0:a4e:16f:73b6 with SMTP id
 n10-20020a170906b30a00b00a4e016f73b6mr1248803ejz.61.1711536481659; 
 Wed, 27 Mar 2024 03:48:01 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 ao18-20020a170907359200b00a46aba003eesm5249366ejc.215.2024.03.27.03.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 03:48:01 -0700 (PDT)
Date: Wed, 27 Mar 2024 11:47:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Yajun Wu <yajunw@nvidia.com>
Cc: "fengli@smartx.com" <fengli@smartx.com>, 
 "raphael.norwitz@nutanix.com" <raphael.norwitz@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "mst@redhat.com" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Subject: Re: vhost-user-blk  reconnect issue
Message-ID: <vzwqswsxtiios4mzwab4br2utyrclkfsluwyvyw6r7gqnx55fv@z3rsaj4hs6cz>
References: <DM4PR12MB5168C0DB5E4B8F30B47738F6B6362@DM4PR12MB5168.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5168C0DB5E4B8F30B47738F6B6362@DM4PR12MB5168.namprd12.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Yajun,

On Mon, Mar 25, 2024 at 10:54:13AM +0000, Yajun Wu wrote:
>Hi experts,
>
>With latest QEMU (8.2.90), we find two vhost-user-blk backend reconnect 
>failure scenarios:

Do you know if has it ever worked and so it's a regression, or have we 
always had this problem?

Thanks,
Stefano

>1. Disconnect vhost-user-blk backend before guest driver probe vblk device, then reconnect backend after guest driver probe device. QEMU won't send out any vhost messages to restore backend.
>This is because vhost->vdev is NULL before guest driver probe vblk device, so vhost_user_blk_disconnect won't be called, s->connected is still true. Next vhost_user_blk_connect will simply return without doing anything.
>
>2. modprobe -r virtio-blk inside VM, then disconnect backend, then reconnect backend, then modprobe virtio-blk. QEMU won't send messages in vhost_dev_init.
>This is because rmmod will let qemu call vhost_user_blk_stop, vhost->vdev also become NULL(in vhost_dev_stop), vhost_user_blk_disconnect won't be called. Again s->connected is still true, even chr connect is closed.
>
>I think even vhost->vdev is NULL, vhost_user_blk_disconnect should be called when chr connect close?
>Hope we can have a fix soon.
>
>
>Thanks,
>Yajun
>


