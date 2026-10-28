Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665C0606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=Fjlij1Pv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLxpF-0001vb-2z; Wed, 28 Oct 2026 03:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLxpD-0001v2-Be
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 03:11:55 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLxpB-00014X-JT
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 03:11:55 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c315869241fso92335366b.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 00:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793171511; x=1793776311; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C3pAyL/TfLRDhodU+4wK7XbefuydGvYrayvqso5pxvk=;
 b=Fjlij1PvqPeXDE7EIcYI1j5zBi2JAGCuBUm/w3+c2fkd32Pe5lcJ5rZ84GIrZdLKW8
 OqrVt4ENagEtz3kpZqE0bD/86s2rGctwcnO3TPQFvh0yEJAuCzFIHM6sUwqdmDa9N2ph
 PBsqBuZqPl7eBngjzv+sgJpzR00/nLnrAtXL8xCz9NGoq0Hrvj7/u/uNGkyHzuhV6PyZ
 PXp+wgDWpBahOaU4t0VRHA8yPtUCysn0wakNkMBy0wC1jaeseutlxV6TQBFRIDZJzBJ4
 +dNHc5Za1D4o/hqGaPcG1HWo1gHWPRDgOEp8xXY36l7IYi3Y7BPjBQh/o4NNN7JgXw9M
 cUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793171511; x=1793776311;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C3pAyL/TfLRDhodU+4wK7XbefuydGvYrayvqso5pxvk=;
 b=PMBGfiKsdvvq0yUX7Nf8dy5wV3whelq33MmjGZ9DzNYyU7z7nSMvBFMm4vegsZTjWM
 av0z2tUlDpGOCofj94VFUzZD9VtkeiW2R6iEMOIbFsZzgPOSCvTLiYqiDLO99ZY6ZDKM
 KUT0FJa5jFqLFEh5fPb6XnbulXCCylwjL7nRqXWzEOqdS35Q0+fUkv39IvXEGjCyh5AY
 V6eZ7QYDc6iU/7CXnE2JLmN8IFiZNeqN8MAvj3Z6S9upZryZfj0OXW3LKCplVnDF4mjR
 TbFOUF9ORlGYyifkc0tyhd2G+nmGioY1gqegJ8TEsLbdMJ2dhG6gMy46S06QMqYU//G/
 y4jQ==
X-Gm-Message-State: AFq9FYIy+4kT5JgjlBkvEzTnZurV/vtMoq55CKwanHHOeTStX2et1CtP
 OxUtkCApVObJRlIt0Mp/Sol4CLS46t+9eowtVQcuAZi554QF3zWIwCqQK23bEKLNckO4w+EoqvS
 Da40z8D9dihl5WNlOeMA7xJzx1QjD10Z8V8Q4RVVW1OpDP2WiIMXnjsCUlquecCdw9ca2gXGo2j
 3/p1dZjT5do9Fq++Ja3gE3bmF0Ot2WQFqU+8XkwPQyslQ=
X-Gm-Gg: AYBFou2HUh9DENGvBVE/3QxMUmH4p9Q0VMkMtv+xUvTWEzmzbsilB/ebP5jlgGUv0Zt
 0cdD58Ic66SA7eKGxxu6HfwZVY5icGSustiyXcd9fPtyc+5nuESW/m//+JQSxKJx+fcpPXxbHfX
 ABDm6k5K6fVxWqzymhtdpOJI23/4/kNpkzcHkx0+v3/Gbp5XGNYSGtsZT4qyOekgZU848IMKQCI
 goj9jJmKo7KEblSFgU/hbM0Bo4kkI9rCs34fP62epUcZOuiC1X6UvJEM3vAd/nGM6wfQtRkwW/0
 ncetiUwpcgAiGRA/Q8fYLNXVLMnM/SYQ8DUWP0SuKyF2l0kSaTBT2wtMOjTGUjoQCnpTAg92Hfx
 EGfAjxy9unSx9hgb1gqoanORM5v+f3CPNM6LrNQZwaWVVQnvnBd+JTcPRS0EL85sKRG8sALCyiN
 YiE7Vo+OLU8MWwOqdDTLpIuTY6wYXySi3hPjyUdqNXXY8n44GU4N2MYFlLiSVkyYWamckd0oCjQ
 hhNJamM+senqQBsG9vsKcgFqGgmYXP/9y/Res2tSlOqDzE1yCSwPYuQa7C9dcLP4gYYlHqbK4X5
 QOdq68+S3+mNE71Cy8bWWWKlo4uDRbDfDWRxO6iRJRUbO7RYE5nhje8prf+YnqgEqYk=
