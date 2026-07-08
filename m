Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797F7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whPVh-00062a-BD; Wed, 08 Jul 2026 06:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1whPVf-000628-0I; Wed, 08 Jul 2026 06:28:07 -0400
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1whPVc-0008DN-Vv; Wed, 08 Jul 2026 06:28:06 -0400
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id 401FE1D00128;
 Wed,  8 Jul 2026 06:28:01 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
 by phl-compute-08.internal (MEProxy); Wed, 08 Jul 2026 06:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1783506481; x=1783592881; bh=4k41SZUckwG7quHXRAobkVbMxbaEZjUZ
 YaZrKzxlOrU=; b=dti5Uma0DGBJN0JubMx6wDmAuQr8jP97AmiYA9FAFnSH2gCi
 hy3D79FjLEHxdcWIbuQSwsKSJcnLgzD6zm3MH/fAPRuoi564whj/Twg71+vucmRF
 KgQGXZFqdOwveSs+9SzkQusxX14hRntdqqT7r1n6AHltHdIM36nDIAS4zedLLHVD
 9am0XB34wUbADUgoGoBq612ortMiYfRCkIB1HEjJwlvwjT9PMGEVYmDiNYNX0Sie
 nuUWsOy2JessDnl8zE5e1rhtZT4iLcfPuKQ7DPaOtynYEYV45gvO4SMjKdSrfYbH
 PmbIkqF3Ef6plw17gOW8tlAjcIFYpUCHpRwYYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783506481; x=
 1783592881; bh=4k41SZUckwG7quHXRAobkVbMxbaEZjUZYaZrKzxlOrU=; b=Z
 kmcagGQRcEGoil6NC6Kx0J/e2NcbNI322orXTSs4vcJRVRgYPzllWc/P1+KwNLSb
 vkxPzuLbKyTnZaI/ZGykcr6E50acKvv7AorjT6cHeUC87W4bvCijtQ3TKDVBWSrp
 yCV5aVgJigJp5bmdfsdQxC/8UBRQdUyguB4dQqA2QjkuiAMoRc2mD/LLsToo+xoz
 Muiu9rpPUSb9rBis7rvJC0s8VrfFLijPYrr//eLxJ+t1A5oJXfhCPh8xJHOvLq0f
 5L2/q9Ftdy4eVnTzSDhLqP0Hrt1kJVgVmjThTooWxEN5CZVZpURfkb2NjiBxMjCA
 HOQYl8Y3oW9uO0G4upV9A==
X-ME-Sender: <xms:MCZOaoiFqvH7ZlpOipFxzTfPiMewZC5Zrcd2dYW278gCsB0obWXe5Q>
 <xme:MCZOar3egf5EqKm26T0tIH8mPoTe9qY_57PsBUiGa2t7Q0DC3jr5vunYuVi9qOOy3
 Ne41DDuo0_K8eMyG8msCC2sxW_FNuPIBbJtys5Ex95ky3PnkMpug2s>
X-ME-Proxy-Cause: dmFkZTGosRPYEEYfWN6XcZVPEmpgI17YjADjNz/EjK09ejFtnmobiA64rpaHAj/fwNaTu8
 x3fDyVv0qqJRtu4nW8hf+9503s/T0Iwo72ye29p6Y+BXZock2oW0A+pJM7TfVWfWgxrcJC
 B1vfqtfssY78sEAj/N6lTIhDiGyZ0+Q+FpVhZfDZ1nZl/A4A9oonwsmcJx41g05udeZu/X
 DquP7rdHn1Z6gUUuoO1fNMGnOuN3hMSdOm4zMeK4k7cGHNT8TRZm/8X3RDgA4y3V53/An6
 Bve3ygZa74LPlOtgrhseCy5+bg29MCyoyoby9Jhyc715jl6B3V/teVZ1l0RIUr1/gIQMtl
 5FhMZW3Wtk7kMtyTO46xHaR4hvhf1tMrZlOV4KFs3VDmR3FRDZq4ei6hEaVk8Pf7gRyclm
 cHeInsQrhDprlNXz8jxZvNgUbcr5g9Xm0QFLPkl7FEQ/ab494Pc38KlOaY9sgwNZGEM3mH
 ng9XTYCjpsFJfZwRWMvko4LCZqA0vUwOLg85CWzNCwSqu8EYuuoAoYwc6FFg5gwA0wRaMo
 c0HE7EYrFpku8oE3c810m98yHYs4KTirYQx1njwyYyMe0Rn0+6rmcdk3LmzlMt9PM14K3j
 HKZrl1RbvzXmhZmDnrha6weyTRjKX+HWDWITd/v7crPJglwMDPEv+LUqMN+g
