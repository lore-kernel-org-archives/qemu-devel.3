Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C82109192B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 22:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3M3A-0005CY-R7; Thu, 19 Mar 2026 18:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1w3M39-0005Bc-0p
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 18:41:07 -0400
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1w3M36-00026k-J0
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 18:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1773960050; x=1774564850; i=lukasstraub2@web.de;
 bh=xUUKqcTUhhhtZLbMuV/1sjBDCOO/We+Bti0AKDFoO74=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VYHnSTWOUe80ouEptdKUozLDumkxv7AxwjN9GAerpo9oydCwTgHEFKE8vSh+RDd4
 ZhEd0xCdeXbSi2q6cclYlU5Gy3jClgCf1KksLXjIjSncL3gdq9xLcV+PNyw/+PeZy
 wsb3t0yYUf9hTc1dGto8AXwD2xU2IBHtGd5Uano8ypBqfP+vaOA9pOXrRPIif6dOD
 h9PutAh2o7kihaPNa8KVl/YSlRi1neRklq7j3yxXxt6jnKDCvhAtJtwHncMQzqVgW
 KQyjo0M8I+jSiuTBRdiIQ+5rJ9tfHTGa4VTw2cN1/9gdfHz5rSZrMU/bVElv5x9zM
 GHlI4nrTJ6JvvnZi4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQ8ao-1wGT2o0CwK-00IKuw; Thu, 19
 Mar 2026 23:40:50 +0100
Date: Thu, 19 Mar 2026 23:40:31 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v11 13/21] migration-test: Add COLO migration unit test
Message-ID: <20260319232607.6d79f980@penguin>
In-Reply-To: <abBYAVLFQ9YDIKpr@fedora>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
 <20260302-colo_unit_test_multifd-v11-13-d653fb3b1d80@web.de>
 <abAvHRJJewZOz-BW@fedora> <20260310162954.61da59f1@penguin>
 <abBYAVLFQ9YDIKpr@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UK=lmMuo3WwjUGui3sIhh7x";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:jjLj+bBme3pij2Xg4QFA8+Cd72UTHAT5i1V/pq7yCnwnfqludaM
 huPA3zdFKFyLCgi3Kono1+QRFOgqYrW5TEKEq83IDtlW8pzE/njuFWQQD2W98Om46oneYfg
 y8y2lncSMllF9J21gq5bBbIBzcj0O8nR5yC96uI3iMRQOATQ7xhVROiTCxWweqFyzQXok/2
 KXKgmvkpH/HbP2I5IeRBg==
