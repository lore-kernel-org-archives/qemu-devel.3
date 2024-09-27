Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02126CEBF60
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 00:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stybl-0003T8-V1; Thu, 26 Sep 2024 20:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1stybi-0003SV-2i
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 20:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1stybf-0003BT-9q
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 20:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727395988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdi7RhD1JrItnWZHHRzu1UNEFoLbMH8UHSBrKjnS208=;
 b=XC8xib4nshxBDitL7nfKGtF/M8UomZ/Fnf42LdupjzNA0vdnelZgqza2H37d2r7u1ouI1T
 i5hf9UviwCauWnWvT0slexYV1FbYmLsIzTEzlw75zLYwra++8pAdYvgmd67fCxbsHAuZta
 BT5i8eITy6A/3KzcyoWJLC0vgeUfkkM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-H5t0qW_7MdimwQMGlJTU7A-1; Thu, 26 Sep 2024 20:13:06 -0400
X-MC-Unique: H5t0qW_7MdimwQMGlJTU7A-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2e08fca19b9so1528015a91.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 17:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727395985; x=1728000785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vdi7RhD1JrItnWZHHRzu1UNEFoLbMH8UHSBrKjnS208=;
 b=CEw9xIk4ZGOAtU5YJqLH7lvJYqW/SMqyYYDWRkV/DszLG8EGJM9vPiHHr0lWzJjMMl
 WV9mJgL5KwF7eoPtmnR+9WDTi7FUdSjczVjygo5yrCv2ZfLF9wD91F4yuRQZOZS4BVXY
 00aTs9Hy7BcyyomGD97xqTchf/3F+6BqGCIzJtMuBVuIttZ69gL+tWYmUScbTMYRnEPu
 yba5XZcZ1dT+NiRIw87oQ5hWpgTxW+OboeK8xwwLqIC//4fZsMB2QHqq0at/HsCG2mPb
 rJHMDKE3YRSiOQwFAWtRErxJzOMVHq31v5EW+Px8T1E21sO3knV2zqUXge9pBuSOXX69
 ztqQ==
X-Gm-Message-State: AOJu0Yw99f/0EV8s/FmpRFCJyT0I19Og3D4gV9HQCP/fqildi8QsPQ6V
 nEvniblD9MFyFdIQcJp+HvL2JSLSDBg7csO1qu2D/R4SVgmIKX2HlrdAcIAsGggXlASsl/yfXHU
 uwvgEA3mo3uIYLF0bjb/kNE0838pObD2tEdubz5POFEWTQwRxb3SYWj+chjMOB48Bl30dSHzSRe
 hNlKBqklacsfRv2/GQ8tBMTM3Wu74=
X-Received: by 2002:a17:90a:2f41:b0:2d8:8d62:a0c with SMTP id
 98e67ed59e1d1-2e0b89a68ccmr1615953a91.3.1727395985525; 
 Thu, 26 Sep 2024 17:13:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFFqXPFqMz18wyDSTzeaNhw5TC4b/mTwhxuAJFkMm1pgSmInqwD4ytacbN1+rpe0btQK42F/iJC30V791vrYs=
X-Received: by 2002:a17:90a:2f41:b0:2d8:8d62:a0c with SMTP id
 98e67ed59e1d1-2e0b89a68ccmr1615919a91.3.1727395985077; Thu, 26 Sep 2024
 17:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-2-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-2-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 08:12:51 +0800
Message-ID: <CACGkMEss57DGfLjJdPuLWy0ARV_oJf7Z=Qyh=Fm7wGQHnR1DTA@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] intel_iommu: Use the latest fault reasons
 defined by spec
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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
> From: Yu Zhang <yu.c.zhang@linux.intel.com>
>
> Spec revision 3.0 or above defines more detailed fault reasons for
> scalable mode. So introduce them into emulation code, see spec
> section 7.1.2 for details.
>
> Note spec revision has no relation with VERSION register, Guest
> kernel should not use that register to judge what features are
> supported. Instead cap/ecap bits should be checked.
>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cl=C3=A9ment Mathieu--Drif<clement.mathieu--drif@eviden.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


