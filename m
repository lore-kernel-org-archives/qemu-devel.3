Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38DFCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4DL-0003A1-GJ; Mon, 01 Sep 2025 09:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ut4DF-00035K-3y
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:04:45 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ut4DD-0005z6-7U
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:04:44 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b0225483ca0so314799566b.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756731880; x=1757336680; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HlKj8OKSsrbMCx7XTlHagNjOcu9W5Y4qb5a5EzELU08=;
 b=bmB9l1XGA/TfBDcspZ9XHhtjTd/ncZXUKiUWNrLqdXR4whKmfdc9EGDZ/dTf71XqRp
 RKa7PmA/CxhkttFjDwHmUQSBRjXErTB/1IlDkJlyGkflz29hRiFBq3RmdtvtQ95UYW2+
 bFrB+v5YiKnTu686g4b+xu/ZD1SgK2tq2sGV/ngLBctf6wSkca1NHIkKsXDayA1UinXb
 UOZl3m7L7lfIps4AgWNNyTgtlKWzZzIeJmcHKpFiEbWn3ZwcZi2HIRaN1Ul3IPwiWZ1A
 rBDd0vw14mtHYb+H6o+wEEOkVy35HIqqhdP4W2AfceyhuVuDNEvDayTTTHZ4w6RWjNqR
 mlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756731880; x=1757336680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HlKj8OKSsrbMCx7XTlHagNjOcu9W5Y4qb5a5EzELU08=;
 b=b5Erze4mm31V0J18RR5GFzrUgy938K9HVPxM9+PEvktAP/wcgGdXXzgmOnFmC9ORbf
 pWecYiIsowig1X6+dCuwHbW/gxmiCkS76ST99gUkuqL48UcLblbqDojKeM4cz1NzXl5N
 2WvAlzkuvWoi+y5S/Zz9B3l5HQ4rySAKIZSJhygBau4XVeyb1HEbw3H1qHOkfnbiYEge
 gBe7cqcqJSIh/B/p2u7kEtNtX1QdkHnMiY2mN0ZrEOba2raul3hIPvxAw0vcmVal/Dio
 bTbJPgk2uva29pJl/NbwV+dZugMFozmEZ/tqUM/ceU1j+AhvX05/PbUSCwSi8vRVPWVp
 jD6g==
X-Gm-Message-State: AOJu0YwaAqE5LnBqiU/qJueooLcJSE4ysaNSh31C3yd8PtyaUjer3Aea
 wbT2bkcQXAxE9z6h2Yx2Xd9+bTUfbMSb6dHgrQfUAmQEWXLrY0Td5RcJdhM/crjUuP3yyoewiED
 fLYRieSAGta+zMZ2VxFxKnnKGQsBYPGv39YhB/LpDOQ==
X-Gm-Gg: ASbGncteD18qBGZu0yIZ0kqYTzAPtZJEL0Za/QLlTWEZffKi6Jym4bl6Iw9hEJ2R/dy
 JxMGglkij+lczb/MRjtLy8YLYsWgkoaoPF5IKOwCoQrcpOfRvUPSZihgQw1aV0YuUXmkKQh9dty
 Wm6CZrxlUaXqSXElSHAAIn+akkSj7PS8CXeUZkPu05z9L6Xs++0ts96lTIutErcAtwInRTF7BZO
 A4k1m/zDmtUnpG21o4=
X-Google-Smtp-Source: AGHT+IGX1I49kNkvlURV0IXi8xO0t68krtT9V1FmXjJ76QABfAyRucSfyA9zVbHRFLdUUVfXLKRNcAtjBb8dA6WgYB4=
X-Received: by 2002:a17:907:c27:b0:afe:63ec:6938 with SMTP id
 a640c23a62f3a-b01d8a308b8mr799651966b.7.1756731879870; Mon, 01 Sep 2025
 06:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250901125304.1047624-1-alex.bennee@linaro.org>
 <20250901125304.1047624-2-alex.bennee@linaro.org>
In-Reply-To: <20250901125304.1047624-2-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 1 Sep 2025 16:04:13 +0300
X-Gm-Features: Ac12FXzcoetJQvq-CpvTIVuKZZaLkftVfX0VbipCW7pubyS08UfUEb4W52rFBk0
Message-ID: <CAAjaMXZNZPyga1xPLemcfF9NDwdw=_nfeW54n5pbbfZgdr7KTQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/arm: use g_autofree for filename in arm_load_dtb
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 1, 2025 at 3:54=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> The function has quite a number of exit cases so lets try and clean
> things up with g_autofree. As the fdt hasn't be allocated yet we can
> return directly from the fail point.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


>  hw/arm/boot.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index d391cd01bb1..56fd13b9f7c 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -528,20 +528,18 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot=
_info *binfo,
>      Error *err =3D NULL;
>
>      if (binfo->dtb_filename) {
> -        char *filename;
> -        filename =3D qemu_find_file(QEMU_FILE_TYPE_DTB, binfo->dtb_filen=
ame);
> +        g_autofree char *filename =3D qemu_find_file(QEMU_FILE_TYPE_DTB,
> +                                                   binfo->dtb_filename);
>          if (!filename) {
>              fprintf(stderr, "Couldn't open dtb file %s\n", binfo->dtb_fi=
lename);
> -            goto fail;
> +            return -1;
>          }
>
>          fdt =3D load_device_tree(filename, &size);
>          if (!fdt) {
>              fprintf(stderr, "Couldn't open dtb file %s\n", filename);
> -            g_free(filename);
>              goto fail;
>          }
> -        g_free(filename);
>      } else {
>          fdt =3D binfo->get_dtb(binfo, &size);
>          if (!fdt) {
> --
> 2.47.2
>
>

