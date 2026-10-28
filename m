Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAFF606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ld0hdzLz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzk0-0004wu-KC; Wed, 28 Oct 2026 05:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLzjy-0004wb-1n
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:14:38 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLzjw-0005Lo-EK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:14:37 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so1318307a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 02:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793178875; cv=none;
 d=google.com; s=arc-20260327;
 b=QIvbG+WstpKqO4YLtcn1MZtQ0PsLu4daedhYGsagsjgvU5isFaVxT9wL5IZGXiyt4v
 taxdKvQRIHTUFK7/Mc3ajRnF2ws411zz2R+8GbYdblqFnx8/9dYSEADnwAjq1x9cV3sU
 1J30aegk8fwZvHSAds0RVfzkDEOUBPFfhrH+YCmfTyS9LyhmG+rfjRvMuDRnPCUKjjLO
 nPywb3uWihaPLxuUVm51ssDjxMmNrhNeBIjlDxpv3r6jyRuin7WxxjhJk4czuhsSgxat
 aZoHbFWoSakHckbe7vUUvmifwn/aelL7K2XRUbw1Jxgncc4wJX+vYEkWz74fj8QRe/jR
 G5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=qcnx2UkBY030N9XVIjKQaLKP7M1ryAvPl3rJ0t9Ije8=;
 fh=46U1FE5Qw0fo7evi6utX9h5HLfzSsvyXi+QDnZDegHo=;
 b=E5KrboehTiD4VPIuKbu6j3s2ntJxccCGv4pz5oEjikAePaLHhJjOjvLKY6U12vxA5b
 IMyPlUuiuNtpgBSIfwob0U5zDyv82mpV9BYE5sC1WJQax4tHOCK93+yBg4Ymc2nPVTJx
 bUDmzR58jyW7lEnFlFt4c2R2viJR8ZKqtlII4piQC6F66Lf4ubWprn+f4RCHzcltwllN
 FficE/+Gf0BWrOSNaJchwarSVCMR+w5Az0Hhmjz061NFw051/VxBU5vjupa4OqzIo2Rw
 dnAeY5v//IZ9nnrAobKawdHpPbLrM166TLctE95CEfr594F3nD++2V//duFOUzmlbbDA
 B7SA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793178875; x=1793783675; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qcnx2UkBY030N9XVIjKQaLKP7M1ryAvPl3rJ0t9Ije8=;
 b=Ld0hdzLzvdPJMMpwF4wmrzG9tsED+RT9gSgKVD8UplxGvnDxFSRYQNXby/H8C97GHe
 ub9BHTP0TtkXoVGeVHlP5zYk+QWjjnfUH0KtfrExqCxZjZgC12ct39duXaWfmJSAbD/x
 6CF4tKFpeg8nEx8/Gx6rtOeE/qbvwtnQ+vI2ZESib9tVXu6EHXDdAerH34md3Dmx8zd8
 klag6+lM7S8kUsoTGinx9yqQrMeMjRZtS6YMYyZALQX0VIaNmnlo7anaCJJbsbaHz0S7
 g9IZq/2GbVeXl57JbCVC9s9s3CQw3DlBY+UiMrxvf0UF1z1p33EOZ339D6tFMDpSdeaw
 mzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793178875; x=1793783675;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qcnx2UkBY030N9XVIjKQaLKP7M1ryAvPl3rJ0t9Ije8=;
 b=m3lNyu8xsIOlNsa7YyZ/YDaSZJSw2o+BqYNA0FA9gBXeke3yFTqJd4pnWHSPcf+1am
 BEa0oAT+tqqBediUFlDUHT6uZNrOli/M//mioCDLnl2SpdbVHQUY3sgR7RM+K7i0wTVj
 1QuuGeD3zpkHLGQV8i4/hXJhH268/iVDvkv9eQFErD+ykZyLC7ucpGPuy4fpXVWYkXRb
 NCFRiLv+8pZ1hybINo5SaKnOp2rpQ2UQwpi97q2DcrqJmb0e2j36RSQB8I1fpcWUtbbi
 2v27t4zKEnTaJbly4qwRaH8rJVe0drff2QXprIjgnMkmawZB/Nwy7/S5m7O8/iJKCBZb
 d0cg==
