Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED326C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 02:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0AFL-0007Kc-Ou; Wed, 02 Apr 2025 22:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1u0AFK-0007KU-JX
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 22:23:58 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1u0AFJ-0007pT-2r
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 22:23:58 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac339f53df9so70294266b.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 19:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743647035; x=1744251835; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwYvqZubT95wB55iqEL+orSxR2/hZ6ceYcxdu3NlnmU=;
 b=MG2etgZ5lHrQ15ZO/TFaBdsq82eAG8jPcP1t8dF2idMEH1tab8GVdM4NxuyARTpHN8
 UKqs4gbm4n1fxyRUPx+JKl69E1jyhF1rO7ciyELu0tgE2D50a9wkc0xqY4ZS26D+OCXg
 2naqRv9jtUG90BbwVXx+9J+46hvPNcI0JU5pQu/8hQRbzQaQtVk1bJr3OJ/4cM/VU+jO
 5OT4zvfvbtyJU7Gc2OZCUKWleKSQBQyDNNrrOD1fZmThjdWX7MEAmSaiWRoLIBHSgb4Z
 zU5waQ1xr4nB6G3jCrzkVdGd0PZ8RTcpS98ma650gHj6XvtExy5RqkKwWLhNHROfNywG
 i6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743647035; x=1744251835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UwYvqZubT95wB55iqEL+orSxR2/hZ6ceYcxdu3NlnmU=;
 b=KYE3wB8J4jhgBH7iwIOCpSD2xFKBNQ8hGbv0XRvARbws0LKQGURFarrcCOlVvOZo8w
 n78aN/D8w50Rt0CXkaYBZWXYUCym9iHUNY7MD/FZtk5tpwrwEG13ABBr9DHq14QXv9F6
 nbD2qAjRU4sIVMjR+Nu0dKsDzi65N9YB4Zan+uwSvm1NvpDp/HCHlpyFEYTPA4dhcunC
 y4PIzIEyCepGnR+oey5nBL1E9nel0JZVD3zCRZ1QIgArbV6M42YBBfXs5C1X7T9Hh2gh
 gBr89A0hhjTzp0O1VKWSw9tGO/WPRtD7tcuGQjhYgPt6Hfdd9EE5m2gensrgpwP1d/DJ
 qqew==
X-Gm-Message-State: AOJu0YwHuuENK8rC4f84g4ZJyar6GaqBZ9T9Edoqm7ZZrcVwbv6dl649
 BSjXCjYfKKxZ7C3LcGuIIhZ/y+536qvu3bbqDlXzERE7WgqyYIUsqAnsuXn+CzlYFPN/KuHfjYe
 w5WwOqj9tBO1xBZn9jpLvEnnFymh2bFSHSv7L3g==
X-Gm-Gg: ASbGnct+aXVvvU1Sbpg6uTCoA+UOv8/RwFcUzHpSGV+IRZvs4Gwln5+IgGfnXA+aTng
 GdptD4VM8EUHwTARbmfezaYyDufZPbtIY2eG/mGkzjQAIyl0PYLGNUUtbeZebHYDqU9aYVzSB/f
 T4RxfAXLiBGAsOGEmozE09ZM8SeIM=
X-Google-Smtp-Source: AGHT+IGexXGXXx7xDw8ZR6tzwRHzI7egiyBLYvla0R6vRv5Iyw1qLmRQAf3dt2AQkf+HgHgOKWxcFos38Dv4Tbk/XQQ=
X-Received: by 2002:a17:907:3d89:b0:ac3:9587:f2ac with SMTP id
 a640c23a62f3a-ac7bc15f2f4mr77881466b.33.1743647034710; Wed, 02 Apr 2025
 19:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250402135402.14526-1-zhangckid@gmail.com>
 <d39ed054-d99b-46a8-afc8-1a2981d919e1@linaro.org>
In-Reply-To: <d39ed054-d99b-46a8-afc8-1a2981d919e1@linaro.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 3 Apr 2025 10:23:18 +0800
X-Gm-Features: AQ5f1JqNca12j6S48RKJAZMiwQBpljqJ1ueqHHSRnYHtO2tumMum8JKfb2Vz8_4
Message-ID: <CAK3tnvLqGLzQffAi=dk_VzXgH_k_r_z2xNTN3tVE-G+xjpPWcw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt.c: Fix wrong default cpu type in AARCH64
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Apr 3, 2025 at 2:43=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/2/25 06:54, Zhang Chen wrote:
> > Because of the CONFIG_TCG auto enabled, the cpu type "cortex-a15"
> > is mistakenly set to the default AARCH64 target.
>
> This is the correct backward compatible setting.
> In essence, it means that you *must* supply a -cpu argument.
>
>

If the "-cpu" is required, the VM should not be started without this argume=
nt.
If yes, I will skip this patch and submit another one to make QEMU
refuse to start without this parameter.

Thanks
Chen

> r~
>
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >   hw/arm/virt.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index a96452f17a..63649e9543 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -3178,9 +3178,10 @@ static void virt_machine_class_init(ObjectClass =
*oc, void *data)
> >       mc->cpu_index_to_instance_props =3D virt_cpu_index_to_props;
> >   #ifdef CONFIG_TCG
> >       mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a15");
> > -#else
> > +#ifdef TARGET_AARCH64
> >       mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("max");
> > -#endif
> > +#endif /* TARGET_AARCH64 */
> > +#endif /* CONFIG_TCG */
> >       mc->valid_cpu_types =3D valid_cpu_types;
> >       mc->get_default_cpu_node_id =3D virt_get_default_cpu_node_id;
> >       mc->kvm_type =3D virt_kvm_type;
>
>

