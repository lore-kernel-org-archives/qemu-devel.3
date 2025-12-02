Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14B9CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 09:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQMyP-0005ww-SI; Tue, 02 Dec 2025 04:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vQMyO-0005uf-IF
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 04:47:04 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vQMyM-0008U2-PI
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 04:47:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A505nZ6rZMerplm8k8fdAniTsAL8w6JR+JfaipQ0RAgqIdUDdINc2QTLHDPsTin3kJeByq6jGfgzsOPISU7si+L63iqN24kvQ0soKWCpxP6g1Zit+7J4sNf5MEUT9cpIODMhdEP+s2c/1GnyT7Ztox813hLUu3rV810UcvIkHy1niY3pVrbCbgJO15zeWLgcHx0kqbfA5kFWehBsXjg8/vtoEbHzKPrOZfUQeKvnyorwPWCh4QTRnA3/qxvECsKncpgup+RXjutDig3v4/1JuDmAJFzqcdglnvStQpP3bKYdBiIY+Vh/+O9Hs1looOoPVuGl1vMw9lc7b8yWg6aBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nud8odJt+2DAHM4Bn/+Jsghv9f5mRvVZvUc4t/CudU=;
 b=hzNa8xlXwnIX5slP81Si0fEiG3DmlpH0YHf/eZFc7xJTC1aZclcM9Xo5Vp8+oZjG2HZSdxaBbQ9BNiDamTHEC77e/Z9PQr92keviwh/KRWByheom6BWWQV/wghdsIHcfgUqEE2ClWYd6ydc420/55NN0J6h2kUkzAhE/Pj6IqW+BdlYqwJSQMLGp7ofLkxhjAbgROnQ3VlMfWeesMpcq1PYdLp2ZyXvjtyMAg3i47/nGzLdpHJgvF0qw37rQEHyN24YoqdnMVMnKAjyttS/PVQWsYC+PhZh97RS9lFm60bPgDXGqvdts9OD29sTX4ewX2sD11oou02bEBOgZtVurvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nud8odJt+2DAHM4Bn/+Jsghv9f5mRvVZvUc4t/CudU=;
 b=GDlB2gG8cV3nmNaQkoNGO/8lKudK8A6vwRQE4dSsls/a3cgoxFHdE/xrykze5a3IB5H514abWCHv9yeP4mpMbKqNCsVtAWlYVEG2nlWKzejVJu4U4KW1RnyB0QVHr17MdOrnEl8F/IyAPkBbwcEkzeovK2utqRBviE9KQo370Qkv0S5VLQL2CFb3x3TqCN65f2mIjnm4v1/t0GH4GJVSL+aC19a2pqgEMW6dYo8PVdaFJ2nmehnRAQeQsqnMaWYcPKTY2Dopab0HwrM+3DvE+q77NUYZYN8agGpD5k0dL+3zlTMnKs2J9fK7/3ow5w50PNwPEMaPScV3t74JKO8sFA==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by PA1PR04MB10938.eurprd04.prod.outlook.com (2603:10a6:102:486::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 09:46:58 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 09:46:58 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: RE: [EXT] Re: [PATCHv3 00/13] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Topic: [EXT] Re: [PATCHv3 00/13] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Index: AQHcWVR8XMZOm6lZIkWllt/IB1o56LUC5D4ggAposICAAJRx8IAATEWAgAAAqhA=
Date: Tue, 2 Dec 2025 09:46:58 +0000
Message-ID: <AM9PR04MB848771BC04FE27A9A7A9906E87D8A@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <AM9PR04MB8487540421160BCD438CFDA987D1A@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <CAFEAcA96wEquV-rWRU8x7DZBkNUOLYb_DVi80GRSZ_ekGGLUhw@mail.gmail.com>
 <AM9PR04MB84870E366018AD0D159DD40287D8A@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <CAFEAcA-i3XMS2w1xD_aVe3y07ac+uD-RzE57OB1dPWdadj--1w@mail.gmail.com>
In-Reply-To: <CAFEAcA-i3XMS2w1xD_aVe3y07ac+uD-RzE57OB1dPWdadj--1w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|PA1PR04MB10938:EE_
x-ms-office365-filtering-correlation-id: 58aed3f3-64cc-4331-dde7-08de3187bc88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?I4AmaBfxX2nlnui7dzAeYXagLWRk6ntLEXly9LFlMbQayqa8Y1DoRqB7r8CW?=
 =?us-ascii?Q?CjB2LKUBC3cVhl/XGbrJEeeYzNM4v6JhijCfzyj+izkIs4plFpq3ZhmpkAGo?=
 =?us-ascii?Q?6XHkHoVc7wfg7cCno7dkmNUT63CXgjdYNFEcXqF2HK8NQb2F73gd0sjxd2vC?=
 =?us-ascii?Q?791V58ZiWXyuxgiLJXOV9t6itFHrnK2OxlnIXDD4LRbI2ZihGJaUIqSqCg9D?=
 =?us-ascii?Q?ZSnWT18vDj90NZ9zOxs6lR4+KjPgypNK0ZjsqGScdMp+0p3CCl6qN1iEjp5a?=
 =?us-ascii?Q?6K6vAmeAx03dZ5miUqQmIU597pVd0LvyM/yGqV0nS8Ri6wU1VMCi8XY+IqfO?=
 =?us-ascii?Q?clwF4LzH02J7mzayFXow28evwWGhc7972PeU2qkGyehhkkMMYBteNGsOoeCc?=
 =?us-ascii?Q?cASPwpc1TqNI2JihP6X0/nTzkHNPsjbdPCShhAQRY+hSPdVwAG1kZsheu4Un?=
 =?us-ascii?Q?A6V4sokZaQ8/hUU8quksIMe6uIYfl9mKuL+4CS3Gc+YdZO/Wq2hmOr+h423B?=
 =?us-ascii?Q?D3Iu76shnJyMbOSzSlxWJTOEjt3LRVNd6jDIP3SBxE1jEj1gBn1qpzrDJS1l?=
 =?us-ascii?Q?vwYy9VMMA/EKeDnG7giAFlLbCmIVcB/rvGc8kTDHjbnvr8JjPSPUy482nc61?=
 =?us-ascii?Q?LRJ4KReHB3uuwG2jMvygXbk214yrg5LlB3pc+oBBK/5GJg7C8lcm3C5jsYry?=
 =?us-ascii?Q?CqGeVPOg0niw7U+OBTuzvpoW6wiHIXiSFSmdDnuzBThi78FIu3whc6jYBKJG?=
 =?us-ascii?Q?KvyGOs4H/Tw+Wn2qwoRZzBvHAGe9fnzaXwT2JIwpujXjAwsO7dkMMASZjyi/?=
 =?us-ascii?Q?dNfEVCWt3GetVTDOP4G8X6FwM16Pe5I8qm44w9Czdp5ZYA5X63KGpw991/ny?=
 =?us-ascii?Q?W7WypD83FYDDLeseUX0llI5hz56qETEGOWoA6TtPqQkbupwyjj/55uewmP9c?=
 =?us-ascii?Q?I1GzTLxxtUgpk+o5/madZcdgPctSVsuzSikdpE4aIKXZnkfvSADjfKfaYqe6?=
 =?us-ascii?Q?1rdvPO/TpZJy6PXSA92pU2QMgc84Lkc+Gx5nnLtxWTTCYMmnzvuWnii2XieD?=
 =?us-ascii?Q?UBSAWYUTh2ar7mmvnKII/h4fuRasSx86LyUHp+5AjYzNMT1OjcgK7J5yqRK6?=
 =?us-ascii?Q?diRgMy3RmtVUwNINXuWhQ74PKv7xggPsLMwcvniRDol955qY/XocH8a0pRBg?=
 =?us-ascii?Q?A3dzLl8jkhWHIEJjd8oDFpmFNEybhCVlE5Umn+0G/F6lwyDCHhW7HKsGiCqJ?=
 =?us-ascii?Q?LM0DcEOEUwe/bNr3rH19/OiFqbnrpjIfEl+0EO5P/eXbzGa0tE0Z2ihmpLLS?=
 =?us-ascii?Q?lgyBK70QPE5saHF0N3DWQ4XsIX1b/r1YROJyT+lGgdpH4Ybz3G7Eh45+0ss6?=
 =?us-ascii?Q?gLHgc41Hb1NOiZrTxFCghX7HbI0Py4Og+XhIMitpP7J+X9i8e6KwsJZNGQWW?=
 =?us-ascii?Q?Q+c/mPOghtsdRFEQNvAISWxIo4mOAKqicwClmyGfRH4icEPCp1Bk2/dk0vzu?=
 =?us-ascii?Q?Zez37Y9kidX7RbnKcrL2QSoIUSQwzh4d+cNW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pPZfnpPMH5Q6QCxbxQwa3OL4qO88Tvqqo0CorQ52gRgItiSv8y3XB+/yRTCx?=
 =?us-ascii?Q?28ToTrHAfV/Hd2kZY5vpCCswPQAHKc0iUIIXBTtTn7Q3OOh7LvoxcT099364?=
 =?us-ascii?Q?cuYMwWuMzxog3nA8pD35i4iSg57xdmWFPnFgBCdigRBx1NcdqHeba7OMEyvN?=
 =?us-ascii?Q?s4eYQ+Kg68HpYcti73lELKdCfIYGc+vK4t/VFO7szzDnqVWindggzbj5p7gC?=
 =?us-ascii?Q?0YhViflaSdcu8FISiPlqZDWtam8zjI+ffIy2BvjnqufEowwTVH/tKwFbVixY?=
 =?us-ascii?Q?HD466XtrBlGaPYWHd1PNLB4s9saTcv2B3z7wC2Np5Guy5X0YaupcDNNRhzIz?=
 =?us-ascii?Q?8Gmdn7Jmnddl9KXIu1MGNzHS/TWNXnPDttOlsr1h0rS9U1dYJvp8MISc/dV5?=
 =?us-ascii?Q?w0bRFJiKSerM0Z1hQqnjYo5z6gp3Eo6XA+Z5AEI9vUzZY0l61ZpmfJ9x7RBO?=
 =?us-ascii?Q?j3CnepfQH+eQGbkoB8jX714vSvssfLqTNMxu/+p1U2ets3gSZoZuQfRcmnmL?=
 =?us-ascii?Q?QrrRbxGst7OBztVcXLgnmQkWqVnCjlw3KYDSRT9XrvRITvu5VRoFO598Piw+?=
 =?us-ascii?Q?S3RsXDwM0sq63vG0slTbAQfj5E2Bebgq0HCUyqmBWuH+sfW35jX1HHRdCyhf?=
 =?us-ascii?Q?b6MNVnaHxHPkqU217muKB637aUJTZm7iScklhUtorPu+mzpedfiwUwdfPfwV?=
 =?us-ascii?Q?T788uDFyXdae7ppcWUPTIm5lD7xTQurnSHeYARB6FdGZIUnj/1BPaP/xhIht?=
 =?us-ascii?Q?wkTiHSkncyRsmoSqHUIiz/vJoj2g+efWyEqCq5sPHzElyZHc3QiYmeb5qTPv?=
 =?us-ascii?Q?NtG0lRUJiJuNqxG2M8QdqYnZqSLdhOVdDYBCOizfLyiC/pF9zzzOW06plPE9?=
 =?us-ascii?Q?DEVPbsBzpr4ppWjtY8cHq7kPOBkpqxonGPIDZRLPsQDioKYNvCHna3lXBfBK?=
 =?us-ascii?Q?4UCapX+MUlhAVy0KOo6RThust/GKXPjEsezLIyEoy/MfOtsySgx7sIvRXnGs?=
 =?us-ascii?Q?Ra8z3ncL4nkJnuGCLg4R4LBBGDHYyh+JTqqr0AKo7Pm02c61sIUKUCbcl1IW?=
 =?us-ascii?Q?jXnL6tSiVwk9EqyZvmzKqvUxUI/n+2W+sjo9PM8SiSRRFq4f87cryiGONUQu?=
 =?us-ascii?Q?Ng3WvI+k8wNPP/eu7R7ruoOfpE7lo6qRFmYXw+3nQFuM30GvJt4Hc9pnYPky?=
 =?us-ascii?Q?sJT8q81n7d2Aw0VAywe405tHTlhDj3IOBYrKJLY/LEiAflOfidGIC6WKxCc7?=
 =?us-ascii?Q?2zpEocg4inEohtorl9BfVbiOYuDIdW4WyntV2l3K4pRRPZmFTtZ+2YmSlu7Y?=
 =?us-ascii?Q?VoMQxnKutxbEpxMs8EIMNSUYjHO+YOFjpWqcIHjiUhl2JrR+ratZi/5UBn0h?=
 =?us-ascii?Q?6k2TFiSof6cvhz+8Bs+nz32uHfWKKuJ8lNrvNJFp4RB4i92AZCbPhCVIppx6?=
 =?us-ascii?Q?kHhYMai0KfMgkdIG4sM5CbtzOWnMp484S4zyiJEX3cBLRaa1eOiNc4MbCUIY?=
 =?us-ascii?Q?fmM1XK4EaADdZ4kYu+GBdDkytTNl98S37UXwUO+R+b7wd0TxX3Koy5xKg1so?=
 =?us-ascii?Q?UyG2GsH1RFeuwmypG47x6SyUJD1Yv4T/vk9knwdG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58aed3f3-64cc-4331-dde7-08de3187bc88
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 09:46:58.6232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlKgYGl8S3z/G65b5eq8RRhYBZ8vBqe7+HVqQKRT2671j865n4fqP73Lh0XUMZAJ2qzoFr2N3glzP7PT4qDiUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10938
Received-SPF: permerror client-ip=2a01:111:f403:c207::3;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: 02 December 2025 15:14
> To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com
> Subject: Re: [EXT] Re: [PATCHv3 00/13] Adding comprehensive support for
> i.MX8MM EVK board
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Tue, 2 Dec 2025 at 05:19, Gaurav Sharma <gaurav.sharma_7@nxp.com>
> wrote:
> >
> >
> > > At least some of these patches were reviewed by Philippe in v1.
> > > Did they all change?
> > >
> > > The way this is supposed to work is that where a patch has been
> > > reviewed and hasn't changed in a followup respin of a patchset, you
> > > keep the reviewed-by tag, which tells us that we don't need to
> > > repeat that bit of the review. More detail:
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fw=
w
> > >
> w.q%2F&data=3D05%7C02%7Cgaurav.sharma_7%40nxp.com%7C5426ed39023f
> 453ab8
> > >
> 5908de31875150%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> 900265
> > >
> 4453250191%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIl
> YiOiIwL
> > >
> jAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7
> C%7
> > >
> C%7C&sdata=3D5MI2GF5C0W%2Fwuyoysgtn4m%2BZQSMrEALcRtZhTxjchcs%3D
> &reserv
> > > ed=3D0
> > > emu.org%2Fdocs%2Fmaster%2Fdevel%2Fsubmitting-a-
> patch.html%23proper-
> > > use-of-reviewed-by-tags-can-aid-
> > >
> review&data=3D05%7C02%7Cgaurav.sharma_7%40nxp.com%7C7d7d9203ac334
> > >
> 65757c908de3116f632%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> > >
> 7C639002171850292201%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGki
> > >
> OnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoy
> > >
> fQ%3D%3D%7C0%7C%7C%7C&sdata=3D%2Bj2Q4APWnTNTY%2FTHqfaEZsmBJH
> > > E%2FzD6zsv%2BxnZ9IyC4%3D&reserved=3D0
> > >
> >
> > The v1 patch files reviewed by Philippe changed. Structure type was
> changed in all those reviewed patches that's why reviewed-by tag was not
> retained in the follow-up revisions.
>=20
> Generally, if somebody says "do this trivial change X"
> and then gives an R-by tag, they mean "if you do this thing and nothing e=
lse
> then you can add my tag to it".
>=20

Got it.

