Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA22D172B0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 07:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmobH-0001Vm-Jb; Mon, 02 Feb 2026 02:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vmobF-0001VP-R4
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 02:43:57 -0500
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vmobC-0004Qq-AS
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 02:43:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSW2p3ydIUqoW8co7LW7j+9hufjjGK5WK3UKs/NTmKEDZCKC1BFD+G/yeFupeQVogyY7P7HFDmVmTQDqseOIMws7azjGL912W0Teo9G3O0wH6iWKMOXg43Wf8MN2zbzyWZLIW9Z3XeW5d3Z4gIzsQVYqY8IdVDKY7iDvIn+tccjEveMRDpSgpgIh2A87/9UZAjaRGcllarE8vVsAQWNJqPNk/BjHJysT9GiJ5GiDt4ogxamzLUMWj0w/DE6V8BKh6akKUaY+ESADNCSQRUHj3Ym2xmGvIWsBO924ltkEPV6znemcjXmlTfgOrGXfnU4j/LdFbuUvThMICdW/Uwd51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exrbctpGKIc1HOzQgEVvknJrhS4HA0Rflmo/etrXFVM=;
 b=X7zAlq47Y1FSYGmyUWwRKMnPdBZl4rNObJc5EeZ4/j4QF5CEPZWcssmoBDeWf2l+ozYq70F8x6N2G09J6LynM2qYz/Pe5tNqD2NkVTUv0GV4I8gTXLBLxo6/wHJLov+d6t5P68CWRnw4mXsCHXH+DYGdwFiQfssn/X3rzYbyzln955povcd75bbqjDEHdjF1YU/Y6k3dCsydHx5OpBCTD8b/ZnAPg344ixFjmTROgqQqOf8w89d0tuD7ojUrJ6WpMSkWoZQQiBGnozyA+g5lgf5e9PsMcGmaFXPBiKPXOcRFwHzGm7bgV7dM3Ci+yd7Do1a184xfgDE0oeVWLExp5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exrbctpGKIc1HOzQgEVvknJrhS4HA0Rflmo/etrXFVM=;
 b=RnJjFgL/EMGCxldoN+q/hG77qFtBEPxpz7WW5D0n8ZCGBxlLzf6By13ee8dplAe+6SZgOVdFpAY3iCDDtNyEPzCCQeRw2MYC71gf8j0CS+DUS9NTwtCbA86Ag6xhDBLCbC7UigmgPwZRpCBdROHcoz6CwK7YYTPQWsQ9sONkadS6X49LCl9NnndFvw9fI/qloGvA0168L91e9hKqLf933uEHbihmUt0CgdFha6w7iZ8fkWMc7PECqM3naGMDPLCdOXLlDkHb5ogTWOcIv8G7zxYDRH72s9VtJSO7pNu2haitpPTalghw7F6h+bfrvu/txw44zExca1qsancjW6T2Yg==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by AM7PR04MB7077.eurprd04.prod.outlook.com (2603:10a6:20b:11c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 07:43:50 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 07:43:50 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCHv4 01/15] hw/arm: Add the i.MX 8MM EVK(Evaluation
 Kit) board
Thread-Topic: [EXT] Re: [PATCHv4 01/15] hw/arm: Add the i.MX 8MM
 EVK(Evaluation Kit) board
Thread-Index: AQHcZalfx1wWExJ35kiD6NPzwhPS7LVOkXuAgCDRzGA=
Date: Mon, 2 Feb 2026 07:43:50 +0000
Message-ID: <AM9PR04MB84877B347C79D69D43EEDD7E879AA@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
 <20251205053819.2021772-2-gaurav.sharma_7@nxp.com>
 <61D6819C-96C4-4C7D-87CF-378F76E85C2A@gmail.com>
