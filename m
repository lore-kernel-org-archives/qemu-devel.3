Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA9FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 11:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seCaN-0006yd-Ix; Wed, 14 Aug 2024 07:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1seCaL-0006y7-UU
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 07:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1seCaJ-00030z-Ir
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 07:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723636473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x+PAFk7vUGr4hK6CLgZFb4PyqJIqsXhixW2vNZQBtmk=;
 b=Z68F2FRTIKLaIRyC6o7/9upOqtM3Zr68lYuV/nqKfIdpL9Bl7cSK1mCGRQXHPskeZjXzNy
 rt+4JrBvVbNCy2ccNxhIfiLsNdbG0qd4mWND8xg4KlULK0bbDi/ozQRrRwnLNg7/U1tm9f
 GIEmUlGxqVF1Z2eZt97kgkwndHoFs8A=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-PEGruH0dNAWZLqWP-LJKPQ-1; Wed, 14 Aug 2024 07:54:31 -0400
X-MC-Unique: PEGruH0dNAWZLqWP-LJKPQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-66628e9ec89so139872627b3.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 04:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723636471; x=1724241271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x+PAFk7vUGr4hK6CLgZFb4PyqJIqsXhixW2vNZQBtmk=;
 b=rxRkjEnfjEhnXkU42F+leqmUZhHaqZwF6QadPt9rKB05Gf94neF4KhFR6ZgGlBGLmW
 a7mZny6Xoo483qX7cV0zqyeuTyVklM5SjSsIX1rHD/SeYBMXKGZWW6jFU2QwM/jPFPc2
 ZFL5/VYlojMVnY1Svu2SFxTlRa7+f90DdpQNU1QAcbduBWQ+N94L7YqVeed8GE+pN+Dt
 HQ6RgiEbiYFZ8s6olpbmBSLY1heRldwE8/65f7FKbHopwSxkRalNvEKkrRsfxji0YJr/
 DaPQkCym/vpfIXIktwWfQqouXLm2Bc1ppfQekxFFqSuK4Hu28RYp4DrDUfQea3YlAo5c
 ulYg==
X-Gm-Message-State: AOJu0YyAbRvlKGB4+vzlJYmn57LrUum0os5B9pLnonLTLrJpcAdA6mUZ
 7lKfNWxiXKYR9/mmNYtLyOTgv2KEGFGtmADnjAEfjODpQqilY0Ug+RM5iy8M3FeGUHDN6zhfoZc
 e1LnSN+prrZglT2KG9mYt8DnXkAtIcbNX7LO+T2mobLFz/HJU3xxT4Zaa1j3W2FRP/AdGMfgbYR
 jHW626PYKmH94sIS+wemJkXr2hThw=
X-Received: by 2002:a05:6902:2186:b0:e0e:89f8:4f8a with SMTP id
 3f1490d57ef6-e1155ab12ffmr2562178276.23.1723636471159; 
 Wed, 14 Aug 2024 04:54:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOwxr8jljjDDrOrhvfn2iyXZOiOhRXTv9ksCzFnYTth+ldM4rJNfa7F79/csGpehPKqV7ALEq39nXHhy6kbmY=
X-Received: by 2002:a05:6902:2186:b0:e0e:89f8:4f8a with SMTP id
 3f1490d57ef6-e1155ab12ffmr2562170276.23.1723636470856; Wed, 14 Aug 2024
 04:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240813031115.129000-1-demeng@redhat.com>
In-Reply-To: <20240813031115.129000-1-demeng@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 14 Aug 2024 14:54:19 +0300
Message-ID: <CAPMcbCpcQ76EeLxDkAwn6jRQjPEbHzz9QMNDNiX54r+kqxo5Vg@mail.gmail.com>
Subject: Re: [PATCH] qemu-guest-agent: Update the logfile path of
 qga-fsfreeze-hook.log
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, mrezanin@redhat.com
Content-Type: multipart/alternative; boundary="000000000000915ef3061fa363eb"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
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

