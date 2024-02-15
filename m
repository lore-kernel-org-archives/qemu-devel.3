Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D257EC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 16:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raePc-0002Dp-4Y; Thu, 15 Feb 2024 11:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1raePa-00026Z-B9
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:16:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1raePY-0005Pq-NF
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708013791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yEYPwmwW4lDvZVjJAc525Jg6AdN67kQgs6vAKprzUsY=;
 b=CLGPkHG/Km8wo3PL+wRECnzvMbBD8LXbI08HhktprOaMD5Zjkh8b9jfDtj3QGG+Vgb1PBL
 Ijb+4wb488rK8jjnyHBvD+gUVa4mK3e7Llnp5wDe6GVv5qaHLMuhET1pEH89pEzNKQNN0o
 Vaz7CV5ayj5Cs/OSBrYFRiep6qUCUws=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-NBpcWFd1M7O9NbaFWgZJEg-1; Thu, 15 Feb 2024 11:16:29 -0500
X-MC-Unique: NBpcWFd1M7O9NbaFWgZJEg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-607df0c12abso7523267b3.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 08:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708013789; x=1708618589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yEYPwmwW4lDvZVjJAc525Jg6AdN67kQgs6vAKprzUsY=;
 b=BzyvxMu+J3Gr+Bn3PGauDKK5zc6UNt0Zx1tRjEmxOFW8OfN3Kd4OGfSuW4F48lFlgn
 IAycPeJi2t+fOQMNYoI409z9YSIcwm6MWVvBGwXKrinckCKSvrZR6YBGO1akceyJ8sbE
 jhVC1TjL8EE8C8p/ArOQ5GVSSfJBQ5UIvE3czlXrhBDbH3AnMLjCi42OenrxiHPLSoWp
 3iQqZR+biVLePEj/L+Sw+38Whz7FSnKW+K2zS6kudaIps//brYroCiYxZTmuaMiEOoHK
 pbI2KLkc0uWdGc3nZM19NyCHV/6lrL45Czqqklbm3wyC+teUw6qyO/qoeAgUtzg02GkU
 B2Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV37jgSPifflj+IEu8StZ/T6vn/f9yGCv9WfqrgVXFtaZh8UjGmSpF/80fD7JikYA8cZuJ9vfATPzWf+Un30I82PgYfjwg=
X-Gm-Message-State: AOJu0Yy4S+e7xYXbdvfP7UqtPN40PD0KoSWXVqjLVF53+Y1orgx2AR1H
 CqGhs5pxpyw0eM/bRha74ZnksbzlI2VKk91Rb4J0plSWsjF0CGroRYd30EUU11teDwQXmBKojIL
 T21aAKYnt4IzmtxZLQBFZqavfeE76Y/QBdeqlE+l0Csq46KGO17L+nk8x+DmM+3JVsUbBI5u8Hl
 SR2S/YIk0U2npBMgFp3KSQYAticnw=
X-Received: by 2002:a0d:d5c4:0:b0:5f7:1006:3f54 with SMTP id
 x187-20020a0dd5c4000000b005f710063f54mr2160112ywd.15.1708013789265; 
 Thu, 15 Feb 2024 08:16:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9LTwdyiFVUNunwBjh9ZFEvDRT0AN6MMtFldIJ+V1Ls0p9Qst74tvLrwV+javqMi7FOMxZkjf6pixZYaaqwIM=
X-Received: by 2002:a0d:d5c4:0:b0:5f7:1006:3f54 with SMTP id
 x187-20020a0dd5c4000000b005f710063f54mr2160103ywd.15.1708013788998; Thu, 15
 Feb 2024 08:16:28 -0800 (PST)
MIME-Version: 1.0
References: <1707910082-10243-1-git-send-email-si-wei.liu@oracle.com>
 <1707910082-10243-13-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1707910082-10243-13-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 15 Feb 2024 17:15:52 +0100
Message-ID: <CAJaqyWe9t=jkW2ZQvv5Z6+4x9R2DQhSKbqVNDUN1b2WXfiSVfQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] vdpa: fix network breakage after cancelling
 migration
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
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

On Wed, Feb 14, 2024 at 1:39=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Fix an issue where cancellation of ongoing migration ends up
> with no network connectivity.
>
> When canceling migration, SVQ will be switched back to the
> passthrough mode, but the right call fd is not programed to
> the device and the svq's own call fd is still used. At the
> point of this transitioning period, the shadow_vqs_enabled
> hadn't been set back to false yet, causing the installation
> of call fd inadvertently bypassed.
>
> Fixes: a8ac88585da1 ("vhost: Add Shadow VirtQueue call forwarding capabil=
ities")
> Cc: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  hw/virtio/vhost-vdpa.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 004110f..dfeca8b 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1468,7 +1468,15 @@ static int vhost_vdpa_set_vring_call(struct vhost_=
dev *dev,
>
>      /* Remember last call fd because we can switch to SVQ anytime. */
>      vhost_svq_set_svq_call_fd(svq, file->fd);
> -    if (v->shadow_vqs_enabled) {
> +    /*
> +     * When SVQ is transitioning to off, shadow_vqs_enabled has
> +     * not been set back to false yet, but the underlying call fd
> +     * will have to switch back to the guest notifier to signal the
> +     * passthrough virtqueues. In other situations, SVQ's own call
> +     * fd shall be used to signal the device model.
> +     */
> +    if (v->shadow_vqs_enabled &&
> +        v->shared->svq_switching !=3D SVQ_TSTATE_DISABLING) {

I think it would be great to not need to add more status variables to
vhost_vdpa (or any struct).

What if we recover the call file descriptor at vhost_vdpa_svqs_stop?
This way everything is more symmetrical as kick and call are set by
vhost_vdpa_svqs_start.

Thanks!

>          return 0;
>      }
>
> --
> 1.8.3.1
>


