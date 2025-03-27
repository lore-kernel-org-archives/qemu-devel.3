Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2D2C36010
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 16:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txqOP-0001Uc-GC; Thu, 27 Mar 2025 12:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1txqOD-0001S9-1q
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 12:47:39 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1txqO9-0007Fo-Ly
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 12:47:32 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso200074466b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1743094047; x=1743698847;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ntg8N4MKXByoErMEqRdNEm07oTTNYL26rY5VGayYUJI=;
 b=3Xuqq7EMxylTMAm6jTkKb8zPBZw1djfqm9U9OHhak9kTjQIL5sEsAM1dQXHloM9ljJ
 a/v4WyoWhSXt73jAXq7cTWqWjwbMo66ol0cJkWizXlmI91xSeDJbwHlNUSc+yLlVT8EL
 1qi1JCvRBN6xJEIdUAIbzklDMISaxUim8Kh2US7DLFLjzZcGc6jXar2QHEtWBKGGYWNC
 rFbkOS8DjZzfj0vd72uwopnjQgjH8XD08miUoH8ETkNewwNTIoLaiV/TzTjrcC405Hst
 64My08Ejs90QHllloDAFtlRf9QCewGs/jyDJNEEyM+11Fqd+zTnrnEhF65AVR1Ue0P0w
 bNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743094047; x=1743698847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ntg8N4MKXByoErMEqRdNEm07oTTNYL26rY5VGayYUJI=;
 b=Agg+NENCnd1ZEIgKtNeI7uzC0oQWhJv20MjpVB3RgEgXsuirRihD+JVo3lrwl/Pkd2
 XTEiB7nLzDY8J9EbermzxLLrjonvj2LH9L61OIGyVHv6ul4isDt5J/tITLq/XfiiX15S
 uL+AWgI7mjn0idyCs3Z4HARf72a2UIwaOuyrG3BqumajAlDRafbL7Z7V1TQF3siGev1U
 qKP49hDW+Dletyvg8yqp6om524+KeegV+p7KqAx5PE/ceUgJLCs4MQdZt8PIu7jk/XVs
 hOwa3byWmVXtO53zKIjWocXBbItYOHt9XAiMgm5NNtwB7HTvetyF91j0V/UiyrQrDxFD
 SbEQ==
X-Gm-Message-State: AOJu0Yy427QNIDe+m7h2JeY6VOKLf9JcIPFdZhf2k25KXyPO4qnejIth
 nO3ykUizHO+RatAqwbh+N81GMzGmqC5IkseBsagURMDgXDYJLJ2oMPl05Th36e1xA/F/46A9t14
 rAdXWbiZOiI5c6AJapPvIuOG6ZnwY8R8soYi+qDaGUnuNRcXq
X-Gm-Gg: ASbGncv64JVS4zFDEhDoZkR1UYwNN36OHp+lWpOCVe1WbIej6mLdaldN3pavmhScDNd
 J15gi32J3xJKWVijm9T78kxwaEUDY20KnfnnsUtztfACoQ3orWmIIVqfCrT2CdWSmecYeWWwMlC
 qd1EqqTMIHYg+sDQhrmXUwgTm/
X-Google-Smtp-Source: AGHT+IHU1zKqDLYkJ+E+juue9WX4YjvAkrscNlauZTiApC3RVbl9K9Ly1ZCxfCo6SqCqCZPziqVxOzVdC7bVdfg32Hw=
X-Received: by 2002:a17:907:3f99:b0:ac6:df9d:265a with SMTP id
 a640c23a62f3a-ac6faecf9c9mr421598566b.16.1743094046781; Thu, 27 Mar 2025
 09:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250313193011.720075-1-loic@rivosinc.com>
