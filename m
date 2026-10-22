Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B54606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kvi8wVat
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJogi-00071a-DT; Thu, 22 Oct 2026 05:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJoge-00070q-SM
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 05:02:13 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJogd-0006Gm-5F
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 05:02:12 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-843cf077f10so1775378a34.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 02:02:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792659729; cv=none;
 d=google.com; s=arc-20260327;
 b=huV+rx4aI7obl+ikmDVwZrjL68Ek/XNZfXUa7g+LY8c3xmHvPFe7mjz32asgAXX6mN
 ELso8ULm/m+M22Ic3rqPz6GCPO7MsCNh6WjtTW6cdh/2cBAf2MzngrglNH11zYSzFJWj
 2thnGtNxO6XK/EMZXBkclPctH6VlI1F59akhcVCgZfCUvAY7TuoOq9+/+wSxCT+fZpU9
 D1ip8+93NnpE8iXKK/+TvM3hqQcBzV0nmIffdirLw1z+JT/98pS3pCfIrAQGmtTIUWJw
 BFDVgQWkZo14Tp7WSLdGgy6w3o8n0LgfYgd984UHoWrAd4Bqha2TvdxbjJ5ZWmLMLn+X
 +NxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=05QvwJvs3AcGfs8QcQ0tDfoVhsAhYZnor7yRXTTOQ9Q=;
 fh=CaWnO18l3T2JEm5Fha20AvFFAY3acH8IOPEOfr9q15k=;
 b=MEtAAZwOMElTJCClROCN91FRRFppMjpNb0/liuA3FGLstHlfoK8gzXGXXVYHQAS/dP
 nnL/pFEcWIDIr0eks3N+Ow1MTeCK02wBoqDAYmAx/w9yxpXgCsWGeBpkLBmaty0raEAY
 9VtOEIOokCfPu1CVIigDUh6rEuStFTu53jaIwvmawZcV4D2Mcq8fbK5xcTwgtEcoX2/t
 IKeid3ijT0nW32mFLIjUWWWxQQdvlJZYcKA9/pRanv4PwkPCM1r6j8CjnRLndGCjLBlq
 s1S0ZxvpbHUJx/nT5/DGlDRq93ORNGTZ0MX08CQiD6V1ET38NWIIdNjNkBKBxIQhLLv7
 zpwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792659729; x=1793264529; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=05QvwJvs3AcGfs8QcQ0tDfoVhsAhYZnor7yRXTTOQ9Q=;
 b=Kvi8wVathbii0g7JsmJDkVaIIJnqLwTmFaXQ2UaM+nqy+XNO+Bkn6VedA9eeWV8Vsx
 DRTLShq3ot7s6TvWwShhmT8pa6XeQ2nQi5LOZJ8uIjsvDpR2k1F9VrJFPPsPNgBFQv4H
 cPl4YwOzHll3x8KvwsVgB8xjD80+ZR5s1BEOGWS/rwzsfajdMiJZ50c/yJ6OaWwMRtxx
 2IOXDtZ+0Uopr7K096bsG8yAKuzuR73y/LgB0t5a8l9NRjdh1wN14Xxm7sqvNC0KUJ5d
 eI83GTrSPgZAArMXZqoP4y375gG2aMeTDTbaM5r+MFwSEWviRv6BnlMIlJSTDpMOy4SJ
 EaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792659729; x=1793264529;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=05QvwJvs3AcGfs8QcQ0tDfoVhsAhYZnor7yRXTTOQ9Q=;
 b=JLtUOHs/mjvXCqqu5qEdJusiOBLkWMIBxftgNadTXg9YYH69y3tOT0pbi3Efle/DeQ
 U94rZAhlqBY5XQhYcoZiUuhi0FGvXZEp8/7WuoNPEyQmvodv5QAn2VdVzqcUEmi/5B3t
 NzNglYY74ZQrgGO8NXUdzULiEE4xQ/mG2CIAhnCtTKvGW+LLC+rpOTHuVKydN+k+NG0i
 zxiSYFrzhHFnSjJzu5R3jKpybY0ii3Kg6kLFqAjR+P080b33h3z7+9eLlrnKN73iAJqL
 I+ncGBDAUejf4jrPvWt9klifzackW4nxhx3PSanpr8We0j+yltI1oDaSsBA/HIVeeKG4
 ub6w==
X-Gm-Message-State: AFq9FYKn15WcQOuEd5EwLvvVAuSARGZGV0TphLxEqZRPv2rsTLgN0eU2
 rfSq5E2hCtxoYq7SSkztbZvehriGAPSGjleH6MVom2Zs1XA9mxR9Et69GebVBNIj0/vw2H7UoKp
 sL9klbfiYmJTHoOBgLJ2JOZCX+nVlSpU=
