Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C014CD29DC8
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 03:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfVNY-0007hB-Gf; Mon, 12 Jan 2026 22:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vfVNV-0007fS-Sd
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 22:47:33 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vfVNU-00032Y-G9
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 22:47:33 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b871cfb49e6so270118766b.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 19:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768276049; x=1768880849; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QiLb5ZEx8M9NR5t8LDyWjmILwme25uQ9O1jZrSX9v2Q=;
 b=Sx2Gl3pozXt2C8NIMxRI3Q5UAnL7Z7/G0YcwxTwo65Ppd97AuFzRiDV9fbPEIKI5r4
 qgoJfYF4m7Ui9XJgF+3RMMquFwgqIw/6fTwbCxn9VgpwreHZwe0OLBSnk6tOg78cuvIL
 mFdqT0DxatCe08Ivk1hgfubFAPo3z/b59rh3rEDvvp0t37B0TbnFdzluqaPGG8DQlj75
 7cPHLDpN1WFJNLKyu5VoogfSyGSqYPAJPfRpFtyInMOX23EzoStHccb2cipLOC7cDsYH
 ieQcsFSUpIapmJ7CQKDT4PjDVMXC28OhlN04q6mX3a7bpM9rtHRGOcvfE/OJ/XiR4fZ9
 8VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768276049; x=1768880849;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QiLb5ZEx8M9NR5t8LDyWjmILwme25uQ9O1jZrSX9v2Q=;
 b=K9pnNbOyFXOb1ykEMwxwYw/cCERnfbs1S1Qiq/u744NS10+ikjJDiNwVkjMP0EzAje
 zB71KDutV9JIeH/X+3ecBD7ZD33THDTG24QJr7ZW2dOUR+L9F2SVFA+gJKPVKqqDku3N
 ilYg7W9Ngz7ilR0hUP6fyiFKRiMfZ+68iFd/43bPE7gtd2G+SUV0kFMhlzEt57+E35fm
 YCs5HBh+1Ud0WtWTOprzz0JNO0DIzEOzkJt7c9K6k/a40Qmbl0TKB3tfIqIKMjMCq8iV
 veXDKgetVUd+o+ASho77ja9Rl+qV/TBxZquxkHLBieGlmDSNrsQ564S656wN9eH4Z+ks
 M6tQ==
X-Gm-Message-State: AOJu0YwUgCZiduldCzhq4FkzJoA9+0BYCsL2cB89QA54XVPsjz7TmUSR
 YQpUrKyHjLC395Xsl5ByzyRLWtRiqhF4pAFV6hGlZhC7La9lR6JDjvJOsstvp/YW/xo1szv0y1h
 9C1VZwrk27Wm9FgumOG+y4NCeFqeETFs=
X-Gm-Gg: AY/fxX5Vpj5VXgmd9PaRS2xXu0rl/9itAGzi/8qAC50Fxjwk3XsM9JkTT6M+vDzXb8f
 0LwP7WWEIltkQcr/7XFe48WiVqf1M7yIs5a5hOMJeI4MBlrd0JIptzqXbuuwV3G/vqFjxoMGfh/
 I0DLkZfae3YyZOCdXD3J+ENjx4HxVttQsjo8r+4JhVz+brOzyLb7TyVgnfJkp6BmAD5My95Pjh+
 Vzlh/hGb40A3Ev15vzrnlQBYbnV/5mliaK3M3AHYxoUAa+dDEy//KSsWGTx731gxJh8SCSg9fLg
 HzifC1wI/6pME2IrEzB0f1qqqw==
X-Google-Smtp-Source: AGHT+IETIC3AMrl2esXUfhMh+MjgQfCSAViTx8CDWhwlSu4EaJ0Ed3XHnrL4JeBzmMiNsUQk3m9KjGiIS2QnKpyEffw=
X-Received: by 2002:a17:907:25c8:b0:b77:2269:8df0 with SMTP id
 a640c23a62f3a-b8445222007mr2195060866b.28.1768276048655; Mon, 12 Jan 2026
 19:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20260112090458.2345280-1-djordje.todorovic@htecgroup.com>
 <20260112090458.2345280-2-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260112090458.2345280-2-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 13 Jan 2026 13:47:02 +1000
X-Gm-Features: AZwV_Qh3CfKpDHfjr8ksh0Jxs12634Dr_mNI0UjKlwvQnbwLdLPx4rgOrDmZM1w
Message-ID: <CAKmqyKNMt=NH4r8o6k4jLmKJ9Su_y+o++6tZF1okmgVJ11MwYA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] hw/riscv: Fix integer overflow in cm_base
 calculation
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "philmd@linaro.org" <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jan 12, 2026 at 7:05=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Cast CM_SIZE to uint64_t before multiplying by the loop counter
> to avoid potential integer overflow.
>
> Resolves: Coverity CID 1644076
>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>  hw/riscv/cps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
> index 86172be5b3..620f54e48a 100644
> --- a/hw/riscv/cps.c
> +++ b/hw/riscv/cps.c
> @@ -133,7 +133,7 @@ static void riscv_cps_realize(DeviceState *dev, Error=
 **errp)
>                              sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gc=
r), 0));
>
>      for (i =3D 0; i < num_of_clusters; i++) {
> -        uint64_t cm_base =3D GLOBAL_CM_BASE + (CM_SIZE * i);
> +        uint64_t cm_base =3D GLOBAL_CM_BASE + ((uint64_t)CM_SIZE * i);

You shouldn't need to cast this, instead this should work

diff --git a/include/hw/riscv/cps.h b/include/hw/riscv/cps.h
index f33fd7ac86..39029bca8f 100644
--- a/include/hw/riscv/cps.h
+++ b/include/hw/riscv/cps.h
@@ -27,7 +27,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPSState, RISCV_CPS)
/* The global CM base for the boston-aia model. */
#define GLOBAL_CM_BASE 0x16100000
/* The CM block is 512 KiB. */
-#define CM_SIZE (1 << 19)
+#define CM_SIZE (1ULL << 19)

/*
 * The mhartid bits has cluster at bit 16, core at bit 4, and hart at

Alistair

>          uint32_t hartid_base =3D i << MHARTID_CLUSTER_SHIFT;
>          s->aplic =3D riscv_aplic_create(cm_base + AIA_PLIC_M_OFFSET,
>                                        AIA_PLIC_M_SIZE,
> --
> 2.34.1

