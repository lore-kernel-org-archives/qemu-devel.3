Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA969CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 09:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSAw4-0005Q6-Hx; Wed, 27 May 2026 05:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1wSAw2-0005Pl-Tt
 for qemu-devel@nongnu.org; Wed, 27 May 2026 05:52:23 -0400
Received: from flow-a1-smtp.messagingengine.com ([103.168.172.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1wSAw0-0006L8-Rg
 for qemu-devel@nongnu.org; Wed, 27 May 2026 05:52:22 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailflow.phl.internal (Postfix) with ESMTP id DC20113800FA;
 Wed, 27 May 2026 05:52:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 27 May 2026 05:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1779875539; x=1779882739; bh=sdxuVNdBgf
 /FUuHboOxbaJwS7/oZr93FT1WsF+6fy3A=; b=RjAHOpieVt0eiqViIMHCPrOATL
 K8vMiqsG+2IugK9zqq9ilL7dtnNoeKZgG/gl3BlGVZhQ9oz69cChLH0T4mOqQBm8
 wZeTE+jdx16BZpQq0f10yVSZVCt2y2D8AdnmrRsIguZ7J9XG8ZY0CX7ef1ijSaki
 IMEkWV59LK8+pvLaSAdg8BEe+IpBq3hul5NZG/Tsl89EEvkhEBp+yeRfzQORPJyk
 /+WjXkM7EPSqfm+Uch7KBFe8kRUYoVIOpXZ6+p8PQ1+fxnKPPe6xqqy6dY0JDaky
 mQhKlM+knHWO9cQqXhwpvhcAWIkuhWwdH+fc2vKS5CxVYuuhCscKCO7edMDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1779875539; x=1779882739; bh=sdxuVNdBgf/FUuHboOxbaJwS7/oZr93FT1W
 sF+6fy3A=; b=qNbNF4UqYBmBhamDaS0aJUfO0QzFxoJVbmNA+1teZsByLI3sllW
 /0YBtisn0Fl5YZfc+WKfg2mjpa9L8eIC3YrNkavTsx4bWI1/PSGadUzB/AKg/IXa
 hC59fb2RTEu9UHjFlkpVHXQoLEIbVv+UGdobfrPFwn/4j6KKJ3cV5/PXIVt1FJJK
 jLkFIm+aWtO4PWOER/GkZqFN4VVoepnw5IzBJts8qDh+BqmH8Vk8cLk4RXeXMC7C
 ZCNO3tU+9ORG/viZcjtaIx3db1DIvm3EwqQa/Ylo7DwPLNccIusjeIF12qBVyJzT
 SO8P2lpbiLz1or1PmlSprYUezfFDsz9kjjw==
X-ME-Sender: <xms:074Wahb83KO7XEjT9VghEHknfrDhK6m-QFSxm8ZuOC7e7SZhGSxUlA>
 <xme:074WaqAgpN0kMufXSbrmRMdO-rDkqDEmfbvhNaR7V9S5tleNT_YjJB_5i9pelxEou
 ZuWKLnfueSPy7Fbl45cdEcmXA6zXdU5ZEVS4K782xe5F7s5XDsfKw>
X-ME-Received: <xmr:074WaoCJcw6r_3ENMXzEL0CJMgYPIZKeiyK7PPsTVGtBC7b2NMjYSUD0qgC3giujqgKzqdSNKD6WfRqkKbwTK4nhqBbZGgcf9wSZlA>
X-ME-Proxy-Cause: dmFkZTE+S095pb8OkHCbvBMFvoPHWh/hdhSpcXg65cvq6DMEqdIbzvzs2KdVWdnfMbirNa
 pYsMXF2UjqxZIzTkoBv90DF4GHTeHt0Du/eY6fjMDzUcIqpIccHCbuyErHLRc5unxYWzNn
 ZjtBX5jwlLFWflRRiGrKySgYkIIzzB5ziVFJNQI3AV9u0TBq34GEExG6bb39XVVRmt6JHG
 3qcXTVmVs6oREfRnLwvBUkTpoCQDgZAeMwYCHfg5Gk4EpZ9LXMsM9XvxVkeqljpCZV/3/2
 +7NMhcZYSvpZ61gaUiFyC9VT2kZj7hQDAvyddhhxlwquo3qt5eULPtdqHCTma7VQCM3YIc
 kEQquAwDskb0IuqPxhUeXeVHBPo9+1rOKF+zrIcF0AQcUNJPsR123yBTI3OHGoa4Q5wges
 4CWe9pcjbNA41S+1REY+pwVkwxyaurn8hdjyZc4UxXMUzm5JqjcPSn5FP2KaOntteB1hRS
 Bmbm6iUiIHZFRy4A2itFdJoky7FM5zCOjfujt1FgnL++v7wifeK7rhyG88m+BvMqK7dxPH
 aCw1spDmZkvxH6+LHCPu07raMfwKlJXCypTzVYcs8Kc9O0PjiaDNpbYxaAzQ7+0BqfzicE
 A+ttYByh8Tvkx7KKxulQxrNEANpPcYtI/2noBL5QriZHo0Ax72eCTrdiWmZg
X-ME-Proxy: <xmx:074WamEyzHzY5ECiU5Tc8tMaTVZYP39LPQd8XHWe0hMJaFTY83V_dQ>
 <xmx:074Wark1m_VuIzN2cXOKEFaPY5EVkiwv1ryrz_3m6xvPS8QS0BynxQ>
 <xmx:074WajsJN_x6d1gc9200_6s_AoiQjPemvbo8qZXCQYDcvevQ6ks1gg>
 <xmx:074WavMAStocrJkVq4i8ZMzEksOiJaGIoqUX-uI4YSfllLzXmZdzfQ>
 <xmx:074WahrxWRnxG7PjMZLnmgPHahtfnWICuQa6k9NbP2myz0g5-Z3lJfuy>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 05:52:18 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 4D5EA819B4E8; Wed, 27 May 2026 11:52:15 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Demi Marie Obenour
 <demiobenour@gmail.com>, Albert Esteve <aesteve@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake
 <eblake@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Elena Ufimtseva
 <elena.ufimtseva@oracle.com>, Auger Eric <eric.auger@redhat.com>,
 felipe@nutanix.com, Jan Kiszka <jan.kiszka@web.de>, Joao Martins
 <joao.m.martins@oracle.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard
 Henderson <richard.henderson@linaro.org>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>
Subject: vhost-user implementations
In-Reply-To: <87y0h5xl7h.fsf@draig.linaro.org>
References: <875x4fmzcv.fsf@draig.linaro.org>
 <96181e0d-4c75-430a-9b80-9d8d0eabcce7@gmail.com>
 <CAAjaMXbFhtiHgiUwmJFXti25+vXRebjtaD6fFD+GkOHsDny=Bg@mail.gmail.com>
 <878q961nkz.fsf@draig.linaro.org> <87mrxlgt6u.fsf@alyssa.is>
 <87y0h5xl7h.fsf@draig.linaro.org>
Date: Wed, 27 May 2026 11:52:13 +0200
Message-ID: <877bopgoxe.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Received-SPF: pass client-ip=103.168.172.136; envelope-from=hi@alyssa.is;
 helo=flow-a1-smtp.messagingengine.com
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

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> *everyone - do we have a comprehensive list of who implements vhost-user
>  these days?

I'll get started with some implementations I know about :)

Frontends
=2D--------

=E2=80=A2 crosvm
=E2=80=A2 QEMU
=E2=80=A2 Cloud Hypervisor
=E2=80=A2 Firecracker
=E2=80=A2 StratoVirt
=E2=80=A2 alioth
=E2=80=A2 Dragonball

Backends
=2D-------

=E2=80=A2 vhost-device
=E2=80=A2 virtiofsd
=E2=80=A2 crosvm
=E2=80=A2 Cloud Hypervisor
=E2=80=A2 Spectrum's router
=E2=80=A2 DPDK
=E2=80=A2 SPDK

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaha+zgAKCRBbRZGEIw/w
oij6AP9oxfTpit70vxL+LFN2oFRYRe1eYdFpNlkHr4hVNzrUvwD8C8romkD67VTN
EHodpyLuEhxQb679lwq86/keibYoyg4=
=EM/x
-----END PGP SIGNATURE-----
--=-=-=--

