Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61C7CEBF69
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 03:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su1xu-0001su-3q; Thu, 26 Sep 2024 23:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su1xn-0001cQ-Qx
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 23:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su1xm-00044n-Ft
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 23:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727408893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MM82ZaPdPNddLYlZkcMD5iQEK6tWC6oNQk2ZDw2sZos=;
 b=QQt9Zk7GeONkHHmvOKFE1b8Qm0/IFEMORLpO9VdSnjqRsHY2/ZsIT3BpC6nymyIXVkpYab
 8n2VUWWwK8umyHiq8DjLjdLYWE+xMntpqQ2nBlOEhOs31h646skfFsIY09AQBJ/YrrlgnK
 kZAuM5chf5DDOw95wmBHT/ObPk5U0iU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-eSPZHKLINOefxUMSzi3clg-1; Thu, 26 Sep 2024 23:48:11 -0400
X-MC-Unique: eSPZHKLINOefxUMSzi3clg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2e08517d5afso1681908a91.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 20:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727408890; x=1728013690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MM82ZaPdPNddLYlZkcMD5iQEK6tWC6oNQk2ZDw2sZos=;
 b=uXjhddR730DAhitRJVCkEmDqM81b6dB8/fbVpwDCMIeNYNP6RHjtvJBLGKolg0EbZA
 ynygl5EAEt8qUiq0/TF8PuPnA72gSHqal8KBrtiO6EngJ3+KU3XGnBGG0SEmSTfEA8jh
 4eEQbvyf+sj65FeeGwtMFPfFlj5zUrIki2wNS7RQ13VeBX+PT6h6uCqnSUQ2Qzl/lVYb
 6ZZT2vvsROWn46dYsbwWJtQmHiHotdRKkc59z9gfkULmp63hsyTN2lrdGL4QHSBSGKN7
 hJb+6/4b3MxDH7sEtZuyay78qB6ol042NoBcsqCCuoqTzHVwRPOrm1y6RWlVF9+P4dVm
 JfdQ==
X-Gm-Message-State: AOJu0YzLFMsXiVu3zzypoufteQIPFjyHjWMWXmkM9YxtBxEDFeuo1UL6
 DMVkij9h5jErb0jvMwqsc8RC1W/sQp/hpK/wOtIJ5OQ0DvUEV/MEWxFA2soizTvm3yLvxM3hUIv
 54u8frw2L9AlYIJTyocMI+9ItZ7doPWuoP4jI2kV0SA6X1vOG/imhESOWcMhEdexpRdwrWdpQUI
 5EIVsNWBBmZQa2z65bvqnKH9HJTR/hpS4hYjTLiQ==
X-Received: by 2002:a17:90a:c391:b0:2e0:a9e8:bb95 with SMTP id
 98e67ed59e1d1-2e0a9e8cf94mr5002037a91.3.1727408890181; 
 Thu, 26 Sep 2024 20:48:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB5oUp+f6NEqqYu9t+FF6nxNN6rIJXpt7gZhgJKKdm+ATBI+ZU5myMaiZKE1wgVMSluM9r/82e93zgXbR6z1Q=
X-Received: by 2002:a17:90a:c391:b0:2e0:a9e8:bb95 with SMTP id
 98e67ed59e1d1-2e0a9e8cf94mr5002004a91.3.1727408889761; Thu, 26 Sep 2024
 20:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-6-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-6-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 11:47:58 +0800
Message-ID: <CACGkMEt=uc+XQFx3qu326PT14gniatB4AKGoS84SEUJ2Bt0aSA@mail.gmail.com>
Subject: Re: [PATCH v3 05/17] intel_iommu: Rename slpte to pte
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
> From: Yi Liu <yi.l.liu@intel.com>
>
> Because we will support both FST(a.k.a, FLT) and SST(a.k.a, SLT) translat=
ion,
> rename variable and functions from slpte to pte whenever possible.
>
> But some are SST only, they are renamed with sl_ prefix.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Co-developed-by: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden=
.com>
> Signed-off-by: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.c=
om>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


