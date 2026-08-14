Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B82EC5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 02:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuhWW-00027b-21; Thu, 13 Aug 2026 22:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuhWR-000278-SX; Thu, 13 Aug 2026 22:19:52 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuhWP-00010T-GJ; Thu, 13 Aug 2026 22:19:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQOeuaTZIRNoPbnJD2ldMqbklgiqN/fVlfwEthStzwaOn1NRMygrFPYLB/RFDZxDt41lRPP5mOE/9V9qjNtyTcbHE2qXlRgG5hHXIPHyyPofc4CLhI0Ts01c8qfTp73krpe0wm2JT3YWxvcogYpJhgZYdFyO8TWkWCqqraOaIzzhpJX6UpClCiPXAl82I5PBMe9pVVTrJAmm0L2ki+PQQhNwai9DFP1Tl0KQY1pDEXGBAotbplVxlG9n6f02GCG3Eb/ECmiJtuO7s/b8hNiH8tFtG/VXytjE2fLP6v6yAWQm2Ew2ERhmJt+KbqBDw3gq1AmSpYe/FOOjW3wDppUI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s00CkDQzVCCiwdgCjpOefqM45cd2Cx2LlgUpF5vL95k=;
 b=qxoSSLu4VRqp6dALNG8x6LuEXqWzRaJlY5oxcPKPnVtcfrj5HYhgFPl2aFrRgt2cS8gQwrF5vpBVyPmJaMRDt9rbqzEnswFMrt33oX8+hSml32drdi9KlBvcgUFsZKwpG1vaFRYiqg0iiRCXR1TBPpw0f1dCwf8vJuRvo+MePrGemSNrB5uL/ahJU2m6U7DLP05BcKT/3dxugWp/dR+aNgEJQ5IU3oIK/GXloKH2rEOluV0JE1DUH9M79y4jclaWs4foYeqC8RhczIbQ9I3vk9goNLcTe/WSsXPNBEo8vrNQKRqXds534D7psK0rnY/U/UOk1VA20UpWdnrkBN/AMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s00CkDQzVCCiwdgCjpOefqM45cd2Cx2LlgUpF5vL95k=;
 b=Wb5k8v3dy87qUihAS+419H5ijS74lasBpvVddR/UgK9IQdQit4EUjiPQOURUk9mLHYn7HAW7fwaP/jZnB9RYRGmcVbvQSSGIyZlZk4w8TzbQaxqtfDK06Vby2lI9Wl7nrsjKBb30tkpXQVLPr2Id/9y+p6xDqtkxod5gBMBq0/b92BuQFa4FjCMYbRS34VPRJCmLHDsSJyKP91iHM5WsPkrgtUtNQBl3SmBUtwIOk3Z1fkH5tso1nYUFJ1VSA2IbUoeEkUJWRBUcoipiyPnRtD80471xMReiccbXp0f5edyCvcB76eoukin5MHjlmpUHAhcz7+6RxQrva1XjiaFwsQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB6664.apcprd06.prod.outlook.com (2603:1096:101:176::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 02:19:41 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 02:19:41 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Mikail Sadic <Mikail.Sadic@ibm.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received byte for SMBus
 block reads
Thread-Topic: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received byte for
 SMBus block reads
Thread-Index: AQHdKwJqkWkcyoBADkCDJjjo6H+Egbabrw9ggABuHACAALCYQA==
Date: Fri, 14 Aug 2026 02:19:41 +0000
Message-ID: <TYZPR06MB4980A0D671A8CBDFBAEF0DBAFCDA2@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260813090205.853307-1-jamin_lin@aspeedtech.com>
 <TYZPR06MB49802BFC78FDFB21489FEE83FCDB2@TYZPR06MB4980.apcprd06.prod.outlook.com>
 <SN7PR15MB6138B5314F2E7D110245815E8ADB2@SN7PR15MB6138.namprd15.prod.outlook.com>
In-Reply-To: <SN7PR15MB6138B5314F2E7D110245815E8ADB2@SN7PR15MB6138.namprd15.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB6664:EE_
x-ms-office365-filtering-correlation-id: 958f24ef-2521-468d-7d58-08def9aa7fdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|921020|10067099003|6133799003|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: PVwgiDtpGKmDZoEB80MZMDUBGLaPdSfZL3JdYVl13QAXfQWubVnlZqp3J55RxjbrMeDHEKLQssf6yPtdvu59gJ6w3DCzaGDrTY2hwMpw/0Ye07OLNHitqy1DtAp/GJqOjT/JDlGQ5Xsccu/yLwjWiyagSDnZ1jAa9wbe+HWPXzPj6N1BXxa1c6GXtALQZ7Hcgew8Bvg9S0kmRmTG4naIthDlm6l5uhRV5hyunSWhB3SmFooYtlUKIHhWhdM3ubcapxbSUU6Xf4NaC+RJ2luxb9maunixNQEtRpFnnsBXYEzxyrK3CbAYaMOe6oZanGklHXXZaIKT9H2veCCS4PIdD8s3BGFp8ZtMpVRdlTcQ9B1FEzqqOw7uqaCRpHADirBllFd9idAVDhj6GaK0EQarnaM8ZXU9c9gxPIUsEOMeLwcLr7XTbiA9ctFTXb9MqZdbegebp+MeccH7rpUFRBRIthu+Cp53UxqRZDr1+b4fHhJ8LOVcj2plapg8kQYujWZu9kv5NDGpgRhdGisGofRtMkFSOYgN0WjgAV4vBCZMNZR+798yAnOJCYKLudwC7Zn0VL9q8cGpQKP5cW/dMhRudDe77slaYymdcGOB1y0hmQ1mZYFJpwcNC2XpKUELSZhWspJ9C9a/OFD49kGIEhtkSxcqxLFNzYMWt3/LiL1SyI4U5Ep7o5Br7AsVi0hBvFACmZG2QCArFEUsZh8Q2teAAQ1bqmjBScNgJ5/a6cTc4/PzP29uKcXVn1FW5U371AvQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(921020)(10067099003)(6133799003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xd3MINzNv3TyOWhD6L6O6prVylr1Sn1S4gxoS+o5mXtPQE13Ijad/jgZSG?=
 =?iso-8859-1?Q?/3J2cB1Sf4T+C5zrW/C25XeuOcmEWBsR1BXWhSKTHZSz7t56xnyLq5mokO?=
 =?iso-8859-1?Q?jzKDq44nBGlg5cWlr6/s2qmmf0QYO95HMDS9+WjNYR8icApgG3mcI7bSFd?=
 =?iso-8859-1?Q?cONUUXyjCctjVERw8W+z6kI+IxrIwHAPlVVGmUiNJVbJPi5pJkOc6d+E2A?=
 =?iso-8859-1?Q?fg+Ex6uW8JQTpPOweI0ttoWCCsw8Egwn5gGCcQJyCxzSfyMLj+T59ZcbOy?=
 =?iso-8859-1?Q?+I0FJNa7appoXInMr91lAJF0yTnGOYlzxf615TfCq25hxgxxN5M1OakiI8?=
 =?iso-8859-1?Q?ngKyuao/yPgVJS9sMfouYBgnzA4GWh9vSdc4jMZuWxXfQfu3X33erZ3RbS?=
 =?iso-8859-1?Q?jp7gKcFAW0YsBNe7GCBqX/xLbSod9BGl3QuRdHaMMLG5R7QcIr5jCp6hk7?=
 =?iso-8859-1?Q?tN02JbxDGt3dQcgsN7qpM7jbBdWTBMXLnLjY6thu4pWca/VsQS0illSYfk?=
 =?iso-8859-1?Q?HtlqIrWZHT3BiAdpBFVxm8Za5q1zPu/siyDpjySMYp699aanCkdYe9NyJb?=
 =?iso-8859-1?Q?OGM6w0jGerL2+YY6lzAPQKP1ELcHc/UynxSot2ZBc4ktlZR8UcwFtXE977?=
 =?iso-8859-1?Q?kb8XwCYg83+1zx/UC8Fa2wwTklEC/IrerECES7zm23DDNMK9KkSNzXz/BT?=
 =?iso-8859-1?Q?zBDJqsRwXh+JqNiBZnxINVuXiV87dhiCZe/exDNPzLVLl5JRyiBAGJCKnd?=
 =?iso-8859-1?Q?xkYfMZ+x2v8A11UjhK153zP+WTD0xyg/B2hwCe+HmVMO8EAncnCtTdIU/0?=
 =?iso-8859-1?Q?iT8x98Oq97zscb7ab/2SFlsz/TYoxDsuQ+QQIWVxTSxlJTrtPXlUttNLLX?=
 =?iso-8859-1?Q?FIwxsZxDrR5k7t5HpWP481rFoMLN81hny53xD8mFiBBXxtlHNUZd8v8nuD?=
 =?iso-8859-1?Q?VdtZIyRY4y8rtiDn+Kjc2C1rxAydbCFeyhO9Cuphx3ouqAKnCw7BggQnZu?=
 =?iso-8859-1?Q?9bk7c4J18JtUa5TbwkwPvv/Utma85UXMSWdaOYOeuRVBP4cMAWL23SqU9V?=
 =?iso-8859-1?Q?d5VvXIOf1Ovvo/4QWs/nkD7BEwgPJiOD1k3AiZ+gaxELzhX2uzelTwQfs8?=
 =?iso-8859-1?Q?RWvFxfrBKuNuibUuG1Ua036QVZSlwLqffBZltLigDfGQ53Xu8dtfiQkRqO?=
 =?iso-8859-1?Q?swsn5uXDaJcgC3S9q139MO1ZnCzR/R0IqrAME0QZ/J+FmHFdnjoRZN69MN?=
 =?iso-8859-1?Q?9Ibq7bS25enQbo86S+UxaFfZANnrZ0ZWdoIA2wXlFnYtHiFi8oQ5qN3qiD?=
 =?iso-8859-1?Q?hOPznjh8ZyIgAZ91k8qs10dIMsgPoFGxKBIOlnjeaJdkZVLboljhY7K5n5?=
 =?iso-8859-1?Q?GGiyBwVJu3hJRNN4BX2GJiTK0uAtvLgqze2vedARtmWR8Sh5I3u3m3DKPn?=
 =?iso-8859-1?Q?0tP+oUJUzClUwty5B98i5KUOlAx+VvCLaXhY1RxdfZWSh6R8D08hDcyH+7?=
 =?iso-8859-1?Q?48uxsujSsPkcC993SKpG2UAAghPRFkbJ0ei4VcxRUiasuS8zlg2RIxofKN?=
 =?iso-8859-1?Q?2Y74sh4v/ipdTL+YYAq3wCbvCcl3wHG50bzlosrmwjNemEOxwCjg75shKE?=
 =?iso-8859-1?Q?JAfPMj9iyNJvp2ecj3Avl+UEYZLmrDAR3eJB/1L45VMvkGJZBlKXt0TPne?=
 =?iso-8859-1?Q?4nCeIKFANTs9wgiwN+iPZBpL3wUZpUMuA9FauAn7qn5vKtuQi1ehJHlGzn?=
 =?iso-8859-1?Q?zOKQhX5wUVbcnpogy6rGyMDweO6YQJad1pbBwiMllrwCpho+ob0sH4pKav?=
 =?iso-8859-1?Q?CotcI/wgTA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZTbilbsnhK9S0X9yRlrd7eEoXW6QTsP2wVUrDQwzSuz5vXwYTYE7t1UXzcI+3O8rzc/WAN752sBOuysW/nbOZxTIEtuwMBdPK4xv4kiBSKuEAdNYZmBMFauM0SXzk1RfYMN/Uv9rg9E+Pqme09WrgEUniv8xgKKXQzaxwI9Irxl6Yt8+LoTMs49J16nex7o2wNMWOFFTtZWQ22EUxSKLHgCz9tVAuwsmdQUsOZNt9l1TOvCIVoXJphG291NjpUHFaIcnRp6ywDCoA8XAKMcJwhmFlbWuGp3Phw0UtDaMUrenJ7weft9txPS46TU+0Sl0I9SxKyUx0s5Dux/gz7YHEQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958f24ef-2521-468d-7d58-08def9aa7fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 02:19:41.7801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F5GrP0Lvcf0Oqe3JgrX0q+3LmrKmWOq5kxy2XAE0At6iumz0yBYPaC6ToVJHMj+4OT0Q5vrRAyMJGmqMG0hKnC251K/9K9X7xT9q+Bx52XQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6664
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> Subject: RE: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received byte for =
SMBus
> block reads
>=20
> Hi Jamin,
>=20
> Tested-by: Mikail Sadic <mikail.sadic@ibm.com>
>=20
> I verified that this (along with the AST2700 buffer mode patch and the ke=
rnel
> fix you referenced) works with the UCD9000 driver, thank you for the help=
!
> I am dropping my patch and depending on yours.
>=20
>=20
> I just have two things I'd like to ask about (not blocking for my purpose=
s, may
> be worth to check):
>=20
> 1. Byte mode is not latched. I think the else branch of aspeed_i2c_bus_re=
cv()
> still only writes the receive byte buffer, so 0x84 goes stale there. This=
 may
> cause problems down the line, specifically for AST1040?
>=20
> 2. I believe dma_buf_en reads like the FUNC_CFG_DMA_EN bit, but the
> DMA-to-pool call passes true while that bit is clear, clearing it is what=
 selects
> the pool. Getting it from RX_DMA_EN inside the helper may stop someone
> from accidentally "fixing" it to match the name and breaking the AST2600
> case.
>=20
Hi Mikail,

Thanks for the suggestion.

Both points are addressed in v2:

1. Byte mode now latches as well.
2. dma_buf_en is gone; the helper reads RX_DMA_EN directly, as you suggeste=
d.

I resend v2 here,
https://patchwork.kernel.org/project/qemu-devel/patch/20260814020836.311961=
3-1-jamin_lin@aspeedtech.com/

Thanks,
Jamin
>=20
> Thanks again for picking this up and catching the original problem.
>=20
> - Mikail Sadic
>=20
>=20
> -----Original Message-----
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> Sent: Thursday, August 13, 2026 4:08 AM
> To: C=E9dric Le Goater <clg@kaod.org>; Peter Maydell
> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>; Troy
> Lee <leetroy@gmail.com>; Kane Chen <kane_chen@aspeedtech.com>;
> Andrew Jeffery <andrew@codeconstruct.com.au>; Joel Stanley
> <joel@jms.id.au>; open list:ASPEED BMCs <qemu-arm@nongnu.org>; open
> list:All patches CC here <qemu-devel@nongnu.org>
> Cc: Troy Lee <troy_lee@aspeedtech.com>; Mikail Sadic
> <Mikail.Sadic@ibm.com>
> Subject: [EXTERNAL] RE: [PATCH v1] hw/i2c/aspeed_i2c: Latch first receive=
d
> byte for SMBus block reads
>=20
> Hi Mikail,
>=20
> Could you please review this patch and verify that it works with the UCD9=
000
> driver?
>=20
> Thanks,
> Jamin
>=20
> > -----Original Message-----
> > From: Jamin Lin <jamin_lin@aspeedtech.com>
> > Sent: Thursday, August 13, 2026 5:02 PM
> > To: C=E9dric Le Goater <clg@kaod.org>; Peter Maydell
> > <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>;
> > Troy Lee <leetroy@gmail.com>; Kane Chen <kane_chen@aspeedtech.com>;
> > Andrew Jeffery <andrew@codeconstruct.com.au>; Joel Stanley
> > <joel@jms.id.au>; open list:ASPEED BMCs <qemu-arm@nongnu.org>; open
> > list:All patches CC here <qemu-devel@nongnu.org>
> > Cc: Jamin Lin <jamin_lin@aspeedtech.com>; Troy Lee
> > <troy_lee@aspeedtech.com>; Mikail.Sadic@ibm.com
> > Subject: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received byte for
> > SMBus block reads
> >
> > An SMBus block read takes the block length from the first byte of the
> > transfer, and firmware reads that byte back from a register rather
> > than from the transfer buffer. The receive paths never updated those
> > registers, so block reads reported a bogus length.
> >
> > On AST2600 the driver reads the length from the receive byte buffer,
> > I2CC_MS_TXRX_BYTE_BUF[15:8]. The datasheet documents that field as
> > valid while the DMA buffer is not enabled. The byte mode receive path
> > already updated it, but the pool buffer path did not, and the driver
> > selects buffer mode by default.
> >
> > On AST2700 the driver reads the length from offset 0x84 instead.
> >
> > Add I2CC_BYTE_DATA_LOG at 0x84. Latch the first received byte from the
> > three receive paths: the pool buffer path, the DMA-to-pool path and
> > the DMA-to-DRAM path. Each latch updates the byte data log, and
> > updates the receive byte buffer as well while the DMA buffer is not
> > enabled. The byte data log is outside the register window of the
> > earlier SoCs, so it is only visible on AST2700/AST1040.
> >
> > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > ---
> >  hw/i2c/aspeed_i2c.c         | 31 ++++++++++++++++++++++++++++++-
> >  include/hw/i2c/aspeed_i2c.h |  2 ++
> >  2 files changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c index
> > 68bdcd0e25..e6d0eee816 100644
> > --- a/hw/i2c/aspeed_i2c.c
> > +++ b/hw/i2c/aspeed_i2c.c
> > @@ -159,6 +159,7 @@ static uint64_t
> > aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
> >      case A_I2CS_INTR_CTRL:
> >      case A_I2CS_DMA_LEN_STS:
> >      case A_I2CS_INTR_STS:
> > +    case A_I2CC_BYTE_DATA_LOG:
> >      case A_I2CC_VERSION_CTRL:
> >          value =3D bus->regs[offset / sizeof(*bus->regs)];
> >          break;
> > @@ -334,6 +335,24 @@ static int
> > aspeed_i2c_bus_send_dma_pool(AspeedI2CBus *bus)
> >      return ret;
> >  }
> >
> > +/*
> > + * Latch the first received byte, which firmware reads back as the
> > +SMBus block
> > + * length. AST2600 reads it from the receive byte buffer, only valid
> > +while the
> > + * DMA buffer is disabled; AST2700 reads it from the byte data log, a
> > +register
> > + * the earlier SoCs do not expose.
> > + */
> > +static void aspeed_i2c_bus_latch_rx_len(AspeedI2CBus *bus, bool
> > dma_buf_en,
> > +                                        uint8_t data) {
> > +    uint32_t reg_byte_buf =3D aspeed_i2c_bus_byte_buf_offset(bus);
> > +
> > +    ARRAY_FIELD_DP32(bus->regs, I2CC_BYTE_DATA_LOG, RX_BUF, data);
> > +
> > +    if (!dma_buf_en) {
> > +        SHARED_ARRAY_FIELD_DP32(bus->regs, reg_byte_buf, RX_BUF,
> > data);
> > +    }
> > +}
> > +
> >  static void aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *bus)  {
> >      AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);
> > @@ -349,6 +368,9 @@ static void
> > aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *bus)
> >          pool_base[offset + i] =3D i2c_recv(bus->bus);
> >          trace_aspeed_i2c_bus_recv("BUFF", i + 1,
> bus->regs[reg_dma_len],
> >                                    pool_base[offset + i]);
> > +        if (i =3D=3D 0) {
> > +            aspeed_i2c_bus_latch_rx_len(bus, true, pool_base[offset]);
> > +        }
> >          bus->regs[reg_dma_len]--;
> >          ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, i +
> 1);
> >      }
> > @@ -443,6 +465,9 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
> >              pool_base[i] =3D i2c_recv(bus->bus);
> >              trace_aspeed_i2c_bus_recv("BUF", i + 1, pool_rx_count,
> >                                        pool_base[i]);
> > +            if (i =3D=3D 0) {
> > +                aspeed_i2c_bus_latch_rx_len(bus, false, pool_base[0]);
> > +            }
> >          }
> >
> >          /* Update RX count */
> > @@ -460,7 +485,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
> >          }
> >
> >          aspeed_i2c_set_rx_dma_dram_offset(bus);
> > -        while (bus->regs[reg_dma_len]) {
> > +        for (i =3D 0; bus->regs[reg_dma_len]; i++) {
> >              MemTxResult result;
> >
> >              data =3D i2c_recv(bus->bus); @@ -476,6 +501,10 @@ static
> > void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
> >                  return;
> >              }
> >
> > +            if (i =3D=3D 0) {
> > +                aspeed_i2c_bus_latch_rx_len(bus, true, data);
> > +            }
> > +
> >              bus->dma_dram_offset++;
> >              bus->regs[reg_dma_len]--;
> >              /* In new mode, keep track of how many bytes we RXed */
> > diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> > index 05937a7a0b..c8e6ea54ad 100644
> > --- a/include/hw/i2c/aspeed_i2c.h
> > +++ b/include/hw/i2c/aspeed_i2c.h
> > @@ -231,6 +231,8 @@ REG32(I2CS_DMA_TX_ADDR_HI, 0x68)
> >      FIELD(I2CS_DMA_TX_ADDR_HI, ADDR_HI, 0, 7)
> > REG32(I2CS_DMA_RX_ADDR_HI, 0x6c)
> >      FIELD(I2CS_DMA_RX_ADDR_HI, ADDR_HI, 0, 7)
> > +REG32(I2CC_BYTE_DATA_LOG, 0x84)
> > +    FIELD(I2CC_BYTE_DATA_LOG, RX_BUF, 0, 8)
> >  REG32(I2CC_VERSION_CTRL, 0x94)
> >      FIELD(I2CC_VERSION_CTRL, FUNC_CFG_DMA_EN, 2, 1)
> >
> > --
> > 2.53.0

