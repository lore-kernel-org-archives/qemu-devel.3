Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9F6C54E49
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 10:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdSjU-0001f8-Na; Fri, 23 Feb 2024 05:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1rdSjS-0001es-AX
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 05:24:42 -0500
Received: from fout5-smtp.messagingengine.com ([103.168.172.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1rdSjP-0008S6-VO
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 05:24:42 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id C022B13800A5;
 Fri, 23 Feb 2024 05:24:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Fri, 23 Feb 2024 05:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
 t=1708683876; x=1708770276; bh=WWEo1IMUSNdbN/to8orlTB/j9PdB8Jbh
 rrSo2TGsJUE=; b=RXN1VLKjxVcJUPaCuBQoWdxBo5vAv467PFPuccGahiWKDIu0
 SMr8OwhTmm7NqiUjYcOZDJERjqbEQIWi+TdlpsNOf6AnvWvIIyh8FofpyfLGZPjl
 9xL4aX+TRbRAeVb91FCQ+1n8GWe4FxopQsO4AYxE379gG67wHZM6sQls9urQyjnZ
 mwD2rlDWkxdiYOnEfC9axEhUgTKEaiL8cejo8x287J4L/DMAPL/vr0qUr5W3m81/
 L9MY0nqrHJCIKE+Pj26Wv2Y2AsUidMbvloPRj/sIFB2UzS5Icvnk/MpsX29cr03O
 gK2Cvkw+uIIkrzryOK8X2FQynSqj4uEH9ZyCkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1708683876; x=1708770276; bh=WWEo1IMUSNdbN/to8orlTB/j9PdB8JbhrrS
 o2TGsJUE=; b=bZVbc7+zgaO+NyKXc5Sh/n3zf+tvZCHXyZeuuOgIXltshJj200E
 BjRW0p4bCXSowh+XoMWpGpjrHoYR7KY3KyYVLi6AQ+c4blg52YAkaO9b31BN2v/p
 CuYRzSkFVwK0vUFelui13d37m1CRL6JwKJ5eruG6KmolMmuSNtgbXBK2ISZ0JfzL
 bzkMt/U7LgdWCgbr449FgicQcQg1ognV4jR9DMAQnB2PqwlNNiM2e/A5QvMzGNlp
 xGSgT4ArHRqNcHtvXQuWlR1uTMmm9mzGwDHfu+NjVSenNflvSyrZ+jb3aLBz+Acu
 nY1vF8cN7cuRl4620+bczWQgvsMK3/tmKmw==
X-ME-Sender: <xms:ZHLYZQ-1u5C-GP4prhU78LI2-jTuPpdF3PE6QApGjg2lIdxbM5etgw>
 <xme:ZHLYZYutYXjbREaQWURaTVzI5F-omWI7qjdPPm2MUXxHGyH4sLHWHbyOjjM-z6zQ-
 Ml-sdQvszaQtTNiMcU>
X-ME-Received: <xmr:ZHLYZWAeBoG5QFNMYJGUC_tAg1wQGRBXJCAYw1LHMi_D-TuZFzutzXWMRq8e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeigdduhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
 ejnecuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghn
 thdrughkqeenucggtffrrghtthgvrhhnpedvuefgkeffhedvkefhueegkeeukeegieetve
 eihfeuuedutdfhudethfdvvedtudenucffohhmrghinhepghhithhlrggsrdgtohhmnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesih
 hrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:ZHLYZQebSPQyf_jhXkdTfRjW73oWw5zIHA7vmykEnYqo7yKWt3MTJA>
 <xmx:ZHLYZVMQ6nY7KvJ1vk4EK1rC_kfICWMVRbOrbUFwAX1G8mOYURh1SA>
 <xmx:ZHLYZakhvnPnySj7hoAzMV6ydWnT7_wSnrQXYoWtsQT8XJ8rYnPvlQ>
 <xmx:ZHLYZea0GVpE6cXy1JzF1QVyFPY0xfBYi6AY-Lsv4fmoCh6pDHqJ5Q>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Feb 2024 05:24:35 -0500 (EST)
Date: Fri, 23 Feb 2024 11:24:31 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: Clarification on cross-version compatibility requirements
Message-ID: <ZdhyX0eufxK1M8og@cormorant.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FQoOh2UGzWE75+Qx"
Content-Disposition: inline
Received-SPF: pass client-ip=103.168.172.148; envelope-from=its@irrelevant.dk;
 helo=fout5-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--FQoOh2UGzWE75+Qx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi all,

Yesterday, a bug but in hw/nvme (#2184) was filed

	https://gitlab.com/qemu-project/qemu/-/issues/2184)

The reporter ran into an issue with hibernating a guest from QEMU v4.1.0
and trying to resume it on v8.2.1. hw/nvme has received some changes
since then, including a change in the BAR layout which causes the boot
to fail.

Now, hw/nvme is marked 'unmigratable'. I realize that this is only
observed and checked under live migration, but I honestly did not know
that hw/nvme were expected to ensure that the kind of "hibernation
migration" works.

I already have a potential fix for the issue (because I don't just want
to say "wontfix", I'd like to fix it), but it got me thinking about what
the general requirements are. And I couldn't find any good documentation
on it.

So, my question is: when is an emulated device required to support such
version compatibility? I'm asking because we've also deprecated some
stuff, like the device originally using an internal Intel PCI device id
that we wanted to get rid of. But now, I don't think I can actually
remove that parameter, I need to keep it around for hw/core/machine.c to
set if necessary.

Can anyone enlighten me on the guidelines (de-facto requirements) for
this?


Thanks,
Klaus

--FQoOh2UGzWE75+Qx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmXYcl4ACgkQTeGvMW1P
Denf1Qf/RFmDUD6F0nv8r4U//3xAyCHhlQAndu3M7Wk2v1CarNb4JToRn25dJvxP
anynsaFbWKxq2mTXzzduRgRorgoxXh0X2GM0bVdUQ12t/y1ym2AxtbZw6015gwy4
pleR5ijovFs3PRQHAm4YyZfQ0JFL50JpEfj746+Da9SugcSm5RMNlHToGVZYsm88
7JR1lLbeM5gJMrWanTQanKRBHJFSFoIQVqIPOBoeowgn9GgWAv44jdAjSzpInqng
ySsIu6PTa9W0++HMMSXwrFbXcpYNDdVGNrvUuITsM0unWqUfP1PwP69KLQbDD49g
OyINWtld+tMNHeTCnvY8cII7pES20g==
=BktK
-----END PGP SIGNATURE-----

--FQoOh2UGzWE75+Qx--

