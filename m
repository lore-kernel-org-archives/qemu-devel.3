Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4834606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xukg74xS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJm5a-0003PU-2e; Thu, 22 Oct 2026 02:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xJm5Y-0003Ot-GE
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 02:15:44 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xJm5W-0000yi-HH
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 02:15:44 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso2317039a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792649740; cv=none;
 d=google.com; s=arc-20260327;
 b=jTjI4vDq2GK394hwoDqUZfD39faUEkef3pwdOxjOOud+pZ9Sk47bSpRbdAxrQDdowV
 5HWEf+z4p5OjrF5Lbv4BGC7nJsUS0l3STm2Je7E4XXmvdcAsHLJe8RrVnCkS6ySIphzD
 tBdpmLeF0nC273Ut1t+PGatKzIku7x9cLzwWglSSVFmEssIhSPs15b1014SKpzQQXRVN
 NXYoOljVVji48nmODHPxYrop1rkqTA36nobZIYFcf8XUgCB8X0LeP1lXq509mkY0X9Gc
 qGDdDALvCOUzMtMdB1bzcqmMJE6PC7GZ4ZUEUjHFg2cIwXFDQ1M+KMyKifyHAEvFyhhc
 X4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=tygBwhnUemSJunkqNLOWUNx1omlGFNO2ijxqfXeCu1I=;
 fh=8H62a63nbPyENZDqgrXug6R7l7UVEnrjvEENi5W5aPc=;
 b=ALrH0sET2toXS2s0EefRs39r7fCtdhHSuWBbf8B4OTH1XfwHcjp66AndBaZJfyabCx
 z4KlB/p2mFPDfZLxN0WaiMjRUV4Rfw7HUfb6B7PGp+EujEUnoXpIY2UyJGRAxC53w5/s
 RUJLDDynsU1kqXkEvcwAYVX6Kk3qDC7dpMAMzUGq4syScqLn+N0Bo70cBQMZJd8f1N89
 lOt83SHnXkbItLBap3iq2PtQhRbz/eX/1BIoOITL8pOpYIDNyk5sNAIlWWqesH9GUez/
 Y7vFqjhKfxFobsErRY4Fu6jrUaYlTyrvpGxwBNpNirHb1uRAUi8Jty4oCeMY94SsJRG5
 IjxQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792649740; x=1793254540; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tygBwhnUemSJunkqNLOWUNx1omlGFNO2ijxqfXeCu1I=;
 b=Xukg74xS/KMPjuiAhmZnOdiGdoJxLS63BvHB3Vjq0l2sFT1RAgK7rxsC7KW+3gvHDR
 lbcoug6s7WNrxq7298g9u4fTRgAuB1m1wQbJxft1FdJD6OgCxJaS0qfeisAN/XNMW5OT
 buQAHEVHplquL1c/923NjteNDKsKQxRPmuJvCT8U+RTa4VN+InSpCZpDZK1LcuOYNIim
 rMxxiA+Q95Qi+6FyIQUQRB5SPPcdqgVdkukByStxz8DvAOqUF11cJcltFH4nZDmHPpPv
 UOsxpjB6qibxNnN2TNpDqVCKpqBTmgElZNO9Bilwhl3kdpxns6edSx2SKJFM1IdiYJrv
 bP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792649740; x=1793254540;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tygBwhnUemSJunkqNLOWUNx1omlGFNO2ijxqfXeCu1I=;
 b=Lld9GN6g7dwqRC22OoKrVbvJJiI0d1C/wyO0UdnN4/v4V2MKmMYHYVrA3SwLeE1fMO
 liz8dShj6HJMJLZlPSKN+qWfyXnhH7fNgxDCYp++pQPuWza6iSkkHnNUjhFO3x086C+i
 sj+chykmH8n7IK9ZtUg7f8UKH3dRInGzyWfEkDQz9EzvaZcnweL2xniak8x2M4AinfiT
 jr2eXrLVHHaC518lxerGqRPhfb2WrgbOyXztiqBJvzex8RVFOax9OL7ddReI7yqHIO6p
 Tepsa5g+rzQYgbH3DWx+sWJbmGIvr6QmLfEqQ2CamNfDyiaAVwpn57R6YjkDpqSgHiGW
 I+hQ==
X-Gm-Message-State: AFq9FYJB3npDRNTWfPDGa/BmIckFycb4LH09Z5tpVchtC+kVv8K0dEOI
 75IOCOsbzxw0+yFb7e2Azb383Vv/wCoGcamXKZmZJC4ULm0JdtEPYWQm6GN5xZ8MqYTihxBJhQ2
 2FsE6LkT+nbexm1VTHJ0FRJKwF2SuYcM=
X-Gm-Gg: AYBFou0mt3m4LrCL1wAv4H242FYWZ48s8E7/jdiekxD3aGenOmuVLJG3T3zB1F7EcTk
 YoBA107PntLwaEDDnrMOMpK4NMipUKlC69C5ceuZgbpQKiRVfaAquxnnL1bLBjN2ihnv7ejsxZU
 /LvAEskQWysUuHel5PthFxl8xHaG49+v6959s56xbqOcBZWK7/j/NDE8SO7cIuxtiOWkUYlpStb
 yRx14EoE5POt5cSfJinZnCR3s/uKLNB9q2SyaiIDRWIiDn9jiYa6eI/mVmgzyZZkPNFU0YFVWgP
 uFolUNFXePIAAms5JInImoliArLLgO3AC+zAAXgrDSaXmZUxdwbO3vzy0Wn6eYoc4HcPtdDopRW
 c9GJu0A7EKde7UyE6bB1crLPX+nEcKzozfcC3