In-Reply-To: <61D6819C-96C4-4C7D-87CF-378F76E85C2A@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|AM7PR04MB7077:EE_
x-ms-office365-filtering-correlation-id: e92c57ab-dc22-4c97-f6cd-08de622ece6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?a/WTLq83wxesBsp8yqWZO7KdcVHMZraAnF1EY6mpxaQxlgehpMX/gEOY0kA6?=
 =?us-ascii?Q?04AtYCwsdRakEez1uXxXp0YCkxgU6xN3Ox6Q98/z4Dj7pv3jleMpv8ri6mz4?=
 =?us-ascii?Q?ddH+pzdaqCHrYGIUQGF14v6MohA25338EM+8j0B0+saEi6ym8PhE3OIJSaXh?=
 =?us-ascii?Q?UwCIKWWuJNxNQnJBqUs7fx1COKWxcMzcpd9uiNnqAuFpPhUDuavKuJZ7Mo5p?=
 =?us-ascii?Q?BAt7te+MQJiInA7kRWwnFVTW4DiK4RaVN7Zs/QDD9sBQ04vqT0JKFn26A1Pq?=
 =?us-ascii?Q?4o70ReozcA72sZceY5PUS+m4Me29cbC0IFABn5eO9L5WhP6jUTWyEuY0vCP9?=
 =?us-ascii?Q?PnNAoq+alyJz1vkzIdrcz17Qfwl+iPAqMSfXiVPocFYPkE7Zzr5q+YDN1uFk?=
 =?us-ascii?Q?XVDGK3R8h7zn8jRD+rgmQ4dSgraJ4BnsXS+VCa8KCfdDNpZHJx1bwRSyExnW?=
 =?us-ascii?Q?OclEXLL4UK5jWvh2UHU1hW29d5iCKa5uaUzzFomF3YaoLjglBJULtqT2prjc?=
 =?us-ascii?Q?Ku3q48M4CWt5waRSZXzGmqCGFzZ+QmeEhsoKd8KNopKbynacbxRJPE8g24GL?=
 =?us-ascii?Q?Fs20Cr2mLdo9t0ZOIrJHfS8U8kYi+Y8HpuPcbS1Kkpvj5nmj/7Lm9vyzi9Bw?=
 =?us-ascii?Q?VMjFovB5E5biLdSs98jAuMu9m5uTZajjCrWqKt8xrMsMLRzj/wjao7ToA4+T?=
 =?us-ascii?Q?mNxk5C7sGiktUqbWpwM13Zp4hJA4Y3WI+Pfi9qIFS6IDT+16sL33ty7ESqkh?=
 =?us-ascii?Q?6YRJVtLIi13VJ8BzqUBBlr/dti0yNxNMLtBNUCqGPsl7lEhRIUG1DHQW+dON?=
 =?us-ascii?Q?b1jLPGv9EeLDSOiZd9Oiy7ECRQ7RS59USJuTuebRRWRnql0ZNdgEfuWQqkrX?=
 =?us-ascii?Q?4+HGZaQ4ow9q19AzfS5dAtR1kjCTobaPxCTa9sH5YB0e85pV3ByUhpV6Y0nc?=
 =?us-ascii?Q?ZH1IZhFb43pb3MfltPVjytSxmVL1pdBQZ+rTvIFhlJ66o55U0wozdhUQzuFh?=
 =?us-ascii?Q?McQL26Xw0yUnrMXZWy1s8SDqdn8LJK38y4xzjjWp0K9FV2QBsA20EgOSVTA4?=
 =?us-ascii?Q?MR5LyC9DmZ9nErflKYRYpuHL2+COxE587zvAPaDRg1YE5U4XfS4W+II2OkxH?=
 =?us-ascii?Q?Y0IrJQk0VqGOpOoJjUaXET5WYxVgakha8UO4jYH4bz30zx14HR/KFjLs45Z0?=
 =?us-ascii?Q?EJnyZC5DCjRYJjN0H3m2LP9VJnsQ44HvmmGuQ8g3GVssDf+Ra7F4JSAijYm9?=
 =?us-ascii?Q?JTVRr/XxYucW5WQgz9QJiCvZNQj/g6JtDV9mUAnlhmXOCi9FbttPNZvqUP5F?=
 =?us-ascii?Q?6M2m2Z1CooFOPCWbgmUVFomllDP7Aaap4VBgQUnbbiQMNpuveoYSMeb5mLT3?=
 =?us-ascii?Q?d6qG57Uz2+wihNJuNNQbWXjf4kN06sy67iYgZO6oBVOLtiDLXpxwgvPD10Yu?=
 =?us-ascii?Q?he3R6PuSMdGuRdj+gCSXEbdYlrE9JHORe3ftiv5c23Xc6mBFhZrvV7WS08Cg?=
 =?us-ascii?Q?uyMTevj4MevpUqfpaTE2ZgloK0UHgkd2lZ8SePgnyF2B3897V28GgFpclekA?=
 =?us-ascii?Q?qr64F+/chWyYlo/JTxO0il5z4qwOu3TauO05ay8swPbkUr1TxGEbd/ezFvJl?=
 =?us-ascii?Q?mn3UFwo0/UuaqtM2aCfFeaw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/CGvoskGGfa9oMlaM03IxE1NtPbgYXROZraQq6iFXpJuZKdkzaccuqZz9KwF?=
 =?us-ascii?Q?iGjRb3IXA0T5jBczkwD0oaadY9s90/ZRR9hL11AU3svJzFHGdTP8VDvFxqo4?=
 =?us-ascii?Q?2oeKNIbLdj0aO0PPp5XwnJl8IYWcwv4QQWWoT+9rYS4wZaU/yq4sVQU9zwbN?=
 =?us-ascii?Q?Jj3qrBd/FQF54lcG4btVsNA5XWLMSwk4cpHhm0JM2hFQ7RxM6kb1eaiDJ3Nx?=
 =?us-ascii?Q?xcNi7mXNg2vB5nIhZVqV5Zu7/78q4b0iDDiiLvoYUQ5eVCB2v/w5A5WEX1RW?=
 =?us-ascii?Q?UFCkvyeM42ICi57rvvPJBALjIumH+yVFcqp+j7k/ClHvYLyYTElYH3r6I7qi?=
 =?us-ascii?Q?QQHN3zK4g41sv95RWhxbyFwb2d5MU7QN6Ao3khKFZU7BlHguUXGLEi2yF1tE?=
 =?us-ascii?Q?YVE9+03HBbP4ZRY7vn4YMYir0OUwe/CVGTCuch9PJuiH/lcYIwMDtKOReGWN?=
 =?us-ascii?Q?Jsz7XDO0jRg4vNEuWTlA60815K9IrZz+0C6LZJmd64M/0GU2OGDbUjGJbSLG?=
 =?us-ascii?Q?J/lZAEiP+uSBq+03LFv8KqxoznbXgNm4XfmNHpNzHP7buvrazgi3kw9oLtAJ?=
 =?us-ascii?Q?VZW/kBT4+1fxqnSWa4rhsDIqrBindE26X00Qylwz/K2uZ7jjiMkHbEreg49D?=
 =?us-ascii?Q?vKDNU7zUtPUYxp9WrER08BGNDW83jlQLCKlj8rpXURI27OUDf3p8eOKCXg2e?=
 =?us-ascii?Q?4hDS0IJKQyiliVK9VUbP7n/HhrjC81jiisg0l7BDOrWxLfNaBgeWIotb4pHY?=
 =?us-ascii?Q?PLEJFRyCU1E9nmr5CooyMUX1p0+sEZJVEo2v43w/11rMgIWAtTgxCdxq0vmC?=
 =?us-ascii?Q?06YupY++90aPqafHSap6dGHwWpvhku/OdtUGW/Rwa1js714YC9gZzALbd2dF?=
 =?us-ascii?Q?7SjkIMLcBhNpvzOnBmabITTm/uFAYGm87IDtng9ylXrCvQcF4L2MxUJIcvEn?=
 =?us-ascii?Q?xZLwByZkO5BCDJmRKuR5N1knqyQGhpc27wKGVweEhw95Jxk7l4gXFBHfeDCs?=
 =?us-ascii?Q?T7nz3ByW8fJtGvgKbqxSk//EL+L3XL3eRWNA3/TkP/xVQhts0GW6a6Rzcxsl?=
 =?us-ascii?Q?4tSbzx6WPFcr+V6VK/gXSRKoyGL1d9DtSQrNFk9RISSq+IGlIoTAqIrJ88Nd?=
 =?us-ascii?Q?WFhUeZpeAtn4kxQobsyZbcSgMZyKxetzITs4p+/iFfSXaRVoyBEku0Yf6AQ0?=
 =?us-ascii?Q?vwdtEN23xgKraXaExg/ZQTUiBtpdX13KeREMN/aIuNwLzU2noaqGcAi2qBSZ?=
 =?us-ascii?Q?YSP7L8DQXrL7XwICd56XZHcEY19ZaQcnl3GEVs9dUQn8fklXDniTXzky6uVQ?=
 =?us-ascii?Q?zIHJ406tOMHHjRI7GpJXysiQGfHEmAs/l3lb1aOoVrksKgAKFENKF47ZKOsz?=
 =?us-ascii?Q?E3J0n06axp5BQH6XCJDg3ZVUI9ll4cCOz0eG717iz+5dSpX+A/+1zw1ojCI8?=
 =?us-ascii?Q?P3JjBE07WiUxGJmCJcf4dVxhhnzsF5pyJvbd2xQxituUiHA0+X+3NDkoajHg?=
 =?us-ascii?Q?efiyV9ASYVYIQ7dNjq3d4x9wfpwwgnMZG4pjg7WaGYDItgw5SWBj1NQZncTq?=
 =?us-ascii?Q?IqbNuHfnRHLm2g0Uiimfbc2jcFQ3NbC3wqdwqfPG1DROSf4fE4/Nn8iVykXM?=
 =?us-ascii?Q?isKdjIsZZaoRtw+T8rBY08FI2tO/TF4cACxxSTAR+VL+0I0Yi2awK24AoqbQ?=
 =?us-ascii?Q?PNMtITzidSJV0Ti/FnevxophuJQbWsqkOOOAfTPA3kkhe9cR1cddhlo5IxeS?=
 =?us-ascii?Q?sz91FiMpiQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92c57ab-dc22-4c97-f6cd-08de622ece6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 07:43:50.4445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 290kXc+7OMLSQNPmxFFwGT04if0ohZ3e8npRgstolSXyRCBQEPj1c2F92e2EXFxpR7HufiDhy1CeBsmWUwT7Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7077
Received-SPF: permerror client-ip=2a01:111:f403:c20f::7;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=0.979,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Hey Bernhard,

Consolidating changes for imx8mp and imx8mm makes sense as it will reduce t=
he code footprint in the repo. However, is it possible that we take it up a=
s part of follow-up patches once the emulation support for 8MM gets mainlin=
ed? If that sounds ok to you.

