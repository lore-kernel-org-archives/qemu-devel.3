Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54907C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 19:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAw8c-00060E-1r; Fri, 02 May 2025 15:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAw7m-0005ph-5W
 for qemu-devel@nongnu.org; Fri, 02 May 2025 15:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAw7i-0002KY-I2
 for qemu-devel@nongnu.org; Fri, 02 May 2025 15:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746214356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aJn/IMAA64lRQJNAaAgSS6RxluD261uncLmmmuJY8Y8=;
 b=Ei5z2Hf6stwTjNlVc2tbXue/3y/6fDknjf0L9qSZAT3cgEuy8z+st5HKJBdGkQsCKdM/9j
 ZbGGOjkeyrdDLU7ezqqdKJksbo2x/wRWn/Xc6toFP9nz4pjIbACH87GXLp6QCWAHWHqNSL
 OINIK3gxQsanTGhu9m3afNRr0qMSmjc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-nbXQlvIZMsyqUtW-bv01VA-1; Fri, 02 May 2025 15:32:35 -0400
X-MC-Unique: nbXQlvIZMsyqUtW-bv01VA-1
X-Mimecast-MFC-AGG-ID: nbXQlvIZMsyqUtW-bv01VA_1746214354
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39c184b20a2so848423f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 12:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746214354; x=1746819154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aJn/IMAA64lRQJNAaAgSS6RxluD261uncLmmmuJY8Y8=;
 b=qZeDBLI6ZGjIXBuOfvEGW1XZN0dFpaKwFtoT7JH32mJ/XvC57ou2bFpa6SJPiXAWWh
 aQFVBajmm4OEWYf3/8qexN19S9CBIK5Ms6MG1LmgfkwH0ZdtHHbkSbrb4eHEBlNa6Rt6
 C8yV7aDwTxEbxkI+Xyf90PXUgpmPyGt3aHRP4trl4xqtX5DBnvl9JutBq25GeSIgCV9E
 5afxAVpvEwi8AuQeP/Jvw9UnPUwnHMYV/CcOgidXMLHysikANucVYBl7NsobvmSaS9mj
 gEe5VHcT4UlJ2Rkk9roEINlfqH8+hh+JNCJs9ha/QshFo7uFbxTaz99xDyL8nhoiyrgI
 azkg==
X-Gm-Message-State: AOJu0Yz/Ie8UvR6PCkD/W5m2bGttAgpUx+F+/2BQp5Ct2fH+rPmgAYJl
 WSNY6Jp0fYeYO7yNdNFttOW+ZLj/uI6nE4DeS2HG6p9gP0BZ3Ezgmgkzrz5XAZtrE3m6hQkC7M3
 CCjY1hRQ+zH1tMkEq12v2zj+NjN6XkOWNaBUHdcCDiSMgj1f+4o/5kqgmtqGGzWFSBaRJnFknlc
 PTwZUWI5DNBuogf5McpqSoTi7esKo=
X-Gm-Gg: ASbGncveEfQ2JthOaS7Sn97y/qpj4u+PBVgmWMgEYjillb1kP+jzspjik6XMCI18oRN
 Q3ZKiE+yNU6IGaUQBLpmuVKJ8L4fhqj7RtHsTLW7RoHagMRd3lulz8DlKxXzbSeHzGBNv
X-Received: by 2002:a05:6000:2585:b0:38d:dd52:1b5d with SMTP id
 ffacd0b85a97d-3a099ad272fmr2963423f8f.4.1746214354222; 
 Fri, 02 May 2025 12:32:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqWrUPchaY0wlo/GwRAo/qLzg99mLzxKsNh4pYq2LrykFLTOrkDSMuszc0WkMBF1MbXhbWSeE3Q3+EI1FE/L0=
X-Received: by 2002:a05:6000:2585:b0:38d:dd52:1b5d with SMTP id
 ffacd0b85a97d-3a099ad272fmr2963411f8f.4.1746214353898; Fri, 02 May 2025
 12:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250502102323.104815-1-pbonzini@redhat.com>
 <20250502102323.104815-9-pbonzini@redhat.com>
 <d6b894fd-ed66-4c04-9ff4-732fdace6256@zabka.it>
In-Reply-To: <d6b894fd-ed66-4c04-9ff4-732fdace6256@zabka.it>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 2 May 2025 21:32:24 +0200
X-Gm-Features: ATxdqUGvPryuBjoHRlDCjKJlQCOqHnqndTndyHWrJQ_9vK3doTUR-mxCzJbC610
Message-ID: <CABgObfZb-a4T75=nqVGgOQugfqEAZpD-L1ohuJp7zoXSYbk6jA@mail.gmail.com>
Subject: Re: [PATCH 8/9] rust: enable clippy::ptr_cast_constness
To: Stefan Zabka <git@zabka.it>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000044232606342c366f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000044232606342c366f
Content-Type: text/plain; charset="UTF-8"

Il ven 2 mag 2025, 20:58 Stefan Zabka <git@zabka.it> ha scritto:

> Unrelated to the actual change, but a drive-by observation:
> If you want to keep the MSRV in sync across all workspace members, you
> could use workspace.package.rust-version to define it once and inherit
> it everywhere. (Same goes for edition, license, and resolver.)
>
> https://doc.rust-lang.org/cargo/reference/workspaces.html#the-package-table
>
> I'd like to provide a patch instead of just heckling, but I have a
> couple of questions:
>
> 1. Is this actually desired behaviour, or might you want different
> values for these fields?
>

Yes, it is.

2. Should I implement this against qemu-project/qemu master branch or is
> there a dedicated Rust tree?
>

Sure, go ahead! I will rebase on top, since I have to resend anyway.

Paolo

3. Should I wait with that until your change is landed so we don't conflict?
>
> Best
> Stefan
>
>

--00000000000044232606342c366f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 2 mag 2025, 20:58 Stefan =
Zabka &lt;<a href=3D"mailto:git@zabka.it">git@zabka.it</a>&gt; ha scritto:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Unrelated to the=
 actual change, but a drive-by observation:<br>
If you want to keep the MSRV in sync across all workspace members, you <br>
could use workspace.package.rust-version to define it once and inherit <br>
it everywhere. (Same goes for edition, license, and resolver.)<br>
<br>
<a href=3D"https://doc.rust-lang.org/cargo/reference/workspaces.html#the-pa=
ckage-table" rel=3D"noreferrer noreferrer" target=3D"_blank">https://doc.ru=
st-lang.org/cargo/reference/workspaces.html#the-package-table</a><br>
<br>
I&#39;d like to provide a patch instead of just heckling, but I have a <br>
couple of questions:<br>
<br>
1. Is this actually desired behaviour, or might you want different <br>
values for these fields?<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Yes, it is.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
2. Should I implement this against qemu-project/qemu master branch or is <b=
r>
there a dedicated Rust tree?<br></blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Sure, go ahead! I will rebase on top, since I h=
ave to resend anyway.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Pa=
olo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
3. Should I wait with that until your change is landed so we don&#39;t conf=
lict?<br>
<br>
Best<br>
Stefan<br>
<br>
</blockquote></div></div></div>

--00000000000044232606342c366f--


