Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128FCC30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 23:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOQhK-0008F1-3h; Mon, 01 Jul 2024 19:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sOQhC-0008E9-Ic
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 19:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sOQhA-00036i-SB
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 19:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719877466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UbkKhLdthwa8OuY4pqMq8iaL8/ZYD5SSDpkopNVSBjU=;
 b=iS0htYPPdGQYvsDpqKBzfgX8qsmZFj6LPkQaGrJzvXoSGUiAJt3Z6swGHCCH6P+56sEWxe
 IjGbCjo2jU21qvvIfwCZbOWFc7vrSBwG5YIq9RQAszf0LDldZoOub9ULT343WpGixH6R5J
 x5Uy2ML6tjxm9Sl0H+AiSbPIB0k/dXM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-zZo1RxRPOMeBo3kG3_3Ieg-1; Mon, 01 Jul 2024 19:44:21 -0400
X-MC-Unique: zZo1RxRPOMeBo3kG3_3Ieg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c924a5edaaso3305288a91.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 16:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719877459; x=1720482259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UbkKhLdthwa8OuY4pqMq8iaL8/ZYD5SSDpkopNVSBjU=;
 b=dr/ZuHFHaysNh3twAljrgGBF5Qi9gZaslj8cmmP3lMu/FXEVx12i0PJB8/LjQcMlUm
 +9aflHHqp1d0fQsJtKFqTKVFzmageYDjQz4NTnOWmwPpMXRmn5N4/eE3Z3CPZzvTUNuT
 KhI5C2Zh0xAQOcLB1pnJWGjtloirqrVGG6/3h2yX4VXXV/D08ylpFfGUdpUHXs/9Vv+5
 RNp/ABXDbenvcbWqCjtyQic44C4Fhknn+imA6/15idCJ9infX40RrsLwON7NF4DR0EJI
 0p/hXvMGsYtYDzKnekZrHJAkzvY89qPDm9eNfJ6IM3yOpQOgLbVHA0ffe+VmYEoCRRo5
 GD3A==
X-Gm-Message-State: AOJu0YzhKYdMUw4zXAonAmst4g+I1OOMMW1QcM+gV2qBJpdBQzg/3Snh
 FbWqH45Q3ekYkKH0CT68aw1AQ9cHSTx7+UqP6D3ZO0zr+oOL0W3o/c02wW5uoKY0H5IjHFGhDy7
 bABPjUiC8BrlS8SXFStIpLXqYZWeHs42tIsKhrBuTYgRq6RVZn+f6tzdetwQzJpLk+B1aDQwDTN
 jDtcuNh5keX2nRI9ElStpGqccmPzE/FGCEmHs=
X-Received: by 2002:a17:90a:e648:b0:2c4:aab1:1803 with SMTP id
 98e67ed59e1d1-2c93d775a1fmr5703763a91.33.1719877459297; 
 Mon, 01 Jul 2024 16:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaZnXyba1uwRJrTUaS0ykwTGRAqpB9ttx2OWNliQI1Xo0oakQfsQnI261jdxkXMt5ErrfK7p+43OyrTA/TR7w=
X-Received: by 2002:a17:90a:e648:b0:2c4:aab1:1803 with SMTP id
 98e67ed59e1d1-2c93d775a1fmr5703752a91.33.1719877458922; Mon, 01 Jul 2024
 16:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240626232230.408004-1-jsnow@redhat.com>
 <20240626232230.408004-4-jsnow@redhat.com>
In-Reply-To: <20240626232230.408004-4-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 1 Jul 2024 19:44:06 -0400
Message-ID: <CAFn=p-Zu-YHHvswewTzpD6P=owhhjbmzpy5AsmXa+hWFJOUHrA@mail.gmail.com>
Subject: Re: [PATCH 3/4] iotests: Change imports for Python 3.13
To: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ff30dd061c382c7b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000ff30dd061c382c7b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping - happy to merge this series myself but didn't wanna change iotests
without at least an ack from the lord of that castle.

On Wed, Jun 26, 2024, 7:22=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:

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
>
>  DEF_GDB_OPTIONS =3D 'localhost:12345'
>
> diff --git a/tests/qemu-iotests/testrunner.py
> b/tests/qemu-iotests/testrunner.py
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

--000000000000ff30dd061c382c7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Ping - happy to merge this series myself but didn&#3=
9;t wanna change iotests without at least an ack from the lord of that cast=
le.<br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Wed, Jun 26, 2024, 7:22=E2=80=AFPM John Snow &lt;<a href=3D"mailto:jsno=
w@redhat.com">jsnow@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">Python 3.13 isn&#39;t out yet, but it&#39;s in beta and Fedora i=
s ramping up to<br>
make it the default system interpreter for Fedora 41.<br>
<br>
They moved our cheese for where ContextManager lives; add a conditional<br>
to locate it while we support both pre-3.9 and 3.13+.<br>
<br>
Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
---<br>
=C2=A0tests/qemu-iotests/testenv.py=C2=A0 =C2=A0 | 7 ++++++-<br>
=C2=A0tests/qemu-iotests/testrunner.py | 9 ++++++---<br>
=C2=A02 files changed, 12 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py<=
br>
index 588f30a4f14..96d69e56963 100644<br>
--- a/tests/qemu-iotests/testenv.py<br>
+++ b/tests/qemu-iotests/testenv.py<br>
@@ -25,7 +25,12 @@<br>
=C2=A0import random<br>
=C2=A0import subprocess<br>
=C2=A0import glob<br>
-from typing import List, Dict, Any, Optional, ContextManager<br>
+from typing import List, Dict, Any, Optional<br>
+<br>
+if sys.version_info &gt;=3D (3, 9):<br>
+=C2=A0 =C2=A0 from contextlib import AbstractContextManager as ContextMana=
ger<br>
+else:<br>
+=C2=A0 =C2=A0 from typing import ContextManager<br>
<br>
=C2=A0DEF_GDB_OPTIONS =3D &#39;localhost:12345&#39;<br>
<br>
diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunn=
er.py<br>
index 7b322272e92..2e236c8fa39 100644<br>
--- a/tests/qemu-iotests/testrunner.py<br>
+++ b/tests/qemu-iotests/testrunner.py<br>
@@ -27,11 +27,14 @@<br>
=C2=A0import shutil<br>
=C2=A0import sys<br>
=C2=A0from multiprocessing import Pool<br>
-from typing import List, Optional, Any, Sequence, Dict, \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ContextManager<br>
-<br>
+from typing import List, Optional, Any, Sequence, Dict<br>
=C2=A0from testenv import TestEnv<br>
<br>
+if sys.version_info &gt;=3D (3, 9):<br>
+=C2=A0 =C2=A0 from contextlib import AbstractContextManager as ContextMana=
ger<br>
+else:<br>
+=C2=A0 =C2=A0 from typing import ContextManager<br>
+<br>
<br>
=C2=A0def silent_unlink(path: Path) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0try:<br>
-- <br>
2.45.0<br>
<br>
</blockquote></div></div></div>

--000000000000ff30dd061c382c7b--


