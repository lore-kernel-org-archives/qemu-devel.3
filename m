Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B231AC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 06:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv9G8-00031B-9A; Thu, 20 Mar 2025 02:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tv9G0-0002u2-Q7
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tv9Fz-00071M-3O
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742451593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mM8yaujc2cZwhjsMt44zW8CoGRN6NhxAv7QCArAiq9U=;
 b=B4gYoy3neMSPR2JsB0/soPoiHYgOZGIjU9T4UV+9xjlvBubYR5m/XX+eD1AMzR0U9kClDw
 2PCDzLhB5xsxdwEmxBLWUZe6B1j3jdrzTbQxJXRzKGUSU+/o3c29Y5kD0vGe0N90dZCAj0
 HKk0RmXwAXg1IcToM/MROCA6FNpp3eI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-iY5kbFJdMjiiDDkKi3O-LQ-1; Thu, 20 Mar 2025 02:19:50 -0400
X-MC-Unique: iY5kbFJdMjiiDDkKi3O-LQ-1
X-Mimecast-MFC-AGG-ID: iY5kbFJdMjiiDDkKi3O-LQ_1742451589
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4394040fea1so1773065e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 23:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742451589; x=1743056389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mM8yaujc2cZwhjsMt44zW8CoGRN6NhxAv7QCArAiq9U=;
 b=bnOnTucW9ZhV51TNLACfg5/FhSAcuDwhVgjNodXd7DD2/sZ3Js8ExniGu44CnO7kqQ
 R2XBgKHF69/IUmAfEel3CXX9w+doRuikniK/bgai2K7vnpdKrhSATppdfwyLQgMNCjx1
 Zy89epxbsaJG85+FNxdVTdHxE/oZQXOYwNvcCYvJOGquglVLCfNxP/QPCZiuq3bpseTx
 Ng3NBHvDuCOIf9b2eQaugIzBxK0qH4/vhCDRi6cF1YwFVWhgQQpDCnA+QhAzcz1yuqYp
 nUnAO+B+ESz+mAJDqfIKqCKYSMSQXEgCvQn16uxY4c2ssHhbwtF2/jiFF7mdNIrKTv9J
 RrBA==
X-Gm-Message-State: AOJu0Yz7p49kYWMyw6EEQXv2gjmtiod4E3xYCi98KHxypLAoY53ixk25
 s9KhicTobWLRhogp/TUXZe+xfRP0E+xKwsSsYXh6u/Bz1KZQ8OyZJQ9tGcLWGjAGHNIcUkAx/kR
 eH253hPNIUVfTv2pk7MfLnvHf3XqT4tJGxzeEpiFzKU+prlwv+eysp4MbI1EY0CBW+EDJa8gAT1
 Poh/kA74BU0Ee7dlKfHr68G6J3IyA=
X-Gm-Gg: ASbGncuzDepXMcRBMg04xxNdNnDpzFpSgv+CrQ/dT83KesDhF0fqGGy31tliUnwntvt
 T9ELzDtujMDaKesrOLneL0sBBvProtcItLp5OQEWTScsRdYUh7GatYTUu4cFGJWHkxrxGK4bzFB
 4=
X-Received: by 2002:a05:600c:cc8:b0:43d:186d:a4bf with SMTP id
 5b1f17b1804b1-43d490d2411mr17546745e9.0.1742451589398; 
 Wed, 19 Mar 2025 23:19:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGorMNkLvFBph8t8UiAHmXgGfQ3WXDOWo5wpT2VBnickADQz0lNdseNkDXp3zcUjGnt92HW17AOtjRgi5Fd+kM=
X-Received: by 2002:a05:600c:cc8:b0:43d:186d:a4bf with SMTP id
 5b1f17b1804b1-43d490d2411mr17546565e9.0.1742451588958; Wed, 19 Mar 2025
 23:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-7-clg@redhat.com>
 <CAE8KmOyy7nLFQ+6Ogr6HT7qA-ThsE7dMm1-AN5L7iHN3WVnqAw@mail.gmail.com>
 <e928f9cf-785e-4fd6-af35-a8114b4b821e@redhat.com>
In-Reply-To: <e928f9cf-785e-4fd6-af35-a8114b4b821e@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 20 Mar 2025 11:49:32 +0530
X-Gm-Features: AQ5f1Jrz_5Vg5_ck9ZO1jAzLxYASjesJ4iks-OUiEMLMzdy2yckr8aetoZOgc70
Message-ID: <CAE8KmOxKCwv5m7NnC5-tTK6uzz0iqW5LWMbq87xhQ1Ro2d0=nA@mail.gmail.com>
Subject: Re: [PATCH for-10.1 06/32] vfio: Introduce a new header file for
 internal migration services
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>, 
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, 19 Mar 2025 at 22:57, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> you are right. I am not satisfied with the header file names.
>
> It has been problematic and I would prefer all header files to have
> a "vfio-" prefix. Sadly, the gcc command line is making it difficult,
> or I misunderstood some parts.
>
> When using :
>
>    #include "hw/vfio/foo.h"
>
> "hw/vfio/foo.h" could refer to either :
>
>    ./hw/vfio/foo.h
>
> or
>
>    ./include/hw/vfio/foo.h
>
> I find it confusing that we can include files from anywhere in
> the directory tree :/

* IIUC, gcc(1) picks the _first_ matching header (name) it finds
across listed (with -I) include directories. When the header name is
quoted ("foo.h"), the search begins from the directory where the
source file resides. In the above example, if the command line was: ..
-I ./hw/vfio/  -I ./include/hw/vfio/  then foo.h from './hw/vfio/'
gets used. If the command line was: -I ./include/hw/vfio/  -I
./hw/vfio/  then foo.h from './include/hw/vfio/' gets used.

> May be call it "vfio-migration-internal.h" ?
>
> or use always : #include "hw/vfio/migration.h" (and remove -I .) ?
>
> Or rename the "include/hw/vfio/vfio-migration.h" file introduced
> in patch 3 for external migration services to some other name.

* It helps to have a unique header (file) name across the project. I
don't see any vfio-migration.h in the current git master.

Thank you.
---
  - Prasad