X-Gm-Message-State: AFq9FYKj1GZiAhow3AJrUvBZWkdU6M4KgJFC6F6YNujVKoYxiapUvvbi
 YKykH18Edf7rHDBktLr2bc3W1w7itoHtrpcsiXm6MAWGgOSmTtOR4xlPk48se5YdpPzc/wthQgI
 slsMr3lcN7ON4ncrq3yRUnRW6X/B+maBWSVrO5gk=
X-Gm-Gg: AYBFou2LnefmScEO9DJ4XJQxd+w+atEtqUJjI5hEXHXDgHLxYLrW8hgKaOg1TAyqaje
 uQqm8SXh3t7sda7zGAkrpVpOLSKlzYxqpcOAFvJmucF+uYWLIHWCBAH+HopMSfjxXVvc2FnTwAH
 JhlGIG2pBIFGXu90dyQZgXnAyeYB4oUVwF/68hSp86QzNHElUM4lpGXpP2J5nbbVtBGaGVzrIyF
 cFP0NlvajNsGYMtJoqdsVJXw4GIv6Ymy7WO2dEEOszc+LoBuRp+LS5gyrok6Z9m/MoYwjv59Ql8
 1w0gME0rMMg8V4PEh6uWYBHRJJS5zROs3ntkZYeS6po1xGxsI1YMgg2/JRfXBJoOGZuZ6utX5Ft
 9M4yoQYjDWSd9dc7G51YeSyfd1JWN2RLRkGsB2A==
X-Received: by 2002:a05:6402:4506:b0:6b4:29f9:1e72 with SMTP id
 4fb4d7f45d1cf-6b49cb593b4mr1011203a12.5.1793178874376; Wed, 28 Oct 2026
 02:14:34 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_4_kLo+p2k+3+JvD_pPLPjc5M9_HSX70_6ewqjg1HyEQ@mail.gmail.com>
 <cd06ea46-5935-40cc-9897-bf004c0983d7@oss.qualcomm.com>
 <CAE2XoE-xipsj_xNJ5tQ5GEkNV+sJE3VuoATxuHj8M9xyVW2u0Q@mail.gmail.com>
 <bade67ae-332a-4b51-aa4d-02c49867dd91@oss.qualcomm.com>
In-Reply-To: <bade67ae-332a-4b51-aa4d-02c49867dd91@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 28 Oct 2026 17:14:21 +0800
X-Gm-Features: AclHuK_E8p1mGWZOy_03jqLZsjWSSszmj7Dp8MBRsikxZnJy8QaxEcLhl3t3788
Message-ID: <CAE2XoE_C+TmLWNT9Ps1WokQkRMKiutYdH4cdwaxFe79P5LZdQg@mail.gmail.com>
Subject: Re: [PATCH 00/26] multi-target: prefix helpers with target prefix
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-level <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52e.google.com
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
>
> Once we have all types correctly duplicated, and using is_available
> everywhere, we can replace the callback approach with a declarative
> approach (.targets), and register types in distinct buckets.
> Then we can have an automatic naming convention "arch-type" which hits
> this bucket, or "type" which must exist uniquely among all buckets.

I tried to do the prototype and found this issue:
For the declarative .targets, do you mean a new TypeInfo field next to
is_available,
or a class field like MachineClass::targets? Bucket registration and
parent lookup
both happen before class_init, so I think it has to be on TypeInfo.
When we do type registration, "MachineClass::targets" is not available yet.



>
> Yes it's a big change, and it can be done in parallel to current effort
> to support multiple targets linked together, it's unrelated.
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

