Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ACBC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 00:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8r8O-0004PB-SK; Sun, 19 May 2024 20:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s8r8N-0004Ox-Sz
 for qemu-devel@nongnu.org; Sun, 19 May 2024 20:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s8r8M-00041t-Ao
 for qemu-devel@nongnu.org; Sun, 19 May 2024 20:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716165847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybYRfWZi4IvVoo/hMqXGrx+tcnnZzqO4RQd7mCyyFbk=;
 b=VsUlNrzCm2CkYwJviCAt/8rle2trdWbsNGbxso4IFomHOQBWw/0dd0TM7rXIzTDkWgKfcV
 snJ+FOYsKe8vhU01yhPvDuAsTZrBNmixlUZAABHklZ557mjE2NPdmCNmyMFk8fpPKJT53v
 Xm7eM/3tModWSKpx1Cw5zyNDMVKcr70=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-qByscSswPl62nhRn1eGszQ-1; Sun, 19 May 2024 20:44:05 -0400
X-MC-Unique: qByscSswPl62nhRn1eGszQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ba1dd99b05so3619527a91.3
 for <qemu-devel@nongnu.org>; Sun, 19 May 2024 17:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716165844; x=1716770644;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ybYRfWZi4IvVoo/hMqXGrx+tcnnZzqO4RQd7mCyyFbk=;
 b=aJ6k7OsbEvtB1fUYLsZytSVwR208TtBNI2/13rtgmtr+JkXolvSXmx6ZBcmxRvliBh
 s622OSb9TeaHlReukuwQaLywx2wVcRwOxoAU2uTn/cGKjlDZVgXCqLn187oZzZyZ59vw
 7xSwyzAHHT79UD8BuZ5xWoJCKFYNpmq38F87yzuCRj7WLRIZPfCxLrYzEvIMZfUGTH00
 i9Qw8naWzI3hMOzX57s3haw9JSJ4HodOQ0IqCylswIQG5zE+cmhNOe3awAKg8SRG9WV0
 OSE1mU0A++ARkfqRL0tqRlSQU3inE6WdHEEWoMbl5q74AMzpWihhbUOomDO1v4bKdBRk
 yTXA==
X-Gm-Message-State: AOJu0Yx7T0UFtrvZa2FaCEcySbcjekPgYHybCkCQYYLqf4JKv/KeY0+K
 4BKA4p4s0uZbXYz75p4dIqed+UHxEohzz95b5cr1OTqyKjCZ5vZBGU81p/bmH3bnDEhfvoMilgz
 DWvOyO46ipvSpfMA3BxtyxlMTM/4Dmar6iX2TQCwrE0GvW4n4zVcIho25szsEdqjrpijaBih1D3
 XpC04iAnzEkF29o6btRsm5IroUXUA=
X-Received: by 2002:a17:90b:100d:b0:2b6:2ef4:e2aa with SMTP id
 98e67ed59e1d1-2b6cc780466mr21638719a91.25.1716165843976; 
 Sun, 19 May 2024 17:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkMHNaA4qxDba1q+xZoXL7A1gYtYvqtqVkJ8Cq4w5bVhnrz8jJDpmBlZBzCTeIF67zP8BsciqTJ/IK56cGN1k=
X-Received: by 2002:a17:90b:100d:b0:2b6:2ef4:e2aa with SMTP id
 98e67ed59e1d1-2b6cc780466mr21638707a91.25.1716165843645; Sun, 19 May 2024
 17:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
In-Reply-To: <20240517102334.81943-1-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 May 2024 08:43:52 +0800
Message-ID: <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, yi.l.liu@intel.com, chao.p.peng@intel.com, 
 Yu Zhang <yu.c.zhang@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.383,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, May 17, 2024 at 6:26=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> From: Yu Zhang <yu.c.zhang@linux.intel.com>
>
> Currently we use only VTD_FR_PASID_TABLE_INV as fault reason.
> Update with more detailed fault reasons listed in VT-d spec 7.2.3.
>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---

I wonder if this could be noticed by the guest or not. If yes should
we consider starting to add thing like version to vtd emulation code?

Thanks


