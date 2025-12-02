Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34EECFD376
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 05:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQIsc-0001rM-KL; Tue, 02 Dec 2025 00:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vQIsZ-0001r1-Ta
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 00:24:47 -0500
Received: from mail-norwayeastazon11013020.outbound.protection.outlook.com
 ([40.107.159.20] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vQIsY-00007a-4a
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 00:24:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPa0CYpnz+CglyD7sC/FTaVTbhSwuwr7PJ37Moqs/zrsQdKIY8C1/VRLLdkDb8lFrOg4uVxtR+NinWGisuipHoGlb59lGTs4zUAepiDuvg4R7h2jek5Bh9odSABcIAsBhIKcyawr3wHPeTTIj7CoGM7UCk0HKoeoPNjFJyHKN7PPpwQf9IWzoKK1GuZVr+BKvm5aPqyzEkrFoi27WU57He44kmuwOJx0ZR0zTTMZv/RbNmNFp60uclggmLjXrqhRAsGJ/bLa4V3gQlGUKSoqo+HJJR7EEzxPgpsQMadPim3KCaBc6mrsEI0//Q6EU5GgDY+njSmrUFH/H+59Vvv+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hn0t2hocbfupaLCOLaPUe6aFWnLmLQWKIsYpgE+uBDc=;
 b=DtD/A42dmUO5uPpUV0jPD9z0u0gkmrmKipE7WHGvTL0VRUPOdKFOKRaqlbkKK3wcNtsf4OsGrfPv5NZ6LC0DojMKBS1YUiwcV+xuByIfZxnDLztbuYCU5y3Ssk67zJQoyA9mP7CFexdNiCxDsIWh++uQQN58C+o3MFKEvEHab65Q8+cwUh+RzBaaevocG4Pw91JsKnV2SNh0yGj17tG6a4hNwF/MplIXEttU+9vwizn4lr9PxoUIHfvyAXkbJaYU3PlOKPoHODSFGAXmFDcydI7AodZgLCj6RNVCsd0SrcAmE+jRl9GS36Efu3/h626/sVpU0XwDZvSvS7bKDVpvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn0t2hocbfupaLCOLaPUe6aFWnLmLQWKIsYpgE+uBDc=;
 b=mKjn90AIp1jWXN2hhLETWhVf+HABIO1lJSwEJRe3abHHWD8G7mZQ9tTu/5kzs3uc/5fIbVBneQS8DEW/scmdSG9+uiSy7vu7ItNRcvGRJDUEok5G45JGWhbJ6CsWx7Eyj+nqHku1tNSfyTmh3y7DKKls8tBfl7yHxRalG9xvNx7ZxmXsZcmieq4KiMnEV+KohhAa3fuWQ6iKCHKpLOAjNaHUtXabzZ+kIRxSjA7UYMsbRO5BNbnBYuv1HjMeIOz1dV6cVkve7xQPhipDcdHVsmhTZq5172Aii71o7/iNW4Aq2pOdJAikXyRLpmwGZ4Yo1kmnqHYvV8UxE+1D3/cklg==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by PA1PR04MB11430.eurprd04.prod.outlook.com (2603:10a6:102:4f0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 05:19:41 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 05:19:41 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: RE: [EXT] Re: [PATCHv3 00/13] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Topic: [EXT] Re: [PATCHv3 00/13] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Index: AQHcWVR8XMZOm6lZIkWllt/IB1o56LUC5D4ggAposICAAJRx8A==
Date: Tue, 2 Dec 2025 05:19:40 +0000
Message-ID: <AM9PR04MB84870E366018AD0D159DD40287D8A@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <AM9PR04MB8487540421160BCD438CFDA987D1A@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <CAFEAcA96wEquV-rWRU8x7DZBkNUOLYb_DVi80GRSZ_ekGGLUhw@mail.gmail.com>
In-Reply-To: <CAFEAcA96wEquV-rWRU8x7DZBkNUOLYb_DVi80GRSZ_ekGGLUhw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|PA1PR04MB11430:EE_
x-ms-office365-filtering-correlation-id: 8d5c4da1-e5ce-4e47-f555-08de31626575
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ekIdDFbMXiZqmyiUIR14DULVM4KHSm0gI6g5hNNJcjeXhc1xEhdXIJ64waze?=
 =?us-ascii?Q?dXMfQ1bIzCxCl8Bnm1dhi98mqSpeBBp9u9XzOZYf93RRrRRa/jEo5qtGiTo3?=
 =?us-ascii?Q?IcNnt3PkGtF3tOQPfQ/5jlELkritLRQmRG5iHQbwk38Bfljyb/E6QIFcGqYx?=
 =?us-ascii?Q?IaIrokqoDdOlPYLXvg6Ew+JN30Rzly1mjx0F6AjdVBi1yAAMy143uXPiVWAd?=
 =?us-ascii?Q?vXQ8eLYLfisUxWRR90bGnkNTDo8nFGxh8gvs51KTzLFAyK6XBjns/F45cIpY?=
 =?us-ascii?Q?3FKuVBVPFB8XwWlV5qEgngCuHdEU2eb0Reh2vRvkSBJcraJs8T0Q0MTGLJCk?=
 =?us-ascii?Q?t0T4L5MdJEp/UApRwjXSQrtcOelmdIlJk86RwZ/81sBd71A2hyHYM9k+aEb/?=
 =?us-ascii?Q?vNUuTzpqZAWDeTFcscukFVKrHSN677KPlnlqa964P1FmAHfq0bGhlWh2Y3gJ?=
 =?us-ascii?Q?omADfyg7jsm/yX0tY2tppi750PwKLaAxSydUSvgJW3PHrqa4Bc9CJcUcA5rQ?=
 =?us-ascii?Q?C/ko/OteKAHTlRNptpfPQAKQE+TMyko/M9aIE01qn94Q/tBt1xqCkiPhkTlD?=
 =?us-ascii?Q?2Cw95BO3xF5zrWAaSu6RvpkfayzEpt+MY9eQaPFAT/rj2N0MIFMc7cetk7j3?=
 =?us-ascii?Q?YxTVv1HBWfk7ach1Mw+7uas0mdtp6P9+7VmEyRTC1P9ft60m1vbfUcleCN7p?=
 =?us-ascii?Q?MGzL2hQ7o+SjfpKeACBtoPqwfJHbJW5V13yhwMvg6dQ6NGasRD4c9QTDENfs?=
 =?us-ascii?Q?/6vK31ICCT76Mgkt43pm140tjM/XkwGy1ZP9U36yWAPPrxVtUcByT+YgLFPv?=
 =?us-ascii?Q?qFAr7FGhRvUI6Ws/isH/rqztpLCK+QFw/eNqotVDAEiG57kVoHeTx6Vf0nCM?=
 =?us-ascii?Q?Wc+fnQ2B7rxsTqHMNAdx8TGEa5ubRwnIPzD88DjRZF2Tn7JIj5AYUIkOhghk?=
 =?us-ascii?Q?YBN1HXO5OnTPHHs1JR3YOotZD+NIlJwSfRsSO4vfcbN9ERyFWajaScOaZ7HG?=
 =?us-ascii?Q?T6KxwDvAym/t/3HraHUv1AKn4euXMg9eOR9GXVn20Pj/6Ya9k43h9y7Wqf+Y?=
 =?us-ascii?Q?kIo8wQ4WdG6eJG+PjEJS/gr5gOR7W5CneGw4sKEU97TB+tQ7hnKWskfr9KfO?=
 =?us-ascii?Q?TJ+jq8v+sTK868+whtX9+YR4uW9866AoOM1Kd7r8MsASJL4/ME76Tr5EHERS?=
 =?us-ascii?Q?Lk8O2f60jyI4bghV7i8nZsMqPkugz+nX2xGy8TAohIANxBVj8P3XqUuDs2vb?=
 =?us-ascii?Q?g/eEKJ6RojBUG9UOxVCHHH67ib7zJXPL6WDfZW7XTWzk5vgpEq4HbCvXD/+D?=
 =?us-ascii?Q?feBCd/amM9fQSRd+XYykyyVZlPknNSCjKMZlvxi/1GQSMBC1+5v5S7MzBO40?=
 =?us-ascii?Q?6nlv4CgDhSjxyEAMhEWLtUU6dbsmVhRQGz5rnmz7yzsNspSp2Ep8CjnV6tne?=
 =?us-ascii?Q?AZ+bMb4hAGj6GCT6/cRBtUXI5SIxdnvWyLYixxeXlb/teCbsYtg+fQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?68CZoal+F1ppSp93j7poAno+9kkSCJavxNLv53pnncW4ORCq42hbXnQM29+Z?=
 =?us-ascii?Q?KyG2i4eW9ESkDHGm3JPLRlw07jOizZYNRKXJ8s5+0lt88Tpo5KsDxCPhbrg+?=
 =?us-ascii?Q?PMWiUWz8AzXZLhFNy++NdPJEv5bhzWhLDDk6Mwi2p3yZlqJDJ4gNDVLGAEVo?=
 =?us-ascii?Q?0VV1+Qfv3vmOFCHtnI3jhQOA44V8ZnPSU6HFu/ClUWwWnToteI29FzuKXMFq?=
 =?us-ascii?Q?5Zw8QfKeU/Tr2ND3X+eRHEqoZcJCX2NFl038+Vsq7/ZYO0DnY1VbvxHifROV?=
 =?us-ascii?Q?QL4xVwy9SdS2h5N3L3muz6xZ0ygnCqRDKoZ1orElByONUGmxX9eOxbtojxeh?=
 =?us-ascii?Q?Ks89f57bE3Bs672GF5BNbAPGoCYQx0mXCPMPbPXqR5ItHDspuwb04qm52RsX?=
 =?us-ascii?Q?0FxwzwRQNdPiuPvWmK6Jm6dIZYO91iM0dg3CS10AXR4se/yZotiANuqmDY0n?=
 =?us-ascii?Q?SK16aT/LLQwg7bU1XTj7NnXYG6mtjqKAhfhg26ySYNNwfMI85IA6iYqTf4uH?=
 =?us-ascii?Q?lS/uFdjv5wV1E7EyssxSCqSLXM/eOxjvu39AD+jamRamuYEGdpvGZKm3suJX?=
 =?us-ascii?Q?pzXwDs+2SiuOz8WH/Rqn1qrvUmeAn7AMsDaQ6XDJOa2Wb6bULtlGdL5dXLXx?=
 =?us-ascii?Q?Uxawz06w82lStavtggr+66lfDxKFC+p3L95V48Wegz/lFn5iaXD8XRWrckfk?=
 =?us-ascii?Q?L1NHXijzVuowtNs8iGcGdKq1VacFrFhl3nUfyR3Cxu/2XbPw5tXNf9CC0MYv?=
 =?us-ascii?Q?n4QOtTA0XNeKZuKqIHn1S7D0PSsm53rdGszeGiWZRA3zivejE8fW27RwRSvP?=
 =?us-ascii?Q?e8PrE6CZlxsrntqtf+2Q6MxCpmI9ELG/dT7T5kLf3pEGjdtsluMrF570LLKn?=
 =?us-ascii?Q?yGsV7GLAx3WHc6L7KDIqLalOXpEtW9WMCMRVr1HRfsggNDTNF/VOacpxAPa+?=
 =?us-ascii?Q?53nZEDLm6g+x1uJ6wrUVILROPypanB/06Ctz5UD+y3M0sdE3FoRc/z3xdRx2?=
 =?us-ascii?Q?6/1dN1gVsbRU2P+waJmWwS8qf044e7pNWh63IJJj8vmzLlyFxbTVTqIn2Zw+?=
 =?us-ascii?Q?KdMCBKLznvq+05+DM3xnxjZ6VfM4vTYyRnntZVf4tsVlfyJiA+XSMC5RGW49?=
 =?us-ascii?Q?ixjzDhtVzsRmFBl6ymGeXt3OBwpm2yq4fax9SRprigzKbqx9csL5LDthF2PP?=
 =?us-ascii?Q?sLjI/oBLDXYpAJxNkmCoHQn2APw0PetZbf+HOfMsVDlrd7GK7uY2c5XjlNnH?=
 =?us-ascii?Q?tH73Uy3HD9ulGz0vM5UcMhHHlqPjbgoQ+9MtMQvUsHBUzCzAxvNYG6BP2/IK?=
 =?us-ascii?Q?emGqICbFuixQkebX3KO4dYxbVcFro7lqkUstbQMuij791hqlD72ObFZnreF2?=
 =?us-ascii?Q?dWKofWfdswwdNqAOEBBLzcotIj/aOS99wExOWBXb32HSynY4zv+ulMnWotca?=
 =?us-ascii?Q?5/86T6R77pDqCm2Vt/7lDasZ6Z/xijN0WwN2V2KBoSABXiLAa74zTUkFgjzT?=
 =?us-ascii?Q?O6CJ7tcJbJZsI7eCcRzMgikxASbZE6GI4Hk4N74zP02rG0eNO20zzEs0ReeZ?=
 =?us-ascii?Q?fwMIE3OY1hv3AN+6FMoxpPPZRlxR5CJFWXPTWEJL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5c4da1-e5ce-4e47-f555-08de31626575
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 05:19:41.1407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kaVrS5Wf5v3+5rNQi7k7gUBlRopPN7jFxkmvdYKXUBOA/1/FwpTyZusVEitUtksPJzpPgLwY2nWMM2quXNntQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11430
Received-SPF: pass client-ip=40.107.159.20;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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


> At least some of these patches were reviewed by Philippe in v1.
> Did they all change?
>
> The way this is supposed to work is that where a patch has been reviewed
> and hasn't changed in a followup respin of a patchset, you keep the
> reviewed-by tag, which tells us that we don't need to repeat that bit of =
the
> review. More detail:
>
> https://www.q/
> emu.org%2Fdocs%2Fmaster%2Fdevel%2Fsubmitting-a-patch.html%23proper-
> use-of-reviewed-by-tags-can-aid-
> review&data=3D05%7C02%7Cgaurav.sharma_7%40nxp.com%7C7d7d9203ac334
> 65757c908de3116f632%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> 7C639002171850292201%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGki
> OnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoy
> fQ%3D%3D%7C0%7C%7C%7C&sdata=3D%2Bj2Q4APWnTNTY%2FTHqfaEZsmBJH
> E%2FzD6zsv%2BxnZ9IyC4%3D&reserved=3D0
>

The v1 patch files reviewed by Philippe changed. Structure type was changed=
 in all those reviewed patches that's why reviewed-by tag was not retained =
in the follow-up revisions.

