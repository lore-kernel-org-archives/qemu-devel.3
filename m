Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B76C79F87
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 12:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck12-00014Z-Ny; Mon, 05 Jan 2026 07:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vck0w-00013v-6Q
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:48:51 -0500
Received: from mail-westeuropeazon11013036.outbound.protection.outlook.com
 ([52.101.72.36] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vck0r-0005jG-98
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:48:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJlsnqKplSD42/oglwcCjVdPVcjHs+b73JL5W7Wc6FxoDQVYfP3pjWxOPbZTJbUivQgGAee2x0q6xzTh5A84T9Oinla/2pQKByDLR45AZ9aZmSpQLxzz88U003BaYlJfK2pT+zL7+O0MMW/YXb7p/pqB8wiTk41zc0oocWLULymnzu+0uxkGxA1XLvZp43u9kWuviIggie7cPtkjFlD22Jt6U+BfuzOfBSskYjYE/oUu05KJlqrFxxQwhORLp2tn+gKBum8Fh98GLE7pdUnDojJwcgHYFxU9eLS0gqFT/ci9w6ywe7bHy3J7dG+4VO7LVbiWEJO4j7o6wKurSfeZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z17E1kPIJGCX/juTqQvz7kk9SyKJaBzZ90Nj/sjHLbI=;
 b=PlH+fZRMobQR9SFeM6BNret4R0txTwtYFQvTcUyw17hQ787IQdAeHhrfHVsf+bqJnv+a6lnrHx5vFG3J+r86KuJPJfBaeZ5uo18VPWM/5r06n0zmsymoasc1UscCdb4L8xiO71LQr3hsXRHxAY9xY6ZdnqtZdn/H/OmhvEqLUWj3n6t+yJ1+H6kGoDLB+T0cLz6kDsbGh3GJBfgQ/woOFpEnFU6bxhB5IDoZ1czLbRTJFYMR0/Jhh/V+LviRoW2x82BElz0NHhVR2JvQEGTkiJbxg8czxQHWogzzv/7t4+HYoz0v6DqYLAIebroVtna7Ny6H/IDqU+TdN4LJKYT+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z17E1kPIJGCX/juTqQvz7kk9SyKJaBzZ90Nj/sjHLbI=;
 b=QEVFQ1ikxs6AeRRT5ji8hT0WpkxDiDB6QB7DL+Ch8l+ifLjNZ4oQfI2+p38lGnnMNt1ULqvzEFDzLDySSd7Yo8e0vG+nDSt85mf8mz6dEUjeZGEiRyFkzwpMf1PFSX6Ag7CQBXeg9zbYVRu/iPLjrvBN9XBTmg6H+gQg6vlYOusUR1G7bobG8QvJtaRzLCt87DfI77leg1plSav2uQDTa5c0ircwgfqCUzGXsDsZIuIfHZYhPQlj6OBcGGvjuQ7TMUTIdapNYmy/SlVObkyhQNj0ljw8FWTIY7I09xDw/VfALzz+4qgQsHQJSHVlkDp5gmkuDYxpwNmim4LyRZEKlA==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by AS5PR04MB9894.eurprd04.prod.outlook.com (2603:10a6:20b:655::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 12:43:38 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 12:43:38 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [PATCHv4 00/15] Adding comprehensive support for i.MX8MM EVK board
Thread-Topic: [PATCHv4 00/15] Adding comprehensive support for i.MX8MM EVK
 board
Thread-Index: AQHcZaleedsdKqUPWUq5Ui2k470lsbUof1fAgBs3ICA=
Date: Mon, 5 Jan 2026 12:43:38 +0000
Message-ID: <AM9PR04MB84870CEFAFB934E3458CD0768786A@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
 <AM9PR04MB8487B6CDD04406F5EF2F8F1687A9A@AM9PR04MB8487.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB8487B6CDD04406F5EF2F8F1687A9A@AM9PR04MB8487.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|AS5PR04MB9894:EE_
x-ms-office365-filtering-correlation-id: 3361afa3-6843-417a-25c6-08de4c580c8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|19092799006|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?oDVITGzpFB2DJlWNfIPrgQCAkjJt7mwmwN0fBcVzWDnD7vW6qTVVuQSsL1FP?=
 =?us-ascii?Q?6GEx0xuUhZVRL3yFZjOcQ+Gd9bkpRGPavvFjjzafX4gpS0EnitW92ti92sX3?=
 =?us-ascii?Q?qjdZ2+A/d9ELfoNF+XSJsQuD0Q7k4w6y/26DaeSQUQnCNzzGY0d/gI2kiqGF?=
 =?us-ascii?Q?7HEmqN0t9DfVD3MVsY90/BEFtah6fJ6laxLbrO6dudJ8Xg2J2WLsjE8lqDl2?=
 =?us-ascii?Q?RAqUlH/lRSa/U3APPVssDuiTfH7pKQu0ZnXXCECtqvf31uxAnoNul2p6WosM?=
 =?us-ascii?Q?s8ZY2Om1R+bylbQaVV+FN1390aGbS30aQoguZqHIhSs80QGDKg89zVB39idu?=
 =?us-ascii?Q?KzrPed2JivMUGfxqntsVnlyy96i9r1JkxFgvWw9XYttB7/zyO1nv3RIRO0Zs?=
 =?us-ascii?Q?JTVSSRrmVs+lnKu/LpzC8YJlB7+1NePIqpXQJjRLhrCn3LIzG2PzYSpXVZeA?=
 =?us-ascii?Q?YlB36bUwNLmYac2I2YNi4egWNzsTrPnnPCIznZWIOaoQRy9yDcVnvkDnwP+l?=
 =?us-ascii?Q?5XB3l7W1n+HQGAzILBJxsYMwc9qxDMe5vF9CsNaN+dNPNfWCMkmWiUMplD9o?=
 =?us-ascii?Q?OCWUxsjPlk8nIeI5u3EGN0QbzL0AF7dTYSkzY+eX/ZQQMLifhIEgwc5qR7WI?=
 =?us-ascii?Q?nBPYEssakVJnMN2EZpwrwMxGQUoGhBSCpXjx3CX3DJFtsMUEJSDnmv/iXPnm?=
 =?us-ascii?Q?UnwrWWjYASpTykKPOT3bmW+KNc/sxm8MzQBpNIONmexP0gzNZqNpMeYellzs?=
 =?us-ascii?Q?/3fRaXt1N5oEkhN33IZpGF+PTwinTr2PzZxUhxK/OW7tjcA+30zlQCYga4qt?=
 =?us-ascii?Q?E05RxsnKuqSZ3Rghl2g9ZhpoCT7C62w0dYOMR+G0fdsKgFUzERQkUJn3ujse?=
 =?us-ascii?Q?NA9TrvUPNqyIFL2QGkhgUJ1PnV9B6nhCmKw/PeOnQ8a1BR0sPIPXtkyi8z2C?=
 =?us-ascii?Q?T994vPiWk5Zcb/hFfKcQhQciX57lrQUUd/PDD07f3t85FmMoBn1o404YHR+G?=
 =?us-ascii?Q?hSN6xKicEJ9KJrlBvednPxXbrWZvQsywfmL0t/IrL10hWeAUitTDsS/ENnZH?=
 =?us-ascii?Q?Aq2X0o4AfceIHPtyuShP1K8j8Br6rxqLJH71c3V1uW3t2u2YR6525im0+qj2?=
 =?us-ascii?Q?DKM4wXJuBoFJqYahjcHdeUmcbi/O9gOALOURJvQ7eAWyYe5tCcFU0wp7tOjw?=
 =?us-ascii?Q?KXTmd42FV+imhf5VZ4t4s8BtpENfjA4bXQzA6NbOypbn9A36jqxFtOGtVmiu?=
 =?us-ascii?Q?dpOCfxUzGPGP4UVKgZPmeFZ/JFaW1feWEwglSGuBBFGPhiSdoumkbac6/JeF?=
 =?us-ascii?Q?jXqCwBQduF2PuUxQ0kzN2FA4JORCKPVkPn9dwkzzEu3pyENaCXeH41SEcpIn?=
 =?us-ascii?Q?P6UkYq8QYaDm89ytpzGiKKI2JIK0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U7HuOZ127/1kQObjjkngr9LYIgFqkZcgubUJDs36ziOkfcPM/mLhxs8hkGwD?=
 =?us-ascii?Q?XqCxSGWyty0vegvq5MHDEO2kjPa94d1ocjwFkXOL+LkiDoYiTZESW7P0mNQS?=
 =?us-ascii?Q?ZmpLvq1qIJt90RM7x7ZefFfD7jVlHvlucNggvay0q8RJIVFTup+3H7fWzs2d?=
 =?us-ascii?Q?ubFAHlZlg6Bld3oz6P03pLboaJHAKhPU3gS0EXjIn0sPMdGpwZFOlZMJB71f?=
 =?us-ascii?Q?GJV1Hk3qVTVL/l1h9KUS7oFV07wcbfDVsNl5HYRRt6YYme00LRbPOSWbGZo8?=
 =?us-ascii?Q?Xlrw3WVwSYmuipv2yko0wQ2itQAOnDhunScQZOOWpwxwJNhyLEHbZzfiGyAe?=
 =?us-ascii?Q?UmuJV1PxDV5lxR6r5xX5OO2PPYQTQ8Zt5BMX7+XKtqJX4VT1R/IMqX59DVii?=
 =?us-ascii?Q?NIacal6K3eP3BE+y71RhJ3fKgGnfl4Q7bAbn1NHTV13H2l0X50Og/Jv7a3c/?=
 =?us-ascii?Q?QK5gDQu9cJIf15amtHFUkQgV1h9ikHkR5cXKTTVPpg6qAdguJfmM0BhvLWI1?=
 =?us-ascii?Q?jgC/H57w2o33lkblj7iQgK/I9Xi/O21Q5fkAXpeaGwEvrOh6xlJ0SaUeMiMw?=
 =?us-ascii?Q?4dn0YC4hfJoVEWQrDQWfxKDkqB5l+b8GwJK2dFVfzuNROL7LYw7ogtI00BjO?=
 =?us-ascii?Q?VH/YB1gqcF3sZNkeKo+41InmknTB30c6oza3pIk6Se31BbqXgB2l+PwOcgmL?=
 =?us-ascii?Q?BmjYD+/54QboF7A/W5yOCbrKlo5nE/TLpC4VT5cbWCjABbC+KY62d02I2Ck7?=
 =?us-ascii?Q?D/YV+OkX3JuUwiEY7mYzgR1NzUmWahtJJK2GIKSaT+1GLIHgG8QDv845e/mu?=
 =?us-ascii?Q?9pFX6n6xdvlXAUmsOhBw+2Xcor44VxfAbTU9PHjkw2lUTs1R7cmPmG66b28m?=
 =?us-ascii?Q?Ui8MZ3cYTkFcSbMTfaYpGBsy7Y6uqk+efF0+BKEXJe86sCq2SWf2JbD8UveC?=
 =?us-ascii?Q?Y1V9KhyWMHbUg2BCfDKJGE4qPV54F24BZoI+BMthzW8EkS1zcjGVRhLLoWp2?=
 =?us-ascii?Q?XQqqZGCuqyAe384I4YrokEPF4RRz+w38UPF+5BIcy3WmO/SDhiKNsDxoG3UE?=
 =?us-ascii?Q?LxI59er+JjbzqEvCDPtDFcJw0pBvCJCheV73AUvf1O0qpztoWuW7+ckT5gqE?=
 =?us-ascii?Q?1ObTzB5yrhI26QLqTgYBSa41Ubf3w6WyKt2W46lBFuFBVdmWc8sdQCaHMOEv?=
 =?us-ascii?Q?YYP+fqCn6shRSsU1Dz2i6YQ19E4Zh56csNcxtD+gx5cf/ZbTk1QbB65RmCqh?=
 =?us-ascii?Q?vZ+9YtiCTBacnCDBHGEaU+ZLAK1zQTwaEwclsbUrIM737dlpE0kHlfT6XDVI?=
 =?us-ascii?Q?mYC100uzsNmg2MvHd8699fBxiRzanEziy5K9nk40DPmSFU2KUY1dGwfrNdv9?=
 =?us-ascii?Q?N/jIp/zP+zE7FNFpX/2jsS3eWgjihhHm5N3G/WWuNKa8XbDY/9YsyMnm/9kM?=
 =?us-ascii?Q?LoJIUf2z+eR/pv7xey9O75pczktYHTmBF1KeP0Qd51K074MYJ5vebmFZefwS?=
 =?us-ascii?Q?OK9s+hTeOmnfHBwyLcVQS8bnqUh2vdJj/NgEvqIyBXa6hSfaErN46jkwreB2?=
 =?us-ascii?Q?Hyhc8I1G9X/OCku345MGQa9RleS4ygrd07wv1WUKX6dpgZE5SkLO+BlDFJ1X?=
 =?us-ascii?Q?q75MTLb6OaVNd4OcDRvrz8oFDtETBQ5v4cHMnv4eGdOUgWNfKa9tGwGAhftd?=
 =?us-ascii?Q?bVX3hvzUedWSwKi6aXIuOusiuFAWQe7KnC8bn6EHlAU7nCT9pzM9UlSrX8do?=
 =?us-ascii?Q?MOb0icCu6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3361afa3-6843-417a-25c6-08de4c580c8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 12:43:38.3727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +wBbuiBxguyI4c4S5sgmWOoIJMA/TQkKEoCZQfgnwVcAuGQPu+9MicyYB3cYdeGmxYfEXZzdrLrPDSB8PgUzdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9894
Received-SPF: pass client-ip=52.101.72.36;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ping

> -----Original Message-----
> From: Gaurav Sharma
> Sent: 19 December 2025 10:37
> To: Gaurav Sharma <gaurav.sharma_7@nxp.com>; qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> Subject: RE: [PATCHv4 00/15] Adding comprehensive support for i.MX8MM
> EVK board
>=20
> ping
>=20
> > -----Original Message-----
> > From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> > Sent: 05 December 2025 11:08
> > To: qemu-devel@nongnu.org
> > Cc: pbonzini@redhat.com; peter.maydell@linaro.org; Gaurav Sharma
> > <gaurav.sharma_7@nxp.com>
> > Subject: [PATCHv4 00/15] Adding comprehensive support for i.MX8MM EVK
> > board
> >
> > Changes in v4:
> > - Update Maintainers file
> > - Re-used iMX8MP CCM and Analog IP for iMX8MM by introducing a variant
> >   specific property
> > - Split up the patch that enabled CCM and Analog in the previous
> >   revision. Now we have 3 patches to enable CCM and Analog in iMX8MM
> > - Updated copyrights
> > - Removed '|| KVM' from hw/arm/Kconfig to prevent 'make check'
> > failures
> >
> > Changes in v3:
> > - Minor documentation change - Added KVM Acceleration section in
> > docs/system/arm/imx8mm-evk.rst
> >
> > Changes in v2:
> > - Fixed the DTB offset in functional testing script test_imx8mm_evk.py
> >   and preserved alphabetical order of machine names in
> > tests/functional/aarch64/meson.build
> > - Fixed a typo and updated the documentation
> > - Modified structures type to static const in fsl-imx8mm.c wherever
> >   applicable.
> > - Added CSI and DSI nodes to the nodes_to_remove list in imx8mm-evk.c.
> > This
> >   is needed because the default DTB in the iMX LF BSP images have CSI
> >   and DSI enabled. Developers/Hobbyists using these BSP images will
> >   observe CSI and DSI crash logs on the console since these are
> > unimplemented.
> >   With this change, both debian and iMX LF images will boot up without
> > any issues.
> >
> > Changes in v1:
> >
> > This patch series adds support for the NXP i.MX8MM EVK (Evaluation
> > Kit) board to QEMU, enabling emulation of this ARM Cortex-A53 based
> > development platform.
> >
> > The series includes:
> >
> > 1. Core peripheral support (CCM clock controller, Analog module) 2.
> > GPT(General Purpose Timer) and WDT(Watchdog Timer) Emulation support
> > 3. GPIO,I2C,SPI,USDHC and USB Emulation support 4. PCIe and ENET
> > Controller Emulation support 5. Documentation and functional test
> > included
> >
> > Key features ported:
> > - Basic boot support with Linux
> > - UART console for serial communication
> > - Interrupt handling
> > - Clock and power management infrastructure
> >
> > Testing:
> > - Linux kernel boots to console
> >
> > Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >
> > Gaurav Sharma (15):
> >   hw/arm: Add the i.MX 8MM EVK(Evaluation Kit) board
> >   hw/misc/imx8mp_analog: Add property to analog device
> >   hw/arm/fsl-imx8mm: Add Analog device IP to iMX8MM SOC
> >   hw/arm/fsl-imx8mm: Add Clock Control Module IP to iMX8MM
> >   hw/arm/fsl-imx8mm: Implemented support for SNVS
> >   hw/arm/fsl-imx8mm: Adding support for USDHC storage controllers
> >   hw/arm/fsl-imx8mm: Add PCIe support
> >   hw/arm/fsl-imx8mm: Add GPIO controllers
> >   hw/arm/fsl-imx8mm: Adding support for I2C emulation
> >   hw/arm/fsl-imx8mm: Adding support for SPI controller
> >   hw/arm/fsl-imx8mm: Adding support for Watchdog Timers
> >   hw/arm/fsl-imx8mm: Adding support for General Purpose Timers
> >   hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller
> >   hw/arm/fsl-imx8mm: Adding support for USB controller
> >   hw/arm/fsl-imx8mm: Adding functional testing of iMX8MM emulation
> >
> >  MAINTAINERS                                 |  10 +
> >  docs/system/arm/imx8mm-evk.rst              |  79 +++
> >  docs/system/target-arm.rst                  |   1 +
> >  hw/arm/Kconfig                              |  24 +
> >  hw/arm/fsl-imx8mm.c                         | 692 ++++++++++++++++++++
> >  hw/arm/imx8mm-evk.c                         | 128 ++++
> >  hw/arm/meson.build                          |   2 +
> >  hw/misc/imx8mp_analog.c                     |  12 +-
> >  hw/timer/imx_gpt.c                          |  26 +
> >  include/hw/arm/fsl-imx8mm.h                 | 241 +++++++
> >  include/hw/misc/imx8mp_analog.h             |   3 +
> >  include/hw/timer/imx_gpt.h                  |   2 +
> >  tests/functional/aarch64/meson.build        |   2 +
> >  tests/functional/aarch64/test_imx8mm_evk.py |  67 ++
> >  14 files changed, 1288 insertions(+), 1 deletion(-)  create mode
> > 100644 docs/system/arm/imx8mm-evk.rst  create mode 100644 hw/arm/fsl-
> > imx8mm.c  create mode 100644 hw/arm/imx8mm-evk.c  create mode
> 100644
> > include/hw/arm/fsl-imx8mm.h  create mode 100755
> > tests/functional/aarch64/test_imx8mm_evk.py
> >
> > --
> > 2.34.1


