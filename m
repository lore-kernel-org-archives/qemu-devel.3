Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB20C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh8Df-0001L6-5U; Mon, 04 Mar 2024 08:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1rh8DI-0001Cs-QK
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:18:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1rh8D5-0004aj-BU
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709558304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ToLgabKW3CnBC4PjEWsOXU953gd7IcurnRflLEy/jek=;
 b=GILOoytczgSR2aNALayNR5wx9hNRW6BhmcWunDY8iuCdJmp4FwMBHipg+SvM+phK/ECVUk
 wTogCKggkWDZ3oVc7G+vf0Gu99vxn4vkofg/v9Ib6NEms3/taMOKL3OLyYX96wOAuW5T2p
 6HG21Ph9T+rEe3AbIpZsrGgf4AOTAQk=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-SJk7A_xJNKu4masXho-o3A-1; Mon, 04 Mar 2024 08:18:22 -0500
X-MC-Unique: SJk7A_xJNKu4masXho-o3A-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dc64f63d768so8028535276.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 05:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709558302; x=1710163102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ToLgabKW3CnBC4PjEWsOXU953gd7IcurnRflLEy/jek=;
 b=bY4SLVlir689tZJ2AXEMgj5oQ3etnxGPopbnY/y9jFNfayJpTpL6uPN8HGGlnc3naj
 p1nCk6RiDo4iCM2ocmjKEevDdv932V05gos/cCWBKBZ6BoRqY/SUqt8mZ91ByFxMvboT
 3R87AEzAyuDDz5OhRieSKx5nW7AuWpJllDBo5GBhhSzSRY/8KuUI+4LGSF5L6iDRraUP
 csx956VHa8Nh86ePv0Q/oT8VguVmjiOPFVTaU71n9vUrtT+i8Lr4nV5gxvx1cuMoGefY
 ShoDwcIU9NO+63YnlibIo1prMyMty11wQXLK9Sezw+K8oqtpCUFcbvMqKLyoC/TwyfUh
 j6sg==
X-Gm-Message-State: AOJu0YwiPXSHEcYqINWDRl1SLtf0wyF0nMboOZVS8xW7On44X+UpkmL7
 Z3qgVmJqJ4QfL1YnWSvH33TSr1WgZXQqpARfbDC8vxDU2N18Wb1owcpGSqQxPUX/6LD34pQOPzb
 2hWs780ttMex+97QiEb/af2cwgqScfWdVkD+HIvumP64ETDc2kDJeIOdpXWI2zdM6sZOaKTME/m
 79fr/LCBMKuTL3fBwqsSO+KLmjQho=
X-Received: by 2002:a25:abb3:0:b0:dcf:ad31:57c9 with SMTP id
 v48-20020a25abb3000000b00dcfad3157c9mr6565176ybi.0.1709558302224; 
 Mon, 04 Mar 2024 05:18:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoSxcRyr79c3Ge+1UCcowaxkcYlx/Y1XDFNl73fMgarXTvgXfrO2Jwh1xmAHFQilBnF9bdds0z393T7hnWIyg=
X-Received: by 2002:a25:abb3:0:b0:dcf:ad31:57c9 with SMTP id
 v48-20020a25abb3000000b00dcfad3157c9mr6565160ybi.0.1709558301931; Mon, 04 Mar
 2024 05:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20240301172858.665135-1-andrey.drobyshev@virtuozzo.com>
 <CAPMcbCrOijMTjm+LhfGyHXjPpQs4gp3Zwh9UKoThMfVwF6e=3g@mail.gmail.com>
In-Reply-To: <CAPMcbCrOijMTjm+LhfGyHXjPpQs4gp3Zwh9UKoThMfVwF6e=3g@mail.gmail.com>
From: Dehan Meng <demeng@redhat.com>
Date: Mon, 4 Mar 2024 21:18:11 +0800
Message-ID: <CA+kPPJxnBKXoDxSJEtm_c6=jjCLnRVLR9o-4YmCG=jkePEk+RA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] qga/commands-posix: replace code duplicating
 commands with a helper
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, 
 michael.roth@amd.com, marcandre.lureau@redhat.com, philmd@linaro.org, 
 den@virtuozzo.com
Content-Type: multipart/alternative; boundary="0000000000004f4ff40612d58f62"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000004f4ff40612d58f62
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series's patches. qga-related commands worked successfully.

Tested-by: Dehan Meng <demeng@redhat.com>


On Mon, Mar 4, 2024 at 8:00=E2=80=AFPM Konstantin Kostiuk <kkostiuk@redhat.=
com>
wrote:

> For series
> Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
>
> On Fri, Mar 1, 2024 at 7:29=E2=80=AFPM Andrey Drobyshev <
> andrey.drobyshev@virtuozzo.com> wrote:
>
>> v1 --> v2:
>>  * Replace commit for guest-get-fsinfo: instead of reporting statvfs(3)
>>    values directly, keep the old ones but add an additional optional
>>    field 'total-bytes-root', only reported in POSIX.  Also tweak the
>>    fields description in qga/qapi-schema.json to document where the
>>    values come from.
>>
>> v1:
>> https://lists.nongnu.org/archive/html/qemu-devel/2024-02/msg05766.html
>>
>> Andrey Drobyshev (7):
>>   qga: guest-get-fsinfo: add optional 'total-bytes-root' field
>>   qga: introduce ga_run_command() helper for guest cmd execution
>>   qga/commands-posix: qmp_guest_shutdown: use ga_run_command helper
>>   qga/commands-posix: qmp_guest_set_time: use ga_run_command helper
>>   qga/commands-posix: execute_fsfreeze_hook: use ga_run_command helper
>>   qga/commands-posix: use ga_run_command helper when suspending via
>>     sysfs
>>   qga/commands-posix: qmp_guest_set_user_password: use ga_run_command
>>     helper
>>
>>  qga/commands-posix.c | 389 +++++++++++++++++++------------------------
>>  qga/commands-win32.c |   1 +
>>  qga/qapi-schema.json |  12 +-
>>  3 files changed, 182 insertions(+), 220 deletions(-)
>>
>> --
>> 2.39.3
>>
>>

--0000000000004f4ff40612d58f62
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span id=3D"gmail-docs-internal-guid-0c54556a-7fff-b959-03=
f2-37f1200994ee"><p dir=3D"ltr" style=3D"line-height:1.2;margin-top:0pt;mar=
gin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;=
font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alt=
ernates:normal;vertical-align:baseline">QE tested this series&#39;s patches=
. qga-related commands worked successfully.</span></p><br><p dir=3D"ltr" st=
yle=3D"line-height:1.2;margin-top:0pt;margin-bottom:0pt"><span style=3D"fon=
t-size:11pt;font-family:Arial,sans-serif;color:rgb(66,66,66);font-variant-n=
umeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal=
;vertical-align:baseline">Tested-by</span><span style=3D"font-size:11pt;fon=
t-family:Arial,sans-serif;font-variant-numeric:normal;font-variant-east-asi=
an:normal;font-variant-alternates:normal;vertical-align:baseline">: Dehan M=
eng &lt;<a href=3D"mailto:demeng@redhat.com" style=3D"box-sizing:border-box=
;font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,&quot;No=
to Sans&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quo=
t;Segoe UI Emoji&quot;;font-size:14px">demeng@redhat.com</a>&gt;</span></p>=
</span><br class=3D"gmail-Apple-interchange-newline"></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 4, 2024 =
at 8:00=E2=80=AFPM Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat=
.com">kkostiuk@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div>For series =
<br></div><div>Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkosti=
uk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, M=
ar 1, 2024 at 7:29=E2=80=AFPM Andrey Drobyshev &lt;<a href=3D"mailto:andrey=
.drobyshev@virtuozzo.com" target=3D"_blank">andrey.drobyshev@virtuozzo.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">v=
1 --&gt; v2:<br>
=C2=A0* Replace commit for guest-get-fsinfo: instead of reporting statvfs(3=
)<br>
=C2=A0 =C2=A0values directly, keep the old ones but add an additional optio=
nal<br>
=C2=A0 =C2=A0field &#39;total-bytes-root&#39;, only reported in POSIX.=C2=
=A0 Also tweak the<br>
=C2=A0 =C2=A0fields description in qga/qapi-schema.json to document where t=
he<br>
=C2=A0 =C2=A0values come from.<br>
<br>
v1: <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2024-02/msg=
05766.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/a=
rchive/html/qemu-devel/2024-02/msg05766.html</a><br>
<br>
Andrey Drobyshev (7):<br>
=C2=A0 qga: guest-get-fsinfo: add optional &#39;total-bytes-root&#39; field=
<br>
=C2=A0 qga: introduce ga_run_command() helper for guest cmd execution<br>
=C2=A0 qga/commands-posix: qmp_guest_shutdown: use ga_run_command helper<br=
>
=C2=A0 qga/commands-posix: qmp_guest_set_time: use ga_run_command helper<br=
>
=C2=A0 qga/commands-posix: execute_fsfreeze_hook: use ga_run_command helper=
<br>
=C2=A0 qga/commands-posix: use ga_run_command helper when suspending via<br=
>
=C2=A0 =C2=A0 sysfs<br>
=C2=A0 qga/commands-posix: qmp_guest_set_user_password: use ga_run_command<=
br>
=C2=A0 =C2=A0 helper<br>
<br>
=C2=A0qga/commands-posix.c | 389 +++++++++++++++++++-----------------------=
-<br>
=C2=A0qga/commands-win32.c |=C2=A0 =C2=A01 +<br>
=C2=A0qga/qapi-schema.json |=C2=A0 12 +-<br>
=C2=A03 files changed, 182 insertions(+), 220 deletions(-)<br>
<br>
-- <br>
2.39.3<br>
<br>
</blockquote></div></div>
</blockquote></div>

--0000000000004f4ff40612d58f62--