In-Reply-To: <20250313193011.720075-1-loic@rivosinc.com>
From: =?UTF-8?B?TG/Dr2MgTGVmb3J0?= <loic@rivosinc.com>
Date: Thu, 27 Mar 2025 17:47:14 +0100
X-Gm-Features: AQ5f1JqQtqiDKbjTHjvSLWJ9dIaoX_-F7u6OsRo8dRdKqvbfllz1UWw2wmLGu48
Message-ID: <CAGKm2NKSAP3hGeMk4D3r-ZXd+=CfQ+NBMrJrQ2hnPapMJyGshw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] target/riscv: Smepmp fixes to match specification
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: multipart/alternative; boundary="000000000000781d0c063155b59b"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=loic@rivosinc.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000781d0c063155b59b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping

On Thu, Mar 13, 2025 at 8:30=E2=80=AFPM Lo=C3=AFc Lefort <loic@rivosinc.com=
> wrote:

> These patches fix Smepmp implementation to make it compliant with the spe=
c.
>
> First patch limits RLB to CSR changes since RLB should not affect privile=
ge
> evaluation. Patch 2 extracts some common code into a function (to be used
> in
> patch 3). Patch 3 fixes validation of pmpcfg CSR writes in order to match
> Smepmp
> specification. Patch 4 is a small optimization and last patch is just
> removing
> redundant code.
>
> ---
> Changes in v2:
> - rebased to latest riscv-to-apply.next
> - addressed Daniel comments on patch 1
>
> Link to v1:
>
> https://lore.kernel.org/qemu-riscv/20250225160052.39564-1-loic@rivosinc.c=
om/
>
> Lo=C3=AFc Lefort (5):
>   target/riscv: pmp: don't allow RLB to bypass rule privileges
>   target/riscv: pmp: move Smepmp operation conversion into a function
>   target/riscv: pmp: fix checks on writes to pmpcfg in Smepmp MML mode
>   target/riscv: pmp: exit csr writes early if value was not changed
>   target/riscv: pmp: remove redundant check in pmp_is_locked
>
>  target/riscv/pmp.c | 151 +++++++++++++++++++++++++--------------------
>  1 file changed, 83 insertions(+), 68 deletions(-)
>
> --
> 2.47.2
>
>

--000000000000781d0c063155b59b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping</div><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 13, 2025 at 8:30=E2=
=80=AFPM Lo=C3=AFc Lefort &lt;<a href=3D"mailto:loic@rivosinc.com">loic@riv=
osinc.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">These patches fix Smepmp implementation to make it compliant wit=
h the spec.<br>
<br>
First patch limits RLB to CSR changes since RLB should not affect privilege=
<br>
evaluation. Patch 2 extracts some common code into a function (to be used i=
n<br>
patch 3). Patch 3 fixes validation of pmpcfg CSR writes in order to match S=
mepmp<br>
specification. Patch 4 is a small optimization and last patch is just remov=
ing<br>
redundant code.<br>
<br>
---<br>
Changes in v2:<br>
- rebased to latest riscv-to-apply.next<br>
- addressed Daniel comments on patch 1<br>
<br>
Link to v1:<br>
<a href=3D"https://lore.kernel.org/qemu-riscv/20250225160052.39564-1-loic@r=
ivosinc.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/=
qemu-riscv/20250225160052.39564-1-loic@rivosinc.com/</a><br>
<br>
Lo=C3=AFc Lefort (5):<br>
=C2=A0 target/riscv: pmp: don&#39;t allow RLB to bypass rule privileges<br>
=C2=A0 target/riscv: pmp: move Smepmp operation conversion into a function<=
br>
=C2=A0 target/riscv: pmp: fix checks on writes to pmpcfg in Smepmp MML mode=
<br>
=C2=A0 target/riscv: pmp: exit csr writes early if value was not changed<br=
>
=C2=A0 target/riscv: pmp: remove redundant check in pmp_is_locked<br>
<br>
=C2=A0target/riscv/pmp.c | 151 +++++++++++++++++++++++++-------------------=
-<br>
=C2=A01 file changed, 83 insertions(+), 68 deletions(-)<br>
<br>
-- <br>
2.47.2<br>
<br>
</blockquote></div>

--000000000000781d0c063155b59b--

