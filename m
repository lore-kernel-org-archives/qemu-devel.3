Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102FDCEBF60
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 00:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stydp-0001E0-9n; Thu, 26 Sep 2024 20:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1stydn-00018q-VX
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 20:15:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1stydm-0003hG-Ad
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 20:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727396121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ud5A4VAgVF8b5EEsyioFITmSEJz2VSzDpIimyJT1wnA=;
 b=Uc0EsREt7mJ3zpvni5/h5Pv8hs+4OoInIFQq4574GT4LWnKglHO/7NlNQAn+kJW70VK5bX
 cu9qgkyrS9fuiMFLZz64SDX9UT/NyOCcHV7nP9eJEaTA9m8HKAZeaUzYJ+YJ173Fmil6ek
 H7i0LUuoT1qe5fs/AYGYmGRxj0gs/dk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-uDLw5mDEPVqGQpJOUTbcgw-1; Thu, 26 Sep 2024 20:15:19 -0400
X-MC-Unique: uDLw5mDEPVqGQpJOUTbcgw-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-204e310e050so16683465ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 17:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727396118; x=1728000918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ud5A4VAgVF8b5EEsyioFITmSEJz2VSzDpIimyJT1wnA=;
 b=dxUON0xEPb6Dsq1CABvt6dUDqpAXyBDzqPJGKlISvWIL3FBBGwiuytaq5CIgxJ8ici
 boYOJpKGJcTAf7FoDBgwgaDQG/smRjYHe145hVrGfsoyuXuqZepyUpImj+zWBq926idW
 ++TROnZ1vX0XCZ1bw3H7BeVy2pG3MRx+Fsy3HLnZ7Jb3ngg3fxTnoz6UdQgylNCIko2B
 MciTAj+OwgFUW9OEWPnZBP9Fm3n3inzyTnkmRHg9y8h77ycnTLNxfSMftp0kM3q7sSEv
 pDAw+1BVYcEZ8QjPIjrSZ05VcIMNk8ISk6mDyerAVJjvlo5bpc2RqZUo4dKGSvADCKfj
 r3qw==
X-Gm-Message-State: AOJu0Yxlit4lEK8quksJU0jJ4wic9V5al+s2/aTvr1raSf3y4LsCi1Xr
 /3JiAinX8UwIX/NXgBikXmVnk50z6LcpUwMyc9zt3LqxCuv83KlcrdVybaxquBnLU0p6/FxKv0P
 Of57JoutxzV3sXX9eyEY7ugIy4AN+nnNX9Ot4MYMEZ251+bwqQkuagZC7iuJ6+qRE5xu3svqCp6
 mInM1e8iN+p74TEk4I5J2yC5QSH/I=
X-Received: by 2002:a17:902:c40a:b0:202:1bb6:1897 with SMTP id
 d9443c01a7336-20b367e4b7emr24012955ad.14.1727396117998; 
 Thu, 26 Sep 2024 17:15:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo0AkeQJOjLuqDHn7Byxm01Vb1VfXUR654KsN2cHykUMUjMpWR5QGdQL78FpesGWVeMIuVaupQVevWVEVK3V0=
X-Received: by 2002:a17:902:c40a:b0:202:1bb6:1897 with SMTP id
 d9443c01a7336-20b367e4b7emr24012455ad.14.1727396117594; Thu, 26 Sep 2024
 17:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-4-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-4-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 08:15:04 +0800
Message-ID: <CACGkMEsz6hN5jENhfZeixfv-Fjp0cKsnSXrKxfokzo8g6esAsA@mail.gmail.com>
Subject: Re: [PATCH v3 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
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
> Add an new element scalable_mode in IntelIOMMUState to mark scalable
> modern mode, this element will be exposed as an intel_iommu property
> finally.
>
> For now, it's only a placehholder and used for address width
> compatibility check and block host device passthrough until nesting
> is supported.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


