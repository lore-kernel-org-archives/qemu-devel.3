Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB0CCAC5A7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 08:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Kap-0001XA-Iw; Wed, 24 Sep 2025 04:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1v1Kam-0001Wq-TN
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:11:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1v1Kad-0002aR-0G
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758701457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e++uruiGGoLoo/au/ZQfOsDB3Z2Da5LeJqtER17d8HM=;
 b=WgzER0oLbGKgF8McvbBcA8NxraWY/pyLN0A8zrGKwj4n5Hn4f4nS10ICTcSJKVHi9qNdER
 Lk/zmc34tMTP1pEsnWaVLsEs7SwujhRVH43Ghw+uo1DkgxiSXBjGHh6ftAx2h7qITUrK4t
 2C578Kq6jWZ1GWK7dnENYdCUHmBLSI8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-BXG4bAa-PYCY4a60a1fHFw-1; Wed, 24 Sep 2025 04:10:56 -0400
X-MC-Unique: BXG4bAa-PYCY4a60a1fHFw-1
X-Mimecast-MFC-AGG-ID: BXG4bAa-PYCY4a60a1fHFw_1758701455
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-78f3a8ee4d8so106812166d6.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 01:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758701455; x=1759306255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e++uruiGGoLoo/au/ZQfOsDB3Z2Da5LeJqtER17d8HM=;
 b=nnij+1jjvr0hB5u68wFggpwrgC3MTLfi4rhQv5GSn+ZfztM9fDjHXstazGlR7Joxss
 /dEfg481QkzJPnQwratn7QImy78PlEa7ktTvrOwJ4Jhjl5I8HM6s/CDf6iNtN3l++aIb
 ciIPKNIfaWJKUFttWLbJajfYLtySjUu1UETcWIXB/iVkY+0bgUggIcUlkc8FzOejsTGq
 mJPfcQxd5mKIlvr3E0CjlUbA4bC8ZW6hvcgjJqcJecVvi1fx6RfXxQBtoQUxPsDLT3eh
 ZBrxkcD3gNf7SAr4Yh4DkDpzNldfdUZE09XACoLaC2zBu66H1ChEX7UdI4rIxJmXkCCM
 yOjw==
X-Gm-Message-State: AOJu0YzccRQuADmb2sPeh590N+bGcqRmFjl2QSgONE4d7Ry5bUwZf+dV
 3PP7rbXfh5cqZEQJY/awUFrLZ2auRpB3fl43gDomLTn6O2GIshPrfJLihH876s0EEUSVo6oI1F1
 xbvMf+VtOK8lYEohfUkQr4wRUokRxytlvhCFlh2iXMMaxiCMvYtSsJo5+m+NmM8rV7OE8BP7k0N
 fRUKBy2dgIRsJaBSWvedSnilERCEzS+fU=
X-Gm-Gg: ASbGncsWic2M/TNlDEcaO56NcDKLpaOMz8Ah05JmVOnToXaYVW1byCU8Dgikb6BpOYj
 9Yk04XF5e91AYl2J2j1KnyY9jB69QBzZjRgS6KhOGXRNVR1br+P2ySLWfTuGfG75O5xxzvDCKKS
 VfTJJIUWIyTsA7UlVxhKMFQwU=
X-Received: by 2002:ad4:5ce1:0:b0:785:ec25:8fc2 with SMTP id
 6a1803df08f44-7e7198623b5mr69927256d6.58.1758701455368; 
 Wed, 24 Sep 2025 01:10:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERiM7x+12gyVLzPd4HwqdeherkV3XIzMc8MZvE1JUBdMrXLBzRFvg4xx6LenDSehvf3Tt/RqgtfTj/UTm33Is=
X-Received: by 2002:ad4:5ce1:0:b0:785:ec25:8fc2 with SMTP id
 6a1803df08f44-7e7198623b5mr69927066d6.58.1758701455036; Wed, 24 Sep 2025
 01:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250916122111.36019-1-f.ebner@proxmox.com>
In-Reply-To: <20250916122111.36019-1-f.ebner@proxmox.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 24 Sep 2025 11:10:43 +0300
X-Gm-Features: AS18NWAImA8tVujOkAiGmD4ZNy55qec0NfBYb8POP1rJgzYVaNs771A-0Inp72o
Message-ID: <CAPMcbCr+f-aCvwZKo5Ds+fWFtAWSUDw3jqXHqi2Fd0eC8OFkEQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/qemu-guest-agent/fsfreeze-hook: improve script
 description
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="0000000000007e71ac063f87978d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000007e71ac063f87978d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Best Regards,
Kostiantyn Kostiuk.


On Tue, Sep 16, 2025 at 3:22=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:

