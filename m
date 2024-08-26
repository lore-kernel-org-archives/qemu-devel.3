Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDBCC5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 00:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siNEW-0002WH-48; Sun, 25 Aug 2024 20:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNES-0002G7-OR; Sun, 25 Aug 2024 20:05:17 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNER-0000tf-1X; Sun, 25 Aug 2024 20:05:16 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f3eabcd293so44145911fa.2; 
 Sun, 25 Aug 2024 17:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724630713; x=1725235513; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHlJRaBtIDTmH2AG8OZYvll6qWQ9sD6hvDte2Q2QKzU=;
 b=FU95UOzeOOmxanxfuQ9HHQYtxvHPYqk8ncauUEEYm7G+8yClT/iPh8C5mzldpjjIDc
 TEzCVdBpYC4qunBeShBLepqMebhi+lSjcKSlW/xsJ1Ddxrkf4E8mA9TydecRdlQmpeMu
 caiosDhLlYQTmE3CJWOmjIv0LPe5lj4MyXrKrZFCPIJIfTyKgY9tIA/yzY131HAY+tzs
 rNoMdryn/y25qtJj3O3mb8sra863lBFggFsT/pxRFncNOkC6L3auXfBMOZI79jfDqmvN
 Xqn6kgZAqklaCXDOCCoR6LnjXFGLQqdiXpjuWD4Hl5mxZjdffXAZoOAs7s5TjViTklQC
 c27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724630713; x=1725235513;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHlJRaBtIDTmH2AG8OZYvll6qWQ9sD6hvDte2Q2QKzU=;
 b=QprXwGAOrCuseTZbjZ3r4y1b+bJr4syxFptBYFWxkrwOttGRQy94BqRQEAzGSVOT1f
 ZmCoV/wkB2uYmF0EaSvsmZmlWHEu7kiB/dR3ql7smng+RDAHJx2URj4BvMiFbkKTy/ha
 kjvxAGE6y31YyMDU9ViOop6EgF8nWg7oVzVQaerwX66QT3MGgOGw6nCCZ1AnUFLQKd6e
 uYInQV0wejwAP92kyYtUp5k0jUs7lBpDoYU8ZKZlE9xD+6+lhjx4S2RAOASU7ePL5I7s
 xVZ2kXQMIq9654VtZy/kc+DxHw4nkSp1NwNu5GqaAyJwJTOqnDsnmvUG/Qz78oh43tuX
 l7Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfhSNnoNOmOnQROMLjQQTDuDvMn7+6CVU8BCy9PSA9KB3IM86NiihJgTLi8UOUd48VD/oKsmnciXlJ@nongnu.org
X-Gm-Message-State: AOJu0YwCAxpssFlP2iEXwRkMnn3XDmAwWZz2jffee20cZVRdtkjxJGhW
 vnB2zEE96yma+QPlKwQvRf0lg6zmcOgPaeSnGdsq+KmVGi/SsS4gyzsKIkpivmSvmxngmnpx2Jq
 YPbBTAKlDzcg7rHRJLpoYhA3Syus=
X-Google-Smtp-Source: AGHT+IH1ge9QtSbC2RFO6yi9rW2tkxjnQXcDU1t7Upa4qLD9DHiRE8REqzk8iqGW+hpo2PjdoirGWsW+zSQ9pwQt5sE=
X-Received: by 2002:a2e:9ec6:0:b0:2f3:ac52:416b with SMTP id
 38308e7fff4ca-2f4f579934emr46444291fa.35.1724630712128; Sun, 25 Aug 2024
 17:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240822162127.705879-1-peter.maydell@linaro.org>
 <20240822162127.705879-3-peter.maydell@linaro.org>
In-Reply-To: <20240822162127.705879-3-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Aug 2024 10:04:44 +1000
Message-ID: <CAKmqyKPsErvX61F8fF2d8PcdHcQcH5KsEtBRpr-7Va=4W62Zcw@mail.gmail.com>
Subject: Re: [PATCH for-9.2 2/6] hw/misc/xlnx-versal-trng: Free s->prng in
 finalize, not unrealize
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=alistair23@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Aug 23, 2024 at 2:22=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> The TYPE_XLNX_VERSAL_TRNG device creates s->prng with g_rand_new()
> in its init method, but it frees it in its unrealize method. This
> results in a leak in the QOM introspection "initialize-inspect-finalize"
> lifecycle:
>
> Direct leak of 2500 byte(s) in 1 object(s) allocated from:
>     #0 0x55ec89eae9d8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-=
from-laptop/qemu/build/asan/qemu-system-aarch64+0x294d9d8) (BuildId: 6d5
> 08874816cc47d17c8dd775e8f809ae520e8cb)
>     #1 0x7f697018fc50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:=
161:13
>     #2 0x7f6970197738 in g_rand_new_with_seed_array debian/build/deb/../.=
./../glib/grand.c:202:17
>     #3 0x7f6970197816 in g_rand_new debian/build/deb/../../../glib/grand.=
c:286:10
>     #4 0x55ec8aa3656a in trng_init hw/misc/xlnx-versal-trng.c:624:15
>     #5 0x55ec8ce75da1 in object_init_with_type qom/object.c:420:9
>     #6 0x55ec8ce5d07b in object_initialize_with_type qom/object.c:562:5
>     #7 0x55ec8ce5e91d in object_new_with_type qom/object.c:782:5
>     #8 0x55ec8ce5e9f1 in object_new qom/object.c:797:12
>     #9 0x55ec8d65c81d in qmp_device_list_properties qom/qom-qmp-cmds.c:14=
4:11
>
> Move the free to finalize so it matches where we are initing
> s->prng. Since that's the only thing our unrealize method was
> doing, this essentially switches the whole function to be
> a finalize implementation.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/misc/xlnx-versal-trng.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
> index 51eb7600414..c0d1dde8708 100644
> --- a/hw/misc/xlnx-versal-trng.c
> +++ b/hw/misc/xlnx-versal-trng.c
> @@ -624,9 +624,9 @@ static void trng_init(Object *obj)
>      s->prng =3D g_rand_new();
>  }
>
> -static void trng_unrealize(DeviceState *dev)
> +static void trng_finalize(Object *obj)
>  {
> -    XlnxVersalTRng *s =3D XLNX_VERSAL_TRNG(dev);
> +    XlnxVersalTRng *s =3D XLNX_VERSAL_TRNG(obj);
>
>      g_rand_free(s->prng);
>      s->prng =3D NULL;
> @@ -689,7 +689,6 @@ static void trng_class_init(ObjectClass *klass, void =
*data)
>      ResettableClass *rc =3D RESETTABLE_CLASS(klass);
>
>      dc->vmsd =3D &vmstate_trng;
> -    dc->unrealize =3D trng_unrealize;
>      rc->phases.hold =3D trng_reset_hold;
>
>      /* Clone uint64 property with set allowed after realized */
> @@ -706,6 +705,7 @@ static const TypeInfo trng_info =3D {
>      .instance_size =3D sizeof(XlnxVersalTRng),
>      .class_init    =3D trng_class_init,
>      .instance_init =3D trng_init,
> +    .instance_finalize =3D trng_finalize,
>  };
>
>  static void trng_register_types(void)
> --
> 2.34.1
>
>

