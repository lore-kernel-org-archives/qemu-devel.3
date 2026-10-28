Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26368606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=fdr/+cw5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLyAR-0007CP-Q7; Wed, 28 Oct 2026 03:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLyAP-0007Bh-A6
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 03:33:49 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLyAM-0002tk-IX
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 03:33:49 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6ae14eecc64so1050441a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 00:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793172825; x=1793777625; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LnjmH2S/AjR4RFfS6rITEgbZa+dsK7wz1YppDAeLdro=;
 b=fdr/+cw5LqGpHTawQupFKyvD/ip8OyyHlYnL6HnPAyCm9L7t5PJWIGTjDxJocbBJ11
 x3wV6b+6tNznb6lYGAjldy8miLL5imzjqaNgAxHwP41pivFv9EN9C7bYu7YHBnzCXZa1
 2vhArwxX833W+d7WY4A1KSjIXgyfFiNs5Pe2c8wYVo2gtDXfWnV9ucSINbkBykOGr4Qq
 NoQHD0MRLhQyH1IBIBcRx+809UVjAHM0dUk2Dapoo1FJueQHtyXbU7x+eGGSA7DDuvzm
 WNiAHRGAgMP0F4uPTV+c0ggGhL1z1vxGDKd17vCZl1qUbAEFrpSViPeKqZmQmUVzp6ER
 V7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793172825; x=1793777625;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LnjmH2S/AjR4RFfS6rITEgbZa+dsK7wz1YppDAeLdro=;
 b=nR/L9jofnt1bWPNOuC8m8G+0YkJrq7+j2/pB/xfCw7pSMRPEWLItkLzFeqAEeLM1ty
 gt5cas9vk6LNvdudKhYCH8fnd2JPyg1FPlUTDxVhMxc5uI4yob+8xRfU5iARuAR6EmYG
 MyoWehSItpPRny1pJXFW7cLcLQfXnz0OwA3jn5olMzIwqXy2QMUhSBVHW2zizYv6zgtg
 CndL9dnkrxWd23nvLX5vXG5p43eXZgU3KK0LFsZ9v+Qu4jC6PuO4IdJr91GT1c9YXxL/
 dMjodMy7AhulDZV/1BsjqZN1rztFI5zkBdcyPNVBNkafUrX/H3kBQlkJQxUYR8QbQ2Vn
 +X5Q==
X-Gm-Message-State: AFq9FYJ85cGf9bOCczdty58FwxrevKHRjbfR99ALGmTjYOG+0et6pQth
 h7DVa5FKHzjscWPwT60JfTDxdYFtPWAmvmF83IdqYwB7I9FXrPxR1WDFUbhPwZuL4/DsOGizlpM
 xmU4BtX+OzLLae34TtbKqB/MYi/g9rI7Xo3L0u7Xs/GkpLwWeoco3JZWMDm/QxlCn0oCwNO0JhC
 N34hLm5HrBn+k7Q9DdAPee8Q1UA0BQY4zmcncLXpip2ck=
X-Gm-Gg: AYBFou0HDmNSSSM//ubHDxjFRmCePacEnHj7PRDUklgnDhncAsjYJhZd+wm8hsvaM2z
 XwaMRkMHhj0Jf2oyuzg1+8GW9igUdaXyVKGLVNCfdgWKiAUJkfvEerfFJ4mVXNWl4qgQ/DTM+qI
 gyKdbw6IOcjrXqqCf/bqNpOLQOwXaslRBsQ6uIftaUG9W3tqOwG7YRtnPOQki1heLn1oHNuVDq2
 po87JJgW8xj/G3ZIWwiu6G+KMBsuSuw3yiYVptfEhe5UwVQectRCj4E6h3PI897/Xc0m9ZorjMm
 hhi9TAehFKXSdVV0NooA5xrua7YARDUeXzPYvCI1PT5Q/KGw9RiOe/6FeG/r5bphW9wSXcwt5CA
 CNQKzAbBjte2rL8TGsONZReKNSynqV2PdGW1+b9xDaDufB9xvvXq/urHjCw6DF3BMzF6S57jq3b
 GJASP3NcR0Q2PLlEPMYTHWCau8kTv1XIeoQcBqc/4qRpcSKk1KWRQgyLMGPvVwI2WwVQqQqWRIk
 6YQetVkPFFGo2AzB565y3pR0MAq50Vm//oL9CYuwFZTrIVhftFKS6Ns90bwEkBW0IWSsUY+cVE5
 uhjxJEdC27cyc2HCisHstDsH09INkVdOJT3/RGh1zsce/MvOcSiotq2t6nsvEUkSqjA=
X-Received: by 2002:a17:906:dc94:b0:c41:a5da:1511 with SMTP id
 a640c23a62f3a-c49bdedd0d2mr114463066b.25.1793172824946; 
 Wed, 28 Oct 2026 00:33:44 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com.
 [209.85.218.50]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4e784esm553614866b.19.2026.10.28.00.33.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 00:33:43 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c445c95d553so80469166b.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 00:33:43 -0700 (PDT)
X-Received: by 2002:a17:906:9fc7:b0:c3f:55e6:83e6 with SMTP id
 a640c23a62f3a-c49bdeab6a7mr115586266b.15.1793172823267; Wed, 28 Oct 2026
 00:33:43 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
 <20261021231346.2452179-18-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261021231346.2452179-18-daniel.barboza@oss.qualcomm.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Wed, 28 Oct 2026 15:33:30 +0800
X-Gmail-Original-Message-ID: <CAMXXpfakWUOw4r3vaSw7y6wkpojHuanXFeL9DD4PwnAqgnhmvA@mail.gmail.com>
X-Gm-Features: AclHuK89muR4AACpl_RTB3BtYsN-Uqlkl6W-kcFwmiJ0B0IhlIkRJhWmLMsz5fU
Message-ID: <CAMXXpfakWUOw4r3vaSw7y6wkpojHuanXFeL9DD4PwnAqgnhmvA@mail.gmail.com>
Subject: Re: [PATCH v4 17/18] hw/riscv/trace: update branch bit in sync
 messages
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, antikostya2@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>, frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="00000000000026e211065ee1952a"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=jay.chang@sifive.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000026e211065ee1952a
Content-Type: text/plain; charset="UTF-8"

>
> +static bool trencoder_addr_is_branch_taken(TraceEncoder *te, uint64_t
> addr)
> +{
> +    uint8_t last_branch;
> +
> +    if (te->branches == 0) {
> +        return false;
> +    }
> +
> +    if (te->last_branch_pc == addr) {
> +        last_branch = extract32(te->branches, te->branches - 1, 1);
>

 last_branch = extract32(te->branch_map, te->branches - 1, 1);

Thanks
Jay Chang

--00000000000026e211065ee1952a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">+static bool trencoder_addr_is_bra=
nch_taken(TraceEncoder *te, uint64_t addr)<br>
+{<br>
+=C2=A0 =C2=A0 uint8_t last_branch;<br>
+<br>
+=C2=A0 =C2=A0 if (te-&gt;branches =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (te-&gt;last_branch_pc =3D=3D addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 last_branch =3D extract32(te-&gt;branches, te-=
&gt;branches - 1, 1);<br></blockquote><div><br></div><div>=C2=A0last_branch=
 =3D extract32(te-&gt;branch_map, te-&gt;branches - 1, 1);<br><br>Thanks<br=
>Jay Chang</div></div></div>

--00000000000026e211065ee1952a--

