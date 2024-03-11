Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F46C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 15:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjhik-0006lF-UN; Mon, 11 Mar 2024 11:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rjhic-0006kn-Pq
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:37:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rjhiZ-0006r3-8F
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710171449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MMzHO3xqviHTt8kaOIGgBnITRujcbe5aeyx3hCRQVrk=;
 b=PusZeM3o39LRpmxJx81bkwNoVhmF2SOk7rUMLAbBTAM7NisIY3BmwQkAL5VyPtWAUwjmga
 OS7r+oJ4gwtbUFEwwZnIpSMvXQ+WAbg9CuEhdRFX3r032XBK25DHcJ/Pdz/kuVaT6+RdkX
 kcVnkXHY9kTm3YhVIl1ZCkT9SE9JjWQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-wOayNvbtOh2M83YTGsBs0Q-1; Mon, 11 Mar 2024 11:37:27 -0400
X-MC-Unique: wOayNvbtOh2M83YTGsBs0Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-51321a5bfadso3469237e87.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 08:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710171446; x=1710776246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MMzHO3xqviHTt8kaOIGgBnITRujcbe5aeyx3hCRQVrk=;
 b=YVLbTNyfnNCwqYUcxxz/TYbt1+WaL+ufqgnHeJXum6ej9z0HBxL9V+tYOAGgoQYAaH
 XxSHAx4xcHy7AZmOWAmbEQBbNZ79vCB5gcpjMrpkdSjtdHyv09cU97r/J12DdFttSH5b
 ZzFBrze0FZgO5X2NXB1QJDT8v9IRXBMTKOEWlssY1OIsGBy1SUGWGPq35HLkB+PiJs/o
 1tNSj4ceJpM1Gd6bZy9MAYIgasYt49go34FSoN2SwgvQkl/YZDTiaWg/zn2V43v7djY2
 oHt3JJbcioQnG5ez4NsN1mXgq+kmBOeZEgkw5stzmHv1SeQicPKaqbsIgq859pbVIBuI
 Edrw==
X-Gm-Message-State: AOJu0YwNbBgSJ6/D9vFXLOKsW07QYjgbIUfLnEX2v1QZCTUOsS1oYPUM
 elmc5wXjYx0+HY/FL6mYag1zbOc/7jzsQDG38F/sP+u8R/i3xNiP8E3G/CTmuJsAr5Tsqu0ckOO
 9N7FxaKdn++3lyCjRqJ+FhVr+aHuViR7Fh5XMnzNhMSkUPXccVgXyTeC0fTLHjL3AdEthsf3dSx
 HQsmMReYNAbi/+1YfdeYudb2SgH4s=
X-Received: by 2002:a19:5e1d:0:b0:512:c8f0:1954 with SMTP id
 s29-20020a195e1d000000b00512c8f01954mr4097800lfb.0.1710171446351; 
 Mon, 11 Mar 2024 08:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9JxfaJJKjwZj/URPUTZFAshd1PYGGEvy4QH9e0oVAR+l5IRltVX1JYNfJDiAlvN+YveNxEHRcQKbv7dXEI1Q=
X-Received: by 2002:a19:5e1d:0:b0:512:c8f0:1954 with SMTP id
 s29-20020a195e1d000000b00512c8f01954mr4097788lfb.0.1710171446002; Mon, 11 Mar
 2024 08:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240227113921.236097-1-armbru@redhat.com>
In-Reply-To: <20240227113921.236097-1-armbru@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 11 Mar 2024 17:37:14 +0200
Message-ID: <CAPMcbCoWbZ+x6BA-xje-VoZfV=i82NiNExD0gScTtG_YyHrYPA@mail.gmail.com>
Subject: Re: [PATCH 00/13] Subject: [PATCH 00/15] qapi: Improve command
 response documentation
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com, 
 eblake@redhat.com
Content-Type: multipart/alternative; boundary="0000000000008b60fb0613645140"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000008b60fb0613645140
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

I will merge qga-related patches in my PULL.

Best Regards,
Konstantin Kostiuk.


On Tue, Feb 27, 2024 at 1:39=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> We use doc comment "Returns" sections both for success and error
> response.  This series moves the latter to new "Errors" sections.
> Enables some cleanup, visible in the diffstat.q
>
> Markus Armbruster (13):
>   qapi: Memorize since & returns sections
>   qapi: Slightly clearer error message for invalid "Returns" section
>   qapi: New documentation section tag "Errors"
>   qapi: Move error documentation to new "Errors" sections
>   qapi: Delete useless "Returns" sections
>   qapi: Clean up "Returns" sections
>   qapi/yank: Tweak @yank's error description for consistency
>   qga/qapi-schema: Move error documentation to new "Errors" sections
>   qga/qapi-schema: Delete useless "Returns" sections
>   qga/qapi-schema: Clean up "Returns" sections
>   qga/qapi-schema: Tweak documentation of fsfreeze commands
>   qga/qapi-schema: Fix guest-set-memory-blocks documentation
>   qapi: Reject "Returns" section when command doesn't return anything
>
>  docs/devel/qapi-code-gen.rst               |  6 +-
>  qapi/block-core.json                       | 74 ++++++++--------------
>  qapi/block-export.json                     | 23 ++++---
>  qapi/block.json                            | 10 ++-
>  qapi/char.json                             |  6 --
>  qapi/dump.json                             |  2 -
>  qapi/machine-target.json                   | 37 ++++++-----
>  qapi/machine.json                          | 19 ++----
>  qapi/migration.json                        | 26 --------
>  qapi/misc-target.json                      |  3 -
>  qapi/misc.json                             | 25 +++-----
>  qapi/net.json                              | 17 +++--
>  qapi/qdev.json                             |  3 +-
>  qapi/qom.json                              |  6 +-
>  qapi/run-state.json                        |  5 +-
>  qapi/tpm.json                              |  2 -
>  qapi/transaction.json                      |  5 +-
>  qapi/ui.json                               | 17 +----
>  qapi/yank.json                             |  5 +-
>  qga/qapi-schema.json                       | 72 +++++++++------------
>  scripts/qapi/parser.py                     | 50 ++++++++++-----
>  tests/qapi-schema/doc-good.json            |  2 +
>  tests/qapi-schema/doc-good.out             |  2 +
>  tests/qapi-schema/doc-good.txt             |  6 ++
>  tests/qapi-schema/doc-invalid-return.err   |  2 +-
>  tests/qapi-schema/doc-invalid-return2.err  |  1 +
>  tests/qapi-schema/doc-invalid-return2.json |  7 ++
>  tests/qapi-schema/doc-invalid-return2.out  |  0
>  tests/qapi-schema/meson.build              |  1 +
>  29 files changed, 189 insertions(+), 245 deletions(-)
>  create mode 100644 tests/qapi-schema/doc-invalid-return2.err
>  create mode 100644 tests/qapi-schema/doc-invalid-return2.json
>  create mode 100644 tests/qapi-schema/doc-invalid-return2.out
>
> --
> 2.43.0
>
>

