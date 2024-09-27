Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38415CEBF78
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 04:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su2HJ-0003Nu-RM; Fri, 27 Sep 2024 00:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2HI-0003IJ-E6
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2HH-0006GN-1Y
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727410102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mts5FMdKVGfo/GCTYbe4NHGIhp/QJz0rnXTnU5j202M=;
 b=XVWJwyHwQz3lDN8OqXW+Kt+aIkPAK4q8u90YPFx+KttZV181rk1Qx2zk1I0M2jXfu39xoR
 2PsgqR+Bl1zSk3ftQ5xJcah2Qz1h8EtlC4+hRMFHYRhCi2Yi2XBhDjCuX68f6Js/QJT6ch
 NtwTjRwZGgqT7/ArU9QW7Gr3FO2RyrE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-v4_IgLiRNe2AjPipEbrB8Q-1; Fri, 27 Sep 2024 00:08:18 -0400
X-MC-Unique: v4_IgLiRNe2AjPipEbrB8Q-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2e082ab2ad2so2272542a91.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 21:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727410097; x=1728014897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mts5FMdKVGfo/GCTYbe4NHGIhp/QJz0rnXTnU5j202M=;
 b=DI5Pj8TQ5oR8jLfRBx8cObQ14IUccSIIwviy2mrXLtfH49DegICiIjIoDLTOLs91T/
 78p57QOvGqpduwopxEpWPN+258jxlM2tdSnW4gVgA10CfH7F0M5ODBqMRl8j4pwvFMOK
 AxnDbEqx9XvxSJIOHR6qoFn4u+r9kZ6VAQF1sQhxCUmBpd2QgYYlt3smn+NJvK3BufoD
 d2IBZ3Nl8iFb/bIk5bmKAJc3RI77+gEwS5BMDa2yV3+3T7xmtvFbCYHioZbj7n9xP8Ha
 JIWmJ/eBJmxVgk8aLBvcZhevRQp7YANVvGhvJt8rR20n85Mqfgv0HDi9BFJzUPGmm6ue
 2o4Q==
X-Gm-Message-State: AOJu0YwbY2anaxiiO+kgFn9QcFpC2Udtwsf/7xFCN7AV5WUAM4Ml+16S
 XmJXukwdQhdoo8nyFU2usCQ96suVCNUmHTI6hzF5fjN/A4olpuANulrEAdqNFVwS80iAOUr+qpP
 JJGhTJ42v/8YyYLnyVtJPDInilQx3AUu7J8WPF5XK/OXGJ1GFkfKiZc7nRm/7eWDEAgghdapA8q
 czxq6ZluNyFRuvHN92EzTZDGOvIC8=
X-Received: by 2002:a17:90b:3d0:b0:2e0:adbd:78ec with SMTP id
 98e67ed59e1d1-2e0b8ee1139mr2231400a91.39.1727410097415; 
 Thu, 26 Sep 2024 21:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCq3lONO0P10YVW6gZb+8J4sne+F1Mx8V3S1iFB7u2C1un8PBkCjozc22r26I0cAake9tvhXy9VKnBlAwhMqw=
X-Received: by 2002:a17:90b:3d0:b0:2e0:adbd:78ec with SMTP id
 98e67ed59e1d1-2e0b8ee1139mr2231380a91.39.1727410096948; Thu, 26 Sep 2024
 21:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-12-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-12-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 12:08:04 +0800
Message-ID: <CACGkMEs5cwOpUonpdDnSNVfCT=0FQFvMAXhP50ZS=L9e+5ANXw@mail.gmail.com>
Subject: Re: [PATCH v3 11/17] intel_iommu: Add an internal API to find an
 address space with PASID
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Sep 11, 2024 at 1:26=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> From: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.com>
>
> This will be used to implement the device IOTLB invalidation
>
> Signed-off-by: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.c=
om>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