> With the current wording, users might think that the -F option is not
> required as long as the script is placed in the default path. Be clear
> that the option is always required. Also includes some minor language
> improvements in the rest of the comment.
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  scripts/qemu-guest-agent/fsfreeze-hook | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/qemu-guest-agent/fsfreeze-hook
> b/scripts/qemu-guest-agent/fsfreeze-hook
> index c1feb6f5ce..5b915af017 100755
> --- a/scripts/qemu-guest-agent/fsfreeze-hook
> +++ b/scripts/qemu-guest-agent/fsfreeze-hook
> @@ -1,11 +1,12 @@
>  #!/bin/sh
>
> -# This script is executed when a guest agent receives fsfreeze-freeze an=
d
> -# fsfreeze-thaw command, if it is specified in --fsfreeze-hook (-F)
> -# option of qemu-ga or placed in default path (/etc/qemu/fsfreeze-hook).
> -# When the agent receives fsfreeze-freeze request, this script is issued
> with
> -# "freeze" argument before the filesystem is frozen. And for fsfreeze-th=
aw
> -# request, it is issued with "thaw" argument after filesystem is thawed.
> +# This script is executed when the guest agent receives fsfreeze-freeze
> and
> +# fsfreeze-thaw commands, provided that the --fsfreeze-hook (-F) option =
of
> +# qemu-ga is specified and the script is placed in
> /etc/qemu/fsfreeze-hook or in
> +# the path specified together with -F. When the agent receives
> fsfreeze-freeze
> +# requests, this script is called with "freeze" as its argument before t=
he
> +# filesystem is frozen. And for fsfreeze-thaw requests, it is called wit=
h
> "thaw"
> +# as its argument after the filesystem is thawed.
>
>  LOGFILE=3D/var/log/qga-fsfreeze-hook.log
>  FSFREEZE_D=3D$(dirname -- "$0")/fsfreeze-hook.d
> --
> 2.47.2
>
>
>
>

--0000000000007e71ac063f87978d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto=
:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><d=
iv><br></div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div><div>Kostiant=
yn Kostiuk.</div></div></div></div><br></div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 16=
, 2025 at 3:22=E2=80=AFPM Fiona Ebner &lt;<a href=3D"mailto:f.ebner@proxmox=
.com">f.ebner@proxmox.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">With the current wording, users might think that t=
he -F option is not<br>
required as long as the script is placed in the default path. Be clear<br>
that the option is always required. Also includes some minor language<br>
improvements in the rest of the comment.<br>
<br>
Signed-off-by: Fiona Ebner &lt;<a href=3D"mailto:f.ebner@proxmox.com" targe=
t=3D"_blank">f.ebner@proxmox.com</a>&gt;<br>
---<br>
=C2=A0scripts/qemu-guest-agent/fsfreeze-hook | 13 +++++++------<br>
=C2=A01 file changed, 7 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-ag=
ent/fsfreeze-hook<br>
index c1feb6f5ce..5b915af017 100755<br>
--- a/scripts/qemu-guest-agent/fsfreeze-hook<br>
+++ b/scripts/qemu-guest-agent/fsfreeze-hook<br>
@@ -1,11 +1,12 @@<br>
=C2=A0#!/bin/sh<br>
<br>
-# This script is executed when a guest agent receives fsfreeze-freeze and<=
br>
-# fsfreeze-thaw command, if it is specified in --fsfreeze-hook (-F)<br>
-# option of qemu-ga or placed in default path (/etc/qemu/fsfreeze-hook).<b=
r>
-# When the agent receives fsfreeze-freeze request, this script is issued w=
ith<br>
-# &quot;freeze&quot; argument before the filesystem is frozen. And for fsf=
reeze-thaw<br>
-# request, it is issued with &quot;thaw&quot; argument after filesystem is=
 thawed.<br>
+# This script is executed when the guest agent receives fsfreeze-freeze an=
d<br>
+# fsfreeze-thaw commands, provided that the --fsfreeze-hook (-F) option of=
<br>
+# qemu-ga is specified and the script is placed in /etc/qemu/fsfreeze-hook=
 or in<br>
+# the path specified together with -F. When the agent receives fsfreeze-fr=
eeze<br>
+# requests, this script is called with &quot;freeze&quot; as its argument =
before the<br>
+# filesystem is frozen. And for fsfreeze-thaw requests, it is called with =
&quot;thaw&quot;<br>
+# as its argument after the filesystem is thawed.<br>
<br>
=C2=A0LOGFILE=3D/var/log/qga-fsfreeze-hook.log<br>
=C2=A0FSFREEZE_D=3D$(dirname -- &quot;$0&quot;)/fsfreeze-hook.d<br>
-- <br>
2.47.2<br>
<br>
<br>
<br>
</blockquote></div>

--0000000000007e71ac063f87978d--


