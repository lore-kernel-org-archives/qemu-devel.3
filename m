Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3548C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 01:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFkKG-0003xL-Lk; Thu, 15 May 2025 21:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkKF-0003vJ-QP
 for qemu-devel@nongnu.org; Thu, 15 May 2025 21:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkKE-0004rK-4l
 for qemu-devel@nongnu.org; Thu, 15 May 2025 21:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747360645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVY3ixE+wqFF3HtEZZpVs3LAmuO0qA4xecvxiLNq1b0=;
 b=QHq1UaMHT6xb2QpAmPrm0MF0k5InRhEkw+jAy/R3+1rV4Xh7Gdq1DNITed36jFpPYeuv7h
 EPrDhg8XJlB9lpaGcVprFsGGL3neTMpLK/sAe63kafwrM1eLJOC9f+rY25GT2tMHSP/b9d
 EY6pxKnwq9Ekh1NInZpDiy7NCupKyDU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-bYY3WFE1NTyzVjAdBCZ3fw-1; Thu, 15 May 2025 21:57:24 -0400
X-MC-Unique: bYY3WFE1NTyzVjAdBCZ3fw-1
X-Mimecast-MFC-AGG-ID: bYY3WFE1NTyzVjAdBCZ3fw_1747360643
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-30c371c34e7so1800406a91.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 18:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747360643; x=1747965443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVY3ixE+wqFF3HtEZZpVs3LAmuO0qA4xecvxiLNq1b0=;
 b=HA+Xj4kWgnAdwrH4nyuB+MU01DLTmCnFfqvYwSuFBta2DlGeCAwz57M65xcDCOp2z5
 jEypGXs7kGJ8cUgu/p9A7176qMc7bD/OwiFJpCZCo1hme9tNDZorsjpNb4npRT64inpD
 m7b3h7YPOWXkPmHsJ0yOvd9JRb4NNABFMez0N/g5QGlOgpFM0ApUBL1ooyN3Ws9p5ezK
 NSLicKYCLYDxCTtztV+6YKCyWltKRKblC/c/bv2EXDcNH0Q1luP+/C/YyJKSL0VOi93a
 FeWvsLA40+a2Lqp7EvcCQVK4YQvDCNektenF3GkNiTNl35g1iuwdwu8zy0E3CV2RtVXa
 GdRQ==
X-Gm-Message-State: AOJu0YzBnS+SRRQ9ZFYPbRyXgZTUIxxeoF7s5ckGa0lZ4m8y0+FJFarf
 /ohIE0DKr7alK3SHLg3/sc4ao/a2zLOacMoXyDfvCha7W3tI5x3pAAZMyuxkdo84SpNN2tRvWCt
 JYwilB4mHj5wfWOgvYubJ0dF23HhTAIVssyf84FqA3k8/KADUM323Ihv9zihgLXa8DqLrDtN3wb
 uhpYiL8gIMFkw2Tvf2UbRT+RSrGmXlCFA=
X-Gm-Gg: ASbGncuWUHyIcPg4+hur91XFf4Lg518QSw/kyMDtu/brFJwVpuV6OdkmXZhdNRo14ut
 PLFD8BiJhyiPkBvIAUJ31Bi8j763EVYVHCNakHBe3ibVwFHZRJoJA/1oXB5e3mgDdHsDobA==
X-Received: by 2002:a17:90b:5410:b0:301:1d03:93cd with SMTP id
 98e67ed59e1d1-30e83216f58mr1065220a91.24.1747360643279; 
 Thu, 15 May 2025 18:57:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsl9Ij38kOI/S7r89serPmMrVs2RLxVENOVPSlECMDCow0daKEy9MzjNRgBg71yuEmpIiLSEb1JAfcaAWT7Us=
X-Received: by 2002:a17:90b:5410:b0:301:1d03:93cd with SMTP id
 98e67ed59e1d1-30e83216f58mr1065196a91.24.1747360642880; Thu, 15 May 2025
 18:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <20250507184647.15580-4-jonah.palmer@oracle.com>
In-Reply-To: <20250507184647.15580-4-jonah.palmer@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 May 2025 09:57:11 +0800
X-Gm-Features: AX0GCFt0FUD16jDHVM30LcSlLn1HEEIm-hvM4O7cJN8zGB1_VC2bxvJ1WmulCPA
Message-ID: <CACGkMEsMMuYqTzcnSpqbywRqY1u7Vpr80Mz0cKjrEJFOOX8fgQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] vdpa: set backend capabilities at vhost_vdpa_init
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
> The backend does not reset them until the vdpa file descriptor is closed
> so there is no harm in doing it only once.
>
> This allows the destination of a live migration to premap memory in
> batches, using VHOST_BACKEND_F_IOTLB_BATCH.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


