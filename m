Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB469C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 14:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGfZx-0006VG-Mw; Mon, 10 Jun 2024 10:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sGfZr-0006RA-Ea
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:00:52 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sGfZo-0000JN-JX
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:00:51 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-62a087bc74bso44890447b3.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1718028034; x=1718632834;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3iDAGAD9uHPDQKbKYJkiat/5ywqRbRsQV32/MRO+/Ls=;
 b=SKxdtXTUoRmSt9tEqrRR+0uoAvxaglTKAagZ9wIrVc9ZQ8JJn6hPnasT9UA1GHwwCP
 7qxYEZyAABSDXb20176bHx98PRZpnWmfr8VKSk0Ya+DaodimNW6rn8WsYU8OoxNwwPY7
 ceCH7zgwB8UsMPRQ4QLVbbjoYen5JF2mgY6zEimD6n51W3Y70jdO+shbVAY/uwLysICZ
 iWxdP1/kXlz/ERY1RN2/Bi98/N6xNSCeuIKwd6I76Mj8dYscYA2vCIUxrypbPYsFAvXB
 OE4MMc1TD21BjvDaoY3wdbhamLI2neq8WM87SFF1azMunrbkU1ZhtsVxoHB/XRflo9Od
 +0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718028034; x=1718632834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3iDAGAD9uHPDQKbKYJkiat/5ywqRbRsQV32/MRO+/Ls=;
 b=ef5JvqDUloZY2mb0lsiuVq6Q0jNgwt5S3VLQmf53EdfPmsiekQugzD8TlDeKqM/LPb
 aimSvm3IDqrdpW68rPsqt3YyeJgq7BRkQSCy44228KhGpdzU2BlrvcL8Npzofbs8wmf8
 ZyKCeXRGnas6u/h5Dc9MFNm0q/v06nPysd9oJz++wVvbBNeT+pxXGM/Ufp96RJJq0Cg/
 WmEdZpej/XKA6xvhyKk0Rfs8LoQmJxVDKE3/9RcYrzuBZv7P2o4rup8t8QtPRPq8E4A6
 3qQ+2ayK+d0GJfinf2/iC64qrnVSAnwS9OxZQnIP1+rDXT5+gxnmbLkgV/oKc1hKDBLV
 B6Cg==
X-Gm-Message-State: AOJu0YwiHK22GH8KBrEENABf+CZodSP2J+D/RWVxwTGAxo8VvFKKDB34
 UbEQ+WU5A7/5zScIp72C7cf/Wz+Z4iEA/61hygtKx9dZvv0tfNoQ+rm7zUyVfziaSghTztfalAQ
 C+JrAxl8Z+RlYdl1Tb86qjIrkKWVu7n/XiMy6
X-Google-Smtp-Source: AGHT+IG+Ts34Qauk3aNj8OOEyaKRABlxMv8Jz5u/CvcpMEe4mSiRBpjnDAkXfrRaLqb0B50+i1EraGwvUfCHUhcsZIM=
X-Received: by 2002:a25:84d1:0:b0:dc2:5553:ca12 with SMTP id
 3f1490d57ef6-dfaf65c5222mr7723726276.14.1718028033652; Mon, 10 Jun 2024
 07:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240608202045.2815-1-phil@philjordan.eu>
 <20240608202045.2815-4-phil@philjordan.eu>
 <dd047370-f0ed-4b8c-a251-037e82f64986@daynix.com>
In-Reply-To: <dd047370-f0ed-4b8c-a251-037e82f64986@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 10 Jun 2024 16:00:21 +0200
Message-ID: <CAAibmn2-JApae_MFX+Wy8MuzkCLuE7DbgmgVOko3f7WzZGoozQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ui/cocoa: Adds support for mouse cursors
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org, 
 marcandre.lureau@redhat.com
Content-Type: multipart/alternative; boundary="000000000000a91417061a899275"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::112b;
 envelope-from=phil@philjordan.eu; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--000000000000a91417061a899275
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Jun 2024 at 11:06, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> Thanks for working on ui/cocoa, but I already have submitted a patch for
> this particular problem:
> https://patchew.org/QEMU/20240318-cursor-v1-0-0bbe6c382217@daynix.com/
>

Sorry, I missed this patch set - thanks for bringing it to my attention.


> The difference between these patches is that my patch does not use
> warping at all. I thought reversing the mouse movement bias is a fragile
> approach that depends on the details of how Quartz works.
>

Hmm. So, I agree that the relative cursor implementation with NSCursor is
somewhat awkward. I'm not sure it's as fragile as you make out as the
behaviour of the APIs used hasn't changed in decades and has plenty of
existing software depending on it. Still, it might behave awkwardly in the
context of other apps warping the cursor at the same time. I also
definitely think host cursor integration is useful and valuable, at least
in absolute pointing mode - for example, when the host system is itself
being remote controlled, and also to avoid the cursor being cropped near
the edges of the guest viewport.

