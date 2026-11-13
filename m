Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5083606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=o4MQ77r8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRpgw-0006Mu-Af; Fri, 13 Nov 2026 06:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRpgq-0006Ls-OD
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 06:43:33 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRpgn-00007j-0z
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 06:43:30 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-67c0bd676eeso719843d50.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 03:43:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794570207; cv=none;
 d=google.com; s=arc-20260327;
 b=KTiHPRsW6MY++uIiffLJR0EzvJ2bedXEvxiZTvPYxqI8Lw09cy+MqeTjIIqiW+sn7H
 Lc96yIe08STKwXuSe1BpxkXfBiSdMzcGX1c/6gHgmFBeqJ/je5nbckjukMhbK//qHI/u
 pC38n10xACHrMFNlhAg8kX55cX7o07mPE1OiAmvGAVjDXfxRQYh33iuhsBMz3mw3Manh
 fWNf5v8sfiB/Qh6/AMCgGXZbUdleruXqtOcTYJdbanYfTGQjuVQLuidSLK9S+CdS0ptE
 T0YawGuO1mLN2XD3+cWRzOhD8nk598IEBQbx/qhP8qHmJSv+uJ4mG/Ns02wY0RhnJl6J
 aloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E+0mnBUGdappCvN2ZRSxsaN+H452oyweMoj7dkGzn9o=;
 fh=286Q6M15v7UtZc2or++lSj7RZFntzRCAkL2zfX9VgJM=;
 b=eyGLLAStckm2AJkVzpbpH26ewSDbaeQFhnS6/XCJld4q0PlbDVjeM/P5gWedPeXhZQ
 3Ij5NKkvTVmjPfISCXR+lKhVTLKhhGBuxyIdvkHT76amk+wm1l+rEfrw2Ch27Yy57QWb
 edKL4I9ZwEgQ4lNmknxXgqsJIHhcmVNf8M0MdG+Uam6pGPmxhSlV2LnESr18gmBgVll6
 /FVjXXkAb0o+kXBwODLoBT8Vw85zNbJJ84zWBpNMwvUGnYPMxgHrV68GxMM6cI6vRada
 IUylryiZ/wNIBkq2y+6dES+AclwGZwpIhGsWNaZzbLV0W7xVRZPkIwsYhK2J5n8w8w+6
 RbqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794570207; x=1795175007; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E+0mnBUGdappCvN2ZRSxsaN+H452oyweMoj7dkGzn9o=;
 b=o4MQ77r85cLD3Dy+WiKNWqrSWLDwPFbA+gsvwkqXbZccPcIO56xCqg9/FBVePGyzft
 uK/XB+0ova+wqvLQmEpZkApqijhssHzOZqxeBy/Ay/6hx0nfLRbpCjzaAnS3vYb2BU68
 shd1jA2m2KHiYtsvwHQJiMOdt/EHWUCSEDFkJ8ULUBP9A9a967GtUty94fLXN4P/vVt7
 alx4yK6FFf0RWIMemeCsSOy+40BFmeLaPfWWHapLF8WFbPEmqKtp9lKF9m0KJk1kDLve
 DX2HdKDtX1VzxG9JMZN+ZG1+b4eabIMD+00KBG6Aa2RbMt+jKi0RPkeypT9NNZ793DLD
 ZgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794570207; x=1795175007;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E+0mnBUGdappCvN2ZRSxsaN+H452oyweMoj7dkGzn9o=;
 b=bs2tZk3ZwtZN2GS/cIdyRMenDQVRUF3Mmab0Mzx+RZSLwinOd6ww5yVdcKKBXwyXw8
 QN2ClyMfBBPpMFOPvqH35KfpXZnti1ghszE76JrHXCp0p/GP92DPfA1A+7l7hKTWZobJ
 n2qErJ4mFvSICur0CjfprKxZMNGUWKWU5HtK6ZPBc3AVq32dRPEMcs/uE3+m6rLMNgJW
 Rzdr+ayJqKMhwT3HCPeL8/M3LGCbJMrt9M3ASsMMwqpSIqDq5APc1iYMZRTYZsoahNuK
 BBJgxJVIJOQrBD/MB9K2dMVa7EX5LcfwlAQ/Q5blji5VM1IvszoM56V6vjVG90qAYuci
 b20A==
X-Forwarded-Encrypted: i=1;
 AL+hErEjWVCiYqAyDuqyof8yfjDZls11kuOz8w7DOFacUFyUFF12vXeifudPovLbF+ysh0Xx7YFHloOXnFVn@nongnu.org
X-Gm-Message-State: APuU4Z8yZyTAJe4cmzY9A8TGqQWqrzEo6rpdwgyjKjqJPmTOM0bt7/nY
 mCiQfCfVrvXGVMPSzLCae7iGd1Ln4oK8DkDvJFPekU13AGRJxgWRqDVkzyndXSH9pGXFLqwNjFK
 /hyc5O44iEqisuTlXINE9UT5yAxkUvanvjMa7K2tAuQ==
