Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8D6CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 10:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umVf2-0007fX-8Z; Thu, 14 Aug 2025 06:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1umVes-0007dQ-IF
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 06:58:11 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1umVeo-0001iX-BK
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 06:58:10 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6188b6f501cso1002020a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 03:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755169068; x=1755773868; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ITxE2TXaGZcbSYOVjt2T07dKYtAjcnjsr/S2uUQup+Y=;
 b=gVgK3nNGh1Y6k00mcSScq2StwIWCu7ja5Bmjsr68kC/P4ErSpahQEOATXS9wLFgYCQ
 6Rpi3xnas9ORVnFC7L0CNUUqMat9FO2LXO40l+NAf0J5MOjmdjng+EMAtbBJBoe2Ia9k
 EGgMMP7qRT/PVuWeCCFi+qPoKVBjUtCpBvTH2GIfyIWqFoG+x0JNqUd/PheGX6HiR4K8
 C1ryrQxBBwTVOP8wdktZBMjY0jcU+mq63pf/icD6ovLFkjOGV75MwhUXdnOsodyt+YHw
 Z88ohY+6cgjU4tDunL+JHLOFHupPDT35pR9nMIfLthvIhkKavZ82I2WSzr/KAdzjDB7p
 S9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755169068; x=1755773868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ITxE2TXaGZcbSYOVjt2T07dKYtAjcnjsr/S2uUQup+Y=;
 b=AIWRF1ohCQwYH6/Vch0xQCqKC4h56C/CkGxW7zC0atualjoWiypJVYq0uj2xLgzKL8
 8zB30Cwv0tsbRgIouQrDbtGfVt6vIh0BArYJUVcHpLBBVwFQVZDM84mqVdNWBgNywtla
 s8j6wngTO3IdKH2FpgYojsvjhAbTsnHhFX6rcDb+AXlfdriAnNJD66ni0T8T74MPAgju
 szkqWamqkXh7ppXvwyobH/xm6qOXxxjzv6dsVbpNN/wmGCYoniQmpZ/U2VbtCWHW5mwR
 cE8qL7W6gMh2IW3fG5Z1Rwo+kGjtk4S5VHYf2o+tPhwzmE4kasHKQfC9V3RCxueiHVOx
 3iDA==
X-Gm-Message-State: AOJu0YybCLEogwmuwwf99u18KRKjc/Y7TPVe7rnj4sDbs+6U8qm+JvG1
 bVC8LptjhwyxylsblEq00Jd/70mQKDvWZyvTQcxOtftSx1BA8Yyyc97IBznKLYAbWZzDcrcf+ev
 Mj5vNbNLk7fHNBY//yEtVYpQMrgfjEZ0xO2Pk/vdB8g==
X-Gm-Gg: ASbGncsgICRmfUDJhLe9tHvYGbDRGmoyLJOM4rqsCt5OTYwLzKOb46MJSmrseTgrIv0
 ENyp/0x22WCSfvtrcPVtymt3TkX6CByO4cQHEiS8jjDLJBmO/h4IIgNj2PGJ9M0KQ8WcCxCvjrU
 mc4dPLeMzlZCHfJDN3n1yXjIJwkukDgx+BTUE4WwNZtFI6YAL4AlTV1rkyc7szK1CyzVlZ5K/Ud
 QjMpAG1zoPhYWYuuOph+JWRF8eol1DZophctq3T
X-Google-Smtp-Source: AGHT+IEgJIImds6IUBreSn6viiGLE0J+RaXHFn5bjYqcoABLT0wCY7CwnSVDN3ZbF/xl6LtEWOWvKb5jcTK3pZqU/8Y=
X-Received: by 2002:a05:6402:3899:b0:618:534:550a with SMTP id
 4fb4d7f45d1cf-6188ba072ecmr2219552a12.24.1755169067641; Thu, 14 Aug 2025
 03:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250814105236.13344-1-gerben@altlinux.org>
