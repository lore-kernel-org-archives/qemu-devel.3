Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BEBC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 10:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpyz-0007it-RB; Tue, 13 Feb 2024 05:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZpyx-0007iX-Kh
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:25:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZpyw-0008LX-1d
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707819941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nq1+k7c1NEuoZRuUNNPOF6ptTsY8R7UB1pX+7oqkTtE=;
 b=HMfQfivyQDgQi8/swacunIC6x0SNxyT72Da/68j2mCQtbHVQWpZmSbot6C22E2L6EJzhQ9
 DlNTcPdH29whBDaXbSydYbXOYsI4VkzjenDhWIVuQsDlC1ZCuFgnk+8/zHsbLa6RJ3Wqx6
 2QOsMBTkdBJ5zu93lY3yp7asih7oyXM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-PhiIrhpNMgyTO6Ty2WOOTg-1; Tue, 13 Feb 2024 05:25:39 -0500
X-MC-Unique: PhiIrhpNMgyTO6Ty2WOOTg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-559555e38b0so3807772a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 02:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707819938; x=1708424738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nq1+k7c1NEuoZRuUNNPOF6ptTsY8R7UB1pX+7oqkTtE=;
 b=rGUqCcOyGbD2RSS4fGCPjBrBiiuD/TTu5i/oPGGkuGD6F/CCwcahTe1wOB47z6mb+s
 TsUvkV35ZQMY7dv7HPgNoY6p2aslz/5vnLkWvUHVeas/nX3HjjkDarq5leUcRoNATMVq
 1ySL3aJKKa8/hduKc8kkloV/3yZs577HcKjQ7A1V/pXGN5SqCrcpskvkrmMWA5T/FYwH
 VA2zEtQUbL5zDVhbTGILESMZiTe5odoqQd6hj/OsUtjrt8BGJlVEawT+slngXRR/hiBn
 ITSj06fvbcYVdQLHCW0u4Xany8Qzxd5+A20TWCgSItwe90i60Ihnen3T3t6BMdVy1tLu
 KK2g==
X-Gm-Message-State: AOJu0YzzlRxAmvXsvY7hpjzT6Ht8DcVPeYRPSMaVhZotbfrhvSRn55LW
 Uwb5adOjC393Bw1xC6Fv8LdHa37umCL4ykh9+/28nnD8/5ONO82L14ennE8ljfECZ5TvHfONZZH
 aZcRoND2Krmx6Wcs6wV9h3weQFolBBWI8J45vC/JoIuTMXPRtkox/
X-Received: by 2002:a17:906:b2d8:b0:a3c:d134:5e15 with SMTP id
 cf24-20020a170906b2d800b00a3cd1345e15mr2719852ejb.33.1707819938476; 
 Tue, 13 Feb 2024 02:25:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFuMDMlj3yU8h4v76XrW6aFbm5AEKpVfDel25TpksbcIH7h6xbahv6gl5Nk5PcKi3lif7C3w==
X-Received: by 2002:a17:906:b2d8:b0:a3c:d134:5e15 with SMTP id
 cf24-20020a170906b2d800b00a3cd1345e15mr2719840ejb.33.1707819938167; 
 Tue, 13 Feb 2024 02:25:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWyDcji7I2z6COabnHsW3h96+Vf6DIrOQok0o6mw5huWMTkfROlYZYc/sfbv+pPGbUkbKCYsHI8WG/qeV0OxBOtUEUn1qnYLplCeLtR3MNNCy8idLg=
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 r25-20020a170906351900b00a38a476fc08sm1146620eja.87.2024.02.13.02.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 02:25:37 -0800 (PST)
Date: Tue, 13 Feb 2024 05:25:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 0/3] Adjust the output of x-query-virtio-status
Message-ID: <20240213052503-mutt-send-email-mst@kernel.org>
References: <cover.1706883915.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706883915.git.yong.huang@smartx.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
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

On Fri, Feb 02, 2024 at 10:32:14PM +0800, Hyman Huang wrote:
> Sorry for the late post of version 3. The modifications are as follows:
> 
> v3:
> - Rebase on master
> - Use the refined commit message furnished by Markus for [PATCH v2 1/2] 
> - Drop the [PATCH v2 2/2]
> - Add [PATCH v3 2/3] to declare the decoding functions to static
> - Add [PATCH v3 3/3] to Define VhostDeviceProtocols and
>   VirtioDeviceFeatures as plain C types
> 
> Since Markus inspired all of the alterations above, we would like to
> thank him for his contribution to this series.
> 
> Please review,
> Yong

Markus do you think you can take a look at this?

> v2:
> - Changing the hmp_virtio_dump_xxx function signatures to implement
>   the bitmap decoding, suggested by Philippe. 
> 
> This patchset is derived from the series:
> https://lore.kernel.org/qemu-devel/cover.1699793550.git.yong.huang@smartx.com/
> Please go to the link to see more background information.
> 
> The following points are what we have done in the patchset:
> 1. Take the policy of adding human-readable output just in HMP.
> 2. For the HMP output, display the human-readable information and
>    drop the unknown bits in practice.
> 3. For the QMP output, remove the descriptive strings and only
>    display bits encoded as numbers.
> 
> Hyman Huang (3):
>   qmp: Switch x-query-virtio-status back to numeric encoding
>   virtio: Declare the decoding functions to static
>   qapi: Define VhostDeviceProtocols and VirtioDeviceFeatures as plain C
>     types
> 
>  hw/virtio/meson.build       |   3 +-
>  hw/virtio/virtio-hmp-cmds.c | 702 +++++++++++++++++++++++++++++++++++-
>  hw/virtio/virtio-qmp.c      | 684 +----------------------------------
>  hw/virtio/virtio-qmp.h      |   3 -
>  qapi/virtio.json            | 231 +-----------
>  5 files changed, 723 insertions(+), 900 deletions(-)
> 
> -- 
> 2.31.1