X-Gm-Gg: AYBFou1VfrSRN37/8bbmRnFdjN+CWEEkBWnv+oEzvdHI54nvpLUbvNcrH0DqtId735s
 C4xBv+QyrbLl98hBbsAJHjhhpHYjx+uoI3JPC10c170yhWrRJplzjrla83TlhD0mM/jKt07zWm2
 ZKz46GEE3h3UPo3Jbc6bOgUg0jN9DYNVdh6Ff7tkdA3mdCqfl0JduJh2ZY8mUXSImz3/QcnfzGy
 l+ReP4yaNfsUhTwRrXjkzqg41oVsfT3FjTOV7XZ8vQnBu3jjCPoC1JhvqBE5Fg9SCl5rWl2IYxX
 koHqbuVSJrZIUIxUYXF0TwSGGl/NQ7La/UCpJ25df35Yz2QaTlrm3fALb7IoIoIvWvGlR1lIZon
 ej9hQ8tGWneNd+7I3D9ACCnjMOGWsuA7VCN98x8v2YBD1EbWRnXabaZ3UBbVokJ+KK8WUg7ghI2
 jBBMqLSpPQQiQMUKaPyyVu
X-Received: by 2002:a05:690e:400f:b0:67c:ace:30ec with SMTP id
 956f58d0204a3-67d8965a4e5mr1646738d50.29.1794570207487; Fri, 13 Nov 2026
 03:43:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260929235109.1398509-1-michael.roth@amd.com>
 <20260929235109.1398509-11-michael.roth@amd.com>
 <0d92762f-b026-472c-86b6-afb9475bfb37@tls.msk.ru>
In-Reply-To: <0d92762f-b026-472c-86b6-afb9475bfb37@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Nov 2026 11:43:12 +0000
X-Gm-Features: AclHuK-0ovHMofMAU4abvH1wqwKidLGkVS0z3wn2kXuEuqiJPvEmXS2IosZGICU
Message-ID: <CAFEAcA-UsEKBfpeQpZ-SPZ2cFXA7_XxVmOdSEQ0UfRC+z8LSTA@mail.gmail.com>
Subject: Re: [PATCH v7 10/12] hostmem: Support fully shared guest memfd to
 back a VM
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, 
 armbru@redhat.com, pankaj.gupta@amd.com, xiaoyao.li@intel.com, 
 chao.p.peng@linux.intel.com, david@kernel.org, berrange@redhat.com, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 at 11:29, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 9/30/26 02:50, Michael Roth wrote:
> > From: Peter Xu <peterx@redhat.com>
> >
> > Host backends supports guest-memfd now by detecting whether it's a
> > confidential VM.  There's no way to choose it yet from the memory level to
> > use it fully shared.  If we use guest-memfd, it so far always implies we
> > need two layers of memory backends, while the guest-memfd only provides the
> > private set of pages.
> >
> > This patch introduces a way so that QEMU can consume guest memfd as the
> > only source of memory to back the object (aka, fully shared).
> >
> > To use the fully shared guest-memfd, one can add a memfd object with:
> >
> >    -object memory-backend-memfd,x-guest-memfd=on,share=on
> >
> > Note that share=on is required with fully shared guest_memfd.
> >
> > Since guest-memfd is not yet a drop-in replacement for memfd (e.g. lack
> > of hugepage support), the option is tagged as experimental for now so
> > that it can be made available for early enablement/testing without
> > causing any surprises for other users.
> >
> > PS: there's a trivial touch-up on fd<0 check, because the stub to create
> > guest-memfd may return negative but not -1.


> > diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> > index 7a7855aaab..666593ff6c 100644
> > --- a/backends/hostmem-memfd.c
> > +++ b/backends/hostmem-memfd.c
> > @@ -18,6 +18,9 @@
> >   #include "qapi/error.h"
> >   #include "qom/object.h"
> >   #include "migration/cpr.h"
> > +#include "system/kvm.h"
> > +#include <linux/kvm.h>
> > +#include "qapi/qapi-visit-common.h"
>
> Starting with this commit, a build of qemu on sparc64 host.  As far as I remember,
> linux on sparc64 does not support kvm, so there's no asm/kvm.h which is included
> by linux/kvm.h.
>
> Should this include (and subsequent addiions) be #if-guarded by CONFIG_KVM perhaps?
> Or maybe this whole file (hostmem-memfd.c) or subsystem (hostmem) should be omitted
> if !kvm?

I think that:
(1) we shouldn't include linux/kvm.h directly here; system/kvm.h will
    pull it in for us
(2) the KVM specific parts of this file should be ifdef guarded if the
    default stuff in system/kvm.h is not sufficient for it to compile
    on a non-KVM host
(3) if the user set the guest-memfd property to "on" but we're not using
    KVM then we should make sure that generates a suitable error
    (i.e. if we had to ifdef the KVM stuff then the else block should
    set the error pointer here)

thanks
-- PMM

