Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CDB606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 03:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zH3QZLL3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN009-00058b-3y; Fri, 30 Oct 2026 23:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xN007-00058O-Ly
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:43:27 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xN006-0004F1-4c
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:43:27 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-3a75f960be3so12130231fa.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793418203; cv=none;
 d=google.com; s=arc-20260327;
 b=M0DZXIVbNgJSradmHPNiiP9hdrtbHC95ehX21ESGU1X+R3n5CkX4MLua09anKGZomz
 eHkSH31H2wH62cCycqvjvtggpRwW79yhJDtbPQy9dekTZFJKPJRshzkae2LAbW+j+IFE
 HjS170C5HeS7MFS7kCa8y/7d3m3YB1khn823Tntza/l02jnw6IyR8wV5C2FriTco0+/6
 3AjaU9eqS05PpZGSqJeCnkr4hvdvNSBOaFFdwdPUjQvU/IIutSbAaDS/AIaSnzEaeJSZ
 u+buu/17kdxBt+tk9mT/v+jKArtLA7QVhcYvmEKjBeOGkN1Hg2btfgCgG2pea3RC2b+d
 zuiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GecFeE0q4BMb2iBJhEN5uz3jHpZqm6m+/ygNhJJbpnw=;
 fh=4SkwuoYsohTajnS9ThUOqh8nRYX1V8duGt1952VKGEc=;
 b=ONHMs1uPQCVfiKA1FFxhoCPI8VTrTUXt+sMuy89T8CRIQFGl9fWlZm+4mZIgsttM8L
 NHgZZJSpyoIO53Phzev6vxuSZfSaSgQ75u+OlbmhB43/gheCB452eP3HaOYiG6kdpaJ7
 eDWjKv3fanBzLjiNA36tPamx9UyPcI7/QuM0j0Ur5XL+r2yiL4wD4T2i2C13LFaip0HC
 69TSee2+PcFfOihCKWcj0foQpPChyXIYY61hC3Q3Ntyc2/iP0LWz5SHpeCj46U6CTaSs
 AUYfSWDF48O3A5CmtGCRWNAbGKHrsOHyiI5G2GCAnFd6DlMoY2qajx7BQmDupKCJwDF/
 qRWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793418203; x=1794023003; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GecFeE0q4BMb2iBJhEN5uz3jHpZqm6m+/ygNhJJbpnw=;
 b=zH3QZLL3N13WIiFUKkoayVLPRSje8Cs6nSFPQRO7atfT5uPLnOJkKofpudjYSTlGaK
 SljyeUQg0rmkV203rhTEbfaLBRUOAGSDpEG6ErjyKyPOn1ZV4XmZX6T29YGifFKB/Mbp
 LbhM5aiIirdt/+snAbEIhGj+lQNeqvJmn+h3+yV1FT8T/pauYy3/wl2YAC9aCwFgOtFw
 Xize+xM/UOfk8654cXYXAXrV51/IHJEgNuH+DdaDBPECRTJnW3GUPIh9/WtA4GWRGYI4
 qRq+RmuG2Y68faLktDTZ1+lTxBFDsWPxfuFnXhwX1OK12Z2ybGKCWzlZJTJdFAZI356N
 oYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793418203; x=1794023003;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GecFeE0q4BMb2iBJhEN5uz3jHpZqm6m+/ygNhJJbpnw=;
 b=G6lGmBcf/ZZG3iCksN42VyvtZoL3r6ttuqsgRvaxbBdRJ9kLfTCZZXzwjYj7X0U9u3
 lM2Sh8NrxoZ+0YKOH+bgVxQI8tY3DX5IShr65YCA2xAjtiIsM56zx0ERTQwJg56GTa3z
 +yLkbvwPKEDbDHA9EZII4WCX6C/XJJPQy0B0I2Rh76L1Mdxf6LZxuplbhRn7y2HryQD4
 hHQ9DA00Rg9RRouYx0s1EhTt30HTV3pzw/Ekx6Ez/KuavbLXVL3tXyqb/Os4QHK+UOeH
 RO7exvapokIA9SiWAqJumQjCSNMh7m1a4bpQLz8TOi9Uhl23gfwtl03uzjbH6wnJx8om
 GpOg==
X-Gm-Message-State: AFq9FYKrpL75indfDBZrCkq47UmI6JX7WoAVrMPnGL9+nbbUS2o0lcad
 YDjVBVTVBr21z9bcoIyZOmSUyDVCnVjKE8CnGf7qo7BHjpGgDiAc6t+mhP1oNTWkwksIwN9zGWp
 gZctAUGsVWK3WCQ9iA4c+/EZt77S0tYc=
X-Gm-Gg: AYBFou0ypTTAquLlvVaJXqZooA28sfXon3auPptz0s9TTlNiXilXXNOcsNT9DxeIAAs
 nme8LtE0LmTdZcmbGiZvclZs8Ia/fE+EOEUjWR10RqiLoFo++i+3OTkRG10c8NnrY9g6fet1mQl
 F0pSraeBhhGwUyvUeeSNuB3on1QwtY2MTEUv+cUeNbYUWsfBxuMT/Pwgv8SLlIVRshrPCvqgrGi
 OCpiRH2qkXitQkWNXEpm397o8oHrzcLT5hKOIn3zdOQE1QTP8xrDIu1/+ZJlOijQuX9lm+k38kX
 IrvVig13pdGhWtVbToIXh3NJLmBJfE0JTrDrUSweWEC08VKa192Bvj7MPLH1vjrqaTDyooNZQE5
 Fj+aYAV0FHj0sJULYdbwTvYBL19gMIHuucJJQ7ZUlcVLCYsy9CwHG/cWDFu8927yQ9MI++Okz7s
 M+/byhFI96gXyuA2NkrnX/1BTQFoA70c9IVkIHu8Y4HvSqM9rha+x3SgQW/O+C5Z9Z7rHe4cQz8
 g==
X-Received: by 2002:a05:651c:50c:b0:3a9:c1de:852a with SMTP id
 38308e7fff4ca-3acb7963315mr9148371fa.3.1793418202970; Fri, 30 Oct 2026
 20:43:22 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030185551.193092-1-richard.henderson@linaro.org>
 <20261030185551.193092-5-richard.henderson@linaro.org>
In-Reply-To: <20261030185551.193092-5-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 30 Oct 2026 23:43:10 -0400
X-Gm-Features: AclHuK_hCYWqM_ezDQ8LUV46W9hJEUPUKjov52ttoGcNcldmfRtm27FpjxcuJEI
Message-ID: <CAEdQ38EV01YW+_5fQZWYyw2zMV-sKB2QXxvMBENGOZt6cjswzg@mail.gmail.com>
Subject: Re: [PATCH v7 04/14] target/ppc: Use tcg_gen_goto_jc_tl
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 2:56=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> @@ -2649,7 +2649,7 @@ static void gen_lookup_and_goto_ptr(DisasContext *c=
tx)
>              pmu_count_insns(ctx);
>          }
>
> -        tcg_gen_lookup_and_goto_ptr();
> +        tcg_gen_goto_jc_tl(cpu_nip);

Not new here, but both callers just above this test
ctx->base.tb->flags & CF_NO_GOTO_PTR. That's a cflags bit, so it should
be tb->cflags. Separate fix, I'd say.