X-ME-Proxy: <xmx:MCZOatJnEBC28O11yyCma7S1TT6B78WE_BeGHcI0PLjWuGKg3MOxQg>
 <xmx:MCZOak9LDCPY7YK9BFn3k9LLffQDICyG7kpmaAx_JuqRG9RUj6GX8g>
 <xmx:MCZOahFECq_6razWOkqhr4JH2vbgZBMA41tZkEXqtwnXPN55ruPoHw>
 <xmx:MCZOan5-4HBUXRFFa7voIHt_t7MnI-tFzm9FgNP7pSVBxC3bsWMj6A>
 <xmx:MSZOaoCo-hthM0KtioRM38yhY00KfRG2pczrjfHEFqohRtoV-Ge6PGrS>
Feedback-ID: idc91472f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 103251820082; Wed,  8 Jul 2026 06:28:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Wed, 08 Jul 2026 12:27:39 +0200
From: "Klaus Jensen" <its@irrelevant.dk>
To: "Alexander Mikhalitsyn" <alexander@mihalicyn.com>,
 "Peter Maydell" <peter.maydell@linaro.org>
Cc: aleksandr.mikhalitsyn@futurfusion.io,
 "Jonathan Cameron via" <qemu-devel@nongnu.org>,
 "Klaus Jensen" <k.jensen@samsung.com>,
 "Stefan Hajnoczi" <stefanha@redhat.com>, "Keith Busch" <kbusch@kernel.org>,
 "Jesper Devantier" <foss@defmacro.it>, "Fam Zheng" <fam@euphon.net>,
 "Kevin Wolf" <kwolf@redhat.com>, "Hanna Reitz" <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9_via?= <qemu-block@nongnu.org>
Message-Id: <dcd72ac6-aeeb-4309-a8cf-09656795cd0d@app.fastmail.com>
In-Reply-To: <868d7628da027aff31851b82944c5d13f9448349.camel@mihalicyn.com>
References: <20260706224426.14156-1-its@irrelevant.dk>
 <20260706224426.14156-5-its@irrelevant.dk>
 <CAFEAcA8ZQX01i9u0dUziRP0rAC1fSF=zbWcmQdLs=82D8ECg4Q@mail.gmail.com>
 <868d7628da027aff31851b82944c5d13f9448349.camel@mihalicyn.com>
Subject: Re: [PULL 04/11] hw/nvme: add migration blockers for non-supported
 cases
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.148; envelope-from=its@irrelevant.dk;
 helo=fout-b5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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



On Wed, Jul 8, 2026, at 12:23, Alexander Mikhalitsyn wrote:
> On Wed, 2026-07-08 at 11:11 +0100, Peter Maydell wrote:
>> On Mon, 6 Jul 2026 at 23:44, Klaus Jensen <its@irrelevant.dk> wrote:
>> >=20
>> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>> >=20
>> > Let's block migration for cases we don't support:
>> > - SR-IOV
>> > - CMB
>> > - PMR
>> > - SPDM
>> >=20
>> > No functional changes here, because NVMe migration is
>> > not supported at all as of this commit.
>>=20
>> Hi; Coverity has a complaint about this commit (CID 1663673):
>
> Dear Peter,
>
>>=20
>> > +#define BLOCKER_FEATURES_MAX_LEN 256
>> > +
>> > +static inline void nvme_add_blocker_feature(char *blocker_features,
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *feature)
>> > +{
>> > +=C2=A0=C2=A0=C2=A0 if (strlen(blocker_features) > 0) {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_strlcat(blocker_featu=
res, ", ", BLOCKER_FEATURES_MAX_LEN);
>> > +=C2=A0=C2=A0=C2=A0 }
>> > +=C2=A0=C2=A0=C2=A0 g_strlcat(blocker_features, feature, BLOCKER_FE=
ATURES_MAX_LEN);
>>=20
>> g_strlcat has a return value to tell us whether it managed to fit
>> all the text in, but we aren't checking it.
>>=20
>> In this case it looks like that's not a big deal (it does always NUL
>> terminate even if it truncates, and we're only using the string
>> to report migration blockers), but I think it would be nicer to
>> avoid using a fixed-size char array: they're usually a bit more
>> bug-prone.
>>=20
>> How about we use glib's GPtrArray and g_strjoinv() instead of
>> manually building the string? Something like:
>>=20
>>=20
>> =C2=A0=C2=A0=C2=A0 g_autoptr(GPtrArray) blocker_features =3D g_ptr_ar=
ray_new();
>>=20
>> =C2=A0=C2=A0=C2=A0 if (...) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_ptr_array_add(blocker_fe=
atures, "SR-IOV");
>> =C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0 [etc...]
>>=20
>>=20
>> =C2=A0=C2=A0=C2=A0 if (blocker_features->len > 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_autofree blocker_list =3D=
 NULL;
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_ptr_array_add(blocker_fe=
atures, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blocker_list =3D g_strjoin=
v(", ", (void *)blocker_features->pdata);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&n->migration_b=
locker,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Migration is not supported for =
%s", blocker_list);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (migrate_add_blocker(&n=
->migration_blocker, errp) < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0 }
>
> oh, thanks. My bad. :-( Would you like to submit your fix as a patch, =
or
> should I take your suggestions and send a fixup patch (or update my se=
ries)?
>

Alex,

Please send as a patch for master, you can add Suggested-by for Peter :)

Cheers,
Klaus

