Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B249A606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jK21H2TQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM2MB-0007Hw-AB; Wed, 28 Oct 2026 08:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xM2M8-0007Gf-AX
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:02:13 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xM2M5-0006sr-OA
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:02:11 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b21cf1a580so1218955a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 05:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793188928; cv=none;
 d=google.com; s=arc-20260327;
 b=f4BG6mdpmlAJDRDhW9P+aSDGYneSsXmKWndN2fmFJBkOKddcrFnfXlZ4XOhaSYfJ99
 HTEIubzlPb6TG3aEh01Oo/O2dqwr68q7u7+1cg5eh4BXoATt0AloemSDJrB7Iaw6btcf
 UQwyxV448L/8GCClr4MlS+dL4kSixwmmOtyMzOnh7C1VbX2GrKJ11XwHm+A1HV5J58CW
 H7Xk5s4496vRRPbJcp+TlXiLQHg+9Z39Cgz9rlzSrEeitiCQcsfpTvA1H4OcIG76hROy
 3xMNbmqgjxE29br5Fe4263F1s3d7jLEYqYeEIkS0z/Co+xs/tFL8Vk/s3hcT/VjJt5N1
 /06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=u83dDTDHy/7yXqnJBMTt6/ZQ3hz8gxZz2bzWLjmqlJI=;
 fh=46U1FE5Qw0fo7evi6utX9h5HLfzSsvyXi+QDnZDegHo=;
 b=aif8GIzX2CERH56njO5u1yuihfYXqnqWmNxYo3zDae/N5FMaeo+DYb8pCauuontSqS
 wysVWyDG/jbwUFaIRIPIo8Cl905DTPEGfgtv12ZAauwTtL08d6ZsclSSGmAeiZ3qwc4N
 yV5iEXqak4SLLKEs2GTeGfzcL7iMQAfO+/WvRq7frdY7HemDbTiI6cbEzdgQukSJx5aL
 hGeyN6Uubd294ewumiKnw8TUbBkC291eDKsrKHxYoldTExZaAzNq2ZJxtYMgyp+dkCuM
 lHtzig1xMTLXMv+p+ByyqgzVjOi6pVMb46vnvi3mKp06tPPwwbTI60bQ9OxnCRpa1l6o
 7/bg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793188928; x=1793793728; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u83dDTDHy/7yXqnJBMTt6/ZQ3hz8gxZz2bzWLjmqlJI=;
 b=jK21H2TQoornW3ppF5EuRYUK3i0dmKF66aXHJJeGaVl1jqMo217Ybnrx6Y17dSXLQ+
 SyY7e5cqh+30CgVlmpBbd9N3++6OBCiqSFJS0L7GCfVNQL4kfgtYBsDwF3b/vd9FKyBN
 fSkyjUG0p+xJkUi1uvfmeaJUb2FJ45kGselwDi4NZw1oNuOnXLCbdrdHCdyrX0+gXig5
 ix7YyMLjDwICR9m0NRG0BevWZfbAL5MIgbWFWttZQjEKqgOgIXiLxYz9zK7v1cVl6cyO
 OLa9SPyqrouDyT4AEtr6qKVw669RIKBK2FYuiJm/pc7W1/QnslOkZR0Ax5KIy0sqSOuC
 KTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793188928; x=1793793728;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u83dDTDHy/7yXqnJBMTt6/ZQ3hz8gxZz2bzWLjmqlJI=;
 b=Y8IlRsn0zbaYhKds2Qb5g5Tv1Wx4VR54nNDIyL/w9aP+jOJptRgQaOuMR4IUaL5nvV
 sL0pNHJOdLg5cVhpB0z60UZzygM5TQSL7ebyEYN2VvXHSOul8kPmWPYKwr2UI5P4EK4g
 QMh4D1S8i+O104XPrCRjz33Yla/YbauTOXBX3gSKvgYFfgpsoYW8mgNnJsqytrzsq9L9
 naZNl5KFyPTcOic/RLPsReNqxHyigHFbUlsw1iKHyrQCwvCMssQ8MC0940CMVD8kxsOU
 gcY0+HVSl7D4eEwSLilSjojBM8IKyhuFRGD4ctDHTAOQznMIM+LiItzcthtYLXg35LKa
 JEVQ==
X-Gm-Message-State: AFq9FYJqwWx9qigmOPbyHD40zfQG5dZCKUWow6w5Cklx5mEMMkQ+P6QQ
 fLXGmeKFQ+TKupcR3yIIbMFLBh1APFoJAZgR3kNaUTkgLDQVVs/KPlBxj3qg/O2rrp+m+HROBr1
 hbpswShU/+oZkh2VEOJGGiELKhy0tILU=
