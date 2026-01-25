Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68442E63CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 17:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk3lU-0008Kq-JQ; Sun, 25 Jan 2026 12:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk3lN-0008In-8u
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 12:19:03 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk3lK-0007Lb-Fg
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 12:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769361528; x=1769966328; i=lukasstraub2@web.de;
 bh=e5kUmSMMsdnGg49lTq6ZeYzoM63RIchU79iM9u/1/Zs=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=HPnoR8ENscIsniFOe9hkmIXpj7NvjzhbmhD3uVAZB1/45ssQVHAhJSdWOl5bibqc
 YYye2frOc0BGmxDsnb7zXg1pGSEIeOQETTpBBWtXximVYrMb8v3Y4Qub3XlZ/aPJi
 XIycKVuoBxBlYPmV8jvlFGgf2QNkjekv78gjvVK763IhQRUamxZkgmFFFnGNV0Xwp
 kFuKKCaNL3pr3Du457PakqD3xxwi+JblVM5sM9kab/DjhjHPjsWK898Hkgt1B7jz8
 tMZsCwtkyhFITX1zT6a3oUuZFtwwdKxIkZAWoO7nEulZFlnitLqUAsjHbcI+3wzc6
 Ca/zsPwUKhWd9bXZEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.97.172]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mkmvj-1wBTHT0Uc3-00gsyr; Sun, 25
 Jan 2026 18:18:48 +0100
Date: Sun, 25 Jan 2026 18:18:36 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 5/8] migration-test: Add COLO migration unit test
Message-ID: <20260125181836.3dd2d026@penguin>
In-Reply-To: <20260121203751.6bc9027d@penguin>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-5-ab521777fa51@web.de>
 <aW-5_BtdDDLw3ZJH@x1.local> <20260121203751.6bc9027d@penguin>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/q1k1R62S_n.JEezF78JNPtr";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:L1KShd8h5P13920wggSjWDgVoL5qw1dWBkd0k6a6Ca5t/WkAjb5
 SkBp17kO1p8KMRAZ6cUQ2wTGmRCMRYZmxohN2exkGA//9VXvWeOAGvuOJgim5JKTUFr1qpA
 Sp0SScvNx77HxHwNOai+FjWbK6iGjdCnQ5oWnPzCHHt5PilMSvs6qJ2vTFbowfOUeMVacFe
 HB4iaHDUCqNuc/AXiBkaQ==
