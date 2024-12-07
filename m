Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2E4E7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 08:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJqFc-0003Cd-7D; Sat, 07 Dec 2024 03:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJqFa-0003C0-Aj; Sat, 07 Dec 2024 03:33:18 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJqFY-0007gD-PB; Sat, 07 Dec 2024 03:33:18 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 22CA8A40075;
 Sat,  7 Dec 2024 08:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1EFC4CECD;
 Sat,  7 Dec 2024 08:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733560394;
 bh=ysUzu1cKx69rnPAx2aBIYuDYfVrYDTwWQl2sRqD/khs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MO9sW+EBvR7TU0rUpiDwFwskd0Er3xxOKVEdxCKeukUDoYo+uNGhtn7iLZIzZReDQ
 4L2avSzyuimVpKNYoGUvnwBpJkmCWEiOK5aSpoSM51fFTSL5+OC64F0QiJtJ6TZWom
 EQTpJWLZYUq0oKE6Krl1XR7onD7CffJyHvv4hsNGKDhgTmWxTGJqUwz3gvhsBfk0WN
 NrSUQbdeDlZwJJFwqjvlUfWdahmZuvEnA14vpLEIoBxYFUzzYQYeXTlew2BsRvuaPj
 99WDnJv0tkDhXilJnxpp1Thkh2smnLPmQpnHrgfPkzqhXTGjyZn9F3byvMaXNKOiSc
 Lsb83FpqtXeyA==
Date: Sat, 7 Dec 2024 09:33:08 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Igor
 Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 27/31] DEBUG
Message-ID: <20241207093308.55376e8e@foz.lan>
In-Reply-To: <87ser02f28.fsf@pond.sub.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
 <6f427a02c2c20512d5da178b47c64d553851a60e.1733504943.git.mchehab+huawei@kernel.org>
 <CAK3XEhNNZyRDgjm5Hjes-Xnj4CxtO2eQcs7AyTNOOFcKa3LusA@mail.gmail.com>
 <87ser02f28.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUBJ_ALL_CAPS=0.5 autolearn=ham autolearn_force=no
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

Em Sat, 07 Dec 2024 07:16:31 +0100
Markus Armbruster <armbru@redhat.com> escreveu:

> Ani Sinha <anisinha@redhat.com> writes:
>=20
> > On Fri, Dec 6, 2024 at 10:51=E2=80=AFPM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote: =20
> >>
> >> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >> ---
> >>  hw/acpi/ghes.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> >> index abca351b18de..1fe4c536611a 100644
> >> --- a/hw/acpi/ghes.c
> >> +++ b/hw/acpi/ghes.c
> >> @@ -534,9 +534,11 @@ void ghes_record_cper_errors(const void *cper, si=
ze_t len,
> >>      ags =3D &acpi_ged_state->ghes_state;
> >>
> >>      if (!ags->hest_lookup) {
> >> +        fprintf(stderr,"Using old GHES lookup\n"); =20
> >
> > I don't like this. If you must please have them under #ifdef DEBUG or
> > somesuch. See ich9.c =20
>=20
> Judging from the subject line, it's not meant to be posted, let alone
> merged :)

Sorry! Yea, this was not meant to be posted.

I ended submitting the entire pile of patches I have pending, including some
patches I placed at the end to test that what method is used to calculate
offsets (the one supported up to current QEMU version, which is limted,
and the new one that uses backport logic).

I'll submit the right patches again. Please ignore this.

Regards,
Mauro