UI-OutboundReport: notjunk:1;M01:P0:Hugj98Pi66I=;K/w6Ny6eLMLascNQAubwMi9Ru0i
 72NQi5iLIQgibQJUwej3YkKfMH5QP77/RRTudKH4Nk3DwgrFIIvlaEEZsLYpkW40dSjdSCkqV
 8RCaKosBFnQkXQzOiXA0BqbZJLjGvbtSZG/n0KSMX7CM4urh0UclFy4eH6CYNmWub9dezjZyI
 sLoPrAYFt3DtcmFkJT2xlohRXXNhtRsb+8QaA3UuznrYuLqfq5TVKUlJvcUDQNFse8CxVCrGk
 1NuJscFjQQAe/MmLnTUTTzkgILR4IQNsmKGNjz0jTB4y0vNYzTBQVvt5fqEiw59+tB+1XGkg3
 qwi1c3TV3GtQzhi3DdlI4MA9Yddh/GHakm5IJHDM2xFPOIGy1NFOFBlKKqJ4YICN/NV4nXM8Z
 aLWEAvFOJowWpdY4YHJxMnB3fVNXnVW+jrcY+0/QSlQuoeWZmV0TQHizCSNRiGRgosRx5Yx3L
 qLGtwutosNPLfJIM6ja5NzMKW25BZiH+d/jYRSUVVe7IdvQXjFqtbrMlHUtKL0s+kyRJEuarc
 eARIb3ZqGundkAnVmZvELCdJ0A/A/9tAn3QUfHvXwJxFdHoyim5RPSCAJ+wtWlXi/1vxYQ9jq
 jwccdBh8+Xo+rC/w229DaFanz64vEohDStRXTZZaAgACeZPRsej4rVNB3X0cjcL5W4hjurnBT
 +PKUAUUSeCETpx7/TUZ91icJ8zAnTab0JqfdCOTmjdNfF228HAM6QiLVANs3hF3T3wgTqPxgu
 FEp2icgIdsq5cJ8W7V7uNfafF1UC5OOVdPj/WaDJOJExA1GZUR8QDLoBrAtJhlEEJsFeI6D5s
 dj8uk+jClbxOud5vR+CWSQRAolbswkrJCpD1qSCHzpnqX/cXbI6CJkshr0CsyAuZu9abrAxjT
 Sms7RESWnTP8rkaw2dt/g7qFQpiYkETkn2FoeeV97vy9P4+E9kT0X2DX4ULGfkgbXZtq14ABM
 CXPXnEJVU3DZlrX5PWp1X/uydiLu4eRQGtgZx0w1KvUr6+h2AUgHkd0xLaIgYNM2LlVFCstW6
 4oVgPOTuTxdvO7XjXHQCPOtVOTECtb5sPL7/UXsd9752uzkCV+9qhUKYMbx7KylXDPLgAutWg
 PVCRp0Fjye4mpX3dCXHl1w5xT9psGS2VMGv/5IIIofEioWuszMKozMkCicA1EIty0+H2PkQs/
 t/q/BabMqleFEILtDt4WWtbL9MNNPtfloHcED3sca1xB3nkDG+2uSm+mxKF0pHn61IoNbupFG
 AUTE/BdFBX6AETj60W+M7VzflL7zqXTX2nLqV3RFlt2/8LyawUyKnRXlgPawlrRUj5q5dj6uB
 p8P9O4xhsv17Bgw03uYkVHrHBuwwcpDb+rckBYt874IAHR8qI6sgqgbP4FY3bTX+0x222mFSP
 pt+Zf6s+2/Alx+EsiMATh2VXJ3O3QbkS6mI6Wadd03V5pjRM8fU9y1x2uCl4xnr/7GTx2+tfp
 azfjvg0R5PJImWuXmq+oCojZtG84LGodNJIrL33wMxLRmAWgBj1lcqlc4PC9Jt9nEltX8bhvV
 wm1gxcdSv5he5bgJeVx1cyO0domyLHL4UolQmiaZQoaPqcbGii6g+1VUW9kSyKZ6VJt8WRNbZ
 0Kztie2cOIZZa2PwjdSLv/jc3mDEkEr2nNlhAup8PQwpWeaDDSyiBhEzPfQWf7qy8SH1wNegS
 10bV2cl1ZJJDtMzou4Gpdn2Ff27Ogj4JSxCvjDb8nGYEMh29fFJWg6dlygltyeAP1u6rVxV2W
 m2HBIzP5QNCswp3NYOxyPWrCuLT7knHvbY03F9ZK/1DezwFlwu4Dt8Ndh+mBJSasgZOk+9vYV
 JGk51gxf0E2pjvKHVGNi2C2A6o2L62AkkUpghYne0Zr4LDXN9n7TjLDOZuzJw6uzpPaJR1Gs1
 ROMHRIMHh9rAn9LgOjsj3a0kjniTmsY6pEQOESH0Lm4X9Fg0EcYELQhAWaqpjsvSx01MBos5D
 Hf2dg8z5a+vSpRoJq9M+oF3TU+OUpC6sXZ9TLUWSdAwg7zez3+Nzeo6Yagd5SXAFhd+vox1yn
 fEsW8+6rusqFd/40oX4BEg7wyp0k005JZy8YDepjXPU9AX+vn1y71IrfgJxhrGBE2ebt78f58
 xiP50YnoN9ojVrqqTe9vmUSFz6vCjckdkXcLxvD4svwTnGI2VWQL71qv4+hsfzRfoNIvEVwHn
 /sI6Ap9BJJnCrpD8cja6gUSM874D4w72Ga9eC1DI9nSKJuwRxy1jx1ezH6lGv613inPhwGEtc
 Bk8GTYidEwqyB7t99YNCHwmRalkRJ04gzoV69hz4HNqKflAJdvS8BAJnOlFatrw5oddQH2MYR
 JoecBg0NwiBRZSceVEl7Sp7LeNer/zbqm+kt/03FFrg68+U/MIwza4S4T7On+9jTRonMYI/sU
 l6I2pu5DHBEM4yrCgssjtr3FRXE1NKLFUZRaqzSES0tXOYxn902aLUOMnyFLR0XNFfbqMmsQv
 WrY+U93N8Zk4hdhw9VuytghwuCOgB41Vwqy+yJeqttaUubRLqhq4Ax16BbaLbo5Wg2mUHKIZx
 OYLGuEYrhGmVK9ziDedow8R5COHBqNGz4d1jcooyF/Bug6Yv87pkWtfjkQRVF1xPY3pdoh8oE
 FwdK8lWq3JmC1sG3AX/pN1TlhaPikQAxbpsaLhI54F+KkIImbT+xgTQne3aUnkMYOuwYdMaWY
 ISwoPk+NdXMFZSX9DwRoxAzh+9eNv1Su+fUxevbCxpB9xFfyhhM3ZnJT2eqYjojl8bnjNi783
 UDO0FLjXsBLjOAfufZeHd4iLgjU8uHjLNUWGE0hrtixcEMhScZ3cXRyVrmHO2Itdrvxfb/Elg
 qhAZ7bV+ZRAZR5XjRHHQL9E+doukDZxDBvy/pRaittA40mP2ulDI6av9CMcoeu+Tb4gKv8bzI
 SLbsqvQ6VX4HApk9yJK7CEqaGi2GNoFtOvW/CG+NiJWrYf15658C7XzEebChh2YnmhKLfmq48
 BFPXzd5J/sVsJdoS6uoxrYirKS9NQuhh7+31MNjTPSy+7a2btnM2fj8eAynJNEtjZ0GLuSPvN
 Rfw3FCr3f1n2clRE80h2RlyRcF9nYjS4xHZsAWQeApCwKUFIFZo4Q6Elnnp4DJ40GOiw2VpDZ
 HeTeMGqYDYW5Qdeu6itswto9U2sKO/22D9OEaQTEAUCwx4kP4zXDvplRzSgWGxpuliBfZbjGH
 fWIr1hBfXO6IV3jQglC4QJfGCHeq9i3Fe4MmPcnvQxWulpV2g8psJ0rxO8N+NMp9m8gusCzqW
 d5C+DK5Hoec7CMUuYDeBwZRTunHpMGPMNf3um5lPbAnTJBaOUJ/y4p31c+HfubzHJvIB4gufJ
 ceirpHUkk5zqqqaXMqANLgcCuPrYGqThXY2sKEkAwz76Aux9UOTsoTNR+quJfIGuTtu6bKe5i
 1hrtWGD5w/twjUyFET5xeyqWaaGHU8pZj0CR8RTc1MhxxH6a/S4q25Nl070Kyv6nhZE967wh1
 mOBJ04lsOaeXQVXsSS/L1n6qA7KfNaMPiG7SapdU9CJ4765XaET65e7xJEXX80pvsWspDpaM/
 oMK+G9VOzJC3IfXrT95cHvececO7eFP5qH2xWn4dVnfQLbdeSPWdRKv2N7Poj+KQJ5lTxPfK/
 7OMeeesY8wsxtAL8A4VDjxNNmOzjx7MoLbgTPppMkz/AkcUwL/bqDHE3KJnaAWTO1gAdOlE8U
 Hvhlqu268tR/GcExF/sZ+h5aqHx92UqTuOSdDX+mys06Ea5lzZaem2tVEAo31mI7CNpWUBg5l
 mkiLD2qGWylNuifruwYcRHZOn1YDW6Ofan5fOWNRAzHA0TKtAR4AjE3TNwPP0bHt9+UIlMmMG
 u6ReNekdMd9PJWusw+jmsArpd4UepzuIfDEFqGycG1CCXwvhwKheaXi2/knw/ACzNKszcjPDx
 Ob5VQwUaPLvtc4pKWap/ZngPVdR/odLP/xF5FrcuunsZoTbvzH5BqoLOEgHEF1stkP9qLn9Sx
 NAmhi/HY50zv5UeaTweB+EGKXNzpeC1ieT92HcjzZcN1g5yQDg305OuwvCRFaeOpZEt80Y7yI
 TWoFvelop6I+hVZwFyAWvLjRZ4rOWF5ZarPB1YZ1lj1n0G+0CZ6kO70opqd0oAvSwGwurVXBJ
 RhJqZ1mawxBw1qQpUhNZMM70VQzoHo962kp+2EsPp2eNSXzZXtNPPBEm1e9XNcY/y5NegfLrz
 CWI2mYMovOFjs8kQDNTPgnAIqGCaGGFFDzqV8iy91w3Ui9teerpGppP/yqWPnxyTRjQBOWH6L
 45AysPhOzUk7InKyBge7z5I/d5yypT3RCBvXXGZnGjgfagUM0xNQxWSEmWJqnQqxZ+CLLIrJr
 f0p3OgrWsRXQyhiEmuoJTFVWQUS9uA7HkfCcx45NXLWcndvwQZcO79PHGoo1wrk5gG7ge7M25
 OCeZIf1GgzcL3UZhwws0HFTM6srX9uXuxPK7WJlG7jNGMH/oVVVAvKve0zmM3LRQMAH6lJV4h
 aBoZu2Y+A636ZSzl0n1J091W0P/FREjNql+1kjwig3KgZBOPNr3hLvta21QN9+GlRPdI+aDdQ
 TsQaX3Psx+UVFcTrONRVkSKgRHuyZexh5AwEXly1TpEJ3vEqdzOmgcehbkEFrKYXj3WlCDb/u
 ShOAJSjrCMHB1W7dF0kdCSNM1eu2ooKRcN7crlyHoRHgBdIqvACfe7N48+PdGnPPkO77euXsw
 zi3+IGgracYnsWv+zhFBaz5fjnoUIppkn6ZGBwc3MMAUWJK4bjyP/8X2ZhNWccmkALd/wBV9Z
 MvnOa9Egr0zEaqYLZk3UltdsE5pgb1ty46H0fwMbLHWJq7BW6kTT+o8DS/bQjh7+ULoskgELh
 kJBl4ZtsC54Tdvc2ciQ4oBGOWOy7Kb4OSpNrQH8cfTcmwj53Gi8iY3qq6+aJDKaZJoeXN+Yw3
 TShJYdX1jqJYChgY3LD53r1k//3Poeqml8viGZ+RSZKfpltE51xIeWWkXhL+kfM2/V0UNwdMM
 ONfUPHFjyuNQfLrvHUERPloN9e9FF+6SpiSdt+n2qTxuXIIcoT2rcF8CxupbNfgU+ca5+6a5Y
 1P83AmeMNB1rZEWlhRjO/3UAJLq//B7+YCyYaIA2cmhdKkkJ1xkIt3l2PJyMGljnB2KKooaoF
 Lt36tL/cEinDZ1qoEgFd7h58Jj8nKK7zwr6RW4nTAZyot4pbJ8rtyNvrh1gOzZG4h4YPj/cyQ
 egVv9EvMvqHwoEFSdvld/1U2N4U2x+6z8k90cB2IKMDewfDvm5sregVRxZOVkMfkwcWKTLhwL
 RbRogghbWvWW0dT5PQTKwf4AdVGD9ong6kLTPj7ZhnbCvdJCtR+HP6auSm6L5JZugYEWJ8EdA
 bfIUici+D4r5hIBu+WdhnBO3UsWRpRh6ERfpFH7RB9mhPydpoq8ig/IOI51Q+hZhiRPwReY8o
 fB
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--Sig_/UK=lmMuo3WwjUGui3sIhh7x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Mar 2026 23:12:25 +0530
Arun Menon <armenon@redhat.com> wrote:

