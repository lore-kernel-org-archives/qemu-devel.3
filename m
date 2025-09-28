Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F56CAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 23:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v30tX-00027x-PU; Sun, 28 Sep 2025 19:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30tU-00027X-Ut
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:33:28 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30tN-0005lF-M8
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:33:27 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-afcb78ead12so681670966b.1
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 16:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759102392; x=1759707192; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhWH4Dui1rGCpq9x3MFD5ISgK9Qn8MUhUgNScVuPsDQ=;
 b=Ul0ZEdXzc3QBPU2aeIa/0Kb0C5uwcg6VrNi1Kwbd5JrtcbC7QtFPwYa03n7Wi8dJMi
 aTPE8ue26Ej4rec1FeD7tbcbS8itIbYtX3G8LHjDWrRMAI5tqBPfA7IVk6R8/lLhc4s8
 JYvMAVapx85h59TKGJEPPsEqDepVrN1juH5mYJp68jlOwu5cLnFzB5uXDApVotLGaVOj
 pq1lq1nglo+g3752iYQUOeX/M17EaTuJnP2VFUqSLJAorVUbeYgWECDrsy7Wr3iDT80w
 F7dj+xyaGkBrH2OIO1Wde/6oEpVNu6B5lPciBAgH17yP3eXOMTREjR4soQcM+4LH8MAP
 f1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759102392; x=1759707192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhWH4Dui1rGCpq9x3MFD5ISgK9Qn8MUhUgNScVuPsDQ=;
 b=HO3wZBKTKVTT1/2brZCPMQBZlXAJwRzxMtNTyyQdx/Ml+6lGePcs4YQSeTYQQGvExl
 Y3BMuzkh2xVzd+PNi3GYxPW4is1qn3Zqy6aP/he0Wfb9xPLIb7YZCDrAQeNzv0jR1Cme
 ZHe4fzcQU3VP5j0n7fkPJUnM05LPgcg4jVR3H3k+1Bb4OTebalNh1U5vTHRfCmzrX/lE
 9Ze4/8gaUlbL4r2Pc44TRx06/3CFVa1Vp78jim4LCrTi0UJ4kY65QrhKs33Nbjq9HoWn
 GyWfbuZmH+pE5Yo/fyVvsjXlrRd+Oi2hl9eh8SYSwvvE/w8m/aTCoSBNcOV21cUqst51
 0NYg==
X-Gm-Message-State: AOJu0YyWVrfMU9xhjsZht3iayP7Xh8TYWHT3BsFbLZDFmG+kd0pCBPoL
 xgtxR0DoBOPeDbjjTJnyUm+L+ILdLyuEUdMwwSXLi7ckefeKohybG57geNub2k/wkMo/mTmJsGL
 KBOXYPSLDJ6BN4ZUQlEbSOWCwXhpyxVk=
X-Gm-Gg: ASbGncvzH7JDhjufQKGye/9C9PHn2c+XoHZE8Q2IyW1lR1+n6Is0CdW6up70wxgK7aV
 7mbRI1+Ihei8OMAgaiCP5aqJS8yBc6yHzDyzrq5ENjjhzzQXQVL+Z3dh3+0ZcbZnntnGyyjjzNp
 cqtFzve+Wv785kvMrkmQDhJAU6xXGU2ak8gFRbXkdOWNiyyWn+pNqioWEI5akz8GPN5flQ7I6vl
 baBilnc7R1PP1Uq+7AFLqgQi2z3ex3/AUxHY+NmFcv+ZwYX
X-Google-Smtp-Source: AGHT+IECH0/oSazbVrdfFdm/JfzkDqZVsp4SFIWq1mLOuuBSOUoz/G5O06mZfxzU7cINgU1znKd49oLTvSGa5vgW6Ew=
X-Received: by 2002:a17:906:d89:b0:b3c:1bfc:c552 with SMTP id
 a640c23a62f3a-b3c1bfccd7bmr358170366b.42.1759102392336; Sun, 28 Sep 2025
 16:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250917114450.175892-1-luc.michel@amd.com>
 <20250917114450.175892-2-luc.michel@amd.com>
