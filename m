Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28885C98329
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 13:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh6pL-0001G0-PX; Sat, 17 Jan 2026 08:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6ox-0001A6-B4
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 08:58:32 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6ou-0006qF-KR
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 08:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768658294; x=1769263094; i=lukasstraub2@web.de;
 bh=X4orNuWIwK5oIbB/RAtyGcJ4Fc8PFjqSHcMHlnpJ5xw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Hf8Gvq1fVMoQJMQah9BLKEMGBhiqf0lALd4lYfrDClcOTv7QfWGdrj41Hk4U3nYe
 53zAJUy+6Qx0K2sFhX7vSs0J/I6Vq3gr3gsYxTBsSJGp1c83+j6Zu3zz+FkC3eHkZ
 vZP+2RV6pIQUiVZuz4aBSaWX05VHrtxfj1NZryhTww/idmRTJwdEX/j6sLkmQ2pcT
 Sb2oxs9bdCqaCbDsZ8kN0p7ohtuOeGHeP3berFYzhZDMUHJTnLFHRYbX+c4vTu5G1
 DP4w7S7faWFpxnHnYKA0UNYRJ3CO61SbKUhSAN7OqnPRmUHGvdq5KWjb82pcJuuq3
 DVjfPY7kiDcA49fIDg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.100.70]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVaYi-1vHuPy2Ojk-00XdKM; Sat, 17
 Jan 2026 14:58:14 +0100
Date: Sat, 17 Jan 2026 14:57:51 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, Hailiang
 Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>, "Dr . David Alan
 Gilbert" <dave@treblig.org>, Prasad Pandit <ppandit@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 08/13] migration: Thread-ify precopy vmstate load process
Message-ID: <20260117145751.2985158f@penguin>
In-Reply-To: <20251022192612.2737648-9-peterx@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
 <20251022192612.2737648-9-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_CO8C=aqKPfKsE37haJZBek";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:9tPxKhiGy0ZyWMdkA53+qoF2CBqoFAXxaIuNR1M4WXNCP40f2Gu
 0z/d/DDb3lqlipL74KXZ4Fx7OnZT5x10eYDBbJR7c6QAlVQooWFt7iRKQbZeY3E//kCmLTe
 op9v7j2FimI0lYDV1e1bXy9EnJ7TJn+XY8JETpsybzTBPTWbqGfu1ChvUGdweh0U8UX/8CR
 9es0qW1RxcT5MTYohrdMw==
