Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57EDF55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6H8-0002lB-HO; Tue, 24 Feb 2026 23:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vv6H5-0002ju-Pk
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:13:23 -0500
Received: from mail-norwayeastazon11013024.outbound.protection.outlook.com
 ([40.107.159.24] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vv6Gx-0003lf-LY
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:13:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNR/YfS+V0xN8d9BJYFW3B5jMnfn76oBrLBal0do1O6Vb+mJnIlaCL5ZkHTp6WF3b9ATgXm9BmLvX0foY6x09TGLRFHOTFHw1yrwpDIguBVkGyUmFARNQkeGHdu5YcanLYuBEE/SWeIsnWdjWD4h0lu88ytFaXU3kCSUUOseMNRB+DvNXe8fSvQbklPRLwrnBM2JITtr2qPjkTHYfylhPbD+AVqxTwAwGrcxbPosbZ1KfqZcg2qZuo0UC95CWAJh2pTFybjmktiwutR0dX5BGBMWAfj3Rbx/o2lQuwSXsA1YGgUiTn0I/flF2ivElZd9SUyjLFvady2BcW8cJui2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4O8MIFwWvJ6hrcApeSKugwTnh12ZmlgkoJM2BZ/0l0=;
 b=rZS8r1CiRCMl7lT3vK+/Dy1dXHHtZEoxLMDFPDl9xBSpzW3y24U3E513wJotvresr4AMGOHF1T5TfPCirPUUkw2hnlYG/Hftb9LZLLQ7v1xYhhmIVAJMUiXJMmkuYgdTe19PEBa/E2Aft4xicjimVPubv30gfTUsQK7uveNlOK6y6NQb8oCf8dUeKm29398rz+FbosYT2akprCvHFK3MlZjDxXmg5ooDIoZpTTBamFwirtoc6RhMfpsVAa01/hQOSVNNBv9qUDXRS/DF9U5dzF7DLQDfPz6v8Rp2NSToLpdTOr4y54Z+gzC9L7aEs1BPRKUOuJZ8hUelhcsImYaVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4O8MIFwWvJ6hrcApeSKugwTnh12ZmlgkoJM2BZ/0l0=;
 b=F3SEa1b0LaDIij8jR7q9tbYHqSVDRKMLYa/LRIQFHHz79W0DQ2ltunaCqnGplfnKRoMXB6Sch9nBsb2K2s4uaEzElbL22cBamCh+lsdAmjunZkWRo2/FHSo1U2s0hISMK++Tii/pFwF/Vz2OyWZB/I5Qs4+JfKELjGB2BStehiZnCiTMal0V8l9EFsqSFV/TJRWL49zvIA+tVcDrmTr47R8q/X53vjxy8OSLFQDftpGsVI0Nl8SSnGVj9tEehu136fJVsV2/8KRBKXVEeE3YtXu2tZOo5c9Xr+zEmUsv2Xbf3acDxboOxhbDKZvWvmgbifXWn2m+aSqOM52QpGRTxw==
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com (2603:10a6:208:6e::32)
 by GV1PR04MB10077.eurprd04.prod.outlook.com (2603:10a6:150:1a5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 04:08:09 +0000
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b]) by AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b%4]) with mapi id 15.20.9632.010; Wed, 25 Feb 2026
 04:08:09 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCHv4 01/15] hw/arm: Add the i.MX 8MM EVK(Evaluation
 Kit) board
Thread-Topic: [EXT] Re: [PATCHv4 01/15] hw/arm: Add the i.MX 8MM
 EVK(Evaluation Kit) board
Thread-Index: AQHcZalfx1wWExJ35kiD6NPzwhPS7LVOkXuAgCDRzGCAIPcuoIACdq0AgAB8IZA=
Date: Wed, 25 Feb 2026 04:08:09 +0000
Message-ID: <AM0PR04MB4370A63B86C0EBC3AE3960D68775A@AM0PR04MB4370.eurprd04.prod.outlook.com>
References: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
 <20251205053819.2021772-2-gaurav.sharma_7@nxp.com>
 <61D6819C-96C4-4C7D-87CF-378F76E85C2A@gmail.com>
 <AM9PR04MB84877B347C79D69D43EEDD7E879AA@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <AM9PR04MB8487D41F72A61106DCDCA8F78777A@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <BBD5B7FA-E9C7-43E1-B2CE-E4299A0700AB@gmail.com>
