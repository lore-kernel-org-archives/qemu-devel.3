Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0ECC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoPk-00067A-So; Wed, 21 Feb 2024 10:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rcoKp-0001tO-IL
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:16:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rcjOt-0008RF-MZ
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 05:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708509623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=42SecKXcOz47okkrRHbgTxl0Hcl8mRZrzLBuSKsVq2E=;
 b=DaMe+XDk4LXicr8qQ8eDuOLhfrEd1R1Jvn/BHkyKGNJ7jYp78aU3KBp3TEO6By0+YKTF0C
 IVgt+rRuL+BSn/dee6Wlf/V8U7r+1re6OzwOdBtQWIQinQiheeNDacmGuaHAfAwVCSDDoY
 QXcMbBaAVSil2H3HzXgUL2R4tNUz1hg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-tdsE-VNENNCQgSlziWQHeQ-1; Wed, 21 Feb 2024 05:00:21 -0500
X-MC-Unique: tdsE-VNENNCQgSlziWQHeQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d23d2bd17fso23732181fa.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 02:00:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708509619; x=1709114419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=42SecKXcOz47okkrRHbgTxl0Hcl8mRZrzLBuSKsVq2E=;
 b=YDcsHziXS/J44YaMkJDBz9IPxktZei9QMdcbd8cAYnLhlG4jmuFOBacAIdIMDJ2qv5
 9O8KRieli3LpBSwyeGVQisv3uec69dP3NYSMkRMjekDEFEa/pKDCoP+4CZLomwTp+ug6
 EwYT5bDXs1CfsrRPGDiFU8Pkojr2MxOB76J27NTyWhCCRuRcLoV8DaqIueN/ce8jtkbw
 nbyZYqfc1xLyPjICrIZvUbu3GLXjcbHWpKRBMz14YaL2XwfKLp+mWstw8ZrztpI/zXe7
 XC/8UwI5uH19rzRPXM0dV0kBg1QLztarM7lyRQ5TPY2bnCqFpyaiL3tdZpHkSMvB8ouQ
 c3oQ==
X-Gm-Message-State: AOJu0Yylq2VtDqDCtZlan/L8F8Nak0bvdANUl0Ji3R9mNDHhWr5UmnTC
 UlocBF/x55qfshia8ZXxkw3NIJzk7iYqQ/7HzBCLoxjzn4rDXf1SVTDhSmPtbYKUVUsiaXeEGAg
 vDd+A6ZZXLvLkToazhInrnq03WzhfcP6YZ3VK58fx3c+7NNr7n7bHamkVipIR+iCx5pn2lLoL9c
 l48uzEOXF3APIMXkYazyFZxayjELI=
X-Received: by 2002:a2e:bc23:0:b0:2d2:230f:f14 with SMTP id
 b35-20020a2ebc23000000b002d2230f0f14mr11526516ljf.12.1708509619763; 
 Wed, 21 Feb 2024 02:00:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+Vo7pjED4tYF605xYHdGPxTDds2n+IPxYdZ73a9eDL7MiBEyVEh47DNAu/gMowDvTz1HCT4GQZ3gK89vCBZs=
X-Received: by 2002:a2e:bc23:0:b0:2d2:230f:f14 with SMTP id
 b35-20020a2ebc23000000b002d2230f0f14mr11526499ljf.12.1708509619493; Wed, 21
 Feb 2024 02:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20240221095130.52711-1-demeng@redhat.com>
In-Reply-To: <20240221095130.52711-1-demeng@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 21 Feb 2024 12:00:08 +0200
Message-ID: <CAPMcbCr9y89BiM+mTF3i2n6GfAA9Xnu3ovoS-KamLZFEiAhrSA@mail.gmail.com>
Subject: Re: [PATCH] qga-win: Add support of Windows Server 2025 in get-osinfo
 command
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000f730010611e164f7"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000f730010611e164f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:51=E2=80=AFAM Dehan Meng <demeng@redhat.com> wro=
te:

> Add support of Windows Server 2025 in get-osinfo command
>
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> ---
>  qga/commands-win32.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 697c65507c..f3c7e604c9 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2154,6 +2154,7 @@ static ga_win_10_0_t const
> WIN_10_0_SERVER_VERSION_MATRIX[4] =3D {
>

You don't update the array size, there are out of range elements


>      {14393, "Microsoft Windows Server 2016",    "2016"},
>      {17763, "Microsoft Windows Server 2019",    "2019"},
>      {20344, "Microsoft Windows Server 2022",    "2022"},
> +    {26040, "MIcrosoft Windows Server 2025",    "2025"},
>      {0, 0}
>  };
>
> --
> 2.35.1
>
>

--000000000000f730010611e164f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 21, 2024 at 11:51=E2=80=
=AFAM Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com">demeng@redhat.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Add support of Windows Server 2025 in get-osinfo command<br>
<br>
Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" target=
=3D"_blank">demeng@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-win32.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 697c65507c..f3c7e604c9 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -2154,6 +2154,7 @@ static ga_win_10_0_t const WIN_10_0_SERVER_VERSION_MA=
TRIX[4] =3D {<br></blockquote><div><br></div><div>You don&#39;t update the =
array size, there are out of range elements<br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0{14393, &quot;Microsoft Windows Server 2016&quot;,=C2=
=A0 =C2=A0 &quot;2016&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{17763, &quot;Microsoft Windows Server 2019&quot;,=C2=
=A0 =C2=A0 &quot;2019&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{20344, &quot;Microsoft Windows Server 2022&quot;,=C2=
=A0 =C2=A0 &quot;2022&quot;},<br>
+=C2=A0 =C2=A0 {26040, &quot;MIcrosoft Windows Server 2025&quot;,=C2=A0 =C2=
=A0 &quot;2025&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{0, 0}<br>
=C2=A0};<br>
<br>
-- <br>
2.35.1<br>
<br>
</blockquote></div></div>

--000000000000f730010611e164f7--


