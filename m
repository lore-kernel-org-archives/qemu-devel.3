Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5740606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=suY15K4U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM2Cq-0002Je-3Q; Wed, 28 Oct 2026 07:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xM2Co-0002JM-GM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:52:34 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xM2Cm-0005jh-PZ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:52:34 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c43373ae89aso118483966b.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 04:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793188351; x=1793793151; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nlno+0xoBVa2H/L5ewCXKT4Zehxi7AG5kPnBfCK8a6o=;
 b=suY15K4UJP0AzW3oKI/Gca1sqMOaUSWUGQ4nrpJFfsvHwUdsFv6NdJwt8JJ8jUN+c2
 0WKPGJtpCqxyJNOCgtC8j9ioBysXz9Mo7RUeVcAlCxbSGV+8wYg9FaWVOf01aiccAT6D
 a/d2/w2Tf4MCx1CYuu/uuHaznvHGlwfdl4YN0P1pdvaPQMcxqzIALg5B9i10KE5SAVmq
 iMNRv+tIHGzrrUtV7orUuJfF92USz3lYUwT1j8GHhyi4p0VwQvHcGyKc8dTSmKKSo2E1
 rKW++EqKFIGuiakDk6SffMpI+v5Vme2Si6/Y1GpG5eWB+LI52GIvlXHmAgyECsUq6U4W
 ibYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793188351; x=1793793151;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nlno+0xoBVa2H/L5ewCXKT4Zehxi7AG5kPnBfCK8a6o=;
 b=VMDjnHcd3MgSddbHK61KPOX7U7vj1xnVWN4sCrxlKOYOO32OORc6k8c/wGROjC9pS8
 lV/OyXkB6bwm7ItC5GRXnu37cS+hWqJXD1/nkPZem/4xG2PofQjAw9atPh2miU7LMmAF
 qmZgBj27Rbjds6ijXy8NOuIH505RuaojxwJgQDfDmfuqwjb5S5QpZ6hBB4GxKYw5MsEJ
 bVUC2zA2goNZG5WWDwcoYEAYrvYu6/cYF2ALWjagJ7+mR3EwGJuiTOli6f+o8dWNGljn
 9S0riyYjCGVH4Z/D383NRh1d+BOOzKh62TAbhvaTQS/hGcosyvGQ6fJhyu+X3kpAkkjU
 vyXg==
X-Gm-Message-State: AFq9FYKFujy5aK9A6xaHi+uTHX2g9hII5fJhbgkmwqD8vzp2W9UJ/POQ
 KrrncVhRQBNJpkN8PSVFuNWrUVshYCgLNCPu5kjjLG51UvgHO+XObku4
X-Gm-Gg: AYBFou1xDt96F/DS0MApbejVr4MjZuEMyIXghx32dFTB2y3Wto/RCw9rASUVbmAHZas
 R42UyjIYsgczZwvvwwYv9LTbikntR7+W4SDl1leSwFWklsDG9W0AtftSvjrP8gbfQQJUCKBtAQs
 hMcGsILk85T9QLeVx3PXyoZpxHS2mS/aG1n0EuvUL58nFLaxyQdyYdCuSfjeihT1YnjGJgp5lFq
 VRDtOvnlXr4FDJz3RZm/AF1e8/S5iBdBmDipr28+A8xA7SiyyLhFmdvK7Cv+V/xzeGVmqMSLdhk
 YF4d9bGq4ekr+5sLH6ibxlC6PhLKZMCozCNtOuX7p2fmudWZ9RLYxxFOgvAqgvr9WOJpsPZc8gm
 IcdA6quAXTKEP5dwJpYkx3d+rKwSSe0Kuaomf4S9Tut3/wMc22vB7VCpi11NqF9cYlbMh/cMRtW
 s3Clv2QmZTn31T8+mVrRcTyP8/ptLJzk8HZIB9u3EBFbIErGDVH6n6doOgN/AZfeWvCSn91pzcA
 0ekG1ZHo4TQrpv6IFNkylIDqU8MWYoZxjQoYL+yJZstvtPCCHn+XMaefzQNLRlaxjls/gJzwxZk
 zwTDeEP1yJB27r7zo+5yn6zWjPiPAhDug0rVnY9uRHE9Y5uJ0xJV5sAYEzKXN6IP6fQu2Hgs7Jc
 G5/T9yrexmI3pkvvGzXVGVuyM3+U=
X-Received: by 2002:a17:907:868c:b0:c49:b85d:f035 with SMTP id
 a640c23a62f3a-c49bdf9533dmr173458466b.32.1793188350635; 
 Wed, 28 Oct 2026 04:52:30 -0700 (PDT)
