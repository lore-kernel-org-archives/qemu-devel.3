Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9216C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSbw-00056A-4g; Thu, 13 Aug 2026 06:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wuSbt-00054m-Ir; Thu, 13 Aug 2026 06:24:29 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wuSbr-0005oj-HP; Thu, 13 Aug 2026 06:24:29 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 16B6B1400032;
 Thu, 13 Aug 2026 06:24:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 13 Aug 2026 06:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1786616664; x=
 1786703064; bh=CIPTDFIxzIko/PB0EkGq2M6/R/F9JQGIqlUWeIy0LZ8=; b=y
 1J0LWHFNYt2ChCwHjkOWv2DGzDorWHhxrxHY5wgswRS94jqftolVTN96uZHNjyU6
 /eeoFqM3+XwwL91vNUzn3hmneIuBnHzb5eq4VF5//my6FYvv95RZlC1yDt4t8BLt
 Mlb940jQAMQ7Rg+GqWGtT3y9bAAIZ2pCq7Z51H8bx89V9knQSl5b68lMAW4aqV6B
 hnvbzzI1jI1CS+Kjo36KQdnAk8iUi+alHDaud8+BDB6yLvC+RxVUJjMFJkWpJ3Ce
 wpioefLNwncu3uwOngtCYnlZc0YONKpaJdTtgbHOIPLONzsbP+swJcdiI8yYCtUf
 JDdwg/YW778ikaYnclPxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1786616664; x=1786703064; bh=CIPTDFIxzIko/PB0EkGq2M6/R/F9JQGIqlU
 WeIy0LZ8=; b=XdTkWwiIq0zVfdmcVUP/H72FH3urvqPqkEyI3TqTu8tft4jTAFI
 nzHCRFErrwy7vHNo1hvzdOs/RMzARJDAzi++G9a3LkYYN4OAYqHZIGm5PFyv0Yf7
 ZIb1BXV1RNMmmg+5NVJedxn3PKK2/vNP9ZCXlXM+m8FukYcWgJGhdA4MQo5wDI8X
 1eY+URdV72qCNxqetNS/3EBfsvVxWQy18bcQq6TcUx/myxgg86yX1HA8X+w66rz6
 FlGCvlKDGz7LmE+K4YvZuQ9Lpm1aMO9lSpIRkBjTLWE/8XdSlfLFCIj8Roqzxrug
 lbPxIXLwGPxwdCbdtKT/huOPw+cjyX4HnMQ==
X-ME-Sender: <xms:Vpt9agdwtmLaPi03r4-DImUwUIQv5YKQKkejjrDBjCPGnG5nuZLBAA>
 <xme:Vpt9ai5rd9eM3bLQJMGFKfHP17J9ueEeV1NWlKMtdsTra6Uht7LnzT6cpUTXSdWTT
 Sd1_rWs0KRuAOAi2GSVnaDyxcI8Mz0iVLQlqrMFZbcYTW0ImmxzopI0>
X-ME-Received: <xmr:Vpt9avvKQAIwdQN_JKbRGd9e8jPd6JJxmYEGhffySRvImb0TrBvXMIqAfWOLqw>
X-ME-Proxy-Cause: dmFkZTE3UVaQ/Sk05L4JTJXTs5ZxU42ngCUEBQY+gDxKqk4Lghi3fJhtl7j7TxyunWAjOj
 ik/ovrM25fsRFS6GJozahG06L5nisPkQVLPqWwS1Ayv62LH8FS5XiKjLE00woKZnyddhft
 U81y2iMyZNtNP/6faaUZiycl+BEfGpCRJ9QhmGhFC81NxF3uamdj591Nq8LLbdSjQLlhDg
 g5qpw5BO1D4Lh3LMtnK1SdXR6ziDI9JZFpmyyx+QqX+pGriGjmVEXkHzVWdgvkZ+19wOJJ
 CdZXi1bbuWLquHb5ZP1xGpr424fK+pSlWSxoJRriyOQk/npYaqpZcBvETnrIi4/0KjM1Oy
 akpvQ17PRWbyrCrqbt5QymmMpZMhmnsQwJ6VbLUpjv/6IdzsACQfZ6ZdCYpQ9UR7XG7nXJ
 JayguvdHSN1t01Ldf6KGR8N4WydQY3yVkBcJURXRWmtmHcwQ0doWIsnPwe/0kQMgbOrzvo
 sMWxQd9Nnr1/0vIt4+Wh9AlX12PHf9vHbkyjAD33PmKG0CfQsPCv5s4/TY9z5erdvZ9Ohk
 F+if3YfOqpb/K79HSL15UTvSa74K3HXV7B4aW5GONvzZu2Q967kotp8rCHFa541sR+Vz6S
 ThAOXlMdWvQNcBr4tczgWOCgFSEsrrFZGcoqUJs3HqhZuWVF85inspsI4ZZg
