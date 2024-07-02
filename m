Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509CBC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 11:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOc3l-0006Ef-No; Tue, 02 Jul 2024 07:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sOc3k-0006EL-5m
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 07:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sOc3i-0003Ar-Bh
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 07:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719921148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y5AO4Yao+JQQAmdTj05CRTK4SyFyMP/ATbPuEOYXRw8=;
 b=brfG0wnvjHb4nKX04jUspAU/uFtNM6zAUsi/FejRKXQJVjGgtrvRdaWci5U4o53HLhq1KG
 PoDD7klMOjrTVSsgDtS9BS9FKnx1PVFrel3GHQVIVKegMK53VqBO/SXYyE17GrXakuKYgH
 pxAcGnnD/IZzDonv+uuVdcR75SFLn0Q=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-lEbddqXHNbOtiXPjfESuqQ-1; Tue, 02 Jul 2024 07:52:27 -0400
X-MC-Unique: lEbddqXHNbOtiXPjfESuqQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3d5608530abso3810255b6e.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 04:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719921146; x=1720525946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5AO4Yao+JQQAmdTj05CRTK4SyFyMP/ATbPuEOYXRw8=;
 b=YyKH5pkMCTxKTgI1E9RN4dlNMGsDINsVBGIXSTY/B5uyT5qV5P33g/G5PJ5IuCt2Mj
 dqHPMws1035VK6o+CqdpQ1k5FV+6S2HIPNKjqrXCN/fn3YCnm0U+iycnhHjTIO7DN3f0
 U1Z6FVljt/CyortYcqNN2rIErV9ymN93RzT9ib0XEL+QI8+yEo6OQiknz2Bzj6aE8nX7
 7RQfH9xFLf3AK4FhZN42RPHcbasPYUYDI6pDqKJiGCuaxfdisdntSJwdiefv5DjehGP1
 vWFBVNVbA/KXzkHKNKC5dqLwVJDY6LX9jnNTwWOibuZAx0IuJ+u8VXT48Rf9NyKYAoTA
 8HOg==
X-Gm-Message-State: AOJu0YwhJs0517PY1byKuhQiIgBpD/Zgxa/L1r3ex29hHuNShVtWxpmU
 qMeN5QOLsqhpMZHsPBwCb01MPwkBngdJysrp678T2WIKSJiW3/2xy+0iGwJSKFRrk0Xpe9hbTQK
 axsRkdmhHf4wLuCCUTZeYLRoPBpUQJc6iB0GzJC0x23k7tAu6pG5d0ZMqe2sSY+lbt5hBhyPmjB
 z+nfU68FHGeC0SWLRk25n9tmH4Mlg=
X-Received: by 2002:a05:6808:152a:b0:3d6:2d09:8a8c with SMTP id
 5614622812f47-3d6b5496fe3mr12933665b6e.51.1719921145291; 
 Tue, 02 Jul 2024 04:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU2+mj2+3eo3cCxXAR8c5YlTMc8rXGkNaAw4CBGNem2MrRfyL1iTI+8CEXI3Ay7RLhrJkI5lsJThH38XIUayI=
X-Received: by 2002:a05:6808:152a:b0:3d6:2d09:8a8c with SMTP id
 5614622812f47-3d6b5496fe3mr12933638b6e.51.1719921144972; Tue, 02 Jul 2024
 04:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240626232230.408004-1-jsnow@redhat.com>
 <20240626232230.408004-4-jsnow@redhat.com>
In-Reply-To: <20240626232230.408004-4-jsnow@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 2 Jul 2024 14:52:08 +0300
Message-ID: <CAMRbyyuPVcwaLcyW=LeMhAWCRdqDBkNzYwE9q4Wan0Pm0k41GQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] iotests: Change imports for Python 3.13
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 27, 2024 at 2:23=E2=80=AFAM John Snow <jsnow@redhat.com> wrote:
>
> Python 3.13 isn't out yet, but it's in beta and Fedora is ramping up to
> make it the default system interpreter for Fedora 41.
>
> They moved our cheese for where ContextManager lives; add a conditional
> to locate it while we support both pre-3.9 and 3.13+.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/testenv.py    | 7 ++++++-
>  tests/qemu-iotests/testrunner.py | 9 ++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.p=
y
> index 588f30a4f14..96d69e56963 100644
> --- a/tests/qemu-iotests/testenv.py
> +++ b/tests/qemu-iotests/testenv.py
> @@ -25,7 +25,12 @@
>  import random
>  import subprocess
>  import glob
> -from typing import List, Dict, Any, Optional, ContextManager
> +from typing import List, Dict, Any, Optional
> +
> +if sys.version_info >=3D (3, 9):
> +    from contextlib import AbstractContextManager as ContextManager
> +else:
> +    from typing import ContextManager

It can be cleaner to add a compat module hiding the details so the
entire project
can have a single instance of this. Other code will just use:

    from compat import ContextManager

>
>  DEF_GDB_OPTIONS =3D 'localhost:12345'
>
> diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testru=
nner.py
> index 7b322272e92..2e236c8fa39 100644
> --- a/tests/qemu-iotests/testrunner.py
> +++ b/tests/qemu-iotests/testrunner.py
> @@ -27,11 +27,14 @@
>  import shutil
>  import sys
>  from multiprocessing import Pool
> -from typing import List, Optional, Any, Sequence, Dict, \
> -        ContextManager
> -
> +from typing import List, Optional, Any, Sequence, Dict
>  from testenv import TestEnv
>
> +if sys.version_info >=3D (3, 9):
> +    from contextlib import AbstractContextManager as ContextManager
> +else:
> +    from typing import ContextManager
> +
>
>  def silent_unlink(path: Path) -> None:
>      try:
> --
> 2.45.0
>
>