In-Reply-To: <20250814105236.13344-1-gerben@altlinux.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 14 Aug 2025 13:57:35 +0300
X-Gm-Features: Ac12FXzpU2bbfA1mZBaq2eAr7qoY64ZGU_Yv0weIRIPo6M1rPRS8dmMJAsuvcEk
Message-ID: <CAAjaMXY=d6yKhG2yjEZxaGPCyQ6g7wUBVq2LYTrnWvWrLXZzmw@mail.gmail.com>
Subject: Re: [PATCH] linux-user: prevent NULL dereference in
 do_sendrecvmsg_locked()
To: gerben@altlinux.org
Cc: "open list:ARM SMMU <qemu-arm@nongnu.org>, " <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, sdl.qemu@linuxtesting.org
Content-Type: multipart/alternative; boundary="000000000000cc480c063c5124e3"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000cc480c063c5124e3
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025, 13:53 , <gerben@altlinux.org> wrote:

> From: Denis Rastyogin <gerben@altlinux.org>
>
> fd_trans_target_to_host_data() in do_sendrecvmsg_locked() may be
> called when msg.msg_iov is NULL, for example when sending with
> MSG_MORE and no actual iovec data is present. Dereferencing
> msg.msg_iov in this case would lead to a NULL pointer access.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Reported-by: Alexey Appolonov <alexey@altlinux.org>
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>  linux-user/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 59b2080b98..c7e6c53f08 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3300,7 +3300,7 @@ static abi_long do_sendrecvmsg_locked(int fd, struct
> target_msghdr *msgp,
>      msg.msg_iov = vec;
>
>      if (send) {
> -        if (fd_trans_target_to_host_data(fd)) {
> +        if (fd_trans_target_to_host_data(fd) && msg.msg_iov->iov_len) {
>

Surely you meant ` && msg.msg_iov` instead of dereferencing the iov_len
field? According to the commit message.

             void *host_msg;
>
>              host_msg = g_malloc(msg.msg_iov->iov_len);
> --
> 2.42.2
>
>
>

--000000000000cc480c063c5124e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 14 Aug 2025, 13:53 , &lt=
;<a href=3D"mailto:gerben@altlinux.org">gerben@altlinux.org</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Denis Rast=
yogin &lt;<a href=3D"mailto:gerben@altlinux.org" target=3D"_blank" rel=3D"n=
oreferrer">gerben@altlinux.org</a>&gt;<br>
<br>
fd_trans_target_to_host_data() in do_sendrecvmsg_locked() may be<br>
called when msg.msg_iov is NULL, for example when sending with<br>
MSG_MORE and no actual iovec data is present. Dereferencing<br>
msg.msg_iov in this case would lead to a NULL pointer access.<br>
<br>
Found by Linux Verification Center (<a href=3D"http://linuxtesting.org" rel=
=3D"noreferrer noreferrer" target=3D"_blank">linuxtesting.org</a>) with SVA=
CE.<br>
<br>
Reported-by: Alexey Appolonov &lt;<a href=3D"mailto:alexey@altlinux.org" ta=
rget=3D"_blank" rel=3D"noreferrer">alexey@altlinux.org</a>&gt;<br>
Signed-off-by: Denis Rastyogin &lt;<a href=3D"mailto:gerben@altlinux.org" t=
arget=3D"_blank" rel=3D"noreferrer">gerben@altlinux.org</a>&gt;<br>
---<br>
=C2=A0linux-user/syscall.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
index 59b2080b98..c7e6c53f08 100644<br>
--- a/linux-user/syscall.c<br>
+++ b/linux-user/syscall.c<br>
@@ -3300,7 +3300,7 @@ static abi_long do_sendrecvmsg_locked(int fd, struct =
target_msghdr *msgp,<br>
=C2=A0 =C2=A0 =C2=A0msg.msg_iov =3D vec;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (send) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd_trans_target_to_host_data(fd)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd_trans_target_to_host_data(fd) &amp;&amp=
; msg.msg_iov-&gt;iov_len) {<br></blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Surely you meant ` &amp;&amp; msg.msg_iov` inst=
ead of dereferencing the iov_len field? According to the commit message.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote =
gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *host_msg;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host_msg =3D g_malloc(msg.m=
sg_iov-&gt;iov_len);<br>
-- <br>
2.42.2<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000cc480c063c5124e3--

