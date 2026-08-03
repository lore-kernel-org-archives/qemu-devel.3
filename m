Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C03C55179
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqt4u-0004kr-76; Mon, 03 Aug 2026 09:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wqt4r-0004j3-DQ; Mon, 03 Aug 2026 09:51:37 -0400
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wqt4p-00076o-JN; Mon, 03 Aug 2026 09:51:37 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id CB9D6EC0099;
 Mon,  3 Aug 2026 09:51:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 03 Aug 2026 09:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1785765093; x=
 1785851493; bh=aa17+ITsMHyYuWJkCsr2qm24oFkn94xOCETKLNjuSiM=; b=I
 F/7VXI3BIHhPfvT3924EvLb1kH7B04JawatiQD6fXfZ3WhG6Lmno/HrQgs+kdhWh
 TDECecxYugc/B8xsLkJYk5TVmBXrIs8z/SBS+6c2oxgP2lYBbdBVXJo+/ttqsrti
 6/r9BZkB3gZwBiyHD6sOXwMgxoSMaaFst+4nZeyn8L4U/bJpQ7SCZHvmjxXujPnL
 ZZMctNVkIA7k7dxUtIbBclSR97HB0+jWEiA9vCi9dueGwDg6yTjPt6za4JZ05uAv
 kTnawH0mG30Ij1BexYA9v3/0njfie8pdhI5W718ctaGfrAePkrpOBqPfH5lrqvmX
 Yn9a2R0Oh+knxnkMmy7Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1785765093; x=1785851493; bh=aa17+ITsMHyYuWJkCsr2qm24oFkn94xOCET
 KLNjuSiM=; b=aD1bilsxfBdavx3PqpXxKNWuj5C0XRCmlZM5MwW4II+LwUnT7W2
 X0YqJNNb07suXYHR9XLTYJ3nwpwoUGhg01T1yRoWDOuk1jTrRWQGv3ngiNdESQdi
 wVwdGDqk7/RwcRmyXqiZ/5GBc1E2MUF4vRN1mv6Ld9IsLHFV7qbKdKR5Dv1FCw1N
 sJ+IdGx1onq+Ivx1SH5b1AonIAsG8tePmyPvZyToeq0jlW9d1hPOec3gtWVLW3gm
 YZb5tpXoPUeg4meF6pkbwKspi74SgjjwTwdxJtu2Urn73qCm3MKbbAWVgjw23+KU
 ldKvBd3Zn/zjoNVEx1em9outF163UvOQZKA==
X-ME-Sender: <xms:5ZxwaimkNatXN8dyYXr-j-Sa6f2gyZTMb3Dm1utFEoCtdcQrxSTz7A>
 <xme:5ZxwaluOBPLiurEqkQTo7pK_qwV5T7uMv4NgAyPutCuocFzChnSX887MNDrMvrBOH
 8w_evuMTGvc3xkSUwIUDuJIIBiJAqmWcr6TK0m_piCbm3QbkrzFIA>
X-ME-Received: <xmr:5Zxwatp5hRncIfxPPK_CsXfuxeCaXdQUWzMIgzEDS2vywWRNYjBhIP6F>
X-ME-Proxy-Cause: dmFkZTEcGtEZPgiWOZeqt+Og9pYiE4Cflhv5AzKAVmMVJ/akCUdBSo/PFartvkQMBHIH+A
 9COMZxykclwnBk25NaFmJtTA/88G89MqnvczdgW3k08YiO8xjTLOnZnncA3zZ+IlKjGE+C
 /B7zVFVgZKzH4TiE4ur2Bua1FAI2/5TZ1Q9opBznMlCsDfYNO+M4s1X4X2smKbAfnFvVmg
 lYaccN5oddq7q379eP3XYqcsJlO5VZgGxWPfKQ8lJiISuZ9JBK7mEPnZE6PrsM+/HwSrnb
 7FtfleVRtN5J2fjgVcTEzKJEC80vs9wQXbp7wMZ/2h7vB93jIj2LKcg5tWP/1PZ59jSnuG
 yLPOiW55did5ieUDRb5r520/lPVV+gRJ8+7pDhqjcM9hn2fYSPVoFYvbVkZ6qq19yqf5ap
 ExKskXm1UEpQtEQy8mLiCavynRzCVnJ7pwiKzgYxBTXkq8FtIgXFsuCihiOM2WuEbqg2M4
 Zi2nhgHukZsfKzAZzTGjbbE4187FWhejrfn6Z2twAqaP3ChnDj3QY781R4cI/+in8UyhUn
 DKOmYjuotUuTJp7Ryy928A+9NLvo7LEpRy9PNjucydX2PgmGS/RVF53WJkWJ3slt8kWp40
 Y3x58DmBy7tynDInZNG7POPWKwNrb6mzbqDdgmMcJJfy4SEvQ1TmKYoaWFSQ