The CALayer based rendering makes sense to me in relative mode though. For
one, it avoids the complicated event offsets. The cursor cropping actually
makes sense as a visual cue when the cursor is actually constrained to the
guest viewport while mouse input is grabbed. And because the guest cursor
is decoupled from the host cursor even after ungrabbing, it makes sense to
continue rendering it even when Qemu has relinquished the host cursor.

I've therefore reworked my NSCursor code on top of your CALayer cursor and
change notifier work so that the NSCursor is visible and updated with the
guest's cursor image when in absolute mode, and the CALayer draws the
cursor in relative mode. Because of the chain of patch dependencies I've
staged it on gitlab here for initial feedback/testing/review:
https://gitlab.com/pmdj/qemu-upstreaming/-/compare/master...m-cocoa-cursors-2.0?from_project_id=53960510&straight=false

Let me know what you think. If we decide to go with this approach we can
post our respective patches as a combined v2 patchset to the list.

Incidentally, that version of my NSCursor patch includes a few
refinements/fixes to the CALayer patch which I'll tease out into a separate
commit, and which I'd recommend applying even if consensus settles on a
CALayer-only approach. (setCursor: was rather long and messy; it also
leaked a colour space object; layer and cursor objects would leak if the
view was hypothetically dealloc'd)

Thanks,
Phil

--000000000000a91417061a899275
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, 9 Jun 2024 at 11:06, Akihi=
ko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blank">=
akihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
Thanks for working on ui/cocoa, but I already have submitted a patch for <b=
r>
this particular problem:<br>
<a href=3D"https://patchew.org/QEMU/20240318-cursor-v1-0-0bbe6c382217@dayni=
x.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU/20240=
318-cursor-v1-0-0bbe6c382217@daynix.com/</a><br></blockquote><div><br></div=
><div>Sorry, I missed this patch set - thanks for bringing it to my attenti=
on. <br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
The difference between these patches is that my patch does not use <br>
warping at all. I thought reversing the mouse movement bias is a fragile <b=
r>
approach that depends on the details of how Quartz works.<br></blockquote><=
div><br></div><div>Hmm. So, I agree that the relative cursor implementation=
 with NSCursor is somewhat awkward. I&#39;m not sure it&#39;s as fragile as=
 you make out as the behaviour of the APIs used hasn&#39;t changed in decad=
es and has plenty of existing software depending on it. Still, it might beh=
ave awkwardly in the context of other apps warping the cursor at the same t=
ime. I also definitely  think host cursor integration is useful and valuabl=
e, at least in absolute pointing mode - for example, when the host system i=
s itself being remote controlled, and also to avoid the cursor being croppe=
d near the edges of the guest viewport.</div><div><br></div><div>The CALaye=
r based rendering makes sense to me in relative mode though. For one, it av=
oids the complicated event offsets. The cursor cropping actually makes sens=
e as a visual cue when the cursor is actually constrained to the guest view=
port while mouse input is grabbed. And because the guest cursor is decouple=
d from the host cursor even after ungrabbing, it makes sense to continue re=
ndering it even when Qemu has relinquished the host cursor.</div><div><br><=
/div><div>I&#39;ve therefore reworked my NSCursor code on top of your CALay=
er  cursor and change notifier work so that the NSCursor is visible and upd=
ated with the guest&#39;s cursor image when in absolute mode, and the CALay=
er draws the cursor in relative mode. Because of the chain of patch depende=
ncies I&#39;ve staged it on gitlab here for initial feedback/testing/review=
:<br></div><div><a href=3D"https://gitlab.com/pmdj/qemu-upstreaming/-/compa=
re/master...m-cocoa-cursors-2.0?from_project_id=3D53960510&amp;straight=3Df=
alse" target=3D"_blank">https://gitlab.com/pmdj/qemu-upstreaming/-/compare/=
master...m-cocoa-cursors-2.0?from_project_id=3D53960510&amp;straight=3Dfals=
e</a></div><div><br></div><div>Let me know what you think. If we decide to =
go with this approach we can post our respective patches as a combined v2 p=
atchset to the list.<br></div><div><br></div><div>Incidentally, that versio=
n of my NSCursor patch includes a few refinements/fixes to the CALayer patc=
h which I&#39;ll tease out into a separate commit, and which I&#39;d recomm=
end applying even if consensus settles on a CALayer-only approach.  (setCur=
sor: was rather long and messy; it also leaked a colour space object; layer=
 and cursor objects would leak if the view was hypothetically dealloc&#39;d=
)</div><div><br></div><div>Thanks,</div><div>Phil</div><div><br></div><div>=
<br></div></div></div></div></div>

--000000000000a91417061a899275--

