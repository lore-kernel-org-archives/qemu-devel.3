Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC3EFDEE38
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFyBB-0002q7-4v; Thu, 23 Apr 2026 13:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wFyAu-0002pC-HY
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:49:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wFyAs-0007kT-O2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776966553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5AjYdJd/b9V635sEEGfdFP6C4yWRB05QJtzSzH/uinw=;
 b=LNlc8w2WdWnwcU4B2F8Vl4RhrQhNHAdl9XtcSFHU2UcPr9RV4CnGSZBgYmcgSIiz1E5aft
 lFwVZDN08EshhUABRHdR0MPQy15gaxSY3V75PfgTaBGzdOWUq2Ff0TUrCV0dl/PElZq39O
 asNCxDVQ4orV5Qcw5B2RRTLS9gABO9o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-_44lFrn9M_OkzWwys1WQxw-1; Thu,
 23 Apr 2026 13:49:09 -0400
X-MC-Unique: _44lFrn9M_OkzWwys1WQxw-1
X-Mimecast-MFC-AGG-ID: _44lFrn9M_OkzWwys1WQxw_1776966548
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2614B19560B5; Thu, 23 Apr 2026 17:49:08 +0000 (UTC)
Received: from localhost (unknown [10.44.32.119])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 315EC180047F; Thu, 23 Apr 2026 17:49:06 +0000 (UTC)
Date: Thu, 23 Apr 2026 13:49:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 00/59] target-arm queue
Message-ID: <20260423174904.GA574634@fedora>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
 <1291497d-21ae-4422-82f4-08a99224252f@linaro.org>
 <CAFEAcA_vFBVBiU=27h1j+hWLX4P_qMbSUzW0rLy8yJJGKpx=rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kOCANvqy8sBKUcsk"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_vFBVBiU=27h1j+hWLX4P_qMbSUzW0rLy8yJJGKpx=rA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--kOCANvqy8sBKUcsk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 01:53:01PM +0100, Peter Maydell wrote:
> On Thu, 23 Apr 2026 at 13:37, Philippe Mathieu-Daud=E9 <philmd@linaro.org=
> wrote:
> >
> > Stefan, there is a comment on #10 (a8af0fb24da) Richard'd rather
> > to be addressed.
>=20
> I would prefer not to reroll the pullreq just for that -- it's a cleanup,
> that's all. Compilation is not broken by that #include line being missing.

Based on Phil's response in the #10 sub-thread there is agreement to
merge this pull request as-is.

Peter: Please send a follow-up to fix the missing #includes.

Thanks,
Stefan

--kOCANvqy8sBKUcsk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnqW5AACgkQnKSrs4Gr
c8ig+ggAxfz3T9peqVzGaSVLAREPYYC4IwB7M/yHb4m6JSHziLA5ikuYquuz5vLE
3VATh6DndD0HxcBPAnP3I0gTwObpILYI3kK276bd96TseXTwyXdNQkjt2E9YXYm8
9b2hLHajC3Yntu9FkdsOAdbN9ztUAB2ZjNDTLaOZO6PwWa3qrlqBD/nzsH0Ux47w
3O2aPx33R/NFzq4iJIRp6ZT6+547oVXdEtlm7n1FKSCPXAGb7/WY4K75CBYkavEf
gb4kn2orXsvHMJx11+islOMuEbmuAs0wMksPqJTzhOnaa8ezoi93oMRKn26NUIFD
57poCX3rSsDqqMSOmSyOkddz58mzag==
=uiGE
-----END PGP SIGNATURE-----

--kOCANvqy8sBKUcsk--


