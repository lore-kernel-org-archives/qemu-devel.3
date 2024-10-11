Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B718D24464
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 01:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz4uu-0000JL-6A; Thu, 10 Oct 2024 21:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz4ur-0000Ix-2N; Thu, 10 Oct 2024 21:58:05 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz4up-0003HK-6q; Thu, 10 Oct 2024 21:58:04 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4a4575edca3so497574137.0; 
 Thu, 10 Oct 2024 18:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728611882; x=1729216682; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ni2losCWUiuq/VOKYga9osJjI39bTzIqU9bjfUJ6+v4=;
 b=Ow4zglXmJlQfLiyz5LqsD+1kMSm83gmtwXvphl3v/U8xY8T45KOvIEkNsw/3m9jENa
 NpUoWhX8SkK99VpAUt7XQskEQWhPii3dtCyYGLWdqnb+UDAH9Ozza/mJHApv2L/7CQ8n
 ZnlKx3krSFoeF6bThkCSzi0Cr829CysnEOM2Vm3rdVxWlIsCu2Vwp/OxFvt/UKztItpf
 hwKu35Y5fcEypiGrtRwHz6EgAyw2WGqx1++LBk/YuHmYJUb0BXXB5w+SLK8F4NlUSlx0
 KLrzHlGQmsy2wwcab6BlS5rzomwTg0fKoK7SH/6LJ6cFQSW2HKA2Ru192QdLMaWzrrjC
 bO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728611882; x=1729216682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ni2losCWUiuq/VOKYga9osJjI39bTzIqU9bjfUJ6+v4=;
 b=W50A2ZHcktRhgYvaDpeMDa6HQcgmnYMsKITHIOxECIIEPA1ccZkfmOBjfQIgidcf7O
 +F6IeeXUcvTkSDyVNcnJR9RAV0j/aOBE16d+OHMdTO2ywDPr9hjpAuVlzK4BBolPeLqG
 41JM4Uu5eQ5cp6cdpoaFRc9e7cgomRE1HozixYRkIhOM12vfN8RjHAkgeVxyT7c1V6ii
 YPMC+6qFU+NO/yRLr2wlp8NewFFXuM/capRruDTht+0ynwNEij2VXHJb0/QvGVaFtbb/
 rUXDxowzQyOzfopNC37JPKy477r2pk7+fmJXGgo8hUwD+zjb89gYa8jKBpjQ5KBMTKfH
 axaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsmqpLR6QnVKk6NO7+/HVUw2fVUxgBZTlib2DM3HtnGC1AQMVUCTmYj2iQwa/LCHX8KBb7CA/+f/f8@nongnu.org
X-Gm-Message-State: AOJu0YxOodHXAlBVJzXRt6xzkLeaLhCOPBLFBwH4ToVrVpVgvmr6gwn0
 g2xLNl/knsgmEGdPsk4uiCiuVvexdk4hru559LaTiy0Jc9MKCkBZyLxL8+Acg+QHr29vkheJVwn
 a2TV6yR8bN0Z+99Ejp0EuWoTcXOU=
X-Google-Smtp-Source: AGHT+IHvi/Yl07tJI3fEdRFXbqx2ld+LSzPOcSqdPUXJtwKBoQw62z3DASbtObYOZfRj4gCrM5M25SyvoI8adoNReW4=
X-Received: by 2002:a05:6102:c91:b0:4a3:be1b:8df4 with SMTP id
 ada2fe7eead31-4a4659c8a6dmr1271267137.16.1728611881676; Thu, 10 Oct 2024
 18:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240924124407.766495-1-dbarboza@ventanamicro.com>
 <20240924124407.766495-4-dbarboza@ventanamicro.com>