X-Received: by 2002:a17:907:a0c9:b0:c29:5b0c:1b44 with SMTP id
 a640c23a62f3a-c49bdf95467mr124435466b.37.1793171511326; 
 Wed, 28 Oct 2026 00:11:51 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com.
 [209.85.208.46]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd798391sm564761266b.71.2026.10.28.00.11.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 00:11:50 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6afbc363efeso1055546a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 00:11:50 -0700 (PDT)
X-Received: by 2002:a05:6402:144:b0:6ac:b3e7:2357 with SMTP id
 4fb4d7f45d1cf-6b49cbecc82mr563014a12.21.1793171510001; Wed, 28 Oct 2026
 00:11:50 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
 <20261021231346.2452179-17-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261021231346.2452179-17-daniel.barboza@oss.qualcomm.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Wed, 28 Oct 2026 15:11:38 +0800
X-Gmail-Original-Message-ID: <CAMXXpfb0arbbqenw5eOHhPrFZ6P5xkN39zkj7JzdUs5kg8oz-g@mail.gmail.com>
X-Gm-Features: AclHuK8Z_IGGX3zmPD92I6x-p2WwSofuPP_-Rw-79QQTdNjSxAxbsKM0_GbapC0
Message-ID: <CAMXXpfb0arbbqenw5eOHhPrFZ6P5xkN39zkj7JzdUs5kg8oz-g@mail.gmail.com>
Subject: Re: [PATCH v4 16/18] hw/riscv/trace-encoder: send branches info
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, antikostya2@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>, frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="000000000000e00845065ee146f8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=jay.chang@sifive.com; helo=mail-ej1-x62d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000e00845065ee146f8
Content-Type: text/plain; charset="UTF-8"

>
> +void trencoder_report_branch(Object *trencoder_obj, uint64_t pc, bool
> taken)
> +{
> +    TraceEncoder *te = TRACE_ENCODER(trencoder_obj);
> +
> +    /*
> +     * Note: the e-trace spec determines the value '1' for a
> +     * branch *not* taken. The helper API is using taken = 1
> +     * to be more intuitive when reading TCG code.
> +     */
> +    if (!taken) {
> +        te->branch_map = deposit32(te->branch_map, te->branches, 1, 1);
> +    }
> +
> +    te->last_branch_pc = pc;
> +    te->branches++;
> +
> +    if (te->branches == TRACE_MAX_BRANCHES) {
> +        trencoder_send_branch_map(trencoder_obj);
> +        te->branches = 0;
>
Should we clear branch_map after sending the packet, or explicitly write
0 for taken branches using deposit32(te->branch_map, te->branches, 1, 0)?

Thanks
Jay Chang

--000000000000e00845065ee146f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">+void trencoder_report_branch(Obje=
ct *trencoder_obj, uint64_t pc, bool taken)<br>
+{<br>
+=C2=A0 =C2=A0 TraceEncoder *te =3D TRACE_ENCODER(trencoder_obj);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Note: the e-trace spec determines the value &#39;1&#=
39; for a<br>
+=C2=A0 =C2=A0 =C2=A0* branch *not* taken. The helper API is using taken =
=3D 1<br>
+=C2=A0 =C2=A0 =C2=A0* to be more intuitive when reading TCG code.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (!taken) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;branch_map =3D deposit32(te-&gt;branch_=
map, te-&gt;branches, 1, 1);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 te-&gt;last_branch_pc =3D pc;<br>
+=C2=A0 =C2=A0 te-&gt;branches++;<br>
+<br>
+=C2=A0 =C2=A0 if (te-&gt;branches =3D=3D TRACE_MAX_BRANCHES) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trencoder_send_branch_map(trencoder_obj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;branches =3D 0;<br></blockquote><div>Sh=
ould we clear branch_map after sending the packet, or explicitly write<br>0=
 for taken branches using deposit32(te-&gt;branch_map, te-&gt;branches, 1, =
0)?<br><br></div><div>Thanks<br>Jay Chang</div></div></div>

--000000000000e00845065ee146f8--