UI-OutboundReport: notjunk:1;M01:P0:7AML/Si893U=;MVtXj5ggbrPyY0UUNLHB2phfa/P
 kzayav100HxQw9PywfaupcXZF0Nuqish7DsOd08y6it74wb0Ida6C1AtCU0nHKE6rG9vG1moU
 FvIPlY2+zAnYleTBep+mTcgLI7UWsanmA4XZ3prHMtewqiAgrh4mptagDQsiArWtDlaS9rSCs
 rX62zv1lZYlfoKtCibpn1o8oK0P8J0lTt8Y2Yuy+bj/13hkLuk3C7WrHxJZ/bXTDD8KWQfyae
 zsOTO9JHv5kOqbiiOGG2mtru9tYycDI/hnw0aTByUlx+59kIqEM9yubv8hVIViuAEgs36jj39
 wOOdgn5mmc2QPuqsfAkFm5GT/48PciVnnTOxXJPgu6S3P2mAc11vSl/vmaGr+yvjCf4nrTe88
 H63iYpXfM+lYtZFIh6dhltD0Xv1TmSxYfkE7uQmGjEmHE0hh9OiS31EFbpNrruZCDBlWG/Ml+
 ApG6NmZmUsQNXoSKxebAYOUkip9T4+Ql6iZi9k2296uGe7nLPESDJDvN6rJhiEnsS4KZbgnCv
 8Ta4vUxFiCpM2X/vKAOOwdq4u6rj8aPf/aeUxdG65rTxMFGmUs1vw5uZ4UfHOGtAU0DflD8cg
 7GpZ8aNDRNbvhPzjT8yyz9HL+jQJrKxi3wicsvoxkaaXT8qH1KIjsxYf1o7R3w8tpWc6gy589
 ujA9/Zwj0lZVRNuV2KkySbh4IljhARNlA4BWcOcdZBQi4JFIyUvlGuZhyLf3BvzoGtt+501av
 Mv+GXmoRrLXfIPsJnfBAKcdvHpiaHWiDi/IROcZE03Vjzk6hNkYBQLIHZa6Ha91HrIoqe1zBg
 ABmdg7U1gQuu2rHZaanHQYeXyhsce3grLJFI9wOvE4VYD1QsVht9jRH0JhZI9e0gtNOsmZIl3
 dL6KYWOpkYxjbZMAuHfaogQfi4d8p1IL/uMnsVKSAkf8v6nzHo9EW2UgQ8rloc5g4+1GKcSfv
 O2JSs9LRsThxiCDMUg6BrvDLEZFd6wNgA8UGKVXup5SXYNBoPVpUmgX6I7bCGKHWY0xOloiHy
 KyB37zv5zPy3Mvh865tkmJQtI8RnM+urOydoZd/TORDAVTptTWzqc/USVeE5Y/kRZWPSCx8Jj
 gYZrpbGAHEqAosfmyCWz4872oZ9Lf3wT5tEFwkVNysRT+3kbmgTowzIJxrcSPAHy1g5XAHrae
 ItsVNseDbf55tGMG6DngYWG1Q495KgBNwdvc+lCovCrwZhREuV3yM1PY8YG7fgfPV3srannec
 1wM1drHSc5Qtn2TL37Ie4GIHsqeByLGq6nY2076qOCS3AicSBOmQro1d8+drYgmNQVlDya2g2
 XVmg65/bmyBm6MMRKMoVX/G2jwcjPpKxDZ7oTV335mxxcA8xtHBt4B6tMdjERqZxhjMDp3baa
 0aefg+htZ2Dk8Vr7njHKKW7Gi4G82HP57mZK92RjCb+VWJzc/7J2xRAMPxiN5ZaujzUrMVEnV
 XHh35qvby+4aXnE7pbLMJpuWhkkZOTrprFrB1v6vuhYyWpFiXzuKzhzKz9GemN9L1Kpilq9CP
 nxIlaSIrVtz3TrUQiWLCodHwirvBSIruy9oYfP9sCqJxoCaMOiAxSiDifSPNOdgpr1N4XFwFz
 1No4R7jcbj2KDCCn00fMRKZ3/IOvoq+5/e9P1C0T3k6/vrobe+fiRwGB/BAEJQ2a0oon1lbcf
 POfBhP9zmnduBMRXi0T1cQ5lCu/uNHSXjEtPhDyuy5oCvaojE/aTkKhM6dpUK5Jt36zSSwStN
 52kYaQ6OxPbomWciaeEQwwnjase9LkWQRNWx7bVg5qX/UzkXa64fwyCjzld0TQQE85emxakmD
 xxCPQ3RQlC05VaFbcjM67dOk6qnRPwoocZ3kmqMxzt5vqlFIPwWZZhAn3OonrJaSgcTM8serG
 6sc32YUWDv85BVWimBZB6E9RDaesZ859DMj7R7pgukgpyAQt+KOch/2j82ULAlgzoSxd1iAoA
 a7Wfshj1l09o6jTsAygzHuBsxs8MzpuyMbbQDJZ064fVnZ39ETQsCaEFz9WRJmLuY9KlwBO04
 0yYXNw0ZoiJc/+Lap9CM3nzw+oHYiGrfZ/Z0aHn0YFg9Ob8W/u3SBGQ7dL9Gb6fOEN4jSTqLI
 6ikl3a8LA9txahpTMwxsi1inuWazseMSbCoFJDEj1LLrV8pltSG3+/ZP0ha+pW4VGyfljKwaP
 yr+PANEYnLNFPA37+Ev0KJKprcbwqmcpbCDrKnD4pzryZHGlZSzAvYqOx/2G1+QYu32TxHWd6
 y4PoW+EHXu6df7TPmnb6BJbIFI6v4gwf9Em91RwrfPx7t9CJR3JgXE2fyHZh3rvZ2O5Hj8f+d
 1l/beBU1gxlJHL+qiAIpwuQBi2jy/m7uLRRv17XyIBsiNvHMePt1VZQZZ/EeMnS796WS2etyw
 lGKadTxFoSO9hPSVYvxNF7HMmKrDXboSf2NxOP8+K4U/vkNbrAp8CEyl3M4JqSxFBX6p3JDgn
 nghjZMhKuoBBhuEBEp2iSxyXYQ1D/FWkvyCbj6aQ4/fuY3xfCgNoVKph0SasHjQQitq637Ram
 72g89H2cNRRbPneQiAVBuuKC3XdwxkKt9V9Q7w9NBT6YaUSUn6RNfRFvDnmCGutRGZrCUUKwT
 KBj7oo7a6KXhrooZ311fC5ipsVQCIoAUnayVQY6ieCyf/aVgij4JwDepbQgb0Ki90mgRmThzU
 M3CMDj45vGybCAg5ZvkxtvTHCAiKhIMjMZvW8EZNmok/MGdSzUndb7SVMXUeY+DUif7ijCCqU
 zxhR7NWNRmPH27+7Pn7xJRu0SYUOZiDc2kIib6xLspAuTA2qCy+0eAyU4UK6pHDHWOyzXWWHQ
 allJR6YfgciQXZYzD9P3jZ+x8W1l5olKtbfrr3zJsiILz8WsK/E9M3w3WWQqVuNgyrbZ+IAor
 32q7fUHD9ds2kOlvGSVNpr6BKtJBKFT6PDq9eRSfU0be+HzUaCFfblI9SJEhRmuiDLF2qyJzY
 BqO8hqcX3R5JJVe89O1a5iuK2b5+ZZoCz4mqaDolOoTcNfuLD+ieeiKc0phoEBJ+Ttn64p3e4
 XnqyWpXqK83bt46warTleXHoWwzcXJjCDHSAG0LAThCJOpbU9yyLd49S1N8wyQl3KNIPSFPqR
 XEKPtYnE7YrJQMVM2HmrvLSUUlNOUVHFjAou1W1tf5+HQF5k4GDMgBYyPfjTBTM+Iq7o6e2da
 aaWnFOfr8bgn/DMJGUrLfi8QVKvRUnKwABXBYlwNnft8XCCh6T6Hy2gAE0fM69WJfPvIFOqpD
 j0kBqy++xW0E/5htvZE9ZVPoOPhJI+4x1elkIqVD8mjOW+7K5HYPI0MHRNya83FxWTWJ/6NSl
 wus3vhIhWkCuP56OHoTZ12bYOpLji4Cadz/kckpbiODNnopurFD5Ernb1V7AVlQQXmI10MVQS
 sGBdQFiVew559BSr+qui7kryeu+4i78YDrov5TNxJs3tX47sUCA1AYuD9RZgQwSrzEM9ukic4
 +ZbdymYZZcNp2vbXXg/QyI65kmyR4uihj2WO/Cvc2EHRC+hvtotXKAE4cq6Ijhq5Bg44MraB9
 9DTvgCOgpjoVtwusjF5kx5RvY7z8qess5nmeMnXha8NAUyVkTeJ8SuiVjU4uRA6Yh+YD1NB24
 /SyyY5nAq22SP9t77ztrF2eaAr7ZKdDtz3aqLFiqM1jl2J32MvOfbZKzBjCt2L0EnlZi9E8wB
 JK3Kxk3D4zcBNUNoRoPOYfVvSiWo4+BAC4mgi0SkhlAAC5cbnBLgCxua/NPNnhIlnrpzr1b2x
 jnj49XGcbECepyQaK5B5DiOUqNdqoILmcn8b68HagbckTu4LwzWAyxoASGcfwZJtsMSHSC8RK
 Km094yJ8FxZ3H0M5/XbvjPyxKdNr4EueOOWxehuT1aOV2ITvW6ZzqQw/eP9YqDwGiBwMZrv8E
 n/QuncXaeVvlESW4C029/i6qJzFaAj1wUcjbM8v5GHX7ACWZva6obyVzCTSRVzbBNRzFiH2Yr
 F4mfGuQOaXq+Gw14EhXWWuD7CBeyF/CgcZVm0ZEN1XGrbsrkxy9No2jn+mnfBR4Vga1INI981
 BZPp0Zc1Y5EDZOqqmgSoi4olSbNtNkoAqLY1WYL/o/xyowKL3ftb1+zKEMQaJYK0e+FCttbVS
 kDgRJaUaQfmIHa5EkJkeMUACBFppPRgtvDrHa/uA1K33JUh7jpGP3+1yfG8wSgqZ0l3cTIEpV
 LzQMYNa6MV2G3RZoMo/8rfQm5cwU3vum9D5JdOqV1Up8usIkiPP6W6CieMibh1CReF5DR8Aoa
 tMEnEg9rQjtfIR8lpJ8rjSGCTxvzrMVvlYG8iD4KliNqNIwSgwwGZsGwgqZVyElBIKddPbG0Q
 SKQ5NoGQJW5FDF5EIEEYVJtd/9DN+ndJv8AYKxk/+69wh8zRUPNlO4FItCKj5lBC0fE24jCgN
 Kc9/kaarh0ciUh6S+Ty5fjyIwPTCB/1RxAtPN8yWTolitgXoWkqX6KWAqMMXNGlgvOFx1yAhr
 iOHKfX5eM6cvAAb6vteAXrdEc2r/Fo9nrbDwzr2I3X0GlPiERT6jKgv/7EAMoD0pa94RHIkQh
 C5G0o74/F64Y38kWdqMELKCNCfzGgzs52ZUlr/ACcELNDhZdjhM4IGZKJ0PT5py7wwgtkrN/H
 q2HrThBN49bnjnMdV8T+cirM6Y2/BpI5o6/xl/CyOEhjrR/URt6hLpDMV2J6PNt5VIPjFj95a
 3CsxCHjx9N1QuoIqrfkoIYqdV7wmPspOSym82/nerhfUHdYprQRmDB5BQOUgrVQS5GG4YKeCy
 gUHrKEcxnoNXGzPjKlXRB0FHtVcaz/TCb4x1i064Ni+5jXckvMXB2HsWfQ75FeqIGmSyAU/cu
 rDZw1eKSDxRTDxRJVuQKF5rZ0O21aTX0SFmeJtpKpv5BPS2ASfswQP61JMqp2+c4a0+1zsTT8
 9jkvOXLGOYQazpdV9vVF6dxSAnPcKl0WE+89W188/74KVYe3PLMRgZGH9BwU64PeBOK1W50yN
 5WvLTdZCxKJFgse1Qrmc/WU5Ii8S+Be7+XCqe3QFzzNUX5Poa5cpfpq6xF4o6+dEk/QztO0Mc
 mI2H0RosX2t2h/sL2CS2AQdGamJgxaQ9ZaQ2KxwjQSwvD9pwCmY9rfnVYNT1T2OPTSzIZEJ1M
 B5o+2JxohIfOk/izUtT7Bc72AGDBe3S+Q6yworqySa23TewrMMpdVGbCC39p5jjUFepa/WTYg
 DJdKif2m2TWNFNdVhzEY7aWxqCrIfocFxdCk1vpUy1l5pJZ5PAtD0dDGZA3DWym8V9YwEsg7G
 qshu96msetCoTHTZsAqd
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

