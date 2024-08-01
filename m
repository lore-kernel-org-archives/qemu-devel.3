Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADABC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXYo-0006HS-KV; Thu, 01 Aug 2024 11:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZXYl-0005vb-57
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZXYi-0004mO-I7
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722525457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=saWSM0dvG6oMWmS/XHDtmdkUhGSwyi8ohATfugSLLzE=;
 b=VczkHmIAgzq91pVHv17zuNW5/LmqjjBV5Sf+ZV2iH7QL1IUpUw5caP75YFeEBJql3hPCbO
 YGdtwO11M4xGpBrHbJFZHIhvmpgwYc41NABiURDDbd6z8nkSb0d9b+1qKyczv2HfqwAeIN
 jmYZT00vd+ceRBXL8i6Pno6+CpwMPFo=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-8MIhzjGeMVWuNmQX_9jAmA-1; Thu, 01 Aug 2024 11:17:34 -0400
X-MC-Unique: 8MIhzjGeMVWuNmQX_9jAmA-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6886cd07673so12396917b3.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722525453; x=1723130253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=saWSM0dvG6oMWmS/XHDtmdkUhGSwyi8ohATfugSLLzE=;
 b=Abuy1ZrUHE4fIS8D9ETKKv8ZkHiOrgCHZhqOE0QD44tv/l7BR6itG0RpeBP7vxjlU1
 diiwlB/A9CfFiyKQw2kipVTT9b1FFfS6EGb3P1xb58j3pEEvJ0yC+aq2DhynnPnJ5OxA
 qjUHEboCm7HqcCtp3czuYkg5k8bRLvXMKIxQBfUXFSlh/XZx4x7xMgxLejIXo1yB6H2u
 9PDfQiviBs1T2PlkKbzSnWCYHielQOu8lKlQV+oRBlTCWiAT+N4Ynlu5oELFOygD10GR
 RW7Nhs3kznLrZs+vC5XL69IrEeUGrXriV4yk/087K/jfhe1mIgZqSefPoUcms4mc0GLs
 rcQw==
X-Gm-Message-State: AOJu0Yw5RtT8rD1gFs+czQVsQ8Ho1dkltdsjhAotQuzCq6uQkkWlPldp
 Svf5/PvkL+bOinTgDlEuze4x5HJisqJfteTZkt7wBO0ytllSQOHABJ9rRQGUj8/2U9NRm6ZdEty
 GC0AELsQEH9iVooZtYExGmAFn4MNZsJaArZDruvJ6ZSDCFmfq8kpsLwh1NaVDsOnYR3WzsPBtKt
 iBpzj53+I747qDpJMK3LvF1i0n3KM=
X-Received: by 2002:a81:8a02:0:b0:627:88fc:61c5 with SMTP id
 00721157ae682-689608712bemr3552207b3.14.1722525453628; 
 Thu, 01 Aug 2024 08:17:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWb+pXe3srA1h/GWNLFlIOcL3RzIFjT+pBFwxzuvCICQfwHyygo1bFQwtpDjywD7rhu5d6eWz1qCxx5yiYRSM=
X-Received: by 2002:a81:8a02:0:b0:627:88fc:61c5 with SMTP id
 00721157ae682-689608712bemr3551957b3.14.1722525453261; Thu, 01 Aug 2024
 08:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-7-crosa@redhat.com>
 <20efca0c-982c-4962-8e0c-ea4959557a5e@linaro.org>
 <CA+bd_6K5S9yrD6hsBsTmW4+eJpPsquE8Ud9eHZzptUwDrHcpeQ@mail.gmail.com>
 <a3b0ebf6-47ca-4aad-9489-16458ffd6ff3@linaro.org>
In-Reply-To: <a3b0ebf6-47ca-4aad-9489-16458ffd6ff3@linaro.org>
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 1 Aug 2024 11:17:21 -0400
Message-ID: <CA+bd_6LmuOdQ8ZdLjwt+MCusjQ8ROv23d9PXoF-Ku3j4j73wsg@mail.gmail.com>
Subject: Re: [PATCH 06/10] tests/avocado/kvm_xen_guest.py: cope with asset RW
 requirements
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, kvm@vger.kernel.org, 
 qemu-arm@nongnu.org, Beraldo Leal <bleal@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 1, 2024 at 8:57=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
> > I agree those files should not be modified, but I wonder if you
> > thought about any solution to this? Given that the same user writes
> > (downloads) those files, do you think setting file permissions between
> > the download and the use of the files should be done?
>
> We want to share a cachedir on development hosts with multiple
> developers. OK to alter a downloaded file before adding it to
> the cache; but then once a file is added/hashed it shouldn't be
> modified IMO.
>

I was asking more in terms of what to do before/after the test.  When
it comes to this type of setup, Avocado's cache was designed to
support this use case.  You can provide multiple cache dirs in the
configuration, and some (the first ones, ideally) can be RO (life NFS
mounts).

But this is hardly something that can be configured without proper
user input, so this is not present in the generic "make
check-avocado".

> So far this directory is group=3DRW but we like the ability to track
> a read-only directory (like owned by a particular user) and adding
> missing assets to current user cachedir, to avoid duplication of
> files and waste of network transfer.
>

That can be done in avocado.conf, something like:

[datadir.paths]
cache_dirs =3D ['/path/that/is/ro/because/owned/by/someone/else',
'/home/cleber/avocado/data/cache']

The asset library will take care of trying to find assets in the RO
directories, while writing to the RW ones.

Hope this helps,
- Cleber.