UI-OutboundReport: notjunk:1;M01:P0:GKCC6rDUk80=;9y2Xot9FNS2GWVHXOiP8MntDGMh
 Jn1QUd8krbOnEYqLvrp3ruRZKmaLKWWixQ9MfzISbbgApKr/yjW337WpdEZ2Yc96Pyy2ZXpga
 5r0pjCxMkRfr0mP5g4MtKtXI6/RQEJiZHfzpD5eJ0oXxXeGg436fctBK+bxul3nWi7soOze3l
 qJU0CiUC1ToU8TNNWA6gtkmrHC5L2djurft2zhL6hrIq7RaxlXwXzX52r1iBhnTwup8S6fP7D
 3bZvr9MVJ5Vwq9G8X+AqoCZ5qECTRJDTFvyottFMzs8t/GMYrxedTZRNSLMdM66L9W18Q2NzN
 TZHL8utPNSlUNE4NnODRhQFmEQ1eI43xpJoxSNbVdvDmACvXQT8P1pjtzmghMPwOsmI+9Neii
 gC3KuoB97wURyQn+Ui+SFVK71O8sPfqQc3v2FfuditkosaxIPUmOaCga2ZKZr4Xq7BYNe+NN1
 RFTmiJ4On6/FcahU+COqvF/nVl/mxqa6KjDjuoLzWfrGCvG7DvFSN++VI3xpm5KFBVkYjQcSt
 IFGYQMmbQ7NblxdvbsF1K9TgwjoxYHGQsIj9XfGz8pkiyq+cMlCvEt1mNC9SC7L/6CBoS0gci
 ddLptQDJeDC0+zqKGcIjqoDdBGaAEAE2M6A6kRqO4ZrGEkH9sO8eQZwg8gC4OXU0oz9ai0BlK
 sYqWjNpDgiGXQy9gug1N7SbO7PLayv6Hu/9hEzqkSXbzJZE7uul/DPtPLkxHtRwRi0ABnejCC
 b35gPHt27hUS7GpjqLGKH52KCzRy9xpQKDoKZiJtmKFIEo/Q1RsivmdIshVNt5Ly4J/x+w6Gt
 yTNSvlnXyn770f3EKCuM8x8ADiqjeAKSdB/cwxlqfxPBFjBVrLicUn7tdKGdPzTy8zisdhS17
 PpHFTRcl+FrEYaXRGq/3yabQAS3fxAuVhlORJZnd4BmRJ87FQjw8n+wT7o1GiRrB3YyxRytVU
 u51zsts5nlnHZxs+0/Fe/rNJo55viCU6HYMYBZ0IfhUMB+SllLAY2DYoo3Ivh8JzBE8SdmMiP
 I10o1H+qB8fTh6LIfphUZ2akrlcdGuzlBIvOoTXakBbYakviwpLS128uAPIBc6QOtVrfYnzxz
 A+2t69ZVZLlFUvL+lY8CCRHvXZu0UHAHI9gd+Vz3fOwl4L/x+DYCgZepqh/J49U24ND0VSKRT
 TL2TAdPQ7BcwCoKnu/sr2QC1AkYyf/SXDU8UWFeLcwRLYPjs6o+v/2Df4vn9Rlhj7DP8AVH3N
 Y9BwYi/7voYxwf48rdMg0vRIC8YavL8vluhvc2WTeM8TbNDMcmBMjs4DW7iy4XPnA0PCJ8Q5A
 Mid9alHH6PAezLadoXxLnTD3ValFkGv2WQojIOH24HQhuwt1RHAKtQQ53PA5N3shdeCRAMNCb
 k5g9qQLds7lu1E77JzpMd9kH/VQLwsE/P+eILnh8qlgxWFCgXQBDpeYWBG3ceejSAdcSWcp5t
 YaOhXmoCurvJlMWspV9ztGEaQgM2vwFJW8gwurihXr4rKEKx1LzBUHSKX/0UnZm2UwkJ5hGBX
 c19awNIvhUSo2o90E8v6DQK2GxlAwc69YdHdOI6oXjgbVyoLw8lZoj6AlCfMjvSrI9jMzs8aR
 bvMlAmQ8IpLIHPeEaJJIXbZFdBlSwqalIBs66GHrDGGLmXnTKXY1CbOaoO51CzMpe87+15Ezq
 jhv4jrj0CXdsLZxB6nraoPI1mbGlx7mb96HwGTKIXuQ2kiCOYa4AbpUWmGIOEb1rIhFr6uKkK
 bN8x/eKSrkCDvT7HLYhBAsKRbGqd/cimWttFmLjlKzXQ6dF/q2xZFIjLBaBrobk1ys12O/+d2
 EGN1c/2JyudtxAFVWOnXmOmcuy7hz8uWbLE7MEWltuzEzWcl4erEFnKEyYVz7NrpV2uzppeob
 I/JLQEU1tVSN5Avu/kanOwb8rhvkKoWym5eP46jsMvutdCsH1qog40XqDQE3/tQaasngtSS8v
 6/AJQFoObV/3UTFDj3sXUHDVUSMrPO2Atu6ldL3YE1hRqHHbsdsbp65NnjOO8Vv9W7YHrvcg5
 Zfel9Qb4BxAnD+sXHIIcoDskOXtoR9yCpRc0gUc0zWrC9OQ9lpaVZl9/Y4PzIKLDvZk+KuJcr
 8w4imjkrcTsrjMxYq28FAMCRlaItqO8qfaeKxCp8WSd9A/SrsshyB3rkus1KZlVta22b08ZnZ
 5OtQETWDqVc5ULNcprR53Bq1pgWUF3RzZ55cxwWO7x8El00HWniZPtTI1TzowannTH+3jbXbA
 ZOwpW2PolXOj3t2foPfUsoM20ToQkjkuHHdhb51I5/6iYC/ebBbba3EdoApK8Sr7hOLC9CaIs
 SAzlDQDiCLbIORdf8t7V6eparYS/foQlvn7OD/x55qg730HCdIxeOzso5DNMdKfyIv+gb48uJ
 uglZ0l5dY76DdmAqzJ4OhqPhvff9mYjt3bf3ISdiWSc1E/MDBIDLs18j8SfG8ja2exygE6q/k
 dUkfa/z37XWyTMQETAwRhvISt/wvY/H4PJIDq/H0rD/HXDyVeoFaoaEqaqn1Y0AROrkc3Knx3
 eWEE0c89/BGdq9uFNM2jjMjayyjb0YY0HpI+Ke/0Y0MFbnX0HQdmEempFspyG4F5W1fOpAzJ2
 Qq9frbCa78NzBAVdyodjaXZaTCdqMu8jhCdgaIpHX9Oyc2znG1Iv+5G2DdQ572p8Kau/i9MQo
 y0aamEJIri0RpoEJd8sXXWQRDfG8ys21aMEsM/jTKSrIL3YGT3YKeEJs8L7tzrY3o2RzzpG5q
 jToofg7fk/fHcMw3y6GL+jiOJ7CfSjvkWlFrHI5ZNbngoxM3PW/YpomxCdCCKapVspsXgaQdj
 2i740CnM9RzKapr4fyiN4NN+mxfWOia4XyvEdH4vOkakyc5bhy/1o+RWESDzevjJLS+7gajiU
 +q1aEAQSb14MA9/1sgcRDYnY6RftFZspwSBjFF7PP4blHqfOGTPH321vR5PaI5Sh1+YkDQHkU
 YEtxLgR4YQgdWTnqu87avJWhNK9drKl9Zk4zLa0uQcolrSEwVPRuXgkxWyIFvYUJc5NK+Ozr2
 0seU4QYDqh6EE9D9PrU6IlDAqUIytlLiDCW1iwJ/SkRB67PA5Rqkxt498YtybKxX/jV6l2pIc
 d7Zwum8ijAY1mqVHPo1QejmTs6bm2NVpdqSCv04hKnRWh4RWp58i+lnBq3YNhj+z0nJE1Q7bC
 ZS/ZBKGi3NcqvDwVdHJQfFHPA3lJlr9wp8axcN8Hz+s51SKSVN/SQ0YofU3Ii6FJVGvstSai/
 dpihE9EKq7ddTe228EdRKNqZksjlqUEHBk8ASFenS7kbtkFPDKqwz+sja9bubKKbeLg+CuBFJ
 0DBZNBKdmOmh+AHX2yr6TXSAV7hIPLL6HyLT10lXg1H7IHYzXFbBGA4GiQ4Hggo8eeDbIu7EP
 x/Y1wTaB77RHCqRv0U2tFCZJiZ9f6/ZXfuKmj3tZhLYTjnanaeaBNh2zM0AxJe2mDw43kPq27
 W7sLN9Yd3C5UTxxMwNTtaZst3ogk0IduygGJ4i0qAreEqnlDJ4+b127OeJ02aAvIz7Aus1aia
 33nn8vOX0qNgyOO8H1RaFmdWIPcrBQaWFzKT5erP1APsAP8fEihxfTB6VW+DZsXHx29HaUIQ4
 ANal9ibKCfZjShmUITJnpZZP3810ZNQjIRCaUwCnw/y0paLSbyUnYabmQ5oorOt8U+q9RDHI0
 9SU4SoNr1Kxg6eksqrxDquKHO5zc9c8F+Y3oTnj47jm2G6TrLOOHIDorVJ6I9zhpCmcz283RD
 +VpEN8Uwh7BMurVpKDLcxvdfUiV7vNDqx7t0YSDMxaQQhjsYC7a6NE3+pmvQtj4Lm1031yt++
 gz4aItZ3SN7cXC66yfcNPKXxZLjEc3XGVupb5e8vT0ddieXmWg1FyncszDs7YBqxnAcbTW+dp
 KTY/6+w/vxYOM53T/gW1v9Llsj+PV31aQVULcf27R85ImAf7yyccivr/VNBL/kuImGHuRHhZh
 oWJQduMxTOZTKgkTSXldOOUEvz/+dlQ0HpKvSNuIaltkr7EaJM+aOYIlkByiCMSOqC/UkjADr
 8Gf/hBtF6d5FdoH5yf6WoBobp64AH5q22PFNs84XBvjjG296g1XlLnpLJBsKRk0cn73FXhbLE
 Y0D5jKdp2zTW/HhqBmCxIW8aKUGR/D0WVuZELhBrahBDmv7+BFfAS5mL8+bs1x0RjAYS3VfXZ
 kvXHQU2cQad66gHF8u8hBW5kuRtt+2Ov/niJU9T6WvIVCRMxNVYzGJa5wQgAZgrA+zgdKUgO7
 qWFhgqByllGF2J9WCOe1TkePSmK0iQPcfpKRjTOnuEUsZC5pi5N48RTJMx1XrIDUcZMEchfn7
 hruodqtc7BTMCa+T0b/gCUbbBaOIok3EKNh/9ECpRcgkTm6+fosbbCeMoxRCj+hYgBhz0VZ7H
 p7Tf6gOTXcXGaTrIR9D4jhhipH7/I9jIJOjqwI3F+EE8n0Kz9fyFv92e1oTKZzK7XcKHdBjom
 DIHyvCi9W0j8NwviXw4VnH/yAI2pFyWDS2eQrXHyzsYGICH1xQQ+fFoZ1LPz54oEe+2oownaA
 6kd3B+TWm8x8IoMG1BvPW+7rk8cMu5ty8siceLRZ5t55outz6HMQ0SlX8cQ9r+t9HQ2lXviVN
 qWMaC79VhsP5sTm0ZsUetXoK3TkhRUPbW4YQpun1SdQeu/w1fQdSjFS+pt8hRmU6L94wwsk3j
 iVRSndkyNFC5foUVBu+Xu0EStgwgK1yyW4HdkF6S3pLDjrs9fl/5WWGczZxOn05V+Cr0rCP8u
 AwDQlU6HOQm2iC0zmtiNZHUVeAfJh05W4okGLe1w/8dYSuFTsK2MJY1P3i1ZhlngSDFQt+pQS
 vdwrrixTlpPOJl6I8nJDhDFIy43Slkz1gb60RU8uJJjSp8N+msR2sf//aXaLdiwlx5bi54BA4
 lsXstpC4wH1JKpryOOr5HCQwVWzvPB9rhX2DV9NwTo+QcYT6bx5BfdFH6Yy4f8rgcFCmkp6zy
 HXDilxWYc3DBK3nOu5CCL9hWhWhMNnwNxUicq+TiL3kwbofqpASI89hsteXj47SuojCoIj+6e
 +0bRS8uDK2ZlbglpZw9eYxLIzFL4Afm3w1xHFTK6g7EHFzOJB8dqkMfnXAwLXUNYNKC+jOz1g
 nFuZywsQ8A6saYZ1uFnIgSHq7qqkMWTbUew0oiZ85Mmb57GUgQe5MWzitNZPRcbCIzHS/Qcp4
 9k1vCmmby++td7acX2hnCSqzRsYLfg82eAMnKeN4zpkXFxlWYxQ==
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/_CO8C=aqKPfKsE37haJZBek
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Oct 2025 15:26:07 -0400
Peter Xu <peterx@redhat.com> wrote:

> Migration module was there for 10+ years.  Initially, it was in most cases
> based on coroutines.  As more features were added into the framework, like
> postcopy, multifd, etc.. it became a mixture of threads and coroutines.
>=20
> I'm guessing coroutines just can't fix all issues that migration want to
> resolve.
>=20
> After all these years, migration is now heavily based on a threaded model.
>=20
> Now there's still a major part of migration framework that is still not
> thread-based, which is precopy load.  We do load in a separate thread in
> postcopy since the 1st day postcopy was introduced, however that requires=
 a
> separate state transition from precopy loading all devices first, which
> still happens in the main thread of a coroutine.
>=20
> This patch tries to move the migration incoming side to be run inside a
> separate thread (mig/dst/main) just like the src (mig/src/main).  The
> entrance to be migration_incoming_thread().
>=20
> Quite a few things are needed to make it fly..  One note here is we need =
to
> change all these things in one patch to not break anything.  The other way
> to do this is add code to make all paths (that this patch touched) be rea=
dy
> for either coroutine or thread.  That may cause confusions in another way.
> So reviewers, please take my sincere apology on the hardness of reviewing
> this patch: it covers a few modules at the same time, and with some risky
> changes.
>=20
> BQL Analysis
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Firstly, when moving it over to the thread, it means the thread cannot ta=
ke
> BQL during the whole process of loading anymore, because otherwise it can
> block main thread from using the BQL for all kinds of other concurrent
> tasks (for example, processing QMP / HMP commands).
>=20
> Here the first question to ask is: what needs BQL during precopy load, and
> what doesn't?
>=20
> Most of the load process shouldn't need BQL, especially when it's about
> RAM.  After all, RAM is still the major chunk of data to move for a live
> migration process.  VFIO started to change that, though, but still, VFIO =
is
> per-device so that shouldn't need BQL either in most cases.
>=20
> Generic device loads will need BQL, likely not when receiving VMSDs, but
> when applying them.  One example is any post_load() could potentially
> inject memory regions causing memory transactions to happen.  That'll need
> to update the global address spaces, hence requires BQL.  The other one is
> CPU sync operations, even if the sync alone may not need BQL (which is
> still to be further justified), run_on_cpu() will need it.
>=20
> For that, qemu_loadvm_state() and qemu_loadvm_state_main() functions need
> to now take a "bql_held" parameter saying whether bql is held.  We could
> use things like BQL_LOCK_GUARD(), but this patch goes with explicit
> lockings rather than relying on bql_locked TLS variable.  In case of
> migration, we always know whether BQL is held in different context as long
> as we can still pass that information downwards.
>=20
> COLO
> =3D=3D=3D=3D
>=20
> COLO assumed the dest VM load happens in a coroutine.  After this patch,
> it's not anymore.  Change that by invoking colo_incoming_co() directly fr=
om
> the migration_incoming_thread().
>=20
> The name (colo_incoming_co()) isn't proper anymore.  Change it to
> colo_incoming_wait(), removing the coroutine annotation alongside.
>=20
> Remove all the bql_lock() implications in COLO, e.g., colo_incoming_co()
> used to release the lock for a short period while join().  Now it's not
> needed.  Instead, taking BQL but only when needed (colo_release_ram_cache=
).
>=20
> At the meantime, there's colo_incoming_co variable that used to store the
> COLO incoming coroutine, only to be kicked off when a secondary failover
> happens.
>=20
> To recap, what should happen for such failover should be (taking example =
of
> a QMP command x-colo-lost-heartbeat triggering on dest QEMU):
>=20
>   - The QMP command will kick off both the coroutine and the COLO
>     thread (colo_process_incoming_thread()), with something like:
>=20
>     /* Notify COLO incoming thread that failover work is finished */
>     qemu_event_set(&mis->colo_incoming_event);
>=20
>     qemu_coroutine_enter(mis->colo_incoming_co);
>=20
>   - The coroutine, which yielded itself before, now resumes after enter(),
>     then it'll wait for the join():
>=20
>     mis->colo_incoming_co =3D qemu_coroutine_self();
>     qemu_coroutine_yield();
>     mis->colo_incoming_co =3D NULL;
>=20
>     /* Wait checkpoint incoming thread exit before free resource */
>     qemu_thread_join(&th);
>=20
> Here, when switching to a thread model, it should be fine removing
> colo_incoming_co variable completely, because if so, the incoming thread
> will (instead of yielding the coroutine) wait at qemu_thread_join() until
> the colo thread completes execution (after receiving colo_incoming_event).
>=20
> [...]
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/colo.h |  6 ++--
>  migration/migration.h    | 14 +++-----
>  migration/colo-stubs.c   |  2 +-
>  migration/colo.c         | 24 ++++---------
>  migration/migration.c    | 77 +++++++++++++++++++++++++---------------
>  migration/rdma.c         | 34 +-----------------
>  migration/savevm.c       |  8 ++---
>  migration/trace-events   |  4 +--
>  8 files changed, 69 insertions(+), 100 deletions(-)
>=20