X-Gm-Gg: AYBFou2Cqm9VSMimIW9Ol4XkKoPkCnAly30hyYkH9B/r6aL9BItC2YuuGU601zAflhM
 9cwLdbUP9ezZelGKu8X2APCSBOgj0gEQk12qHTlcIv8NwlE1mPotuVbTL4gWD02z1WzX8IShQD6
 v/LfuRMAlxR/k1rhZy/DYZkt4jSjhCUXNqOKpnOecf+HD0u0SjVHdaQA0zPy+QO6RDIcT4PhMMm
 E0C/TKLl5zwSlhAUwBz592ncsM70Z6iZoxC0iAhu1RHIfAZvOXS7+66iQaEQJYXb1CISF6SzC+y
 pZlqzgUli/zb7N3X3Q925KnCBKbHhkdOcPJVtN/EDFp8sACS4nz+Mk8J9A0e0gwWUleWnZmoium
 xGTlbsZVQCm2+AmtgFrVxwJOss9tvGBXLcC5mUbzoUJseG/jVbLzrs/sQow==
X-Received: by 2002:a05:6808:2389:b0:539:e1c7:c05d with SMTP id
 5614622812f47-5535dd9cce8mr3037573b6e.49.1792659729301; Thu, 22 Oct 2026
 02:02:09 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022072238.319308-1-waysorrypub@gmail.com>
 <20261022072238.319308-3-waysorrypub@gmail.com>
 <20261022101845.381dd1a6@imammedo>
In-Reply-To: <20261022101845.381dd1a6@imammedo>
From: way sorry <waysorrypub@gmail.com>
Date: Thu, 22 Oct 2026 17:01:57 +0800
X-Gm-Features: AclHuK9IqozglrlAsDlNbxxTBN3ZmvoZtGOMG-OI10J4hx77zJA6n5jONPgd6Dg
Message-ID: <CAECqSzXF6a2P9-tz_xRP8+t_RQUYRjgsRhQtMygnRLJJtvHPTg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] hw/loongarch/virt-acpi-build: Drop UART _DSD clock
 and add _STA
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, 17746591750@163.com, maobibo@loongson.cn, 
 lixianglai@loongson.cn, jiaxun.yang@flygoat.com, mst@redhat.com, 
 anisinha@redhat.com
Content-Type: multipart/alternative; boundary="0000000000005e4343065e6a1e5d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=waysorrypub@gmail.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000005e4343065e6a1e5d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor,

The _STA method was added in response to Bibo's review comment on the
original patch, where
he explicitly suggested adding _STA.

I understand your concern that omitting _STA already implies 0x0f. However,
the two review
comments seem to suggest different approaches.

I'm happy to split the changes into separate patches as required. For _STA,
though, I'd
appreciate it if we could first agree on whether it should be added or
omitted, so I have a clear
direction for the next version.

Thanks,
pillow

On Thu, Oct 22, 2026 at 4:18=E2=80=AFPM Igor Mammedov <imammedo@redhat.com>=
 wrote:

> On Thu, 22 Oct 2026 15:22:36 +0800
> pillow <waysorrypub@gmail.com> wrote:
>
> ...
> > @@ -325,7 +324,7 @@ static void build_uart_device_aml(Aml *table, int
> index)
> ...
> > +    aml_append(dev, aml_name_decl("_STA", aml_int(0x0f)));
>
> also is it really necessary? Doesn't missing _STA imply 0xF already?
>
> >      crs =3D aml_resource_template();
> >      aml_append(crs,
> >          aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
>
>

--0000000000005e4343065e6a1e5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Igor,<div><br></div><div>The _STA method was added in r=
esponse to Bibo&#39;s review comment on the original patch, where</div><div=
>he explicitly suggested adding _STA.</div><div><br></div><div>I understand=
 your concern that omitting _STA already implies 0x0f. However, the two rev=
iew</div><div>comments seem to suggest different approaches.</div><div><br>=
</div><div>I&#39;m happy to split the changes into separate patches as requ=
ired. For _STA, though, I&#39;d</div><div>appreciate it if we could first a=
gree on whether it should be added or omitted, so I have a clear</div><div>=
direction for the next version.</div><div><br></div><div>Thanks,</div><div>=
pillow</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 22, 2026 at 4:18=E2=80=AFPM I=
gor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com">imammedo@redhat.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
On Thu, 22 Oct 2026 15:22:36 +0800<br>
pillow &lt;<a href=3D"mailto:waysorrypub@gmail.com" target=3D"_blank">wayso=
rrypub@gmail.com</a>&gt; wrote:<br>
<br>
...<br>
&gt; @@ -325,7 +324,7 @@ static void build_uart_device_aml(Aml *table, int =
index)<br>
...<br>
&gt; +=C2=A0 =C2=A0 aml_append(dev, aml_name_decl(&quot;_STA&quot;, aml_int=
(0x0f)));<br>
<br>
also is it really necessary? Doesn&#39;t missing _STA imply 0xF already?<br=
>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 crs =3D aml_resource_template();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 aml_append(crs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_qword_memory(AML_POS_DECODE, AML=
_MIN_FIXED, AML_MAX_FIXED,<br>
<br>
</blockquote></div>

--0000000000005e4343065e6a1e5d--

