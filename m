Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52505CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 04:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9FvS-0001IQ-OU; Thu, 16 Oct 2025 00:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1v9FvR-0001II-AI
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 00:49:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1v9FvO-00078T-NR
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 00:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760590152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JY0yVXYrvciF+94k7t7DMHGAFpvJedOryxL5V2L76iM=;
 b=XT/0v72YDWfCMAOOpQPcEzfUczy1RzjPiKiAMc4Ms//YWg8rrOGEKRobd0s/wTbCwXH8vX
 Bz5v+dmqLAVrV5eLlSBHomY4JDglTusmhKXIYuHHxkM6JxztrbIkCH6/+EVf1sWiHUnqGw
 ZO42CnqrqbiZAl2NxBiIOLuWrtnobVg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-w2BdRlIIN8yPV7B3-8ttuA-1; Thu, 16 Oct 2025 00:48:02 -0400
X-MC-Unique: w2BdRlIIN8yPV7B3-8ttuA-1
X-Mimecast-MFC-AGG-ID: w2BdRlIIN8yPV7B3-8ttuA_1760590082
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-286a252bfbfso9256615ad.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 21:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760590082; x=1761194882;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JY0yVXYrvciF+94k7t7DMHGAFpvJedOryxL5V2L76iM=;
 b=Ct5LBmcl1m5ilFaiVppL3+TeRmLAMw8i9esedjMR4ak9Nnt4Zx0z9MrOhRfgB5PUGo
 6qsSrvKnX5RX/wKIBFvDJK5IGRcNdVZfoCfJUVA7k3hDTutXtWsvdFosqYQt5knHDj8l
 kxmiEz/0vuVrdHgbKzp3r1IJsqLaAewat0P0O9fUIz7ufbbXHqHD54tY2Bstg0xx3XUc
 EkJtTpAiIuajPkAvShKgTbMlM6RfV6CGTn3kPsQytw5e21J8KweEx98BuFoIt1spdX7J
 CTn8B379dWOnKmNlMGV6mswsZqxZFynj+BI2usOpcXcsxEqfVVIzhlXGCq4w582TsLn9
 GK1g==
X-Gm-Message-State: AOJu0YwFAfWSjZVscaLEkwuJ7GX8QTI8ZFGqoMUGZt2yDJBlcQghRu4k
 MgJzT9BiunZVxBshHySi4pug1Wst7tZzCRimpIXtMfbqr4POPuUIb56KDftwGNRjGlccTedPGIG
 bVC8V+gkuhs6BMsCuxNQEgpnNmqZ/is5DPbu5g+YKwFISqXxXdjAwZH3Y
X-Gm-Gg: ASbGncsbN0n36tCLlVQaXVCRstIfrvVGumMNFTyGDlEDwr8zWWvyxx2VGOdkIa8kZEw
 hjSvztqMtnwdIy5ok0K/ATAXWv0uCsHfKIq6ow4EX+/+bxahzlUd8031+MCOl9HMsVeHOOyaxyX
 rb9Kq+wwJ/vNin5uY3Rvviddltn1DrNPMSqZ1P+4km3WOK1PVlunssTxqCTotlbPaN0nI7pS9d7
 wniiM+DlzZjht6AFD15Mm7Y90aQMZf/2mTj+5GcL+DP4ZuwrLa1bHORubcxr+BCmLHOujOHzymJ
 8eLKe79iqYuaXFIPDhlJhzovZsluSD1Wqk3s1WKU28YHvf6tljbzBUv5H6x9lwzDmaH62BaSz8o
 x9FB9zcrveMKCbHo=
X-Received: by 2002:a17:903:286:b0:24c:c8e7:60b5 with SMTP id
 d9443c01a7336-2902723ebf6mr445029465ad.16.1760590081716; 
 Wed, 15 Oct 2025 21:48:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6+W5rYwkc2qehEnUGSUPd/it+rHvJF2JeB6QNZahxUe5ZSL/r7mUUoSmf82AezK8D4dYBoQ==
X-Received: by 2002:a17:903:286:b0:24c:c8e7:60b5 with SMTP id
 d9443c01a7336-2902723ebf6mr445029315ad.16.1760590081281; 
 Wed, 15 Oct 2025 21:48:01 -0700 (PDT)
Received: from smtpclient.apple ([122.162.208.81])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099b0249asm13982445ad.109.2025.10.15.21.47.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 21:48:00 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.4\))
Subject: Re: [PATCH v3 1/5] igvm: move igvm.h file to include/system
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20251015112342.1672955-2-kraxel@redhat.com>
Date: Thu, 16 Oct 2025 10:17:46 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <87AF8465-03C8-4C1F-A6DA-05B94C8F1F3F@redhat.com>
References: <20251015112342.1672955-1-kraxel@redhat.com>
 <20251015112342.1672955-2-kraxel@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



> On 15 Oct 2025, at 4:53=E2=80=AFPM, Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>=20
> Prepare for arch-specific igvm code being added to the code base.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> {backends =3D> include/system}/igvm.h | 0
> backends/igvm-cfg.c                 | 2 +-
> backends/igvm.c                     | 2 +-
> 3 files changed, 2 insertions(+), 2 deletions(-)
> rename {backends =3D> include/system}/igvm.h (100%)
>=20
> diff --git a/backends/igvm.h b/include/system/igvm.h
> similarity index 100%
> rename from backends/igvm.h
> rename to include/system/igvm.h
> diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
> index 45df63e06c1a..d00acf351249 100644
> --- a/backends/igvm-cfg.c
> +++ b/backends/igvm-cfg.c
> @@ -12,7 +12,7 @@
> #include "qemu/osdep.h"
>=20
> #include "system/igvm-cfg.h"
> -#include "igvm.h"
> +#include "system/igvm.h"
> #include "qom/object_interfaces.h"
>=20
> static char *get_igvm(Object *obj, Error **errp)
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 9ad41582ee5e..723d45b755a0 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -11,8 +11,8 @@
>=20
> #include "qemu/osdep.h"
>=20
> -#include "igvm.h"
> #include "qapi/error.h"
> +#include "system/igvm.h"
> #include "system/memory.h"
> #include "system/address-spaces.h"
> #include "hw/core/cpu.h"
> --=20
> 2.51.0
>=20