In-Reply-To: <BBD5B7FA-E9C7-43E1-B2CE-E4299A0700AB@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: shentey@gmail.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4370:EE_|GV1PR04MB10077:EE_
x-ms-office365-filtering-correlation-id: bfff2982-3baf-4b01-65c6-08de74237c9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/+ywGHVzU1/uDWM/XPXoLWXlcXyktlOBbPAFz2X98+Mr4TWMUbSPJ2H+zeba?=
 =?us-ascii?Q?QnBoycZfRJcoWBq5droQ5R6YRHj86o1S4RFm7GRPL7LFhhVyCuRQsZtzeIwE?=
 =?us-ascii?Q?zlLy3JydeEL8OVK4Ckw1Ql5Cl2+uGDBwmg++cpIgNcOTnLNGTf/G0I4PpdWy?=
 =?us-ascii?Q?aXg2bEYxDAckQW3yfNdQQ4oBdvlPoguzZ5hL0PDbr6mhYPGS1Se37nQdC6+N?=
 =?us-ascii?Q?gKlIon7ARWz+ELI3SDgS4e1RhOSiA7Pt7xq5EvsvRe14tlqX3epVbmWXa8xB?=
 =?us-ascii?Q?+PnayM3/7uvwcesTXgb0Ri1Kr2+P41cyX8M7zcvyeQy0QxUugUkBSBN3LYmG?=
 =?us-ascii?Q?zW7YQ6GfAZPQMrtevEOqv4sCq6bwXjXGLJ2Xm4JnwG++56YiHTNQZEfuzZT0?=
 =?us-ascii?Q?bRHZlNUN+O9tzZ6bTNvqCXd3xF3Vqk4ZRPjeafRjAE7VycK3olDsm0R5I6ot?=
 =?us-ascii?Q?qJkwEwZn0fcaIC2fQUo9GRZG+Z7MK3XPSlDB4lnhM1eLGEop0kxTuStD36oh?=
 =?us-ascii?Q?WNFVluFKiO2wygH2dTu7Z55cdd3zrNeW3kpoEJqqS+fQkwnqLE5Jw48AoO8d?=
 =?us-ascii?Q?AwoDdNh4z+PrFeAVs6N7sz7Z74XGHaLRb/tCv7xdWfu6watu+fNVCrJDoKPY?=
 =?us-ascii?Q?QhsqI5NInRF6vbffzL3o1ryPOvsow26k5nHO39Kn9nhNZfN5qW3rWhvt7YdD?=
 =?us-ascii?Q?kC6YWjguxVqJL2SRpoxfr6lwqyuxfTL3qVzjtfR6+tDYJUxkBBD5huIURt31?=
 =?us-ascii?Q?S51KK18iarQB+RkYZrE+W3+iii5cqi0hT6f7N0LfftJSgDGHsBV2E2g6lRD6?=
 =?us-ascii?Q?gkgir0r50ssCGBShoWI24U6mMEX8ASVjQcHf3m9v72pg7/HrJYV/gUKXxmY9?=
 =?us-ascii?Q?/asjQt/O9Jus10t5V4RI+PytdwQMe1OAeYMOOMc4DD6vg1iMcA3LhmTHfHKc?=
 =?us-ascii?Q?AQYOsEvxin+nYJOqJyDWsUP96BiPJze6hgiCo+bLzs+d/5A/QbB4AvL9Ww9p?=
 =?us-ascii?Q?MOuwtj6jgvmwleSH3RkqTr4PG/PvAqfiB9iuJB6QPDIEH+SxlpEMNhlGsmvi?=
 =?us-ascii?Q?Kaiasl0j9ZufJ/2aMnEBNXmmUIBMcnNTr2Ezpc9qc9XV0pcVF5kRtV3afMrt?=
 =?us-ascii?Q?imJVEfRoXYZRfTJfE32gsJb76itjdrF+qcFeFh/0uMa909F+h9i2yK/h61h8?=
 =?us-ascii?Q?8MqMOftQhgAkNE4a7kXx+73F52d2wqrrno1TbkUC04+9pWufQZ2y8hbRPkIy?=
 =?us-ascii?Q?RkHgFSDdHbkOrRd9Z8LDGlVy3zFE0eRGtUd+tF8Zuwo5MeYTUpIImM9UpPHZ?=
 =?us-ascii?Q?mjrj96mT5mFMeBHkVYtq9F4pB/QEaDZrGgxWXguCTM+11ms0tMHXsMrUlS+u?=
 =?us-ascii?Q?P+rtOz9hy3+q+sBqZQBCnkMcInyqLKf/PIlthE8OU7uLbTzAwxRmhJFfdBlh?=
 =?us-ascii?Q?wTRZYo5Ju7UwG7yTtGwuOnpfrzt7tmAjkZGxaFr7M+fubJFO1HqMMAs7d7Nd?=
 =?us-ascii?Q?tx4IZoYmskGXIsBi5nb+KdwhXE2xnLWq0Dp8av0H4OTMokH7M7TtrlwX56aY?=
 =?us-ascii?Q?qHwIB2+LVpidaNepafY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4370.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mbPqoCpbC9ldyPof5XMFx/afLXLbo7GuapOPZl0XOTdRG7W1ox/vEBzWyP0H?=
 =?us-ascii?Q?sOsK4rlqwgdiVng6bW6dTOdejoknjISR5rNTsN3FAhR3RzcMxngpGMWXkaVs?=
 =?us-ascii?Q?Dqx/M6wVULzFzsYH0ffXRczDVFl8kChPCUW4zak7zNesYXz01YjIXugxaWw/?=
 =?us-ascii?Q?QX8fuHILg5UO20RmfiaDVW6txM/aCve/riWmUARXI6wHbbavyFnXBquoKmLw?=
 =?us-ascii?Q?saK1TQOUYkb4Mb/+hkEVH0LK6T7OCU0O1LZXP+hTJ+2sqjdTYs/8M731T4jx?=
 =?us-ascii?Q?pHv5tDD7/emr7UNQ+F3aFQQG80CmIJvszzQiH1uUujsyKr5rpWKs/I824IVx?=
 =?us-ascii?Q?O6+DkjZ8oRAHLsxtT5Ax/SCOslZXhvqE7JUca1NemfcZwaTW5WB3w/I4c3W7?=
 =?us-ascii?Q?45cXooG7KRlwRS95l0GYUYQ9UgmapFjCe8tffULBvaZ9bFmIg/aUHMpMmqv6?=
 =?us-ascii?Q?xfRp4e2X0O7DCXFH2/qidUCEMbIVAvOhMaCzEwzpdNi6jZY1x0hLUrsGgqzO?=
 =?us-ascii?Q?OxPkk1deuHYA+kS5ETOWGYguciJ4E5O83o9ZjnWAKq9sCu3sLOTM6vLt8ch2?=
 =?us-ascii?Q?UR+3ZISiXO1WaOHjIyFcrO+idfOKdCNnTXPy+ssPGFvWxzP3FNDqoaR1YizT?=
 =?us-ascii?Q?wSYRp1LCtBDM7Vfz5xWdmIOl6mnaMqD0lTcAqZmKfBrlTArXhCv647k49IlF?=
 =?us-ascii?Q?rGU4PJ/8mZ/9HSLjWGxr3Ws4RFyG6S5T9R/HEqTK3z+pu6ZSC7voJWufyE/N?=
 =?us-ascii?Q?hslxN3eN0NBC4DcxYdmXtTcBKospPLBu4/GECO/rVlzcb6W94pQh6cnLk2TU?=
 =?us-ascii?Q?K2zIuP1wph67WGR20u4fzAWx6uB3nEOzSkjh93ByFgOcsok5PvZep9ER4XtR?=
 =?us-ascii?Q?SZERc3xwMaPMvqdl+FLLsKM2YQKRh1/njGTPZMLSWPFkUOxvJrxS4gNwg7Nv?=
 =?us-ascii?Q?7Thj3zqRcoanAV9wBogO34BwTfUHgMTWsNNF4B4YeP2SqPewDRiBMFVeT48w?=
 =?us-ascii?Q?G48Yh4kmoMGz8tOctdgHhHO6MNvo2w5khCbWJAolz2uNojN+Fw3TO7gNiJqe?=
 =?us-ascii?Q?wy5PiXjMZoSg+1KfAVTfcKGkIVjqyoz5bhV16bZauXx6qzkwN29S2HFxlgdh?=
 =?us-ascii?Q?Fs75h3um/PV2yaGU2PtyrHpDAT/H9WIXOqJ9q9LvGv/UALG5vi04hQmzR2qH?=
 =?us-ascii?Q?zSrBlTebv4+bnV0dqNja3e45kEPGm34dRqqR6G3ZXtSQ3r7fADZJWYbf+ka6?=
 =?us-ascii?Q?gKMj7SDt+6gFa+sCIPaf5evI08Cuk8UJgw/X993KJYDcElgk2fh4kk6mJG6I?=
 =?us-ascii?Q?905QGylWyu/faPHWeuCks7lheRTjsm9UX/kVBF+AJ9rmgnu5IJeuLXpLvclB?=
 =?us-ascii?Q?ZuDXs3T5DR1rhJl8SfgRoDgeppWZcDcvDeaORu/HBWFL5uLypwnGQlMId0EL?=
 =?us-ascii?Q?N5dY7Ow5mnTCqps/6VvUL17TuzKEMoVoS9facIvYyIdsvutj2YqLg74zVyhh?=
 =?us-ascii?Q?Xlj/mscN7Mcxr33t3BZ2R+HQWob1GIvipKf0mixDqNHm6DZm1H3oLbS72+dG?=
 =?us-ascii?Q?BQHbrn0NG5dqdl0L1l51L9OFBCILLKc3zQKjfD9JNst8sSXDKzj0TXuZRFwo?=
 =?us-ascii?Q?bZin8S6Ao9RijklGpaC5omLnuRXjsnhNDT/sBbRXNP+ifWi1OUi/WoPSprVK?=
 =?us-ascii?Q?MTSlHR9s9d57qbRdEkWOt+p2y2ze3uhamcy+bzEencb8EzsKSxsyviVKWufx?=
 =?us-ascii?Q?rT/Aeie2zA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4370.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfff2982-3baf-4b01-65c6-08de74237c9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 04:08:09.6337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmcFpcdMI6c6BNoNusbQGhsnvvlvSnBxR3Uoi6q7UnhKgLkVwqSgdrhHHCu2YDLl+89W9dyA0q6kpkvTii1K8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10077
Received-SPF: pass client-ip=40.107.159.24;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Yes @Bernhard Beschow. Sounds good.

> -----Original Message-----
> From: Bernhard Beschow <shentey@gmail.com>
> Sent: 25 February 2026 02:13
> To: Gaurav Sharma <gaurav.sharma_7@nxp.com>; qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> Subject: RE: [EXT] Re: [PATCHv4 01/15] hw/arm: Add the i.MX 8MM
> EVK(Evaluation Kit) board
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> Am 23. Februar 2026 07:08:00 UTC schrieb Gaurav Sharma
> <gaurav.sharma_7@nxp.com>:
> >@Bernhard Beschow, so how shall we go ahead to enable imx8mm?
>
> Hi Gurav,
>
> Yeah, let's not miss the upcoming release!
>
> My proposal is to leave the code essentially as is, at least for now, but=
 share
> the documentation to avoid duplication. My recent changes to imx8mp-evk
> [1] prepared the documentation to be shared, requiring just some defaults=
 to
> be adjusted in imx8mm-evk.c to match real hardware, namely RAM size and
> number of CPUs; see first patch in [1]. Then a new documentation patch
> could be added to this series advertising imx8mm-evk in addition to imx8m=
p-
> evk, and basically asking users to replace  'imx8mp' by 'imx8mm' in the
> commands to use the new machine. The duplicate imx8mm-evk.rst would be
> dropped from the series.
>
> Does this sound good to you? I'll leave some R-b tags for the code.
>
> Best regards,
> Bernhard
>
> [1]
> https://lore.ke/
> rnel.org%2Fqemu-devel%2F20260114213227.3812-1-
> shentey%40gmail.com%2F&data=3D05%7C02%7Cgaurav.sharma_7%40nxp.com
> %7C05c3e6bb432a492fda3808de73e55fac%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635%7C0%7C0%7C639075626177382799%7CUnknown%7CTWFpbGZsb3d
> 8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOI
> joiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DRRBzP3u2pSr20zcix
> Dnd5d6YmlQQf05BIGS8VFZwGOk%3D&reserved=3D0
>
> >
> >> -----Original Message-----
> >> From: Gaurav Sharma
> >> Sent: 02 February 2026 13:14
> >> To: Bernhard Beschow <shentey@gmail.com>; qemu-devel@nongnu.org
> >> Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> >> Subject: RE: [EXT] Re: [PATCHv4 01/15] hw/arm: Add the i.MX 8MM
> >> EVK(Evaluation Kit) board
> >>
> >> Hey Bernhard,
> >>
> >> Consolidating changes for imx8mp and imx8mm makes sense as it will
> >> reduce the code footprint in the repo. However, is it possible that
> >> we take it up as part of follow-up patches once the emulation support
> >> for 8MM gets mainlined? If that sounds ok to you.
> >>
> >> > -----Original Message-----
> >> > From: Bernhard Beschow <shentey@gmail.com>
> >> > Sent: 12 January 2026 16:00
> >> > To: qemu-devel@nongnu.org; Gaurav Sharma
> >> <gaurav.sharma_7@nxp.com>
> >> > Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> >> > Subject: [EXT] Re: [PATCHv4 01/15] hw/arm: Add the i.MX 8MM
> >> > EVK(Evaluation Kit) board
> >> >
> >> > Caution: This is an external email. Please take care when clicking
> >> > links or opening attachments. When in doubt, report the message
> >> > using the 'Report this email' button
> >> >
> >> >
> >> > Am 5. Dezember 2025 05:38:05 UTC schrieb Gaurav Sharma
> >> > <gaurav.sharma_7@nxp.com>:
> >> > >Implemented CPUs, RAM, UARTs and Interrupt Controller Other
> >> > >peripherals are represented as TYPE_UNIMPLEMENTED_DEVICE
> Complete
> >> > >memory map
> >> > of the
> >> > >SoC is provided.
> >> > >
> >> > >Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >> > >---
> >> > > MAINTAINERS                    |  10 +
> >> > > docs/system/arm/imx8mm-evk.rst |  68 ++++++
> >> > > docs/system/target-arm.rst     |   1 +
> >> > > hw/arm/Kconfig                 |  12 ++
> >> > > hw/arm/fsl-imx8mm.c            | 366
> >> +++++++++++++++++++++++++++++++++
> >> > > hw/arm/imx8mm-evk.c            | 110 ++++++++++
> >> > > hw/arm/meson.build             |   2 +
> >> > > include/hw/arm/fsl-imx8mm.h    | 157 ++++++++++++++
> >> > > 8 files changed, 726 insertions(+) create mode 100644
> >> > > docs/system/arm/imx8mm-evk.rst  create mode
> >> > 100644
> >> > >hw/arm/fsl-imx8mm.c  create mode 100644 hw/arm/imx8mm-evk.c
> >> > >create mode 100644 include/hw/arm/fsl-imx8mm.h
> >> > >
> >> > >diff --git a/MAINTAINERS b/MAINTAINERS index
> >> > >be6efff80c..41f76c5bd0
> >> > >100644
> >> > >--- a/MAINTAINERS
> >> > >+++ b/MAINTAINERS
> >> > >@@ -884,6 +884,16 @@ F: hw/pci-host/designware.c
> >> > > F: include/hw/pci-host/designware.h
> >> > > F: docs/system/arm/mcimx7d-sabre.rst
> >> > >
> >> > >+MCIMX8MM-EVK / iMX8MM
> >> > >+M: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >> > >+L: qemu-arm@nongnu.org
> >> > >+S: Maintained
> >> > >+F: hw/arm/fsl-imx8mm.c
> >> > >+F: hw/arm/imx8mm-evk.c
> >> > >+F: include/hw/arm/fsl-imx8mm.h
> >> > >+F: docs/system/arm/imx8mm-evk.rst
> >> > >+F: tests/functional/aarch64/test_imx8mm_evk.py
> >> > >+
> >> > > MCIMX8MP-EVK / i.MX8MP
> >> > > M: Bernhard Beschow <shentey@gmail.com>
> >> > > L: qemu-arm@nongnu.org
> >> > >diff --git a/docs/system/arm/imx8mm-evk.rst
> >> > >b/docs/system/arm/imx8mm-evk.rst new file mode 100644 index
> >> > >0000000000..408253193c
> >> > >--- /dev/null
> >> > >+++ b/docs/system/arm/imx8mm-evk.rst
> >> > >@@ -0,0 +1,68 @@
> >> > >+NXP i.MX 8MM Evaluation Kit (``imx8mm-evk``)
> >> > >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> > >+
> >> > >+The ``imx8mm-evk`` machine models the i.MX 8M Mini Evaluation
> >> > >+Kit, based on an i.MX 8MM SoC.
> >> >
> >> > This file is basically the one from imx8mp-evk with s/imx8mp/imx8mm/=
 .