X-ME-Proxy: <xmx:5ZxwarcoeOertjYOTevVU48Nf4pTQSH2MgoeVbb5WhaN_N68USfcoA>
 <xmx:5Zxwaln5woXmu7XNI5-19u5WgtX4ciSNagPeemaP2PFcdKMaOqf_TA>
 <xmx:5ZxwaiZexF72Zbp1Y-BP4z48qz_cmg2oyu4NF04dAunXt-w5vQrbnQ>
 <xmx:5Zxwaq7QxMtfaQo1C2pbzAKdGBe-U0el-RkPTT72TfPEMT_bx-Jw_Q>
 <xmx:5Zxwanw5yEZh6CfarjBBIa_aY2ynj6dpSLJEqd0wPGEdWBULH7GyaGWD>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 09:51:32 -0400 (EDT)
Date: Mon, 3 Aug 2026 06:51:31 -0700
From: Klaus Jensen <its@irrelevant.dk>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 4/6] hw/nvme: Fix block accounting for compare
Message-ID: <anCc43cF93AXXRhg@AALNPWKJENSEN.aal.scsc.local>
References: <20260724152315.234183-1-hreitz@redhat.com>
 <20260724152315.234183-5-hreitz@redhat.com>
 <amn1nQAR37yHAhpl@AALNPWKJENSEN.aal.scsc.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D5YHw7M7scoCz2Yc"
Content-Disposition: inline
In-Reply-To: <amn1nQAR37yHAhpl@AALNPWKJENSEN.aal.scsc.local>
Received-SPF: pass client-ip=103.168.172.151; envelope-from=its@irrelevant.dk;
 helo=fout-a8-smtp.messagingengine.com
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

--D5YHw7M7scoCz2Yc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 29 14:44, Klaus Jensen wrote:
> On Jul 24 17:23, Hanna Czenczek wrote:
> > nvme_compare() starts block accounting for the operation, but
> > nvme_compare_data_cb() (and nvme_compare_mdata_cb()) do not always
> > finalize the cookie.  Specifically, there are a lot of error paths that
> > do not call block_acct_failed().
> >=20
> > Fix this by putting block_acct_done()/block_acct_failed() under the
> > `out` labels of nvme_compare_data_cb() and nvme_compare_mdata_cb().
> >=20
> > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>=20
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
>=20

Will this make it for 11.1? Otherwise, I'd like to grab the two nvme
related patches in my pull.

Thanks,
Klaus

--D5YHw7M7scoCz2Yc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmpwnOMACgkQTeGvMW1P
DemvawgAkq6yfnrAnBlbyRnBCnE6vthrkb8DuX/js1qYdlG+B61amoUL5hRjADPX
VfXEjQFqJfmysYpnyPQuhek2VwwXFucWFgrwsKp72MU2b7bulzcfansLup5fchX/
tinw9+T/AYr7JZy4sELhJeMafzimJf17YYgE4tqMxqT0RrI//USeXgNZmBYu99dr
PoIwkstdDJTa6PriaK3+jM8krFzgshfmkHagSBfMvj5wus3s0q5Ia/mSuHS1A2i8
kVydaRQ2EhfSqpvqtzW+3A0yJx4XiDhhaYL48tpuCM938equbhTYQFGuPntpyYnk
rRU1lIAVclVbR0qfVrMe4NsYTo45Tw==
=Ubum
-----END PGP SIGNATURE-----

--D5YHw7M7scoCz2Yc--

