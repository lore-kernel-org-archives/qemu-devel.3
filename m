Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90080D2FEDF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 21:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkqLd-00062c-Dn; Tue, 27 Jan 2026 16:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vkqLb-0005y5-11
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 16:11:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vkqLZ-0000jW-7p
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 16:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769548295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=151sA2ra38p1Qj6qwzYiO0e1Neofg2v6sxBOTrXd73M=;
 b=Dp9RK7GApjQGIq5PcnjPUO2nh2ACn2Gq91fsdbkFPSeMsqoUzLAm2puSY1u9Ds89ticjo7
 Cg+7By+JlcBu81PKO1amI2x+F9rMhXFBleS4l5cShQ5LBhjwYuHv+7Wscmbu9ByKMDL3kK
 1nx1muvHVuoWIoXHQwd7ixZMu/p/Pl4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-bWNWaEw9N8GY1itPYbGsug-1; Tue,
 27 Jan 2026 16:11:26 -0500
X-MC-Unique: bWNWaEw9N8GY1itPYbGsug-1
X-Mimecast-MFC-AGG-ID: bWNWaEw9N8GY1itPYbGsug_1769548284
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEF68195608D; Tue, 27 Jan 2026 21:11:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.97])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6EB9F1956095; Tue, 27 Jan 2026 21:11:22 +0000 (UTC)
Date: Tue, 27 Jan 2026 16:11:21 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: JAEHOON KIM <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 fam@euphon.net, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
Subject: Re: [PATCH RFC v1 0/3] aio-poll: improve aio-polling efficiency
Message-ID: <20260127211121.GB96301@fedora>
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260119181630.GA834718@fedora>
 <eb9693ae-6aae-4599-8c8c-22268357d2c0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uJYxvatJWw5rzBre"
Content-Disposition: inline
In-Reply-To: <eb9693ae-6aae-4599-8c8c-22268357d2c0@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--uJYxvatJWw5rzBre
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 01:15:04PM -0600, JAEHOON KIM wrote:
> On 1/19/2026 12:16 PM, Stefan Hajnoczi wrote:
> > On Tue, Jan 13, 2026 at 11:48:21AM -0600, Jaehoon Kim wrote:
> > > We evaluated the patches on an s390x host with a single guest using 16
> > > virtio block devices backed by FCP multipath devices in a separate-di=
sk
> > > setup, with the I/O scheduler set to 'none' in both host and guest.
> > >=20
> > > The fio workload included sequential and random read/write with varyi=
ng
> > > numbers of jobs (1,4,8,16) and io_depth of 8. The tests were conducted
> > > with single and dual iothreads, using the newly introduced poll-weight
> > > parameter to measure their impact on CPU cost and throughput.
> > >=20
> > > Compared to the baseline, across four FIO workload patterns (sequenti=
al
> > > R/W, random R/W), and averaged over FIO job counts of 1, 4, 8, and 16,
> > > throughput decreased slightly (-3% to -8% for one iothread, -2% to -5%
> > > for two iothreads), while CPU usage on the s390x host dropped
> > > significantly (-10% to -25% and -7% to -12%, respectively).
> > Hi Jaehoon,
> > I would like to run the same fio benchmarks on a local NVMe drive (<10us
> > request latency) to see how that type of hardware configuration is
> > affected. Are the scripts and fio job files available somewhere?
> >=20
> > Thanks,
> > Stefan
>=20
> Thank you for your reply.
> The fio scripts are not available in a location you can access, but there=
 is nothing particularly special in the settings.
> I=E2=80=99m sharing below the methodology and test setup used by our perf=
ormance team.
>=20
> Guest Setup
> ----------------------
> - 12 vCPUs, 4 GiB memory
> - 16 virtio disks based on the FCP multipath devices in the host
>=20
> FIO test parameters
> -----------------------
> - FIO Version: fio-3.33
> - Filesize: 2G
> - Blocksize: 8K / 128K
> - Direct I/O: 1
> - FIO I/O Engine: libaio
> - NUMJOB List: 1, 4, 8, 16
> - IODEPTH: 8
> - Runtime (s): 150
>=20
> Two FIO samples for random read
> --------------------------------
> fio --direct=3D1 --name=3Dtest --numjobs=3D16 --filename=3Dbase.0.0:base.=
1.0:base.2.0:base.3.0:base.4.0:base.5.0:base.6.0:base.7.0:base.8.0:base.9.0=
:base.10.0:base.11.0:base.12.0:base.13.0:base.14.0:base.15.0 --size=3D32G  =
--time_based --runtime=3D4m --readwrite=3Drandread --ioengine=3Dlibaio --io=
depth=3D8 --bs=3D8k
> fio --direct=3D1 --name=3Dtest --numjobs=3D4  --filename=3Dsubw1/base.0.0=
:subw4/base.3.0:subw8/base.7.0:subw12/base.11.0:subw16/base.15.0           =
                                                             --size=3D8G   =
--time_based --runtime=3D4m --readwrite=3Drandread --ioengine=3Dlibaio --io=
depth=3D8 --bs=3D8k
>=20
>=20
> additional notes
> ----------------
> - Each file is placed on a separate disk device mounted under subw<n> as =
specified in --filename=3D....
> - We execute one warmup run, then two measurement runs and calculate the =
average

Thanks, I will share x86_64 with fast local NVMe results when I have collec=
ted them.

Stefan

--uJYxvatJWw5rzBre
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAml5KfkACgkQnKSrs4Gr
c8jwQAf9GTc2nMoP4dxH/rl7siY1kYFurW4V/vbMFXBxCkFATI0p4Nls5PjEVPBJ
cnC8Xf8lUNaCd0P9Cfq/l3pbWXFPjPyQuZgvmD0soleFzka1vYxILICFV/wCnleD
mEvxw4bve5Lha62qUCmEhMjdI433L6atLdcwUZM2PHACagUjnhFmCuytdPQo7NWj
UPQ9SscPaWdBv5vOwhewchSL85NzlJcuNSwSlpnt+Ux/gfeScznUZTHKhE0jqO+L
YHk6y5ZT8OHUUS87ENSObuLpmU+wUiQ/xF/jKM+k/BmEOqXDL8Gcpf42/q2Akg3F
W16rvxDUVflzjVo8DL0yv61egb/5dg==
=I18m
-----END PGP SIGNATURE-----

--uJYxvatJWw5rzBre--