Received: from tulp
 (2001-1c02-1a15-3000-25f6-628e-6064-de9b.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:25f6:628e:6064:de9b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4e995dsm587571766b.25.2026.10.28.04.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 04:52:30 -0700 (PDT)
Date: Wed, 28 Oct 2026 12:51:41 +0100
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 michael.roth@amd.com
Subject: Re: [PATCH 1/2] qga: fix build on illumos
Message-ID: <auHhzRcOxIEZeMn6@tulp>
References: <20261015173250.65942-1-bogorodskiy@gmail.com>
 <20261015173250.65942-2-bogorodskiy@gmail.com>
 <CAPMcbCos82eavn8oci6O+T+Qbw6Vt8UWPezwA0Fc9KDN1CLX0w@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPMcbCos82eavn8oci6O+T+Qbw6Vt8UWPezwA0Fc9KDN1CLX0w@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Kostiantyn Kostiuk wrote:

> On Thu, Oct 15, 2026 at 8:33 PM Roman Bogorodskiy <bogorodskiy@gmail.com>
> wrote:
> 
> > Currently, build fails on illumos with:
> >
> > ../qga/commands-posix.c: In function 'qmp_guest_get_load':
> > ../qga/commands-posix.c:1408:9: error: implicit declaration of function
> > 'getloadavg' [-Wimplicit-function-declaration]
> >  1408 |     if (getloadavg(loadavg, G_N_ELEMENTS(loadavg)) < 0) {
> >       |         ^~~~~~~~~~
> > ../qga/commands-posix.c:1408:9: warning: nested extern declaration of
> > 'getloadavg' [-Wnested-externs]
> >
> > This happens because including <sys/loadavg.h> which is needed
> > for getloadavg() on illumos is nested under the "#ifdef HAVE_GETIFADDRS"
> > block, and is not included when HAVE_GETIFADDRS is not defined.
> >
> > As getloadavg() does not depend on HAVE_GETIFADDRS, include
> > <sys/loadavg.h> outside of the "#ifdef HAVE_GETIFADDRS".
> >
> > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> > ---
> >  qga/commands-posix.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index 837e285b6d..f58169b43e 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -16,6 +16,9 @@
> >  #include <sys/utsname.h>
> >  #include <sys/wait.h>
> >  #include <dirent.h>
> > +#if defined(CONFIG_SOLARIS) && defined(CONFIG_GETLOADAVG)
> > +#include <sys/loadavg.h>
> > +#endif
> >  #include "qga-qapi-commands.h"
> >  #include "qapi/error.h"
> >  #include "qemu/host-utils.h"
> > @@ -43,9 +46,6 @@
> >  #include <net/ethernet.h>
> >  #endif
> >  #ifdef CONFIG_SOLARIS
> > -#ifdef CONFIG_GETLOADAVG
> > -#include <sys/loadavg.h>
> > -#endif
> >
> 
> What is the difference?
> 
> Before commit we check CONFIG_GETLOADAVG inside CONFIG_SOLARIS, so
> this is definitly the same that you change CONFIG_GETLOADAVG
> && CONFIG_SOLARIS

The whole include block looks like that:

#ifdef HAVE_GETIFADDRS
#include <arpa/inet.h>
#include <sys/socket.h>
#include <net/if.h>
#if defined(__NetBSD__) || defined(__OpenBSD__) || defined(CONFIG_SOLARIS)
#include <net/if_arp.h>
#include <netinet/if_ether.h>
#if !defined(ETHER_ADDR_LEN) && defined(ETHERADDRL)
#define ETHER_ADDR_LEN ETHERADDRL
#endif
#else
#include <net/ethernet.h>
#endif
#ifdef CONFIG_SOLARIS
#ifdef CONFIG_GETLOADAVG
#include <sys/loadavg.h>
#endif
#include <sys/sockio.h>
#endif
#endif

So if HAVE_GETIFADDRS is not defined, we do not include <sys/loadavg.h>,
which we actually need even without HAVE_GETIFADDRS, as shown in the
build error snippet in the commit message.

So the patch fixes the build because it moves out this include outside
of the "#ifdef HAVE_GETIFADDRS".

"CONFIG_GETLOADAVG && CONFIG_SOLARIS" is a cosmetic change so we do not
have 2 layers of checks just for a single header.

> 
> Best Regards,
> Kostiantyn Kostiuk.
> 
> 
> 
> >  #include <sys/sockio.h>
> >  #endif
> >  #endif
> > --
> > 2.55.0
> >
> >