In-Reply-To: <20250917114450.175892-2-luc.michel@amd.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 09:32:46 +1000
X-Gm-Features: AS18NWA3Gnr-ywJAxpoV4xPkHuyv0nW5sk3IzR5oWSPT_cKRsW31s7nSd56uKOM
Message-ID: <CAKmqyKMGTQVbRdndgu+JA1ZvdJP8+i6m+LX3chWm_pW4nkwXrA@mail.gmail.com>
Subject: Re: [PATCH 1/7] hw/core/register: remove the REGISTER device type
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
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

On Wed, Sep 17, 2025 at 9:51=E2=80=AFPM Luc Michel <luc.michel@amd.com> wro=
te:
>
> The REGISTER class (RegisterInfo struct) is currently a QOM type
> inheriting from DEVICE. This class has no real purpose:
>    - the qdev API is not used,
>    - according to the comment preceding it, the object_initialize call
>      is here to zero-initialize the struct. However all the effective
>      struct attributes are then initialized explicitly.
>    - the object is never parented.
>
> This commits drops the REGISTER QOM type completely, leaving the
> RegisterInfo struct as a bare C struct.
>
> The register_register_types function is left empty here because it is
> reused in the next commit.
>
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/register.h |  7 -------
>  hw/core/register.c    | 18 ------------------
>  2 files changed, 25 deletions(-)
>
> diff --git a/include/hw/register.h b/include/hw/register.h
> index a913c52aee5..4d13ea183c7 100644
> --- a/include/hw/register.h
> +++ b/include/hw/register.h
> @@ -73,25 +73,18 @@ struct RegisterAccessInfo {
>   *
>   * @opaque: Opaque data for the register
>   */
>
>  struct RegisterInfo {
> -    /* <private> */
> -    DeviceState parent_obj;
> -
> -    /* <public> */
>      void *data;
>      int data_size;
>
>      const RegisterAccessInfo *access;
>
>      void *opaque;
>  };
>
> -#define TYPE_REGISTER "qemu-register"
> -DECLARE_INSTANCE_CHECKER(RegisterInfo, REGISTER,
> -                         TYPE_REGISTER)
>
>  /**
>   * This structure is used to group all of the individual registers which=
 are
>   * modeled using the RegisterInfo structure.
>   *
> diff --git a/hw/core/register.c b/hw/core/register.c
> index 8f63d9f227c..57dde29710c 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -256,13 +256,10 @@ static RegisterInfoArray *register_init_block(Devic=
eState *owner,
>
>      for (i =3D 0; i < num; i++) {
>          int index =3D rae[i].addr / data_size;
>          RegisterInfo *r =3D &ri[index];
>
> -        /* Init the register, this will zero it. */
> -        object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
> -
>          /* Set the properties of the register */
>          r->data =3D data + data_size * index;
>          r->data_size =3D data_size;
>          r->access =3D &rae[i];
>          r->opaque =3D owner;
> @@ -317,26 +314,11 @@ void register_finalize_block(RegisterInfoArray *r_a=
rray)
>      object_unparent(OBJECT(&r_array->mem));
>      g_free(r_array->r);
>      g_free(r_array);
>  }
>
> -static void register_class_init(ObjectClass *oc, const void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(oc);
> -
> -    /* Reason: needs to be wired up to work */
> -    dc->user_creatable =3D false;
> -}
> -
> -static const TypeInfo register_info =3D {
> -    .name  =3D TYPE_REGISTER,
> -    .parent =3D TYPE_DEVICE,
> -    .class_init =3D register_class_init,
> -    .instance_size =3D sizeof(RegisterInfo),
> -};
>
>  static void register_register_types(void)
>  {
> -    type_register_static(&register_info);
>  }
>
>  type_init(register_register_types)
> --
> 2.50.1
>
>

