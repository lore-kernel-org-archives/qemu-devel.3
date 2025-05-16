Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA27DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 01:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFkG1-00070Z-2I; Thu, 15 May 2025 21:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkFy-0006s9-PB
 for qemu-devel@nongnu.org; Thu, 15 May 2025 21:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkFx-0004Z5-5r
 for qemu-devel@nongnu.org; Thu, 15 May 2025 21:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747360380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Da9BEi87hwdb8tEIIb0yaJkvNUn00hqf0M/Cquz67FE=;
 b=YbqdSno1rlW939BJgSWsCTKAVrh1p2argUtY/xP+0dV1oq/TWhtLHh9nRJwYcPCZ0ZzTkM
 ilrQ1BFPljKNtVamU1H5zJGtI/u97hXQ/X1ZHCPzg3bE5YaodPgUpP3QTTes7RbiTIjguM
 0vsBIbsFp1srhqxoh5rWglKDpXtTxaQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-1jsUTSzqNLiUvwT1d0O9NQ-1; Thu, 15 May 2025 21:52:59 -0400
X-MC-Unique: 1jsUTSzqNLiUvwT1d0O9NQ-1
X-Mimecast-MFC-AGG-ID: 1jsUTSzqNLiUvwT1d0O9NQ_1747360378
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b26eec6da92so99871a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 18:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747360378; x=1747965178;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Da9BEi87hwdb8tEIIb0yaJkvNUn00hqf0M/Cquz67FE=;
 b=tCf7TYU8Ea/Etot6ikk0RmvFXXKRoBN1+BBwHILUDLjh5DIyD+f1M7LhRg4onlBBqQ
 kshgkfx5rbYyS16NEynHjlcDar1nDkbmubiIMjRLnMgbn6vRmTjv/tm/95ZtrlWZ5BHt
 NIqTzwSk2+6wiS1uL4zSDVW6nJvm2h7waDHh1NW9GYiKfBOp90t2thXvgko7+Soaee7f
 TMWeXmFxOoil4RZXcuLivtH8KNs2LNYrEPcSyBZ7iZl4wloS/4TJHsqjigE6rkgBhzex
 kzq+aSFF+bWaEdXiU3Y1OPWuAv7zk6t2Mn14s3v2UnfeXnB69w4q8nzV+39LGEoKRaQC
 0wkw==
X-Gm-Message-State: AOJu0YwuLtgEvYGvkgeehS90zEE1mITVuHIm73TE6BDouTgZfhCVwZK/
 CXHKZYxnrikfmE80rdlZ1D1h4v7u66ST41Ed4nBF2awZc183w1WJeNli6V4homikzTyb5U24Wyn
 mwNDUYuAAtbjmYobOLnRE9I/5OJ3zmtaHk4oH6yfmCuQ2alh+pRH7IrY9OWCkntDMrA3bIdwhSg
 nPM7ER4LHW6dIxQnwI2r92Wngt2XWaQmo=
X-Gm-Gg: ASbGnct2HPPNHT2XzjSzUAk8JfbfzFWjiES0j7Wdl4tbNOGVZGVRfbZdu0WftvfkRoS
 1vLF4AVAJ8QWPDQobBjs21YYyUW8WtRJo0ixeKB7r+5mVMcX6dKYS3wjAONeTrlkNLBQGzA==
X-Received: by 2002:a17:90b:3bce:b0:2fe:b907:5e5a with SMTP id
 98e67ed59e1d1-30e4db3d8c5mr6814215a91.10.1747360377942; 
 Thu, 15 May 2025 18:52:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr2WIM8YAenwTY+VLaVTf9XVO+RZHVtqGizlFQ5nsQFTPVWHaUBD2PnZ1atA8KW2gC9eEfbQWy+yzwmhbhlak=
X-Received: by 2002:a17:90b:3bce:b0:2fe:b907:5e5a with SMTP id
 98e67ed59e1d1-30e4db3d8c5mr6814178a91.10.1747360377510; Thu, 15 May 2025
 18:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <20250507184647.15580-2-jonah.palmer@oracle.com>
In-Reply-To: <20250507184647.15580-2-jonah.palmer@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 May 2025 09:52:46 +0800
X-Gm-Features: AX0GCFteR0uO_iJ23v7tzlho0BB3rRFHYFJulN-k4x-tBXHcT7gfAdsQXmoz3M0
Message-ID: <CACGkMEtmz7H3_MbuM3e6+QsqxnNvfak0Lu9AJ52NLNOyxLiP6w@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] vdpa: check for iova tree initialized at
 net_client_start
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, peterx@redhat.com, 
 mst@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com, leiyang@redhat.com, 
 parav@mellanox.com, sgarzare@redhat.com, si-wei.liu@oracle.com, 
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 8, 2025 at 2:47=E2=80=AFAM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> From: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> To map the guest memory while it is migrating we need to create the
> iova_tree, as long as the destination uses x-svq=3Don. Checking to not
> override it.
>
> The function vhost_vdpa_net_client_stop clear it if the device is
> stopped. If the guest starts the device again, the iova tree is
> recreated by vhost_vdpa_net_data_start_first or vhost_vdpa_net_cvq_start
> if needed, so old behavior is kept.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  net/vhost-vdpa.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 7ca8b46eee..decb826868 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -366,7 +366,9 @@ static void vhost_vdpa_net_data_start_first(VhostVDPA=
State *s)
>
>      migration_add_notifier(&s->migration_state,
>                             vdpa_net_migration_state_notifier);
> -    if (v->shadow_vqs_enabled) {
> +
> +    /* iova_tree may be initialized by vhost_vdpa_net_load_setup */
> +    if (v->shadow_vqs_enabled && !v->shared->iova_tree) {
>          v->shared->iova_tree =3D vhost_iova_tree_new(v->shared->iova_ran=
ge.first,
>                                                     v->shared->iova_range=
.last);
>      }
> --
> 2.43.5
>