X-ME-Proxy: <xmx:Vpt9aqhOpUftK5JV3ei6C8hhqCG4yghdhO2B8cHvfjJdp1YqoSRrsw>
 <xmx:Vpt9airJx6wSsDwYyqPP7j5F83eCEKawV2U4xynhHeWAUpbsERumYw>
 <xmx:Vpt9avtd7Xy8_OJZR9EvrNAPL-8r0MLcS9LO_X0nC5N71F-ds36KSg>
 <xmx:Vpt9atZDcVS9QxQXnKipqEOvUcrPmkb_vyuuBJOBiFv4jEPd5tmBCg>
 <xmx:WJt9alikfo9HRvy0A-6Aj-QwkOlVoEIWaEnbldhNr5IhB79EHYU7IRLs>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 06:24:22 -0400 (EDT)
Date: Thu, 13 Aug 2026 12:24:21 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Leo Cheng <leo-cheng@vip.qq.com>
Cc: Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] docs/nvme: fix doubled word in detached namespace
 description
Message-ID: <an2bUneTLSavGFTp@AALNPWKJENSEN.aal.scsc.local>
References: <tencent_7CCA5131E298B98FB02B48E362186F801A09@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m87OjnaRIprNlkWW"
Content-Disposition: inline
In-Reply-To: <tencent_7CCA5131E298B98FB02B48E362186F801A09@qq.com>
Received-SPF: pass client-ip=103.168.172.157; envelope-from=its@irrelevant.dk;
 helo=fhigh-a6-smtp.messagingengine.com
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

--m87OjnaRIprNlkWW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 11 19:40, Leo Cheng wrote:
> Signed-off-by: Leo Cheng <leo-cheng@vip.qq.com>
> ---
>  docs/system/devices/nvme.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
> index 98a4401..531f156 100644
> --- a/docs/system/devices/nvme.rst
> +++ b/docs/system/devices/nvme.rst
> @@ -142,7 +142,7 @@ linked to an ``nvme-subsys`` device allows additional=
 ``nvme-ns`` parameters:
>    are hotplugged).
> =20
>  ``detached`` (default: ``off``)
> -  If set to ``on``, the namespace will be be available in the subsystem,=
 but
> +  If set to ``on``, the namespace will be available in the subsystem, but
>    not attached to any controllers initially. A shared namespace with thi=
s set
>    to ``on`` will never be automatically attached to controllers.
> =20
> --=20
> 2.43.0
>=20
>=20
>=20

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

Thanks, queued!

--m87OjnaRIprNlkWW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmp9m1IACgkQTeGvMW1P
Dekdygf+JzMqVDo1msBRPY/9JajgodINhGicqXStvb225T8NhEULLtmWrLctVlcW
yxe7tdq0xB/nUOFjkUAoUao89pXrIb7o8ar5nfAgpLwnrzfYRZYXWt4/cvQWOQ/h
Gqh40wxKa7xXXHR9fdiK2UMrqLR4tFgEBDNK6nheuHIKJ5iXjnfCQ6bWuYUX7iQr
lZIkrv7ocD9bL2X9P0bITFTgQd19WOQD0aK38xafKfyHrjLsCI0owIgKmfVQRVIJ
YG3YdhNCHtz6om0eNqQYz4QutqLvzwjFp6vk7fnuC3DSPH/16uUaacWDoOybPdiS
Yn9QT+Ku42//DPSMJu+3BD65U6Fy9Q==
=zVhg
-----END PGP SIGNATURE-----

--m87OjnaRIprNlkWW--