X-Received: by 2002:a05:6402:1cc5:b0:6b4:201f:17d6 with SMTP id
 4fb4d7f45d1cf-6b4201f1c40mr1124452a12.16.1792649740097; Wed, 21 Oct 2026
 23:15:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
 <20261021181244.867840-2-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_78JWfKfs+5ek=6E50gjGpeRsoVe1meu=gi7FunKcjAw@mail.gmail.com>
 <e5c61cec-24eb-49a5-b9df-81cf4072635d@oss.qualcomm.com>
 <CAE2XoE-=z5NMAJ3+raj6G7tY2Mmv0=K3w5i8jPjvMmxo6eS-WQ@mail.gmail.com>
 <98d7be02-3afc-49db-96e6-bd84ec6b7218@oss.qualcomm.com>
In-Reply-To: <98d7be02-3afc-49db-96e6-bd84ec6b7218@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 22 Oct 2026 14:15:27 +0800
X-Gm-Features: AclHuK_9PImFPchuFFEssQ6bOTNlbkoHYj20F9xW3e6u_SfbYaXKdRssBA8zZSo
Message-ID: <CAE2XoE8S=UiK23OgUiw9OvXc0FDznCWQiOhigz_J6Oyud08EKw@mail.gmail.com>
Subject: Re: [PATCH v5 01/21] target-info: add target_heterogeneous
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x529.google.com
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 7:39=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/21/2026 3:41 PM, Yonggang Luo wrote:
> > On Thu, Oct 22, 2026 at 6:02=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/21/2026 2:53 PM, Yonggang Luo wrote:
> >>> On Thu, Oct 22, 2026 at 2:14=E2=80=AFAM Pierrick Bouvier
> >>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>
> >>>> For now, this function strictly returns false. We'll turn it to true
> >>>> once heterogeneous emulation in supported. Meanwhile, we can use thi=
s to
> >>>> add various checks and asserts over the codebase as reminders about =
what
> >>>> we'll need to modify.
> >>>>
> >>>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>> Reviewed-by: Anton Johansson <anjo@rev.ng>
> >>>> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> >>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> >>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >>>> ---
> >>>>  include/qemu/target-info.h | 8 ++++++++
> >>>>  target-info.c              | 6 ++++++
> >>>>  2 files changed, 14 insertions(+)
> >>>>
> >>>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> >>>> index 862097c6c63..923c00c917c 100644
> >>>> --- a/include/qemu/target-info.h
> >>>> +++ b/include/qemu/target-info.h
> >>>> @@ -42,6 +42,14 @@ const char *target_cpu_type(void);
> >>>>   */
> >>>>  bool target_big_endian(void);
> >>>>
> >>>> +/**
> >>>> + * target_heterogeneous:
> >>>> + *
> >>>> + * Returns true if current binary has support for running several t=
arget
> >>>> + * architectures at once (heterogeneous emulation).
> >>>> + */
> >>>> +bool target_heterogeneous(void);
> >>>> +
> >>>>  /**
> >>>>   * target_base_arm:
> >>>>   *
> >>>> diff --git a/target-info.c b/target-info.c
> >>>> index 254530d8ea5..b8a4a7ebf7a 100644
> >>>> --- a/target-info.c
> >>>> +++ b/target-info.c
> >>>> @@ -42,6 +42,12 @@ bool target_big_endian(void)
> >>>>      return target_endian_mode() =3D=3D ENDIAN_MODE_BIG;
> >>>>  }
> >>>>
> >>>> +bool target_heterogeneous(void)
> >>>> +{
> >>>> +    /* For now, we only run a single target at a time */
> >>>> +    return false;
> >>>> +}
> >>>
> >>> How about place this in stubs/target_heterogeneous.c
> >>> So when do multi-target tests, we can override it with
> >>>
> >>> bool target_heterogeneous(void)
> >>> {
> >>>     /* For now, we only run a single target at a time */
> >>>     return true;
> >>> }
> >>>
> >>
> >> At the moment, even though multiple targets might be supported for the
> >> same binary, we still run only a single one at a time (same in
> >> single-binary), so this function will return false until this changes.
> >>
> >> Why would we want to override it today?
> >
> > Just for less changes in future, this does not mean this patch is not v=
alid,
> > at least it gives an API that I can use later.
> >
> > I did something similar to get the single-binary qemu-system working.
> > And I named it as target_combined_binary(), I think they can act the
> > same function.
> >
> > https://lore.kernel.org/qemu-devel/20261014094224.1976-2-luoyonggang@gm=
ail.com/
> >
>
> For now, I think we can keep the current patch, as there is no need
> (yet) to have conflicting symbols for target_heterogeneous.

Fine with it, I am waiting for it to be merged.

>
> Thanks,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