> >> > Perhaps we could just list both boards in this section there and
> >> > mention somewhere.that all the commands apply to imx8mm in an
> >> > analogous fashion? That way we won't have to update both documents
> >> > when something changes.
> >> >
> >> > >+
> >> > >+Supported devices
> >> > >+-----------------
> >> > >+
> >> > >+The ``imx8mm-evk`` machine implements the following devices:
> >> > >+
> >> > >+ * Up to 4 Cortex-A53 cores
> >> > >+ * Generic Interrupt Controller (GICv3)
> >> > >+ * 4 UARTs
> >> > >+
> >> > >+Boot options
> >> > >+------------
> >> > >+
> >> > >+The ``imx8mm-evk`` machine can start a Linux kernel directly
> >> > >+using the standard ``-kernel`` functionality.
> >> > >+
> >> > >+Direct Linux Kernel Boot
> >> > >+''''''''''''''''''''''''
> >> > >+
> >> > >+Probably the easiest way to get started with a whole Linux system
> >> > >+on the machine is to generate an image with Buildroot. Version
> >> > >+2024.11.1 is tested at the time of writing and involves two steps.
> >> > >+First run the following commands in the toplevel directory of the
> >> Buildroot source tree:
> >> > >+
> >> > >+.. code-block:: bash
> >> > >+
> >> > >+  $ make freescale_imx8mmevk_defconfig  $ make
> >> > >+
> >> > >+Once finished successfully there is an ``output/image`` subfolder.
> >> > >+Navigate into it and resize the SD card image to a power of two:
> >> > >+
> >> > >+.. code-block:: bash
> >> > >+
> >> > >+  $ qemu-img resize sdcard.img 256M
> >> > >+
> >> > >+Now that everything is prepared the machine can be started as
> follows:
> >> > >+
> >> > >+.. code-block:: bash
> >> > >+
> >> > >+  $ qemu-system-aarch64 -M imx8mm-evk -smp 4 -m 3G \
> >> > >+      -display none -serial null -serial stdio \
> >> > >+      -kernel Image \
> >> > >+      -dtb imx8mm-evk.dtb \
> >> > >+      -append "root=3D/dev/mmcblk2p2" \
> >> > >+      -drive file=3Dsdcard.img,if=3Dsd,bus=3D2,format=3Draw,id=3Dm=
mcblk2
> >> > >+
> >> > >+
> >> > >+KVM Acceleration
> >> > >+----------------
> >> > >+
> >> > >+Be aware of the following limitations:
> >> > >+
> >> > >+* The ``imx8mm-evk`` machine is not included under the
> >> > >+"virtualization use
> >> > case"
> >> > >+  of :doc:`QEMU's security policy </system/security>`. This means
> >> > >+that you
> >> > >+  should not trust that it can contain malicious guests, whether
> >> > >+it is run
> >> > >+  using TCG or KVM. If you don't trust your guests and you're
> >> > >+relying on QEMU to
> >> > >+  be the security boundary, you want to choose another machine
> >> > >+such as
> >> > ``virt``.
> >> > >+* Rather than Cortex-A53 CPUs, the same CPU type as the host's
> >> > >+will be
> >> > used.
> >> > >+  This is a limitation of KVM and may not work with guests with a
> >> > >+tight
> >> > >+  dependency on Cortex-A53.
> >> > >+* No EL2 and EL3 exception levels are available which is also a
> >> > >+KVM
> >> > limitation.
> >> > >+  Direct kernel boot should work but running U-Boot, TF-A, etc.
> >> > >+ won't
> >> > succeed.
> >> > >diff --git a/docs/system/target-arm.rst
> >> > >b/docs/system/target-arm.rst index a96d1867df..d6a4b5bb00 100644
> >> > >--- a/docs/system/target-arm.rst
> >> > >+++ b/docs/system/target-arm.rst
> >> > >@@ -97,6 +97,7 @@ Board-specific documentation
> >> > >    arm/mcimx6ul-evk
> >> > >    arm/mcimx7d-sabre
> >> > >    arm/imx8mp-evk
> >> > >+   arm/imx8mm-evk
> >> > >    arm/orangepi
> >> > >    arm/raspi
> >> > >    arm/collie
> >> > >diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig index
> >> > >0cdeb60f1f..be38c67a1c 100644
> >> > >--- a/hw/arm/Kconfig
> >> > >+++ b/hw/arm/Kconfig
> >> > >@@ -626,6 +626,18 @@ config FSL_IMX8MP_EVK
> >> > >     depends on TCG || KVM
> >> > >     select FSL_IMX8MP
> >> > >
> >> > >+config FSL_IMX8MM
> >> > >+    bool
> >> > >+    select ARM_GIC
> >> > >+    select IMX
> >> > >+
> >> > >+config FSL_IMX8MM_EVK
> >> > >+    bool
> >> > >+    default y
> >> > >+    depends on AARCH64
> >> > >+    depends on TCG
> >> > >+    select FSL_IMX8MM
> >> > >+
> >> > > config ARM_SMMUV3
> >> > >     bool
> >> > >
> >> > >diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c new file
> >> > >mode
> >> > >100644 index 0000000000..fb6a78adba
> >> > >--- /dev/null
> >> > >+++ b/hw/arm/fsl-imx8mm.c
> >> > >@@ -0,0 +1,366 @@
> >> > >+/*
> >> > >+ * i.MX 8MM SoC Implementation
> >> > >+ *
> >> > >+ * Based on hw/arm/fsl-imx6.c
> >> >
> >> > s/imx6/imx8mp/ ?
> >> >
> >> > >+ *
> >> > >+ * Copyright (c) 2025, NXP Semiconductors
> >> > >+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >> > >+ *
> >> > >+ * SPDX-License-Identifier: GPL-2.0-or-later
> >> > >+ *
> >> > >+ * iMX8MM Reference Manual -
> >> > >+
> >> > https://w/
> >> >
> ww%2F&data=3D05%7C02%7Cgaurav.sharma_7%40nxp.com%7C05c3e6bb432a
> 492fda
> >> >
> 3808de73e55fac%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C639
> 0756
> >> >
> 26177414656%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUs
> IlYiOiI
> >> >
> wLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0
> %7
> >> >
> C%7C%7C&sdata=3DA3KqJnGKEgme8oGLnC%2FVbwHUF1lrKDg5FLLAaQv6jlo%3
> D&rese
> >> > rved=3D0
> >> > >+ .nxp.com%2Fproducts%2Fi.MX8MMINI&data=3D05%7C02%7Cgaurav.sh
> ar
> >> ma
> >> > _7%40nxp
> >> > >+ .com%7C7a050f54b27c4afe07b608de51c58b03%7C686ea1d3bc2b4c6f
> a9
> >> 2c
> >> > d99c5c3
> >> > >+
> >> >
> >>
> 01635%7C0%7C0%7C639038106049104546%7CUnknown%7CTWFpbGZsb3d8
> >> > eyJFbXB0eU
> >> > >+
> >> >
> >>
> 1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsI
> >> > ld
> >> > >+
> >> >
> >>
> UIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dp1OkZJs6ixqHT%2BlrwoGP0My19J
> >> > oizYZfPS
> >> > >+ vSqYpo%2Fwo%3D&reserved=3D0 -> Documentation */
> >> > >+
> >> > >+#include "qemu/osdep.h"
> >> > >+#include "system/address-spaces.h"
> >> > >+#include "hw/arm/bsa.h"
> >> > >+#include "hw/arm/fsl-imx8mm.h"
> >> > >+#include "hw/misc/unimp.h"
> >> > >+#include "hw/boards.h"
> >> > >+#include "system/kvm.h"
> >> > >+#include "system/system.h"
> >> > >+#include "target/arm/cpu.h"
> >> > >+#include "target/arm/cpu-qom.h"
> >> > >+#include "target/arm/kvm_arm.h"
> >> > >+#include "qapi/error.h"
> >> > >+#include "qobject/qlist.h"
> >> > >+
> >> > >+static const struct {
> >> > >+    hwaddr addr;
> >> > >+    size_t size;
> >> > >+    const char *name;
> >> > >+} fsl_imx8mm_memmap[] =3D {
> >> > >+    [FSL_IMX8MM_RAM] =3D { FSL_IMX8MM_RAM_START,
> >> > FSL_IMX8MM_RAM_SIZE_MAX, "ram" },
> >> > >+    [FSL_IMX8MM_DDR_PHY_BROADCAST] =3D { 0x3dc00000, 4 * MiB,
> >> > "ddr_phy_broadcast" },
> >> > >+    [FSL_IMX8MM_DDR_PERF_MON] =3D { 0x3d800000, 4 * MiB,
> >> > "ddr_perf_mon" },
> >> > >+    [FSL_IMX8MM_DDR_CTL] =3D { 0x3d400000, 4 * MiB, "ddr_ctl" },
> >> > >+    [FSL_IMX8MM_DDR_PHY] =3D { 0x3c000000, 16 * MiB, "ddr_phy" },
> >> > >+    [FSL_IMX8MM_GIC_DIST] =3D { 0x38800000, 512 * KiB, "gic_dist" =
},
> >> > >+    [FSL_IMX8MM_GIC_REDIST] =3D { 0x38880000, 512 * KiB,
> "gic_redist" },
> >> > >+    [FSL_IMX8MM_VPU] =3D { 0x38340000, 2 * MiB, "vpu" },
> >> > >+    [FSL_IMX8MM_VPU_BLK_CTRL] =3D { 0x38330000, 2 * MiB,
> >> "vpu_blk_ctrl" },
> >> > >+    [FSL_IMX8MM_VPU_G2_DECODER] =3D { 0x38310000, 1 * MiB,
> >> > "vpu_g2_decoder" },
> >> > >+    [FSL_IMX8MM_VPU_G1_DECODER] =3D { 0x38300000, 1 * MiB,
> >> > "vpu_g1_decoder" },
> >> > >+    [FSL_IMX8MM_USB2_OTG] =3D { 0x32e50200, 0x200, "usb2_otg" },
> >> > >+    [FSL_IMX8MM_USB2] =3D { 0x32e50000, 0x200, "usb2" },
> >> > >+    [FSL_IMX8MM_USB1_OTG] =3D { 0x32e40200, 0x200, "usb1_otg" },
> >> > >+    [FSL_IMX8MM_USB1] =3D { 0x32e40000, 0x200, "usb1" },
> >> > >+    [FSL_IMX8MM_GPU2D] =3D { 0x38000000, 64 * KiB, "gpu2d" },
> >> > >+    [FSL_IMX8MM_QSPI1_RX_BUFFER] =3D { 0x34000000, 32 * MiB,
> >> > "qspi1_rx_buffer" },
> >> > >+    [FSL_IMX8MM_PCIE1] =3D { 0x33800000, 4 * MiB, "pcie1" },
> >> > >+    [FSL_IMX8MM_QSPI1_TX_BUFFER] =3D { 0x33008000, 32 * KiB,
> >> > "qspi1_tx_buffer" },
> >> > >+    [FSL_IMX8MM_APBH_DMA] =3D { 0x33000000, 32 * KiB,
> "apbh_dma" },
> >> > >+
> >> > >+    /* AIPS-4 Begin */
> >> > >+    [FSL_IMX8MM_TZASC] =3D { 0x32f80000, 64 * KiB, "tzasc" },
> >> > >+    [FSL_IMX8MM_PCIE_PHY1] =3D { 0x32f00000, 64 * KiB, "pcie_phy1"=
 },
> >> > >+    [FSL_IMX8MM_MEDIA_BLK_CTL] =3D { 0x32e28000, 256,
> >> "media_blk_ctl" },
> >> > >+    [FSL_IMX8MM_LCDIF] =3D { 0x32e00000, 64 * KiB, "lcdif" },
> >> > >+    [FSL_IMX8MM_MIPI_DSI] =3D { 0x32e10000, 64 * KiB, "mipi_dsi" }=
,
> >> > >+    [FSL_IMX8MM_MIPI_CSI] =3D { 0x32e30000, 64 * KiB, "mipi_csi" }=
,
> >> > >+    [FSL_IMX8MM_AIPS4_CONFIGURATION] =3D { 0x32df0000, 64 * KiB,
> >> > "aips4_configuration" },
> >> > >+    /* AIPS-4 End */
> >> > >+
> >> > >+    [FSL_IMX8MM_INTERCONNECT] =3D { 0x32700000, 1 * MiB,
> >> "interconnect"
> >> > >+ },
> >> > >+
> >> > >+    /* AIPS-3 Begin */
> >> > >+    [FSL_IMX8MM_ENET1] =3D { 0x30be0000, 64 * KiB, "enet1" },
> >> > >+    [FSL_IMX8MM_SDMA1] =3D { 0x30bd0000, 64 * KiB, "sdma1" },
> >> > >+    [FSL_IMX8MM_QSPI] =3D { 0x30bb0000, 64 * KiB, "qspi" },
> >> > >+    [FSL_IMX8MM_USDHC3] =3D { 0x30b60000, 64 * KiB, "usdhc3" },
> >> > >+    [FSL_IMX8MM_USDHC2] =3D { 0x30b50000, 64 * KiB, "usdhc2" },
> >> > >+    [FSL_IMX8MM_USDHC1] =3D { 0x30b40000, 64 * KiB, "usdhc1" },
> >> > >+    [FSL_IMX8MM_SEMAPHORE_HS] =3D { 0x30ac0000, 64 * KiB,
> >> > "semaphore_hs" },
> >> > >+    [FSL_IMX8MM_MU_B] =3D { 0x30ab0000, 64 * KiB, "mu_b" },
> >> > >+    [FSL_IMX8MM_MU_A] =3D { 0x30aa0000, 64 * KiB, "mu_a" },
> >> > >+    [FSL_IMX8MM_UART4] =3D { 0x30a60000, 64 * KiB, "uart4" },
> >> > >+    [FSL_IMX8MM_I2C4] =3D { 0x30a50000, 64 * KiB, "i2c4" },
> >> > >+    [FSL_IMX8MM_I2C3] =3D { 0x30a40000, 64 * KiB, "i2c3" },
> >> > >+    [FSL_IMX8MM_I2C2] =3D { 0x30a30000, 64 * KiB, "i2c2" },
> >> > >+    [FSL_IMX8MM_I2C1] =3D { 0x30a20000, 64 * KiB, "i2c1" },
> >> > >+    [FSL_IMX8MM_AIPS3_CONFIGURATION] =3D { 0x309f0000, 64 * KiB,
> >> > "aips3_configuration" },
> >> > >+    [FSL_IMX8MM_CAAM] =3D { 0x30900000, 256 * KiB, "caam" },
> >> > >+    [FSL_IMX8MM_SPBA1] =3D { 0x308f0000, 64 * KiB, "spba1" },
> >> > >+    [FSL_IMX8MM_UART2] =3D { 0x30890000, 64 * KiB, "uart2" },
> >> > >+    [FSL_IMX8MM_UART3] =3D { 0x30880000, 64 * KiB, "uart3" },
> >> > >+    [FSL_IMX8MM_UART1] =3D { 0x30860000, 64 * KiB, "uart1" },
> >> > >+    [FSL_IMX8MM_ECSPI3] =3D { 0x30840000, 64 * KiB, "ecspi3" },
> >> > >+    [FSL_IMX8MM_ECSPI2] =3D { 0x30830000, 64 * KiB, "ecspi2" },
> >> > >+    [FSL_IMX8MM_ECSPI1] =3D { 0x30820000, 64 * KiB, "ecspi1" },
> >> > >+    /* AIPS-3 End */
> >> > >+
> >> > >+    /* AIPS-2 Begin */
> >> > >+    [FSL_IMX8MM_QOSC] =3D { 0x307f0000, 64 * KiB, "qosc" },
> >> > >+    [FSL_IMX8MM_PERFMON2] =3D { 0x307d0000, 64 * KiB, "perfmon2" }=
,
> >> > >+    [FSL_IMX8MM_PERFMON1] =3D { 0x307c0000, 64 * KiB, "perfmon1" }=
,
> >> > >+    [FSL_IMX8MM_GPT4] =3D { 0x30700000, 64 * KiB, "gpt4" },
> >> > >+    [FSL_IMX8MM_GPT5] =3D { 0x306f0000, 64 * KiB, "gpt5" },
> >> > >+    [FSL_IMX8MM_GPT6] =3D { 0x306e0000, 64 * KiB, "gpt6" },
> >> > >+    [FSL_IMX8MM_SYSCNT_CTRL] =3D { 0x306c0000, 64 * KiB,
> "syscnt_ctrl" },
> >> > >+    [FSL_IMX8MM_SYSCNT_CMP] =3D { 0x306b0000, 64 * KiB,
> "syscnt_cmp" },
> >> > >+    [FSL_IMX8MM_SYSCNT_RD] =3D { 0x306a0000, 64 * KiB, "syscnt_rd"=
 },
> >> > >+    [FSL_IMX8MM_PWM4] =3D { 0x30690000, 64 * KiB, "pwm4" },
> >> > >+    [FSL_IMX8MM_PWM3] =3D { 0x30680000, 64 * KiB, "pwm3" },
> >> > >+    [FSL_IMX8MM_PWM2] =3D { 0x30670000, 64 * KiB, "pwm2" },
> >> > >+    [FSL_IMX8MM_PWM1] =3D { 0x30660000, 64 * KiB, "pwm1" },
> >> > >+    [FSL_IMX8MM_AIPS2_CONFIGURATION] =3D { 0x305f0000, 64 * KiB,
> >> > "aips2_configuration" },
> >> > >+    /* AIPS-2 End */
> >> > >+
> >> > >+    /* AIPS-1 Begin */
> >> > >+    [FSL_IMX8MM_CSU] =3D { 0x303e0000, 64 * KiB, "csu" },
> >> > >+    [FSL_IMX8MM_RDC] =3D { 0x303d0000, 64 * KiB, "rdc" },
> >> > >+    [FSL_IMX8MM_SEMAPHORE2] =3D { 0x303c0000, 64 * KiB,
> >> "semaphore2" },
> >> > >+    [FSL_IMX8MM_SEMAPHORE1] =3D { 0x303b0000, 64 * KiB,
> >> "semaphore1" },
> >> > >+    [FSL_IMX8MM_GPC] =3D { 0x303a0000, 64 * KiB, "gpc" },
> >> > >+    [FSL_IMX8MM_SRC] =3D { 0x30390000, 64 * KiB, "src" },
> >> > >+    [FSL_IMX8MM_CCM] =3D { 0x30380000, 64 * KiB, "ccm" },
> >> > >+    [FSL_IMX8MM_SNVS_HP] =3D { 0x30370000, 64 * KiB, "snvs_hp" },
> >> > >+    [FSL_IMX8MM_ANA_PLL] =3D { 0x30360000, 64 * KiB, "ana_pll" },
> >> > >+    [FSL_IMX8MM_OCOTP_CTRL] =3D { 0x30350000, 64 * KiB,
> "ocotp_ctrl" },
> >> > >+    [FSL_IMX8MM_IOMUXC_GPR] =3D { 0x30340000, 64 * KiB,
> >> "iomuxc_gpr" },
> >> > >+    [FSL_IMX8MM_IOMUXC] =3D { 0x30330000, 64 * KiB, "iomuxc" },
> >> > >+    [FSL_IMX8MM_GPT3] =3D { 0x302f0000, 64 * KiB, "gpt3" },
> >> > >+    [FSL_IMX8MM_GPT2] =3D { 0x302e0000, 64 * KiB, "gpt2" },
> >> > >+    [FSL_IMX8MM_GPT1] =3D { 0x302d0000, 64 * KiB, "gpt1" },
> >> > >+    [FSL_IMX8MM_SDMA2] =3D { 0x302c0000, 64 * KiB, "sdma2" },
> >> > >+    [FSL_IMX8MM_SDMA3] =3D { 0x302b0000, 64 * KiB, "sdma3" },
> >> > >+    [FSL_IMX8MM_WDOG3] =3D { 0x302a0000, 64 * KiB, "wdog3" },
> >> > >+    [FSL_IMX8MM_WDOG2] =3D { 0x30290000, 64 * KiB, "wdog2" },
> >> > >+    [FSL_IMX8MM_WDOG1] =3D { 0x30280000, 64 * KiB, "wdog1" },
> >> > >+    [FSL_IMX8MM_ANA_OSC] =3D { 0x30270000, 64 * KiB, "ana_osc" },
> >> > >+    [FSL_IMX8MM_ANA_TSENSOR] =3D { 0x30260000, 64 * KiB,
> >> > "ana_tsensor" },
> >> > >+    [FSL_IMX8MM_GPIO5] =3D { 0x30240000, 64 * KiB, "gpio5" },
> >> > >+    [FSL_IMX8MM_GPIO4] =3D { 0x30230000, 64 * KiB, "gpio4" },
> >> > >+    [FSL_IMX8MM_GPIO3] =3D { 0x30220000, 64 * KiB, "gpio3" },
> >> > >+    [FSL_IMX8MM_GPIO2] =3D { 0x30210000, 64 * KiB, "gpio2" },
> >> > >+    [FSL_IMX8MM_GPIO1] =3D { 0x30200000, 64 * KiB, "gpio1" },
> >> > >+    [FSL_IMX8MM_AIPS1_CONFIGURATION] =3D { 0x301f0000, 64 * KiB,
> >> > "aips1_configuration" },
> >> > >+    [FSL_IMX8MM_SAI6] =3D { 0x30060000, 64 * KiB, "sai6" },
> >> > >+    [FSL_IMX8MM_SAI5] =3D { 0x30050000, 64 * KiB, "sai5" },
> >> > >+    [FSL_IMX8MM_SAI3] =3D { 0x30030000, 64 * KiB, "sai3" },
> >> > >+    [FSL_IMX8MM_SAI2] =3D { 0x30020000, 64 * KiB, "sai2" },
> >> > >+    [FSL_IMX8MM_SAI1] =3D { 0x30010000, 64 * KiB, "sai1" },
> >> > >+
> >> > >+    /* AIPS-1 End */
> >> > >+
> >> > >+    [FSL_IMX8MM_A53_DAP] =3D { 0x28000000, 16 * MiB, "a53_dap" },
> >> > >+    [FSL_IMX8MM_PCIE1_MEM] =3D { 0x18000000, 128 * MiB,
> >> "pcie1_mem" },
> >> > >+    [FSL_IMX8MM_QSPI_MEM] =3D { 0x08000000, 256 * MiB,
> "qspi_mem" },
> >> > >+    [FSL_IMX8MM_OCRAM] =3D { 0x00900000, 256 * KiB, "ocram" },
> >> > >+    [FSL_IMX8MM_TCM_DTCM] =3D { 0x00800000, 128 * KiB,
> "tcm_dtcm" },
> >> > >+    [FSL_IMX8MM_TCM_ITCM] =3D { 0x007e0000, 128 * KiB, "tcm_itcm" =
},
> >> > >+    [FSL_IMX8MM_OCRAM_S] =3D { 0x00180000, 32 * KiB, "ocram_s" },
> >> > >+    [FSL_IMX8MM_CAAM_MEM] =3D { 0x00100000, 32 * KiB,
> "caam_mem" },
> >> > >+    [FSL_IMX8MM_BOOT_ROM_PROTECTED] =3D { 0x0003f000, 4 * KiB,
> >> > "boot_rom_protected" },
> >> > >+    [FSL_IMX8MM_BOOT_ROM] =3D { 0x00000000, 252 * KiB, "boot_rom"
> >> > >+ }, };
> >> > >+
> >> > >+static void fsl_imx8mm_init(Object *obj) {
> >> > >+    MachineState *ms =3D MACHINE(qdev_get_machine());
> >> > >+    FslImx8mmState *s =3D FSL_IMX8MM(obj);
> >> > >+    const char *cpu_type =3D ms->cpu_type ?:
> >> > ARM_CPU_TYPE_NAME("cortex-a53");
> >> > >+    int i;
> >> > >+
> >> > >+    for (i =3D 0; i < MIN(ms->smp.cpus, FSL_IMX8MM_NUM_CPUS); i++)=
 {
> >> > >+        g_autofree char *name =3D g_strdup_printf("cpu%d", i);
> >> > >+        object_initialize_child(obj, name, &s->cpu[i], cpu_type);
> >> > >+    }
> >> > >+
> >> > >+    object_initialize_child(obj, "gic", &s->gic,
> >> > >+ gicv3_class_name());
> >> > >+
> >> > >+    for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
> >> > >+        g_autofree char *name =3D g_strdup_printf("uart%d", i + 1)=
;
> >> > >+        object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_S=
ERIAL);
> >> > >+    }
> >> > >+
> >> > >+}
> >> > >+
> >> > >+static void fsl_imx8mm_realize(DeviceState *dev, Error **errp) {
> >> > >+    MachineState *ms =3D MACHINE(qdev_get_machine());
> >> > >+    FslImx8mmState *s =3D FSL_IMX8MM(dev);
> >> > >+    DeviceState *gicdev =3D DEVICE(&s->gic);
> >> > >+    int i;
> >> > >+
> >> > >+    if (ms->smp.cpus > FSL_IMX8MM_NUM_CPUS) {
> >> > >+        error_setg(errp, "%s: Only %d CPUs are supported (%d
> requested)",
> >> > >+                   TYPE_FSL_IMX8MM, FSL_IMX8MM_NUM_CPUS, ms-
> >> >smp.cpus);
> >> > >+        return;
> >> > >+    }
> >> > >+
> >> > >+    /* CPUs */
> >> > >+    for (i =3D 0; i < ms->smp.cpus; i++) {
> >> > >+        /* On uniprocessor, the CBAR is set to 0 */
> >> > >+        if (ms->smp.cpus > 1 &&
> >> > >+                object_property_find(OBJECT(&s->cpu[i]), "reset-cb=
ar")) {
> >> > >+            object_property_set_int(OBJECT(&s->cpu[i]),
> >> > >+ "reset-cbar",
> >> > >+
> >> fsl_imx8mm_memmap[FSL_IMX8MM_GIC_DIST].addr,
> >> > >+                                    &error_abort);
> >> > >+        }
> >> > >+
> >> > >+        /*
> >> > >+         * CNTFID0 base frequency in Hz of system counter
> >> > >+         */
> >> > >+        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000=
000,
> >> > >+                                &error_abort);
> >> > >+
> >> > >+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el2")) {
> >> > >+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el2"=
,
> >> > >+                                     !kvm_enabled(), &error_abort)=
;
> >> > >+        }
> >> > >+
> >> > >+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
> >> > >+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3"=
,
> >> > >+                                     !kvm_enabled(), &error_abort)=
;
> >> > >+        }
> >> > >+
> >> > >+        if (i) {
> >> > >+            /*
> >> > >+             * Secondary CPUs start in powered-down state (and can=
 be
> >> > >+             * powered up via the SRC system reset controller)
> >> > >+             */
> >> > >+            object_property_set_bool(OBJECT(&s->cpu[i]),
> >> > >+ "start-powered-
> >> off",
> >> > >+                                     true, &error_abort);
> >> > >+        }
> >> > >+
> >> > >+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
> >> > >+            return;
> >> > >+        }
> >> > >+    }
> >> > >+
> >> > >+    /* GIC */
> >> > >+    {
> >> > >+        SysBusDevice *gicsbd =3D SYS_BUS_DEVICE(&s->gic);
> >> > >+        QList *redist_region_count;
> >> > >+        bool pmu =3D object_property_get_bool(OBJECT(first_cpu),
> >> > >+ "pmu", NULL);
> >> > >+
> >> > >+        qdev_prop_set_uint32(gicdev, "num-cpu", ms->smp.cpus);
> >> > >+        qdev_prop_set_uint32(gicdev, "num-irq",
> >> > >+                             FSL_IMX8MM_NUM_IRQS + GIC_INTERNAL);
> >> > >+        redist_region_count =3D qlist_new();
> >> > >+        qlist_append_int(redist_region_count, ms->smp.cpus);
> >> > >+        qdev_prop_set_array(gicdev, "redist-region-count",
> >> > redist_region_count);
> >> > >+        object_property_set_link(OBJECT(&s->gic), "sysmem",
> >> > >+                                 OBJECT(get_system_memory()), &err=
or_fatal);
> >> > >+        if (!sysbus_realize(gicsbd, errp)) {
> >> > >+            return;
> >> > >+        }
> >> > >+        sysbus_mmio_map(gicsbd, 0,
> >> > fsl_imx8mm_memmap[FSL_IMX8MM_GIC_DIST].addr);
> >> > >+        sysbus_mmio_map(gicsbd, 1,
> >> > >+ fsl_imx8mm_memmap[FSL_IMX8MM_GIC_REDIST].addr);
> >> > >+
> >> > >+        /*
> >> > >+         * Wire the outputs from each CPU's generic timer and the =
GICv3
> >> > >+         * maintenance interrupt signal to the appropriate GIC
> >> > >+ PPI inputs,
> >> and
> >> > >+         * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs=
.
> >> > >+         */
> >> > >+        for (i =3D 0; i < ms->smp.cpus; i++) {
> >> > >+            DeviceState *cpudev =3D DEVICE(&s->cpu[i]);
> >> > >+            int intidbase =3D FSL_IMX8MM_NUM_IRQS + i * GIC_INTERN=
AL;
> >> > >+            qemu_irq irq;
> >> > >+
> >> > >+            /*
> >> > >+             * Mapping from the output timer irq lines from the CP=
U to the
> >> > >+             * GIC PPI inputs.
> >> > >+             */
> >> > >+            static const int timer_irqs[] =3D {
> >> > >+                [GTIMER_PHYS] =3D ARCH_TIMER_NS_EL1_IRQ,
> >> > >+                [GTIMER_VIRT] =3D ARCH_TIMER_VIRT_IRQ,
> >> > >+                [GTIMER_HYP]  =3D ARCH_TIMER_NS_EL2_IRQ,
> >> > >+                [GTIMER_SEC]  =3D ARCH_TIMER_S_EL1_IRQ,
> >> > >+            };
> >> > >+
> >> > >+            for (int j =3D 0; j < ARRAY_SIZE(timer_irqs); j++) {
> >> > >+                irq =3D qdev_get_gpio_in(gicdev, intidbase + timer=
_irqs[j]);
> >> > >+                qdev_connect_gpio_out(cpudev, j, irq);
> >> > >+            }
> >> > >+
> >> > >+            irq =3D qdev_get_gpio_in(gicdev, intidbase +
> >> ARCH_GIC_MAINT_IRQ);
> >> > >+            qdev_connect_gpio_out_named(cpudev,
> >> > >+ "gicv3-maintenance-
> >> > interrupt",
> >> > >+                                        0, irq);
> >> > >+
> >> > >+            irq =3D qdev_get_gpio_in(gicdev, intidbase + VIRTUAL_P=
MU_IRQ);
> >> > >+            qdev_connect_gpio_out_named(cpudev, "pmu-interrupt",
> >> > >+ 0, irq);
> >> > >+
> >> > >+            sysbus_connect_irq(gicsbd, i,
> >> > >+                               qdev_get_gpio_in(cpudev, ARM_CPU_IR=
Q));
> >> > >+            sysbus_connect_irq(gicsbd, i + ms->smp.cpus,
> >> > >+                               qdev_get_gpio_in(cpudev, ARM_CPU_FI=
Q));
> >> > >+            sysbus_connect_irq(gicsbd, i + 2 * ms->smp.cpus,
> >> > >+                               qdev_get_gpio_in(cpudev, ARM_CPU_VI=
RQ));
> >> > >+            sysbus_connect_irq(gicsbd, i + 3 * ms->smp.cpus,
> >> > >+                               qdev_get_gpio_in(cpudev,
> >> > >+ ARM_CPU_VFIQ));
> >> > >+
> >> > >+            if (kvm_enabled()) {
> >> > >+                if (pmu) {
> >> > >+                    assert(arm_feature(&s->cpu[i].env, ARM_FEATURE=
_PMU));
> >> > >+                    if (kvm_irqchip_in_kernel()) {
> >> > >+                        kvm_arm_pmu_set_irq(&s->cpu[i], VIRTUAL_PM=
U_IRQ);
> >> > >+                    }
> >> > >+                    kvm_arm_pmu_init(&s->cpu[i]);
> >> > >+                }
> >> > >+            }
> >> > >+        }
> >> > >+    }
> >> > >+
> >> > >+    /* UARTs */
> >> > >+    for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
> >> > >+        static const struct {
> >> > >+            hwaddr addr;
> >> > >+            unsigned int irq;
> >> > >+        } serial_table[FSL_IMX8MM_NUM_UARTS] =3D {
> >> > >+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART1].addr,
> >> > FSL_IMX8MM_UART1_IRQ },
> >> > >+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART2].addr,
> >> > FSL_IMX8MM_UART2_IRQ },
> >> > >+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART3].addr,
> >> > FSL_IMX8MM_UART3_IRQ },
> >> > >+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART4].addr,
> >> > FSL_IMX8MM_UART4_IRQ },
> >> > >+        };
> >> > >+
> >> > >+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_h=
d(i));
> >> > >+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
> >> > >+            return;
> >> > >+        }
> >> > >+
> >> > >+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0,
> >> > serial_table[i].addr);
> >> > >+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
> >> > >+                           qdev_get_gpio_in(gicdev, serial_table[i=
].irq));
> >> > >+    }
> >> > >+
> >> > >+    /* Unimplemented devices */
> >> > >+    for (i =3D 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
> >> > >+        switch (i) {
> >> > >+        case FSL_IMX8MM_GIC_DIST:
> >> > >+        case FSL_IMX8MM_GIC_REDIST:
> >> > >+        case FSL_IMX8MM_RAM:
> >> > >+        case FSL_IMX8MM_UART1 ... FSL_IMX8MM_UART4:
> >> > >+            /* device implemented and treated above */
> >> > >+            break;
> >> > >+
> >> > >+        default:
> >> > >+            create_unimplemented_device(fsl_imx8mm_memmap[i].name,
> >> > >+                                        fsl_imx8mm_memmap[i].addr,
> >> > >+                                        fsl_imx8mm_memmap[i].size)=
;
> >> > >+            break;
> >> > >+        }
> >> > >+    }
> >> > >+}
> >> > >+
> >> > >+static void fsl_imx8mm_class_init(ObjectClass *oc, const void *dat=
a) {
> >> > >+    DeviceClass *dc =3D DEVICE_CLASS(oc);
> >> > >+
> >> > >+    dc->realize =3D fsl_imx8mm_realize;
> >> > >+
> >> > >+    dc->desc =3D "i.MX 8MM SoC";
> >> > >+}
> >> > >+
> >> > >+static const TypeInfo fsl_imx8mm_types[] =3D {
> >> > >+    {
> >> > >+        .name =3D TYPE_FSL_IMX8MM,
> >> > >+        .parent =3D TYPE_SYS_BUS_DEVICE,
> >> > >+        .instance_size =3D sizeof(FslImx8mmState),
> >> > >+        .instance_init =3D fsl_imx8mm_init,
> >> > >+        .class_init =3D fsl_imx8mm_class_init,
> >> > >+    },
> >> > >+};
> >> > >+
> >> > >+DEFINE_TYPES(fsl_imx8mm_types)
> >> > >diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c new file
> >> mode
> >> > >100644 index 0000000000..ffc69f1050
> >> > >--- /dev/null
> >> > >+++ b/hw/arm/imx8mm-evk.c
> >> > >@@ -0,0 +1,110 @@
> >> > >+/*
> >> > >+ * NXP i.MX 8MM Evaluation Kit System Emulation
> >> > >+ *
> >> > >+ * Copyright (c) 2025, NXP Semiconductors
> >> > >+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >> > >+ *
> >> > >+ * SPDX-License-Identifier: GPL-2.0-or-later  */
> >> > >+
> >> > >+#include "qemu/osdep.h"
> >> > >+#include "system/address-spaces.h"
> >> > >+#include "hw/arm/boot.h"
> >> > >+#include "hw/arm/fsl-imx8mm.h"
> >> > >+#include "hw/arm/machines-qom.h"
> >> > >+#include "hw/boards.h"
> >> > >+#include "hw/qdev-properties.h"
> >> > >+#include "system/kvm.h"
> >> > >+#include "system/qtest.h"
> >> > >+#include "qemu/error-report.h"
> >> > >+#include "qapi/error.h"
> >> > >+#include <libfdt.h>
> >> >
> >> > Rather than introducing a new source file I think it should be
> >> > possible to extend imx8mp-evk instead. More comments below.
> >> >
> >> > >+
> >> > >+static void imx8mm_evk_modify_dtb(const struct arm_boot_info
> >> > >+*info, void *fdt) {
> >> > >+    int i, offset;
> >> > >+
> >> > >+    /* Temporarily disable following nodes until they are implemen=
ted
> */
> >> > >+    const char *nodes_to_remove[] =3D {
> >> > >+        "nxp,imx8mm-fspi",
> >> > >+        "fsl,imx8mm-mipi-csi",
> >> > >+        "fsl,imx8mm-mipi-dsim"
> >> >
> >> > You could probably just add these nodes to the list in imx8mp-evk.
> >> >
> >> > >+    };
> >> > >+
> >> > >+    for (i =3D 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
> >> > >+        const char *dev_str =3D nodes_to_remove[i];
> >> > >+
> >> > >+        offset =3D fdt_node_offset_by_compatible(fdt, -1, dev_str)=
;
> >> > >+        while (offset >=3D 0) {
> >> > >+            fdt_nop_node(fdt, offset);
> >> > >+            offset =3D fdt_node_offset_by_compatible(fdt, offset, =
dev_str);
> >> > >+        }
> >> > >+    }
> >> > >+
> >> > >+    /* Remove cpu-idle-states property from CPU nodes */
> >> > >+    offset =3D fdt_node_offset_by_compatible(fdt, -1, "arm,cortex-=
a53");
> >> > >+    while (offset >=3D 0) {
> >> > >+        fdt_nop_property(fdt, offset, "cpu-idle-states");
> >> > >+        offset =3D fdt_node_offset_by_compatible(fdt, offset,
> >> > >+ "arm,cortex-
> >> a53");
> >> > >+    }
> >> > >+
> >> > >+    if (kvm_enabled()) {
> >> > >+        /* Use system counter frequency from host CPU to fix time =
in
> guest */
> >> > >+        offset =3D fdt_node_offset_by_compatible(fdt, -1, "arm,arm=
v8-
> timer");
> >> > >+        while (offset >=3D 0) {
> >> > >+            fdt_nop_property(fdt, offset, "clock-frequency");
> >> > >+            offset =3D fdt_node_offset_by_compatible(fdt, offset,
> >> > >+ "arm,armv8-
> >> > timer");
> >> > >+        }
> >> > >+    }
> >> > >+}
> >> > >+
> >> > >+static void imx8mm_evk_init(MachineState *machine) {
> >> > >+    static struct arm_boot_info boot_info;
> >> > >+    FslImx8mmState *s;
> >> > >+
> >> >
> >> > In this function it might be possible to perform an
> >> > object_dynamic_cast() on the MachineState to check which machine
> >> > was
> >> requested by the user.
> >> > Depending on that one could fill variables with SoC-specific values
> >> > and use them below instead of hardcoded values.
> >> >
> >> > >+    if (machine->ram_size > FSL_IMX8MM_RAM_SIZE_MAX) {
> >> > >+        error_report("RAM size " RAM_ADDR_FMT " above max
> >> > >+ supported
> >> > (%08" PRIx64 ")",
> >> > >+                     machine->ram_size, FSL_IMX8MM_RAM_SIZE_MAX);
> >> > >+        exit(1);
> >> > >+    }
> >> > >+
> >> > >+    boot_info =3D (struct arm_boot_info) {
> >> > >+        .loader_start =3D FSL_IMX8MM_RAM_START,
> >> > >+        .board_id =3D -1,
> >> > >+        .ram_size =3D machine->ram_size,
> >> > >+        .psci_conduit =3D QEMU_PSCI_CONDUIT_SMC,
> >> > >+        .modify_dtb =3D imx8mm_evk_modify_dtb,
> >> > >+    };
> >> > >+
> >> > >+    s =3D FSL_IMX8MM(object_new(TYPE_FSL_IMX8MM));
> >> > >+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
> >> > >+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
> >> > >+
> >> > >+    memory_region_add_subregion(get_system_memory(),
> >> > FSL_IMX8MM_RAM_START,
> >> > >+                                machine->ram);
> >> > >+
> >> > >+    if (!qtest_enabled()) {
> >> > >+        arm_load_kernel(&s->cpu[0], machine, &boot_info);
> >> > >+    }
> >> > >+}
> >> > >+
> >> > >+static const char *imx8mm_evk_get_default_cpu_type(const
> >> > >+MachineState
> >> > >+*ms) {
> >> > >+    if (kvm_enabled()) {
> >> > >+        return ARM_CPU_TYPE_NAME("host");
> >> > >+    }
> >> > >+
> >> > >+    return ARM_CPU_TYPE_NAME("cortex-a53"); }
> >> >
> >> > The code below might just be able to copied over to imx8mp-evk.c.
> >> >
> >> > Does such consolidation work?
> >> >
> >> > Best regards,
> >> > Bernhard
> >> >
> >> > >+
> >> > >+static void imx8mm_evk_machine_init(MachineClass *mc) {
> >> > >+    mc->desc =3D "NXP i.MX 8MM EVK Board";
> >> > >+    mc->init =3D imx8mm_evk_init;
> >> > >+    mc->max_cpus =3D FSL_IMX8MM_NUM_CPUS;
> >> > >+    mc->default_ram_id =3D "imx8mm-evk.ram";
> >> > >+    mc->get_default_cpu_type =3D imx8mm_evk_get_default_cpu_type; =
}
> >> > >+
> >> > >+DEFINE_MACHINE_AARCH64("imx8mm-evk",
> >> imx8mm_evk_machine_init)
> >> > >diff --git a/hw/arm/meson.build b/hw/arm/meson.build index
> >> > >aeaf654790..12ecb824cc 100644
> >> > >--- a/hw/arm/meson.build
> >> > >+++ b/hw/arm/meson.build
> >> > >@@ -84,6 +84,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE',
> >> > if_true:
> >> > >files('armsse.c'))
> >> > > arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true:
> >> > >files('fsl-imx7.c', 'mcimx7d-sabre.c'))
> >> > > arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true:
> >> > >files('fsl-imx8mp.c'))
> >> > > arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true:
> >> > >files('imx8mp-evk.c'))
> >> > >+arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM', if_true:
> >> > >+files('fsl-imx8mm.c'))
> >> > >+arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM_EVK', if_true:
> >> > >+files('imx8mm-evk.c'))
> >> > > arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true:
> >> > >files('smmuv3.c'))
> >> > > arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true:
> >> > >files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
> >> > > arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true:
> >> > >files('nrf51_soc.c')) diff --git a/include/hw/arm/fsl-imx8mm.h
> >> > >b/include/hw/arm/fsl-imx8mm.h new file mode 100644 index
> >> > >0000000000..133f519b7c
> >> > >--- /dev/null
> >> > >+++ b/include/hw/arm/fsl-imx8mm.h
> >> > >@@ -0,0 +1,157 @@
> >> > >+/*
> >> > >+ * i.MX 8MM SoC Definitions
> >> > >+ *
> >> > >+ * Copyright (c) 2025, NXP Semiconductors
> >> > >+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >> > >+ *
> >> > >+ * SPDX-License-Identifier: GPL-2.0-or-later  */
> >> > >+
> >> > >+#ifndef FSL_IMX8MM_H
> >> > >+#define FSL_IMX8MM_H
> >> > >+
> >> > >+#include "cpu.h"
> >> > >+#include "hw/char/imx_serial.h"
> >> > >+#include "hw/intc/arm_gicv3_common.h"
> >> > >+#include "qom/object.h"
> >> > >+#include "qemu/units.h"
> >> > >+
> >> > >+#define TYPE_FSL_IMX8MM "fsl-imx8mm"
> >> > >+OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mmState, FSL_IMX8MM)
> >> > >+
> >> > >+#define FSL_IMX8MM_RAM_START        0x40000000
> >> > >+#define FSL_IMX8MM_RAM_SIZE_MAX     (4 * GiB)
> >> > >+
> >> > >+enum FslImx8mmConfiguration {
> >> > >+    FSL_IMX8MM_NUM_CPUS         =3D 4,
> >> > >+    FSL_IMX8MM_NUM_IRQS         =3D 128,
> >> > >+    FSL_IMX8MM_NUM_UARTS        =3D 4,
> >> > >+};
> >> > >+
> >> > >+struct FslImx8mmState {
> >> > >+    SysBusDevice   parent_obj;
> >> > >+
> >> > >+    ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
> >> > >+    GICv3State         gic;
> >> > >+    IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
> >> > >+};
> >> > >+
> >> > >+enum FslImx8mmMemoryRegions {
> >> > >+    FSL_IMX8MM_A53_DAP,
> >> > >+    FSL_IMX8MM_AIPS1_CONFIGURATION,
> >> > >+    FSL_IMX8MM_AIPS2_CONFIGURATION,
> >> > >+    FSL_IMX8MM_AIPS3_CONFIGURATION,
> >> > >+    FSL_IMX8MM_AIPS4_CONFIGURATION,
> >> > >+    FSL_IMX8MM_ANA_OSC,
> >> > >+    FSL_IMX8MM_ANA_PLL,
> >> > >+    FSL_IMX8MM_ANA_TSENSOR,
> >> > >+    FSL_IMX8MM_APBH_DMA,
> >> > >+    FSL_IMX8MM_BOOT_ROM,
> >> > >+    FSL_IMX8MM_BOOT_ROM_PROTECTED,
> >> > >+    FSL_IMX8MM_CAAM,
> >> > >+    FSL_IMX8MM_CAAM_MEM,
> >> > >+    FSL_IMX8MM_CCM,
> >> > >+    FSL_IMX8MM_CSU,
> >> > >+    FSL_IMX8MM_DDR_CTL,
> >> > >+    FSL_IMX8MM_DDR_PERF_MON,
> >> > >+    FSL_IMX8MM_DDR_PHY,
> >> > >+    FSL_IMX8MM_DDR_PHY_BROADCAST,
> >> > >+    FSL_IMX8MM_ECSPI1,
> >> > >+    FSL_IMX8MM_ECSPI2,
> >> > >+    FSL_IMX8MM_ECSPI3,
> >> > >+    FSL_IMX8MM_ENET1,
> >> > >+    FSL_IMX8MM_GIC_DIST,
> >> > >+    FSL_IMX8MM_GIC_REDIST,
> >> > >+    FSL_IMX8MM_GPC,
> >> > >+    FSL_IMX8MM_GPIO1,
> >> > >+    FSL_IMX8MM_GPIO2,
> >> > >+    FSL_IMX8MM_GPIO3,
> >> > >+    FSL_IMX8MM_GPIO4,
> >> > >+    FSL_IMX8MM_GPIO5,
> >> > >+    FSL_IMX8MM_GPT1,
> >> > >+    FSL_IMX8MM_GPT2,
> >> > >+    FSL_IMX8MM_GPT3,
> >> > >+    FSL_IMX8MM_GPT4,
> >> > >+    FSL_IMX8MM_GPT5,
> >> > >+    FSL_IMX8MM_GPT6,
> >> > >+    FSL_IMX8MM_GPU2D,
> >> > >+    FSL_IMX8MM_I2C1,
> >> > >+    FSL_IMX8MM_I2C2,
> >> > >+    FSL_IMX8MM_I2C3,
> >> > >+    FSL_IMX8MM_I2C4,
> >> > >+    FSL_IMX8MM_INTERCONNECT,
> >> > >+    FSL_IMX8MM_IOMUXC,
> >> > >+    FSL_IMX8MM_IOMUXC_GPR,
> >> > >+    FSL_IMX8MM_MEDIA_BLK_CTL,
> >> > >+    FSL_IMX8MM_LCDIF,
> >> > >+    FSL_IMX8MM_MIPI_CSI,
> >> > >+    FSL_IMX8MM_MIPI_DSI,
> >> > >+    FSL_IMX8MM_MU_A,
> >> > >+    FSL_IMX8MM_MU_B,
> >> > >+    FSL_IMX8MM_OCOTP_CTRL,
> >> > >+    FSL_IMX8MM_OCRAM,
> >> > >+    FSL_IMX8MM_OCRAM_S,
> >> > >+    FSL_IMX8MM_PCIE1,
> >> > >+    FSL_IMX8MM_PCIE1_MEM,
> >> > >+    FSL_IMX8MM_PCIE_PHY1,
> >> > >+    FSL_IMX8MM_PERFMON1,
> >> > >+    FSL_IMX8MM_PERFMON2,
> >> > >+    FSL_IMX8MM_PWM1,
> >> > >+    FSL_IMX8MM_PWM2,
> >> > >+    FSL_IMX8MM_PWM3,
> >> > >+    FSL_IMX8MM_PWM4,
> >> > >+    FSL_IMX8MM_QOSC,
> >> > >+    FSL_IMX8MM_QSPI,
> >> > >+    FSL_IMX8MM_QSPI1_RX_BUFFER,
> >> > >+    FSL_IMX8MM_QSPI1_TX_BUFFER,
> >> > >+    FSL_IMX8MM_QSPI_MEM,
> >> > >+    FSL_IMX8MM_RAM,
> >> > >+    FSL_IMX8MM_RDC,
> >> > >+    FSL_IMX8MM_SAI1,
> >> > >+    FSL_IMX8MM_SAI2,
> >> > >+    FSL_IMX8MM_SAI3,
> >> > >+    FSL_IMX8MM_SAI5,
> >> > >+    FSL_IMX8MM_SAI6,
> >> > >+    FSL_IMX8MM_SDMA1,
> >> > >+    FSL_IMX8MM_SDMA2,
> >> > >+    FSL_IMX8MM_SDMA3,
> >> > >+    FSL_IMX8MM_SEMAPHORE1,
> >> > >+    FSL_IMX8MM_SEMAPHORE2,
> >> > >+    FSL_IMX8MM_SEMAPHORE_HS,
> >> > >+    FSL_IMX8MM_SNVS_HP,
> >> > >+    FSL_IMX8MM_SPBA1,
> >> > >+    FSL_IMX8MM_SRC,
> >> > >+    FSL_IMX8MM_SYSCNT_CMP,
> >> > >+    FSL_IMX8MM_SYSCNT_CTRL,
> >> > >+    FSL_IMX8MM_SYSCNT_RD,
> >> > >+    FSL_IMX8MM_TCM_DTCM,
> >> > >+    FSL_IMX8MM_TCM_ITCM,
> >> > >+    FSL_IMX8MM_TZASC,
> >> > >+    FSL_IMX8MM_UART1,
> >> > >+    FSL_IMX8MM_UART2,
> >> > >+    FSL_IMX8MM_UART3,
> >> > >+    FSL_IMX8MM_UART4,
> >> > >+    FSL_IMX8MM_USB1,
> >> > >+    FSL_IMX8MM_USB2,
> >> > >+    FSL_IMX8MM_USB1_OTG,
> >> > >+    FSL_IMX8MM_USB2_OTG,
> >> > >+    FSL_IMX8MM_USDHC1,
> >> > >+    FSL_IMX8MM_USDHC2,
> >> > >+    FSL_IMX8MM_USDHC3,
> >> > >+    FSL_IMX8MM_VPU,
> >> > >+    FSL_IMX8MM_VPU_BLK_CTRL,
> >> > >+    FSL_IMX8MM_VPU_G1_DECODER,
> >> > >+    FSL_IMX8MM_VPU_G2_DECODER,
> >> > >+    FSL_IMX8MM_WDOG1,
> >> > >+    FSL_IMX8MM_WDOG2,
> >> > >+    FSL_IMX8MM_WDOG3,
> >> > >+};
> >> > >+
> >> > >+enum FslImx8mmIrqs {
> >> > >+    FSL_IMX8MM_UART1_IRQ    =3D 26,
> >> > >+    FSL_IMX8MM_UART2_IRQ    =3D 27,
> >> > >+    FSL_IMX8MM_UART3_IRQ    =3D 28,
> >> > >+    FSL_IMX8MM_UART4_IRQ    =3D 29,
> >> > >+};
> >> > >+
> >> > >+#endif /* FSL_IMX8MM_H */

