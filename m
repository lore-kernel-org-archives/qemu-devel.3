Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C77CEBF76
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 04:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su2HI-0003HE-63; Fri, 27 Sep 2024 00:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2HH-0003E6-9F
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2HF-0006GG-V0
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727410100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OTnve1IY/xn72fTWJAMzWxStRePV28Y6ecYTjxfYJng=;
 b=f6s3o+1RUaHr3ZViu0q3QZ/xw3LEr48S1nx429rPNvq+/FeBlrCxghfH+Yz1ZmvXiEW0jW
 GKF7oD/aod8RtyIYCWDUUUowSZC4mCEkut49zBvRRY374d/eRoFKkIWjkPFA1uutVT2OM+
 NkwEZQsYp3YR3cCBeT5A7foWqMm+x68=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-tPuHmQxKNJy5msdCUei9bA-1; Fri, 27 Sep 2024 00:08:15 -0400
X-MC-Unique: tPuHmQxKNJy5msdCUei9bA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2e08a2b07bcso1719356a91.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 21:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727410094; x=1728014894;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OTnve1IY/xn72fTWJAMzWxStRePV28Y6ecYTjxfYJng=;
 b=Y51awHgcq2Jhr5s07N2oLqJn4qQV3r+JQgK0MD6eavbAPsUa0HRM6TjgkpFYEFp2Kl
 G1NqEZUul6Sxx4PJi1BTtjT0lJDGSgAaEtybAAjLBaUUvMn5hekk5Rv7Q1eYIm/k7SGd
 om6rvV5dRfCThkOc1Y1IhNvS84KqIB45r3t5kPEnMQHrZOzoywsklwJ3eOdBRkoM1TyX
 ZucqW4B+pLuwlbbiYHYx9LGDJ3KWoj6r1ZXrsJe2+uXbZdz/lryKN/889icP0wD4UN0t
 wAjYS/hx1bZqS7gVPsKDX+As5+D1gfJ7/9RWYya7ib+MeC02tj5cvwuYhz7wJJ94zTpT
 odyg==
X-Gm-Message-State: AOJu0YyKV/r1Fe78xDqCywM8qsNHVL3VUPs8w/XiCtLnRUYJiCClwwwz
 0sEzeBuCtetS918e8IczzV/NFTm12wT3u9p5frZMzTcNakQM6VTQRd0kA0SrPdn13/8jNePPRNF
 aHVEisTsw2gsPvNEh5BYRKK0LA1tBoAxWPtuAk3xwQtfvtc6YFlTl+dw0uHvvloYKBjrCesvkEg
 sYS9zJbsuzS8L2/u4b4wb76ffEuXk=
X-Received: by 2002:a17:90b:3546:b0:2da:5edd:c165 with SMTP id
 98e67ed59e1d1-2e0b8ea136dmr2306264a91.30.1727410094526; 
 Thu, 26 Sep 2024 21:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYm+WBFGbQAUVPMQ6yA/ki8tiQQxuizZmzk1CaawuCTquaeLGoSYgLlsN0BXpoHHpOit4YaREZlxrhp3Zk3YM=
X-Received: by 2002:a17:90b:3546:b0:2da:5edd:c165 with SMTP id
 98e67ed59e1d1-2e0b8ea136dmr2306236a91.30.1727410094054; Thu, 26 Sep 2024
 21:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-11-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-11-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 12:08:01 +0800
Message-ID: <CACGkMEuJix+AXU7Fmwaw9yfwr6P1+1s2gsp1GmKieLLQkbgKzQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/17] intel_iommu: Process PASID-based iotlb
 invalidation
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
> PASID-based iotlb (piotlb) is used during walking Intel
> VT-d stage-1 page table.
>
> This emulates the stage-1 page table iotlb invalidation requested
> by a PASID-based IOTLB Invalidate Descriptor (P_IOTLB).
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cl=C3=A9ment Mathieu--Drif<clement.mathieu--drif@eviden.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