> Hi Lukas,
>=20
> On Tue, Mar 10, 2026 at 04:29:54PM +0100, Lukas Straub wrote:
> > On Tue, 10 Mar 2026 20:17:57 +0530
> > Arun Menon <armenon@redhat.com> wrote:
> >  =20
> > > Hi Lukas,
> > >=20
> > > On Mon, Mar 02, 2026 at 12:45:28PM +0100, Lukas Straub wrote: =20
> > > > Add a COLO migration test for COLO migration and failover.
> > > >=20
> > > > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > > > Tested-by: Fabiano Rosas <farosas@suse.de>
> > > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > > [...]
> > > >   =20
> > >=20
> > > I was running the qtests locally, and I encountered a timeout error.
> > >=20
> > > Command run: mkdir -p build ; cd build ; make check-qtest-x86_64;
> > >=20
> > > Following is the output:
> > > =3D=3D=3D=3D=3D=3D
> > > [...]
> > >=20
> > > Summary of Failures:
> > > 67/67 qtest+qtest-x86_64 - qemu:qtest-x86_64/migration-test         T=
IMEOUT        480.05s   killed by signal 15 SIGTERM
> > > Ok:                64
> > > Fail:              0
> > > Skipped:           2
> > > Timeout:           1
> > > =3D=3D=3D=3D=3D=3D
> > >=20
> > > It seems that the test runner is stuck waiting for some input.
> > > Following is the stack trace
> > > [...]
> > > =3D=3D=3D=3D=3D=3D
> > > gstack 128276
> > > Thread 2 (Thread 0x7fdd090716c0 (LWP 128279) "call_rcu"):
> > > #0  0x00007fdd0921434d in syscall () from /lib64/libc.so.6
> > > #1  0x0000557fd604563a in qemu_futex_wait (f=3D0x557fd60a0190 <rcu_ca=
ll_ready_event>, val=3D4294967295) at /home/arun/workdir/new/devel/upstream=
/qemu-priv/include/qemu/futex.h:47
> > > #2  0x0000557fd604584e in qemu_event_wait (ev=3D0x557fd60a0190 <rcu_c=
all_ready_event>) at ../util/event.c:162
> > > #3  0x0000557fd6045fde in call_rcu_thread (opaque=3D0x0) at ../util/r=
cu.c:304
> > > #4  0x0000557fd600e8fb in qemu_thread_start (args=3D0x557fd6beec70) a=
t ../util/qemu-thread-posix.c:414
> > > #5  0x00007fdd09193464 in start_thread () from /lib64/libc.so.6
> > > #6  0x00007fdd092165ac in __clone3 () from /lib64/libc.so.6
> > >=20
> > > Thread 1 (Thread 0x7fdd09073240 (LWP 128276) "migration-test"):
> > > #0  0x00007fdd0919b982 in __syscall_cancel_arch () from /lib64/libc.s=
o.6
> > > #1  0x00007fdd0918fc3c in __internal_syscall_cancel () from /lib64/li=
bc.so.6
> > > #2  0x00007fdd091dfb62 in clock_nanosleep@GLIBC_2.2.5 () from /lib64/=
libc.so.6
> > > #3  0x00007fdd091ebb37 in nanosleep () from /lib64/libc.so.6
> > > #4  0x00007fdd0921613a in usleep () from /lib64/libc.so.6
> > > #5  0x0000557fd5fd99cd in wait_for_serial (side=3D0x557fd6065f08 "des=
t_serial") at ../tests/qtest/migration/framework.c:82
> > > #6  0x0000557fd5fe5865 in test_colo_common (args=3D0x557fd6bfdf50, fa=
ilover_during_checkpoint=3Dfalse, primary_failover=3Dtrue) at ../tests/qtes=
t/migration/colo-tests.c:66 =20
> >=20
> > 60    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
> > 61
> > 62    wait_for_migration_status(from, "colo", NULL);
> > 63    wait_for_resume(to, get_dst());
> > 64
> > 65    wait_for_serial("src_serial");
> > 66    wait_for_serial("dest_serial");
> >=20
> > Interesting, so the secondary guest is stuck/crahsed after entering
> > colo state despite having resumed.
> >=20
> > It works fine here on master. And before the merge I have looped the
> > colo tests for a whole day on my machine without any failures.
> >=20
> > How often does this happen? What is the commit you are on, host, ASAN,
> > MSAN, UBSAN, configure options? With kvm or without? =20
>=20
> I have started the run on a fedora-43 VM. I am on commit:
> de61484ec39f418e5c0d4603017695f9ffb8fe24 master branch.

