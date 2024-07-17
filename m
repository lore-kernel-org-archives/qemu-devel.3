Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2E8C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 07:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTzPV-0002hY-B4; Wed, 17 Jul 2024 03:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bfu@redhat.com>) id 1sTzPR-0002Xu-BT
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 03:49:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bfu@redhat.com>) id 1sTzPP-0000gc-Km
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 03:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721202546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AmXSq1VyzXmT+g0rrlHtxKtJQ3Af5Imo9iPkzwdnSn4=;
 b=JykYHYChCZ5qD1KenBG4aMKezXZ2H4HGWfXbrxR29WPR+L1W6e3/wXEfvOfmld5DnTe8e7
 H18TJdUCLYFiM+V+J1El7g5Q0LUBQlJv0BY3PoGRryTKUhi5eIMBbHoVAY2KYPUJOUqgBG
 LuOM/M5v8OOpPl3DYGjz47omZ4mw2O0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-ncRdsZ15ODGw8E4xkH7a8A-1; Wed, 17 Jul 2024 03:49:04 -0400
X-MC-Unique: ncRdsZ15ODGw8E4xkH7a8A-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1fc2d78e911so22360375ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 00:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721202543; x=1721807343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AmXSq1VyzXmT+g0rrlHtxKtJQ3Af5Imo9iPkzwdnSn4=;
 b=lmBliqYn1NEE3rhYXG7mMouw6ZV2cbfRLWUaAIEyUYFF85+4tKZ9AeIqEDCRnkRTb7
 wIDD3lBFTk8CvccN1HFxxwZm5Dq15FOfjVuJxCHR2NXv+b+yk/upywjwPJXHNpDNobb4
 eZQI0fms90LzJV8eLX3ojym79qG+GKIvwqMkKG/m6lArS8yy2v5bprGr6GWmAgH7dVVh
 oQZ6NE08d0XCJG0F+ubOrt89dxMCFRCCKOjdW14/DqZsj7elMII9DePCrRxkor1V4+F1
 pCQGO0O4ZusZks042BB89j4SI3xYkJ6sT4IsMZgi3RXXNpZ8Lp5VFOG/3cfsOp2aBQ6W
 Rc6w==
X-Gm-Message-State: AOJu0YzD+vIdzlP0nvaKgrIdSz0b3i+5x9/qbCfkQSsq94yFPqRzdx1b
 VqzP4fq99j0kY5Omai20+eu4gNYHeusNp7A7hJuLtv7BQrVgdmc7ascNNKg8FVbqvHrinx1w7kJ
 pLtVt6H70tF7LDQtU06+tzAgH81I1PIAr4r6ZXUuNS4qAw8dbMLvF8f4zcf4sJU68SHYd63xInP
 4+JfmsldjLXg5fLzO0pLhmBUyHp+E=
X-Received: by 2002:a05:6a21:33a5:b0:1c3:b1b2:ce17 with SMTP id
 adf61e73a8af0-1c3fdd97d8bmr1117882637.48.1721202542934; 
 Wed, 17 Jul 2024 00:49:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs8VR/R8qseaB1PAMotB/yoFGS5kKedt5tleUik+Pd0XiLWBNOOvRnyo5tPJkwKQdcpeov85EFJk5HrGyPm7k=
X-Received: by 2002:a05:6a21:33a5:b0:1c3:b1b2:ce17 with SMTP id
 adf61e73a8af0-1c3fdd97d8bmr1117872637.48.1721202542614; Wed, 17 Jul 2024
 00:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFRHJ6J9uMk+HMZL+W+KE1yoRCOLPgbPUVVDku55sdXYiGXXHg@mail.gmail.com>
 <20240716090008.187506-2-pbonzini@redhat.com>
In-Reply-To: <20240716090008.187506-2-pbonzini@redhat.com>
From: Boqiao Fu <bfu@redhat.com>
Date: Wed, 17 Jul 2024 15:48:51 +0800
Message-ID: <CAFRHJ6L3ENDB2wLvtgQ5kFV=Lpjf-dgXkTeTQODd+0kyH-tF-g@mail.gmail.com>
Subject: Re: [PATCH] Manpage: Update description of 'user=username' for
 '-run-with'
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000023aeb0061d6cb2b0"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=bfu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000023aeb0061d6cb2b0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

thanks for your helping

Best,
Boqiao

On Tue, Jul 16, 2024 at 5:00=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:

> > Manpage: the description of '-runs' didn't show this parameter will use
> > setuid, so the customer might get confused when 'elevateprivileges=3Dde=
ny'
> is
> > used. Since '-runas' is going to be deprecated and replaced by this
> > parameter in the coming qemu9.1, add the message here.
>
> Queued, thanks.  I modified the patch a bit to explain how setgid and
> setgroups are used in addition to setuid:
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ad6521ef5e7..694fa37f284 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5024,8 +5024,11 @@ SRST
>      in combination with -runas.
>
>      ``user=3Dusername`` or ``user=3Duid:gid`` can be used to drop root
> privileges
> -    by switching to the specified user (via username) or user and group
> -    (via uid:gid) immediately before starting guest execution.
> +    before starting guest execution. QEMU will use the ``setuid`` and
> ``setgid``
> +    system calls to switch to the specified identity.  Note that the
> +    ``user=3Dusername`` syntax will also apply the full set of supplemen=
tary
> +    groups for the user, whereas the ``user=3Duid:gid`` will use only th=
e
> +    ``gid`` group.
>
> Paolo
>
>

--00000000000023aeb0061d6cb2b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">thanks for your helping<div><br></div><div>Best,</div><div=
>Boqiao</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Tue, Jul 16, 2024 at 5:00=E2=80=AFPM Paolo Bonzini &lt;<a h=
ref=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; Manpage: the des=
cription of &#39;-runs&#39; didn&#39;t show this parameter will use<br>
&gt; setuid, so the customer might get confused when &#39;elevateprivileges=
=3Ddeny&#39; is<br>
&gt; used. Since &#39;-runas&#39; is going to be deprecated and replaced by=
 this<br>
&gt; parameter in the coming qemu9.1, add the message here.<br>
<br>
Queued, thanks.=C2=A0 I modified the patch a bit to explain how setgid and<=
br>
setgroups are used in addition to setuid:<br>
<br>
diff --git a/qemu-options.hx b/qemu-options.hx<br>
index ad6521ef5e7..694fa37f284 100644<br>
--- a/qemu-options.hx<br>
+++ b/qemu-options.hx<br>
@@ -5024,8 +5024,11 @@ SRST<br>
=C2=A0 =C2=A0 =C2=A0in combination with -runas.<br>
<br>
=C2=A0 =C2=A0 =C2=A0``user=3Dusername`` or ``user=3Duid:gid`` can be used t=
o drop root privileges<br>
-=C2=A0 =C2=A0 by switching to the specified user (via username) or user an=
d group<br>
-=C2=A0 =C2=A0 (via uid:gid) immediately before starting guest execution.<b=
r>
+=C2=A0 =C2=A0 before starting guest execution. QEMU will use the ``setuid`=
` and ``setgid``<br>
+=C2=A0 =C2=A0 system calls to switch to the specified identity.=C2=A0 Note=
 that the<br>
+=C2=A0 =C2=A0 ``user=3Dusername`` syntax will also apply the full set of s=
upplementary<br>
+=C2=A0 =C2=A0 groups for the user, whereas the ``user=3Duid:gid`` will use=
 only the<br>
+=C2=A0 =C2=A0 ``gid`` group.<br>
<br>
Paolo<br>
<br>
</blockquote></div>

--00000000000023aeb0061d6cb2b0--


