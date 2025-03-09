Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7873CC28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 23:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trPy2-0005ud-Nv; Sun, 09 Mar 2025 19:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1trPy0-0005u4-RP
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 19:21:56 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1trPxy-0007ZI-Cn
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 19:21:56 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ff64550991so5421362a91.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 16:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1741562511; x=1742167311;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tA/eHQYB+kom3KFCUCc+vncZ7RyxEurDiA7G8uteLrU=;
 b=an5dzKmmYMGD4SDDND9PTZTfRVuy1QFVQrzBVCgA7pLRMb+sqUo0lm4P8tfov9lb5j
 thZDj6F0Dfm6HmPRbGimRhQMSPOWD1kWmtNTxqbIMHI5hw4nO5uZSQkHVUKrSFmLyLHY
 AgGPUfKLTi4I3To+b8rWvvsPtWseCm1xmnQfNY4KbHA6xU7M79IoKhp9A2VHOPXNIra2
 yAY2fv6n4/Lru1P7EVh/NqID8NgYAnZASB1RgX42LLj9bdsmlqv81K6/AQfPlpu2Se4Z
 p/uQ0t1u3MO0nYw/NzQEeo1Z98j9apwTBZi6PhI3FCghPW89Y2vez+KAlBUzNn02ckF3
 EYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741562511; x=1742167311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tA/eHQYB+kom3KFCUCc+vncZ7RyxEurDiA7G8uteLrU=;
 b=Ysyt0PyZL/WHk9X+NHoc9FVSfZXt4JeoUvlby0XBLjhvxU4KUbuxyWr3K7aNzxaWh3
 pf+qzjbKbk7CenkYc+Bxs8K4pbe6zDNljGIqeHfj+DahQvzUKSe/Q43QnMozMfgAwJiB
 rbT3hQ6zguTsjzQQGfC2ogbBY8BC/1RV0sb9sHPMO2BYg0r17t1OjYtFCCtdiGXRUMlB
 9V4gvJ8Vh7scDb3ZAHy/ZqlknOHsTSL0Ug0DgUTNWZZqaiMs+JD7VztVFukLY1QgQBqk
 iLSAINuh47uwhTcQlfNGyZNcaDnmVpqcfoGM1zfJfFkANVeiQ81jsA06QcpeXKuQ4vnR
 vVww==
X-Gm-Message-State: AOJu0YwPzSOwKEi9dVyUSgSQjnxMPX+OGqGyD6ywYcJd7R+Qg+UzlrFc
 eP5sKao4I/G3AW44SpK0+jPsPQOeUREdbHA82npbtkaBopm76/flBCdN21T6wRrL1yxDpmwjxxA
 Rz1FLbmmensotBx9ZCKi/bxAUI7LlbnZyaQ4O5A==
X-Gm-Gg: ASbGncumh9iPdDVedEEb8FdahNAQD17kTLi1CgRQdzLsv3vCRwzNjDSC64EsmlzPNtf
 YgN57y8sBoWoI1qhDt27P0NN1DLIvxzD59sawAHTI30WOEdWVZL7NxEPrG1IPPN6t1pQ9uXDKtV
 gNaINmNTu3UeeQ7BTZQ/v75tysGg==
X-Google-Smtp-Source: AGHT+IHg9q63UxyvKdr9z47ZtsFk2KNPn9GUU3Zd5tkYHZyvi1Yek5tOmkUuwfBJjr/3npp9MbwiBjJL2oE78AgwklQ=
X-Received: by 2002:a17:90b:3883:b0:2fe:d766:ad8e with SMTP id
 98e67ed59e1d1-2ff7ce74e92mr17257144a91.4.1741562511121; Sun, 09 Mar 2025
 16:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250307130951.4816-1-philmd@linaro.org>
 <20250307130951.4816-2-philmd@linaro.org>
In-Reply-To: <20250307130951.4816-2-philmd@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 9 Mar 2025 17:21:40 -0600
X-Gm-Features: AQ5f1JpMQEOtR3bVd4IO8qZYyzuhLTAnU367lqFXDYegMW2xw80SSifZ3O9-jLY
Message-ID: <CANCZdfoyn==Lt0BCO0q4P2876nC6gTZGnXzpuKA_gXnCa2khyw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] bsd-user: Always use mmap_find_vma_aligned() in
 target_mmap()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Riku Voipio <riku.voipio@iki.fi>, Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000d48771062ff11ee0"
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1034.google.com
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

--000000000000d48771062ff11ee0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 6:09=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> Massage target_mmap(): calculate alignment once, then
> unconditionally call mmap_find_vma_aligned().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  bsd-user/mmap.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000d48771062ff11ee0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 6:09=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:p=
hilmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Massage target_mmap(): calculate alignme=
nt once, then<br>
unconditionally call mmap_find_vma_aligned().<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/mmap.c | 11 ++++++-----<br>
=C2=A01 file changed, 6 insertions(+), 5 deletions(-)<br></blockquote><div>=
<br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.co=
m">imp@bsdimp.com</a>&gt;</div><div>=C2=A0</div></div></div>

--000000000000d48771062ff11ee0--