> -----Original Message-----
> From: Bernhard Beschow <shentey@gmail.com>
> Sent: 12 January 2026 16:00
> To: qemu-devel@nongnu.org; Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> Subject: [EXT] Re: [PATCHv4 01/15] hw/arm: Add the i.MX 8MM
> EVK(Evaluation Kit) board
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Am 5. Dezember 2025 05:38:05 UTC schrieb Gaurav Sharma
> <gaurav.sharma_7@nxp.com>:
> >Implemented CPUs, RAM, UARTs and Interrupt Controller Other peripherals
> >are represented as TYPE_UNIMPLEMENTED_DEVICE Complete memory map
> of the
> >SoC is provided.
> >
> >Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >---
> > MAINTAINERS                    |  10 +
> > docs/system/arm/imx8mm-evk.rst |  68 ++++++
> > docs/system/target-arm.rst     |   1 +
> > hw/arm/Kconfig                 |  12 ++
> > hw/arm/fsl-imx8mm.c            | 366 +++++++++++++++++++++++++++++++++
> > hw/arm/imx8mm-evk.c            | 110 ++++++++++
> > hw/arm/meson.build             |   2 +
> > include/hw/arm/fsl-imx8mm.h    | 157 ++++++++++++++
> > 8 files changed, 726 insertions(+)
> > create mode 100644 docs/system/arm/imx8mm-evk.rst  create mode
> 100644
> >hw/arm/fsl-imx8mm.c  create mode 100644 hw/arm/imx8mm-evk.c  create
> >mode 100644 include/hw/arm/fsl-imx8mm.h
> >
> >diff --git a/MAINTAINERS b/MAINTAINERS
> >index be6efff80c..41f76c5bd0 100644
> >--- a/MAINTAINERS
> >+++ b/MAINTAINERS
> >@@ -884,6 +884,16 @@ F: hw/pci-host/designware.c
> > F: include/hw/pci-host/designware.h
> > F: docs/system/arm/mcimx7d-sabre.rst
> >
> >+MCIMX8MM-EVK / iMX8MM
> >+M: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >+L: qemu-arm@nongnu.org
> >+S: Maintained
> >+F: hw/arm/fsl-imx8mm.c
> >+F: hw/arm/imx8mm-evk.c
> >+F: include/hw/arm/fsl-imx8mm.h
> >+F: docs/system/arm/imx8mm-evk.rst
> >+F: tests/functional/aarch64/test_imx8mm_evk.py
> >+
> > MCIMX8MP-EVK / i.MX8MP
> > M: Bernhard Beschow <shentey@gmail.com>
> > L: qemu-arm@nongnu.org
> >diff --git a/docs/system/arm/imx8mm-evk.rst
> >b/docs/system/arm/imx8mm-evk.rst new file mode 100644 index
> >0000000000..408253193c
> >--- /dev/null
> >+++ b/docs/system/arm/imx8mm-evk.rst
> >@@ -0,0 +1,68 @@
> >+NXP i.MX 8MM Evaluation Kit (``imx8mm-evk``)
> >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >+
> >+The ``imx8mm-evk`` machine models the i.MX 8M Mini Evaluation Kit,
> >+based on an i.MX 8MM SoC.
>=20
> This file is basically the one from imx8mp-evk with s/imx8mp/imx8mm/ .
> Perhaps we could just list both boards in this section there and mention
> somewhere.that all the commands apply to imx8mm in an analogous
> fashion? That way we won't have to update both documents when something
> changes.
>=20
> >+
> >+Supported devices
> >+-----------------
> >+
> >+The ``imx8mm-evk`` machine implements the following devices:
> >+
> >+ * Up to 4 Cortex-A53 cores
> >+ * Generic Interrupt Controller (GICv3)
> >+ * 4 UARTs
> >+
> >+Boot options
> >+------------
> >+
> >+The ``imx8mm-evk`` machine can start a Linux kernel directly using the
> >+standard ``-kernel`` functionality.
> >+
> >+Direct Linux Kernel Boot
> >+''''''''''''''''''''''''
> >+
> >+Probably the easiest way to get started with a whole Linux system on
> >+the machine is to generate an image with Buildroot. Version 2024.11.1
> >+is tested at the time of writing and involves two steps. First run the
> >+following commands in the toplevel directory of the Buildroot source tr=
ee:
> >+
> >+.. code-block:: bash
> >+
> >+  $ make freescale_imx8mmevk_defconfig  $ make
> >+
> >+Once finished successfully there is an ``output/image`` subfolder.
> >+Navigate into it and resize the SD card image to a power of two:
> >+
> >+.. code-block:: bash
> >+
> >+  $ qemu-img resize sdcard.img 256M
> >+
> >+Now that everything is prepared the machine can be started as follows:
> >+
> >+.. code-block:: bash
> >+
> >+  $ qemu-system-aarch64 -M imx8mm-evk -smp 4 -m 3G \
> >+      -display none -serial null -serial stdio \
> >+      -kernel Image \
> >+      -dtb imx8mm-evk.dtb \
> >+      -append "root=3D/dev/mmcblk2p2" \
> >+      -drive file=3Dsdcard.img,if=3Dsd,bus=3D2,format=3Draw,id=3Dmmcblk=
2
> >+
> >+
> >+KVM Acceleration
> >+----------------
> >+
> >+Be aware of the following limitations:
> >+
> >+* The ``imx8mm-evk`` machine is not included under the "virtualization =
use
> case"
> >+  of :doc:`QEMU's security policy </system/security>`. This means that
> >+you
> >+  should not trust that it can contain malicious guests, whether it is
> >+run
> >+  using TCG or KVM. If you don't trust your guests and you're relying
> >+on QEMU to
> >+  be the security boundary, you want to choose another machine such as
> ``virt``.
> >+* Rather than Cortex-A53 CPUs, the same CPU type as the host's will be
> used.
> >+  This is a limitation of KVM and may not work with guests with a
> >+tight
> >+  dependency on Cortex-A53.
> >+* No EL2 and EL3 exception levels are available which is also a KVM
> limitation.
> >+  Direct kernel boot should work but running U-Boot, TF-A, etc. won't
> succeed.
> >diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> >index a96d1867df..d6a4b5bb00 100644
> >--- a/docs/system/target-arm.rst
> >+++ b/docs/system/target-arm.rst
> >@@ -97,6 +97,7 @@ Board-specific documentation
> >    arm/mcimx6ul-evk
> >    arm/mcimx7d-sabre
> >    arm/imx8mp-evk
> >+   arm/imx8mm-evk
> >    arm/orangepi
> >    arm/raspi
> >    arm/collie
> >diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig index
> >0cdeb60f1f..be38c67a1c 100644
> >--- a/hw/arm/Kconfig
> >+++ b/hw/arm/Kconfig
> >@@ -626,6 +626,18 @@ config FSL_IMX8MP_EVK
> >     depends on TCG || KVM
> >     select FSL_IMX8MP
> >
> >+config FSL_IMX8MM
> >+    bool
> >+    select ARM_GIC
> >+    select IMX
> >+
> >+config FSL_IMX8MM_EVK
> >+    bool
> >+    default y
> >+    depends on AARCH64
> >+    depends on TCG
> >+    select FSL_IMX8MM
> >+
> > config ARM_SMMUV3
> >     bool
> >
> >diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c new file mode
> >100644 index 0000000000..fb6a78adba
> >--- /dev/null
> >+++ b/hw/arm/fsl-imx8mm.c
> >@@ -0,0 +1,366 @@
> >+/*
> >+ * i.MX 8MM SoC Implementation
> >+ *
> >+ * Based on hw/arm/fsl-imx6.c
>=20
> s/imx6/imx8mp/ ?
>=20
> >+ *
> >+ * Copyright (c) 2025, NXP Semiconductors
> >+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >+ *
> >+ * SPDX-License-Identifier: GPL-2.0-or-later
> >+ *
> >+ * iMX8MM Reference Manual -
> >+
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> >+ .nxp.com%2Fproducts%2Fi.MX8MMINI&data=3D05%7C02%7Cgaurav.sharma
> _7%40nxp
> >+ .com%7C7a050f54b27c4afe07b608de51c58b03%7C686ea1d3bc2b4c6fa92c
> d99c5c3
> >+
> 01635%7C0%7C0%7C639038106049104546%7CUnknown%7CTWFpbGZsb3d8
> eyJFbXB0eU
> >+
> 1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsI
> ld
> >+
> UIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dp1OkZJs6ixqHT%2BlrwoGP0My19J
> oizYZfPS
> >+ vSqYpo%2Fwo%3D&reserved=3D0 -> Documentation */
> >+
> >+#include "qemu/osdep.h"
> >+#include "system/address-spaces.h"
> >+#include "hw/arm/bsa.h"
> >+#include "hw/arm/fsl-imx8mm.h"
> >+#include "hw/misc/unimp.h"
> >+#include "hw/boards.h"
> >+#include "system/kvm.h"
> >+#include "system/system.h"
> >+#include "target/arm/cpu.h"
> >+#include "target/arm/cpu-qom.h"
> >+#include "target/arm/kvm_arm.h"
> >+#include "qapi/error.h"
> >+#include "qobject/qlist.h"
> >+
> >+static const struct {
> >+    hwaddr addr;
> >+    size_t size;
> >+    const char *name;
> >+} fsl_imx8mm_memmap[] =3D {
> >+    [FSL_IMX8MM_RAM] =3D { FSL_IMX8MM_RAM_START,
> FSL_IMX8MM_RAM_SIZE_MAX, "ram" },
> >+    [FSL_IMX8MM_DDR_PHY_BROADCAST] =3D { 0x3dc00000, 4 * MiB,
> "ddr_phy_broadcast" },
> >+    [FSL_IMX8MM_DDR_PERF_MON] =3D { 0x3d800000, 4 * MiB,
> "ddr_perf_mon" },
> >+    [FSL_IMX8MM_DDR_CTL] =3D { 0x3d400000, 4 * MiB, "ddr_ctl" },
> >+    [FSL_IMX8MM_DDR_PHY] =3D { 0x3c000000, 16 * MiB, "ddr_phy" },
> >+    [FSL_IMX8MM_GIC_DIST] =3D { 0x38800000, 512 * KiB, "gic_dist" },
> >+    [FSL_IMX8MM_GIC_REDIST] =3D { 0x38880000, 512 * KiB, "gic_redist" }=
,
> >+    [FSL_IMX8MM_VPU] =3D { 0x38340000, 2 * MiB, "vpu" },
> >+    [FSL_IMX8MM_VPU_BLK_CTRL] =3D { 0x38330000, 2 * MiB, "vpu_blk_ctrl"=
 },
> >+    [FSL_IMX8MM_VPU_G2_DECODER] =3D { 0x38310000, 1 * MiB,
> "vpu_g2_decoder" },
> >+    [FSL_IMX8MM_VPU_G1_DECODER] =3D { 0x38300000, 1 * MiB,
> "vpu_g1_decoder" },
> >+    [FSL_IMX8MM_USB2_OTG] =3D { 0x32e50200, 0x200, "usb2_otg" },
> >+    [FSL_IMX8MM_USB2] =3D { 0x32e50000, 0x200, "usb2" },
> >+    [FSL_IMX8MM_USB1_OTG] =3D { 0x32e40200, 0x200, "usb1_otg" },
> >+    [FSL_IMX8MM_USB1] =3D { 0x32e40000, 0x200, "usb1" },
> >+    [FSL_IMX8MM_GPU2D] =3D { 0x38000000, 64 * KiB, "gpu2d" },
> >+    [FSL_IMX8MM_QSPI1_RX_BUFFER] =3D { 0x34000000, 32 * MiB,
> "qspi1_rx_buffer" },
> >+    [FSL_IMX8MM_PCIE1] =3D { 0x33800000, 4 * MiB, "pcie1" },
> >+    [FSL_IMX8MM_QSPI1_TX_BUFFER] =3D { 0x33008000, 32 * KiB,
> "qspi1_tx_buffer" },
> >+    [FSL_IMX8MM_APBH_DMA] =3D { 0x33000000, 32 * KiB, "apbh_dma" },
> >+
> >+    /* AIPS-4 Begin */
> >+    [FSL_IMX8MM_TZASC] =3D { 0x32f80000, 64 * KiB, "tzasc" },
> >+    [FSL_IMX8MM_PCIE_PHY1] =3D { 0x32f00000, 64 * KiB, "pcie_phy1" },
> >+    [FSL_IMX8MM_MEDIA_BLK_CTL] =3D { 0x32e28000, 256, "media_blk_ctl" }=
,
> >+    [FSL_IMX8MM_LCDIF] =3D { 0x32e00000, 64 * KiB, "lcdif" },
> >+    [FSL_IMX8MM_MIPI_DSI] =3D { 0x32e10000, 64 * KiB, "mipi_dsi" },
> >+    [FSL_IMX8MM_MIPI_CSI] =3D { 0x32e30000, 64 * KiB, "mipi_csi" },
> >+    [FSL_IMX8MM_AIPS4_CONFIGURATION] =3D { 0x32df0000, 64 * KiB,
> "aips4_configuration" },
> >+    /* AIPS-4 End */
> >+
> >+    [FSL_IMX8MM_INTERCONNECT] =3D { 0x32700000, 1 * MiB, "interconnect"
> >+ },
> >+
> >+    /* AIPS-3 Begin */
> >+    [FSL_IMX8MM_ENET1] =3D { 0x30be0000, 64 * KiB, "enet1" },
> >+    [FSL_IMX8MM_SDMA1] =3D { 0x30bd0000, 64 * KiB, "sdma1" },
> >+    [FSL_IMX8MM_QSPI] =3D { 0x30bb0000, 64 * KiB, "qspi" },
> >+    [FSL_IMX8MM_USDHC3] =3D { 0x30b60000, 64 * KiB, "usdhc3" },
> >+    [FSL_IMX8MM_USDHC2] =3D { 0x30b50000, 64 * KiB, "usdhc2" },
> >+    [FSL_IMX8MM_USDHC1] =3D { 0x30b40000, 64 * KiB, "usdhc1" },
> >+    [FSL_IMX8MM_SEMAPHORE_HS] =3D { 0x30ac0000, 64 * KiB,
> "semaphore_hs" },
> >+    [FSL_IMX8MM_MU_B] =3D { 0x30ab0000, 64 * KiB, "mu_b" },
> >+    [FSL_IMX8MM_MU_A] =3D { 0x30aa0000, 64 * KiB, "mu_a" },
> >+    [FSL_IMX8MM_UART4] =3D { 0x30a60000, 64 * KiB, "uart4" },
> >+    [FSL_IMX8MM_I2C4] =3D { 0x30a50000, 64 * KiB, "i2c4" },
> >+    [FSL_IMX8MM_I2C3] =3D { 0x30a40000, 64 * KiB, "i2c3" },
> >+    [FSL_IMX8MM_I2C2] =3D { 0x30a30000, 64 * KiB, "i2c2" },
> >+    [FSL_IMX8MM_I2C1] =3D { 0x30a20000, 64 * KiB, "i2c1" },
> >+    [FSL_IMX8MM_AIPS3_CONFIGURATION] =3D { 0x309f0000, 64 * KiB,
> "aips3_configuration" },
> >+    [FSL_IMX8MM_CAAM] =3D { 0x30900000, 256 * KiB, "caam" },
> >+    [FSL_IMX8MM_SPBA1] =3D { 0x308f0000, 64 * KiB, "spba1" },
> >+    [FSL_IMX8MM_UART2] =3D { 0x30890000, 64 * KiB, "uart2" },
> >+    [FSL_IMX8MM_UART3] =3D { 0x30880000, 64 * KiB, "uart3" },
> >+    [FSL_IMX8MM_UART1] =3D { 0x30860000, 64 * KiB, "uart1" },
> >+    [FSL_IMX8MM_ECSPI3] =3D { 0x30840000, 64 * KiB, "ecspi3" },
> >+    [FSL_IMX8MM_ECSPI2] =3D { 0x30830000, 64 * KiB, "ecspi2" },
> >+    [FSL_IMX8MM_ECSPI1] =3D { 0x30820000, 64 * KiB, "ecspi1" },
> >+    /* AIPS-3 End */
> >+
> >+    /* AIPS-2 Begin */
> >+    [FSL_IMX8MM_QOSC] =3D { 0x307f0000, 64 * KiB, "qosc" },
> >+    [FSL_IMX8MM_PERFMON2] =3D { 0x307d0000, 64 * KiB, "perfmon2" },
> >+    [FSL_IMX8MM_PERFMON1] =3D { 0x307c0000, 64 * KiB, "perfmon1" },
> >+    [FSL_IMX8MM_GPT4] =3D { 0x30700000, 64 * KiB, "gpt4" },
> >+    [FSL_IMX8MM_GPT5] =3D { 0x306f0000, 64 * KiB, "gpt5" },
> >+    [FSL_IMX8MM_GPT6] =3D { 0x306e0000, 64 * KiB, "gpt6" },
> >+    [FSL_IMX8MM_SYSCNT_CTRL] =3D { 0x306c0000, 64 * KiB, "syscnt_ctrl" =
},
> >+    [FSL_IMX8MM_SYSCNT_CMP] =3D { 0x306b0000, 64 * KiB, "syscnt_cmp" },
> >+    [FSL_IMX8MM_SYSCNT_RD] =3D { 0x306a0000, 64 * KiB, "syscnt_rd" },
> >+    [FSL_IMX8MM_PWM4] =3D { 0x30690000, 64 * KiB, "pwm4" },
> >+    [FSL_IMX8MM_PWM3] =3D { 0x30680000, 64 * KiB, "pwm3" },
> >+    [FSL_IMX8MM_PWM2] =3D { 0x30670000, 64 * KiB, "pwm2" },
> >+    [FSL_IMX8MM_PWM1] =3D { 0x30660000, 64 * KiB, "pwm1" },
> >+    [FSL_IMX8MM_AIPS2_CONFIGURATION] =3D { 0x305f0000, 64 * KiB,
> "aips2_configuration" },
> >+    /* AIPS-2 End */
> >+
> >+    /* AIPS-1 Begin */
> >+    [FSL_IMX8MM_CSU] =3D { 0x303e0000, 64 * KiB, "csu" },
> >+    [FSL_IMX8MM_RDC] =3D { 0x303d0000, 64 * KiB, "rdc" },
> >+    [FSL_IMX8MM_SEMAPHORE2] =3D { 0x303c0000, 64 * KiB, "semaphore2" },
> >+    [FSL_IMX8MM_SEMAPHORE1] =3D { 0x303b0000, 64 * KiB, "semaphore1" },
> >+    [FSL_IMX8MM_GPC] =3D { 0x303a0000, 64 * KiB, "gpc" },
> >+    [FSL_IMX8MM_SRC] =3D { 0x30390000, 64 * KiB, "src" },
> >+    [FSL_IMX8MM_CCM] =3D { 0x30380000, 64 * KiB, "ccm" },
> >+    [FSL_IMX8MM_SNVS_HP] =3D { 0x30370000, 64 * KiB, "snvs_hp" },
> >+    [FSL_IMX8MM_ANA_PLL] =3D { 0x30360000, 64 * KiB, "ana_pll" },
> >+    [FSL_IMX8MM_OCOTP_CTRL] =3D { 0x30350000, 64 * KiB, "ocotp_ctrl" },
> >+    [FSL_IMX8MM_IOMUXC_GPR] =3D { 0x30340000, 64 * KiB, "iomuxc_gpr" },
> >+    [FSL_IMX8MM_IOMUXC] =3D { 0x30330000, 64 * KiB, "iomuxc" },
> >+    [FSL_IMX8MM_GPT3] =3D { 0x302f0000, 64 * KiB, "gpt3" },
> >+    [FSL_IMX8MM_GPT2] =3D { 0x302e0000, 64 * KiB, "gpt2" },
> >+    [FSL_IMX8MM_GPT1] =3D { 0x302d0000, 64 * KiB, "gpt1" },
> >+    [FSL_IMX8MM_SDMA2] =3D { 0x302c0000, 64 * KiB, "sdma2" },
> >+    [FSL_IMX8MM_SDMA3] =3D { 0x302b0000, 64 * KiB, "sdma3" },
> >+    [FSL_IMX8MM_WDOG3] =3D { 0x302a0000, 64 * KiB, "wdog3" },
> >+    [FSL_IMX8MM_WDOG2] =3D { 0x30290000, 64 * KiB, "wdog2" },
> >+    [FSL_IMX8MM_WDOG1] =3D { 0x30280000, 64 * KiB, "wdog1" },
> >+    [FSL_IMX8MM_ANA_OSC] =3D { 0x30270000, 64 * KiB, "ana_osc" },
> >+    [FSL_IMX8MM_ANA_TSENSOR] =3D { 0x30260000, 64 * KiB,
> "ana_tsensor" },
> >+    [FSL_IMX8MM_GPIO5] =3D { 0x30240000, 64 * KiB, "gpio5" },
> >+    [FSL_IMX8MM_GPIO4] =3D { 0x30230000, 64 * KiB, "gpio4" },
> >+    [FSL_IMX8MM_GPIO3] =3D { 0x30220000, 64 * KiB, "gpio3" },
> >+    [FSL_IMX8MM_GPIO2] =3D { 0x30210000, 64 * KiB, "gpio2" },
> >+    [FSL_IMX8MM_GPIO1] =3D { 0x30200000, 64 * KiB, "gpio1" },
> >+    [FSL_IMX8MM_AIPS1_CONFIGURATION] =3D { 0x301f0000, 64 * KiB,
> "aips1_configuration" },
> >+    [FSL_IMX8MM_SAI6] =3D { 0x30060000, 64 * KiB, "sai6" },
> >+    [FSL_IMX8MM_SAI5] =3D { 0x30050000, 64 * KiB, "sai5" },
> >+    [FSL_IMX8MM_SAI3] =3D { 0x30030000, 64 * KiB, "sai3" },
> >+    [FSL_IMX8MM_SAI2] =3D { 0x30020000, 64 * KiB, "sai2" },
> >+    [FSL_IMX8MM_SAI1] =3D { 0x30010000, 64 * KiB, "sai1" },
> >+
> >+    /* AIPS-1 End */
> >+
> >+    [FSL_IMX8MM_A53_DAP] =3D { 0x28000000, 16 * MiB, "a53_dap" },
> >+    [FSL_IMX8MM_PCIE1_MEM] =3D { 0x18000000, 128 * MiB, "pcie1_mem" },
> >+    [FSL_IMX8MM_QSPI_MEM] =3D { 0x08000000, 256 * MiB, "qspi_mem" },
> >+    [FSL_IMX8MM_OCRAM] =3D { 0x00900000, 256 * KiB, "ocram" },
> >+    [FSL_IMX8MM_TCM_DTCM] =3D { 0x00800000, 128 * KiB, "tcm_dtcm" },
> >+    [FSL_IMX8MM_TCM_ITCM] =3D { 0x007e0000, 128 * KiB, "tcm_itcm" },
> >+    [FSL_IMX8MM_OCRAM_S] =3D { 0x00180000, 32 * KiB, "ocram_s" },
> >+    [FSL_IMX8MM_CAAM_MEM] =3D { 0x00100000, 32 * KiB, "caam_mem" },
> >+    [FSL_IMX8MM_BOOT_ROM_PROTECTED] =3D { 0x0003f000, 4 * KiB,
> "boot_rom_protected" },
> >+    [FSL_IMX8MM_BOOT_ROM] =3D { 0x00000000, 252 * KiB, "boot_rom" }, };
> >+
> >+static void fsl_imx8mm_init(Object *obj) {
> >+    MachineState *ms =3D MACHINE(qdev_get_machine());
> >+    FslImx8mmState *s =3D FSL_IMX8MM(obj);
> >+    const char *cpu_type =3D ms->cpu_type ?:
> ARM_CPU_TYPE_NAME("cortex-a53");
> >+    int i;
> >+
> >+    for (i =3D 0; i < MIN(ms->smp.cpus, FSL_IMX8MM_NUM_CPUS); i++) {
> >+        g_autofree char *name =3D g_strdup_printf("cpu%d", i);
> >+        object_initialize_child(obj, name, &s->cpu[i], cpu_type);
> >+    }
> >+
> >+    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
> >+
> >+    for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
> >+        g_autofree char *name =3D g_strdup_printf("uart%d", i + 1);
> >+        object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL=
);
> >+    }
> >+
> >+}
> >+
> >+static void fsl_imx8mm_realize(DeviceState *dev, Error **errp) {
> >+    MachineState *ms =3D MACHINE(qdev_get_machine());
> >+    FslImx8mmState *s =3D FSL_IMX8MM(dev);
> >+    DeviceState *gicdev =3D DEVICE(&s->gic);
> >+    int i;
> >+
> >+    if (ms->smp.cpus > FSL_IMX8MM_NUM_CPUS) {
> >+        error_setg(errp, "%s: Only %d CPUs are supported (%d requested)=
",
> >+                   TYPE_FSL_IMX8MM, FSL_IMX8MM_NUM_CPUS, ms->smp.cpus);
> >+        return;
> >+    }
> >+
> >+    /* CPUs */
> >+    for (i =3D 0; i < ms->smp.cpus; i++) {
> >+        /* On uniprocessor, the CBAR is set to 0 */
> >+        if (ms->smp.cpus > 1 &&
> >+                object_property_find(OBJECT(&s->cpu[i]), "reset-cbar"))=
 {
> >+            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
> >+                                    fsl_imx8mm_memmap[FSL_IMX8MM_GIC_DI=
ST].addr,
> >+                                    &error_abort);
> >+        }
> >+
> >+        /*
> >+         * CNTFID0 base frequency in Hz of system counter
> >+         */
> >+        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
> >+                                &error_abort);
> >+
> >+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el2")) {
> >+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el2",
> >+                                     !kvm_enabled(), &error_abort);
> >+        }
> >+
> >+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
> >+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3",
> >+                                     !kvm_enabled(), &error_abort);
> >+        }
> >+
> >+        if (i) {
> >+            /*
> >+             * Secondary CPUs start in powered-down state (and can be
> >+             * powered up via the SRC system reset controller)
> >+             */
> >+            object_property_set_bool(OBJECT(&s->cpu[i]), "start-powered=
-off",
> >+                                     true, &error_abort);
> >+        }
> >+
> >+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
> >+            return;
> >+        }
> >+    }
> >+
> >+    /* GIC */
> >+    {
> >+        SysBusDevice *gicsbd =3D SYS_BUS_DEVICE(&s->gic);
> >+        QList *redist_region_count;
> >+        bool pmu =3D object_property_get_bool(OBJECT(first_cpu), "pmu",
> >+ NULL);
> >+
> >+        qdev_prop_set_uint32(gicdev, "num-cpu", ms->smp.cpus);
> >+        qdev_prop_set_uint32(gicdev, "num-irq",
> >+                             FSL_IMX8MM_NUM_IRQS + GIC_INTERNAL);
> >+        redist_region_count =3D qlist_new();
> >+        qlist_append_int(redist_region_count, ms->smp.cpus);
> >+        qdev_prop_set_array(gicdev, "redist-region-count",
> redist_region_count);
> >+        object_property_set_link(OBJECT(&s->gic), "sysmem",
> >+                                 OBJECT(get_system_memory()), &error_fa=
tal);
> >+        if (!sysbus_realize(gicsbd, errp)) {
> >+            return;
> >+        }
> >+        sysbus_mmio_map(gicsbd, 0,
> fsl_imx8mm_memmap[FSL_IMX8MM_GIC_DIST].addr);
> >+        sysbus_mmio_map(gicsbd, 1,
> >+ fsl_imx8mm_memmap[FSL_IMX8MM_GIC_REDIST].addr);
> >+
> >+        /*
> >+         * Wire the outputs from each CPU's generic timer and the GICv3
> >+         * maintenance interrupt signal to the appropriate GIC PPI inpu=
ts, and
> >+         * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
> >+         */
> >+        for (i =3D 0; i < ms->smp.cpus; i++) {
> >+            DeviceState *cpudev =3D DEVICE(&s->cpu[i]);
> >+            int intidbase =3D FSL_IMX8MM_NUM_IRQS + i * GIC_INTERNAL;
> >+            qemu_irq irq;
> >+
> >+            /*
> >+             * Mapping from the output timer irq lines from the CPU to =
the
> >+             * GIC PPI inputs.
> >+             */
> >+            static const int timer_irqs[] =3D {
> >+                [GTIMER_PHYS] =3D ARCH_TIMER_NS_EL1_IRQ,
> >+                [GTIMER_VIRT] =3D ARCH_TIMER_VIRT_IRQ,
> >+                [GTIMER_HYP]  =3D ARCH_TIMER_NS_EL2_IRQ,
> >+                [GTIMER_SEC]  =3D ARCH_TIMER_S_EL1_IRQ,
> >+            };
> >+
> >+            for (int j =3D 0; j < ARRAY_SIZE(timer_irqs); j++) {
> >+                irq =3D qdev_get_gpio_in(gicdev, intidbase + timer_irqs=
[j]);
> >+                qdev_connect_gpio_out(cpudev, j, irq);
> >+            }
> >+
> >+            irq =3D qdev_get_gpio_in(gicdev, intidbase + ARCH_GIC_MAINT=
_IRQ);
> >+            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-
> interrupt",
> >+                                        0, irq);
> >+
> >+            irq =3D qdev_get_gpio_in(gicdev, intidbase + VIRTUAL_PMU_IR=
Q);
> >+            qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
> >+ irq);
> >+
> >+            sysbus_connect_irq(gicsbd, i,
> >+                               qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> >+            sysbus_connect_irq(gicsbd, i + ms->smp.cpus,
> >+                               qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> >+            sysbus_connect_irq(gicsbd, i + 2 * ms->smp.cpus,
> >+                               qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
> >+            sysbus_connect_irq(gicsbd, i + 3 * ms->smp.cpus,
> >+                               qdev_get_gpio_in(cpudev,
> >+ ARM_CPU_VFIQ));
> >+
> >+            if (kvm_enabled()) {
> >+                if (pmu) {
> >+                    assert(arm_feature(&s->cpu[i].env, ARM_FEATURE_PMU)=
);
> >+                    if (kvm_irqchip_in_kernel()) {
> >+                        kvm_arm_pmu_set_irq(&s->cpu[i], VIRTUAL_PMU_IRQ=
);
> >+                    }
> >+                    kvm_arm_pmu_init(&s->cpu[i]);
> >+                }
> >+            }
> >+        }
> >+    }
> >+
> >+    /* UARTs */
> >+    for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
> >+        static const struct {
> >+            hwaddr addr;
> >+            unsigned int irq;
> >+        } serial_table[FSL_IMX8MM_NUM_UARTS] =3D {
> >+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART1].addr,
> FSL_IMX8MM_UART1_IRQ },
> >+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART2].addr,
> FSL_IMX8MM_UART2_IRQ },
> >+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART3].addr,
> FSL_IMX8MM_UART3_IRQ },
> >+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART4].addr,
> FSL_IMX8MM_UART4_IRQ },
> >+        };
> >+
> >+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i))=
;
> >+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
> >+            return;
> >+        }
> >+
> >+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0,
> serial_table[i].addr);
> >+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
> >+                           qdev_get_gpio_in(gicdev, serial_table[i].irq=
));
> >+    }
> >+
> >+    /* Unimplemented devices */
> >+    for (i =3D 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
> >+        switch (i) {
> >+        case FSL_IMX8MM_GIC_DIST:
> >+        case FSL_IMX8MM_GIC_REDIST:
> >+        case FSL_IMX8MM_RAM:
> >+        case FSL_IMX8MM_UART1 ... FSL_IMX8MM_UART4:
> >+            /* device implemented and treated above */
> >+            break;
> >+
> >+        default:
> >+            create_unimplemented_device(fsl_imx8mm_memmap[i].name,
> >+                                        fsl_imx8mm_memmap[i].addr,
> >+                                        fsl_imx8mm_memmap[i].size);
> >+            break;
> >+        }
> >+    }
> >+}
> >+
> >+static void fsl_imx8mm_class_init(ObjectClass *oc, const void *data) {
> >+    DeviceClass *dc =3D DEVICE_CLASS(oc);
> >+
> >+    dc->realize =3D fsl_imx8mm_realize;
> >+
> >+    dc->desc =3D "i.MX 8MM SoC";
> >+}
> >+
> >+static const TypeInfo fsl_imx8mm_types[] =3D {
> >+    {
> >+        .name =3D TYPE_FSL_IMX8MM,
> >+        .parent =3D TYPE_SYS_BUS_DEVICE,
> >+        .instance_size =3D sizeof(FslImx8mmState),
> >+        .instance_init =3D fsl_imx8mm_init,
> >+        .class_init =3D fsl_imx8mm_class_init,
> >+    },
> >+};
> >+
> >+DEFINE_TYPES(fsl_imx8mm_types)
> >diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c new file mode
> >100644 index 0000000000..ffc69f1050
> >--- /dev/null
> >+++ b/hw/arm/imx8mm-evk.c
> >@@ -0,0 +1,110 @@
> >+/*
> >+ * NXP i.MX 8MM Evaluation Kit System Emulation
> >+ *
> >+ * Copyright (c) 2025, NXP Semiconductors
> >+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >+ *
> >+ * SPDX-License-Identifier: GPL-2.0-or-later  */
> >+
> >+#include "qemu/osdep.h"
> >+#include "system/address-spaces.h"
> >+#include "hw/arm/boot.h"
> >+#include "hw/arm/fsl-imx8mm.h"
> >+#include "hw/arm/machines-qom.h"
> >+#include "hw/boards.h"
> >+#include "hw/qdev-properties.h"
> >+#include "system/kvm.h"
> >+#include "system/qtest.h"
> >+#include "qemu/error-report.h"
> >+#include "qapi/error.h"
> >+#include <libfdt.h>
>=20
> Rather than introducing a new source file I think it should be possible t=
o
> extend imx8mp-evk instead. More comments below.
>=20
> >+
> >+static void imx8mm_evk_modify_dtb(const struct arm_boot_info *info,
> >+void *fdt) {
> >+    int i, offset;
> >+
> >+    /* Temporarily disable following nodes until they are implemented *=
/
> >+    const char *nodes_to_remove[] =3D {
> >+        "nxp,imx8mm-fspi",
> >+        "fsl,imx8mm-mipi-csi",
> >+        "fsl,imx8mm-mipi-dsim"
>=20
> You could probably just add these nodes to the list in imx8mp-evk.
>=20
> >+    };
> >+
> >+    for (i =3D 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
> >+        const char *dev_str =3D nodes_to_remove[i];
> >+
> >+        offset =3D fdt_node_offset_by_compatible(fdt, -1, dev_str);
> >+        while (offset >=3D 0) {
> >+            fdt_nop_node(fdt, offset);
> >+            offset =3D fdt_node_offset_by_compatible(fdt, offset, dev_s=
tr);
> >+        }
> >+    }
> >+
> >+    /* Remove cpu-idle-states property from CPU nodes */
> >+    offset =3D fdt_node_offset_by_compatible(fdt, -1, "arm,cortex-a53")=
;
> >+    while (offset >=3D 0) {
> >+        fdt_nop_property(fdt, offset, "cpu-idle-states");
> >+        offset =3D fdt_node_offset_by_compatible(fdt, offset, "arm,cort=
ex-a53");
> >+    }
> >+
> >+    if (kvm_enabled()) {
> >+        /* Use system counter frequency from host CPU to fix time in gu=
est */
> >+        offset =3D fdt_node_offset_by_compatible(fdt, -1, "arm,armv8-ti=
mer");
> >+        while (offset >=3D 0) {
> >+            fdt_nop_property(fdt, offset, "clock-frequency");
> >+            offset =3D fdt_node_offset_by_compatible(fdt, offset, "arm,=
armv8-
> timer");
> >+        }
> >+    }
> >+}
> >+
> >+static void imx8mm_evk_init(MachineState *machine) {
> >+    static struct arm_boot_info boot_info;
> >+    FslImx8mmState *s;
> >+
>=20
> In this function it might be possible to perform an object_dynamic_cast()=
 on
> the MachineState to check which machine was requested by the user.
> Depending on that one could fill variables with SoC-specific values and u=
se
> them below instead of hardcoded values.
>=20
> >+    if (machine->ram_size > FSL_IMX8MM_RAM_SIZE_MAX) {
> >+        error_report("RAM size " RAM_ADDR_FMT " above max supported
> (%08" PRIx64 ")",
> >+                     machine->ram_size, FSL_IMX8MM_RAM_SIZE_MAX);
> >+        exit(1);
> >+    }
> >+
> >+    boot_info =3D (struct arm_boot_info) {
> >+        .loader_start =3D FSL_IMX8MM_RAM_START,
> >+        .board_id =3D -1,
> >+        .ram_size =3D machine->ram_size,
> >+        .psci_conduit =3D QEMU_PSCI_CONDUIT_SMC,
> >+        .modify_dtb =3D imx8mm_evk_modify_dtb,
> >+    };
> >+
> >+    s =3D FSL_IMX8MM(object_new(TYPE_FSL_IMX8MM));
> >+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
> >+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
> >+
> >+    memory_region_add_subregion(get_system_memory(),
> FSL_IMX8MM_RAM_START,
> >+                                machine->ram);
> >+
> >+    if (!qtest_enabled()) {
> >+        arm_load_kernel(&s->cpu[0], machine, &boot_info);
> >+    }
> >+}
> >+
> >+static const char *imx8mm_evk_get_default_cpu_type(const MachineState
> >+*ms) {
> >+    if (kvm_enabled()) {
> >+        return ARM_CPU_TYPE_NAME("host");
> >+    }
> >+
> >+    return ARM_CPU_TYPE_NAME("cortex-a53"); }
>=20
> The code below might just be able to copied over to imx8mp-evk.c.
>=20
> Does such consolidation work?
>=20
> Best regards,
> Bernhard
>=20
> >+
> >+static void imx8mm_evk_machine_init(MachineClass *mc) {
> >+    mc->desc =3D "NXP i.MX 8MM EVK Board";
> >+    mc->init =3D imx8mm_evk_init;
> >+    mc->max_cpus =3D FSL_IMX8MM_NUM_CPUS;
> >+    mc->default_ram_id =3D "imx8mm-evk.ram";
> >+    mc->get_default_cpu_type =3D imx8mm_evk_get_default_cpu_type; }
> >+
> >+DEFINE_MACHINE_AARCH64("imx8mm-evk", imx8mm_evk_machine_init)
> >diff --git a/hw/arm/meson.build b/hw/arm/meson.build index
> >aeaf654790..12ecb824cc 100644
> >--- a/hw/arm/meson.build
> >+++ b/hw/arm/meson.build
> >@@ -84,6 +84,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE',
> if_true:
> >files('armsse.c'))
> > arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true:
> >files('fsl-imx7.c', 'mcimx7d-sabre.c'))
> > arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true:
> >files('fsl-imx8mp.c'))
> > arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true:
> >files('imx8mp-evk.c'))
> >+arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM', if_true:
> >+files('fsl-imx8mm.c'))
> >+arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM_EVK', if_true:
> >+files('imx8mm-evk.c'))
> > arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true:
> >files('smmuv3.c'))
> > arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true:
> >files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
> > arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true:
> >files('nrf51_soc.c')) diff --git a/include/hw/arm/fsl-imx8mm.h
> >b/include/hw/arm/fsl-imx8mm.h new file mode 100644 index
> >0000000000..133f519b7c
> >--- /dev/null
> >+++ b/include/hw/arm/fsl-imx8mm.h
> >@@ -0,0 +1,157 @@
> >+/*
> >+ * i.MX 8MM SoC Definitions
> >+ *
> >+ * Copyright (c) 2025, NXP Semiconductors
> >+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >+ *
> >+ * SPDX-License-Identifier: GPL-2.0-or-later  */
> >+
> >+#ifndef FSL_IMX8MM_H
> >+#define FSL_IMX8MM_H
> >+
> >+#include "cpu.h"
> >+#include "hw/char/imx_serial.h"
> >+#include "hw/intc/arm_gicv3_common.h"
> >+#include "qom/object.h"
> >+#include "qemu/units.h"
> >+
> >+#define TYPE_FSL_IMX8MM "fsl-imx8mm"
> >+OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mmState, FSL_IMX8MM)
> >+
> >+#define FSL_IMX8MM_RAM_START        0x40000000
> >+#define FSL_IMX8MM_RAM_SIZE_MAX     (4 * GiB)
> >+
> >+enum FslImx8mmConfiguration {
> >+    FSL_IMX8MM_NUM_CPUS         =3D 4,
> >+    FSL_IMX8MM_NUM_IRQS         =3D 128,
> >+    FSL_IMX8MM_NUM_UARTS        =3D 4,
> >+};
> >+
> >+struct FslImx8mmState {
> >+    SysBusDevice   parent_obj;
> >+
> >+    ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
> >+    GICv3State         gic;
> >+    IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
> >+};
> >+
> >+enum FslImx8mmMemoryRegions {
> >+    FSL_IMX8MM_A53_DAP,
> >+    FSL_IMX8MM_AIPS1_CONFIGURATION,
> >+    FSL_IMX8MM_AIPS2_CONFIGURATION,
> >+    FSL_IMX8MM_AIPS3_CONFIGURATION,
> >+    FSL_IMX8MM_AIPS4_CONFIGURATION,
> >+    FSL_IMX8MM_ANA_OSC,
> >+    FSL_IMX8MM_ANA_PLL,
> >+    FSL_IMX8MM_ANA_TSENSOR,
> >+    FSL_IMX8MM_APBH_DMA,
> >+    FSL_IMX8MM_BOOT_ROM,
> >+    FSL_IMX8MM_BOOT_ROM_PROTECTED,
> >+    FSL_IMX8MM_CAAM,
> >+    FSL_IMX8MM_CAAM_MEM,
> >+    FSL_IMX8MM_CCM,
> >+    FSL_IMX8MM_CSU,
> >+    FSL_IMX8MM_DDR_CTL,
> >+    FSL_IMX8MM_DDR_PERF_MON,
> >+    FSL_IMX8MM_DDR_PHY,
> >+    FSL_IMX8MM_DDR_PHY_BROADCAST,
> >+    FSL_IMX8MM_ECSPI1,
> >+    FSL_IMX8MM_ECSPI2,
> >+    FSL_IMX8MM_ECSPI3,
> >+    FSL_IMX8MM_ENET1,
> >+    FSL_IMX8MM_GIC_DIST,
> >+    FSL_IMX8MM_GIC_REDIST,
> >+    FSL_IMX8MM_GPC,
> >+    FSL_IMX8MM_GPIO1,
> >+    FSL_IMX8MM_GPIO2,
> >+    FSL_IMX8MM_GPIO3,
> >+    FSL_IMX8MM_GPIO4,
> >+    FSL_IMX8MM_GPIO5,
> >+    FSL_IMX8MM_GPT1,
> >+    FSL_IMX8MM_GPT2,
> >+    FSL_IMX8MM_GPT3,
> >+    FSL_IMX8MM_GPT4,
> >+    FSL_IMX8MM_GPT5,
> >+    FSL_IMX8MM_GPT6,
> >+    FSL_IMX8MM_GPU2D,
> >+    FSL_IMX8MM_I2C1,
> >+    FSL_IMX8MM_I2C2,
> >+    FSL_IMX8MM_I2C3,
> >+    FSL_IMX8MM_I2C4,
> >+    FSL_IMX8MM_INTERCONNECT,
> >+    FSL_IMX8MM_IOMUXC,
> >+    FSL_IMX8MM_IOMUXC_GPR,
> >+    FSL_IMX8MM_MEDIA_BLK_CTL,
> >+    FSL_IMX8MM_LCDIF,
> >+    FSL_IMX8MM_MIPI_CSI,
> >+    FSL_IMX8MM_MIPI_DSI,
> >+    FSL_IMX8MM_MU_A,
> >+    FSL_IMX8MM_MU_B,
> >+    FSL_IMX8MM_OCOTP_CTRL,
> >+    FSL_IMX8MM_OCRAM,
> >+    FSL_IMX8MM_OCRAM_S,
> >+    FSL_IMX8MM_PCIE1,
> >+    FSL_IMX8MM_PCIE1_MEM,
> >+    FSL_IMX8MM_PCIE_PHY1,
> >+    FSL_IMX8MM_PERFMON1,
> >+    FSL_IMX8MM_PERFMON2,
> >+    FSL_IMX8MM_PWM1,
> >+    FSL_IMX8MM_PWM2,
> >+    FSL_IMX8MM_PWM3,
> >+    FSL_IMX8MM_PWM4,
> >+    FSL_IMX8MM_QOSC,
> >+    FSL_IMX8MM_QSPI,
> >+    FSL_IMX8MM_QSPI1_RX_BUFFER,
> >+    FSL_IMX8MM_QSPI1_TX_BUFFER,
> >+    FSL_IMX8MM_QSPI_MEM,
> >+    FSL_IMX8MM_RAM,
> >+    FSL_IMX8MM_RDC,
> >+    FSL_IMX8MM_SAI1,
> >+    FSL_IMX8MM_SAI2,
> >+    FSL_IMX8MM_SAI3,
> >+    FSL_IMX8MM_SAI5,
> >+    FSL_IMX8MM_SAI6,
> >+    FSL_IMX8MM_SDMA1,
> >+    FSL_IMX8MM_SDMA2,
> >+    FSL_IMX8MM_SDMA3,
> >+    FSL_IMX8MM_SEMAPHORE1,
> >+    FSL_IMX8MM_SEMAPHORE2,
> >+    FSL_IMX8MM_SEMAPHORE_HS,
> >+    FSL_IMX8MM_SNVS_HP,
> >+    FSL_IMX8MM_SPBA1,
> >+    FSL_IMX8MM_SRC,
> >+    FSL_IMX8MM_SYSCNT_CMP,
> >+    FSL_IMX8MM_SYSCNT_CTRL,
> >+    FSL_IMX8MM_SYSCNT_RD,
> >+    FSL_IMX8MM_TCM_DTCM,
> >+    FSL_IMX8MM_TCM_ITCM,
> >+    FSL_IMX8MM_TZASC,
> >+    FSL_IMX8MM_UART1,
> >+    FSL_IMX8MM_UART2,
> >+    FSL_IMX8MM_UART3,
> >+    FSL_IMX8MM_UART4,
> >+    FSL_IMX8MM_USB1,
> >+    FSL_IMX8MM_USB2,
> >+    FSL_IMX8MM_USB1_OTG,
> >+    FSL_IMX8MM_USB2_OTG,
> >+    FSL_IMX8MM_USDHC1,
> >+    FSL_IMX8MM_USDHC2,
> >+    FSL_IMX8MM_USDHC3,
> >+    FSL_IMX8MM_VPU,
> >+    FSL_IMX8MM_VPU_BLK_CTRL,
> >+    FSL_IMX8MM_VPU_G1_DECODER,
> >+    FSL_IMX8MM_VPU_G2_DECODER,
> >+    FSL_IMX8MM_WDOG1,
> >+    FSL_IMX8MM_WDOG2,
> >+    FSL_IMX8MM_WDOG3,
> >+};
> >+
> >+enum FslImx8mmIrqs {
> >+    FSL_IMX8MM_UART1_IRQ    =3D 26,
> >+    FSL_IMX8MM_UART2_IRQ    =3D 27,
> >+    FSL_IMX8MM_UART3_IRQ    =3D 28,
> >+    FSL_IMX8MM_UART4_IRQ    =3D 29,
> >+};
> >+
> >+#endif /* FSL_IMX8MM_H */

