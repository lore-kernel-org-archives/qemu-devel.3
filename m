Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BC0C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWEL-0002cG-1O; Mon, 10 Feb 2025 11:01:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1thWEJ-0002bS-Re
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:01:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1thWEH-0006jz-Ba
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739203306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VZY/VyBKCNyzaOSV3v6x2uVgDbUIdIS5Q2pD1yrUts=;
 b=W/5YNpGSaQl94jm5FvJDq+3zP1v0Qx+AKOZlCfSsWQJkpOKzsicAgpmCPPoacyAa50Ki7w
 oa6q48pKI0Wes1+zcdeSiEHUYkcOElGyXava7a0Pyved4VofCI7Y3UBzjb70fOFkafZBXf
 v5m9TinPH2IqjDOM+EqMOFwOLeCHlKs=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-x-tYZJaENJKJJ_Me3UrbXw-1; Mon, 10 Feb 2025 11:01:44 -0500
X-MC-Unique: x-tYZJaENJKJJ_Me3UrbXw-1
X-Mimecast-MFC-AGG-ID: x-tYZJaENJKJJ_Me3UrbXw
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-8552a33a7d6so3431039f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739203304; x=1739808104;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3VZY/VyBKCNyzaOSV3v6x2uVgDbUIdIS5Q2pD1yrUts=;
 b=LhSWgIx4DQpbdvXKm02ElMxZ+0KjeETQwdmfrnJIeDnxfBbUl/LhI9UvX9NU+734Id
 loSTVmEnQ/GE9BMd1jzxzdyVR8HQFcTeyKCM1C+SkOne5uNkftprq+bw3ERF9iSDV7EN
 amsXp1v/0TVPVou+KpeSCt+kW0Avq9LSahViOY0JGUOs7uh39eW4Chh03Xj4G0od9AZr
 3nqqzSlezsYMvcfam+xJg+06LlqP9SEvE6WOMRi5opwPK3pTmWllZJWCdI9oqBZPt8Uy
 jyhw9eDaCZ9urrWGw3KWaKs4Atc10L7ugZTbPAX79zh9DgXM0s1/+gto0TpKysbaxKY3
 0y+w==
X-Gm-Message-State: AOJu0YyZI4hnOwHrXJ4GvUfid/nMgbdjC42zeLWdLKYQkzXQPBYcG5nt
 3dOlgCJMQMXsU3hCCwyWrv8baZv1JrMp44bBVJB/ggXMLDBwd4af2OIHm7wkgQlpDG1WLi52eCu
 6xo1kIBwNWDizhX3kipW/YLu7v4fyUCPZCNRglRb6YGhRuD9ChtEd
X-Gm-Gg: ASbGncu0d7mB+Pnq5p90PiNwRVXejEOdqnTbO4LVx9Yh42CpTdkfBtXCb8rD6oC9A2o
 m18A0akFs8IJF4Ik7vB5W62b9XIf1HIUVp1SvoREog49wX44T+jSlA67DnZUJmvYfCWZSdUCae6
 77LhoWwNwem6e/gju9bCzwa27YcwbYlFQbEg4m06OvQ0oB2/+62zUeFHRSuImVGqinQRuVPUCpT
 OZIeTgoTyOoLp+GHI68U5WvMsoNpyfugv8oxVQ1t/ZGX7FzpBuFN2VxeIvPzqBQ8eDn8of54ynE
 EIbdqBBb
X-Received: by 2002:a05:6602:7288:b0:83a:e6b2:be3 with SMTP id
 ca18e2360f4ac-854fd9bddbemr363581439f.0.1739203303730; 
 Mon, 10 Feb 2025 08:01:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFn/sMfHIYaqa1Att9uIbWhiYF9nN4SBZ+IzGRFvsmhhtcCO7MrQGoXd9Smd6h76w4oqVzkQ==
X-Received: by 2002:a05:6602:7288:b0:83a:e6b2:be3 with SMTP id
 ca18e2360f4ac-854fd9bddbemr363580239f.0.1739203303345; 
 Mon, 10 Feb 2025 08:01:43 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8552a2f7677sm62787939f.5.2025.02.10.08.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:01:42 -0800 (PST)
Date: Mon, 10 Feb 2025 09:01:40 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/7] vfio: Improve error reporting when MMIO region
 mapping fails
Message-ID: <20250210090140.1b944892.alex.williamson@redhat.com>
In-Reply-To: <20250206131438.1505542-1-clg@redhat.com>
References: <20250206131438.1505542-1-clg@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
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

On Thu,  6 Feb 2025 14:14:28 +0100
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Hello,
>=20
> Under certain circumstances, a MMIO region of a device fails to map
> because the region is outside the supported IOVA ranges of the VM. In
> this case, PCI peer-to-peer transactions on BARs are not supported.
> This typically occurs when the IOMMU address space width is less than
> the physical address width, as can be the case on some Intel consumer
> processors or when using a vIOMMU device with default settings.
>=20
> This series tries to clarify the error message reported to the user.
>=20
> Thanks,
>=20
> C.
>=20
> Changes in v3:
>=20
>  - Fixed warn_report_err_once()
>  - Improved commit logs a bit=20
>  - Dropped check on compatibility of CPU and IOMMU address space
>    width. Will address later in its own series.
>=20
> Changes in v2:
>=20
>  - Removed advice on how to resolve the issue. Diagnostic is enough.
>  - Introduced helpers
>  - Checked device type, since this only applies to PCI
>  - Added cleanup
> =20
> C=C3=A9dric Le Goater (7):
>   util/error: Introduce warn_report_err_once()
>   vfio/pci: Replace "iommu_device" by "vIOMMU"
>   vfio: Rephrase comment in vfio_listener_region_add() error path
>   vfio: Introduce vfio_get_vfio_device()
>   vfio: Improve error reporting when MMIO region mapping fails
>   vfio: Remove reports of DMA mapping errors in backends
>   vfio: Remove superfluous error report in vfio_listener_region_add()
>=20
>  include/hw/vfio/vfio-common.h |  1 +
>  include/qapi/error.h          | 12 +++++++++++
>  backends/iommufd.c            |  3 ---
>  hw/vfio/common.c              | 40 +++++++++++++++++++++++++----------
>  hw/vfio/container.c           |  2 --
>  hw/vfio/helpers.c             | 10 +++++++++
>  hw/vfio/pci.c                 |  2 +-
>  util/error.c                  | 11 ++++++++++
>  8 files changed, 64 insertions(+), 17 deletions(-)
>=20

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