Looks good to me, you got the COLO parts exactly right. Thank you for
putting so much effort in this.

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

Best Regards,
Lukas Straub


--Sig_/_CO8C=aqKPfKsE37haJZBek
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmlrlV8ACgkQNasLKJxd
sljemA/7BJwslPkt6xSnfUzOWU+4Hos293YGSXQuWKRgKw21Ulp2g0/hP7F0dYBi
bcxx95IZ37yyns8x8oJIg/Hscv6Zx3/WR4s7wuft/nESJIYMsg2khzMfbg/cnABX
c+GVs/xar7aT/vLo3AV1ihSoEERPFM5RGfs14gpNTfGtpKCCTCg1pUKq51rPrwlo
/tKliD5O7LtZil6e6wwJhsumAtiu9YXk+XTeDu2FVJfteXOIJk+WHBPcvK1u4yf2
NUtx4qyR8S1ha71vEenjRlJvQrS8Ae7xZXZ7ZBdVjQcOEd9Q9KbyHK4HaGSLt662
Ai/UQaUzwHsP99WI6vlYWRPATGZbDSA6AQ77uQTnSRzZoqgPCx/oqsX8WbXIXACi
sY8IQZY5Uu4XtxAL1Y68z+hBwuNv7qKIMaKg5VAp/LS9/1iYc6XwnuJv+t9aKRYd
pfN2RYoNxmbb44Tu+FMLmWk/aCZTvFSXkZev9N4uuCjlj79cD69OUJpYwsQJ2cD1
t7ujmOuRc2Kla0EC24hVPAF4cHowUK1dbRD+TaQEVT5CAnv2v9N+CX6hufgZuJCl
/9meBQPa1nWp4yGnR6if9W8IZsH/2ILM8KxDqoz89maLCj9f/JWfih19I/RdKO0w
Dy+JIxf+iRmQLmo4R+oYMNds4uVwcXFCkqR8LVIxv4XndI6SY78=
=gxLe
-----END PGP SIGNATURE-----

--Sig_/_CO8C=aqKPfKsE37haJZBek--