--000000000000915ef3061fa363eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This bug looks specific to the RedHat SELinux configuration.
Is this any reason to move LOGFILE except this?

Best Regards,
Konstantin Kostiuk.


On Tue, Aug 13, 2024 at 6:11=E2=80=AFAM Dehan Meng <demeng@redhat.com> wrot=
e:

> Since '/var/log/qga-fsfreeze-hook.log' is not included to proper
> selinux context 'system_u:object_r:virt_qemu_ga_log_t:s0', it
> should be changed to '/var/log/qemu-ga/qga-fsfreeze-hook.log'
>
> Jira: https://issues.redhat.com/browse/RHEL-52250
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> ---
>  scripts/qemu-guest-agent/fsfreeze-hook | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qemu-guest-agent/fsfreeze-hook
> b/scripts/qemu-guest-agent/fsfreeze-hook
> index 13aafd4845..98aad5e18b 100755
> --- a/scripts/qemu-guest-agent/fsfreeze-hook
> +++ b/scripts/qemu-guest-agent/fsfreeze-hook
> @@ -7,7 +7,7 @@
>  # "freeze" argument before the filesystem is frozen. And for fsfreeze-th=
aw
>  # request, it is issued with "thaw" argument after filesystem is thawed.
>
> -LOGFILE=3D/var/log/qga-fsfreeze-hook.log
> +LOGFILE=3D/var/log/qemu-ga/qga-fsfreeze-hook.log
>  FSFREEZE_D=3D$(dirname -- "$0")/fsfreeze-hook.d
>
>  # Check whether file $1 is a backup or rpm-generated file and should be
> ignored
> --
> 2.40.1
>
>

--000000000000915ef3061fa363eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This bug looks specific to the RedHat SELinux configu=
ration.</div><div>Is this any reason to move LOGFILE except this?<br></div>=
<div><br></div><div><div><div dir=3D"ltr" class=3D"gmail_signature" data-sm=
artmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div><div>K=
onstantin Kostiuk.</div></div></div></div><br></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 13, 2024 at=
 6:11=E2=80=AFAM Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com">demeng=
@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Since &#39;/var/log/qga-fsfreeze-hook.log&#39; is not included t=
o proper<br>
selinux context &#39;system_u:object_r:virt_qemu_ga_log_t:s0&#39;, it<br>
should be changed to &#39;/var/log/qemu-ga/qga-fsfreeze-hook.log&#39;<br>
<br>
Jira: <a href=3D"https://issues.redhat.com/browse/RHEL-52250" rel=3D"norefe=
rrer" target=3D"_blank">https://issues.redhat.com/browse/RHEL-52250</a><br>
Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" target=
=3D"_blank">demeng@redhat.com</a>&gt;<br>
---<br>
=C2=A0scripts/qemu-guest-agent/fsfreeze-hook | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-ag=
ent/fsfreeze-hook<br>
index 13aafd4845..98aad5e18b 100755<br>
--- a/scripts/qemu-guest-agent/fsfreeze-hook<br>
+++ b/scripts/qemu-guest-agent/fsfreeze-hook<br>
@@ -7,7 +7,7 @@<br>
=C2=A0# &quot;freeze&quot; argument before the filesystem is frozen. And fo=
r fsfreeze-thaw<br>
=C2=A0# request, it is issued with &quot;thaw&quot; argument after filesyst=
em is thawed.<br>
<br>
-LOGFILE=3D/var/log/qga-fsfreeze-hook.log<br>
+LOGFILE=3D/var/log/qemu-ga/qga-fsfreeze-hook.log<br>
=C2=A0FSFREEZE_D=3D$(dirname -- &quot;$0&quot;)/fsfreeze-hook.d<br>
<br>
=C2=A0# Check whether file $1 is a backup or rpm-generated file and should =
be ignored<br>
-- <br>
2.40.1<br>
<br>
</blockquote></div>

--000000000000915ef3061fa363eb--