Okay, so the problem is that nested virtualization slows down kvm page
faults (e.g. dirtying the dirty bitmap) so much that it takes longer
for the guest to dirty the memory than the interval between two colo
checkpoints at which point the dirty bitmap is cleared again. And to
make matters worse the secondary qemu process is starved by the primary
qemu for some reason.

So the following happens:
1. After a checkpoint primary dirties all it's memory pretty quickly
and afterwards the dirty mem + serial out loops quickly. So it is very
likely the guest is in the middle of dirtying the memory at any given
time.
2. The colo checkpointing is actually working flawlessly it only seems
stuck because the migraion-test is stuck and not echoing the qmp events.
The secondary receives the primary checkpoint (whose guest is in the
middle of dirtying memory) and both sides resume. The secondary is
starved and spends a lot of time in the dirty mem phase.
3. Another checkpoint happens, before the secondary guest is finished
dirtying memory and has a chance sending the serial out signal. Goto 1.

Can you try increasing the checkpoint interval the following and see
what works for you:
migrate_set_parameter_int(from, "x-checkpoint-delay", 300);

In my tests, raising it to 1000 worked fine. Though for a doubly nested VM
I had to raise it to 5000. E.g. It takes up to 5 seconds to dirty 100Mb
memory in a doubly nested VM.

