Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38474CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2sQ-0002MO-On; Mon, 01 Sep 2025 07:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut2sO-0002M9-SI
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut2sH-0000IW-GA
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756726738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=br6lFDDd3KDdFbXr4OlauHeyFgJdw44+ZL7FT2x+Jbk=;
 b=dUCzAGH80oHYzqERkPu2VUbln3KvAPk6CNuDabq0aOef5twpv6tZz7qlAtz2zBjtd/zZkb
 edgF5/epVUHvbCDB+k/kT6V0RaGxAN2KQe4rc/G7cbpWfkQLhUHepHCRDiE2dDEtm0a1KD
 Zi2eQhd8wALOHUxP1ZxFe/Q7rQkNaQ8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-wHr_IArRP6qs338mhtbmBA-1; Mon, 01 Sep 2025 07:38:56 -0400
X-MC-Unique: wHr_IArRP6qs338mhtbmBA-1
X-Mimecast-MFC-AGG-ID: wHr_IArRP6qs338mhtbmBA_1756726736
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7fea03c6847so160303885a.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756726736; x=1757331536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=br6lFDDd3KDdFbXr4OlauHeyFgJdw44+ZL7FT2x+Jbk=;
 b=e6+8OeKjCE7gB64R+jyiwFYCa1gc0g32fiWu41XQAe/qGwESlofVBjbzS9R3b3FZsg
 8r5KQsYKdn2ZJ2tW9Hp3nx6f/WtuKgjuGBJ8xahIITbFplc2Q4cuTYLQ4MGyWe11082i
 I7+8/exaf4KiK0XZZQsWJsWyzkgS3bZm8cGK7Uf6dVs3fbZSRa6IEcw6VjnN3u1+GH/s
 bMbosI7rKB9ZHG/vC+GEFIuz9zAtU1O0FAUei4KdlKCkupmgGxq83ERhcY+oXBcV2U+t
 Misko9Q3FG/bg9Icb+ngGpu+JwEzqOYBCRxIrqRqCqey8NoK/aCcKIDTXc6mMO1nzo6J
 7LeA==
X-Gm-Message-State: AOJu0YywL6wK/hHfUiUUM8RDlY0Kt27BvYk01vBQLCPGsBU4rlTOurjY
 D6w1FVYYxa2j0Jh8t3p5oA18FNoGYD4CrxNUNTNJASYwgYE2U3PwG4nDEth02rYjJ4N2sk92aLE
 yLFV/DKBfchGYs/S75WgD3obBQ5xdTsVk/V2rZIclRyvTgro9ScSC9JlW
X-Gm-Gg: ASbGnctKe/bwDXsie32CVLsYXTv9dbjMiBqhAt2q/UodLDMwgpNorO1Iva2OfIYEf4n
 fNc/uaOyTuqPFHclO4bzGjW/pmSTzNmXf2lLzPFLoZ/eOBFPtm2n/KUiKp0aw2ryKKydUol0dPG
 j1h54wwsocElK2ZQJvUDiFg1w5p1zKQxaKMuA7flp7XFys8fdNexe0nNbD0rEW06wxpPU2mZvCw
 wJiOilHm1gkv92qd77Ml8u3d5AnfXFI1r/6xU/D2FcrPloYvVz8MMBAla2MnSPHf39WpyjhCiC/
 LQZqgxFz47b2b4l1rmBtZ49LpSw98w==
X-Received: by 2002:a05:620a:414b:b0:7d4:5db0:5b95 with SMTP id
 af79cd13be357-7ff2b69c9a8mr877999485a.58.1756726736181; 
 Mon, 01 Sep 2025 04:38:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhPV0hm7N+tC9sdX5/5NbkgKw8Qein10NAXECOuDh+x3l6DAuz6c0UxgMSuqJLC6zDOQv0Vw==
X-Received: by 2002:a05:620a:414b:b0:7d4:5db0:5b95 with SMTP id
 af79cd13be357-7ff2b69c9a8mr877996785a.58.1756726735688; 
 Mon, 01 Sep 2025 04:38:55 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7fc16340db0sm649481085a.67.2025.09.01.04.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:38:55 -0700 (PDT)
Date: Mon, 1 Sep 2025 13:38:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 pbonzini@redhat.com, qemu-arm@nongnu.org
Subject: Re: [PATCH] smbios: cap DIMM size to 2Tb as workaround for broken
 Windows
Message-ID: <20250901133851.2e407990@fedora>
In-Reply-To: <aLVijyqK4pPocGH8@redhat.com>
References: <20250901084915.2607632-1-imammedo@redhat.com>
 <aLVijyqK4pPocGH8@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 1 Sep 2025 10:08:31 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, Sep 01, 2025 at 10:49:15AM +0200, Igor Mammedov wrote:
> > With current limit set to match max spec size (2PTb),
> > Windows fails to parse type 17 records when DIMM size reaches 4Tb+.
> > Failure happens in GetPhysicallyInstalledSystemMemory() function,
> > and fails "Check SMBIOS System Memory Tables" SVVP test.
> > Though not fatal, it might cause issues for userspace apps,
> > something like [1].
> >=20
> > Lets cap default DIMM size to 2Tb for now, until MS fixes it.
> >=20
> > 1) https://issues.redhat.com/browse/RHEL-81999?focusedId=3D27731200&pag=
e=3Dcom.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel#commen=
t-27731200 =20
>=20
> Why link to a comment that refers to a link to Adobe photoshop
> and doesn't mention KVM ???

It's just to demo that GetPhysicallyInstalledSystemMemory(),
can cause issues (I doubt very much it's our case, since it's
unlikely that there are physical DIMMs of 4Tb+ size in wild).
Lets drop it.

I'd expect issues in various inventory sw and honestly I'd kick
this very niche problem MS direction.
I resisted long enough till the things got moving towards
resolution on MS side, but folks insist on workaround in QEMU.
If w10 isn't going to get fix, then QEMU is the only option
to work around the bug.

PS:
forgot another workaround (QEMU): configure initial RAM to be less
than 4Tb and all additional RAM add as DIMMs on QEMU CLI.
(however it's the job to be done by mgmt which could know
Windows version and total amount of RAM)

PS2:
I'm fine with dropping the idea of patching QEMU defaults
for yet another way to work around the issue.

> Also should have:
>=20
> Fixes: 62f182c97b31445012d37181005a83ff8453edaa
>=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > PS: It's obvious 32 int overflow math somewhere in Windows,
> >     MS admitted that it's Windows bug and in a process of fixing it.
> >     However it's unclear if W10 and earlier would get the fix.
> >     So however I dislike changing defaults, we heed to work around
> >     the issue (it looks like QEMU regression while not being it).
> >     Hopefully 2Tb/DIMM split will last longer until VM memory size
> >     will become large enough to cause to many type 17 records issue
> >     again.
> > PS2:
> >     Alternatively, instead of messing with defaults, I can create
> >     a dedicated knob to ask for desired DIMM size cap explicitly
> >     on CLI. That will let users to enable workaround when they
> >     hit this corner case. Downside is that knob has to be propagated
> >     up all mgmt stack, which might be not desirable. =20
>=20
>=20
> How many type 17 records can we get before hitting the the
> Linux limits which was the motiviation for the previous
> fix 62f182c97b31445012d37181005a83ff8453edaa ?
>=20
> ie, with this 2 TB dimm size, what is our effective maximum
> RAM size ?

it would be around 2PTb (assuming 1000 records,
exact number varies due to configuration since the rest of SMBIOS
tables take some part of that 64K buffer).

>=20
>=20
> With regards,
> Daniel