--0000000000008b60fb0613645140
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Markus,</div><div><br></div><div>I will merge qga-=
related patches in my PULL.<br></div><div><br></div><div><div><div><div><di=
v><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signat=
ure"><div dir=3D"ltr"><div>Best Regards,</div><div>Konstantin Kostiuk.</div=
></div></div></div><br></div></div></div></div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 27, 2024 at 1:39=
=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armb=
ru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">We use doc comment &quot;Returns&quot; sections both for succe=
ss and error<br>
response.=C2=A0 This series moves the latter to new &quot;Errors&quot; sect=
ions.<br>
Enables some cleanup, visible in the diffstat.q<br>
<br>
Markus Armbruster (13):<br>
=C2=A0 qapi: Memorize since &amp; returns sections<br>
=C2=A0 qapi: Slightly clearer error message for invalid &quot;Returns&quot;=
 section<br>
=C2=A0 qapi: New documentation section tag &quot;Errors&quot;<br>
=C2=A0 qapi: Move error documentation to new &quot;Errors&quot; sections<br=
>
=C2=A0 qapi: Delete useless &quot;Returns&quot; sections<br>
=C2=A0 qapi: Clean up &quot;Returns&quot; sections<br>
=C2=A0 qapi/yank: Tweak @yank&#39;s error description for consistency<br>
=C2=A0 qga/qapi-schema: Move error documentation to new &quot;Errors&quot; =
sections<br>
=C2=A0 qga/qapi-schema: Delete useless &quot;Returns&quot; sections<br>
=C2=A0 qga/qapi-schema: Clean up &quot;Returns&quot; sections<br>
=C2=A0 qga/qapi-schema: Tweak documentation of fsfreeze commands<br>
=C2=A0 qga/qapi-schema: Fix guest-set-memory-blocks documentation<br>
=C2=A0 qapi: Reject &quot;Returns&quot; section when command doesn&#39;t re=
turn anything<br>
<br>
=C2=A0docs/devel/qapi-code-gen.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 6 +-<br>
=C2=A0qapi/block-core.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 74 ++++++++--------------<br>
=C2=A0qapi/block-export.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 23 ++++---<br>
=C2=A0qapi/block.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 ++-<br>
=C2=A0qapi/char.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 --<br>
=C2=A0qapi/dump.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 -<br>
=C2=A0qapi/machine-target.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 37 ++++++-----<br>
=C2=A0qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 19 ++----<br>
=C2=A0qapi/migration.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 26 --------<br>
=C2=A0qapi/misc-target.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 -<br>
=C2=A0qapi/misc.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 25 +++-----<br>
=C2=A0qapi/net.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 17 +++--<br>
=C2=A0qapi/qdev.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +-<br>
=C2=A0qapi/qom.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +-<br>
=C2=A0qapi/run-state.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +-<br>
=C2=A0qapi/tpm.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 -<br>
=C2=A0qapi/transaction.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +-<br>
=C2=A0qapi/ui.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 17 +----<br>
=C2=A0qapi/yank.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +-<br>
=C2=A0qga/qapi-schema.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 72 +++++++++------------<br>
=C2=A0scripts/qapi/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 50 ++++++++++-----<br>
=C2=A0tests/qapi-schema/doc-good.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 2 +<br>
=C2=A0tests/qapi-schema/doc-good.out=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 2 +<br>
=C2=A0tests/qapi-schema/doc-good.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 6 ++<br>
=C2=A0tests/qapi-schema/doc-invalid-return.err=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0tests/qapi-schema/doc-invalid-return2.err=C2=A0 |=C2=A0 1 +<br>
=C2=A0tests/qapi-schema/doc-invalid-return2.json |=C2=A0 7 ++<br>
=C2=A0tests/qapi-schema/doc-invalid-return2.out=C2=A0 |=C2=A0 0<br>
=C2=A0tests/qapi-schema/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A029 files changed, 189 insertions(+), 245 deletions(-)<br>
=C2=A0create mode 100644 tests/qapi-schema/doc-invalid-return2.err<br>
=C2=A0create mode 100644 tests/qapi-schema/doc-invalid-return2.json<br>
=C2=A0create mode 100644 tests/qapi-schema/doc-invalid-return2.out<br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--0000000000008b60fb0613645140--


