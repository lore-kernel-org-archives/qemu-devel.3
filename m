Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A5FC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 06:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toGYV-0004py-Re; Sat, 01 Mar 2025 01:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hikalium@hikalium.com>)
 id 1toGYU-0004pm-4S
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 01:42:34 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hikalium@hikalium.com>)
 id 1toGYS-0004Ct-Em
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 01:42:33 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so4477028a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 22:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hikalium-com.20230601.gappssmtp.com; s=20230601; t=1740811350; x=1741416150;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wOhsnhWcp/oB0H9OkHn8hUNSLjLyQJMmKpGtcq3Zsjo=;
 b=BcmtlOavrPiofoynlZomEf27GbJiDPAmc6YepMgArs/aiSXu8V4fSG7P1K3ML/5kat
 WgybSSIdJC5eMD3OvpsEG2hm6Aau3HTV4OXJfK9YRTNIdRzeEB8p3tzoqaxMa8thaUz9
 7JN18qQVk2D9bMcILzKb9GNcfwOEeg0ROlGlN14QlsJeuRm6Z9+K/HG1MzNL9Pu9NZ2Z
 xpsW/7e8ZXltzk9ztL/CFq+yY0mZHP3NKYfRh7J0U9/KOnq7Y6f8dKupKXCYiFzKCv76
 IFUgZF8H2rE9dRppa2s2cX++fE8wHZH5yCX1EpKr557MDMta3oVycdljppCPEz8+hp34
 sujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740811350; x=1741416150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wOhsnhWcp/oB0H9OkHn8hUNSLjLyQJMmKpGtcq3Zsjo=;
 b=YYCqwBclNtWG8Gd+iuvf1Q4Fzuy4QsMUk5tgwq7NaKlv0ndp2XLh2UxNsNaLCwzIke
 Lntjk4OuLt1CSJbPnkTFyrpR8iW8sE4yI+FCnKQAhtxsUaoP8TNr0NPRiyJFB3WeCzw4
 sz+AnduF14TxNN9hLgHuEQeroSeakHSFw3w846Mwd5/UjDkT8kSqaDAs0IgTB0+XAFCi
 szE6xICWSf7ETf0YyuXaysliRXx+cwdtTvvpGmEm2mmSKjUwDmNxbxjFsjZ4Ij5TkGZq
 vwNitWHXK9Taegxa/XxzD1W3z1Zy1enZsXZBC/PP0jJpEcJOv0pXsrSegX3aVeFFg1Pv
 ZbbA==
X-Gm-Message-State: AOJu0YzWHOAJx//8Zw+Oh2XjqTkfstZt6r5V85EmuHT+Wnb5CwTVTtZZ
 91rvZw0Q0dpsXrpQC/IHrR5954y6C8mG/bSwvJ5kQzaBraYsAB8Mv5FJQSKC0d8RSFpMF+gnz92
 olWBsIdOYaQxlC6rJqc8YAg/APcwl9U2mcuVLpA==
X-Gm-Gg: ASbGncsDDSBjheP0Prpkhw8pv/y+SpGOovBM/LK83KvPDsOnKj4Z3RXXlnIsVYN4lYt
 BDi8VQEa04MUVWsKbfXbrSX+EjJSjrXMynVQ2ugmkmpewJ+tKm2zDfQ0zM9EyFWATxi38CASrKy
 nkL6fDDz+IGSoJEyPeOyX4y89j
X-Google-Smtp-Source: AGHT+IFj9clJ9enWaypjJfq0qCtwdcIlMKurJ8OTbcC1QFZSWKRlheBZgibF0WLg5olsIUwA/nMj+CBEH+3r1kO/CG8=
X-Received: by 2002:a17:90b:3fcb:b0:2fe:9581:fbea with SMTP id
 98e67ed59e1d1-2febabf414amr10217407a91.29.1740811350252; Fri, 28 Feb 2025
 22:42:30 -0800 (PST)
MIME-Version: 1.0
References: <PH8PR11MB6879500CDBB703E22EC3D6F0FAC32@PH8PR11MB6879.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB6879500CDBB703E22EC3D6F0FAC32@PH8PR11MB6879.namprd11.prod.outlook.com>
From: hikalium <hikalium@hikalium.com>
Date: Sat, 1 Mar 2025 15:42:17 +0900
X-Gm-Features: AQ5f1JpAhgUg5rQb38CRMYGH4zbtjB7gC1BzKTTyaq8V-3cbBn_j5COC9-5O16U
Message-ID: <CAB7+XXqH9efN-bG4mAt51jM7ucnH4QcdRHhDnsNjWz8s9A=mqw@mail.gmail.com>
Subject: Re: Some regression due to "ui/gtk: Fix mouse/motion event scaling
 issue with GTK display backend"
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000273ef9062f423a3b"
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=hikalium@hikalium.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000273ef9062f423a3b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kim,

Thanks for the report!
Could you give me detailed steps to reproduce the issue so that we can work
on a proper fix?

Thank you,
--
hikalium


2025=E5=B9=B42=E6=9C=8826=E6=97=A5(=E6=B0=B4) 3:03 Kim, Dongwon <dongwon.ki=
m@intel.com>:

> Hi hikalium,
>
> This commit actually breaks one of our use cases with Ubuntu host when th=
e
> display scaling factor is
> set to 200%. It seems like gtk_widget_get_scale_factor is only way to get
> that DPI scaling factor
> and without this, mouse movement on the guest wouldn't be able to go
> across certain boundary
> as the coordinate will be halved (in case DPI scaling factor is 200%).
>
> commit 37e91415018db3656b46cdea8f9e4d47b3ff130d
> Author: hikalium <hikalium@hikalium.com>
> Date:   Sun May 12 20:14:35 2024 +0900
>
>     ui/gtk: Fix mouse/motion event scaling issue with GTK display backend
>
>

--000000000000273ef9062f423a3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Kim,</div><div><br></div><div>Thanks for the repor=
t!</div><div>Could you give me detailed steps to reproduce the issue so tha=
t we can work on a proper fix?=C2=A0</div><div><br></div><div>Thank you,</d=
iv><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_=
signature"><div dir=3D"ltr"><div>--</div>hikalium</div></div></div><br></di=
v><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">2025=E5=B9=B42=E6=9C=8826=E6=97=A5(=E6=B0=B4) 3:03 Kim, D=
ongwon &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@intel.com</=
a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi hikal=
ium,<br>
<br>
This commit actually breaks one of our use cases with Ubuntu host when the =
display scaling factor is<br>
set to 200%. It seems like gtk_widget_get_scale_factor is only way to get t=
hat DPI scaling factor<br>
and without this, mouse movement on the guest wouldn&#39;t be able to go ac=
ross certain boundary<br>
as the coordinate will be halved (in case DPI scaling factor is 200%).<br>
<br>
commit 37e91415018db3656b46cdea8f9e4d47b3ff130d<br>
Author: hikalium &lt;<a href=3D"mailto:hikalium@hikalium.com" target=3D"_bl=
ank">hikalium@hikalium.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Sun May 12 20:14:35 2024 +0900<br>
<br>
=C2=A0 =C2=A0 ui/gtk: Fix mouse/motion event scaling issue with GTK display=
 backend<br>
<br>
</blockquote></div>

--000000000000273ef9062f423a3b--

