Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834E7C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 07:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfbJP-0000T3-4F; Thu, 29 Feb 2024 02:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rfbJN-0000R0-9E; Thu, 29 Feb 2024 02:58:37 -0500
Received: from mail-sgaapc01on2070f.outbound.protection.outlook.com
 ([2a01:111:f400:feab::70f]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rfbJL-0001hS-Iq; Thu, 29 Feb 2024 02:58:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuEbl9TOdJwoMPVLdVtNSx8R3517jjL4+pQGQ6VlW0jmHFIqrMclXmykFkccKPnGxaqS1Vzzv9UWUoB7tZ3MOJnwTsdX+IiIG87EnDclrmAxufibzj5iOcS8B1kqXcBYhVC/MRWwPDI8QCTj2l7ilZDE1M/i/MIlkYBKfqEImhWEVJnAC6v+B2ln8EYb2MxtUr+W9jvTHTUtWQIghDjwcwzhnOuMAdzGRo2T3gEtci8MBlPx/ImW2ytgpYYDmORVwP60enLMJPhCtOQKIzS2nAhizfVbY3bMxCGnnSuLRYQ3Sh3bZJh2Jy6sG2hRZTHz5sL7FZubblLRtUK9+59EGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0qrz1M2ZYhcvCg5GbOmWrXhXLmjfng/fQawhWYXa1M=;
 b=A/tCoW+edcoONZvkgQffdN3qX8mvBxPtIXG0eaZOxv/TSvuLfr76vlwVealFPcSbtp7i0dgvnnBVphU6xedbJtiUnZwGYUA73o8oAWlzJYW20BwIUptYD5GbR9CCb+eH3agtin8DqQYkX1Gf7czzNsWfU7D5qXmk4d72w7R7TTC8YgssjwvqveVU5M9blc9ScwM2IktrvLp1oLgzEFwzLJeePhWgDk0QwvbFgoTlJ7WaIiozC8kGhBsJiQ7FXg3X4UzRfhCVxqDd8J1860NwwsSly3pEYpvH7uT4zW7ZlNv6NzddAVag6MAOEvSDTqmAs/CvRGm+tUjmJ8Q0sQGSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0qrz1M2ZYhcvCg5GbOmWrXhXLmjfng/fQawhWYXa1M=;
 b=Z8HZ+u8PpcLTReXM3Fsteiq+E5Z3ITlSwrdxIk4qIxJvOJjK4rOGniHK36FHhDC7ULnWRyjv19ZpztDxVYK8K5l8+FJfmb6RrboOfuYklHz5Utx4XN+myiuDNTLNE2HFSK9uCfRnwsilcrXwO+O/vKTzF62VfPk5L9ynZz3vngriXrI2hjE4vfhKqz0eBXEz0DLqbTCiJQyLOPa8vwqU3j7XxB5Zwlltbj6flqb9ooi8ftPTes+LpyFK2a8gB5NxMUYtc/uj5xgJcYcbbrgU1mYEk0cMKFfY8Ue3N6hsn4tRwPiH1U6RQdyMIHWLaKheP1baXX6t8RuS2lWDQH2zmw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SI2PR06MB5195.apcprd06.prod.outlook.com (2603:1096:4:1bf::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.39; Thu, 29 Feb 2024 07:58:28 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 07:58:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 8/8] aspeed: Add an AST2700 eval board
Thread-Topic: [PATCH v1 8/8] aspeed: Add an AST2700 eval board
Thread-Index: AQHaauLiedApTYd2DEatyfju4PLRdbEg8W0ggAAC0BA=
Date: Thu, 29 Feb 2024 07:58:28 +0000
Message-ID: <SI2PR06MB50416760BC100CC2FB33CDDEFC5F2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240229074234.976164-1-jamin_lin@aspeedtech.com>
 <20240229074234.976164-9-jamin_lin@aspeedtech.com>
 <SI2PR06MB5041B1EA856220BB77B8809DFC5F2@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB5041B1EA856220BB77B8809DFC5F2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SI2PR06MB5195:EE_
x-ms-office365-filtering-correlation-id: 99267715-8988-49c0-665f-08dc38fc36ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T+Ta92ERDWDnJLv/0aXOZFNMKqBXaiiZNF11hGaBgGtiFVGGMo5fBwG22+0y9kw57Ups2P4d0QMSBuAGO9wKdoBvmZHo+7/UsUI1y+iDCeEg9TdyFTP6Mr8AO91W0Dz5R4fCghaLC5Ws1YGGS/fenkTGMopa5UEMezyz7FkGNgV/CvenHoVJHQQWH4UzW+sfGx9VTsG5Z/pRJXP0mt7BXJRb1m9yR1NhEeJQQzGntGxIhx/joNRudHGAyQp3Ni1S1FQm1uU8nlKlnyGNKIHw3V8k3jYiRaOu7QEr6jRkteuVCzlMlt10AxHsq1AeQZWe/TpQkyWeZqsfc8pypOhpq5DHmUbPCJTs42OxLkdAre2KuZnJdBJy3bClLjF/JW6jnpEhg9Y1cCWU+OgPB3gZjyqYbGazelA0+Gg2VIvcRWZZu+N8mthHtUJQOV9xHhSBjRRO4qDv/vhvvYO9wl1Z2Vm7xzExtdwy7qMtSbg2cRznC0l43tIxX9Jowd9LHIzDHbC1ohNw4tjjGNyx2DUqoF8pAG/cUxYHeH+pv3PJz40+f9TlmQi2amD9bx8hQLaMckxH5H8K1DdI1rqrk/KHmCD64xoDX4XYvmLsmncmIbLz1rA18qqWBmNa8MBCfr/KR4IcYEnawQfCahL4KxgggvwSw8TYJNKJP+1Xk1IpyDk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dQ9yXTYmLZilW+75hRFMDrxUH/6AeMngxxfea9z+dzfO1g/tCkhCSfNVAmUB?=
 =?us-ascii?Q?dHH61NPsMwRuaouRWIG3eB/yOx4gfaUAcoHSxVbPF5s9pE186nJOdRnTcDHd?=
 =?us-ascii?Q?oIXK+x+aOn5+3+dvxQSnYTt+zCMbRdoMBbwOh7EO6m5K8ViKFa4s3FbV9i0N?=
 =?us-ascii?Q?bgndvY+jIpCHIccDedz+deSFfyJ5tcZ4mIaENwW4eRUI8Gk1H1+E0myQ/kZI?=
 =?us-ascii?Q?RWjCjbZBbsO8Z7VYbKyJPLdVInmdRFZJbYSu8MQsbMEz27cx7c+aovb92+CR?=
 =?us-ascii?Q?YVYRs+HofoXNFg9ZxJ8sUv84q5mCg6WL9IHOu6m0Z33FmEat+DEIKauOCljC?=
 =?us-ascii?Q?i4jjeYAylUJS1uzV0vz3v2GlzW8NHNFMl0n5ZdNfdOuV1w95SICqebU/F8Te?=
 =?us-ascii?Q?Hv9I/jEzyXLkRm5954csT6TSXmMuRPHfK6auATuRg04k1mOkxZ+B5w4ojcLA?=
 =?us-ascii?Q?bgay58nUvLZ9IB/vIto+AbiqAIlnsevij/C9vbisx6IgUIWm1OCjGn8HPu1k?=
 =?us-ascii?Q?N6dbCC01hKWB15JsCQxPnRr1yQaFdb6poFyD5ndtJYCvTP2uXlIiI3sez0Zg?=
 =?us-ascii?Q?SlTzvVpbv8dgDrR0NZ5LcrJiZPlChpRLSj5a5LG169Yw8USKmbe+2Y7fMYYP?=
 =?us-ascii?Q?RxJfh6Rnhe4s1JEkE6zkSWefCEBQIia6BZWWkWedYn8DXYW3gS2v+Wbtrlup?=
 =?us-ascii?Q?R7HPJhnKZN6L/wu0osUERbap0tEXXUHq4fZuXr+bS17ZatEEh3w6RpOR51Ny?=
 =?us-ascii?Q?EgkGN5WulUkNtFt5p05ZTIb5oRYJ/WF509Wo2bPgbRN9pYuab4VChGZGLaE6?=
 =?us-ascii?Q?racOYMkwkLfsaXtymuNv0gLe2VN1nCaaIGneigHQiS3O2aAR6Yrcp5YlYSXb?=
 =?us-ascii?Q?oG/kpWgyLcAa5TGnE2h5lQkqUqFHKIvFPODKHDuAEAUDasmlijmK/poc0t1Y?=
 =?us-ascii?Q?wT7B+rYYW/XHmVAn2JKy2YvkPc9hQViWcdsK2fVuTsgoZQc+GoNaic5yd7D7?=
 =?us-ascii?Q?He/cm/mPYDvX1fjQrgcGg1rShxPZrF+mxFZQCPD3L9Okiew5TeQNh6CbVQ6u?=
 =?us-ascii?Q?SNQBIJc4JhP8MQl9VWw47cDz6Ti+Su919b0JNf5WMZ4VhgN7vFQ/sqEg1bvs?=
 =?us-ascii?Q?rFb3XK9pKm3P+CLX/cWoN/yxnsnMIFS43i/4RMTlNvrR1OWS9UKaL8/4sfy3?=
 =?us-ascii?Q?SYcaxtjlZVb0FSujeEMUcaGsXYl0AeaSblEZBWDWnfgXvugALxPar2ZDB07D?=
 =?us-ascii?Q?/d4HP726w6+O9QvjaXUmnIs2qQ2+O0vKBfGB3FpyHaRoU6/o3Ol6gqURGk3M?=
 =?us-ascii?Q?KCao+nrukYSDqdw1cJXVEf62YSUhWPXkYumc9gqSytRDz80kd4aPkG/swY7f?=
 =?us-ascii?Q?ROLiFNwODQlpj8wQEjnzp8AXeQnuyomSMPs4A7N16zZ9eFk9epgq5SxwsoYu?=
 =?us-ascii?Q?a0UHhy3ceC4xo4BJ2qKAOFWEm0mnG6fNiWAswASJn4Z0RTYjMsM5LNlFjNiz?=
 =?us-ascii?Q?qegkb7fqv6kLdMaaCGaXm38l12UCv8JF1CeC3QtCOJn55pJeV14kxCbrXFq9?=
 =?us-ascii?Q?GR8zRgGlThcOP24fp+9Igch0TeAh5nhySNRTOFsy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99267715-8988-49c0-665f-08dc38fc36ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 07:58:28.3915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYcQ+UrQuhxhmxTuMk4R8FzGWMy78GuhMX3Ji400I7ZiF4bJB9Cu7aRQiNn0Ex2aCjjzQN+rMOrWWcOTNa1tXPBkTNEptokBUn+Mi/78lns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5195
Received-SPF: pass client-ip=2a01:111:f400:feab::70f;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> -----Original Message-----
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> Sent: Thursday, February 29, 2024 3:53 PM
> To: Jamin Lin <jamin_lin@aspeedtech.com>; clg@kaod.org;
> peter.maydell@linaro.org; andrew@codeconstruct.com.au; joel@jms.id.au;
> qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: Troy Lee <troy_lee@aspeedtech.com>; Yunlin Tang
> <yunlin.tang@aspeedtech.com>
> Subject: RE: [PATCH v1 8/8] aspeed: Add an AST2700 eval board
>=20
> > -----Original Message-----
> > From: Jamin Lin <jamin_lin@aspeedtech.com>
> > Sent: Thursday, February 29, 2024 3:43 PM
> > To: clg@kaod.org; peter.maydell@linaro.org;
> > andrew@codeconstruct.com.au; joel@jms.id.au; qemu-arm@nongnu.org;
> > qemu-devel@nongnu.org
> > Cc: Troy Lee <troy_lee@aspeedtech.com>; Jamin Lin
> > <jamin_lin@aspeedtech.com>; Yunlin Tang <yunlin.tang@aspeedtech.com>
> > Subject: [PATCH v1 8/8] aspeed: Add an AST2700 eval board
> >
> Hi all,
>=20
> I tried to send the patch series to support AST2700 but I encountered som=
e
> patches were rejected by server IP 211.20.114.70.
>=20
> Error Log:
> qemu-devel@nongnu.org
> eggs.gnu.org
> Remote Server returned '550-[SPF] 211.20.114.70 is not allowed to send ma=
il
> from aspeedtech.com. 550 Please see
> http://www.openspf.org/Why?scope=3Dmfrom;identity=3Djamin_lin@aspeedtech.=
c
> om;ip=3D211.20.114.70'
> qemu-arm@nongnu.org
> eggs.gnu.org
> Remote Server returned '550-[SPF] 211.20.114.70 is not allowed to send ma=
il
> from aspeedtech.com. 550 Please see
> http://www.openspf.org/Why?scope=3Dmfrom;identity=3Djamin_lin@aspeedtech.=
c
> om;ip=3D211.20.114.70
>=20
> Did you encounter the same errors before?
> My send email command as following.
> git send-email
> --cc troy_lee@aspeedtech.com
> --cc jamin_lin@aspeedtech.com
> --cc yunlin.tang@aspeedtech.com
> --to-cmd "./scripts/get_maintainer.pl ../v1-patch/*.patch" ../v1-patch/*.=
patch
>=20
> Thanks-Jamin
>=20
It seems our mail server issue. We are checking this issue.
Thanks

> > AST2700 CPU is ARM Cortex-A35 which is 64 bits.
> > Add TARGET_AARCH64 to build this machine.
> >
> > According to the design of ast2700, it has a bootmcu(riscv-32) which
> > is used for executing SPL.
> > Then, CPUs(cortex-a35) execute u-boot, kernel and rofs.
> >
> > Currently, qemu not support emulate two CPU architectures at the same
> > machine. Therefore, qemu will only support to emulate CPU(cortex-a35)
> > side for ast2700
> >
> > Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > ---
> >  hw/arm/aspeed.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c index
> > 8854581ca8..4544026d14 100644
> > --- a/hw/arm/aspeed.c
> > +++ b/hw/arm/aspeed.c
> > @@ -178,6 +178,12 @@ struct AspeedMachineState {  #define
> > AST2600_EVB_HW_STRAP1 0x000000C0  #define
> AST2600_EVB_HW_STRAP2
> > 0x00000003
> >
> > +#ifdef TARGET_AARCH64
> > +/* AST2700 evb hardware value */
> > +#define AST2700_EVB_HW_STRAP1 0x000000C0 #define
> > AST2700_EVB_HW_STRAP2
> > +0x00000003 #endif
> > +
> >  /* Tacoma hardware value */
> >  #define TACOMA_BMC_HW_STRAP1  0x00000000  #define
> > TACOMA_BMC_HW_STRAP2  0x00000040 @@ -1588,6 +1594,26 @@
> static void
> > aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
> >      aspeed_machine_class_init_cpus_defaults(mc);
> >  }
> >
> > +#ifdef TARGET_AARCH64
> > +static void aspeed_machine_ast2700_evb_class_init(ObjectClass *oc,
> > +void
> > +*data) {
> > +    MachineClass *mc =3D MACHINE_CLASS(oc);
> > +    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);
> > +
> > +    mc->desc =3D "Aspeed AST2700 EVB (Cortex-A35)";
> > +    amc->soc_name  =3D "ast2700-a0";
> > +    amc->hw_strap1 =3D AST2700_EVB_HW_STRAP1;
> > +    amc->hw_strap2 =3D AST2700_EVB_HW_STRAP2;
> > +    amc->fmc_model =3D "w25q01jvq";
> > +    amc->spi_model =3D "w25q512jv";
> > +    amc->num_cs    =3D 2;
> > +    amc->macs_mask =3D ASPEED_MAC0_ON | ASPEED_MAC1_ON |
> > ASPEED_MAC2_ON;
> > +    amc->uart_default =3D ASPEED_DEV_UART12;
> > +    mc->default_ram_size =3D 1 * GiB;
> > +    aspeed_machine_class_init_cpus_defaults(mc);
> > +}
> > +#endif
> > +
> >  static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
> >                                                       void
> *data) { @@
> > -1711,6 +1737,12 @@ static const TypeInfo aspeed_machine_types[] =3D {
> >          .name           =3D MACHINE_TYPE_NAME("ast1030-evb"),
> >          .parent         =3D TYPE_ASPEED_MACHINE,
> >          .class_init     =3D
> > aspeed_minibmc_machine_ast1030_evb_class_init,
> > +#ifdef TARGET_AARCH64
> > +    }, {
> > +        .name          =3D MACHINE_TYPE_NAME("ast2700-evb"),
> > +        .parent        =3D TYPE_ASPEED_MACHINE,
> > +        .class_init    =3D aspeed_machine_ast2700_evb_class_init,
> > +#endif
> >      }, {
> >          .name          =3D TYPE_ASPEED_MACHINE,
> >          .parent        =3D TYPE_MACHINE,
> > --
> > 2.25.1