--Sig_/q1k1R62S_n.JEezF78JNPtr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Jan 2026 20:37:51 +0100
Lukas Straub <lukasstraub2@web.de> wrote:

> On Tue, 20 Jan 2026 12:23:08 -0500
> Peter Xu <peterx@redhat.com> wrote:
>=20
> > On Sat, Jan 17, 2026 at 03:09:12PM +0100, Lukas Straub wrote: =20
> > > Add a COLO migration test for COLO migration and failover.
> > >=20
> > > COLO does not support q35 machine at this time.
> > >=20
> > > [...]
> > > =20
> > > +int test_colo_common(MigrateCommon *args, bool failover_during_check=
point,
> > > +                     bool primary_failover)
> > > +{
> > > +    QTestState *from, *to;
> > > +    void *data_hook =3D NULL;
> > > +
> > > +    /*
> > > +     * For the COLO test, both VMs will run in parallel. Thus both V=
Ms want to
> > > +     * open the image read/write at the same time. Using read-only=
=3Don is not
> > > +     * possible here, because ide-hd does not support read-only back=
ing image.
> > > +     *
> > > +     * So use -snapshot, where each qemu instance creates its own wr=
itable
> > > +     * snapshot internally while leaving the real image read-only.
> > > +     */
> > > +    args->start.opts_source =3D "-snapshot";
> > > +    args->start.opts_target =3D "-snapshot";
> > > +
> > > +    /*
> > > +     * COLO migration code logs many errors when the migration socket
> > > +     * is shut down, these are expected so we hide them here.
> > > +     */
> > > +    args->start.hide_stderr =3D true;
> > > +
> > > +    /*
> > > +     * COLO currently does not work with Q35 machine
> > > +     */
> > > +    args->start.force_pc_machine =3D true;
> > > +
> > > +    args->start.oob =3D true;   =20
> >=20
> > Just curious: is OOB required in COLO for some reason?  I understand ya=
nk
> > you used below uses OOB, so the question is behind that, on what can be
> > blocked in main thread, and special in COLO.

There is a lot that can hang:
The netfilters all run on the main loop and use blocking write.
fiter-mirror on the primary side mirrors packets to the secondary and
can hang.
filter-redirect on the secondary side redirects packets to primary's
colo-compare and can hang.
The nbd client on the primary side that is connected to the nbd server
on the secondary side can hang. Especially during vm_stop() which fluses
all inflight block io with BQL held.

Regards,
Lukas Straub

> >  =20
> > > +    args->start.caps[MIGRATION_CAPABILITY_X_COLO] =3D true;
> > > +
> > > +    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
> > > +        return -1;
> > > +    }
> > > +
> > > +    migrate_set_parameter_int(from, "x-checkpoint-delay", 300);
> > > +
> > > +    if (args->start_hook) {
> > > +        data_hook =3D args->start_hook(from, to);
> > > +    }
> > > +
> > > +    migrate_ensure_converge(from);
> > > +    wait_for_serial("src_serial");
> > > +
> > > +    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
> > > +
> > > +    wait_for_migration_status(from, "colo", NULL);
> > > +    wait_for_resume(to, &dst_state);   =20
> >=20
> > We can move this whole function into colo-tests.c.  Here you may want to
> > use get_dst() instead. =20
>=20
> Okey, will do that.
>=20
> >  =20
> > > +
> > > +    wait_for_serial("src_serial");
> > > +    wait_for_serial("dest_serial");
> > > +
> > > +    /* wait for 3 checkpoints */
> > > +    for (int i =3D 0; i < 3; i++) {
> > > +        qtest_qmp_eventwait(to, "RESUME");
> > > +        wait_for_serial("src_serial");
> > > +        wait_for_serial("dest_serial");
> > > +    }
> > > +
> > > +    if (failover_during_checkpoint) {
> > > +        qtest_qmp_eventwait(to, "STOP");
> > > +    }
> > > +    if (primary_failover) {
> > > +        qtest_qmp_assert_success(from, "{'exec-oob': 'yank', 'id': '=
yank-cmd', "
> > > +                                            "'arguments': {'instance=
s':"
> > > +                                                "[{'type': 'migratio=
n'}]}}");
> > > +        qtest_qmp_assert_success(from, "{'execute': 'x-colo-lost-hea=
rtbeat'}");
> > > +        wait_for_serial("src_serial");
> > > +    } else {
> > > +        qtest_qmp_assert_success(to, "{'exec-oob': 'yank', 'id': 'ya=
nk-cmd', "
> > > +                                        "'arguments': {'instances':"
> > > +                                            "[{'type': 'migration'}]=
}}");
> > > +        qtest_qmp_assert_success(to, "{'execute': 'x-colo-lost-heart=
beat'}");
> > > +        wait_for_serial("dest_serial");
> > > +    }
> > > +
> > > +    if (args->end_hook) {
> > > +        args->end_hook(from, to, data_hook);
> > > +    }
> > > +
> > > +    migrate_end(from, to, !primary_failover);
> > > +
> > > +    return 0;
> > > +}
> > > +
> > >  QTestMigrationState *get_src(void)
> > >  {
> > >      return &src_state;
> > > [...]


--Sig_/q1k1R62S_n.JEezF78JNPtr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAml2UG0ACgkQNasLKJxd
sljUXRAAsqpNZmQFXmD3q2EmFX0kAro/eo9nfVn/1KJop7QJKy5Sc1xjEux+uDv/
b3x/xCn+8IeglH5HCAeti3FoaH3J+Xfs14Ivm3Rs7vXQeXOeN+vZqL674d4jrfEw
8Kr9+sUQdslpUkxRhEh/uDLJDJCxpi2MvqvwKzj2/8S97wD0JB6f4bdMgkaPKW6o
to/Ouwoc9V3YRFvlcFwhXNYAKdYLg6W8uyoKQyrwLiR1/1KFauyTNhhIF/MDHZfV
AwIWF4euWcveKLsICe096Qc/B7TURG5+Xfjqirb+aURBtpbvSLLIsCp82+NXsMgw
H0JuhqgctNo14gNQk86w2+DgLFwi0cOQI+aQC0DHBuVWWJ340f+5ZJ6qwyLsRQ2Z
W/AZI+b/71MGCScDsL/L/43UKh1wa6SwWLo6dWH3B0wGcVQpSfvlEHPGk9t4VwED
DA9Pi7fAF6zd/r6Q0LokE37XCgmOtEBNdh8LUIA6z6aTRQrCALGVS2YAozSG71VJ
1c1xOs73zCFwZ1ZZ2no8IhJ7tm8SCnfg3VGxWf31uKPSqGWB4XhzBEAiRboPp4+u
DdBPjLWxKWdF8odztd9Z/FmYjoZbLEYbY+mdq00KJ0+HzPXh4TQpJIHTmWvVj4g1
c/T1a5V4r3OxuX1KT+gSttoKqp2y0YYTQBjKegm4OtYFKSrLIQk=
=QNTt
-----END PGP SIGNATURE-----

--Sig_/q1k1R62S_n.JEezF78JNPtr--