In-Reply-To: <20240924124407.766495-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Oct 2024 11:57:35 +1000
Message-ID: <CAKmqyKMMRCFvWYa1GjwkbJsBh8q_OgtA2UVdaNEJsr=N66hvkQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] target/riscv/kvm: add kvm-aia bools props
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Tue, Sep 24, 2024 at 10:46=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Boolean properties are preferrable in comparision to string properties
> since they don't require a string parsing.
>
> Add three bools that represents the available kvm-aia mode:
> riscv-aia-emul, riscv-aia-hwaccel, riscv-aia-auto. They work like the
> existing riscv-aia string property, i.e. if no bool is set we'll default
> to riscv-aia-auto, if the host supports it.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 77 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 32f3dd6a43..e256e3fc48 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1671,6 +1671,62 @@ static void riscv_set_kvm_aia(Object *obj, const c=
har *val, Error **errp)
>      }
>  }
>
> +static void riscv_set_kvm_aia_bool(uint32_t aia_bool, bool val)
> +{
> +    bool default_aia_mode =3D KVM_DEV_RISCV_AIA_MODE_AUTO;
> +
> +    g_assert(aia_bool <=3D KVM_DEV_RISCV_AIA_MODE_AUTO);
> +
> +    if (val) {
> +        aia_mode =3D aia_bool;
> +        return;
> +    }
> +
> +    /*
> +     * Setting an aia_bool to 'false' does nothing if
> +     * aia_mode isn't set to aia_bool.
> +     */
> +    if (aia_mode !=3D aia_bool) {
> +        return;
> +    }
> +
> +    /*
> +     * Return to default value if we're disabling the
> +     * current set aia_mode.
> +     */
> +    aia_mode =3D default_aia_mode;
> +}
> +
> +static bool riscv_get_kvm_aia_emul(Object *obj, Error **errp)
> +{
> +    return aia_mode =3D=3D KVM_DEV_RISCV_AIA_MODE_EMUL;
> +}
> +
> +static void riscv_set_kvm_aia_emul(Object *obj,  bool val, Error **errp)
> +{
> +    riscv_set_kvm_aia_bool(KVM_DEV_RISCV_AIA_MODE_EMUL, val);
> +}
> +
> +static bool riscv_get_kvm_aia_hwaccel(Object *obj, Error **errp)
> +{
> +    return aia_mode =3D=3D KVM_DEV_RISCV_AIA_MODE_HWACCEL;
> +}
> +
> +static void riscv_set_kvm_aia_hwaccel(Object *obj,  bool val, Error **er=
rp)
> +{
> +    riscv_set_kvm_aia_bool(KVM_DEV_RISCV_AIA_MODE_HWACCEL, val);
> +}
> +
> +static bool riscv_get_kvm_aia_auto(Object *obj, Error **errp)
> +{
> +    return aia_mode =3D=3D KVM_DEV_RISCV_AIA_MODE_AUTO;
> +}
> +
> +static void riscv_set_kvm_aia_auto(Object *obj,  bool val, Error **errp)
> +{
> +    riscv_set_kvm_aia_bool(KVM_DEV_RISCV_AIA_MODE_AUTO, val);
> +}
> +
>  void kvm_arch_accel_class_init(ObjectClass *oc)
>  {
>      object_class_property_add_str(oc, "riscv-aia", riscv_get_kvm_aia,
> @@ -1681,6 +1737,27 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>          "if the host supports it");
>      object_property_set_default_str(object_class_property_find(oc, "risc=
v-aia"),
>                                      "auto");
> +
> +    object_class_property_add_bool(oc, "riscv-aia-emul",
> +                                   riscv_get_kvm_aia_emul,
> +                                   riscv_set_kvm_aia_emul);
> +    object_class_property_set_description(oc, "riscv-aia-emul",
> +        "Set KVM AIA mode to 'emul'. Changing KVM AIA modes relies on ho=
st "
> +        "support. Default mode is 'auto' if the host supports it");
> +
> +    object_class_property_add_bool(oc, "riscv-aia-hwaccel",
> +                                   riscv_get_kvm_aia_hwaccel,
> +                                   riscv_set_kvm_aia_hwaccel);
> +    object_class_property_set_description(oc, "riscv-aia-hwaccel",
> +        "Set KVM AIA mode to 'hwaccel'. Changing KVM AIA modes relies on=
 host "
> +        "support. Default mode is 'auto' if the host supports it");
> +
> +    object_class_property_add_bool(oc, "riscv-aia-auto",
> +                                   riscv_get_kvm_aia_auto,
> +                                   riscv_set_kvm_aia_auto);
> +    object_class_property_set_description(oc, "riscv-aia-auto",
> +        "Set KVM AIA mode to 'auto'. Changing KVM AIA modes "
> +        "relies on host support");

This seems more confusing. What should happen if a user sets multiple to tr=
ue?

Alistair

>  }
>
>  void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
> --
> 2.45.2
>
>