X-Gm-Gg: AYBFou3qr2V+h/2jpRoDB7vohBJJ6LrAIjRMwRDKiiH6iv7lQqdJ7mql9Wx7nyidBcG
 Ia5tFm9PnerotnU28yVBLZJ5556uhE7CqIlgxUlK21FWTtCc/s+Dh/8c4XaztaXfQqPUXVBcooi
 ch+PLIZGm0c+EW3HIdgM0If2Fh3N2Cu7TTGaFUa09D/0tppZBZcusoxH8ojL+QgrkQhupyA+I7B
 kRgiupuvTEmq6XkrhXtWp4IxtI+xe667DdvZVLd0OMZU9rUKTGmRCgWmKPsdZJ9IHQpeHw5S2UW
 HXg4Fd6JWHJYe4wCZ6WHEsUp9y1nYgPGz/qhpCQSWxDv/Dr2TLZiw1cfmMqs5B9nC14oYMSCvem
 5Eebk8AKLZeCmi17hagU1Os+LtTQTJnNv7Wzy
X-Received: by 2002:a05:6402:6cf:b0:6b4:35af:3264 with SMTP id
 4fb4d7f45d1cf-6b49cc1649emr1016323a12.38.1793188927636; Wed, 28 Oct 2026
 05:02:07 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_4_kLo+p2k+3+JvD_pPLPjc5M9_HSX70_6ewqjg1HyEQ@mail.gmail.com>
 <cd06ea46-5935-40cc-9897-bf004c0983d7@oss.qualcomm.com>
 <CAE2XoE-xipsj_xNJ5tQ5GEkNV+sJE3VuoATxuHj8M9xyVW2u0Q@mail.gmail.com>
 <bade67ae-332a-4b51-aa4d-02c49867dd91@oss.qualcomm.com>
In-Reply-To: <bade67ae-332a-4b51-aa4d-02c49867dd91@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 28 Oct 2026 20:01:55 +0800
X-Gm-Features: AclHuK90OE06_-Plu6-EYkhaCKX_zCLKqgGHAmWPtFEfTKv7WuoWqXk1iNvvNPo
Message-ID: <CAE2XoE_F9LCwd8U7MN1h-mWkRrrdEo1G4_LAMQAqeS1QQKwh8Q@mail.gmail.com>
Subject: Re: [PATCH 00/26] multi-target: prefix helpers with target prefix
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-level <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x535.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 1:40=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/26/2026 9:57 PM, Yonggang Luo wrote:
> >> I hope that through the recent series sent on multi target topic, you
> >> can see better how to try to slice work in smaller pieces. I try to
> >> focus on having a clear goal for each series, and each patch has a
> >> unique purpose. Then wait for reviews, and iterate from here.
> >
> > I have learned much, I need more information or discussion about thow t=
o
> > avoid calling target_info() in class_init. You suggest me to use is_ava=
ilable
> > but I still did not get it, because for multi-target binary, the is_ava=
ilable
> > will not be called. so adding more things into is_available is
> > useless(for my target).
> > So I want a more clean explanation of how to do that. (I have already
> > tried rename/duplicate
> > the QOM name with is_available, too much changes and cumbersome)
> >
>
> First step is to create distinct duplicated types for every QOM type
> concerned (like two cpu max, one for arm, one for aarch64), and select
> the right one with is_available.

Hi Pierrick:
This is doable, I'll do it.

>
> Once we have all types correctly duplicated, and using is_available
> everywhere, we can replace the callback approach with a declarative
> approach (.targets), and register types in distinct buckets.
> Then we can have an automatic naming convention "arch-type" which hits
> this bucket, or "type" which must exist uniquely among all buckets.


>
> Yes it's a big change, and it can be done in parallel to current effort
> to support multiple targets linked together, it's unrelated.

I will go with this path first, any new idea is welcome:

typedef struct TypeList {
    uint64_t targets;                 /* OR over the chain */
    QSLIST_HEAD(, TypeImpl) variants; /* TypeImpls with this name */
} TypeList;
struct TypeImpl {
    ...
    uint64_t targets;                 /* where this TypeImpl is available *=
/
    QSLIST_ENTRY(TypeImpl) next;      /* next TypeImpl with this name */
};

and targets is computed from is_avaiable automatically

static uint64_t type_targets_from_is_available(const TypeInfo *info)
{
    uint64_t targets =3D 0;

    if (!info->is_available) {
        return QEMU_ARCH_ALL;
    }
    for (GSList *e =3D target_info_qom_get_targets(); e; e =3D e->next) {
        const TargetInfo *ti =3D TARGET_INFO_CLASS(e->data)->target_info;

        if (target_info_eval(ti, info->is_available)) {
            targets |=3D QEMU_ARCH_BIT(ti->target_arch);
        }
    }
    return targets;
}

so we can get a working solution of your buckets idea.

The TypeList is the buckets

>
> Please note that the bucket idea is just an idea at this point, and I'm
> not sure if this will be accepted. In all cases, the refactoring for
> using is_available and have duplicated first is needed first, so lets
> focus on that.
>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