Regards,
Lukas Straub

>=20
> The configuration command I used was:
> ../configure --target-list=3Dx86_64-softmmu --enable-debug --enable-trace=
-backends=3Dlog --enable-slirp
>=20
> Targets and accelerators
>   KVM support                     : YES
>=20
> >=20
> > Can you try the following and show me the log:
> > (cd build && QTEST_QEMU_IMG=3D./qemu-img QTEST_QEMU_BINARY=3D./qemu-sys=
tem-x86_64 QTEST_LOG=3D- tests/qtest/migration-test --full -p /x86_64/migra=
tion/colo/plain)
> >  =20
>=20
> I have attached the log file : qemu.log to this email. It is stuck at
> the last line :=20
> {"timestamp": {"seconds": 1773164370, "microseconds": 609791}, "event": "=
RESUME"}
>=20
> It should be some configuration miss from my end.
> Thank you for looking into it.
>=20
> [...]
> > >=20
> > >=20
> > > Is there something that I am missing? Can you please look into this?=
=20
> > >=20
> > >=20
> > > Regards,
> > > Arun Menon
> > >  =20
> >  =20
>=20
> Regards,
> Arun Menon
>=20


--Sig_/UK=lmMuo3WwjUGui3sIhh7x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmm8e18ACgkQNasLKJxd
slh3fBAArbuk03t+D+3bQ2jaPvJX/znIT5sO4hr2gsgqXJA0uLTla6r/2fIDLbZy
ObJyRVrww19k7hwDtXduVuYQc7v9nDr4l5Gu9/fQwehlbOUaEJsQOTkpIsWiaGeF
bI1dFBDRxZVQWZFPXnahy7njmUOOPaj4YGXDuMFwUwpJEWHX3/BNk4qpfMnz2P9q
0VbotMiIgaRJWcC7+ZHj3WkHIvEBVACEfNPZx4TGhIizfs9Ypw0RJJOBG7ujHp6E
EcQGwWqRQMzG/ag+PYhQbn+EJE2WvxwBLpZzh67QjVJR+PlKMd7GpX0jgpb0Gntm
x0jfxErrCvLRDRF/hv3xCqSceAkqgQEnIYPF5vVilW1KvWNUAQhVYRaAGFItIGii
3AWVSdIp19OCFNuHPNunwoQBBRafGVYJaTsoqsIjCIdFzKRdQnwVHTeN2F74T54N
LbgXLRg8EFr9Y0oU1avck5wrewsJnXPIeH3eOYjlEsTJdxrlDVDvQV8jsJ+pbDyU
rEP6lTerC3cI2fT/QIHSsyaEU5PRSy+JgPGA4qfSWZT2MPdi4ogutq+/m3oByCXl
1W2y5UUqh/Yamy48xdhjeekjjlxEmhmNe4yLIyNoMAvU3q995hbJXXVSWOpQj8nj
ZiZ+ZS+HU+4M5Kr2MGVID1/EUYFuXKOWvjAkFSXnln1rz5hlVhQ=
=Nctq
-----END PGP SIGNATURE-----

--Sig_/UK=lmMuo3WwjUGui3sIhh7x--

